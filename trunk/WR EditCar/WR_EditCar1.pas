unit WR_EditCar1;
{$IFDEF FPC} {$MODE Delphi} {$ENDIF}
interface
uses
  SysUtils, Classes, Forms, StdCtrls, Dialogs, ExtCtrls, Controls, ComCtrls, Spin,
  {$IFDEF FPC} LResources, LCLIntf, TAGraph, TASeries, {$ENDIF}
  WR_EditCar_Lang, WR_DataSet,
  {$IFDEF VER140}Chart, FloatSpinEdit, {$ENDIF}
  WR_AboutBox, KromUtils,
  Grids, Graphics, Buttons, Math
  {$IFDEF VER140}, ValEdit, TeEngine, Series, TeeProcs {$ENDIF};

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonLoad: TButton;
    ButtonSave: TButton;
    Open1: TOpenDialog;
    Save1: TSaveDialog;
    RGFormat: TRadioGroup;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label0: TLabel;
    Label2: TLabel;
    LBModel: TListBox;
    BrowseForWR2DS: TButton;
    WR2DSPath: TEdit;
    Label115: TLabel;
    LB2Model: TListBox;
    ImportWR2Car: TButton;
    Label128: TLabel;
    WRDSPath: TEdit;
    BrowseForWRDS: TButton;
    ImportWRCar: TButton;
    TabSheet4: TTabSheet;
    GroupBox3: TGroupBox;
    Label129: TLabel;
    PageControl2: TPageControl;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    ValueListEditor1: TValueListEditor;
    {$ENDIF}
    GroupDisplayModes: TGroupBox;
    Image7: TImage;
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
    Image5: TImage;
    Label87: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label58: TLabel;
    Label60: TLabel;
    Label88: TLabel;
    Label59: TLabel;
    Label89: TLabel;
    Image2: TImage;
    Image3: TImage;
    Image1: TImage;
    RGdrive: TRadioGroup;
    Image4: TImage;
    Bevel19: TBevel;
    Label77: TLabel;
    Bevel10: TBevel;
    Label134: TLabel;
    Label135: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    TabSheet13: TTabSheet;
    GroupBox4: TGroupBox;
    Memo1: TMemo;
    GroupBox5: TGroupBox;
    Memo2: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Button1: TButton;
    BitBtn5: TBitBtn;
    SDriverX2: TFloatSpinEdit;
    SDriverY2: TFloatSpinEdit;
    SDriverZ2: TFloatSpinEdit;
    SDriverZ1: TFloatSpinEdit;
    SDriverY1: TFloatSpinEdit;
    SDriverX1: TFloatSpinEdit;
    DFX: TFloatSpinEdit;
    DFY: TFloatSpinEdit;
    DFZ: TFloatSpinEdit;
    DMZ: TFloatSpinEdit;
    DMY: TFloatSpinEdit;
    DMX: TFloatSpinEdit;
    GroupSound: TGroupBox;
    Label41: TLabel;
    Edit7: TEdit;
    SSrate: TSpinEdit;
    Label42: TLabel;
    Label54: TLabel;
    SLautstarke: TSpinEdit;
    SMotID: TSpinEdit;
    Label116: TLabel;
    Label117: TLabel;
    SAusID: TSpinEdit;
    SSaug: TSpinEdit;
    Label120: TLabel;
    Label121: TLabel;
    SLastger: TSpinEdit;
    GroupLooks: TGroupBox;
    SappBR1: TSpinEdit;
    SappBR2: TSpinEdit;
    SappBR3: TSpinEdit;
    Label29: TLabel;
    Label30: TLabel;
    SappCAB3: TSpinEdit;
    SappCAB2: TSpinEdit;
    SappCAB1: TSpinEdit;
    Label32: TLabel;
    TypLink: TEdit;
    Label99: TLabel;
    Label86: TLabel;
    TypRech: TEdit;
    Label75: TLabel;
    SColor: TSpinEdit;
    Label114: TLabel;
    GroupHUD: TGroupBox;
    STachoID: TSpinEdit;
    LtachoID: TLabel;
    Label133: TLabel;
    SmphID: TSpinEdit;
    LmphID: TLabel;
    LkmhID: TLabel;
    SkmhID: TSpinEdit;
    Label76: TLabel;
    GroupCameras: TGroupBox;
    ScamCX: TSpinEdit;
    ScamIZ: TSpinEdit;
    ScamCZ: TSpinEdit;
    ScamHZ: TSpinEdit;
    ScamHY: TSpinEdit;
    ScamCY: TSpinEdit;
    ScamIY: TSpinEdit;
    ScamPY: TSpinEdit;
    ScamPZ: TSpinEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label51: TLabel;
    Label46: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label43: TLabel;
    GroupWeight: TGroupBox;
    Sweight: TSpinEdit;
    Label37: TLabel;
    Label61: TLabel;
    SweightD: TSpinEdit;
    SAngular: TSpinEdit;
    Label68: TLabel;
    GroupSuspension: TGroupBox;
    SDamper: TSpinEdit;
    Label64: TLabel;
    Label65: TLabel;
    SFeather: TSpinEdit;
    SRelease: TSpinEdit;
    SBounce: TSpinEdit;
    SWheelY: TSpinEdit;
    SSperrDif: TSpinEdit;
    Stabilizat: TFloatSpinEdit;
    Label72: TLabel;
    Label130: TLabel;
    Label27: TLabel;
    Label63: TLabel;
    Label62: TLabel;
    GroupAerodynamics: TGroupBox;
    SSlipR: TSpinEdit;
    Label85: TLabel;
    Label84: TLabel;
    SSlipF: TSpinEdit;
    FSAirB: TFloatSpinEdit;
    Label83: TLabel;
    GroupTireSize: TGroupBox;
    STireFW: TSpinEdit;
    STireRW: TSpinEdit;
    Label10: TLabel;
    Label9: TLabel;
    STireRR: TSpinEdit;
    STireFR: TSpinEdit;
    STireFD: TSpinEdit;
    STireRD: TSpinEdit;
    Label13: TLabel;
    TireFrontSize: TLabel;
    TireRearSize: TLabel;
    GroupWheelbase: TGroupBox;
    STireFT: TSpinEdit;
    STireRT: TSpinEdit;
    Label14: TLabel;
    Label25: TLabel;
    STireRZ: TSpinEdit;
    STireFZ: TSpinEdit;
    Label142: TLabel;
    Label26: TLabel;
    GroupTireProps: TGroupBox;
    FSSlipR: TFloatSpinEdit;
    FSSlipF: TFloatSpinEdit;
    FSGripFR: TFloatSpinEdit;
    FSGrip: TFloatSpinEdit;
    FS106: TFloatSpinEdit;
    FS103: TFloatSpinEdit;
    Label66: TLabel;
    Label67: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label73: TLabel;
    GroupTorqueCurve: TGroupBox;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    GroupEngineStats: TGroupBox;
    FS0100: TFloatSpinEdit;
    Label80: TLabel;
    Label79: TLabel;
    Stopsp: TSpinEdit;
    Edit4: TEdit;
    SMnm: TSpinEdit;
    SMhp: TSpinEdit;
    Edit5: TEdit;
    Label36: TLabel;
    Label39: TLabel;
    Edit6: TEdit;
    Label35: TLabel;
    Label34: TLabel;
    Label52: TLabel;
    GroupTorque: TGroupBox;
    SNMStep: TSpinEdit;
    SrpmMax: TSpinEdit;
    Label82: TLabel;
    SMtorque: TSpinEdit;
    Label40: TLabel;
    Label28: TLabel;
    GroupGears: TGroupBox;
    FSGearF: TFloatSpinEdit;
    FSGearR: TFloatSpinEdit;
    FSGear7: TFloatSpinEdit;
    FSGear6: TFloatSpinEdit;
    FSGear5: TFloatSpinEdit;
    FSGear4: TFloatSpinEdit;
    FSGear3: TFloatSpinEdit;
    FSGear2: TFloatSpinEdit;
    FSGear1: TFloatSpinEdit;
    SGearQty: TSpinEdit;
    Label150: TLabel;
    Label149: TLabel;
    Label148: TLabel;
    Label147: TLabel;
    Label146: TLabel;
    Label145: TLabel;
    Label144: TLabel;
    Label143: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label38: TLabel;
    Label24: TLabel;
    Label15: TLabel;
    GroupCockpit: TGroupBox;
    Image6: TImage;
    SDrwX: TSpinEdit;
    SDrwY: TSpinEdit;
    SDrwZ: TSpinEdit;
    ST2Y: TSpinEdit;
    ST2X: TSpinEdit;
    ST1X: TSpinEdit;
    ST1Y: TSpinEdit;
    ST1Z: TSpinEdit;
    ST2Z: TSpinEdit;
    SDrwW: TSpinEdit;
    ST2A2: TSpinEdit;
    ST2A1: TSpinEdit;
    ST1A1: TSpinEdit;
    ST1A2: TSpinEdit;
    ST1A3: TSpinEdit;
    ST2A3: TSpinEdit;
    ST2Start: TSpinEdit;
    FST2Scale: TFloatSpinEdit;
    FST1Scale: TFloatSpinEdit;
    ST1Start: TSpinEdit;
    FST1Size: TFloatSpinEdit;
    FST2Size: TFloatSpinEdit;
    ST1Mode: TSpinEdit;
    ST2Mode: TSpinEdit;
    Bevel20: TBevel;
    Label113: TLabel;
    Label91: TLabel;
    Label94: TLabel;
    Label93: TLabel;
    Label92: TLabel;
    Bevel1: TBevel;
    Label96: TLabel;
    Label95: TLabel;
    Label97: TLabel;
    Bevel11: TBevel;
    Label101: TLabel;
    Label100: TLabel;
    Label98: TLabel;
    Label102: TLabel;
    Bevel12: TBevel;
    Label90: TLabel;
    Bevel13: TBevel;
    GroupName: TGroupBox;
    CBCabrio2: TCheckBox;
    CBCabrio1: TCheckBox;
    Edit3: TEdit;
    Edit2: TEdit;
    Logo: TEdit;
    Hersteller: TEdit;
    Edit8: TEdit;
    Edit1: TEdit;
    Label55: TLabel;
    Label31: TLabel;
    Label118: TLabel;
    Label153: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Caravan: TEdit;
    Label152: TLabel;
    GroupClass: TGroupBox;
    RaceClass1_4: TRadioGroup;
    SRaceClass: TSpinEdit;
    Label127: TLabel;
    Label33: TLabel;
    SClassID: TSpinEdit;
    SScore: TSpinEdit;
    Label50: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure InitChart();
    procedure OpenClick(Sender: TObject);
    procedure OpenCAR(aCarFile: string);
    procedure MouseClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); reintroduce;
    procedure VLEChange(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure AboutClick(Sender: TObject);
    procedure FSChange(Sender: TObject);
    procedure RefreshVLE;
    procedure PageChange(Sender: TObject);
    procedure TorqueMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure TorqueMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FSChangeLink(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FSChange2(Sender: TObject);
    procedure RGFormatClick(Sender: TObject);
    procedure BrowseForWR2DSClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure ScanWR2DS(sender:string);
    procedure ImportWR2CarClick(Sender: TObject);
    procedure ImportWRCarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure UpdateControls();
    procedure UpdateDataSet();
  end;


type TEditingFormat = (fmtMBWR, fmtWR2, fmtAFC11N, fmtFVR, fmtAFC11HN);

var
  Form1: TForm1;

  ExeDir,CarName:string;

  LineSerieHP: TLineSeries;
  LineSerieNM: TLineSeries;  

  LockControls:boolean=false; //New variable

  allowFS2,{AllowDataUpdate,}VLEEdit:boolean; //First Import click, Chapter not found, Not First Time, Allow Change

  DSqty:integer; //DS values (2)
  TBqty,TBCondQty:array[1..2] of integer;
  TBLib:array[1..2] of string;
  TBCond:array[1..2] of array of string;
  COqty: array[1..2,0..300] of integer;
  COid:  array[1..2,0..300] of integer;
  COtext:array[1..2,0..300,1..5] of string;
  data:array [1..2,0..512,1..3]of integer;       //Type of data (integer,real,string)
    vi:array [1..2,0..512,1..3]of integer;       //Values (empty,value,backup?)
    vr:array [1..2,0..512,1..3]of real;
    vs:array [1..2,0..512,1..3]of string;
  Title:array of array of string;
  Value:array of array of array of record
    Int:integer;
    Rel:single;
    Str:string;
  end;
  CarFmt:TEditingFormat;

implementation

procedure TForm1.FormCreate(Sender: TObject);
begin
  DecimalSeparator := '.';
  CarName := ExtractOpenedFileName(CMDLine);
  ExeDir := ExtractFilePath(Application.ExeName);

  InitChart();
  fDataSet := TDataSet.Create;

  fDataSet.DoProperIndexing := true;

  if not FileExists(CarName) then
    CarName := ExeDir + 'editcar.car';

  if FileExists(CarName) then
    OpenCar(CarName);
end;


procedure TForm1.InitChart();
begin
  FreeAndNil(LineSerieHP);
  FreeAndNil(LineSerieNM);

  LineSerieHP := TLineSeries.Create(Chart1);
  LineSerieHP.Pointer.Brush.Color := clRed;
  LineSerieHP.ShowInLegend := false;
  LineSerieHP.SeriesColor := clRed;
  Chart1.AddSeries(LineSerieHP);

  LineSerieNM := TLineSeries.Create(Chart1);
  LineSerieNM.Pointer.Brush.Color := clBlue;
  LineSerieNM.ShowInLegend := false;
  LineSerieNM.SeriesColor := clBlue;
  Chart1.AddSeries(LineSerieNM);
end;


procedure TForm1.OpenClick(Sender: TObject);
begin
  if not RunOpenDialog(Open1,'','','"World Racing" car descriptor (*.car)|*.car|All Files (*.*)|*.*') then exit;
  CarName := Open1.FileName;

  if fileexists(ExeDir+'unlimiter.'+inttostr(846)) then
  begin
    SRaceClass.MaxValue:=65535;
    SClassID.MaxValue:=65535;
  end;

  OpenCar(CarName);
end;


procedure TForm1.OpenCAR(aCarFile: string);
begin
  fDataSet.LoadDS(aCarFile);

  //Special fix for Sound SampleRate
  if fDataSet.GetValueType(105,74,2)<>1 then begin
    fDataSet.SetValueType(105,74,2,1); //Integer in all WR cars
    fDataSet.SetValue(105,74,2,round(fDataSet.GetValue(105,74,2).Rel));
  end;

  //Add missing field to MBWR cars
  if fDataSet.COIndex(103,0) = -1 then
    fDataSet.InsertCOEntry(103, 0, fDataSet.COCount(103,1), 'Kommentar', 16);
  if fDataSet.COIndex(105,0) = -1 then
    fDataSet.InsertCOEntry(105, 0, fDataSet.COCount(105,1), 'Kommentar', 16);

  RGFormat.ItemIndex := 1; //Default to WR2, for it has the most audience
  if fDataSet.GetCOLib(105,8)='FlagMissionCar' then RGFormat.ItemIndex:=0; //MBWR
  if fDataSet.GetCOLib(105,8)='CarClassID' then RGFormat.ItemIndex:=1; //WR2
  if fDataSet.GetCOLib(105,57)='mocod' then RGFormat.ItemIndex:=3; //FVR
  RGFormatClick(nil);

  UpdateControls;
end;


procedure TForm1.RefreshVLE; //Send data to List from memory
//var i,k,Count:integer;
begin
  {
  VLEEdit:=false;
  ValueListEditor1.Strings.Clear;
  for i:=1 to DSqty do begin
    if (i=1)and(TBqty[i]>256) then Count:=81 else       //257
    if (i=2)and(TBqty[i]>256) then Count:=106 else      //287
    Count:=TBqty[i];
    for k:=1 to Count do begin
      s:=inttostr(i)+'-'+int2fix(COid[i,k],3)+'. '+COtext[i,COid[i,k],1];
      case data[i,COid[i,k],2] of
        1: ValueListEditor1.InsertRow(s,inttostr(vi[i,COid[i,k],2]),true);
        2: ValueListEditor1.InsertRow(s,float2fix(vr[i,COid[i,k],2],3),true);
        3: ValueListEditor1.InsertRow(s,vs[i,COid[i,k],2],true);
      end;
    end;
  end;
  VLEEdit:=true;
  }
end;

procedure TForm1.VLEChange(Sender: TObject);
//var i,k:integer; Key,Val:string;
begin
  {
  if VLEEdit=false then exit;
  Key:=ValueListEditor1.Keys[ValueListEditor1.Row];
  Val:=ValueListEditor1.Values[ValueListEditor1.Keys[ValueListEditor1.Row]];
  if (length(Key)>=6)and(Val<>'') then begin //Format is #-###. at least 6 chars
    i:=strtoint(Key[1]);
    k:=strtoint(Key[3]+Key[4]+Key[5]);
    case data[i,k,2] of
      1: vi[i,k,2]:=strtoint(Val);
      2: vr[i,k,2]:=strtofloat(Val);
      3: vs[i,k,2]:=Val;
    end;
  end;
  }
end;

//Redirect to Keyboard call, cause of different input parameters.
procedure TForm1.MouseClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var w:word;
begin
  w:=0;
  Form1.KeyDown(Form1,w,Shift);
end;

procedure TForm1.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//var i,k:integer;
begin
{
with ValueListEditor1 do
  if length(Keys[Row])>=6 then begin
    i:=strtoint(Keys[Row][1]);
    k:=strtoint(Keys[Row][3]+Keys[Row][4]+Keys[Row][5]);

    Label0.caption:='DB       -  '+TBLib[i];
    Label1.caption:='Title      -  '+COtext[i,k,1];
    Label2.caption:='Library  -  '+COtext[i,k,3];
    Label3.caption:='Index    -  '+COtext[i,k,4];
    Label4.caption:='Info       -  '+COtext[i,k,5];
    case data[i,k,2] of
    1: Label5.caption:='Format  -  Integer';
    2: Label5.caption:='Format  -  Float';
    3: Label5.caption:='Format  -  String';
    end;

    case data[i,k,1] of
    1: Label6.caption:='Integer1 -  '+inttostr(vi[i,k,1]);
    2: Label6.caption:='Real1    -  '+floattostr(vr[i,k,1]);
    3: Label6.caption:='String1  -  '+vs[i,k,1];
    0: Label6.caption:='  -  ';
    end;
    case data[i,k,2] of
    1: Label7.caption:='Integer2 -  '+inttostr(vi[i,k,2]);
    2: Label7.caption:='Real2    -  '+floattostr(vr[i,k,2]);
    3: Label7.caption:='String2  -  '+vs[i,k,2];
    0: Label7.caption:='  -  ';
    end;
    case data[i,k,3] of
    1: Label8.caption:='Integer3 -  '+inttostr(vi[i,k,3]);
    2: Label8.caption:='Real3    -  '+floattostr(vr[i,k,3]);
    3: Label8.caption:='String3  -  '+vs[i,k,3];
    0: Label8.caption:='  -  ';
    end;
  end; //with ... do
}
end;

procedure TForm1.SaveClick(Sender: TObject);
var i,j,k,h,m:integer; f2:textfile;
begin
  if not RunSaveDialog(Save1,'editcar.car',ExtractFilePath(carname),'"World Racing" car descriptor (*.car)|*.car|All Files (*.*)|*.*') then exit;

{  case CarFmt of
    fmtMBWR:    begin fDataSet.SetTBLength(103,75); fDataSet.SetTBLength(105, 98); end;
    fmtWR2:     begin fDataSet.SetTBLength(103,80); fDataSet.SetTBLength(105,105); end;
    fmtAFC11N:  begin fDataSet.SetTBLength(103,80); fDataSet.SetTBLength(105,106); end;
    fmtFVR:     begin fDataSet.SetTBLength(103,80); fDataSet.SetTBLength(105,110); end;
  end;}

  fDataSet.SaveDS(Save1.FileName);

  exit;

if not fileexists(ExeDir+'unlimiter.'+inttostr(846)) then
begin
  EnsureRange(vi[2, 7,2],100,999); //restrict ClassID in menu to 100..999 range
  EnsureRange(vi[2,42,2],0,300); //restrict RaceClass in game to 0..300
end;

TBLib[1]:='Edit_3DCarsDB';
TBLib[2]:='Edit_CarsDB';
TBCondQty[1]:=2;
TBCondQty[2]:=2;
TBCond[1,1]:='VCarsAddOn';//WR2
TBCond[2,1]:='VCarsAddOn';//WR2
TBCond[1,2]:='WRnoDemo';  //WR/WR2
TBCond[2,2]:='WRnoDemo';  //WR/WR2
for i:=1 to DSqty do
for k:=0 to TBqty[i] do begin
  COqty[i,k]:=2; //0,actual,WR2 second car
  COid[i,k]:=k;//-1;
  COtext[i,k,1]:=dataText[i,k,1];
  COtext[i,k,2]:=dataText[i,k,2];
  COtext[i,k,3]:=dataText[i,k,3];
  COtext[i,k,4]:=dataText[i,k,4];
  COtext[i,k,5]:=dataText[i,k,5];
  for h:=1 to COqty[i,k] do
    data[i,COid[i,k],h]:=dataType[i,k{-1}];
end;//TB

m:=0;
//format specific tweaks, COtext[2,7,1] used to identify format when loading
if CarFmt=fmtMBWR then begin
  m:=1; //1..qty, don't use 0 index
  COtext[2,7,1]:='FlagMissionCar';
  vi[2,7,2]:=0;
end;
if CarFmt=fmtWR2  then begin
  m:=0;
  //COtext[2,7,1]:='CarClassID';   //filled by default
end;
if CarFmt=fmtAFC11N then
  m:=0;
if CarFmt=fmtFVR then
  m:=0;

assignfile(f2,Save1.FileName); rewrite(f2);
write(f2,'NDDSVAEn',chr2(DSqty,4),'VAst',#0,#0,#0,#0,#2,#0,#0,#0,#1,#0,#0,#0,'VAau',#0);
for i:=1 to DSqty do begin                         //103/105            //i?
  write(f2,'NDTBVAEn',chr2(TBqty[i]+1-m{number of indices},4),'VAId',chr2(101+i*2,4),'VAiC',chr(i),'VALb');
  write(f2,chr2(length(TBLib[i]),4),TBLib[i],#0,'Cond',chr2(TBCondQty[i],4));
  for j:=1 to TBCondQty[i] do write(f2,chr2(length(TBCond[i,j]),4),TBCond[i,j],#0);

  for k:=m{index to start with} to TBqty[i] do begin
    write(f2,'NDCOVAEn',chr2(COqty[i,k],4));
    write(f2,'VAId',chr2(COid[i,k],4));
    write(f2,'VALb',chr2(length(COtext[i,COid[i,k],1]),4));
    if length(COtext[i,COid[i,k],1])<>0 then write(f2,COtext[i,COid[i,k],1],#0);
    write(f2,'VAiU',#1,'VASM',chr2(length(COtext[i,COid[i,k],2]),4));
    if length(COtext[i,COid[i,k],2])<>0 then write(f2,COtext[i,COid[i,k],2],#0);
    write(f2,'VAST',chr2(length(COtext[i,COid[i,k],3]),4));
    if length(COtext[i,COid[i,k],3])<>0 then write(f2,COtext[i,COid[i,k],3],#0);
    write(f2,'VAIC',chr2(length(COtext[i,COid[i,k],4]),4));
    if length(COtext[i,COid[i,k],4])<>0 then write(f2,COtext[i,COid[i,k],4],#0);
    write(f2,'VASC',chr2(length(COtext[i,COid[i,k],5]),4));
    if length(COtext[i,COid[i,k],5])<>0 then write(f2,COtext[i,COid[i,k],5],#0);
    for h:=1 to COqty[i,k] do
      case data[i,COid[i,k],h] of //2, +1 for each car in WR2
      1: write(f2,#1,chr2(vi[i,COid[i,k],h],4));
      2: write(f2,#2,unreal2(vr[i,COid[i,k],h]));
      3: begin
           write(f2,#16,chr2(length(vs[i,COid[i,k],h]),4));
           if length(vs[i,COid[i,k],h])<>0 then
             write(f2,vs[i,COid[i,k],h],#0);
         end;
      end;
  end;   //k..TBqty
end;   //i..DSqty
closefile(f2);
end;

procedure TForm1.AboutClick(Sender: TObject);
begin
  AboutForm.Show('Version 1.5f (29 Sep 2008)','Edit car`s perfomance in "EditCar.car" file.'+eol+eol+
                          'German translation by Jonas Wolf'+eol+
                          'Hungarian translation by Nagyidai Andor'+eol+
                          'Russian translation by Krom (incomplete)','EDITCAR');
end;


procedure TForm1.FSChange(Sender: TObject);
var s1:string; z:real;
begin
  if LockControls then exit;
  UpdateDataSet();

  //Change application title according to opened file path and car name
  s1 := carname;
  if length(s1)>30 then s1 := '...'+decs(s1,-(length(s1)-32),1);
  Form1.Caption := s1+'  -  '+Edit1.Text; //path - carname
  Application.Title := Edit1.Text;

  //Fill in max speeds for gears
  if (SrpmMax.Value<>0)and(STireFR.Value<>0)and(FSGearF.Value<>0) then begin
    z := STireFR.Value/25.4/168*SrpmMax.Value/FSGearF.Value*1.625;
    if FSGear1.Value<>0 then Label143.Caption:='('+float2fix(z/FSGear1.Value,3)+' km/h)' else Label143.Caption:='';
    if FSGear2.Value<>0 then Label144.Caption:='('+float2fix(z/FSGear2.Value,3)+' km/h)' else Label144.Caption:='';
    if FSGear3.Value<>0 then Label145.Caption:='('+float2fix(z/FSGear3.Value,3)+' km/h)' else Label145.Caption:='';
    if FSGear4.Value<>0 then Label146.Caption:='('+float2fix(z/FSGear4.Value,3)+' km/h)' else Label146.Caption:='';
    if FSGear5.Value<>0 then Label147.Caption:='('+float2fix(z/FSGear5.Value,3)+' km/h)' else Label147.Caption:='';
    if FSGear6.Value<>0 then Label148.Caption:='('+float2fix(z/FSGear6.Value,3)+' km/h)' else Label148.Caption:='';
    if FSGear7.Value<>0 then Label149.Caption:='('+float2fix(z/FSGear7.Value,3)+' km/h)' else Label149.Caption:='';
    if FSGearR.Value<>0 then Label150.Caption:='('+float2fix(z/FSGearR.Value,3)+' km/h)' else Label150.Caption:='';
  end;

  //Fill in standard Tire sizes
  if (STireFW.Text<>'')and(STireRW.Text<>'')and(STireFW.Value<>0)and(STireRW.Value<>0) then begin
    TireFrontSize.Caption:=STireFW.Text+'/'+
    inttostr(round((STireFR.Value-STireFD.Value*12.7)/STireFW.Value*100))+' R'+STireFD.Text;
    TireRearSize.Caption:=STireRW.Text+'/'+
    inttostr(round((STireRR.Value-STireRD.Value*12.7)/STireRW.Value*100))+' R'+STireRD.Text;
  end;

  Label142.Caption := inttostr(STireFZ.Value-STireRZ.Value)+' mm';
  if RGFormat.ItemIndex=0 then LkmhID.Caption:=kmhID[SkmhID.Value] else LkmhID.Caption:=WRkmhID[SkmhID.Value];
  if RGFormat.ItemIndex=0 then LmphID.Caption:=mphID[SmphID.Value] else LmphID.Caption:=WRmphID[SmphID.Value];
  LtachoID.Caption := WRtachoID[StachoID.Value];
end;

procedure TForm1.PageChange(Sender: TObject);
begin
  if PageControl2.ActivePageIndex = PageControl2.PageCount-1 then RefreshVLE else UpdateControls;
  if PageControl2.ActivePage.Caption = 'Engine' then TorqueMouseMove(nil,[ssShift],0,0);
end;

procedure TForm1.TorqueMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var i,u,v:integer;
begin
{$IFDEF VER140}
  if (LineSerieHP = nil) or (LineSerieNM = nil) then exit;
  if LineSerieHP.Count <> 21 then exit; //yet empty

  u := EnsureRange(round(LineSerieHP.XScreenToValue(X)/SNMStep.Value),0,20);
  v := max(round(LineSerieHP.YScreenToValue(Y)),0);

  Chart1.Title.Text.Strings[0] := 'Torque/RPM (HP) - '+inttostr(v)+'/'+inttostr(u*SNMStep.Value)+' ('+inttostr(round(v*u*SNMStep.Value/7023.5))+')';
   if (ssLeft in Shift) then begin
    fDataSet.SetValue(2,51+u,2,v+0.0);
    LineSerieHP.YValue[u] := v;
    //LineSerieHP.SetYValue(u,v);
  end;
  for i:=1 to 20 do
    LineSerieNM.YValue[i] := round(i*LineSerieHP.YValue[i]*SNMStep.Value/7023.5);
    //LineSerieNM.SetYValue(i, round(i*LineSerieHP.GetYValue(i)*SNMStep.Value/7023.5));
{$ENDIF}
end;

procedure TForm1.TorqueMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
{$IFDEF VER140}
  Chart1.LeftAxis.Maximum := round(LineSerieHP.MaxYValue*1.2);
  if Chart1.LeftAxis.Maximum = 0 then Chart1.LeftAxis.Maximum := 500;
  UpdateDataSet;
{$ENDIF}
end;

procedure TForm1.FSChangeLink(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
FSChange(Form1);
end;

procedure TForm1.FSChange2(Sender: TObject);
begin
if allowFS2 then begin
SDriverX2.Value:=DFX.Value;
SDriverY2.Value:=DFY.Value-37;
SDriverZ2.Value:=DFZ.Value+27;
SDriverX1.Value:=DMX.Value-1;
SDriverY1.Value:=DMY.Value-21;
SDriverZ1.Value:=DMZ.Value+69;
end;
end;


//We enable all controls and then disable ones that aren't usable by current EditingFormat
procedure TForm1.RGFormatClick(Sender: TObject);
var i:integer;
begin
  LockControls := true;
FSChange(nil);
for i:=0 to Form1.ComponentCount-1 do
//Components with Tag=888 are protected from enabling
if TComponent(Form1.Components[i]).Tag<>888 then begin
  if Form1.Components[i] is TControl then TControl(Form1.Components[i]).Enabled:=true;
  if Form1.Components[i] is TLabel then TLabel(Form1.Components[i]).Enabled:=true;
end;

case RGFormat.ItemIndex of
  0: CarFmt := fmtMBWR;
  1: CarFmt := fmtWR2;
  2: CarFmt := fmtAFC11N;
  3: CarFmt := fmtFVR;
  4: CarFmt := fmtAFC11HN;
end;

  //Identity tab
  Label31.Enabled       := CarFmt in [fmtMBWR]; //Cabrio Folder
  Edit8.Enabled         := CarFmt in [fmtMBWR]; //Cabrio Folder

  Label56.Enabled       := CarFmt in [fmtMBWR]; //Class Name
  Edit2.Enabled         := CarFmt in [fmtMBWR]; //Class Name

  CBCabrio1.Enabled     := CarFmt in [fmtMBWR]; //Cabrio checkbox
  CBCabrio2.Enabled     := CarFmt in [fmtMBWR]; //Cabrio checkbox

  Label33.Enabled       := CarFmt in [fmtMBWR, fmtWR2, fmtAFC11N]; //Menu Class
  SClassID.Enabled      := CarFmt in [fmtMBWR, fmtWR2, fmtAFC11N]; //Menu Class
  Label50.Enabled       := CarFmt in [fmtWR2, fmtAFC11N]; //Score to Open
  SScore.Enabled        := CarFmt in [fmtWR2, fmtAFC11N]; //Score to Open
  Memo1.Enabled         := CarFmt in [fmtWR2, fmtAFC11N];     //Score to Open memo

  //Appearance tab
  Label41.Enabled       := CarFmt in [fmtMBWR]; //Motor Sound File
  Edit7.Enabled         := CarFmt in [fmtMBWR]; //Motor Sound File

  Label116.Enabled      := CarFmt in [fmtWR2, fmtAFC11N]; //Engine m_ms
  SAusID.Enabled        := CarFmt in [fmtWR2, fmtAFC11N]; //Engine m_ms
  Label117.Enabled      := CarFmt in [fmtWR2, fmtAFC11N]; //Exhaust m_ap
  SMotID.Enabled        := CarFmt in [fmtWR2, fmtAFC11N]; //Exhaust m_ap
  Label120.Enabled      := CarFmt in [fmtWR2, fmtAFC11N]; //Saug.. m_saug
  SSaug.Enabled         := CarFmt in [fmtWR2, fmtAFC11N]; //Saug.. m_saug
  Label121.Enabled      := CarFmt in [fmtWR2, fmtAFC11N]; //Last.. m_last
  SLastger.Enabled      := CarFmt in [fmtWR2, fmtAFC11N]; //Last.. m_last

  Label30.Enabled       := CarFmt in [fmtMBWR]; // Cabrio brakelights IDs
  SappCAB1.Enabled      := CarFmt in [fmtMBWR]; // Cabrio brakelights IDs
  SappCAB2.Enabled      := CarFmt in [fmtMBWR]; // Cabrio brakelights IDs
  SappCAB3.Enabled      := CarFmt in [fmtMBWR]; // Cabrio brakelights IDs

  LtachoID.Enabled      := CarFmt in [fmtWR2, fmtAFC11N, fmtFVR]; //Tacho ID
  STachoID.Enabled      := CarFmt in [fmtWR2, fmtAFC11N, fmtFVR]; //Tacho ID

  Label99.Enabled       := CarFmt in [fmtMBWR]; // bez1.tga
  TypLink.Enabled       := CarFmt in [fmtMBWR]; // bez1.tga
  Label86.Enabled       := CarFmt in [fmtMBWR]; // bez2.tga
  TypRech.Enabled       := CarFmt in [fmtMBWR]; // bez2.tga

  Label114.Enabled      := CarFmt in [fmtWR2, fmtAFC11N]; //Default Menu Color
  SColor.Enabled        := CarFmt in [fmtWR2, fmtAFC11N]; //Default Menu Color
  Label152.Enabled      := CarFmt in [fmtAFC11N]; //Caravan
  Caravan.Enabled       := CarFmt in [fmtAFC11N]; //Caravan


if RGFormat.ItemIndex=0 then begin
  Label118.Enabled:=false;
  Hersteller.Enabled:=false;
  Label153.Enabled:=false;
  Logo.Enabled:=false;
  Label133.Enabled:=false;
  RaceClass1_4.Items[0]:='Series';
  RaceClass1_4.Items[1]:='Racing';
  RaceClass1_4.Items[2]:='Prototype';
  RaceClass1_4.Items[3]:='Vintage';
end;

if RGFormat.ItemIndex=1 then begin
  RaceClass1_4.Items[0]:='Racing';
  RaceClass1_4.Items[1]:='Series';
  RaceClass1_4.Items[2]:='Rally';
  RaceClass1_4.Items[3]:='Off-Roader';
end;

if RGFormat.ItemIndex=2 then begin
  RaceClass1_4.Items[0]:='Racing';
  RaceClass1_4.Items[1]:='Series';
  RaceClass1_4.Items[2]:='Rally';
  RaceClass1_4.Items[3]:='Off-Roader';
end;

if RGFormat.ItemIndex=3 then begin //Ferrari Virtual Race
  Label118.Enabled:=false;
  Hersteller.Enabled:=false;
  Label153.Enabled:=false;
  Logo.Enabled:=false;
  RaceClass1_4.Enabled:=false;
  Label127.Enabled:=false;
  SRaceClass.Enabled:=false;
  //Appearance
  Label42.Enabled:=false;
  SSrate.Enabled:=false;
  Label54.Enabled:=false;
  SLautstarke.Enabled:=false;
  Label33.Enabled:=false;
  Label29.Enabled:=false;
  SappBR1.Enabled:=false;
  SappBR2.Enabled:=false;
  SappBR3.Enabled:=false;
end;

  LockControls := false;
//FSChange(nil);
end;

procedure TForm1.BrowseForWR2DSClick(Sender: TObject);
begin
if Sender=BrowseForWRDS then begin
  if not RunOpenDialog(Open1,'','','MBWR database (WR.ds)|wr.ds|All Files (*.*)|*.*') then exit;
  WRDSPath.Text:=Open1.FileName;
  ScanWR2DS('WR1');
end;

if Sender=BrowseForWR2DS then begin
  if not RunOpenDialog(Open1,'','','WR2 database (WR2.ds)|wr2.ds|All Files (*.*)|*.*') then exit;
  WR2DSPath.Text:=Open1.FileName;
  ScanWR2DS('WR2');
end;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePageIndex=1 then ScanWR2DS('WR1');
  if PageControl1.ActivePageIndex=2 then ScanWR2DS('WR2');
end;

procedure TForm1.ScanWR2DS(Sender:string);
var DSqty,TBqty,COqty:integer;
 i,j,k,h,m:integer;
 s,s2:string;
 c:array [1..2048] of char;
 f:file;
begin
LB2Model.Enabled:=false;
ImportWR2Car.Enabled:=false;
LBModel.Enabled:=false;
ImportWRCar.Enabled:=false;

if Sender='WR1' then begin
  if FileExists(WRDSPath.Text) then
    assignfile(f,WRDSPath.Text)
  else
    if FileExists(ExeDir+'WR.ds') then begin
      assignfile(f,ExeDir+'WR.ds');
      WRDSPath.Text:='.\WR.ds';
    end else
      exit;
end;

if Sender='WR2' then begin
  if FileExists(WR2DSPath.Text) then
    assignfile(f,WR2DSPath.Text)
  else
    if FileExists(ExeDir+'WR2.ds') then begin
      assignfile(f,ExeDir+'WR2.ds');
      WR2DSPath.Text:='.\WR2.ds';
    end else
      exit;
end;

FileMode:=0; reset(f,1); FileMode:=2;
blockread(f,c,33);
DSqty:=ord(c[9]);
setlength(Title,DSqty); //0..DS
setlength(Value,DSqty); //0..DS
for i:=1 to 42{DSqty} do begin //(Value[42-1]) to save time
blockread(f,c,33);
TBqty:=ord(c[9]);
j:=ord(c[30]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
setlength(Title[i-1],TBqty+1);
setlength(Value[i-1],TBqty);
Title[i-1][TBqty]:=s; s:='';

for k:=1 to TBqty do begin
blockread(f,c,12);//28
COqty:=ord(c[9])+ord(c[10])*256;
if c[1]<>'N' then begin
j:=ord(c[5]);       //Cond
  for m:=1 to j do begin
    if m=1 then blockread(f,c,ord(c[9])+1);
    if m>1 then begin blockread(f,c,4); blockread(f,c,ord(c[1])+1); end;
  end;
blockread(f,c,12);//28
COqty:=ord(c[9])+ord(c[10])*256;
end;
blockread(f,c,16);
j:=ord(c[13]);
if j<>0 then blockread(f,c,j+1);                //VAlb
for m:=1 to j do s:=s+c[m];
//writeln(fo,'Title - '+s);
Title[i-1][k-1]:=s; s:='';
blockread(f,c,13);
j:=ord(c[10]);
if j<>0 then blockread(f,c,j+1);                //VASM (file path)
for m:=1 to j do s:=s+c[m];
//writeln(fo,'DB path - '+s);
s:='';
blockread(f,c,8);
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1);               //DB name
for m:=1 to j do s:=s+c[m];
//writeln(fo,'DB name - '+s);
s:='';
blockread(f,c,8);
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1);               //SC...
for m:=1 to j do s:=s+c[m];
//writeln(fo,'... - '+s);
s:='';
blockread(f,c,8);
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1);               //IC...
for m:=1 to j do s:=s+c[m];
//writeln(fo,'... - '+s);
s:='';

setlength(Value[i-1][k-1],COqty);
for j:=1 to COqty do begin
blockread(f,c,1);

if c[1]=#1 then
blockread(f,Value[i-1][k-1][j-1].Int,4) else

if c[1]=#2 then
blockread(f,Value[i-1][k-1][j-1].Rel,4) else

if c[1]=#16 then begin
blockread(f,h,4); s:='';
if h<>0 then blockread(f,c,h+1);
for m:=1 to h do s:=s+c[m]; Value[i-1][k-1][j-1].Str:=s; s:='';
end;// else
//s:='0';

end;
end;
end; //1..DSqty
closefile(f);
if Sender='WR2' then begin
LB2Model.Clear;
for i:=1 to length(Value[23][0])-1 do begin//NumCars
s:=inttostr(i div 10)+inttostr(i mod 10)+'.';
for k:=length(Value[23][43][i].Str+' '+Value[23][2][i].Str) to 160 do s:=' '+s; //store ID in 160+
{$IFDEF VER140}
LB2Model.AddItem(Value[23][43][i].Str+' '+Value[23][2][i].Str+s,nil);
{$ENDIF}
{$IFDEF FPC}
LB2Model.Items.AddObject(Value[23][43][i].Str+' '+Value[23][2][i].Str+s,nil);
{$ENDIF}
end;
setlength(Value[23][14],96);//special fix
setlength(Value[23][40],96);//special fix
setlength(Value[38][25],83);//special fix
LB2Model.Enabled:=true;
ImportWR2Car.Enabled:=true;
end;
if Sender='WR1' then begin
LBModel.Clear;
for i:=1 to length(Value[23][0])-1 do begin
s:=Value[23][2][i].Str; j:=0;
for k:=1 to length(s)-2 do j:=j*10+strtoint(s[k+1]);
s:=Value[30][21][Value[23][1][i].Int].Str; m:=0;
for k:=1 to length(s)-2 do m:=m*10+strtoint(s[k+1]);
s:=inttostr(i div 100)+inttostr(i div 10 mod 10)+inttostr(i mod 10)+'.';
if (Value[0][2][m].Str+' '+Value[0][2][j].Str)<>' ' then
s2:=Value[0][2][m].Str+' '+Value[0][2][j].Str else
if (Value[0][1][m].Str+' '+Value[0][1][j].Str)<>' ' then
s2:=Value[0][1][m].Str+' '+Value[0][1][j].Str else
if (Value[0][6][m].Str+' '+Value[0][6][j].Str)<>' ' then
s2:=Value[0][6][m].Str+' '+Value[0][6][j].Str;
for k:=length(s2) to 160 do s:=' '+s; //store ID in 160+
{$IFDEF VER140}
LB2Model.AddItem(s2+s,nil);
{$ENDIF}
{$IFDEF FPC}
LB2Model.Items.AddObject(s2+s,nil);
{$ENDIF}
end;
LBModel.Enabled:=true;
ImportWRCar.Enabled:=true;
end;
end;

procedure TForm1.ImportWR2CarClick(Sender: TObject);
var i,id:integer;
begin
id:=strtoint(LB2Model.Items[LB2Model.ItemIndex][162]+LB2Model.Items[LB2Model.ItemIndex][163]);
//Label115.Caption:=inttostr(id); //ID stored beyond visibility :-)
vi[2,1,2]:=Value[23][0][id].Int;//
vi[2,2,2]:=Value[23][1][id].Int;//
vs[2,3,2]:=Value[23][2][id].Str;
vi[2,4,2]:=Value[23][3][id].Int;
vi[2,5,2]:=Value[23][4][id].Int;//FlagRelease
vi[2,6,2]:=Value[23][5][id].Int;
vi[2,7,2]:=Value[23][6][id].Int;//CarClassID (menu)
vi[2,8,2]:=Value[23][7][id].Int;
vr[2,9,2]:=Value[23][8][id].Rel;
vi[2,10,2]:=Value[23][9][id].Int;
vi[2,11,2]:=Value[23][10][id].Int;//MotorID
vi[2,12,2]:=Value[23][11][id].Int;//GetriebeID
vi[2,13,2]:=Value[23][12][id].Int;//WheelsFrontID
vi[2,14,2]:=Value[23][13][id].Int;//WheelsRearID
vs[2,15,2]:=Value[23][14][id].Str;//TypLinks
vi[2,16,2]:=Value[23][15][id].Int;//Damper
vi[2,17,2]:=Value[23][16][id].Int;//Feather
vr[2,18,2]:=Value[23][17][id].Rel;//
vr[2,19,2]:=Value[23][18][id].Rel;//
vr[2,20,2]:=Value[23][19][id].Rel;//
vr[2,21,2]:=Value[23][20][id].Rel;//
vi[2,22,2]:=Value[23][21][id].Int;//
vr[2,23,2]:=Value[23][22][id].Rel;//SlipF
vr[2,24,2]:=Value[23][23][id].Rel;//SlipR
vr[2,25,2]:=Value[23][24][id].Rel;//
vr[2,26,2]:=Value[23][25][id].Rel;//
vi[2,27,2]:=Value[23][26][id].Int;//WeightDistr
vr[2,28,2]:=Value[23][27][id].Rel;//
vi[2,29,2]:=Value[23][28][id].Int;//
vi[2,30,2]:=10;//Fuel consumtion rate ?
vi[2,31,2]:=100;//Fuel tank volume
vi[2,32,2]:=Value[23][29][id].Int;//Weight_KG
vi[2,33,2]:=1;// ??
vi[2,34,2]:=0;// ??
vr[2,35,2]:=3;// Drivewheel turn rounds
vi[2,36,2]:=Value[23][30][id].Int;//DriveWheels
vr[2,37,2]:=Value[23][31][id].Rel;//
vr[2,38,2]:=Value[23][32][id].Rel;//AirBrake
vi[2,39,2]:=Value[23][33][id].Int;//
vi[2,40,2]:=Value[23][34][id].Int;//
vi[2,41,2]:=Value[23][35][id].Int;//Sperrdiff
vi[2,42,2]:=Value[23][36][id].Int;//
vr[2,43,2]:=Value[23][37][id].Rel;//WheelYPOS
vr[2,44,2]:=Value[23][38][id].Rel;//WheelYPOS
vi[2,45,2]:=Value[23][39][id].Int;//
vs[2,46,2]:=Value[23][40][id].Str;//TypRechts
vi[2,47,2]:=Value[23][41][id].Int;//
vi[2,48,2]:=Value[23][42][id].Int;//
vs[2,104,2]:=Value[23][43][id].Str;//Name
vs[2,105,2]:=Value[23][44][id].Str;//Logo
vs[2,106,2]:='';//Caravan
//MotorenDB
vi[2,49,2]:=Value[38][1][Value[23][10][id].Int].Int;//MaxRPM
for i:=0 to 20 do
vr[2,50+i,2]:=Value[38][2+i][Value[23][10][id].Int].Rel;//0-10k
vr[2,71,2]:=Value[38][23][Value[23][10][id].Int].Rel;//NMStep
vi[2,72,2]:=0;//MotorBremse
vi[2,73,2]:=0;//Schwungmasse
vi[2,74,2]:=Value[38][24][Value[23][10][id].Int].Int;
vs[2,75,2]:=Value[38][25][Value[23][10][id].Int].Str;
vi[2,76,2]:=Value[38][26][Value[23][10][id].Int].Int;//
vi[2,77,2]:=Value[38][27][Value[23][10][id].Int].Int;//
vs[2,78,2]:=Value[38][28][Value[23][10][id].Int].Str;
vs[2,79,2]:=Value[38][29][Value[23][10][id].Int].Str;
vi[2,80,2]:=Value[38][30][Value[23][10][id].Int].Int;
vs[2,81,2]:=Value[38][31][Value[23][10][id].Int].Str;
vi[2,82,2]:=2; // ??
vi[2,83,2]:=Value[38][32][Value[23][10][id].Int].Int;//Laustaerke
vi[2,99,2]:=Value[38][37][Value[23][10][id].Int].Int;//Drehzahlmesser
vi[2,100,2]:=Value[38][33][Value[23][10][id].Int].Int;
vi[2,101,2]:=Value[38][34][Value[23][10][id].Int].Int;
vi[2,102,2]:=Value[38][35][Value[23][10][id].Int].Int;
vi[2,103,2]:=Value[38][36][Value[23][10][id].Int].Int;
//GearboxDB
vi[2,84,2]:=Value[39][1][Value[23][11][id].Int].Int;//NumGears
vr[2,85,2]:=Value[39][2][Value[23][11][id].Int].Rel;//
vr[2,86,2]:=Value[39][3][Value[23][11][id].Int].Rel;//
vr[2,87,2]:=Value[39][4][Value[23][11][id].Int].Rel;//
vr[2,88,2]:=Value[39][5][Value[23][11][id].Int].Rel;//
vr[2,89,2]:=Value[39][6][Value[23][11][id].Int].Rel;//
vr[2,90,2]:=Value[39][7][Value[23][11][id].Int].Rel;//
vr[2,91,2]:=Value[39][8][Value[23][11][id].Int].Rel;//
vr[2,92,2]:=Value[39][9][Value[23][11][id].Int].Rel;//
//TiresDB
vr[2,93,2]:=Value[40][1][Value[23][12][id].Int].Rel;//F
vr[2,94,2]:=Value[40][2][Value[23][12][id].Int].Rel;
vr[2,95,2]:=Value[40][3][Value[23][12][id].Int].Rel;
vr[2,96,2]:=Value[40][1][Value[23][13][id].Int].Rel;//R
vr[2,97,2]:=Value[40][2][Value[23][13][id].Int].Rel;
vr[2,98,2]:=Value[40][3][Value[23][13][id].Int].Rel;
//[1]
vi[1,1,2]:=Value[29][0][Value[23][1][id].Int].Int;//
vs[1,2,2]:=Value[29][1][Value[23][1][id].Int].Str;//
vs[1,3,2]:='';//EngineNameClose
vi[1,4,2]:=0;//FlagCabrio
vr[1,5,2]:=Value[29][2][Value[23][1][id].Int].Rel;//
vr[1,6,2]:=Value[29][3][Value[23][1][id].Int].Rel;//
vr[1,7,2]:=Value[29][4][Value[23][1][id].Int].Rel;//
vr[1,8,2]:=Value[29][5][Value[23][1][id].Int].Rel;//
vi[1,9,2]:=Value[29][6][Value[23][1][id].Int].Int;//
vi[1,10,2]:=Value[29][7][Value[23][1][id].Int].Int;//
vi[1,11,2]:=Value[29][8][Value[23][1][id].Int].Int;//
vi[1,12,2]:=-1;//SWLight
vi[1,13,2]:=-1;//
vi[1,14,2]:=-1;//
vr[1,15,2]:=Value[29][9][Value[23][1][id].Int].Rel;//
vr[1,16,2]:=Value[29][10][Value[23][1][id].Int].Rel;//
vr[1,17,2]:=Value[29][11][Value[23][1][id].Int].Rel;//
vr[1,18,2]:=Value[29][12][Value[23][1][id].Int].Rel;//
vr[1,19,2]:=Value[29][13][Value[23][1][id].Int].Rel;//
vr[1,20,2]:=Value[29][14][Value[23][1][id].Int].Rel;//
vi[1,21,2]:=-1;//LastSelectCar
vs[1,22,2]:='';//ClassName
vi[1,23,2]:=-1;//Order
vs[1,24,2]:='';//Ref3DCarsOrder
vi[1,25,2]:=Value[29][15][Value[23][1][id].Int].Int;//
vr[1,26,2]:=Value[29][16][Value[23][1][id].Int].Rel;//
vi[1,27,2]:=Value[29][17][Value[23][1][id].Int].Int;//FlagCabrio?
vi[1,28,2]:=-1;//CAB.BRLight
vi[1,29,2]:=-1;//
vi[1,30,2]:=-1;//
vi[1,31,2]:=Value[29][18][Value[23][1][id].Int].Int;//Vinyl
vi[1,32,2]:=Value[29][19][Value[23][1][id].Int].Int;//
vi[1,33,2]:=Value[29][20][Value[23][1][id].Int].Int;//
vi[1,34,2]:=Value[29][21][Value[23][1][id].Int].Int;//
vi[1,35,2]:=Value[29][22][Value[23][1][id].Int].Int;//Color
vi[1,36,2]:=Value[29][23][Value[23][1][id].Int].Int;//
vi[1,37,2]:=Value[29][24][Value[23][1][id].Int].Int;//
vi[1,38,2]:=Value[29][25][Value[23][1][id].Int].Int;//
vi[1,39,2]:=Value[29][26][Value[23][1][id].Int].Int;//Rims
vi[1,40,2]:=Value[29][27][Value[23][1][id].Int].Int;//
vi[1,41,2]:=Value[29][28][Value[23][1][id].Int].Int;//
vi[1,42,2]:=Value[29][29][Value[23][1][id].Int].Int;//

vr[1,43,2]:=Value[29][30][Value[23][1][id].Int].Rel;//
vr[1,44,2]:=Value[29][31][Value[23][1][id].Int].Rel;//
vr[1,45,2]:=Value[29][32][Value[23][1][id].Int].Rel;//
vr[1,46,2]:=Value[29][33][Value[23][1][id].Int].Rel;//
vr[1,47,2]:=Value[29][34][Value[23][1][id].Int].Rel;//
vr[1,48,2]:=Value[29][35][Value[23][1][id].Int].Rel;//
vr[1,49,2]:=Value[29][36][Value[23][1][id].Int].Rel;//
vr[1,50,2]:=vr[1,43,2];//Female Head - same
vr[1,51,2]:=vr[1,44,2];//
vr[1,52,2]:=vr[1,45,2];//
vi[1,53,2]:=Value[29][37][Value[23][1][id].Int].Int;//
vr[1,54,2]:=Value[29][38][Value[23][1][id].Int].Rel;//
vr[1,55,2]:=Value[29][39][Value[23][1][id].Int].Rel;//
vr[1,56,2]:=Value[29][40][Value[23][1][id].Int].Rel;//
vr[1,57,2]:=Value[29][41][Value[23][1][id].Int].Rel;//
vr[1,58,2]:=Value[29][42][Value[23][1][id].Int].Rel;//
vr[1,59,2]:=Value[29][43][Value[23][1][id].Int].Rel;//
vr[1,60,2]:=Value[29][44][Value[23][1][id].Int].Rel;//
vr[1,61,2]:=Value[29][45][Value[23][1][id].Int].Rel;//
vr[1,62,2]:=Value[29][46][Value[23][1][id].Int].Rel;//
vi[1,63,2]:=Value[29][47][Value[23][1][id].Int].Int;//
vr[1,64,2]:=Value[29][48][Value[23][1][id].Int].Rel;//
vr[1,65,2]:=Value[29][49][Value[23][1][id].Int].Rel;//
vr[1,66,2]:=Value[29][50][Value[23][1][id].Int].Rel;//
vr[1,67,2]:=Value[29][51][Value[23][1][id].Int].Rel;//
vr[1,68,2]:=Value[29][52][Value[23][1][id].Int].Rel;//
vr[1,69,2]:=Value[29][53][Value[23][1][id].Int].Rel;//
vr[1,70,2]:=Value[29][54][Value[23][1][id].Int].Rel;//
vr[1,71,2]:=Value[29][55][Value[23][1][id].Int].Rel;//
vr[1,72,2]:=Value[29][56][Value[23][1][id].Int].Rel;//
vi[1,73,2]:=0;//Order26
vr[1,74,2]:=Value[29][57][Value[23][1][id].Int].Rel;//
vr[1,75,2]:=Value[29][58][Value[23][1][id].Int].Rel;//
//vi[1,76,2]:=
//vi[1,77,2]:=
//vi[1,78,2]:=
//vi[1,79,2]:=
vi[1,80,2]:=Value[29][63][Value[23][1][id].Int].Int;//ColorIndex

vi[1,1,2]:=0;//Index
vi[1,23,2]:=0;//Order
vi[1,73,2]:=0;//Order26
vi[2,1,2]:=0;//Index
vi[2,2,2]:=0;//3DCarID
vi[2,11,2]:=0;//Motoren
vi[2,12,2]:=0;//Gearbox
vi[2,13,2]:=0;//TiresF
vi[2,14,2]:=0;//TiresR
//RefreshFS;
//RefreshVLE;       //Update List
//FSChange(Form1);
end;

procedure TForm1.ImportWRCarClick(Sender: TObject);
var i,k,m,id:integer;
  s:string;
begin
id:=strtoint(LBModel.Items[LBModel.ItemIndex][162]+LBModel.Items[LBModel.ItemIndex][163]+LBModel.Items[LBModel.ItemIndex][164]);
vi[2,1,2]:=Value[23][0][id].Int;//
vi[2,2,2]:=Value[23][1][id].Int;//
s:=Value[23][2][id].Str; m:=0;
for k:=1 to length(s)-2 do m:=m*10+strtoint(s[k+1]);
if Value[0][2][m].Str<>'' then vs[2,3,2]:=Value[0][2][m].Str else
if Value[0][1][m].Str<>'' then vs[2,3,2]:=Value[0][1][m].Str else
if Value[0][6][m].Str<>'' then vs[2,3,2]:=Value[0][6][m].Str;
vi[2,4,2]:=Value[23][3][id].Int;
vi[2,5,2]:=Value[23][4][id].Int;//FlagRelease
vi[2,6,2]:=Value[23][5][id].Int;
vi[2,7,2]:=Value[23][6][id].Int;//CarClassID (menu)
vi[2,8,2]:=Value[23][7][id].Int;
vr[2,9,2]:=Value[23][8][id].Rel;
vi[2,10,2]:=Value[23][9][id].Int;
vi[2,11,2]:=Value[23][10][id].Int;//MotorID
vi[2,12,2]:=Value[23][11][id].Int;//GetriebeID
vi[2,13,2]:=Value[23][12][id].Int;//WheelsFrontID
vi[2,14,2]:=Value[23][13][id].Int;//WheelsRearID
vs[2,15,2]:=Value[23][14][id].Str;//TypLinks
vi[2,16,2]:=Value[23][15][id].Int;//Damper
vi[2,17,2]:=Value[23][16][id].Int;//Feather
vr[2,18,2]:=Value[23][17][id].Rel;//
vr[2,19,2]:=Value[23][18][id].Rel;//
vr[2,20,2]:=Value[23][19][id].Rel;//
vr[2,21,2]:=Value[23][20][id].Rel;//
vi[2,22,2]:=Value[23][21][id].Int;//
vr[2,23,2]:=Value[23][22][id].Rel;//SlipF
vr[2,24,2]:=Value[23][23][id].Rel;//SlipR
vr[2,25,2]:=Value[23][24][id].Rel;//
vr[2,26,2]:=Value[23][25][id].Rel;//
vi[2,27,2]:=Value[23][26][id].Int;//WeightDistr
vr[2,28,2]:=Value[23][27][id].Rel;//
vi[2,29,2]:=Value[23][28][id].Int;//
vr[2,30,2]:=Value[23][29][id].Rel;//Fuel consumtion rate ?
vi[2,31,2]:=Value[23][30][id].Int;//Fuel tank volume
vi[2,32,2]:=Value[23][31][id].Int;//Weight_KG
vi[2,33,2]:=Value[23][32][id].Int;// ??
vr[2,34,2]:=Value[23][33][id].Rel;// ??
vr[2,35,2]:=Value[23][34][id].Rel;// Drivewheel turn rounds
vi[2,36,2]:=Value[23][35][id].Int;//DriveWheels
vr[2,37,2]:=Value[23][36][id].Rel;//
vr[2,38,2]:=Value[23][37][id].Rel;//AirBrake
vi[2,39,2]:=Value[23][38][id].Int;//
vi[2,40,2]:=Value[23][39][id].Int;//
vi[2,41,2]:=Value[23][40][id].Int;//Sperrdiff
vi[2,42,2]:=Value[23][41][id].Int;//RaceClass
vr[2,43,2]:=Value[23][42][id].Rel;//WheelYPOS
vr[2,44,2]:=Value[23][43][id].Rel;//
vi[2,45,2]:=Value[23][44][id].Int;//
vs[2,46,2]:=Value[23][45][id].Str;//TypRechts
vi[2,47,2]:=Value[23][46][id].Int;//
vi[2,48,2]:=Value[23][47][id].Int;//
vs[2,104,2]:='';//Name
vs[2,105,2]:='';//Logo
vs[2,106,2]:='';//Caravan
//MotorenDB
vi[2,49,2]:=Value[39][1][Value[23][10][id].Int].Int;//MaxRPM
for i:=0 to 20 do
vr[2,50+i,2]:=Value[39][2+i][Value[23][10][id].Int].Rel;//0-10k
vr[2,71,2]:=Value[39][23][Value[23][10][id].Int].Rel;//NMStep
vr[2,72,2]:=Value[39][24][Value[23][10][id].Int].Rel;//MotorBremse
vr[2,73,2]:=Value[39][25][Value[23][10][id].Int].Rel;//Schwungmasse
vi[2,74,2]:=Value[39][26][Value[23][10][id].Int].Int;
vs[2,75,2]:=Value[39][27][Value[23][10][id].Int].Str;
vi[2,76,2]:=Value[39][28][Value[23][10][id].Int].Int;//
vi[2,77,2]:=Value[39][29][Value[23][10][id].Int].Int;//
vs[2,78,2]:=Value[39][30][Value[23][10][id].Int].Str;
vs[2,79,2]:=Value[39][31][Value[23][10][id].Int].Str;
vi[2,80,2]:=Value[39][32][Value[23][10][id].Int].Int;
vs[2,81,2]:=Value[39][33][Value[23][10][id].Int].Str;
vi[2,82,2]:=Value[39][34][Value[23][10][id].Int].Int;// ??
vi[2,83,2]:=Value[39][35][Value[23][10][id].Int].Int;//Laustaerke
vi[2,99,2]:=0;//Drehzahlmesser
vi[2,100,2]:=0;
vi[2,101,2]:=0;
vi[2,102,2]:=0;
vi[2,103,2]:=0;
//GearboxDB
vi[2,84,2]:=Value[40][1][Value[23][11][id].Int].Int;//NumGears
vr[2,85,2]:=Value[40][2][Value[23][11][id].Int].Rel;//
vr[2,86,2]:=Value[40][3][Value[23][11][id].Int].Rel;//
vr[2,87,2]:=Value[40][4][Value[23][11][id].Int].Rel;//
vr[2,88,2]:=Value[40][5][Value[23][11][id].Int].Rel;//
vr[2,89,2]:=Value[40][6][Value[23][11][id].Int].Rel;//
vr[2,90,2]:=Value[40][7][Value[23][11][id].Int].Rel;//
vr[2,91,2]:=Value[40][8][Value[23][11][id].Int].Rel;//
vr[2,92,2]:=Value[40][9][Value[23][11][id].Int].Rel;//
//TiresDB
vr[2,93,2]:=Value[41][1][Value[23][12][id].Int].Rel;//F
vr[2,94,2]:=Value[41][2][Value[23][12][id].Int].Rel;
vr[2,95,2]:=Value[41][3][Value[23][12][id].Int].Rel;
vr[2,96,2]:=Value[41][1][Value[23][13][id].Int].Rel;//R
vr[2,97,2]:=Value[41][2][Value[23][13][id].Int].Rel;
vr[2,98,2]:=Value[41][3][Value[23][13][id].Int].Rel;
//[1]
vi[1,1,2]:=Value[30][0][Value[23][1][id].Int].Int;//
vs[1,2,2]:=Value[30][1][Value[23][1][id].Int].Str;//
vs[1,3,2]:=Value[30][2][Value[23][1][id].Int].Str;//EngineNameClose
vi[1,4,2]:=Value[30][3][Value[23][1][id].Int].Int;//FlagCabrio
vr[1,5,2]:=Value[30][4][Value[23][1][id].Int].Rel;//
vr[1,6,2]:=Value[30][5][Value[23][1][id].Int].Rel;//
vr[1,7,2]:=Value[30][6][Value[23][1][id].Int].Rel;//
vr[1,8,2]:=Value[30][7][Value[23][1][id].Int].Rel;//
vi[1,9,2]:=Value[30][8][Value[23][1][id].Int].Int;//
vi[1,10,2]:=Value[30][9][Value[23][1][id].Int].Int;//
vi[1,11,2]:=Value[30][10][Value[23][1][id].Int].Int;//
vi[1,12,2]:=Value[30][11][Value[23][1][id].Int].Int;//SWLight
vi[1,13,2]:=Value[30][12][Value[23][1][id].Int].Int;//
vi[1,14,2]:=Value[30][13][Value[23][1][id].Int].Int;//
vr[1,15,2]:=Value[30][14][Value[23][1][id].Int].Rel;//
vr[1,16,2]:=Value[30][15][Value[23][1][id].Int].Rel;//
vr[1,17,2]:=Value[30][16][Value[23][1][id].Int].Rel;//
vr[1,18,2]:=Value[30][17][Value[23][1][id].Int].Rel;//
vr[1,19,2]:=Value[30][18][Value[23][1][id].Int].Rel;//
vr[1,20,2]:=Value[30][19][Value[23][1][id].Int].Rel;//
vi[1,21,2]:=Value[30][20][Value[23][1][id].Int].Int;//LastSelectCar
s:=Value[30][21][Value[23][1][id].Int].Str; m:=0;
for k:=1 to length(s)-2 do m:=m*10+strtoint(s[k+1]);
if Value[0][2][m].Str<>'' then vs[1,22,2]:=Value[0][2][m].Str else
if Value[0][1][m].Str<>'' then vs[1,22,2]:=Value[0][1][m].Str else
if Value[0][6][m].Str<>'' then vs[1,22,2]:=Value[0][6][m].Str;
vi[1,23,2]:=Value[30][22][Value[23][1][id].Int].Int;//Order
vs[1,24,2]:=Value[30][23][Value[23][1][id].Int].Str;//Ref3DCarsOrder
vi[1,25,2]:=Value[30][24][Value[23][1][id].Int].Int;//
vr[1,26,2]:=Value[30][25][Value[23][1][id].Int].Rel;//
vi[1,27,2]:=Value[30][26][Value[23][1][id].Int].Int;//FlagCabrio?
vi[1,28,2]:=Value[30][27][Value[23][1][id].Int].Int;//CAB.BRLight
vi[1,29,2]:=Value[30][28][Value[23][1][id].Int].Int;//
vi[1,30,2]:=Value[30][29][Value[23][1][id].Int].Int;//

vi[1,31,2]:=Value[30][30][Value[23][1][id].Int].Int;//
vi[1,32,2]:=Value[30][31][Value[23][1][id].Int].Int;//
vi[1,33,2]:=Value[30][32][Value[23][1][id].Int].Int;//
vi[1,34,2]:=Value[30][33][Value[23][1][id].Int].Int;//
vi[1,35,2]:=Value[30][34][Value[23][1][id].Int].Int;//
vi[1,36,2]:=Value[30][35][Value[23][1][id].Int].Int;//
vi[1,37,2]:=Value[30][36][Value[23][1][id].Int].Int;//
vi[1,38,2]:=Value[30][37][Value[23][1][id].Int].Int;//
vi[1,39,2]:=Value[30][38][Value[23][1][id].Int].Int;//
vi[1,40,2]:=Value[30][39][Value[23][1][id].Int].Int;//
vi[1,41,2]:=Value[30][40][Value[23][1][id].Int].Int;//
vi[1,42,2]:=Value[30][41][Value[23][1][id].Int].Int;//

vr[1,43,2]:=Value[30][42][Value[23][1][id].Int].Rel;//
vr[1,44,2]:=Value[30][43][Value[23][1][id].Int].Rel;//
vr[1,45,2]:=Value[30][44][Value[23][1][id].Int].Rel;//
vr[1,46,2]:=Value[30][45][Value[23][1][id].Int].Rel;//
vr[1,47,2]:=Value[30][46][Value[23][1][id].Int].Rel;//
vr[1,48,2]:=Value[30][47][Value[23][1][id].Int].Rel;//
vr[1,49,2]:=Value[30][48][Value[23][1][id].Int].Rel;//
vr[1,50,2]:=Value[30][49][Value[23][1][id].Int].Rel;//
vr[1,51,2]:=Value[30][50][Value[23][1][id].Int].Rel;//
vr[1,52,2]:=Value[30][51][Value[23][1][id].Int].Rel;//

vi[1,53,2]:=Value[30][52][Value[23][1][id].Int].Int;//
vr[1,54,2]:=Value[30][53][Value[23][1][id].Int].Rel;//
vr[1,55,2]:=Value[30][54][Value[23][1][id].Int].Rel;//
vr[1,56,2]:=Value[30][55][Value[23][1][id].Int].Rel;//
vr[1,57,2]:=Value[30][56][Value[23][1][id].Int].Rel;//
vr[1,58,2]:=Value[30][57][Value[23][1][id].Int].Rel;//
vr[1,59,2]:=Value[30][58][Value[23][1][id].Int].Rel;//
vr[1,60,2]:=Value[30][59][Value[23][1][id].Int].Rel;//
vr[1,61,2]:=Value[30][60][Value[23][1][id].Int].Rel;//
vr[1,62,2]:=Value[30][61][Value[23][1][id].Int].Rel;//
vi[1,63,2]:=Value[30][62][Value[23][1][id].Int].Int;//
vr[1,64,2]:=Value[30][63][Value[23][1][id].Int].Rel;//
vr[1,65,2]:=Value[30][64][Value[23][1][id].Int].Rel;//
vr[1,66,2]:=Value[30][65][Value[23][1][id].Int].Rel;//
vr[1,67,2]:=Value[30][66][Value[23][1][id].Int].Rel;//
vr[1,68,2]:=Value[30][67][Value[23][1][id].Int].Rel;//
vr[1,69,2]:=Value[30][68][Value[23][1][id].Int].Rel;//
vr[1,70,2]:=Value[30][69][Value[23][1][id].Int].Rel;//
vr[1,71,2]:=Value[30][70][Value[23][1][id].Int].Rel;//
vr[1,72,2]:=Value[30][71][Value[23][1][id].Int].Rel;//
vi[1,73,2]:=Value[30][72][Value[23][1][id].Int].Int;//Order26
vr[1,74,2]:=Value[30][73][Value[23][1][id].Int].Rel;//
vr[1,75,2]:=Value[30][74][Value[23][1][id].Int].Rel;//
//vi[1,76,2]:=
//vi[1,77,2]:=
//vi[1,78,2]:=
//vi[1,79,2]:=
vi[1,80,2]:=0;//ColorIndex

vi[1,1,2]:=0;//Index
vi[1,23,2]:=0;//Order
vi[1,73,2]:=0;//Order26
vi[2,1,2]:=0;//Index
vi[2,2,2]:=0;//3DCarID
vi[2,11,2]:=0;//Motoren
vi[2,12,2]:=0;//Gearbox
vi[2,13,2]:=0;//TiresF
vi[2,14,2]:=0;//TiresR
//RefreshFS;
//RefreshVLE;       //Update List
//FSChange(Form1);
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  //WriteLangFile(Form1,'Lang.txt',true);
end;


procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  ReadLangFile(Form1,ExeDir+'Lang'+TBitBtn(Sender).Caption+'.txt',true);
  BitBtn2.Enabled:=false;
  BitBtn3.Enabled:=false;
  BitBtn4.Enabled:=false;
  BitBtn5.Enabled:=false;
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
  UpdateControls;
end;


procedure TForm1.UpdateControls();
var
  k:integer;
begin
  LockControls := true;
  with fDataSet do begin
    //Identity - Name
    Edit1.Text            := GetValue(103,2,2).Str;        //Main Folder
    Edit8.Text            := GetValue(103,3,2).Str;        //Cabrio Folder
    Hersteller.Text       := GetValue(105,104,2).Str;      //Hersteller
    Logo.Text             := GetValue(105,105,2).Str;      //
    Edit2.Text            := GetValue(103,22,2).Str;       //Class
    Edit3.Text            := GetValue(105,3,2).Str;        //Model
    CBCabrio1.Checked     := GetValue(103,4,2).Int = 1;
    CBCabrio2.Checked     := GetValue(103,27,2).Int = 1;
    //Identity - Placement
    RaceClass1_4.ItemIndex := Math.min(GetValue(105,42,2).Int-1,4); //1..4 + Custom
    SRaceClass.Value      := GetValue(105,42,2).Int;
    SRaceClass.Enabled    := not (GetValue(105,42,2).Int in [1..4]);
    SScore.Value          := GetValue(105,4,2).Int;
    SClassID.Value        := GetValue(105,7,2).Int;

    //Appearance - Cameras
    ScamPY.Value          := round(GetValue(103,15,2).Rel*100);
    ScamPZ.Value          := round(GetValue(103,16,2).Rel*100);
    ScamIY.Value          := round(GetValue(103,17,2).Rel*100);
    ScamIZ.Value          := round(GetValue(103,18,2).Rel*100);
    ScamCX.Value          := round(GetValue(103,26,2).Rel*100);
    ScamCY.Value          := round(GetValue(103,19,2).Rel*100);
    ScamCZ.Value          := round(GetValue(103,20,2).Rel*100);
    ScamHY.Value          := round(GetValue(103,74,2).Rel*100);
    ScamHZ.Value          := round(GetValue(103,75,2).Rel*100);
    //Appearance - Sound
    Edit7.Text          := GetValue(105,75,2).Str;
    SSrate.Value        := GetValue(105,74,2).Int;
    SLautstarke.Value   := GetValue(105,83,2).Int;
    SMotID.Value        := GetValue(105,103,2).Int;
    SAusID.Value        := GetValue(105,102,2).Int;
    SSaug.Value         := GetValue(105,100,2).Int;
    SLastger.Value      := GetValue(105,101,2).Int;
    //Appearance - Brakelight Materials
    SappBR1.Value         := GetValue(103,9,2).Int;
    SappBR2.Value         := GetValue(103,10,2).Int;
    SappBR3.Value         := GetValue(103,11,2).Int;
    SappCAB1.Value        := GetValue(103,28,2).Int;
    SappCAB2.Value        := GetValue(103,29,2).Int;
    SappCAB3.Value        := GetValue(103,30,2).Int;
    //Appearance - HUD
    SkmhID.Value          := GetValue(105,47,2).Int;
    SmphID.Value          := GetValue(105,48,2).Int;
    STachoID.Value        := GetValue(105,99,2).Int;
    //Appearance - Special
    TypLink.Text        := GetValue(105,17,2).Str;  //TypLink
    TypRech.Text        := GetValue(105,46,2).Str;  //TypRech
    SColor.Value        := GetValue(103,80,2).Int;  //ColorID
    Caravan.Text        := GetValue(105,106,2).Str; //Caravan

    //Suspension - Weight
    Sweight.Value       := GetValue(105,32,2).Int;
    SweightD.Value      := GetValue(105,27,2).Int;
    SAngular.Value      := GetValue(105,22,2).Int;
    //Suspension - Suspension
    SDamper.Value       := GetValue(105,16,2).Int;
    SFeather.Value      := GetValue(105,17,2).Int;
    SRelease.Value      := round(GetValue(105,18,2).Rel*100);
    SBounce.Value       := round(GetValue(105,19,2).Rel*100);
    SSperrDif.Value     := GetValue(105,41,2).Int;
    SWheelY.Value       := round(GetValue(105,43,2).Rel*100);
    Stabilizat.Value    := GetValue(105,26,2).Rel;
    //Suspension - Drive-Train
    RGdrive.ItemIndex   := GetValue(105,36,2).Int-1;
    //Suspension - Aerodynamics
    FSAirB.Value        := GetValue(105,38,2).Rel;
    SSlipF.Value        := GetValue(105,39,2).Int;
    SSlipR.Value        := GetValue(105,40,2).Int;

    //Wheels - Size
    STireFR.Value         := round(GetValue(105,93,2).Rel*100);
    STireFW.Value         := round(GetValue(105,94,2).Rel*100);
    STireFD.Value         := round(GetValue(105,95,2).Rel/0.127); //Half an inch
    STireRR.Value         := round(GetValue(105,96,2).Rel*100);
    STireRW.Value         := round(GetValue(105,97,2).Rel*100);
    STireRD.Value         := round(GetValue(105,98,2).Rel/0.127); //Half an inch
    //Wheels - Positioning
    STireFT.Value         := round(GetValue(103,5,2).Rel*200);
    STireRT.Value         := round(GetValue(103,6,2).Rel*200);
    STireFZ.Value         := round(GetValue(103,7,2).Rel*100);
    STireRZ.Value         := round(GetValue(103,8,2).Rel*100);
    //Wheels - Tire Properties
    FSGrip.Value        := GetValue(105,20,2).Rel;
    FSGripFR.Value      := GetValue(105,21,2).Rel;
    FSSlipF.Value       := GetValue(105,23,2).Rel;
    FSSlipR.Value       := GetValue(105,24,2).Rel;
    FS103.Value         := GetValue(105,25,2).Rel;
    FS106.Value         := GetValue(105,28,2).Rel;

    //Engine - Chart
    LineSerieHP.Clear;
    LineSerieNM.Clear;
    for k:=0 to 20 do LineSerieHP.AddXY(k*SNMStep.Value, round(GetValue(105,50+k,2).Rel));
    for k:=0 to 20 do LineSerieNM.AddXY(k*SNMStep.Value, 0);
    {$IFDEF VER140} Chart1.LeftAxis.Maximum := round(LineSerieHP.MaxYValue*1.2); {$ENDIF}
    //Engine - Torque Curve
    SNMStep.Value       := round(GetValue(105,71,2).Rel); //NMStep
    SrpmMax.Value       := GetValue(105,49,2).Int;
    SMtorque.Value      := GetValue(105,29,2).Int;
    //Engine - Statistics
    SMhp.Value          := GetValue(105,77,2).Int;
    Edit5.Text          := GetValue(105,78,2).Str;
    SMnm.Value          := GetValue(105,80,2).Int;
    Edit6.Text          := GetValue(105,81,2).Str;
    Edit4.Text          := GetValue(105,79,2).Str;
    Stopsp.Value        := GetValue(105,10,2).Int;
    FS0100.Value        := GetValue(105,44,2).Rel;

    //Gearbox
    SGearQty.Value      := GetValue(105,84,2).Int;
    FSGear1.Value       := GetValue(105,85,2).Rel;
    FSGear2.Value       := GetValue(105,86,2).Rel;
    FSGear3.Value       := GetValue(105,87,2).Rel;
    FSGear4.Value       := GetValue(105,88,2).Rel;
    FSGear5.Value       := GetValue(105,89,2).Rel;
    FSGear6.Value       := GetValue(105,90,2).Rel;
    FSGear7.Value       := GetValue(105,91,2).Rel;
    FSGearR.Value       := GetValue(105,92,2).Rel;
    FSGearF.Value       := GetValue(105,37,2).Rel;

    //Driver - Male Head
    SDriverX2.Value       := round(GetValue(103,50,2).Rel*100);
    SDriverY2.Value       := round(GetValue(103,51,2).Rel*100);
    SDriverZ2.Value       := round(GetValue(103,52,2).Rel*100);
    SDriverX1.Value       := round(GetValue(103,43,2).Rel*100);
    SDriverY1.Value       := round(GetValue(103,44,2).Rel*100);
    SDriverZ1.Value       := round(GetValue(103,45,2).Rel*100);

    //Cockpit - Speedo
    ST1X.Value            := round(GetValue(103,54,2).Rel*100);
    ST1Y.Value            := round(GetValue(103,55,2).Rel*100);
    ST1Z.Value            := round(GetValue(103,56,2).Rel*100);
    ST1A1.Value           := round(GetValue(103,57,2).Rel*180/pi);
    ST1A2.Value           := round(GetValue(103,58,2).Rel*180/pi);
    ST1A3.Value           := round(GetValue(103,59,2).Rel*180/pi);
    FST1Scale.Value       := GetValue(103,60,2).Rel;
    ST1Start.Value        := round(GetValue(103,61,2).Rel*180/pi);
    FST1Size.Value        := GetValue(103,62,2).Rel;
    ST1Mode.Value         := GetValue(103,53,2).Int;
    //Cockpit - Tacho
    ST2X.Value            := round(GetValue(103,64,2).Rel*100);
    ST2Y.Value            := round(GetValue(103,65,2).Rel*100);
    ST2Z.Value            := round(GetValue(103,66,2).Rel*100);
    ST2A1.Value           := round(GetValue(103,67,2).Rel*180/pi);
    ST2A2.Value           := round(GetValue(103,68,2).Rel*180/pi);
    ST2A3.Value           := round(GetValue(103,69,2).Rel*180/pi);
    FST2Scale.Value       := GetValue(103,70,2).Rel;
    ST2Start.Value        := round(GetValue(103,71,2).Rel*180/pi);
    FST2Size.Value        := GetValue(103,72,2).Rel;
    ST2Mode.Value         := GetValue(103,63,2).Int;
    //Cockpit - Drivewheel
    SDrwX.Value           := round(GetValue(103,46,2).Rel*100);
    SDrwY.Value           := round(GetValue(103,47,2).Rel*100);
    SDrwZ.Value           := round(GetValue(103,48,2).Rel*100);
    SDrwW.Value           := round(GetValue(103,49,2).Rel*180/pi);
  end;

  LockControls := false;
end;


procedure TForm1.UpdateDataSet();
var
  k:integer;
begin
  if LockControls then exit;
  with fDataSet do begin
    //Identity - Name
    SetValue(103,2,2,Edit1.Text);         //Main Folder
    SetValue(103,3,2,Edit8.Text);         //Cabrio Folder
    SetValue(105,104,2,Hersteller.Text);  //Hersteller
    SetValue(105,105,2,Logo.Text);        //
    SetValue(103,22,2,Edit2.Text);        //Class
    SetValue(105,3,2,Edit3.Text);         //Model
    SetValue(103,4,2,integer(CBCabrio1.Checked));
    SetValue(103,27,2,integer(CBCabrio2.Checked));

    //Identity - Placement
    case RaceClass1_4.ItemIndex of
      0..3: SetValue(105,42,2,RaceClass1_4.ItemIndex + 1);
      else  SetValue(105,42,2,SRaceClass.Value);
    end;
    SetValue(105,4,2,SScore.Value);
    SetValue(105,7,2,SClassID.Value);

    //Appearance - Cameras
    SetValue(103,15,2,ScamPY.Value/100);
    SetValue(103,16,2,ScamPZ.Value/100);
    SetValue(103,17,2,ScamIY.Value/100);
    SetValue(103,18,2,ScamIZ.Value/100);
    SetValue(103,26,2,ScamCX.Value/100);
    SetValue(103,19,2,ScamCY.Value/100);
    SetValue(103,20,2,ScamCZ.Value/100);
    SetValue(103,74,2,ScamHY.Value/100);
    SetValue(103,75,2,ScamHZ.Value/100);
    //Appearance - Sound
    SetValue(105,76,2,Edit7.Text);
    SetValue(105,74,2,SSrate.Value);
    SetValue(105,83,2,SLautstarke.Value);
    SetValue(105,103,2,SMotID.Value);
    SetValue(105,102,2,SAusID.Value);
    SetValue(105,100,2,SSaug.Value);
    SetValue(105,101,2,SLastger.Value);
    //Appearance - Brakelight Materials
    SetValue(103,9,2,SappBR1.Value);
    SetValue(103,10,2,SappBR2.Value);
    SetValue(103,11,2,SappBR3.Value);
    SetValue(103,28,2,SappCAB1.Value);
    SetValue(103,29,2,SappCAB2.Value);
    SetValue(103,30,2,SappCAB3.Value);
    //Appearance - HUD
    SetValue(105,3,2,SkmhID.Value);
    SetValue(105,48,2,SmphID.Value);
    SetValue(105,99,2,STachoID.Value);
    //Appearance - Special
    SetValue(105,15,2,TypLink.Text);  //TypLink
    SetValue(105,46,2,TypRech.Text);  //TypRech
    SetValue(103,80,2,SColor.Value);  //ColorID
    SetValue(105,106,2,Caravan.Text); //Caravan
    //Suspension - Weight
    SetValue(105,32,2,Sweight.Value);
    SetValue(105,27,2,SweightD.Value);
    SetValue(105,22,2,SAngular.Value);
    //Suspension - Suspension
    SetValue(105,16,2,SDamper.Value);
    SetValue(105,17,2,SFeather.Value);
    SetValue(105,18,2,SRelease.Value/100);
    SetValue(105,19,2,SBounce.Value/100);
    SetValue(105,41,2,SSperrDif.Value);
    SetValue(105,43,2,SWheelY.Value/100);
    SetValue(105,26,2,Stabilizat.Value);
    //Suspension - Drive-Train
    SetValue(105,36,2,RGdrive.ItemIndex + 1);
    //Suspension - Aerodynamics
    SetValue(105,38,2,FSAirB.Value);
    SetValue(105,39,2,SSlipF.Value);
    SetValue(105,40,2,SSlipR.Value);

    //Wheels - Size
    SetValue(105,93,2,STireFR.Value/100);
    SetValue(105,94,2,STireFW.Value/100);
    SetValue(105,95,2,STireFD.Value*0.127);
    SetValue(105,96,2,STireRR.Value/100);
    SetValue(105,97,2,STireRW.Value/100);
    SetValue(105,98,2,STireRD.Value*0.127);
    //Wheels - Positioning
    SetValue(103,5,2,STireFT.Value/200);
    SetValue(103,6,2,STireRT.Value/200);
    SetValue(103,7,2,STireFZ.Value/100);
    SetValue(103,8,2,STireRZ.Value/100);
    //Wheels - Tire Properties
    SetValue(105,20,2,FSGrip.Value);
    SetValue(105,21,2,FSGripFR.Value);
    SetValue(105,23,2,FSSlipF.Value);
    SetValue(105,24,2,FSSlipR.Value);
    SetValue(105,25,2,FS103.Value);
    SetValue(105,28,2,FS106.Value);

    //Engine - Chart
    for k:=0 to 20 do SetValue(105,50+k,2,LineSerieHP.YValues[k]);//.GetYValue(k));// .YValues[k]);
    //Engine - Torque Curve
    SetValue(105,71,2,SNMStep.Value+0.0); //NMStep
    SetValue(105,49,2,SrpmMax.Value);
    SetValue(105,29,2,SMtorque.Value);
    //Engine - Statistics
    SetValue(105,77,2,SMhp.Value);
    SetValue(105,78,2,Edit5.Text);
    SetValue(105,80,2,SMnm.Value);
    SetValue(105,81,2,Edit6.Text);
    SetValue(105,79,2,Edit4.Text);
    SetValue(105,10,2,Stopsp.Value);
    SetValue(105,44,2,FS0100.Value);

    //Gearbox
    SetValue(105,84,2,SGearQty.Value);
    SetValue(105,85,2,FSGear1.Value);
    SetValue(105,86,2,FSGear2.Value);
    SetValue(105,87,2,FSGear3.Value);
    SetValue(105,88,2,FSGear4.Value);
    SetValue(105,89,2,FSGear5.Value);
    SetValue(105,90,2,FSGear6.Value);
    SetValue(105,91,2,FSGear7.Value);
    SetValue(105,92,2,FSGearR.Value);
    SetValue(105,37,2,FSGearF.Value);

    //Driver - Male Head
    SetValue(103,50,2,SDriverX2.Value/100);
    SetValue(103,51,2,SDriverY2.Value/100);
    SetValue(103,52,2,SDriverZ2.Value/100);
    SetValue(103,43,2,SDriverX1.Value/100);
    SetValue(103,44,2,SDriverY1.Value/100);
    SetValue(103,45,2,SDriverZ1.Value/100);

    //Cockpit - Speedo
    SetValue(103,54,2,ST1X.Value/100);
    SetValue(103,55,2,ST1Y.Value/100);
    SetValue(103,56,2,ST1Z.Value/100);
    SetValue(103,57,2,ST1A1.Value/180*pi);
    SetValue(103,58,2,ST1A2.Value/180*pi);
    SetValue(103,59,2,ST1A3.Value/180*pi);
    SetValue(103,60,2,FST1Scale.Value);
    SetValue(103,61,2,ST1Start.Value/180*pi);
    SetValue(103,62,2,FST1Size.Value);
    SetValue(103,53,2,ST1Mode.Value);

    //Cockpit - Tacho
    SetValue(103,64,2,ST2X.Value/100);
    SetValue(103,65,2,ST2Y.Value/100);
    SetValue(103,66,2,ST2Z.Value/100);
    SetValue(103,67,2,ST2A1.Value/180*pi);
    SetValue(103,68,2,ST2A2.Value/180*pi);
    SetValue(103,69,2,ST2A3.Value/180*pi);
    SetValue(103,70,2,FST2Scale.Value);
    SetValue(103,71,2,ST2Start.Value/180*pi);
    SetValue(103,72,2,FST2Size.Value);
    SetValue(103,63,2,ST2Mode.Value);
    //Cockpit - Drivewheel
    SetValue(103,46,2,SDrwX.Value/100);
    SetValue(103,47,2,SDrwY.Value/100);
    SetValue(103,48,2,SDrwZ.Value/100);
    SetValue(103,49,2,SDrwW.Value/180*pi);
  end;

end;


{$IFDEF VER140}
  {$R *.dfm}
{$ENDIF}


initialization
{$IFDEF FPC}
  {$I WR_EditCar1.lrs}
{$ENDIF}

end.

