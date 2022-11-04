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
    CLBCars: TCheckListBox;
    Label3: TLabel;
    SaveChanges: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    TrackBar1: TTrackBar;
    Image1: TImage;
    Shape1: TShape;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure OpenDS(Sender: TObject; filename:string);
    procedure SaveDS(Sender: TObject);
    procedure SaveProfiles(Sender: TObject);
    procedure AddTracksToDS(Sender: TObject);
    procedure SearchAutos(Sender: TObject);
    procedure SearchProfiles(Sender: TObject);
    procedure GetProfileInfo(s1:string;i1:integer);
    procedure GetAutoInfo(s1:string;i1:integer);
    procedure CLBClickCheck(Sender: TObject);
    procedure Info(Sender: TObject);
    procedure WriteINI(Sender: TObject);
    procedure CBSimMissionsClick(Sender: TObject);
    procedure ReadINI(Sender: TObject);
    procedure PopulateCarList(Sender: TObject);
    procedure CBSortCarsClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CLBCarsDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure TrackBar1Change(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BitBtn3Click(Sender: TObject);
  end;

const
 StockCars=55;
 MaxCars=256;

var
  Form1: TForm1;
  f:file;
  ft:textfile;
  c: array [1..1024000]of char;
  i,j,k,m,h:integer;
  s:string;
  RootDir:string;
  TimeCode:integer;
  zz:string='     '{;//}+'                                                                                        ';

////////////////////////////////////////////////////////////////////////////////
  Header: array [1..33]of char;
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
  EC_DSqty: array [1..MaxCars]of integer;

  EC_TB: array [1..MaxCars,1..3] of record //2+1
  Entries,Index:integer;   //VA_Index
  Cond:byte;       //Cond switch
  CondText:array of string; //Cond text
  end;

  EC_CO: array [1..MaxCars,1..3,1..512] of record Entries,Index:integer; end;

  EC_Value: array [1..MaxCars,1..3,1..512] of array of record
  Typ:byte; Int:integer; Rel:single; Str:string; end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  ProfileQty:integer;
  Profile: array [1..32]of record
  Folder:string;
  Install:bool;
  end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//1..32 Profiles count
//1..32 DS count
//1..40 TB count
  P_: array [1..32]of record
  Header: array [1..33]of char;
  DSqty:integer;

  TB: array [1..32] of record
  Entries:integer; //VA_Entries
  Index:integer;   //VA_Index
  iC:byte;         //VA_iC ?
  Lib:string;      //VA_Lib
  Cond:byte;       //Cond switch
  CondText:array of string; //Cond text
  end;

  CO: array [1..32,1..40] of record
  Entries:integer; //VA_Entries
  Index:integer;   //VA_Index
  Lib:string;      //VA_Lib
  iU:byte;         //VA_iU ?
  SM,ST,IC,SC:string;       //VA_database path, VA_ST, VA_IC, VA_SC
  end;

  Value: array [1..32,1..40] of array of record
  Typ:byte; Int:integer; Rel:single; Str:string; end;
  end;

////////////////////////////////////////////////////////////////////////////////
  AddonCarQty:integer;
  AddonCar: array [1..1024]of record
  Folder:string;
  Factory,Model,Name:string;
  ColorID:integer;
  Install:boolean;
  end;

implementation

{$R *.dfm}
uses SupprtUnit2, Unit2, WR_AboutBox;

procedure TForm1.FormCreate(Sender: TObject);
begin
Form2.Show;
Form2.Repaint;
if fileexists('krom.dev') then ChDir('E:\Cobra 11 - Crash Time');
RootDir:=getcurrentdir;
if not fileexists('FrontEnd\C11vol5.ds') then begin
Form2.FormStyle:=fsNormal;
MessageBox(Form1.Handle,'"FrontEnd\C11vol5.ds" not found. Run CTMan from AFC11CT folder.','Error',MB_OK);
Form2.Close;
exit;
end;
if not FileExists('FrontEnd\C11vol5.bak') then CopyFile('FrontEnd\C11vol5.ds','FrontEnd\C11vol5.bak',true);
if fileexists('FrontEnd\C11vol5.ds') then OpenDS(nil,'FrontEnd\C11vol5.ds');
ElapsedTime(@TimeCode);
Form2.Label2.Caption:='Scanning: Profiles ...'; Form2.Label2.Refresh; SearchProfiles(nil);
Form2.Label2.Caption:='Scanning: Cars ...';     Form2.Label2.Refresh; SearchAutos(nil);         //Form2.Memo1.Lines.Add('Autos - '+ElapsedTime(@TimeCode));
if Form2.Showing then Form2.Destroy;
PopulateCarList(nil);
ReadINI(nil);
end;

procedure TForm1.OpenDS(Sender: TObject; filename:string);
begin
AssignFile(f,filename); FileMode:=0; reset(f,1); FileMode:=2;
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
                       Value[i,k,j].Str:=StrPas(@c); end; end;
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
AssignFile(f,'FrontEnd\C11vol5.ds'); rewrite(f,1); c[1]:=#0;

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
WriteINI(nil);
end;

procedure TForm1.SaveProfiles(Sender: TObject);
var s1,s2:string; ID,h:integer;
begin
for ID:=1 to ProfileQty do if Profile[ID].Install then begin

  for k:=1 to 3 do P_[ID].CO[13,k].Entries:=StockCars; //base number of C11 cars
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

  for k:=1 to 15 do P_[ID].CO[15,k].Entries:=StockCars; //base number of C11 cars

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

AssignFile(f,RootDir+'\C11-Saves\'+profile[ID].Folder+'\Career.new'); rewrite(f,1);
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
CO[24,j].Entries:=StockCars;                                    //reset original Qty
setlength(Value[24,j],CO[24,j].Entries+AddonCarQty+1);
for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
inc(CO[24,j].Entries);
Value[24,j,CO[24,j].Entries]:=Value[24,j,CO[24,j].Entries-1];
end;
end;

//_3DCarsDB
for j:=1 to TB[31].Entries do begin CO[31,j].Entries:=StockCars;
setlength(Value[31,j],CO[31,j].Entries+AddonCarQty+1);
for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
inc(CO[31,j].Entries);
Value[31,j,CO[31,j].Entries]:=Value[31,j,CO[31,j].Entries-1];
end;
end;

//MotorenDB
for j:=1 to TB[40].Entries do if (j<>26) then begin CO[40,j].Entries:=22;
setlength(Value[40,j],CO[40,j].Entries+AddonCarQty+1);
for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
inc(CO[40,j].Entries);
Value[40,j,CO[40,j].Entries]:=Value[40,j,CO[40,j].Entries-1];
end;
end;
//GetriebeDB
for j:=1 to TB[41].Entries do begin CO[41,j].Entries:=54;
setlength(Value[41,j],CO[41,j].Entries+AddonCarQty+1);
for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
inc(CO[41,j].Entries);
Value[41,j,CO[41,j].Entries]:=Value[41,j,CO[41,j].Entries-1];
end;
end;
//ReifenDB
for j:=1 to TB[42].Entries do begin CO[42,j].Entries:=57;
setlength(Value[42,j],CO[42,j].Entries+AddonCarQty*2+1);
for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
inc(CO[42,j].Entries);
Value[42,j,CO[42,j].Entries]:=Value[42,j,CO[42,j].Entries-1];
inc(CO[42,j].Entries);
Value[42,j,CO[42,j].Entries]:=Value[42,j,CO[42,j].Entries-1];
end;
end;

ID:=StockCars;
for i:=1 to AddonCarQty do if (AddonCar[i].Install)and(i<>15)and(i<>41) then begin
inc(ID);
Value[24,1,ID].Int:=ID-1;                               //Index
Value[24,2,ID].Int:=ID-1;                               //3D CarID
Value[24,3,ID].Str:=EC_Value[i,2,4,2].Str;                      //CarTextID
Value[24,4,ID].Int:=EC_Value[i,2,5,2].Int;                      //Score
Value[24,5,ID].Int:=EC_Value[i,2,6,2].Int;                      //
Value[24,6,ID].Int:=0;                                          //ReleaseByCaseID
Value[24,7,ID].Int:=EC_Value[i,2,8,2].Int;                      //
Value[24,8,ID].Int:=EC_Value[i,2,9,2].Int;                      //
Value[24,9,ID].Int:=EC_Value[i,2,10,2].Int;                     //
Value[24,10,ID].Int:=EC_Value[i,2,11,2].Int;                    //
Value[24,11,ID].Int:=(ID-33)-1;                                 //MotorID
Value[24,12,ID].Int:=(ID-1)-1;                                 //
Value[24,13,ID].Int:=(ID*2-54)-1;                               //
Value[24,14,ID].Int:=(ID*2-53)-1;                               //
//Value[24,15,ID].Int:=                                 //TypLinks - empty
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
Value[24,44,ID].Str:=EC_Value[i,2,105,2].Str;                    //HerstellerName
Value[24,45,ID].Str:=EC_Value[i,2,106,2].Str;                    //
if (EC_TB[i,2].Entries<107)or(EC_Value[i,2,107,2].Str='') then Value[24,46,ID].Str:='kein' else  //Caravan
Value[24,46,ID].Str:=EC_Value[i,2,107,2].Str;                    //Caravan
Value[24,47,ID].Str:=EC_Value[i,2,105,2].Str;                    //HerstellerName

//

Value[31,1,ID].Int:=ID-1;
Value[31,2,ID].Str:=EC_Value[i,1,3,2].Str;                      //EngineName
Value[31,3,ID].Rel:=EC_Value[i,1,6,2].Rel;                    //
Value[31,4,ID].Rel:=EC_Value[i,1,7,2].Rel;                    //
Value[31,5,ID].Rel:=EC_Value[i,1,8,2].Rel;                    //
Value[31,6,ID].Rel:=EC_Value[i,1,9,2].Rel;                    //
Value[31,7,ID].Int:=EC_Value[i,1,10,2].Int;                    //
Value[31,8,ID].Int:=EC_Value[i,1,11,2].Int;                    //
Value[31,9,ID].Int:=EC_Value[i,1,12,2].Int;                    //
Value[31,10,ID].Rel:=EC_Value[i,1,16,2].Rel;                    //
Value[31,11,ID].Rel:=EC_Value[i,1,17,2].Rel;                    //
Value[31,12,ID].Rel:=EC_Value[i,1,18,2].Rel;                    //
Value[31,13,ID].Rel:=EC_Value[i,1,19,2].Rel;                    //
Value[31,14,ID].Rel:=EC_Value[i,1,20,2].Rel;                    //
Value[31,15,ID].Rel:=EC_Value[i,1,21,2].Rel;                    //
Value[31,16,ID].Int:=EC_Value[i,1,26,2].Int;                    //UserColorID
Value[31,17,ID].Rel:=EC_Value[i,1,27,2].Rel;                    //
Value[31,18,ID].Int:=EC_Value[i,1,28,2].Int;                    //FlagCabrio
Value[31,19,ID].Int:=0;                    //SplitUser
Value[31,20,ID].Int:=0;                    //
Value[31,21,ID].Int:=0;                    //
Value[31,22,ID].Int:=0;                    //
Value[31,23,ID].Int:=0;                    //
Value[31,24,ID].Int:=0;                    //
Value[31,25,ID].Int:=0;                    //
Value[31,26,ID].Int:=0;                    //
Value[31,27,ID].Int:=0;                    //
Value[31,28,ID].Int:=0;                    //
Value[31,29,ID].Int:=0;                    //
Value[31,30,ID].Int:=0;                    //
Value[31,31,ID].Rel:=EC_Value[i,1,44,2].Rel;                    //KopfXPos
Value[31,32,ID].Rel:=EC_Value[i,1,45,2].Rel;                    //
Value[31,33,ID].Rel:=EC_Value[i,1,46,2].Rel;                    //
Value[31,34,ID].Rel:=EC_Value[i,1,47,2].Rel;                    //
Value[31,35,ID].Rel:=EC_Value[i,1,48,2].Rel;                    //
Value[31,36,ID].Rel:=EC_Value[i,1,49,2].Rel;                    //
Value[31,37,ID].Rel:=EC_Value[i,1,50,2].Rel;                    //
Value[31,38,ID].Int:=EC_Value[i,1,54,2].Int;                    //Tacho1Modus
Value[31,39,ID].Rel:=EC_Value[i,1,55,2].Rel;                    //
Value[31,40,ID].Rel:=EC_Value[i,1,56,2].Rel;                    //
Value[31,41,ID].Rel:=EC_Value[i,1,57,2].Rel;                    //
Value[31,42,ID].Rel:=EC_Value[i,1,58,2].Rel;                    //
Value[31,43,ID].Rel:=EC_Value[i,1,59,2].Rel;                    //
Value[31,44,ID].Rel:=EC_Value[i,1,60,2].Rel;                    //
Value[31,45,ID].Rel:=EC_Value[i,1,61,2].Rel;                    //
Value[31,46,ID].Rel:=EC_Value[i,1,62,2].Rel;                    //
Value[31,47,ID].Rel:=EC_Value[i,1,63,2].Rel;                    //
Value[31,48,ID].Int:=EC_Value[i,1,64,2].Int;                    //Tacho2Modus
Value[31,49,ID].Rel:=EC_Value[i,1,65,2].Rel;                    //
Value[31,50,ID].Rel:=EC_Value[i,1,66,2].Rel;                    //
Value[31,51,ID].Rel:=EC_Value[i,1,67,2].Rel;                    //
Value[31,52,ID].Rel:=EC_Value[i,1,68,2].Rel;                    //
Value[31,53,ID].Rel:=EC_Value[i,1,69,2].Rel;                    //
Value[31,54,ID].Rel:=EC_Value[i,1,70,2].Rel;                    //
Value[31,55,ID].Rel:=EC_Value[i,1,71,2].Rel;                    //
Value[31,56,ID].Rel:=EC_Value[i,1,72,2].Rel;                    //
Value[31,57,ID].Rel:=EC_Value[i,1,73,2].Rel;                    //
Value[31,58,ID].Rel:=EC_Value[i,1,75,2].Rel;                    //MHaube
Value[31,59,ID].Rel:=EC_Value[i,1,76,2].Rel;    //
Value[31,60,ID].Str:='';                        //UserVinyl
Value[31,61,ID].Int:=0;                         //NumVinyls
Value[31,62,ID].Str:='';                        //UserRim
Value[31,63,ID].Str:='';                        //Marker
Value[31,64,ID].Int:=EC_Value[i,1,81,2].Int;    //ColorIndex
Value[31,65,ID].Int:=0;                         //DienstWagenFlag

//MotorenDB
Value[40,1,(ID-33)].Int:=(ID-33)-1;             //
Value[40,2,(ID-33)].Int:=EC_Value[i,2,50,2].Int;//
Value[40,3,(ID-33)].Rel:=EC_Value[i,2,51,2].Rel;//
Value[40,4,(ID-33)].Rel:=EC_Value[i,2,52,2].Rel;//
Value[40,5,(ID-33)].Rel:=EC_Value[i,2,53,2].Rel;//
Value[40,6,(ID-33)].Rel:=EC_Value[i,2,54,2].Rel;//
Value[40,7,(ID-33)].Rel:=EC_Value[i,2,55,2].Rel;//
Value[40,8,(ID-33)].Rel:=EC_Value[i,2,56,2].Rel;//
Value[40,9,(ID-33)].Rel:=EC_Value[i,2,57,2].Rel;//
Value[40,10,(ID-33)].Rel:=EC_Value[i,2,58,2].Rel;//
Value[40,11,(ID-33)].Rel:=EC_Value[i,2,59,2].Rel;//
Value[40,12,(ID-33)].Rel:=EC_Value[i,2,60,2].Rel;//
Value[40,13,(ID-33)].Rel:=EC_Value[i,2,61,2].Rel;//
Value[40,14,(ID-33)].Rel:=EC_Value[i,2,62,2].Rel;//
Value[40,15,(ID-33)].Rel:=EC_Value[i,2,63,2].Rel;//
Value[40,16,(ID-33)].Rel:=EC_Value[i,2,64,2].Rel;//
Value[40,17,(ID-33)].Rel:=EC_Value[i,2,65,2].Rel;//
Value[40,18,(ID-33)].Rel:=EC_Value[i,2,66,2].Rel;//
Value[40,19,(ID-33)].Rel:=EC_Value[i,2,67,2].Rel;//
Value[40,20,(ID-33)].Rel:=EC_Value[i,2,68,2].Rel;//
Value[40,21,(ID-33)].Rel:=EC_Value[i,2,69,2].Rel;//
Value[40,22,(ID-33)].Rel:=EC_Value[i,2,70,2].Rel;//
Value[40,23,(ID-33)].Rel:=EC_Value[i,2,71,2].Rel;//
Value[40,24,(ID-33)].Rel:=EC_Value[i,2,72,2].Rel;//NMStep
Value[40,25,(ID-33)].Int:=EC_Value[i,2,75,2].Int;//SampleRate
//Value[40,26,(ID-13)].Int:=EC_Value[i,2,76,2].Int;//MotorSample
Value[40,27,(ID-33)].Int:=EC_Value[i,2,77,2].Int;//
Value[40,28,(ID-33)].Int:=EC_Value[i,2,78,2].Int;//
Value[40,29,(ID-33)].Str:=EC_Value[i,2,79,2].Str;//
Value[40,30,(ID-33)].Str:=EC_Value[i,2,80,2].Str;//
Value[40,31,(ID-33)].Int:=EC_Value[i,2,81,2].Int;//
Value[40,32,(ID-33)].Str:=EC_Value[i,2,82,2].Str;//
Value[40,33,(ID-33)].Int:=EC_Value[i,2,84,2].Int;//Lautstaerke
Value[40,34,(ID-33)].Int:=EC_Value[i,2,101,2].Int;//
Value[40,35,(ID-33)].Int:=EC_Value[i,2,102,2].Int;//
Value[40,36,(ID-33)].Int:=EC_Value[i,2,103,2].Int;//
Value[40,37,(ID-33)].Int:=EC_Value[i,2,104,2].Int;//
Value[40,38,(ID-33)].Int:=EC_Value[i,2,100,2].Int;//Drehzahlmesser

//GearboxID
Value[41,1,(ID-1)].Int:=(ID-1)-1;//
Value[41,2,(ID-1)].Int:=EC_Value[i,2,85,2].Int;//
Value[41,3,(ID-1)].Rel:=EC_Value[i,2,86,2].Rel;//1
Value[41,4,(ID-1)].Rel:=EC_Value[i,2,87,2].Rel;//2
Value[41,5,(ID-1)].Rel:=EC_Value[i,2,88,2].Rel;//3
Value[41,6,(ID-1)].Rel:=EC_Value[i,2,89,2].Rel;//4
Value[41,7,(ID-1)].Rel:=EC_Value[i,2,90,2].Rel;//5
Value[41,8,(ID-1)].Rel:=EC_Value[i,2,91,2].Rel;//6
Value[41,9,(ID-1)].Rel:=EC_Value[i,2,92,2].Rel;//7
Value[41,10,(ID-1)].Rel:=EC_Value[i,2,93,2].Rel;//RW

//Tires
for j:=0 to 1 do begin
Value[42,1,(ID*2+j-54)].Int:=(ID*2+j-54)-1;//
Value[42,2,(ID*2+j-54)].Rel:=EC_Value[i,2,94+j*3,2].Rel;//
Value[42,3,(ID*2+j-54)].Rel:=EC_Value[i,2,95+j*3,2].Rel;//
Value[42,4,(ID*2+j-54)].Rel:=EC_Value[i,2,96+j*3,2].Rel;//
end;    //

end;
Value[16,9,9].Typ:=4; //Prevent Editcar from loading the C11vol5.ds
Value[41,7,7].Typ:=4; //Prevent Editcar from loading the C11vol5.ds
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
AssignFile(f,RootDir+'\C11-Saves\'+s1+'\career.wrc'); FileMode:=0; reset(f,1); FileMode:=2;
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
                       P_[i1].Value[i,k,j].Str:=StrPas(@c); end; end;
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
Pos:=0; //reset to 0
AssignFile(f,RootDir+'\Autos\'+s1+'\EditCar.car'); FileMode:=0; reset(f,128); FileMode:=2;
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
begin
for i:=1 to CLBProfiles.Count do Profile[i].Install:=CLBProfiles.Checked[i-1];
for i:=1 to CLBCars.Count do AddonCar[i].Install:=CLBCars.Checked[i-1];
if CLBCars.ItemIndex<0 then exit;
TrackBar1.Position:=AddonCar[CLBCars.ItemIndex+1].ColorID;
end;

procedure TForm1.Info(Sender: TObject);
begin
AboutForm.Show;
AboutForm.LTitle1.Caption:='AFC11CT Manager';
AboutForm.LTitle2.Caption:='by Krom';
AboutForm.LVersi.Caption:='Version 0.1 (05 Aug 2008)';
AboutForm.LDescr.Caption:='Manages AFC11CT addons.';
end;

procedure TForm1.WriteINI(Sender: TObject);
begin
chdir(RootDir);
AssignFile(ft,'CTMan.ini'); rewrite(ft);
writeln(ft,'AFC11CT Manager INI file');

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

{writeln(ft);
writeln(ft,'DrivingMode:');
if CBSimMissions.Checked then
writeln(ft,'Sim') else writeln(ft,'Arcade');}

{writeln(ft);
writeln(ft,'ListingMode:');
writeln(ft,inttostr(RGListing.ItemIndex)); }

closefile(ft);
end;

procedure TForm1.CBSimMissionsClick(Sender: TObject);
begin
//for i:=2 to 30 do if CBSimMissions.Checked then
//Value[49,30,i].Int:=0 else Value[49,30,i].Int:=100; //Missions Arcade / Simulation
end;

procedure TForm1.ReadINI(Sender: TObject);
var i,col:integer; st:string;
begin
chdir(RootDir);
if not fileexists('CTMan.ini') then exit;
AssignFile(ft,'CTMan.ini'); reset(ft);
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
    for i:=0 to CLBCars.Count-1 do begin
    st:=CLBCars.Items[i];
    decs(st,-length(st)+3);
      if AddonCar[strtoint(st)].Folder=s then begin
      CLBCars.Checked[i]:=true;
      AddonCar[strtoint(st)].ColorID:=col;
      end;
    end;
  until(s='');

{  if s='DrivingMode:' then begin
  readln(ft,s);
  if s='Sim' then CBSimMissions.Checked:=true;
  end;}

 { if s='ListingMode:' then begin
  readln(ft,s);
  RGListing.ItemIndex:=EnsureRange(strtoint(s),0,RGListing.Items.Count-1);
  end;    }

until(eof(ft));
closefile(ft);
CLBClickCheck(nil);
end;

procedure TForm1.PopulateCarList(Sender: TObject);
var i:integer;
begin
for i:=1 to AddonCarQty do begin

//if RGListing.Items[RGListing.ItemIndex]='Folders' then
CLBCars.AddItem(AddonCar[i].Folder+zz+int2fix(i,3),nil);

end;
CLBCars.Refresh;
end;

procedure TForm1.CBSortCarsClick(Sender: TObject);
begin
//CLBCars.Sorted:=CBSortCars.Checked;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
SaveChanges.Click();
Form1.Close;
ChDir(RootDir);
ShellExecute(handle, 'open', 'CrashTime.exe', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.CLBCarsDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
CLBCars.Canvas.TextOut(Rect.Left+22,Rect.Top,CLBCars.Items[Index]);
CLBCars.Canvas.Brush.Color:=PresetColor[AddonCar[Index+1].ColorID];
CLBCars.Canvas.TextOut(Rect.Left+2,Rect.Top,'      ');
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
if CLBCars.ItemIndex<0 then exit;
AddonCar[CLBCars.ItemIndex+1].ColorID:=TrackBar1.Position;
Shape1.Brush.Color:=PresetColor[AddonCar[CLBCars.ItemIndex+1].ColorID]; //coloring solution
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

procedure TForm1.BitBtn3Click(Sender: TObject);
{var
  f1,f2,f3:file;
  ft:textfile;
  c:array of char;
  NumRead:integer;
  i,k,h:integer;
  CTABcount,
  CTAB_Index:integer;
  CTABSize: array [1..128]of integer;
  ps_2Count:integer;
  ps_2Size: array [1..128]of integer;
  IsPixelShader:boolean;
  Head: array [1..128]of record
    ID: array [1..4]of char;
    c1:integer;           //c28
    CodeOffset:integer;
    c2:integer;
    Names:integer;
    c3:integer;           //c28
    c4:integer;
    c5:integer;
    NamesInfo: array [1..16]of record
      Inf: array [1..10]of word;
    end;
  end;
       }
begin   (*
SaveChanges.Click();
ChDir(RootDir);
setlength(c,4096000+1);

AssignFile(f1,'CrashTime_sse2.ds'); reset(f1,1);
AssignFile(ft,'ct.txt'); rewrite(ft);
AssignFile(f2,'CrashTime_sse2.exe'); rewrite(f2,1);

blockread(f1,c[1],2500552);
blockwrite(f2,c[1],2500552);

{for i:=1 to 1 do begin
  blockread(f1,Head[i],32);
  blockwrite(f2,Head[i],32);
  for k:=1 to Head[i].Names do begin
    blockread(f1,Head[i],20);
    blockwrite(f2,Head[i],20);
  end;
end;}

i:=0; k:=65535; CTAB_Index:=0; ps_2Count:=0;
repeat
inc(i);
blockread(f1,h,4);
if h=1111577667 then begin //CTAB
  if CTAB_Index<>0 then CloseFile(f3);
  inc(CTAB_Index);
  CTABSize[CTAB_Index]:=k*4;
  write(ft,'(',k*4,',');
  k:=0;
  AssignFile(f3,'shad'+inttostr(CTAB_Index)+'.ds'); rewrite(f3,1);
end;
inc(k);

//30 - overall important
//30 - overall important except UV mapping?
//48 - overall important
//55 - overall car important
//60 - overall car important
//70 - ?
//74 - ?
//77 - ?
//78 - ?
//80 - Car reflections in race and carbody mat in menu
//84 - Car reflections in race
//85 - Car reflections in race
//86 - Car reflections in race

{if CTAB_Index<>87 then //unknown lenght

//if CTAB_Index =20 then //unknown lenght
//if CTAB_Index in [1..10] then //unknown lenght
if CTAB_Index in [30..87] then //unknown lenght
//if CTABLen[CTAB_Index+1,1]-CTABLen[CTAB_Index,1]<200 then
if //(k*4>CTABLen[CTAB_Index,3]+68)and     //text id
   (k*4>(CTABLen[CTAB_Index+1,1]-CTABLen[CTAB_Index,1]-96))and    //Leave the footer
   (k*4<=(CTABLen[CTAB_Index+1,1]-CTABLen[CTAB_Index,1]-96)) then    //Leave the footer
  h:=0;  }

blockwrite(f2,h,4);
blockwrite(f3,h,4);

until(i=20000);
CloseFile(f3);
blockread(f1,c[1],2500552,NumRead);
blockwrite(f2,c[1],NumRead);

(*
CTABCount:=0; k:=0; h:=0;
for i:=1 to NumRead-6 do begin

if c[i]+c[i+1]+c[i+2]+c[i+3]='CTAB' then begin
write(ft,#9+'CodeSize=',i-h);
writeln(ft,#9+'ShadSize=',i-k);
inc(CTABCount);
write(ft,'{',CTABCount,'} (',2500552+i,',');
k:=i;
end;

if c[i]+c[i+1]+c[i+2]+c[i+3]+c[i+4]+c[i+5]='ps_2_0' then begin
write(ft,2500552+i,',',i-k,'), '+#9+'//ps_2_0  '+#9+'CTABSize=',i-k);
h:=i;
end;

if c[i]+c[i+1]+c[i+2]+c[i+3]+c[i+4]+c[i+5]='vs_2_0' then begin
write(ft,2500552+i,',',i-k,'), '+#9+'//vs_2_0  '+#9+'CTABSize=',i-k);
h:=i;
end;

end;   //*)
                {
closefile(f1);
closefile(ft);
closefile(f2);

BitBtn3.Caption:=inttostr(ps_2Count);
                       }
//Form1.Close;
//ShellExecute(handle, 'open', 'CrashTime.exe', nil, nil, SW_SHOWNORMAL);
end;

end.

