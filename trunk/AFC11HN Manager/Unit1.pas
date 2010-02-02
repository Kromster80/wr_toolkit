unit Unit1;
{$IFDEF FPC} {$MODE Delphi} {$ENDIF}
interface
uses
  {$IFDEF FPC} LResources, LCLIntf, {$ENDIF}
  Windows, SysUtils, Classes, Controls, ExtCtrls, Forms,
  StdCtrls, KromUtils, ComCtrls, CheckLst, Buttons, Dialogs;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    CLBCars: TCheckListBox;
    Label3: TLabel;
    SaveChanges: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    SAll: TButton;
    SNone: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OpenDS(Sender: TObject; filename:string);
    procedure SaveDS(Sender: TObject);
    procedure AddTracksToDS(Sender: TObject);
    procedure SearchAutos(Sender: TObject);
    procedure GetAutoInfo(s1:string;i1:integer);
    procedure Info(Sender: TObject);
    procedure WriteINI(Sender: TObject);
    procedure CBSimMissionsClick(Sender: TObject);
    procedure ReadINI(Sender: TObject);
    procedure PopulateCarList(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CLBCarsClick(Sender: TObject);
    procedure SAllClick(Sender: TObject);
  end;

const
 StockCars=54;
 MaxCars=256;
 VersionInfo='AFC11HN Manager       Version 0.1 (02 Dec 2009)';

var
  Form1: TForm1;
  f:file;
  ft:textfile;
  c:array[1..1024000]of char;
  i,j,k,m,h:integer;
  s:string;
  WorkDir:string;
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
  AddonCarQty:integer;
  AddonCar:array[1..1024]of record
    Folder:string;
    Factory,Model,Name:string;
    Install:boolean;
  end;

implementation

uses Unit2, WR_AboutBox;

procedure TForm1.FormCreate(Sender: TObject);
var s1,s2:string;
begin
  if Sender<>nil then exit; //Wait until all forms are init
  Form2.Show;
  Form2.Repaint;

  if fileexists('krom.dev') then ChDir('E:\Crash Time III Demo');

  WorkDir := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  if not fileexists(WorkDir+'FrontEnd2\FrontEnd.ds') then begin
    Form2.FormStyle := fsNormal;
    MessageBox(Form1.Handle,'".\FrontEnd2\FrontEnd.ds" not found. Run HNMan from AFC11HN folder.','Error',MB_OK);
    Form1.Close;
    exit;
  end;

  s1 := WorkDir+'FrontEnd2\FrontEnd.ds';
  s2 := WorkDir+'FrontEnd2\FrontEnd.bak';
  if not FileExists(s2) then
    CopyFile(@(s1)[1],@(s2)[1],true);
  OpenDS(nil,WorkDir+'FrontEnd2\FrontEnd.ds');
  ElapsedTime(@TimeCode);
  Form2.Label2.Caption := 'Scanning: Cars ...';     Form2.Label2.Refresh; SearchAutos(nil);         //Form2.Memo1.Lines.Add('Autos - '+ElapsedTime(@TimeCode));
  if Form2.Showing then Form2.Destroy;
  PopulateCarList(nil);
  ReadINI(nil);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  WriteINI(nil);
end;

procedure TForm1.OpenDS(Sender: TObject; filename:string);
begin
assignfile(f,filename); FileMode:=0; reset(f,1); FileMode:=2;
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
assignfile(f,WorkDir+'FrontEnd2\FrontEnd.ds'); rewrite(f,1); c[1]:=#0;

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

WriteINI(nil);
end;

procedure TForm1.AddTracksToDS(Sender: TObject);
var ID:integer;
begin
  //CarsDB
  for j:=1 to TB[6].Entries do if (j<>16)and(j<>42) then begin   //skip these TypLinks/TypRechts
    CO[6,j].Entries:=StockCars;                                    //reset original Qty
    setlength(Value[6,j],CO[6,j].Entries+AddonCarQty+1);
    for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
      inc(CO[6,j].Entries);
      Value[6,j,CO[6,j].Entries]:=Value[6,j,CO[6,j].Entries-1];
    end;
  end;

  //_3DCarsDB
  for j:=1 to TB[7].Entries do if (j<>1) then begin
    CO[7,j].Entries:=StockCars;
    setlength(Value[7,j],CO[7,j].Entries+AddonCarQty+1);
    for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
      inc(CO[7,j].Entries);
      Value[7,j,CO[7,j].Entries]:=Value[7,j,CO[7,j].Entries-1];
    end;
  end;

  //MotorenDB
  for j:=1 to TB[8].Entries do if (j<>1)and(j<>29) then begin
    CO[8,j].Entries:=33;
    setlength(Value[8,j],CO[8,j].Entries+AddonCarQty+1);
    for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
      inc(CO[8,j].Entries);
      Value[8,j,CO[8,j].Entries]:=Value[8,j,CO[8,j].Entries-1];
    end;
  end;

  //GetriebeDB
  for j:=1 to TB[9].Entries do begin
    CO[9,j].Entries:=14;
    setlength(Value[9,j],CO[9,j].Entries+AddonCarQty+1);
    for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
      inc(CO[9,j].Entries);
      Value[9,j,CO[9,j].Entries]:=Value[9,j,CO[9,j].Entries-1];
    end;
  end;

  //ReifenDB
  for j:=1 to TB[10].Entries do begin
    CO[10,j].Entries:=72;
    setlength(Value[10,j],CO[10,j].Entries+AddonCarQty*2+1);
    for i:=1 to AddonCarQty do if AddonCar[i].Install then begin
      inc(CO[10,j].Entries);
      Value[10,j,CO[10,j].Entries]:=Value[10,j,CO[10,j].Entries-1];
      inc(CO[10,j].Entries);
      Value[10,j,CO[10,j].Entries]:=Value[10,j,CO[10,j].Entries-1];
    end;
  end;

ID:=StockCars;
for i:=1 to AddonCarQty do if (AddonCar[i].Install)and(i<>16)and(i<>42) then begin
inc(ID);
Value[6,1,ID].Str:='AddOn car';                        //Kommentar
Value[6,2,ID].Int:=ID-1;                               //Index
Value[6,3,ID].Int:=ID-1;                               //3D CarID
Value[6,4,ID].Str:=EC_Value[i,2,4,2].Str;                      //CarTextID
Value[6,5,ID].Int:=EC_Value[i,2,5,2].Int;                      //Score
Value[6,6,ID].Int:=EC_Value[i,2,6,2].Int;                      //
Value[6,7,ID].Int:=0;                                          //ReleaseByCaseID
Value[6,8,ID].Int:=EC_Value[i,2,8,2].Int;                      //
Value[6,9,ID].Int:=EC_Value[i,2,9,2].Int;                      //
Value[6,10,ID].Int:=EC_Value[i,2,10,2].Int;                     //
Value[6,11,ID].Int:=EC_Value[i,2,11,2].Int;                    //
Value[6,12,ID].Int:=(ID-21)-1;                                 //MotorID
Value[6,13,ID].Int:=(ID-40)-1;                                 //
Value[6,14,ID].Int:=(ID*2-37)-1;                               //
Value[6,15,ID].Int:=(ID*2-36)-1;                               //
//Value[6,16,ID].Int:=                                 //TypLinks - empty
Value[6,17,ID].Int:=EC_Value[i,2,17,2].Int;                    //
Value[6,18,ID].Int:=EC_Value[i,2,18,2].Int;                    //
Value[6,19,ID].Rel:=EC_Value[i,2,19,2].Rel;                    //Ausfedern
Value[6,20,ID].Rel:=EC_Value[i,2,20,2].Rel;                    //
Value[6,21,ID].Rel:=EC_Value[i,2,21,2].Rel;                    //
Value[6,22,ID].Rel:=EC_Value[i,2,22,2].Rel;                    //
Value[6,23,ID].Int:=EC_Value[i,2,23,2].Int;                    //Drehimpulse
Value[6,24,ID].Rel:=EC_Value[i,2,24,2].Rel;                    //
Value[6,25,ID].Rel:=EC_Value[i,2,25,2].Rel;                    //
Value[6,26,ID].Rel:=EC_Value[i,2,26,2].Rel;                    //
Value[6,27,ID].Rel:=EC_Value[i,2,27,2].Rel;                    //
Value[6,28,ID].Int:=EC_Value[i,2,28,2].Int;                    //%
Value[6,29,ID].Rel:=EC_Value[i,2,29,2].Rel;                    //
Value[6,30,ID].Int:=EC_Value[i,2,30,2].Int;                    //Drehmomentfalkor
Value[6,31,ID].Int:=EC_Value[i,2,33,2].Int;                    //Weight_KG
Value[6,32,ID].Int:=EC_Value[i,2,37,2].Int;                    //Antrieb
Value[6,33,ID].Rel:=EC_Value[i,2,38,2].Rel;                    //Gesamt
Value[6,34,ID].Rel:=EC_Value[i,2,39,2].Rel;                    //Luftwider
Value[6,35,ID].Int:=EC_Value[i,2,40,2].Int;                    //
Value[6,36,ID].Int:=EC_Value[i,2,41,2].Int;                    //
Value[6,37,ID].Int:=EC_Value[i,2,42,2].Int;                    //
Value[6,38,ID].Int:=EC_Value[i,2,43,2].Int;                    //RaceClass
Value[6,39,ID].Rel:=EC_Value[i,2,44,2].Rel;                    //ReifenYPos
Value[6,40,ID].Rel:=EC_Value[i,2,45,2].Rel;                    //0-100
Value[6,41,ID].Int:=EC_Value[i,2,46,2].Int;                    //MphTopSpeed
//Value[6,42,ID].Int:=                                 //TypRechts - empty
Value[6,43,ID].Int:=EC_Value[i,2,48,2].Int;                    //
Value[6,44,ID].Int:=EC_Value[i,2,49,2].Int;                    //
Value[6,45,ID].Str:=EC_Value[i,2,105,2].Str;                    //HerstellerName
Value[6,46,ID].Str:=EC_Value[i,2,106,2].Str;                    //
if (EC_TB[i,2].Entries<107)or(EC_Value[i,2,107,2].Str='') then Value[6,47,ID].Str:='kein' else  //Caravan
Value[6,47,ID].Str:=EC_Value[i,2,107,2].Str;                    //
Value[6,48,ID].Str:=EC_Value[i,2,105,2].Str;                    //
//The rest gets repeaten from last car

//Value[7,1,ID].Str:= empty
Value[7,2,ID].Int:=ID-1;
Value[7,3,ID].Str:=EC_Value[i,1,3,2].Str;                      //EngineName
Value[7,4,ID].Rel:=EC_Value[i,1,6,2].Rel;                    //
Value[7,5,ID].Rel:=EC_Value[i,1,7,2].Rel;                    //
Value[7,6,ID].Rel:=EC_Value[i,1,8,2].Rel;                    //
Value[7,7,ID].Rel:=EC_Value[i,1,9,2].Rel;                    //
Value[7,8,ID].Int:=EC_Value[i,1,10,2].Int;                    //
Value[7,9,ID].Int:=EC_Value[i,1,11,2].Int;                    //
Value[7,10,ID].Int:=EC_Value[i,1,12,2].Int;                    //
Value[7,11,ID].Rel:=EC_Value[i,1,16,2].Rel;                    //
Value[7,12,ID].Rel:=EC_Value[i,1,17,2].Rel;                    //
Value[7,13,ID].Rel:=EC_Value[i,1,18,2].Rel;                    //
Value[7,14,ID].Rel:=EC_Value[i,1,19,2].Rel;                    //
Value[7,15,ID].Rel:=EC_Value[i,1,20,2].Rel;                    //
Value[7,16,ID].Rel:=EC_Value[i,1,21,2].Rel;                    //
Value[7,17,ID].Int:=EC_Value[i,1,26,2].Int;                    //UserColorID
Value[7,18,ID].Rel:=EC_Value[i,1,27,2].Rel;                    //
Value[7,19,ID].Int:=EC_Value[i,1,28,2].Int;                    //FlagCabrio
Value[7,20,ID].Int:=0;                    //SplitUser
Value[7,21,ID].Int:=0;                    //
Value[7,22,ID].Int:=0;                    //
Value[7,23,ID].Int:=0;                    //
Value[7,24,ID].Int:=0;                    //
Value[7,25,ID].Int:=0;                    //
Value[7,26,ID].Int:=0;                    //
Value[7,27,ID].Int:=0;                    //
Value[7,28,ID].Int:=0;                    //
Value[7,29,ID].Int:=0;                    //
Value[7,30,ID].Int:=0;                    //
Value[7,31,ID].Int:=0;                    //
Value[7,32,ID].Rel:=EC_Value[i,1,44,2].Rel;                    //KopfXPos
Value[7,33,ID].Rel:=EC_Value[i,1,45,2].Rel;                    //
Value[7,34,ID].Rel:=EC_Value[i,1,46,2].Rel;                    //
Value[7,35,ID].Rel:=EC_Value[i,1,47,2].Rel;                    //
Value[7,36,ID].Rel:=EC_Value[i,1,48,2].Rel;                    //
Value[7,37,ID].Rel:=EC_Value[i,1,49,2].Rel;                    //
Value[7,38,ID].Rel:=EC_Value[i,1,50,2].Rel;                    //
Value[7,39,ID].Int:=EC_Value[i,1,54,2].Int;                    //Tacho1Modus
Value[7,40,ID].Rel:=EC_Value[i,1,55,2].Rel;                    //
Value[7,41,ID].Rel:=EC_Value[i,1,56,2].Rel;                    //
Value[7,42,ID].Rel:=EC_Value[i,1,57,2].Rel;                    //
Value[7,43,ID].Rel:=EC_Value[i,1,58,2].Rel;                    //
Value[7,44,ID].Rel:=EC_Value[i,1,59,2].Rel;                    //
Value[7,45,ID].Rel:=EC_Value[i,1,60,2].Rel;                    //
Value[7,46,ID].Rel:=EC_Value[i,1,61,2].Rel;                    //
Value[7,47,ID].Rel:=EC_Value[i,1,62,2].Rel;                    //
Value[7,48,ID].Rel:=EC_Value[i,1,63,2].Rel;                    //
Value[7,49,ID].Int:=EC_Value[i,1,64,2].Int;                    //Tacho2Modus
Value[7,50,ID].Rel:=EC_Value[i,1,65,2].Rel;                    //
Value[7,51,ID].Rel:=EC_Value[i,1,66,2].Rel;                    //
Value[7,52,ID].Rel:=EC_Value[i,1,67,2].Rel;                    //
Value[7,53,ID].Rel:=EC_Value[i,1,68,2].Rel;                    //
Value[7,54,ID].Rel:=EC_Value[i,1,69,2].Rel;                    //
Value[7,55,ID].Rel:=EC_Value[i,1,70,2].Rel;                    //
Value[7,56,ID].Rel:=EC_Value[i,1,71,2].Rel;                    //
Value[7,57,ID].Rel:=EC_Value[i,1,72,2].Rel;                    //
Value[7,58,ID].Rel:=EC_Value[i,1,73,2].Rel;                    //
Value[7,59,ID].Rel:=EC_Value[i,1,75,2].Rel;                    //MHaube
Value[7,60,ID].Rel:=EC_Value[i,1,76,2].Rel;    //
Value[7,61,ID].Str:='';                        //UserVinyl
Value[7,62,ID].Int:=0;                         //NumVinyls
Value[7,63,ID].Str:='';                        //UserRim
Value[7,64,ID].Str:='';                        //Marker
Value[7,65,ID].Int:=EC_Value[i,1,81,2].Int;    //ColorIndex
Value[7,66,ID].Int:=0;                         //DienstWagenFlag
Value[7,67,ID].Int:=1;                         //FlagColorSelection

//MotorenDB
//Value[8,1,ID].Str:= empty
Value[8,2,(ID-21)].Int:=(ID-21)-1;             //
Value[8,3,(ID-21)].Int:=EC_Value[i,2,50,2].Int;//
Value[8,4,(ID-21)].Rel:=EC_Value[i,2,51,2].Rel;//
Value[8,5,(ID-21)].Rel:=EC_Value[i,2,52,2].Rel;//
Value[8,6,(ID-21)].Rel:=EC_Value[i,2,53,2].Rel;//
Value[8,7,(ID-21)].Rel:=EC_Value[i,2,54,2].Rel;//
Value[8,8,(ID-21)].Rel:=EC_Value[i,2,55,2].Rel;//
Value[8,9,(ID-21)].Rel:=EC_Value[i,2,56,2].Rel;//
Value[8,10,(ID-21)].Rel:=EC_Value[i,2,57,2].Rel;//
Value[8,11,(ID-21)].Rel:=EC_Value[i,2,58,2].Rel;//
Value[8,12,(ID-21)].Rel:=EC_Value[i,2,59,2].Rel;//
Value[8,13,(ID-21)].Rel:=EC_Value[i,2,60,2].Rel;//
Value[8,14,(ID-21)].Rel:=EC_Value[i,2,61,2].Rel;//
Value[8,15,(ID-21)].Rel:=EC_Value[i,2,62,2].Rel;//
Value[8,16,(ID-21)].Rel:=EC_Value[i,2,63,2].Rel;//
Value[8,17,(ID-21)].Rel:=EC_Value[i,2,64,2].Rel;//
Value[8,18,(ID-21)].Rel:=EC_Value[i,2,65,2].Rel;//
Value[8,19,(ID-21)].Rel:=EC_Value[i,2,66,2].Rel;//
Value[8,20,(ID-21)].Rel:=EC_Value[i,2,67,2].Rel;//
Value[8,21,(ID-21)].Rel:=EC_Value[i,2,68,2].Rel;//
Value[8,22,(ID-21)].Rel:=EC_Value[i,2,69,2].Rel;//
Value[8,23,(ID-21)].Rel:=EC_Value[i,2,70,2].Rel;//
Value[8,24,(ID-21)].Rel:=EC_Value[i,2,71,2].Rel;//
Value[8,25,(ID-21)].Rel:=EC_Value[i,2,72,2].Rel;//NMStep
Value[8,26,(ID-21)].Rel:=0;//10500rpm
Value[8,27,(ID-21)].Rel:=0;//11rpm
Value[8,28,(ID-21)].Int:=EC_Value[i,2,75,2].Int;//SampleRate
//Value[8,29,(ID-21)].Int:=EC_Value[i,2,76,2].Int;//MotorSample
Value[8,30,(ID-21)].Int:=EC_Value[i,2,77,2].Int;//
Value[8,31,(ID-21)].Int:=EC_Value[i,2,78,2].Int;//
Value[8,32,(ID-21)].Str:=EC_Value[i,2,79,2].Str;//
Value[8,33,(ID-21)].Str:=EC_Value[i,2,80,2].Str;//
Value[8,34,(ID-21)].Int:=EC_Value[i,2,81,2].Int;//
Value[8,35,(ID-21)].Str:=EC_Value[i,2,82,2].Str;//
Value[8,36,(ID-21)].Int:=EC_Value[i,2,84,2].Int;//Lautstaerke
Value[8,37,(ID-21)].Int:=EC_Value[i,2,101,2].Int;//
Value[8,38,(ID-21)].Int:=EC_Value[i,2,102,2].Int;//
Value[8,39,(ID-21)].Int:=EC_Value[i,2,103,2].Int;//
Value[8,40,(ID-21)].Int:=EC_Value[i,2,104,2].Int;//
Value[8,41,(ID-21)].Int:=EC_Value[i,2,100,2].Int;//Drehzahlmesser
Value[8,42,(ID-21)].Rel:=0;//11.5rpm
Value[8,43,(ID-21)].Rel:=0;//12rpm
Value[8,44,(ID-21)].Rel:=0;//12.5rpm
Value[8,45,(ID-21)].Rel:=0;//13rpm
Value[8,46,(ID-21)].Rel:=0;//13.5rpm
Value[8,47,(ID-21)].Rel:=0;//14rpm
Value[8,48,(ID-21)].Rel:=0;//14.5rpm
Value[8,49,(ID-21)].Rel:=0;//15rpm

//GearboxID
//Value[9,1,ID].Str:= empty
Value[9,2,(ID-40)].Int:=(ID-40)-1;//
Value[9,3,(ID-40)].Int:=EC_Value[i,2,85,2].Int;//
Value[9,4,(ID-40)].Rel:=EC_Value[i,2,86,2].Rel;//1
Value[9,5,(ID-40)].Rel:=EC_Value[i,2,87,2].Rel;//2
Value[9,6,(ID-40)].Rel:=EC_Value[i,2,88,2].Rel;//3
Value[9,7,(ID-40)].Rel:=EC_Value[i,2,89,2].Rel;//4
Value[9,8,(ID-40)].Rel:=EC_Value[i,2,90,2].Rel;//5
Value[9,9,(ID-40)].Rel:=EC_Value[i,2,91,2].Rel;//6
Value[9,10,(ID-40)].Rel:=EC_Value[i,2,92,2].Rel;//7
Value[9,11,(ID-40)].Rel:=EC_Value[i,2,93,2].Rel;//RW

//Tires
for j:=0 to 1 do begin
  //Value[10,1,ID].Str:= empty
  Value[10,2,(ID*2+j-37)].Int:=(ID*2+j-37)-1;//
  Value[10,3,(ID*2+j-37)].Rel:=EC_Value[i,2,94+j*3,2].Rel;//
  Value[10,4,(ID*2+j-37)].Rel:=EC_Value[i,2,95+j*3,2].Rel;//
  Value[10,5,(ID*2+j-37)].Rel:=EC_Value[i,2,96+j*3,2].Rel;//
end;    //

end;
  Value[9,9,9].Typ:=4; //Prevent Editcar from loading the C11vol5.ds
  Value[9,7,7].Typ:=4; //Prevent Editcar from loading the C11vol5.ds
end;

procedure TForm1.SearchAutos(Sender: TObject);
var SearchRec:TSearchRec; ii:integer;
begin
ChDir(WorkDir); AddonCarQty:=0;
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
  if fileexists(WorkDir+'\Autos\'+SearchRec.Name+'\EditCar.car') then begin
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
assignfile(f,WorkDir+'\Autos\'+s1+'\EditCar.car'); FileMode:=0; reset(f,128); FileMode:=2;
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
//AddonCar[i1].ColorID:=EC_Value[i1,1,81,2].Int;
end;

procedure TForm1.Info(Sender: TObject);
begin
  AboutForm.Show(VersionInfo,'Manages AFC11HN addons.','AFC11HNMan');
end;

procedure TForm1.WriteINI(Sender: TObject);
begin
  assignfile(ft,WorkDir+'HNMan.ini'); rewrite(ft);
  writeln(ft,'AFC11HN Manager INI file');

  writeln(ft);
  writeln(ft,'Cars:');
  for i:=1 to AddOnCarQty do
    if AddonCar[i].Install then begin
    writeln(ft,AddonCar[i].Folder);
    //writeln(ft,AddonCar[i].ColorID);
  end;
  closefile(ft);
end;

procedure TForm1.CBSimMissionsClick(Sender: TObject);
begin
  //for i:=2 to 30 do if CBSimMissions.Checked then
  //Value[49,30,i].Int:=0 else Value[49,30,i].Int:=100; //Missions Arcade / Simulation
end;

procedure TForm1.ReadINI(Sender: TObject);
var i:integer; st:widestring;
begin
  if not fileexists(WorkDir+'HNMan.ini') then exit;
  assignfile(ft, WorkDir+'HNMan.ini'); reset(ft);
  readln(ft); readln(ft);

  repeat
  readln(ft,s);

    if s = 'Cars:' then
    repeat
      readln(ft, s);
      //We compare string with AddonCar Folder incase player has some other display format, e.g. RaceClass.Name.Folder
      for i := 0 to CLBCars.Count-1 do begin
        st := Copy(CLBCars.Items[i], length(CLBCars.Items[i])-2, 3); //Read last 3 chars
        CLBCars.Checked[i] := CompareStr(AddonCar[strtoint(st)].Folder,s)=0;
      end;
    until(s='');

  until(eof(ft));
  closefile(ft);
  CLBCarsClick(nil);
end;

procedure TForm1.PopulateCarList(Sender: TObject);
var i:integer;
begin
  for i:=1 to AddonCarQty do
    CLBCars.Items.Add(AddonCar[i].Folder+zz+int2fix(i,3));
  CLBCars.Refresh;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  SaveChanges.Click();
  Form1.Close;
  ChDir(WorkDir);
  ShellExecute(handle, 'open', 'HighwayNights.exe', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.CLBCarsClick(Sender: TObject);
var i:integer;
begin
  for i:=1 to CLBCars.Count do
    AddonCar[i].Install := CLBCars.Checked[i-1];
end;

procedure TForm1.SAllClick(Sender: TObject);
begin
  for i:=1 to CLBCars.Count do
    CLBCars.Checked[i-1]:=(Sender=SAll)and(Sender<>SNone);
  CLBCarsClick(nil);
end;

{$IFDEF VER140}
  {$R *.dfm}
{$ENDIF}

initialization
{$IFDEF FPC}
  {$I Unit1.lrs}
{$ENDIF}

end.

