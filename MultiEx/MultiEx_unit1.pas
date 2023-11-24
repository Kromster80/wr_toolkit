unit MultiEx_unit1;
interface
uses
  Windows, SysUtils, Classes, Forms, StdCtrls, FileCtrl, Messages, ShellAPI,
  Menus, ExtCtrls, Graphics, Controls, Dialogs, WR_AboutBox;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    ListBox1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Image1: TImage;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label6b: TLabel;
    Label8: TLabel;
    Label8b: TLabel;
    PopupMenu1: TPopupMenu;
    Export1: TMenuItem;
    ExportAll1: TMenuItem;
    Label5: TLabel;
    Label5b: TLabel;
    Label7: TLabel;
    Label7b: TLabel;
    NiceCheck: TCheckBox;
    Image3: TImage;
    Image4: TImage;
    Label10: TLabel;
    Timer1: TTimer;
    Image6: TImage;
    Label9: TLabel;
    Image7: TImage;
    Button1: TButton;
    Browse: TButton;
    CBWriteLog: TCheckBox;
    procedure OpenClick(Sender: TObject);
    procedure DefineFMT(filename:string);
    procedure MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ExtractSelected(Sender: TObject);
    procedure ExtractAll(Sender: TObject);
    procedure OpenMBWR(synname:string);
    procedure OpenMBTR(synname:string);
    procedure OpenBIGF(bigname:string);
    procedure OpenVIV(bigname:string);
    procedure ExtractMBWR(Idx:integer);
    procedure ExtractMBTR(Idx:integer);
    procedure ExtractBIGF(Idx:integer);
    procedure Keup(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure SetNICE2(Sender: TObject);
    procedure EastEgg(Sender: TObject);
    procedure Time(Sender: TObject);
    procedure EastEgg2(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BrowseClick(Sender: TObject);
  private
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
  end;

var
  Form1: TForm1;
  f,fout:file;
  flog:textfile; //Log file
  x:integer;
  Glob:integer; //position of decompressor
  Addv,Dist,Leng:integer; //distance & length in decompression mech
  qty:integer;
  d:array[1..32*1024*1024] of char; //output file array in memory
  c:array[1..4096] of char;
  objprop,objlength,objstart:array[1..1024] of integer;
  Idx:integer;
  tim,tim2:integer;
  fname:array[1..1024] of string;
  fmt,arname:string;   //File format,Filename
  CFileName: array[0..MAX_PATH] of Char;
  Msg2:TWMDropFiles;
  s,ss:string;
  NumRead,ToRead:integer;

implementation

{$R *.DFM}

procedure TForm1.WMDropFiles(var Msg: TWMDropFiles);
var
  CFileName: array[0..MAX_PATH] of Char;
begin
  try
    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then
    begin
      DefineFMT(CFileName);
      Msg.Result := 0;
    end;
  finally
    DragFinish(Msg.Drop);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var k:integer; filename:string;
begin
DragAcceptFiles(Form1.Handle,true);
s:=CMDLine; k:=0;
//Memo1.Lines.Add(s);
//s:='"c:\abc"  "E:\World Racing 2\Scenarios\Japan\V2\Tracks\Tracks.SYN"';    //Test cmdline
repeat
inc(k);
if s[k]='"' then
  repeat inc(k); until(s[k]='"'); //exe path in " " skipped.
until(s[k]=#32);  //s[k]=#32 now
inc(k);     //s[k]="
if s[k]=#32 then inc(k); //double space in WinXP
if length(s)>k then
repeat
if s[k]<>'"' then begin filename:=filename+s[k]; end;
inc(k);
until(length(s)=k);  //Path to SYN in synname now
memo1.Lines.Add(filename);
DefineFMT(filename);
end;

procedure TForm1.OpenClick(Sender: TObject);                     //GetInfo
begin
if not OpenDialog1.Execute then exit;
DefineFMT(OpenDialog1.FileName);
end;

procedure TForm1.DefineFMT(filename:string);
begin
if not FileExists(filename) then exit;
ss:=filename; arname:='';
repeat
arname:=ss[length(ss)]+arname;
setlength(ss,(length(ss)-1));
until(ss[length(ss)]='\');
Edit1.Text:=ss; Edit1.Enabled:=true; Browse.Enabled:=true; //Path to extract
Label2.Caption:=arname; Form1.Caption:='Multi-Extractor - '+arname;
assignfile(f,filename); FileMode:=0; reset(f,1); FileMode:=2;
blockread(f,c,8);
if c[1]+c[2]+c[3]+c[4]+c[5]+c[6]+c[7]+c[8]='SYN!v2.0' then OpenMBWR(filename) else
if c[1]+c[2]+c[3]+c[4]='FNYS'                         then OpenMBTR(filename) else
if (c[1]+c[2]+c[3]+c[4]='BIGF')and(uppercase(filename[length(filename)])<>'V') then OpenBIGF(filename) else
if (c[1]+c[2]+c[3]+c[4]='BIGF')and(uppercase(filename[length(filename)])='V')  then OpenVIV(filename) else begin
MessageBox(0,'File is not MBWR or MBTR/N.I.C.E.2 or CMR4 or NFS format.','Error',MB_OK or MB_ICONSTOP or MB_TASKMODAL);
Edit1.Enabled:=false; Browse.Enabled:=false; closefile(f); end;
end;

procedure TForm1.OpenMBWR(synname:string);
var i,k:integer;
begin
ListBox1.Clear; s:='';
reset(f,1);
blockread(f,c,64); //Head
qty:=ord(c[9])+ord(c[10])*256;
Label7b.Caption:='--/'+inttostr(qty);
for i:=1 to qty do begin
blockread(f,c,64);
k:=1; fname[i]:='';
repeat
fname[i]:=fname[i]+c[k]; inc(k);
until(c[k]=#0);
objstart[i]:=ord(c[49])+ord(c[50])*256+ord(c[51])*256*256+ord(c[52])*256*256*256;
objlength[i]:=ord(c[53])+ord(c[54])*256+ord(c[55])*256*256+ord(c[56])*256*256*256;
objprop[i]:=ord(c[57])+ord(c[58])*256+ord(c[59])*256*256+ord(c[60])*256*256*256;
ListBox1.Items.Add(fname[i]);
end;
fmt:='MBWR'; NiceCheck.Enabled:=false;
Label2.Caption:=arname+'  ('+fmt+')';
end;

procedure TForm1.OpenMBTR(synname:string);
var i,k:integer;
begin
memo1.Lines.Clear; ListBox1.Clear; s:='';
reset(f,1);
blockread(f,c,16); //Head
qty:=ord(c[5])+ord(c[6])*256;
Label7b.Caption:='--/'+inttostr(qty);
for i:=1 to qty do begin
blockread(f,c,32);
k:=1; fname[i]:='';
repeat
fname[i]:=fname[i]+c[k];
inc(k);
until(c[k]=#0);
objstart[i]:=4+ord(c[25])+ord(c[26])*256+ord(c[27])*256*256+ord(c[28])*256*256*256;
objlength[i]:=ord(c[29])+ord(c[30])*256+ord(c[31])*256*256+ord(c[32])*256*256*256;
objprop[i]:=objlength[i];
ListBox1.Items.Add(fname[i]);
end;
blockread(f,c,4);  //Total size ???
objlength[qty]:=objlength[qty]-4;
fmt:='MBTR'; NiceCheck.Enabled:=true; SetNICE2(nil);
Label2.Caption:=arname+'  ('+fmt+')';
end;

procedure TForm1.OpenBIGF(bigname:string);
var i,k,offset:integer;
begin
memo1.Lines.Clear; ListBox1.Clear; s:='';
reset(f,1);
blockread(f,c,36); //Head
qty:=ord(c[5])+ord(c[6])*256;
offset:=ord(c[9])+ord(c[10])*256;
Label7b.Caption:='--/'+inttostr(qty);
for i:=1 to qty do begin
blockread(f,c,24);
k:=1; fname[i]:='';
repeat
fname[i]:=fname[i]+c[k]; inc(k);
until(c[k]=#0);
objstart[i]:=ord(c[21])+ord(c[22])*256+ord(c[23])*256*256+ord(c[24])*256*256*256+offset;
objlength[i]:=ord(c[17])+ord(c[18])*256+ord(c[19])*256*256+ord(c[20])*256*256*256;
objprop[i]:=objlength[i];
ListBox1.Items.Add(fname[i]);
end;
fmt:='BIGF'; NiceCheck.Enabled:=false;
Label2.Caption:=arname+'  ('+fmt+')';
end;

procedure TForm1.OpenVIV(bigname:string);
var i,k,offset:integer;
begin
memo1.Lines.Clear; ListBox1.Clear; s:='';
reset(f,1);
blockread(f,c,16); //Head
qty:=ord(c[12])+ord(c[11])*256;
offset:=0;
Label7b.Caption:='--/'+inttostr(qty);
for i:=1 to qty do begin
blockread(f,c,8);
objstart[i]:=ord(c[4])+ord(c[3])*256+ord(c[2])*256*256+ord(c[1])*256*256*256+offset;
objlength[i]:=ord(c[8])+ord(c[7])*256+ord(c[6])*256*256+ord(c[5])*256*256*256;
objprop[i]:=objlength[i];
k:=1; fname[i]:='';
repeat
blockread(f,c,1);
if c[1]<>#0 then fname[i]:=fname[i]+c[1];
until(c[1]=#0);
ListBox1.Items.Add(fname[i]);
end;
fmt:='VIV'; NiceCheck.Enabled:=false;
Label2.Caption:=arname+'  ('+fmt+')';
end;

procedure TForm1.ExtractSelected(Sender: TObject);            //Export one
var i,k,Idx:integer; selname:string;
begin
CreateDir(Edit1.Text); ChDir(Edit1.Text);
for i:=1 to ListBox1.Items.Count do
  if ListBox1.Selected[i-1] then begin
  selname:=ListBox1.Items[i-1];
  for k:=1 to ListBox1.Count do if selname=fname[k] then Idx:=k;
  if fmt='MBWR' then ExtractMBWR(Idx) else
  if fmt='BIGF' then ExtractBIGF(Idx) else
  if fmt='VIV' then ExtractBIGF(Idx) else
  if (fmt='MBTR')or(fmt='NICE2') then ExtractMBTR(Idx);
end;
end;

procedure TForm1.ExtractMBWR(Idx:integer);            //Export one
var h,i,k:integer; orig:array[1..8] of byte; //Flags
begin
//memo1.Lines.Add(fname[Idx]+' - ID'+inttostr(Idx));
Reset(f,1); seek(f,objstart[Idx]);
assignfile(fout,fname[Idx]); rewrite(fout,1);
if CBWriteLog.Checked then begin
assignfile(flog,fname[Idx]+'.log');
ReWrite(flog);
if uppercase(arname)='SLK.SYN' then writeln(flog,'Reverse offset order in SLK.SYN !!!');
end;
glob:=0; addv:=0;

repeat
blockread(f,c,1);
x:=ord(c[1]);  //Compressed or not, bits
if x>=128 then begin x:=x-128; orig[8]:=1; end else orig[8]:=2;  //2 means 0
if x>=64 then begin x:=x-64; orig[7]:=1; end else orig[7]:=2;    //1-Take that
if x>=32 then begin x:=x-32; orig[6]:=1; end else orig[6]:=2;    //2-Take from behind
if x>=16 then begin x:=x-16; orig[5]:=1; end else orig[5]:=2;
if x>=8 then begin x:=x-8; orig[4]:=1; end else orig[4]:=2;
if x>=4 then begin x:=x-4; orig[3]:=1; end else orig[3]:=2;
if x>=2 then begin x:=x-2; orig[2]:=1; end else orig[2]:=2;
if x>=1 then begin x:=x-1; orig[1]:=1; end else orig[1]:=2;
ToRead:=orig[8]+orig[7]+orig[6]+orig[5]+orig[4]+orig[3]+orig[2]+orig[1];
blockread(f,c,ToRead,NumRead);

i:=0; k:=0;
repeat inc(i); inc(k);
if orig[i]=1 then begin inc(glob); d[glob]:=c[k]; end
else begin
Dist:=ord(c[k]); Leng:=ord(c[k+1]);   //1byte + 4bits from 2nd byte  Length is only last 4bits+3
if uppercase(arname)='SLK.SYN' then begin Dist:=ord(c[k+1]); Leng:=ord(c[k]); end; //special fix
if Leng>=128 then begin Leng:=Leng-128; Dist:=Dist+2048; end;
if Leng>=64  then begin Leng:=Leng-64;  Dist:=Dist+1024; end;
if Leng>=32  then begin Leng:=Leng-32;  Dist:=Dist+512;  end;
if Leng>=16  then begin Leng:=Leng-16;  Dist:=Dist+256;  end;
Leng:=Leng+3;

if CBWriteLog.Checked then writeln(flog,'Distance '{+inttostr(Dist mod 256)+'/'+inttostr(Dist div 256)+' Full - '}+inttostr(Dist));
if CBWriteLog.Checked then writeln(flog,'Length '+inttostr(Leng));
if Glob>(18+addv+4096) then addv:=addv+4096;

 for h:=1 to Leng do
 if Dist>=(glob-addv) then begin
 d[glob+h]:=d[18+h+Dist+addv-4096];
if (18+h+Dist+addv-4096)<=0 then //and((glob+h)<=objprop[Idx]) then begin
 d[glob+h]:=#32;
//memo1.Lines.Add(arname+' Check '+inttostr(glob+h)+' byte');
//if Dist>glob then
//i:=i;
//end
 end else
 d[glob+h]:=d[18+h+Dist+addv];

if CBWriteLog.Checked then begin
writeln(flog,'Fragment '+inttostr(i)+'/8');
writeln(flog,'Position '+inttostr(glob));
writeln(flog,'Recieved Data');
for h:=1 to Leng do write(flog,d[glob+h]);
writeln(flog,'');
writeln(flog,'');
end;
glob:=glob+Leng;
inc(k);  //Two bytes instead of one, as pointer(2) this_byte(1)
end;

until(i=8);
until(glob>=objprop[Idx]);
//for i:=1 to objprop[Idx] do
//blockwrite(fout,d[i],1,NumRead);
blockwrite(fout,d,objprop[Idx]);
closefile(fout);
if CBWriteLog.Checked then closefile(flog);
end;

procedure TForm1.ExtractMBTR(Idx:integer);     //Export all
var h,i,k,pass:integer; orig:array[1..8] of byte; //Flags
begin
if fmt='MBTR' then seek(f,objstart[Idx]) else if fmt='NICE2' then seek(f,objstart[Idx]+4);
assignfile(fout,fname[Idx]); rewrite(fout,1);
//assignfile(flog,'log.log'); rewrite(flog);
glob:=0; addv:=0; pass:=0;
repeat
blockread(f,c,1);
x:=ord(c[1]);  //Compressed or not, bits
if x>=128then begin x:=x-128;orig[1]:=1; end else orig[1]:=2;  //2 means 0
if x>=64 then begin x:=x-64; orig[2]:=1; end else orig[2]:=2;    //1-Take that
if x>=32 then begin x:=x-32; orig[3]:=1; end else orig[3]:=2;    //2-Take from behind
if x>=16 then begin x:=x-16; orig[4]:=1; end else orig[4]:=2;
if x>=8  then begin x:=x-8;  orig[5]:=1; end else orig[5]:=2;
if x>=4  then begin x:=x-4;  orig[6]:=1; end else orig[6]:=2;
if x>=2  then begin x:=x-2;  orig[7]:=1; end else orig[7]:=2;
if x>=1  then begin x:=x-1;  orig[8]:=1; end else orig[8]:=2;
ToRead:=orig[8]+orig[7]+orig[6]+orig[5]+orig[4]+orig[3]+orig[2]+orig[1];
blockread(f,c,ToRead,NumRead); inc(pass);
//if ToRead<>NumRead then
//s:=s;
i:=0; k:=0;
repeat inc(i); inc(k);
if pass<objlength[Idx] then
if orig[i]=1 then begin inc(pass); inc(glob); d[glob]:=c[k]; end
else begin inc(pass);
Leng:=ord(c[k]); Dist:=ord(c[k+1]);    //1byte +
Dist:=Dist+256*(Leng div 16);          // 4bits from 2nd byte
Leng:=(Leng mod 16)+3;                 //Length is only last 4bits+3
//writeln(flog,'Distance '+inttostr(Dist));
//writeln(flog,'Length '+inttostr(Leng-3)+'+3');
for h:=1 to Leng do d[glob+h]:=d[glob-Dist+h];
//writeln(flog,'Fragment '+inttostr(i)+'/8');
//writeln(flog,'Position '+inttostr(glob));
//writeln(flog,'Recieved Data');
//for h:=1 to Leng do write(flog,d[glob+h]);
//writeln(flog,'');
//writeln(flog,'');
glob:=glob+Leng;
inc(k);  //Two bytes instead of one, as pointer(2) this_byte(1)
inc(pass);
end;
until((i=8)or(pass>=objlength[Idx]));
until((pass>=objlength[Idx])or(NumRead<ToRead));
blockwrite(fout,d,glob);
closefile(fout);
//closefile(flog);
end;


procedure TForm1.ExtractAll(Sender: TObject);     //Export all
begin
ListBox1.SelectAll;
ExtractSelected(Form1);
end;

procedure TForm1.ExtractBIGF(Idx:integer);
var i:integer;
begin
Reset(f,1);
seek(f,objstart[Idx]);
  assignfile(fout,fname[Idx]); rewrite(fout,1);
     for i:=1 to (objlength[Idx]div 4096) do begin
        blockread(f,c,4096);
        blockwrite(fout,c,4096);
     end;
        blockread(f,c,objlength[Idx]mod 4096);
        blockwrite(fout,c,objlength[Idx]mod 4096);
  closefile(fout);
memo1.Lines.Add(fname[Idx]+' - Extracted');
end;

procedure TForm1.Keup(Sender: TObject; var Key: Word; Shift: TShiftState);
var i,k,Idx,size1,size2,count:integer; selname:string;
begin
if ListBox1.ItemIndex=-1 then exit;
count:=0; size1:=0; size2:=0;
if ListBox1.SelCount=1 then begin
  selname:=ListBox1.Items[ListBox1.ItemIndex];
  for k:=1 to ListBox1.Count do if selname=fname[k] then Idx:=k;
  GroupBox1.Caption:='  '+fname[Idx]+'  ';
  size1:=objlength[Idx]; size2:=objprop[Idx];
  Label7b.Caption:=inttostr(Idx)+'/'+inttostr(qty); //ID
end else
  for k:=1 to ListBox1.Count do if ListBox1.Selected[k-1] then begin
  selname:=ListBox1.Items[k-1];
  for i:=1 to ListBox1.Count do if selname=fname[i] then Idx:=i;
  inc(count);
  inc(size1,objlength[Idx]);
  inc(size2,objprop[Idx]);
  GroupBox1.Caption:='  '+inttostr(count)+' files selected'+'  ';
  Label7b.Caption:='--/'+inttostr(qty); //ID    
end;
Label5b.Caption:=inttostr(size1)+' Bytes'; //compressed
Label6b.Caption:=inttostr(size2)+' Bytes'; //decompressed
if size2<>0 then Label8b.Caption:=inttostr(round(size1/size2*100))+'%'; //ratio
end;

procedure TForm1.MouseDown(Sender: TObject; Button: TMouseButton;   //ShowInfo
  Shift: TShiftState; X, Y: Integer);
var k:integer; w:word;
begin
k:=ListBox1.ItemHeight; //if <> 13
if ListBox1.Items.Count>((Y div k)+ListBox1.TopIndex) then begin
ListBox1.Selected[(Y div k)+ListBox1.TopIndex]:=true;
w:=32; Keup(Form1,w,Shift);
if Button=mbRight then PopupMenu1.Popup(Form1.Left+ListBox1.Left+X+8,Form1.Top+ListBox1.Top+Y+26);
end;
end;

procedure TForm1.SetNICE2(Sender: TObject);
begin
if NiceCheck.Checked then
fmt:='NICE2' else fmt:='MBTR';
Label2.Caption:=arname+'  ('+fmt+')';
end;

procedure TForm1.EastEgg(Sender: TObject);
begin
Memo1.Visible:=not Memo1.Visible;
Label1.Visible:=not Label1.Visible;
tim:=0;
end;

procedure TForm1.Time(Sender: TObject);
begin
if Memo1.Visible=false then inc(tim);
if GroupBox1.Visible=false then inc(tim2);
if tim>=25 then begin Label1.Visible:=true; Memo1.Visible:=true; tim:=0; end;
if tim2>=25 then begin GroupBox1.Visible:=true; tim2:=0; end;
end;

procedure TForm1.EastEgg2(Sender: TObject);
begin
GroupBox1.Visible:=not GroupBox1.Visible;
tim2:=0;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
AboutForm.Show;
AboutForm.LTitle.Caption:='Multi-Extractor';
AboutForm.LVersi.Caption:='Version 0.8d';
AboutForm.LDescr.Caption:='Unpack Synetic (MBWR/NICE2/), CMR4 (BIG) and NFS (VIV) packages.';
end;

procedure TForm1.BrowseClick(Sender: TObject);
var fpath:string;
begin
fpath:=Edit1.Text;
SelectDirectory('Folder','',fpath);
Edit1.Text:=fpath;
end;

end.
