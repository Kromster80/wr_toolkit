unit Unit1;
interface
uses
  Windows, Messages, SysUtils, Classes, Controls, ShellAPI,
  Forms, StdCtrls, Math, KromUtils, CheckLst, Buttons, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    CLBSceneries: TCheckListBox;
    CLBProfiles: TCheckListBox;
    GBScenery: TGroupBox;
    LBTracks: TListBox;
    Label2: TLabel;
    Label6: TLabel;
    Label8: TLabel;
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
    CLBMissions: TCheckListBox;
    GroupBox4: TGroupBox;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    SaveAllChanges: TBitBtn;
    Label45: TLabel;
    Label38: TLabel;
    Label37: TLabel;
    Label36: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    TWMissions: TTreeView;
    ListCars2: TListBox;
    CBCars: TComboBox;
    Label127: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label138: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    About: TBitBtn;
    Label3: TLabel;
    GB143: TGroupBox;
    R_SceneryBG: TCheckBox;
    R_WriteKM: TCheckBox;
    GBCheats: TGroupBox;
    Cheat_AllCarsTracks: TCheckBox;
    SaveAndRunWR2: TBitBtn;
    Label4: TLabel;
    ScAll: TButton;
    ScNone: TButton;
    r_Stats: TCheckBox;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure CLBSceneriesClick(Sender: TObject);
    procedure LBTracksClick(Sender: TObject);
    procedure CLBMissionsClick(Sender: TObject);
    procedure CLBSceneriesClickCheck(Sender: TObject);
    procedure CLBMissionsClickCheck(Sender: TObject);
    procedure CLBProfilesClickCheck(Sender: TObject);
    procedure CBCarsChange(Sender: TObject);
    procedure UpdateCarInfo(ID:integer; AddOn:boolean);
    procedure AboutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure ScAllClick(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,NewHeight: Integer; var Resize: Boolean);
    procedure SaveAndRunWR2Click(Sender: TObject);
    procedure SaveAndRunMPClick(Sender: TObject);
    procedure SaveAllChangesClick(Sender: TObject);
    procedure ListCars2Click(Sender: TObject);
  end;

const
 MaxProf=32;
 MaxScen=512;
 MaxCars=4096;
 MaxMiss=128;

 BaseTracks = 184; //WR2 has this much of tracks in stock

 AddOnCarPrefix='`';
 TrackType:array[1..4] of string=('All','Series','Rally','Off-Road');
 VersionInfo='WR2 Manager       Version 0.3m (06 Aug 2010)';

var
  Form1: TForm1;
  c:array[1..1024000]of char;
  RootDir:string;
  zz:string='     '+'                                                                                                     ';

  RuntimeQty:integer;
  Runtime:array of string;

  AddQty:integer=0;
  AddRuntime:array[1..MaxScen+256]of record //Add total of MaxScen + overhead for various things
    Title:string;    //Short ID
    Mode:string;     //Add/Replace
    LandMark:string; //unique text line in fxp
    Offset:word;     //offset from LandMark
    Length:word;     //number of addon lines
    Lines:array[1..2048]of string; //max lines per injection =  Maps*Track (70*30)
  end;

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
  ProfileQty:integer;
  Profile:array[1..MaxProf]of record
    Folder:string;
    Install:bool;
  end;

////////////////////////////////////////////////////////////////////////////////
//1..MaxProf Profiles count
//1..25 DS count
//1..36 TB count
  P_:array[1..MaxProf]of record
  Header:array[1..33]of char;
  DSqty:integer;

  TB:array[1..25] of record
  Entries:integer; //VA_Entries
  Index:integer;   //VA_Index
  iC:byte;         //VA_iC ?
  Lib:string;      //VA_Lib
  Cond:byte;       //Cond switch
  CondText:array of string; //Cond text
  end;

  CO:array[1..25,1..36] of record
  Entries:integer; //VA_Entries
  Index:integer;   //VA_Index
  Lib:string;      //VA_Lib
  iU:byte;         //VA_iU ?
  SM,ST,IC,SC:string;       //VA_database path, VA_ST, VA_IC, VA_SC
  end;

  Value:array[1..25,1..36] of array of record
  Typ:byte; Int:integer; Rel:single; Str:string; end;
  end;
