unit MTkit2_IO;
interface
uses
  Windows, SysUtils, MTkit2_Defaults, KromUtils, Math, Dialogs;

function  LoadOBJ(const aFilename: string; out Log: string): Boolean;
function  Load3DS(const aFilename: string; out Log: string): Boolean;
function  LoadLWO(const aFilename: string; out Log: string): Boolean;

procedure SaveMOX2LWO(const aFilename: string; aSpreadOverX: Boolean);

procedure LoadMTL(const aFilename: string);
procedure SaveMTL(const aFilename: string);

function  LoadCPO(const aFilename: string): Boolean;
procedure SaveCPO(const aFilename: string);

function  LoadCOB(const aFilename: string): Boolean;
procedure SaveCOB(const aFilename: string);

procedure SaveCOB2LWO(const aFilename: string);
procedure SaveCPO2LWO(const aFilename: string; ShapeID: Integer);

procedure LoadTREE(const aFilename: string);

procedure LoadLights(const aFilename: string);
procedure SaveLights(const aFilename: string);

function  LoadPBF(const aFilename: string): Boolean;
procedure SavePBF(const aFilename: string);

function  LoadPSF(const aFilename: string): Boolean;
procedure SavePSF(const aFilename: string);

function  ScanVinyls(aPath: string): Boolean;

implementation
uses
  MTkit2_Unit1;

function LoadOBJ(const aFilename: string; out Log:string):Boolean;
var
  f:textfile;
  h,i:Integer;
  VerticeCount,TexCoordCount,NormalCount:Integer;
  vID,tID,nID:array[1..3]of Integer;
  SurfID,SmoothGroup:Word;
  MtlLib:string;
  OBJxyz:array of Vector3f;
  OBJuv:array of Vector2f;
  OBJn:array of Vector3f;
  SmoothGroupID:array of Integer;
