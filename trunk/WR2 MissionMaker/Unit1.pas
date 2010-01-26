unit Unit1;  
interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Buttons,
  Graphics, ExtCtrls, Forms, StdCtrls, KromUtils, Math, ComCtrls, CheckLst, Spin,
  FloatSpinEdit, Dialogs;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    CLBSceneries: TCheckListBox;
    Button2: TButton;
    Button3: TButton;
    GBScenery: TGroupBox;
    LBTracks: TListBox;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    GBTrack: TGroupBox;
    Label1: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    GroupBoxCar: TGroupBox;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    TabSheet4: TTabSheet;
    Label86: TLabel;
    Label47: TLabel;
    Label45: TLabel;
    Label38: TLabel;
    Label37: TLabel;
    Label36: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    TabSheet5: TTabSheet;
    LoadMission: TButton;
    Button13: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    ListCars2: TListBox;
    CBCars: TComboBox;
    Label127: TLabel;
    Label128: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label59: TLabel;
    Label60: TLabel;
    Label69: TLabel;
    Label73: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label84: TLabel;
    Label35: TLabel;
    AllRandom: TButton;
    ScnSame: TButton;
    ScnSameRandom: TButton;
    ScnRandom: TButton;
    Button10: TButton;
    LapSame: TButton;
    Lap1_5: TButton;
    Lap4_10: TButton;
    Lap10_30: TButton;
    TBRaceQty: TTrackBar;
    Scn1: TComboBox;
    Trk1: TComboBox;
    Scn2: TComboBox;
    Trk2: TComboBox;
    L2: TSpinEdit;
    C2: TSpinEdit;
    T2: TComboBox;
    Scn3: TComboBox;
    Trk3: TComboBox;
    L3: TSpinEdit;
    C3: TSpinEdit;
    T3: TComboBox;
    Scn4: TComboBox;
    Trk4: TComboBox;
    L4: TSpinEdit;
    C4: TSpinEdit;
    T4: TComboBox;
    Scn5: TComboBox;
    Trk5: TComboBox;
    L5: TSpinEdit;
    C5: TSpinEdit;
    T5: TComboBox;
    Scn6: TComboBox;
    Trk6: TComboBox;
    L6: TSpinEdit;
    C6: TSpinEdit;
    T6: TComboBox;
    L1: TSpinEdit;
    C1: TSpinEdit;
    T1: TComboBox;
    CarSame: TButton;
    Car2_6: TButton;
    TraSame: TButton;
    TraRandom1: TButton;
    Button11: TButton;
    TraRandom2: TButton;
    Button14: TButton;
    Len1: TEdit;
    Len2: TEdit;
    Len3: TEdit;
    Len4: TEdit;
    Len5: TEdit;
    Len6: TEdit;
    GroupBox2: TGroupBox;
    Label70: TLabel;
    TBSimulation: TTrackBar;
    Label85: TLabel;
    TBAI: TTrackBar;
    Label34: TLabel;
    TBMaxDam: TTrackBar;
    Label48: TLabel;
    TBNitro: TTrackBar;
    RandAddons: TCheckBox;
    CBRaceMode: TComboBox;
    Label72: TLabel;
    Label71: TLabel;
    CBCar: TComboBox;
    CBAnyCar: TCheckBox;
    Scn7: TComboBox;
    Trk7: TComboBox;
    L7: TSpinEdit;
    Len7: TEdit;
    C7: TSpinEdit;
    T7: TComboBox;
    DistSame: TBitBtn;
    Dist_5km: TBitBtn;
    Dist_40km: TBitBtn;
    Dist_100km: TBitBtn;
    GroupBox3: TGroupBox;
    Label139: TLabel;
    M_Name: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    M_ResultTyp: TComboBox;
    Label7: TLabel;
    Label50: TLabel;
    Label4: TLabel;
    Label74: TLabel;
    M_Cash: TSpinEdit;
    M_Score: TSpinEdit;
    M_Class: TSpinEdit;
    M_NumRaces: TSpinEdit;
    M_Gold: TMemo;
    Label22: TLabel;
    Label30: TLabel;
    M_Silver: TMemo;
    M_Bronze: TMemo;
    Label49: TLabel;
    Label20: TLabel;
    M_Fail: TMemo;
    M_EventCode: TComboBox;
    M_InitCShip: TComboBox;
    M_Author: TEdit;
    M_Contact: TEdit;
    Label68: TLabel;
    Label58: TLabel;
    Label82: TLabel;
    Label3: TLabel;
    GroupBox4: TGroupBox;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label150: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label83: TLabel;
    Label99: TLabel;
    Label123: TLabel;
    Label126: TLabel;
    M_BonusID: TComboBox;
    M_CarID: TComboBox;
    M_TrackID: TComboBox;
    M_Laps: TSpinEdit;
    M_StartPos: TSpinEdit;
    M_LeadMeter: TSpinEdit;
    M_LeadPos: TSpinEdit;
    M_Nitro: TSpinEdit;
    M_Traffic: TSpinEdit;
    M_RaceMode: TComboBox;
    M_MinPlace: TSpinEdit;
    M_AvSpeed: TSpinEdit;
    M_Drifts: TSpinEdit;
    M_FinishLeadTime: TSpinEdit;
    M_MaxDamage: TSpinEdit;
    M_TopSpeed: TSpinEdit;
    M_TopSpeedNum: TSpinEdit;
    M_OppStrength: TSpinEdit;
    M_DriveModel: TSpinEdit;
    SpinEdit20: TSpinEdit;
    SpinEdit21: TSpinEdit;
    M_CarFilter: TSpinEdit;
    M_TrackFilter: TSpinEdit;
    M_OppCar1: TComboBox;
    M_OppCar2: TComboBox;
    M_OppCar3: TComboBox;
    M_OppCar4: TComboBox;
    M_OppCar5: TComboBox;
    M_InitCode: TSpinEdit;
    M_HeadlineText: TMemo;
    M_MissionText: TMemo;
    M_SuccessText: TMemo;
    M_FailText: TMemo;
    M_Leadtime: TFloatSpinEdit;
    M_MaxLapTime: TFloatSpinEdit;
    M_RaceTime: TFloatSpinEdit;
    M_EventC: TComboBox;
    M_InitOppCars: TComboBox;
    M_NumDrivers: TComboBox;
    TC_Race: TTabControl;
    procedure FormCreate(Sender: TObject);
    procedure OpenDS(Sender: TObject; filename:string);
    procedure SearchSceneries(Sender: TObject);
    procedure SearchAutos(Sender: TObject);
    procedure GetAutoInfo(s1:string;i1:integer);
    procedure GetSceneryInfo(s1:string;i1:integer);
    procedure CLBSceneriesClick(Sender: TObject);
    procedure LBTracksClick(Sender: TObject);
    procedure GetMissionInfo(s1:string);
    procedure RefreshSceneryList(Sender: TObject);
    procedure CollectCustomMissionData(Sender: TObject);
    procedure SceneryRandom(Sender: TObject);
    procedure LapRandom(Sender: TObject);
    procedure CarRandom(Sender: TObject);
    procedure AllRandomClick(Sender: TObject);
    procedure TBChange(Sender: TObject);
    procedure TrafficRandom(Sender: TObject);
    procedure ListCars0Click(Sender: TObject);
    procedure CBRaceModeChange(Sender: TObject);
    procedure RefreshTrackList(Sender: TObject);
    procedure RefreshLengths(Sender: TObject);
    procedure AssignChart(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure TC_RaceChange(Sender: TObject);
    procedure M_DriversChange(Sender: TObject);
    procedure M_NumRacesChange(Sender: TObject);
    procedure LoadMissionClick(Sender: TObject);
    procedure SetMissionDataToUI(Sender: TObject);
    procedure CBCarsChange(Sender: TObject);
    procedure UpdateCarInfo(ID:integer; AddOn:boolean);
    procedure GetDataFromUI(Sender: TObject);
    procedure SetDataToUI();
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  f:file;
  ft:textfile;
  c:array[1..1024000]of char;
  i,j,k,m,h:integer;
  s:string;
  RootDir:string;
  TimeCode:integer;
  zz:string='     ';//+'                                                                                   ';
  AddOnCarPrefix:string='`';

  ForbidRefreshSceneryList:boolean=false;
  Scn:array[1..8]of TComboBox;
  Trk:array[1..8]of TComboBox;
  Lap:array[1..8]of TSpinEdit;
  Car:array[1..8]of TSpinEdit;
  Nit:array[1..8]of TComboBox;
  Tra:array[1..8]of TComboBox;
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
  EC_DSqty:integer;

  EC_TB:array[1..3] of record //2+1
  Entries,Index:integer;   //VA_Index
  Cond:byte;       //Cond switch
  CondText:array of string; //Cond text
  end;

  EC_CO:array[1..3] of array[1..512] of record
  Entries,Index:integer;   //VA_Index
  end;

  EC_Value:array[1..3] of array[1..512] of array of record
  Typ:byte; Int:integer; Rel:single; Str:string; end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  AddonCarQty:integer;
  AddonCar:array[1..1024]of record
  Folder:string;
  Factory,Model,Name:string;
  Score,MenuClass,RaceClass:integer;
  end;
  CarsInClass:array[1..1024]of integer;

  AddonSceneryQty:integer;
    AddonScenery:array[1..128]of record
    Folder:string;
    EngineName,BGround,Name,SceneryFlag:string;
    FreeRideID,FreeRideID_abs,TrackQty:integer;
      Track:array[1..32]of record
      TrackNo:byte;
      Name:string;
      CheckPoint:byte;
      mDistance:integer;
      Direction:byte;
      WayPoint:byte;
      Maps:string;
      TypeID:byte;
      NumSections,Order:byte;
      end;
    Author,Converter,Contact,Comment:string;
    end;
    TotalTracks:record
      Stock:record Circuit,Asphaltz,Rallyz,OffRoadz:word; end;
      AddOn:record Circuit,Asphaltz,Rallyz,OffRoadz:word; end;
    circuit,asphaltz,rallyz,offroadz:array[1..1024]of word;
    Qty:array[1..8]of word;
    end;

    AddonMission:record
     FileName:string;
     //Index
     EventCode:byte;
     Score:integer;
     //FlagRelease
     //NumDrives
     NumRaces:byte;
     MissionName:string;
     ResultTyp:byte;
     //Result
     RefTextFail,RefText1,RefText2,RefText3:string;
     //ReleaseMission
     //ResultCash
     MissionClass,DefCash:integer;
     InitCShip:byte;
     Author,Contact:string; //Version 2+
     Comment,CarName,TrackName:string; //Version 3+

     Race:array[1..32]of record
       HeadLineText:string;
       BonusID,CarID,TrackID,NumLaps,NumDrivers,StartPosition,
       LeadTime,LeadMeter,LeadPositions,Nitro,Traffic,
       RaceMode:word;
       MissionText:string;
       MinPlace,AvgSpeed,Drifts,FinishLeadTime,MaxDamage,
       RaceTime,MaxLapTime,TopSpeed,TopSpeedNum,
       OppStrength,DriveModel,MissionID,MissionRaceOrder,
       TrackFilter,CarFilter,EventCode,InitOppCars,
       OppCar1,OppCar2,OppCar3,OppCar4,OppCar5:word;
       TextSuccess,TextFail:string;
       InitCode:word;
      end;
    end;
  MNode:array[1..1024]of TTreeNode;
  MRaceOld:integer=1;

  OldPosition:byte=0;

  MissionEditorRefresh:boolean=false;

implementation

{$R *.dfm}
uses SupprtUnit2;

procedure TForm1.FormCreate(Sender: TObject);
var wr2ds:string;
begin
Randomize;
//ChDir('E:\World Racing 2\');
//zz:='   ';
RootDir:=getcurrentdir;//+'\\\';
wr2ds:=RootDir+'\FrontEnd\wr2.ds';
CopyFile(@wr2ds[1],@(decs(wr2ds,2,1)+'bak')[1],true);
//MessageBox(Form1.Handle,'Backup created','Info',MB_OK);
if fileexists(wr2ds) then OpenDS(nil,wr2ds) else begin
  MessageBox(Form1.Handle,'"FrontEnd\wr2.ds" not found. Run EXE from WR2 folder!','Warning',MB_OK);
  Form1.Close;
  exit;
end;
//MessageBox(Form1.Handle,'wr2ds readed and released','Info',MB_OK);
MRaceOld:=1; //MissionRace
TC_Race.TabIndex:=0;
ElapsedTime(@TimeCode);
SearchAutos(nil);         //Form2.Memo1.Lines.Add('Autos - '+ElapsedTime(@TimeCode));
SearchSceneries(nil);     //Form2.Memo1.Lines.Add('Sceneries - '+ElapsedTime(@TimeCode));
//MessageBox(Form1.Handle,'AddOns folder processed or skipped','Info',MB_OK);
RefreshSceneryList(nil);
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

if (i=14)or(i=16)or(i=19)or(i=49) then
setlength(Value[i,k],CO[i,k].Entries+1024) else
setlength(Value[i,k],CO[i,k].Entries+10);//stupid way to avoid common length
for j:=1 to CO[i,k].Entries do begin      //mismatches when adding new stuff
Value[i,k,j].Typ:=0;
Value[i,k,j].Int:=0;
Value[i,k,j].Rel:=0;
Value[i,k,j].Str:='';
blockread(f,c,1);
if c[1]=#1  then begin Value[i,k,j].Typ:=1; blockread(f,Value[i,k,j].Int,4); end;
if c[1]=#2  then begin Value[i,k,j].Typ:=2; blockread(f,Value[i,k,j].Rel,4); end;
if c[1]=#16 then begin Value[i,k,j].Typ:=3; Value[i,k,j].Str:=''; blockread(f,h,4);
                       if h<>0 then begin blockread(f,c,h+1);
                       Value[i,k,j].Str:=StrPas(@c); end; end;
if Value[i,k,j].Typ=0 then exit;

end;//CO.Entries
end;//TB.Entries
end; //1..DSqty
closefile(f);
end;

procedure TForm1.SearchSceneries(Sender: TObject);
var SearchRec:TSearchRec; ii:integer;
begin
ChDir(RootDir);
////////////////////////////////////////////////////////////////////////////////
//Scanning for add-on scenario folders
////////////////////////////////////////////////////////////////////////////////
if not DirectoryExists('AddOns\Sceneries') then begin
//MessageBox(Form1.Handle,'"AddOns\Sceneries\" not found','Warning',MB_OK);
AddonSceneryQty:=0;
//exit;
end else begin
  ChDir('AddOns\Sceneries');
  FindFirst('*', faAnyFile or faDirectory, SearchRec);
  h:=1;
  repeat
    if (SearchRec.Attr and faDirectory<>0)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..')and
    (fileexists(RootDir+'\AddOns\Sceneries\'+SearchRec.Name+'\EditScenery.sc2')) then begin
      AddonScenery[h].Folder:=SearchRec.Name;
      inc(h);
    end;
  until (FindNext(SearchRec)<>0);
  FindClose(SearchRec);
  AddonSceneryQty:=h-1;
  //resorting add-on sceneries for Multi-Players
  for i:=1 to h-1 do //all
    for k:=i+1 to h-1 do  //all following after
      if UpperCase(AddonScenery[i].Folder)>UpperCase(AddonScenery[k].Folder) then
        SwapStr(AddonScenery[i].Folder,AddonScenery[k].Folder);

end;

for ii:=1 to AddonSceneryQty do
if fileexists(AddonScenery[ii].Folder+'\EditScenery.sc2') then
GetSceneryInfo(AddonScenery[ii].Folder,ii);

for i:=2 to 7 do begin  //CO[16,2].Entries
CLBSceneries.AddItem(#160+WRTexte(Value[16,5,i].Str)+zz+int2fix(i-1,2),nil);
CLBSceneries.State[i-2]:=cbGrayed;
CLBSceneries.ItemEnabled[i-2]:=false;
end;

for ii:=1 to AddonSceneryQty do
CLBSceneries.AddItem(AddonScenery[ii].Name+zz+int2fix(ii,2),nil);

 //Reset for the first time
TotalTracks.Stock.Circuit:=0;   TotalTracks.AddOn.Circuit:=0;
TotalTracks.Stock.Asphaltz:=0;   TotalTracks.AddOn.Asphaltz:=0;
TotalTracks.Stock.Rallyz:=0;     TotalTracks.AddOn.Rallyz:=0;
TotalTracks.Stock.OffRoadz:=0;   TotalTracks.AddOn.OffRoadz:=0;

with TotalTracks do
for ii:=1 to 183 do
if Value[14,12,ii+1].Int <> 1 then //Do not include waypoint tracks
case Value[14,16,ii+1].Int of
  1:begin inc(Stock.Circuit);   Circuit[Stock.Circuit]:=ii;     end; //Circuit
  2:begin inc(Stock.Asphaltz);  Asphaltz[Stock.Asphaltz]:=ii;   end; //Asphalt
  3:begin inc(Stock.Rallyz);    Rallyz[Stock.Rallyz]:=ii;       end; //Rally
  4:begin inc(Stock.OffRoadz);  OffRoadz[Stock.OffRoadz]:=ii;   end; //OffRoad
end;

{h:=183; with TotalTracks do
for ii:=1 to AddonSceneryQty do for kk:=1 to AddonScenery[ii].TrackQty do begin inc(h);
case AddonScenery[ii].Track[kk].TypeID of
1:begin inc(AddOn.Circuit);     Circuit[Stock.Circuit+AddOn.Circuit]:=h;     end;
2:begin inc(AddOn.Asphaltz);    Asphaltz[Stock.Asphaltz+AddOn.Asphaltz]:=h;  end;
3:begin inc(AddOn.Rallyz);      Rallyz[Stock.Rallyz+AddOn.Rallyz]:=h;        end;
4:begin inc(AddOn.OffRoadz);    OffRoadz[Stock.OffRoadz+AddOn.OffRoadz]:=h;  end;
end; end; }

with TotalTracks do begin     //Make list of incremental bounds
Qty[1]:=       Stock.Circuit; //for easier randomization
Qty[2]:=Qty[1]+Stock.Asphaltz;//waypoint does not involved yet
Qty[3]:=Qty[2]+Stock.Rallyz;
Qty[4]:=Qty[3]+Stock.OffRoadz;
Qty[5]:=Qty[4]+AddOn.Circuit;
Qty[6]:=Qty[5]+AddOn.Asphaltz;
Qty[7]:=Qty[6]+AddOn.Rallyz;
Qty[8]:=Qty[7]+AddOn.OffRoadz;
end;

Label47.Caption:='Total of 183 + '+inttostr(h-183)+' = '+inttostr(h)+' Tracks';

M_TrackID.Clear; m:=0;
for i:=2 to 184 do //184 is base number of WR2 tracks
M_TrackID.Items.Add(WRTexte(Value[14,4,i].Str)+zz+int2fix(i-1,3));
{for i:=1 to AddonSceneryQty do
  if AddonScenery[i].Install then
    for k:=1 to AddonScenery[i].TrackQty do begin
    inc(m);
    M_TrackID.Items.Add(AddonScenery[i].Track[k].Name+zz+inttostr(183+m));
    end;      }
M_TrackID.ItemIndex:=0;
end;

procedure TForm1.GetSceneryInfo(s1:string; i1:integer);
begin
assignfile(f,s1+'\EditScenery.sc2'); FileMode:=0; reset(f,1); FileMode:=2; //read-only
blockread(f,c,4); if c[1]+c[2]+c[3]+c[4]<>'WR2'+#1 then exit;
blockread(f,c,2); //Chapters
with AddonScenery[i1] do begin
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); EngineName:=StrPas(@c); end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); BGround:=StrPas(@c); end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Name:=StrPas(@c); end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); SceneryFlag:=StrPas(@c); end;
blockread(f,FreeRideID,2);
blockread(f,TrackQty,2);
for k:=1 to TrackQty do with AddonScenery[i1].Track[k] do begin
blockread(f,TrackNo,2);
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Name:=StrPas(@c); end;
blockread(f,CheckPoint,2);
blockread(f,mDistance,2);
blockread(f,Direction,2);
blockread(f,WayPoint,2);
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Maps:=StrPas(@c); end;
blockread(f,TypeID,2);
blockread(f,NumSections,2);
blockread(f,Order,2);
end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Author:=StrPas(@c); end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Converter:=StrPas(@c); end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Contact:=StrPas(@c); end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Comment:=StrPas(@c); end;

end;

closefile(f);
end;

procedure TForm1.SearchAutos(Sender: TObject);
var SearchRec:TSearchRec; ii,kk,jj,t:integer;
begin
ChDir(RootDir); AddonCarQty:=0;
if not DirectoryExists('AddOns\autos') then begin
//MessageBox(Form1.Handle,'"AddOns\autos\" not found','Warning',MB_OK);
//exit;
end else begin
ChDir('AddOns\autos');
  FindFirst('*', faAnyFile or faDirectory, SearchRec);
  h:=1;
  repeat
  if (SearchRec.Attr and faDirectory<>0)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then
  if fileexists(RootDir+'\AddOns\autos\'+SearchRec.Name+'\EditCar.car') then begin
  AddonCar[h].Folder:=SearchRec.Name;
  inc(h); end;
  until (FindNext(SearchRec)<>0);
  FindClose(SearchRec);
  AddonCarQty:=h-1;
end;


for ii:=1 to AddonCarQty do begin //don't use (i) here
GetAutoInfo(AddonCar[ii].Folder,ii);
if AddonCar[ii].Factory<>'' then
AddonCar[ii].Name:=' '+AddonCar[ii].Factory+' '+AddonCar[ii].Model else
AddonCar[ii].Name:=' '+AddonCar[ii].Model;
CBCars.AddItem(AddOnCarPrefix+AddonCar[ii].Name+zz+inttostr(ii),nil);
end;

for i:=2 to CO[24,3].Entries do
CBCars.AddItem(#160+Value[24,44,i].Str+' '+Value[24,3,i].Str+zz+inttostr(i-1),nil);

CBCars.ItemIndex:=0;

//IDs:=0;
ListCars2.AddItem('',nil);
for k:=1 to 1024 do begin
  for i:=2 to CO[24,3].Entries do
  if Value[24,7,i].Int=k then begin
  ListCars2.AddItem(#160+Value[24,44,i].Str+' '+Value[24,3,i].Str+zz+inttostr(i-1)+' '+inttostr(Value[24,4,i].Int),nil);
  inc(CarsInClass[k]);
  end;
  for ii:=1 to AddonCarQty do
  if AddonCar[ii].MenuClass=k then begin
  ListCars2.AddItem(AddOnCarPrefix+AddonCar[ii].Name+zz+inttostr(ii)+' '+inttostr(AddonCar[ii].Score),nil);
  inc(CarsInClass[k]);
  end;
  if ListCars2.Items.Strings[ListCars2.Count-1]<>'' then begin
  ListCars2.AddItem('',nil);
  //inc(IDs);
  end;
end;

t:=0;
for ii:=1 to 1024 do begin
if CarsInClass[ii]<>0 then inc(t);
for kk:=1 to CarsInClass[ii] do begin
  for jj:=1 to kk-1 do
  if IDfromSTR(ListCars2.Items[kk-1+t],1)<IDfromSTR(ListCars2.Items[jj-1+t],1) then begin //previous is empty row
  ListCars2.Items.Insert(jj-1+t,ListCars2.Items[kk-1+t]);
  ListCars2.Items.Delete(kk-1+t+1);          //Delete moved text
  end;
//inc(t);
end;
inc(t,CarsInClass[ii]);
end;                           

for i:=2 to ListCars2.Count-1 do
for k:=2 to i-1 do begin
if (ListCars2.Items[i-2]='')and //compare by groups
   (ListCars2.Items[k-2]='')and
((IDfromSTR(ListCars2.Items[k-1],1))
>(IDfromSTR(ListCars2.Items[i-1],1)))
then begin //compare Scores
t:=0;
repeat
ListCars2.Items.Insert(k-1+t,ListCars2.Items[i-1+t]);
inc(t);
ListCars2.Items.Delete(i-1+t);          //Delete moved text
until(ListCars2.Items[i-1+t]='');       //until empty moved
ListCars2.Items.Insert(k-1+t,'');       //add spacer
ListCars2.Items.Delete(i-1+t+1);        //delete old spacer
break;
end;
end;

ListCars2.Items.Delete(ListCars2.Count-1); //Delete last empty

Label86.Caption:=inttostr(CO[24,3].Entries-1)+'+'+inttostr(AddonCarQty)+'='+inttostr(CO[24,3].Entries-1+AddonCarQty)+' Cars';

M_CarID.Clear;
M_OppCar1.Clear; M_OppCar2.Clear; M_OppCar3.Clear; M_OppCar4.Clear; M_OppCar5.Clear;
M_OppCar1.Items.Add(' Same car'+zz+'0'); M_OppCar2.Items.Add(' Same car'+zz+'0');
M_OppCar3.Items.Add(' Same car'+zz+'0'); M_OppCar4.Items.Add(' Same car'+zz+'0');
M_OppCar5.Items.Add(' Same car'+zz+'0');
for i:=2 to 94 do begin//94 is base number of WR2 cars
M_CarID.Items.Add(Value[24,44,i].Str+' '+Value[24,3,i].Str+zz+inttostr(i-1));
M_OppCar1.Items.Add(Value[24,44,i].Str+' '+Value[24,3,i].Str+zz+inttostr(i-1));
M_OppCar2.Items.Add(Value[24,44,i].Str+' '+Value[24,3,i].Str+zz+inttostr(i-1));
M_OppCar3.Items.Add(Value[24,44,i].Str+' '+Value[24,3,i].Str+zz+inttostr(i-1));
M_OppCar4.Items.Add(Value[24,44,i].Str+' '+Value[24,3,i].Str+zz+inttostr(i-1));
M_OppCar5.Items.Add(Value[24,44,i].Str+' '+Value[24,3,i].Str+zz+inttostr(i-1));
end;
{for i:=1 to AddonCarQty do begin
s:=AddonCar[i].Model+zz+inttostr(93+i);
if AddonCar[i].Factory<>'' then s:=AddonCar[i].Factory+' '+s;
M_CarID.Items.Add(s);
end;             }
M_CarID.ItemIndex:=0;
M_OppCar1.ItemIndex:=0; M_OppCar2.ItemIndex:=0; M_OppCar3.ItemIndex:=0;
M_OppCar4.ItemIndex:=0; M_OppCar5.ItemIndex:=0;
end;

procedure TForm1.GetAutoInfo(s1:string;i1:integer);
var NumRead,Pos:integer;
begin
Pos:=0; //reset to 0
assignfile(f,RootDir+'\AddOns\autos\'+s1+'\EditCar.car'); FileMode:=0; reset(f,128); FileMode:=2;
blockread(f,c,1000,NumRead); closefile(f); //reading 128kbytes should be enough (usually ~30kb)
EC_DSqty:=ord(c[Pos+9]);
inc(Pos,33);
for i:=1 to EC_DSqty do begin
EC_TB[i].Entries:=ord(c[Pos+9])+ord(c[Pos+10])*256;
if ord(c[Pos+30])<>0 then inc(Pos,ord(c[Pos+30])+1);//blockread(f,c,ord(c[30])+1);
inc(Pos,33);

for k:=1 to EC_TB[i].Entries do begin
if (c[Pos+1]+c[Pos+2]+c[Pos+3]+c[Pos+4])<>'NDCO' then begin
inc(Pos,4);
EC_TB[i].Cond:=int2(c[Pos+1],c[Pos+2]);
inc(Pos,4);
setlength(EC_TB[i].CondText,EC_TB[i].Cond+1);
  for j:=1 to EC_TB[i].Cond do begin
  inc(Pos,int2(c[Pos+1],c[Pos+2])+1);  //reading upside-down
  inc(Pos,4);
  for m:=1 to h do EC_TB[i].CondText[j]:=EC_TB[i].CondText[j]+c[m];
  end;
//read upcoming NDCO
//inc(Pos,4);
end;
inc(Pos,4);
//VAEn, VAId, VALb
EC_CO[i,k].Entries:=ord(c[Pos+5])+ord(c[Pos+6])*256;
j:=ord(c[Pos+21]); inc(Pos,24); if j<>0 then inc(Pos,j+1);//VAEn, VAId, VALb
j:=ord(c[Pos+10]); inc(Pos,13); if j<>0 then inc(Pos,j+1);//VASM
j:=ord(c[Pos+5]);  inc(Pos, 8); if j<>0 then inc(Pos,j+1);//VAST
j:=ord(c[Pos+5]);  inc(Pos, 8); if j<>0 then inc(Pos,j+1);//VAIC
j:=ord(c[Pos+5]);  inc(Pos, 8); if j<>0 then inc(Pos,j+1);//VASC

setlength(EC_Value[i,k],EC_CO[i,k].Entries+1);//optimistic way to avoid common length mismatches
for j:=1 to EC_CO[i,k].Entries do begin
EC_Value[i,k,j].Typ:=0; EC_Value[i,k,j].Int:=0; EC_Value[i,k,j].Rel:=0; EC_Value[i,k,j].Str:='';
if c[Pos+1]=#1  then begin
            EC_Value[i,k,j].Typ:=1; EC_Value[i,k,j].Int:=int2(c[Pos+2],c[Pos+3],c[Pos+4],c[Pos+5]); inc(Pos,5); end;
if c[Pos+1]=#2  then begin
            EC_Value[i,k,j].Typ:=2; EC_Value[i,k,j].Rel:=real2(c[Pos+2],c[Pos+3],c[Pos+4],c[Pos+5]); inc(Pos,5); end;
if c[Pos+1]=#16 then begin
            EC_Value[i,k,j].Typ:=3; h:=int2(c[Pos+2],c[Pos+3],c[Pos+4],c[Pos+5]); inc(Pos,5);
            for m:=1 to h do EC_Value[i,k,j].Str:=EC_Value[i,k,j].Str+c[Pos+m];
            if h<>0 then inc(Pos,h+1); end;
if EC_Value[i,k,j].Typ=0 then Form1.Close;
end;//CO.Entries
end;//TB.Entries
end; //1..DSqty

if length(EC_Value[2,105])>=2 then //fix for old editcars with few fields
AddonCar[i1].Factory:=EC_Value[2,105,2].Str
else AddonCar[i1].Factory:='';
AddonCar[i1].Model:=EC_Value[2,4,2].Str;
AddonCar[i1].Score:=EC_Value[2,5,2].Int;
AddonCar[i1].MenuClass:=EC_Value[2,8,2].Int;
end;

procedure TForm1.CLBSceneriesClick(Sender: TObject);
var ID,kk:integer;
begin
LBTracks.Clear;
if CLBSceneries.ItemIndex<=5 then begin //6 Stock sceneries
ID:=CLBSceneries.ItemIndex+1;
kk:=1;
for i:=1 to 184 do//184 is base number of WR2 tracks
if Value[14,2,i].Int=ID then begin
LBTracks.AddItem(inttostr(kk)+'. '+WRTexte(Value[14,4,i].Str)+zz+inttostr(i),nil);
inc(kk);
end;
Label8.Caption:=Value[16,2,ID+1].Str;
GBScenery.Caption:='  '+WRTexte(Value[16,5,ID+1].Str)+'  ';
Label11.Caption:=Value[16,7,ID+1].Str;
Label12.Caption:=WRTexte(Value[14,4,Value[16,8,ID+1].Int+1].Str);
Label39.Caption:='Synetic';
Label40.Caption:='-';
Label44.Caption:='www.synetic.de';
Label46.Caption:='Stock WR2 scenery';
end;
if CLBSceneries.ItemIndex>5 then begin //add-on sceneries
ID:=CLBSceneries.ItemIndex-6+1;
for i:=1 to AddonScenery[ID].TrackQty do
LBTracks.AddItem(inttostr(i)+'. '+AddonScenery[ID].Track[i].Name,nil);
Label8.Caption:=AddonScenery[ID].EngineName;
GBScenery.Caption:='  '+AddonScenery[ID].Name+'  ';
Label11.Caption:=AddonScenery[ID].SceneryFlag;
Label12.Caption:=AddonScenery[ID].Track[AddonScenery[ID].FreeRideID].Name;
Label39.Caption:=AddonScenery[ID].Author;
Label40.Caption:=AddonScenery[ID].Converter;
Label44.Caption:=AddonScenery[ID].Contact;
Label46.Caption:=AddonScenery[ID].Comment;
end;

Label46.Width:=145;
LBTracks.ItemIndex:=0;
LBTracksClick(nil);
end;

procedure TForm1.LBTracksClick(Sender: TObject);
var ID,ID2:integer;
begin
if CLBSceneries.ItemIndex<=5 then begin
ID2:=IDfromSTR(LBTracks.Items[LBTracks.ItemIndex],1);
Label21.Caption:=inttostr(Value[14,3,ID2].Int);
GBTrack.Caption:='  '+WRTexte(Value[14,4,ID2].Str)+'  ';
Label23.Caption:=inttostr(Value[14,5,ID2].Int);
Label24.Caption:=inttostr(Value[14,9,ID2].Int)+' m';
if Value[14,10,ID2].Int=1 then Label25.Caption:='ClockWise' else
if Value[14,10,ID2].Int=2 then Label25.Caption:='CounterClockWise' else Label25.Caption:='<<<LEER>>>';
Label26.Caption:=inttostr(Value[14,12,ID2].Int);
Label27.Caption:=Value[14,13,ID2].Str;
Label28.Caption:=inttostr(Value[14,16,ID2].Int);
Label29.Caption:=inttostr(Value[14,25,ID2].Int);
end;
if CLBSceneries.ItemIndex>5 then begin
ID:=CLBSceneries.ItemIndex-6+1; ID2:=LBTracks.ItemIndex+1;
with AddonScenery[ID].Track[ID2] do begin
Label21.Caption:=inttostr(TrackNo);
GBTrack.Caption:='  '+Name+'  ';
Label23.Caption:=inttostr(CheckPoint);
Label24.Caption:=inttostr(mDistance)+' m';
if Direction=1 then Label25.Caption:='ClockWise' else
if Direction=2 then Label25.Caption:='CounterClockWise' else Label25.Caption:='<<<LEER>>>';
Label26.Caption:=inttostr(WayPoint);
Label27.Caption:=Maps;
Label28.Caption:=inttostr(TypeID);
Label29.Caption:=inttostr(NumSections);
end;
end;
end;

procedure TForm1.GetMissionInfo(s1:string);
var version:byte;
begin
assignfile(f,s1); FileMode:=0; reset(f,1); FileMode:=2; //read-only
blockread(f,c,4);
version:=ord(c[4]);
if (c[1]+c[2]+c[3]<>'WR2') then exit;
blockread(f,c,2); //=1
with AddonMission do begin //mission maker ID
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); MissionName:=StrPas(@c); end;
blockread(f,EventCode,2);
blockread(f,ResultTyp,2);
blockread(f,NumRaces,2);
blockread(f,MissionClass,2);
blockread(f,Score,2);
blockread(f,DefCash,2);
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); RefText1:=StrPas(@c); end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); RefText2:=StrPas(@c); end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); RefText3:=StrPas(@c); end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); RefTextFail:=StrPas(@c); end;
blockread(f,InitCShip,2);
for k:=1 to NumRaces do begin
blockread(f,c,2); //=ID
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Race[k].HeadLineText:=StrPas(@c); end;
blockread(f,Race[k].BonusID,24);
{blockread(f,Race[k].CarID,2);
blockread(f,Race[k].TrackID,2);
blockread(f,Race[k].NumLaps,2);
blockread(f,Race[k].NumDrivers,2);
blockread(f,Race[k].StartPosition,2);
blockread(f,Race[k].LeadTime,2);
blockread(f,Race[k].LeadMeter,2);
blockread(f,Race[k].LeadPositions,2);
blockread(f,Race[k].Nitro,2);
blockread(f,Race[k].Traffic,2);
blockread(f,Race[k].RaceMode,2);}
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Race[k].MissionText:=StrPas(@c); end;
blockread(f,Race[k].MinPlace,22);
{blockread(f,Race[k].AvgSpeed,2);
blockread(f,Race[k].Drifts,2);
blockread(f,Race[k].FinishLeadTime,2);
blockread(f,Race[k].MaxDamage,2);
blockread(f,Race[k].RaceTime,2);
blockread(f,Race[k].MaxLapTime,2);
blockread(f,Race[k].TopSpeed,2);
blockread(f,Race[k].TopSpeedNum,2);
blockread(f,Race[k].OppStrength,2);
blockread(f,Race[k].DriveModel,2);}
blockread(f,c,2); //MissionID
blockread(f,c,2); //MissionRaceOrder
blockread(f,Race[k].TrackFilter,2);
blockread(f,Race[k].CarFilter,2);
blockread(f,Race[k].EventCode,2);
blockread(f,Race[k].InitOppCars,2);
blockread(f,Race[k].OppCar1,2);
blockread(f,Race[k].OppCar2,2);
blockread(f,Race[k].OppCar3,2);
blockread(f,Race[k].OppCar4,2);
blockread(f,Race[k].OppCar5,2);
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Race[k].TextSuccess:=StrPas(@c); end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Race[k].TextFail:=StrPas(@c); end;
blockread(f,Race[k].InitCode,2);
end; //..NumRaces
if version>=2 then begin
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Author:=StrPas(@c); end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Contact:=StrPas(@c); end;
end;
if version>=3 then begin
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Comment:=StrPas(@c); end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); CarName:=StrPas(@c); end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); TrackName:=StrPas(@c); end;
end;

