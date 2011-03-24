unit Unit_Tracing;
interface
uses Unit1, Sysutils, Math, KromUtils, Unit_Defaults;

type TPickDirection = (pd_Top, pd_Bottom, pd_Near);

function TraceHeightY(inx,iny,inz:single; aPickDir:TPickDirection):single;
procedure TraceHeight(inx,iny,inz:single; aPickDir:TPickDirection; ResultY:psingle; ResultPoly:pinteger);
procedure TraceVectorShadows(ShadowEdgeHardness:byte; TraceDetails:boolean);

implementation

function TraceHeightY(inx,iny,inz:single; aPickDir:TPickDirection):single;
var y:single; i:integer;
begin
  TraceHeight(inx, iny, inz, aPickDir, @y, @i);
  Result:=y;
end;


procedure TraceHeight(inx,iny,inz:single; aPickDir:TPickDirection; ResultY:psingle; ResultPoly:pinteger);
const Num=16; //how many polys to check
var
  i,k,PolyQty,ci,cb:integer;
  x1,z1,x2,z2,x3,z3,ytemp,nx,ny,nz,D:single;
  v1,v2,v3:array[1..3] of single;
  tp:array[1..Num]of integer;
begin
  PolyQty:=1; ci:=1;
  FillChar(tp,SizeOf(tp),#0);
  cb:=                                                                    //CollisionBlock:=
      (EnsureRange(round(inz/256+0.5+Qty.BlocksZ*2),1,Qty.BlocksZ*4)-1)*  //(Z-1)*
       Qty.BlocksX*4+                                                     //Qty.BlocksX*4+
       EnsureRange(round(inx/256+0.5+Qty.BlocksX*2),1,Qty.BlocksX*4);     //(X-1)+1

  repeat
    for i:=1 to v06[cb][ci] do begin // Polycount; BlockID; ..polys..; Polycount; BlockID; ..polys..; 0-terminator.
      k:=Block[((v06[cb,ci+1])div Qty.BlocksX+1),
               ((v06[cb,ci+1])mod Qty.BlocksX+1)].FirstPoly+1+v06[cb,ci+1+i];

      x1:=inx-VTX[v[k,1]].X; z1:=inz-VTX[v[k,1]].Z;
      x2:=inx-VTX[v[k,2]].X; z2:=inz-VTX[v[k,2]].Z;
      x3:=inx-VTX[v[k,3]].X; z3:=inz-VTX[v[k,3]].Z;

      if (-x1*z2+z1*x2>=0) //point within triangle makes 3 triangles whose normals face up (nY > 0)
      and(-x2*z3+z2*x3>=0) //simply check if any of these normals Y>=0
      and(-x3*z1+z3*x1>=0) then begin
        tp[PolyQty]:=k;
        if PolyQty<Num then inc(PolyQty); //avoid overflows
      end;
    end;
    inc(ci,v06[cb,ci]+2); //qty+2
  until(v06[cb,ci]=0); //end of list

  PolyQty:=PolyQty-1;

  ResultY^:=0;
  ResultPoly^:=1;

  for i:=1 to PolyQty do begin
    v1[1]:=VTX[v[tp[i],1]].X; v1[2]:=VTX[v[tp[i],1]].Y; v1[3]:=VTX[v[tp[i],1]].Z;
    v2[1]:=VTX[v[tp[i],2]].X; v2[2]:=VTX[v[tp[i],2]].Y; v2[3]:=VTX[v[tp[i],2]].Z;
    v3[1]:=VTX[v[tp[i],3]].X; v3[2]:=VTX[v[tp[i],3]].Y; v3[3]:=VTX[v[tp[i],3]].Z;
    Normal2Poly(v1,v2,v3,@nx,@ny,@nz);
    Normalize(nx,ny,nz);
    D:=-(nx*VTX[v[tp[i],1]].X+ny*VTX[v[tp[i],1]].Y+nz*VTX[v[tp[i],1]].Z);
    ytemp:=-(inx*nx+inz*nz+D)/ny; //true height respecting poly surface

    case aPickDir of
      pd_Top:     if ((ytemp > ResultY^)and(ny > 0))or(i = 1) then begin //choose highest one
                    ResultY^:=ytemp;
                    ResultPoly^:=tp[i];
                  end;
      pd_Bottom:  if ((ytemp < ResultY^)and(ny > 0))or(i = 1) then begin //choose lowest one
                    ResultY^:=ytemp;
                    ResultPoly^:=tp[i];
                  end;
      pd_Near:    if ((abs(ytemp-iny) < abs(ResultY^-iny))and(ny > 0))or(i = 1) then begin //choose nearest one
                    ResultY^:=ytemp;
                    ResultPoly^:=tp[i];
                  end;
      else Assert(false,'Unknown pick direction querried');
    end;
  end;

end;

procedure TraceVectorShadows(ShadowEdgeHardness:byte; TraceDetails:boolean);
var
  m,j,I,K,ci,cb,cv,BlockID,Test,Test2:integer;
  tx,tz,Step:integer;
  ind1,ind2:integer;
  v1,v2,v3,n1,n2,n3{,tmp}:Vector3f;
  Strip:array[1..16]of shortint;
  StripQuest:byte;
  tb:byte;
  vp,vs,sp,ip:Vector3f; //Point: VectorPos,VectorToSun,SunPos,IntersectionPos
  ABC:array of Vector3f; //Poly normal
  D,H,L:array of single; //Poly info
  NoShadow:array of boolean;
  t,u,sa,sb,dx:single;
  bx,bz:integer;
  //Trace from Block to Sun
  L1x,L1y,L2x,L2y,L3x,L3y,L4x,L4y,Sx,Sy:integer;
  Edge:array[1..8]of integer;
  e1,e2,ID,ttt:integer;
  UniqV:array of integer;
  ShadAcc:array of record Count,Value:word; end;
  ShowLog:boolean;
  ShadHi,ShadLo,Shad2,Shad4:integer;
  CutOff:record a,b,c,d,e,f,g:array[1..2]of integer; end;
  s:string;
begin

  case ShadowEdgeHardness of
  0:   begin ShadHi:=144; ShadLo:=112; end; //Soft shadows
  1:   begin ShadHi:=160; ShadLo:= 96; end; //Medium shadows
  else begin ShadHi:=200; ShadLo:= 56; end; //Hard shadows //200+36+18=254
  end;
  //Shad2:=(ShadHi-ShadLo) div 4;
  //Shad4:=(ShadHi-ShadLo) div 8;
  Shad2:=(ShadHi-ShadLo) div 2;
  Shad4:=(ShadHi-ShadLo) div 4;

ShowLog:=true;

Form1.MemoLog.Clear;
Form1.MemoLog.Show;
Form1.MemoLog.Repaint;

ElapsedTime(@OldTime);
//ShowLog:=false; for Test:=1 to 10 do
begin

//Finding out each polys normal (A,B,C), determinant D? , high and low bounds (H,L)
if ShowLog then Form1.MemoLog.Lines.Add('Collecting poly info');
setlength(ABC,Qty.Polys+1); setlength(D,Qty.Polys+1);
setlength(H,Qty.Polys+1);   setlength(L,Qty.Polys+1); //Highest&Lowest points
setlength(NoShadow,Qty.Polys+1);

for k:=1 to Qty.TexturesTotal do
for i:=v07[k].FirstPoly+1 to v07[k].FirstPoly+v07[k].NumPoly do
  if MaterialW[v07[k].SurfaceID+1].NoShadow=1 then
    NoShadow[i]:=true;

for I:=1 to Qty.Polys do begin
  v1.X:=VTX[v[I,1]].X; v1.Y:=VTX[v[I,1]].Y; v1.Z:=VTX[v[I,1]].Z;
  v2.X:=VTX[v[I,2]].X; v2.Y:=VTX[v[I,2]].Y; v2.Z:=VTX[v[I,2]].Z;
  v3.X:=VTX[v[I,3]].X; v3.Y:=VTX[v[I,3]].Y; v3.Z:=VTX[v[I,3]].Z;
  Normal2Poly(v1,v2,v3,@ABC[I]);
  Normalize(ABC[I]);
  D[I]:=-(ABC[I].X*VTX[v[I,1]].X+ABC[I].Y*VTX[v[I,1]].Y+ABC[I].Z*VTX[v[I,1]].Z);
  H[I]:=max(VTX[v[I,1]].Y,VTX[v[I,2]].Y,VTX[v[I,3]].Y);
  L[I]:=min(VTX[v[I,1]].Y,VTX[v[I,2]].Y,VTX[v[I,3]].Y);
end;

//Find each blocks high and low bounds,
//DONT_TRACE_TAG is a special UV value of background grid
//that should be ignored in this case
if ShowLog then Form1.MemoLog.Lines.Add('Collecting block heights');
setlength(BlockHi,Qty.BlocksX*Qty.BlocksZ*16+1);
setlength(BlockLo,Qty.BlocksX*Qty.BlocksZ*16+1);
for K:=1 to Qty.BlocksX*Qty.BlocksZ*16 do begin
  ci:=1;
  repeat
    for cv:=1 to v06[K,ci] do begin // Polycount; BlockID; ..polys..; Polycount; BlockID; ..polys..; 0-terminator.
      I:=Block[((v06[K,ci+1])div Qty.BlocksX+1),((v06[K,ci+1])mod Qty.BlocksX+1)].FirstPoly+1+v06[K,ci+1+cv];
      if ((ci=1)and(cv=1))or(BlockHi[K]<H[I]) then BlockHi[K]:=H[I];
      if ((ci=1)and(cv=1))or((BlockLo[K]>L[I])and(VTX[v[I,1]].U<>DONT_TRACE_TAG)) then BlockLo[K]:=L[I];
    end;
    inc(ci,v06[K,ci]+2); //qty+2
  until(v06[K,ci]=0); //end of list
end;

//Building list of blocks that can possibly occlude trace to sun for given block
if ShowLog then Form1.MemoLog.Lines.Add('Tracing block-sun paths');
setlength(Trace2Sun,Qty.BlocksX*Qty.BlocksZ*16+1); cb:=0;
for I:=1 to Qty.BlocksZ*4 do for K:=1 to Qty.BlocksX*4 do begin
  inc(cb); BX:=K; BZ:=I;
  setlength(Trace2Sun[cb],50+1); //
  ci:=0;

  L1x:=BX; L1y:=BZ; L2x:=BX; L2y:=BZ+1;       //23
  L3x:=BX+1; L3y:=BZ+1; L4x:=BX+1; L4y:=BZ;   //14
  Sx:=round(BX+LVL.SunX*1000000); Sy:=round(BZ+LVL.SunZ*1000000); //far far away

  j:=0;
  repeat

    if LVL.SunZ=0 then begin
    if LVL.SunX>=0 then e1:=EnsureRange(BX,1,Qty.BlocksX*4) else e1:=1;
    if LVL.SunX>=0 then e2:=Qty.BlocksX*4 else e2:=EnsureRange(BX,1,Qty.BlocksX*4);
    end else begin

      for m:=0 to 1 do begin //Lower-Higher border
        Edge[1+m*4]:=trunc(L1x+((BZ+j+m)-L1y)*(Sx-L1x)/(Sy-L1y)); //L1-S
        Edge[2+m*4]:=trunc(L2x+((BZ+j+m)-L2y)*(Sx-L2x)/(Sy-L2y)); //L2-S
        Edge[3+m*4]:=trunc(L3x+((BZ+j+m)-L3y)*(Sx-L3x)/(Sy-L3y)); //L3-S
        Edge[4+m*4]:=trunc(L4x+((BZ+j+m)-L4y)*(Sx-L4x)/(Sy-L4y)); //L4-S
      end;

      if LVL.SunX>=0 then begin
        e1:=EnsureRange(MinIntValue(Edge),BX,Qty.BlocksX*4);
        e2:=EnsureRange(MaxIntValue(Edge),BX,Qty.BlocksX*4);
      end else begin
        e1:=EnsureRange(MinIntValue(Edge),1,BX);
        e2:=EnsureRange(MaxIntValue(Edge),1,BX);
      end;

    end;

    for m:=e1 to e2 do begin
      ID:=(BZ+j-1)*Qty.BlocksX*4+m;
      //Get distance between vertex and block
      dx:=GetLength(m-bx,j); //Check if block high enough and possibly can drop shadow on current block
      dx:=BlockLo[cb]+(256*dx-362)*abs(tan(arcsin(LVL.SunY)));//store whole add-up in one value
      //362^2=256^2+256^2
        if dx <= BlockHi[ID] then begin
          //allocate additional space
          if length(Trace2Sun[cb])-1<ci+1 then setlength(Trace2Sun[cb],length(Trace2Sun[cb])+50+1); //
          inc(ci);                
          Trace2Sun[cb,ci]:=(BZ+j-1)*Qty.BlocksX*4+m;
        end;
    end;

    if LVL.SunZ>=0 then inc(j) else dec(j);
  until(((LVL.SunZ>0)and(BZ+j>Qty.BlocksZ*4))or((LVL.SunZ<0)and(BZ+j<1))or(LVL.SunZ=0));

  setlength(Trace2Sun[cb],ci+2);
  Trace2Sun[cb,ci+1]:=0;
  Trace2Sun[cb,0]:=ci;
end;

//Make a list of unique vertices.
//Field contains either own vertice ID or reference to duplicate vertice.
//List is reverse sorted, meaning all references are forward directed (to forward)
//Vertice treated as unique only if it has unique XYZ, rest is not important
//Form1.MemoLog.Lines.Add('Complete in '+ElapsedTime(@OldTime));
if ShowLog then Form1.MemoLog.Lines.Add('Listing duplicate vertices');
setlength(UniqV,VTXQty[64]+1);
for K:=VTXQty[64] downto 1 do begin //scan all points
  UniqV[K]:=K;                        //assume each point is unique
  for I:=K+1 to min(VTXQty[64],K+2000) do         //check previous points (starting from nearest)
  if (VTX[I].X=VTX[K].X)and(VTX[I].Y=VTX[K].Y)and(VTX[I].Z=VTX[K].Z) then begin //if such point already exist
  UniqV[K]:=I;                      //make reference to it
  inc(UniqV[0]);                    //Statistic
  break;                            //break comparision for speedup
  end;
end;
if ShowLog then Form1.MemoLog.Lines.Add(inttostr(UniqV[0])+' duplicates found');
//Form1.MemoLog.Lines.Add('Complete in '+ElapsedTime(@OldTime));

for K:=1 to VTXQty[64] do VTX[K].Shadow:=ShadLo;
Step:=VTXQty[64] div 50; //2% step

if ShowLog then Form1.MemoLog.Lines.Add('Checking points');

FillChar(CutOff,sizeof(CutOff),#0);

for K:=VTXQty[64] downto 1 do begin //reverse is faster somehow

  if ShowLog then
  if k mod Step = 0 then begin
    Form1.TraceShadows.Caption:=inttostr(100-round(k/VTXQty[64]*100))+' %';
    Form1.TraceShadows.Refresh;
  end;

  inc(CutOff.a[1]);
  if UniqV[K]<>K then begin
    VTX[K].Shadow:=VTX[UniqV[K]].Shadow;
  end else begin
    inc(CutOff.a[2]);

    vp.X:=VTX[K].X; vp.Y:=VTX[K].Y; vp.Z:=VTX[K].Z; //VerticePos
    sp.X:=vp.X+LVL.SunX*1000000; sp.Y:=vp.Y+LVL.SunY*1000000; sp.Z:=vp.Z+LVL.SunZ*1000000;
    vs.X:=vp.X-sp.X; vs.Y:=vp.Y-sp.Y; vs.Z:=vp.Z-sp.Z; //Vector to Sun (x1-x2)

    //Get BlockID where vertice is located
    bx:=EnsureRange(trunc(vp.X/256+Qty.BlocksX*2+1),1,Qty.BlocksX*4);
    bz:=EnsureRange(trunc(vp.Z/256+Qty.BlocksZ*2+1),1,Qty.BlocksZ*4);
    BlockID:=round((bz-1)*Qty.BlocksX*4+bx);

    for cb:=Trace2Sun[BlockID,0] downto 1 do begin//reverse is faster
      //Get distance between vertex and block
      tx:=(Trace2Sun[BlockID,cb]-1)mod (Qty.BlocksX*4)+1;
      tz:=(Trace2Sun[BlockID,cb]-1)div (Qty.BlocksX*4)+1;
      dx:=GetLength(tx-bx,tz-bz); //Check if block high enough and possibly can drop shadow on current block
      dx:=vp.Y+(256*dx-362)*abs(tan(arcsin(LVL.SunY)));//store whole add-up in one value
      //362^2=256^2+256^2
      inc(CutOff.b[1]);
      if dx <= BlockHi[Trace2Sun[BlockID,cb]] then begin
        inc(CutOff.b[2]);
        ci:=1;
        repeat
          for cv:=1 to v06[Trace2Sun[BlockID,cb],ci] do begin // Polycount; BlockID; ..polys..; Polycount; BlockID; ..polys..; 0-terminator.
            //Block[z,x].FirstPoly
            I:=Block[(v06[Trace2Sun[BlockID,cb],ci+1]div Qty.BlocksX+1),
                     (v06[Trace2Sun[BlockID,cb],ci+1]mod Qty.BlocksX+1)].FirstPoly+1+v06[Trace2Sun[BlockID,cb],ci+1+cv];

            if NoShadow[I]=false then begin

              inc(CutOff.c[1]);
              //Include only those polys above the point, cos sun can't go down
              if (vp.Y<H[I])and(dx<H[I])then begin
                inc(CutOff.c[2]);
                //check that dist to v[I,1],v[I,2],v[I,3] big enough to be different point - doesn't matter
                t:=ABC[I].X*vs.X+ABC[I].Y*vs.Y+ABC[I].Z*vs.Z;      //A(x1-x2)+B(y1-y2)+C(z1-z2)

                inc(CutOff.d[1]);
                if t<>0 then begin //Ray parallel to poly
                  inc(CutOff.d[2]);
                  u:=(ABC[I].X*vp.X+ABC[I].Y*vp.Y+ABC[I].Z*vp.Z+D[I])/t; //A*x1+B*y1+C*z1+D
                  ip.X:=vp.X-u*(vs.X); //IntersectionPoint
                  ip.Y:=vp.Y-u*(vs.Y);
                  ip.Z:=vp.Z-u*(vs.Z);

                  inc(CutOff.e[1]);
                  //Rough check if ip is inside poly bounding box
                  if (ip.X>=Min(VTX[v[I,1]].X,VTX[v[I,2]].X,VTX[v[I,3]].X))and
                     (ip.X<=Max(VTX[v[I,1]].X,VTX[v[I,2]].X,VTX[v[I,3]].X))and
                     (ip.Z>=Min(VTX[v[I,1]].Z,VTX[v[I,2]].Z,VTX[v[I,3]].Z))and
                     (ip.Z<=Max(VTX[v[I,1]].Z,VTX[v[I,2]].Z,VTX[v[I,3]].Z))and
                     (ip.Y>=Min(VTX[v[I,1]].Y,VTX[v[I,2]].Y,VTX[v[I,3]].Y))and
                     (ip.Y<=Max(VTX[v[I,1]].Y,VTX[v[I,2]].Y,VTX[v[I,3]].Y))
                  then begin
                    inc(CutOff.e[2]);

                    sa:=GetLength(vs); //Sun<->Vertex
                    sb:=GetLength(ip.X-sp.X,ip.Y-sp.Y,ip.Z-sp.Z); //Sun<->Intersection

                    inc(CutOff.f[1]);
                    //Eliminate those farther than test point
                    if sb<sa then begin
                      inc(CutOff.f[2]);
                      v1.X:=VTX[v[I,1]].X; v1.Y:=VTX[v[I,1]].Y; v1.Z:=VTX[v[I,1]].Z;
                      v2.X:=VTX[v[I,2]].X; v2.Y:=VTX[v[I,2]].Y; v2.Z:=VTX[v[I,2]].Z;
                      v3.X:=VTX[v[I,3]].X; v3.Y:=VTX[v[I,3]].Y; v3.Z:=VTX[v[I,3]].Z;

                      Normal2Poly(v1,v2,ip,@n1); Normalize(n1);
                      Normal2Poly(v2,v3,ip,@n2); Normalize(n2);
                      Normal2Poly(v3,v1,ip,@n3); Normalize(n3);
                      //slight variations are ok, cos rounding errors
                      inc(CutOff.g[1]);
                      if (abs(n1.X-n2.X)<0.2)and(abs(n1.Y-n2.Y)<0.2)and(abs(n1.Z-n2.Z)<0.2)and
                         (abs(n2.X-n3.X)<0.2)and(abs(n2.Y-n3.Y)<0.2)and(abs(n2.Z-n3.Z)<0.2) then
                      begin
                        inc(CutOff.g[2]);
                        VTX[K].Shadow:=ShadHi;
                        break;
                      end;

                    end;

                  end;

                end;

              end;

            end;

          end;
          inc(ci,v06[Trace2Sun[BlockID,cb],ci]+2); //qty+2
          if VTX[K].Shadow>128 then break; //Trace if vertex still not shaded

        until(v06[Trace2Sun[BlockID,cb],ci]=0); //end of list

      end;
      if VTX[K].Shadow>128 then break; //Trace if vertex still not shaded

    end;//1..cb

  end;//if UniqV[K]<>K then else

end;//for K:=VTXQty[64] downto 1

if ShowLog then begin
  Form1.MemoLog.Lines.Add('Dup   '+inttostr(round(CutOff.a[2]/CutOff.a[1]*100))+'% vertices used ('+inttostr(CutOff.a[2])+')');
  Form1.MemoLog.Lines.Add('BlokH '+inttostr(round(CutOff.b[2]/CutOff.b[1]*100))+'% vertices used ('+inttostr(CutOff.b[2])+')');
  Form1.MemoLog.Lines.Add('PolyH '+inttostr(round(CutOff.c[2]/CutOff.c[1]*100))+'% vertices used ('+inttostr(CutOff.c[2])+')');
  Form1.MemoLog.Lines.Add('Paral '+inttostr(round(CutOff.d[2]/CutOff.d[1]*100))+'% vertices used ('+inttostr(CutOff.d[2])+')');
  Form1.MemoLog.Lines.Add('Bbox  '+inttostr(round(CutOff.e[2]/CutOff.e[1]*100))+'% vertices used ('+inttostr(CutOff.e[2])+')');
  Form1.MemoLog.Lines.Add('Beyon '+inttostr(round(CutOff.f[2]/CutOff.f[1]*100))+'% vertices used ('+inttostr(CutOff.f[2])+')');
  Form1.MemoLog.Lines.Add('InPol '+inttostr(round(CutOff.g[2]/CutOff.g[1]*100))+'% vertices used ('+inttostr(CutOff.g[2])+')');
end;

/////////////////////////////////////////////
// -- Detalization --
/////////////////////////////////////////////
if TraceDetails then begin
  Step:=Qty.Polys div 50; //2% step
  if ShowLog then Form1.MemoLog.Lines.Add('Second pass');

  FillChar(CutOff,sizeof(CutOff),#0);

  for K:=1 to Qty.Polys do for m:=1 to 3 do begin
    //Subsequentaly check polygon edges AB, BC, CA
    //Somehow this can be optimized to check adjustment polys edge ...
    case m of
      1:begin ind1:=v[k,1]; ind2:=v[k,2]; end;
      2:begin ind1:=v[k,2]; ind2:=v[k,3]; end;
      3:begin ind1:=v[k,3]; ind2:=v[k,1]; end;
    end;

    if ShowLog then
      if k mod Step = 0 then begin
      Form1.TraceShadows.Caption:=inttostr(round(k/Qty.Polys*100))+' %';
      Form1.TraceShadows.Refresh;
    end;

    inc(CutOff.a[1]);
    //Make detalisation if there is a shadow gradient along edge
    if (VTX[ind1].Shadow AND 128)<>(VTX[ind2].Shadow AND 128) then begin
      inc(CutOff.a[2]);
      //Make Ind1 least-shaded and Ind2 most-shaded
      if VTX[ind1].Shadow>VTX[ind2].Shadow then begin ci:=ind2; ind2:=ind1; ind1:=ci; end;
      //Subsequentaly check middle of the edge and then quarter of it.
      for j:=1 to 2 do begin
        StripQuest := 0;
        case j of
          1:begin
              vp.X:=(VTX[ind1].X+VTX[ind2].X)/2;  //00?SS
              vp.Y:=(VTX[ind1].Y+VTX[ind2].Y)/2;
              vp.Z:=(VTX[ind1].Z+VTX[ind2].Z)/2;
              Strip[1]:=-1; Strip[2]:=-1; Strip[3]:=-1;
              StripQuest:=2;
            end;
          2:if Strip[2]=1 then begin
              vp.X:=(VTX[ind1].X*3+VTX[ind2].X)/4; //0?SSS
              vp.Y:=(VTX[ind1].Y*3+VTX[ind2].Y)/4;
              vp.Z:=(VTX[ind1].Z*3+VTX[ind2].Z)/4;
              StripQuest:=1;
            end else begin
              vp.X:=(VTX[ind1].X+VTX[ind2].X*3)/4; //000?S
              vp.Y:=(VTX[ind1].Y+VTX[ind2].Y*3)/4;
              vp.Z:=(VTX[ind1].Z+VTX[ind2].Z*3)/4;
              StripQuest:=3;
            end;
        end; //case j of ...

        //vp //POrigin
        sp.X:=vp.X+LVL.SunX*1000000; sp.Y:=vp.Y+LVL.SunY*1000000; sp.Z:=vp.Z+LVL.SunZ*1000000;
        vs.X:=vp.X-sp.X; vs.Y:=vp.Y-sp.Y; vs.Z:=vp.Z-sp.Z; //PVector to Sun (x1-x2)
        //Eliminate those farther than test point
        //sa:=GetLength(pv[1],pv[2],pv[3]); //Sun<->Vertex

        //Get vertex Block
        bx:=EnsureRange(trunc(vp.X/256+Qty.BlocksX*2+1),1,Qty.BlocksX*4);
        bz:=EnsureRange(trunc(vp.Z/256+Qty.BlocksZ*2+1),1,Qty.BlocksZ*4);
        BlockID:=round((bz-1)*Qty.BlocksX*4+bx);

        inc(CutOff.b[1]);
        for cb:=Trace2Sun[BlockID,0] downto 1 do begin//reverse is faster
          inc(CutOff.b[2]);
          ci:=1;
          repeat
            for cv:=1 to v06[Trace2Sun[BlockID,cb],ci] do begin // Polycount; BlockID; ..polys..; Polycount; BlockID; ..polys..; 0-terminator.
              //Block[z,x].FirstPoly
              I:=Block[(v06[Trace2Sun[BlockID,cb],ci+1]div Qty.BlocksX+1),
                       (v06[Trace2Sun[BlockID,cb],ci+1]mod Qty.BlocksX+1)].FirstPoly+1+v06[Trace2Sun[BlockID,cb],ci+1+cv];

              if NoShadow[I]=false then begin

                //Include only those polys above the point, cos sun can't go down
                inc(CutOff.c[1]);
                if (vp.Y<H[I]){and(dx<H[I])}then begin
                  inc(CutOff.c[2]);
                  //check that dist to v[I,1],v[I,2],v[I,3] big enough to be different point - doesn't matter
                  t:=ABC[I].X*vs.X+ABC[I].Y*vs.Y+ABC[I].Z*vs.Z;      //A(x1-x2)+B(y1-y2)+C(z1-z2)

                  inc(CutOff.d[1]);
                  if t<>0 then begin //Ray parallel to poly
                    inc(CutOff.d[2]);
                    u:=(ABC[I].X*vp.X+ABC[I].Y*vp.Y+ABC[I].Z*vp.Z+D[I])/t; //A*x1+B*y1+C*z1+D
                    ip.X:=vp.X-u*(vs.X); //IntersectionPoint
                    ip.Y:=vp.Y-u*(vs.Y);
                    ip.Z:=vp.Z-u*(vs.Z);
                    inc(CutOff.e[1]);
                    if (ip.X>=Min(VTX[v[I,1]].X,VTX[v[I,2]].X,VTX[v[I,3]].X))and
                       (ip.X<=Max(VTX[v[I,1]].X,VTX[v[I,2]].X,VTX[v[I,3]].X))and
                       (ip.Z>=Min(VTX[v[I,1]].Z,VTX[v[I,2]].Z,VTX[v[I,3]].Z))and
                       (ip.Z<=Max(VTX[v[I,1]].Z,VTX[v[I,2]].Z,VTX[v[I,3]].Z))and
                       (ip.Y>=Min(VTX[v[I,1]].Y,VTX[v[I,2]].Y,VTX[v[I,3]].Y))and
                       (ip.Y<=Max(VTX[v[I,1]].Y,VTX[v[I,2]].Y,VTX[v[I,3]].Y))
                    then begin
                      inc(CutOff.e[2]);
                      //Eliminate those farther than test point
                      sa:=GetLength(vs); //Sun<->Vertex
                      sb:=GetLength(ip.X-sp.X,ip.Y-sp.Y,ip.Z-sp.Z); //Sun<->Intersection
                      inc(CutOff.f[1]);
                      if sb<sa then begin
                        inc(CutOff.f[2]);
                        v1.X:=VTX[v[I,1]].X; v1.Y:=VTX[v[I,1]].Y; v1.Z:=VTX[v[I,1]].Z;
                        v2.X:=VTX[v[I,2]].X; v2.Y:=VTX[v[I,2]].Y; v2.Z:=VTX[v[I,2]].Z;
                        v3.X:=VTX[v[I,3]].X; v3.Y:=VTX[v[I,3]].Y; v3.Z:=VTX[v[I,3]].Z;

                        Normal2Poly(v1,v2,ip,@n1); Normalize(n1);
                        Normal2Poly(v2,v3,ip,@n2); Normalize(n2);
                        Normal2Poly(v3,v1,ip,@n3); Normalize(n3);
                        inc(CutOff.g[1]);
                        //slight variations are ok, cos rounding errors
                        if (abs(n1.X-n2.X)<0.2)and(abs(n1.Y-n2.Y)<0.2)and(abs(n1.Z-n2.Z)<0.2)and
                           (abs(n2.X-n3.X)<0.2)and(abs(n2.Y-n3.Y)<0.2)and(abs(n2.Z-n3.Z)<0.2) then
                        begin
                          inc(CutOff.g[2]);
                          Strip[StripQuest]:=1;
                          break;
                        end;

                      end;

                    end;

                  end;

                end;
                
              end;

            end;
            inc(ci,v06[Trace2Sun[BlockID,cb],ci]+2); //qty+2
            if Strip[StripQuest]=1 then break; //Trace if vertex still not shaded

          until(v06[Trace2Sun[BlockID,cb],ci]=0); //end of list

          if Strip[StripQuest]=1 then break; //Trace if vertex still not shaded
        end;//1..cb
      end; //for j:=1 to 1 - Strip[..]

      cv:=ShadLo+Strip[2]*Shad2; //Least shadow     OoooX OooxX 0oxxX 0xxxX
      if Strip[2]=1 then inc(cv,Strip[1]*Shad4)
                    else inc(cv,Strip[3]*Shad4);
      VTX[ind1].Shadow:=EnsureRange(cv,0,255);
      cv:=ShadHi+Strip[2]*Shad2; //Most shadow     OoooX OooxX 0oxxX 0xxxX
      if Strip[2]=1 then inc(cv,Strip[1]*Shad4)
                    else inc(cv,Strip[3]*Shad4);
      VTX[ind2].Shadow:=EnsureRange(cv,0,255);

    end; //shadow edge

  end; //for K:=1 to Qty.Polys do for m:=1 to 3

//FillChar(ShadAcc,sizeof(ShadAcc),#0);
setlength(ShadAcc,VTXQty[64]+1);

for K:=VTXQty[64] downto 1 do begin
  inc(ShadAcc[K].Count);
  inc(ShadAcc[K].Value,VTX[K].Shadow);
  if UniqV[K]<>K then begin //Summ up with duplicate vertice
    inc(ShadAcc[UniqV[K]].Count,ShadAcc[K].Count);
    inc(ShadAcc[UniqV[K]].Value,ShadAcc[K].Value);
  end;
end;

for K:=VTXQty[64] downto 1 do
  if UniqV[K]=K then
    VTX[K].Shadow:=round (ShadAcc[UniqV[K]].Value / ShadAcc[UniqV[K]].Count)
  else
    VTX[K].Shadow:=VTX[UniqV[K]].Shadow;

if ShowLog then begin
  Form1.MemoLog.Lines.Add(inttostr(round(CutOff.a[2]/CutOff.a[1]*100))+'% vertices used ('+inttostr(CutOff.a[2])+')');
  Form1.MemoLog.Lines.Add(inttostr(round(CutOff.b[2]/CutOff.b[1]*100))+'% vertices used ('+inttostr(CutOff.b[2])+')');
  Form1.MemoLog.Lines.Add(inttostr(round(CutOff.c[2]/CutOff.c[1]*100))+'% vertices used ('+inttostr(CutOff.c[2])+')');
  Form1.MemoLog.Lines.Add(inttostr(round(CutOff.d[2]/CutOff.d[1]*100))+'% vertices used ('+inttostr(CutOff.d[2])+')');
  Form1.MemoLog.Lines.Add(inttostr(round(CutOff.e[2]/CutOff.e[1]*100))+'% vertices used ('+inttostr(CutOff.e[2])+')');
  Form1.MemoLog.Lines.Add(inttostr(round(CutOff.f[2]/CutOff.f[1]*100))+'% vertices used ('+inttostr(CutOff.f[2])+')');
  Form1.MemoLog.Lines.Add(inttostr(round(CutOff.g[2]/CutOff.g[1]*100))+'% vertices used ('+inttostr(CutOff.g[2])+')');
end;

end; //if TraceDetails

end;//1..Test
Form1.MemoLog.Lines.Add('Complete in '+ElapsedTime(@OldTime));
Form1.MemoLog.Lines.Add('');
Form1.MemoLog.Lines.Add('Click here to remove this frame');
Form1.TraceShadows.Caption:='Trace shadows';
Changes.VTX:=true;
list_id:=0;
list_ogl:=0;
end;

end.