////////////////////////////////////////////////////////////////////////////////

  AddonCarQty:integer;
  AddonCar:array[1..MaxCars]of record
  Folder:string;
  Factory,Model,Name:string;
  Score,MenuClass,RaceClass:integer;
  end;
  CarsInClass:array[1..MaxCars]of integer;

  AddonSceneryQty:integer;
    AddonScenery:array[1..MaxScen]of record
    Folder:string;
    EngineName,BGround,Name,SceneryFlag:string;
    FreeRideID,FreeRideID_abs,TrackQty:integer;
      Track:array[1..64]of record //WR2 uses up to 32 tracks in fact
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
    Install:bool;
    end;

    AddonMissionQty:integer;
    AddonMission:array[1..MaxMiss]of record
     FileName:string;
     EventCode:byte;
     Score:integer;
     NumRaces:byte;
     Name:string;
     ResultTyp:byte;
     RefTextFail,RefText1,RefText2,RefText3:string;
     MissionClass,DefCash:integer;
     InitCShip:byte;
     Author,Contact:string; //Version 2+
     Comment,CarName,TrackName:string; //Version 3+

      Race:array[1..32]of record
       HeadLineText:string;
       BonusID,CarID,TrackID,Laps,Drivers,StartPosition,
       LeadTime,LeadMeter,LeadPositions,Nitro,Traffic,
       RaceMode:word;
       MissionText:string;
       MinPlace,AvSpeed,Drifts,FinishLeadTime,MaxDamage,
       RaceTime,MaxLapTime,TopSpeed,TopSpeedNum,
       OppStrength,DriveModel,MissionID,MissionRaceOrder,
       TrackFilter,CarFilter,EventCode,InitOppCars,
       OppCar1,OppCar2,OppCar3,OppCar4,OppCar5:word;
       TextSuccess,TextFail:string;
       InitCode:word;
      end;
    Install:bool;
    end;
  MNode:array[1..MaxMiss]of TTreeNode;

implementation

{$R *.dfm}
uses Unit_WRTools, Unit2, WR_AboutBox, Unit_Search, Unit_RuntimeFXP, Unit_WR2DS, Unit_INI;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoClientAreaResize(Self);
  if Sender<>nil then exit; //Wait until all forms are init

  Form1.Hide;
  Form1.Caption := VersionInfo;
  Form2.Label1.Caption := VersionInfo;
  Form2.Show;
  Form2.Repaint;

  if fileexists('krom.dev') then ChDir('E:\World Racing 2');

  RootDir := GetCurrentDir;
  if RootDir[length(RootDir)] <> '\' then RootDir := RootDir + '\';

  if FileExists('FrontEnd\wr2.ds')and not FileExists('FrontEnd\WR2.bak') then
    CopyFile('FrontEnd\WR2.ds','FrontEnd\WR2.bak',true);

  if FileExists('FrontEnd\Runtime.fxp')and not FileExists('FrontEnd\Runtime.bak') then
    CopyFile('FrontEnd\Runtime.fxp','FrontEnd\Runtime.bak',true);

  GB143.Visible := fileexists('FrontEnd\Runtime.fxp');

  if FileExists(RootDir+'FrontEnd\wr2.ds') then
    OpenDS(RootDir+'FrontEnd\wr2.ds')
  else begin
    MessageBox(0, PChar('"FrontEnd\wr2.ds" not found.'+eol+'You need to run WR2Manager from WR2 folder!'), 'Error', MB_ICONERROR or MB_OK or MB_TOPMOST or MB_APPLMODAL);
    Form1.Close;
    exit;
  end;

  //if Form2.Showing then Form2.Hide;
  Form2.Label2.Caption:='Scanning: Profiles ...'; Form2.Label2.Refresh; SearchProfiles();
  Form2.Label2.Caption:='Scanning: Cars ...';     Form2.Label2.Refresh; SearchAutos();
  Form2.Label2.Caption:='Scanning: Sceneries ...';Form2.Label2.Refresh; SearchSceneries();
  Form2.Label2.Caption:='Scanning: Missions ...'; Form2.Label2.Refresh; SearchMissions();
  ReadINI();

  if Form2.Showing then Form2.Close;
  Form1.Show;