end; //..with
closefile(f);
end;

procedure TForm1.RefreshSceneryList(Sender: TObject);
var ScnID:array[1..8] of integer;
begin
  if ForbidRefreshSceneryList then exit;
  ForbidRefreshSceneryList:=true;
  AssignChart(nil);

  for i:=1 to TBRaceQty.Position do begin  //Refresh scenery list in case it changed
    ScnID[i]:=Scn[i].ItemIndex; Scn[i].Clear;
    for k:=1 to 6 do Scn[i].AddItem(Value[16,2,k+1].Str,nil);
    if RandAddons.Checked then for k:=1 to AddOnSceneryQty do Scn[i].AddItem(AddonScenery[k].Name,nil);
    if ScnID[i]>=Scn[i].Items.Count then ScnID[i]:=Scn[i].Items.Count-1;
    Scn[i].ItemIndex:=ScnID[i];
    Scn[i].Enabled:=true; Trk[i].Enabled:=true; Lap[i].Enabled:=true;
    Car[i].Enabled:=true; Tra[i].Enabled:=true;
  end;

  for i:=TBRaceQty.Position+1 to TBRaceQty.Max do begin //Disable unused
    Scn[i].Enabled:=false; Trk[i].Enabled:=false; Lap[i].Enabled:=false;
    Car[i].Enabled:=false; Tra[i].Enabled:=false;
  end;
  ForbidRefreshSceneryList:=false;
  OldPosition:=TBRaceQty.Position;
  RefreshTrackList(nil);
