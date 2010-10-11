program tga2ptx;
uses windows, sysutils, Math;

const
  VersionInfo = 'TGA2PTX v2';

var
  fout:textfile; //Log


  ftga:file;
  MMH,MMV,x:integer;
  Rmm,Gmm,Bmm,Amm,R,G,B,A:array[1..2048,1..2048]of integer;
  c:array[1..2048*4] of char;
  SizeH,SizeV,InBit:integer;

{$R *.res}
function ConvertTGA2PTX(tganame:string; MipMapLev:integer; aCompress:boolean):boolean;
var
  i,k,m,h,j:integer;
  f1,f2,f3:int64;
  Fog:array[1..3]of byte;
  Area:word; Ratio:single; Tmp1,Tmp2,Tmp3,Tmp4,Acc:single;
begin
  if not FileExists(tganame) then exit;
  setlength(tganame,length(tganame)-3);
  ////////////////////////////Reading TGA//////////////////////
  AssignFile(ftga,tganame+'tga');
  FileMode:=0; Reset(ftga,1); FileMode:=2; //As read-only

  BlockRead(ftga,c,18);
  SizeH := ord(c[13])+ord(c[14])*256;
  SizeV := ord(c[15])+ord(c[16])*256;
  InBit := ord(c[17]);
  if ((InBit<>24)and(InBit<>32))or(
  (SizeH<>8)and(SizeH<>16)and(SizeH<>32)and
  (SizeH<>64)and(SizeH<>128)and(SizeH<>256)and
  (SizeH<>512)and(SizeH<>1024)and(SizeH<>2048))or
  ((SizeV<>8)and(SizeV<>16)and(SizeV<>32)and
  (SizeV<>64)and(SizeV<>128)and(SizeV<>256)and
  (SizeV<>512)and(SizeV<>1024)and(SizeV<>2048)) then begin
    MessageBox(0, @(TGAName + ' size must be 8,16,32...2048 x 24/32 bit')[1], 'Error', MB_OK);
    closefile(ftga);
    exit;
  end;

  for i:=sizeV downto 1 do begin
    BlockRead(ftga,c,SizeH*(InBit div 8));
    for k:=1 to sizeH do
    case InBit of
      24: begin
            B[k,i]:=ord(c[k*3-2]);
            G[k,i]:=ord(c[k*3-1]);
            R[k,i]:=ord(c[k*3-0]);
            A[k,i]:=0;
          end;
      32: begin
            B[k,i]:=ord(c[k*4-3]);
            G[k,i]:=ord(c[k*4-2]);
            R[k,i]:=ord(c[k*4-1]);
            A[k,i]:=ord(c[k*4-0]);
          end;
      else begin
            MessageBox(0, @(TGAName + ' color depth must be 24 or 32 bit')[1], 'Error', MB_OK);
            exit;
          end;
    end;
  end;
  closefile(ftga);


  ////////////////////////////Writing PTX//////////////////////
  AssignFile(fout,tganame+'ptx'); ReWrite(fout);
  write(fout,#0,chr(InBit));
  write(fout,#0,#0);
  write(fout,chr(SizeH),chr(SizeH div 256),#0,#0);
  write(fout,chr(SizeV),chr(SizeV div 256),#0,#0);

  if SizeH>=SizeV then x:=SizeH else x:=SizeV;
  k:=0;
  repeat x:=x div 2; inc(k); until(x=2);     //smallest mip-map level size is 4x1 pixels
  if (MipMapLev<=0)or(MipMapLev>k) then MipMapLev:=k;


  ////////////////////////Compute fog color/////////////////////
  f1:=0; f2:=0; f3:=0;
  for i:=1 to sizeV do for k:=1 to sizeH do begin
    f1 := f1 + (R[k,i]);
    f2 := f2 + (G[k,i]);
    f3 := f3 + (B[k,i]);
  end;
  Fog[1] := round(f1 / (sizeV*sizeH));
  Fog[2] := round(f2 / (sizeV*sizeH));
  Fog[3] := round(f3 / (sizeV*sizeH));
  write(fout,chr(MipMapLev),chr(Fog[3]),chr(Fog[2]),chr(Fog[1]));   //MipMapLevels, Fog color


  MMH := SizeH;
  MMV := SizeV;
  for m:=1 to MipMapLev do begin
    write(fout,chr((MMH*MMV*4)),chr((MMH*MMV*4) div 256),chr((MMH*MMV*4) div 65536),#0,#0,#0,#0,#0);
    if m=1 then
    for i:=1 to MMV do for k:=1 to MMH do begin
      Rmm[k,i]:=R[k,i];      //First level
      Gmm[k,i]:=G[k,i];      //mipmap
      Bmm[k,i]:=B[k,i];      //
      Amm[k,i]:=A[k,i];
    end
    else
    begin
      Area:=round(IntPower(2,m-1)); //1..1024 (one side only), temp limit to 16
      for i:=1 to MMV do for k:=1 to MMH do begin
        Tmp1:=0; Tmp2:=0; Tmp3:=0; Tmp4:=0; Acc:=0;
        for h:=1 to Area do for j:=1 to Area do begin
          Ratio:=sqr( Area/2 - (h-0.5) ) + sqr( Area/2 - (j-0.5) );
          Ratio:=Math.max(1-sqrt(Ratio)/Area,0);
          //Ratio:=sqr(Ratio); //Fits rather good but kills thin lines
          Tmp1 := Tmp1+R[(k-1)*Area+h,(i-1)*Area+j]*Ratio;
          Tmp2 := Tmp2+G[(k-1)*Area+h,(i-1)*Area+j]*Ratio;
          Tmp3 := Tmp3+B[(k-1)*Area+h,(i-1)*Area+j]*Ratio;
          Tmp4 := Tmp4+A[(k-1)*Area+h,(i-1)*Area+j]*Ratio;
          Acc := Acc + Ratio;
        end;
        Acc := max(Acc,1);
        Rmm[k,i] := round(EnsureRange(Tmp1/Acc,0,255));
        Gmm[k,i] := round(EnsureRange(Tmp2/Acc,0,255));
        Bmm[k,i] := round(EnsureRange(Tmp3/Acc,0,255));
        Amm[k,i] := round(EnsureRange(Tmp4/Acc,0,255));
      end;
    end;
    for i:=1 to MMV do for k:=1 to MMH do
      write(fout,chr(Bmm[k,i]),chr(Gmm[k,i]),chr(Rmm[k,i]),chr(Amm[k,i]));
    MMH:=MMH div 2;
    MMV:=MMV div 2;
    if MMH=0 then MMH:=1;
    if MMV=0 then MMV:=1;
  end;
  closefile(fout);
end;


var
  i:integer;
  TGACount:integer;
  TGAName:array of string;
  SearchRec:TSearchRec;
  MipMapL:integer;
  Compress:boolean;
begin
  //ShowMessage(inttostr(ParamCount)+' ... '+ParamStr(0)+' ...'+ParamStr(1)+' ... '+ParamStr(2));
  TGACount := 0;
  Compress := false; //Default
  MipMapL  := 0;     //Default

  for i:=1 to ParamCount do begin
    if Copy(ParamStr(i),0,2) = '/m' then MipMapL := StrToIntDef(Copy(ParamStr(i), 2, 2), 0) else
    if Copy(ParamStr(i),0,2) = '/c' then Compress := true else
    begin
      inc(TGACount);
      if length(TGAName) <= TGACount then setlength(TGAName, TGACount+32);
      TGAName[TGACount] := ParamStr(i);
    end;
  end;

  //ShowMessage('Mipmaps: '+inttostr(MipMapL)+', Compress: '+inttostr(byte(Compress))+', TGA: '+tganame);


  /////////////////////////////////////////////////////////////
  if (TGACount>=1) and (UpperCase(TGAName[1])='*.TGA') then begin
    i := 0;
    FindFirst('*.tga', (faAnyFile-faDirectory-faArchive-faSymLink), SearchRec);
    repeat
      ConvertTGA2PTX(SearchRec.Name, 0, Compress); //0 = Default mip-map count
      inc(i);
    until (FindNext(SearchRec)<>0);
    FindClose(SearchRec);
    MessageBox(0, @Format('Converted %d TGA files.', [i])[1], VersionInfo, MB_OK);
    exit;
  end
  else
  if(TGACount>=1) then begin
    for i:=1 to TGACount do
    if fileexists(TGAName[i]) then
      ConvertTGA2PTX(TGAName[i], MipMapL, Compress);
    exit;
  end;

  //If we did not quit by now - show a message

  MessageBox(0,
  '    File not found'+#10+#13+
  #10+#13+
  'Command-line parameters:'+#10+#13+
  #10+#13+
  '    /c               compress resulting PTX files,'+#10+#13+
  '    /m#           force number of mip-map levels to generate,'+#10+#13+
  '    123.tga     TGA to convert, you may do several files in a row'+#10+#13+
  '    *.tga         convert all TGA files in current folder.'+#10+#13+
  #10+#13+
  'Examples:'+#10+#13+
  '    tga2ptx.exe bmw.tga'+#10+#13+
  '    tga2ptx.exe /m9 bmw.tga'+#10+#13+
  '    tga2ptx.exe /c *.tga'+#10+#13+
  '    tga2ptx.exe *.tga'+#10+#13+
  #10+#13+
  'Written by Krom: kromster80@gmail.com'+#10+#13+
  'MBWR/WR2/AFC11/FVR tools at: http://krom.reveur.de/'
  ,VersionInfo, MB_OK);
end.
