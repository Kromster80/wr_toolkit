unit MTkit2_Unit1;
interface
uses
  Buttons, Classes, ComCtrls, Controls, Dialogs, ExtCtrls, FileCtrl, Forms,
  Graphics, INIFiles, Math, Menus, ShellCtrls, Spin, StdCtrls, SysUtils, Windows,
  Messages,

  dglOpenGL, FloatSpinEdit, KromOGLUtils, KromUtils, TGATexture, PTXTexture,

  MTkit2_Defaults, MTkit2_Render, MTkit2_RenderLegacy, MTkit2_IO, MTkit2_COB, MTkit2_CPO, MTkit2_MOX, MTkit2_Tree, MTkit2_Vertex,
  Vcl.ButtonGroup, Vcl.CategoryButtons;

type
  TInputMode = (imRelative, imAbsolute);

//todo: Split into own unit
  TButtonGroup = class(Vcl.ButtonGroup.TButtonGroup)
  private
    fButtonEnabled: array of Boolean;
    procedure SetButtonEnabled(aIndex: Integer; aValue: Boolean);
    function GetButtonEnabled(aIndex: Integer): Boolean;
  protected
    procedure DrawButton(Index: Integer; Canvas: TCanvas; Rect: TRect; State: TButtonDrawState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Resize; override;
  public
    property ButtonEnabled[aIndex: Integer]: Boolean read GetButtonEnabled write SetButtonEnabled;
  end;


  TForm1 = class(TForm)
    odOpen: TOpenDialog;
    RenderPanel: TPanel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    About1: TMenuItem;
    mnuLoadMOX: TMenuItem;
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
    Label26: TLabel; Label27: TLabel; Label28: TLabel; Label29: TLabel; Label30: TLabel; Label32: TLabel; Label33: TLabel;
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
    mnuSaveMOX: TMenuItem;
    sdSave: TSaveDialog;
    mnuImportLWO1: TMenuItem;
    mnuSaveMTL: TMenuItem;
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
    mnuLoadCOB: TMenuItem;
    mnuSaveCOB: TMenuItem;
    RGDetailType: TRadioGroup;
    EDetailName: TEdit;
    CBActDam: TCheckBox;
    CBMonoColor: TCheckBox;
    mnuImportLWOCOB1: TMenuItem;
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
    mnuExportMOX1: TMenuItem;
    mnuExportCOB1: TMenuItem;
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
    Panel10: TPanel;
    TexReload2: TSpeedButton;
    mnuImportLWO2: TMenuItem;
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
    mnuLoadCPO: TMenuItem;
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
    mnuSaveCPO: TMenuItem;
    TBDirt: TTrackBar;
    ResetMTLOrder: TMenuItem;
    CBVinyl: TComboBox;
    Panel4: TPanel;
    CBShowGrid: TMenuItem;
    btnShowLights: TSpeedButton;
    btnShowColli: TSpeedButton;
    btnShowWireframe: TSpeedButton;
    Import1: TMenuItem;
    mnuImportOBJMOX1: TMenuItem;
    mnuLoadTREE: TMenuItem;
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
    mnuImport3DSMOX1: TMenuItem;
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
    bgLoad: TButtonGroup;
    Label2: TLabel;
    bgImport: TButtonGroup;
    Label34: TLabel;
    bgSaveAs: TButtonGroup;
    Label49: TLabel;
    Label35: TLabel;
    bgExport: TButtonGroup;

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
    procedure mnuImportLWO1Click(Sender: TObject);
    procedure UpdateOpenedFileInfo(const aFilename: string);
    procedure mnuSaveMTLClick(Sender: TObject);
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
    procedure mnuSaveCOBClick(Sender: TObject);
    procedure tvPartsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure tvPartsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure MatMonoColorClick(Sender: TObject);
    procedure mnuImportLWOCOB1Click(Sender: TObject);
    procedure btnCOBVerticeCopyClick(Sender: TObject);
    procedure btnCOBVerticePasteClick(Sender: TObject);
    procedure LBCOBPointsClick(Sender: TObject);
    procedure seCOBXChange(Sender: TObject);
    procedure mnuExportMOX1Click(Sender: TObject);
    procedure mnuExportCOB1Click(Sender: TObject);
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
    procedure mnuImportLWO2Click(Sender: TObject);
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
    procedure mnuSaveCPOClick(Sender: TObject);
    procedure CBShowGridClick(Sender: TObject);
    procedure CBShowPartClick(Sender: TObject);
    procedure FlapPartsChange(Sender: TObject);
    procedure RebuildImpNormals;
    procedure mnuImport3DSMOX1Click(Sender: TObject);
    procedure mnuImportOBJMOX1Click(Sender: TObject);
    procedure mnuLoadTREEClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure SaveMOXClick(Sender: TObject);
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
    procedure bgLoadButtonClicked(Sender: TObject; Index: Integer);
    procedure bgSaveAsButtonClicked(Sender: TObject; Index: Integer);
    procedure bgImportButtonClicked(Sender: TObject; Index: Integer);
    procedure bgExportButtonClicked(Sender: TObject; Index: Integer);
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
    fMOX: TMOX2;
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
    procedure ConverseImp_MOX;
    procedure MaterialSetDefault;
    procedure SaveMOX(const aFilename: string);
    procedure DevScanMOXHeaders;
    procedure RebuildPartsTree;
    procedure ExchangePartsOrdering;
    procedure ActionsDisable(aActions: TEditingActions);
    procedure ActionsEnable(aActions: TEditingActions);
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
  GraphUtil, ColorPicker2, UnitRawInputHeaders,
  MTKit2_Textures;

{$R *.dfm}

const
  BG_LOAD_MOXMTL = 0;
  BG_LOAD_COB    = 1;
  BG_LOAD_CPO    = 2;
  BG_LOAD_TREE   = 3;
  BG_SAVE_AS_MOX = 0;
  BG_SAVE_AS_MTL = 1;
  BG_SAVE_AS_COB = 2;
  BG_SAVE_AS_CPO = 3;
  BG_IMPORT_3DS_MOX = 0;
  BG_IMPORT_OBJ_MOX = 1;
  BG_IMPORT_LWO_MOX = 2;
  BG_IMPORT_LWO_MOX2 = 3;
  BG_IMPORT_LWO_COB = 4;
  BG_EXPORT_MOX_LWO = 0;
  BG_EXPORT_COB_LWO = 1;


{ TButtonGroup }
function TButtonGroup.GetButtonEnabled(aIndex: Integer): Boolean;
begin
  Result := fButtonEnabled[aIndex];
end;

procedure TButtonGroup.SetButtonEnabled(aIndex: Integer; aValue: Boolean);
begin
  fButtonEnabled[aIndex] := aValue;
  Invalidate;
end;

procedure TButtonGroup.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  btnIdx: Integer;
begin
  // Ignore mouse events for disabled buttons
  btnIdx := IndexOfButtonAt(X, Y);
  if (btnIdx <> -1) and ButtonEnabled[btnIdx] then
    inherited;
end;

procedure TButtonGroup.Resize;
var
  I: Integer;
  oldCount: Integer;
begin
  // Sync enabled buttons count every so often
  oldCount := Length(fButtonEnabled);
  if Items.Count <> oldCount then
  begin
    SetLength(fButtonEnabled, Items.Count);
    for I := oldCount to High(fButtonEnabled) do
      fButtonEnabled[I] := True;
  end;
end;

procedure TButtonGroup.DrawButton(Index: Integer; Canvas: TCanvas; Rect: TRect; State: TButtonDrawState);
var
  TextLeft, TextTop: Integer;
  RectHeight: Integer;
  ImgTop: Integer;
  TextOffset: Integer;
  ButtonItem: TGrpButtonItem;
  FillColor: TColor;
  EdgeColor: TColor;
  TextRect: TRect;
  OrgRect: TRect;
  Text: string;
begin
  begin
    OrgRect := Rect;
    Canvas.Font := Font;

    begin
      if not ButtonEnabled[Index] then
      begin
        // Grey on grey
        Canvas.Brush.Color := GetShadowColor(clBtnFace, -15);
        Canvas.Font.Color := $B0B0B0;
      end else
      if bdsSelected in State then
      begin
        Canvas.Brush.Color := GetShadowColor(clBtnFace, -25);
        Canvas.Font.Color := clBtnText;
      end
      else if bdsDown in State then
      begin
        Canvas.Brush.Color := clBtnShadow;
        Canvas.Font.Color := clBtnFace;
      end
      else
        Canvas.Brush.Color := clBtnFace;
    end;

    FillColor := Canvas.Brush.Color;
    EdgeColor := GetShadowColor(FillColor, -25);

    { Back }
    begin
      InflateRect(Rect, -2, -1);
      Canvas.FillRect(Rect);
    end;

    if ButtonEnabled[Index] then
    if (bdsHot in State) and not (bdsDown in State) then
      EdgeColor := GetShadowColor(EdgeColor, -50);

    { Draw the edge outline }
    begin
      Canvas.Brush.Color := EdgeColor;
      Canvas.FrameRect(Rect);
      Canvas.Brush.Color := FillColor;
    end;

    { Compute the text location }
    TextLeft := Rect.Left + 4;
    RectHeight := Rect.Bottom - Rect.Top;
    TextTop := Rect.Top + (RectHeight - Canvas.TextHeight('Wg')) div 2; { Do not localize }
    if TextTop < Rect.Top then
      TextTop := Rect.Top;
    if bdsDown in State then
    begin
      Inc(TextTop);
      Inc(TextLeft);
    end;

    ButtonItem := Items[Index];
    TextOffset := 0;

    if gboShowCaptions in ButtonOptions then
    begin
      { Avoid clipping the image }
      Inc(TextLeft, TextOffset);
      TextRect.Left := TextLeft;
      TextRect.Right := Rect.Right - 1;
      TextRect.Top := TextTop;
      TextRect.Bottom := Rect.Bottom -1;
      Text := ButtonItem.Caption;
      Canvas.TextRect(TextRect, Text, [tfEndEllipsis]);
    end;
  end;
  Canvas.Brush.Color := Color; { Restore the original color }
end;


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
  fMOX := TMOX2.Create;
  fTree := TModelTree.Create;

  ActionsDisable(cuALL);

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


procedure TForm1.Button4Click(Sender: TObject);
begin
  {Placeholder}
end;


procedure TForm1.bgLoadButtonClicked(Sender: TObject; Index: Integer);
begin
  case Index of
    BG_LOAD_MOXMTL: if RunOpenDialog2(odOpen, fOpenedFolder, FILE_TYPE_INFO[kftMox].Filter) then
                      LoadFile(odOpen.FileName, lmLoadAndShow);
    BG_LOAD_COB:    if RunOpenDialog2(odOpen, fOpenedFolder, 'World Racing 2 collision files (*.cob)|*.cob') then
                      LoadFile(odOpen.FileName, lmLoadAndShow);
    BG_LOAD_CPO:    if RunOpenDialog2(odOpen, fOpenedFolder, 'Alarm for Cobra 11 Nitro collision files (*.cpo)|*.cpo') then
                      LoadFile(odOpen.FileName, lmLoadAndShow);
    BG_LOAD_TREE:   if RunOpenDialog2(odOpen, fOpenedFolder, FILE_TYPE_INFO[kftTree].Filter) then
                      LoadFile(odOpen.FileName, lmLoadAndShow);
  end;
end;


procedure TForm1.bgSaveAsButtonClicked(Sender: TObject; Index: Integer);
begin
  case Index of
    BG_SAVE_AS_MOX: if RunSaveDialog2(sdSave, fOpenedFileMask + '.mox', FILE_TYPE_INFO[kftMox].Filter) then
                      SaveMOX(sdSave.FileName);
    BG_SAVE_AS_MTL: if RunSaveDialog(sdSave, fOpenedFileMask + '.mtl', '', 'World Racing Material files (*.mtl)|*.mtl', 'mtl') then
                      SaveMTL(sdSave.FileName, fMOX.Header.MatCount);
    BG_SAVE_AS_COB: if RunSaveDialog(sdSave, fOpenedFileMask + '_colli.cob', '', 'World Racing 2 collision files (*.cob)|*.cob', 'cob') then
                    begin
                      fCOB.RebuildBounds;
                      SendDataToUI(uiCOB);
                      fCOB.SaveCOB(sdSave.FileName);
                    end;
    BG_SAVE_AS_CPO: if RunSaveDialog(sdSave, fOpenedFileMask + '.cpo', '', 'World Racing 2 collision files (*.cpo)|*.cpo', 'cpo') then
                      SaveCPO(sdSave.FileName);
  end;
end;


procedure TForm1.bgImportButtonClicked(Sender: TObject; Index: Integer);
begin
  try
    case Index of
      BG_IMPORT_3DS_MOX:  if RunOpenDialog2(odOpen, fOpenedFolder, '3DMax object files (*.3ds)|*.3ds') then
                          begin
                            Load3DS(odOpen.FileName);
                            RebuildImpNormals;
                            ConverseImp_MOX;
                            UpdateOpenedFileInfo(odOpen.FileName);
                          end;
      BG_IMPORT_OBJ_MOX:  if RunOpenDialog2(odOpen,fOpenedFolder,'OBJ object files (*.obj)|*.obj') then
                          begin
                            LoadOBJ(odOpen.FileName);
                            ConverseImp_MOX;
                            UpdateOpenedFileInfo(odOpen.FileName)
                          end;
      BG_IMPORT_LWO_MOX:  if RunOpenDialog2(odOpen,fOpenedFolder, FILE_TYPE_INFO[kftLwo].Filter) then
                          begin
                            LoadLWO(odOpen.FileName);
                            RebuildImpNormals;
                            ConverseImp_MOX;
                            UpdateOpenedFileInfo(odOpen.FileName);
                          end;
      BG_IMPORT_LWO_MOX2: begin
                            bgImportButtonClicked(nil, BG_IMPORT_LWO_MOX);

                            LoadMTL(fOpenedFileMask+'.mtl', fMOX.Header.MatCount);
                            LoadTextures;
                            ScanVinyls(fOpenedFolder);
                            ActionsEnable(cuMTL);

                            LoadPSF(fMOX, fOpenedFileMask+'.psf');
                            LoadPBF(fMOX, fOpenedFileMask+'.pbf');
                            ExchangePartsOrdering;
                            RebuildPartsTree;
                            fMOX.BlinkersLoad(fOpenedFileMask+'.lsf');

                            SendDataToUI(uiBlinkers);
                            btnBlinkerPaste.Enabled := False;
                          end;
      BG_IMPORT_LWO_COB:  if RunOpenDialog2(odOpen, fOpenedFolder, FILE_TYPE_INFO[kftLwo].Filter) then
                          begin
                            fCOB.ImportLWO(odOpen.Filename);
                            ActionsEnable(cuCOB);
                            SendDataToUI(uiCOB);
                            SetRenderObject([roCOB]);
                          end;
    end;
  except
    on E: Exception do
      MessageBox(Handle, PChar(E.Message), 'Error', MB_OK or MB_ICONERROR);
  end;
end;

procedure TForm1.bgExportButtonClicked(Sender: TObject; Index: Integer);
var
  doSpread: Boolean;
begin
  case Index of
    BG_EXPORT_MOX_LWO:  if RunSaveDialog2(sdSave, fOpenedFileMask + '.lwo', FILE_TYPE_INFO[kftLwo].Filter) then
                        begin
                          meLog.Lines.Add('Writing MOX>LWO file');
                          doSpread := MessageBox(Handle, 'Do you want to spread parts over X axis?', 'Question', MB_YESNO or MB_ICONQUESTION) = ID_YES;
                          fMOX.SaveMOX2LWO(sdSave.FileName, ColID, doSpread);
                          meLog.Lines.Add('MOX>LWO Save Complete');
                        end;
    BG_EXPORT_COB_LWO:  if RunSaveDialog2(sdSave, fOpenedFileMask + '_colli.lwo', FILE_TYPE_INFO[kftLwo].Filter) then
                        begin
                          meLog.Lines.Add('Writing COB>LWO file');
                          fCOB.ExportLWO(sdSave.FileName);
                          meLog.Lines.Add('COB>LWO Save Complete');
                        end;
  end;
end;


procedure TForm1.SendDataToUI(aSection: TUIDataSection);
var
  ii: Integer;
  oldID1: Integer;
begin
  case aSection of
    uiMOX:      begin
                  edVerticeCount.Text := IntToStr(fMOX.Header.VerticeCount);
                  edPolyCount.Text := IntToStr(fMOX.Header.PolyCount);
                  edPartCount.Text := IntToStr(fMOX.Header.PartCount);
                  edMaterialCount.Text := IntToStr(fMOX.Header.MatCount);
                  edChunkCount.Text := IntToStr(fMOX.Header.ChunkCount);
                  edBlinkerCount.Text := IntToStr(fMOX.Header.BlinkerCount);
                end;
    uiMTL:      begin
                  LBMaterials.Clear;
                  for ii:=1 to fMOX.Header.MatCount do
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
                  for ii:=1 to fMOX.Header.BlinkerCount do
                    LBBlinkers.Items.Add(IntToStr(ii)+'. '+ fMOX.Blinkers[ii].GetStr);
                  if oldID1<LBBlinkers.Count then LBBlinkers.ItemIndex:=oldID1;
                  fUIRefresh := False;
                end;
    uiParts:    begin
                  TVParts.Items.Clear;
                  for ii:=1 to fMOX.Header.PartCount do
                  begin
                    if fMOX.Parts[ii].Parent=-1 then Dnode[ii] := TVParts.Items.Add(nil,fMOX.Parts[ii].Dname) else //make Root
                    Dnode[ii] := TVParts.Items.AddChild(Dnode[fMOX.Parts[ii].Parent+1],fMOX.Parts[ii].Dname);      //child
                  end;
                  if fMOX.Header.PartCount>=1 then Dnode[1].Expand(False);
                end;
    uiCOB:      begin
                  fUIRefresh := True;
                  oldID1 := LBCOBPoints.ItemIndex;
                  LBCOBPoints.Clear;
                  for ii := 0 to fCOB.Head.PolyCount - 1 do
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
  for I:=1 to fMOX.Header.ChunkCount do
  begin
    if MoxCall[I]=0 then MoxCall[I]:=glGenLists(1);
    glNewList(MoxCall[I], GL_COMPILE);
    glBegin(GL_TRIANGLES);
      for K:=1 to fMOX.Chunks[I].PolyCount do  //1..number polys
      for H:=3 downto 1 do
      begin
        glTexCoord2fv(@fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,H]].U);
        glNormal3fv(@fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,H]].nX);
        glVertex3fv(@fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,H]].X);
      end;
    glEnd;
    glEndList;

    if MoxUVCall[I]=0 then MoxUVCall[I]:=glGenLists(1);
    glNewList(MoxUVCall[I], GL_COMPILE);
    glbegin(GL_TRIANGLES);
      for K:=1 to fMOX.Chunks[I].PolyCount do
      begin
        Normal2Poly(fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,1]].U,fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,1]].V,
                    fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,2]].U,fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,2]].V,
                    fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,3]].U,fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,3]].V, t);
        if t>=0 then
          for H:=3 downto 1 do
          begin
            glTexCoord2fv(@fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,H]].U);
            glVertex2f(fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,H]].U,-fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,H]].V+1);
            //glVertex2f(fMOX.Vertice[fMOX.Face[fMOX.Chunk[I,1]+K,H]].x1,-fMOX.Vertice[fMOX.Face[fMOX.Chunk[I,1]+K,H]].x2+1);//AFC11CT
          end
        else
          for H:=1 to 3 do begin
            glTexCoord2fv(@fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,H]].U);
            glVertex2f(fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,H]].U,-fMOX.Vertice[fMOX.Face[fMOX.Chunks[I].FirstPoly+K,H]].V+1);
            //glVertex2f(fMOX.Vertice[fMOX.Face[fMOX.Chunk[I,1]+K,H]].x1,-fMOX.Vertice[fMOX.Face[fMOX.Chunk[I,1]+K,H]].x2+1);//AFC11CT
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
    RenderOpenGL(fMOX);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    RenderDirt(fMOX, '', TBDirt.Position);
  end else
  begin
    glTranslatef(0, 0, -6);
    glTranslatef(xMov, yMov, 0);
    glRotatef(yRot, 1, 0, 0);
    glRotatef(xRot, 0, 1, 0);
    glkScale(Sqr(zoom));

    if RenderOptions.ShowPart and (ActivePage=apParts) and (SelectedTreeNode<>0) then
      glTranslatef(-fMOX.Parts[SelectedTreeNode].Matrix[4,1]-PartModify[SelectedTreeNode].Move[1],
                   -fMOX.Parts[SelectedTreeNode].Matrix[4,2]-PartModify[SelectedTreeNode].Move[2],
                   -fMOX.Parts[SelectedTreeNode].Matrix[4,3]-PartModify[SelectedTreeNode].Move[3]);
    if cbTargetLight.Checked and (ActivePage=apLights) and (LBBlinkers.ItemIndex<>-1) then
      glTranslatef(-fMOX.Blinkers[LBBlinkers.ItemIndex+1].Matrix[4,1],
                   -fMOX.Blinkers[LBBlinkers.ItemIndex+1].Matrix[4,2],
                   -fMOX.Blinkers[LBBlinkers.ItemIndex+1].Matrix[4,3]);

    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); //Set alpha mode
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glBindTexture(GL_TEXTURE_2D, 0);

    glDisable(GL_LIGHTING);
    if CBShowGrid.Checked then RenderGrid;
    glEnable(GL_LIGHTING);

    if roMOX in fRenderObjects then
    begin
      if fRenderMode = rmShaders then
        RenderShaders(fMOX);

      if fRenderMode = rmOpenGL then
      begin
        RenderOpenGL(fMOX);
        glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
        RenderDirt(fMOX, '', TBDirt.Position);
        if SelectedTreeNode<>0 then
          RenderPivotSetup(fMOX, PivotPointActual.Value+fMOX.Chunks[fMOX.Parts[SelectedTreeNode].FirstMat+1].FirstVtx-1,
                           PivotPointActual.MaxValue,
                           PivotPointActual.Value); //PivotPointActual & SRnage both have +1
        RenderDummy(fMOX);
        glDisable(GL_LIGHTING);
        if RenderOptions.Wire then RenderWireframe(fMOX, fColorWireframe);
        glEnable(GL_LIGHTING);
      end;
      glDisable(GL_DEPTH_TEST);
      if (ActivePage = apLights) or RenderOptions.LightVec then
        RenderLights(fMOX, LBBlinkers.ItemIndex+1, TBlinkerPreviewMode(rgBlinkerPreview.ItemIndex), ActivePage = apLights, Lightvectors1.Checked);
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
  for i:=1 to fMOX.Header.MatCount do
    if MoxTex[i] <> 0 then
    begin
      glDeleteTextures(1, @MoxTex[i]);
      MoxTex[i] := 0;
    end;
  glDeleteTextures(1, @DirtTex);
  glDeleteTextures(1, @ScratchTex);

  // Load new textures
  for i:=1 to fMOX.Header.MatCount do
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
    blinkerType := fMOX.Blinkers[idx].BlinkerType;
    case blinkerType of //Fit 0..24 IDs in RG range of 0..12
      16: blinkerType := 10;
      20: blinkerType := 11;
      24: blinkerType := 12;
      33: blinkerType := 13;
    end;

    rgBlinkerType.ItemIndex := blinkerType;

    fsBlinkerSizeMin.Value := fMOX.Blinkers[idx].sMin;
    fsBlinkerSizeMax.Value := fMOX.Blinkers[idx].sMax;
    fsBlinkerFreq.Value := fMOX.Blinkers[idx].Freq;
    //S1.Value:=fMOX.Blinkers[LBBlinkers.ItemIndex+1].z1;
    seBlinkerParent.Value:=fMOX.Blinkers[idx].Parent;
    fsBlinkerX.Value:=fMOX.Blinkers[idx].Matrix[4,1]/10;
    fsBlinkerY.Value:=fMOX.Blinkers[idx].Matrix[4,2]/10;
    fsBlinkerZ.Value:=fMOX.Blinkers[idx].Matrix[4,3]/10;
    shpBlinkerColor.Brush.Color := fMOX.Blinkers[idx].R+fMOX.Blinkers[idx].G*256+fMOX.Blinkers[idx].B*65536;

    with fMOX.Blinkers[idx] do
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
    0..9: fMOX.Blinkers[idx].BlinkerType := rgBlinkerType.ItemIndex;
    10:   fMOX.Blinkers[idx].BlinkerType := 16;
    11:   fMOX.Blinkers[idx].BlinkerType := 20;
    12:   fMOX.Blinkers[idx].BlinkerType := 24;
    13:   fMOX.Blinkers[idx].BlinkerType := 33;
  end;

  fMOX.Blinkers[idx].sMin := fsBlinkerSizeMin.Value;
  fMOX.Blinkers[idx].sMax := fsBlinkerSizeMax.Value;
  fMOX.Blinkers[idx].Freq := fsBlinkerFreq.Value;
  fMOX.Blinkers[idx].Unused := 0;
  fMOX.Blinkers[idx].Parent := seBlinkerParent.Value;
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
  Label23.Caption:='#'+IntToStr(idx)+' P'+IntToStr(fMOX.Parts[idx].Parent+1)
                                   +' C'+IntToStr(fMOX.Parts[idx].Child+1)
                                   +' P'+IntToStr(fMOX.Parts[idx].PrevInLevel+1)
                                   +' N'+IntToStr(fMOX.Parts[idx].NextInLevel+1);

  EDetailName.Text:=fMOX.Parts[SelectedTreeNode].Dname;
  CX.Value:=fMOX.Parts[SelectedTreeNode].xMid;
  CY.Value:=fMOX.Parts[SelectedTreeNode].yMid;
  CZ.Value:=fMOX.Parts[SelectedTreeNode].zMid;
  CRad.Value:=fMOX.Parts[SelectedTreeNode].fRadius;

  RGDetailType.ItemIndex := fMOX.Parts[SelectedTreeNode].TypeID;
  if RGDetailType.ItemIndex<>fMOX.Parts[SelectedTreeNode].TypeID then
    MessageBox(Handle, 'Unknown detail ID type', 'Discovery', MB_OK or MB_ICONSTOP);

  LX1.Value:=fMOX.Parts[SelectedTreeNode].x1/Pi*180;//-YZ rotation
  LX2.Value:=fMOX.Parts[SelectedTreeNode].x2/Pi*180;//+YZ rotation
  LY1.Value:=fMOX.Parts[SelectedTreeNode].y1/Pi*180;//-XZ rotation
  LY2.Value:=fMOX.Parts[SelectedTreeNode].y2/Pi*180;//+XZ rotation
  LZ1.Value:=fMOX.Parts[SelectedTreeNode].z1/Pi*180;//-XY rotation
  LZ2.Value:=fMOX.Parts[SelectedTreeNode].z2/Pi*180;//+XY rotation
  ForbidPartsChange := False;
  FlapParts.Enabled:=SelectedTreeNode<>0;
  Label30.Enabled:=SelectedTreeNode<>0;

  ForbidPivotChange := True;
  try
    PivotPointActual.MaxValue :=
      fMOX.Chunks[fMOX.Parts[SelectedTreeNode].FirstMat+1+fMOX.Parts[SelectedTreeNode].NumMat-1].LastVtx -
      fMOX.Chunks[fMOX.Parts[SelectedTreeNode].FirstMat+1].FirstVtx+1;
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
  i,j,k,m:Integer;
  ii:Integer;
  f:file;
  tx,ty,tz: array [1..256]of real;
  Lev:Integer;
  lazyqty: array of Integer;
  face6: array [1..3] of Word;