end;

procedure TForm1.RefreshTrackList(Sender: TObject);
var
  ii,kk:integer;
  TrkID:array[1..8] of integer;
begin
  for ii:=1 to TBRaceQty.Position do begin
    TrkID[ii]:=Trk[ii].ItemIndex;
    Trk[ii].Clear;

    for kk:=1 to 183 do
      if Value[14,2,kk+1].Int=Scn[ii].ItemIndex+1 then //Tracks that belong to current scenery
        if Value[14,12,kk+1].Int <> 1 then //Exclude waypoint tracks
        Trk[ii].AddItem(WRTexte(Value[14,4,kk+1].Str)+zz+int2fix(kk,3),nil);

    //If there are any add-on sceneries to be included they start from Index 6
    if (RandAddons.Checked)and(Scn[ii].ItemIndex-5>=1) then
      for kk:=1 to AddonScenery[Scn[ii].ItemIndex-5].TrackQty do
        Trk[ii].AddItem(AddonScenery[Scn[ii].ItemIndex-5].Track[kk].Name,nil);

    Trk[ii].ItemIndex:=min(TrkID[ii],Trk[ii].Items.Count-1);
  end;
RefreshLengths(nil);
end;

procedure TForm1.RefreshLengths(Sender: TObject);
var ii,kk:integer;
begin
for ii:=1 to TBRaceQty.Position do begin
if  Scn[ii].ItemIndex=-1 then
s:=s else
if Scn[ii].ItemIndex<6 then begin
kk:=strtoint(decs(Trk[ii].Text,-length(Trk[ii].Text)+3,1));
s:=floattostr(Lap[ii].Value*Value[14,9,kk+1].Int/1000)+' km';
end else s:=floattostr(Lap[ii].Value*AddonScenery[Scn[ii].ItemIndex-5].Track[Trk[ii].ItemIndex+1].mDistance/1000)+' km';
case ii of
1: Len1.Text:=s; 2: Len2.Text:=s;
3: Len3.Text:=s; 4: Len4.Text:=s;
5: Len5.Text:=s; 6: Len6.Text:=s;
end;
end;
end;

