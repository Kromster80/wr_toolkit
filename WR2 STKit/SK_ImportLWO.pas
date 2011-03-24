unit SK_ImportLWO;
interface
uses Unit1,sysutils,Windows,KromUtils,Math,dglOpenGL,Unit_Defaults;

  procedure LoadLWO(Input:string);
  procedure PrepareLWOData();
  procedure CompileVTX_IDX();
  procedure CompileQAD();
  procedure OptimizeVerticesClick_();
  procedure OptimizeCullingSpheresClick_();
  procedure PrepareOtherData();

implementation

procedure LoadLWO(Input:string);
var
  f:file;
  ii,kk,j:integer;
  ChapSize,FileSize,sz:integer;
  ChapName:string[4];
  lay,SurfaceID:integer;           //
  s:string;
begin
  if not fileexists(Input) then exit;

  ElapsedTime(@OldTime);
  assignfile(f,Input); reset(f,1);

  Lay:=0;
  for ii:=1 to length(LW.ClipTex) do LW.ClipTex[ii]:='';

  FillChar(LWQty, SizeOf(LWQty), #0);

  SurfaceID := 1;

  blockread(f,c,12);
  if (c[1]+c[2]+c[3]+c[4]+c[9]+c[10]+c[11]+c[12])<>'FORMLWO2' then begin
    MessageBox(Form1.Handle,'Old or unknown LWO format','Error',MB_OK or MB_ICONERROR);
    closefile(f);
    exit;
  end;
  FileSize := int2(c[8],c[7],c[6],c[5])-4;

  repeat
    blockread(f,c,8);
    ChapName := c[1]+c[2]+c[3]+c[4];
    ChapSize := int2(c[8],c[7],c[6],c[5]);
    FileSize := FileSize - ChapSize - 8;

    if ChapName='TAGS' then begin
      blockread(f,c,ChapSize);
      ii:=0;
      repeat
        inc(ii,2);
        if c[ii]=#0 then inc(LWQty.Tags[0]);
      until(ii=ChapSize);
    end else

    if ChapName='LAYR' then begin
      blockread(f,c,ChapSize);
      inc(Lay); //Layers come not sorted
      if Lay > MAX_LWO_LAYERS then begin
        MessageBox(Form1.Handle,'Too many layers in file','Error',MB_OK or MB_ICONERROR);
        closefile(f);
        exit;
      end;
    end else

    if ChapName='PNTS' then begin
      LWQty.Vert[lay]:=ChapSize div 12;
      setlength(LW.XYZ ,LWQty.Vert[0]+LWQty.Vert[lay]+1);
      setlength(LW.UV  ,LWQty.Vert[0]+LWQty.Vert[lay]+1);
      setlength(LW.RGBA,LWQty.Vert[0]+LWQty.Vert[lay]+1);
      setlength(LW.Nv  ,LWQty.Vert[0]+LWQty.Vert[lay]+1);
      blockread(f,c,ChapSize);
      for ii:=1 to LWQty.Vert[lay] do begin
        LW.XYZ[LWQty.Vert[0]+ii,1]:=real2(c[ii*12-8],c[ii*12-9],c[ii*12-10],c[ii*12-11])*10;
        LW.XYZ[LWQty.Vert[0]+ii,2]:=real2(c[ii*12-4],c[ii*12-5],c[ii*12-6],c[ii*12-7])*10;
        LW.XYZ[LWQty.Vert[0]+ii,3]:=real2(c[ii*12-0],c[ii*12-1],c[ii*12-2],c[ii*12-3])*10;
      end;
      inc(LWQty.Vert[0],LWQty.Vert[lay]);
    end else

    if ChapName='VMAP' then begin
    blockread(f,c,6);    //TXUV_2
    ChapName:=c[1]+c[2]+c[3]+c[4];
    dec(ChapSize,6);
    if ChapName='TXUV' then begin
      repeat
        blockread(f,c,2);
        dec(ChapSize,2); //UV-map name
      until((c[1]=#0)or(c[2]=#0));
      blockread(f,c,ChapSize);
      ii:=0;
      repeat
        inc(ii,10);
        inc(LWQty.UV[lay]);
        if c[ii-9]=#255 then begin
          kk:=ord(c[ii-8])*65536+1;
          inc(ii,2);
          inc(kk,ord(c[ii-8])+ord(c[ii-9])*256);
        end else
          kk:=ord(c[ii-8])+ord(c[ii-9])*256+1;
        LW.UV[LWQty.Vert[0]-LWQty.Vert[lay]+kk,1]:=real2(c[ii-4],c[ii-5],c[ii-6],c[ii-7]);
        LW.UV[LWQty.Vert[0]-LWQty.Vert[lay]+kk,2]:=real2(c[ii-0],c[ii-1],c[ii-2],c[ii-3]);
      until(ii>=ChapSize);
      inc(LWQty.UV[0],LWQty.UV[lay]);
      end else

    {  if (ChapName='RGBA')or(ChapName='RGB ') then begin
      repeat blockread(f,c,2); dec(ChapSize,2); //UV-map name
      until((c[1]=#0)or(c[2]=#0));
      if chname='RGBA' then sz:=18 else sz:=14;
      LWQty.RGBA[lay]:=ChapSize div sz;
      blockread(f,c,sz*LWQty.RGBA[lay]);
        for ii:=0 to LWQty.RGBA[lay]-1 do begin
        if c[ii*sz+1]=#255 then begin
        MyMessageBox(Form1.Handle,'More than 65k points in one layer.'+#13+'Split model into several layers.','Error',MB_OK or MB_ICONERROR);
        closefile(f); exit;
        end;
        kk:=ord(c[ii*sz+1])*256+ord(c[ii*sz+2])+1;
        LW.RGBA[LWQty.Vert[0]-LWQty.Vert[lay]+kk,1]:=
        EnsureRange(round(real2(c[ii*sz+6],c[ii*sz+5],c[ii*sz+4],c[ii*sz+3])*256),0,255);
        LW.RGBA[LWQty.Vert[0]-LWQty.Vert[lay]+kk,2]:=
        EnsureRange(round(real2(c[ii*sz+10],c[ii*sz+9],c[ii*sz+8],c[ii*sz+7])*256),0,255);
        LW.RGBA[LWQty.Vert[0]-LWQty.Vert[lay]+kk,3]:=
        EnsureRange(round(real2(c[ii*sz+14],c[ii*sz+13],c[ii*sz+12],c[ii*sz+11])*256),0,255);
        end;
      inc(LWQty.RGBA[0],LWQty.RGBA[lay]);
      end else  }

      begin
      Form1.MemoLWO.Lines.Add(c[1]+c[2]+c[3]+c[4]+' vertex map skipped');
      blockread(f,c,ChapSize); end;

    for ii:=1 to LWQty.Poly[lay] do for kk:=1 to 3 do begin //lqty[0]-lqty[lay] >> lqty[0]
    LW.DUV[ii+LWQty.Poly[0]-LWQty.Poly[lay],kk,1]:=LW.UV[LW.Poly[ii+LWQty.Poly[0]-LWQty.Poly[lay],kk],1];
    LW.DUV[ii+LWQty.Poly[0]-LWQty.Poly[lay],kk,2]:=LW.UV[LW.Poly[ii+LWQty.Poly[0]-LWQty.Poly[lay],kk],2];
    end;
    end else

    if ChapName='POLS' then begin
    blockread(f,c,4);
    dec(ChapSize,4);
      if (c[1]+c[2]+c[3]+c[4])<>'FACE' then begin
      Form1.MemoLWO.Lines.Add(c[1]+c[2]+c[3]+c[4]+' POLS skipped');
      blockread(f,c,ChapSize);
      LWQty.Poly[lay]:=0
      end else begin
    LWQty.Poly[lay]:=0;
        repeat inc(LWQty.Poly[lay]);
        if length(LW.Poly)-2<=LWQty.Poly[0]+LWQty.Poly[lay] then setlength(LW.Poly,length(LW.Poly)+1000); //keep (+1) free ahead for multi-point polys
        blockread(f,c,2); dec(ChapSize,2);
        kk:=ord(c[1])*256+ord(c[2]); //# of Vertices (3 or 4)

        if (kk<>3)and(kk<>4) then begin
        MessageBox(Form1.Handle,'Non-triangle/quadrangle polygon encountered','Error',MB_OK or MB_ICONERROR);
        closefile(f); exit; end;

        LW.Poly[LWQty.Poly[0]+LWQty.Poly[lay],0]:=kk;
        for ii:=1 to 3 do begin
        blockread(f,c,2); dec(ChapSize,2);
            if c[1]=#255 then begin
            LW.Poly[LWQty.Poly[0]+LWQty.Poly[lay],ii]:=ord(c[2])*65536+LWQty.Vert[0]-LWQty.Vert[lay]+1;   //0.1.2
            blockread(f,c,2); dec(ChapSize,2);
            inc(LW.Poly[LWQty.Poly[0]+LWQty.Poly[lay],ii],int2(c[2],c[1]));
            end else
        LW.Poly[LWQty.Poly[0]+LWQty.Poly[lay],ii]:=int2(c[2],c[1])+LWQty.Vert[0]-LWQty.Vert[lay]+1;   //0.1.2
        end;

        if kk=4 then begin
        inc(LWQty.AddPoly[0]);
        //if length(LW.PolyAdd)-2<=LWQty.AddPoly[0] then setlength(LW.PolyAdd,LWQty.AddPoly[0]+100);
        if length(LW.PolyAdd)<length(LW.Poly)+100 then setlength(LW.PolyAdd,length(LW.Poly)+100); //Needs to be the same
        LW.PolyAdd[LWQty.AddPoly[0]].id:=LWQty.Poly[0]+LWQty.Poly[lay]; //replicating real polyID

        LW.PolyAdd[LWQty.Poly[0]+LWQty.Poly[lay]].InvID:=LWQty.AddPoly[0]; //replicating real polyID, inverse for VMAD

        LW.PolyAdd[LWQty.AddPoly[0]].v1:=LW.Poly[LWQty.Poly[0]+LWQty.Poly[lay],1];
        LW.PolyAdd[LWQty.AddPoly[0]].v2:=LW.Poly[LWQty.Poly[0]+LWQty.Poly[lay],3];
        blockread(f,c,2); dec(ChapSize,2);
            if c[1]=#255 then begin
            LW.PolyAdd[LWQty.AddPoly[0]].v3:=ord(c[2])*65536+LWQty.Vert[0]-LWQty.Vert[lay]+1;
            blockread(f,c,2); dec(ChapSize,2);
            inc(LW.PolyAdd[LWQty.AddPoly[0]].v3,int2(c[2],c[1]));
            end else
        LW.PolyAdd[LWQty.AddPoly[0]].v3:=int2(c[2],c[1])+LWQty.Vert[0]-LWQty.Vert[lay]+1;
        end;
        until(ChapSize<=0);
    inc(LWQty.Poly[0],LWQty.Poly[lay]);

    setlength(LW.DUV,LWQty.Poly[0]+1);
    //Mirroring UVs to discontinous UVs, since DUV may not exist, while PTAG exists always :P
    for ii:=1 to LWQty.Poly[lay] do for kk:=1 to 3 do begin //lqty[0]-lqty[lay] >> lqty[0]
    LW.DUV[ii+LWQty.Poly[0]-LWQty.Poly[lay],kk,1]:=LW.UV[LW.Poly[ii+LWQty.Poly[0]-LWQty.Poly[lay],kk],1];
    LW.DUV[ii+LWQty.Poly[0]-LWQty.Poly[lay],kk,2]:=LW.UV[LW.Poly[ii+LWQty.Poly[0]-LWQty.Poly[lay],kk],2];
    end;

    end; //'FACE'
    end else

    if ChapName='PTAG' then begin
      blockread(f,c,4);
      dec(ChapSize,4);
      if (c[1]+c[2]+c[3]+c[4])<>'SURF' then begin
        Form1.MemoLWO.Lines.Add(c[1]+c[2]+c[3]+c[4]+' PTAG skipped');
        blockread(f,c,ChapSize);
      end else begin
        setlength(LW.Surf,LWQty.Poly[0]+100);
        blockread(f,c,ChapSize);
        ii:=0;
        repeat
          inc(ii,4);
          if c[ii-3]=#255 then begin
          kk:=ord(c[ii-2])*65536;           //polygon
          inc(ii,2);
          inc(kk,int2(c[ii-2],c[ii-3])+1);
        end else
          kk:=int2(c[ii-2],c[ii-3])+1;           //polygon
          LW.Surf[kk+LWQty.Poly[0]-LWQty.Poly[lay]]:=int2(c[ii-0],c[ii-1])+1;    //surface assignment
        until(ii>=ChapSize);
      end;
    end else

    if ChapName='VMAD' then begin
      blockread(f,c,6);    //TXUV_2
      dec(ChapSize,6);

      if (c[1]+c[2]+c[3]+c[4])<>'TXUV' then begin
        Form1.MemoLWO.Lines.Add(c[1]+c[2]+c[3]+c[4]+' VMAD skipped');
        blockread(f,c,ChapSize);
      end else begin

        repeat
          blockread(f,c,2);
          dec(ChapSize,2); //UV-map name
        until((c[1]=#0)or(c[2]=#0));

        repeat

          //point ; poly ; new coord
          blockread(f,c,2); dec(ChapSize,2);
          if c[1]=#255 then begin
            vmad.Vert:=ord(c[2])*65536+1; //vertex ID
            blockread(f,c,2);
            dec(ChapSize,2);
            inc(vmad.Vert,int2(c[2],c[1])); //vertex ID
          end else
            vmad.Vert:=int2(c[2],c[1])+1; //vertex ID

          blockread(f,c,2);
          dec(ChapSize,2);
          if c[1]=#255 then begin
            vmad.Poly:=ord(c[2])*65536+1; //poly ID
            blockread(f,c,2); dec(ChapSize,2);
            inc(vmad.Poly,int2(c[2],c[1])); //poly ID
          end else
            vmad.Poly:=int2(c[2],c[1])+1; //poly ID

          //This one is assigned to temp var, since it is used frequently here
          sz:=vmad.Poly+LWQty.Poly[0]-LWQty.Poly[lay];

          blockread(f,c,8); dec(ChapSize,8);
          for j:=1 to LW.Poly[sz,0] do begin
            if (j<4)and(LW.Poly[sz,j]=vmad.Vert+LWQty.Vert[0]-LWQty.Vert[lay]) then begin
              LW.DUV[sz,j,1]:=real2(c[4],c[3],c[2],c[1]);
              LW.DUV[sz,j,2]:=real2(c[8],c[7],c[6],c[5]);
            end;

            //If there's a quad we need to find it's parent
            if j>3 then begin
              {kk:=LWQty.AddPoly[0];
              repeat
                dec(kk); //Reverse is faster, as always =)
              until(LW.PolyAdd[kk].id<=sz);}

              kk:=LW.PolyAdd[sz].InvID;

              if LW.PolyAdd[kk].id=sz then
                if LW.PolyAdd[kk].v3=vmad.Vert+LWQty.Vert[0]-LWQty.Vert[lay] then begin
                  LW.PolyAdd[kk].u:=real2(c[4],c[3],c[2],c[1]);
                  LW.PolyAdd[kk].v:=real2(c[8],c[7],c[6],c[5]);
                  LW.PolyAdd[kk].uv:=-1;
                end else
                  LW.PolyAdd[kk].uv:=vmad.Vert+LWQty.Vert[0]-LWQty.Vert[lay]; //unused and wrong!
            end;

          end;

        until(ChapSize<=0);
      end;//(c[1]+c[2]+c[3]+c[4])='TXUV'
    end else

    if (ChapName='CLIP')and(ChapSize<>0) then begin
      blockread(f,c,ChapSize);
      s:=''; ii:=9;
      repeat
        ii:=ii+2;
        if c[ii]<>#0 then s:=s+c[ii];
        if c[ii+1]<>#0 then s:=s+c[ii+1];
      until(c[ii+1]=#0);
      kk:=1;
      repeat
        LW.ClipTex[int2(c[4],c[3])]:=LW.ClipTex[int2(c[4],c[3])]+s[kk];
        if s[kk]='/' then LW.ClipTex[int2(c[4],c[3])]:='';
        inc(kk);
      until(s[kk]='.');
    end else

    if ChapName='SURF' then begin
      blockread(f,c,ChapSize);
      ii:=1;
      setlength(LW.SName,SurfaceID+2);
      setlength(LW.SText,SurfaceID+2);
      LW.SName[SurfaceID] := strpas(@c); //Surface name from LightWave
      repeat
        //Keep on looking for Texture usage/assignment
        if c[ii]+c[ii+1]+c[ii+2]+c[ii+3]+c[ii+4]+c[ii+5]='IMAG'+#0+#2 then begin
          inc(ii,6);
          if int2(c[ii+1],c[ii])<>0 then
          LW.SText[SurfaceID] := LW.ClipTex[int2(c[ii+1],c[ii])];
          inc(ii,2);
        end;
        if ii<ChapSize then inc(ii); //slow but simple
      until(ii>=ChapSize);
      inc(SurfaceID);
      LWQty.Surf[0]:=SurfaceID-1;
    end else

    begin
      //memo1.Lines.Add(chname+' '+inttostr(ChapSize)+'byte ('+inttostr(m)+') skipped');
      for ii:=1 to (ChapSize div 1024000) do blockread(f,c,1024000);
      blockread(f,c,ChapSize mod 1024000);
    end;
  until(FileSize<=0);

  closefile(f);
  Form1.MemoLWO.Lines.Add('Load LWO in'+ElapsedTime(@OldTime));

  PrepareLWOData();
end;


procedure PrepareLWOData();
var
  ii,kk,VQty,PQty:integer;
  Scn_Bound:array[1..2,1..2]of single;
  Scn_Low:single;
begin

  if LWQty.Surf[0]>256 then begin
    MessageBox(Form1.Handle, 'Surface count exceeds alowed 256', 'Fatal Error', MB_OK or MB_ICONERROR);
    exit;
  end;

  Form1.MemoLWO.Lines.Add('Removing parts ...');
  for ii:=1 to LWQty.Poly[0] do
    dec(LW.Surf[ii],(LWQty.Tags[0]-LWQty.Surf[0]));
  Form1.Done(Form1.MemoLWO);

  Form1.MemoLWO.Lines.Add('Setting bounds ...');
  Scn_Bound[1,1]:=0; Scn_Bound[1,2]:=0; Scn_Bound[2,1]:=0; Scn_Bound[2,2]:=0; Scn_Low:=0;
  for ii:=1 to LWQty.Vert[0] do begin
    if LW.XYZ[ii,1]<Scn_Bound[1,1] then Scn_Bound[1,1] := LW.XYZ[ii,1]; //Defining map boundaries
    if LW.XYZ[ii,1]>Scn_Bound[1,2] then Scn_Bound[1,2] := LW.XYZ[ii,1];
    if LW.XYZ[ii,2]<Scn_Low        then Scn_Low        := LW.XYZ[ii,2];
    if LW.XYZ[ii,3]<Scn_Bound[2,1] then Scn_Bound[2,1] := LW.XYZ[ii,3];
    if LW.XYZ[ii,3]>Scn_Bound[2,2] then Scn_Bound[2,2] := LW.XYZ[ii,3];
  end;

  //We don't want to center the map, cos it might be WIP and move away if one
  //adds new structures to it, and thus whole object/triggers/streets placement will be ruined.
  SizeX := ceil(max(abs(Scn_Bound[1,1]),abs(Scn_Bound[1,2]))/1024)*2;
  SizeZ := ceil(max(abs(Scn_Bound[2,1]),abs(Scn_Bound[2,2]))/1024)*2;
  Form1.Done(Form1.MemoLWO);

  if SizeX*SizeZ>MAX_BLOCK_COUNT then begin
    MessageBox(Form1.Handle, 'Map size is too big for WR2', 'Fatal Error', MB_OK or MB_ICONERROR);
    exit;
  end;

  if (SizeX>MAX_BLOCKS_X) or (SizeZ>MAX_BLOCKS_Z) then begin
    MessageBox(Form1.Handle, 'Map size is too lengthy for STKit2', 'Fatal Error', MB_OK or MB_ICONERROR);
    exit;
  end;

  Form1.MemoLWO.Lines.Add('Drawing BG grid ...');
  VQty:=LWQty.Vert[0]; //Temp vertice counter
  PQty:=LWQty.Poly[0]; //Temp indice counter
  inc(LWQty.Vert[0],SizeZ*SizeX*4);
  inc(LWQty.Poly[0],SizeZ*SizeX*2);
    setlength(LW.XYZ ,LWQty.Vert[0]+1);
    setlength(LW.UV  ,LWQty.Vert[0]+1);
    setlength(LW.RGBA,LWQty.Vert[0]+1);
    setlength(LW.Nv  ,LWQty.Vert[0]+1);
    setlength(LW.Poly,LWQty.Poly[0]+1);
    setlength(LW.DUV ,LWQty.Poly[0]+1);
    setlength(LW.Surf,LWQty.Poly[0]+1);
  for ii:=0 to SizeZ-1 do for kk:=0 to SizeX-1 do begin
    LW.XYZ[VQty+1,1]:=(kk*2-SizeX  )*512+1; LW.XYZ[VQty+1,2]:=Scn_low-50; LW.XYZ[VQty+1,3]:=(ii*2-SizeZ  )*512+1;
    LW.XYZ[VQty+2,1]:=(kk*2-SizeX  )*512+1; LW.XYZ[VQty+2,2]:=Scn_low-50; LW.XYZ[VQty+2,3]:=(ii*2-SizeZ+2)*512-1;
    LW.XYZ[VQty+3,1]:=(kk*2-SizeX+2)*512-1; LW.XYZ[VQty+3,2]:=Scn_low-50; LW.XYZ[VQty+3,3]:=(ii*2-SizeZ+2)*512-1;
    LW.XYZ[VQty+4,1]:=(kk*2-SizeX+2)*512-1; LW.XYZ[VQty+4,2]:=Scn_low-50; LW.XYZ[VQty+4,3]:=(ii*2-SizeZ  )*512+1;
    LW.Poly[PQty+1,0]:=3; LW.Poly[PQty+1,1]:=VQty+3; LW.Poly[PQty+1,2]:=VQty+2; LW.Poly[PQty+1,3]:=VQty+1;
    LW.Poly[PQty+2,0]:=3; LW.Poly[PQty+2,1]:=VQty+1; LW.Poly[PQty+2,2]:=VQty+4; LW.Poly[PQty+2,3]:=VQty+3;
    LW.DUV[PQty+1,1,1]:=DONT_TRACE_TAG;//thats hint for shadowtracing this poly shouldn't be traced
    LW.DUV[PQty+2,1,1]:=DONT_TRACE_TAG;//thats hint for shadowtracing this poly shouldn't be traced
    LW.Surf[PQty+1]:=1;
    LW.Surf[PQty+2]:=1;
    inc(VQty,4);
    inc(PQty,2);
  end;
  Form1.Done(Form1.MemoLWO);

  Form1.MemoLWO.Lines.Add('Prep LWO in'+ElapsedTime(@OldTime));
  CompileVTX_IDX();
end;


procedure CompileVTX_IDX();
var
  ii,kk,m,ci,ck:integer;
  x,z:real;
  tmp:array of array[0..5]of integer;
  tms:array of array[1..6]of single;
begin
  ////////////////////////////////////////////////////////////////////////////////
  Form1.MemoLWO.Lines.Add('Adding Quad data ...');
  ////////////////////////////////////////////////////////////////////////////////
  setlength(LW.Poly,length(LW.Poly)+LWQty.AddPoly[0]);
  setlength(LW.Surf,length(LW.Surf)+LWQty.AddPoly[0]);
  setlength(LW.duv,length(LW.duv)+LWQty.AddPoly[0]);
  for ii:=1 to LWQty.AddPoly[0] do begin
    ci:=LWQty.Poly[0]+ii;
    LW.Poly[ci,1]:=LW.PolyAdd[ii].v1;
    LW.Poly[ci,2]:=LW.PolyAdd[ii].v2;
    LW.Poly[ci,3]:=LW.PolyAdd[ii].v3;
    LW.Surf[ci]:=LW.Surf[LW.PolyAdd[ii].id];
    LW.duv[ci,1,1]:=LW.duv[LW.PolyAdd[ii].id,1,1]; LW.duv[ci,1,2]:=LW.duv[LW.PolyAdd[ii].id,1,2]; //1<-2 2<-3 3<-Vadd
    LW.duv[ci,2,1]:=LW.duv[LW.PolyAdd[ii].id,3,1]; LW.duv[ci,2,2]:=LW.duv[LW.PolyAdd[ii].id,3,2];
    if LW.PolyAdd[ii].uv=-1 then begin
      LW.duv[ci,3,1]:=LW.PolyAdd[ii].u;            LW.duv[ci,3,2]:=LW.PolyAdd[ii].v;
    end else begin
      LW.duv[ci,3,1]:=LW.uv[LW.PolyAdd[ii].v3,1];  LW.duv[ci,3,2]:=LW.uv[LW.PolyAdd[ii].v3,2];
    end;
  end;
  inc(LWQty.Poly[0],LWQty.AddPoly[0]); //increase polyqty
  Form1.Done(Form1.MemoLWO);

  ////////////////////////////////////////////////////////////////////////////////
  Form1.MemoLWO.Lines.Add('Redistributing polys ...');
  ////////////////////////////////////////////////////////////////////////////////
  setlength(tmp,LWQty.Poly[0]+1);
  setlength(tms,LWQty.Poly[0]+1);
  ci:=0;
  for kk:=1 to LWQty.Surf[0]do
    for ii:=1 to LWQty.Poly[0] do
      if LW.Surf[ii]=kk then begin
      inc(ci);
      tmp[ci,0]:=LW.Poly[ii,0];
      tmp[ci,1]:=LW.Poly[ii,1];
      tmp[ci,2]:=LW.Poly[ii,2];
      tmp[ci,3]:=LW.Poly[ii,3];
      tmp[ci,4]:=LW.Surf[ii];
      tms[ci,1]:=LW.duv[ii,1,1];
      tms[ci,2]:=LW.duv[ii,1,2];
      tms[ci,3]:=LW.duv[ii,2,1];
      tms[ci,4]:=LW.duv[ii,2,2];
      tms[ci,5]:=LW.duv[ii,3,1];
      tms[ci,6]:=LW.duv[ii,3,2];
      end;

  for ii:=1 to LWQty.Poly[0] do begin
    LW.Poly[ii,0]:=tmp[ii,0];
    LW.Poly[ii,1]:=tmp[ii,1];
    LW.Poly[ii,2]:=tmp[ii,2];
    LW.Poly[ii,3]:=tmp[ii,3];
    LW.Surf[ii]:=tmp[ii,4];
    LW.duv[ii,1,1]:=tms[ii,1];
    LW.duv[ii,1,2]:=tms[ii,2];
    LW.duv[ii,2,1]:=tms[ii,3];
    LW.duv[ii,2,2]:=tms[ii,4];
    LW.duv[ii,3,1]:=tms[ii,5];
    LW.duv[ii,3,2]:=tms[ii,6];
  end;

  Form1.Done(Form1.MemoLWO);

////////////////////////////////////////////////////////////////////////////////
Form1.MemoLWO.Lines.Add('Generating Normals ...');
////////////////////////////////////////////////////////////////////////////////
setlength(LW.Np,LWQty.Poly[0]+1);
for ii:=1 to LWQty.Poly[0] do
Normal2Poly(LW.XYZ[LW.Poly[ii,1]],LW.XYZ[LW.Poly[ii,2]],LW.XYZ[LW.Poly[ii,3]],@LW.Np[ii,1],@LW.Np[ii,2],@LW.Np[ii,3]);

for ii:=1 to LWQty.Vert[0] do for kk:=1 to 3 do LW.Nv[ii,kk]:=0; //Set all to '0'

for ii:=1 to LWQty.Poly[0] do for kk:=1 to 3 do begin //accumulating data to vertices
LW.Nv[LW.Poly[ii,kk],1]:=LW.Nv[LW.Poly[ii,kk],1]+LW.Np[ii,1];
LW.Nv[LW.Poly[ii,kk],2]:=LW.Nv[LW.Poly[ii,kk],2]+LW.Np[ii,2];
LW.Nv[LW.Poly[ii,kk],3]:=LW.Nv[LW.Poly[ii,kk],3]+LW.Np[ii,3];
end;

for ii:=1 to LWQty.Vert[0] do
Normalize(LW.Nv[ii,1],LW.Nv[ii,2],LW.Nv[ii,3],@LW.Nv[ii,1],@LW.Nv[ii,2],@LW.Nv[ii,3]);

Form1.Done(Form1.MemoLWO);

////////////////////////////////////////////////////////////////////////////////
Form1.MemoLWO.Lines.Add('Grouping polys to Blocks ...');
////////////////////////////////////////////////////////////////////////////////
for ii:=1 to SizeX*SizeZ do pqtyb[ii,2]:=0;
FillChar(split,SizeOf(split),#0);

setlength(pblock,LWQty.Poly[0]+1);
for ii:=1 to LWQty.Poly[0] do begin
x:=(LW.XYZ[LW.Poly[ii,1],1]+LW.XYZ[LW.Poly[ii,2],1]+LW.XYZ[LW.Poly[ii,3],1])/3; //X center of poly
z:=(LW.XYZ[LW.Poly[ii,1],3]+LW.XYZ[LW.Poly[ii,2],3]+LW.XYZ[LW.Poly[ii,3],3])/3; //Z center of poly
ci:=trunc(x/1024+SizeX/2)+1;
ck:=trunc(z/1024+SizeZ/2)+1;
EnsureRange(ci,1,SizeX);
EnsureRange(ck,1,SizeZ);
pblock[ii]:=ci+(ck-1)*SizeX;
inc(pqtyb[pblock[ii],2]);//number of polys in Block
end; //Each poly(j) belongs to its block now.
Form1.Done(Form1.MemoLWO);

Form1.MemoLWO.Lines.Add('Splitting to 65k chunks:');
kk:=1;
for ii:=1 to SizeX*SizeZ do begin
pqtyb[ii+1,1]:=pqtyb[ii,1]+pqtyb[ii,2]; //Making list of poly groups
if (split[kk,2]+pqtyb[ii,2]*3)>65535 then begin
split[kk,1]:=ii-1;
inc(kk);
end;
inc(split[kk,2],pqtyb[ii,2]*3);
end;
split[kk,1]:=SizeX*SizeZ;

for ii:=1 to 64 do begin
  if split[ii,2]>0 then Form1.MemoLWO.Lines.Add('#'+inttostr(ii)+' - '+inttostr(split[ii,2]));
  if split[ii,2]>=65536 then begin
    MessageBox(Form1.Handle,PChar('Too big chunk made at block '+inttostr(split[ii,1])),'Fatal Error',MB_OK or MB_ICONERROR);
    exit;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
Form1.MemoLWO.Lines.Add('Building IDX ...');
////////////////////////////////////////////////////////////////////////////////
IDXQty:=LWQty.Poly[0]*3; m:=1; ci:=0;
setlength(repoint,LWQty.Poly[0]+1);
setlength(v,IDXQty div 3+1);
for ii:=1 to SizeX*SizeZ do begin
  for kk:=1 to LWQty.Poly[0] do if pblock[kk]=ii then begin
  v[m,1]:=ci+0+1;
  v[m,2]:=ci+1+1;
  v[m,3]:=ci+2+1;
  inc(ci,3);
  repoint[m]:=kk;              //reverse
  inc(m);
  end;
end;
Form1.Done(Form1.MemoLWO);

////////////////////////////////////////////////////////////////////////////////
Form1.MemoLWO.Lines.Add('Compiling VTX ...');
////////////////////////////////////////////////////////////////////////////////
for ii:=1 to 63 do VTXQty[ii]:=split[ii,2];
VTXQty[64]:=LWQty.Poly[0]*3;

setlength(VTX,LWQty.Poly[0]*3+1);
m:=1;
for ii:=1 to LWQty.Poly[0] do
for kk:=1 to 3 do begin
  VTX[m].X:=LW.XYZ[LW.Poly[repoint[ii],kk],1];
  VTX[m].Y:=LW.XYZ[LW.Poly[repoint[ii],kk],2];
  VTX[m].Z:=LW.XYZ[LW.Poly[repoint[ii],kk],3];
  VTX[m].nZ:=round(LW.Nv[LW.Poly[repoint[ii],kk],3]*127+128);
  VTX[m].nY:=round(LW.Nv[LW.Poly[repoint[ii],kk],2]*127+128);
  VTX[m].nX:=round(LW.Nv[LW.Poly[repoint[ii],kk],1]*127+128);
  VTX[m].n0:=0;
  VTX[m].U:=LW.DUV[repoint[ii],kk,1];
  VTX[m].V:=1-LW.DUV[repoint[ii],kk,2];
  VTX[m].BlendR:=LW.RGBA[LW.Poly[repoint[ii],kk],1];//R
  VTX[m].BlendG:=LW.RGBA[LW.Poly[repoint[ii],kk],2];//G
  VTX[m].BlendB:=LW.RGBA[LW.Poly[repoint[ii],kk],3];//B

  VTX[m].Shadow:=0;//none
  VTX[m].B:=45;
  VTX[m].G:=45;
  VTX[m].R:=45;
  VTX[m].A:=0;
  inc(m);
end;
  Form1.Done(Form1.MemoLWO);

  Form1.MemoLWO.Lines.Add('VTX-IDX in'+ElapsedTime(@OldTime));
  CompileQAD();
end;


procedure CompileQAD();
var ii,kk,m,m2,j,h,BlockID:integer; s:string;
begin
Form1.MemoLWO.Lines.Add('');
Form1.MemoLWO.Lines.Add('<<< Preparing QAD Data >>>');
Qty.WidthX :=(SizeX-2)*16;
Qty.LengthZ:=(SizeZ-2)*16;
Qty.BlocksX:=SizeX;
Qty.BlocksZ:=SizeZ;
Qty.BlocksTotal:=Qty.BlocksX*Qty.BlocksZ;
Qty.TexturesTotal:=0;                           //Filled later
Qty.TexturesFiles:=0;                           //Filled later
Qty.BumpTexturesFiles:=0;                       //Thats AFC11 field, just make sure it's 0
//Qty.ObjectFiles:=0;                             //Filled later
Qty.Polys:=LWQty.Poly[0];
Qty.Materials:=1;                               //Filled later
//Qty.ObjectsTotal:=0;                            //Filled later
//Qty.GroundTypes:=1;                           //Keep old grounds
Qty.ColliSize:=0;                               //Filled later
//Qty.Lights:=0;                                //Keep old lights
//WR2
Qty.x1:=256;
Qty.x2:=0;
Qty.x3:=1;
//Qty.Sounds:=0;                                //Keep old sounds

Form1.MemoLWO.Lines.Add('Colliding polys with Blocks ...');
setlength(Bi,0);
setlength(Bi,LWQty.Poly[0]+1);
for ii:=1 to LWQty.Poly[0] do begin //Looking for blocks containing current poly
krintersect(                 //Shifting scenario, so it start from (0;0)
LW.XYZ[LW.Poly[repoint[ii],1],1]+SizeX*512,LW.XYZ[LW.Poly[repoint[ii],1],3]+SizeZ*512,
LW.XYZ[LW.Poly[repoint[ii],2],1]+SizeX*512,LW.XYZ[LW.Poly[repoint[ii],2],3]+SizeZ*512,
LW.XYZ[LW.Poly[repoint[ii],3],1]+SizeX*512,LW.XYZ[LW.Poly[repoint[ii],3],3]+SizeZ*512,
SizeX*4,SizeZ*4,Bi[ii]); //list of sub-blocks for current poly
end;
Form1.Done(Form1.MemoLWO);

Form1.MemoLWO.Lines.Add('Building collision groups ...');
setlength(Cbl,0);
setlength(Cbl,SizeZ*4*SizeX*4+1);//
for ii:=1 to SizeZ*4*SizeX*4 do begin
setlength(Cbl[ii],2);//
Cbl[ii,0]:=0; //Resetting counters
end;

for ii:=1 to LWQty.Poly[0] do begin      //Assigning polys to CollisionBlock they belong
kk:=1;
if (bi[ii,1]<>0) then //ghost polys that overlap nothing ?
repeat
BlockID:=bi[ii,kk];
inc(Cbl[BlockID,0]);
if (Cbl[BlockID,0]+1)>=length(Cbl[BlockID]) then
setlength(Cbl[BlockID],length(Cbl[BlockID])+1); //+1 to make sure array ends with 0
Cbl[BlockID,Cbl[BlockID,0]]:=ii; //[Block which poly intersects, current place in array counter[of current poly]] :=
inc(kk);
until(bi[ii,kk]=0);
end;

for ii:=1 to SizeZ*4*SizeX*4 do
if Cbl[ii,0]=0 then begin
setlength(Cbl[ii],3);
Cbl[ii,0]:=1;
Cbl[ii,1]:=1;
end;

for ii:=1 to length(v05) do v05[ii]:=0;

kk:=0;         // Polycount; BlockID; ..polys..; Polycount; BlockID; ..polys..; 0-terminator.
setlength(v06,0);
setlength(v06,SizeZ*4*SizeX*4+1);
for ii:=1 to SizeZ*4*SizeX*4 do begin
inc(kk); j:=0; h:=1; m:=2; m2:=2;
if Cbl[kk,0]>0 then begin //if there is something to collide with :D
repeat
  repeat inc(j); //Finding parent block
  until((pqtyb[j,1]+pqtyb[j,2]+1)>Cbl[kk,h]);
if (m+1)>=length(v06[kk]) then setlength(v06[kk],length(v06[kk])+5);
  v06[kk,m]:=j-1; inc(m);                    //2nd=BlockID; 9th=BlockID
  inc(v05[kk],4);                            //
  repeat
  inc(v06[kk,m-m2]);                         //3rd=qty; 8th=qty
if (m+1)>=length(v06[kk]) then setlength(v06[kk],length(v06[kk])+5);
  v06[kk,m]:=Cbl[kk,h]-pqtyb[j,1]-1;         //4th...7th =poly
  inc(h); inc(m); inc(m2);
  inc(v05[kk],2);
  until(((pqtyb[j,1]+pqtyb[j,2]+1)<=Cbl[kk,h])or(Cbl[kk,h]=0));
if (m+1)>=length(v06[kk]) then setlength(v06[kk],length(v06[kk])+5);
v06[kk,m]:=0;
inc(m); m2:=2;                             //f.e. m=8>9
until(Cbl[kk,h]=0);
inc(v05[kk],2);                              //0 terminator
end;
end;

kk:=0;
for ii:=1 to Qty.BlocksTotal*16 do
if v05[ii]>kk then kk:=v05[ii];
Form1.Done(Form1.MemoLWO);
Form1.MemoLWO.Lines.Add('Longest collision group = '+inttostr(kk div 2));

for kk:=1 to Qty.BlocksTotal*16 do
v05[kk+1]:=v05[kk+1]+v05[kk];
for ii:=Qty.BlocksTotal*16 downto 1 do
v05[ii+1]:=v05[ii]+Qty.BlocksTotal*16*4;
v05[1]:=Qty.BlocksTotal*16*4;
Qty.ColliSize:=v05[Qty.BlocksTotal*16+1];

for ii:=1 to length(sqtyb) do begin
sqtyb[ii,1]:=0;
sqtyb[ii,2]:=0;
end;

Form1.MemoLWO.Lines.Add('Optimizing surface groups ...');
setlength(v07,0);
setlength(v07,100); //start value
m:=0; ii:=0; h:=1;
repeat
inc(ii); //counter for number of groups
kk:=0;
if ii>=length(v07) then setlength(v07,length(v07)+100);
v07[ii].FirstPoly:=m;
repeat
inc(kk);     //dramaticaly decreases surface count by aligning neighbour polys surfaces
if (m+1+kk)>LWQty.Poly[0] then break;                      //Evading range errors
until((LW.Surf[repoint[m+1]]<>LW.Surf[repoint[m+1+kk]])or(pblock[repoint[m+1]]<>pblock[repoint[m+1+kk]]));
if (m+1+kk)<=LWQty.Poly[0] then if pblock[repoint[m+1]]<>pblock[repoint[m+1+kk]] then inc(h); //h - block ID
inc(sqtyb[h,2]);        //one more group of polys - one surfaced
v07[ii].NumPoly:=kk;
v07[ii].SurfaceID:=LW.Surf[repoint[m+1]]-1;   //-1
m:=m+kk;
until(m>=LWQty.Poly[0]);
Qty.TexturesTotal:=ii;
sqtyb[h,2]:=sqtyb[h,2]-1;

inc(sqtyb[1,2]); //First group
for ii:=1 to SizeX*SizeZ do sqtyb[ii+1,1]:=sqtyb[ii,1]+sqtyb[ii,2];
Form1.Done(Form1.MemoLWO);
Form1.MemoLWO.Lines.Add('Surface groups - '+inttostr(sqtyb[SizeX*SizeZ,1])+' ('+inttostr(Qty.TexturesTotal)+')');

{Qty.TexturesFiles:=LWQty.Surf[0];
for ii:=1 to Qty.TexturesFiles do
if LW.SText[ii]='' then TexName[ii]:='-none'+inttostr(ii)+'-' else TexName[ii]:=LW.SText[ii];}

ii:=1;
repeat
TexName[ii]:=LW.ClipTex[ii];//UpperCase(LW.ClipTex[ii][1])+LowerCase(decs(LW.ClipTex[ii],-1,1));
inc(ii);
until((LW.ClipTex[ii]='')or(ii=256));
Qty.TexturesFiles:=ii-1;

for ii:=1 to Qty.TexturesFiles do for kk:=1 to Qty.TexturesFiles do
if uppercase(TexName[kk])>uppercase(TexName[ii]) then begin //swap
s:=TexName[ii]; TexName[ii]:=TexName[kk]; TexName[kk]:=s;
end;

Qty.Materials:=LWQty.Surf[0];
for ii:=1 to Qty.Materials do with Material[ii] do begin
for kk:=1 to Qty.TexturesFiles do if uppercase(LW.SText[ii])=uppercase(TexName[kk]) then
Tex1:=kk-1;
Tex2:=0;
Tex3:=0;
Mode:=32;
for kk:=1 to 3 do begin
Matrix[kk,1,1]:=0.1; Matrix[kk,1,2]:=0; Matrix[kk,1,3]:=0; Matrix[kk,1,4]:=0;
Matrix[kk,2,1]:=0; Matrix[kk,2,2]:=0; Matrix[kk,2,3]:=-0.1; Matrix[kk,2,4]:=0;
//CRC[kk]:=Adler32CRC(@Matrix[kk,1,1],32); //Matrix checksum
end;
MaterialW[ii].Name:=LW.SName[ii];
MaterialW[ii].GrowGrass:=0;
MaterialW[ii].Enlite:=0;
end;

Changes.WRK:=true;

Form1.MemoLWO.Lines.Add('Building table of contents ...');
h:=0;
for ii:=1 to SizeZ do
for kk:=1 to SizeX do begin
  Block[ii,kk].X:=kk-1;
  Block[ii,kk].Z:=ii-1;
  Block[ii,kk].FirstPoly :=pqtyb[kk+(ii-1)*SizeX,1];                 //First poly
  Block[ii,kk].NumPoly   :=pqtyb[kk+(ii-1)*SizeX,2];                 //Length polys
  Block[ii,kk].FirstTex  :=sqtyb[kk+(ii-1)*SizeX,1];                 //First Surface
  Block[ii,kk].NumTex    :=sqtyb[kk+(ii-1)*SizeX,2];                 //Number Surfaces
  Block[ii,kk].FirstObj  :=-1;
  Block[ii,kk].NumObj    :=0;
  Block[ii,kk].FirstLight:=-1;
  Block[ii,kk].NumLight  :=0;
  if (ii-1)*SizeX+kk>split[h+1,1] then inc(h); //processed block > split block
  Block[ii,kk].Chunk65k:=h;
  Block[ii,kk].x1:=0;
end;
Form1.Done(Form1.MemoLWO);

FillChar(Tex2Ground,SizeOf(Tex2Ground),#0);

if Qty.GroundTypes=0 then begin
  Qty.GroundTypes:=1;
  Ground[1].Name:='Default';
  Ground[1].Dirt:=0;
  Ground[1].GripF:=100;
  Ground[1].GripR:=100;
  Ground[1].NoiseID:=0;
  Ground[1].SkidID:=1;
  Ground[1].NoColliFlag:=0;
  Ground[1].x8:=0;
end;

Form1.MemoLWO.Lines.Add('QAD in'+ElapsedTime(@OldTime));
Changes.VTX:=true;
Changes.IDX:=true;
Changes.QAD:=true;

  OptimizeVerticesClick_();
  OptimizeCullingSpheresClick_();
  Form1.MemoLWO.Lines.Add('Vertices optimized in'+ElapsedTime(@OldTime));
  PrepareOtherData();
end;


procedure OptimizeVerticesClick_();
var
  i,k,h,x,z:integer;
  c65k,Ref:integer;
  UniqV:array of integer; //Uniqueness of vertice
  DecBy:array of integer; //Decrease by .. for this vertice
  VertInBlock:array of array of word; //Stores ID of Block in which this vertice is used
  VCount:array of integer; //Number of vertices per Block
begin
setlength(UniqV,VTXQty[64]+1);
setlength(DecBy,VTXQty[64]+1);
setlength(VertInBlock,VTXQty[64]+1);
setlength(VCount,Qty.BlocksX*Qty.BlocksZ+1);

  for K:=4 to VTXQty[64] do begin   //scan all points starting from poly#2
    UniqV[K]:=0;                    //assume each point is unique
    for I:=K-1 downto max(1,K-1500) do  //check previous points (starting from nearest, till end of current range)
    if(VTX[I].X=VTX[K].X)and(VTX[I].Y=VTX[K].Y)and(VTX[I].Z=VTX[K].Z)and
      (VTX[I].nX=VTX[K].nX)and(VTX[I].nY=VTX[K].nY)and(VTX[I].nZ=VTX[K].nZ)and
      (VTX[I].U=VTX[K].U)and(VTX[I].V=VTX[K].V)and
      (VTX[I].BlendR=VTX[K].BlendR)and(VTX[I].BlendG=VTX[K].BlendG)and
      (VTX[I].BlendB=VTX[K].BlendB)and(VTX[I].Shadow=VTX[K].Shadow)and //Shadows are generated per XYZ, so no need to remove them from check here
      (VTX[I].B=VTX[K].B)and(VTX[I].G=VTX[K].G)and(VTX[I].R=VTX[K].R)and(VTX[I].A=VTX[K].A)
    then begin                          //if such point already exist
      Ref:=I;
      if UniqV[Ref]<>0 then  //Find original vertice instead of referencing to a reference
        repeat Ref:=UniqV[Ref]; until(UniqV[Ref]=0);
      UniqV[K]:=Ref;                    //make reference to it
      inc(UniqV[0]);                    //Statistic
      break;                            //break comparision for speedup
    end;
  end;
Form1.MemoLWO.Lines.Add(inttostr(VTXQty[64])+' vertices before optimization');

//Remap polys to unique vertices
for i:=1 to Qty.Polys do
  for h:=1 to 3 do
    if UniqV[v[i,h]]<>0 then v[i,h]:=UniqV[v[i,h]];

//Part one is done, all polys redirected to unique vertices,
//now we can pack vertices and drop unused ones.

//Need to know how much each vertice changes its place when packed up
Ref:=0;
for i:=1 to VTXQty[64] do begin
  if UniqV[i]<>0 then inc(Ref);
  DecBy[i]:=Ref;
  if UniqV[i]<>0 then DecBy[i]:=0;
end;

//Pack vertices
for i:=1 to VTXQty[64] do
  VTX[i-DecBy[i]]:=VTX[i];

setlength(VTX,VTXQty[64]-UniqV[0]+1); //Cut the rest

//Update indices to packed vertices
for i:=1 to Qty.Polys do
  for h:=1 to 3 do
    v[i,h]:=v[i,h]-DecBy[v[i,h]];

//Now everything is tightly packed and it's time to deal with splitting to 65k vertices chunks
//But how?
//1 - Make each Block vertices independent from neighbour Blocks
//2 -

//First we need to know in which Blocks each vertice is used (upto 4 Blocks?)
for i:=1 to Qty.BlocksX*Qty.BlocksZ do begin
  x:=(i-1) mod Qty.BlocksX+1;
  z:=(i-1) div Qty.BlocksX+1;
  //if i= Qty.BlocksX*Qty.BlocksZ then
  //x:=20;
  Ref:=0;
  for k:=Block[z,x].FirstPoly+1 to Block[z,x].FirstPoly+Block[z,x].NumPoly do
    for h:=1 to 3 do begin
      if length(VertInBlock[v[k,h]])=0 then begin
        setlength(VertInBlock[v[k,h]],2); //Init
        VertInBlock[v[k,h],0]:=1; //Counter
        VertInBlock[v[k,h],1]:=i; //BlockID
        inc(Ref);
      end else begin
        if VertInBlock[v[k,h],VertInBlock[v[k,h],0]]<>i then begin
          inc(VertInBlock[v[k,h],0]);
          if length(VertInBlock[v[k,h]])=VertInBlock[v[k,h],0] then
            setlength(VertInBlock[v[k,h]],VertInBlock[v[k,h],0]+3);
          VertInBlock[v[k,h],VertInBlock[v[k,h],0]]:=i;
          inc(Ref);
        end;
      end;
    end;
  VCount[i]:=Ref;
end;

//Using own vertices for each Block adds only ~1% overuse, we can live with that
FillChar(VTXQty,SizeOf(VTXQty),#0);
c65k:=1;
for i:=1 to Qty.BlocksX*Qty.BlocksZ do begin
  x:=(i-1) mod Qty.BlocksX+1;
  z:=(i-1) div Qty.BlocksX+1;
  if VTXQty[c65k]+VCount[i]>65535 then begin
    inc(c65k);
    VTXQty[c65k]:=0;
  end;
  Block[z,x].Chunk65k:=c65k-1;
  inc(VTXQty[c65k],VCount[i]);
end;

for i:=1 to 63 do inc(VTXQty[64],VTXQty[i]);

setlength(VTX,VTXQty[64]*2+1); //Use second half to build new array to save effort on writing smart remap stuff

//Now comes boring part - remap polys
Ref:=1;
for i:=1 to Qty.BlocksX*Qty.BlocksZ do begin
  x:=(i-1) mod Qty.BlocksX+1;
  z:=(i-1) div Qty.BlocksX+1;
  setlength(UniqV,0); //Clearup for each new Block
  setlength(UniqV,VTXQty[64]+1);
  for k:=Block[z,x].FirstPoly+1 to Block[z,x].FirstPoly+Block[z,x].NumPoly do
    for h:=1 to 3 do begin
      if UniqV[v[k,h]]=0 then begin
        UniqV[v[k,h]]:=Ref;
        VTX[VTXQty[64]+Ref]:=VTX[v[k,h]];
        inc(Ref);
      end;
        v[k,h]:=UniqV[v[k,h]];
    end;
end;

//Final check for error
for i:=1 to Qty.Polys do
  for h:=1 to 3 do
    if (v[i,h]<=0)or(v[i,h]>=Ref) then
      Assert(false,'Indice out of range');

//Put vertices back in place
for i:=1 to VTXQty[64] do
  VTX[i]:=VTX[i+VTXQty[64]];

Form1.MemoLWO.Lines.Add(inttostr(VTXQty[64])+' vertices left');

setlength(VTX,VTXQty[64]+1);
setlength(UniqV,0);
setlength(DecBy,0);
setlength(VertInBlock,0);
setlength(VCount,0);

Changes.QAD:=true;
Changes.VTX:=true;
Changes.IDX:=true;

//Reload the scenery
list_id:=0;
list_ogl:=0;
end;


procedure OptimizeCullingSpheresClick_();
var
  ii,kk,ci,ck:integer;
  BlockBounds:array[1..MAX_BLOCKS_X, 1..MAX_BLOCKS_Z, 1..2] of Vector3f;
begin
  //Init minimum and maximum values
  for ii:=1 to MAX_BLOCKS_X do for kk:=1 to MAX_BLOCKS_Z do begin
    BlockBounds[ii,kk,1].X := MaxSingle;
    BlockBounds[ii,kk,1].Y := MaxSingle;
    BlockBounds[ii,kk,1].Z := MaxSingle;
    BlockBounds[ii,kk,2].X := -MaxSingle;
    BlockBounds[ii,kk,2].Y := -MaxSingle;
    BlockBounds[ii,kk,2].Z := -MaxSingle;
  end;

  for ii:=1 to Qty.BlocksZ do for kk:=1 to Qty.BlocksX do begin
    for ci:=Block[ii,kk].FirstPoly+1 to Block[ii,kk].FirstPoly + Block[ii,kk].NumPoly do
    if VTX[v[ci,1]].U <> DONT_TRACE_TAG then
    for ck := 1 to 3 do begin
      BlockBounds[ii,kk,1].X := min(BlockBounds[ii,kk,1].X, VTX[v[ci,ck]].X);
      BlockBounds[ii,kk,1].Y := min(BlockBounds[ii,kk,1].Y, VTX[v[ci,ck]].Y);
      BlockBounds[ii,kk,1].Z := min(BlockBounds[ii,kk,1].Z, VTX[v[ci,ck]].Z);
      BlockBounds[ii,kk,2].X := max(BlockBounds[ii,kk,2].X, VTX[v[ci,ck]].X);
      BlockBounds[ii,kk,2].Y := max(BlockBounds[ii,kk,2].Y, VTX[v[ci,ck]].Y);
      BlockBounds[ii,kk,2].Z := max(BlockBounds[ii,kk,2].Z, VTX[v[ci,ck]].Z);
    end;
  end;

  for ii:=1 to Qty.BlocksZ do for kk:=1 to Qty.BlocksX do begin
    Block[ii,kk].CenterX := (BlockBounds[ii,kk,1].X + BlockBounds[ii,kk,2].X) / 2;
    Block[ii,kk].CenterY := (BlockBounds[ii,kk,1].Y + BlockBounds[ii,kk,2].Y) / 2;
    Block[ii,kk].CenterZ := (BlockBounds[ii,kk,1].Z + BlockBounds[ii,kk,2].Z) / 2;
    Block[ii,kk].Rad     := GetLength( //Length from center point to any bounding box vertice is the same
                            (Block[ii,kk].CenterX - BlockBounds[ii,kk,1].X),
                            (Block[ii,kk].CenterY - BlockBounds[ii,kk,1].Y),
                            (Block[ii,kk].CenterZ - BlockBounds[ii,kk,1].Z));
  end;
end;


procedure PrepareOtherData();
begin
Form1.MemoLWO.Lines.Add('Preparing misc data');

SceneryPath:=fOptions.WorkDir+'Scenarios\'+Scenery+'\'+SceneryVersion+'\';

AutoImportTexturesList:=SceneryPath+Scenery+'_'+SceneryVersion+'_TexturesAssignList.dat';
if (Form1.CBLoadTexList.Checked)and(FileExists(AutoImportTexturesList)) then begin
  Form1.ImportTexturesClick(nil);
  Form1.MemoLWO.Lines.Add('Loaded '+Scenery+'_'+SceneryVersion+'_TexturesAssignList.dat');
end;

AutoImportMaterialsList:=SceneryPath+Scenery+'_'+SceneryVersion+'_MaterialsList.dat';
if (Form1.CBLoadMatList.Checked)and(FileExists(AutoImportMaterialsList)) then begin
  Form1.ImportMaterialsClick(nil);
  Form1.MemoLWO.Lines.Add('Loaded '+Scenery+'_'+SceneryVersion+'_MaterialsList.dat');
end;

Form1.MemoLWO.Lines.Add('Applying lightning ...');
Form1.LightApplyClick(Form1.LoadLWOScen);
Form1.Done(Form1.MemoLWO);

Form1.MemoLWO.Lines.Add('Rebuilding chunk modes ...');
Form1.ComputeChunkMode(nil);
Form1.Done(Form1.MemoLWO);

Form1.RecalculatematerialCRC1Click(nil);

list_id:=0;
list_ogl:=0;
list_tx:=0;
Form1.SendQADtoUI('All');
ScnRefresh:=false;
Form1.SaveScenery.Enabled:=true;
SaveButton:=true;

Form1.MemoLWO.Lines.Add('['+inttostr(SizeX)+'x'+inttostr(SizeZ)+'] '+floattostr(SizeX*102.4/1000)+' x '+floattostr(SizeZ*102.4/1000)+'km');

setlength(Cbl,0);
//setlength(cc,0);
setlength(Bi,0);
setlength(repoint,0);
setlength(recreat,0);
setlength(LW.XYZ,0);
setlength(LW.UV,0);
setlength(LW.Nv,0);
setlength(LW.Np,0);
setlength(LW.DUV,0);
setlength(LW.RGBA,0);
setlength(LW.Poly,0);
setlength(LW.SName,0);
setlength(LW.SText,0);
Form1.MemoLWO.Lines.Add('LWO data cleared');
end;
end.
