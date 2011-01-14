unit Unit_Grass;
interface
uses StdCtrls, Windows, Defaults, KromUtils, Math, SysUtils, OpenGL, dglOpenGL, Unit_Render, PTXTexture;

{ Although there are 4 distinct LOD files we will treat them as one Grass setup
  There's no need to treat them separately for any reasons, that brings only confusion. }
const MAX_RO_FILES = 4;

type
  TSGrass = class
    private
      RO:array[1..MAX_RO_FILES]of record
        Head:record x1,x2,x3,sizeX,sizeZ,XZ,Qty,Density:integer; end;
        Tex:string[32];
        UV:array[1..4]of record X:array[1..8]of single; end;
        Chunks:array of array of record First,Num:integer; end;
        Grass:array of record
          X,Y,Z:single;
          ID,Size:byte;
          Color:word;
        end;
      end;

      function GetTexName():string;
      procedure SetTexName(aTexName:string);
    public
      Changed:boolean;

      property TexName:string read GetTexName write SetTexName;
      function GetStats(LOD, aIndex:integer):string;
      procedure ReloadTexture();

      procedure Generate(aProgressLabel:Pointer);
      procedure SetPlainColor(R,G,B:byte);
      procedure LoadColorFromTGA(aTGAFile:string);

      function  LoadFromFile(aFile:string):boolean;
      procedure SaveToFile(aFile:string; Optimize:boolean);
      procedure Render(aLOD,GMode:integer; RenderMode:RenderModeTypes);
    end;


implementation
uses Unit1;


function TSGrass.GetStats(LOD, aIndex:integer):string;
begin
  case aIndex of
    1: Result := inttostr(RO[lod].Head.x1);
    2: Result := inttostr(RO[lod].Head.x2);
    3: Result := inttostr(RO[lod].Head.x3);
    4: Result := inttostr(RO[lod].Head.sizeX);
    5: Result := inttostr(RO[lod].Head.sizeZ);
    6: Result := inttostr(RO[lod].Head.XZ);
    7: Result := inttostr(RO[lod].Head.Qty);
    8: Result := inttostr(RO[lod].Head.Density);
  end;
end;


function TSGrass.GetTexName():string;
begin
  Result := RO[1].Tex;
end;


procedure TSGrass.SetTexName(aTexName:string);
var i:integer;
begin
  for i:=1 to MAX_RO_FILES do
    RO[i].Tex := aTexName;
  Changed := true;
end;


procedure TSGrass.Generate(aProgressLabel:Pointer);
const Num=16;
var
  LOD:integer;
  Dens:integer; //Grass density per "side"
  i,k,ii,kk,x,z,ci,ck,cb,tmp:integer;
  ps:array of word; //There could be more than 255 materials, hence we use "word"
  inx,ResultY,inz:single; //XYZ for height finding
  PolyQty:integer;
  x1,z1,x2,z2,x3,z3,ytemp,nx,ny,nz,D:single;
  v1,v2,v3:array[1..3] of single;
  tp:array[1..Num]of integer;
  s:string;
begin
  for LOD:=1 to MAX_RO_FILES do begin
    case LOD of
      1: begin RO[LOD].Head.Density:=2560; Dens:=11; end; //Dens^2 ~= 128,256,512,1024
      2: begin RO[LOD].Head.Density:=5120; Dens:=16; end;
      3: begin RO[LOD].Head.Density:=10240; Dens:=22; end;
      4: begin RO[LOD].Head.Density:=20480; Dens:=32; end;
      else exit;
    end;

    RO[LOD].Head.x1     := 65536;
    RO[LOD].Head.x2     := 1;
    RO[LOD].Head.x3     := 4;
    RO[LOD].Head.sizeX  := Qty.BlocksX*4;
    RO[LOD].Head.sizeZ  := Qty.BlocksZ*4;
    RO[LOD].Head.XZ     := RO[LOD].Head.sizeX*RO[LOD].Head.sizeZ;
    RO[LOD].Head.Qty    := 0;
    if RO[LOD].Tex = '' then RO[LOD].Tex := 'RandObj';

    setlength(RO[LOD].Chunks,RO[LOD].Head.sizeZ+1);
    for i:=1 to RO[LOD].Head.sizeZ do setlength(RO[LOD].Chunks[i],RO[LOD].Head.sizeX+1);

    setlength(RO[LOD].Grass,Dens*Dens*RO[LOD].Head.sizeZ*RO[LOD].Head.sizeX+1);

    setlength(ps,Qty.Polys+1); k:=1;
    for i:=1 to Qty.Polys do begin
      if i=v07[k+1].FirstPoly+1 then inc(k);
      ps[i]:=v07[k].SurfaceID+1;
    end;

    ci:=0; tmp:=0;
    for i:=1 to RO[lod].Head.sizeZ do begin
      if aProgressLabel<>nil then begin
        TLabel(aProgressLabel).Caption := Format('%d.%d%',[LOD, round(i/RO[lod].Head.sizeZ*100)]);
        TLabel(aProgressLabel).Refresh;
      end;
      for k:=1 to RO[lod].Head.sizeX do begin
        RO[lod].Chunks[i,k].First:=ci;

        for z:=1 to Dens do for x:=1 to Dens do begin
          RO[lod].Grass[ci+1].X:=((x-0.5)/Dens+(k-1)-Qty.BlocksX*2+RandomS(0.33/Dens))*256; // +/-0.33
          RO[lod].Grass[ci+1].Z:=((z-0.5)/Dens+(i-1)-Qty.BlocksZ*2+RandomS(0.33/Dens))*256; // +/-0.33

          inx:=RO[lod].Grass[ci+1].X;
          inz:=RO[lod].Grass[ci+1].Z;

          //Check polys under given X/Z whenever they meet following requirements:
          // - Has GrowGrass material property
          // - Are faced up
          // - Are highest from all found meeting previous conditions
          PolyQty:=1; ck:=1; tp[1]:=0; ResultY:=DONT_TRACE_TAG;
          cb:=                                                                    //CollisionBlock:=
              (EnsureRange(round(inz/256+0.5+Qty.BlocksZ*2),1,Qty.BlocksZ*4)-1)*  //(Z-1)*
               Qty.BlocksX*4+                                                     //Qty.BlocksX*4+
               EnsureRange(round(inx/256+0.5+Qty.BlocksX*2),1,Qty.BlocksX*4);     //(X-1)+1

          repeat
            for ii:=1 to v06[cb][ck] do begin // Polycount; BlockID; ..polys..; Polycount; BlockID; ..polys..; 0-terminator.
              kk:=Block[((v06[cb,ck+1])div Qty.BlocksX+1),
                        ((v06[cb,ck+1])mod Qty.BlocksX+1)].FirstPoly+1+v06[cb,ck+1+ii];

              if MaterialW[ps[kk]].GrowGrass=1 then begin
                x1:=inx-VTX[v[kk,1]].X; z1:=inz-VTX[v[kk,1]].Z;
                x2:=inx-VTX[v[kk,2]].X; z2:=inz-VTX[v[kk,2]].Z;
                x3:=inx-VTX[v[kk,3]].X; z3:=inz-VTX[v[kk,3]].Z;

                if (-x1*z2+z1*x2>=0) //point within triangle makes 3 triangles whose normals face up (nY > 0)
                and(-x2*z3+z2*x3>=0) //simply check if any of these normals Y>=0
                and(-x3*z1+z3*x1>=0) then begin
                  tp[PolyQty]:=kk;
                  if PolyQty<Num then inc(PolyQty); //avoid overflows
                end;
              end;
            end;
            inc(ck,v06[cb,ck]+2); //qty+2
          until(v06[cb,ck]=0); //end of list

          dec(PolyQty);

          for ii:=1 to PolyQty do begin
            v1[1]:=VTX[v[tp[ii],1]].X; v1[2]:=VTX[v[tp[ii],1]].Y; v1[3]:=VTX[v[tp[ii],1]].Z;
            v2[1]:=VTX[v[tp[ii],2]].X; v2[2]:=VTX[v[tp[ii],2]].Y; v2[3]:=VTX[v[tp[ii],2]].Z;
            v3[1]:=VTX[v[tp[ii],3]].X; v3[2]:=VTX[v[tp[ii],3]].Y; v3[3]:=VTX[v[tp[ii],3]].Z;
            Normal2Poly(v1,v2,v3,@nx,@ny,@nz);
            Normalize(nx,ny,nz);
            D:=-(nx*VTX[v[tp[ii],1]].X+ny*VTX[v[tp[ii],1]].Y+nz*VTX[v[tp[ii],1]].Z);
            ytemp:=-(inx*nx+inz*nz+D)/ny; //true height respecting poly surface
            if ((ytemp > ResultY)and(ny > 0))or(ii=1) then ResultY:=ytemp; //choose highest one
          end;

          if ResultY<>DONT_TRACE_TAG then begin
            RO[lod].Grass[ci+1].Y:=ResultY;
            inc(ci);
            RO[lod].Grass[ci].Size:=Random(16);
            RO[lod].Grass[ci].ID:=Random(4); //4 is reserved for fields
            RO[lod].Grass[ci].Color:=(Random(65536)) mod 65535; //temp colors
          end;
        end;

        RO[lod].Chunks[i,k].Num:=ci-RO[lod].Chunks[i,k].First;
      end; //i
    end; //k
    RO[lod].Head.Qty:=ci;

    //s:=ElapsedTime(@OldTime); decs(s,5); // XX***ms
    //Label92.Caption:=s+'s';

    //4 items in a strip
    for i:=1 to 4 do begin
      RO[lod].UV[i].X[1] := 0;
      RO[lod].UV[i].X[2] := (i-1)*0.25;
      RO[lod].UV[i].X[3] := 0;
      RO[lod].UV[i].X[4] := i*0.25;
      RO[lod].UV[i].X[5] := 1;
      RO[lod].UV[i].X[6] := 10;
      RO[lod].UV[i].X[7] := 10;
      RO[lod].UV[i].X[8] := 0;
    end;

  end;
  Changed := true;
end;


procedure TSGrass.ReloadTexture();
begin
  LoadTexturePTX(SceneryPath+'Textures\'+RO[1].Tex+'.ptx',coGrassTex);
end;


procedure TSGrass.SetPlainColor(R,G,B:byte);
var i,LOD:integer;
begin
  R := EnsureRange(R div 15,0,15);
  G := EnsureRange(G div 15,0,15);
  B := EnsureRange(B div 15,0,15);

  for LOD := 1 to MAX_RO_FILES do
    for i:=1 to RO[LOD].Head.Qty do begin
      RO[LOD].Grass[i].Color :=
        EnsureRange(b+Random(0),0,15)+
        EnsureRange(g+RandomS(1),0,15) shl 4+
        EnsureRange(r+Random(0),0,15) shl 8; //it's times faster to access local numbers
    end;
  Changed := true;
end;


{ Will load TGA image and apply it's color to grass underneath
  Mask will be used to determine where grass grows }
procedure TSGrass.LoadColorFromTGA(aTGAFile:string);
const Num=16; //how many polys to check
var
  f:file;
  i,k,x,ci,ck:integer;
  sx,sz:word;
  HasAlpha:boolean;
  tga:array of array of array[1..4] of byte;
  ix,iz:integer;
  rx,rz:single;
  r1,g1,b1,a1:integer;
  LOD:integer;
begin
  assignfile(f,aTGAFile); reset(f,1);
  blockread(f,c,12);
  blockread(f,sx,2);
  blockread(f,sz,2);
  blockread(f,c,2); HasAlpha:=c[1]=#32;

  if (sx>2048)or(sz>2048) then begin
    MessageBox(Form1.Handle,'Image size exceeds 2048px limit', 'Error', MB_OK or MB_ICONWARNING);
    closefile(f);
    exit;
  end;

  if HasAlpha then ci:=sx*sz*4 else ci:=sx*sz*3;

  blockread(f,c,ci);
  ci:=1;
  setlength(tga,sz+1);
  for i:=1 to sz do begin
    setlength(tga[i],sx+1);
    for k:=1 to sx do begin  //BGRA
      tga[i,k,1]:=ord(c[ci]);
      tga[i,k,2]:=ord(c[ci+1]);
      tga[i,k,3]:=ord(c[ci+2]);
      if HasAlpha then tga[i,k,4]:=ord(c[ci+3]) else tga[i,k,4]:=255;
      if HasAlpha then inc(ci,4) else inc(ci,3);
    end;
  end;
  closefile(f);

  for LOD:=1 to MAX_RO_FILES do begin

    ci:=0; ck:=0;
    for i:=1 to RO[lod].Head.sizeZ do begin
    //Label92.Caption:=inttostr(round(i/RO[lod].Head.sizeZ*100))+' %';
    //Label92.Refresh;
    //RenderFrame(nil);
    for k:=1 to RO[lod].Head.sizeX do begin
    RO[lod].Chunks[i,k].First:=ci;

        for x:=1 to RO[lod].Chunks[i,k].Num do begin
        inc(ck);
        RO[lod].Grass[ci+1]:=RO[lod].Grass[ck];

          rx:=sx*(RO[LOD].Grass[ci+1].X+Qty.BlocksX*512)/(Qty.BlocksX*1024)+1;
          rz:=sz*(RO[LOD].Grass[ci+1].Z+Qty.BlocksZ*512)/(Qty.BlocksZ*1024)+1;
          rx:=EnsureRange(rx,1,sx);
          rz:=EnsureRange(rz,1,sz);
          ix:=EnsureRange(trunc(rx),1,sx-1); rx:=frac(rx);
          iz:=EnsureRange(trunc(rz),1,sz-1); rz:=frac(rz);

          r1:=round((tga[iz  ,ix,3]*(1-rx)+tga[iz  ,ix+1,3]*(rx))*(1-rz)+
                    (tga[iz+1,ix,3]*(1-rx)+tga[iz+1,ix+1,3]*(rx))*rz   );

          g1:=round((tga[iz  ,ix,2]*(1-rx)+tga[iz  ,ix+1,2]*(rx))*(1-rz)+
                    (tga[iz+1,ix,2]*(1-rx)+tga[iz+1,ix+1,2]*(rx))*rz   );

          b1:=round((tga[iz  ,ix,1]*(1-rx)+tga[iz  ,ix+1,1]*(rx))*(1-rz)+
                    (tga[iz+1,ix,1]*(1-rx)+tga[iz+1,ix+1,1]*(rx))*rz   );

          a1:=round((tga[iz  ,ix,2]*(1-rx)+tga[iz  ,ix+1,2]*(rx))*(1-rz)+
                     (tga[iz+1,ix,2]*(1-rx)+tga[iz+1,ix+1,2]*(rx))*rz   );

          RO[LOD].Grass[i].Color:=
            EnsureRange(round(b1/17),0,15)+
            EnsureRange(round(g1/17),0,15)*16+
            EnsureRange(round(r1/17),0,15)*256;

          if (a1=255)or((a1>25)and(Random*((a1/255))>=0.3)) then begin //0.5*0.5 ~ 0.25
          RO[lod].Grass[ci+1].Size:=Random(round(16*a1/255));
          inc(ci);
          end;
        end;

    RO[lod].Chunks[i,k].Num:=ci-RO[lod].Chunks[i,k].First;
    end; //i
    end; //k
    RO[lod].Head.Qty:=ci;
  end;// for LOD:=1 to 4 do begin
  Changed := true;

  //Label92.Caption:=ElapsedTime(@OldTime);
end;


function TSGrass.LoadFromFile(aFile:string):boolean;
var
  i,LOD:integer;
  f:file;
  FileName:string; c:array[1..33]of char;
begin
  Result := false;

  for LOD:=1 to MAX_RO_FILES do begin
    FileName := aFile+'.RO'+inttostr(LOD);
    if not FileExists(FileName) then begin
      RO[LOD].Head.Qty   := 0;
      RO[LOD].Head.sizeX := 0;
      RO[LOD].Head.sizeZ := 0;
    end else begin
      AssignFile(f,FileName); FileMode:=0; reset(f,1); FileMode:=2;
      blockread(f,RO[LOD].Head,32);
      setlength(RO[LOD].Chunks,RO[LOD].Head.sizeZ+1);
      for i:=1 to RO[LOD].Head.sizeZ do
        setlength(RO[LOD].Chunks[i],RO[LOD].Head.sizeX+1);
      blockread(f,c,32); c[33]:=#0; //Make sure it's 0-terminated
      RO[LOD].Tex := StrPas(@c); //Name
      blockread(f,RO[LOD].UV,128);
      for i:=1 to RO[LOD].Head.sizeZ do
        blockread(f,RO[LOD].Chunks[i,1],RO[LOD].Head.sizeX*8);
      setlength(RO[LOD].Grass,RO[LOD].Head.Qty+1);
      blockread(f,RO[LOD].Grass[1],RO[LOD].Head.Qty*16); //R=0..3, G=0..15, B=0..15 16..255, A=0..15
      closefile(f);
      Result := true;
    end;
  end;

  Changed := false;
end;


procedure TSGrass.SaveToFile(aFile:string; Optimize:boolean);
var
  f:file;
  i,LOD:integer;
begin

  for LOD:=1 to MAX_RO_FILES do begin
    if Optimize=true then
    for i:=1 to RO[LOD].Head.Qty do begin
      RO[LOD].Grass[i].X:=round(RO[LOD].Grass[i].X/2)*2;
      RO[LOD].Grass[i].Y:=round(RO[LOD].Grass[i].Y-0.2);
      RO[LOD].Grass[i].Z:=round(RO[LOD].Grass[i].Z/2)*2;
      RO[LOD].Grass[i].Size:=EnsureRange(round(RO[LOD].Grass[i].Size/2)*2,0,15);
    end;

    assignfile(f,aFile+'.ro'+inttostr(LOD)); rewrite(f,1);
    blockwrite(f,RO[LOD].Head,32);
    blockwrite(f,chr2(RO[LOD].Tex,32)[1],32);
    blockwrite(f,RO[LOD].UV,128);
    for i:=1 to RO[LOD].Head.sizeZ do
      blockwrite(f,RO[LOD].Chunks[i,1],RO[LOD].Head.sizeX*8);
    blockwrite(f,RO[LOD].Grass[1],RO[LOD].Head.Qty*16);
    closefile(f);
  end;

  Changed := false;
end;


procedure TSGrass.Render(aLOD,GMode:integer; RenderMode:RenderModeTypes);
var ii,kk,h,m:integer;
begin
  if aLOD=0 then exit;
  if RO[aLOD].Head.Qty=0 then exit;

  if RenderMode<rmFull then
    glBegin(GL_POINTS)
  else begin
    glEnable(GL_ALPHA_TEST);
    glAlphaFunc(GL_GREATER,0.5);
    glBlendFunc(GL_ONE, GL_ZERO);
    case GMode of
      1,2: glBindTexture(GL_TEXTURE_2D,0);
      3:   glBindTexture(GL_TEXTURE_2D,coGrassTex);
    end;
  end;


  for m:=1 to 4 do
  for kk:=1 to RO[aLOD].Head.sizeZ do for ii:=1 to RO[aLOD].Head.sizeX do
  if GetLength(((ii-RO[aLOD].Head.sizeX/2)*256-xPos),((kk-RO[aLOD].Head.sizeZ/2)*256-zPos))<fOptions.ViewDistance/6 then
  for h:=RO[aLOD].Chunks[kk,ii].First+1 to RO[aLOD].Chunks[kk,ii].First+RO[aLOD].Chunks[kk,ii].Num do
  if RO[aLOD].Grass[h].ID+1=m then begin
    EnsureRange(h,1,RO[aLOD].Head.Qty);

    case GMode of  //R=0..3, G=0..15, B=BG, A=R0
      1: SetPresetColorGL(RO[aLOD].Grass[h].ID*2+1,1); //Type
      2: glcolor4f(RO[aLOD].Grass[h].Size/15,RO[aLOD].Grass[h].Size/15,RO[aLOD].Grass[h].Size/15,1);
      3: glColor3ub((RO[aLOD].Grass[h].Color and 3840)div 16+15,(RO[aLOD].Grass[h].Color and 240+15),(RO[aLOD].Grass[h].Color and 15)*16+15); //Convert 16bit to RGB
    end;

    if fOptions.RenderMode >= rmFull then begin
      glPushMatrix;
        glTranslatef(RO[aLOD].Grass[h].X,RO[aLOD].Grass[h].Y,RO[aLOD].Grass[h].Z);
        glRotatef(xRot,0,1,0);
        if GMode<3 then glRotatef(180+yRot,1,0,0);
        glScalef(0.8+RO[aLOD].Grass[h].Size/20,0.8+RO[aLOD].Grass[h].Size/20,0.8+RO[aLOD].Grass[h].Size/20); //80cm..150cm
        glCallList(coGrass[m]);
      glPopMatrix;
    end else
      glVertex3f(RO[aLOD].Grass[h].X,RO[aLOD].Grass[h].Y+5,RO[aLOD].Grass[h].Z); //+5 to raise above the ground
  end;

  if fOptions.RenderMode<rmFull then
    glEnd;

  glBindTexture(GL_TEXTURE_2D,0);
  glDisable(GL_ALPHA_TEST);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
end;


end.