procedure TForm1.CollectCustomMissionData(Sender: TObject);
begin
RefreshSceneryList(nil);
with AddonMission do begin
FileName:='CustomMission';
Author:='MissionMaker';
Contact:='http://krom.reveur.de';
case CBRaceMode.ItemIndex of
0: EventCode:=6; //Simple
1: EventCode:=9; //Champ
2: EventCode:=4; //KO
3: EventCode:=6; //empty
end;
Score:=0;
NumRaces:=TBRaceQty.Position;
MissionName:='Custom Mission';
ResultTyp:=1;
RefTextFail:='Failed';
RefText1:='Gold';
RefText2:='Silver';
RefText3:='Bronze';
MissionClass:=73+1;
DefCash:=100*TBRaceQty.Position;
InitCShip:=0;
NumRaces:=TBRaceQty.Position;
for k:=1 to TBRaceQty.Position do begin
Race[k].HeadLineText:='Race #'+inttostr(k);
Race[k].BonusID:=0;
Race[k].CarID:=1;
Race[k].TrackID:=IDFromStr(Trk[k].Text,1);
Race[k].NumLaps:=Lap[k].Value;
Race[k].NumDrivers:=Car[k].Value;
Race[k].StartPosition:=Car[k].Value; //Last
Race[k].LeadTime:=0;
Race[k].LeadMeter:=0;
Race[k].LeadPositions:=0;
Race[k].Nitro:=TBNitro.Position*25;
Race[k].Traffic:=Tra[k].ItemIndex*25; //0..25..50..75..100
case CBRaceMode.ItemIndex of //3-WayPoint 4-CP Off-road 1-Default 7-KO Race 5-CheckpointRace
0: Race[k].RaceMode:=1; //Simple
1: Race[k].RaceMode:=1; //Champ
2: Race[k].RaceMode:=7; //KO
3: Race[k].RaceMode:=1; //empty
end;
Race[k].MissionText:='Custom Mission';
Race[k].MinPlace:=0;
Race[k].AvgSpeed:=0;
Race[k].Drifts:=0;
Race[k].FinishLeadTime:=0; //Lead by N x 10ms
Race[k].MaxDamage:=TBMaxDam.Position; //0=off
Race[k].RaceTime:=0;
Race[k].MaxLapTime:=0;
Race[k].TopSpeed:=0;
Race[k].TopSpeedNum:=0;
Race[k].OppStrength:=TBAI.Position;
Race[k].DriveModel:=TBSimulation.Position;
//Race[k].MissionID:=73+AddonMissionQty;
//Race[k].MissionRaceOrder:=k;
Race[k].TrackFilter:=0;
Race[k].CarFilter:=65000*byte(CBAnyCar.Checked);
Race[k].EventCode:=0;
Race[k].InitOppCars:=2;
Race[k].OppCar1:=0;
Race[k].OppCar2:=0;
Race[k].OppCar3:=0;
Race[k].OppCar4:=0;
Race[k].OppCar5:=0;
Race[k].TextSuccess:='Success';
Race[k].TextFail:='Fail';
Race[k].InitCode:=0;
end;//1..RaceQty
end;//with AddonMission[i] do ..
end;

