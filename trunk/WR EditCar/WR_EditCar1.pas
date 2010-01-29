unit WR_EditCar1;
{$IFDEF FPC} {$MODE Delphi} {$ENDIF}
interface
uses
  SysUtils, Classes, Forms, StdCtrls, Dialogs, ExtCtrls, Controls, ComCtrls, Spin,
  {$IFDEF FPC} LResources, LCLIntf, TAGraph, {$ENDIF}
  WR_EditCar_Lang, WR_DataSet,
  {$IFDEF VER140} FloatSpinEdit, {$ENDIF}
  WR_AboutBox, KromUtils,
  Grids, Chart, Graphics, Buttons, Math,
  {$IFDEF VER140} ValEdit, TeEngine, Series, TeeProcs {$ENDIF};

type
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
    Label131: TLabel;
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
    Image6: TImage;
    ST2Mode: TSpinEdit;
    ST1Mode: TSpinEdit;
    Bevel12: TBevel;
    Label102: TLabel;
    Label98: TLabel;
    FST2Size: TFloatSpinEdit;
    FST1Size: TFloatSpinEdit;
    ST1Start: TSpinEdit;
    FST1Scale: TFloatSpinEdit;
    FST2Scale: TFloatSpinEdit;
    ST2Start: TSpinEdit;
    Label100: TLabel;
    Label101: TLabel;
    Bevel11: TBevel;
    Label97: TLabel;
    ST2A3: TSpinEdit;
    ST1A3: TSpinEdit;
    ST1A2: TSpinEdit;
    ST1A1: TSpinEdit;
    ST2A1: TSpinEdit;
    ST2A2: TSpinEdit;
    SDrwW: TSpinEdit;
    Label95: TLabel;
    Label96: TLabel;
    Bevel1: TBevel;
    ST2Z: TSpinEdit;
    ST1Z: TSpinEdit;
    ST1Y: TSpinEdit;
    ST1X: TSpinEdit;
    ST2X: TSpinEdit;
    ST2Y: TSpinEdit;
    SDrwZ: TSpinEdit;
    SDrwY: TSpinEdit;
    SDrwX: TSpinEdit;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label91: TLabel;
    Label90: TLabel;
    Label113: TLabel;
    GroupBox1: TGroupBox;
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
    SGearQty: TSpinEdit;
    Label24: TLabel;
    Label15: TLabel;
    FSGear1: TFloatSpinEdit;
    FSGear2: TFloatSpinEdit;
    FSGear3: TFloatSpinEdit;
    FSGear4: TFloatSpinEdit;
    FSGear5: TFloatSpinEdit;
    FSGear6: TFloatSpinEdit;
    FSGear7: TFloatSpinEdit;
    FSGearR: TFloatSpinEdit;
    FSGearF: TFloatSpinEdit;
    Image2: TImage;
    Label38: TLabel;
    Label23: TLabel;
    Label22: TLabel;
    Label21: TLabel;
    Label20: TLabel;
    Label19: TLabel;
    Label18: TLabel;
    Label17: TLabel;
    Label16: TLabel;
    Label80: TLabel;
    FS0100: TFloatSpinEdit;
    Edit4: TEdit;
    Stopsp: TSpinEdit;
    Label79: TLabel;
    Label52: TLabel;
    SMnm: TSpinEdit;
    SMhp: TSpinEdit;
    Label39: TLabel;
    Label36: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label35: TLabel;
    Label34: TLabel;
    Label81: TLabel;
    Bevel8: TBevel;
    Image3: TImage;
    Label40: TLabel;
    SMtorque: TSpinEdit;
    SrpmMax: TSpinEdit;
    SNMStep: TSpinEdit;
    Label82: TLabel;
    Label28: TLabel;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Label125: TLabel;
    STireFW: TSpinEdit;
    STireFR: TSpinEdit;
    STireFD: TSpinEdit;
    TireFrontSize: TLabel;
    TireRearSize: TLabel;
    STireRD: TSpinEdit;
    STireRR: TSpinEdit;
    STireRW: TSpinEdit;
    Label10: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    Bevel15: TBevel;
    Image1: TImage;
    STireRT: TSpinEdit;
    STireFT: TSpinEdit;
    Label126: TLabel;
    Bevel16: TBevel;
    STireFZ: TSpinEdit;
    STireRZ: TSpinEdit;
    Label25: TLabel;
    Label14: TLabel;
    FSGrip: TFloatSpinEdit;
    FSGripFR: TFloatSpinEdit;
    FSSlipF: TFloatSpinEdit;
    FSSlipR: TFloatSpinEdit;
    Label70: TLabel;
    Label69: TLabel;
    Label67: TLabel;
    Label66: TLabel;
    FS103: TFloatSpinEdit;
    Label71: TLabel;
    Label73: TLabel;
    FS106: TFloatSpinEdit;
    Bevel17: TBevel;
    Label49: TLabel;
    Label26: TLabel;
    Label124: TLabel;
    Bevel14: TBevel;
    Sweight: TSpinEdit;
    Sweightd: TSpinEdit;
    SAngular: TSpinEdit;
    Label68: TLabel;
    Label61: TLabel;
    Label37: TLabel;
    RGdrive: TRadioGroup;
    SDamper: TSpinEdit;
    Label123: TLabel;
    Bevel5: TBevel;
    Label64: TLabel;
    Label65: TLabel;
    SFeather: TSpinEdit;
    SRelease: TSpinEdit;
    SBounce: TSpinEdit;
    SWheelY: TSpinEdit;
    SSperrDif: TSpinEdit;
    FS104: TFloatSpinEdit;
    Label72: TLabel;
    Label130: TLabel;
    Label27: TLabel;
    Label63: TLabel;
    Label62: TLabel;
    Label122: TLabel;
    Bevel9: TBevel;
    Label83: TLabel;
    FSAirB: TFloatSpinEdit;
    SSlipF: TSpinEdit;
    Label84: TLabel;
    Label85: TLabel;
    SSlipR: TSpinEdit;
    Image4: TImage;
    SappCAB2: TSpinEdit;
    SappCAB1: TSpinEdit;
    SappBR1: TSpinEdit;
    Label30: TLabel;
    SappBR2: TSpinEdit;
    Label29: TLabel;
    SappBR3: TSpinEdit;
    SappCAB3: TSpinEdit;
    Label76: TLabel;
    SkmhID: TSpinEdit;
    SmphID: TSpinEdit;
    Label133: TLabel;
    STachoID: TSpinEdit;
    LtachoID: TLabel;
    LmphID: TLabel;
    LkmhID: TLabel;
    ScamPZ: TSpinEdit;
    ScamPY: TSpinEdit;
    ScamIY: TSpinEdit;
    ScamCY: TSpinEdit;
    ScamHY: TSpinEdit;
    ScamHZ: TSpinEdit;
    ScamCZ: TSpinEdit;
    ScamIZ: TSpinEdit;
    Label43: TLabel;
    Label45: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    Label51: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    ScamCX: TSpinEdit;
    Label75: TLabel;
    SAusID: TSpinEdit;
    SMotID: TSpinEdit;
    SSaug: TSpinEdit;
    SLastger: TSpinEdit;
    Label121: TLabel;
    Label120: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Edit7: TEdit;
    Label42: TLabel;
    SSrate: TSpinEdit;
    Label41: TLabel;
    TypLink: TEdit;
    Label99: TLabel;
    Typ2: TEdit;
    Label86: TLabel;
    SColor: TSpinEdit;
    Label114: TLabel;
    Bevel18: TBevel;
    Bevel19: TBevel;
    Label77: TLabel;
    Bevel10: TBevel;
    Label134: TLabel;
    Label135: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Bevel20: TBevel;
    TabSheet13: TTabSheet;
    Edit1: TEdit;
    Edit8: TEdit;
    Hersteller: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label57: TLabel;
    Label56: TLabel;
    Label118: TLabel;
    Label31: TLabel;
    Label55: TLabel;
    Bevel21: TBevel;
    Label139: TLabel;
    SRaceClass: TSpinEdit;
    Label33: TLabel;
    Label127: TLabel;
    SClassID: TSpinEdit;
    Label50: TLabel;
    SScore: TSpinEdit;
    Bevel22: TBevel;
    Label140: TLabel;
    RaceClass1_4: TRadioGroup;
    Bevel23: TBevel;
    Label141: TLabel;
    Label74: TLabel;
    Bevel3: TBevel;
    Bevel2: TBevel;
    Label32: TLabel;
    Bevel4: TBevel;
    Bevel6: TBevel;
    Label119: TLabel;
    Label78: TLabel;
    Bevel7: TBevel;
    Bevel24: TBevel;
    Label53: TLabel;
    Bevel13: TBevel;
    GroupBox4: TGroupBox;
    Memo1: TMemo;
    CBCabrio2: TCheckBox;
    CBCabrio1: TCheckBox;
    GroupBox5: TGroupBox;
    Memo2: TMemo;
    Label54: TLabel;
    SLautstarke: TSpinEdit;
    BitBtn1: TBitBtn;
    Label142: TLabel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Button1: TButton;
    Label143: TLabel;
    Label144: TLabel;
    Label145: TLabel;
    Label146: TLabel;
    Label147: TLabel;
    Label148: TLabel;
    Label149: TLabel;
    Label150: TLabel;
    Caravan: TEdit;
    Label152: TLabel;
    Logo: TEdit;
    Label153: TLabel;
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
    Button2: TButton;
    procedure OpenClick(Sender: TObject);
    procedure OpenCAR(Sender: TObject);
    procedure MouseClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); reintroduce;
    procedure SaveClick(Sender: TObject);
    procedure AboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FSChange(Sender: TObject);
    procedure RefreshVLE;
    procedure RefreshFS;
    procedure PageChange(Sender: TObject);
    procedure RPMEdit(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Mup(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure VLEChange(Sender: TObject);
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
  end;


type TEditingFormat = (fmtMBWR, fmtWR2, fmtAFC11N, fmtFVR);

var
  Form1: TForm1;

  LockControls:boolean=false; //New variable

  allowFS2,AllowDataUpdate,VLEEdit:boolean; //First Import click, Chapter not found, Mouse spy for TChart, Not First Time, Allow Change

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
  c:array [1..2048] of char;
  ExeDir,carname,s2,s:string;
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
  DecimalSeparator:='.';
  carname := ExtractOpenedFileName(CMDLine);
  ExeDir := ExtractFilePath(Application.ExeName);

  fDataSet := TDataSet.Create;
  fDataSet.LoadDS('editcar.car');

  exit;
  
  if not FileExists(carname) then
    carname := 'editcar.car';

  if FileExists(carname) then
    OpenCAR(Form1);
end;

procedure TForm1.OpenClick(Sender: TObject);
begin
  if not RunOpenDialog(Open1,'','','"World Racing" car descriptor (*.car)|*.car|All Files (*.*)|*.*') then exit;
  carname:=Open1.FileName;
  if fileexists(ExeDir+'unlimiter.'+inttostr(846)) then
  begin
    SRaceClass.MaxValue:=65535;
    SClassID.MaxValue:=65535;
  end;
  OpenCAR(Form1);
end;

procedure TForm1.OpenCAR(Sender: TObject);
var i,j,k,h,x:integer; f:file;
begin
AllowDataUpdate:=false;

assignfile(f,carname); FileMode:=0; reset(f,1); FileMode:=2;
for i:=1 to 2 do for j:=0 to 512 do for k:=1 to 3 do begin
vi[i,j,k]:=0; //clearing 2 tables, 256 entries, 3 values
vr[i,j,k]:=0;
vs[i,j,k]:='';
end;

blockread(f,c,12); DSqty:=ord(c[9]);
blockread(f,c,21); // VAst VAau ?

for i:=1 to DSqty do begin
blockread(f,c,12); //TB
TBqty[i]:=ord(c[9])+ord(c[10])*256;

blockread(f,c,8);                                //VAId_139_
blockread(f,c,5);                                //VAIC_0
blockread(f,c,8);                                //VALb____
h:=ord(c[5]);
blockread(f,c,h+1);
TBLib[i]:='';
for k:=1 to h do TBLib[i]:=TBLib[i]+c[k];

blockread(f,c,8);
TBCondQty[i]:=ord(c[5]); //Cond qty =2
setlength(TBCond[i],TBCondQty[i]+1); //Cond strings

    for k:=1 to TBCondQty[i] do begin
    blockread(f,c,4); h:=ord(c[1]);
    blockread(f,c,h+1); TBCond[i,k]:='';
    for j:=1 to h do TBCond[i,k]:=TBCond[i,k]+c[j]; //usually VersionPC/VCarsAddOn + WRnoDemo
    end;

    for k:=1 to TBqty[i] do begin
    blockread(f,c,12); //CO
    COqty[i,k]:=ord(c[9]); //usually 2 (3 unused (make backup !))
    blockread(f,c,8);  //VAid____
    COid[i,k]:=ord(c[5])+ord(c[6])*256;
    blockread(f,c,8);  //VAlb____
    h:=ord(c[5]);
    if h<>0 then blockread(f,c,h+1);
    COtext[i,COid[i,k],1]:='';
    for j:=1 to h do COtext[i,COid[i,k],1]:=COtext[i,COid[i,k],1]+c[j]; //CO Library name
    blockread(f,c,13); //VAiU_VASM____
    h:=ord(c[10]);
    if h<>0 then blockread(f,c,h+1);
    COtext[i,COid[i,k],2]:='';
    for j:=1 to h do COtext[i,COid[i,k],2]:=COtext[i,COid[i,k],2]+c[j]; //CO input Unit ?
    blockread(f,c,8);  //VAST
    h:=ord(c[5]);
    if h<>0 then blockread(f,c,h+1);
    COtext[i,COid[i,k],3]:='';
    for j:=1 to h do COtext[i,COid[i,k],3]:=COtext[i,COid[i,k],3]+c[j]; //CO String value ?
    blockread(f,c,8);  //VAIC
    h:=ord(c[5]);
    if h<>0 then blockread(f,c,h+1);
    COtext[i,COid[i,k],4]:='';
    for j:=1 to h do COtext[i,COid[i,k],4]:=COtext[i,COid[i,k],4]+c[j]; //CO ?
    blockread(f,c,8);  //VASC
    h:=ord(c[5]);
    if h<>0 then blockread(f,c,h+1);
    COtext[i,COid[i,k],5]:='';
    for j:=1 to h do COtext[i,COid[i,k],5]:=COtext[i,COid[i,k],5]+c[j]; //CO ?

        for h:=1 to COqty[i,k] do begin //i,k,h
        data[i,COid[i,k],h]:=0;
        blockread(f,c,5);
            if c[1]=#1 then begin
            vi[i,COid[i,k],h]:=ord(c[2])+ord(c[3])*256+ord(c[4])*65536+ord(c[5])*16777216;
            data[i,COid[i,k],h]:=1;
            end else
            if c[1]=#2 then begin
            vr[i,COid[i,k],h]:=real2(c[2],c[3],c[4],c[5]);
            data[i,COid[i,k],h]:=2;
            end else
            if c[1]=#16 then begin
            x:=ord(c[2]);
            vs[i,COid[i,k],h]:=''; //prepare empty
            if x<>0 then blockread(f,c,x+1);
            for j:=1 to x do vs[i,COid[i,k],h]:=vs[i,COid[i,k],h]+c[j];
            data[i,COid[i,k],h]:=3;
            end;
        end; //1..h

    end; //k..TB
end; //i..DS

closefile(f);
//Special fix for Sound SampleRate
if data[2,74,2]<>1 then begin
data[2,74,2]:=1; //Integer in all WR cars
vi[2,74,2]:=round(vr[2,74,2]);
end;

RGFormat.ItemIndex:=1; //Default to WR2
if COtext[2,7,1]='FlagMissionCar' then RGFormat.ItemIndex:=0; //Reset file format
if COtext[2,7,1]='CarClassID' then RGFormat.ItemIndex:=1; //Reset file format
if COtext[2,56,1]='mocod' then RGFormat.ItemIndex:=3; //Reset file format
RGFormatClick(nil);

  RefreshFS;        //Update FS
  RefreshVLE;       //Update List
  AllowDataUpdate:=true; //FSChange(Form1);
  FSChange(Form1);
end;

procedure TForm1.RefreshVLE; //Send data to List from memory
var i,k,Count:integer;
begin
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
end;

procedure TForm1.VLEChange(Sender: TObject);
var i,k:integer; Key,Val:string;
begin
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
end;

//Redirect to Keyboard call, cause of different input parameters.
procedure TForm1.MouseClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var w:word;
begin
  w:=0;
  Form1.KeyDown(Form1,w,Shift);
end;

procedure TForm1.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var i,k:integer;
begin
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
end;

procedure TForm1.SaveClick(Sender: TObject);
var i,j,k,h,m:integer; Inp:string; f2:textfile;
begin
if not RunSaveDialog(Save1,'.car',ExtractFilePath(carname),'"World Racing" car descriptor (*.car)|*.car|All Files (*.*)|*.*') then exit;

if not fileexists(ExeDir+'unlimiter.'+inttostr(846)) then
begin
  EnsureRange(vi[2, 7,2],100,999); //restrict ClassID in menu to 100..999 range
  EnsureRange(vi[2,42,2],0,300); //restrict RaceClass in game to 0..300
end;

DSqty:=2; //2 volumes

  if CarFmt=fmtMBWR then TBqty[1]:=75;
  if CarFmt=fmtWR2  then TBqty[1]:=80;//0..80 id of WR2
  if CarFmt=fmtAFC11N  then TBqty[1]:=80;
  if CarFmt=fmtFVR  then TBqty[1]:=80;

  if CarFmt=fmtMBWR then TBqty[2]:=98;
  if CarFmt=fmtWR2  then TBqty[2]:=105;//0..105 id of WR2
  if CarFmt=fmtAFC11N  then TBqty[2]:=106;//106 is Caravan
  if CarFmt=fmtFVR  then TBqty[2]:=110;

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
var s1:string; k:integer; z:real;
//Transfer values from FloatSpins and other editors to memory
begin
if LockControls then exit;
if not AllowDataUpdate then exit;

//Change application title according to opened file path and car name
s1:=carname;
if length(s1)>30 then
s1:='...'+decs(s1,-(length(s1)-32),1);
Form1.Caption:=s1+'  -  '+Edit1.Text; //path - carname
Application.Title:=Edit1.Text;

//Fill in max speeds for gears
if (SrpmMax.Value<>0)and(STireFR.Value<>0)and(FSGearF.Value<>0) then begin
  z:=STireFR.Value/25.4/168*SrpmMax.Value/FSGearF.Value*1.625;
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

Label142.Caption:=inttostr(STireFZ.Value-STireRZ.Value)+' mm';
if RGFormat.ItemIndex=0 then LkmhID.Caption:=kmhID[SkmhID.Value] else LkmhID.Caption:=WRkmhID[SkmhID.Value];
if RGFormat.ItemIndex=0 then LmphID.Caption:=mphID[SmphID.Value] else LmphID.Caption:=WRmphID[SmphID.Value];
LtachoID.Caption:=WRtachoID[StachoID.Value];

if CBCabrio1.Checked=true then vi[1,4,2]:=1 else vi[1,4,2]:=0;
if CBCabrio2.Checked=true then vi[1,27,2]:=1 else vi[1,27,2]:=0;
vi[1,9,2]:=SappBR1.Value;
vi[1,10,2]:=SappBR2.Value;
vi[1,11,2]:=SappBR3.Value;
vi[1,28,2]:=SappCAB1.Value;
vi[1,29,2]:=SappCAB2.Value;
vi[1,30,2]:=SappCAB3.Value;
vr[1,15,2]:=ScamPY.Value/100;
vr[1,16,2]:=ScamPZ.Value/100;
vr[1,17,2]:=ScamIY.Value/100;
vr[1,18,2]:=ScamIZ.Value/100;
vr[1,26,2]:=ScamCX.Value/100;
vr[1,19,2]:=ScamCY.Value/100;
vr[1,20,2]:=ScamCZ.Value/100;
vr[1,43,2]:=SDriverX1.Value/100;
vr[1,44,2]:=SDriverY1.Value/100;
vr[1,45,2]:=SDriverZ1.Value/100;
vr[1,46,2]:=SDrwX.Value/100;
vr[1,47,2]:=SDrwY.Value/100;
vr[1,48,2]:=SDrwZ.Value/100;
vr[1,49,2]:=SDrwW.Value/180*pi;
vr[1,50,2]:=SDriverX2.Value/100;
vr[1,51,2]:=SDriverY2.Value/100;
vr[1,52,2]:=SDriverZ2.Value/100;
vi[1,53,2]:=ST1Mode.Value;
vr[1,54,2]:=ST1X.Value/100;
vr[1,55,2]:=ST1Y.Value/100;
vr[1,56,2]:=ST1Z.Value/100;
vr[1,57,2]:=ST1A1.Value/180*pi;
vr[1,58,2]:=ST1A2.Value/180*pi;
vr[1,59,2]:=ST1A3.Value/180*pi;
vr[1,60,2]:=FST1Scale.Value;
vr[1,61,2]:=ST1Start.Value/180*pi;
vr[1,62,2]:=FST1Size.Value;
vi[1,63,2]:=ST2Mode.Value;
vr[1,64,2]:=ST2X.Value/100;
vr[1,65,2]:=ST2Y.Value/100;
vr[1,66,2]:=ST2Z.Value/100;
vr[1,67,2]:=ST2A1.Value/180*pi;
vr[1,68,2]:=ST2A2.Value/180*pi;
vr[1,69,2]:=ST2A3.Value/180*pi;
vr[1,70,2]:=FST2Scale.Value;
vr[1,71,2]:=ST2Start.Value/180*pi;
vr[1,72,2]:=FST2Size.Value;
allowFS2:=false;
DFX.Value:=SDriverX2.Value;
DFY.Value:=SDriverY2.Value+37;
DFZ.Value:=SDriverZ2.Value-27;
DMX.Value:=SDriverX1.Value+1;
DMY.Value:=SDriverY1.Value+21;
DMZ.Value:=SDriverZ1.Value-69;
allowFS2:=true;
vr[1,74,2]:=ScamHY.Value/100;
vr[1,75,2]:=ScamHZ.Value/100;
vi[1,80,2]:=SColor.Value;
vi[2,4,2]:=SScore.Value;
vi[2,7,2]:=SClassID.Value;
vi[2,10,2]:=Stopsp.Value; //Km/h
vi[2,45,2]:=round(Stopsp.Value/1.61); //mph
vi[2,16,2]:=SDamper.Value;
vi[2,17,2]:=SFeather.Value;
vr[2,18,2]:=SRelease.Value/100;
vr[2,19,2]:=SBounce.Value/100;
vr[2,20,2]:=FSGrip.Value;
vr[2,21,2]:=FSGripFR.Value;
vi[2,22,2]:=SAngular.Value;
vr[2,23,2]:=FSSlipF.Value;
vr[2,24,2]:=FSSlipR.Value;
vr[2,25,2]:=FS103.Value;
vr[2,26,2]:=FS104.Value;
vr[2,28,2]:=FS106.Value;

vs[1,2,2]:=Edit1.Text;
vs[1,3,2]:=Edit8.Text;
vs[1,22,2]:=Edit2.Text;
vs[2,3,2]:=Edit3.Text;
vs[2,15,2]:=TypLink.Text;
vs[2,46,2]:=Typ2.Text;
vi[2,27,2]:=Sweightd.Value;
vi[2,32,2]:=Sweight.Value;
vi[2,36,2]:=RGdrive.ItemIndex+1;
vr[2,38,2]:=FSAirB.Value;
vi[2,39,2]:=SSlipF.Value;
vi[2,40,2]:=SSlipR.Value;
vi[2,41,2]:=SSperrDif.Value;
case RaceClass1_4.ItemIndex of
0..3: begin SRaceClass.Enabled:=false; vi[2,42,2]:=RaceClass1_4.ItemIndex+1; end;
4:    begin SRaceClass.Enabled:=true;  vi[2,42,2]:=SRaceClass.Value; end;
end;
vr[2,44,2]:=FS0100.Value;
vi[2,47,2]:=SkmhID.Value;
vi[2,48,2]:=SmphID.Value;
vi[2,49,2]:=SrpmMax.Value;
vi[2,29,2]:=SMtorque.Value;
vr[2,71,2]:=SNMStep.Value;

Chart1.Series[0].Clear; Chart1.Series[1].Clear;
for k:=0 to 20 do Chart1.Series[0].AddXY(k*SNMStep.Value,round(vr[2,50+k,2]),'',120);
for k:=0 to 20 do Chart1.Series[1].AddXY(k*SNMStep.Value,0,'',120*65536);
Chart1.LeftAxis.Maximum:=round(Chart1.Series[0].MaxYValue*1.2);
Chart1.BottomAxis.Maximum:=SNMStep.Value*20;

vi[2,74,2]:=SSrate.Value;
vs[2,75,2]:=Edit7.Text;
vi[2,76,2]:=round(SMhp.Value*0.734); //kW calculation
vi[2,77,2]:=SMhp.Value;
vs[2,78,2]:=Edit5.Text;
vs[2,79,2]:=Edit4.Text;
vi[2,80,2]:=SMnm.Value;
vs[2,81,2]:=Edit6.Text;
vi[2,83,2]:=SLautstarke.Value;
vi[2,84,2]:=SGearQty.Value;
vr[2,85,2]:=FSGear1.Value;
vr[2,86,2]:=FSGear2.Value;
vr[2,87,2]:=FSGear3.Value;
vr[2,88,2]:=FSGear4.Value;
vr[2,89,2]:=FSGear5.Value;
vr[2,90,2]:=FSGear6.Value;
vr[2,91,2]:=FSGear7.Value;
vr[2,92,2]:=FSGearR.Value;
vr[2,37,2]:=FSGearF.Value;
vr[1,5,2]:=STireFT.Value/200;
vr[1,6,2]:=STireRT.Value/200;
vr[1,7,2]:=STireFZ.Value/100;
vr[1,8,2]:=STireRZ.Value/100;
vr[2,43,2]:=SWheelY.Value/100;
vr[2,93,2]:=STireFR.Value/100;
vr[2,94,2]:=STireFW.Value/100;
vr[2,95,2]:=STireFD.Value*0.127;
vr[2,96,2]:=STireRR.Value/100;
vr[2,97,2]:=STireRW.Value/100;
vr[2,98,2]:=STireRD.Value*0.127;
vi[2,99,2]:=STachoID.Value;
vi[2,100,2]:=SSaug.Value;
vi[2,101,2]:=SLastger.Value;
vi[2,102,2]:=SAusID.Value;
vi[2,103,2]:=SMotID.Value;
vs[2,104,2]:=Hersteller.Text;
vs[2,105,2]:=Logo.Text;
vs[2,106,2]:=Caravan.Text;
end;

procedure TForm1.RefreshFS;
var k:integer;
begin //Send data to SpinEditors from memory
AllowDataUpdate:=false;
Edit1.Text:=vs[1,2,2];  //folder
Edit8.Text:=vs[1,3,2];  //folder
Edit2.Text:=vs[1,22,2]; //class
Edit3.Text:=vs[2,3,2]; //model
TypLink.Text:=vs[2,15,2]; //logo
Typ2.Text:=vs[2,46,2]; //logo

if vi[1,4,2]=1 then CBCabrio1.Checked:=true else CBCabrio1.Checked:=false;
if vi[1,27,2]=1 then CBCabrio2.Checked:=true else CBCabrio2.Checked:=false;
STireFT.Value:=round(vr[1,5,2]*200);
STireRT.Value:=round(vr[1,6,2]*200);
STireFZ.Value:=round(vr[1,7,2]*100);
STireRZ.Value:=round(vr[1,8,2]*100);
SappBR1.Value:=vi[1,9,2];
SappBR2.Value:=vi[1,10,2];
SappBR3.Value:=vi[1,11,2];
SappCAB1.Value:=vi[1,28,2];
SappCAB2.Value:=vi[1,29,2];
SappCAB3.Value:=vi[1,30,2];
ScamPY.Value:=round(vr[1,15,2]*100);
ScamPZ.Value:=round(vr[1,16,2]*100);
ScamIY.Value:=round(vr[1,17,2]*100);
ScamIZ.Value:=round(vr[1,18,2]*100);
ScamCX.Value:=round(vr[1,26,2]*100);
ScamCY.Value:=round(vr[1,19,2]*100);
ScamCZ.Value:=round(vr[1,20,2]*100);
SDriverX1.Value:=round(vr[1,43,2]*100);
SDriverY1.Value:=round(vr[1,44,2]*100);
SDriverZ1.Value:=round(vr[1,45,2]*100);
SDrwX.Value:=round(vr[1,46,2]*100);
SDrwY.Value:=round(vr[1,47,2]*100);
SDrwZ.Value:=round(vr[1,48,2]*100);
SDrwW.Value:=round(vr[1,49,2]*180/pi);
SDriverX2.Value:=round(vr[1,50,2]*100);
SDriverY2.Value:=round(vr[1,51,2]*100);
SDriverZ2.Value:=round(vr[1,52,2]*100);
ST1Mode.Value:=vi[1,53,2];
ST1X.Value:=round(vr[1,54,2]*100);
ST1Y.Value:=round(vr[1,55,2]*100);
ST1Z.Value:=round(vr[1,56,2]*100);
ST1A1.Value:=round(vr[1,57,2]*180/pi);
ST1A2.Value:=round(vr[1,58,2]*180/pi);
ST1A3.Value:=round(vr[1,59,2]*180/pi);
FST1Scale.Value:=vr[1,60,2];
ST1Start.Value:=round(vr[1,61,2]*180/pi);
FST1Size.Value:=vr[1,62,2];
ST2Mode.Value:=vi[1,63,2];
ST2X.Value:=round(vr[1,64,2]*100);
ST2Y.Value:=round(vr[1,65,2]*100);
ST2Z.Value:=round(vr[1,66,2]*100);
ST2A1.Value:=round(vr[1,67,2]*180/pi);
ST2A2.Value:=round(vr[1,68,2]*180/pi);
ST2A3.Value:=round(vr[1,69,2]*180/pi);
FST2Scale.Value:=vr[1,70,2];
ST2Start.Value:=round(vr[1,71,2]*180/pi);
FST2Size.Value:=vr[1,72,2];
ScamHY.Value:=round(vr[1,74,2]*100);
ScamHZ.Value:=round(vr[1,75,2]*100);
SColor.Value:=vi[1,80,2];
SScore.Value:=vi[2,4,2];
SClassID.Value:=vi[2,7,2];
Stopsp.Value:=vi[2,10,2];
SDamper.Value:=vi[2,16,2];
SFeather.Value:=vi[2,17,2];
SRelease.Value:=round(vr[2,18,2]*100);
SBounce.Value:=round(vr[2,19,2]*100);
FSGrip.Value:=vr[2,20,2];
FSGripFR.Value:=vr[2,21,2];
SAngular.Value:=vi[2,22,2];
FSSlipF.Value:=vr[2,23,2];
FSSlipR.Value:=vr[2,24,2];
FS103.Value:=vr[2,25,2];
FS104.Value:=vr[2,26,2];
Sweightd.Value:=vi[2,27,2];
FS106.Value:=vr[2,28,2];
SMtorque.Value:=vi[2,29,2];

Sweight.Value:=vi[2,32,2];
RGdrive.ItemIndex:=vi[2,36,2]-1;
FSAirB.Value:=vr[2,38,2];
SSlipF.Value:=vi[2,39,2];
SSlipR.Value:=vi[2,40,2];
SSperrDif.Value:=vi[2,41,2];
case vi[2,42,2] of
1..4: begin SRaceClass.Enabled:=false; RaceClass1_4.ItemIndex:=vi[2,42,2]-1; end;
else begin RaceClass1_4.ItemIndex:=4; SRaceClass.Enabled:=true;  SRaceClass.Value:=vi[2,42,2]; end;
end;
SWheelY.Value:=round(vr[2,43,2]*100);
FS0100.Value:=vr[2,44,2];
SkmhID.Value:=vi[2,47,2];
SmphID.Value:=vi[2,48,2];
SrpmMax.Value:=vi[2,49,2];
if round(vr[2,71,2])<>0 then SNMStep.Value:=round(vr[2,71,2]);

Chart1.Series[0].Clear; Chart1.Series[1].Clear;
for k:=0 to 20 do Chart1.Series[0].AddXY(k*SNMStep.Value,round(vr[2,50+k,2]),'',120);
for k:=0 to 20 do Chart1.Series[1].AddXY(k*SNMStep.Value,0,'',120*65536);
Chart1.LeftAxis.Maximum:=round(Chart1.Series[0].MaxYValue*1.2);
Chart1.BottomAxis.Maximum:=SNMStep.Value*20;

SSrate.Value:=vi[2,74,2];
Edit7.Text:=vs[2,75,2];
SMhp.Value:=vi[2,77,2];
Edit5.Text:=vs[2,78,2];
Edit4.Text:=vs[2,79,2];
SMnm.Value:=vi[2,80,2];

Edit6.Text:=vs[2,81,2];
SLautstarke.Value:=vi[2,83,2];
SGearQty.Value:=vi[2,84,2];
FSGear1.Value:=vr[2,85,2];
FSGear2.Value:=vr[2,86,2];
FSGear3.Value:=vr[2,87,2];
FSGear4.Value:=vr[2,88,2];
FSGear5.Value:=vr[2,89,2];
FSGear6.Value:=vr[2,90,2];
FSGear7.Value:=vr[2,91,2];
FSGearR.Value:=vr[2,92,2];
FSGearF.Value:=vr[2,37,2];
STireFR.Value:=round(vr[2,93,2]*100);
STireFW.Value:=round(vr[2,94,2]*100);
STireFD.Value:=round(vr[2,95,2]/0.127);
STireRR.Value:=round(vr[2,96,2]*100);
STireRW.Value:=round(vr[2,97,2]*100);
STireRD.Value:=round(vr[2,98,2]/0.127);
STachoID.Value:=vi[2,99,2];
SSaug.Value:=vi[2,100,2];
SLastger.Value:=vi[2,101,2];
SAusID.Value:=vi[2,102,2];
SMotID.Value:=vi[2,103,2];
Hersteller.Text:=vs[2,104,2];
Logo.Text:=vs[2,105,2];
Caravan.Text:=vs[2,106,2];
AllowDataUpdate:=true;
end;

procedure TForm1.PageChange(Sender: TObject);
begin
if PageControl2.ActivePageIndex=PageControl2.PageCount-1 then RefreshVLE else RefreshFS;
if PageControl2.ActivePage.Caption='Engine' then RPMEdit(nil,[ssShift],0,0);
end;

procedure TForm1.RPMEdit(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var i,u,v:integer;
begin
  u:=EnsureRange(round(Chart1.Series[0].XScreenToValue(X)/SNMStep.Value),0,20); //u=X
  v:=max(round(Chart1.Series[0].YScreenToValue(Y)),0);
  Chart1.Title.Text.Strings[0]:='Torque/RPM (HP) - '+inttostr(v)+'/'+inttostr(u*SNMStep.Value)+' ('+inttostr(round(v*u*SNMStep.Value/7023.5))+')';
  if (ssLeft in Shift)and(Chart1.Series[0].XValues.Count=21) then begin
    vr[2,50+u,2]:=v;
    Chart1.Series[0].YValue[u]:=v;
  end;
  for i:=1 to 20 do
    Chart1.Series[1].YValue[i]:=round(i*Chart1.Series[0].YValue[i]*SNMStep.Value/7023.5);
end;

procedure TForm1.Mup(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
Chart1.LeftAxis.Maximum:=round(Chart1.Series[0].MaxYValue*1.2);
if Chart1.LeftAxis.Maximum=0 then Chart1.LeftAxis.Maximum:=1000;
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

  Label119.Enabled      := CarFmt in [fmtMBWR, fmtWR2, fmtAFC11N]; // -Special--
  Label99.Enabled       := CarFmt in [fmtMBWR]; // bez1.tga
  TypLink.Enabled       := CarFmt in [fmtMBWR]; // bez1.tga
  Label86.Enabled       := CarFmt in [fmtMBWR]; // bez2.tga
  Typ2.Enabled          := CarFmt in [fmtMBWR]; // bez2.tga

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

FSChange(nil);
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
LB2Model.AddItem(Value[23][43][i].Str+' '+Value[23][2][i].Str+s,nil);
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
LBModel.AddItem(s2+s,nil);
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
RefreshFS;
RefreshVLE;       //Update List
FSChange(Form1);
end;

procedure TForm1.ImportWRCarClick(Sender: TObject);
var i,k,m,id:integer;
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
RefreshFS;
RefreshVLE;       //Update List
FSChange(Form1);
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
begin
  LockControls := true;
  Edit1.Text := fDataSet.GetValueAsString(1,3,2);  //folder
  Edit8.Text := fDataSet.GetValueAsString(1,4,2);  //folder
  Edit2.Text := fDataSet.GetValueAsString(1,23,2); //class
  Edit3.Text := fDataSet.GetValueAsString(2,4,2); //model}
{  Edit1.Text :=vs[1,2,2];  //folder
  Edit8.Text :=vs[1,3,2];  //folder
  Edit2.Text :=vs[1,22,2]; //class
  Edit3.Text :=vs[2,3,2]; //model}
 //

  LockControls := false;
end;


{$IFDEF VER140}
  {$R *.dfm}
{$ENDIF}


initialization
{$IFDEF FPC}
  {$I WR_EditCar1.lrs}
{$ENDIF}

end.


