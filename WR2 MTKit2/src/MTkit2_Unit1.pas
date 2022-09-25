unit MTkit2_Unit1;
interface
uses
  Buttons, Classes, ComCtrls, Controls, Dialogs, ExtCtrls, FileCtrl, Forms,
  Graphics, INIFiles, Math, Menus, ShellCtrls, Spin, StdCtrls, SysUtils, Windows,
  Messages,

  dglOpenGL, FloatSpinEdit, KromOGLUtils, KromUtils, TGATexture, PTXTexture,

  MTkit2_Defaults, MTkit2_Render, MTkit2_RenderLegacy, MTkit2_IO, MTkit2_COB, MTkit2_CPO, MTkit2_MOX, MTkit2_Tree, MTkit2_Vertex;

type
  TInputMode = (imRelative, imAbsolute);

  TForm1 = class(TForm)
    odOpen: TOpenDialog;
    RenderPanel: TPanel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    About1: TMenuItem;
    LoadMOX1: TMenuItem;
    PageControl1: TPageControl;
    tsMaterials: TTabSheet;
    tsParts: TTabSheet;
    tsBlinkers: TTabSheet;
    tvParts: TTreeView;
    tsExtra: TTabSheet;
    Label1: TLabel; Label3: TLabel; Label4: TLabel; Label5: TLabel;
    Label6: TLabel; Label8: TLabel; Label9: TLabel; Label10: TLabel;
    Label11: TLabel; Label12: TLabel; Label13: TLabel; Label14: TLabel; Label17: TLabel; Label18: TLabel; Label19: TLabel; Label20: TLabel;
    Label21: TLabel; Label22: TLabel; Label24: TLabel; Label25: TLabel;
    Label26: TLabel; Label27: TLabel; Label28: TLabel; Label29: TLabel; Label30: TLabel; Label32: TLabel; Label33: TLabel; Label35: TLabel;
    Label36: TLabel; Label37: TLabel; Label38: TLabel; Label39: TLabel;
    edVerticeCount: TEdit;
    edPolyCount: TEdit;
    edPartCount: TEdit;
    CBColor: TComboBox;
    edMaterialTextureFile: TEdit;
    CBClipU: TComboBox;
    tbMaterialTransparency: TTrackBar;
    CBClipV: TComboBox;
    CBMatClass2: TComboBox;
    CBMatClass3: TComboBox;
    meLog: TMemo;
    LBMaterials: TListBox;
    lbBlinkers: TListBox;
    rgBlinkerType: TRadioGroup;
    fsBlinkerSizeMin: TFloatSpinEdit;
    fsBlinkerSizeMax: TFloatSpinEdit;
    fsBlinkerFreq: TFloatSpinEdit;
    seBlinkerParent: TSpinEdit;
    fsBlinkerX: TFloatSpinEdit;
    fsBlinkerY: TFloatSpinEdit;
    fsBlinkerZ: TFloatSpinEdit;
    MatName: TEdit;
    SaveMOX1: TMenuItem;
    sdSave: TSaveDialog;
    ImportLWO1: TMenuItem;
    Shape1: TShape;
    SaveMTL1: TMenuItem;
    edMaterialCount: TEdit;
    Label41: TLabel;
    TexBrowse: TButton;
    cbShowMaterial: TCheckBox;
    cbTargetLight: TCheckBox;
    CB1: TCheckBox; CB2: TCheckBox; CB3: TCheckBox; CB4: TCheckBox;
    Label44: TLabel;
    Label45: TLabel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    fsBlinkerH: TFloatSpinEdit;
    fsBlinkerP: TFloatSpinEdit;
    fsBlinkerB: TFloatSpinEdit;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    btnBlinkerAdd: TButton;
    btnBlinkerRem: TButton;
    btnBlinkersLoad: TButton;
    btnBlinkersSave: TButton;
    btnBlinkerCopy: TSpeedButton;
    btnBlinkerPaste: TSpeedButton;
    Shape2: TShape;
    LoadCOB1: TMenuItem;
    SaveCOB1: TMenuItem;
    RGDetailType: TRadioGroup;
    EDetailName: TEdit;
    CBActDam: TCheckBox;
    CBMonoColor: TCheckBox;
    ImportLWOCOB1: TMenuItem;
    tsCOB: TTabSheet;
    cbCOBShowIds: TCheckBox;
    LBCOBPoints: TListBox;
    btnCOBVerticeCopy: TSpeedButton;
    btnCOBVerticePaste: TSpeedButton;
    seCOBX: TFloatSpinEdit;
    seCOBY: TFloatSpinEdit;
    seCOBZ: TFloatSpinEdit;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Bevel6: TBevel;
    Bevel13: TBevel;
    ExportMOX1: TMenuItem;
    ExportCOB1: TMenuItem;
    Label61: TLabel;
    MatCopy: TSpeedButton;
    MatPaste: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SetColorsToCurrent: TSpeedButton;
    PageControl2: TPageControl;
    PivotSetup: TTabSheet;
    Behaviour: TTabSheet;
    CX: TFloatSpinEdit;
    CY: TFloatSpinEdit;
    CZ: TFloatSpinEdit;
    CRad: TFloatSpinEdit;
    LX1: TFloatSpinEdit;
    LX2: TFloatSpinEdit;
    LY1: TFloatSpinEdit;
    LY2: TFloatSpinEdit;
    LZ1: TFloatSpinEdit;
    LZ2: TFloatSpinEdit;
    CustomPivotX: TFloatSpinEdit;
    CustomPivotY: TFloatSpinEdit;
    CustomPivotZ: TFloatSpinEdit;
    FloatSpinEdit4: TFloatSpinEdit;
    FloatSpinEdit5: TFloatSpinEdit;
    FloatSpinEdit6: TFloatSpinEdit;
    Label51: TLabel;
    RGPivotX: TRadioGroup;
    RGPivotY: TRadioGroup;
    RGPivotZ: TRadioGroup;
    PivotPointActual: TSpinEdit;
    btnPartPivotUse: TSpeedButton;
    btnPSFLoad: TButton;
    btnPSFSave: TButton;
    CBShowPart: TCheckBox;
    btnPBFLoad: TButton;
    btnPBFSave: TButton;
    FlapParts: TTrackBar;
    Bevel17: TBevel;
    Label43: TLabel;
    Bevel18: TBevel;
    Panel8: TPanel;
    Panel10: TPanel;
    TexReload2: TSpeedButton;
    ImportLWO2: TMenuItem;
    Label63: TLabel;
    SpeedButton3: TSpeedButton;
    COB_X: TFloatSpinEdit;
    COB_Y: TFloatSpinEdit;
    COB_Z: TFloatSpinEdit;
    COB_X1: TFloatSpinEdit;
    COB_Y1: TFloatSpinEdit;
    COB_Z1: TFloatSpinEdit;
    COB_X2: TFloatSpinEdit;
    COB_Y2: TFloatSpinEdit;
    COB_Z2: TFloatSpinEdit;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    btnCOBRecompute: TButton;
    edChunkCount: TEdit;
    edBlinkerCount: TEdit;
    Label71: TLabel;
    Label72: TLabel;
    Extra1: TMenuItem;
    Label74: TLabel;
    Label76: TLabel;
    rgBlinkerPreview: TRadioGroup;
    LoadCPO1: TMenuItem;
    Label23: TLabel;
    tsBrowse: TTabSheet;
    FileListBox1: TFileListBox;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    ViewReset: TButton;
    Chrome1: TMenuItem;
    CBRenderMode: TComboBox;
    ShapeA: TShape;
    ShapeD: TShape;
    ShapeS1: TShape;
    ShapeS2: TShape;
    ShapeR: TShape;
    Label31: TLabel;
    Panel1: TPanel;
    shpBlinkerColor: TShape;
    Button4: TButton;
    ShapeBG: TShape;
    FPSLimitEdit: TFloatSpinEdit;
    ComboBox1: TComboBox;
    Label7: TLabel;
    Label40: TLabel;
    Label42: TLabel;
    Lightvectors1: TMenuItem;
    tsCPO: TTabSheet;
    lbCPOShapes: TListBox;
    seCPOX: TFloatSpinEdit;
    seCPOY: TFloatSpinEdit;
    seCPOZ: TFloatSpinEdit;
    Label53: TLabel;
    Label52: TLabel;
    Label50: TLabel;
    btnCPOAdd: TButton;
    btnCPORem: TButton;
    btnCPOCopy: TSpeedButton;
    btnCPOPaste: TSpeedButton;
    seCPOSX: TFloatSpinEdit;
    Label54: TLabel;
    seCPOSY: TFloatSpinEdit;
    Label77: TLabel;
    Label78: TLabel;
    seCPOSZ: TFloatSpinEdit;
    seCPORH: TFloatSpinEdit;
    seCPORP: TFloatSpinEdit;
    seCPORB: TFloatSpinEdit;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Bevel2: TBevel;
    Label83: TLabel;
    Bevel3: TBevel;
    Bevel5: TBevel;
    Label84: TLabel;
    Bevel8: TBevel;
    Bevel16: TBevel;
    Label85: TLabel;
    Bevel21: TBevel;
    ReloadShadersCode: TSpeedButton;
    SaveCPO1: TMenuItem;
    TBDirt: TTrackBar;
    ResetMTLOrder: TMenuItem;
    CBVinyl: TComboBox;
    Panel4: TPanel;
    CBShowGrid: TMenuItem;
    btnShowLights: TSpeedButton;
    btnShowColli: TSpeedButton;
    btnShowWireframe: TSpeedButton;
    Import1: TMenuItem;
    ImportOBJMOX1: TMenuItem;
    LoadTREE1: TMenuItem;
    Load1: TMenuItem;
    Save2: TMenuItem;
    Export1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    Label55: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    StatusBar1: TStatusBar;
    N3: TMenuItem;
    btnShowUVMap: TSpeedButton;
    Panel6: TPanel;
    Panel7: TPanel;
    ImageM: TSpeedButton;
    ImageR: TSpeedButton;
    ImageZ: TSpeedButton;
    ShapeWF: TShape;
    Label15: TLabel;
    Button1: TButton;
    Import3DSMOX1: TMenuItem;
    N4: TMenuItem;
    btnCPOImport: TButton;
    btnCPOExport: TButton;
    Label16: TLabel;
    Bevel1: TBevel;
    Bevel4: TBevel;
    btnRegisterMOX: TButton;
    cbAskOnClose: TCheckBox;
    Dev1: TMenuItem;
    ScanMOXheaders1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CompileLoadedMOX;
    procedure RenderResize(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure lbBlinkersClick(Sender: TObject);
    procedure BlinkChange(Sender: TObject);
    procedure CBColorChange(Sender: TObject);
    procedure LBMaterialsClick(Sender: TObject);
    procedure MaterialPropertiesChange(Sender: TObject);
    procedure MatNameChange(Sender: TObject);
    procedure tvPartsChange(Sender: TObject; Node: TTreeNode);
    procedure MatEdSetAllColorsToCurrent(Sender: TObject);
    procedure MatTexReloadClick(Sender: TObject);
    procedure CBChromeClick(Sender: TObject);
    procedure PartTypeChange(Sender: TObject);
    procedure ImportLWO1Click(Sender: TObject);
    procedure UpdateOpenedFileInfo(const aFilename: string);
    procedure SaveMTL1Click(Sender: TObject);
    procedure MatTexBrowseClick(Sender: TObject);
    procedure BlinkPositionChange(Sender: TObject);
    procedure btnBlinkerAddClick(Sender: TObject);
    procedure btnBlinkerRemClick(Sender: TObject);
    procedure BlinkCopyClick(Sender: TObject);
    procedure BlinkPasteClick(Sender: TObject);
    procedure btnBlinkersSaveClick(Sender: TObject);
    procedure btnBlinkersLoadClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure LoadCOBClick(Sender: TObject);
    procedure SaveCOB1Click(Sender: TObject);
    procedure tvPartsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure tvPartsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure MatMonoColorClick(Sender: TObject);
    procedure ImportLWOCOB1Click(Sender: TObject);
    procedure btnCOBVerticeCopyClick(Sender: TObject);
    procedure btnCOBVerticePasteClick(Sender: TObject);
    procedure LBCOBPointsClick(Sender: TObject);
    procedure seCOBXChange(Sender: TObject);
    procedure ExportMOX1Click(Sender: TObject);
    procedure ExportCOB1Click(Sender: TObject);
    procedure MatCopyClick(Sender: TObject);
    procedure MatPasteClick(Sender: TObject);
    procedure RGPivotClick(Sender: TObject);
    procedure btnPartPivotUseClick(Sender: TObject);
    procedure btnPSFSaveClick(Sender: TObject);
    procedure btnPSFLoadClick(Sender: TObject);
    procedure btnPBFSaveClick(Sender: TObject);
    procedure btnPBFLoadClick(Sender: TObject);
    procedure CBActDamClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SB_RenderOpts(Sender: TObject);
    procedure ImportLWO2Click(Sender: TObject);
    procedure ResetMTLOrderClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure btnCOBRecomputeClick(Sender: TObject);
    procedure LoadMOXClick(Sender: TObject);
    procedure LoadCPOClick(Sender: TObject);
    procedure FileListBox1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure ResetView(Sender: TObject);
    procedure CBRenderModeChange(Sender: TObject);
    procedure ShapeAMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure FPSLimitEditChange(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbCPOShapesClick(Sender: TObject);
    procedure Lightvectors1Click(Sender: TObject);
    procedure CPOChange(Sender: TObject);
    procedure btnCPOAddClick(Sender: TObject);
    procedure btnCPORemClick(Sender: TObject);
    procedure ReloadShadersCodeClick(Sender: TObject);
    procedure SaveCPO1Click(Sender: TObject);
    procedure CBShowGridClick(Sender: TObject);
    procedure CBShowPartClick(Sender: TObject);
    procedure FlapPartsChange(Sender: TObject);
    procedure RebuildImpNormals;
    procedure Import3DSMOX1Click(Sender: TObject);
    procedure ImportOBJMOX1Click(Sender: TObject);
    procedure LoadTREE1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure SaveMOXClick(Sender: TObject);
    procedure ClearUpClick(aClearup: TClearUp);
    procedure ShowUpClick(aClearup: TClearUp);
    procedure CBVinylChange(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure KnowScale(Sender: TObject);
    procedure btnCPOImportClick(Sender: TObject);
    procedure btnCPOExportClick(Sender: TObject);
    procedure lbBlinkersDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure btnRegisterMOXClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ScanMOXheaders1Click(Sender: TObject);
    procedure shpBlinkerColorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ShapeBGMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    h_DC: HDC;
    h_RC: HGLRC;
    fOldTimeFPS: Cardinal;
    fOldFrameTimes: Cardinal;
    fFrameCount: Cardinal;
    fLastInputMode: TInputMode;
    fUIRefresh: Boolean;

    fColorBackground: Cardinal;
    fColorWireframe: Cardinal;

    fOpenedFileMask: string;
    fOpenedFolder: string;
    fRenderMode: TRenderMode;
    fCameraAction: TCameraAction;
    fOriginCursorX, fOriginCursorY: Integer;

    fLightCopyID: Integer;
    fColorCopyID: Integer;
    fCOBCopyItem: Integer;
    fUseShaders: Boolean;
    fRenderObjects: TRenderObjectSet;

    fCOB: TModelCOB;
    fTree: TModelTree;

    procedure LoadSettingsFromIni(const aFilename: string);
    procedure SaveSettingsToIni(const aFilename: string);
    procedure OnIdle(Sender: TObject; var Done: Boolean);
    procedure OnMessage(var aMsg: TMsg; var aHandled: Boolean);
    procedure Render;
    procedure LoadFile(const aFilename: string; aMode: TLoadMode);
    procedure LoadTextures;
    procedure SendDataToUI(aSection: TUIDataSection);
    procedure SetActivePage(aPage: TActivePage);
    procedure SetRenderObject(aSet: TRenderObjectSet);
    procedure BlinkerAdd(aIndex: Integer);
    procedure BlinkerRemove(aIndex: Integer);
    procedure ConverseImp_MOX;
    procedure MaterialSetDefault;
    procedure SaveMOX(const aFilename: string);
    procedure DevScanMOXHeaders;
    procedure RebuildPartsTree;
    procedure ExchangePartsOrdering;
  end;

var
  Form1: TForm1;

  FPSLag: Word = 33;
  OldTimeLWO: Cardinal;
  EnvTexture,SpecTexture,Spec2Texture:glUint;
  DirtTex,ScratchTex:glUint;
  FlameTex,LensFlareTex,DummyTex,SelectionTex:glUint;
  Dummy,Pivot,BBox,BBoxW,Center,FlameSprite,Sprite1Side,Sprite2Side,SelectionSphere:glUint;
  MoxCall,MoxUVCall: array [1..16384]of Word;
  MoxTex: array [1..256]of glUint;

  // Viewport controls
  xMov, yMov: Single;
  XRot: Single=25;
  YRot: Single=20;
  zoom: Single=0.3125;

  RenderOptions: record
    ShowPart: Boolean;
    ShowMaterial: Integer;
    ShowDamage: Boolean;
    PartsFlapPos: Single;
    LightVec, Colli, Wire, UVMap: Boolean;
  end;

  ExeDir: string;
  ActivePage: TActivePage;

  MatID,ColID:Integer;
  SelectedTreeNode:Integer;
  DefColor:Byte; //Yellow

var
  // This should be universal exchange format in MTKit2
  Imp: record
    VerticeCount, PolyCount, SurfCount, PartCount: Integer;
    XYZ: array [1..MAX_MOX_VTX] of Vector3f;
    Np: array [1..MAX_MOX_VTX] of Vector3f;
    Nv: array [1..MAX_MOX_VTX] of Vector3f;
    UV: array [1..MAX_MOX_VTX] of Vector2f;
    DUV: array [1..MAX_MOX_VTX,1..4] of Vector2f; //poly.point.value
    Faces: array [1..MAX_MOX_IDX,1..4]of Integer;    //Polygon links
    Surf: array [1..MAX_MOX_IDX]of Word;
    Part: array [1..MAX_MOX_IDX]of Word;
    PartName: array [1..MAX_PARTS]of string;
    Mtl: array [1..MAX_MATERIALS]of record
      Title:string;
      Amb,Dif,Spec:record R,G,B:Byte; end;
      Reflect,Transparency:Byte;
      TexName:string;
    end;
  end;

  LWOQty: record
    UV,DUV: array [0..MAX_PARTS] of Integer;  //DUV exceeds 65K sometimes it's ok
    XYZ,Poly,Surf: array [1..MAX_PARTS] of Word;
  end;

  Dnode: array [1..MAX_PARTS]of TTreeNode;

  NumColors: Byte; //Number of colors to use

  VinylsCount:Integer;
  VinylsTex:GLUint;
  VinylsList: array [1..128] of string;

  PartModify: array [1..MAX_PARTS] of record
    ActualPoint: Integer;
    AxisSetup: array [1..3] of Byte;
    Low: array [1..3] of Single;
    High: array [1..3] of Single;
    Custom: array [1..3] of Single;
    Move: array [1..3] of Single;
  end;

  RenderChrome: Boolean;
  IsLightwave2MOX: Boolean=False;
  ForbidPartsChange: Boolean=True;
  ForbidPivotChange: Boolean=False;

implementation
uses
  ColorPicker2, UnitRawInputHeaders,
  MTKit2_Textures;

{$R *.dfm}

procedure RegisterListener;
const
  // https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/hid-usages#usage-page
  HID_USAGE_PAGE_GENERIC = 1;
  HID_USAGE_PAGE_GAME = 5;
  HID_USAGE_PAGE_LED = 8;
  HID_USAGE_PAGE_BUTTON = 9;
  // https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/hid-usages#usage-id
  HID_USAGE_GENERIC_MOUSE = 2;
  HID_USAGE_GENERIC_KEYBOARD = 6;
var
  rid: tagRAWINPUTDEVICE;
begin
  // To receive WM_INPUT messages, an application must first register the raw input devices using RegisterRawInputDevices.
  // By default, an application does not receive raw input.
  rid.usUsagePage := HID_USAGE_PAGE_GENERIC;
  rid.usUsage := HID_USAGE_GENERIC_MOUSE;
  rid.dwFlags := 0;
  rid.hwndTarget := 0; // If NULL it follows the keyboard focus
  RegisterRawInputDevices(@rid, 1, SizeOf(rid));
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  fname: string;
begin
  fname := ParamStr(1); //Get filename parameter
  ExeDir := ExtractFilePath(Application.ExeName);
  meLog.Lines.Add(fname);
  Caption := APP_TITLE + ' v' + VER_INFO;

  LoadSettingsFromIni(ExeDir + 'MTKit2 Data\options.ini');
  SetRenderFrame(RenderPanel.Handle, h_DC, h_RC);
  meLog.Lines.Add('Basic OpenGL init complete');

  BuildFont(h_DC, 20);
  RenderInit;
  RenderResize(nil);
  CompileCommonObjects;
  fUseShaders := LoadFresnelShader;
  if fUseShaders then meLog.Lines.Add('Shaders loaded');

  PivotSetup.TabVisible := False;
  Application.OnIdle := OnIdle;
  RegisterListener;
  Application.OnMessage := OnMessage;
  PageControl1Change(nil); //update ActivePage
  CBRenderModeChange(nil); //update RenderMode
  FormatSettings.DecimalSeparator := '.';

  fCOB := TModelCOB.Create;
  fTree := TModelTree.Create;

  ClearUpClick(cuALL);

  Dev1.Visible := FileExists('krom.dev');

  if not FileExists('krom.dev') then SetActivePage(apMTL);
  //fname:='E:\World Racing 2\AddOns\Autos\3000gt\3000gt.mox';
  //fname:='alfa147.mox';
  //fname:='E:\WR2 Demo Skoda\Autos\octavia_rs\octavia_rs.mox';
  //fname:=ExeDir+'CPO Collection\Schirm_gelb.cpo';
  //fname:='D:\a.tree';
  //fname:='demo8.mox';

  {ImportLWOCOB('Octavia_Race_colli_colli.lwo');
  fCOB.SaveCOB('l2c_old.cob');
  fCOB.Clear;
  fCOB.ImportLWO2COB('Octavia_Race_colli_colli.lwo');
  fCOB.SaveCOB('l2c_new.cob');
  Halt;}

  //Open it through browser
  if FileExists(fname) then
  begin
    FileListBox1.FileName := fname;
    FileListBox1Click(nil);
  end else
    fOpenedFolder := ExeDir;

  DoClientAreaResize(Form1);
end;

procedure TForm1.LoadSettingsFromIni(const aFilename: string);
var
  iniFile: TIniFile;
begin
  meLog.Lines.Add('Reading options.ini ...');
  iniFile := TIniFile.Create(aFilename);

  fColorBackground := iniFile.ReadInteger('Background color', 'R', 128) +
                      iniFile.ReadInteger('Background color', 'G', 128) shl 8 +
                      iniFile.ReadInteger('Background color', 'B', 128) shl 16;
  ShapeBG.Brush.Color := fColorBackground;

  fColorWireframe :=  iniFile.ReadInteger('Wireframe color', 'R', 255) +
                      iniFile.ReadInteger('Wireframe color', 'G', 255) shl 8 +
                      iniFile.ReadInteger('Wireframe color', 'B', 255) shl 16;
  ShapeWF.Brush.Color := fColorWireframe;

  FPSLimitEdit.Value  := iniFile.ReadInteger('FPS limit', 'Value', 33);
  FPSLag := abs(round(1/FPSLimitEdit.Value*1000));
  cbAskOnClose.Checked := iniFile.ReadBool('Ask on close', 'Value', True);

  DefColor := iniFile.ReadInteger('Default body color', 'Index', 4); //Yellow
  ComboBox1.ItemIndex := DefColor;

  iniFile.Free;
end;


procedure TForm1.SaveSettingsToIni(const aFilename: string);
var
  iniFile: TIniFile;
begin
  meLog.Lines.Add('Writing options.ini ...');
  iniFile := TIniFile.Create(aFilename);

  iniFile.WriteInteger('Background color', 'R', fColorBackground and $FF);
  iniFile.WriteInteger('Background color', 'G', fColorBackground shr 8 and $FF);
  iniFile.WriteInteger('Background color', 'B', fColorBackground shr 16 and $FF);

  iniFile.WriteInteger('Wireframe color', 'R', fColorWireframe and $FF);
  iniFile.WriteInteger('Wireframe color', 'G', fColorWireframe shr 8 and $FF);
  iniFile.WriteInteger('Wireframe color', 'B', fColorWireframe shr 16 and $FF);

  iniFile.WriteInteger('FPS limit', 'Value', round(1000/FPSLag));

  iniFile.WriteBool('Ask on close', 'Value', cbAskOnClose.Checked);

  iniFile.WriteInteger('Default body color', 'Index', DefColor);

  iniFile.WriteString('Comments', '0', 'FPS limit: Set to 1000 to disable it');

  iniFile.Free;
end;


procedure TForm1.OnIdle(Sender: TObject; var Done: Boolean);
var
  frameTime: Cardinal;
begin
  if not Form1.Active then Exit;
  if fCameraAction <> caNone then Exit;

  Done := False;
  frameTime := GetTickCount - fOldTimeFPS;
  fOldTimeFPS := GetTickCount;
  if (FPSLag <> 1) and (frameTime < FPSLag) then
  begin
    Sleep(FPSLag - frameTime);
    frameTime := FPSLag;
  end;

  if frameTime > 1000 then
    frameTime := 1000;
  fOldFrameTimes := fOldFrameTimes + frameTime;
  Inc(fFrameCount);
  if fOldFrameTimes >= FPS_INTERVAL then
  begin
    StatusBar1.Panels[1].Text :=
      FloatToStr(Round((1000 / (fOldFrameTimes / fFrameCount)) * 10) / 10) + ' fps (' + IntToStr(1000 div FPSLag) + ')';
    fOldFrameTimes := 0;
    fFrameCount := 0;
  end; // FPS calculation complete

  Render;
end;


procedure TForm1.OnMessage(var aMsg: TMsg; var aHandled: Boolean);
var
  dwSize: Cardinal;
  ri: tagRAWINPUT;
begin
  if aMsg.message = WM_INPUT then
  begin
    if GetRawInputData(HRAWINPUT(aMsg.lParam), RID_INPUT, nil, dwSize, SizeOf(RAWINPUTHEADER)) <> 0 then
      ShowMessage('Error calling GetRawInputData');

    if dwSize = 0 then
      ShowMessage('Can not allocate memory');

    if GetRawInputData(HRAWINPUT(aMsg.lParam), RID_INPUT, @ri, dwSize, SizeOf(RAWINPUTHEADER)) <> dwSize then
      ShowMessage('GetRawInputData doesn''t return correct size !');

    // https://docs.microsoft.com/en-us/windows/win32/api/winuser/ns-winuser-rawinputdevicelist
    // https://docs.microsoft.com/en-us/windows/win32/api/winuser/ns-winuser-rawmouse
    if ri.header.dwType = RIM_TYPEMOUSE then
    begin
      if ri.mouse.usFlags and $1 = 0 then
        fLastInputMode := imRelative
      else
        fLastInputMode := imAbsolute;
    end;
  end;

  aHandled := False;
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DirectoryExists(ExeDir + 'MTKit2 Data\') then
    SaveSettingsToIni(ExeDir + 'MTKit2 Data\options.ini');
end;


procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if cbAskOnClose.Checked then
    CanClose := (MessageBox(Handle, 'Close MTKit2?', 'Question', MB_YESNO or MB_ICONQUESTION) = ID_YES);
end;


procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fCOB);
  FreeAndNil(fTree);

  wglMakeCurrent(h_DC, 0);
  wglDeleteContext(h_RC);
end;


procedure TForm1.Button4Click(Sender: TObject); begin {Placeholder} end;


procedure TForm1.SendDataToUI(aSection: TUIDataSection);
var
  ii: Integer;
  oldID1: Integer;
begin
  case aSection of
    uiMOX:      begin
                  edVerticeCount.Text := IntToStr(MOX.Header.VerticeCount);
                  edPolyCount.Text := IntToStr(MOX.Header.PolyCount);
                  edPartCount.Text := IntToStr(MOX.Header.PartCount);
                  edMaterialCount.Text := IntToStr(MOX.Header.MatCount);
                  edChunkCount.Text := IntToStr(MOX.Header.ChunkCount);
                  edBlinkerCount.Text := IntToStr(MOX.Header.BlinkerCount);
                end;
    uiMTL:      begin
                  LBMaterials.Clear;
                  for ii:=1 to MOX.Header.MatCount do
                    LBMaterials.AddItem(Material[ii].Mtag+' '+Material[ii].Title,nil);
                  LBMaterials.ItemIndex:=0;
                  if NumColors=1 then
                    CBColor.ItemIndex:=0
                  else
                    CBColor.ItemIndex:=DefColor;
                  LBMaterialsClick(nil);
                end;
    uiVinyl:    begin
                  CBVinyl.Clear;
                  CBVinyl.AddItem('-Default-', nil);
                  for ii:=1 to VinylsCount do
                    CBVinyl.AddItem(VinylsList[ii], nil);
                  CBVinyl.ItemIndex:=0;
                end;
    uiBlinkers: begin
                  fUIRefresh := True;
                  oldID1:=LBBlinkers.ItemIndex;
                  LBBlinkers.Clear;
                  for ii:=1 to MOX.Header.BlinkerCount do
                    LBBlinkers.Items.Add(IntToStr(ii)+'. '+ MOX.Blinkers[ii].GetStr);
                  if oldID1<LBBlinkers.Count then LBBlinkers.ItemIndex:=oldID1;
                  fUIRefresh := False;
                end;
    uiParts:    begin
                  TVParts.Items.Clear;
                  for ii:=1 to MOX.Header.PartCount do
                  begin
                    if MOX.Parts[ii].Parent=-1 then Dnode[ii] := TVParts.Items.Add(nil,MOX.Parts[ii].Dname) else //make Root
                    Dnode[ii] := TVParts.Items.AddChild(Dnode[MOX.Parts[ii].Parent+1],MOX.Parts[ii].Dname);      //child
                  end;
                  if MOX.Header.PartCount>=1 then Dnode[1].Expand(False);
                end;
    uiCOB:      begin
                  fUIRefresh := True;
                  oldID1 := LBCOBPoints.ItemIndex;
                  LBCOBPoints.Clear;
                  for ii := 0 to fCOB.Head.PointQty - 1 do
                    LBCOBPoints.Items.Add(IntToStr(ii + 1));
                  LBCOBPoints.ItemIndex := EnsureRange(oldID1, 0, LBCOBPoints.Count - 1);
                  fUIRefresh := False;

                  COB_X.Value := fCOB.Head.X;
                  COB_Y.Value := fCOB.Head.Y;
                  COB_Z.Value := fCOB.Head.Z;
                  COB_X1.Value := fCOB.Head.Xmin;
                  COB_Y1.Value := fCOB.Head.Ymin;
                  COB_Z1.Value := fCOB.Head.Zmin;
                  COB_X2.Value := fCOB.Head.Xmax;
                  COB_Y2.Value := fCOB.Head.Ymax;
                  COB_Z2.Value := fCOB.Head.Zmax;
                end;
    uiCPO:      begin
                  fUIRefresh := True;
                  oldID1:=LBCPOShapes.ItemIndex;
                  LBCPOShapes.Clear;
                  for ii:=1 to CPOHead.Qty do
                    case  CPO[ii].Format of
                      2:  LBCPOShapes.Items.Add('Bound #'+IntToStr(ii));
                      3:  LBCPOShapes.Items.Add('Shape #'+IntToStr(ii)+' '+IntToStr(CPO[ii].IndiceSize div 2));
                    else
                      LBCPOShapes.Items.Add('Unknown #'+IntToStr(ii));
                    end;
                  fUIRefresh := False;
                  LBCPOShapes.ItemIndex:=EnsureRange(oldID1,0,LBCPOShapes.Count-1);
                  LBCPOShapesClick(nil);
                  Label82.Caption:='Shapes: '+IntToStr(CPOHead.Qty);
                end;
  end;
end;

procedure TForm1.CompileLoadedMOX;
var
  H,I,K: Integer;
  t: Single;
begin
  for I:=1 to MOX.Header.ChunkCount do
  begin
    if MoxCall[I]=0 then MoxCall[I]:=glGenLists(1);
    glNewList(MoxCall[I], GL_COMPILE);
    glBegin(GL_TRIANGLES);
      for K:=1 to MOX.Chunks[I].PolyCount do  //1..number polys
      for H:=3 downto 1 do
      begin
        glTexCoord2fv(@MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,H]].U);
        glNormal3fv(@MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,H]].nX);
        glVertex3fv(@MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,H]].X);
      end;
    glEnd;
    glEndList;

    if MoxUVCall[I]=0 then MoxUVCall[I]:=glGenLists(1);
    glNewList(MoxUVCall[I], GL_COMPILE);
    glbegin(GL_TRIANGLES);
      for K:=1 to MOX.Chunks[I].PolyCount do
      begin
        Normal2Poly(MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,1]].U,MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,1]].V,
                    MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,2]].U,MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,2]].V,
                    MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,3]].U,MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,3]].V, t);
        if t>=0 then
          for H:=3 downto 1 do
          begin
            glTexCoord2fv(@MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,H]].U);
            glVertex2f(MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,H]].U,-MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,H]].V+1);
            //glVertex2f(MOX.Vertice[MOX.Face[MOX.Chunk[I,1]+K,H]].x1,-MOX.Vertice[MOX.Face[MOX.Chunk[I,1]+K,H]].x2+1);//AFC11CT
          end
        else
          for H:=1 to 3 do begin
            glTexCoord2fv(@MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,H]].U);
            glVertex2f(MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,H]].U,-MOX.Vertice[MOX.Face[MOX.Chunks[I].FirstPoly+K,H]].V+1);
            //glVertex2f(MOX.Vertice[MOX.Face[MOX.Chunk[I,1]+K,H]].x1,-MOX.Vertice[MOX.Face[MOX.Chunk[I,1]+K,H]].x2+1);//AFC11CT
          end;
      end;
    glEnd;
    glEndList;
  end;

  KnowScale(nil);