procedure TForm1.SceneryRandom(Sender: TObject);
var k:integer;

  procedure SetScnTrk(ID,TrackID:integer);
    begin
      Scn[ID].ItemIndex:=Value[14,2,TrackID].Int-1;
      RefreshTrackList(nil);
      Trk[ID].ItemIndex:=Value[14,3,TrackID].Int-1;
    end;

begin
  ForbidRefreshSceneryList:=true;

  //All sceneries/tracks the same as first
  if sender=ScnSame then begin
    for i:=1 to TBRaceQty.Position do
      Scn[i].ItemIndex:=Scn[1].ItemIndex;
    RefreshTrackList(nil);
    for i:=1 to TBRaceQty.Position do
      Trk[i].ItemIndex:=Trk[1].ItemIndex;
  end;

  //All sceneries same as first, but tracks are random
  if sender=ScnSameRandom then begin
    for i:=1 to TBRaceQty.Position do
      Scn[i].ItemIndex:=Scn[1].ItemIndex;
    RefreshTrackList(nil);
    for i:=1 to TBRaceQty.Position do
      Trk[i].ItemIndex:=random(Trk[i].Items.Count);
  end;

  for i:=1 to TBRaceQty.Position do
    if sender=ScnRandom then //Make randomization 50/50 dependable on sceneries/tracks quantity
  //if random(2)=0 then
 {   begin //Randomize tracks by scenery
    if RandAddons.Checked then
    Scn[i].ItemIndex:=random(6+AddOnSceneryQty)+1 else
    Scn[i].ItemIndex:=random(6)+1;
    RefreshTrackList(nil);
    Trk[i].ItemIndex:=random(Trk[i].Items.Count);
    end; else }
    begin