end;


procedure TForm1.CLBSceneriesClick(Sender: TObject);
var ID,kk,i:integer;
begin
  LBTracks.Clear;
  if CLBSceneries.ItemIndex<=5 then begin //6 Stock sceneries
    ID := CLBSceneries.ItemIndex+1;
    kk := 1;
    for i:=1 to BaseTracks do
      if Value[14,2,i].Int=ID then begin
        LBTracks.AddItem(inttostr(kk)+'. '+WRTexte(Value[14,4,i].Str), TObject(i));
        inc(kk);
      end;
    Label8.Caption    := Value[16,2,ID+1].Str;
    GBScenery.Caption := '  '+WRTexte(Value[16,5,ID+1].Str)+'  ';
    Label12.Caption   := WRTexte(Value[14,4,Value[16,8,ID+1].Int+1].Str);
    Label39.Caption   := 'Synetic';
    Label40.Caption   := '-';
    Label44.Caption   := 'www.synetic.de';
    Label46.Caption   := 'Stock WR2 scenery';
  end;

  if CLBSceneries.ItemIndex>5 then begin //add-on sceneries
    ID := CLBSceneries.ItemIndex-6+1;
    for i:=1 to AddonScenery[ID].TrackQty do
      LBTracks.AddItem(inttostr(i)+'. '+AddonScenery[ID].Track[i].Name,nil);
    Label8.Caption    := AddonScenery[ID].EngineName;
    GBScenery.Caption := '  '+AddonScenery[ID].Name+'  ';
    Label12.Caption   := AddonScenery[ID].Track[AddonScenery[ID].FreeRideID].Name;
    Label39.Caption   := AddonScenery[ID].Author;
    Label40.Caption   := AddonScenery[ID].Converter;
    Label44.Caption   := AddonScenery[ID].Contact;
    Label46.Caption   := AddonScenery[ID].Comment;
  end;

  Label46.Width      := 145;
  LBTracks.ItemIndex := 0;
  LBTracksClick(nil);
end;


procedure TForm1.LBTracksClick(Sender: TObject);
var ID,ID2:integer;
begin
  if CLBSceneries.ItemIndex<=5 then begin //WR2 stock maps
    ID2 := integer(LBTracks.Items.Objects[LBTracks.ItemIndex]);
    GBTrack.Caption := '  '+WRTexte(Value[14,4,ID2].Str)+'  ';
    Label21.Caption := inttostr(Value[14,3,ID2].Int);
    Label23.Caption := inttostr(Value[14,5,ID2].Int);
    Label24.Caption := inttostr(Value[14,9,ID2].Int)+' m';
    case Value[14,10,ID2].Int of
      1:   Label25.Caption := 'ClockWise';
      2:   Label25.Caption := 'CounterClockWise';
      else Label25.Caption := inttostr(Value[14,10,ID2].Int);
    end;
    Label26.Caption := inttostr(Value[14,12,ID2].Int);
    Label27.Caption := Value[14,13,ID2].Str;
    Label28.Caption := TrackType[Value[14,16,ID2].Int];
    Label29.Caption := inttostr(Value[14,25,ID2].Int);
  end;
  if CLBSceneries.ItemIndex>5 then begin //Addon maps
    ID:=CLBSceneries.ItemIndex-6+1; ID2:=LBTracks.ItemIndex+1;
    with AddonScenery[ID].Track[ID2] do begin
      Label21.Caption := inttostr(TrackNo);
      GBTrack.Caption := '  '+Name+'  ';
      Label23.Caption := inttostr(CheckPoint);
      Label24.Caption := inttostr(mDistance)+' m';
      case Direction of
        1:   Label25.Caption := 'ClockWise';
        2:   Label25.Caption := 'CounterClockWise';
        else Label25.Caption := inttostr(Direction);
      end;
      Label26.Caption := inttostr(WayPoint);
      if WayPoint=0 then Label27.Caption:='Track'+AddonScenery[ID].Folder+int2fix(TrackNo,2)+'.tga'
                    else Label27.Caption:='Track'+AddonScenery[ID].Folder+'WP'+int2fix(TrackNo,2)+'.tga';
      Label28.Caption := TrackType[TypeID];
      Label29.Caption := inttostr(NumSections);
    end;
  end;
