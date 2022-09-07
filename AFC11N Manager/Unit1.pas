unit Unit1;
interface
uses
  ShellApi, Windows, Messages, SysUtils, Classes, Controls, Graphics, ExtCtrls, Forms,
  StdCtrls, KromUtils, ComCtrls, CheckLst, Spin, FloatSpinEdit, Math, Dialogs, Buttons;

type
  TForm1 = class(TForm)
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Label2: TLabel;
    CLBProfiles: TCheckListBox;
    CBSimMissions: TCheckBox;
    CLBCars: TCheckListBox;
    Label3: TLabel;
    RGListing: TRadioGroup;
    CBSortCars: TCheckBox;
    SaveChanges: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    TrackBar1: TTrackBar;
    Image1: TImage;
    Shape1: TShape;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SaveDS(Sender: TObject);
    procedure SaveProfiles(Sender: TObject);
    procedure AddTracksToDS(Sender: TObject);
    procedure SearchAutos(Sender: TObject);
    procedure SearchProfiles(Sender: TObject);
    procedure CLBClickCheck(Sender: TObject);
    procedure Info(Sender: TObject);
    procedure CBSimMissionsClick(Sender: TObject);
    procedure PopulateCarList(Sender: TObject);
    procedure CBSortCarsClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CLBCarsDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure TrackBar1Change(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    procedure ReadINI;
    procedure WriteINI;
    procedure GetAutoInfo(s1:string;i1:integer);
    procedure GetProfileInfo(s1:string;i1:integer);
    procedure OpenDS(afilename:string);
  end;

const
  MaxCars = 256;

  PRESET_COLORS: array [1..15] of TColor = (
    $000000,$000080,$0000D0,$0060C0,$00B0D0,
    $0080F0,$D0D0D0,$404040,$405000,$006000,
    $600000,$A05050,$602060,$909090,$808080);

var
  Form1: TForm1;
  f:file;
  ft:textfile;
  c:array[1..1024000]of AnsiChar;
  i,j,k,m,h:integer;
  s:string;
  RootDir:string;
  TimeCode:integer;
  zz:string='     '{;//}+'                                                                                        ';

////////////////////////////////////////////////////////////////////////////////
  Header:array[1..33]of char;
  DSqty:integer;

  TB:array of record
  Entries:integer; //VA_Entries
  Index:integer;   //VA_Index
  iC:byte;         //VA_iC ?
  Lib:string;      //VA_Lib
  Cond:byte;       //Cond switch
  CondText:array of string; //Cond text
  end;

  CO:array of array of record
  Entries:integer; //VA_Entries
  Index:integer;   //VA_Index
  Lib:string;      //VA_Lib
  iU:byte;         //VA_iU ?
  SM,ST,IC,SC:string;       //VA_database path, VA_ST, VA_IC, VA_SC
  end;

  Value:array of array of array of record
  Typ:byte; Int:integer; Rel:single; Str:string; end;
////////////////////////////////////////////////////////////////////////////////
  EC_DSqty:array[1..MaxCars]of integer;

  EC_TB:array[1..MaxCars,1..3] of record //2+1
  Entries,Index:integer;   //VA_Index
  Cond:byte;       //Cond switch
  CondText:array of string; //Cond text
  end;

  EC_CO:array[1..MaxCars,1..3,1..512] of record Entries,Index:integer; end;

  EC_Value:array[1..MaxCars,1..3,1..512] of array of record
  Typ:byte; Int:integer; Rel:single; Str:string; end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  ProfileQty:integer;
  Profile:array[1..32]of record
  Folder:string;
  Install:bool;
  end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//1..32 Profiles count
//1..32 DS count
//1..36 TB count
  P_:array[1..32]of record
  Header:array[1..33]of char;
  DSqty:integer;

  TB:array[1..32] of record
  Entries:integer; //VA_Entries
  Index:integer;   //VA_Index
  iC:byte;         //VA_iC ?
  Lib:string;      //VA_Lib
  Cond:byte;       //Cond switch
  CondText:array of string; //Cond text
  end;

  CO:array[1..32,1..36] of record
  Entries:integer; //VA_Entries
  Index:integer;   //VA_Index
  Lib:string;      //VA_Lib
  iU:byte;         //VA_iU ?
  SM,ST,IC,SC:string;       //VA_database path, VA_ST, VA_IC, VA_SC
  end;

  Value:array[1..32,1..36] of array of record
  Typ:byte; Int:integer; Rel:single; Str:string; end;
  end;

////////////////////////////////////////////////////////////////////////////////
  AddonCarQty:integer;
  AddonCar:array[1..1024]of record
    Folder:string;
    Factory,Model,Name:string;
    Version:string;
    ColorID:integer;
    Install:boolean;
  end;

implementation
uses
  Unit2, WR_AboutBox;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form2.Show;
  Form2.Repaint;

  if FileExists('krom.dev') then
    ChDir('D:\Alarm for Cobra 11 - Nitro');

  RootDir := GetCurrentDir;
  if not fileexists('FrontEnd\Cobra11.ds') then
  begin
    Form2.FormStyle:=fsNormal;
    MessageBox(Form1.Handle,'"FrontEnd\Cobra11.ds" not found. Run AFC11NMan from AFC11 folder.','Error',MB_OK);
    Form2.Close;
    exit;
  end;
  if not FileExists('FrontEnd\Cobra11.bak') then CopyFile('FrontEnd\Cobra11.ds', 'FrontEnd\Cobra11.bak', True);
  if fileexists('FrontEnd\Cobra11.ds') then OpenDS('FrontEnd\Cobra11.ds');
  ElapsedTime(@TimeCode);
  Form2.Label2.Caption:='Scanning: Profiles ...'; Form2.Label2.Refresh; SearchProfiles(nil);
  Form2.Label2.Caption:='Scanning: Cars ...';     Form2.Label2.Refresh; SearchAutos(nil);
  //Form2.Memo1.Lines.Add('Autos - '+ElapsedTime(@TimeCode));
  if Form2.Showing then Form2.Destroy;
  PopulateCarList(nil);
  ReadINI;
end;

procedure TForm1.OpenDS(afilename:string);
begin
assignfile(f,afilename); FileMode:=0; reset(f,1); FileMode:=2;
blockread(f,Header,33);
DSqty:=ord(Header[9]);
setlength(TB,DSqty+1);
setlength(CO,DSqty+1);
setlength(Value,DSqty+1);
for i:=1 to DSqty do begin
blockread(f,c,33);
TB[i].Entries:=ord(c[9])+ord(c[10])*256;
TB[i].Index:=ord(c[17])+ord(c[18])*256;
TB[i].iC:=ord(c[25]);
j:=ord(c[30]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
TB[i].Lib:=s;
setlength(CO[i],TB[i].Entries+1);
setlength(Value[i],TB[i].Entries+1);

for k:=1 to TB[i].Entries do begin
blockread(f,c,4);
if c[1]+c[2]+c[3]+c[4]<>'NDCO' then begin
blockread(f,c,4);
TB[i].Cond:=int2(c[1],c[2]);
setlength(TB[i].CondText,TB[i].Cond+1);
  for j:=1 to TB[i].Cond do begin
  blockread(f,c,4);
  h:=int2(c[1],c[2]); //length of entry
  blockread(f,c,h+1);
  for m:=1 to h do TB[i].CondText[j]:=TB[i].CondText[j]+c[m];
  end;
blockread(f,c,4); //read upcoming NDCO
end;

blockread(f,c,24);                      //VAEn, VAId, VALb
CO[i,k].Entries:=ord(c[5])+ord(c[6])*256;
CO[i,k].Index:=ord(c[13])+ord(c[14])*256;
j:=ord(c[21]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
CO[i,k].Lib:=s;

blockread(f,c,13);                      //VASM
CO[i,k].iU:=ord(c[5]);
j:=ord(c[10]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
CO[i,k].SM:=s;

blockread(f,c,8);                       //VAST
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
CO[i,k].ST:=s;

blockread(f,c,8);                       //VAIC
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
CO[i,k].IC:=s;

blockread(f,c,8);                       //VASC
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
CO[i,k].SC:=s;

setlength(Value[i,k],CO[i,k].Entries+1);//stupid way to avoid common length
for j:=1 to CO[i,k].Entries do begin      //mismatches when adding new stuff
Value[i,k,j].Typ:=0;
Value[i,k,j].Int:=0;
Value[i,k,j].Rel:=0;
Value[i,k,j].Str:='';
blockread(f,c,1);
if c[1]=#1  then begin Value[i,k,j].Typ:=1; blockread(f,Value[i,k,j].Int,4); end;
if c[1]=#2  then begin Value[i,k,j].Typ:=2; blockread(f,Value[i,k,j].Rel,4); end;
if c[1]=#4  then begin Value[i,k,j].Typ:=4; blockread(f,c,4); end; //Prevents Editcar from reding ds file
if c[1]=#16 then begin Value[i,k,j].Typ:=3; Value[i,k,j].Str:=''; blockread(f,h,4);
                       if h<>0 then begin blockread(f,c,h+1);
                       Value[i,k,j].Str:=PAnsiChar(@c); end; end;
if Value[i,k,j].Typ=0 then
exit;

end;//CO.Entries
end;//TB.Entries
end; //1..DSqty
closefile(f);
end;

procedure TForm1.SaveDS(Sender: TObject);
begin
AddTracksToDS(nil);
ChDir(RootDir);
assignfile(f,'FrontEnd\Cobra11.ds'); rewrite(f,1); c[1]:=#0;

blockwrite(f,Header,33); //assume DSQty didn't changed
for i:=1 to DSqty do begin
s:='NDTBVAEn'+chr2(TB[i].Entries,4)+'VAId'+chr2(TB[i].Index,4)+'VAiC'+chr(TB[i].iC)+
'VALb'+chr2(length(TB[i].Lib),4)+TB[i].Lib+#0;
if TB[i].Cond>0 then s:=s+'Cond'+chr2(TB[i].Cond,4);
for j:=1 to TB[i].Cond do s:=s+chr2(length(TB[i].CondText[j]),4)+TB[i].CondText[j]+#0;
blockwrite(f,s[1],length(s));

    for k:=1 to TB[i].Entries do begin
    s:='NDCOVAEn'+chr2(CO[i,k].Entries,4)+'VAId'+chr2(CO[i,k].Index,4)
    +'VALb'+chr2(length(CO[i,k].Lib),4)+CO[i,k].Lib+#0
    +'VAiU'+chr(CO[i,k].iU)
        +'VASM'+chr2(length(CO[i,k].SM),4);
    if CO[i,k].SM<>'' then s:=s+CO[i,k].SM+#0;
    s:=s+'VAST'+chr2(length(CO[i,k].ST),4);
    if CO[i,k].ST<>'' then s:=s+CO[i,k].ST+#0;
    s:=s+'VAIC'+chr2(length(CO[i,k].IC),4);
    if CO[i,k].IC<>'' then s:=s+CO[i,k].IC+#0;
    s:=s+'VASC'+chr2(length(CO[i,k].SC),4);
    if CO[i,k].SC<>'' then s:=s+CO[i,k].SC+#0;
    blockwrite(f,s[1],length(s));

        for j:=1 to CO[i,k].Entries do begin

          case Value[i,k,j].Typ of
          1:      s:=#1+chr2(Value[i,k,j].Int,4);
          2:      s:=#2+unreal2(Value[i,k,j].Rel);
          3:begin s:=#16+chr2(length(Value[i,k,j].Str),4);
          if Value[i,k,j].Str<>'' then s:=s+Value[i,k,j].Str+#0; end;
          else    s:=#4+#0+#0+#0+#0; //this way EditCar tool won't be able to load this file
          end;                       //since it can handle only 1,2,16 types and will drop I/O Error

        blockwrite(f,s[1],length(s));
        end;//CO.Entries

    end;//TB.Entries

end; //1..DSqty
closefile(f);

if DirectoryExists('C11-Saves') then SaveProfiles(nil);
WriteINI;
end;

procedure TForm1.SaveProfiles(Sender: TObject);
var s1,s2:string; ID,h:integer;
begin
for ID:=1 to ProfileQty do if Profile[ID].Install then begin

  for k:=1 to 3 do P_[ID].CO[13,k].Entries:=24; //base number of C11 cars
  for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
      for k:=1 to 3 do begin
      inc(P_[ID].CO[13,k].Entries);
      setlength(P_[ID].Value[13,k],P_[ID].CO[13,k].Entries+1);
      end;
    k:=P_[ID].CO[13,1].Entries; //last one
    P_[ID].Value[13,1,k].Typ:=1; P_[ID].Value[13,1,k].Int:=1; //ReleaseFlag
    P_[ID].Value[13,2,k].Typ:=1; P_[ID].Value[13,2,k].Int:=0; //NumDrives
    P_[ID].Value[13,3,k].Typ:=2; P_[ID].Value[13,3,k].Int:=0; //kmDist
  end;

  for k:=1 to 15 do P_[ID].CO[15,k].Entries:=24; //base number of C11 cars

  for i:=1 to AddonCarQty do if AddonCar[i].Install then begin

    for k:=1 to 15 do begin
    inc(P_[ID].CO[15,k].Entries); h:=P_[ID].CO[15,k].Entries;
    setlength(P_[ID].Value[15,k],P_[ID].CO[15,k].Entries+1);
    P_[ID].Value[15,k,h].Typ:=P_[ID].Value[15,k,h-1].Typ;
    end;

  P_[ID].Value[15,1,h].Int:=AddonCar[i].ColorID;
  for k:=2 to 13 do P_[ID].Value[15,k,h].Int:=0;
  P_[ID].Value[15,14,h].Str:='';
  P_[ID].Value[15,15,h].Str:='';
  end;      

assignfile(f,RootDir+'\C11-Saves\'+profile[ID].Folder+'\Career.new'); rewrite(f,1);
c[1]:=#0;
blockwrite(f,P_[ID].Header,33); //assume DSQty didn't changed
for i:=1 to P_[ID].DSqty do begin
s:='NDTBVAEn'+chr2(P_[ID].TB[i].Entries,4)+'VAId'+chr2(P_[ID].TB[i].Index,4)+'VAiC'+chr(P_[ID].TB[i].iC)+
'VALb'+chr2(length(P_[ID].TB[i].Lib),4)+P_[ID].TB[i].Lib+#0;
if P_[ID].TB[i].Cond>0 then s:=s+'Cond'+chr2(P_[ID].TB[i].Cond,4);
for j:=1 to P_[ID].TB[i].Cond do s:=s+chr2(length(P_[ID].TB[i].CondText[j]),4)+P_[ID].TB[i].CondText[j]+#0;
blockwrite(f,s[1],length(s));

for k:=1 to P_[ID].TB[i].Entries do begin
s:='NDCOVAEn'+chr2(P_[ID].CO[i,k].Entries,4)+'VAId'+chr2(P_[ID].CO[i,k].Index,4)
+'VALb'+chr2(length(P_[ID].CO[i,k].Lib),4)+P_[ID].CO[i,k].Lib+#0
+'VAiU'+chr(P_[ID].CO[i,k].iU)
+'VASM'+chr2(length(P_[ID].CO[i,k].SM),4);
if P_[ID].CO[i,k].SM<>'' then s:=s+P_[ID].CO[i,k].SM+#0;
s:=s+'VAST'+chr2(length(P_[ID].CO[i,k].ST),4);
if P_[ID].CO[i,k].ST<>'' then s:=s+P_[ID].CO[i,k].ST+#0;
s:=s+'VAIC'+chr2(length(P_[ID].CO[i,k].IC),4);
if P_[ID].CO[i,k].IC<>'' then s:=s+P_[ID].CO[i,k].IC+#0;
s:=s+'VASC'+chr2(length(P_[ID].CO[i,k].SC),4);
if P_[ID].CO[i,k].SC<>'' then s:=s+P_[ID].CO[i,k].SC+#0;
blockwrite(f,s[1],length(s));

for j:=1 to P_[ID].CO[i,k].Entries do begin
case P_[ID].Value[i,k,j].Typ of
1:      s:=#1+chr2(P_[ID].Value[i,k,j].Int,4);
2:      s:=#2+unreal2(P_[ID].Value[i,k,j].Rel);
3:begin s:=#16+chr2(length(P_[ID].Value[i,k,j].Str),4);
if P_[ID].Value[i,k,j].Str<>'' then s:=s+P_[ID].Value[i,k,j].Str+#0; end;
end;
blockwrite(f,s[1],length(s));

end;//CO.Entries
SaveChanges.Caption:=inttostr(i)+' '+inttostr(k);
end;//TB.Entries
end; //1..DSqty
closefile(f);

s:='.wrc '+datetostr(date)+' '+timetostr(time);
for k:=1 to length(s) do
if s[k]=':' then s[k]:='-';
s1:=RootDir+'\C11-Saves\'+profile[ID].Folder+'\Career.wrc';
s2:=RootDir+'\C11-Saves\'+profile[ID].Folder+'\Career'+s+'.bak';
RenameFile(s1,s2);
s1:=RootDir+'\C11-Saves\'+profile[ID].Folder+'\Career.new';
s2:=RootDir+'\C11-Saves\'+profile[ID].Folder+'\Career.wrc';
RenameFile(s1,s2);
end;
end;

procedure TForm1.AddTracksToDS(Sender: TObject);
var ID:integer;
begin
//CarsDB
for j:=1 to TB[24].Entries do if (j<>15)and(j<>41) then begin   //skip these TypLinks/TypRechts
CO[24,j].Entries:=24;                                          //reset original Qty
setlength(Value[24,j],CO[24,j].Entries+AddonCarQty+1);
for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
inc(CO[24,j].Entries);
Value[24,j,CO[24,j].Entries].Typ:=Value[24,j,CO[24,j].Entries-1].Typ;
end;
end;
//_3DCarsDB
for j:=1 to TB[30].Entries do begin CO[30,j].Entries:=24;
setlength(Value[30,j],CO[30,j].Entries+AddonCarQty+1);
for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
inc(CO[30,j].Entries);
Value[30,j,CO[30,j].Entries].Typ:=Value[30,j,CO[30,j].Entries-1].Typ;
end;
end;
//MotorenDB
for j:=1 to TB[39].Entries do if (j<>26) then begin CO[39,j].Entries:=11;
setlength(Value[39,j],CO[39,j].Entries+AddonCarQty+1);
for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
inc(CO[39,j].Entries);
Value[39,j,CO[39,j].Entries].Typ:=Value[39,j,CO[39,j].Entries-1].Typ;
end;
end;
//GetriebeDB
for j:=1 to TB[40].Entries do begin CO[40,j].Entries:=50;
setlength(Value[40,j],CO[40,j].Entries+AddonCarQty+1);
for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
inc(CO[40,j].Entries);
Value[40,j,CO[40,j].Entries].Typ:=Value[40,j,CO[40,j].Entries-1].Typ;
end;
end;
//ReifenDB
for j:=1 to TB[41].Entries do begin CO[41,j].Entries:=22;
setlength(Value[41,j],CO[41,j].Entries+AddonCarQty*2+1);
for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
inc(CO[41,j].Entries);
Value[41,j,CO[41,j].Entries].Typ:=Value[41,j,CO[41,j].Entries-1].Typ;
inc(CO[41,j].Entries);
Value[41,j,CO[41,j].Entries].Typ:=Value[41,j,CO[41,j].Entries-1].Typ;
end;
end;

ID:=24;
for i:=1 to AddonCarQty do if (AddonCar[i].Install)and(i<>15)and(i<>41) then begin
inc(ID);
Value[24,1,ID].Int:=ID-1;                               //Index
Value[24,2,ID].Int:=ID-1;                               //3D CarID
Value[24,3,ID].Str:=EC_Value[i,2,4,2].Str;                      //CarTextID
Value[24,4,ID].Int:=EC_Value[i,2,5,2].Int;                      //Score
Value[24,5,ID].Int:=EC_Value[i,2,6,2].Int;                      //
Value[24,6,ID].Int:=EC_Value[i,2,7,2].Int;                      //
Value[24,7,ID].Int:=EC_Value[i,2,8,2].Int;                      //
Value[24,8,ID].Int:=EC_Value[i,2,9,2].Int;                      //
Value[24,9,ID].Int:=EC_Value[i,2,10,2].Int;                     //
Value[24,10,ID].Int:=EC_Value[i,2,11,2].Int;                    //
Value[24,11,ID].Int:=(ID-13)-1;                    //MotorID
Value[24,12,ID].Int:=(ID+26)-1;                    //
Value[24,13,ID].Int:=(ID*2-27)-1;                    //
Value[24,14,ID].Int:=(ID*2-26)-1;                    //
//Value[24,15,ID].Int:=                                   //TypLinks
Value[24,16,ID].Int:=EC_Value[i,2,17,2].Int;                    //
Value[24,17,ID].Int:=EC_Value[i,2,18,2].Int;                    //
Value[24,18,ID].Rel:=EC_Value[i,2,19,2].Rel;                    //Ausfedern
Value[24,19,ID].Rel:=EC_Value[i,2,20,2].Rel;                    //
Value[24,20,ID].Rel:=EC_Value[i,2,21,2].Rel;                    //
Value[24,21,ID].Rel:=EC_Value[i,2,22,2].Rel;                    //
Value[24,22,ID].Int:=EC_Value[i,2,23,2].Int;                    //Drehimpulse
Value[24,23,ID].Rel:=EC_Value[i,2,24,2].Rel;                    //
Value[24,24,ID].Rel:=EC_Value[i,2,25,2].Rel;                    //
Value[24,25,ID].Rel:=EC_Value[i,2,26,2].Rel;                    //
Value[24,26,ID].Rel:=EC_Value[i,2,27,2].Rel;                    //
Value[24,27,ID].Int:=EC_Value[i,2,28,2].Int;                    //%
Value[24,28,ID].Rel:=EC_Value[i,2,29,2].Rel;                    //
Value[24,29,ID].Int:=EC_Value[i,2,30,2].Int;                    //Drehmomentfalkor
Value[24,30,ID].Int:=EC_Value[i,2,33,2].Int;                    //Weight_KG
Value[24,31,ID].Int:=EC_Value[i,2,37,2].Int;                    //Antrieb
Value[24,32,ID].Rel:=EC_Value[i,2,38,2].Rel;                    //Gesamt
Value[24,33,ID].Rel:=EC_Value[i,2,39,2].Rel;                    //Luftwider
Value[24,34,ID].Int:=EC_Value[i,2,40,2].Int;                    //
Value[24,35,ID].Int:=EC_Value[i,2,41,2].Int;                    //
Value[24,36,ID].Int:=EC_Value[i,2,42,2].Int;                    //
Value[24,37,ID].Int:=EC_Value[i,2,43,2].Int;                    //RaceClass
Value[24,38,ID].Rel:=EC_Value[i,2,44,2].Rel;                    //ReifenYPos
Value[24,39,ID].Rel:=EC_Value[i,2,45,2].Rel;                    //0-100
Value[24,40,ID].Int:=EC_Value[i,2,46,2].Int;                    //MphTopSpeed
//Value[24,41,ID].Int:=                                 //TypRechts - empty
Value[24,42,ID].Int:=EC_Value[i,2,48,2].Int;                    //
Value[24,43,ID].Int:=EC_Value[i,2,49,2].Int;                    //
Value[24,44,ID].Str:=EC_Value[i,2,105,2].Str;                    //
Value[24,45,ID].Str:=EC_Value[i,2,106,2].Str;                    //
if EC_TB[i,2].Entries<107 then Value[24,46,ID].Str:='kein' else  //Caravan
Value[24,46,ID].Str:=EC_Value[i,2,107,2].Str;                    //Caravan
Value[24,47,ID].Str:=EC_Value[i,1,23,2].Str;                    //ClassName

//
Value[30,1,ID].Int:=ID-1;
Value[30,2,ID].Str:=EC_Value[i,1,3,2].Str;                      //EngineName
Value[30,3,ID].Rel:=EC_Value[i,1,6,2].Rel;                    //
Value[30,4,ID].Rel:=EC_Value[i,1,7,2].Rel;                    //
Value[30,5,ID].Rel:=EC_Value[i,1,8,2].Rel;                    //
Value[30,6,ID].Rel:=EC_Value[i,1,9,2].Rel;                    //
Value[30,7,ID].Int:=EC_Value[i,1,10,2].Int;                    //
Value[30,8,ID].Int:=EC_Value[i,1,11,2].Int;                    //
Value[30,9,ID].Int:=EC_Value[i,1,12,2].Int;                    //
Value[30,10,ID].Rel:=EC_Value[i,1,16,2].Rel;                    //
Value[30,11,ID].Rel:=EC_Value[i,1,17,2].Rel;                    //
Value[30,12,ID].Rel:=EC_Value[i,1,18,2].Rel;                    //
Value[30,13,ID].Rel:=EC_Value[i,1,19,2].Rel;                    //
Value[30,14,ID].Rel:=EC_Value[i,1,20,2].Rel;                    //
Value[30,15,ID].Rel:=EC_Value[i,1,21,2].Rel;                    //
Value[30,16,ID].Int:=EC_Value[i,1,26,2].Int;                    //UserColorID
Value[30,17,ID].Rel:=EC_Value[i,1,27,2].Rel;                    //
Value[30,18,ID].Int:=EC_Value[i,1,28,2].Int;                    //FlagCabrio
Value[30,19,ID].Int:=0;                    //SplitUser
Value[30,20,ID].Int:=0;                    //
Value[30,21,ID].Int:=0;                    //
Value[30,22,ID].Int:=0;                    //
Value[30,23,ID].Int:=0;                    //
Value[30,24,ID].Int:=0;                    //
Value[30,25,ID].Int:=0;                    //
Value[30,26,ID].Int:=0;                    //
Value[30,27,ID].Int:=0;                    //
Value[30,28,ID].Int:=0;                    //
Value[30,29,ID].Int:=0;                    //
Value[30,30,ID].Int:=0;                    //
Value[30,31,ID].Rel:=EC_Value[i,1,44,2].Rel;                    //KopfXPos
Value[30,32,ID].Rel:=EC_Value[i,1,45,2].Rel;                    //
Value[30,33,ID].Rel:=EC_Value[i,1,46,2].Rel;                    //
Value[30,34,ID].Rel:=EC_Value[i,1,47,2].Rel;                    //
Value[30,35,ID].Rel:=EC_Value[i,1,48,2].Rel;                    //
Value[30,36,ID].Rel:=EC_Value[i,1,49,2].Rel;                    //
Value[30,37,ID].Rel:=EC_Value[i,1,50,2].Rel;                    //
Value[30,38,ID].Int:=EC_Value[i,1,54,2].Int;                    //Tacho1Modus
Value[30,39,ID].Rel:=EC_Value[i,1,55,2].Rel;                    //
Value[30,40,ID].Rel:=EC_Value[i,1,56,2].Rel;                    //
Value[30,41,ID].Rel:=EC_Value[i,1,57,2].Rel;                    //
Value[30,42,ID].Rel:=EC_Value[i,1,58,2].Rel;                    //
Value[30,43,ID].Rel:=EC_Value[i,1,59,2].Rel;                    //
Value[30,44,ID].Rel:=EC_Value[i,1,60,2].Rel;                    //
Value[30,45,ID].Rel:=EC_Value[i,1,61,2].Rel;                    //
Value[30,46,ID].Rel:=EC_Value[i,1,62,2].Rel;                    //
Value[30,47,ID].Rel:=EC_Value[i,1,63,2].Rel;                    //
Value[30,48,ID].Int:=EC_Value[i,1,64,2].Int;                    //Tacho2Modus
Value[30,49,ID].Rel:=EC_Value[i,1,65,2].Rel;                    //
Value[30,50,ID].Rel:=EC_Value[i,1,66,2].Rel;                    //
Value[30,51,ID].Rel:=EC_Value[i,1,67,2].Rel;                    //
Value[30,52,ID].Rel:=EC_Value[i,1,68,2].Rel;                    //
Value[30,53,ID].Rel:=EC_Value[i,1,69,2].Rel;                    //
Value[30,54,ID].Rel:=EC_Value[i,1,70,2].Rel;                    //
Value[30,55,ID].Rel:=EC_Value[i,1,71,2].Rel;                    //
Value[30,56,ID].Rel:=EC_Value[i,1,72,2].Rel;                    //
Value[30,57,ID].Rel:=EC_Value[i,1,73,2].Rel;                    //
Value[30,58,ID].Rel:=EC_Value[i,1,75,2].Rel;                    //MHaube
Value[30,59,ID].Rel:=EC_Value[i,1,76,2].Rel;    //
Value[30,60,ID].Str:='';                        //UserVinyl
Value[30,61,ID].Int:=0;                         //NumVinyls
Value[30,62,ID].Str:='';                        //UserRim
Value[30,63,ID].Str:='';                        //Marker
Value[30,64,ID].Int:=EC_Value[i,1,81,2].Int;    //ColorIndex
Value[30,65,ID].Int:=0;                         //DienstWagenFlag

//MotorenDB
Value[39,1,(ID-13)].Int:=(ID-13)-1;             //
Value[39,2,(ID-13)].Int:=EC_Value[i,2,50,2].Int;//
Value[39,3,(ID-13)].Rel:=EC_Value[i,2,51,2].Rel;//
Value[39,4,(ID-13)].Rel:=EC_Value[i,2,52,2].Rel;//
Value[39,5,(ID-13)].Rel:=EC_Value[i,2,53,2].Rel;//
Value[39,6,(ID-13)].Rel:=EC_Value[i,2,54,2].Rel;//
Value[39,7,(ID-13)].Rel:=EC_Value[i,2,55,2].Rel;//
Value[39,8,(ID-13)].Rel:=EC_Value[i,2,56,2].Rel;//
Value[39,9,(ID-13)].Rel:=EC_Value[i,2,57,2].Rel;//
Value[39,10,(ID-13)].Rel:=EC_Value[i,2,58,2].Rel;//
Value[39,11,(ID-13)].Rel:=EC_Value[i,2,59,2].Rel;//
Value[39,12,(ID-13)].Rel:=EC_Value[i,2,60,2].Rel;//
Value[39,13,(ID-13)].Rel:=EC_Value[i,2,61,2].Rel;//
Value[39,14,(ID-13)].Rel:=EC_Value[i,2,62,2].Rel;//
Value[39,15,(ID-13)].Rel:=EC_Value[i,2,63,2].Rel;//
Value[39,16,(ID-13)].Rel:=EC_Value[i,2,64,2].Rel;//
Value[39,17,(ID-13)].Rel:=EC_Value[i,2,65,2].Rel;//
Value[39,18,(ID-13)].Rel:=EC_Value[i,2,66,2].Rel;//
Value[39,19,(ID-13)].Rel:=EC_Value[i,2,67,2].Rel;//
Value[39,20,(ID-13)].Rel:=EC_Value[i,2,68,2].Rel;//
Value[39,21,(ID-13)].Rel:=EC_Value[i,2,69,2].Rel;//
Value[39,22,(ID-13)].Rel:=EC_Value[i,2,70,2].Rel;//
Value[39,23,(ID-13)].Rel:=EC_Value[i,2,71,2].Rel;//
Value[39,24,(ID-13)].Rel:=EC_Value[i,2,72,2].Rel;//NMStep
Value[39,25,(ID-13)].Int:=EC_Value[i,2,75,2].Int;//SampleRate
//Value[39,26,(ID-13)].Int:=EC_Value[i,2,76,2].Int;//MotorSample
Value[39,27,(ID-13)].Int:=EC_Value[i,2,77,2].Int;//
Value[39,28,(ID-13)].Int:=EC_Value[i,2,78,2].Int;//
Value[39,29,(ID-13)].Str:=EC_Value[i,2,79,2].Str;//
Value[39,30,(ID-13)].Str:=EC_Value[i,2,80,2].Str;//
Value[39,31,(ID-13)].Int:=EC_Value[i,2,81,2].Int;//
Value[39,32,(ID-13)].Str:=EC_Value[i,2,82,2].Str;//
Value[39,33,(ID-13)].Int:=EC_Value[i,2,84,2].Int;//Lautstaerke
Value[39,34,(ID-13)].Int:=EC_Value[i,2,101,2].Int;//
Value[39,35,(ID-13)].Int:=EC_Value[i,2,102,2].Int;//
Value[39,36,(ID-13)].Int:=EC_Value[i,2,103,2].Int;//
Value[39,37,(ID-13)].Int:=EC_Value[i,2,104,2].Int;//
Value[39,38,(ID-13)].Int:=EC_Value[i,2,100,2].Int;//Drehzahlmesser

//GearboxID
Value[40,1,(ID+26)].Int:=(ID+26)-1;//
Value[40,2,(ID+26)].Int:=EC_Value[i,2,85,2].Int;//
Value[40,3,(ID+26)].Rel:=EC_Value[i,2,86,2].Rel;//1
Value[40,4,(ID+26)].Rel:=EC_Value[i,2,87,2].Rel;//2
Value[40,5,(ID+26)].Rel:=EC_Value[i,2,88,2].Rel;//3
Value[40,6,(ID+26)].Rel:=EC_Value[i,2,89,2].Rel;//4
Value[40,7,(ID+26)].Rel:=EC_Value[i,2,90,2].Rel;//5
Value[40,8,(ID+26)].Rel:=EC_Value[i,2,91,2].Rel;//6
Value[40,9,(ID+26)].Rel:=EC_Value[i,2,92,2].Rel;//7
Value[40,10,(ID+26)].Rel:=EC_Value[i,2,93,2].Rel;//RW

//Tires
for j:=0 to 1 do begin
Value[41,1,(ID*2+j-27)].Int:=(ID*2+j-27)-1;//
Value[41,2,(ID*2+j-27)].Rel:=EC_Value[i,2,94+j*3,2].Rel;//
Value[41,3,(ID*2+j-27)].Rel:=EC_Value[i,2,95+j*3,2].Rel;//
Value[41,4,(ID*2+j-27)].Rel:=EC_Value[i,2,96+j*3,2].Rel;//
end;

end;
Value[16,9,9].Typ:=4; //Prevent Editcar from loading the cobra11.ds
Value[40,7,7].Typ:=4; //Prevent Editcar from loading the cobra11.ds
end;

procedure TForm1.SearchProfiles(Sender: TObject);
var SearchRec:TSearchRec; ii:integer;
begin
ChDir(RootDir);
if not DirectoryExists('C11-Saves') then begin
Form2.FormStyle:=fsNormal;
MessageBox(Form1.Handle,'"C11-Saves\" not found','Warning',MB_OK);
Form2.FormStyle:=fsStayOnTop;
exit;
end;
ChDir('C11-Saves');
FindFirst('*', faAnyFile or faDirectory, SearchRec);
h:=1;
repeat
if (SearchRec.Attr and faDirectory<>0)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then
if fileexists(RootDir+'\C11-Saves\'+SearchRec.Name+'\career.wrc') then begin
Profile[h].Folder:=SearchRec.Name;
inc(h); end;
until (FindNext(SearchRec)<>0);
FindClose(SearchRec);
ProfileQty:=h-1;
for ii:=1 to ProfileQty do begin
GetProfileInfo(Profile[ii].Folder,ii);
CLBProfiles.AddItem(Profile[ii].Folder,nil);
end;
end;

procedure TForm1.GetProfileInfo(s1:string;i1:integer);
var NumRead,Pos:integer;
begin
assignfile(f,RootDir+'\C11-Saves\'+s1+'\career.wrc'); FileMode:=0; reset(f,1); FileMode:=2;
blockread(f,P_[i1].Header,33);
P_[i1].DSqty:=ord(P_[i1].Header[9]);
for i:=1 to P_[i1].DSqty do begin
blockread(f,c,33);
P_[i1].TB[i].Entries:=ord(c[9])+ord(c[10])*256;
P_[i1].TB[i].Index:=ord(c[17])+ord(c[18])*256;
P_[i1].TB[i].iC:=ord(c[25]);
j:=ord(c[30]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
P_[i1].TB[i].Lib:=s;

for k:=1 to P_[i1].TB[i].Entries do begin
blockread(f,c,4);
if c[1]+c[2]+c[3]+c[4]<>'NDCO' then begin
blockread(f,c,4);
P_[i1].TB[i].Cond:=int2(c[1],c[2]);
setlength(P_[i1].TB[i].CondText,P_[i1].TB[i].Cond+1);
  for j:=1 to P_[i1].TB[i].Cond do begin
  blockread(f,c,4);
  h:=int2(c[1],c[2]); //length of entry
  blockread(f,c,h+1);
  for m:=1 to h do P_[i1].TB[i].CondText[j]:=P_[i1].TB[i].CondText[j]+c[m];
  end;
blockread(f,c,4); //read upcoming NDCO
end;

blockread(f,c,24);                      //VAEn, VAId, VALb
P_[i1].CO[i,k].Entries:=ord(c[5])+ord(c[6])*256;
P_[i1].CO[i,k].Index:=ord(c[13])+ord(c[14])*256;
j:=ord(c[21]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
P_[i1].CO[i,k].Lib:=s;

blockread(f,c,13);                      //VASM
P_[i1].CO[i,k].iU:=ord(c[5]);
j:=ord(c[10]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
P_[i1].CO[i,k].SM:=s;

blockread(f,c,8);                       //VAST
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
P_[i1].CO[i,k].ST:=s;

blockread(f,c,8);                       //VAIC
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
P_[i1].CO[i,k].IC:=s;

blockread(f,c,8);                       //VASC
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
P_[i1].CO[i,k].SC:=s;

setlength(P_[i1].Value[i,k],P_[i1].CO[i,k].Entries+1);//stupid way to avoid common length
for j:=1 to P_[i1].CO[i,k].Entries do begin      //mismatches when adding new stuff
P_[i1].Value[i,k,j].Typ:=0;
P_[i1].Value[i,k,j].Int:=0;
P_[i1].Value[i,k,j].Rel:=0;
P_[i1].Value[i,k,j].Str:='';
blockread(f,c,1);
if c[1]=#1  then begin P_[i1].Value[i,k,j].Typ:=1; blockread(f,P_[i1].Value[i,k,j].Int,4); end;
if c[1]=#2  then begin P_[i1].Value[i,k,j].Typ:=2; blockread(f,P_[i1].Value[i,k,j].Rel,4); end;
if c[1]=#16 then begin P_[i1].Value[i,k,j].Typ:=3; blockread(f,h,4); if h<>0 then begin blockread(f,c,h+1);
                       P_[i1].Value[i,k,j].Str:=PAnsiChar(@c); end; end;
if P_[i1].Value[i,k,j].Typ=0 then exit;

end;//CO.Entries
end;//TB.Entries
end; //1..DSqty
closefile(f);
end;

procedure TForm1.SearchAutos(Sender: TObject);
var SearchRec:TSearchRec; ii:integer;
begin
ChDir(RootDir); AddonCarQty:=0;
if not DirectoryExists('Autos') then begin
Form2.FormStyle:=fsNormal;
MessageBox(Form1.Handle,'"Autos\" not found','Warning',MB_OK);
Form2.FormStyle:=fsStayOnTop;
exit;
end else begin
ChDir('Autos');
  FindFirst('*', faAnyFile or faDirectory, SearchRec);
  h:=1;
  repeat
  if (SearchRec.Attr and faDirectory<>0)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then
  if fileexists(RootDir+'\Autos\'+SearchRec.Name+'\EditCar.car') then begin
  AddonCar[h].Folder:=SearchRec.Name;
  inc(h); end;
  until (FindNext(SearchRec)<>0);
  FindClose(SearchRec);
  AddonCarQty:=h-1;
end;

Form2.Label3.Visible:=true;
for ii:=1 to AddonCarQty do begin //don't use (i) here
Form2.Label3.Caption:=inttostr(ii)+'/'+inttostr(AddonCarQty)+' ('+AddonCar[ii].Folder+')'; Form2.Label3.Repaint;
GetAutoInfo(AddonCar[ii].Folder,ii);
end;

Form2.Label3.Visible:=false;
end;

procedure TForm1.GetAutoInfo(s1:string;i1:integer);
var NumRead,Pos:integer;
begin
AddonCar[i1].Version:='WR2';
Pos:=0; //reset to 0
assignfile(f,RootDir+'\Autos\'+s1+'\EditCar.car'); FileMode:=0; reset(f,128); FileMode:=2;
blockread(f,c,1000,NumRead); closefile(f); //reading 128kbytes should be enough (usually ~30kb)
EC_DSqty[i1]:=ord(c[Pos+9]);
inc(Pos,33);
for i:=1 to EC_DSqty[i1] do begin
EC_TB[i1,i].Entries:=ord(c[Pos+9])+ord(c[Pos+10])*256;
if ord(c[Pos+30])<>0 then inc(Pos,ord(c[Pos+30])+1);//blockread(f,c,ord(c[30])+1);
inc(Pos,33);

for k:=1 to EC_TB[i1,i].Entries do begin
if (c[Pos+1]+c[Pos+2]+c[Pos+3]+c[Pos+4])<>'NDCO' then begin
inc(Pos,4);
EC_TB[i1,i].Cond:=int2(c[Pos+1],c[Pos+2]);
inc(Pos,4);
setlength(EC_TB[i1,i].CondText,EC_TB[i1,i].Cond+1);
  for j:=1 to EC_TB[i1,i].Cond do begin
  inc(Pos,int2(c[Pos+1],c[Pos+2])+1);  //reading upside-down
  inc(Pos,4);
  for m:=1 to h do EC_TB[i1,i].CondText[j]:=EC_TB[i1,i].CondText[j]+c[m];
  end;
//read upcoming NDCO
//inc(Pos,4);
end;
inc(Pos,4);
//VAEn, VAId, VALb
EC_CO[i1,i,k].Entries:=ord(c[Pos+5])+ord(c[Pos+6])*256;
j:=ord(c[Pos+21]); inc(Pos,24); if j<>0 then inc(Pos,j+1);//VAEn, VAId, VALb
j:=ord(c[Pos+10]); inc(Pos,13); if j<>0 then inc(Pos,j+1);//VASM
j:=ord(c[Pos+5]);  inc(Pos, 8); if j<>0 then inc(Pos,j+1);//VAST
j:=ord(c[Pos+5]);  inc(Pos, 8); if j<>0 then inc(Pos,j+1);//VAIC
j:=ord(c[Pos+5]);  inc(Pos, 8); if j<>0 then inc(Pos,j+1);//VASC

setlength(EC_Value[i1,i,k],EC_CO[i1,i,k].Entries+1);//optimistic way to avoid common length mismatches
for j:=1 to EC_CO[i1,i,k].Entries do begin
if j>2 then AddonCar[i1].Version:='MBWR';
EC_Value[i1,i,k,j].Typ:=0; EC_Value[i1,i,k,j].Int:=0; EC_Value[i1,i,k,j].Rel:=0; EC_Value[i1,i,k,j].Str:='';
if c[Pos+1]=#1  then begin
            EC_Value[i1,i,k,j].Typ:=1; EC_Value[i1,i,k,j].Int:=int2(c[Pos+2],c[Pos+3],c[Pos+4],c[Pos+5]); inc(Pos,5); end;
if c[Pos+1]=#2  then begin
            EC_Value[i1,i,k,j].Typ:=2; EC_Value[i1,i,k,j].Rel:=real2(c[Pos+2],c[Pos+3],c[Pos+4],c[Pos+5]); inc(Pos,5); end;
if c[Pos+1]=#16 then begin
            EC_Value[i1,i,k,j].Typ:=3; h:=int2(c[Pos+2],c[Pos+3],c[Pos+4],c[Pos+5]); inc(Pos,5);
            for m:=1 to h do EC_Value[i1,i,k,j].Str:=EC_Value[i1,i,k,j].Str+c[Pos+m];
            if h<>0 then inc(Pos,h+1); end;
if EC_Value[i1,i,k,j].Typ=0 then Form1.Close;
end;//CO.Entries
end;//TB.Entries
end; //1..DSqty

if length(EC_Value[i1,2,105])>=2 then //fix for old editcars with few fields
AddonCar[i1].Factory:=EC_Value[i1,2,105,2].Str
else AddonCar[i1].Factory:='';
AddonCar[i1].Model:=EC_Value[i1,2,4,2].Str;
AddonCar[i1].ColorID:=EC_Value[i1,1,81,2].Int;
end;

procedure TForm1.CLBClickCheck(Sender: TObject);
var I: Integer;
begin
  for I:=1 to CLBProfiles.Count do Profile[I].Install:=CLBProfiles.Checked[I-1];
  for I:=1 to CLBCars.Count do AddonCar[I].Install:=CLBCars.Checked[I-1];

  if CLBCars.ItemIndex>=0 then
    TrackBar1.Position:=AddonCar[CLBCars.ItemIndex+1].ColorID;
end;


procedure TForm1.Info(Sender: TObject);
begin
  AboutForm.Show('AFC11N Manager', 'Version 0.1c (08 Sep 2007)', 'Manages AFC11 addons.','AFC11NMAN' );
end;


procedure TForm1.WriteINI;
begin
  chdir(RootDir);
  assignfile(ft,'C11Man.ini'); rewrite(ft);
  writeln(ft,'C11 Manager INI file');

  writeln(ft);
  writeln(ft,'Profiles:');
  for i:=1 to ProfileQty do
    if Profile[i].Install then
      writeln(ft,Profile[i].Folder);

  writeln(ft);
  writeln(ft,'Cars:');
  for i:=1 to AddOnCarQty do
  if AddonCar[i].Install then begin
    writeln(ft,AddonCar[i].Folder);
    writeln(ft,AddonCar[i].ColorID);
  end;

  writeln(ft);
  writeln(ft,'DrivingMode:');
  if CBSimMissions.Checked then
    writeln(ft,'Sim') else writeln(ft,'Arcade');

  writeln(ft);
  writeln(ft,'ListingMode:');
  writeln(ft,inttostr(RGListing.ItemIndex));

  closefile(ft);
end;


procedure TForm1.CBSimMissionsClick(Sender: TObject);
begin
  for i:=2 to 30 do if CBSimMissions.Checked then
    Value[49,30,i].Int:=0 else Value[49,30,i].Int:=100; //Missions Arcade / Simulation
end;

procedure TForm1.ReadINI;
var
  i,col:integer;
  st:AnsiString;
begin
  chdir(RootDir);
  if not fileexists('C11Man.ini') then exit;
  assignfile(ft,'C11Man.ini'); reset(ft);
  readln(ft); readln(ft);

  repeat
    readln(ft,s);

    if s='Profiles:' then
    repeat readln(ft,s);
    for i:=0 to CLBProfiles.Count-1 do
    if CLBProfiles.Items[i]=s then //List entries are same as corresponding folder names
    CLBProfiles.Checked[i]:=true;
    until(s='');

    if s='Cars:' then
    repeat
      readln(ft,s);
      if s<>'' then readln(ft,col);
      for i:=0 to CLBCars.Count-1 do
      begin
        st:=CLBCars.Items[i];
        decs(st,-length(st)+3);
        if AddonCar[strtoint(st)].Folder=s then
        begin
          CLBCars.Checked[i]:=true;
          AddonCar[strtoint(st)].ColorID:=col;
        end;
      end;
    until(s='');

    if s='DrivingMode:' then
    begin
      readln(ft,s);
      if s='Sim' then CBSimMissions.Checked:=true;
    end;

    if s='ListingMode:' then
    begin
      readln(ft,s);
      RGListing.ItemIndex:=EnsureRange(strtoint(s),0,RGListing.Items.Count-1);
    end;

  until(eof(ft));
  closefile(ft);
  CLBClickCheck(nil);
end;


procedure TForm1.PopulateCarList(Sender: TObject);
var i:integer;
begin
  for i:=1 to AddonCarQty do
    if RGListing.Items[RGListing.ItemIndex]='Folders' then
      CLBCars.AddItem(AddonCar[i].Folder+zz+int2fix(i,3),nil);

  CLBCars.Refresh;
end;


procedure TForm1.CBSortCarsClick(Sender: TObject);
begin
  CLBCars.Sorted:=CBSortCars.Checked;
end;


procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  SaveChanges.Click();
  Form1.Close;
  ChDir(RootDir);
  ShellExecute(handle, 'open', 'C11_PC.exe', nil, nil, SW_SHOWNORMAL);
end;


procedure TForm1.CLBCarsDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  CLBCars.Canvas.TextOut(Rect.Left+22,Rect.Top,CLBCars.Items[Index]);
  CLBCars.Canvas.Brush.Color:=PRESET_COLORS[AddonCar[Index+1].ColorID];
  CLBCars.Canvas.TextOut(Rect.Left+2,Rect.Top,'      ');
end;


procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  if CLBCars.ItemIndex<0 then exit;
  AddonCar[CLBCars.ItemIndex+1].ColorID:=TrackBar1.Position;
  Shape1.Brush.Color:=PRESET_COLORS[AddonCar[CLBCars.ItemIndex+1].ColorID]; //coloring solution
  CLBCars.Repaint;
end;


procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Image1MouseUp(Sender, Button, Shift, X, Y);
end;


procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Col:byte;
begin
  Col:=X div (Image1.Width div 15) + 1;
  TrackBar1.Position:=Col;
end;


end.