begin
  AssignFile(f,aFilename); rewrite(f,1);

  if PivotSetup.TabVisible then  //LWO>MOX only !
  begin  //Set MoxMat/Sid order continous
    //kinda lazy to re-do SRange stuff, so just sort it out here :-)

    setlength(lazyqty,fMOX.Header.PartCount+1);
    lazyqty[0]:=0;

    for i:=1 to fMOX.Header.PartCount do
    begin
      lazyqty[i]:=1;                  //number of fMOX.Parts
      for j:=fMOX.Parts[i].FirstMat+1 to fMOX.Parts[i].FirstMat+fMOX.Parts[i].NumMat do
        if (fMOX.Chunks[j].PolyCount>0) then
        begin  //if polycount for part >1
          fMOX.Chunks[lazyqty[0]+lazyqty[i]].FirstPoly:=fMOX.Chunks[j].FirstPoly;
          fMOX.Chunks[lazyqty[0]+lazyqty[i]].PolyCount:=fMOX.Chunks[j].PolyCount;
          fMOX.Chunks[lazyqty[0]+lazyqty[i]].FirstVtx:=fMOX.Chunks[j].FirstVtx;
          fMOX.Chunks[lazyqty[0]+lazyqty[i]].LastVtx:=fMOX.Chunks[j].LastVtx;
          fMOX.Chunks[lazyqty[0]+lazyqty[i]].SidA:=fMOX.Chunks   [j].SidA;
          fMOX.Chunks[lazyqty[0]+lazyqty[i]].SidB:=fMOX.Chunks   [j].SidB;
          //MoxMat[lazyqty[0]+lazyqty[i]].ID:=MoxMat[j].ID;
          inc(lazyqty[i]);
        end;
      dec(lazyqty[i]);
      inc(lazyqty[0],lazyqty[i]);
    end;

    fMOX.Header.ChunkCount:=0;
    fMOX.Parts[1].FirstMat:=0;

    for i:=1 to fMOX.Header.PartCount do
    begin
      inc(fMOX.Header.ChunkCount, lazyqty[i]);
      fMOX.Parts[i].NumMat:=lazyqty[i];
      fMOX.Parts[i+1].FirstMat:=fMOX.Parts[i].FirstMat+fMOX.Parts[i].NumMat;
    end;
    //re-Sorting ends here}

    k:=1; m:=0;
    for i:=1 to fMOX.Header.VerticeCount do
    begin
      if i=fMOX.Chunks[k].LastVtx+1 then
        inc(k);//3-point From  //4-point Till //k-partID

      if fMOX.Parts[m+1].FirstMat+1=k then
      begin
        inc(m); //m-detailID
        tx[m]:=0; ty[m]:=0; tz[m]:=0;
        Lev:=m;
        //repeat
          if (fMOX.Parts[Lev].Parent<>-1) then
          begin
            Lev:=fMOX.Parts[Lev].Parent+1; //parentID
            tx[m] := Tx[m]-PartModify[Lev].Move[1];
            ty[m] := Ty[m]-PartModify[Lev].Move[2];
            tz[m] := Tz[m]-PartModify[Lev].Move[3];
          end;
        //until(fMOX.Parts[Lev].Parent=-1);
        tx[m] := Tx[m]+PartModify[m].Move[1];
        ty[m] := Ty[m]+PartModify[m].Move[2];
        tz[m] := Tz[m]+PartModify[m].Move[3];
      end;

      fMOX.Vertice[i].X:=fMOX.Vertice[i].X-PartModify[m].Move[1];
      fMOX.Vertice[i].Y:=fMOX.Vertice[i].Y-PartModify[m].Move[2];
      fMOX.Vertice[i].Z:=fMOX.Vertice[i].Z-PartModify[m].Move[3];
    end;

    for i:=1 to fMOX.Header.PartCount do
    begin
      fMOX.Parts[i].Matrix[4,1] := Tx[i];//PartModify[i].Move[1];
      fMOX.Parts[i].Matrix[4,2] := Ty[i];//PartModify[i].Move[2];
      fMOX.Parts[i].Matrix[4,3] := Tz[i];//PartModify[i].Move[3];
      fMOX.Parts[i].xMid:=fMOX.Parts[i].xMid-PartModify[i].Move[1];
      fMOX.Parts[i].yMid:=fMOX.Parts[i].yMid-PartModify[i].Move[2];
      fMOX.Parts[i].zMid:=fMOX.Parts[i].zMid-PartModify[i].Move[3];
    end;
  end;

  PivotSetup.TabVisible := False;

  // Make sure we write Ansi chars
  BlockWrite(f, PAnsiChar(MOX_FORMAT_HEADER)^, 8);

  BlockWrite(f, fMOX.Header, 24);
  BlockWrite(f, fMOX.Vertice, fMOX.Header.VerticeCount*40);
  for ii:=1 to fMOX.Header.PolyCount do
  begin
    face6[1] := fMOX.Face[ii,1] - 1;
    face6[2] := fMOX.Face[ii,2] - 1;
    face6[3] := fMOX.Face[ii,3] - 1;

    BlockWrite(f, face6, 6);
  end;

  for ii:=1 to fMOX.Header.ChunkCount do
  begin
    BlockWrite(f,fMOX.Chunks[ii].SidA,2); BlockWrite(f,#0+#0,2);
    BlockWrite(f,fMOX.Chunks[ii].SidB,2); BlockWrite(f,#0+#0,2);

    dec(fMOX.Chunks[ii].FirstVtx); dec(fMOX.Chunks[ii].LastVtx);
    BlockWrite(f,fMOX.Chunks[ii].FirstPoly,2); BlockWrite(f,#0+#0,2);
    BlockWrite(f,fMOX.Chunks[ii].PolyCount,2); BlockWrite(f,#0+#0,2);
    BlockWrite(f,fMOX.Chunks[ii].FirstVtx,2); BlockWrite(f,#0+#0,2);
    BlockWrite(f,fMOX.Chunks[ii].LastVtx,2); BlockWrite(f,#0+#0,2);
    inc(fMOX.Chunks[ii].FirstVtx); inc(fMOX.Chunks[ii].LastVtx);
  end;

  BlockWrite(f, fMOX.MoxMat, 336*fMOX.Header.MatCount);   //4+332

  for ii:=1 to fMOX.Header.PartCount do
  begin
    s:=chr2(fMOX.Parts[ii].Dname,64);
    BlockWrite(f,s[1],64);
    BlockWrite(f,fMOX.Parts[ii].Matrix,132);
  end;

  //todo: It is worth writing more important blinkers first (deprioritize LED decoys),
  // since the game has a limit on how many blinkers it can show at once (384)
  for ii:=1 to fMOX.Header.BlinkerCount do //Write blinkers in order
   BlockWrite(f, fMOX.Blinkers[ii], 88);

  closefile(f);
  meLog.Lines.Add('MOX file closed');
  for i:=1 to fMOX.Header.PartCount do
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
  if (TVParts.Selected = nil) or ForbidPartsChange then Exit;

  if LX1.Value > LX2.Value then
  if Sender = LX1 then LX2.Value := LX1.Value else LX1.Value := LX2.Value;

  if LY1.Value > LY2.Value then
  if Sender = LY1 then LY2.Value := LY1.Value else LY1.Value := LY2.Value;

  if LZ1.Value > LZ2.Value then
  if Sender = LZ1 then LZ2.Value := LZ1.Value else LZ1.Value := LZ2.Value;

  SelectedTreeNode := tvParts.Selected.AbsoluteIndex + 1;
  fMOX.Parts[SelectedTreeNode].Dname := EDetailName.Text;
  fMOX.Parts[SelectedTreeNode].xMid := CX.Value;
  fMOX.Parts[SelectedTreeNode].yMid := CY.Value;
  fMOX.Parts[SelectedTreeNode].zMid := CZ.Value;
  fMOX.Parts[SelectedTreeNode].fRadius := CRad.Value;
  fMOX.Parts[SelectedTreeNode].w1 := 0; // SpinEdit5.Value;
  fMOX.Parts[SelectedTreeNode].w2 := 0; // SpinEdit6.Value;
  fMOX.Parts[SelectedTreeNode].w3 := 0; // SpinEdit7.Value;
  fMOX.Parts[SelectedTreeNode].w4 := 0; // SpinEdit8.Value;
  fMOX.Parts[SelectedTreeNode].w5 := 0; // SpinEdit9.Value;
  fMOX.Parts[SelectedTreeNode].TypeID := RGDetailType.ItemIndex;
  fMOX.Parts[SelectedTreeNode].x1 := LX1.Value / 180 * Pi; // -YZ rotation
  fMOX.Parts[SelectedTreeNode].x2 := LX2.Value / 180 * Pi; // -YZ rotation
  fMOX.Parts[SelectedTreeNode].y1 := LY1.Value / 180 * Pi; // -YZ rotation
  fMOX.Parts[SelectedTreeNode].y2 := LY2.Value / 180 * Pi; // -YZ rotation
  fMOX.Parts[SelectedTreeNode].z1 := LZ1.Value / 180 * Pi; // -YZ rotation
  fMOX.Parts[SelectedTreeNode].z2 := LZ2.Value / 180 * Pi; // -YZ rotation
  tvParts.Items[SelectedTreeNode - 1].Text := fMOX.Parts[SelectedTreeNode].Dname;
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
  //Shape2.Width:=32;

  fMOX.Clear;

  fMOX.Header.PartCount:=Imp.PartCount;
  fMOX.Header.MatCount:=Imp.SurfCount;

  TVParts.ReadOnly := False;
  FillChar(PartModify,SizeOf(PartModify),#0);

  RGPivotClick(nil);

  //Convert all unused vertices into blinkers later
  for i:=1 to Imp.VerticeCount do sprite[i] := True;
  for i:=1 to Imp.PolyCount do
  begin
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
    inc(fMOX.Header.PartCount);
  end;

  fMOX.Header.BlinkerCount := 0;
  for i:=1 to Imp.VerticeCount do
    if sprite[i] and (fMOX.Header.BlinkerCount < MAX_BLINKERS) then
    begin
      Inc(fMOX.Header.BlinkerCount);                                 //63+1=64
      with fMOX.Blinkers[fMOX.Header.BlinkerCount] do
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

  setlength(altpoint,fMOX.Header.PartCount+1);
  setlength(altpoly,fMOX.Header.PartCount+1);
  setlength(VqtyAtSurf,fMOX.Header.PartCount+1);
  setlength(PqtyAtSurf,fMOX.Header.PartCount+1);
  setlength(v2,fMOX.Header.PartCount+1);
  for i:=1 to fMOX.Header.PartCount do
  begin
    setlength(altpoint[i],fMOX.Header.MatCount+1);
    setlength(altpoly[i],fMOX.Header.MatCount+1);
    setlength(VqtyAtSurf[i],fMOX.Header.MatCount+1);
    setlength(PqtyAtSurf[i],fMOX.Header.MatCount+1);
    setlength(v2[i],fMOX.Header.MatCount+1);
  end;

  for m:=1 to fMOX.Header.PartCount do
  for i:=1 to Imp.PolyCount do
    if Imp.Part[i]=m then //for all polys belong to current part
    begin
      if i mod 1000 = 0 then
      begin
        //Shape2.Width:=round((i/Imp.PolyCount)*100);
//        Label35.Caption:=IntToStr(round((i/Imp.PolyCount)*100))+' %';
//        Label35.Repaint;
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
//  Shape2.Width:=100;

  h:=1;
  for m:=1 to fMOX.Header.PartCount do
  begin
    t:=1;
    for i:=1 to fMOX.Header.MatCount do
      for k:=1 to VqtyAtSurf[m,i] do
      begin
        fMOX.Vertice[h].X:=Imp.XYZ[altpoint[m,i,k,1]].X;
        fMOX.Vertice[h].Y:=Imp.XYZ[altpoint[m,i,k,1]].Y;
        fMOX.Vertice[h].Z:=Imp.XYZ[altpoint[m,i,k,1]].Z;
        fMOX.Vertice[h].nX:=Imp.Nv[altpoint[m,i,k,1]].X;
        fMOX.Vertice[h].nY:=Imp.Nv[altpoint[m,i,k,1]].Y;
        fMOX.Vertice[h].nZ:=Imp.Nv[altpoint[m,i,k,1]].Z;
        fMOX.Vertice[h].U:=Imp.DUV[altpoint[m,i,k,3],altpoint[m,i,k,2]].U;
        fMOX.Vertice[h].V:=1-Imp.DUV[altpoint[m,i,k,3],altpoint[m,i,k,2]].V;
        fMOX.Header.VerticeCount:=h;

        //Take 1st point of material as beginning for bounds checking
        if (t=1) then
        begin
          t:=0;
          PartModify[m].Low[1]:=fMOX.Vertice[h].X;
          PartModify[m].Low[2]:=fMOX.Vertice[h].Y;
          PartModify[m].Low[3]:=fMOX.Vertice[h].Z;
          PartModify[m].High[1]:=fMOX.Vertice[h].X;
          PartModify[m].High[2]:=fMOX.Vertice[h].Y;
          PartModify[m].High[3]:=fMOX.Vertice[h].Z;
        end;

        PartModify[m].Low[1]:=min(PartModify[m].Low[1],fMOX.Vertice[h].X);
        PartModify[m].Low[2]:=min(PartModify[m].Low[2],fMOX.Vertice[h].Y);
        PartModify[m].Low[3]:=min(PartModify[m].Low[3],fMOX.Vertice[h].Z);
        PartModify[m].High[1]:=max(PartModify[m].High[1],fMOX.Vertice[h].X);
        PartModify[m].High[2]:=max(PartModify[m].High[2],fMOX.Vertice[h].Y);
        PartModify[m].High[3]:=max(PartModify[m].High[3],fMOX.Vertice[h].Z);

        inc(h);
      end;
  end;

  SetLength(fMOX.Chunks, fMOX.Header.PartCount * fMOX.Header.MatCount + 1);
  h:=1;
  for m:=1 to fMOX.Header.PartCount do
  for i:=1 to fMOX.Header.MatCount do
  begin
    if h > 1 then
      fMOX.Chunks[h].FirstVtx := fMOX.Chunks[h-1].LastVtx+1
    else
      fMOX.Chunks[h].FirstVtx := 1;

    fMOX.Chunks[h].LastVtx:=fMOX.Chunks[h].FirstVtx+VqtyAtSurf[m,i]-1;
    fMOX.Header.ChunkCount := h;
    inc(h);
  end;
  SetLength(fMOX.Chunks, fMOX.Header.ChunkCount + 1);

  j:=1; t:=1;
  for m:=1 to fMOX.Header.PartCount do
    for i:=1 to fMOX.Header.MatCount do
    begin
      for k:=1 to PqtyAtSurf[m,i] do
      begin
        for h:=1 to 3 do fMOX.Face[j,h]:=v2[m,i,k,h]+fMOX.Chunks[t].FirstVtx-1;
        inc(j);
      end;
    inc(t);
    end;

  h:=1;
  for m:=1 to fMOX.Header.PartCount do
  begin
    fMOX.Parts[m].NumMat:=0;
    for i:=1 to fMOX.Header.MatCount do
    begin
      fMOX.Chunks[h].PolyCount:=PqtyAtSurf[m,i];
      if h>1 then fMOX.Chunks[h].FirstPoly:=fMOX.Chunks[h-1].FirstPoly+fMOX.Chunks[h-1].PolyCount else fMOX.Chunks[h].FirstPoly:=0;
      fMOX.Header.PolyCount := fMOX.Chunks[h].FirstPoly+fMOX.Chunks[h].PolyCount;
      inc(fMOX.Parts[m].NumMat);
      inc(h);
    end;
  end;

  for i:=1 to fMOX.Header.MatCount do
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

  for i:=1 to fMOX.Header.MatCount do for k:=2 to MAX_COLORS do
  Material[i].Color[k]:=Material[i].Color[1]; //Set all colors same
  LoadTextures;

  h:=1;
  for m:=1 to fMOX.Header.PartCount do
    for i:=1 to fMOX.Header.MatCount do
    begin
      fMOX.Chunks[h].SidA:=i-1;
      fMOX.Chunks[h].SidB:=i-1;
      inc(h);
    end;

  for i:=1 to fMOX.Header.MatCount do
  begin
    fMOX.MoxMat[i].ID:=i-1;
    for k:=1 to 332 do fMOX.MoxMat[i].xxx[k]:=#0;
  end;

  for i:=1 to fMOX.Header.PartCount do
  begin
    fMOX.Parts[i].Dname:=Imp.PartName[i];
    fMOX.Parts[i].Matrix[1,1]:=1;
    fMOX.Parts[i].Matrix[2,2]:=1;
    fMOX.Parts[i].Matrix[3,3]:=1;
    fMOX.Parts[i].Matrix[4,4]:=1;
    fMOX.Parts[i].Parent:=-1;
    fMOX.Parts[i].Child:=-1;
    fMOX.Parts[i].PrevInLevel:=-1;
    fMOX.Parts[i].NextInLevel:=-1;
    //fMOX.Parts[i].NumMat:=
    fMOX.Parts[i+1].FirstMat:=fMOX.Parts[i].FirstMat+fMOX.Parts[i].NumMat;

    fMOX.Parts[i].xMid:=PartModify[i].Low[1]+(PartModify[i].High[1]-PartModify[i].Low[1])/2;
    fMOX.Parts[i].yMid:=PartModify[i].Low[2]+(PartModify[i].High[2]-PartModify[i].Low[2])/2;
    fMOX.Parts[i].zMid:=PartModify[i].Low[3]+(PartModify[i].High[3]-PartModify[i].Low[3])/2;
    fMOX.Parts[i].fRadius:=(PartModify[i].High[1]-PartModify[i].Low[1])/3+
                        (PartModify[i].High[2]-PartModify[i].Low[2])/3+
                        (PartModify[i].High[3]-PartModify[i].Low[3])/3;
  end;

  setlength(altpoint,0); //Clear arrays entirely to avoid mismatch errors
  setlength(altpoly,0);
  setlength(v2,0);

  CompileLoadedMOX;

//  Label35.Caption := Floattostr(round((GetTickCount-OldTimeLWO)/100)/10)+' s';

  ActionsEnable(cuMOX);
  ActionsEnable(cuMTL);
  SetRenderObject([roMOX]);
  SetActivePage(apMTL);

  mnuSaveMOX.Enabled := True;
  bgSaveAs.ButtonEnabled[BG_SAVE_AS_MOX] := True;

  IsLightwave2MOX := True;
  PivotSetup.TabVisible := True;
end;


procedure TForm1.MatTexBrowseClick(Sender: TObject);
begin
  if MatID = 0 then Exit;
  if not RunOpenDialog2(odOpen, fOpenedFolder, 'Targa, PTX image files (*.ptx; *.tga)|*.tga;*.ptx') then Exit;

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

  fMOX.Blinkers[idx].Matrix[4,1] := fsBlinkerX.Value*10;
  fMOX.Blinkers[idx].Matrix[4,2] := fsBlinkerY.Value*10;
  fMOX.Blinkers[idx].Matrix[4,3] := fsBlinkerZ.Value*10;
  Angles2Matrix(fsBlinkerH.Value, fsBlinkerP.Value, fsBlinkerB.Value, @fMOX.Blinkers[idx].Matrix, 16);
end;


procedure TForm1.btnBlinkerAddClick(Sender: TObject);
begin
  fMOX.BlinkerAdd(LBBlinkers.ItemIndex+1);

  SendDataToUI(uiBlinkers);
end;


procedure TForm1.btnBlinkerRemClick(Sender: TObject);
begin
  if LBBlinkers.ItemIndex = -1 then Exit;

  fMOX.BlinkerRemove(LBBlinkers.ItemIndex + 1);

  if LBBlinkers.ItemIndex = -1 then
    LBBlinkers.ItemIndex := LBBlinkers.Count - 1;

  SendDataToUI(uiBlinkers);
  LBBlinkersClick(nil);
end;


procedure TForm1.BlinkCopyClick(Sender: TObject);
begin
  fLightCopyID := LBBlinkers.ItemIndex + 1;
  btnBlinkerPaste.Enabled := InRange(fLightCopyID, 1, fMOX.Header.BlinkerCount);
end;


procedure TForm1.BlinkPasteClick(Sender: TObject);
var
  idx: Integer;
begin
  idx := LBBlinkers.ItemIndex+1;
  if idx = 0 then Exit;

  if not InRange(fLightCopyID, 1, fMOX.Header.BlinkerCount) then
  begin
    btnBlinkerPaste.Enabled := False;
    Exit;
  end;

  fMOX.Blinkers[idx] := fMOX.Blinkers[fLightCopyID];

  SendDataToUI(uiBlinkers);
  LBBlinkersClick(nil);
end;


procedure TForm1.btnBlinkersLoadClick(Sender: TObject);
begin
  if not RunOpenDialog2(odOpen, '', 'MTKit2 Lights Setup Files (*.lsf)|*.lsf') then Exit;

  fMOX.BlinkersLoad(odOpen.FileName);
  SendDataToUI(uiBlinkers);
  btnBlinkerPaste.Enabled := False;
end;


procedure TForm1.btnBlinkersSaveClick(Sender: TObject);
begin
  if not RunSaveDialog(sdSave, fOpenedFileMask + '.lsf', '', 'MTKit2 Lights Setup Files (*.lsf)|*.lsf', 'lsf') then Exit;

  fMOX.BlinkersSave(sdSave.FileName);
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
  SetLength(order, fMOX.Header.PartCount + 1);
  for I := 1 to fMOX.Header.PartCount do
    for K := 1 to fMOX.Header.PartCount do
      if fMOX.Parts[I].Dname = TVParts.Items[K - 1].Text then
        order[K] := I;

  SetLength(exVertice, fMOX.Header.VerticeCount + 1);
  SetLength(exPolys, fMOX.Header.PolyCount + 1);
  SetLength(exChunk, fMOX.Header.MatCount * fMOX.Header.PartCount + 1);

  accPoly := 0; accVert := 0;
  for I := 1 to fMOX.Header.PartCount do
  begin
    aDname[i] := fMOX.Parts[order[i]].Dname;
    aParts[i].xMid := fMOX.Parts[order[i]].xMid;
    aParts[i].yMid := fMOX.Parts[order[i]].yMid;
    aParts[i].zMid := fMOX.Parts[order[i]].zMid;
    aParts[i].fRadius := fMOX.Parts[order[i]].fRadius;
    aParts[i].TypeID := fMOX.Parts[order[i]].TypeID;
    aParts[i].x1 := fMOX.Parts[order[i]].x1;
    aParts[i].x2 := fMOX.Parts[order[i]].x2;
    aParts[i].y1 := fMOX.Parts[order[i]].y1;
    aParts[i].y2 := fMOX.Parts[order[i]].y2;
    aParts[i].z1 := fMOX.Parts[order[i]].z1;
    aParts[i].z2 := fMOX.Parts[order[i]].z2;
    CopyMemory(@aPartModify[I], @PartModify[order[I]], 56); //55+1 !

    for K := 1 to fMOX.Header.MatCount do
    begin
      iDest := (I - 1) * fMOX.header.MatCount + K; // destination
      iSrc := (order[I] - 1) * fMOX.header.MatCount + K; // source

      exChunk[iDest].FirstPoly := accPoly;                                   //first poly
      exChunk[iDest].PolyCount := fMOX.Chunks[iSrc].PolyCount;             //poly count
      Inc(accPoly, fMOX.Chunks[iSrc].PolyCount);
      exChunk[iDest].FirstVtx := accVert+1;                                 //first point
      Inc(accVert, fMOX.Chunks[iSrc].LastVtx - fMOX.Chunks[iSrc].FirstVtx + 1);
      exChunk[iDest].LastVtx := accVert;                                   //last point

      for J := exChunk[iDest].FirstVtx to exChunk[iDest].LastVtx do
        CopyMemory(@exVertice[J], @fMOX.Vertice[fMOX.Chunks[iSrc].FirstVtx+(J-exChunk[iDest].FirstVtx)], 40);

      for J:=1 to exChunk[iDest].PolyCount do
      begin
        exPolys[exChunk[iDest].FirstPoly+J,1]:=fMOX.Face[fMOX.Chunks[iSrc].FirstPoly+J,1]+exChunk[iDest].FirstVtx-fMOX.Chunks[iSrc].FirstVtx;
        exPolys[exChunk[iDest].FirstPoly+J,2]:=fMOX.Face[fMOX.Chunks[iSrc].FirstPoly+J,2]+exChunk[iDest].FirstVtx-fMOX.Chunks[iSrc].FirstVtx;
        exPolys[exChunk[iDest].FirstPoly+J,3]:=fMOX.Face[fMOX.Chunks[iSrc].FirstPoly+J,3]+exChunk[iDest].FirstVtx-fMOX.Chunks[iSrc].FirstVtx;
      end;
    end;
  end;


  CopyMemory(@PartModify, @aPartModify, Length(PartModify) * 56); //55+1 !
  CopyMemory(@fMOX.Vertice[1], @exVertice[1], fMOX.Header.VerticeCount * SizeOf(fMOX.Vertice[1]));//XYZXYZUV00 of Single
  CopyMemory(@fMOX.Face[1], @exPolys[1], fMOX.Header.PolyCount * SizeOf(fMOX.Face[1]));                //1..3 of Word

  for I:=1 to fMOX.Header.ChunkCount do
  begin
    fMOX.Chunks[I].FirstPoly := exChunk[I].FirstPoly;
    fMOX.Chunks[I].PolyCount := exChunk[I].PolyCount;
    fMOX.Chunks[I].FirstVtx := exChunk[I].FirstVtx;
    fMOX.Chunks[I].LastVtx := exChunk[I].LastVtx;
  end;

  for I:=1 to fMOX.Header.PartCount do
  begin
    fMOX.Parts[I].Dname:=aDname[I];
    fMOX.Parts[I].xMid:=aParts[I].xMid;
    fMOX.Parts[I].yMid:=aParts[I].yMid;
    fMOX.Parts[I].zMid:=aParts[I].zMid;
    fMOX.Parts[I].fRadius:=aParts[I].fRadius;
    fMOX.Parts[I].TypeID:=aParts[I].TypeID;
    fMOX.Parts[I].x1:=aParts[I].x1; fMOX.Parts[I].x2:=aParts[I].x2;
    fMOX.Parts[I].y1:=aParts[I].y1; fMOX.Parts[I].y2:=aParts[I].y2;
    fMOX.Parts[I].z1:=aParts[I].z1; fMOX.Parts[I].z2:=aParts[I].z2;
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
      fMOX.Parts[I + 1].Parent := -1
    else // No parents
      fMOX.Parts[I + 1].Parent := TVParts.Items[I].Parent.AbsoluteIndex;

    if not TVParts.Items[I].HasChildren then
      fMOX.Parts[I + 1].Child := -1
    else // No childs
      fMOX.Parts[I + 1].Child := TVParts.Items[I].AbsoluteIndex + 1;

    if TVParts.Items[I].getPrevSibling <> nil then
      fMOX.Parts[I + 1].PrevInLevel := TVParts.Items[I].getPrevSibling.AbsoluteIndex
    else
      fMOX.Parts[I + 1].PrevInLevel := -1;

    if TVParts.Items[I].getNextSibling <> nil then
      fMOX.Parts[I + 1].NextInLevel := TVParts.Items[I].getNextSibling.AbsoluteIndex
    else
      fMOX.Parts[I + 1].NextInLevel := -1;
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
  btnCOBVerticePaste.Enabled := InRange(fCOBCopyItem, 0, fCOB.Head.PolyCount - 1);
end;


procedure TForm1.btnCOBVerticePasteClick(Sender: TObject);
var
  idx: Integer;
begin
  idx := LBCOBPoints.ItemIndex;
  if idx = -1 then Exit;

  if fCOBCopyItem <> EnsureRange(fCOBCopyItem, 0, fCOB.Head.PolyCount - 1) then
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
  if fColorCopyID <> EnsureRange(fColorCopyID, 1, fMOX.Header.MatCount) then
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
    Custom[1]:=fMOX.Vertice[idx+fMOX.Chunks[fMOX.Parts[SelectedTreeNode].FirstMat+1].FirstVtx-1].X;
    Custom[2]:=fMOX.Vertice[idx+fMOX.Chunks[fMOX.Parts[SelectedTreeNode].FirstMat+1].FirstVtx-1].Y;
    Custom[3]:=fMOX.Vertice[idx+fMOX.Chunks[fMOX.Parts[SelectedTreeNode].FirstMat+1].FirstVtx-1].Z;
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
  SavePSF(fMOX, sdSave.FileName);
  meLog.Lines.Add('PSF file closed');
end;


procedure TForm1.btnPSFLoadClick(Sender: TObject);
begin
  if TVParts.Items.Count<1 then Exit;
  //if Sender=PSFLoad then begin
  if not RunOpenDialog2(odOpen,'','MTKit2 Pivot Setup Files (*.psf)|*.psf') then Exit;
  meLog.Lines.Add('Reading PSF ...');
  if not LoadPSF(fMOX, odOpen.FileName) then Exit;
  meLog.Lines.Add('PSF file closed');
end;


procedure TForm1.btnPBFSaveClick(Sender: TObject);
begin
  if not RunSaveDialog(sdSave, fOpenedFileMask + '_colli.pbf', '', 'MTKit2 Part Behaviour Files (*.pbf)|*.pbf', 'pbf') then Exit;
  meLog.Lines.Add('Assigning PBF file ...');
  SavePBF(fMOX, sdSave.FileName);
  meLog.Lines.Add('PBF file closed');
end;


procedure TForm1.btnPBFLoadClick(Sender: TObject);
begin
  if not RunOpenDialog2(odOpen, '', 'MTKit2 Part Behaviour Files (*.pbf)|*.pbf') then Exit;

  meLog.Lines.Add('Reading PBF ...');
  LoadPBF(fMOX, odOpen.FileName);
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
  for i:=1 to fMOX.Header.MatCount do
    Material[i].Mtag:=IntToHex((i-1),4);
  SendDataToUI(uiMTL);
end;


procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  if TVParts.Selected = nil then Exit;

  SelectedTreeNode := TVParts.Selected.AbsoluteIndex + 1;
  with PartModify[SelectedTreeNode] do
  begin
    fMOX.Parts[SelectedTreeNode].xMid := (High[1] + Low[1]) / 2;
    fMOX.Parts[SelectedTreeNode].yMid := (High[2] + Low[2]) / 2;
    fMOX.Parts[SelectedTreeNode].zMid := (High[3] + Low[3]) / 2;
    fMOX.Parts[SelectedTreeNode].fRadius := (High[1] - Low[1]) / 3 + (High[2] - Low[2]) / 3 + (High[3] - Low[3]) / 3;
  end;
  CX.Value := fMOX.Parts[SelectedTreeNode].xMid;
  CY.Value := fMOX.Parts[SelectedTreeNode].yMid;
  CZ.Value := fMOX.Parts[SelectedTreeNode].zMid;
  CRad.Value := fMOX.Parts[SelectedTreeNode].fRadius;
end;


procedure TForm1.btnCOBRecomputeClick(Sender: TObject);
begin
  fCOB.RebuildBounds;
  SendDataToUI(uiCOB);
end;


procedure TForm1.FileListBox1Click(Sender: TObject);
begin
  fMOX.Clear;
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
  ActionsDisable(cuALL);

  if SameText(ExtractFileExt(aFilename), '.mox') then
  begin
    meLog.Lines.Add('Loading MOX ...');
    meLog.Lines.Add(aFilename);

    TVParts.ReadOnly := True;
    IsLightwave2MOX := False;
    PivotSetup.TabVisible := False;

    try
      fMOX.LoadMOX(aFilename);
    except
      on E: Exception do
        MessageBox(0, PChar(E.Message), 'Error', MB_OK or MB_ICONERROR);
    end;

    meLog.Lines.Add('MOX file closed');

    ActionsEnable(cuMOX);

    CompileLoadedMOX;

    mnuSaveMOX.Enabled := True;
    bgSaveAs.ButtonEnabled[BG_SAVE_AS_MOX] := True;
    mnuExportMOX1.Enabled := True;
    bgExport.ButtonEnabled[BG_EXPORT_MOX_LWO] := True;

    StatusBar1.Panels[0].Text := fMOX.MOXFormatInt + ' - ' + fMOX.MOXFormatStr;

    ActionsEnable(cuMOX);
    LoadMTL(ChangeFileExt(aFilename, '.mtl'), fMOX.Header.MatCount);
    LoadTextures;
    ScanVinyls(fOpenedFolder);
    ActionsEnable(cuMTL);
    SetRenderObject([roMOX]);
    if fCOB.LoadCOB(ChangeFileExt(aFilename, '_colli.cob')) then
    begin
      ActionsEnable(cuCOB);
      SetRenderObject([roMOX, roCOB]);
    end;
    if LoadCPO(ChangeFileExt(aFilename, '_colli.cpo')) then
    begin
      ActionsEnable(cuCPO);
      SetRenderObject([roMOX, roCPO]);
    end;
    if LoadCPO(ChangeFileExt(aFilename, '.cpo')) then
    begin
      ActionsEnable(cuCPO);
      SetRenderObject([roMOX, roCPO]);
    end;
    if aMode = lmLoadAndShow then
      SetActivePage(apMTL);
  end;

  if SameText(ExtractFileExt(aFilename), '.cob') then
  begin
    if not fCOB.LoadCOB(aFilename) then Exit;
    ActionsEnable(cuCOB);
    SetRenderObject([roCOB]);
    if aMode = lmLoadAndShow then SetActivePage(apCOB);
  end;

  if SameText(ExtractFileExt(aFilename), '.cpo') then
    if LoadCPO(aFilename) then
    begin
      SetRenderObject([roCPO]);
      ActionsEnable(cuCPO);
      if aMode = lmLoadAndShow then SetActivePage(apCPO);
    end;

  if SameText(ExtractFileExt(aFilename), '.tree') then
  begin
    fTree.LoadFromFile(aFilename);
    fTree.PrepareDisplayList;
    fTree.PrepareTextures(fOpenedFolder);
    ActionsEnable(cuTREE);
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
    ActionsEnable(cuCPO);
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

        fMOX.LoadMOX(slFiles[I]);
        slLog.Append(Format('%s'#9'%s'#9'%s'#9'%s'#9'%d'#9'%d'#9'%d'#9'%d'#9'%d'#9'%d',
          [fMOX.MOXFormatInt, fMOX.MOXFormatStr, 'OK  ', slFiles[i],
            fMOX.header.VerticeCount, fMOX.header.PolyCount,
            fMOX.header.ChunkCount, fMOX.header.MatCount,
            fMOX.header.PartCount, fMOX.header.BlinkerCount]));
      except
        on E: EExceptionTooNew do
          { We dont support newer formats yet };
        on E: Exception do
          slLog.Append(fMOX.MOXFormatInt + #9 + fMOX.MOXFormatStr + #9 + 'FAIL' + #9 + slFiles[I] + #9 + E.Message);
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
  if not RunOpenDialog2(odOpen, fOpenedFolder, FILE_TYPE_INFO[kftMox].Filter) then Exit;
  LoadFile(odOpen.FileName, lmLoadAndShow);
end;


procedure TForm1.LoadCOBClick(Sender: TObject);
begin
  if not RunOpenDialog2(odOpen,fOpenedFolder,'World Racing 2 collision files (*.cob)|*.cob') then Exit;
  LoadFile(odOpen.FileName, lmLoadAndShow);
end;


procedure TForm1.LoadCPOClick(Sender: TObject);
begin
  if not RunOpenDialog2(odOpen,fOpenedFolder,'Alarm for Cobra 11 Nitro collision files (*.cpo)|*.cpo') then Exit;
  LoadFile(odOpen.FileName, lmLoadAndShow);
end;


procedure TForm1.mnuLoadTREEClick(Sender: TObject);
begin
  if not RunOpenDialog2(odOpen, fOpenedFolder, FILE_TYPE_INFO[kftTree].Filter) then Exit;
  LoadFile(odOpen.FileName, lmLoadAndShow);
end;


procedure TForm1.SaveMOXClick(Sender: TObject);
begin
  if not RunSaveDialog2(sdSave, fOpenedFileMask + FILE_TYPE_INFO[kftMox].Ext, FILE_TYPE_INFO[kftMox].Filter) then Exit;

  meLog.Lines.Add('Saving MOX file ...');
  SaveMOX(sdSave.FileName);
  meLog.Lines.Add('MOX file written');
end;


procedure TForm1.mnuSaveMTLClick(Sender: TObject);
begin
  if not RunSaveDialog(sdSave, fOpenedFileMask+'.mtl','','World Racing Material files (*.mtl)|*.mtl','mtl') then Exit;
  meLog.Lines.Add('Saving MTL file ...');
  SaveMTL(sdSave.FileName, fMOX.Header.MatCount);
  meLog.Lines.Add('MTL file written');
end;


procedure TForm1.mnuSaveCOBClick(Sender: TObject);
begin
  if not RunSaveDialog(sdSave, fOpenedFileMask+'_colli.cob', '', 'World Racing 2 collision files (*.cob)|*.cob', 'cob') then Exit;

  fCOB.RebuildBounds;
  SendDataToUI(uiCOB);

  fCOB.SaveCOB(sdSave.FileName);
end;


procedure TForm1.mnuSaveCPOClick(Sender: TObject);
begin
  if not RunSaveDialog(sdSave, fOpenedFileMask+'.cpo','','World Racing 2 collision files (*.cpo)|*.cpo','cpo') then Exit;
  SaveCPO(sdSave.FileName);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.mnuImport3DSMOX1Click(Sender: TObject);
begin
  if not RunOpenDialog2(odOpen,fOpenedFolder,'3DMax object files (*.3ds)|*.3ds') then Exit;
  if not Load3DS(odOpen.FileName) then Exit;

  RebuildImpNormals;
  ConverseImp_MOX;
  UpdateOpenedFileInfo(odOpen.FileName)
end;

procedure TForm1.mnuImportOBJMOX1Click(Sender: TObject);
begin
  if not RunOpenDialog2(odOpen,fOpenedFolder,'OBJ object files (*.obj)|*.obj') then Exit;
  if not LoadOBJ(odOpen.FileName) then Exit;

  ConverseImp_MOX;
  UpdateOpenedFileInfo(odOpen.FileName)
end;

procedure TForm1.mnuImportLWO1Click(Sender: TObject);
begin
  if not RunOpenDialog2(odOpen,fOpenedFolder, FILE_TYPE_INFO[kftLwo].Filter) then Exit;
  if not LoadLWO(odOpen.FileName) then Exit;

  RebuildImpNormals;
  ConverseImp_MOX;
  UpdateOpenedFileInfo(odOpen.FileName);
end;


procedure TForm1.mnuImportLWO2Click(Sender: TObject);
begin
  mnuImportLWO1Click(nil);

  LoadMTL(fOpenedFileMask+'.mtl', fMOX.Header.MatCount);
  LoadTextures;
  ScanVinyls(fOpenedFolder);
  ActionsEnable(cuMTL);

  LoadPSF(fMOX, fOpenedFileMask+'.psf');
  LoadPBF(fMOX, fOpenedFileMask+'.pbf');
  ExchangePartsOrdering;
  RebuildPartsTree;
  fMOX.BlinkersLoad(fOpenedFileMask + '.lsf');

  SendDataToUI(uiBlinkers);
  btnBlinkerPaste.Enabled := False;
end;


procedure TForm1.mnuImportLWOCOB1Click(Sender: TObject);
begin
  if not RunOpenDialog2(odOpen, fOpenedFolder, FILE_TYPE_INFO[kftLwo].Filter) then Exit;

  try
    fCOB.ImportLWO(odOpen.Filename);

    ActionsEnable(cuCOB);
    SendDataToUI(uiCOB);
    SetRenderObject([roCOB]);
  except
    on E: Exception do
      MessageBox(Handle, PChar(E.Message), 'Error', MB_OK or MB_ICONERROR);
  end;
end;


procedure TForm1.mnuExportMOX1Click(Sender: TObject);
var
  doSpread: Boolean;
begin
  if not RunSaveDialog2(sdSave, fOpenedFileMask+'.lwo', FILE_TYPE_INFO[kftLwo].Filter) then Exit;

  meLog.Lines.Add('Writing MOX>LWO file');

  doSpread := MessageBox(Handle, 'Do you want to spread parts over X axis?', 'Question', MB_YESNO or MB_ICONQUESTION) = ID_YES;

  fMOX.SaveMOX2LWO(sdSave.FileName, ColID, doSpread);

  meLog.Lines.Add('MOX>LWO Save Complete');
end;


procedure TForm1.mnuExportCOB1Click(Sender: TObject);
begin
  if not RunSaveDialog2(sdSave, fOpenedFileMask + '_colli.lwo', FILE_TYPE_INFO[kftLwo].Filter) then Exit;
  meLog.Lines.Add('Writing COB>LWO file');
  fCOB.ExportLWO(sdSave.FileName);
  meLog.Lines.Add('COB>LWO Save Complete');
end;


procedure TForm1.ActionsDisable(aActions: TEditingActions);
begin
  RenderOptions.LightVec := False;
  RenderOptions.Colli := False;
  RenderOptions.Wire := False;
  RenderOptions.UVMap := False;
  RenderResize(nil);

  if aActions in [cuMOX, cuALL] then
  begin
    fMOX.Clear;
    bgSaveAs.ButtonEnabled[BG_SAVE_AS_MOX] := False;
    bgExport.ButtonEnabled[BG_EXPORT_MOX_LWO] := False;
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

  if aActions in [cuMTL, cuALL] then
  begin
    FillChar(Material,SizeOf(Material),#0);
    NumColors:=0;
    mnuSaveMTL.Enabled := False;
    bgSaveAs.ButtonEnabled[BG_SAVE_AS_MTL] := False;
    MatCopy.Enabled := False;
    MatPaste.Enabled := False;
    ResetMTLOrder.Enabled := False;
    CBMonoColor.Checked := False;
    SendDataToUI(uiMTL);
    SendDataToUI(uiVinyl);
  end;

  if aActions in [cuCOB, cuALL] then
  begin
    fCOB.Clear;
    btnShowColli.Down := False;
    btnShowColli.Enabled := False;
    mnuSaveCOB.Enabled := False;
    bgSaveAs.ButtonEnabled[BG_SAVE_AS_COB] := False;
    btnCOBVerticeCopy.Enabled := False;
    btnCOBVerticePaste.Enabled := False;
    mnuExportCOB1.Enabled := False;
    bgExport.ButtonEnabled[BG_EXPORT_COB_LWO] := False;
    SendDataToUI(uiCOB);
  end;

  if aActions in [cuCPO, cuALL] then
  begin
    FillChar(CPO,SizeOf(CPO),#0);
    FillChar(CPOHead,SizeOf(CPOHead),#0);
    btnShowColli.Down := False;
    btnShowColli.Enabled := False;
    mnuSaveCPO.Enabled := False;
    bgSaveAs.ButtonEnabled[BG_SAVE_AS_CPO] := False;
    SendDataToUI(uiCPO);
  end;

  if aActions in [cuTREE, cuALL] then
  begin
    fTree.Clear;
    btnShowWireframe.Down := False;
    btnShowWireframe.Enabled := False;
  end;
end;


procedure TForm1.ActionsEnable(aActions: TEditingActions);
begin
  if aActions = cuMOX then
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

  if aActions = cuMTL then
  begin
    mnuSaveMTL.Enabled := True;
    bgSaveAs.ButtonEnabled[BG_SAVE_AS_MTL] := True;
    MatCopy.Enabled := True;
    MatPaste.Enabled := False;
    ResetMTLOrder.Enabled := True;
    CBMonoColor.Checked:=NumColors=1;
    MatMonoColorClick(nil);
    SendDataToUI(uiMTL);
    SendDataToUI(uiVinyl);
  end;

  if aActions = cuCOB then
  begin
    btnShowColli.Enabled := True;
    mnuSaveCOB.Enabled := True;
    bgSaveAs.ButtonEnabled[BG_SAVE_AS_COB] := True;
    mnuExportCOB1.Enabled := True;
    bgExport.ButtonEnabled[BG_EXPORT_COB_LWO] := True;
    btnCOBVerticeCopy.Enabled := True;
    btnCOBVerticePaste.Enabled := False;
    SendDataToUI(uiCOB);
  end;

  if aActions = cuCPO then
  begin
    btnShowColli.Enabled := True;
    mnuSaveCPO.Enabled := True;
    bgSaveAs.ButtonEnabled[BG_SAVE_AS_CPO] := True;
    SendDataToUI(uiCPO);
  end;

  if aActions = cuTREE then
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
  blinker := fMOX.Blinkers[idx];

  TForm_ColorPicker2.Execute(
    blinker.R + blinker.G shl 8 + blinker.B shl 16,
    procedure(aColor: Cardinal)
    begin
      // Live preview
      shpBlinkerColor.Brush.Color := aColor;

      fMOX.Blinkers[idx].R := aColor mod 256;
      fMOX.Blinkers[idx].G := aColor div 256 mod 256;
      fMOX.Blinkers[idx].B := aColor div 65536;
      fMOX.Blinkers[idx].A := 255;

      Render;
    end,
    nil,
    procedure
    begin
      // Cancel - restore original color
      fMOX.Blinkers[idx] := blinker;
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
  filename: string;
begin
  filename := ExeDir + 'LoadOBJ\clkdtm.obj';
  //filename:=ExeDir+'LoadOBJ\oacwr2.obj';
  if not LoadOBJ(filename) then Exit;

  ConverseImp_MOX;
  UpdateOpenedFileInfo(filename);
end;


procedure TForm1.KnowScale(Sender: TObject);
var
  i: Integer;
  boundMin, boundMax: Single;
begin
  boundMin := MaxSingle;
  boundMax := -MaxSingle;
  for i := 1 to fMOX.Header.VerticeCount do
  begin
    boundMin := Min(boundMin, fMOX.Vertice[i].X, fMOX.Vertice[i].Y);
    boundMin := Min(boundMin, fMOX.Vertice[i].Z);
    boundMax := Max(boundMax, fMOX.Vertice[i].X, fMOX.Vertice[i].Y);
    boundMax := Max(boundMax, fMOX.Vertice[i].Z);
  end;

  zoom := Sqrt(5.5 / (boundMax - boundMin)); // 5.5 looks about right
end;


procedure TForm1.btnCPOImportClick(Sender: TObject);
var
  i,h,IDnew:Integer;
begin
  if not RunOpenDialog2(odOpen, fOpenedFolder, FILE_TYPE_INFO[kftLwo].Filter) then Exit;
  if not LoadLWO(odOpen.FileName) then Exit;

  if CPOHead.Qty >= MAX_CPO_SHAPES then Exit;

  if CPOHead.Qty = 0 then
  begin
    ActionsEnable(cuCPO);
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

  if not RunSaveDialog2(sdSave, fOpenedFileMask + '.lwo', FILE_TYPE_INFO[kftLwo].Filter) then
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
    lbCanvas.Brush.Color := fMOX.Blinkers[idx].R + fMOX.Blinkers[idx].G shl 8 + fMOX.Blinkers[idx].B shl 16;
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