{    if RandAddons.Checked then          //1..x Random of all excluding WP
      k:=random(TotalTracks.Qty[6])+1
    {else }
      k:=random(TotalTracks.Qty[3])+1;

    if InRange(k,1,TotalTracks.Qty[1]) then //Circuit
      SetScnTrk(i,TotalTracks.Circuit[k]+1);

    if InRange(k,TotalTracks.Qty[1]+1,TotalTracks.Qty[2]) then //Asphalt
      SetScnTrk(i,TotalTracks.rallyz[ k-TotalTracks.Qty[1] ]+1);

    if InRange(k,TotalTracks.Qty[2]+1,TotalTracks.Qty[3]) then //Rally
      SetScnTrk(i,TotalTracks.rallyz[ k-TotalTracks.Qty[2] ]+1);

    if InRange(k,TotalTracks.Qty[3]+1,TotalTracks.Qty[4]) then //OffRoad
      SetScnTrk(i,TotalTracks.offroadz[ k-TotalTracks.Qty[3] ]+1);

{      if InRange(k,TotalTracks.Qty[3]+1,TotalTracks.Qty[4]) then
//        SetScnTrk(i,TotalTracks.asphalt[ k - TotalTracks.Qty[3] + TotalTracks.Stock.Asphalt]+1);
        SetScnTrk(i,1);
      if InRange(k,TotalTracks.Qty[4]+1,TotalTracks.Qty[5]) then
//        SetScnTrk(i,TotalTracks.rally[ k - TotalTracks.Qty[4] + TotalTracks.Stock.Rally ]+1);
        SetScnTrk(i,1);
      if InRange(k,TotalTracks.Qty[5]+1,TotalTracks.Qty[6]) then
//        SetScnTrk(i,TotalTracks.offroad[ k - TotalTracks.Qty[5] + TotalTracks.Stock.OffRoad ]+1);
        SetScnTrk(i,1);  }

    end;
ForbidRefreshSceneryList:=false;
end;

procedure TForm1.LapRandom(Sender: TObject);
begin
for i:=1 to TBRaceQty.Position do
if sender=LapSame then Lap[i].Value:=Lap[1].Value else
if Sender=Lap1_5 then Lap[i].Value:=random(5)+1 else  //0..4 +1
if Sender=Lap4_10 then Lap[i].Value:=random(7)+4 else //0..6 +4
if Sender=Lap10_30 then Lap[i].Value:=random(21)+10;  //0..20 +10
end;

procedure TForm1.CarRandom(Sender: TObject);
begin
if CBRaceMode.ItemIndex<>2 then
for i:=1 to TBRaceQty.Position do
if sender=CarSame then Car[i].Value:=Car[1].Value else
if Sender=Car2_6 then Car[i].Value:=random(5)+2; //2..6
end;

procedure TForm1.AllRandomClick(Sender: TObject);
begin
SceneryRandom(ScnRandom);
LapRandom(Lap1_5);
CarRandom(Car2_6);
TrafficRandom(TraRandom1);
end;

procedure TForm1.TBChange(Sender: TObject);
begin
Label70.Caption:='Sim/Arcade '+inttostr(100-TBSimulation.Position)+'/'
                              +inttostr(TBSimulation.Position);
Label85.Caption:='AI Strength '+inttostr(TBAI.Position)+'%';
Label34.Caption:='Max Damage '+inttostr(TBMaxDam.Position)+'%';
Label48.Caption:='Nitro '+inttostr(TBNitro.Position*25)+'%';
end;

procedure TForm1.TrafficRandom(Sender: TObject);
begin
for i:=1 to TBRaceQty.Position do
if sender=TraSame    then Tra[i].ItemIndex:=Tra[1].ItemIndex else
if Sender=TraRandom1 then Tra[i].ItemIndex:=random(3) else  //0..2
if Sender=TraRandom2 then Tra[i].ItemIndex:=random(2)+3;   //3..4
end;

procedure TForm1.ListCars0Click(Sender: TObject);
var ID:integer;
begin
if ListCars2.Items[ListCars2.ItemIndex]='' then exit;
ID:=IDfromSTR(ListCars2.Items[ListCars2.ItemIndex],2);
UpdateCarInfo(ID,ListCars2.Items[ListCars2.ItemIndex][1]=AddOnCarPrefix);
end;

procedure TForm1.CBRaceModeChange(Sender: TObject);
begin
if CBRaceMode.ItemIndex=2 then begin
TBRaceQty.Height:=141-24;
TBRaceQty.Max:=5;
C1.Value:=6; C1.Enabled:=false;
C2.Value:=5; C2.Enabled:=false;
C3.Value:=4; C3.Enabled:=false;
C4.Value:=3; C4.Enabled:=false;
C5.Value:=2; C5.Enabled:=false;
CarSame.Enabled:=false;
Car2_6.Enabled:=false;
end else begin
TBRaceQty.Height:=141;
TBRaceQty.Max:=6;
C1.Enabled:=true;
C2.Enabled:=true;
C3.Enabled:=true;
C4.Enabled:=true;
C5.Enabled:=true;
CarSame.Enabled:=true;
Car2_6.Enabled:=true;
end;

end;


procedure TForm1.AssignChart(Sender: TObject);
begin
Scn[1]:=Scn1; Scn[2]:=Scn2; Scn[3]:=Scn3; Scn[4]:=Scn4; Scn[5]:=Scn5; Scn[6]:=Scn6;
Trk[1]:=Trk1; Trk[2]:=Trk2; Trk[3]:=Trk3; Trk[4]:=Trk4; Trk[5]:=Trk5; Trk[6]:=Trk6;
Lap[1]:=L1; Lap[2]:=L2; Lap[3]:=L3; Lap[4]:=L4; Lap[5]:=L5; Lap[6]:=L6;
Car[1]:=C1; Car[2]:=C2; Car[3]:=C3; Car[4]:=C4; Car[5]:=C5; Car[6]:=C6;
Tra[1]:=T1; Tra[2]:=T2; Tra[3]:=T3; Tra[4]:=T4; Tra[5]:=T5; Tra[6]:=T6;
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
SaveDialog1.Filter:='WR2 Manager Custom Mission file (*.mis)|*.mis';
SaveDialog1.InitialDir:=RootDir+'\AddOns\Missions\';
if not DirectoryExists(RootDir+'\AddOns\Missions\') then CreateDir(RootDir+'\AddOns\Missions\');
if not SaveDialog1.Execute then exit;
if GetFileExt(SaveDialog1.FileName)<>'MIS' then SaveDialog1.FileName:=SaveDialog1.FileName+'.mis';
assignfile(f,SaveDialog1.FileName); rewrite(f,1);
blockwrite(f,'WR2'+#2,4);//byte4 means file version
blockwrite(f,#1+#0,2);//meaning number of missions in file

if M_Name.Text='' then begin M_Name.Text:='NewMission'; closefile(f); exit; end;
h:=length(M_Name.Text); blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(M_Name.Text,h+1)[1],h+1);
h:=M_EventCode.ItemIndex+1; blockwrite(f,h,2);
h:=M_ResultTyp.ItemIndex+1; blockwrite(f,h,2);
h:=M_NumRaces.Value;      blockwrite(f,h,2);
h:=M_Class.Value;         blockwrite(f,h,2); 
h:=M_Score.Value;         blockwrite(f,h,2); 
h:=M_Cash.Value;          blockwrite(f,h,2); 
h:=length(M_Gold.Lines.GetText);
blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(M_Gold.Lines.GetText,h+1)[1],h+1);
h:=length(M_Silver.Lines.GetText);
blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(M_Silver.Lines.GetText,h+1)[1],h+1);
h:=length(M_Bronze.Lines.GetText);
blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(M_Bronze.Lines.GetText,h+1)[1],h+1);
h:=length(M_Fail.Lines.GetText);
blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(M_Fail.Lines.GetText,h+1)[1],h+1);
h:=M_InitCShip.ItemIndex;     blockwrite(f,h,2);