end;


procedure TForm1.CLBMissionsClick(Sender: TObject);
var ID:integer;
begin
  ID:=CLBMissions.ItemIndex+1;
  Label61.Caption  := inttostr(AddonMission[ID].EventCode);
  Label62.Caption  := inttostr(AddonMission[ID].Score);
  Label63.Caption  := inttostr(AddonMission[ID].NumRaces);
  Label64.Caption  := AddonMission[ID].Name;
  Label65.Caption  := ResultType[AddonMission[ID].ResultTyp];
  Label66.Caption  := inttostr(AddonMission[ID].MissionClass);
  Label67.Caption  := inttostr(AddonMission[ID].DefCash);
  Label138.Caption := AddonMission[ID].Author;
  Label136.Caption := AddonMission[ID].Contact;
end;


procedure TForm1.CLBSceneriesClickCheck(Sender: TObject);
var ID:integer;
begin
  ID := CLBSceneries.ItemIndex-6+1;
  if ID<1 then exit;
  AddonScenery[ID].Install:=CLBSceneries.Checked[CLBSceneries.ItemIndex];
end;


procedure TForm1.CLBMissionsClickCheck(Sender: TObject);
var ID:integer;
begin
  ID:=CLBMissions.ItemIndex+1;
  AddonMission[ID].Install:=CLBMissions.Checked[ID-1];
end;


procedure TForm1.CLBProfilesClickCheck(Sender: TObject);
var i:integer;
begin
 for i:=1 to CLBProfiles.Count do
 Profile[i].Install := CLBProfiles.Checked[i-1];
end;


procedure TForm1.CBCarsChange(Sender: TObject);
var ID,i:integer;
begin
  ID := integer(CBCars.Items.Objects[CBCars.ItemIndex]);

  UpdateCarInfo(ID,CBCars.Items[CBCars.ItemIndex][1] = AddOnCarPrefix);

  for i:=1 to ListCars2.Count do
    if (ListCars2.Items[i-1]<>'')
    and(IDfromSTR(ListCars2.Items[i-1],2)=ID)
    and(ListCars2.Items[i-1][1]=CBCars.Items[CBCars.ItemIndex][1])
    then
      ListCars2.ItemIndex := i-1;
      
  ListCars2.TopIndex:=ListCars2.ItemIndex-10;
end;