end;

procedure TForm1.Render;
begin
  glClearColor(fColorBackground and $FF / 255, fColorBackground shr 8 and $FF / 255, fColorBackground shr 16 and $FF / 255, 0); 	   // Grey Background
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);    // Clear The Screen And The Depth Buffer
  glLoadIdentity;                                       // Reset The View
  glLightfv(GL_LIGHT0, GL_POSITION, @LightPos);  //can make
  glLightfv(GL_LIGHT1, GL_POSITION, @LightPos2); //static lights
  glPointSize(8);

  if RenderOptions.UVMap then
  begin
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); //Set alpha mode
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glBindTexture(GL_TEXTURE_2D, 0);
    glDisable(GL_LIGHTING);

    glTranslatef(-xMov/10,yMov/10,0);
    glTranslatef(0.5,0.5,0);
    glkScale(sqr(zoom*3.2));
    glTranslatef(-0.5,-0.5,0);

    RenderUVGrid(CBShowGrid.Checked);
    RenderOpenGL;
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    RenderDirt('', TBDirt.Position);
  end else
  begin
    glTranslatef(0, 0, -6);
    glTranslatef(xMov, yMov, 0);
    glRotatef(yRot, 1, 0, 0);
    glRotatef(xRot, 0, 1, 0);
    glkScale(Sqr(zoom));

    if RenderOptions.ShowPart and (ActivePage=apParts) and (SelectedTreeNode<>0) then
      glTranslatef(-MOX.Parts[SelectedTreeNode].Matrix[4,1]-PartModify[SelectedTreeNode].Move[1],
                   -MOX.Parts[SelectedTreeNode].Matrix[4,2]-PartModify[SelectedTreeNode].Move[2],
                   -MOX.Parts[SelectedTreeNode].Matrix[4,3]-PartModify[SelectedTreeNode].Move[3]);
    if cbTargetLight.Checked and (ActivePage=apLights) and (LBBlinkers.ItemIndex<>-1) then
      glTranslatef(-MOX.Blinkers[LBBlinkers.ItemIndex+1].Matrix[4,1],
                   -MOX.Blinkers[LBBlinkers.ItemIndex+1].Matrix[4,2],
                   -MOX.Blinkers[LBBlinkers.ItemIndex+1].Matrix[4,3]);

    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); //Set alpha mode
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glBindTexture(GL_TEXTURE_2D, 0);

    glDisable(GL_LIGHTING);
    if CBShowGrid.Checked then RenderGrid;
    glEnable(GL_LIGHTING);

    if roMOX in fRenderObjects then
    begin
      if fRenderMode = rmShaders then
        RenderShaders;

      if fRenderMode = rmOpenGL then
      begin
        RenderOpenGL;
        glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
        RenderDirt('', TBDirt.Position);
        if SelectedTreeNode<>0 then
          RenderPivotSetup(PivotPointActual.Value+MOX.Chunks[MOX.Parts[SelectedTreeNode].FirstMat+1].FirstVtx-1,
                           PivotPointActual.MaxValue,
                           PivotPointActual.Value); //PivotPointActual & SRnage both have +1
        RenderDummy;
        glDisable(GL_LIGHTING);
        if RenderOptions.Wire then RenderWireframe(fColorWireframe);
        glEnable(GL_LIGHTING);
      end;
      glDisable(GL_DEPTH_TEST);
      if (ActivePage = apLights) or RenderOptions.LightVec then
        RenderLights(LBBlinkers.ItemIndex+1, TBlinkerPreviewMode(rgBlinkerPreview.ItemIndex), ActivePage = apLights, Lightvectors1.Checked);
      glEnable(GL_DEPTH_TEST);
    end;

    if roTREE in fRenderObjects then
      fTree.Render(Pivot, xRot, yRot, RenderOptions.Wire);

    if (roCOB in fRenderObjects) then
      if (ActivePage = apCOB)
      or RenderOptions.Colli
      or (ActivePage = apBrowse) and not (roMOX in fRenderObjects) then
        RenderCOB(fCOB, LBCOBPoints.ItemIndex, cbCOBShowIds.Checked);