//TC_RaceClick(nil);
with AddonMission do //mission maker ID
for k:=1 to M_NumRaces.Value do begin
blockwrite(f,k,2);
h:=length(Race[k].HeadLineText);
blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(Race[k].HeadLineText,h+1)[1],h+1);
blockwrite(f,Race[k].BonusID,24);
{blockwrite(f,Race[k].BonusID,2);
blockwrite(f,Race[k].CarID,2);
blockwrite(f,Race[k].TrackID,2);
blockwrite(f,Race[k].NumLaps,2);
blockwrite(f,Race[k].NumDrivers,2);
blockwrite(f,Race[k].StartPosition,2);
blockwrite(f,Race[k].LeadTime,2);
blockwrite(f,Race[k].LeadMeter,2);
blockwrite(f,Race[k].LeadPositions,2);
blockwrite(f,Race[k].Nitro,2);
blockwrite(f,Race[k].Traffic,2);
blockwrite(f,Race[k].RaceMode,2); }
h:=length(Race[k].MissionText);
blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(Race[k].MissionText,h+1)[1],h+1);
blockwrite(f,Race[k].MinPlace,22);
{blockwrite(f,Race[k].MinPlace,2);
blockwrite(f,Race[k].AvgSpeed,2);
blockwrite(f,Race[k].Drifts,2);
blockwrite(f,Race[k].FinishLeadTime,2);
blockwrite(f,Race[k].MaxDamage,2);
blockwrite(f,Race[k].RaceTime,2);
blockwrite(f,Race[k].MaxLapTime,2);
blockwrite(f,Race[k].TopSpeed,2);
blockwrite(f,Race[k].TopSpeedNum,2);
blockwrite(f,Race[k].OppStrength,2);
blockwrite(f,Race[k].DriveModel,2); }
h:=M_Class.Value; blockwrite(f,h,2); //MissionID
blockwrite(f,k,2); //MissionRaceOrder
blockwrite(f,Race[k].TrackFilter,2);
blockwrite(f,Race[k].CarFilter,2);
blockwrite(f,Race[k].EventCode,2);
blockwrite(f,Race[k].InitOppCars,2);
blockwrite(f,Race[k].OppCar1,2);
blockwrite(f,Race[k].OppCar2,2);
blockwrite(f,Race[k].OppCar3,2);
blockwrite(f,Race[k].OppCar4,2);
blockwrite(f,Race[k].OppCar5,2);
h:=length(Race[k].TextSuccess);
blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(Race[k].TextSuccess,h+1)[1],h+1);
h:=length(Race[k].TextFail);
blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(Race[k].TextFail,h+1)[1],h+1);
blockwrite(f,Race[k].InitCode,2);
end;
//Version 2+
h:=length(M_Author.Text); blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(M_Author.Text,h+1)[1],h+1);
h:=length(M_Contact.Text); blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(M_Contact.Text,h+1)[1],h+1);
//Version 3+ //Comment, addon CarName and TrackName
h:=length(M_Author.Text); blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(M_Author.Text,h+1)[1],h+1);
h:=length(M_Contact.Text); blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(M_Contact.Text,h+1)[1],h+1);
h:=length(M_Contact.Text); blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(M_Contact.Text,h+1)[1],h+1);

closefile(f);
end;

procedure TForm1.TC_RaceChange(Sender: TObject);
begin
if TC_Race.TabIndex+1>M_NumRaces.Value then TC_Race.TabIndex:=M_NumRaces.Value-1;
SetDataToUI();
end;

procedure TForm1.M_DriversChange(Sender: TObject);
begin
if M_NumDrivers.Text='' then exit;
M_OppCar5.Enabled:=(M_NumDrivers.ItemIndex>=5) and (M_InitOppCars.ItemIndex=0);
M_OppCar4.Enabled:=(M_NumDrivers.ItemIndex>=4) and (M_InitOppCars.ItemIndex=0);
M_OppCar3.Enabled:=(M_NumDrivers.ItemIndex>=3) and (M_InitOppCars.ItemIndex=0);
M_OppCar2.Enabled:=(M_NumDrivers.ItemIndex>=2) and (M_InitOppCars.ItemIndex=0);
M_OppCar1.Enabled:=(M_NumDrivers.ItemIndex>=1) and (M_InitOppCars.ItemIndex=0);
end;

procedure TForm1.M_NumRacesChange(Sender: TObject);
begin
if M_NumRaces.Text='' then exit;
if M_NumRaces.Value<TC_Race.TabIndex+1 then TC_Race.TabIndex:=M_NumRaces.Value-1;
SetDataToUI();
end;

procedure TForm1.LoadMissionClick(Sender: TObject);
begin
OpenDialog1.Filter:='WR2 Manager Custom Mission file *.mis|*.mis';
OpenDialog1.InitialDir:=RootDir+'\AddOns\Missions\';
if not OpenDialog1.Execute then exit;
GetMissionInfo(OpenDialog1.FileName);
SetMissionDataToUI(nil);
end;