procedure TForm1.UpdateCarInfo(ID:integer; AddOn:boolean);
begin
  if AddOn then begin
    GroupBoxCar.Caption:=' '+AddonCar[id].Factory+' '+AddonCar[id].Model+' ';
    Label41.Caption:=AddonCar[id].Folder;
    Label42.Caption:=inttostr(AddonCar[id].Score);
    Label43.Caption:=inttostr(AddonCar[id].MenuClass);
    Label9.Caption:=inttostr(AddonCar[id].RaceClass);
    //Panel1.Caption:='AddOns\Autos\'+AddonCar[id].Folder+'\'+AddonCar[id].Folder+'.mox';
  end else begin
    GroupBoxCar.Caption:=' '+Value[24,44,id+1].Str+' '+Value[24,3,id+1].Str+' ';
    Label41.Caption:=Value[30,2,Value[24,2,id+1].Int+1].Str;
    Label42.Caption:=inttostr(Value[24,4,id+1].Int);
    Label43.Caption:=inttostr(Value[24,7,id+1].Int);
    Label9.Caption:=inttostr(Value[24,37,id+1].Int);
    //Panel1.Caption:='Autos\'+Value[30,2,Value[24,2,id+1].Int+1].Str+'\'+Value[30,2,Value[24,2,id+1].Int+1].Str+'.mox';
  end;
end;


procedure TForm1.AboutClick(Sender: TObject);
begin
  AboutForm.Show(VersionInfo,'Manages all WR2 addons.','WR2Man');
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteINI();
end;


procedure TForm1.FormResize(Sender: TObject);
begin
  CLBSceneries.Columns := CLBSceneries.Width div 150;
  if CLBSceneries.Columns = 1 then CLBSceneries.Columns := 0;
end;


procedure TForm1.ScAllClick(Sender: TObject);
var i:integer;
begin
  if PageControl1.ActivePageIndex=1 then
    for i:=1 to AddonSceneryQty do begin
      CLBSceneries.Checked[6+i-1] := Sender=ScAll; //Sender is either ScAll or ScNone
      AddonScenery[i].Install     := Sender=ScAll;
    end;

  if PageControl1.ActivePageIndex=2 then
    for i:=1 to AddonMissionQty do begin
      CLBMissions.Checked[i-1] := Sender=ScAll; //Sender is either ScAll or ScNone
      AddonMission[i].Install  := Sender=ScAll;
    end;
end;


procedure TForm1.FormCanResize(Sender: TObject; var NewWidth,NewHeight: Integer; var Resize: Boolean);
begin
  NewHeight := max(NewHeight,528);
  NewWidth  := max(NewWidth,720);
end;


procedure TForm1.SaveAndRunWR2Click(Sender: TObject);
begin
  SaveAllChangesClick(nil);
  ChDir(RootDir);
  ShellExecute(handle, 'open', 'WR2_PC.exe', NiL, Nil, SW_SHOWNORMAL);
  Form1.Close;
end;


procedure TForm1.SaveAndRunMPClick(Sender: TObject);
begin
  SaveAllChangesClick(nil);
  ChDir(RootDir);
  ShellExecute(handle, 'open', 'MP Lounge 2.exe', NiL, Nil, SW_SHOWNORMAL);
  Form1.Close;
end;


procedure TForm1.SaveAllChangesClick(Sender: TObject);
begin
  SaveAllChanges.Caption := 'Saving...';
  SaveAllChanges.Enabled := false;

  AddTracksToDS();
  AddMissionsToDS();
  SaveDS(RootDir+'FrontEnd\WR2.ds');

  if fileexists(RootDir+'FrontEnd\Runtime.fxp') then begin
    ReadRuntimeFXP(nil);
    MakeRuntimeFXPEntries(nil);
    SaveRuntimeFXP(nil);
  end;

  if DirectoryExists(RootDir+'WR2-Saves') then
    SaveProfiles();

  WriteINI();
  SaveAllChanges.Enabled := true;
  SaveAllChanges.Caption := 'Save all changes';
end;


procedure TForm1.ListCars2Click(Sender: TObject);
var ID:integer;
begin
  if ListCars2.Items[ListCars2.ItemIndex]='' then exit;
  ID:=IDfromSTR(ListCars2.Items[ListCars2.ItemIndex],2);  
  UpdateCarInfo(ID,ListCars2.Items[ListCars2.ItemIndex][1]=AddOnCarPrefix);
end;


end.

