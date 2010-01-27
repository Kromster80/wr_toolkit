program tga2ptx;
{$MODE Delphi}
uses
  {$IFDEF FPC}
  Interfaces,
  LCLIntf,
  {$ENDIF}
  SysUtils;


var
  fout:textfile;
  s,tganame,ErrS:string;
  SearchRec:TSearchRec;
  ii,MipMapL:integer;
  ftga:file;
  MMH,MMV,x,h,i,k:integer;
  Rmm,Gmm,Bmm,Amm,R,G,B,A:array[1..2048,1..2048]of integer;
  c:array[1..2048*4] of char;
  SizeH,SizeV,InBit:integer;


  {$IFDEF VER140}
  {$R *.res}
  {$ENDIF}

  //todo: move everything to external PAS unit so that Lazarus and Delphi wouldn't have duplicate code in DPR and LPR

function ConvertTGA2PTX(tganame:string; MipMapLev:integer):boolean;
begin
Result:=false;
if not FileExists(tganame) then exit;
setlength(tganame,length(tganame)-3);
////////////////////////////Reading TGA//////////////////////
AssignFile(ftga,tganame+'tga'); Reset(ftga,1);
BlockRead(ftga,c,18);
SizeH:=ord(c[13])+ord(c[14])*256;
SizeV:=ord(c[15])+ord(c[16])*256;
InBit:=ord(c[17]);
if ((InBit<>24)and(InBit<>32))or(
(SizeH<>8)and(SizeH<>16)and(SizeH<>32)and
(SizeH<>64)and(SizeH<>128)and(SizeH<>256)and
(SizeH<>512)and(SizeH<>1024)and(SizeH<>2048))or
((SizeV<>8)and(SizeV<>16)and(SizeV<>32)and
(SizeV<>64)and(SizeV<>128)and(SizeV<>256)and
(SizeV<>512)and(SizeV<>1024)and(SizeV<>2048)) then begin
MessageBox(0,'TGA size must be 8,16,32...1024 x 24/32 bit','Error', $00); //MB_OK
closefile(ftga); end
else begin
for i:=sizeV downto 1 do begin
BlockRead(ftga,c,SizeH*(InBit div 8));
  for k:=1 to sizeH do
if InBit=24 then begin
  B[k,i]:=ord(c[k*3-2]);
  G[k,i]:=ord(c[k*3-1]);
  R[k,i]:=ord(c[k*3-0]);
end else
if InBit=32 then begin
  B[k,i]:=ord(c[k*4-3]);
  G[k,i]:=ord(c[k*4-2]);
  R[k,i]:=ord(c[k*4-1]);
  A[k,i]:=ord(c[k*4-0]);
end;
end;
closefile(ftga);
end;

////////////////////////////Writing PTX//////////////////////
AssignFile(fout,tganame+'ptx'); ReWrite(fout);
write(fout,#0,chr(InBit));
write(fout,#0,#0);
write(fout,chr(SizeH),chr(SizeH div 256),#0,#0);
write(fout,chr(SizeV),chr(SizeV div 256),#0,#0);
if SizeH>=SizeV then x:=SizeH else x:=SizeV;
k:=0;
repeat x:=x div 2; inc(k); until(x=2);     //min size 4x1 pixels.
if (MipMapLev<=0)or(MipMapLev>k) then MipMapLev:=k;
write(fout,chr(MipMapLev),#128,#128,#128);   //MipMapLevels,R?G?B?
MMH:=SizeH;
MMV:=SizeV;
for h:=1 to MipMapLev do begin
write(fout,chr((MMH*MMV*4)),chr((MMH*MMV*4) div 256),chr((MMH*MMV*4) div 65536),#0,#0,#0,#0,#0);
for i:=1 to MMV do for k:=1 to MMH do begin
if h=1 then begin
Rmm[k,i]:=R[k,i];      //First level
Gmm[k,i]:=G[k,i];      //mipmap
Bmm[k,i]:=B[k,i];      //
if InBit=32 then Amm[k,i]:=A[k,i] else Amm[k,i]:=0;
end else begin
Rmm[k,i]:=(Rmm[k*2,i*2]+Rmm[k*2-1,i*2]+Rmm[k*2,i*2-1]+Rmm[k*2-1,i*2-1])div 4;
Gmm[k,i]:=(Gmm[k*2,i*2]+Gmm[k*2-1,i*2]+Gmm[k*2,i*2-1]+Gmm[k*2-1,i*2-1])div 4;
Bmm[k,i]:=(Bmm[k*2,i*2]+Bmm[k*2-1,i*2]+Bmm[k*2,i*2-1]+Bmm[k*2-1,i*2-1])div 4;
Amm[k,i]:=(Amm[k*2,i*2]+Amm[k*2-1,i*2]+Amm[k*2,i*2-1]+Amm[k*2-1,i*2-1])div 4;
end;
write(fout,chr(Bmm[k,i]),chr(Gmm[k,i]),chr(Rmm[k,i]));
write(fout,chr(Amm[k,i])); //Alredy zero`ed if none
end;
MMH:=MMH div 2;
MMV:=MMV div 2;
if MMH=0 then MMH:=1;
if MMV=0 then MMV:=1;
end;
closefile(fout);

Result:=true;
end;


begin
//chDir('Tga2Ptx');
//s:='"C2:\ty" *.tga';
tganame:='';
s:=cmdline;
ii:=0; MipMapL:=0;
repeat
inc(ii);
if s[ii]='"' then repeat inc(ii); until(s[ii]='"'); //exe path in " " skipped.
until(s[ii]=#32);  //s[k]=#32 now
inc(ii);     //s[k]="
if length(s)>ii then
repeat
if s[ii]='-' then begin MipMapL:=ord(s[ii+1])-48; inc(ii,3); end;
if s[ii]<>'"' then tganame:=tganame+s[ii];
inc(ii);
until(length(s)<ii);
/////////////////////////////////////////////////////////////
if UpperCase(tganame)='*.TGA' then begin
      ii:=0; MipMapL:=0; //all default
      FindFirst('*', faAnyFile, SearchRec);
      repeat
      if length(SearchRec.Name)>=5 then begin //*.tga
      s:=UpperCase(SearchRec.Name);
        if s[length(s)-3]+s[length(s)-2]+s[length(s)-1]+s[length(s)]='.TGA' then begin
        ConvertTGA2PTX(SearchRec.Name,MipMapL); inc(ii); end;
      end;
      until (FindNext(SearchRec)<>0);
      FindClose(SearchRec);
      ErrS := 'Converted '+inttostr(ii)+' TGA files.';
MessageBox(0,@(ErrS)[1],'TGA2PTX v2', $00); //MB_OK
end else

if fileexists(tganame) then begin //SomeName.tga
ConvertTGA2PTX(tganame,MipMapL);
end else

MessageBox(0,
'File not found'+#10+#13+
#10+#13+
'Command-line parameters:'+#10+#13+
'-x            number of mip-map levels to generate'+#10+#13+
'                (9 is the maximum) (optional),'+#10+#13+
'???.tga    TGA file to convert.'+#10+#13+
'*.tga       all TGA files in current folder.'+#10+#13+
#10+#13+
'Examples:'+#10+#13+
'tga2ptx.exe bmw.tga'+#10+#13+
'tga2ptx.exe -9 bmw.tga'+#10+#13+
'tga2ptx.exe *.tga'+#10+#13+
#10+#13+
'Written by Krom: kromster80@gmail.com'+#10+#13+
'MBWR/WR2/C11 tools at: http://krom.reveur.de/'
,'TGA2PTX v2', $00); //MB_OK
end.