//      glDisable(GL_DEPTH_TEST);
    if (roCPO in fRenderObjects) then
      if (ActivePage = apCPO) or (RenderOptions.Colli)
      or (ActivePage = apBrowse) and not (roMOX in fRenderObjects) then
      begin
//      glDisable(GL_DEPTH_FUNC);
        glDepthFunc(GL_ALWAYS);
//      RenderCPO(LBCPOShapes.ItemIndex+1);
//      glEnable(GL_DEPTH_FUNC);
        glDepthFunc(GL_LEQUAL);
        RenderCPO(LBCPOShapes.ItemIndex+1);
      end;
//      glEnable(GL_DEPTH_TEST);
  end;

  swapBuffers(h_DC);
     {
  //Reset
  glClearColor(0, 0, 0, 0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);    // Clear The Screen And The Depth Buffer
  glDisable(GL_LIGHTING);
  glLoadIdentity;                                       // Reset The View
  glPointSize(8);

  //Do only 3D view yet
  if not RenderOptions.UVMap then begin
    glTranslate(0,0,-6);
    glTranslate(xMov,yMov,0);
    glRotatef(yRot, 1, 0, 0);
    glRotatef(xRot, 0, 1, 0);
    glkScale(sqr(zoom));

    if roMOX in RenderObject then
      if RenderMode=rmOpenGL then
        RenderOpenGL;

  end;   }
end;


procedure TForm1.RenderResize(Sender: TObject);
var
  minsize: Integer;
  xo, yo: Single;
begin
  if (RenderPanel.Height = 0) then RenderPanel.Height := 1;
  if (RenderPanel.Width = 0) then RenderPanel.Width := 1;
  glViewport(0, 0, RenderPanel.Width, RenderPanel.Height);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;

  minsize := min(RenderPanel.Width, RenderPanel.Height);
  xo := (RenderPanel.Width / minsize - 1) / 2;
  yo := (RenderPanel.Height / minsize - 1) / 2;

  if RenderOptions.UVMap then
    gluOrtho2D(0 - xo, 1 + xo, 0 - yo, 1 + yo)
  else
    gluPerspective(60, -RenderPanel.Width / RenderPanel.Height, 0.1, 200.0);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
end;


procedure TForm1.Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Sender = ImageR) or ((Sender = RenderPanel) and (Button = mbLeft)) then fCameraAction := caRotate;
  if (Sender = ImageM) or ((Sender = RenderPanel) and (Button = mbRight)) then fCameraAction := caMove;
  if (Sender = ImageZ) then fCameraAction := caZoom;

  fOriginCursorX := X;
  fOriginCursorY := Y;

  ShowCursor(False);
end;


procedure TForm1.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
var
  origin: TPoint;
begin
  case fCameraAction of
    caRotate: begin
                xRot := xRot - (X - fOriginCursorX);
                yRot := yRot + (Y - fOriginCursorY);
              end;
    caZoom:   begin
                Zoom := EnsureRange(zoom + (X - fOriginCursorX) / 150, 0.06125, 2);
              end;
    caMove:   begin
                xMov := xMov - (X - fOriginCursorX) / 100;
                yMov := yMov - (Y - fOriginCursorY) / 100;
              end;
  else
    Exit;
  end;

  case fLastInputMode of
    imRelative: begin
                  // Stick mouse cursor to start location, otherwise it stucks at screen border
                  origin := TControl(Sender).ClientToScreen(Point(fOriginCursorX, fOriginCursorY));
                  SetCursorPos(origin.X, origin.Y)
                end;
    imAbsolute: begin
                  // Update tablet cursor origin, otherwise its offset will grow exponentially
                  fOriginCursorX := X;
                  fOriginCursorY := Y;
                end;
  end;

  Render;
end;


procedure TForm1.Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  fCameraAction := caNone;
  ShowCursor(True);
end;


procedure TForm1.LoadTextures;
var
  i,k: Integer;
begin
  // Clear RAM used by textures
  for i:=1 to MOX.Header.MatCount do
    if MoxTex[i] <> 0 then
    begin
      glDeleteTextures(1, @MoxTex[i]);
      MoxTex[i] := 0;
    end;
  glDeleteTextures(1, @DirtTex);
  glDeleteTextures(1, @ScratchTex);

  // Load new textures
  for i:=1 to MOX.Header.MatCount do
  begin
    for k:=1 to i-1 do
      if Material[k].TexName = Material[i].TexName then
        MoxTex[i] := MoxTex[k]; //use earlier loaded texture ID

    if MoxTex[i] = 0 then
      MoxTex[i] := TryToLoadTexture(fOpenedFolder, Material[i].TexName);
  end;

  DirtTex := TryToLoadTexture(fOpenedFolder, 'dirt.tga');
  ScratchTex := TryToLoadTexture(fOpenedFolder, 'scratch.tga');
end;


procedure TForm1.lbBlinkersClick(Sender: TObject);
var
  idx: Integer;
  blinkerType: Integer;
  ax,ay,az: Integer;
  m: array [1..9] of Single;
begin
  idx := LBBlinkers.ItemIndex+1;
  if idx = 0 then Exit;

  fUIRefresh := True;
  try
    blinkerType := MOX.Blinkers[idx].BlinkerType;
    case blinkerType of //Fit 0..24 IDs in RG range of 0..12
      16: blinkerType := 10;
      20: blinkerType := 11;
      24: blinkerType := 12;
      33: blinkerType := 13;
    end;

    rgBlinkerType.ItemIndex := blinkerType;

    fsBlinkerSizeMin.Value := MOX.Blinkers[idx].sMin;
    fsBlinkerSizeMax.Value := MOX.Blinkers[idx].sMax;
    fsBlinkerFreq.Value := MOX.Blinkers[idx].Freq;
    //S1.Value:=MOX.Blinkers[LBBlinkers.ItemIndex+1].z1;
    seBlinkerParent.Value:=MOX.Blinkers[idx].Parent;
    fsBlinkerX.Value:=MOX.Blinkers[idx].Matrix[4,1]/10;
    fsBlinkerY.Value:=MOX.Blinkers[idx].Matrix[4,2]/10;
    fsBlinkerZ.Value:=MOX.Blinkers[idx].Matrix[4,3]/10;
    shpBlinkerColor.Brush.Color := MOX.Blinkers[idx].R+MOX.Blinkers[idx].G*256+MOX.Blinkers[idx].B*65536;

    with MOX.Blinkers[idx] do
    begin
      m[1]:=Matrix[1,1]; m[2]:=Matrix[1,2]; m[3]:=Matrix[1,3];
      m[4]:=Matrix[2,1]; m[5]:=Matrix[2,2]; m[6]:=Matrix[2,3];
      m[7]:=Matrix[3,1]; m[8]:=Matrix[3,2]; m[9]:=Matrix[3,3];
    end;

    Matrix2Angles(m, 9, @ax, @ay, @az);

    fsBlinkerH.Value := Round(ax);
    fsBlinkerP.Value := Round(ay);
    fsBlinkerB.Value := Round(az);
  finally
    fUIRefresh := False;
  end;
end;


procedure TForm1.BlinkChange(Sender: TObject);
var
  idx: Integer;
begin
  idx := LBBlinkers.ItemIndex+1;
  if idx = 0 then Exit;
  if fUIRefresh then Exit;

  case rgBlinkerType.ItemIndex of
    0..9: MOX.Blinkers[idx].BlinkerType := rgBlinkerType.ItemIndex;
    10:   MOX.Blinkers[idx].BlinkerType := 16;
    11:   MOX.Blinkers[idx].BlinkerType := 20;
    12:   MOX.Blinkers[idx].BlinkerType := 24;
    13:   MOX.Blinkers[idx].BlinkerType := 33;
  end;

  MOX.Blinkers[idx].sMin := fsBlinkerSizeMin.Value;
  MOX.Blinkers[idx].sMax := fsBlinkerSizeMax.Value;
  MOX.Blinkers[idx].Freq := fsBlinkerFreq.Value;
  MOX.Blinkers[idx].Unused := 0;
  MOX.Blinkers[idx].Parent := seBlinkerParent.Value;
  SendDataToUI(uiBlinkers);
end;


procedure TForm1.CBColorChange(Sender: TObject);
begin
  ColID := CBColor.ItemIndex+1;
  if MatID = 0 then Exit;

  with Material[MatID].Color[ColID] do
  begin
    ShapeA.Brush.Color:=Amb.R+Amb.G*256+Amb.B*65536;
    ShapeD.Brush.Color:=Dif.R+Dif.G*256+Dif.B*65536;
    ShapeS1.Brush.Color:=Sp1.R+Sp1.G*256+Sp1.B*65536;
    ShapeS2.Brush.Color:=Sp2.R+Sp2.G*256+Sp2.B*65536;
    ShapeR.Brush.Color:=Ref.R+Ref.G*256+Ref.B*65536;
  end;
end;


procedure TForm1.LBMaterialsClick(Sender: TObject);
begin
  MatID := LBMaterials.ItemIndex + 1;
  if MatID = 0 then Exit;

  MatName.Text := Material[MatID].Title;

  fUIRefresh := True;
  try
    tbMaterialTransparency.Position := Material[MatID].Transparency;
    edMaterialTextureFile.Text := Material[MatID].TexName;
    CBMatClass2.ItemIndex := Material[MatID].MatClass[2];
    CBMatClass3.ItemIndex := Material[MatID].MatClass[3];
    CB1.Checked := (Material[MatID].MatClass[4] AND 1) = 1;
    CB2.Checked := (Material[MatID].MatClass[4] AND 2) = 2;
    CB3.Checked := (Material[MatID].MatClass[4] AND 4) = 4;
    CB4.Checked := (Material[MatID].MatClass[4] AND 8) = 8;
    CBClipU.ItemIndex := Material[MatID].TexEdge.U;
    CBClipV.ItemIndex := Material[MatID].TexEdge.V;
  finally
    fUIRefresh := False;
  end;

  CBColorChange(nil); //update color panels
end;


procedure TForm1.MaterialPropertiesChange(Sender: TObject);
var
  t:Integer;
begin
  if MatID = 0 then Exit;
  Label13.Caption := IntToStr(tbMaterialTransparency.Position) + '% Transparency';
  if fUIRefresh then Exit;

  Material[MatID].Transparency := tbMaterialTransparency.Position;
  Material[MatID].TexName := edMaterialTextureFile.Text;
  Material[MatID].MatClass[2] := CBMatClass2.ItemIndex;
  Material[MatID].MatClass[3] := CBMatClass3.ItemIndex;
  t:=0;
  if CB1.Checked then inc(t,1);
  if CB2.Checked then inc(t,2);
  if CB3.Checked then inc(t,4);
  if CB4.Checked then inc(t,8);
  Material[MatID].MatClass[4] := T;
  Material[MatID].TexEdge.U:=CBClipU.ItemIndex;
  Material[MatID].TexEdge.V:=CBClipV.ItemIndex;
end;


procedure TForm1.MatNameChange(Sender: TObject);
begin
  if MatID=0 then Exit;
  Material[MatID].Title:=MatName.Text;
  LBMaterials.Items[MatID-1]:=Material[MatID].Mtag+' '+Material[MatID].Title;
end;


procedure TForm1.tvPartsChange(Sender: TObject; Node: TTreeNode);
var
  idx: Integer;
begin
  ForbidPartsChange := True;
  Label63.Caption:='ID: '+IntToStr(TVParts.Selected.AbsoluteIndex);
  SelectedTreeNode := TVParts.Selected.AbsoluteIndex+1;
  idx:=SelectedTreeNode;
  Label23.Caption:='#'+IntToStr(idx)+' P'+IntToStr(MOX.Parts[idx].Parent+1)
                                   +' C'+IntToStr(MOX.Parts[idx].Child+1)
                                   +' P'+IntToStr(MOX.Parts[idx].PrevInLevel+1)
                                   +' N'+IntToStr(MOX.Parts[idx].NextInLevel+1);

  EDetailName.Text:=MOX.Parts[SelectedTreeNode].Dname;
  CX.Value:=MOX.Parts[SelectedTreeNode].xMid;
  CY.Value:=MOX.Parts[SelectedTreeNode].yMid;
  CZ.Value:=MOX.Parts[SelectedTreeNode].zMid;
  CRad.Value:=MOX.Parts[SelectedTreeNode].fRadius;

  RGDetailType.ItemIndex := MOX.Parts[SelectedTreeNode].TypeID;
  if RGDetailType.ItemIndex<>MOX.Parts[SelectedTreeNode].TypeID then
    MessageBox(Handle, 'Unknown detail ID type', 'Discovery', MB_OK or MB_ICONSTOP);

  LX1.Value:=MOX.Parts[SelectedTreeNode].x1/Pi*180;//-YZ rotation
  LX2.Value:=MOX.Parts[SelectedTreeNode].x2/Pi*180;//+YZ rotation
  LY1.Value:=MOX.Parts[SelectedTreeNode].y1/Pi*180;//-XZ rotation
  LY2.Value:=MOX.Parts[SelectedTreeNode].y2/Pi*180;//+XZ rotation
  LZ1.Value:=MOX.Parts[SelectedTreeNode].z1/Pi*180;//-XY rotation
  LZ2.Value:=MOX.Parts[SelectedTreeNode].z2/Pi*180;//+XY rotation
  ForbidPartsChange := False;
  FlapParts.Enabled:=SelectedTreeNode<>0;
  Label30.Enabled:=SelectedTreeNode<>0;

  ForbidPivotChange := True;
  try
    PivotPointActual.MaxValue :=
      MOX.Chunks[MOX.Parts[SelectedTreeNode].FirstMat+1+MOX.Parts[SelectedTreeNode].NumMat-1].LastVtx -
      MOX.Chunks[MOX.Parts[SelectedTreeNode].FirstMat+1].FirstVtx+1;
    PivotPointActual.Value:=PartModify[SelectedTreeNode].ActualPoint;
    RGPivotX.ItemIndex:=PartModify[SelectedTreeNode].AxisSetup[1];
    RGPivotY.ItemIndex:=PartModify[SelectedTreeNode].AxisSetup[2];
    RGPivotZ.ItemIndex:=PartModify[SelectedTreeNode].AxisSetup[3];
    CustomPivotX.Value:=PartModify[SelectedTreeNode].Custom[1];
    CustomPivotY.Value:=PartModify[SelectedTreeNode].Custom[2];
    CustomPivotZ.Value:=PartModify[SelectedTreeNode].Custom[3];
  finally
    ForbidPivotChange := False;
  end;