procedure TForm1.SetMissionDataToUI(Sender: TObject);
begin
M_Name.Text:=AddonMission.MissionName;
M_EventCode.ItemIndex:=AddonMission.EventCode-1;
M_ResultTyp.ItemIndex:=AddonMission.ResultTyp-1;
M_NumRaces.Value:=AddonMission.NumRaces;
M_Class.Value:=AddonMission.MissionClass;
M_Score.Value:=AddonMission.Score;
M_Cash.Value:=AddonMission.DefCash;
M_Gold.Lines.SetText(@AddonMission.RefText1[1]);
M_Silver.Lines.SetText(@AddonMission.RefText2[1]);
M_Bronze.Lines.SetText(@AddonMission.RefText3[1]);
M_Fail.Lines.SetText(@AddonMission.RefTextFail[1]);
M_InitCShip.ItemIndex:=AddonMission.InitCShip;
M_Author.Text:=AddonMission.Author;
M_Contact.Text:=AddonMission.Contact;
SetDataToUI();
end;

procedure TForm1.CBCarsChange(Sender: TObject);
var ID:integer;
begin
ID:=IDfromSTR(CBCars.Items[CBCars.ItemIndex],1);

UpdateCarInfo(ID,CBCars.Items[CBCars.ItemIndex][1]=AddOnCarPrefix);

for i:=1 to ListCars2.Count do
if (ListCars2.Items[i-1]<>'') then
 if(IDfromSTR(ListCars2.Items[i-1],2)=ID)and(ListCars2.Items[i-1][1]=CBCars.Items[CBCars.ItemIndex][1]) then ListCars2.ItemIndex:=i-1;
ListCars2.TopIndex:=ListCars2.ItemIndex-10;
end;

procedure TForm1.UpdateCarInfo(ID:integer; AddOn:boolean);
begin
if AddOn then begin
GroupBoxCar.Caption:=' '+AddonCar[id].Factory+' '+AddonCar[id].Model+' ';
Label41.Caption:=AddonCar[id].Folder;
Label42.Caption:=inttostr(AddonCar[id].Score);
Label43.Caption:=inttostr(AddonCar[id].MenuClass);
end else begin
GroupBoxCar.Caption:=' '+Value[24,44,id+1].Str+' '+Value[24,3,id+1].Str+' ';
Label41.Caption:=Value[30,2,Value[24,2,id+1].Int+1].Str;
Label42.Caption:=inttostr(Value[24,4,id+1].Int);
Label43.Caption:=inttostr(Value[24,7,id+1].Int);
end;
end;

procedure TForm1.GetDataFromUI(Sender: TObject);
begin
if MissionEditorRefresh then exit;
with AddonMission.Race[TC_Race.TabIndex+1] do begin
HeadLineText:=M_HeadlineText.Lines.GetText;
BonusID:=M_BonusID.ItemIndex; //0..11
CarID:=IDfromSTR(M_CarID.Text,1);    //M_CarID.ItemIndex+1;
TrackID:=IDfromSTR(M_TrackID.Text,1);//M_TrackID.ItemIndex+1;
NumLaps:=M_Laps.Value;
NumDrivers:=M_NumDrivers.ItemIndex+1;
StartPosition:=M_StartPos.Value;
LeadTime:=round(M_LeadTime.Value*10);
LeadMeter:=M_LeadMeter.Value;
LeadPositions:=M_LeadPos.Value;
Nitro:=M_Nitro.Value;
Traffic:=M_Traffic.Value;
RaceMode:=M_RaceMode.ItemIndex+1;
MissionText:=M_MissionText.Lines.GetText;
MinPlace:=M_MinPlace.Value;
AvgSpeed:=M_AvSpeed.Value;
Drifts:=M_Drifts.Value;
FinishLeadTime:=M_FinishLeadTime.Value;
MaxDamage:=M_MaxDamage.Value;
RaceTime:=round(M_RaceTime.Value*10);
MaxLapTime:=round(M_MaxLapTime.Value*10);
TopSpeed:=M_TopSpeed.Value;
TopSpeedNum:=M_TopSpeedNum.Value;
OppStrength:=M_OppStrength.Value;
DriveModel:=M_DriveModel.Value;
//MissionID:=
//MissionRaceOrder:=
TrackFilter:=M_TrackFilter.Value;
CarFilter:=M_CarFilter.Value;
EventCode:=max(M_EventC.ItemIndex,0);
InitOppCars:=max(M_InitOppCars.ItemIndex,0);
OppCar1:=IDfromSTR(M_OppCar1.Text,1);    //ItemIndex;
OppCar2:=IDfromSTR(M_OppCar2.Text,1);    //ItemIndex;
OppCar3:=IDfromSTR(M_OppCar3.Text,1);    //ItemIndex;
OppCar4:=IDfromSTR(M_OppCar4.Text,1);    //ItemIndex;
OppCar5:=IDfromSTR(M_OppCar5.Text,1);    //ItemIndex;
TextSuccess:=M_SuccessText.Lines.GetText;
TextFail:=M_FailText.Lines.GetText;
InitCode:=M_InitCode.Value;
end;
M_DriversChange(nil);
end;

procedure TForm1.SetDataToUI();
begin
MissionEditorRefresh:=true;
with AddonMission.Race[TC_Race.TabIndex+1] do begin
if HeadLineText<>'' then M_HeadlineText.Lines.SetText(@HeadLineText[1]) else M_HeadlineText.Clear;
M_BonusID.ItemIndex:=BonusID; //0..11
//M_CarID.ItemIndex:=CarID-1;
for i:=1 to M_CarID.Items.Count   do if IDfromSTR(M_CarID.Items[i-1],1)  =CarID   then M_CarID.ItemIndex:=i-1;
for i:=1 to M_TrackID.Items.Count do if IDfromSTR(M_TrackID.Items[i-1],1)=TrackID then M_TrackID.ItemIndex:=i-1;
M_Laps.Value:=NumLaps;
M_NumDrivers.ItemIndex:=NumDrivers-1;
M_StartPos.Value:=StartPosition;
M_LeadTime.Value:=LeadTime/10;
M_LeadMeter.Value:=LeadMeter;
M_LeadPos.Value:=LeadPositions;
M_Nitro.Value:=Nitro;
M_Traffic.Value:=Traffic;
M_RaceMode.ItemIndex:=RaceMode-1;
if MissionText<>'' then M_MissionText.Lines.SetText(@MissionText[1]) else M_MissionText.Clear;

M_MinPlace.Value:=MinPlace;
M_AvSpeed.Value:=AvgSpeed;
M_Drifts.Value:=Drifts;
M_FinishLeadTime.Value:=FinishLeadTime;
M_MaxDamage.Value:=MaxDamage;
M_RaceTime.Value:=RaceTime/10;
M_MaxLapTime.Value:=MaxLapTime/10;
M_TopSpeed.Value:=TopSpeed;
M_TopSpeedNum.Value:=TopSpeedNum;
M_OppStrength.Value:=OppStrength;
M_DriveModel.Value:=DriveModel;
//MissionID:=
//MissionRaceOrder:=
M_TrackFilter.Value:=TrackFilter;
M_CarFilter.Value:=CarFilter;
M_EventC.ItemIndex:=EventCode;
M_InitOppCars.ItemIndex:=InitOppCars;
for i:=1 to M_OppCar1.Items.Count do if IDfromSTR(M_OppCar1.Items[i-1],1)=OppCar1 then M_OppCar1.ItemIndex:=i-1;
for i:=1 to M_OppCar2.Items.Count do if IDfromSTR(M_OppCar2.Items[i-1],1)=OppCar2 then M_OppCar2.ItemIndex:=i-1;
for i:=1 to M_OppCar3.Items.Count do if IDfromSTR(M_OppCar3.Items[i-1],1)=OppCar3 then M_OppCar3.ItemIndex:=i-1;
for i:=1 to M_OppCar4.Items.Count do if IDfromSTR(M_OppCar4.Items[i-1],1)=OppCar4 then M_OppCar4.ItemIndex:=i-1;
for i:=1 to M_OppCar5.Items.Count do if IDfromSTR(M_OppCar5.Items[i-1],1)=OppCar5 then M_OppCar5.ItemIndex:=i-1;
if TextSuccess<>'' then M_SuccessText.Lines.SetText(@TextSuccess[1]) else M_SuccessText.Clear;
if TextFail<>'' then M_FailText.Lines.SetText(@TextFail[1]) else M_FailText.Clear;
M_InitCode.Value:=InitCode;
end;
M_DriversChange(nil);
MissionEditorRefresh:=false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
CollectCustomMissionData(nil);
SetMissionDataToUI(nil);
Button13Click(nil);
end;

end.

