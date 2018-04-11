unit WR_EditCar1;
interface
uses
  SysUtils, Classes, Forms, StdCtrls, Dialogs, ExtCtrls, Controls, ComCtrls, Spin, StrUtils,
  WR_EditCar_Lang, WR_DataSet,
  Chart, FloatSpinEdit,
  WR_AboutBox, KromUtils,
  Grids, Graphics, Buttons, Math,
  ValEdit, Series, TeeProcs, TeEngine;

type
  TForm1 = class(TForm)
    ButtonLoad: TButton;
    ButtonSave: TButton;
    Open1: TOpenDialog;
    Save1: TSaveDialog;
    RGFormat: TRadioGroup;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    LBModel: TListBox;
    Label128: TLabel;
    BrowseForDS: TButton;
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
    FSGear9: TFloatSpinEdit;
    FSGear8: TFloatSpinEdit;
    FSGear7: TFloatSpinEdit;
    FSGear6: TFloatSpinEdit;
    FSGear5: TFloatSpinEdit;
    FSGear4: TFloatSpinEdit;
    FSGear3: TFloatSpinEdit;
    FSGear2: TFloatSpinEdit;
    FSGear1: TFloatSpinEdit;
    SGearQty: TSpinEdit;
    Label150: TLabel;
    Label201: TLabel;
    Label200: TLabel;
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
    SRaceClass: TSpinEdit;
    Label127: TLabel;
    Label33: TLabel;
    SClassID: TSpinEdit;
    SScore: TSpinEdit;
    Label50: TLabel;
    GroupBox1: TGroupBox;
    Memo5: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    ListView1: TListView;
    procedure FormCreate(Sender: TObject);
    procedure InitChart();
    procedure OpenClick(Sender: TObject);
    procedure OpenCAR(aCarFile: string);
    procedure UpdateCaption;
    procedure SaveClick(Sender: TObject);
    procedure AboutClick(Sender: TObject);
    procedure FSChange(Sender: TObject);
    procedure PageChange(Sender: TObject);
    procedure TorqueMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure TorqueMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FSChangeLink(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FSChangeHead(Sender: TObject);
    procedure RGFormatClick(Sender: TObject);
    procedure BrowseForDSClick(Sender: TObject);
    procedure ScanDS(aDSPath:string);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure UpdateControls;
    procedure UpdateValueList;
    procedure UpdateDataSet;
    procedure ImportDSCarClick(Sender: TObject);
  end;


type TEditingFormat = (fmtMBWR, fmtWR2, fmtAFC11N, fmtAFC11CT, fmtAFC11BW, fmtFVR, fmtAFC11HN);

const
  VersionInfo = 'EditCar 2 Beta       (02 Aug 2010)';
  MaxFieldsCarsDB = 105; //EditCar.car capacity
  MaxFields3DCarsDB = 80; //EditCar.car capacity

var
  Form1: TForm1;

  ImportDS:TDataSet; //This DS might be accessed a lot while user chooses a car to import, hence it's practical to read it once and keep in memory

  ExeDir,CarName:string;

  LineSerieHP: TLineSeries;
  LineSerieNM: TLineSeries;

  LockControls:boolean=false; //prevent values change to invoke controls update
  LockControlsHead:boolean=false; //prevent values change to invoke controls update [for Heads]

  VLEEdit:boolean; //First Import click, Chapter not found, Not First Time, Allow Change

  CarFmt:TEditingFormat;

implementation

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoClientAreaResize(Self);
  DecimalSeparator := '.';
  CarName := ExtractOpenedFileName(CMDLine);
  ExeDir := ExtractFilePath(Application.ExeName);

  Caption := VersionInfo;

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
  UpdateCaption;
  UpdateValueList;
end;


//Change application title according to opened file path and car name
procedure TForm1.UpdateCaption;
var s:string;
begin
  s := CarName;
  if length(s) > 32 then s := '...' + RightStr(s, 32);
  Form1.Caption := s+'  -  ' + Edit1.Text; //path - carname
  Application.Title := Edit1.Text;
end;


procedure TForm1.SaveClick(Sender: TObject);
begin
  if not RunSaveDialog(Save1, 'editcar.car', ExtractFilePath(carname), '"World Racing" car descriptor (*.car)|*.car|All Files (*.*)|*.*') then exit;

{  case CarFmt of
    fmtMBWR:    begin fDataSet.SetTBLength(103,75); fDataSet.SetTBLength(105, 98); end;
    fmtWR2:     begin fDataSet.SetTBLength(103,80); fDataSet.SetTBLength(105,105); end;
    fmtAFC11N:  begin fDataSet.SetTBLength(103,80); fDataSet.SetTBLength(105,106); end;
    fmtFVR:     begin fDataSet.SetTBLength(103,80); fDataSet.SetTBLength(105,110); end;
  end;}

  fDataSet.SaveDS(Save1.FileName);
end;


procedure TForm1.AboutClick(Sender: TObject);
begin
  AboutForm.Show(VersionInfo,'Edit cars perfomance in "EditCar.car" files.'+eol+eol+
                             'German translation by Jonas Wolf'+eol+
                             'Hungarian translation by Nagyidai Andor'+eol+
                             'Russian translation by Krom (incomplete)','EDITCAR');
end;


procedure TForm1.FSChangeLink(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FSChange(Form1);
end;


procedure TForm1.FSChange(Sender: TObject);
var z:real;
begin
  if LockControls then exit;
  UpdateDataSet();

  if Sender = Edit1 then
    UpdateCaption;

  //Fill in max speeds for gears
  if (SrpmMax.Value<>0)and(STireFR.Value<>0)and(FSGearF.Value<>0) then
  begin
    z := STireFR.Value/25.4/168*SrpmMax.Value/FSGearF.Value*1.625;
    if FSGear1.Value<>0 then Label143.Caption := Format('(%.1f) km/h', [z/FSGear1.Value]) else Label143.Caption:='';
    if FSGear2.Value<>0 then Label144.Caption := Format('(%.1f) km/h', [z/FSGear2.Value]) else Label144.Caption:='';
    if FSGear3.Value<>0 then Label145.Caption := Format('(%.1f) km/h', [z/FSGear3.Value]) else Label145.Caption:='';
    if FSGear4.Value<>0 then Label146.Caption := Format('(%.1f) km/h', [z/FSGear4.Value]) else Label146.Caption:='';
    if FSGear5.Value<>0 then Label147.Caption := Format('(%.1f) km/h', [z/FSGear5.Value]) else Label147.Caption:='';
    if FSGear6.Value<>0 then Label148.Caption := Format('(%.1f) km/h', [z/FSGear6.Value]) else Label148.Caption:='';
    if FSGear7.Value<>0 then Label149.Caption := Format('(%.1f) km/h', [z/FSGear7.Value]) else Label149.Caption:='';
    if FSGear8.Value<>0 then Label200.Caption := Format('(%.1f) km/h', [z/FSGear8.Value]) else Label200.Caption:='';
    if FSGear9.Value<>0 then Label149.Caption := Format('(%.1f) km/h', [z/FSGear9.Value]) else Label201.Caption:='';
    if FSGearR.Value<>0 then Label150.Caption := Format('(%.1f) km/h', [z/FSGearR.Value]) else Label150.Caption:='';
  end;

  //Fill in standard Tire sizes
  if (STireFW.Text<>'')and(STireRW.Text<>'')and(STireFW.Value<>0)and(STireRW.Value<>0) then begin
    TireFrontSize.Caption := STireFW.Text+'/'+
      inttostr(round((STireFR.Value-STireFD.Value*12.7)/STireFW.Value*100))+' R'+STireFD.Text;
    TireRearSize.Caption := STireRW.Text+'/'+
      inttostr(round((STireRR.Value-STireRD.Value*12.7)/STireRW.Value*100))+' R'+STireRD.Text;
  end;

  Label142.Caption := inttostr(STireFZ.Value-STireRZ.Value)+' mm';
  if RGFormat.ItemIndex=0 then LkmhID.Caption:=kmhID[SkmhID.Value] else LkmhID.Caption:=WRkmhID[SkmhID.Value];
  if RGFormat.ItemIndex=0 then LmphID.Caption:=mphID[SmphID.Value] else LmphID.Caption:=WRmphID[SmphID.Value];
  LtachoID.Caption := WRtachoID[StachoID.Value];
end;


procedure TForm1.PageChange(Sender: TObject);
begin
  if PageControl2.ActivePageIndex <> PageControl2.PageCount-1 then UpdateControls;
  if PageControl2.ActivePage.Caption = 'Engine' then TorqueMouseMove(nil,[ssShift],0,0);
end;


procedure TForm1.TorqueMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var i,u,v:integer;
begin
  if (LineSerieHP = nil) or (LineSerieNM = nil) then exit;
  if LineSerieHP.Count <> 21 then exit; //yet empty

  u := EnsureRange(round(LineSerieHP.XScreenToValue(X)/SNMStep.Value),0,20);
  v := max(round(LineSerieHP.YScreenToValue(Y)),0);

  Chart1.Title.Text.Strings[0] := Format('Torque/RPM (HP) - %d/%d (%.0f)',
                                  [v, u*SNMStep.Value, v*u*SNMStep.Value/7023.5]);
  if (ssLeft in Shift) then begin
    fDataSet.SetValue(2,51+u,2,v+0.0);
    LineSerieHP.YValue[u] := v;
    //LineSerieHP.SetYValue(u,v);
  end;
  for i:=1 to 20 do
    LineSerieNM.YValue[i] := round(i*LineSerieHP.YValue[i]*SNMStep.Value/7023.5);
    //LineSerieNM.SetYValue(i, round(i*LineSerieHP.GetYValue(i)*SNMStep.Value/7023.5));
end;

procedure TForm1.TorqueMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Chart1.LeftAxis.Maximum := round(LineSerieHP.MaxYValue*1.2);
  if Chart1.LeftAxis.Maximum = 0 then Chart1.LeftAxis.Maximum := 500;
  UpdateDataSet;
end;


procedure TForm1.FSChangeHead(Sender: TObject);
begin
  if LockControlsHead then exit;

  SDriverX2.Value := DFX.Value;
  SDriverY2.Value := DFY.Value - 37;
  SDriverZ2.Value := DFZ.Value + 27;
  SDriverX1.Value := DMX.Value - 1;
  SDriverY1.Value := DMY.Value - 21;
  SDriverZ1.Value := DMZ.Value + 69;
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
    if Form1.Components[i] is TControl then TControl(Form1.Components[i]).Enabled := true;
    if Form1.Components[i] is TLabel then   TLabel(Form1.Components[i]).Enabled   := true;
  end;

  case RGFormat.ItemIndex of
    0: CarFmt := fmtMBWR;
    1: CarFmt := fmtWR2;
    2: CarFmt := fmtAFC11N;
    3: CarFmt := fmtAFC11CT;
    4: CarFmt := fmtAFC11BW;
    5: CarFmt := fmtFVR;
    6: CarFmt := fmtAFC11HN;
  end;

  //Identity tab
  Label152.Enabled      := CarFmt in [fmtAFC11N, fmtAFC11CT, fmtAFC11BW, fmtFVR, fmtAFC11HN]; //Caravan
  Caravan.Enabled       := CarFmt in [fmtAFC11N, fmtAFC11CT, fmtAFC11BW, fmtFVR, fmtAFC11HN]; //Caravan
  Label31.Enabled       := CarFmt in [fmtMBWR]; //Cabrio Folder
  Edit8.Enabled         := CarFmt in [fmtMBWR]; //Cabrio Folder
  Label118.Enabled      := CarFmt in [fmtAFC11N, fmtAFC11CT, fmtAFC11BW, fmtFVR, fmtAFC11HN]; //Brand name
  Hersteller.Enabled    := CarFmt in [fmtAFC11N, fmtAFC11CT, fmtAFC11BW, fmtFVR, fmtAFC11HN]; //Brand name
  Label153.Enabled      := CarFmt in [fmtAFC11N, fmtAFC11CT, fmtAFC11BW, fmtFVR, fmtAFC11HN]; //Logo
  Logo.Enabled          := CarFmt in [fmtAFC11N, fmtAFC11CT, fmtAFC11BW, fmtFVR, fmtAFC11HN]; //Logo
  Label56.Enabled       := CarFmt in [fmtMBWR]; //Class Name
  Edit2.Enabled         := CarFmt in [fmtMBWR]; //Class Name
  CBCabrio1.Enabled     := CarFmt in [fmtMBWR]; //Cabrio checkbox
  CBCabrio2.Enabled     := CarFmt in [fmtMBWR]; //Cabrio checkbox
  Label33.Enabled       := CarFmt in [fmtWR2, fmtAFC11N, fmtAFC11CT, fmtAFC11BW, fmtFVR, fmtAFC11HN]; //Menu Class
  SClassID.Enabled      := CarFmt in [fmtWR2, fmtAFC11N, fmtAFC11CT, fmtAFC11BW, fmtFVR, fmtAFC11HN]; //Menu Class
  Memo1.Enabled         := CarFmt in [fmtWR2];     //Score to Open memo

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

  Label133.Enabled      := CarFmt in [fmtWR2, fmtAFC11N, fmtFVR]; //Tacho ID
  LtachoID.Enabled      := CarFmt in [fmtWR2, fmtAFC11N, fmtFVR]; //Tacho ID
  STachoID.Enabled      := CarFmt in [fmtWR2, fmtAFC11N, fmtFVR]; //Tacho ID

  Label99.Enabled       := CarFmt in [fmtMBWR]; // bez1.tga
  TypLink.Enabled       := CarFmt in [fmtMBWR]; // bez1.tga
  Label86.Enabled       := CarFmt in [fmtMBWR]; // bez2.tga
  TypRech.Enabled       := CarFmt in [fmtMBWR]; // bez2.tga

  Label114.Enabled      := CarFmt in [fmtWR2, fmtAFC11N]; //Default Menu Color
  SColor.Enabled        := CarFmt in [fmtWR2, fmtAFC11N]; //Default Menu Color


if RGFormat.ItemIndex=3 then begin //Ferrari Virtual Race
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


procedure TForm1.BrowseForDSClick(Sender: TObject);
begin
  if not RunOpenDialog(Open1, '', ExeDir, 'Synetic database (*.ds)|*.ds|All Files (*.*)|*.*') then exit;
  ScanDS(Open1.FileName);
end;


procedure TForm1.ScanDS(aDSPath:string);
var
  i:integer;
begin
  ImportDS := TDataSet.Create;
  ImportDS.DoProperIndexing := true;
  ImportDS.LoadDS(aDSPath);

  LBModel.Clear;

  case ImportDS.Version of
    dsvMBWR:    for i:=2 to ImportDS.COCount(23,3) do
                  LBModel.AddItem(ImportDS.WRTextEn(ImportDS.GetValueAsString(23,3,i)),TObject(i-1));
    dsvWR2:     for i:=2 to ImportDS.COCount(23,3) do
                  LBModel.AddItem(ImportDS.GetValueAsString(23,49,i)+' '+ImportDS.GetValueAsString(23,3,i),TObject(i-1));
    dsvAFC11N,
    dsvAFC11CT,
    dsvAFC11BW,
    dsvFVR,
    dsvAFC11HN: for i:=2 to ImportDS.COCount(23,3) do
                  LBModel.AddItem(ImportDS.WRTextEn(ImportDS.GetValueAsString(23,52,i))+' '+ImportDS.WRTextEn(ImportDS.GetValueAsString(23,3,i)),TObject(i-1));
    else exit;
  end;

  Label128.Caption := 'DataSet of ' + DSVersionName[ImportDS.Version,1];
  LBModel.Enabled := true;
end;


procedure TForm1.ImportDSCarClick(Sender: TObject);
var
  CarID:integer;
  i:integer;
  TempID:integer;
begin

  if LBModel.ItemIndex = -1 then exit;
  CarID := Integer(LBModel.Items.Objects[LBModel.ItemIndex]) + 1;

  //Let's sketch it for MBWR first, then we'll see how it goes
  if ImportDS.Version = dsvMBWR then begin

    for i:=0 to fDataSet.TBCount(105) do
      fDataSet.SetValue(105,i,2, 777888999);

    fDataSet.SetValue(105,0,2, ImportDS.GetValue(23,0,CarID)); //Kommentar
    fDataSet.SetValue(105,1,2, 0); //Index
    fDataSet.SetValue(105,2,2, 0); //3DCarID
    fDataSet.SetValue(105,3,2, ImportDS.WRTextEn(ImportDS.GetValueAsString(23,3,CarID)));
    for i:=4 to 48 do
      fDataSet.SetValue(105,i,2, ImportDS.GetValue(23,i,CarID));
    //Overrides
    fDataSet.SetValue(105,11,2, 0); //MotorID
    fDataSet.SetValue(105,12,2, 0); //GearboxID
    fDataSet.SetValue(105,13,2, 0); //TiresID
    fDataSet.SetValue(105,14,2, 0); //TiresID

    //MotorDB
    TempID := ImportDS.GetValue(23,11,CarID).Int + 1; //todo: Access CO by 0..n indexes!!
    for i:=2 to 36 do //MAXDREHZAHL..Lautstaerke
      fDataSet.SetValue(105,i+47,2, ImportDS.GetValue(39,i,TempID));

    //GearboxDB
    TempID := ImportDS.GetValue(23,12,CarID).Int + 1; //todo: Access CO by 0..n indexes!!
    for i:=2 to 10 do //AnzahlGaenge..RWGang
      fDataSet.SetValue(105,i+82,2, ImportDS.GetValue(40,i,TempID));

    //TiresID
    TempID := ImportDS.GetValue(23,13,CarID).Int + 1; //todo: Access CO by 0..n indexes!!
    for i:=2 to 4 do //reifenradius..ENGINE_FELGENHOEHE
      fDataSet.SetValue(105,i+91,2, ImportDS.GetValue(41,i,TempID));

    //TiresID
    TempID := ImportDS.GetValue(23,14,CarID).Int + 1; //todo: Access CO by 0..n indexes!!
    for i:=2 to 4 do //reifenradius..ENGINE_FELGENHOEHE
      fDataSet.SetValue(105,i+94,2, ImportDS.GetValue(41,i,TempID));

    //Clearup unused fields
    for i:=99 to 110 do
      fDataSet.SetValueAsString(105,i,2,'0');

    //3DCarsDB
    TempID := ImportDS.GetValue(23,2,CarID).Int + 1; //todo: Access CO by 0..n indexes!!
    fDataSet.SetValue(103,0,2, ImportDS.GetValue(30,0,TempID)); //Kommentar
    fDataSet.SetValue(103,1,2, 0); //Index
    for i:=2 to 75 do
      fDataSet.SetValue(103,i,2, ImportDS.GetValue(30,i,TempID));
    fDataSet.SetValue(103,22,2, ImportDS.WRTextEn(ImportDS.GetValueAsString(30,22,TempID)));
    fDataSet.SetValue(103,23,2, 0); //Order
    fDataSet.SetValue(103,24,2, ''); //Ref3DCarsOrder
    fDataSet.SetValue(103,73,2, 0); //Order26

    //Clearup unused fields
    for i:=76 to 80 do
      fDataSet.SetValueAsString(103,i,2,'0');

  end;


  //Sketch it for AFC11BW
  if ImportDS.Version = dsvAFC11BW then begin

    fDataSet.SetValue(105,0,2, ImportDS.GetValue(23,0,CarID)); //Kommentar
    fDataSet.SetValue(105,1,2, 0); //Index
    fDataSet.SetValue(105,2,2, 0); //3DCarID
    fDataSet.SetValue(105,3,2, ImportDS.WRTextEn(ImportDS.GetValueAsString(23,3,CarID)));
    for i:=4 to 48 do
      fDataSet.SetValue(105,i,2, ImportDS.GetValue(23,i,CarID));
    //Overrides
    fDataSet.SetValue(105,11,2, 0); //MotorID
    fDataSet.SetValue(105,12,2, 0); //GearboxID
    fDataSet.SetValue(105,13,2, 0); //TiresID
    fDataSet.SetValue(105,14,2, 0); //TiresID

    //MotorDB
    TempID := ImportDS.GetValue(23,11,CarID).Int + 1; //todo: Access CO by 0..n indexes!!
    for i:=2 to 36 do //MAXDREHZAHL..Lautstaerke
      fDataSet.SetValue(105,i+47,2, ImportDS.GetValue(39,i,TempID));

    //Rename 72-73, they were unused prior to AFC11 (Motorbremse, Schwungmasse)
    //todo: RenameCO
    //fDataSet.(105, 72, 'DRM10500Revs');
    //fDataSet(105, 73, 'DRM11000Revs');
    fDataSet.SetValueAsString(105,82,2,'0'); //missing in AFC11BW.ds

    //GearboxDB
    TempID := ImportDS.GetValue(23,12,CarID).Int + 1; //todo: Access CO by 0..n indexes!!
    for i:=2 to 10 do //AnzahlGaenge..RWGang
      fDataSet.SetValue(105,i+82,2, ImportDS.GetValue(40,i,TempID));

    //TiresID
    TempID := ImportDS.GetValue(23,13,CarID).Int + 1; //todo: Access CO by 0..n indexes!!
    for i:=2 to 4 do //reifenradius..ENGINE_FELGENHOEHE
      fDataSet.SetValue(105,i+91,2, ImportDS.GetValue(41,i,TempID));

    //TiresID
    TempID := ImportDS.GetValue(23,14,CarID).Int + 1; //todo: Access CO by 0..n indexes!!
    for i:=2 to 4 do //reifenradius..ENGINE_FELGENHOEHE
      fDataSet.SetValue(105,i+94,2, ImportDS.GetValue(41,i,TempID));

    //AFC Addendum
    fDataSet.SetValue(105, 99,2, ImportDS.GetValue(39,41,TempID)); //Drehzahlmesser
    for i:=37 to 40 do //SauggeraeuschID..MotorID
      fDataSet.SetValue(105,i+63,2, ImportDS.GetValue(39,i,TempID));
    fDataSet.SetValue(105,104,2, ImportDS.GetValue(23,49,CarID)); //HerstellerName
    fDataSet.SetValue(105,105,2, ImportDS.GetValue(23,50,CarID)); //HerstellerLogo

    fDataSet.SetValue(105,106,2, ImportDS.GetValue(23,51,CarID)); //Anbauten (caravan)
    fDataSet.SetValue(105,107,2, ImportDS.GetValue(23,52,CarID)); //ClassTextID
    fDataSet.SetValue(105,108,2, ImportDS.GetValue(23,53,CarID)); //BitmapFilename
    fDataSet.SetValue(105,109,2, ImportDS.GetValue(23,54,CarID)); //BitmapFilenameX
    fDataSet.SetValue(105,110,2, ImportDS.GetValue(23,55,CarID)); //BitmapFilenameY


    //3DCarsDB
    TempID := ImportDS.GetValue(23,2,CarID).Int + 1; //todo: Access CO by 0..n indexes!!
    fDataSet.SetValue(103,0,2, ImportDS.GetValue(30,0,TempID)); //Kommentar
    fDataSet.SetValue(103,1,2, 0); //Index
    for i:=2 to 75 do
      fDataSet.SetValue(103,i,2, ImportDS.GetValue(30,i,TempID));
    fDataSet.SetValue(103,22,2, ImportDS.WRTextEn(ImportDS.GetValueAsString(30,22,TempID)));
    fDataSet.SetValue(103,23,2, 0); //Order
    fDataSet.SetValue(103,24,2, ''); //Ref3DCarsOrder
    fDataSet.SetValue(103,73,2, 0); //Order26

    //Clearup unused fields
    for i:=76 to 80 do
      fDataSet.SetValueAsString(103,i,2,'0');

  end;

  UpdateControls;
  RGFormat.ItemIndex := byte(ImportDS.Version)-1;
  RGFormatClick(nil);
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



procedure TForm1.UpdateValueList;
var i:integer;
begin
  ListView1.Clear;
  for i:=0 to fDataSet.TBCount(105)-1 do
    with ListView1.Items.Add do
    begin
      Caption := fDataSet.GetCOLib(105,i);
      SubItems.Add(fDataSet.GetValueAsString(105,i,2));
    end;
  for i:=0 to fDataSet.TBCount(103)-1 do
    with ListView1.Items.Add do
    begin
      Caption := fDataSet.GetCOLib(103,i);
      SubItems.Add(fDataSet.GetValueAsString(103,i,2));
    end;
end;


procedure TForm1.UpdateControls;
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
    SRaceClass.Value      := GetValue(105,42,2).Int;
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
    Chart1.LeftAxis.Maximum := round(LineSerieHP.MaxYValue*1.2);
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
    FSGear8.Value       := GetValue(105,111,2).Rel;
    FSGear9.Value       := GetValue(105,112,2).Rel;
    FSGearR.Value       := GetValue(105,92,2).Rel;
    FSGearF.Value       := GetValue(105,37,2).Rel;

    //Driver - Male Head
    SDriverX2.Value       := round(GetValue(103,50,2).Rel*100);
    SDriverY2.Value       := round(GetValue(103,51,2).Rel*100);
    SDriverZ2.Value       := round(GetValue(103,52,2).Rel*100);
    SDriverX1.Value       := round(GetValue(103,43,2).Rel*100);
    SDriverY1.Value       := round(GetValue(103,44,2).Rel*100);
    SDriverZ1.Value       := round(GetValue(103,45,2).Rel*100);

    LockControlsHead := true;
    DFX.Value := SDriverX2.Value;
    DFY.Value := SDriverY2.Value + 37;
    DFZ.Value := SDriverZ2.Value - 27;
    DMX.Value := SDriverX1.Value + 1;
    DMY.Value := SDriverY1.Value + 21;
    DMZ.Value := SDriverZ1.Value - 69;
    LockControlsHead := false;

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
    SetValue(105,42,2,SRaceClass.Value);
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

    for k:=0 to 20 do SetValue(105,50+k,2,LineSerieHP.YValues[k]);
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

    LockControlsHead := true;
    DFX.Value := SDriverX2.Value;
    DFY.Value := SDriverY2.Value + 37;
    DFZ.Value := SDriverZ2.Value - 27;
    DMX.Value := SDriverX1.Value + 1;
    DMY.Value := SDriverY1.Value + 21;
    DMZ.Value := SDriverZ1.Value - 69;
    LockControlsHead := false;

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


{$R *.dfm}


initialization

end.