begin
  Result:=False;
  Log:='';

  OldTimeLWO:=GetTickCount;

  FillChar(Imp,SizeOf(Imp),#0);

  setlength(OBJxyz,65536);
  setlength(OBJuv,65536);
  setlength(OBJn,65536);
  setlength(SmoothGroupID,65536);

  for i:=1 to 65280 do
    for h:=1 to 3 do begin
      Imp.DUV[i,h].U:=123456;
      Imp.DUV[i,h].V:=123456;
    end;
  for i:=1 to 65280 do begin
    Imp.XYZ[i].X:=123456;
    Imp.XYZ[i].Y:=123456;
    Imp.XYZ[i].Z:=123456;
    Imp.Nv[i].X:=123456;
    Imp.Nv[i].Y:=123456;
    Imp.Nv[i].Z:=123456;
    SmoothGroupID[i]:=123456;
  end;

  VerticeCount:=0;
  TexCoordCount:=0;
  NormalCount:=0;
  SurfID:=0;
  SmoothGroup := 0;

  AssignFile(f,aFilename); FileMode:=0; Reset(f); FileMode:=2;

  repeat
    Readln(f,s);

    while ((s='')or(s[1]='#'))and(not Eof(f)) do Readln(f,s);

    if Copy(s,1,6)='mtllib' then MtlLib:=Copy(s,8,Length(s));

    if Copy(s,1,2)='v ' then begin //Another vertice found
      Inc(VerticeCount);
      OBJxyz[VerticeCount].X:=-GetNumberFromString(Copy(s,3,Length(s)),1);
      OBJxyz[VerticeCount].Y:=GetNumberFromString(Copy(s,3,Length(s)),2);
      OBJxyz[VerticeCount].Z:=GetNumberFromString(Copy(s,3,Length(s)),3);
    end;

    if Copy(s,1,2)='vt' then begin //UV coord
      Inc(TexCoordCount);
      OBJuv[TexCoordCount].U:=GetNumberFromString(Copy(s,4,Length(s)),1);
      OBJuv[TexCoordCount].V:=GetNumberFromString(Copy(s,4,Length(s)),2);
    end;

    if Copy(s,1,2)='vn' then begin //Normal
      Inc(NormalCount);
      OBJn[NormalCount].X:=-GetNumberFromString(Copy(s,4,Length(s)),1);
      OBJn[NormalCount].Y:=GetNumberFromString(Copy(s,4,Length(s)),2);
      OBJn[NormalCount].Z:=GetNumberFromString(Copy(s,4,Length(s)),3);
    end;

    if Copy(s,1,2)='g ' then begin //New group
      Inc(Imp.PartCount);
      Imp.PartName[Imp.PartCount]:=Copy(s,3,Length(s));
    end;

    if Copy(s,1,6)='usemtl' then begin
      SurfID:=0;

      for i:=1 to Imp.SurfCount do
        if Imp.Mtl[i].Title=Copy(s,8,Length(s)) then
          SurfID:=i;

      if SurfID=0 then begin
        Inc(Imp.SurfCount);
        Imp.Mtl[Imp.SurfCount].Title:=Copy(s,8,Length(s));
        Imp.Mtl[Imp.SurfCount].Dif.R:=255;
        Imp.Mtl[Imp.SurfCount].Dif.G:=0;
        Imp.Mtl[Imp.SurfCount].Dif.B:=255;
        SurfID:=Imp.SurfCount;
      end;
    end;

    if Copy(s,1,2)='s ' then begin //Looks like smoothing group ID
      SmoothGroup:=Round(GetNumberFromString(s,1));
    end;

    if Copy(s,1,2) = 'f ' then //Face indices are reverse order
    begin
      vID[1] := Round(GetNumberFromString(Copy(s,3,Length(s)),7));
      vID[2] := Round(GetNumberFromString(Copy(s,3,Length(s)),4));
      vID[3] := Round(GetNumberFromString(Copy(s,3,Length(s)),1));
      tID[1] := Round(GetNumberFromString(Copy(s,3,Length(s)),8));
      tID[2] := Round(GetNumberFromString(Copy(s,3,Length(s)),5));
      tID[3] := Round(GetNumberFromString(Copy(s,3,Length(s)),2));
      nID[1] := Round(GetNumberFromString(Copy(s,3,Length(s)),9));
      nID[2] := Round(GetNumberFromString(Copy(s,3,Length(s)),6));
      nID[3] := Round(GetNumberFromString(Copy(s,3,Length(s)),3));

      if nID[1] = 0 then
      begin
        MessageDlg('Unknown OBJ format, contact kromster80@gmail.com', mtError, [mbOK], 0);
        CloseFile(f);
        Exit;
      end;

      Inc(Imp.PolyCount);

      //We want to take XYZ as basis and fill it with OBJ xyz data and polystructure, respecting Normals
      //if Normals are different we shall make a new vertice and add it to the end

      for h:=1 to 3 do begin

        if (Imp.XYZ[vID[h]].X=123456)and(Imp.Nv[vID[h]].X=123456)and(SmoothGroupID[vID[h]]=123456) then begin //Vertice is still not filled
          Imp.XYZ[vID[h]]:=OBJxyz[vID[h]];
          Imp.Nv[vID[h]]:=OBJn[nID[h]];
          SmoothGroupID[vID[h]]:=SmoothGroup;
        end
        else
        if (Imp.Nv[vID[h]].X<>OBJn[nID[h]].X)
         or(Imp.Nv[vID[h]].Y<>OBJn[nID[h]].Y)
         or(Imp.Nv[vID[h]].Z<>OBJn[nID[h]].Z) then begin //Vertice normal is different
          Imp.Nv[vID[h]].X:=0;
          Imp.Nv[vID[h]].Y:=0;
          Imp.Nv[vID[h]].Z:=0;
        end
        else
        if SmoothGroupID[vID[h]]<>SmoothGroup then begin //Vertice smoothing group is different?
          Imp.Nv[vID[h]].X:=0;
          Imp.Nv[vID[h]].Y:=0;
          Imp.Nv[vID[h]].Z:=0;
        end;

        Imp.Faces[Imp.PolyCount,h]:=vID[h];
        Imp.DUV[Imp.PolyCount,h]:=OBJuv[tID[h]];

      end;

      Imp.VerticeCount:=VerticeCount;

      Imp.Surf[Imp.PolyCount]:=SurfID;
      Imp.Part[Imp.PolyCount]:=Imp.PartCount;
    end;

  until(Eof(f));
  CloseFile(f);

  AssignFile(f,ExtractFilePath(aFilename)+MtlLib); FileMode:=0; Reset(f); FileMode:=2;

  repeat
    Readln(f,s);

    while ((s='')or(s[1]='#'))and(not Eof(f)) do Readln(f,s);

    if Copy(s,1,6)='newmtl' then begin
      SurfID:=0;
      for i:=1 to Imp.SurfCount do
        if Imp.Mtl[i].Title=Copy(s,8,Length(s)) then
          SurfID:=i;
    end;

    if SurfID<>0 then begin

      if Copy(s,1,2)='Kd' then begin
        Imp.Mtl[SurfID].Dif.R:=Round(GetNumberFromString(Copy(s,4,Length(s)),1)*255);
        Imp.Mtl[SurfID].Dif.G:=Round(GetNumberFromString(Copy(s,4,Length(s)),2)*255);
        Imp.Mtl[SurfID].Dif.B:=Round(GetNumberFromString(Copy(s,4,Length(s)),3)*255);
      end;

      if Copy(s,1,6)='map_Kd' then
        Imp.Mtl[SurfID].TexName:=ExtractFileName(Copy(s,8,Length(s)));

    end;

  until(Eof(f));
  CloseFile(f);

  Log:=Log+'OBJ readed';
  Result:=True;
end;


function Load3DS(const aFilename: string; out Log:string):Boolean;
var
  f:file;
  c: array [1..MAX_READ_BUFFER] of AnsiChar;
  h,i:Integer;
  MatLay,MatLayUse,ObjLay,Len,Tmp:Word;
  Chunk: packed record
    ID:Word;
    Len:Integer;
  end;
  ChunkLen:array[1..5]of Integer;
  PivotMtx:record
    RotMtx:array[1..9]of Single;
    Offset:array[1..3]of Single;
  end;
  ObjName:string;
  VCount,PCount:array[1..256]of Word; //That is 3ds layers/blocks
begin
  Result:=False;
  Log:='';

  OldTimeLWO:=GetTickCount;

  FillChar(Imp,SizeOf(Imp),#0);

  for i:=1 to 65280 do
    for h:=1 to 3 do begin
      Imp.DUV[i,h].U:=123456;
      Imp.DUV[i,h].V:=123456;
    end;

  FillChar(ChunkLen,SizeOf(ChunkLen),#0);
  FillChar(VCount,SizeOf(VCount),#0);
  FillChar(PCount,SizeOf(PCount),#0);

  MatLay:=0;
  ObjLay:=0;

  AssignFile(f,aFilename); FileMode:=0; Reset(f,1); FileMode:=2;

  BlockRead(f,Chunk,6);
  ChunkLen[1]:=Chunk.Len-6;
  if Chunk.ID<>$4D4D then begin
    MessageDlg('This is unsupported 3DS format',mtError,[mbOK],0);
    CloseFile(f); exit;
  end;

  repeat
    BlockRead(f,Chunk,6);
    ChunkLen[2]:=Chunk.Len-6;
    Dec(ChunkLen[1],Chunk.Len);

    if Chunk.ID = $3D3D then
    begin

      repeat
        BlockRead(f,Chunk,6);
        ChunkLen[3]:=Chunk.Len-6;
        Dec(ChunkLen[2],Chunk.Len);

//        if Chunk.ID=$3D3E then begin //??
//          BlockRead(f,c,Chunk.Len-6);
//        end else

//        if Chunk.ID=$0010 then begin //??
//          BlockRead(f,c,Chunk.Len-6);
//        end else

        if Chunk.ID=$B000 then begin //Keyframer chunk
          repeat
            BlockRead(f,Chunk,6);
            ChunkLen[4]:=Chunk.Len-6;
            Dec(ChunkLen[3],Chunk.Len);

            begin
              //Log:=Log+'B000 chunk skipped ='+inttohex(Chunk.ID,4)+' ('+inttostr(Chunk.Len)+'Bytes)'+eol;
              BlockRead(f,c,Chunk.Len-6);
            end;
          until((ChunkLen[3]=0)or(Eof(f)));
        end else

        if Chunk.ID=$AFFF then begin //Material_Chunk
          Inc(MatLay);
          repeat
            BlockRead(f,Chunk,6);
            ChunkLen[4]:=Chunk.Len-6;
            Dec(ChunkLen[3],Chunk.Len);

            if Chunk.ID=$A000 then begin //?
              BlockRead(f,c,Chunk.Len-6);
              Imp.Mtl[MatLay].Title:=PAnsiChar(@c[1]);
            end else

            if Chunk.ID=$A010 then begin //AmbientColor
              BlockRead(f,c,Chunk.Len-6);
            end else

            if Chunk.ID=$A020 then begin //DiffuseColor
              BlockRead(f,c,Chunk.Len-6);
              Imp.Mtl[MatLay].Dif.R:=ord(c[7]);
              Imp.Mtl[MatLay].Dif.G:=ord(c[8]);
              Imp.Mtl[MatLay].Dif.B:=ord(c[9]);
            end else

            begin
              //Log:=Log+'AFFF chunk skipped ='+inttohex(Chunk.ID,4)+' ('+inttostr(Chunk.Len)+'Bytes)'+eol;
              BlockRead(f,c,Chunk.Len-6);
            end;
          until((ChunkLen[3]=0)or(Eof(f)));
        end else

        if Chunk.ID=$4000 then begin //Object_Chunk
          Inc(ObjLay);
          ObjName:='';
          repeat
            BlockRead(f,c,1);
            if c[1]<>#0 then ObjName:=ObjName+c[1];
          until((c[1]=#0)or(Length(ObjName)=19));
          Dec(ChunkLen[3],Length(ObjName)+1);

          repeat
            BlockRead(f,Chunk,6);
            ChunkLen[4]:=Chunk.Len-6;
            Dec(ChunkLen[3],Chunk.Len);

            if Chunk.ID=$4100 then begin //Triangular_Mesh

              repeat
                BlockRead(f,Chunk,6);
                ChunkLen[5]:=Chunk.Len-6;
                Dec(ChunkLen[4],Chunk.Len);

                if Chunk.ID=$4110 then begin //Vertices_List
                  BlockRead(f,VCount[ObjLay],2);
                  for i:=1 to VCount[ObjLay] do
                    BlockRead(f,Imp.XYZ[Imp.VerticeCount+i],12);
                end else

                if Chunk.ID=$4140 then begin //UVMap_List
                  BlockRead(f,Len,2);
                  for i:=1 to Len do
                    BlockRead(f,Imp.UV[Imp.VerticeCount+i],8);
                end else

                if Chunk.ID=$4160 then begin //Pivot RotationMatrix and Offset
                  BlockRead(f,PivotMtx,48);
                end else

                if Chunk.ID=$4120 then begin //Faces_List
                  BlockRead(f,PCount[ObjLay],2);
                  Dec(ChunkLen[5],PCount[ObjLay]*8+2);

                  if Imp.PolyCount+PCount[ObjLay]>65280 then begin
                    MessageDlg('Point quantity exceeds 65`280 limit',mtError,[mbOK],0);
                    CloseFile(f);
                    exit;
                  end;

                  for i:=1 to PCount[ObjLay] do begin
                    for h:=1 to 3 do begin
                      BlockRead(f,Imp.Faces[Imp.PolyCount+i,h],2);
                      Inc(Imp.Faces[Imp.PolyCount+i,h],Imp.VerticeCount+1);
                    end;
                    BlockRead(f,c,2);
                  end;

                  repeat
                    BlockRead(f,Chunk,6);
                    Dec(ChunkLen[5],Chunk.Len);

                    if Chunk.ID=$4130 then begin //Faces_Material
                      ObjName:='';
                      repeat
                        BlockRead(f,c,1);
                        if c[1]<>#0 then ObjName:=ObjName+c[1];
                      until((c[1]=#0)or(Length(ObjName)=20));

                      MatLayUse:=9999; //if names doesn't match invoke RangeError later on
                      for i:=1 to MatLay do
                        if Imp.Mtl[i].Title=ObjName then MatLayUse:=i;

                      BlockRead(f,Len,2);
                      for i:=1 to Len do begin
                        BlockRead(f,Tmp,2);
                        Imp.Surf[Tmp+Imp.PolyCount+1]:=MatLayUse;
                      end;
                    end else

                    if Chunk.ID=$4150 then begin //Smoothing_Group_List
                      for i:=1 to PCount[ObjLay] do begin
                        BlockRead(f,c,4);
                      end;
                      Log:=Log+'Smoothing groups readed'+eol;
                    end else

                    begin
                      Log:=Log+'4120 chunk skipped ='+inttohex(Chunk.ID,4)+' ('+inttostr(Chunk.Len)+'Bytes)'+eol;
                      BlockRead(f,c,Chunk.Len-6);
                    end;
                  until((ChunkLen[5]=0)or(Eof(f)));
                end else

                begin
                  Log:=Log+'4100 chunk skipped ='+inttohex(Chunk.ID,4)+' ('+inttostr(Chunk.Len)+'Bytes)'+eol;
                  BlockRead(f,c,Chunk.Len-6);
                end;
              until((ChunkLen[4]=0)or(Eof(f)));

              Inc(Imp.VerticeCount,VCount[ObjLay]);
              Inc(Imp.PolyCount,PCount[ObjLay]);
              //Inc(Imp.SurfCount);
            end else

            begin
              Log:=Log+'4000 chunk skipped ='+inttohex(Chunk.ID,4)+' ('+inttostr(Chunk.Len)+'Bytes)'+eol;
              BlockRead(f,c,Chunk.Len-6);
            end;
          until((ChunkLen[3]=0)or(Eof(f)));
        end else

        begin
          Log:=Log+'3D3D chunk skipped ='+inttohex(Chunk.ID,4)+' ('+inttostr(Chunk.Len)+'Bytes)'+eol;
          BlockRead(f,c,Chunk.Len-6);
        end;
      until(Eof(f));
    end else

    begin
      Log:=Log+'4D4D chunk skipped ='+inttohex(Chunk.ID,4)+' ('+inttostr(Chunk.Len)+'Bytes)'+eol;
      BlockRead(f,c,Chunk.Len-6);
    end;
  until(Eof(f));

CloseFile(f);

////////////////////////////////////////////////////////////////////////////////

  //Scale 3DMax coords
  for i:=1 to Imp.VerticeCount do begin
  Imp.XYZ[i].X:=-Imp.XYZ[i].X*10;
  Imp.XYZ[i].Y:=Imp.XYZ[i].Y*10;
  Imp.XYZ[i].Z:=Imp.XYZ[i].Z*10;
  SwapFloat(Imp.XYZ[i].X,Imp.XYZ[i].Z); //Swap X and Z axis
  end;

  for i:=1 to Imp.PolyCount do begin
  if Imp.Surf[i]=0 then Imp.Surf[i]:=1;
  end;

  Imp.SurfCount:=MatLay;
  Log:=Log+'3DS readed';
  Result:=True;
end;


function LoadLWO(const aFilename: string; out Log:string):Boolean;
var
  c: array [1..MAX_READ_BUFFER] of AnsiChar;
  f:file;
  h,i,j,k,m:Integer;
  xr:Single;
  chsize,xt:Integer;
  lay,stag:Integer;
  PrevChunk,tags:Integer;
  MatCount,PartCount,ColWireCount:Integer;
  PTag: array [1..MAX_PARTS * 2] of Byte; //1=surf 2=part 3=color
  cliptex:array[1..512]of string;
begin
  Result:=False;
  Log:='';
  OldTimeLWO:=GetTickCount;

  FillChar(Imp,SizeOf(Imp),#0);
  for i:=1 to 65280 do
    for h:=1 to 4 do begin
      Imp.DUV[i,h].U:=123456;
      Imp.DUV[i,h].V:=123456;
    end;

  stag:=1; tags:=0; Lay:=0;
  FillChar(Ptag,SizeOf(Ptag),#0);
  FillChar(cliptex,SizeOf(cliptex),#0);

  AssignFile(f,aFilename); FileMode:=0; Reset(f,1); FileMode:=2;
  BlockRead(f,c,12);

  if (c[1]+c[2]+c[3]+c[4]+c[9]+c[10]+c[11]+c[12])<>'FORMLWO2' then begin
    MessageDlg('Wrong header. File is not Lightwave 7.0+ format',mtError,[mbOK],0);
    CloseFile(f); exit;
  end;

  m:=int2(c[8],c[7],c[6],c[5])-4;

  repeat
  BlockRead(f,c,8);
  chname:=c[1]+c[2]+c[3]+c[4];
  chsize:=int2(c[8],c[7],c[6],c[5]);
  m:=m-chsize-8;

  if chsize<>0 then

  if chname='TAGS' then begin
    BlockRead(f,c,chsize);
    i:=0; k:=0;
    repeat
      Inc(k);
      repeat
        Inc(i,2);
        if c[i-1]<>#0 then Imp.PartName[k]:=Imp.PartName[k]+c[i-1];
        if c[i]<>#0 then Imp.PartName[k]:=Imp.PartName[k]+c[i];
        if c[i]=#0 then begin Inc(tags); ptag[tags]:=3; end; //set as colorwire=unuse
      until(c[i]=#0);
    until(i>=chsize);
  end else

  if chname='LAYR' then begin
  BlockRead(f,c,chsize); Inc(lay); //Layers come not sorted !!! May cause problems later
  end else

  if chname='PNTS' then begin
    LWOQty.XYZ[lay]:=chsize div 12;

    if LWOQty.XYZ[lay]>65280 then begin
      MessageDlg('Point quantity exceeds 65`280 limit',mtError,[mbOK],0);
      CloseFile(f); exit;
    end;

    for i:=1 to LWOQty.XYZ[lay] do begin
      BlockRead(f,c,12);
      Imp.XYZ[Imp.VerticeCount+i].X:=real2(c[4],c[3],c[2],c[1])*10;
      Imp.XYZ[Imp.VerticeCount+i].Y:=real2(c[8],c[7],c[6],c[5])*10;
      Imp.XYZ[Imp.VerticeCount+i].Z:=real2(c[12],c[11],c[10],c[9])*10;
    end;

    Inc(Imp.VerticeCount,LWOQty.XYZ[lay]);
  end else

  if chname='VMAP' then begin
    BlockRead(f,c,6);    //TXUV_2
    if (c[1]+c[2]+c[3]+c[4])<>'TXUV' then begin
      Log:=Log+'VMAP '+c[1]+c[2]+c[3]+c[4]+' skipped'+eol;
      BlockRead(f,c,chsize-6); end
    else begin
      repeat
        BlockRead(f,c,2); chsize:=chsize-2; //UV-map name
      until((c[1]=#0)or(c[2]=#0));
      LWOQty.UV[lay]:=(chsize-6) div 10;
      for i:=1 to LWOQty.UV[lay] do begin
        BlockRead(f,c,2);
        k:=ord(c[1])*256+ord(c[2])+1;// if k>LWOQty.XYZ[lay] then fail;
        BlockRead(f,c,8);
        Imp.UV[Imp.VerticeCount-LWOQty.XYZ[lay]+k].U:=real2(c[4],c[3],c[2],c[1]);
        Imp.UV[Imp.VerticeCount-LWOQty.XYZ[lay]+k].V:=real2(c[8],c[7],c[6],c[5]);
      end;
    end;
    Inc(LWOQty.UV[0],LWOQty.UV[lay]);
  end else

  if chname='POLS' then begin
    BlockRead(f,c,4); chsize:=chsize-4;
    LWOQty.Poly[lay]:=0;
    repeat

      BlockRead(f,c,2); Dec(chsize,2);
      k:=ord(c[1])*256+ord(c[2]);
      BlockRead(f,c,2*k); Dec(chsize,2*k);

      if (k=3)or(k=4) then begin
        Inc(LWOQty.Poly[lay]);
        Imp.Faces[LWOQty.Poly[lay]+Imp.PolyCount,1]:=ord(c[1])*256+ord(c[2])+Imp.VerticeCount-LWOQty.XYZ[lay]+1;
        Imp.Faces[LWOQty.Poly[lay]+Imp.PolyCount,2]:=ord(c[3])*256+ord(c[4])+Imp.VerticeCount-LWOQty.XYZ[lay]+1;
        Imp.Faces[LWOQty.Poly[lay]+Imp.PolyCount,3]:=ord(c[5])*256+ord(c[6])+Imp.VerticeCount-LWOQty.XYZ[lay]+1;
      end else
        MessageDlg('Only triangle polygons are accepted',mtError,[mbOK],0);

      if k=4 then
        Imp.Faces[LWOQty.Poly[lay]+Imp.PolyCount,4]:=ord(c[7])*256+ord(c[8])+Imp.VerticeCount-LWOQty.XYZ[lay]+1
      else
        Imp.Faces[LWOQty.Poly[lay]+Imp.PolyCount,4]:=0;

    until(chsize<=0);
    if chsize<0 then begin
      MessageDlg('Unknown error in POLS chunk',mtError,[mbOK],0);
      CloseFile(f); exit;
    end;
    Inc(Imp.PolyCount,LWOQty.Poly[lay]);
  end else

  if chname='PTAG' then begin
    BlockRead(f,c,4);
    if (c[1]+c[2]+c[3]+c[4])='PART' then begin
      chsize:=chsize-4;
      for i:=1 to (chsize div 4) do begin
        BlockRead(f,c,4);
        k:=ord(c[1])*256+ord(c[2])+1;           //polygon
        Imp.Part[k+Imp.PolyCount-LWOQty.Poly[lay]]:=ord(c[3])*256+ord(c[4])+1;    //part assignment
        Ptag[(ord(c[3])*256+ord(c[4])+1)]:=2;
      end;
    end else
    if (c[1]+c[2]+c[3]+c[4])='SURF' then begin
    //  chsize:=chsize-4;
      j:=0;
      for i:=1 to LWOQty.Poly[lay] do begin
        BlockRead(f,c,4);
        k:=ord(c[1])*256+ord(c[2])+1;           //polygon
        Imp.Surf[k+Imp.PolyCount-LWOQty.Poly[lay]]:=ord(c[3])*256+ord(c[4])+1;    //surface assignment
        Ptag[ord(c[3])*256+ord(c[4])+1]:=1;
      end;
    end else begin
      Log:=Log+'PTAG '+c[1]+c[2]+c[3]+c[4]+' skipped'+eol;
      BlockRead(f,c,chsize-4)
    end;
  end else

  if chname='VMAD' then begin
    BlockRead(f,c,6);    //TXUV_2
    if (c[1]+c[2]+c[3]+c[4])<>'TXUV' then begin
      Log:=Log+'VMAD '+c[1]+c[2]+c[3]+c[4]+' skipped'+eol;
      BlockRead(f,c,chsize-6);
    end
    else begin
      repeat
        BlockRead(f,c,2);
        Dec(chsize,2); //UV-map name
      until((c[1]=#0)or(c[2]=#0));
      LWOQty.DUV[lay]:=(chsize-6) div 12;
      for i:=1 to LWOQty.DUV[lay] do begin
        BlockRead(f,c,4);
        k:=ord(c[1])*256+ord(c[2])+1;  //point
        h:=ord(c[3])*256+ord(c[4])+1;  //poly
        BlockRead(f,c,8);              //coords
        for j:=1 to 4 do
          if Imp.Faces[h+Imp.PolyCount-LWOQty.Poly[lay],j]=k+Imp.VerticeCount-LWOQty.XYZ[lay] then begin
            Imp.DUV[h+Imp.PolyCount-LWOQty.Poly[lay],j].U:=real2(c[4],c[3],c[2],c[1]);
            Imp.DUV[h+Imp.PolyCount-LWOQty.Poly[lay],j].V:=real2(c[8],c[7],c[6],c[5]);
          end;
      end;
    end;
    Inc(LWOQty.DUV[0],LWOQty.DUV[lay]);
  end else

  if chname='CLIP' then begin
    BlockRead(f,c,chsize);
    s:=''; i:=9;
    repeat
      i:=i+2;
      if c[i]<>#0 then s:=s+c[i];
      if c[i+1]<>#0 then s:=s+c[i+1];
    until(c[i+1]=#0);
    k:=1;
    repeat
      cliptex[ord(c[3])*256+ord(c[4])]:=cliptex[ord(c[3])*256+ord(c[4])]+s[k];
      if s[k]='/' then cliptex[ord(c[3])*256+ord(c[4])]:='';
      Inc(k);
    until((k=Length(s))or(s[k]='.'));
  end else

  if chname='SURF' then begin
  BlockRead(f,c,chsize);
  i:=-1;
  Imp.Mtl[stag].Title:='';
  Imp.Mtl[stag].TexName:='';
  repeat
  i:=i+2;
  if c[i]<>#0 then Imp.Mtl[stag].Title:=Imp.Mtl[stag].Title+c[i];
  if c[i+1]<>#0 then Imp.Mtl[stag].Title:=Imp.Mtl[stag].Title+c[i+1];
  until(c[i+1]=#0);
  //Log:=Log+' - '+Imp.Mtl[stag].Title+eol;
  i:=i+4;
  repeat
  if c[i]+c[i+1]+c[i+2]+c[i+3]+c[i+4]+c[i+5]='COLR'+#0+#14 then begin i:=i+6;
  Imp.Mtl[stag].Dif.R:=Round(real2(c[i+3],c[i+2],c[i+1],c[i])*255);
  Imp.Mtl[stag].Dif.G:=Round(real2(c[i+7],c[i+6],c[i+5],c[i+4])*255);
  Imp.Mtl[stag].Dif.B:=Round(real2(c[i+11],c[i+10],c[i+9],c[i+8])*255);
  i:=i+14-1; end;
  if c[i]+c[i+1]+c[i+2]+c[i+3]+c[i+4]+c[i+5]='SPEC'+#0+#6 then begin i:=i+6;
  xt:=Round(real2(c[i+3],c[i+2],c[i+1],c[i])*255); xt:=EnsureRange(xt,0,255);
  Imp.Mtl[stag].Spec.R:=xt;
  Imp.Mtl[stag].Spec.G:=xt;
  Imp.Mtl[stag].Spec.B:=xt;
  i:=i+6-1; end;
  if c[i]+c[i+1]+c[i+2]+c[i+3]+c[i+4]+c[i+5]='REFL'+#0+#6 then begin i:=i+6;
  if Round(real2(c[i+3],c[i+2],c[i+1],c[i])*100)<>0 then Imp.Mtl[stag].Reflect:=50;
  i:=i+6-1; end;
  if c[i]+c[i+1]+c[i+2]+c[i+3]+c[i+4]+c[i+5]='LUMI'+#0+#6 then begin i:=i+6;
  Imp.Mtl[stag].Amb.R:=Round(real2(c[i+3],c[i+2],c[i+1],c[i])*255);
  Imp.Mtl[stag].Amb.G:=Round(real2(c[i+3],c[i+2],c[i+1],c[i])*255);
  Imp.Mtl[stag].Amb.B:=Round(real2(c[i+3],c[i+2],c[i+1],c[i])*255);
  i:=i+6-1; end;
  if c[i]+c[i+1]+c[i+2]+c[i+3]+c[i+4]+c[i+5]='TRAN'+#0+#6 then begin i:=i+6;
  xt:=Round(real2(c[i+3],c[i+2],c[i+1],c[i])*100);
  Imp.Mtl[stag].Transparency:=EnsureRange(Round(real2(c[i+3],c[i+2],c[i+1],c[i])*100),0,255); //0..255 only
  i:=i+6-1; end;
  if c[i]+c[i+1]+c[i+2]+c[i+3]+c[i+4]+c[i+5]='IMAG'+#0+#2 then begin i:=i+6;
  if (c[i+1]<>#0)and(cliptex[ord(c[i+1])]<>'') then Imp.Mtl[stag].TexName:=cliptex[ord(c[i+1])]+'.tga';
  i:=i+2-1; end;

  if i<chsize then i:=i+1
  until(i>=chsize);
  Imp.SurfCount:=stag;
  Inc(stag);          //finaly stag = surf qty+1
  end else

  begin
  Log:=Log+chname+' skipped'+eol;
  for i:=1 to (chsize div MAX_READ_BUFFER) do BlockRead(f,c,MAX_READ_BUFFER);
  BlockRead(f,c,chsize mod MAX_READ_BUFFER);
  end;
  until(m<=0);

  if m<0 then begin
    MessageDlg('Uknown error happened while processing LWO file',mtError,[mbOK],0);
    CloseFile(f); exit;
  end;
  CloseFile(f);

  ////////////////////////////////////////////////////////////////////////////////
  // Prepare LWO
  ////////////////////////////////////////////////////////////////////////////////

  MatCount:=0;
  PartCount:=0;

  k:=0; ColWireCount:=0;
  repeat
    Inc(k);
    if Ptag[k]=1 then Inc(MatCount);
    if Ptag[k]=2 then Inc(PartCount);
    if Ptag[k]=3 then Inc(ColWireCount);
  until(Ptag[k]=0); //now CW stands for number of colorwires

  for i:=ColWireCount+1 to MAX_PARTS do
    Imp.PartName[i-ColWireCount]:=Imp.PartName[i];

  for i:=1 to Imp.PolyCount do begin
  if (PartCount<>0)and(Imp.Part[i]<>0) then Dec(Imp.Part[i],ColWireCount);//getting rid of colorwires
  Imp.Surf[i]:=Imp.Surf[i]-ColWireCount-PartCount;//getting rid of colorwires
  end;

  Imp.SurfCount:=MatCount;
  Imp.PartCount:=PartCount;
  Log:=Log+'LWO readed';
  Result:=True;
end;

procedure SaveMOX2LWO(const aFilename: string; aSpreadOverX: Boolean);
var
  ft:textfile;
  rs: AnsiString;
  h,i,j,k,m:Integer;
  uu,vv,xr:Single;
  t,t2:Vector3f;
  ID,ID2,CurrentLev,DepthLev:Integer;
  mtx: TMatrix;
begin
  SetLength(rs, 4);
  AssignFile(ft,aFilename);
  Rewrite(ft);

  Write(ft,'FORM');

  m:=0;
  m:=m+12;                                        //+'LWO2TAGS   2'

  for i:=1 to MOX.Qty.Mat do
    if Material[i].Title<>'' then
      if (Length(Material[i].Title) mod 2)=1 then
        Inc(m,Length(Material[i].Title)+1)
      else
        Inc(m,Length(Material[i].Title)+2)
    else
      if Material[i].Mtag<>'' then Inc(m,6); //4+2

  m:=m+8+18;                                      //+LAYR_
  m:=m+8+MOX.Qty.Vertice*12;                      //+PNTS+3D
  m:=m+14+10+MOX.Qty.Vertice*10;                  //+UV
  m:=m+12+MOX.Qty.Poly*8;                         //+Face 3.x.x.x
  m:=m+12+MOX.Qty.Poly*4;                         //+Surface

  for i:=1 to MOX.Qty.Mat do
    if Material[i].TexName<>'' then begin
      if (Length(Material[i].TexName) mod 2)=1 then
        m:=m+Length(Material[i].TexName)+1
      else
        m:=m+Length(Material[i].TexName)+2;
      m:=8+10+m+4;                                //+CLIP+STIL+name+path
    end;

  for i:=1 to MOX.Qty.Mat do
    if Material[i].Title<>'' then
      if (Length(Material[i].Title) mod 2)=1 then
        Inc(m,Length(Material[i].Title)+1)
      else
        Inc(m,Length(Material[i].Title)+2)
    else
     if Material[i].Mtag<>'' then Inc(m,6);       //Writing tagID instead of name, 4+2

  m:=m+(8+2+66+252)*MOX.Qty.Mat;                  //+SURF Data

  //=========================Writing data

  Write(ft, AnsiChar(m div 1677216), AnsiChar(m div 65536), AnsiChar(m div 256), AnsiChar(m));
  Write(ft, 'LWO2', 'TAGS');

  m:=0;
  for i:=1 to MOX.Qty.Mat do
    if Material[i].Title<>'' then
      if (Length(Material[i].Title) mod 2)=1 then
        Inc(m,Length(Material[i].Title)+1)
      else
       Inc(m,Length(Material[i].Title)+2)
    else
      if Material[i].Mtag<>'' then Inc(m,6); //4+2

  Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));

  for i:=1 to MOX.Qty.Mat do
    if Material[i].Title<>'' then
      if (Length(Material[i].Title) mod 2)=1 then
        Write(ft,Material[i].Title,#0)
      else
        Write(ft,Material[i].Title,#0,#0)
    else
      if Material[i].Mtag<>'' then
        Write(ft,Material[i].Mtag,#0,#0); //4+2

  Write(ft,'LAYR',#0,#0,#0,#18,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0);

  Write(ft,'PNTS');
  m:=MOX.Qty.Vertice*12; Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));
  ID:=0; ID2:=0;

  for j:=1 to MOX.Qty.Vertice do
  begin
    t.x:=MOX.Vertice[j].X;
    t.y:=MOX.Vertice[j].Y;
    t.z:=MOX.Vertice[j].Z;

    if j=MOX.Chunk[ID+1,3] then //current point matches first point of next chunk
      Inc(ID); //This is ID of current chunk
    if (ID = MOX.Parts[ID2+1].FirstMat+1) and (MOX.Parts[ID2+1].NumMat <> 0) then
      Inc(ID2); //This is ID of current detail

    DepthLev := 8;
    repeat
      CurrentLev := 1; k := ID2;
      while (MOX.Parts[k].Parent > -1) and (CurrentLev <> DepthLev) do
      begin
        k := MOX.Parts[k].Parent+1;
        Inc(CurrentLev);
      end;

      DepthLev := CurrentLev; // set depth for first run
      Dec(DepthLev);          // -1

      mtx := MOX.Parts[k].Matrix;
      t2.x:=t.x*mtx[1,1]+t.y*mtx[2,1]+t.z*mtx[3,1]+mtx[4,1];
      t2.y:=t.x*mtx[1,2]+t.y*mtx[2,2]+t.z*mtx[3,2]+mtx[4,2];
      t2.z:=t.x*mtx[1,3]+t.y*mtx[2,3]+t.z*mtx[3,3]+mtx[4,3];
      t:=t2;
    until(DepthLev=0);

    MOX.Vertice[j].X := t.x + ID2 * 25 * Ord(aSpreadOverX);
    MOX.Vertice[j].Y := t.y;
    MOX.Vertice[j].Z := t.z;
    rs := unreal2(MOX.Vertice[j].X/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //LWO uses
    rs := unreal2(MOX.Vertice[j].Y/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //reverse Byte
    rs := unreal2(MOX.Vertice[j].Z/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //order
  end;

  Write(ft,'VMAP');
  m:=6+10+MOX.Qty.Vertice*10; Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'TXUV',#0,#2);
  Write(ft,'Texture01',#0);           //TextureMap name in LW
  j:=0;
  for k:=1 to MOX.Qty.Vertice do begin
    if k=MOX.Chunk[j+1,3] then Inc(j); //j=1 ...
    Write(ft,AnsiChar((k-1) div 256),AnsiChar(k-1));
    if Material[j].TexScale.U=0 then Material[j].TexScale.U:=1;
    if Material[j].TexScale.V=0 then Material[j].TexScale.V:=1;
    uu:= MOX.Vertice[k].U*Material[j].TexScale.U+Material[j].TexOffset.U;             // not Reversed
    vv:=-MOX.Vertice[k].V*Material[j].TexScale.V+Material[j].TexOffset.V+1;             // not Reversed
    if Material[j].TexAngle=90 then begin xr:=uu; uu:=-vv; vv:=xr; end; //Rotate 90 CCW
    if Material[j].TexAngle=-90 then begin xr:=uu; uu:=vv; vv:=-xr; end;//Rotate 90 CW
    rs:=unreal2(uu); Write(ft,rs[4],rs[3],rs[2],rs[1]);
    rs:=unreal2(vv); Write(ft,rs[4],rs[3],rs[2],rs[1]);
  end;

  Write(ft,'POLS');
  m:=MOX.Qty.Poly*8+4; Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'FACE');
  for j:=1 to MOX.Qty.Poly do begin
    Write(ft,#0,#3 // 3 Points/Polygon
    ,AnsiChar((MOX.Face[j,1]-1) div 256),AnsiChar(MOX.Face[j,1]-1)
    ,AnsiChar((MOX.Face[j,2]-1) div 256),AnsiChar(MOX.Face[j,2]-1)
    ,AnsiChar((MOX.Face[j,3]-1) div 256),AnsiChar(MOX.Face[j,3]-1));
  end;

  Write(ft,'PTAG');
  m:=MOX.Qty.Poly*4+4; Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'SURF'); ID:=0;
  for i:=1 to MOX.Qty.Poly do begin
    if i-1=MOX.Chunk[ID+1,1] then Inc(ID);
    Write(ft,AnsiChar((i-1) div 256),AnsiChar(i-1),AnsiChar((MOX.Sid[ID,1]) div 256),AnsiChar(MOX.Sid[ID,1]));
  end;

  for i:=1 to MOX.Qty.Mat do if Material[i].TexName<>'' then begin
    Write(ft,'CLIP');
    if (Length(Material[i].TexName) mod 2)=1 then m:=Length(Material[i].TexName)+1 else m:=Length(Material[i].TexName)+2;
    m:=10+m+4; Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));
    Write(ft,#0,#0,#0,AnsiChar(i));
    Write(ft,'STIL'); m:=m-10; Write(ft,AnsiChar(m div 256),AnsiChar(m));
    Write(ft,'C:1/',Material[i].TexName);
    if (Length(Material[i].TexName) mod 2)=1 then Write(ft,#0) else Write(ft,#0,#0);
  end;

  for i:=1 to MOX.Qty.Mat do begin
    Write(ft,'SURF');
    m:=2+66+252;      ////Data Len
    if Material[i].Title<>'' then
     if (Length(Material[i].Title) mod 2)=1 then
      Inc(m,Length(Material[i].Title)+1) else
      Inc(m,Length(Material[i].Title)+2) else
     if Material[i].Mtag<>'' then Inc(m,6); //4+2
    Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));

    if Material[i].Title<>'' then
     if (Length(Material[i].Title) mod 2)=1 then
      Write(ft,Material[i].Title,#0) else
      Write(ft,Material[i].Title,#0,#0) else
     if Material[i].Mtag<>'' then Write(ft,Material[i].Mtag,#0,#0); //4+2

    Write(ft,#0,#0);
    Write(ft,'COLR',#0,#14);
    rs:=unreal2(Material[i].Color[ColID].Dif.R/255); Write(ft,rs[4],rs[3],rs[2],rs[1]);
    rs:=unreal2(Material[i].Color[ColID].Dif.G/255); Write(ft,rs[4],rs[3],rs[2],rs[1]);
    rs:=unreal2(Material[i].Color[ColID].Dif.B/255); Write(ft,rs[4],rs[3],rs[2],rs[1]);

    Write(ft,#0,#0);
    Write(ft,'SPEC',#0,#6);
    rs:=unreal2((Material[i].Color[ColID].Sp1.R+
                 Material[i].Color[ColID].Sp1.G+
                 Material[i].Color[ColID].Sp1.B)/300);
    Write(ft,rs[4],rs[3],rs[2],rs[1]);
    Write(ft,#0,#0);

    Write(ft,'REFL',#0,#6);
    rs:=unreal2(Material[i].Color[ColID].Ref.R/255); Write(ft,rs[4],rs[3],rs[2],rs[1]);
    Write(ft,#0,#0);

    Write(ft,'TRAN',#0,#6);
    rs:=unreal2(Material[i].Transparency/100); Write(ft,rs[4],rs[3],rs[2],rs[1]);
    Write(ft,#0,#0);

    Write(ft,'SMAN',#0,#4);
    Write(ft,#63,#200,#3,#14);

    Write(ft,'BLOK'); // 252-6
    m:=246; Write(ft,AnsiChar(m div 256),AnsiChar(m));
    Write(ft,'IMAP',#0,'*A',#0,'CHAN',#0,#4,'COLROPAC',#0,#8,#0,#0,#63,#128,#0,#0,#0,#0);
    Write(ft,'ENAB',#0,#2,#0,#1,'NEGA',#0,#2,#0,#0,'TMAP',#0,#98,'CNTR',#0,#14); for j:=1 to 14 do Write(ft,#0);
    Write(ft,'SIZE',#0,#14); for j:=1 to 3 do Write(ft,#63,#128,#0,#0); Write(ft,#0,#0);
    Write(ft,'ROTA',#0,#14); for j:=1 to 14 do Write(ft,#0);
    Write(ft,'FALL',#0,#16); for j:=1 to 16 do Write(ft,#0);
    Write(ft,'OREF',#0,#2,#0,#0,'CSYS',#0,#2,#0,#0,'PROJ',#0,#2,#0,#5,'AXIS',#0,#2,#0,#2);
    Write(ft,'IMAG',#0,#2,#0,AnsiChar(i),'WRAP',#0,#4,#0,#0,#0,#0,'WRPW',#0,#6,#63,#128,#0,#0,#0,#0);
    Write(ft,'WRPH',#0,#6,#63,#128,#0,#0,#0,#0,'VMAP',#0,#10,'Texture01',#0);
    Write(ft,'AAST',#0,#6,#0,#0,#63,#128,#0,#0,'PIXB',#0,#2,#0,#1);
  end;

  CloseFile(ft);
end;

procedure LoadMTL(const aFilename: string);
var
  h,i,j,k: Integer;
  ft: textfile;
  NumMaterials: Integer; //for current MTL file
begin
  NumMaterials:=0;
  NumColors:=1;
  FillChar(Material,SizeOf(Material),#0);

  if FileExists(aFilename) then
  begin
    AssignFile(ft,aFilename);
    FileMode:=0; Reset(ft); FileMode:=2;

    j:=0;
    repeat
      Readln(ft,s);
      repeat      //Removing last " "s
        if Length(s)>=1 then if s[Length(s)]=#32 then setlength(s,Length(s)-1);
      until((s='')or(s[Length(s)]<>#32)); //removing spacers

      CHname:=''; k:=1;
      repeat
        if Length(s)>=k then CHname:=CHname+s[k];
        Inc(k);
      until((Length(s)<k)or(s[k]=#32)); CHname:=uppercase(CHname); //Chapter name now available

      if CHname='COLSETINF' then else //DoNothing

      if CHname='#' then begin
        Inc(j);
        Material[j].Mtag:=s[5]+s[6]+s[7]+s[8];
        for h:=10 to Length(s) do Material[j].Title:=Material[j].Title+s[h];
        Inc(NumMaterials);
      end else

      if CHname='MATCLASS' then begin
        Material[j].MatClass[1]:=strtoint(s[11]);
        Material[j].MatClass[2]:=strtoint(s[14]);
        Material[j].MatClass[3]:=strtoint(s[17]);
        Material[j].MatClass[4]:=strtoint(s[19]+s[20]);
      end else

      if chname='DIFFUSE' then begin k:=1;
        repeat
          h:=7+k*9; if Length(s)<h then h:=Length(s);
          Material[j].Color[k].Dif.R:=hextoint(s[h-5])*16+hextoint(s[h-4]); //11,20, ...
          Material[j].Color[k].Dif.G:=hextoint(s[h-3])*16+hextoint(s[h-2]);
          Material[j].Color[k].Dif.B:=hextoint(s[h-1])*16+hextoint(s[h-0]);
          Inc(k);
        until(k=16)
      end else

      if chname='AMBIENT' then begin k:=1;
        repeat
          h:=7+k*9; if Length(s)<h then h:=Length(s);
          Material[j].Color[k].Amb.R:=hextoint(s[h-5])*16+hextoint(s[h-4]); //11,20, ...
          Material[j].Color[k].Amb.G:=hextoint(s[h-3])*16+hextoint(s[h-2]);
          Material[j].Color[k].Amb.B:=hextoint(s[h-1])*16+hextoint(s[h-0]);
          Inc(k);
        until(k=16)
      end else

      if chname='SPECULAR' then begin k:=1;
        repeat
          h:=8+k*9; if Length(s)<h then h:=Length(s);
          Material[j].Color[k].Sp1.R:=hextoint(s[h-5])*16+hextoint(s[h-4]); //12,21, ...
          Material[j].Color[k].Sp1.G:=hextoint(s[h-3])*16+hextoint(s[h-2]);
          Material[j].Color[k].Sp1.B:=hextoint(s[h-1])*16+hextoint(s[h-0]);
          Inc(k);
        until(k=16)
      end else

      if chname='REFLECT' then begin k:=1;
        repeat
          h:=7+k*9; if Length(s)<h then h:=Length(s);
          Material[j].Color[k].Ref.R:=hextoint(s[h-5])*16+hextoint(s[h-4]); //11,20, ...
          Material[j].Color[k].Ref.G:=hextoint(s[h-3])*16+hextoint(s[h-2]);
          Material[j].Color[k].Ref.B:=hextoint(s[h-1])*16+hextoint(s[h-0]);
          Inc(k);
        until(k=16)
      end else

      if chname='SPECULAR2' then begin k:=1;
        repeat
          h:=9+k*9; if Length(s)<h then h:=Length(s);
          Material[j].Color[k].Sp2.R:=hextoint(s[h-5])*16+hextoint(s[h-4]); //12,21, ...
          Material[j].Color[k].Sp2.G:=hextoint(s[h-3])*16+hextoint(s[h-2]);
          Material[j].Color[k].Sp2.B:=hextoint(s[h-1])*16+hextoint(s[h-0]);
          Inc(k);
        until(k=16)
      end else

      //XDIFFUSE
      //XSPECULAR

      if chname='TRANSPARENCY' then
        Material[j].Transparency:=EnsureRange(Round(GetNumberFromString(s,1)*100),0,100)
      else

      if chname='TEX1NAME' then begin i:=10;
        Material[j].TexName:='';
        repeat Inc(i);
          if s[i]<>'"' then Material[j].TexName:=Material[j].TexName+s[i];
        until((i=Length(s))or(s[i]='"')or(s[i]='.'));
        if Material[j].TexName<>'' then Material[j].TexName:=Material[j].TexName+'tga';
      end else

      if chname='TEXFLAGS' then begin
        Material[j].TexEdge.U:=strtoint(s[12]);
        Material[j].TexEdge.V:=strtoint(s[13]);
      end else

      if chname='TEXOFFSET' then begin
        Material[j].TexOffset.U:=GetNumberFromString(s,1);
        Material[j].TexOffset.V:=GetNumberFromString(s,2);
      end else

      if chname='TEXSCALE' then begin
        Material[j].TexScale.U:=GetNumberFromString(s,1);
        Material[j].TexScale.V:=GetNumberFromString(s,2);
      end else

      if chname='TEXANGLE' then begin
        Material[j].TexAngle:=strtofloat(s[10]+s[11]+s[12]+s[13]+s[14])*1000;
        if Material[j].TexAngle=1570 then Material[j].TexAngle:=90;
        if Material[j].TexAngle=-157 then Material[j].TexAngle:=-90;
      end;

      if Length(s)>80 then
        NumColors:=MAX_COLORS; //if any line is long enough to pass

    until(Eof(ft));
    CloseFile(ft);
  end;

  begin //FileNotExists or append incomplete MTL

    for i:=NumMaterials+1 to MOX.Qty.Mat do
    with Material[i] do begin
      Mtag:=inttohex((i-1),4);
      Color[1].Amb.R:=0;  Color[1].Amb.G:=0;  Color[1].Amb.B:=0;
      Color[1].Dif.R:=96; Color[1].Dif.G:=96; Color[1].Dif.B:=80;
      Color[1].Sp1.R:=64; Color[1].Sp1.G:=64; Color[1].Sp1.B:=48;
      Color[1].Sp2.R:=32; Color[1].Sp2.G:=32; Color[1].Sp2.B:=24;
      Color[1].Ref.R:=50; Color[1].Ref.G:=50; Color[1].Ref.B:=50;
      TexEdge.U:=1; TexEdge.V:=1;
    end;

    for i:=NumMaterials+1 to MOX.Qty.Mat do
    for k:=1 to MAX_COLORS do
      Material[i].Color[k]:=Material[i].Color[1]; //Set all colors same
  end;
end;

procedure SaveMTL(const aFilename: string);
var
  i,k:Integer;
  ft:textfile;
begin
  AssignFile(ft,aFilename); Rewrite(ft);

  if NumColors = MAX_COLORS then
    writeln(ft,'ColSetInf "01Schwarz" "02Rot" "03Rot" "04DunkelRot" "05Gelb" "06Gelb" "07Weiss" "08Anthrazit" "09DunkelGruen" "10DunkelGruen" "11Blau" "12QuarzBlau" "13Blau" "14Silber" "15Silber" "Michel-gruen" "oldtimer-blau" "oldtimer-gruen" "nardo-rot" "Fensterglass"')
  else
    writeln(ft,'ColSetInf "Default"');

  for i:=1 to MOX.Qty.Mat do with Material[i] do begin
    writeln(ft,'');
    writeln(ft,'# 0x',Mtag+' '+Title);
    writeln(ft,'MatClass 0',MatClass[1],' 0',MatClass[2],' 0',MatClass[3],' '+int2fix(MatClass[4],2));
    Write(ft,'Diffuse');  for k:=1 to NumColors do
    Write(ft,' 0x',inttohex(Color[k].Dif.B+Color[k].Dif.G*256+Color[k].Dif.R*65536,6)); writeln(ft);
    Write(ft,'Ambient');  for k:=1 to NumColors do
    Write(ft,' 0x',inttohex(Color[k].Amb.B+Color[k].Amb.G*256+Color[k].Amb.R*65536,6)); writeln(ft);
    Write(ft,'Specular'); for k:=1 to NumColors do
    Write(ft,' 0x',inttohex(Color[k].Sp1.B+Color[k].Sp1.G*256+Color[k].Sp1.R*65536,6)); writeln(ft);
    Write(ft,'Reflect');  for k:=1 to NumColors do
    Write(ft,' 0x',inttohex(Color[k].Ref.B+Color[k].Ref.G*256+Color[k].Ref.R*65536,6)); writeln(ft);
    Write(ft,'Specular2');for k:=1 to NumColors do
    Write(ft,' 0x',inttohex(Color[k].Sp2.B+Color[k].Sp2.G*256+Color[k].Sp2.R*65536,6)); writeln(ft);
    Write(ft,'XDiffuse'); for k:=1 to NumColors do Write(ft,' 0x000000'); writeln(ft,'');
    Write(ft,'XSpecular');for k:=1 to NumColors do Write(ft,' 0x000000'); writeln(ft,'');
    s:=floattostr(Transparency/100);
    for k:=Length(s)+1 to 8 do if k=2 then s:=s+'.' else s:=s+'0';
    writeln(ft,'Transparency ',s);
    writeln(ft,'Tex1Name "'+TexName+'"');
    writeln(ft,'TexFlags 0x',inttostr(TexEdge.U),inttostr(TexEdge.V),' 0x00 0x00 0x00');
    writeln(ft,'TexOffset 0.000000 0.000000');
    writeln(ft,'TexScale 1.000000 1.000000');
    writeln(ft,'TexAngle 0.000000');
    end;
  writeln(ft,'');
  CloseFile(ft);
end;


function LoadCPO(const aFilename: string):Boolean;
var
  i:Integer;
  f:file;
begin
  Result:=False;

  if not FileExists(aFilename) then exit;
  AssignFile(f,aFilename); FileMode:=0; Reset(f,1); FileMode:=2;
  BlockRead(f,CPOHead,16);

  for i:=1 to CPOHead.Qty do begin
    BlockRead(f,CPO[i].Format,4);

    if CPO[i].Format=2 then begin
      BlockRead(f,CPO[i].ScaleX,12);
      BlockRead(f,CPO[i].PosX,12);
      BlockRead(f,CPO[i].Matrix9,36);
    end;

    if CPO[i].Format=3 then begin
      BlockRead(f,CPO[i].VerticeCount,16);
      BlockRead(f,CPO[i].Vertices[1],CPO[i].VerticeCount*12);
      BlockRead(f,CPO[i].Indices[1],CPO[i].IndiceSize);
      BlockRead(f,CPO[i].PosX,12);
      BlockRead(f,CPO[i].Matrix9,36);
    end;
  end;

  CloseFile(f);
  Result:=True;
end;

procedure SaveCPO(const aFilename: string);
var
  i: Integer;
  f: file;
begin
  AssignFile(f, aFilename);
  Rewrite(f, 1);

  BlockWrite(f, CPOHead, 16);

  for i := 1 to CPOHead.Qty do
  begin
    BlockWrite(f,CPO[i].Format, 4);

    if CPO[i].Format = 2 then
    begin
      BlockWrite(f,CPO[i].ScaleX,12);
      BlockWrite(f,CPO[i].PosX,12);
      BlockWrite(f,CPO[i].Matrix9,36);
    end;

    if CPO[i].Format = 3 then
    begin
      BlockWrite(f,CPO[i].VerticeCount,16);
      BlockWrite(f,CPO[i].Vertices[1],CPO[i].VerticeCount*12);
      BlockWrite(f,CPO[i].Indices[1],CPO[i].IndiceSize);
      BlockWrite(f,CPO[i].PosX,12);
      BlockWrite(f,CPO[i].Matrix9,36);
    end;
  end;

  CloseFile(f);
end;

function LoadCOB(const aFilename: string): Boolean;
var
  i:Integer;
  f:file;
begin
  Result := False;
  if not FileExists(aFilename) then Exit;

  AssignFile(f,aFilename);
  FileMode:=0; Reset(f,1); FileMode:=2;
  BlockRead(f,COB.Head.PointQty,44);
  for i:=1 to COB.Head.PointQty do BlockRead(f,COB.Vertices[i].X,12);
  BlockRead(f,COB.Faces[1],6*COB.Head.PolyQty);
  for i:=1 to COB.Head.PolyQty do BlockRead(f,COB.NormalsP[i].X,12);
  CloseFile(f);

  Result := True;
end;

procedure SaveCOB(const aFilename: string);
var
  i: Integer;
  f: file;
begin
  AssignFile(f,aFilename); Rewrite(f,1);
  BlockWrite(f,COB.Head.PointQty,44);
  for i:=1 to COB.Head.PointQty do BlockWrite(f,COB.Vertices[i].X,12);
  for i:=1 to COB.Head.PolyQty do BlockWrite(f,COB.Faces[i,1],6);
  for i:=1 to COB.Head.PolyQty do BlockWrite(f,COB.NormalsP[i].X,12);
  CloseFile(f);
end;

procedure SaveCOB2LWO(const aFilename: string);
var
  i,m: Integer;
  rs: string[4];
  ft: textfile;
begin
  AssignFile(ft,aFilename); Rewrite(ft);
  Write(ft,'FORM'); m:=0;
  Inc(m,12);                                                     //+'LWO2TAGS   2'
  Inc(m,8);                                                      //Default
  Inc(m,8+18);                                                   //+LAYR_
  Inc(m,8+COB.Head.PointQty*12);                                 //+PNTS+3D
  Inc(m,12+COB.Head.PolyQty*8);                                  //+Face 3.x.x.x
  Inc(m,12+COB.Head.PolyQty*4);                                  //+PTAG
  //Inc(m,8+10);                                                 //+SURF Data

  Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'LWO2','TAGS');
  Write(ft,#0,#0,#0,#8,'Default',#0);
  Write(ft,'LAYR',#0,#0,#0,#18,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0);

  Write(ft,'PNTS');
  m:=COB.Head.PointQty*12; Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  for i:=1 to COB.Head.PointQty do
  begin
    rs:=unreal2(COB.Vertices[i].X/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //LWO uses
    rs:=unreal2(COB.Vertices[i].Y/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //reverse
    rs:=unreal2(COB.Vertices[i].Z/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //order
  end;

  Write(ft,'POLS');
  m:=COB.Head.PolyQty*8+4; Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'FACE');
  for i:=1 to COB.Head.PolyQty do
  Write(ft,#0,#3
  ,AnsiChar((COB.Faces[i,1]) div 256),AnsiChar(COB.Faces[i,1])
  ,AnsiChar((COB.Faces[i,2]) div 256),AnsiChar(COB.Faces[i,2])
  ,AnsiChar((COB.Faces[i,3]) div 256),AnsiChar(COB.Faces[i,3]));

  Write(ft,'PTAG');
  m:=COB.Head.PolyQty*4+4; Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'SURF');
  for i:=0 to COB.Head.PolyQty-1 do Write(ft,AnsiChar(i div 256),AnsiChar(i),#0,#0);

  Write(ft,'SURF',#0,#0,#0,#10,'Default',#0,#0,#0);

  CloseFile(ft);
end;


procedure SaveCPO2LWO(const aFilename: string; ShapeID:Integer);
var
  i,m:Integer;
  rs:string[4];
  ft:textfile;
begin
  if (ShapeID=0)or(CPO[ShapeID].Format=2) then exit; //No sense to export bounding box to lwo

  AssignFile(ft,aFilename); Rewrite(ft);
  Write(ft,'FORM'); m:=0;
  Inc(m,12);                                                     //+'LWO2TAGS   2'
  Inc(m,8);                                                      //Default
  Inc(m,8+18);                                                   //+LAYR_
  Inc(m,8+CPO[ShapeID].VerticeCount*12);                         //+PNTS+3D
  Inc(m,12+CPO[ShapeID].IndiceSize);                             //Face
  Inc(m,12+CPO[ShapeID].PolyCount*4);                            //+PTAG
  //Inc(m,8+10);                                                 //+SURF Data

  Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'LWO2','TAGS');
  Write(ft,#0,#0,#0,#8,'Default',#0);
  Write(ft,'LAYR',#0,#0,#0,#18,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0);

  Write(ft,'PNTS');
  m:=CPO[ShapeID].VerticeCount*12; Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  for i:=1 to CPO[ShapeID].VerticeCount do begin
  rs:=unreal2(CPO[ShapeID].Vertices[i].X/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //LWO uses
  rs:=unreal2(CPO[ShapeID].Vertices[i].Y/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //reverse
  rs:=unreal2(CPO[ShapeID].Vertices[i].Z/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //order
  end;

  Write(ft,'POLS');
  m:=CPO[ShapeID].IndiceSize+4; Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'FACE');
  for i:=1 to (CPO[ShapeID].IndiceSize div 2) do
  Write(ft,AnsiChar(CPO[ShapeID].Indices[i] div 256),AnsiChar(CPO[ShapeID].Indices[i]));

  Write(ft,'PTAG');
  m:=CPO[ShapeID].PolyCount*4+4; Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'SURF');
  for i:=0 to CPO[ShapeID].PolyCount-1 do Write(ft,AnsiChar(i div 256),AnsiChar(i),#0,#0);

  Write(ft,'SURF',#0,#0,#0,#10,'Default',#0,#0,#0);

  CloseFile(ft);
end;


procedure LoadTREE(const aFilename: string);
var
  c: array [1..MAX_READ_BUFFER] of AnsiChar;
  i: Integer;
  f: file;
begin
  AssignFile(f, aFilename);
  FileMode := 0;
  Reset(f, 1);
  FileMode := 2;

  BlockRead(f,Tree,16);
  BlockRead(f,c,64); TreeTexNames[1]:=PAnsiChar(@c[1]);
  BlockRead(f,c,64); TreeTexNames[2]:=PAnsiChar(@c[1]);
  BlockRead(f,TreeLOD,48);//
  BlockRead(f,TreeChunks,60);//
  //for i:=1 to 15 do
  //memo2.Lines.Add(inttostr(TreeChunks[i]));
  BlockRead(f,TreeVertex[1],32*Tree.NumVertex);
  BlockRead(f,TreeLeaves,16*Tree.NumLeaves);
  BlockRead(f,TreePoly[1],Tree.NumIndices*2);
  //BlockRead(f,c,Tree.NumIndices);
  CloseFile(f);

  TreeHeight:=0;
  for i:=1 to Tree.NumVertex do
  if TreeHeight<TreeVertex[i].Y then
    TreeHeight:=Round(TreeVertex[i].Y);
  //RGExtra.Items[1]:='Show TREE ('+floattostr(TreeHeight/10)+'m)';
end;


procedure LoadLights(const aFilename: string);
var
  f:file;
begin
  if not FileExists(aFilename) then exit;

  AssignFile(f,aFilename);
  FileMode := 0;
  Reset(f, 1);
  FileMode := 2;
  BlockRead(f, MOX.Qty.Blink, 4);
  if MOX.Qty.Blink > MAX_BLINKERS then
    MOX.Qty.Blink := MAX_BLINKERS;
  BlockRead(f, MOX.Blinkers, 88 * MOX.Qty.Blink);
  CloseFile(f);
end;


procedure SaveLights(const aFilename: string);
var
  f:file;
begin
  AssignFile(f,aFilename); Rewrite(f,1);
  BlockWrite(f,MOX.Qty.Blink,4);
  BlockWrite(f,MOX.Blinkers,88*MOX.Qty.Blink);
  CloseFile(f);
end;


function LoadPBF(const aFilename: string):Boolean;
var
  h,i,k:Integer;
  ft:textfile;
  DQty:Integer;
  name:array[1..256]of string;
  Parent,child,next,prev:array[1..256]of smallint;
  DetailMet:Boolean;
  TmpX,TmpY,TmpZ,TmpR,TmpX1,TmpX2,TmpY1,TmpY2,TmpZ1,TmpZ2:array[1..256]of Single;
  TmpID:array[1..256]of Integer;
begin
  Result:=False;
  if not FileExists(aFilename) then exit;
  AssignFile(ft,aFilename);
  FileMode:=0; Reset(ft); FileMode:=2;

  Readln(ft);
  Readln(ft,s);
  case Length(s) of
  8: DQty:=strtoint(s[8]);
  9: DQty:=strtoint(s[8]+s[9]);
  10:DQty:=strtoint(s[8]+s[9]+s[10]);
  else DQty:=0; //
  end;

  Readln(ft);
  for i:=1 to DQty do begin
  Readln(ft,name[i]);
  Readln(ft,TmpID[i]);
  Readln(ft,Parent[i]);
  Readln(ft,Child[i]);
  Readln(ft,Prev[i]);
  Readln(ft,Next[i]);
  Readln(ft,TmpX[i]);
  Readln(ft,TmpY[i]);
  Readln(ft,TmpZ[i]);
  Readln(ft,TmpR[i]);
  Readln(ft,TmpX1[i]);
  Readln(ft,TmpX2[i]);
  Readln(ft,TmpY1[i]);
  Readln(ft,TmpY2[i]);
  Readln(ft,TmpZ1[i]);
  Readln(ft,TmpZ2[i]);
  Readln(ft);
  end;
  CloseFile(ft);

  for i:=1 to MOX.Qty.Parts do
    for k:=1 to MOX.Qty.Parts do
      if MOX.Parts[i].Dname=name[k] then begin
        MOX.Parts[i].TypeID:=TmpID[k];
        MOX.Parts[i].xMid:=TmpX[k];
        MOX.Parts[i].yMid:=TmpY[k];
        MOX.Parts[i].zMid:=TmpZ[k];
        MOX.Parts[i].fRadius:=TmpR[k];
        MOX.Parts[i].x1:=TmpX1[k];
        MOX.Parts[i].x2:=TmpX2[k];
        MOX.Parts[i].y1:=TmpY1[k];
        MOX.Parts[i].y2:=TmpY2[k];
        MOX.Parts[i].z1:=TmpZ1[k];
        MOX.Parts[i].z2:=TmpZ2[k];
      end;

  Form1.TVParts.Items.Clear; h:=1;
  for i:=1 to MOX.Qty.Parts do
  begin //Add matching nodes
    DetailMet:=False;
    for k:=1 to MOX.Qty.Parts do if name[i]=MOX.Parts[k].Dname then DetailMet:=True;

    if DetailMet then
    begin
      if Parent[i]=-1 then Dnode[i]:=Form1.TVParts.Items.Add(nil,name[i])
      else //make Root one
      Dnode[i]:=Form1.TVParts.Items.AddChild(Dnode[Parent[i]+1],name[i]);
      Inc(h);
    end;
  end;

  for i:=1 to MOX.Qty.Parts do
  begin //Add non-matching nodes from LWO
    DetailMet:=False;
    for k:=1 to MOX.Qty.Parts do if MOX.Parts[k].Dname=name[k] then DetailMet:=True;
    if not DetailMet then begin
      Dnode[h]:=Form1.TVParts.Items.Add(nil,MOX.Parts[i].Dname);
      Inc(h);
    end;
  end;

  if MOX.Qty.Parts>=1 then Dnode[1].Expand(False);

  Form1.ExchangePartsOrdering;
  Form1.RebuildPartsTree;
  Result:=True;
end;


procedure SavePBF(const aFilename: string);
var
  i:Integer;
  ft:textfile;
begin
  AssignFile(ft,aFilename); Rewrite(ft);

  writeln(ft,'Part Behaviour File by MTKit2');
  writeln(ft,'Parts#=',MOX.Qty.Parts);
  writeln(ft);
  for i:=1 to MOX.Qty.Parts do
  begin
    writeln(ft,MOX.Parts[i].Dname);
    writeln(ft,floattostr(MOX.Parts[i].TypeID));
    writeln(ft,floattostr(MOX.Parts[i].Parent));
    writeln(ft,floattostr(MOX.Parts[i].Child));
    writeln(ft,floattostr(MOX.Parts[i].PrevInLevel));
    writeln(ft,floattostr(MOX.Parts[i].NextInLevel));
    writeln(ft,floattostr(MOX.Parts[i].xMid));
    writeln(ft,floattostr(MOX.Parts[i].yMid));
    writeln(ft,floattostr(MOX.Parts[i].zMid));
    writeln(ft,floattostr(MOX.Parts[i].fRadius));
    writeln(ft,floattostr(MOX.Parts[i].x1));
    writeln(ft,floattostr(MOX.Parts[i].x2));
    writeln(ft,floattostr(MOX.Parts[i].y1));
    writeln(ft,floattostr(MOX.Parts[i].y2));
    writeln(ft,floattostr(MOX.Parts[i].z1));
    writeln(ft,floattostr(MOX.Parts[i].z2));
    writeln(ft);
  end;
  writeln(ft,'//end');
  CloseFile(ft);
end;


function LoadPSF(const aFilename: string):Boolean;
var
  i,k:Integer;
  ft:textfile;
  tmp1,tmp2,tmp3:array[1..256]of Single;
  name:array[1..256]of string;
  DQty:Integer;
begin
  Result:=False;
  if not FileExists(aFilename) then exit;
  AssignFile(ft,aFilename);
  FileMode:=0; Reset(ft); FileMode:=2;

  Readln(ft);
  Readln(ft,s);
  case Length(s) of
    8: DQty:=strtoint(s[8]);
    9: DQty:=strtoint(s[8]+s[9]);
    10:DQty:=strtoint(s[8]+s[9]+s[10]);
    else DQty:=0; //
  end;

  Readln(ft); //empty row
  for i:=1 to DQty do begin
    Readln(ft,name[i]);
    Readln(ft,tmp1[i]);
    Readln(ft,tmp2[i]);
    Readln(ft,tmp3[i]);
    Readln(ft);
  end;

  for i:=1 to MOX.Qty.Parts do
    for k:=1 to DQty do
      if MOX.Parts[i].Dname=name[k] then
      begin
        PartModify[i].Custom[1]:=tmp1[k];
        PartModify[i].Move[1]:=tmp1[k];
        PartModify[i].AxisSetup[1]:=3;
        PartModify[i].Custom[2]:=tmp2[k];
        PartModify[i].Move[2]:=tmp2[k];
        PartModify[i].AxisSetup[2]:=3;
        PartModify[i].Custom[3]:=tmp3[k];
        PartModify[i].Move[3]:=tmp3[k];
        PartModify[i].AxisSetup[3]:=3;
      end;

  CloseFile(ft);
  Result:=True;
end;

procedure SavePSF(const aFilename: string);
var
  i:Integer;
  ft:textfile;
begin
  AssignFile(ft,aFilename); Rewrite(ft);

  writeln(ft,'PivotSetupFile by MTKit2');
  writeln(ft,'Parts#=',MOX.Qty.Parts);
  writeln(ft);

  for i:=1 to MOX.Qty.Parts do
  begin
    writeln(ft,MOX.Parts[i].Dname);
    writeln(ft,floattostr(PartModify[i].Move[1]));
    writeln(ft,floattostr(PartModify[i].Move[2]));
    writeln(ft,floattostr(PartModify[i].Move[3]));
    writeln(ft);
  end;

  writeln(ft,'//end');
  CloseFile(ft);
end;


function ScanVinyls(aPath:string):Boolean;
var
  SearchRec: TSearchRec;
  ii: Integer;
begin
  Result := False;
  VinylsCount := 0;

  ChDir(aPath);
  if DirectoryExists(aPath+'\Textures_PC\Vinyls') then
    ChDir(aPath+'\Textures_PC\Vinyls')
  else
  //if DirectoryExists(InPath+'Textures\Vinyls') then
  //  ChDir(InPath+'Textures\Vinyls')
  //else
    Exit;

  FindFirst('*', faAnyFile or faDirectory, SearchRec);
  ii:=1;
  repeat
    if (SearchRec.Attr and faDirectory=0)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then
      if GetFileExt(SearchRec.Name) = 'PTX' then
      begin
        VinylsList[ii] := SearchRec.Name;
        Inc(ii);
      end;
  until (FindNext(SearchRec) <> 0);
  FindClose(SearchRec);
  VinylsCount:=ii-1;

  Result := True;
end;


end.