end;


procedure TForm1.MatEdSetAllColorsToCurrent(Sender: TObject);
var
  ii: Integer;
begin
  if MatID=0 then Exit;
  for ii:=1 to MAX_COLORS do if ii<>ColID then
    Material[MatID].Color[ii]:=Material[MatID].Color[ColID];
end;


procedure TForm1.SaveMOX(const aFilename: string);
const
  MOX_FORMAT_HEADER: AnsiString = '!XOM'#0#0#2#2;
var
  s: AnsiString;
  h,i,j,k,m:Integer;
  ii,kk:Integer;
  f:file;
  vv: array [1..65280,1..3]of longWord;
  tx,ty,tz: array [1..256]of real;
  Lev:Integer;
  lazyqty: array of Integer;
  face6: array [1..3] of Word;
begin
  assignfile(f,aFilename); rewrite(f,1);

  if PivotSetup.TabVisible then  //LWO>MOX only !
  begin  //Set MoxMat/Sid order continous
    //kinda lazy to re-do SRange stuff, so just sort it out here :-)

    setlength(lazyqty,MOX.Header.PartCount+1);
    lazyqty[0]:=0;

    for i:=1 to MOX.Header.PartCount do
    begin
      lazyqty[i]:=1;                  //number of MOX.Parts
      for j:=MOX.Parts[i].FirstMat+1 to MOX.Parts[i].FirstMat+MOX.Parts[i].NumMat do
        if (MOX.Chunks[j].PolyCount>0) then
        begin  //if polycount for part >1
          MOX.Chunks[lazyqty[0]+lazyqty[i]].FirstPoly:=MOX.Chunks[j].FirstPoly;
          MOX.Chunks[lazyqty[0]+lazyqty[i]].PolyCount:=MOX.Chunks[j].PolyCount;
          MOX.Chunks[lazyqty[0]+lazyqty[i]].FirstVtx:=MOX.Chunks[j].FirstVtx;
          MOX.Chunks[lazyqty[0]+lazyqty[i]].LastVtx:=MOX.Chunks[j].LastVtx;
          MOX.Chunks[lazyqty[0]+lazyqty[i]].SidA:=MOX.Chunks   [j].SidA;
          MOX.Chunks[lazyqty[0]+lazyqty[i]].SidB:=MOX.Chunks   [j].SidB;
          //MoxMat[lazyqty[0]+lazyqty[i]].ID:=MoxMat[j].ID;
          inc(lazyqty[i]);
        end;
      dec(lazyqty[i]);
      inc(lazyqty[0],lazyqty[i]);
    end;

    MOX.Header.ChunkCount:=0;
    MOX.Parts[1].FirstMat:=0;

    for i:=1 to MOX.Header.PartCount do
    begin
      inc(MOX.Header.ChunkCount, lazyqty[i]);
      MOX.Parts[i].NumMat:=lazyqty[i];
      MOX.Parts[i+1].FirstMat:=MOX.Parts[i].FirstMat+MOX.Parts[i].NumMat;
    end;
    //re-Sorting ends here}

    k:=1; m:=0;
    for i:=1 to MOX.Header.VerticeCount do
    begin
      if i=MOX.Chunks[k].LastVtx+1 then
        inc(k);//3-point From  //4-point Till //k-partID

      if MOX.Parts[m+1].FirstMat+1=k then
      begin
        inc(m); //m-detailID
        tx[m]:=0; ty[m]:=0; tz[m]:=0;
        Lev:=m;
        //repeat
          if (MOX.Parts[Lev].Parent<>-1) then
          begin
            Lev:=MOX.Parts[Lev].Parent+1; //parentID
            tx[m] := Tx[m]-PartModify[Lev].Move[1];
            ty[m] := Ty[m]-PartModify[Lev].Move[2];
            tz[m] := Tz[m]-PartModify[Lev].Move[3];
          end;
        //until(MOX.Parts[Lev].Parent=-1);
        tx[m] := Tx[m]+PartModify[m].Move[1];
        ty[m] := Ty[m]+PartModify[m].Move[2];
        tz[m] := Tz[m]+PartModify[m].Move[3];
      end;

      MOX.Vertice[i].X:=MOX.Vertice[i].X-PartModify[m].Move[1];
      MOX.Vertice[i].Y:=MOX.Vertice[i].Y-PartModify[m].Move[2];
      MOX.Vertice[i].Z:=MOX.Vertice[i].Z-PartModify[m].Move[3];
    end;

    for i:=1 to MOX.Header.PartCount do
    begin
      MOX.Parts[i].Matrix[4,1] := Tx[i];//PartModify[i].Move[1];
      MOX.Parts[i].Matrix[4,2] := Ty[i];//PartModify[i].Move[2];
      MOX.Parts[i].Matrix[4,3] := Tz[i];//PartModify[i].Move[3];
      MOX.Parts[i].xMid:=MOX.Parts[i].xMid-PartModify[i].Move[1];
      MOX.Parts[i].yMid:=MOX.Parts[i].yMid-PartModify[i].Move[2];
      MOX.Parts[i].zMid:=MOX.Parts[i].zMid-PartModify[i].Move[3];
    end;
  end;

  PivotSetup.TabVisible := False;

  // Make sure we write Ansi chars
  BlockWrite(f, PAnsiChar(MOX_FORMAT_HEADER)^, 8);

  BlockWrite(f, MOX.Header, 24);
  BlockWrite(f, MOX.Vertice, MOX.Header.VerticeCount*40);
  for ii:=1 to MOX.Header.PolyCount do
  begin
    face6[1] := MOX.Face[ii,1] - 1;
    face6[2] := MOX.Face[ii,2] - 1;
    face6[3] := MOX.Face[ii,3] - 1;

    BlockWrite(f, face6, 6);
  end;

  for ii:=1 to MOX.Header.ChunkCount do
  begin
    BlockWrite(f,MOX.Chunks[ii].SidA,2); BlockWrite(f,#0+#0,2);
    BlockWrite(f,MOX.Chunks[ii].SidB,2); BlockWrite(f,#0+#0,2);

    dec(MOX.Chunks[ii].FirstVtx); dec(MOX.Chunks[ii].LastVtx);
    BlockWrite(f,MOX.Chunks[ii].FirstPoly,2); BlockWrite(f,#0+#0,2);
    BlockWrite(f,MOX.Chunks[ii].PolyCount,2); BlockWrite(f,#0+#0,2);
    BlockWrite(f,MOX.Chunks[ii].FirstVtx,2); BlockWrite(f,#0+#0,2);
    BlockWrite(f,MOX.Chunks[ii].LastVtx,2); BlockWrite(f,#0+#0,2);
    inc(MOX.Chunks[ii].FirstVtx); inc(MOX.Chunks[ii].LastVtx);
  end;

  BlockWrite(f, MOX.MoxMat, 336*MOX.Header.MatCount);   //4+332

  for ii:=1 to MOX.Header.PartCount do
  begin
    s:=chr2(MOX.Parts[ii].Dname,64);
    BlockWrite(f,s[1],64);
    BlockWrite(f,MOX.Parts[ii].Matrix,132);
  end;

  //todo: It is worth writing more important blinkers first (deprioritize LED decoys),
  // since the game has a limit on how many blinkers it can show at once (384)
  for ii:=1 to MOX.Header.BlinkerCount do //Write blinkers in order
   BlockWrite(f, MOX.Blinkers[ii], 88);

  closefile(f);
  meLog.Lines.Add('MOX file closed');
  for i:=1 to MOX.Header.PartCount do
  begin
    PartModify[i].Custom[1]:=0;
    PartModify[i].Custom[2]:=0;
    PartModify[i].Custom[3]:=0;
    PartModify[i].Move[1]:=0;
    PartModify[i].Move[2]:=0;
    PartModify[i].Move[3]:=0;
  end;

  CompileLoadedMOX; // To make sure it looks just right
end;


procedure TForm1.MatTexReloadClick(Sender: TObject);
begin
  if MatID=0 then Exit;
  LoadTextures; //tweak
end;


procedure TForm1.PartTypeChange(Sender: TObject);
begin
  if (TVParts.Selected=nil)or(ForbidPartsChange) then Exit;
  if LX1.Value>LX2.Value then
  if Sender=LX1 then LX2.Value:=LX1.Value else LX1.Value:=LX2.Value;

  if LY1.Value>LY2.Value then
  if Sender=LY1 then LY2.Value:=LY1.Value else LY1.Value:=LY2.Value;
  if LZ1.Value>LZ2.Value then
  if Sender=LZ1 then LZ2.Value:=LZ1.Value else LZ1.Value:=LZ2.Value;
  SelectedTreeNode := TVParts.Selected.AbsoluteIndex+1;
  MOX.Parts[SelectedTreeNode].Dname:=EDetailName.Text;
  MOX.Parts[SelectedTreeNode].xMid:=CX.Value;
  MOX.Parts[SelectedTreeNode].yMid:=CY.Value;
  MOX.Parts[SelectedTreeNode].zMid:=CZ.Value;
  MOX.Parts[SelectedTreeNode].fRadius:=CRad.Value;
  MOX.Parts[SelectedTreeNode].w1:=0;//SpinEdit5.Value;
  MOX.Parts[SelectedTreeNode].w2:=0;//SpinEdit6.Value;
  MOX.Parts[SelectedTreeNode].w3:=0;//SpinEdit7.Value;
  MOX.Parts[SelectedTreeNode].w4:=0;//SpinEdit8.Value;
  MOX.Parts[SelectedTreeNode].w5:=0;//SpinEdit9.Value;
  MOX.Parts[SelectedTreeNode].TypeID := RGDetailType.ItemIndex;
  MOX.Parts[SelectedTreeNode].x1:=LX1.Value/180*pi;//-YZ rotation
  MOX.Parts[SelectedTreeNode].x2:=LX2.Value/180*pi;//-YZ rotation
  MOX.Parts[SelectedTreeNode].y1:=LY1.Value/180*pi;//-YZ rotation
  MOX.Parts[SelectedTreeNode].y2:=LY2.Value/180*pi;//-YZ rotation
  MOX.Parts[SelectedTreeNode].z1:=LZ1.Value/180*pi;//-YZ rotation
  MOX.Parts[SelectedTreeNode].z2:=LZ2.Value/180*pi;//-YZ rotation
  TVParts.Items[SelectedTreeNode-1].Text:=MOX.Parts[SelectedTreeNode].Dname;
end;


procedure TForm1.UpdateOpenedFileInfo(const aFilename: string);
begin
  fOpenedFileMask := decs(aFilename, 4, 0);
  fOpenedFolder := ExtractFileDir(fOpenedFileMask);
  if fOpenedFolder = '' then
    fOpenedFolder := ExeDir;

  Form1.Caption := 'MTKit2 - ' + ExtractFileName(fOpenedFileMask);
  Application.Title := 'MTKit2 - ' + ExtractFileName(fOpenedFileMask);
end;


procedure TForm1.ConverseImp_MOX;
var
  h,i,j,k,m,t:Integer;
  VqtyAtSurf,PqtyAtSurf: array of array of Integer;
  altpoint: array of array of array of array[1..3] of Integer; found: Boolean; //MOX.Parts,materials,points
  altpoly: array of array of array of Integer;                                //MOX.Parts,materials,points
  v2: array of array of array of array[1..3] of Integer;
  PolyPerMaterial: array [1..512] of Integer;
  MakeDefaultPart: Boolean;
  sprite: array [1..MAX_MOX_VTX]of Boolean;
begin
  Shape2.Width:=32;

  FillChar(MOX,SizeOf(MOX),#0);

  MOX.Header.PartCount:=Imp.PartCount;
  MOX.Header.MatCount:=Imp.SurfCount;

  TVParts.ReadOnly := False;
  FillChar(PartModify,SizeOf(PartModify),#0);

  RGPivotClick(nil);

  //Convert all unused vertices into blinkers later
  for i:=1 to Imp.VerticeCount do sprite[i] := True;
  for i:=1 to Imp.PolyCount do begin
    sprite[Imp.Faces[i,1]] := False;
    sprite[Imp.Faces[i,2]] := False;
    sprite[Imp.Faces[i,3]] := False;
  end;

  MakeDefaultPart := False;
  for i:=1 to Imp.PolyCount do
  if Imp.Part[i]=0 then MakeDefaultPart := True;

  if MakeDefaultPart then begin //insert part for default
    for i:=MAX_PARTS-1 downto 1 do Imp.PartName[i+1]:=Imp.PartName[i];
    Imp.PartName[1]:='Default(Body)';
    for i:=1 to Imp.PolyCount do inc(Imp.Part[i]); //set part #1
    inc(MOX.Header.PartCount);
  end;

  MOX.Header.BlinkerCount := 0;
  for i:=1 to Imp.VerticeCount do
    if sprite[i] and (MOX.Header.BlinkerCount < MAX_BLINKERS) then
    begin
      Inc(MOX.Header.BlinkerCount);                                 //63+1=64
      with MOX.Blinkers[MOX.Header.BlinkerCount] do
      begin //0..63
        BlinkerType := 2;
        Matrix[1,1]:=1; Matrix[1,2]:=0; Matrix[1,3]:=0; Matrix[1,4]:=0;
        Matrix[2,1]:=0; Matrix[2,2]:=1; Matrix[2,3]:=0; Matrix[2,4]:=0;
        Matrix[3,1]:=0; Matrix[3,2]:=0; Matrix[3,3]:=1; Matrix[3,4]:=0;
        Matrix[4,1]:=Imp.XYZ[i].X;
        Matrix[4,2]:=Imp.XYZ[i].Y;
        Matrix[4,3]:=Imp.XYZ[i].Z;
        Matrix[4,4]:=1;
        sMin:=1;
        sMax:=1;
        Freq:=0;
        B:=255;
        G:=64;
        R:=0;
        A:=255;
      end;
    end;
  SendDataToUI(uiBlinkers);
  btnBlinkersLoad.Enabled := True;
  btnBlinkersSave.Enabled := True;

  for i:=1 to Imp.PolyCount do
    for h:=1 to 3 do begin //Remapping UVs to DUVs
      if Imp.duv[i,h].u=123456 then Imp.duv[i,h].u:=Imp.UV[Imp.Faces[i,h]].U; //
      if Imp.duv[i,h].v=123456 then Imp.duv[i,h].v:=Imp.UV[Imp.Faces[i,h]].V;
    end;

  ////////////////////////////////////////////////////////////////////////////////
  //Splitting                                                                   //
  ////////////////////////////////////////////////////////////////////////////////

  setlength(altpoint,MOX.Header.PartCount+1);
  setlength(altpoly,MOX.Header.PartCount+1);
  setlength(VqtyAtSurf,MOX.Header.PartCount+1);
  setlength(PqtyAtSurf,MOX.Header.PartCount+1);
  setlength(v2,MOX.Header.PartCount+1);
  for i:=1 to MOX.Header.PartCount do
  begin
    setlength(altpoint[i],MOX.Header.MatCount+1);
    setlength(altpoly[i],MOX.Header.MatCount+1);
    setlength(VqtyAtSurf[i],MOX.Header.MatCount+1);
    setlength(PqtyAtSurf[i],MOX.Header.MatCount+1);
    setlength(v2[i],MOX.Header.MatCount+1);
  end;

  for m:=1 to MOX.Header.PartCount do
  for i:=1 to Imp.PolyCount do
    if Imp.Part[i]=m then //for all polys belong to current part
    begin
      if i mod 1000 = 0 then
      begin
        Shape2.Width:=round((i/Imp.PolyCount)*100);
        Label35.Caption:=IntToStr(round((i/Imp.PolyCount)*100))+' %';
        Label35.Repaint;
      end;

      for h:=1 to 3 do  //point-by-point
      begin
        found := False; //"match found" marker
        for k:=PqtyAtSurf[m,Imp.Surf[i]] downto 1 do
        begin
          //not to compare with self but all others of same surface
          //reverse direction saves 40-80%
          for j:=1 to 3 do //scan all previous points of polys
            if (altpoint[m,Imp.Surf[i],v2[m,Imp.Surf[i],k,j],1]=Imp.Faces[i,h])and  //original points match
            (Imp.Part[altpoly[m,Imp.Surf[i],k]]=Imp.Part[i])and                                //part tag
            (Imp.duv[altpoly[m,Imp.Surf[i],k],j].u=Imp.duv[i,h].u)and         //UVs
            (Imp.duv[altpoly[m,Imp.Surf[i],k],j].v=Imp.duv[i,h].v) then  //UVs
            begin
              if length(v2[m,Imp.Surf[i]])-1<=PqtyAtSurf[m,Imp.Surf[i]] then
                setlength(v2[m,Imp.Surf[i]],PqtyAtSurf[m,Imp.Surf[i]]+100);

              v2[m,Imp.Surf[i],PqtyAtSurf[m,Imp.Surf[i]]+1,h]:=v2[m,Imp.Surf[i],k,j]; //make V2 use it
              found := True;
            end;
            if found then break; //5% save
        end;

        if not found then
        begin
          inc(VqtyAtSurf[m,Imp.Surf[i]]);
          if length(altpoint[m,Imp.Surf[i]])<=VqtyAtSurf[m,Imp.Surf[i]] then
          setlength(altpoint[m,Imp.Surf[i]],VqtyAtSurf[m,Imp.Surf[i]]+100);
          if length(v2[m,Imp.Surf[i]])-1<=PqtyAtSurf[m,Imp.Surf[i]] then
          setlength(v2[m,Imp.Surf[i]],PqtyAtSurf[m,Imp.Surf[i]]+100);

          altpoint[m,Imp.Surf[i],VqtyAtSurf[m,Imp.Surf[i]],1]:=Imp.Faces[i,h];      //reference point
          altpoint[m,Imp.Surf[i],VqtyAtSurf[m,Imp.Surf[i]],2]:=h;                   //DUV point
          altpoint[m,Imp.Surf[i],VqtyAtSurf[m,Imp.Surf[i]],3]:=i;                   //parent poly
          v2[m,Imp.Surf[i],PqtyAtSurf[m,Imp.Surf[i]]+1,h]:=VqtyAtSurf[m,Imp.Surf[i]];
        end;

        if h=3 then
        begin
          inc(PqtyAtSurf[m,Imp.Surf[i]]);
          if length(altpoly[m,Imp.Surf[i]])<=PqtyAtSurf[m,Imp.Surf[i]] then
            setlength(altpoly[m,Imp.Surf[i]],PqtyAtSurf[m,Imp.Surf[i]]+100);
          altpoly[m,Imp.Surf[i],PqtyAtSurf[m,Imp.Surf[i]]]:=i;
        end;
      end;
    end;
  Shape2.Width:=100;

  h:=1;
  for m:=1 to MOX.Header.PartCount do
  begin
    t:=1;
    for i:=1 to MOX.Header.MatCount do
      for k:=1 to VqtyAtSurf[m,i] do
      begin
        MOX.Vertice[h].X:=Imp.XYZ[altpoint[m,i,k,1]].X;
        MOX.Vertice[h].Y:=Imp.XYZ[altpoint[m,i,k,1]].Y;
        MOX.Vertice[h].Z:=Imp.XYZ[altpoint[m,i,k,1]].Z;
        MOX.Vertice[h].nX:=Imp.Nv[altpoint[m,i,k,1]].X;
        MOX.Vertice[h].nY:=Imp.Nv[altpoint[m,i,k,1]].Y;
        MOX.Vertice[h].nZ:=Imp.Nv[altpoint[m,i,k,1]].Z;
        MOX.Vertice[h].U:=Imp.DUV[altpoint[m,i,k,3],altpoint[m,i,k,2]].U;
        MOX.Vertice[h].V:=1-Imp.DUV[altpoint[m,i,k,3],altpoint[m,i,k,2]].V;
        MOX.Header.VerticeCount:=h;

          if (t=1) then begin //Take 1st point of material as beginning for bounds checking
          t:=0;
          PartModify[m].Low[1]:=MOX.Vertice[h].X;
          PartModify[m].Low[2]:=MOX.Vertice[h].Y;
          PartModify[m].Low[3]:=MOX.Vertice[h].Z;
          PartModify[m].High[1]:=MOX.Vertice[h].X;
          PartModify[m].High[2]:=MOX.Vertice[h].Y;
          PartModify[m].High[3]:=MOX.Vertice[h].Z;
          end;

        PartModify[m].Low[1]:=min(PartModify[m].Low[1],MOX.Vertice[h].X);
        PartModify[m].Low[2]:=min(PartModify[m].Low[2],MOX.Vertice[h].Y);
        PartModify[m].Low[3]:=min(PartModify[m].Low[3],MOX.Vertice[h].Z);
        PartModify[m].High[1]:=max(PartModify[m].High[1],MOX.Vertice[h].X);
        PartModify[m].High[2]:=max(PartModify[m].High[2],MOX.Vertice[h].Y);
        PartModify[m].High[3]:=max(PartModify[m].High[3],MOX.Vertice[h].Z);

        inc(h);
      end;
  end;

  FillChar(MOX.Chunks,SizeOf(MOX.Chunks),#0);
  FillChar(MOX.Parts,SizeOf(MOX.Parts),#0);

  SetLength(MOX.Chunks, MOX.Header.PartCount * MOX.Header.MatCount + 1);
  h:=1;
  for m:=1 to MOX.Header.PartCount do
  for i:=1 to MOX.Header.MatCount do
  begin
    if h > 1 then
      MOX.Chunks[h].FirstVtx := MOX.Chunks[h-1].LastVtx+1
    else
      MOX.Chunks[h].FirstVtx := 1;

    MOX.Chunks[h].LastVtx:=MOX.Chunks[h].FirstVtx+VqtyAtSurf[m,i]-1;
    MOX.Header.ChunkCount := h;
    inc(h);
  end;
  SetLength(MOX.Chunks, MOX.Header.ChunkCount + 1);

  j:=1; t:=1;
  for m:=1 to MOX.Header.PartCount do
    for i:=1 to MOX.Header.MatCount do
    begin
      for k:=1 to PqtyAtSurf[m,i] do
      begin
        for h:=1 to 3 do MOX.Face[j,h]:=v2[m,i,k,h]+MOX.Chunks[t].FirstVtx-1;
        inc(j);
      end;
    inc(t);
    end;

  h:=1;
  for m:=1 to MOX.Header.PartCount do
  begin
    MOX.Parts[m].NumMat:=0;
    for i:=1 to MOX.Header.MatCount do
    begin
      MOX.Chunks[h].PolyCount:=PqtyAtSurf[m,i];
      if h>1 then MOX.Chunks[h].FirstPoly:=MOX.Chunks[h-1].FirstPoly+MOX.Chunks[h-1].PolyCount else MOX.Chunks[h].FirstPoly:=0;
      MOX.Header.PolyCount := MOX.Chunks[h].FirstPoly+MOX.Chunks[h].PolyCount;
      inc(MOX.Parts[m].NumMat);
      inc(h);
    end;
  end;

  for i:=1 to MOX.Header.MatCount do
  begin
    Material[i].Mtag:=inttohex((i-1),4);
    Material[i].Title:=Imp.Mtl[i].Title;
    if Imp.Mtl[i].TexName<>'' then Material[i].MatClass[2]:=3; //Make texture visible if there's one
    Material[i].Color[1].Amb.R:=Imp.Mtl[i].Amb.R;
    Material[i].Color[1].Amb.G:=Imp.Mtl[i].Amb.G;
    Material[i].Color[1].Amb.B:=Imp.Mtl[i].Amb.B;
    Material[i].Color[1].Dif.R:=Imp.Mtl[i].Dif.R;
    Material[i].Color[1].Dif.G:=Imp.Mtl[i].Dif.G;
    Material[i].Color[1].Dif.B:=Imp.Mtl[i].Dif.B;
    Material[i].Color[1].Sp1.R:=Imp.Mtl[i].Spec.R;
    Material[i].Color[1].Sp1.G:=Imp.Mtl[i].Spec.G;
    Material[i].Color[1].Sp1.B:=Imp.Mtl[i].Spec.B;
    Material[i].Color[1].Ref.R:=Imp.Mtl[i].Reflect;
    Material[i].Color[1].Ref.G:=Imp.Mtl[i].Reflect;
    Material[i].Color[1].Ref.B:=Imp.Mtl[i].Reflect;
    Material[i].Transparency:=Imp.Mtl[i].Transparency;
    Material[i].TexEdge.U:=1;
    Material[i].TexEdge.V:=1;
    Material[i].TexName:=Imp.Mtl[i].TexName;
  end;

  NumColors:=MAX_COLORS;

  for i:=1 to MOX.Header.MatCount do for k:=2 to MAX_COLORS do
  Material[i].Color[k]:=Material[i].Color[1]; //Set all colors same
  LoadTextures;

  h:=1;
  for m:=1 to MOX.Header.PartCount do
    for i:=1 to MOX.Header.MatCount do
    begin
      MOX.Chunks[h].SidA:=i-1;
      MOX.Chunks[h].SidB:=i-1;
      inc(h);
    end;

  for i:=1 to MOX.Header.MatCount do
  begin
    MOX.MoxMat[i].ID:=i-1;
    for k:=1 to 332 do MOX.MoxMat[i].xxx[k]:=#0;
  end;

  for i:=1 to MOX.Header.PartCount do
  begin
    MOX.Parts[i].Dname:=Imp.PartName[i];
    MOX.Parts[i].Matrix[1,1]:=1;
    MOX.Parts[i].Matrix[2,2]:=1;
    MOX.Parts[i].Matrix[3,3]:=1;
    MOX.Parts[i].Matrix[4,4]:=1;
    MOX.Parts[i].Parent:=-1;
    MOX.Parts[i].Child:=-1;
    MOX.Parts[i].PrevInLevel:=-1;
    MOX.Parts[i].NextInLevel:=-1;
    //MOX.Parts[i].NumMat:=
    MOX.Parts[i+1].FirstMat:=MOX.Parts[i].FirstMat+MOX.Parts[i].NumMat;

    MOX.Parts[i].xMid:=PartModify[i].Low[1]+(PartModify[i].High[1]-PartModify[i].Low[1])/2;
    MOX.Parts[i].yMid:=PartModify[i].Low[2]+(PartModify[i].High[2]-PartModify[i].Low[2])/2;
    MOX.Parts[i].zMid:=PartModify[i].Low[3]+(PartModify[i].High[3]-PartModify[i].Low[3])/2;
    MOX.Parts[i].fRadius:=(PartModify[i].High[1]-PartModify[i].Low[1])/3+
                        (PartModify[i].High[2]-PartModify[i].Low[2])/3+
                        (PartModify[i].High[3]-PartModify[i].Low[3])/3;
  end;

  setlength(altpoint,0); //Clear arrays entirely to avoid mismatch errors
  setlength(altpoly,0);
  setlength(v2,0);

  CompileLoadedMOX;

  Label35.Caption := Floattostr(round((GetTickCount-OldTimeLWO)/100)/10)+' s';

  ShowUpClick(cuMOX);
  ShowUpClick(cuMTL);
  SetRenderObject([roMOX]);
  SetActivePage(apMTL);

  SaveMOX1.Enabled := True;

  IsLightwave2MOX := True;
  PivotSetup.TabVisible := True;
end;


procedure TForm1.MatTexBrowseClick(Sender: TObject);
begin
  if MatID = 0 then Exit;
  if not RunOpenDialog(odOpen, '', fOpenedFolder, 'Targa, PTX image files (*.ptx; *.tga)|*.tga;*.ptx') then Exit;

  edMaterialTextureFile.Text := ExtractFileName(odOpen.FileName);
  MatTexReloadClick(nil);
end;


procedure TForm1.BlinkPositionChange(Sender: TObject);
var
  idx: Integer;
begin
  idx := LBBlinkers.ItemIndex+1;
  if idx = 0 then Exit;
  if fUIRefresh then Exit;

  MOX.Blinkers[idx].Matrix[4,1] := fsBlinkerX.Value*10;
  MOX.Blinkers[idx].Matrix[4,2] := fsBlinkerY.Value*10;
  MOX.Blinkers[idx].Matrix[4,3] := fsBlinkerZ.Value*10;
  Angles2Matrix(fsBlinkerH.Value, fsBlinkerP.Value, fsBlinkerB.Value, @MOX.Blinkers[idx].Matrix, 16);
end;


procedure TForm1.btnBlinkerAddClick(Sender: TObject);
begin
  BlinkerAdd(LBBlinkers.ItemIndex+1);

  SendDataToUI(uiBlinkers);
end;


procedure TForm1.BlinkerAdd(aIndex: Integer);
begin
  if MOX.Header.BlinkerCount >= MAX_BLINKERS then Exit;

  Inc(MOX.Header.BlinkerCount);

  if InRange(aIndex, 1, MOX.Header.BlinkerCount) then
    // Duplicate existing
    MOX.Blinkers[MOX.Header.BlinkerCount] := MOX.Blinkers[aIndex]
  else
  begin
    // Create new
    MOX.Blinkers[MOX.Header.BlinkerCount].BlinkerType := 0;
    MOX.Blinkers[MOX.Header.BlinkerCount].sMin := 0;
    MOX.Blinkers[MOX.Header.BlinkerCount].sMax := 1;
    MOX.Blinkers[MOX.Header.BlinkerCount].Freq := 0;
    MOX.Blinkers[MOX.Header.BlinkerCount].B := 255;
    MOX.Blinkers[MOX.Header.BlinkerCount].G := 64;
    MOX.Blinkers[MOX.Header.BlinkerCount].R := 0;
    MOX.Blinkers[MOX.Header.BlinkerCount].A := 255;
    MOX.Blinkers[MOX.Header.BlinkerCount].Unused := 0;
    MOX.Blinkers[MOX.Header.BlinkerCount].Parent := 0;
    FillChar(MOX.Blinkers[MOX.Header.BlinkerCount].Matrix, SizeOf(MOX.Blinkers[MOX.Header.BlinkerCount].Matrix), #0);
    MOX.Blinkers[MOX.Header.BlinkerCount].Matrix[1, 1] := 1;
    MOX.Blinkers[MOX.Header.BlinkerCount].Matrix[2, 2] := 1;
    MOX.Blinkers[MOX.Header.BlinkerCount].Matrix[3, 3] := 1;
    MOX.Blinkers[MOX.Header.BlinkerCount].Matrix[4, 4] := 1;
  end;
end;


procedure TForm1.btnBlinkerRemClick(Sender: TObject);
begin
  if LBBlinkers.ItemIndex = -1 then Exit;

  BlinkerRemove(LBBlinkers.ItemIndex + 1);

  if LBBlinkers.ItemIndex = -1 then
    LBBlinkers.ItemIndex := LBBlinkers.Count - 1;

  SendDataToUI(uiBlinkers);
  LBBlinkersClick(nil);
end;


procedure TForm1.BlinkerRemove(aIndex: Integer);
var
  I: Integer;
begin
  for I := aIndex to MOX.Header.BlinkerCount - 1 do
    MOX.Blinkers[I] := MOX.Blinkers[I + 1];

  Dec(MOX.Header.BlinkerCount);
end;


procedure TForm1.BlinkCopyClick(Sender: TObject);
begin
  fLightCopyID := LBBlinkers.ItemIndex + 1;
  btnBlinkerPaste.Enabled := InRange(fLightCopyID, 1, MOX.Header.BlinkerCount);
end;


procedure TForm1.BlinkPasteClick(Sender: TObject);
var
  idx: Integer;
begin
  idx := LBBlinkers.ItemIndex+1;
  if idx = 0 then Exit;

  if not InRange(fLightCopyID, 1, MOX.Header.BlinkerCount) then
  begin
    btnBlinkerPaste.Enabled := False;
    Exit;
  end;

  MOX.Blinkers[idx] := MOX.Blinkers[fLightCopyID];

  SendDataToUI(uiBlinkers);
  LBBlinkersClick(nil);
end;


procedure TForm1.btnBlinkersLoadClick(Sender: TObject);
begin
  if not RunOpenDialog(odOpen, '', '', 'MTKit2 Lights Setup Files (*.lsf)|*.lsf') then Exit;

  LoadBlinkers(odOpen.FileName);
  SendDataToUI(uiBlinkers);
  btnBlinkerPaste.Enabled := False;
end;


procedure TForm1.btnBlinkersSaveClick(Sender: TObject);
begin
  if not RunSaveDialog(sdSave, fOpenedFileMask + '.lsf', '', 'MTKit2 Lights Setup Files (*.lsf)|*.lsf', 'lsf') then Exit;

  SaveBlinkers(sdSave.FileName);
end;


procedure TForm1.About1Click(Sender: TObject);
var
  glslVersion: string;
  vfl: Integer;
begin
  // Newer versions return string
  glslVersion := glGetString(GL_SHADING_LANGUAGE_VERSION);
  glGetIntegerv(GL_MAX_VARYING_FLOATS_ARB, @vfl);

  MessageBox(
    Handle,
    PChar(
      APP_TITLE + '    ' + VER_INFO + eol + eol +
      'using OpenGL ' + glGetString(GL_VERSION) + ' by ' + glGetString(GL_RENDERER) + eol +
      'using GLSL version ' + glslVersion + ' with max floats ' + IntToStr(vfl) + eol + eol +
      'Written by Krom - kromster80@gmail.com' + eol +
      'Site - http://krom.reveur.de'),
    'Info',
    MB_OK or MB_ICONINFORMATION);
end;


procedure TForm1.tvPartsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if (TVParts.GetNodeAt(X, Y) = TVParts.TopItem) and (TVParts.TopItem <> TVParts.Items[0]) then
    TVParts.TopItem := TVParts.Items[TVParts.GetNodeAt(X,Y).AbsoluteIndex-1];

  Accept := IsLightwave2MOX;
end;


procedure TForm1.tvPartsDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  TVParts.Selected.MoveTo(TVParts.GetNodeAt(X,Y), naAddChild); // First?

  RebuildPartsTree;
  ExchangePartsOrdering;

  SelectedTreeNode := TVParts.Selected.AbsoluteIndex+1;
end;


procedure TForm1.ExchangePartsOrdering;
var
  I,j,K: Integer;
  accPoly, accVert: Integer;
  iDest, iSrc: Integer;
  order: array of Integer;
  aDname: array [1..MAX_PARTS] of string;
  aPartModify: array [1..MAX_PARTS] of record ActualPoint:Integer; AxisSetup: array [1..3]of Byte; Low: array [1..3]of Single; High: array [1..3]of Single; Custom: array [1..3]of Single; Move: array [1..3]of Single; end;
  aParts: array [1..MAX_PARTS] of record xMid,yMid,zMid,fRadius:Single; TypeID:smallint; x1,x2,y1,y2,z1,z2:Single; end;
  exChunk: array of TMOXChunk;
  exVertice: array of record X,Y,Z,nX,nY,nZ,U,V,x1,x2: Single; end; //40Bytes
  exPolys: array of array [1..3] of Integer;
begin
  SetLength(order, MOX.Header.PartCount + 1);
  for I := 1 to MOX.Header.PartCount do
    for K := 1 to MOX.Header.PartCount do
      if MOX.Parts[I].Dname = TVParts.Items[K - 1].Text then
        order[K] := I;

  SetLength(exVertice, MOX.Header.VerticeCount + 1);
  SetLength(exPolys, MOX.Header.PolyCount + 1);
  SetLength(exChunk, MOX.Header.MatCount * MOX.Header.PartCount + 1);

  accPoly := 0; accVert := 0;
  for I := 1 to MOX.Header.PartCount do
  begin
    aDname[i] := MOX.Parts[order[i]].Dname;
    aParts[i].xMid := MOX.Parts[order[i]].xMid;
    aParts[i].yMid := MOX.Parts[order[i]].yMid;
    aParts[i].zMid := MOX.Parts[order[i]].zMid;
    aParts[i].fRadius := MOX.Parts[order[i]].fRadius;
    aParts[i].TypeID := MOX.Parts[order[i]].TypeID;
    aParts[i].x1 := MOX.Parts[order[i]].x1;
    aParts[i].x2 := MOX.Parts[order[i]].x2;
    aParts[i].y1 := MOX.Parts[order[i]].y1;
    aParts[i].y2 := MOX.Parts[order[i]].y2;
    aParts[i].z1 := MOX.Parts[order[i]].z1;
    aParts[i].z2 := MOX.Parts[order[i]].z2;
    CopyMemory(@aPartModify[I], @PartModify[order[I]], 56); //55+1 !

    for K := 1 to MOX.Header.MatCount do
    begin
      iDest := (I - 1) * MOX.header.MatCount + K; // destination
      iSrc := (order[I] - 1) * MOX.header.MatCount + K; // source

      exChunk[iDest].FirstPoly := accPoly;                                   //first poly
      exChunk[iDest].PolyCount := MOX.Chunks[iSrc].PolyCount;             //poly count
      Inc(accPoly, MOX.Chunks[iSrc].PolyCount);
      exChunk[iDest].FirstVtx := accVert+1;                                 //first point
      Inc(accVert, MOX.Chunks[iSrc].LastVtx - MOX.Chunks[iSrc].FirstVtx + 1);
      exChunk[iDest].LastVtx := accVert;                                   //last point

      for J := exChunk[iDest].FirstVtx to exChunk[iDest].LastVtx do
        CopyMemory(@exVertice[J], @MOX.Vertice[MOX.Chunks[iSrc].FirstVtx+(J-exChunk[iDest].FirstVtx)], 40);

      for J:=1 to exChunk[iDest].PolyCount do
      begin
        exPolys[exChunk[iDest].FirstPoly+J,1]:=MOX.Face[MOX.Chunks[iSrc].FirstPoly+J,1]+exChunk[iDest].FirstVtx-MOX.Chunks[iSrc].FirstVtx;
        exPolys[exChunk[iDest].FirstPoly+J,2]:=MOX.Face[MOX.Chunks[iSrc].FirstPoly+J,2]+exChunk[iDest].FirstVtx-MOX.Chunks[iSrc].FirstVtx;
        exPolys[exChunk[iDest].FirstPoly+J,3]:=MOX.Face[MOX.Chunks[iSrc].FirstPoly+J,3]+exChunk[iDest].FirstVtx-MOX.Chunks[iSrc].FirstVtx;
      end;
    end;
  end;


  CopyMemory(@PartModify, @aPartModify, Length(PartModify) * 56); //55+1 !
  CopyMemory(@MOX.Vertice[1], @exVertice[1], MOX.Header.VerticeCount * SizeOf(MOX.Vertice[1]));//XYZXYZUV00 of Single
  CopyMemory(@MOX.Face[1], @exPolys[1], MOX.Header.PolyCount * SizeOf(MOX.Face[1]));                //1..3 of Word

  for I:=1 to MOX.Header.ChunkCount do
  begin
    MOX.Chunks[I].FirstPoly := exChunk[I].FirstPoly;
    MOX.Chunks[I].PolyCount := exChunk[I].PolyCount;
    MOX.Chunks[I].FirstVtx := exChunk[I].FirstVtx;
    MOX.Chunks[I].LastVtx := exChunk[I].LastVtx;
  end;

  for I:=1 to MOX.Header.PartCount do
  begin
    MOX.Parts[I].Dname:=aDname[I];
    MOX.Parts[I].xMid:=aParts[I].xMid;
    MOX.Parts[I].yMid:=aParts[I].yMid;
    MOX.Parts[I].zMid:=aParts[I].zMid;
    MOX.Parts[I].fRadius:=aParts[I].fRadius;
    MOX.Parts[I].TypeID:=aParts[I].TypeID;
    MOX.Parts[I].x1:=aParts[I].x1; MOX.Parts[I].x2:=aParts[I].x2;
    MOX.Parts[I].y1:=aParts[I].y1; MOX.Parts[I].y2:=aParts[I].y2;
    MOX.Parts[I].z1:=aParts[I].z1; MOX.Parts[I].z2:=aParts[I].z2;
  end;

  CompileLoadedMOX;
end;


procedure TForm1.RebuildPartsTree;
var
  I: Integer;
begin
  for I:=0 to TVParts.Items.Count-1 do
  begin
    if TVParts.Items[I].Level = 0 then
      MOX.Parts[I + 1].Parent := -1
    else // No parents
      MOX.Parts[I + 1].Parent := TVParts.Items[I].Parent.AbsoluteIndex;

    if not TVParts.Items[I].HasChildren then
      MOX.Parts[I + 1].Child := -1
    else // No childs
      MOX.Parts[I + 1].Child := TVParts.Items[I].AbsoluteIndex + 1;

    if TVParts.Items[I].getPrevSibling <> nil then
      MOX.Parts[I + 1].PrevInLevel := TVParts.Items[I].getPrevSibling.AbsoluteIndex
    else
      MOX.Parts[I + 1].PrevInLevel := -1;

    if TVParts.Items[I].getNextSibling <> nil then
      MOX.Parts[I + 1].NextInLevel := TVParts.Items[I].getNextSibling.AbsoluteIndex
    else
      MOX.Parts[I + 1].NextInLevel := -1;
  end;
end;


procedure TForm1.MatMonoColorClick(Sender: TObject);
begin
  if CBMonoColor.Checked then
  begin
    CBColor.ItemIndex:=0;
    NumColors:=1
  end else
  begin
    CBColor.ItemIndex:=DefColor;
    NumColors:=MAX_COLORS;
  end;

  CBColor.Enabled := not CBMonoColor.Checked;
  SetColorsToCurrent.Enabled:=not CBMonoColor.Checked;
  CBColorChange(nil);
end;


procedure TForm1.btnCOBVerticeCopyClick(Sender: TObject);
begin
  fCOBCopyItem := LBCOBPoints.ItemIndex;
  btnCOBVerticePaste.Enabled := InRange(fCOBCopyItem, 0, fCOB.Head.PointQty - 1);
end;


procedure TForm1.btnCOBVerticePasteClick(Sender: TObject);
var
  idx: Integer;
begin
  idx := LBCOBPoints.ItemIndex;
  if idx = -1 then Exit;

  if fCOBCopyItem <> EnsureRange(fCOBCopyItem, 0, fCOB.Head.PointQty - 1) then
  begin
    btnCOBVerticePaste.Enabled := False;
    Exit;
  end;

  fCOB.Vertices[idx] := fCOB.Vertices[fCOBCopyItem];

  fCOB.RebuildBounds;
  SendDataToUI(uiCOB);
end;


procedure TForm1.LBCOBPointsClick(Sender: TObject);
var
  idx: Integer;
begin
  idx := LBCOBPoints.ItemIndex;
  if idx = -1 then Exit;

  fUIRefresh := True;
  seCOBX.Value := fCOB.Vertices[idx].X;
  seCOBY.Value := fCOB.Vertices[idx].Y;
  seCOBZ.Value := fCOB.Vertices[idx].Z;
  fUIRefresh := False;
end;


procedure TForm1.seCOBXChange(Sender: TObject);
var
  idx: Integer;
begin
  idx := LBCOBPoints.ItemIndex;
  if idx = -1 then Exit;
  if fUIRefresh then Exit;

  fCOB.Vertices[idx].X := seCOBX.Value;
  fCOB.Vertices[idx].Y := seCOBY.Value;
  fCOB.Vertices[idx].Z := seCOBZ.Value;

  fCOB.RebuildBounds;
  SendDataToUI(uiCOB);
end;


procedure TForm1.MatCopyClick(Sender: TObject);
begin
  if MatID=0 then Exit;
  fColorCopyID := MatID;
  MatPaste.Enabled := True;
end;


procedure TForm1.MatPasteClick(Sender: TObject);
var
  i:Integer;
begin
  if fColorCopyID <> EnsureRange(fColorCopyID, 1, MOX.Header.MatCount) then
  begin
    MatPaste.Enabled := False;
    Exit;
  end;

  for i:=1 to MAX_COLORS do Material[MatID].Color[i]:=Material[fColorCopyID].Color[i];
  CBColorChange(nil);
end;


procedure TForm1.RGPivotClick(Sender: TObject);
begin
  if SelectedTreeNode = 0 then Exit;
  CustomPivotX.Enabled:=RGPivotX.ItemIndex=3;
  CustomPivotY.Enabled:=RGPivotY.ItemIndex=3;
  CustomPivotZ.Enabled:=RGPivotZ.ItemIndex=3;

  if ForbidPivotChange then Exit;

  with PartModify[SelectedTreeNode] do
  begin
    if Sender=CustomPivotX then
    begin
      RGPivotX.ItemIndex:=3;
      Custom[1]:=CustomPivotX.Value;
    end;
    if Sender=CustomPivotY then
    begin
      RGPivotY.ItemIndex:=3;
      Custom[2]:=CustomPivotY.Value;
    end;
    if Sender=CustomPivotZ then
    begin
      RGPivotZ.ItemIndex:=3;
      Custom[3]:=CustomPivotZ.Value;
    end;

    if RGPivotX.ItemIndex=0 then Move[1]:=Low[1];
    if RGPivotX.ItemIndex=1 then Move[1]:=(Low[1]+High[1])/2;
    if RGPivotX.ItemIndex=2 then Move[1]:=High[1];
    if RGPivotX.ItemIndex=3 then Move[1]:=Custom[1];

    if RGPivotY.ItemIndex=0 then Move[2]:=Low[2];
    if RGPivotY.ItemIndex=1 then Move[2]:=(Low[2]+High[2])/2;
    if RGPivotY.ItemIndex=2 then Move[2]:=High[2];
    if RGPivotY.ItemIndex=3 then Move[2]:=Custom[2];

    if RGPivotZ.ItemIndex=0 then Move[3]:=Low[3];
    if RGPivotZ.ItemIndex=1 then Move[3]:=(Low[3]+High[3])/2;
    if RGPivotZ.ItemIndex=2 then Move[3]:=High[3];
    if RGPivotZ.ItemIndex=3 then Move[3]:=Custom[3];

    AxisSetup[1]:=RGPivotX.ItemIndex;
    AxisSetup[2]:=RGPivotY.ItemIndex;
    AxisSetup[3]:=RGPivotZ.ItemIndex;
  end;
end;

procedure TForm1.btnPartPivotUseClick(Sender: TObject);
var
  idx: Integer;
begin
  if SelectedTreeNode = 0 then Exit;
  idx := PivotPointActual.Value;

  ForbidPivotChange := True;
  with PartModify[SelectedTreeNode] do
  begin
    Custom[1]:=MOX.Vertice[idx+MOX.Chunks[MOX.Parts[SelectedTreeNode].FirstMat+1].FirstVtx-1].X;
    Custom[2]:=MOX.Vertice[idx+MOX.Chunks[MOX.Parts[SelectedTreeNode].FirstMat+1].FirstVtx-1].Y;
    Custom[3]:=MOX.Vertice[idx+MOX.Chunks[MOX.Parts[SelectedTreeNode].FirstMat+1].FirstVtx-1].Z;
    CustomPivotX.Value:=Custom[1];
    CustomPivotY.Value:=Custom[2];
    CustomPivotZ.Value:=Custom[3];
    ActualPoint:=idx;
  end;
  ForbidPivotChange := False;
  RGPivotClick(nil);//force update
end;


procedure TForm1.btnPSFSaveClick(Sender: TObject);
begin
  if not RunSaveDialog(sdSave, fOpenedFileMask + '.psf', '', 'MTKit2 Pivot Setup Files (*.psf)|*.psf', 'psf') then Exit;
  meLog.Lines.Add('Assigning PSF file ...');
  SavePSF(sdSave.FileName);
  meLog.Lines.Add('PSF file closed');
end;


procedure TForm1.btnPSFLoadClick(Sender: TObject);
begin
  if TVParts.Items.Count<1 then Exit;
  //if Sender=PSFLoad then begin
  if not RunOpenDialog(odOpen,'','','MTKit2 Pivot Setup Files (*.psf)|*.psf') then Exit;
  meLog.Lines.Add('Reading PSF ...');
  if not LoadPSF(odOpen.FileName) then Exit;
  meLog.Lines.Add('PSF file closed');
end;


procedure TForm1.btnPBFSaveClick(Sender: TObject);
begin
  if not RunSaveDialog(sdSave, fOpenedFileMask + '_colli.pbf', '', 'MTKit2 Part Behaviour Files (*.pbf)|*.pbf', 'pbf') then Exit;
  meLog.Lines.Add('Assigning PBF file ...');
  SavePBF(sdSave.FileName);
  meLog.Lines.Add('PBF file closed');
end;


procedure TForm1.btnPBFLoadClick(Sender: TObject);
begin
  if not RunOpenDialog(odOpen, '', '', 'MTKit2 Part Behaviour Files (*.pbf)|*.pbf') then Exit;

  meLog.Lines.Add('Reading PBF ...');
  LoadPBF(odOpen.FileName);
  ExchangePartsOrdering;
  RebuildPartsTree;
  meLog.Lines.Add('PBF file processed and closed');
end;


procedure TForm1.CBActDamClick(Sender: TObject);
begin
  FlapParts.Enabled:=CBActDam.Checked;
  Label30.Enabled:=CBActDam.Checked;
  RenderOptions.ShowDamage:=CBActDam.Checked;
end;


procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  MaterialSetDefault;
end;


procedure TForm1.MaterialSetDefault;
var
  ii: Integer;
begin
  if MatID = 0 then Exit;

  for ii:=1 to MAX_COLORS do
    with Material[MatID].Color[ii] do
    begin
      Dif.R := DEFAULT_COLORS[ii, 1];
      Dif.G := DEFAULT_COLORS[ii, 2];
      Dif.B := DEFAULT_COLORS[ii, 3];
      Sp1.R := DEFAULT_SPEC[1];
      Sp1.G := DEFAULT_SPEC[2];
      Sp1.B := DEFAULT_SPEC[3];
      Sp2.R := DEFAULT_SPEC2[ii, 1];
      Sp2.G := DEFAULT_SPEC2[ii, 2];
      Sp2.B := DEFAULT_SPEC2[ii, 3];
      Amb.R := 0;
      Amb.G := 0;
      Amb.B := 0;
      Ref.R := DEFAULT_REFLECT[ii, 1];
      Ref.G := DEFAULT_REFLECT[ii, 2];
      Ref.B := DEFAULT_REFLECT[ii, 3];
    end;
  CBColorChange(nil);
end;


procedure TForm1.ResetMTLOrderClick(Sender: TObject);
var
  i:Integer;
begin
  for i:=1 to MOX.Header.MatCount do
    Material[i].Mtag:=IntToHex((i-1),4);
  SendDataToUI(uiMTL);
end;


procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  if TVParts.Selected = nil then Exit;

  SelectedTreeNode := TVParts.Selected.AbsoluteIndex + 1;
  with PartModify[SelectedTreeNode] do
  begin
    MOX.Parts[SelectedTreeNode].xMid := (High[1] + Low[1]) / 2;
    MOX.Parts[SelectedTreeNode].yMid := (High[2] + Low[2]) / 2;
    MOX.Parts[SelectedTreeNode].zMid := (High[3] + Low[3]) / 2;
    MOX.Parts[SelectedTreeNode].fRadius := (High[1] - Low[1]) / 3 + (High[2] - Low[2]) / 3 + (High[3] - Low[3]) / 3;
  end;
  CX.Value := MOX.Parts[SelectedTreeNode].xMid;
  CY.Value := MOX.Parts[SelectedTreeNode].yMid;
  CZ.Value := MOX.Parts[SelectedTreeNode].zMid;
  CRad.Value := MOX.Parts[SelectedTreeNode].fRadius;
end;


procedure TForm1.btnCOBRecomputeClick(Sender: TObject);
begin
  fCOB.RebuildBounds;
  SendDataToUI(uiCOB);
end;


procedure TForm1.FileListBox1Click(Sender: TObject);
begin
  FillChar(MOX.Header, SizeOf(MOX.Header), #0);
  fCOB.Clear;
  fTree.Clear;
  ResetView(nil);
  LoadFile(FileListBox1.FileName, lmJustLoad);
end;


procedure TForm1.LoadFile(const aFilename: string; aMode: TLoadMode);
begin
  if not FileExists(aFilename) then
  begin
    MessageBox(Handle, 'File not found', 'Error', MB_OK or MB_ICONERROR);
    Exit;
  end;

  UpdateOpenedFileInfo(aFilename);
  ClearUpClick(cuALL);

  if SameText(ExtractFileExt(aFilename), '.mox') then
  begin
    meLog.Lines.Add('Loading MOX ...');
    meLog.Lines.Add(aFilename);

    TVParts.ReadOnly := True;
    IsLightwave2MOX := False;
    PivotSetup.TabVisible := False;

    try
      LoadMOX(aFilename);
    except
      on E: Exception do
        MessageBox(0, PChar(E.Message), 'Error', MB_OK or MB_ICONERROR);
    end;

    meLog.Lines.Add('MOX file closed');

    ShowUpClick(cuMOX);

    CompileLoadedMOX;

    SaveMOX1.Enabled := True;
    ExportMOX1.Enabled := True;

    StatusBar1.Panels[0].Text := MOX.MOXFormatInt + ' - ' + MOX.MOXFormatStr;

    ShowUpClick(cuMOX);
    LoadMTL(ChangeFileExt(aFilename, '.mtl'));
    LoadTextures;
    ScanVinyls(fOpenedFolder);
    ShowUpClick(cuMTL);
    SetRenderObject([roMOX]);
    if fCOB.LoadCOB(ChangeFileExt(aFilename, '_colli.cob')) then
    begin
      ShowUpClick(cuCOB);
      SetRenderObject([roMOX, roCOB]);
    end;
    if LoadCPO(ChangeFileExt(aFilename, '_colli.cpo')) then
    begin
      ShowUpClick(cuCPO);
      SetRenderObject([roMOX, roCPO]);
    end;
    if LoadCPO(ChangeFileExt(aFilename, '.cpo')) then
    begin
      ShowUpClick(cuCPO);
      SetRenderObject([roMOX, roCPO]);
    end;
    if aMode = lmLoadAndShow then
      SetActivePage(apMTL);
  end;

  if SameText(ExtractFileExt(aFilename), '.cob') then
  begin
    if not fCOB.LoadCOB(aFilename) then Exit;
    ShowUpClick(cuCOB);
    SetRenderObject([roCOB]);
    if aMode = lmLoadAndShow then SetActivePage(apCOB);
  end;

  if SameText(ExtractFileExt(aFilename), '.cpo') then
    if LoadCPO(aFilename) then
    begin
      SetRenderObject([roCPO]);
      ShowUpClick(cuCPO);
      if aMode = lmLoadAndShow then SetActivePage(apCPO);
    end;

  if SameText(ExtractFileExt(aFilename), '.tree') then
  begin
    fTree.LoadFromFile(aFilename);
    fTree.PrepareDisplayList;
    fTree.PrepareTextures(fOpenedFolder);
    ShowUpClick(cuTREE);
    meLog.Lines.Add('TREE Loaded ...');
    SetRenderObject([roTREE]);
  end;
end;


procedure TForm1.PageControl1Change(Sender: TObject);
begin
  SelectedTreeNode := 0;
  ActivePage := TActivePage(PageControl1.TabIndex);
end;


procedure TForm1.SetActivePage(aPage: TActivePage);
begin
  ActivePage := aPage;
  PageControl1.ActivePageIndex := Ord(ActivePage);
end;


procedure TForm1.SetRenderObject(aSet: TRenderObjectSet);
begin
  fRenderObjects := aSet;
end;


procedure TForm1.ResetView(Sender: TObject);
begin
  xMov := 0;
  yMov := 0;
  XRot := -30;
  YRot := 20;
  zoom := 0.3125;
end;


procedure TForm1.CBRenderModeChange(Sender: TObject);
begin
  if not fUseShaders then
    CBRenderMode.ItemIndex := 0;

  fRenderMode := TRenderMode(CBRenderMode.ItemIndex);
end;


procedure TForm1.ShapeAMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  tgtColor: PCardinal;
  originalColor: Cardinal;
begin
  if MatID = 0 then Exit;
  if ColID = 0 then Exit;

  if Sender = ShapeA then tgtColor := @Material[MatID].Color[ColID].Amb;
  if Sender = ShapeD then tgtColor := @Material[MatID].Color[ColID].Dif;
  if Sender = ShapeS1 then tgtColor := @Material[MatID].Color[ColID].Sp1;
  if Sender = ShapeS2 then tgtColor := @Material[MatID].Color[ColID].Sp2;
  if Sender = ShapeR then tgtColor := @Material[MatID].Color[ColID].Ref;

  originalColor := tgtColor^;

  TForm_ColorPicker2.Execute(
    originalColor,
    procedure(aColor: Cardinal)
    begin
      // Live preview
      tgtColor^ := aColor;
      TShape(Sender).Brush.Color := aColor;

      Render;
    end,
    nil,
    procedure
    begin
      // Cancel - restore original color
      tgtColor^ := originalColor;
      TShape(Sender).Brush.Color := originalColor;
    end);
end;


procedure TForm1.ShapeBGMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  tgtColor: PCardinal;
  originalColor: Cardinal;
begin
  if Sender = ShapeBG then tgtColor := @fColorBackground;
  if Sender = ShapeWF then tgtColor := @fColorWireframe;

  originalColor := tgtColor^;

  TForm_ColorPicker2.Execute(
    originalColor,
    procedure(aColor: Cardinal)
    begin
      // Live preview
      tgtColor^ := aColor;
      TShape(Sender).Brush.Color := aColor;

      Render;
    end,
    nil,
    procedure
    begin
      // Cancel - restore original color
      tgtColor^ := originalColor;
      TShape(Sender).Brush.Color := originalColor;
    end);
end;


procedure TForm1.FPSLimitEditChange(Sender: TObject);
begin
  FPSLag := max(1, round(1000 / FPSLimitEdit.Value));
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  DefColor := ComboBox1.ItemIndex;
end;

procedure TForm1.lbCPOShapesClick(Sender: TObject);
var
  idx: Integer;
  ax, ay, az: Integer;
begin
  idx := LBCPOShapes.ItemIndex + 1;
  if idx = 0 then Exit;

  fUIRefresh := True;
  try
    seCPOX.Value := CPO[idx].PosX;
    seCPOY.Value := CPO[idx].PosY;
    seCPOZ.Value := CPO[idx].PosZ;
    seCPOSX.Enabled := CPO[idx].Format = 2;
    seCPOSY.Enabled := CPO[idx].Format = 2;
    seCPOSZ.Enabled := CPO[idx].Format = 2;
    if CPO[idx].Format = 2 then
    begin
      seCPOSX.Value := CPO[idx].ScaleX;
      seCPOSY.Value := CPO[idx].ScaleY;
      seCPOSZ.Value := CPO[idx].ScaleZ;
    end;
    Matrix2Angles(CPO[idx].Matrix9, 9, @ax, @ay, @az);

    seCPORH.Value := Round(ax);
    seCPORP.Value := Round(ay);
    seCPORB.Value := Round(az);
  finally
    fUIRefresh := False;
  end;
end;

procedure TForm1.CPOChange(Sender: TObject);
var
  idx: Integer;
begin
  idx := LBCPOShapes.ItemIndex+1;
  if idx = 0 then Exit;
  if fUIRefresh then Exit;

  CPO[idx].PosX := seCPOX.Value;
  CPO[idx].PosY := seCPOY.Value;
  CPO[idx].PosZ := seCPOZ.Value;
  CPO[idx].ScaleX := seCPOSX.Value;
  CPO[idx].ScaleY := seCPOSY.Value;
  CPO[idx].ScaleZ := seCPOSZ.Value;

  Angles2Matrix(seCPORH.Value, seCPORP.Value, seCPORB.Value, @CPO[idx].Matrix9, 9);
end;

procedure TForm1.btnCPOAddClick(Sender: TObject);
var
  ID,IDnew: Integer;
begin
  if CPOHead.Qty >= MAX_CPO_SHAPES then Exit;
  if CPOHead.Qty = 0 then
  begin
    ShowUpClick(cuCPO);
    FillChar(CPOHead, SizeOf(CPOHead), #0);
    CPOHead.Head:='!OPC';
  end;
  ID:=LBCPOShapes.ItemIndex+1;
  inc(CPOHead.Qty);
  IDnew:=CPOHead.Qty;
  if (ID=0) or (CPO[ID].Format=3) then
  begin
    CPO[IDnew].Format:=2;
    CPO[IDnew].PosX:=0;
    CPO[IDnew].PosY:=0;
    CPO[IDnew].PosZ:=0;
    CPO[IDnew].ScaleX:=5;
    CPO[IDnew].ScaleY:=5;
    CPO[IDnew].ScaleZ:=5;
    Angles2Matrix(0,0,0, @CPO[IDnew].Matrix9, 9);
  end else
    CPO[IDnew]:=CPO[ID];

  SendDataToUI(uiCPO);

  SetRenderObject(fRenderObjects + [roCPO]);

  LBCPOShapes.ItemIndex:=LBCPOShapes.Count-1;
end;


procedure TForm1.btnCPORemClick(Sender: TObject);
var
  i,ID:Integer;
begin
  ID:=LBCPOShapes.ItemIndex+1; if ID=0 then Exit;
  for i:=ID to CPOHead.Qty-1 do
    CPO[i]:=CPO[i+1];
  dec(CPOHead.Qty);
  SendDataToUI(uiCPO);
end;


procedure TForm1.ReloadShadersCodeClick(Sender: TObject);
begin
  fUseShaders := LoadFresnelShader;
end;


procedure TForm1.CBShowGridClick(Sender: TObject);
begin
  CBShowGrid.Checked:=not CBShowGrid.Checked;
end;


procedure TForm1.CBChromeClick(Sender: TObject);
begin
  Chrome1.Checked := not Chrome1.Checked;
  RenderChrome := Chrome1.Checked;
end;


procedure TForm1.Lightvectors1Click(Sender: TObject);
begin
  Lightvectors1.Checked := not Lightvectors1.Checked;
end;


procedure TForm1.CBShowPartClick(Sender: TObject);
begin
  RenderOptions.ShowPart := CBShowPart.Checked;
end;


procedure TForm1.FlapPartsChange(Sender: TObject);
begin
  RenderOptions.PartsFlapPos := 1 - FlapParts.Position / FlapParts.Max;
end;


procedure TForm1.RebuildImpNormals;
var
  i,h: Integer;
  Avg1,Avg2: Vector3f;
begin
  for i:=1 to Imp.PolyCount do
  begin
    if Imp.Faces[i,4] = 0 then
      Normal2Poly(Imp.xyz[Imp.Faces[i,1]],Imp.xyz[Imp.Faces[i,2]],Imp.xyz[Imp.Faces[i,3]],@Imp.Np[i])
    else
    begin
      Normal2Poly(Imp.xyz[Imp.Faces[i,1]],Imp.xyz[Imp.Faces[i,2]],Imp.xyz[Imp.Faces[i,3]],@Avg1);
      Normal2Poly(Imp.xyz[Imp.Faces[i,1]],Imp.xyz[Imp.Faces[i,3]],Imp.xyz[Imp.Faces[i,4]],@Avg2);
      Imp.Np[i]:=mix(Avg1,Avg2,0.5);
    end;
  //Normalize(Imp.Np[i]); Sounds good but looks bad.
  end;

  FillChar(Imp.Nv,SizeOf(Imp.Nv),#0);

  for i:=1 to Imp.PolyCount do
    for h:=1 to 4 do
      if Imp.Faces[i,h]<>0 then
      begin //accumulating data to points
        Imp.Nv[Imp.Faces[i,h]].X:=Imp.Nv[Imp.Faces[i,h]].X+Imp.Np[i].X;
        Imp.Nv[Imp.Faces[i,h]].Y:=Imp.Nv[Imp.Faces[i,h]].Y+Imp.Np[i].Y;
        Imp.Nv[Imp.Faces[i,h]].Z:=Imp.Nv[Imp.Faces[i,h]].Z+Imp.Np[i].Z;
      end;

  for i:=1 to Imp.VerticeCount do
    Normalize(Imp.Nv[i]);

  h:=0; //Add quads data
  for i:=1 to Imp.PolyCount do
    if Imp.Faces[i,4]<>0 then
    begin
      inc(h);
      if Imp.PolyCount+h>=65280 then
      begin
        MessageDlg('Poly quantity exceeded 65`280 limit while splitting quad polys',mtError,[mbOK],0);
        Exit;
      end;
      Imp.DUV[Imp.PolyCount+h,1]:=Imp.DUV[i,1];
      Imp.DUV[Imp.PolyCount+h,2]:=Imp.DUV[i,3];
      Imp.DUV[Imp.PolyCount+h,3]:=Imp.DUV[i,4];
      Imp.Faces[Imp.PolyCount+h,1]:=Imp.Faces[i,1];
      Imp.Faces[Imp.PolyCount+h,2]:=Imp.Faces[i,3];
      Imp.Faces[Imp.PolyCount+h,3]:=Imp.Faces[i,4];
      Imp.Surf[Imp.PolyCount+h]:=Imp.Surf[i];
      Imp.Part[Imp.PolyCount+h]:=Imp.Part[i];
    end;
  inc(Imp.PolyCount,h);
end;


procedure TForm1.Exit1Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.SB_RenderOpts(Sender: TObject);
begin
  if Sender = btnShowLights then RenderOptions.LightVec := btnShowLights.Down;
  if Sender = btnShowColli then RenderOptions.Colli := btnShowColli.Down;
  if Sender = btnShowWireframe then RenderOptions.Wire := btnShowWireframe.Down;
  if Sender = btnShowUVMap then
  begin
    RenderOptions.UVMap := btnShowUVMap.Down;
    RenderResize(nil);
  end;
end;


procedure TForm1.ScanMOXheaders1Click(Sender: TObject);
begin
  DevScanMOXHeaders;
end;


procedure TForm1.DevScanMOXHeaders;
begin
  TThread.CreateAnonymousThread(
    procedure
    var
      slFiles, slLog: TStringList;
      I: Integer;
    begin
      slFiles := TStringList.Create;

      ListFiles('..\..\', '.mox', True, slFiles, nil);
      ListFiles('D:\', '.mox', True, slFiles,
        procedure(aMsg: string)
        begin
          if slFiles.Count mod 100 = 0 then
            StatusBar1.Panels[2].Text := Format('Searching %d - \%s', [slFiles.Count, aMsg]);
        end);

      slLog := TStringList.Create;
      slLog.Append('Ver'#9'Fmt'#9'Result'#9'Path'#9'Vertices'#9'Polys'#9'Chunks'#9'Materials'#9'Parts'#9'Blinkers');

      for I := 0 to slFiles.Count - 1 do
      try
        if I mod 100 = 0 then
          StatusBar1.Panels[2].Text := Format('Loading %d/%d - \%s', [I, slFiles.Count, slFiles[I]]);

        LoadMOX(slFiles[I]);
        slLog.Append(Format('%s'#9'%s'#9'%s'#9'%s'#9'%d'#9'%d'#9'%d'#9'%d'#9'%d'#9'%d',
          [MOX.MOXFormatInt, MOX.MOXFormatStr, 'OK  ', slFiles[i],
            MOX.header.VerticeCount, MOX.header.PolyCount,
            MOX.header.ChunkCount, MOX.header.MatCount,
            MOX.header.PartCount, MOX.header.BlinkerCount]));
      except
        on E: EExceptionTooNew do
          { We dont support newer formats yet };
        on E: Exception do
          slLog.Append(MOX.MOXFormatInt + #9 + MOX.MOXFormatStr + #9 + 'FAIL' + #9 + slFiles[I] + #9 + E.Message);
      end;

      slLog.Append(Format('%d files', [slFiles.Count]));
      slLog.SaveToFile('mox.txt');

      MessageBox(Handle, PChar(Format('Scanned %d MOX files', [slFiles.Count])), '', MB_OK or MB_ICONINFORMATION);

      slLog.Free;
      slFiles.Free;
    end
  ).Start;
end;


/////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////
//                                                         //
//  SSS   AAA   V   V EEEEE      // L     OOO   AAA  DDDD  //
// S     A   A  V   V E         //  L    O   O A   A D   D //
//  SSS  AAAAA  V   V EEEE     //   L    O   O AAAAA D   D //
//     S A   A   V V  E       //    L    O   O A   A D   D //
//  SSS  A   A    V   EEEEE  //     LLLLL OOO  A   A DDDD  //
//                                                         //
  /////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////

procedure TForm1.LoadMOXClick(Sender: TObject);
begin
  if not RunOpenDialog(odOpen,'',fOpenedFolder,'World Racing 2 object files (*.mox)|*.mox') then Exit;
  LoadFile(odOpen.FileName, lmLoadAndShow);
end;


procedure TForm1.LoadCOBClick(Sender: TObject);
begin
  if not RunOpenDialog(odOpen,'',fOpenedFolder,'World Racing 2 collision files (*.cob)|*.cob') then Exit;
  LoadFile(odOpen.FileName, lmLoadAndShow);
end;


procedure TForm1.LoadCPOClick(Sender: TObject);
begin
  if not RunOpenDialog(odOpen,'',fOpenedFolder,'Alarm for Cobra 11 Nitro collision files (*.cpo)|*.cpo') then Exit;
  LoadFile(odOpen.FileName, lmLoadAndShow);
end;


procedure TForm1.LoadTREE1Click(Sender: TObject);
begin
  if not RunOpenDialog(odOpen,'',fOpenedFolder,'World Racing 2 tree files (*.tree)|*.tree') then Exit;
  LoadFile(odOpen.FileName, lmLoadAndShow);
end;


procedure TForm1.SaveMOXClick(Sender: TObject);
begin
  if not RunSaveDialog(sdSave, fOpenedFileMask + '.mox', '', 'World Racing 2 object files (*.mox)|*.mox', 'mox') then Exit;

  meLog.Lines.Add('Saving MOX file ...');
  SaveMOX(sdSave.FileName);
  meLog.Lines.Add('MOX file written');
end;


procedure TForm1.SaveMTL1Click(Sender: TObject);
begin
  if not RunSaveDialog(sdSave, fOpenedFileMask+'.mtl','','World Racing Material files (*.mtl)|*.mtl','mtl') then Exit;
  //sdSave.FileName:=AssureFileExt(sdSave.FileName,'mtl');
  meLog.Lines.Add('Saving MTL file ...');
  SaveMTL(sdSave.FileName);
  meLog.Lines.Add('MTL file written');
end;


procedure TForm1.SaveCOB1Click(Sender: TObject);
begin
  if not RunSaveDialog(sdSave, fOpenedFileMask+'_colli.cob', '', 'World Racing 2 collision files (*.cob)|*.cob', 'cob') then Exit;

  fCOB.RebuildBounds;
  SendDataToUI(uiCOB);

  fCOB.SaveCOB(sdSave.FileName);
end;


procedure TForm1.SaveCPO1Click(Sender: TObject);
begin
  if not RunSaveDialog(sdSave, fOpenedFileMask+'.cpo','','World Racing 2 collision files (*.cpo)|*.cpo','cpo') then Exit;
  SaveCPO(sdSave.FileName);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Import3DSMOX1Click(Sender: TObject);
var
  log: string;
begin
  if not RunOpenDialog(odOpen,'',fOpenedFolder,'3DMax object files (*.3ds)|*.3ds') then Exit;
  if not Load3DS(odOpen.FileName,log) then Exit;
  meLog.Lines.Add(log);
  RebuildImpNormals;
  ConverseImp_MOX;
  UpdateOpenedFileInfo(odOpen.FileName)
end;

procedure TForm1.ImportOBJMOX1Click(Sender: TObject);
var
  log: string;
begin
  if not RunOpenDialog(odOpen,'',fOpenedFolder,'OBJ object files (*.obj)|*.obj') then Exit;
  if not LoadOBJ(odOpen.FileName,log) then Exit;

  meLog.Lines.Add(log);
  ConverseImp_MOX;
  UpdateOpenedFileInfo(odOpen.FileName)
end;

procedure TForm1.ImportLWO1Click(Sender: TObject);
var
  log: string;
begin
  if not RunOpenDialog(odOpen,'',fOpenedFolder,'Lightwave 3D files (*.lwo)|*.lwo') then Exit;
  if not LoadLWO(odOpen.FileName,log) then Exit;

  meLog.Lines.Add(log);
  RebuildImpNormals;
  ConverseImp_MOX;
  UpdateOpenedFileInfo(odOpen.FileName);
end;


procedure TForm1.ImportLWO2Click(Sender: TObject);
begin
  ImportLWO1Click(nil);

  LoadMTL(fOpenedFileMask+'.mtl');
  LoadTextures;
  ScanVinyls(fOpenedFolder);
  ShowUpClick(cuMTL);

  LoadPSF(fOpenedFileMask+'.psf');
  LoadPBF(fOpenedFileMask+'.pbf');
  ExchangePartsOrdering;
  RebuildPartsTree;
  LoadBlinkers(fOpenedFileMask+'.lsf');

  SendDataToUI(uiBlinkers);
  btnBlinkerPaste.Enabled := False;
end;


procedure TForm1.ImportLWOCOB1Click(Sender: TObject);
begin
  if not RunOpenDialog(odOpen, '', fOpenedFolder, 'Lightwave 3D files (*.lwo)|*.lwo') then Exit;

  fCOB.ImportLWO2COB(odOpen.Filename);

  ShowUpClick(cuCOB);
  SendDataToUI(uiCOB);
  SetRenderObject([roCOB]);
end;


procedure TForm1.ExportMOX1Click(Sender: TObject);
var
  doSpread: Boolean;
begin
  if not RunSaveDialog(sdSave, fOpenedFileMask+'.lwo','','Lightwave 3D files (*.lwo)|*.lwo','lwo') then Exit;

  meLog.Lines.Add('Writing MOX>LWO file');

  doSpread := MessageBox(Handle, 'Do you want to spread parts over X axis?', 'Question', MB_YESNO or MB_ICONQUESTION) = ID_YES;

  SaveMOX2LWO(sdSave.FileName, ColID, doSpread);

  meLog.Lines.Add('MOX>LWO Save Complete');
end;


procedure TForm1.ExportCOB1Click(Sender: TObject);
begin
  if not RunSaveDialog(sdSave, fOpenedFileMask + '_colli.lwo', '', 'Lightwave 3D files (*.lwo)|*.lwo', 'lwo') then Exit;
  meLog.Lines.Add('Writing COB>LWO file');
  fCOB.SaveCOB2LWO(sdSave.FileName);
  meLog.Lines.Add('COB>LWO Save Complete');
end;


procedure TForm1.ClearUpClick(aClearup: TClearUp);
begin
  RenderOptions.LightVec := False;
  RenderOptions.Colli := False;
  RenderOptions.Wire := False;
  RenderOptions.UVMap := False;
  RenderResize(nil);

  if aClearup in [cuMOX, cuALL] then
  begin
    FillChar(MOX,SizeOf(MOX),#0);
    btnBlinkerCopy.Enabled := False;
    btnBlinkerPaste.Enabled := False;
    btnBlinkersLoad.Enabled := False;
    btnBlinkersSave.Enabled := False;
    btnBlinkerAdd.Enabled := False;
    btnBlinkerRem.Enabled := False;
    btnPBFLoad.Enabled := False;
    btnPBFSave.Enabled := False;
    btnShowLights.Down := False;
    btnShowLights.Enabled := False;
    btnShowUVMap.Down := False;
    btnShowUVMap.Enabled := False;
    btnShowWireframe.Down := False;
    btnShowWireframe.Enabled := False;
    SendDataToUI(uiParts);
    SendDataToUI(uiBlinkers);
    SendDataToUI(uiMOX);
  end;

  if aClearup in [cuMTL, cuALL] then
  begin
    FillChar(Material,SizeOf(Material),#0);
    NumColors:=0;
    SaveMTL1.Enabled := False;
    MatCopy.Enabled := False;
    MatPaste.Enabled := False;
    ResetMTLOrder.Enabled := False;
    CBMonoColor.Checked := False;
    SendDataToUI(uiMTL);
    SendDataToUI(uiVinyl);
  end;

  if aClearup in [cuCOB, cuALL] then
  begin
    fCOB.Clear;
    btnShowColli.Down := False;
    btnShowColli.Enabled := False;
    SaveCOB1.Enabled := False;
    btnCOBVerticeCopy.Enabled := False;
    btnCOBVerticePaste.Enabled := False;
    ExportCOB1.Enabled := False;
    SendDataToUI(uiCOB);
  end;

  if aClearup in [cuCPO, cuALL] then
  begin
    FillChar(CPO,SizeOf(CPO),#0);
    FillChar(CPOHead,SizeOf(CPOHead),#0);
    btnShowColli.Down := False;
    btnShowColli.Enabled := False;
    SaveCPO1.Enabled := False;
    SendDataToUI(uiCPO);
  end;

  if aClearup in [cuTREE, cuALL] then
  begin
    fTree.Clear;
    btnShowWireframe.Down := False;
    btnShowWireframe.Enabled := False;
  end;
end;

procedure TForm1.ShowUpClick(aClearup: TClearUp);
begin
  if aClearup = cuMOX then
  begin
    SendDataToUI(uiParts);
    SendDataToUI(uiBlinkers);
    SendDataToUI(uiMOX);

    btnBlinkerCopy.Enabled := True;
    btnBlinkerPaste.Enabled := False;
    btnBlinkerAdd.Enabled := True;
    btnBlinkerRem.Enabled := True;
    btnBlinkersLoad.Enabled := True;
    btnBlinkersSave.Enabled := True;
    btnPBFLoad.Enabled := True;
    btnPBFSave.Enabled := True;
    btnShowLights.Enabled := True;
    btnShowWireframe.Enabled := True;
    btnShowUVMap.Enabled := True;
  end;

  if aClearup = cuMTL then
  begin
    SaveMTL1.Enabled := True;
    MatCopy.Enabled := True;
    MatPaste.Enabled := False;
    ResetMTLOrder.Enabled := True;
    CBMonoColor.Checked:=NumColors=1;
    MatMonoColorClick(nil);
    SendDataToUI(uiMTL);
    SendDataToUI(uiVinyl);
  end;

  if aClearup = cuCOB then
  begin
    btnShowColli.Enabled := True;
    SaveCOB1.Enabled := True;
    ExportCOB1.Enabled := True;
    btnCOBVerticeCopy.Enabled := True;
    btnCOBVerticePaste.Enabled := False;
    SendDataToUI(uiCOB);
  end;

  if aClearup = cuCPO then
  begin
    btnShowColli.Enabled := True;
    SaveCPO1.Enabled := True;
    SendDataToUI(uiCPO);
  end;

  if aClearup = cuTREE then
    btnShowWireframe.Enabled := True;
end;


procedure TForm1.shpBlinkerColorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  idx: Integer;
  blinker: TMOXBlinker;
begin
  idx := LBBlinkers.ItemIndex+1;
  if idx = 0 then Exit;

  // Copy
  blinker := MOX.Blinkers[idx];

  TForm_ColorPicker2.Execute(
    blinker.R + blinker.G shl 8 + blinker.B shl 16,
    procedure(aColor: Cardinal)
    begin
      // Live preview
      shpBlinkerColor.Brush.Color := aColor;

      MOX.Blinkers[idx].R := aColor mod 256;
      MOX.Blinkers[idx].G := aColor div 256 mod 256;
      MOX.Blinkers[idx].B := aColor div 65536;
      MOX.Blinkers[idx].A := 255;

      Render;
    end,
    nil,
    procedure
    begin
      // Cancel - restore original color
      MOX.Blinkers[idx] := blinker;
      shpBlinkerColor.Brush.Color := blinker.R + blinker.G shl 8 + blinker.B shl 16;
    end);
end;

procedure TForm1.CBVinylChange(Sender: TObject);
var
  I: Integer;
begin
  I := CBVinyl.ItemIndex;
  if I < 1 then Exit;

  if FileExists(fOpenedFolder+'\Textures_PC\Vinyls\'+VinylsList[I]) then
    LoadTexturePTX(fOpenedFolder+'\Textures_PC\Vinyls\'+VinylsList[I], VinylsTex);
end;


procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  loc: TPoint;
begin
  loc := RenderPanel.ScreenToClient(MousePos);
  if InRange(loc.X, 0, RenderPanel.Width)
  and InRange(loc.Y, 0, RenderPanel.Height) then
  begin
    zoom := zoom + WheelDelta / 4000;
    Handled := True;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  log: string;
  filename: string;
begin
  filename := ExeDir + 'LoadOBJ\clkdtm.obj';
  //filename:=ExeDir+'LoadOBJ\oacwr2.obj';
  if not LoadOBJ(filename, log) then Exit;
  meLog.Lines.Add(log);
  ConverseImp_MOX;
  UpdateOpenedFileInfo(filename);
end;

procedure TForm1.KnowScale(Sender: TObject);
var
  i:Integer;
  AbsMin,AbsMax:Single;
begin
  AbsMin := MaxSingle;
  AbsMax := -MaxSingle;
  for i := 1 to MOX.Header.VerticeCount do
  begin
    AbsMin := min(AbsMin, MOX.Vertice[i].X, MOX.Vertice[i].Y);
    AbsMin := min(AbsMin, MOX.Vertice[i].Z);
    AbsMax := max(AbsMax, MOX.Vertice[i].X, MOX.Vertice[i].Y);
    AbsMax := max(AbsMax, MOX.Vertice[i].Z);
  end;

  zoom := Sqrt(5.5 / (AbsMax - AbsMin)); // 5.5 looks about right
end;


procedure TForm1.btnCPOImportClick(Sender: TObject);
var
  log:string;
  i,h,IDnew:Integer;
begin
  if not RunOpenDialog(odOpen,'',fOpenedFolder,'Lightwave 3D files (*.lwo)|*.lwo') then Exit;
  if not LoadLWO(odOpen.FileName,log) then Exit;
  meLog.Lines.Add(log);

  if CPOHead.Qty >= MAX_CPO_SHAPES then Exit;

  if CPOHead.Qty = 0 then
  begin
    ShowUpClick(cuCPO);
    FillChar(CPOHead,SizeOf(CPOHead),#0);
    CPOHead.Head:='!OPC';
  end;
  inc(CPOHead.Qty);
  IDnew:=CPOHead.Qty;

  CPO[IDnew].Format:=3;
  CPO[IDnew].PosX:=0;
  CPO[IDnew].PosY:=0;
  CPO[IDnew].PosZ:=0;
  Angles2Matrix(0,0,0, @CPO[IDnew].Matrix9, 9);

  CPO[IDnew].VerticeCount:=Imp.VerticeCount;
  CPO[IDnew].PolyCount:=Imp.PolyCount;
  CPO[IDnew].IndiceSize:=Imp.PolyCount*6+Imp.PolyCount*2; //indices+indicecountperpoly
  CPO[IDnew].Clear1:=0;
  for i:=1 to Imp.VerticeCount do
    CPO[IDnew].Vertices[i]:=Imp.XYZ[i];

  for i:=1 to Imp.PolyCount do
  for h:=1 to 4 do
  case h of
    1: CPO[IDnew].Indices[(i-1)*4+h]:=3;
    2..4: CPO[IDnew].Indices[(i-1)*4+h]:=Imp.Faces[i,h-1]-1;
  end;

  SendDataToUI(uiCPO);

  SetRenderObject(fRenderObjects + [roCPO]);

  LBCPOShapes.ItemIndex := LBCPOShapes.Count-1;
end;


procedure TForm1.btnCPOExportClick(Sender: TObject);
var
  idx: Integer;
begin
  idx := LBCPOShapes.ItemIndex + 1;
  if (idx = 0) or (CPO[idx].Format = 2) then
  begin
    MessageBox(Handle, 'Select a freeform shape from list above', 'Error', MB_OK or MB_ICONERROR);
    Exit;
  end;

  if not RunSaveDialog(sdSave, fOpenedFileMask+'.lwo', '', 'Lightwave 3D files (*.lwo)|*.lwo', 'lwo') then
    Exit;

  meLog.Lines.Add('Writing CPO>LWO file');
  SaveCPO2LWO(sdSave.FileName, idx);
  meLog.Lines.Add('CPO>LWO Save Complete');
end;


procedure TForm1.lbBlinkersDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  myRect: TRect;
  prevColor: TColor;
  idx: Integer;
  idColor: Integer;
  lbCanvas: TCanvas;
begin
  idx := Index + 1;
  myRect := Rect;

  myRect.Left := 1;
  myRect.Right := 15;
  Inc(myRect.Top);
  Dec(myRect.Bottom, 2);

  lbCanvas := TListBox(Control).Canvas;

  prevColor := lbCanvas.Brush.Color; // Save old color
  lbCanvas.FillRect(Rect);

  if Control = lbBlinkers then
  begin
    lbCanvas.Brush.Color := MOX.Blinkers[idx].R + MOX.Blinkers[idx].G shl 8 + MOX.Blinkers[idx].B shl 16;
    lbCanvas.FillRect(myRect);
  end;

  if Control = lbMaterials then
  begin
    idColor := CBColor.ItemIndex+1;
    with Material[idx].Color[idColor].Dif do
      lbCanvas.Brush.Color := R + G shl 8 + B shl 16;
    lbCanvas.FillRect(myRect);

    Inc(myRect.Left, 5);
    with Material[idx].Color[idColor].Sp2 do
      lbCanvas.Brush.Color := R + G shl 8 + B shl 16;
    lbCanvas.FillRect(myRect);

    Inc(myRect.Left, 5);
    with Material[idx].Color[idColor].Sp1 do
      lbCanvas.Brush.Color := R + G shl 8 + B shl 16;
    lbCanvas.FillRect(myRect);
  end;

  lbCanvas.Brush.Color := prevColor;
  lbCanvas.TextOut(myRect.Right+4, Rect.Top, TListBox(Control).Items[Index]);
end;


procedure TForm1.btnRegisterMOXClick(Sender: TObject);
begin
  RegisterFileType('.mox', Application.ExeName);
  MessageBox(Handle, 'Registered', 'Info', MB_OK or MB_ICONINFORMATION);
end;


end.
