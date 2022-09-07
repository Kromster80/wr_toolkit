unit MTkit2_Unit1;
interface
uses
  Buttons, Classes, ComCtrls, Controls, Dialogs, ExtCtrls, FileCtrl, Forms,
  Graphics, INIFiles, Math, Menus, ShellCtrls, Spin, StdCtrls, SysUtils, Windows,

  dglOpenGL, FloatSpinEdit, KromOGLUtils, KromUtils, TGATexture, PTXTexture,

  MTkit2_Defaults, MTkit2_Render, MTkit2_RenderLegacy, MTkit2_IO;

type
  TForm1 = class(TForm)
    Open1: TOpenDialog;
    RenderPanel: TPanel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    About1: TMenuItem;
    LoadMOX1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet; TabSheet2: TTabSheet; TabSheet3: TTabSheet;
    TVParts: TTreeView;
    TabSheet5: TTabSheet;
    Label1: TLabel; Label2: TLabel; Label3: TLabel; Label4: TLabel; Label5: TLabel;
    Label6: TLabel; Label8: TLabel; Label9: TLabel; Label10: TLabel;
    Label11: TLabel; Label12: TLabel; Label13: TLabel; Label14: TLabel; Label17: TLabel; Label18: TLabel; Label19: TLabel; Label20: TLabel;
    Label21: TLabel; Label22: TLabel; Label24: TLabel; Label25: TLabel;
    Label26: TLabel; Label27: TLabel; Label28: TLabel; Label29: TLabel; Label30: TLabel; Label32: TLabel; Label33: TLabel; Label35: TLabel;
    Label36: TLabel; Label37: TLabel; Label38: TLabel; Label39: TLabel;
    Edit3Dqty: TEdit;
    EditUVqty: TEdit;
    EditPqty: TEdit;
    EditSqty: TEdit;
    CBColor: TComboBox;
    ETextureName: TEdit;
    CBClipU: TComboBox;
    TTransparency: TTrackBar;
    CBClipV: TComboBox;
    CBMatClass2: TComboBox;
    CBMatClass3: TComboBox;
    Memo1: TMemo;
    LBMaterials: TListBox;
    LBBlinkers: TListBox;
    RGBlinkType: TRadioGroup;
    FS1: TFloatSpinEdit;
    FS2: TFloatSpinEdit;
    FS3: TFloatSpinEdit;
    S2: TSpinEdit;
    FSX: TFloatSpinEdit;
    FSY: TFloatSpinEdit;
    FSZ: TFloatSpinEdit;
    MatName: TEdit;
    SaveMOX1: TMenuItem;
    Save1: TSaveDialog;
    ImportLWO1: TMenuItem;
    Shape1: TShape;
    SaveMTL1: TMenuItem;
    EditMqty: TEdit;
    Label41: TLabel;
    TexBrowse: TButton;
    CBShowMat: TCheckBox;
    CBShowLight: TCheckBox;
    CB1: TCheckBox; CB2: TCheckBox; CB3: TCheckBox; CB4: TCheckBox;
    Label44: TLabel;
    Label45: TLabel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    FSH: TFloatSpinEdit;
    FSP: TFloatSpinEdit;
    FSB: TFloatSpinEdit;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    AddBlink: TButton;
    RemBlink: TButton;
    LoadBlink: TButton;
    SaveBlink: TButton;
    BlinkerCopy: TSpeedButton;
    BlinkerPaste: TSpeedButton;
    Shape2: TShape;
    LoadCOB1: TMenuItem;
    SaveCOB1: TMenuItem;
    RGDetailType: TRadioGroup;
    EDetailName: TEdit;
    CBActDam: TCheckBox;
    CBMonoColor: TCheckBox;
    ImportLWOCOB1: TMenuItem;
    TabSheet4: TTabSheet;
    CBShowIDs: TCheckBox;
    LBCOBPoints: TListBox;
    COBCopy: TSpeedButton;
    COBPaste: TSpeedButton;
    COBX: TFloatSpinEdit;
    COBY: TFloatSpinEdit;
    COBZ: TFloatSpinEdit;
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
    SpeedButton2: TSpeedButton;
    PSFLoad: TButton;
    PSFSave: TButton;
    CBShowPart: TCheckBox;
    PBFLoad: TButton;
    PBFSave: TButton;
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
    B_COBRecompute: TButton;
    EditCqty: TEdit;
    EditBqty: TEdit;
    Label71: TLabel;
    Label72: TLabel;
    Extra1: TMenuItem;
    Label74: TLabel;
    Label76: TLabel;
    RGActBlink: TRadioGroup;
    LoadCPO1: TMenuItem;
    Label23: TLabel;
    TabSheet6: TTabSheet;
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
    ShapeL: TShape;
    Button4: TButton;
    ShapeBG: TShape;
    FPSLimitEdit: TFloatSpinEdit;
    ComboBox1: TComboBox;
    Label7: TLabel;
    Label40: TLabel;
    Label42: TLabel;
    Lightvectors1: TMenuItem;
    TabSheet7: TTabSheet;
    LBCPOShapes: TListBox;
    CPOX: TFloatSpinEdit;
    CPOY: TFloatSpinEdit;
    CPOZ: TFloatSpinEdit;
    Label53: TLabel;
    Label52: TLabel;
    Label50: TLabel;
    CPOAdd: TButton;
    CPORem: TButton;
    CPOCopy: TSpeedButton;
    CPOPaste: TSpeedButton;
    CPOSX: TFloatSpinEdit;
    Label54: TLabel;
    CPOSY: TFloatSpinEdit;
    Label77: TLabel;
    Label78: TLabel;
    CPOSZ: TFloatSpinEdit;
    CPORH: TFloatSpinEdit;
    CPORP: TFloatSpinEdit;
    CPORB: TFloatSpinEdit;
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
    SB_Light: TSpeedButton;
    SB_Colli: TSpeedButton;
    SB_Wire: TSpeedButton;
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
    SB_UVmap: TSpeedButton;
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
    B_CPOImport: TButton;
    B_CPOExport: TButton;
    Label16: TLabel;
    Bevel1: TBevel;
    Bevel4: TBevel;
    Button2: TButton;
    cbAskOnClose: TCheckBox;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RenderFrame(Sender:TObject);
    procedure LoadTextures;
    function TryToLoadTexture(const aFilename: string):cardinal;
    procedure SendDataToUI(Sender:uiSendDataToUI);
    procedure CompileLoaded(Typename:string);
    procedure RenderResize(Sender: TObject);
    procedure LoadMOX(const aFilename: string);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LBBlinkersClick(Sender: TObject);
    procedure BlinkChange(Sender: TObject);
    procedure CBColorChange(Sender: TObject);
    procedure LBMaterialsClick(Sender: TObject);
    procedure MaterialPropertiesChange(Sender: TObject);
    procedure MatNameChange(Sender: TObject);
    procedure TVPartsChange(Sender: TObject; Node: TTreeNode);
    procedure MatEdSetAllColorsToCurrent(Sender: TObject);
    procedure SaveMOX(const aFilename: string);
    procedure MatTexReloadClick(Sender: TObject);
    procedure CBChromeClick(Sender: TObject);
    procedure PartTypeChange(Sender: TObject);
    procedure ImportLWO1Click(Sender: TObject);
    procedure UpdateOpenedFileInfo(const aFilename: string);
    procedure ConverseImp_MOX;
    procedure ConverseImp_COB;
    procedure RebuildCOBBounds;
    procedure SaveMTL1Click(Sender: TObject);
    procedure MatTexBrowseClick(Sender: TObject);
    procedure BlinkPositionChange(Sender: TObject);
    procedure BlinkAddClick(Sender: TObject);
    procedure BlinkRemoveClick(Sender: TObject);
    procedure BlinkCopyClick(Sender: TObject);
    procedure BlinkPasteClick(Sender: TObject);
    procedure SaveBlinkClick(Sender: TObject);
    procedure LoadBlinkClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure LoadCOBClick(Sender: TObject);
    procedure SaveCOB1Click(Sender: TObject);
    procedure TVPartsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure TVPartsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure RebuildPartsTree;
    procedure ExchangePartsOrdering;
    procedure MatMonoColorClick(Sender: TObject);
    procedure ImportLWOCOB1Click(Sender: TObject);
    procedure CoBCopyClick(Sender: TObject);
    procedure COBPasteClick(Sender: TObject);
    procedure LBCOBPointsClick(Sender: TObject);
    procedure COBXChange(Sender: TObject);
    procedure ExportMOX1Click(Sender: TObject);
    procedure ExportCOB1Click(Sender: TObject);
    procedure MatCopyClick(Sender: TObject);
    procedure MatPasteClick(Sender: TObject);
    procedure RGPivotClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure PSFSaveClick(Sender: TObject);
    procedure PSFLoadClick(Sender: TObject);
    procedure PBFSaveClick(Sender: TObject);
    procedure PBFLoadClick(Sender: TObject);
    procedure CBActDamClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SB_RenderOpts(Sender: TObject);
    procedure ImportLWO2Click(Sender: TObject);
    procedure ResetMTLOrderClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure B_COBRecomputeClick(Sender: TObject);
    procedure LoadMOXClick(Sender: TObject);
    procedure LoadCPOClick(Sender: TObject);
    procedure FileListBox1Click(Sender: TObject);
    function  LoadFile(const aFilename: string; lm: TLoadMode):Boolean;
    procedure PageControl1Change(Sender: TObject);
    procedure SetActivePage(ap:apActivePage);
    procedure SetRenderObject(ro:roRenderObject);
    procedure ResetView(Sender: TObject);
    procedure CBRenderModeChange(Sender: TObject);
    procedure ShapeAMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ShapeADragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure FPSLimitEditChange(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LBCPOShapesClick(Sender: TObject);
    procedure Lightvectors1Click(Sender: TObject);
    procedure CPOChange(Sender: TObject);
    procedure CPOAddClick(Sender: TObject);
    procedure CPORemClick(Sender: TObject);
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
    procedure B_CPOImportClick(Sender: TObject);
    procedure B_CPOExportClick(Sender: TObject);
    procedure LBBlinkersDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    procedure LoadSettingsFromIni(const aFilename: string);
    procedure SaveSettingsToIni(const aFilename: string);
    procedure OnIdle(Sender: TObject; var Done: Boolean);
  end;

const
  VersionInfo = 'Mesh ToolKit 2.3.9 (09 Mar 2022)';
  FPS_INTERVAL: Cardinal = 1000;               // Calculate FPS every ---- ms
  MAX_MATERIALS = 255;
  MAX_COLORS = 15;
  MAX_BLINKERS = 128;
  MAX_PARTS = 255;
  MAX_CPO_SHAPES = 12;
  MAX_READ_BUFFER = 262144;

var
  Form1: TForm1;
  s,s2,chname:AnsiString;            //Strings

  //OpenGL variables
  h_DC: HDC;
  h_RC: HGLRC;
  FPSLag:Word=33;
  OldTimeFPS,OldTimeRC,OldTimeLWO,OldFrameTimes,FrameCount:cardinal;
  UseShaders:Boolean;
  EnvTexture,SpecTexture,Spec2Texture:glUint;
  DirtTex,ScratchTex:glUint;
  FlameTex,LensFlareTex,DummyTex,SelectionTex:glUint;
  Dummy,Pivot,BBox,BBoxW,Center,FlameSprite,Sprite1Side,Sprite2Side,SelectionSphere:glUint;
  MoxCall,MoxUVCall: array [1..16384]of Word;
  MoxTex: array [1..256]of glUint;
  TreeCall:Integer;
  TreeTex: array [1..2]of glUint;
  BGColor: array [1..3]of Byte;
  WFColor: array [1..3]of Byte;

  //Viewport controls
  xMov,yMov:Single;
  XRot:Single=25;
  YRot:Single=20;
  zoom: Single=0.3125;
  CursorClick:TPoint;
  MouseX,MouseY:Integer;
  OldX:Integer;

  RenderOpts:record
    ShowPart:Boolean;
    ShowMaterial:Integer;
    ShowDamage:Boolean;
    PartsFlapPos:Single;
    LightVec,Colli,Wire,UVMap:Boolean;
  end;

  Opened3DMask:string; //Opened3DFileNameMask
  OpenedFolder:string; //OpenedFolderMask
  ExeDir:string;
  ActivePage:apActivePage;
  RenderMode:rmRenderMode=rmOpenGL;
  RenderObject:roRenderObject;
  CameraAction:string='';

  MatID,ColID,LitID:Integer;
  LightCopyID:Integer;
  ColorCopyID:Integer;
  COBCopyItem:Integer;
  SelectedTreeNode:Integer;
  DefColor:Byte; //Yellow

  COB: record
    Head: record
      PointQty,PolyQty: Integer;
      X,Y,Z,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax: Single;
    end;
    Vertices: array [1..256] of Vector3f;
    NormalsP: array [1..256] of Vector3f;
    Faces: array [1..256,1..3] of Word;   //Polygon links
  end;

  CPOHead: record
    Head: array [1..4] of AnsiChar;
    Qty,x1,x2,x3: Integer;
  end;
  CPO: array [1..MAX_CPO_SHAPES]of record
    Format:Integer; //2 possible types 2-box 3-shape
    PosX,PosY,PosZ:Single;
    ScaleX,ScaleY,ScaleZ:Single;
    Matrix9: array [1..9]of Single;
    VerticeCount,PolyCount,IndiceSize,Clear1:Integer;
    Vertices: array [1..256]of Vector3f;
    Indices: array [1..512]of Word;
  end;

type
  TMatrix = array [1..4,1..4] of Single;

var
  MOX: record
    Qty: record Vertice,Poly,Chunks,Mat,Parts,Blink: Integer; end;
    Vertice: array [1..65280] of record X,Y,Z,nX,nY,nZ,U,V,x1,x2: Single; end;
    Face: array [1..65280,1..3] of Word;   //Polygon links
    Chunk: array [1..2048,1..4] of Word; //Surface ranges (points/polys) 40parts*40materials
    Sid: array [1..2048,1..2] of Word;
    MoxMat: array [1..1024] of record
      ID: Integer;
      xxx: array [1..332] of AnsiChar;
    end;
    Parts: array [1..MAX_PARTS] of record
      Dname: string[64];
      Matrix: TMatrix;
      Parent,Child,PrevInLevel,NextInLevel: smallint;
      FirstMat,NumMat: Word;
      xMid,yMid,zMid,fRadius: Single;
      w1,w2,w3: smallint;
      TypeID: smallint;
      x1,x2,y1,y2,z1,z2: Single;
      w4,w5: Integer;
    end;
    Blinkers: array [1..MAX_BLINKERS]of record
      TypeID: Integer;                      //4 Type of object
      sMin,sMax,Freq: Single;               //Min,Max
      B,G,R,A: Byte;                //20
      z1,Parent: smallint;                      //24
      Matrix: TMatrix;  //88
    end;
  end;

  BlinkWrite: array [1..MAX_BLINKERS] of Byte;

  //This should be universal exchange format in MTKit2
  Imp: record
    VerticeCount,PolyCount,SurfCount,PartCount: Integer;
    XYZ: array [1..65280] of Vector3f;
    Np: array [1..65280] of Vector3f;
    Nv: array [1..65280] of Vector3f;
    UV: array [1..65280] of Vector2f;
    DUV: array [1..65280,1..4] of Vector2f; //poly.point.value
    Faces: array [1..65280,1..4]of Word;    //Polygon links
    Surf: array [1..65280]of Word;
    Part: array [1..65280]of Word;
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
  Material: array [1..MAX_MATERIALS]of record
   Mtag:string[4];//Material tag (#_0x----)
   Title:string;
   MatClass: array [1..4]of Integer;     //Material class selector (by index)
   Color: array [1..20]of record
     Amb,Dif,Sp1,Sp2,Ref:record
       R,G,B:Byte;
     end;
   end;
   Transparency:Byte;
   TexName:string;
   TexEdge:record U:Byte; V:Byte; end;
   TexOffset,TexScale:record U:Single; V:Single; end;
   TexAngle:Single;
  end;

  VinylsCount:Integer;
  VinylsTex:GLUint;
  VinylsList: array [1..128]of string;

  PartModify: array [1..MAX_PARTS]of record
   ActualPoint:Integer;
   AxisSetup: array [1..3]of Byte;
   Low: array [1..3]of Single;
   High: array [1..3]of Single;
   Custom: array [1..3]of Single;
   Move: array [1..3]of Single;
  end;


  //TreeViewExchange
  kp,kv,i1,i2:Integer; order: array [1..MAX_PARTS] of Integer;
  aDname: array [1..MAX_PARTS]of string;
  aPartModify: array [1..MAX_PARTS]of record ActualPoint:Integer; AxisSetup: array [1..3]of Byte; Low: array [1..3]of Single; High: array [1..3]of Single; Custom: array [1..3]of Single; Move: array [1..3]of Single; end;
  aParts: array [1..MAX_PARTS]of record xMid,yMid,zMid,fRadius:Single; TypeID:smallint; x1,x2,y1,y2,z1,z2:Single; end;
  aSRange: array [1..2048,1..4]of Word;
  aVertex: array [1..65280] of record X,Y,Z,nX,nY,nZ,U,V,x1,x2: Single; end; //40Bytes
  av: array [1..65280,1..3] of Word;                                         //6Bytes


  Tree: record
    header: array [1..4] of AnsiChar;
    NumVertex, NumLeaves, NumIndices: Integer;
  end;
  TreeTexNames: array [1..2] of string;
  TreeLOD: array [1..3] of record First,Count,Offset,PolyCount: Integer; end;
  TreeChunks: array [1..20] of Integer;
  TreeVertex: array [1..16384] of record X,Y,Z,nX,nY,nZ,U,V: Single; end;
  TreePoly: array [1..16384,1..3] of Word;
  TreeLeaves: array [1..1024] of record X,Y,Z: Single; R,G,B,A: Byte; end;
  TreeHeight: Integer;

  RenderChrome: Boolean;
  IsLightwave2MOX: Boolean=False;
  COBRefresh: Boolean=False;
  CPORefresh: Boolean=False;
  LightRefresh: Boolean=True;
  MaterialRefresh: Boolean=True;
  ForbidPartsChange: Boolean=True;
  ForbidPivotChange: Boolean=False;

implementation
uses
  ColorPicker;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  aFilename: string;
begin
  aFilename := ParamStr(1); //Get filename parameter
  ExeDir := ExtractFilePath(Application.ExeName);
  Memo1.Lines.Add(aFilename);
  Caption := VersionInfo;

  LoadSettingsFromIni(ExeDir + 'MTKit2 Data\options.ini');
  SetRenderFrame(RenderPanel.Handle);
  Memo1.Lines.Add('Basic OpenGL init complete');

  BuildFont(h_DC, 20);
  RenderInit;
  RenderResize(nil);
  CompileCommonObjects;
  UseShaders := LoadFresnelShader;
  if UseShaders then Memo1.Lines.Add('Shaders loaded');

  PivotSetup.TabVisible := False;
  Application.OnIdle := OnIdle;
  PageControl1Change(nil); //update ActivePage
  CBRenderModeChange(nil); //update RenderMode
  FormatSettings.DecimalSeparator := '.';

  ClearUpClick(cuALL);

  if not FileExists('krom.dev') then SetActivePage(apMTL);
  //aFilename:='E:\World Racing 2\AddOns\Autos\3000gt\3000gt.mox';
  //aFilename:='alfa147.mox';
  //aFilename:='E:\WR2 Demo Skoda\Autos\octavia_rs\octavia_rs.mox';
  //aFilename:=ExeDir+'CPO Collection\Schirm_gelb.cpo';
  //aFilename:='D:\a.tree';
  //aFilename:='demo8.mox';

  //Open it through browser
  if FileExists(aFilename) then
  begin
    FileListBox1.FileName := aFilename;
    FileListBox1Click(nil);
  end else
    OpenedFolder := ExeDir;

  DoClientAreaResize(Form1);
end;

procedure TForm1.LoadSettingsFromIni(const aFilename: string);
var
  iniFile: TIniFile;
begin
  Memo1.Lines.Add('Reading options.ini ...');
  iniFile := TIniFile.Create(aFilename);

  BGColor[1] := iniFile.ReadInteger('Background color', 'R', 128);
  BGColor[2] := iniFile.ReadInteger('Background color', 'G', 128);
  BGColor[3] := iniFile.ReadInteger('Background color', 'B', 128);
  ShapeBG.Brush.Color := BGColor[1] + BGColor[2] shl 8 + BGColor[3] shl 16;

  WFColor[1] := iniFile.ReadInteger('Wireframe color', 'R', 255);
  WFColor[2] := iniFile.ReadInteger('Wireframe color', 'G', 255);
  WFColor[3] := iniFile.ReadInteger('Wireframe color', 'B', 255);
  ShapeWF.Brush.Color := WFColor[1] + WFColor[2] shl 8 + WFColor[3] shl 16;

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
  Memo1.Lines.Add('Writing options.ini ...');
  iniFile := TIniFile.Create(aFilename);

  iniFile.WriteInteger('Background color', 'R', BGColor[1]);
  iniFile.WriteInteger('Background color', 'G', BGColor[2]);
  iniFile.WriteInteger('Background color', 'B', BGColor[3]);

  iniFile.WriteInteger('Wireframe color', 'R', WFColor[1]);
  iniFile.WriteInteger('Wireframe color', 'G', WFColor[2]);
  iniFile.WriteInteger('Wireframe color', 'B', WFColor[3]);

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
  if not Form1.Active and not Form_ColorPicker.Active then Exit;
  if CameraAction <> '' then Exit;

  Done := False;
  frameTime := GetTickCount - OldTimeFPS;
  OldTimeFPS := GetTickCount;
  if (FPSLag <> 1) and (frameTime < FPSLag) then
  begin
    Sleep(FPSLag - frameTime);
    frameTime := FPSLag;
  end;

  if frameTime > 1000 then
    frameTime := 1000;
  OldFrameTimes := OldFrameTimes + frameTime;
  Inc(FrameCount);
  if OldFrameTimes >= FPS_INTERVAL then
  begin
    StatusBar1.Panels[1].Text :=
      FloatToStr(Round((1000 / (OldFrameTimes / FrameCount)) * 10) / 10) + ' fps (' + IntToStr(1000 div FPSLag) + ')';
    OldFrameTimes := 0;
    FrameCount := 0;
  end; // FPS calculation complete

  RenderFrame(nil);
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
  wglMakeCurrent(h_DC, 0);
  wglDeleteContext(h_RC);
end;


procedure TForm1.LoadMOX(const aFilename: string);
var
  c: array [1..MAX_READ_BUFFER] of AnsiChar;
  h,i,j,k: Integer;
  f: file;
  vv: array [1..65280,1..3] of longWord;
  MOXFormat: string;
begin
  if not fileexists(aFilename) then Exit;

  Memo1.Lines.Add('Loading MOX ...');
  Memo1.Lines.Add(aFilename);

  assignfile(f,aFilename); FileMode:=0; reset(f,1); FileMode:=2;

  FillChar(MOX,SizeOf(MOX),#0);

  blockread(f,c,8);

  if c[1]+c[2]+c[3]+c[4]<>('!XOM') then
  begin
    MessageBox(Handle, PChar('Unknown format - '+c[1]+c[2]+c[3]+c[4]), 'Error', MB_OK or MB_ICONERROR);
    closefile(f);
    Exit;
  end;

  if c[6]+c[7]+c[8]=(#0+#2+#2) then MOXFormat:='WR22' else //32bit chunks, parts, blinkers
  if c[6]+c[7]+c[8]=(#0+#0+#2) then MOXFormat:='WR02' else //32bit chunks
  if c[6]+c[7]+c[8]=(#0+#1+#0) then MOXFormat:='MBWR' else //16bit chunks
  begin
    MessageBox(Handle, PChar('Unknown version - '+IntToStr(ord(c[1]))+IntToStr(ord(c[2]))+IntToStr(ord(c[3])) + IntToStr(ord(c[4]))), 'Error', MB_OK or MB_ICONERROR);
    closefile(f);
    Exit;
  end;

  TVParts.ReadOnly:=True;
  IsLightwave2MOX:=False;
  PivotSetup.TabVisible:=False;

  blockread(f,MOX.Qty,24);

  blockread(f,MOX.Vertice,MOX.Qty.Vertice*40);

  Memo1.Lines.Add('Loading polygons ...');
  for i:=1 to MOX.Qty.Poly do
  if c[5]=#1 then
  begin
    blockread(f,vv[i],12);
    MOX.Face[i,1]:=vv[i,1]+1;
    MOX.Face[i,2]:=vv[i,2]+1;
    MOX.Face[i,3]:=vv[i,3]+1
  end else begin
    blockread(f,MOX.Face[i],6);
    inc(MOX.Face[i,1],1); inc(MOX.Face[i,2],1); inc(MOX.Face[i,3],1);
  end;

  Memo1.Lines.Add('Loading surface assignments ...');
  if MOXFormat='MBWR' then
  for j:=1 to MOX.Qty.Chunks do
  begin
    blockread(f,c,12);
    MOX.Sid[j,1]:=ord(c[1])+ord(c[2])*256;
    MOX.Sid[j,2]:=ord(c[3])+ord(c[4])*256;
    MOX.Chunk[j,1]:=ord(c[5])+ord(c[6])*256; //first Poly
    MOX.Chunk[j,2]:=ord(c[7])+ord(c[8])*256; //number Polys
    MOX.Chunk[j,3]:=ord(c[9])+ord(c[10])*256+1; //point From
    MOX.Chunk[j,4]:=ord(c[11])+ord(c[12])*256+1; //point Till
  end;

  if (MOXFormat='WR22')or(MOXFormat='WR02') then
  for j:=1 to MOX.Qty.Chunks do
  begin
    blockread(f,c,24);
    MOX.Sid[j,1]:=ord(c[1])+ord(c[2])*256;
    MOX.Sid[j,2]:=ord(c[5])+ord(c[6])*256;
    MOX.Chunk[j,1]:=ord(c[9])+ord(c[10])*256; //first Poly
    MOX.Chunk[j,2]:=ord(c[13])+ord(c[14])*256; //number Polys
    MOX.Chunk[j,3]:=ord(c[17])+ord(c[18])*256+1; //point From
    MOX.Chunk[j,4]:=ord(c[21])+ord(c[22])*256+1; //point Till
  end;

  blockread(f,MOX.MoxMat,(80+256)*MOX.Qty.Mat);   //Crap&Mess

  Memo1.Lines.Add('Reading Parts ...');

  if MOXFormat='WR22' then
    for j:=1 to MOX.Qty.Parts do begin
      blockread(f,c,64);
      MOX.Parts[j].Dname:=PAnsiChar(@c[1]);
      blockread(f,MOX.Parts[j].Matrix,132);
    end;

  if (MOXFormat='MBWR')or(MOXFormat='WR02') then
  begin
    MOX.Qty.Parts:=1;
    FillChar(MOX.Parts[1],SizeOf(MOX.Parts[1]),#0);
    with MOX.Parts[1] do
    begin
      Dname:='Default';
      Matrix[1,1]:=1; Matrix[2,2]:=1; Matrix[3,3]:=1; Matrix[4,4]:=1;
      Parent:=-1;
      Child:=-1;
      PrevInLevel:=-1;
      NextInLevel:=-1;
      FirstMat:=0;
      NumMat:=MOX.Qty.Mat;
      fRadius:=10;
    end;
  end;

  Memo1.Lines.Add('Reading Blinkers ...');
  if MOX.Qty.Blink > MAX_BLINKERS then
  begin
    MOX.Qty.Blink := MAX_BLINKERS;
    MessageBox(Handle, PChar('Blinker quantity limited to '+IntToStr(MAX_BLINKERS)+' due to compatibility issues.'), 'Warning', MB_OK or MB_ICONWARNING);
  end;
  if MOXFormat='WR22' then blockread(f,MOX.Blinkers,88*MOX.Qty.Blink);
  closefile(f);
  Memo1.Lines.Add('MOX file closed');

  ShowUpClick(cuMOX);

  CompileLoaded('MOX');

  SaveMOX1.Enabled := True;
  ExportMOX1.Enabled := True;
end;

procedure TForm1.Button4Click(Sender: TObject); begin {Placeholder} end;

procedure TForm1.SendDataToUI(Sender:uiSendDataToUI);
var
  ii:Integer;
  oldID1:Integer;
begin
  case Sender of
    uiMOX:    begin
                Edit3Dqty.Text:=IntToStr(MOX.Qty.Vertice);
                EditUVqty.Text:=IntToStr(MOX.Qty.Vertice);
                EditPqty.Text:=IntToStr(MOX.Qty.Poly);
                EditSqty.Text:=IntToStr(MOX.Qty.Parts);
                EditMqty.Text:=IntToStr(MOX.Qty.Mat);
                EditCqty.Text:=IntToStr(MOX.Qty.Chunks);
                EditBqty.Text:=IntToStr(MOX.Qty.Blink);
              end;
    uiMTL:    begin
                LBMaterials.Clear;
                for ii:=1 to MOX.Qty.Mat do
                  LBMaterials.AddItem(Material[ii].Mtag+' '+Material[ii].Title,nil);
                LBMaterials.ItemIndex:=0;
                if NumColors=1 then
                  CBColor.ItemIndex:=0
                else
                  CBColor.ItemIndex:=DefColor;
                LBMaterialsClick(nil);
              end;
    uiVin:    begin
                CBVinyl.Clear;
                CBVinyl.AddItem('-Default-', nil);
                for ii:=1 to VinylsCount do
                  CBVinyl.AddItem(VinylsList[ii], nil);
                CBVinyl.ItemIndex:=0;
              end;
    uiLights: begin
                LightRefresh:=True;
                oldID1:=LBBlinkers.ItemIndex;
                LBBlinkers.Clear;
                for ii:=1 to MOX.Qty.Blink do
                  LBBlinkers.Items.Add(IntToStr(ii)+'. '+BLINKER_TYPE_SHORTNAME[MOX.Blinkers[ii].TypeID]+'  '+
                    FloatToStrF(MOX.Blinkers[ii].sMin,ffGeneral,5,7)+'->'+
                    FloatToStrF(MOX.Blinkers[ii].sMax,ffGeneral,5,7)+'  '+
                    IntToStr(MOX.Blinkers[ii].Parent)
                    );
                if oldID1<LBBlinkers.Count then LBBlinkers.ItemIndex:=oldID1;
                LightRefresh:=False;
              end;
    uiParts:  begin
                TVParts.Items.Clear;
                for ii:=1 to MOX.Qty.Parts do
                begin
                  if MOX.Parts[ii].Parent=-1 then Dnode[ii]:=TVParts.Items.Add(nil,MOX.Parts[ii].Dname) else //make Root
                  Dnode[ii]:=TVParts.Items.AddChild(Dnode[MOX.Parts[ii].Parent+1],MOX.Parts[ii].Dname);      //child
                end;
                if MOX.Qty.Parts>=1 then Dnode[1].Expand(False);
              end;
    uiCOB:    begin
                COBRefresh:=True;
                oldID1:=LBCOBPoints.ItemIndex;
                LBCOBPoints.Clear;
                LBCPOShapes.Clear;
                for ii:=1 to COB.Head.PointQty do LBCOBPoints.Items.Add(IntToStr(ii));
                LBCOBPoints.ItemIndex:=EnsureRange(oldID1,0,LBCOBPoints.Count-1);
                COBRefresh:=False;
                COB_X.Value:=COB.Head.X; COB_Y.Value:=COB.Head.Y; COB_Z.Value:=COB.Head.Z;
                COB_X1.Value:=COB.Head.Xmin; COB_Y1.Value:=COB.Head.Ymin; COB_Z1.Value:=COB.Head.Zmin;
                COB_X2.Value:=COB.Head.Xmax; COB_Y2.Value:=COB.Head.Ymax; COB_Z2.Value:=COB.Head.Zmax;
              end;
    uiCPO:    begin
                CPORefresh:=True;
                oldID1:=LBCPOShapes.ItemIndex;
                LBCPOShapes.Clear;
                for ii:=1 to CPOHead.Qty do
                  case  CPO[ii].Format of
                    2: LBCPOShapes.Items.Add('Bound #'+IntToStr(ii));
                    3: LBCPOShapes.Items.Add('Shape #'+IntToStr(ii)+' '+IntToStr(CPO[ii].IndiceSize div 2));
                    else LBCPOShapes.Items.Add('Unknown #'+IntToStr(ii));
                  end;
                CPORefresh:=False;
                LBCPOShapes.ItemIndex:=EnsureRange(oldID1,0,LBCPOShapes.Count-1);
                LBCPOShapesClick(nil);
                Label82.Caption:='Shapes: '+IntToStr(CPOHead.Qty);
              end;
  end;
end;

procedure TForm1.CompileLoaded(Typename: string);
var
  h,i,k,LOD:Integer;
  t:Single;
begin
  if Typename='MOX' then
  begin
    for i:=1 to MOX.Qty.Chunks do
    begin
      if MoxCall[i]=0 then MoxCall[i]:=glGenLists(1);
      glNewList (MoxCall[i], GL_COMPILE);
      glbegin (gl_triangles);
        for k:=1 to MOX.Chunk[i,2] do  //1..number polys
        for h:=3 downto 1 do begin
          glTexCoord2fv(@MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,h]].U);
          glNormal3fv(@MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,h]].nX);
          glVertex3fv(@MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,h]].X);
        end;
      glEnd;
      glEndList;

      if MoxUVCall[i]=0 then MoxUVCall[i]:=glGenLists(1);
      glNewList (MoxUVCall[i], GL_COMPILE);
      glbegin (gl_triangles);
        for k:=1 to MOX.Chunk[i,2] do begin
          Normal2Poly(MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,1]].U,MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,1]].V,
                      MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,2]].U,MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,2]].V,
                      MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,3]].U,MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,3]].V,t);
          if t>=0 then
            for h:=3 downto 1 do begin
              glTexCoord2fv(@MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,h]].U);
              glVertex2f(MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,h]].U,-MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,h]].V+1);
              //glVertex2f(MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,h]].x1,-MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,h]].x2+1);//AFC11CT
            end
          else
            for h:=1 to 3 do begin
              glTexCoord2fv(@MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,h]].U);
              glVertex2f(MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,h]].U,-MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,h]].V+1);
              //glVertex2f(MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,h]].x1,-MOX.Vertice[MOX.Face[MOX.Chunk[i,1]+k,h]].x2+1);//AFC11CT
            end;
        end;
      glEnd;
      glEndList;
    end;
      KnowScale(nil);
  end else
  if Typename='TREE' then
  begin
    LOD:=1;
    if TreeCall=0 then TreeCall:=glGenLists(1);
    glNewList (TreeCall, GL_COMPILE);
    glbegin (gl_triangles);
      for i:=TreeLOD[LOD].Offset div 3+1 to TreeLOD[LOD].Offset div 3+TreeLOD[LOD].PolyCount do
      for h:=3 downto 1 do
      begin
        glTexCoord2fv(@TreeVertex[TreePoly[i,h]+1].U);
        glNormal3fv(@TreeVertex[TreePoly[i,h]+1].nX);
        glVertex3fv(@TreeVertex[TreePoly[i,h]+1].X);
      end;
    glEnd;
    glEndList;
  end;
end;

procedure TForm1.RenderFrame(Sender:TObject);
begin
  glClearColor(BGColor[1]/255, BGColor[2]/255, BGColor[3]/255, 0); 	   // Grey Background
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);    // Clear The Screen And The Depth Buffer
  glLoadIdentity;                                       // Reset The View
  glLightfv(GL_LIGHT0, GL_POSITION, @LightPos);  //can make
  glLightfv(GL_LIGHT1, GL_POSITION, @LightPos2); //static lights
  glPointSize(8);

  if RenderOpts.UVMap then begin
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA); //Set alpha mode
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glBindTexture(GL_TEXTURE_2D, 0);
    glDisable(GL_LIGHTING);

    glTranslatef(-xMov/10,yMov/10,0);
    glTranslatef(0.5,0.5,0);
    glkScale(sqr(zoom*3.2));
    glTranslatef(-0.5,-0.5,0);

    RenderUVGrid(CBShowGrid.Checked);
    RenderOpenGL;
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    RenderDirt('', TBDirt.Position);

  end else begin
    glTranslatef(0,0,-6);
    glTranslatef(xMov,yMov,0);
    glRotatef(yRot, 1, 0, 0);
    glRotatef(xRot, 0, 1, 0);
    glkScale(sqr(zoom));

    if (RenderOpts.ShowPart)and(ActivePage=apParts)and(SelectedTreeNode<>0) then
      glTranslatef(-MOX.Parts[SelectedTreeNode].Matrix[4,1]-PartModify[SelectedTreeNode].Move[1],
                   -MOX.Parts[SelectedTreeNode].Matrix[4,2]-PartModify[SelectedTreeNode].Move[2],
                   -MOX.Parts[SelectedTreeNode].Matrix[4,3]-PartModify[SelectedTreeNode].Move[3]);
    if (CBShowLight.Checked)and(ActivePage=apLights)and(LBBlinkers.ItemIndex<>-1) then
      glTranslatef(-MOX.Blinkers[LBBlinkers.ItemIndex+1].Matrix[4,1],
                   -MOX.Blinkers[LBBlinkers.ItemIndex+1].Matrix[4,2],
                   -MOX.Blinkers[LBBlinkers.ItemIndex+1].Matrix[4,3]);

    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA); //Set alpha mode
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glBindTexture(GL_TEXTURE_2D, 0);

    glDisable(GL_LIGHTING);
    if CBShowGrid.Checked then RenderGrid;
    glEnable(GL_LIGHTING);

    if roMOX in RenderObject then begin
      if RenderMode=rmShaders then RenderShaders;
      if RenderMode=rmOpenGL then begin
        RenderOpenGL;
        glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
        RenderDirt('', TBDirt.Position);
        if SelectedTreeNode<>0 then
          RenderPivotSetup(PivotPointActual.Value+MOX.Chunk[MOX.Parts[SelectedTreeNode].FirstMat+1,3]-1,
                           PivotPointActual.MaxValue,
                           PivotPointActual.Value); //PivotPointActual & SRnage both have +1
        RenderDummy;
        glDisable(GL_LIGHTING);
        if RenderOpts.Wire then RenderWireframe('Wire');
        glEnable(GL_LIGHTING);
      end;
      glDisable(GL_DEPTH_TEST);
      if (ActivePage=apLights)or(RenderOpts.LightVec) then RenderLights(LBBlinkers.ItemIndex+1,RGActBlink.ItemIndex,ActivePage=apLights);
      glEnable(GL_DEPTH_TEST);
    end;

    if roTREE in RenderObject then RenderTREE;

    if (roCOB in RenderObject) then
      if (ActivePage=apCOB)or(RenderOpts.Colli)or
      (ActivePage=apBrowse)and not(roMOX in RenderObject) then
        RenderCOB(LBCOBPoints.ItemIndex+1);


//      glDisable(GL_DEPTH_TEST);
    if (roCPO in RenderObject) then
      if (ActivePage=apCPO)or(RenderOpts.Colli)or
      (ActivePage=apBrowse)and not(roMOX in RenderObject) then begin
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
  if not RenderOpts.UVMap then begin
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
var minsize:Integer; xo,yo:Single;
begin
  if (RenderPanel.Height = 0) then RenderPanel.Height := 1;
  if (RenderPanel.Width = 0) then RenderPanel.Width := 1;
  glViewport(0, 0, RenderPanel.Width, RenderPanel.Height);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;

  minsize:=min(RenderPanel.Width, RenderPanel.Height);
  xo:=(RenderPanel.Width/minsize-1)/2;
  yo:=(RenderPanel.Height/minsize-1)/2;

  if RenderOpts.UVMap then
    gluOrtho2D(0-xo,1+xo,0-yo,1+yo)
  else
    gluPerspective(60, -RenderPanel.Width/RenderPanel.Height, 0.1, 200.0);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
end;


procedure TForm1.Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Sender=ImageR)or((Sender=RenderPanel)and(Button=mbLeft)) then CameraAction:='Rotate';
  if (Sender=ImageM)or((Sender=RenderPanel)and(Button=mbRight)) then CameraAction:='Move';
  if (Sender=ImageZ) then CameraAction:='Zoom';
  MouseX:=X; MouseY:=Y;
  GetCursorPos(CursorClick);
  //ShowCursor(False);
end;


procedure TForm1.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
var
  dx,dy:Integer;
begin
dx:=0;
dy:=0;
if CameraAction='' then Exit;
if CameraAction='Rotate' then begin
  xRot:=xRot-(X-MouseX);
  yRot:=yRot+(Y-MouseY);
  dx:=Form1.ClientOrigin.X+ImageR.Left+MouseX;
  dy:=Form1.ClientOrigin.Y+ImageR.Top+MouseY;
end;
if CameraAction='Zoom' then begin
  Zoom:=EnsureRange(Zoom+(X-MouseX)/150,0.06125,2);
  dx:=Form1.ClientOrigin.X+ImageZ.Left+MouseX;
  dy:=Form1.ClientOrigin.Y+ImageZ.Top+MouseY;
end;
if CameraAction='Move' then begin
  xMov:=xMov-(X-MouseX)/100;
  yMov:=yMov-(Y-MouseY)/100;
  dx:=Form1.ClientOrigin.X+ImageM.Left+MouseX;
  dy:=Form1.ClientOrigin.Y+ImageM.Top+MouseY;
end;
if (Sender=RenderPanel) then begin
  dx:=Form1.ClientOrigin.X+RenderPanel.Left+MouseX;
  dy:=Form1.ClientOrigin.Y+RenderPanel.Top+MouseY;
end;
//return cursor to start location = "stick it"
SetCursorPos(dx,dy);
//MouseX:=X; MouseY:=Y;
RenderFrame(nil);
end;


procedure TForm1.Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CameraAction:='';
  ShowCursor(True);
end;


procedure TForm1.LoadTextures;
var
  i,k:Integer;
begin
  for i:=1 to MOX.Qty.Mat do
    if MoxTex[i]<>0 then begin
      glDeleteTextures(1,@MoxTex[i]); //Clear RAM used by textures
      MoxTex[i]:=0;
    end;
  glDeleteTextures(1,@DirtTex); //Clear RAM used by textures
  glDeleteTextures(1,@ScratchTex); //Clear RAM used by textures

  for i:=1 to MOX.Qty.Mat do begin //Load new textures

    for k:=1 to i-1 do if Material[k].TexName=Material[i].TexName then
      MoxTex[i]:=MoxTex[k]; //use earlier loaded texture ID

    if MoxTex[i]=0 then
      MoxTex[i]:=TryToLoadTexture(Material[i].TexName);

  end;

  DirtTex := TryToLoadTexture('dirt.tga');
  ScratchTex := TryToLoadTexture('scratch.tga');
end;


function TForm1.TryToLoadTexture(const aFilename: string):cardinal;
var
  TexID: Cardinal;
  FileName: string;
begin
  TexID := 0;
  //Try in following order:
  //Textures_PC\TGA > Textures\TGA > Textures_PC\PTX > Textures\PTX
  FileName := TruncateExt(aFileName) + '.';
  if FileExists(OpenedFolder + '\Textures_PC\' + FileName + 'TGA') then
    LoadTexture(OpenedFolder + '\Textures_PC\' + FileName + 'TGA', TexID, 0)
  else if FileExists(OpenedFolder + '\Textures\' + FileName + 'TGA') then
    LoadTexture(OpenedFolder + '\Textures\' + FileName + 'TGA', TexID, 0)
  else if FileExists(OpenedFolder + '\Textures_PC\' + FileName + 'PTX') then
    LoadTexturePTX(OpenedFolder + '\Textures_PC\' + FileName + 'PTX', TexID)
  else if FileExists(OpenedFolder + '\Textures\' + FileName + 'PTX') then
    LoadTexturePTX(OpenedFolder + '\Textures\' + FileName + 'PTX', TexID);
  Result := TexID;
end;


procedure TForm1.LBBlinkersClick(Sender: TObject);
var
  x: Integer;
  ax,ay,az: Integer;
  m: array [1..9] of Single;
begin
LitID:=LBBlinkers.ItemIndex+1;
if LitID=0 then Exit;

LightRefresh:=True;
x:=MOX.Blinkers[LitID].TypeID;
case x of //Fit 0..24 IDs in RG range of 0..12
  16: x:=10;
  20: x:=11;
  24: x:=12;
  33: x:=13;
end;
RGBlinkType.ItemIndex:=x;
FS1.Value:=MOX.Blinkers[LitID].sMin;
FS2.Value:=MOX.Blinkers[LitID].sMax;
FS3.Value:=MOX.Blinkers[LitID].Freq;
//S1.Value:=MOX.Blinkers[LBBlinkers.ItemIndex+1].z1;
S2.Value:=MOX.Blinkers[LitID].Parent;
FSX.Value:=MOX.Blinkers[LitID].Matrix[4,1]/10;
FSY.Value:=MOX.Blinkers[LitID].Matrix[4,2]/10;
FSZ.Value:=MOX.Blinkers[LitID].Matrix[4,3]/10;
ShapeL.Brush.Color:=MOX.Blinkers[LitID].R+MOX.Blinkers[LitID].G*256+MOX.Blinkers[LitID].B*65536;

with MOX.Blinkers[LitID] do begin
m[1]:=Matrix[1,1]; m[2]:=Matrix[1,2]; m[3]:=Matrix[1,3];
m[4]:=Matrix[2,1]; m[5]:=Matrix[2,2]; m[6]:=Matrix[2,3];
m[7]:=Matrix[3,1]; m[8]:=Matrix[3,2]; m[9]:=Matrix[3,3];
end;

Matrix2Angles(m,9,@ax,@ay,@az);

FSH.Value:=round(ax);
FSP.Value:=round(ay);
FSB.Value:=round(az);

LightRefresh:=False;
end;


procedure TForm1.BlinkChange(Sender: TObject);
begin
if LitID=0 then Exit;
if LightRefresh then Exit;
case RGBlinkType.ItemIndex of
  0..9: MOX.Blinkers[LitID].TypeID:=RGBlinkType.ItemIndex;
  10:   MOX.Blinkers[LitID].TypeID:=16;
  11:   MOX.Blinkers[LitID].TypeID:=20;
  12:   MOX.Blinkers[LitID].TypeID:=24;
  13:   MOX.Blinkers[LitID].TypeID:=33;
end;
MOX.Blinkers[LitID].sMin:=FS1.Value;
MOX.Blinkers[LitID].sMax:=FS2.Value;
MOX.Blinkers[LitID].Freq:=FS3.Value;
MOX.Blinkers[LitID].z1:=0;//S1.Value;
MOX.Blinkers[LitID].Parent:=S2.Value;
SendDataToUI(uiLights);
end;

procedure TForm1.CBColorChange(Sender: TObject);
begin
ColID:=CBColor.ItemIndex+1;
if MatID=0 then Exit;
with Material[MatID].Color[ColID] do begin
  ShapeA.Brush.Color:=Amb.R+Amb.G*256+Amb.B*65536;
  ShapeD.Brush.Color:=Dif.R+Dif.G*256+Dif.B*65536;
  ShapeS1.Brush.Color:=Sp1.R+Sp1.G*256+Sp1.B*65536;
  ShapeS2.Brush.Color:=Sp2.R+Sp2.G*256+Sp2.B*65536;
  ShapeR.Brush.Color:=Ref.R+Ref.G*256+Ref.B*65536;
end;
end;


procedure TForm1.LBMaterialsClick(Sender: TObject);
begin
MatID:=LBMaterials.ItemIndex+1;
if MatID=0 then Exit;
MatName.Text:=Material[MatID].Title;
MaterialRefresh:=True;
TTransparency.Position:=Material[MatID].Transparency;
ETextureName.Text:=Material[MatID].TexName;
CBMatClass2.ItemIndex:=Material[MatID].MatClass[2];
CBMatClass3.ItemIndex:=Material[MatID].MatClass[3];
CB1.Checked:=(Material[MatID].MatClass[4] AND 1) = 1;
CB2.Checked:=(Material[MatID].MatClass[4] AND 2) = 2;
CB3.Checked:=(Material[MatID].MatClass[4] AND 4) = 4;
CB4.Checked:=(Material[MatID].MatClass[4] AND 8) = 8;
CBClipU.ItemIndex:=Material[MatID].TexEdge.U;
CBClipV.ItemIndex:=Material[MatID].TexEdge.V;
MaterialRefresh:=False;

CBColorChange(nil); //update color panels
end;


procedure TForm1.MaterialPropertiesChange(Sender: TObject);
var
  t:Integer;
begin
if MatID=0 then Exit;
Label13.Caption:=IntToStr(TTransparency.Position)+'% Transparency';
if MaterialRefresh then Exit;
Material[MatID].Transparency:=TTransparency.Position;
Material[MatID].TexName:=ETextureName.Text;
Material[MatID].MatClass[2]:=CBMatClass2.ItemIndex;
Material[MatID].MatClass[3]:=CBMatClass3.ItemIndex;
t:=0;
if CB1.Checked then inc(t,1);
if CB2.Checked then inc(t,2);
if CB3.Checked then inc(t,4);
if CB4.Checked then inc(t,8);
Material[MatID].MatClass[4]:=t;
Material[MatID].TexEdge.U:=CBClipU.ItemIndex;
Material[MatID].TexEdge.V:=CBClipV.ItemIndex;
end;


procedure TForm1.MatNameChange(Sender: TObject);
begin
  if MatID=0 then Exit;
  Material[MatID].Title:=MatName.Text;
  LBMaterials.Items[MatID-1]:=Material[MatID].Mtag+' '+Material[MatID].Title;
end;


procedure TForm1.TVPartsChange(Sender: TObject; Node: TTreeNode);
var ID:Integer;
begin
ForbidPartsChange:=True;
Label63.Caption:='ID: '+IntToStr(TVParts.Selected.AbsoluteIndex);
SelectedTreeNode:=TVParts.Selected.AbsoluteIndex+1;
ID:=SelectedTreeNode;
Label23.Caption:='#'+IntToStr(ID)+' P'+IntToStr(MOX.Parts[ID].Parent+1)
                                 +' C'+IntToStr(MOX.Parts[ID].Child+1)
                                 +' P'+IntToStr(MOX.Parts[ID].PrevInLevel+1)
                                 +' N'+IntToStr(MOX.Parts[ID].NextInLevel+1);

EDetailName.Text:=MOX.Parts[SelectedTreeNode].Dname;
CX.Value:=MOX.Parts[SelectedTreeNode].xMid;
CY.Value:=MOX.Parts[SelectedTreeNode].yMid;
CZ.Value:=MOX.Parts[SelectedTreeNode].zMid;
CRad.Value:=MOX.Parts[SelectedTreeNode].fRadius;

RGDetailType.ItemIndex:=MOX.Parts[SelectedTreeNode].TypeID;
if RGDetailType.ItemIndex<>MOX.Parts[SelectedTreeNode].TypeID then
MessageBox(Handle, 'Unknown detail ID type', 'Discovery', MB_OK or MB_ICONSTOP);;

LX1.Value:=MOX.Parts[SelectedTreeNode].x1/pi*180;//-YZ rotation
LX2.Value:=MOX.Parts[SelectedTreeNode].x2/pi*180;//+YZ rotation
LY1.Value:=MOX.Parts[SelectedTreeNode].y1/pi*180;//-XZ rotation
LY2.Value:=MOX.Parts[SelectedTreeNode].y2/pi*180;//+XZ rotation
LZ1.Value:=MOX.Parts[SelectedTreeNode].z1/pi*180;//-XY rotation
LZ2.Value:=MOX.Parts[SelectedTreeNode].z2/pi*180;//+XY rotation
ForbidPartsChange:=False;
FlapParts.Enabled:=SelectedTreeNode<>0;
Label30.Enabled:=SelectedTreeNode<>0;
ForbidPivotChange:=True;
PivotPointActual.MaxValue:=
MOX.Chunk[MOX.Parts[SelectedTreeNode].FirstMat+1+MOX.Parts[SelectedTreeNode].NumMat-1,4]-
MOX.Chunk[MOX.Parts[SelectedTreeNode].FirstMat+1,3]+1;
PivotPointActual.Value:=PartModify[SelectedTreeNode].ActualPoint;
RGPivotX.ItemIndex:=PartModify[SelectedTreeNode].AxisSetup[1];
RGPivotY.ItemIndex:=PartModify[SelectedTreeNode].AxisSetup[2];
RGPivotZ.ItemIndex:=PartModify[SelectedTreeNode].AxisSetup[3];
CustomPivotX.Value:=PartModify[SelectedTreeNode].Custom[1];
CustomPivotY.Value:=PartModify[SelectedTreeNode].Custom[2];
CustomPivotZ.Value:=PartModify[SelectedTreeNode].Custom[3];
ForbidPivotChange:=False;
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
  h,i,j,k,m:Integer;
  ii,kk:Integer;
  f:file;
  vv: array [1..65280,1..3]of longWord;
  tx,ty,tz: array [1..256]of real;
  Lev:Integer;
  lazyqty: array of Integer;
begin
  assignfile(f,aFilename); rewrite(f,1);

  if PivotSetup.TabVisible then begin //LWO>MOX only !
    //Set MoxMat/Sid order continous
    //kinda lazy to re-do SRange stuff, so just sort it out here :-)

    setlength(lazyqty,MOX.Qty.Parts+1);
    lazyqty[0]:=0;

    for i:=1 to MOX.Qty.Parts do begin
      lazyqty[i]:=1;                  //number of MOX.Parts
        for j:=MOX.Parts[i].FirstMat+1 to MOX.Parts[i].FirstMat+MOX.Parts[i].NumMat do
          if (MOX.Chunk[j,2]>0) then begin  //if polycount for part >1
            MOX.Chunk[lazyqty[0]+lazyqty[i],1]:=MOX.Chunk[j,1];
            MOX.Chunk[lazyqty[0]+lazyqty[i],2]:=MOX.Chunk[j,2];
            MOX.Chunk[lazyqty[0]+lazyqty[i],3]:=MOX.Chunk[j,3];
            MOX.Chunk[lazyqty[0]+lazyqty[i],4]:=MOX.Chunk[j,4];
              MOX.Sid[lazyqty[0]+lazyqty[i],1]:=MOX.Sid   [j,1];
              MOX.Sid[lazyqty[0]+lazyqty[i],2]:=MOX.Sid   [j,2];
            //MoxMat[lazyqty[0]+lazyqty[i]].ID:=MoxMat[j].ID;
            inc(lazyqty[i]);
          end;
      dec(lazyqty[i]);
      inc(lazyqty[0],lazyqty[i]);
      end;

    MOX.Qty.Chunks:=0;
    MOX.Parts[1].FirstMat:=0;

    for i:=1 to MOX.Qty.Parts do begin
      inc(MOX.Qty.Chunks,lazyqty[i]);
      MOX.Parts[i].NumMat:=lazyqty[i];
      MOX.Parts[i+1].FirstMat:=MOX.Parts[i].FirstMat+MOX.Parts[i].NumMat;
    end;
    //re-Sorting ends here}

    k:=1; m:=0;
    for i:=1 to MOX.Qty.Vertice do begin
      if i=MOX.Chunk[k,4]+1 then
        inc(k);//3-point From  //4-point Till //k-partID

      if MOX.Parts[m+1].FirstMat+1=k then begin
        inc(m); //m-detailID
        tx[m]:=0; ty[m]:=0; tz[m]:=0;
        Lev:=m;
        //repeat
          if (MOX.Parts[Lev].Parent<>-1) then begin
            Lev:=MOX.Parts[Lev].Parent+1; //parentID
            tx[m]:=tx[m]-PartModify[Lev].Move[1];
            ty[m]:=ty[m]-PartModify[Lev].Move[2];
            tz[m]:=tz[m]-PartModify[Lev].Move[3];
          end;
        //until(MOX.Parts[Lev].Parent=-1);
        tx[m]:=tx[m]+PartModify[m].Move[1];
        ty[m]:=ty[m]+PartModify[m].Move[2];
        tz[m]:=tz[m]+PartModify[m].Move[3];
      end;

      MOX.Vertice[i].X:=MOX.Vertice[i].X-PartModify[m].Move[1];
      MOX.Vertice[i].Y:=MOX.Vertice[i].Y-PartModify[m].Move[2];
      MOX.Vertice[i].Z:=MOX.Vertice[i].Z-PartModify[m].Move[3];
    end;

    for i:=1 to MOX.Qty.Parts do begin
      MOX.Parts[i].Matrix[4,1]:=tx[i];//PartModify[i].Move[1];
      MOX.Parts[i].Matrix[4,2]:=ty[i];//PartModify[i].Move[2];
      MOX.Parts[i].Matrix[4,3]:=tz[i];//PartModify[i].Move[3];
      MOX.Parts[i].xMid:=MOX.Parts[i].xMid-PartModify[i].Move[1];
      MOX.Parts[i].yMid:=MOX.Parts[i].yMid-PartModify[i].Move[2];
      MOX.Parts[i].zMid:=MOX.Parts[i].zMid-PartModify[i].Move[3];
    end;

  end;

    PivotSetup.TabVisible:=False;

    // Make sure we write Ansi chars
    BlockWrite(f, PAnsiChar(MOX_FORMAT_HEADER)^, 8);

    BlockWrite(f,MOX.Qty,24);
    BlockWrite(f,MOX.Vertice,MOX.Qty.Vertice*40);
    for ii:=1 to MOX.Qty.Poly do begin
      dec(MOX.Face[ii,1],1); dec(MOX.Face[ii,2],1); dec(MOX.Face[ii,3],1);//V-1

        BlockWrite(f,MOX.Face[ii],6);
      inc(MOX.Face[ii,1],1); inc(MOX.Face[ii,2],1); inc(MOX.Face[ii,3],1);//restore values V+1 !
    end;

    for ii:=1 to MOX.Qty.Chunks do begin
      BlockWrite(f,MOX.Sid[ii,1],2); BlockWrite(f,#0+#0,2);
      BlockWrite(f,MOX.Sid[ii,2],2); BlockWrite(f,#0+#0,2);

      dec(MOX.Chunk[ii,3]); dec(MOX.Chunk[ii,4]);
      BlockWrite(f,MOX.Chunk[ii,1],2); BlockWrite(f,#0+#0,2);
      BlockWrite(f,MOX.Chunk[ii,2],2); BlockWrite(f,#0+#0,2);
      BlockWrite(f,MOX.Chunk[ii,3],2); BlockWrite(f,#0+#0,2);
      BlockWrite(f,MOX.Chunk[ii,4],2); BlockWrite(f,#0+#0,2);
      inc(MOX.Chunk[ii,3]); inc(MOX.Chunk[ii,4]);
    end;


  BlockWrite(f,MOX.MoxMat,336*MOX.Qty.Mat);   //4+332

  for ii:=1 to MOX.Qty.Parts do begin
    s:=chr2(MOX.Parts[ii].Dname,64);
    BlockWrite(f,s[1],64);
    BlockWrite(f,MOX.Parts[ii].Matrix,132);
  end;

  for ii:=1 to MOX.Qty.Blink do //Write blinkers in order
    for kk:=0 to 33 do
     if MOX.Blinkers[ii].TypeID=kk then
       BlockWrite(f,MOX.Blinkers[ii],88);

  {
  for ii:=1 to MOX.Qty.Blink do //Write important "blinkers" first
    if (MOX.Blinkers[ii].TypeID<2)or(MOX.Blinkers[ii].TypeID>9) then begin
      BlockWrite(f,MOX.Blinkers[ii],88);
      BlinkWrite[ii]:=255;           //Written
    end else
      BlinkWrite[ii]:=0;  //Not written

  for ii:=1 to MOX.Qty.Blink do if BlinkWrite[ii]=0 then
      for kk:=ii+1 to MOX.Qty.Blink do
      if (BlinkWrite[kk]=0)and(MOX.Blinkers[kk].Matrix[4,1]=-MOX.Blinkers[ii].Matrix[4,1]) then
      if MOX.Blinkers[kk].Matrix[4,1]>0 then begin BlinkWrite[ii]:=4; BlinkWrite[kk]:=2; end //L-R sides
                                    else begin BlinkWrite[ii]:=2; BlinkWrite[kk]:=4; end;//R-L sides

  for ii:=1 to MOX.Qty.Blink do if BlinkWrite[ii]=0 then begin
    BlockWrite(f,MOX.Blinkers[ii],88); //Write assymetrical blinkers
    BlinkWrite[ii]:=255;
  end;

  for ii:=1 to MOX.Qty.Blink do
    if BlinkWrite[ii]=2 then
      if ii mod 2 = 0 then begin
        BlockWrite(f,MOX.Blinkers[ii],88);
        BlinkWrite[ii]:=255;
      end else
        for kk:=ii to MOX.Qty.Blink do
          if BlinkWrite[kk]=4 then begin
            BlockWrite(f,MOX.Blinkers[kk],88);
            BlinkWrite[kk]:=255;
          end;

  for ii:=1 to MOX.Qty.Blink do if BlinkWrite[ii]<>255 then
  BlockWrite(f,MOX.Blinkers[ii],88);  }

  closefile(f);
  Memo1.Lines.Add('MOX file closed');
  for i:=1 to MOX.Qty.Parts do begin
    PartModify[i].Custom[1]:=0;
    PartModify[i].Custom[2]:=0;
    PartModify[i].Custom[3]:=0;
    PartModify[i].Move[1]:=0;
    PartModify[i].Move[2]:=0;
    PartModify[i].Move[3]:=0;
  end;
  CompileLoaded('MOX'); //To make sure it looks just right
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
SelectedTreeNode:=TVParts.Selected.AbsoluteIndex+1;
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
MOX.Parts[SelectedTreeNode].TypeID:=RGDetailType.ItemIndex;
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
  Opened3DMask:=decs(aFilename,4,0);
  OpenedFolder:=ExtractFileDir(Opened3DMask);
  if OpenedFolder='' then OpenedFolder:=ExeDir;
  Form1.Caption:='MTKit2 - '+ExtractFileName(Opened3DMask);
  Application.Title:='MTKit2 - '+ExtractFileName(Opened3DMask);
end;


procedure TForm1.ConverseImp_MOX;
var
  h,i,j,k,m,t:Integer;
  VqtyAtSurf,PqtyAtSurf: array of array of Word;
  altpoint: array of array of array of array[1..3] of Word; found: Boolean; //MOX.Parts,materials,points
  altpoly: array of array of array of Word;                                //MOX.Parts,materials,points
  v2: array of array of array of array[1..3] of Word;
  PolyPerMaterial: array [1..512]of Word;
  MakeDefaultPart:Boolean;
  sprite: array [1..65280]of Boolean;
begin
  Shape2.Width:=32;

  FillChar(MOX,SizeOf(MOX),#0);

  MOX.Qty.Parts:=Imp.PartCount;
  MOX.Qty.Mat:=Imp.SurfCount;

  TVParts.ReadOnly:=False;
  FillChar(PartModify,SizeOf(PartModify),#0);

  RGPivotClick(nil);

  //Convert all unused vertices into blinkers later
  for i:=1 to Imp.VerticeCount do sprite[i]:=True;
  for i:=1 to Imp.PolyCount do begin
    sprite[Imp.Faces[i,1]]:=False;
    sprite[Imp.Faces[i,2]]:=False;
    sprite[Imp.Faces[i,3]]:=False;
  end;

  MakeDefaultPart:=False;
  for i:=1 to Imp.PolyCount do
  if Imp.Part[i]=0 then MakeDefaultPart:=True;

  if MakeDefaultPart then begin //insert part for default
    for i:=MAX_PARTS-1 downto 1 do Imp.PartName[i+1]:=Imp.PartName[i];
    Imp.PartName[1]:='Default(Body)';
    for i:=1 to Imp.PolyCount do inc(Imp.Part[i]); //set part #1
    inc(MOX.Qty.Parts);
  end;

  MOX.Qty.Blink:=0;
  for i:=1 to Imp.VerticeCount do
    if (sprite[i])and(MOX.Qty.Blink<MAX_BLINKERS)then begin
      inc(MOX.Qty.Blink);                                 //63+1=64
      with MOX.Blinkers[MOX.Qty.Blink] do begin //0..63
        TypeID:=2;
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
  SendDataToUI(uiLights);
  LoadBlink.Enabled:=True;
  SaveBlink.Enabled:=True;

  for i:=1 to Imp.PolyCount do
    for h:=1 to 3 do begin //Remapping UVs to DUVs
      if Imp.duv[i,h].u=123456 then Imp.duv[i,h].u:=Imp.UV[Imp.Faces[i,h]].U; //
      if Imp.duv[i,h].v=123456 then Imp.duv[i,h].v:=Imp.UV[Imp.Faces[i,h]].V;
    end;

  ////////////////////////////////////////////////////////////////////////////////
  //Splitting                                                                   //
  ////////////////////////////////////////////////////////////////////////////////

  setlength(altpoint,MOX.Qty.Parts+1);
  setlength(altpoly,MOX.Qty.Parts+1);
  setlength(VqtyAtSurf,MOX.Qty.Parts+1);
  setlength(PqtyAtSurf,MOX.Qty.Parts+1);
  setlength(v2,MOX.Qty.Parts+1);
  for i:=1 to MOX.Qty.Parts do begin
    setlength(altpoint[i],MOX.Qty.Mat+1);
    setlength(altpoly[i],MOX.Qty.Mat+1);
    setlength(VqtyAtSurf[i],MOX.Qty.Mat+1);
    setlength(PqtyAtSurf[i],MOX.Qty.Mat+1);
    setlength(v2[i],MOX.Qty.Mat+1);
  end;

  for m:=1 to MOX.Qty.Parts do
  for i:=1 to Imp.PolyCount do
    if Imp.Part[i]=m then begin//for all polys belong to current part
    if i mod 1000 = 0 then begin
    Shape2.Width:=round((i/Imp.PolyCount)*100);
    Label35.Caption:=IntToStr(round((i/Imp.PolyCount)*100))+' %'; Label35.Repaint;
    end;

      for h:=1 to 3 do begin //point-by-point
      found:=False; //"match found" marker
        for k:=PqtyAtSurf[m,Imp.Surf[i]] downto 1 do begin
        //not to compare with self but all others of same surface
        //reverse direction saves 40-80%
        for j:=1 to 3 do //scan all previous points of polys
          if (altpoint[m,Imp.Surf[i],v2[m,Imp.Surf[i],k,j],1]=Imp.Faces[i,h])and  //original points match
          (Imp.Part[altpoly[m,Imp.Surf[i],k]]=Imp.Part[i])and                                //part tag
          (Imp.duv[altpoly[m,Imp.Surf[i],k],j].u=Imp.duv[i,h].u)and         //UVs
          (Imp.duv[altpoly[m,Imp.Surf[i],k],j].v=Imp.duv[i,h].v) then begin //UVs
      if length(v2[m,Imp.Surf[i]])-1<=PqtyAtSurf[m,Imp.Surf[i]] then
      setlength(v2[m,Imp.Surf[i]],PqtyAtSurf[m,Imp.Surf[i]]+100);

          v2[m,Imp.Surf[i],PqtyAtSurf[m,Imp.Surf[i]]+1,h]:=v2[m,Imp.Surf[i],k,j]; //make V2 use it
          found:=True;
          end;
        if found then break; //5% save
        end;
      if not found then begin
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
    if h=3 then begin
    inc(PqtyAtSurf[m,Imp.Surf[i]]);
        if length(altpoly[m,Imp.Surf[i]])<=PqtyAtSurf[m,Imp.Surf[i]] then
        setlength(altpoly[m,Imp.Surf[i]],PqtyAtSurf[m,Imp.Surf[i]]+100);
    altpoly[m,Imp.Surf[i],PqtyAtSurf[m,Imp.Surf[i]]]:=i;
    end;
  end;
  end;
  Shape2.Width:=100;

  h:=1;
  for m:=1 to MOX.Qty.Parts do begin
    t:=1;
    for i:=1 to MOX.Qty.Mat do
      for k:=1 to VqtyAtSurf[m,i] do begin

        MOX.Vertice[h].X:=Imp.XYZ[altpoint[m,i,k,1]].X;
        MOX.Vertice[h].Y:=Imp.XYZ[altpoint[m,i,k,1]].Y;
        MOX.Vertice[h].Z:=Imp.XYZ[altpoint[m,i,k,1]].Z;
        MOX.Vertice[h].nX:=Imp.Nv[altpoint[m,i,k,1]].X;
        MOX.Vertice[h].nY:=Imp.Nv[altpoint[m,i,k,1]].Y;
        MOX.Vertice[h].nZ:=Imp.Nv[altpoint[m,i,k,1]].Z;
        MOX.Vertice[h].U:=Imp.DUV[altpoint[m,i,k,3],altpoint[m,i,k,2]].U;
        MOX.Vertice[h].V:=1-Imp.DUV[altpoint[m,i,k,3],altpoint[m,i,k,2]].V;
        MOX.Qty.Vertice:=h;

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

  FillChar(MOX.Chunk,SizeOf(MOX.Chunk),#0);
  FillChar(MOX.Parts,SizeOf(MOX.Parts),#0);

  h:=1;
  for m:=1 to MOX.Qty.Parts do
    for i:=1 to MOX.Qty.Mat do begin
  if h>1 then MOX.Chunk[h,3]:=MOX.Chunk[h-1,4]+1 else MOX.Chunk[h,3]:=1;
  MOX.Chunk[h,4]:=MOX.Chunk[h,3]+VqtyAtSurf[m,i]-1;
  MOX.Qty.Chunks:=h;
  inc(h);
  end;

  j:=1; t:=1;
  for m:=1 to MOX.Qty.Parts do
    for i:=1 to MOX.Qty.Mat do begin
      for k:=1 to PqtyAtSurf[m,i] do begin
      for h:=1 to 3 do MOX.Face[j,h]:=v2[m,i,k,h]+MOX.Chunk[t,3]-1;
      inc(j);
      end;
    inc(t);
    end;

  h:=1;
  for m:=1 to MOX.Qty.Parts do begin
    MOX.Parts[m].NumMat:=0;
    for i:=1 to MOX.Qty.Mat do begin
      MOX.Chunk[h,2]:=PqtyAtSurf[m,i];
      if h>1 then MOX.Chunk[h,1]:=MOX.Chunk[h-1,1]+MOX.Chunk[h-1,2] else MOX.Chunk[h,1]:=0;
      MOX.Qty.Poly:=MOX.Chunk[h,1]+MOX.Chunk[h,2];
      inc(MOX.Parts[m].NumMat);
      inc(h);
    end;
  end;

  for i:=1 to MOX.Qty.Mat do begin
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

  for i:=1 to MOX.Qty.Mat do for k:=2 to MAX_COLORS do
  Material[i].Color[k]:=Material[i].Color[1]; //Set all colors same
  LoadTextures;

  h:=1;
  for m:=1 to MOX.Qty.Parts do
    for i:=1 to MOX.Qty.Mat do begin
      MOX.Sid[h,1]:=i-1;
      MOX.Sid[h,2]:=i-1;
      inc(h);
    end;

  for i:=1 to MOX.Qty.Mat do begin
    MOX.MoxMat[i].ID:=i-1;
    for k:=1 to 332 do MOX.MoxMat[i].xxx[k]:=#0;
  end;

  for i:=1 to MOX.Qty.Parts do begin
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

  CompileLoaded('MOX');

  Label35.Caption:=floattostr(round((GetTickCount-OldTimeLWO)/100)/10)+' s';

  ShowUpClick(cuMOX);
  ShowUpClick(cuMTL);
  SetRenderObject([roMOX]);
  SetActivePage(apMTL);

  SaveMOX1.Enabled:=True;

  IsLightwave2MOX:=True;
  PivotSetup.TabVisible:=True;
end;


procedure TForm1.MatTexBrowseClick(Sender: TObject);
begin
  if MatID=0 then Exit;
  if not RunOpenDialog(Open1,'',OpenedFolder,'Targa, PTX image files (*.ptx; *.tga)|*.tga;*.ptx') then Exit;
  ETextureName.Text:=ExtractFileName(Open1.FileName);
  MatTexReloadClick(nil);
end;


procedure TForm1.BlinkPositionChange(Sender: TObject);
begin
  if LitID=0 then Exit;
  if LightRefresh then Exit;
  MOX.Blinkers[LitID].Matrix[4,1]:=FSX.Value*10;
  MOX.Blinkers[LitID].Matrix[4,2]:=FSY.Value*10;
  MOX.Blinkers[LitID].Matrix[4,3]:=FSZ.Value*10;
  Angles2Matrix(FSH.Value,FSP.Value,FSB.Value, @MOX.Blinkers[LitID].Matrix, 16);
end;


procedure TForm1.BlinkAddClick(Sender: TObject);
begin
  if MOX.Qty.Blink>=MAX_BLINKERS then Exit;
  inc(MOX.Qty.Blink);

  if LBBlinkers.ItemIndex>=0 then MOX.Blinkers[MOX.Qty.Blink]:=MOX.Blinkers[LBBlinkers.ItemIndex+1] else begin
    MOX.Blinkers[MOX.Qty.Blink].TypeID:=0;
    MOX.Blinkers[MOX.Qty.Blink].sMin:=0;
    MOX.Blinkers[MOX.Qty.Blink].sMax:=1;
    MOX.Blinkers[MOX.Qty.Blink].Freq:=0;
    MOX.Blinkers[MOX.Qty.Blink].B:=255;
    MOX.Blinkers[MOX.Qty.Blink].G:=64;
    MOX.Blinkers[MOX.Qty.Blink].R:=0;
    MOX.Blinkers[MOX.Qty.Blink].A:=255;
    MOX.Blinkers[MOX.Qty.Blink].z1:=0;
    MOX.Blinkers[MOX.Qty.Blink].Parent:=0;
    FillChar(MOX.Blinkers[MOX.Qty.Blink].Matrix,SizeOf(MOX.Blinkers[MOX.Qty.Blink].Matrix),#0);
    MOX.Blinkers[MOX.Qty.Blink].Matrix[1,1]:=1;
    MOX.Blinkers[MOX.Qty.Blink].Matrix[2,2]:=1;
    MOX.Blinkers[MOX.Qty.Blink].Matrix[3,3]:=1;
    MOX.Blinkers[MOX.Qty.Blink].Matrix[4,4]:=1;
  end;
  SendDataToUI(uiLights);
end;


procedure TForm1.BlinkRemoveClick(Sender: TObject);
var
  i:Integer;
begin
  if LBBlinkers.ItemIndex=-1 then Exit;
  for i:=LBBlinkers.ItemIndex+1 to MOX.Qty.Blink-1 do
  MOX.Blinkers[i]:=MOX.Blinkers[i+1];
  dec(MOX.Qty.Blink);
  SendDataToUI(uiLights);
  if LBBlinkers.ItemIndex=-1 then LBBlinkers.ItemIndex:=LBBlinkers.Count-1;
  if LBBlinkers.ItemIndex<>-1 then LBBlinkersClick(nil);
end;


procedure TForm1.BlinkCopyClick(Sender: TObject);
begin
  LightCopyID:=LBBlinkers.ItemIndex+1;
  if LightCopyID>0 then BlinkerPaste.Enabled:=True;
end;


procedure TForm1.BlinkPasteClick(Sender: TObject);
var
  ID:Integer;
begin
  ID:=LBBlinkers.ItemIndex+1;
  if ID=0 then Exit;

  if LightCopyID<>EnsureRange(LightCopyID,1,MOX.Qty.Blink) then
  begin
    BlinkerPaste.Enabled:=False;
    Exit;
  end;

  MOX.Blinkers[ID].TypeID:=MOX.Blinkers[LightCopyID].TypeID;
  MOX.Blinkers[ID].sMin:=MOX.Blinkers[LightCopyID].sMin;
  MOX.Blinkers[ID].sMax:=MOX.Blinkers[LightCopyID].sMax;
  MOX.Blinkers[ID].Freq:=MOX.Blinkers[LightCopyID].Freq;
  MOX.Blinkers[ID].B:=MOX.Blinkers[LightCopyID].B;
  MOX.Blinkers[ID].G:=MOX.Blinkers[LightCopyID].G;
  MOX.Blinkers[ID].R:=MOX.Blinkers[LightCopyID].R;
  MOX.Blinkers[ID].A:=MOX.Blinkers[LightCopyID].A;
  MOX.Blinkers[ID].z1:=MOX.Blinkers[LightCopyID].z1;
  MOX.Blinkers[ID].Parent:=MOX.Blinkers[LightCopyID].Parent;
  SendDataToUI(uiLights);
  LBBlinkersClick(nil);
end;


procedure TForm1.LoadBlinkClick(Sender: TObject);
begin
  if not RunOpenDialog(Open1, '', '', 'MTKit2 Lights Setup Files (*.lsf)|*.lsf') then
    Exit;

  LoadLights(Open1.FileName);
  SendDataToUI(uiLights);
  BlinkerPaste.Enabled := False;
end;


procedure TForm1.SaveBlinkClick(Sender: TObject);
begin
  if not RunSaveDialog(Save1, Opened3DMask+'.lsf','','MTKit2 Lights Setup Files (*.lsf)|*.lsf','lsf') then Exit;
  SaveLights(Save1.FileName);
end;


procedure TForm1.About1Click(Sender: TObject);
var
  ver, vfl: Integer;
begin
  glGetIntegerv(GL_SHADING_LANGUAGE_VERSION_ARB, @ver);
  glGetIntegerv(GL_MAX_VARYING_FLOATS_ARB, @vfl);

  MessageBox(
    Handle,
    PChar(
      VersionInfo + eol + eol +
      'using OpenGL ' + glGetString(GL_VERSION) + ' by ' + glGetString(GL_RENDERER) + eol +
      'using GLSL version ' + IntToStr(ver) + ' with max floats ' + IntToStr(vfl) + eol + eol +
      'Written by Krom - kromster80@gmail.com' + eol +
      'Site - http://krom.reveur.de'),
    'Info',
    MB_OK or MB_ICONINFORMATION);
end;


procedure TForm1.TVPartsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if (TVParts.GetNodeAt(X, Y) = TVParts.TopItem) and (TVParts.TopItem <> TVParts.Items[0]) then
    TVParts.TopItem := TVParts.Items[TVParts.GetNodeAt(X,Y).AbsoluteIndex-1];

  Accept := IsLightwave2MOX;
end;


procedure TForm1.TVPartsDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  TVParts.Selected.MoveTo(TVParts.GetNodeAt(X,Y),naAddChild); //First?
  RebuildPartsTree;
  ExchangePartsOrdering;
  SelectedTreeNode:=TVParts.Selected.AbsoluteIndex+1;
end;


procedure TForm1.ExchangePartsOrdering;
var
  i,j,k:Integer;
begin //Exchanging MOX.Parts ordering
  for i := 1 to MOX.Qty.Parts do
    for k := 1 to MOX.Qty.Parts do
      if MOX.Parts[i].Dname = TVParts.Items[k - 1].Text then
        order[k] := i;

  kp:=0; kv:=0;
  for i:=1 to MOX.Qty.Parts do
  begin
    aDname[i]:=MOX.Parts[order[i]].Dname;
    aParts[i].xMid:=MOX.Parts[order[i]].xMid;
    aParts[i].yMid:=MOX.Parts[order[i]].yMid;
    aParts[i].zMid:=MOX.Parts[order[i]].zMid;
    aParts[i].fRadius:=MOX.Parts[order[i]].fRadius;
    aParts[i].TypeID:=MOX.Parts[order[i]].TypeID;
    aParts[i].x1:=MOX.Parts[order[i]].x1; aParts[i].x2:=MOX.Parts[order[i]].x2;
    aParts[i].y1:=MOX.Parts[order[i]].y1; aParts[i].y2:=MOX.Parts[order[i]].y2;
    aParts[i].z1:=MOX.Parts[order[i]].z1; aParts[i].z2:=MOX.Parts[order[i]].z2;
    CopyMemory(@aPartModify[i],@PartModify[order[i]],56); //55+1 !

    for k:=1 to MOX.Qty.Mat do
    begin
      i1:=(i-1)*MOX.Qty.Mat+k;            //destination
      i2:=(order[i]-1)*MOX.Qty.Mat+k;     //source

      aSRange[i1,1]:=kp;                                   //first poly
      aSRange[i1,2]:=MOX.Chunk[i2,2];                         //poly count
      inc(kp,MOX.Chunk[i2,2]);
      aSRange[i1,3]:=kv+1;                                 //first point
      inc(kv,MOX.Chunk[i2,4]-MOX.Chunk[i2,3]+1);
      aSRange[i1,4]:=kv;                                   //last point

      for j:=aSRange[i1,3] to aSRange[i1,4] do
      CopyMemory(@aVertex[j],@MOX.Vertice[MOX.Chunk[i2,3]+(j-aSRange[i1,3])],40);
      for j:=1 to aSRange[i1,2] do begin
        av[aSRange[i1,1]+j,1]:=MOX.Face[MOX.Chunk[i2,1]+j,1]+aSRange[i1,3]-MOX.Chunk[i2,3];
        av[aSRange[i1,1]+j,2]:=MOX.Face[MOX.Chunk[i2,1]+j,2]+aSRange[i1,3]-MOX.Chunk[i2,3];
        av[aSRange[i1,1]+j,3]:=MOX.Face[MOX.Chunk[i2,1]+j,3]+aSRange[i1,3]-MOX.Chunk[i2,3];
      end;
    end;
  end;

  CopyMemory(@PartModify,@aPartModify,length(PartModify)*56); //55+1 !
  CopyMemory(@MOX.Chunk,@aSRange,length(MOX.Chunk)*8); //1..4 of Word
  CopyMemory(@MOX.Vertice,@aVertex,length(MOX.Vertice)*40);//XYZXYZUV00 of Single
  CopyMemory(@MOX.Face,@av,length(MOX.Face)*6);                //1..3 of Word
  for i:=1 to MOX.Qty.Parts do
  begin
    MOX.Parts[i].Dname:=aDname[i];
    MOX.Parts[i].xMid:=aParts[i].xMid;
    MOX.Parts[i].yMid:=aParts[i].yMid;
    MOX.Parts[i].zMid:=aParts[i].zMid;
    MOX.Parts[i].fRadius:=aParts[i].fRadius;
    MOX.Parts[i].TypeID:=aParts[i].TypeID;
    MOX.Parts[i].x1:=aParts[i].x1; MOX.Parts[i].x2:=aParts[i].x2;
    MOX.Parts[i].y1:=aParts[i].y1; MOX.Parts[i].y2:=aParts[i].y2;
    MOX.Parts[i].z1:=aParts[i].z1; MOX.Parts[i].z2:=aParts[i].z2;
  end;

  CompileLoaded('MOX');
end;


procedure TForm1.RebuildPartsTree;
var
  i:Integer;
begin
  for i:=0 to TVParts.Items.Count-1 do
  begin
    if TVParts.Items[i].Level = 0 then
      MOX.Parts[i + 1].Parent := -1
    else // No parents
      MOX.Parts[i + 1].Parent := TVParts.Items[i].Parent.AbsoluteIndex;

    if not TVParts.Items[i].HasChildren then
      MOX.Parts[i + 1].Child := -1
    else // No childs
      MOX.Parts[i + 1].Child := TVParts.Items[i].AbsoluteIndex + 1;

    if TVParts.Items[i].getPrevSibling <> nil then
      MOX.Parts[i + 1].PrevInLevel := TVParts.Items[i].getPrevSibling.AbsoluteIndex
    else
      MOX.Parts[i + 1].PrevInLevel := -1;

    if TVParts.Items[i].getNextSibling <> nil then
      MOX.Parts[i + 1].NextInLevel := TVParts.Items[i].getNextSibling.AbsoluteIndex
    else
      MOX.Parts[i + 1].NextInLevel := -1;
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

  CBColor.Enabled:=not CBMonoColor.Checked;
  SetColorsToCurrent.Enabled:=not CBMonoColor.Checked;
  CBColorChange(nil);
end;


procedure TForm1.ConverseImp_COB;
var
  i,h:Integer;
begin
  if (Imp.VerticeCount>255) or (Imp.PolyCount>255) then
  begin
    MessageBox(Handle, 'Can''t import more than 255 vertices to COB', 'Error', MB_OK or MB_ICONERROR);
    Exit;
  end;

  COB.Head.PointQty:=Imp.VerticeCount;
  COB.Head.PolyQty:=Imp.PolyCount;

  for i:=1 to Imp.VerticeCount do
    COB.Vertices[i]:=Imp.XYZ[i];

  for i:=1 to Imp.PolyCount do
    COB.NormalsP[i]:=Imp.Np[i];

  for i:=1 to Imp.PolyCount do
    for h:=1 to 3 do
      COB.Faces[i,h]:=Imp.Faces[i,h]-1;

  ShowUpClick(cuCOB);
  RebuildCOBBounds;
  SetRenderObject([roCOB]);
end;

procedure TForm1.RebuildCOBBounds;
var
  i:Integer;
begin
COB.Head.Xmin:=0; COB.Head.Xmax:=0;
COB.Head.Ymin:=0; COB.Head.Ymax:=0;
COB.Head.Zmin:=0; COB.Head.Zmax:=0;
for i:=1 to COB.Head.PolyQty do begin //computing normal to every polygon
  Normal2Poly(COB.Vertices[COB.Faces[i,1]+1],COB.Vertices[COB.Faces[i,2]+1],COB.Vertices[COB.Faces[i,3]+1],@COB.NormalsP[i]);
  Normalize(COB.NormalsP[i]);
end;

for i:=1 to COB.Head.PointQty do begin
  COB.Head.Xmax:=max(COB.Head.Xmax,COB.Vertices[i].X);
  COB.Head.Ymax:=max(COB.Head.Ymax,COB.Vertices[i].Y);
  COB.Head.Zmax:=max(COB.Head.Zmax,COB.Vertices[i].Z);
  COB.Head.Xmin:=min(COB.Head.Xmin,COB.Vertices[i].X);
  COB.Head.Ymin:=min(COB.Head.Ymin,COB.Vertices[i].Y);
  COB.Head.Zmin:=min(COB.Head.Zmin,COB.Vertices[i].Z);
end;

COB.Head.X:=0;//Cob.Xmax+Cob.Xmin;
COB.Head.Y:=0;//Cob.Ymax+Cob.Ymin;
COB.Head.Z:=0;//Cob.Zmax+Cob.Zmin;

SendDataToUI(uiCOB);
end;

procedure TForm1.CoBCopyClick(Sender: TObject);
begin
COBCopyItem:=LBCOBPoints.ItemIndex+1;
if COBCopyItem>0 then COBPaste.Enabled:=True;
end;

procedure TForm1.COBPasteClick(Sender: TObject);
begin
if COBCopyItem<>EnsureRange(COBCopyItem,1,MOX.Qty.Blink) then begin
COBPaste.Enabled:=False;
Exit;
end;
COB.Vertices[LBCOBPoints.ItemIndex+1].X:=COB.Vertices[COBCopyItem].X;
COB.Vertices[LBCOBPoints.ItemIndex+1].Y:=COB.Vertices[COBCopyItem].Y;
COB.Vertices[LBCOBPoints.ItemIndex+1].Z:=COB.Vertices[COBCopyItem].Z;
RebuildCOBBounds;
SendDataToUI(uiCOB);
end;

procedure TForm1.LBCOBPointsClick(Sender: TObject);
var ID:Integer;
begin
ID:=LBCOBPoints.ItemIndex+1; if ID=0 then Exit;
COBRefresh:=True;
COBX.Value:=COB.Vertices[ID].X;
COBY.Value:=COB.Vertices[ID].Y;
COBZ.Value:=COB.Vertices[ID].Z;
COBRefresh:=False;
end;

procedure TForm1.COBXChange(Sender: TObject);
var ID:Integer;
begin
ID:=LBCOBPoints.ItemIndex+1; if ID=0 then Exit;
if COBRefresh then Exit;
COB.Vertices[ID].X:=COBX.Value;
COB.Vertices[ID].Y:=COBY.Value;
COB.Vertices[ID].Z:=COBZ.Value;
RebuildCOBBounds;
SendDataToUI(uiCOB);
end;

procedure TForm1.MatCopyClick(Sender: TObject);
begin
if MatID=0 then Exit;
ColorCopyID:=MatID;
MatPaste.Enabled:=True;
end;

procedure TForm1.MatPasteClick(Sender: TObject);
var
  i:Integer;
begin
if ColorCopyID<>EnsureRange(ColorCopyID,1,MOX.Qty.Mat) then begin
MatPaste.Enabled:=False; Exit; end;
for i:=1 to MAX_COLORS do Material[MatID].Color[i]:=Material[ColorCopyID].Color[i];
CBColorChange(nil);
end;

procedure TForm1.RGPivotClick(Sender: TObject);
begin
  if SelectedTreeNode=0 then Exit;
  CustomPivotX.Enabled:=RGPivotX.ItemIndex=3;
  CustomPivotY.Enabled:=RGPivotY.ItemIndex=3;
  CustomPivotZ.Enabled:=RGPivotZ.ItemIndex=3;

  if ForbidPivotChange then Exit;

  with PartModify[SelectedTreeNode] do begin
    if Sender=CustomPivotX then begin
    RGPivotX.ItemIndex:=3;
    Custom[1]:=CustomPivotX.Value;
    end;
    if Sender=CustomPivotY then begin
    RGPivotY.ItemIndex:=3;
    Custom[2]:=CustomPivotY.Value;
    end;
    if Sender=CustomPivotZ then begin
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

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  ID:Integer;
begin
  if SelectedTreeNode=0 then Exit;
  ID:=PivotPointActual.Value;
  ForbidPivotChange:=True;
  with PartModify[SelectedTreeNode] do
  begin
    Custom[1]:=MOX.Vertice[ID+MOX.Chunk[MOX.Parts[SelectedTreeNode].FirstMat+1,3]-1].X;
    Custom[2]:=MOX.Vertice[ID+MOX.Chunk[MOX.Parts[SelectedTreeNode].FirstMat+1,3]-1].Y;
    Custom[3]:=MOX.Vertice[ID+MOX.Chunk[MOX.Parts[SelectedTreeNode].FirstMat+1,3]-1].Z;
    CustomPivotX.Value:=Custom[1];
    CustomPivotY.Value:=Custom[2];
    CustomPivotZ.Value:=Custom[3];
    ActualPoint:=ID;
  end;
  ForbidPivotChange:=False;
  RGPivotClick(nil);//force update
end;


procedure TForm1.PSFSaveClick(Sender: TObject);
begin
  if not RunSaveDialog(Save1,Opened3DMask+'.psf','','MTKit2 Pivot Setup Files (*.psf)|*.psf','psf') then Exit;
  Memo1.Lines.Add('Assigning PSF file ...');
  SavePSF(Save1.FileName);
  Memo1.Lines.Add('PSF file closed');
end;


procedure TForm1.PSFLoadClick(Sender: TObject);
begin
  if TVParts.Items.Count<1 then Exit;
  //if Sender=PSFLoad then begin
  if not RunOpenDialog(Open1,'','','MTKit2 Pivot Setup Files (*.psf)|*.psf') then Exit;
  Memo1.Lines.Add('Reading PSF ...');
  if not LoadPSF(Open1.FileName) then Exit;
  Memo1.Lines.Add('PSF file closed');
end;


procedure TForm1.PBFSaveClick(Sender: TObject);
begin
  if not RunSaveDialog(Save1,Opened3DMask+'_colli.pbf','','MTKit2 Part Behaviour Files (*.pbf)|*.pbf','pbf') then Exit;
  Memo1.Lines.Add('Assigning PBF file ...');
  SavePBF(Save1.FileName);
  Memo1.Lines.Add('PBF file closed');
end;


procedure TForm1.PBFLoadClick(Sender: TObject);
begin
  if not RunOpenDialog(Open1,'','','MTKit2 Part Behaviour Files (*.pbf)|*.pbf') then Exit;
  Memo1.Lines.Add('Reading PBF ...');
  LoadPBF(Open1.FileName);
  Memo1.Lines.Add('PBF file processed and closed');
end;


procedure TForm1.CBActDamClick(Sender: TObject);
begin
  FlapParts.Enabled:=CBActDam.Checked;
  Label30.Enabled:=CBActDam.Checked;
  RenderOpts.ShowDamage:=CBActDam.Checked;
end;


procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  ii: Integer;
begin
  if MatID=0 then Exit;
  for ii:=1 to MAX_COLORS do
    with Material[MatID].Color[ii] do begin
      Dif.R:=DefaultColor[ii,1];
      Dif.G:=DefaultColor[ii,2];
      Dif.B:=DefaultColor[ii,3];
      Sp1.R:=DefaultSpec[1];
      Sp1.G:=DefaultSpec[2];
      Sp1.B:=DefaultSpec[3];
      Sp2.R:=DefaultSpec2[ii,1];
      Sp2.G:=DefaultSpec2[ii,2];
      Sp2.B:=DefaultSpec2[ii,3];
      Amb.R:=0;
      Amb.G:=0;
      Amb.B:=0;
      Ref.R:=DefaultReflect[ii,1];
      Ref.G:=DefaultReflect[ii,2];
      Ref.B:=DefaultReflect[ii,3];
    end;
  CBColorChange(nil);
end;


procedure TForm1.ResetMTLOrderClick(Sender: TObject);
var
  i:Integer;
begin
  for i:=1 to MOX.Qty.Mat do
    Material[i].Mtag:=IntToHex((i-1),4);
  SendDataToUI(uiMTL);
end;


procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  if TVParts.Selected = nil then Exit;

  SelectedTreeNode := TVParts.Selected.AbsoluteIndex+1;
  with PartModify[SelectedTreeNode] do
  begin
    MOX.Parts[SelectedTreeNode].xMid:=(High[1]+Low[1])/2;
    MOX.Parts[SelectedTreeNode].yMid:=(High[2]+Low[2])/2;
    MOX.Parts[SelectedTreeNode].zMid:=(High[3]+Low[3])/2;
    MOX.Parts[SelectedTreeNode].fRadius:=(High[1]-Low[1])/3+(High[2]-Low[2])/3+(High[3]-Low[3])/3;
  end;
  CX.Value:=MOX.Parts[SelectedTreeNode].xMid;
  CY.Value:=MOX.Parts[SelectedTreeNode].yMid;
  CZ.Value:=MOX.Parts[SelectedTreeNode].zMid;
  CRad.Value:=MOX.Parts[SelectedTreeNode].fRadius;
end;


procedure TForm1.B_COBRecomputeClick(Sender: TObject);
begin
  RebuildCOBBounds;
end;


procedure TForm1.FileListBox1Click(Sender: TObject);
begin
  FillChar(MOX.Qty,SizeOf(MOX.Qty),#0);
  FillChar(COB,SizeOf(COB),#0);
  FillChar(Tree,SizeOf(Tree),#0);
  ResetView(nil);
  LoadFile(FileListBox1.FileName,lmJustLoad);
end;


function TForm1.LoadFile(const aFilename: string; lm: TLoadMode):Boolean;
var
  i: Integer;
begin
  Result:=False;
  UpdateOpenedFileInfo(aFilename);
  ClearUpClick(cuALL);

  if GetFileExt(aFilename)='MOX' then
  begin
    LoadMOX(aFilename);
    ShowUpClick(cuMOX);
      LoadMTL(decs(aFilename,4,0)+'.mtl');
      LoadTextures;
      ScanVinyls(OpenedFolder);
      ShowUpClick(cuMTL);
    SetRenderObject([roMOX]);
    if LoadCOB(decs(aFilename,4,0)+'_colli.cob') then
    begin
      ShowUpClick(cuCOB);
      SetRenderObject([roMOX,roCOB]);
    end;
    if LoadCPO(decs(aFilename,4,0)+'_colli.cpo') then
    begin
      ShowUpClick(cuCPO);
      SetRenderObject([roMOX,roCPO]);
    end;
    if LoadCPO(decs(aFilename,4,0)+'.cpo') then
    begin
      ShowUpClick(cuCPO);
      SetRenderObject([roMOX,roCPO]);
    end;
    if lm = lmLoadAndShow then
      SetActivePage(apMTL);
  end;

  if GetFileExt(aFilename)='COB' then
  begin
    if not LoadCOB(aFilename) then Exit;
    ShowUpClick(cuCOB);
    SetRenderObject([roCOB]);
    if lm=lmLoadAndShow then SetActivePage(apCOB);
  end;

  if GetFileExt(aFilename)='CPO' then
    if LoadCPO(aFilename) then
    begin
      SetRenderObject([roCPO]);
      ShowUpClick(cuCPO);
      if lm=lmLoadAndShow then SetActivePage(apCPO);
    end;

  if GetFileExt(aFilename)='TREE'then
  begin
    LoadTree(aFilename);
    CompileLoaded('TREE');
    for i:=1 to 2 do begin
      glDeleteTextures(1,@TreeTex[i]); //Clear RAM used by textures
      TreeTex[i]:=TryToLoadTexture(TreeTexNames[i]);
    end;
    ShowUpClick(cuTREE);
    Memo1.Lines.Add('TREE Loaded ...');
    SetRenderObject([roTREE]);
  end;

  Result:=True;
end;


procedure TForm1.PageControl1Change(Sender: TObject);
begin
  SelectedTreeNode:=0;
  case PageControl1.TabIndex of
    0: ActivePage:=apMTL;
    1: ActivePage:=apParts;
    2: ActivePage:=apLights;
    3: ActivePage:=apCOB;
    4: ActivePage:=apCPO;
    5: ActivePage:=apExtra;
    6: ActivePage:=apBrowse;
  end;
end;


procedure TForm1.SetActivePage(ap:apActivePage);
begin
  ActivePage:=ap;
  case ap of
    apMTL    : PageControl1.ActivePageIndex:=0;
    apParts  : PageControl1.ActivePageIndex:=1;
    apLights : PageControl1.ActivePageIndex:=2;
    apCOB    : PageControl1.ActivePageIndex:=3;
    apCPO    : PageControl1.ActivePageIndex:=4;
    apExtra  : PageControl1.ActivePageIndex:=5;
    apBrowse : PageControl1.ActivePageIndex:=6;
  end;
end;


procedure TForm1.SetRenderObject(ro:roRenderObject);
begin
  RenderObject:=ro;
end;


procedure TForm1.ResetView(Sender: TObject);
begin
  xMov:=0;
  yMov:=0;
  xRot:=-30;
  yRot:=20;
  Zoom:=0.3125;
end;


procedure TForm1.CBRenderModeChange(Sender: TObject);
begin
  if not UseShaders then CBRenderMode.ItemIndex:=0;
  case CBRenderMode.ItemIndex of
    0: RenderMode:=rmOpenGL;
    1: RenderMode:=rmShaders;
  end;
end;


procedure TForm1.ShapeAMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  r,g,b: Integer;
begin
  if MatID = 0 then Exit;

  r := (Sender as TShape).Brush.Color mod 256;
  g := (Sender as TShape).Brush.Color mod 65536 div 256;
  b := (Sender as TShape).Brush.Color mod 16777216 div 65536;

  DefineInputColor(r,g,b,Sender);
end;

procedure TForm1.ShapeADragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if (MatID <> 0) and (ColID <> 0) then
  with Material[MatID].Color[ColID] do
  begin
    Amb.R:=ShapeA.Brush.Color mod 256;
    Amb.G:=ShapeA.Brush.Color div 256 mod 256;
    Amb.B:=ShapeA.Brush.Color div 65536;
    Dif.R:=ShapeD.Brush.Color mod 256;
    Dif.G:=ShapeD.Brush.Color div 256 mod 256;
    Dif.B:=ShapeD.Brush.Color div 65536;
    Sp1.R:=ShapeS1.Brush.Color mod 256;
    Sp1.G:=ShapeS1.Brush.Color div 256 mod 256;
    Sp1.B:=ShapeS1.Brush.Color div 65536;
    Sp2.R:=ShapeS2.Brush.Color mod 256;
    Sp2.G:=ShapeS2.Brush.Color div 256 mod 256;
    Sp2.B:=ShapeS2.Brush.Color div 65536;
    Ref.R:=ShapeR.Brush.Color mod 256;
    Ref.G:=ShapeR.Brush.Color div 256 mod 256;
    Ref.B:=ShapeR.Brush.Color div 65536;
  end;

  if LitID <> 0 then
  if ActivePage = apLights then
  begin
    MOX.Blinkers[LitID].R:=ShapeL.Brush.Color mod 256;
    MOX.Blinkers[LitID].G:=ShapeL.Brush.Color div 256 mod 256;
    MOX.Blinkers[LitID].B:=ShapeL.Brush.Color div 65536;
    MOX.Blinkers[LitID].A:=255;
  end;

  if ActivePage = apExtra then
  begin
    BGColor[1]:=ShapeBG.Brush.Color mod 256;
    BGColor[2]:=ShapeBG.Brush.Color div 256 mod 256;
    BGColor[3]:=ShapeBG.Brush.Color div 65536;
    WFColor[1]:=ShapeWF.Brush.Color mod 256;
    WFColor[2]:=ShapeWF.Brush.Color div 256 mod 256;
    WFColor[3]:=ShapeWF.Brush.Color div 65536;
  end;
end;


procedure TForm1.FPSLimitEditChange(Sender: TObject);
begin
  FPSLag := max(1, round(1000 / FPSLimitEdit.Value));
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  DefColor:=ComboBox1.ItemIndex;
end;

procedure TForm1.LBCPOShapesClick(Sender: TObject);
var
  I: Integer;
  ax,ay,az: Integer;
begin
  I:=LBCPOShapes.ItemIndex+1;
  if I = 0 then Exit;
  COBRefresh:=True;

  CPOX.Value:=CPO[I].PosX;
  CPOY.Value:=CPO[I].PosY;
  CPOZ.Value:=CPO[I].PosZ;
  CPOSX.Enabled:=CPO[I].Format=2;
  CPOSY.Enabled:=CPO[I].Format=2;
  CPOSZ.Enabled:=CPO[I].Format=2;
  if CPO[I].Format=2 then begin
    CPOSX.Value:=CPO[I].ScaleX;
    CPOSY.Value:=CPO[I].ScaleY;
    CPOSZ.Value:=CPO[I].ScaleZ;
  end;
  Matrix2Angles(CPO[I].Matrix9,9,@ax,@ay,@az);

  CPORH.Value:=round(ax);
  CPORP.Value:=round(ay);
  CPORB.Value:=round(az);
  COBRefresh:=False;
end;

procedure TForm1.CPOChange(Sender: TObject);
var
  I: Integer;
begin
  I:=LBCPOShapes.ItemIndex+1; if I=0 then Exit;
  if COBRefresh then Exit;
  CPO[I].PosX:=CPOX.Value;
  CPO[I].PosY:=CPOY.Value;
  CPO[I].PosZ:=CPOZ.Value;
  CPO[I].ScaleX:=CPOSX.Value;
  CPO[I].ScaleY:=CPOSY.Value;
  CPO[I].ScaleZ:=CPOSZ.Value;

  Angles2Matrix(CPORH.Value,CPORP.Value,CPORB.Value, @CPO[I].Matrix9, 9);
end;

procedure TForm1.CPOAddClick(Sender: TObject);
var
  ID,IDnew:Integer;
begin
  if CPOHead.Qty>=MAX_CPO_SHAPES then Exit;
  if CPOHead.Qty=0 then begin
    ShowUpClick(cuCPO);
    FillChar(CPOHead,SizeOf(CPOHead),#0);
    CPOHead.Head:='!OPC';
  end;
  ID:=LBCPOShapes.ItemIndex+1;
  inc(CPOHead.Qty);
  IDnew:=CPOHead.Qty;
  if (ID=0)or(CPO[ID].Format=3) then begin
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

  SetRenderObject(RenderObject + [roCPO]);

  LBCPOShapes.ItemIndex:=LBCPOShapes.Count-1;
end;


procedure TForm1.CPORemClick(Sender: TObject);
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
  UseShaders := LoadFresnelShader;
end;


procedure TForm1.CBShowGridClick(Sender: TObject);
begin
  CBShowGrid.Checked:=not CBShowGrid.Checked;
end;


procedure TForm1.CBChromeClick(Sender: TObject);
begin
  Chrome1.Checked:= not Chrome1.Checked;
  RenderChrome:=Chrome1.Checked;
end;


procedure TForm1.Lightvectors1Click(Sender: TObject);
begin
  Lightvectors1.Checked := not Lightvectors1.Checked;
end;


procedure TForm1.CBShowPartClick(Sender: TObject);
begin
  RenderOpts.ShowPart := CBShowPart.Checked;
end;


procedure TForm1.FlapPartsChange(Sender: TObject);
begin
  RenderOpts.PartsFlapPos := 1 - FlapParts.Position / FlapParts.Max;
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
  if Sender=SB_Light then RenderOpts.LightVec:=SB_Light.Down;
  if Sender=SB_Colli then RenderOpts.Colli:=SB_Colli.Down;
  if Sender=SB_Wire then RenderOpts.Wire:=SB_Wire.Down;
  if Sender=SB_UVmap then begin
    RenderOpts.UVMap:=SB_UVmap.Down;
    RenderResize(nil);
  end;
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
  if not RunOpenDialog(Open1,'',OpenedFolder,'World Racing 2 object files (*.mox)|*.mox') then Exit;
  LoadFile(Open1.FileName,lmLoadAndShow);
end;

procedure TForm1.LoadCOBClick(Sender: TObject);
begin
  if not RunOpenDialog(Open1,'',OpenedFolder,'World Racing 2 collision files (*.cob)|*.cob') then Exit;
  LoadFile(Open1.FileName,lmLoadAndShow);
end;

procedure TForm1.LoadCPOClick(Sender: TObject);
begin
  if not RunOpenDialog(Open1,'',OpenedFolder,'Alarm for Cobra 11 Nitro collision files (*.cpo)|*.cpo') then Exit;
  LoadFile(Open1.FileName,lmLoadAndShow);
end;

procedure TForm1.LoadTREE1Click(Sender: TObject);
begin
  if not RunOpenDialog(Open1,'',OpenedFolder,'World Racing 2 tree files (*.tree)|*.tree') then Exit;
  LoadFile(Open1.FileName,lmLoadAndShow);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.SaveMOXClick(Sender: TObject);
begin
  if not RunSaveDialog(Save1, Opened3DMask + '.mox', '', 'World Racing 2 object files (*.mox)|*.mox', 'mox') then Exit;

  Memo1.Lines.Add('Saving MOX file ...');
  SaveMOX(Save1.FileName);
  Memo1.Lines.Add('MOX file written');
end;

procedure TForm1.SaveMTL1Click(Sender: TObject);
begin
  if not RunSaveDialog(Save1,Opened3DMask+'.mtl','','World Racing Material files (*.mtl)|*.mtl','mtl') then Exit;
  //Save1.FileName:=AssureFileExt(Save1.FileName,'mtl');
  Memo1.Lines.Add('Saving MTL file ...');
  SaveMTL(Save1.FileName);
  Memo1.Lines.Add('MTL file written');
end;

procedure TForm1.SaveCOB1Click(Sender: TObject);
begin
  if not RunSaveDialog(Save1,Opened3DMask+'_colli.cob','','World Racing 2 collision files (*.cob)|*.cob','cob') then Exit;
  RebuildCOBBounds; //Need to recompute BBOX and normals
  SaveCOB(Save1.FileName);
end;

procedure TForm1.SaveCPO1Click(Sender: TObject);
begin
  if not RunSaveDialog(Save1,Opened3DMask+'.cpo','','World Racing 2 collision files (*.cpo)|*.cpo','cpo') then Exit;
  SaveCPO(Save1.FileName);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Import3DSMOX1Click(Sender: TObject);
var
  log: string;
begin
  if not RunOpenDialog(Open1,'',OpenedFolder,'3DMax object files (*.3ds)|*.3ds') then Exit;
  if not Load3DS(Open1.FileName,log) then Exit;
  Memo1.Lines.Add(log);
  RebuildImpNormals;
  ConverseImp_MOX;
  UpdateOpenedFileInfo(Open1.FileName)
end;

procedure TForm1.ImportOBJMOX1Click(Sender: TObject);
var
  log: string;
begin
  if not RunOpenDialog(Open1,'',OpenedFolder,'OBJ object files (*.obj)|*.obj') then Exit;
  if not LoadOBJ(Open1.FileName,log) then Exit;
  Memo1.Lines.Add(log);
  ConverseImp_MOX;
  UpdateOpenedFileInfo(Open1.FileName)
end;

procedure TForm1.ImportLWO1Click(Sender: TObject);
var
  log: string;
begin
  if not RunOpenDialog(Open1,'',OpenedFolder,'Lightwave 3D files (*.lwo)|*.lwo') then Exit;
  if not LoadLWO(Open1.FileName,log) then Exit;
  Memo1.Lines.Add(log);
  RebuildImpNormals;
  ConverseImp_MOX;
  UpdateOpenedFileInfo(Open1.FileName);
end;


procedure TForm1.ImportLWO2Click(Sender: TObject);
begin
  ImportLWO1Click(nil);

  LoadMTL(Opened3DMask+'.mtl');
  LoadTextures;
  ScanVinyls(OpenedFolder);
  ShowUpClick(cuMTL);

  LoadPSF(Opened3DMask+'.psf');
  LoadPBF(Opened3DMask+'.pbf');
  LoadLights(Opened3DMask+'.lsf');
  SendDataToUI(uiLights);
  BlinkerPaste.Enabled:=False;
end;


procedure TForm1.ImportLWOCOB1Click(Sender: TObject);
var Log: string;
begin
  if not RunOpenDialog(Open1,'',OpenedFolder,'Lightwave 3D files (*.lwo)|*.lwo') then Exit;
  LoadLWO(Open1.FileName, Log);
  ConverseImp_COB;
end;


procedure TForm1.ExportMOX1Click(Sender: TObject);
var
  doSpread: Boolean;
begin
  if not RunSaveDialog(Save1,Opened3DMask+'.lwo','','Lightwave 3D files (*.lwo)|*.lwo','lwo') then Exit;

  Memo1.Lines.Add('Writing MOX>LWO file');

  doSpread := MessageBox(Handle, 'Do you want to spread parts over X axis?', 'Question', MB_YESNO or MB_ICONQUESTION) = ID_YES;

  SaveMOX2LWO(Save1.FileName, doSpread);

  Memo1.Lines.Add('MOX>LWO Save Complete');
end;


procedure TForm1.ExportCOB1Click(Sender: TObject);
begin
  if not RunSaveDialog(Save1,Opened3DMask+'_colli.lwo','','Lightwave 3D files (*.lwo)|*.lwo','lwo') then Exit;
  Memo1.Lines.Add('Writing COB>LWO file');
  SaveCOB2LWO(Save1.FileName);
  Memo1.Lines.Add('COB>LWO Save Complete');
end;


procedure TForm1.ClearUpClick(aClearup: TClearUp);
begin
  RenderOpts.LightVec:=False;
  RenderOpts.Colli:=False;
  RenderOpts.Wire:=False;
  RenderOpts.UVMap:=False;
  RenderResize(nil);

  if aClearup in [cuMOX, cuALL] then
  begin
    FillChar(MOX,SizeOf(MOX),#0);
    BlinkerCopy.Enabled:=False;
    BlinkerPaste.Enabled:=False;
    LoadBlink.Enabled:=False;
    SaveBlink.Enabled:=False;
    AddBlink.Enabled:=False;
    RemBlink.Enabled:=False;
    PBFLoad.Enabled:=False;
    PBFSave.Enabled:=False;
    SB_Light.Down:=False;
    SB_Light.Enabled:=False;
    SB_UVMap.Down:=False;
    SB_UVMap.Enabled:=False;
    SB_Wire.Down:=False;
    SB_Wire.Enabled:=False;
    SendDataToUI(uiParts);
    SendDataToUI(uiLights);
    SendDataToUI(uiMOX);
  end;

  if aClearup in [cuMTL, cuALL] then
  begin
    FillChar(Material,SizeOf(Material),#0);
    NumColors:=0;
    SaveMTL1.Enabled:=False;
    MatCopy.Enabled:=False;
    MatPaste.Enabled:=False;
    ResetMTLOrder.Enabled:=False;
    CBMonoColor.Checked:=False;
    SendDataToUI(uiMTL);
    SendDataToUI(uiVin);
  end;

  if aClearup in [cuCOB, cuALL] then
  begin
    FillChar(COB,SizeOf(COB),#0);
    SB_Colli.Down:=False;
    SB_Colli.Enabled:=False;
    SaveCOB1.Enabled:=False;
    COBCopy.Enabled:=False;
    COBPaste.Enabled:=False;
    ExportCOB1.Enabled:=False;
    SendDataToUI(uiCOB);
  end;

  if aClearup in [cuCPO, cuALL] then
  begin
    FillChar(CPO,SizeOf(CPO),#0);
    FillChar(CPOHead,SizeOf(CPOHead),#0);
    SB_Colli.Down:=False;
    SB_Colli.Enabled:=False;
    SaveCPO1.Enabled:=False;
    SendDataToUI(uiCPO);
  end;

  if aClearup in [cuTREE, cuALL] then
  begin
    FillChar(Tree,SizeOf(Tree),#0);
    SB_Wire.Down:=False;
    SB_Wire.Enabled:=False;
  end;
end;

procedure TForm1.ShowUpClick(aClearup: TClearUp);
begin
  if aClearup = cuMOX then
  begin
    SendDataToUI(uiParts);
    SendDataToUI(uiLights);
    SendDataToUI(uiMOX);

    BlinkerCopy.Enabled:=True;
    BlinkerPaste.Enabled:=False;
    AddBlink.Enabled:=True;
    RemBlink.Enabled:=True;
    LoadBlink.Enabled:=True;
    SaveBlink.Enabled:=True;
    PBFLoad.Enabled:=True;
    PBFSave.Enabled:=True;
    SB_Light.Enabled:=True;
    SB_Wire.Enabled:=True;
    SB_UVMap.Enabled:=True;
  end;

  if aClearup=cuMTL then
  begin
    SaveMTL1.Enabled:=True;
    MatCopy.Enabled:=True;
    MatPaste.Enabled:=False;
    ResetMTLOrder.Enabled:=True;
    CBMonoColor.Checked:=NumColors=1;
    MatMonoColorClick(nil);
    SendDataToUI(uiMTL);
    SendDataToUI(uiVin);
  end;

  if aClearup=cuCOB then
  begin
    SB_Colli.Enabled:=True;
    SaveCOB1.Enabled:=True;
    ExportCOB1.Enabled:=True;
    COBCopy.Enabled:=True;
    COBPaste.Enabled:=False;
    SendDataToUI(uiCOB);
  end;

  if aClearup=cuCPO then
  begin
    SB_Colli.Enabled:=True;
    SaveCPO1.Enabled:=True;
    SendDataToUI(uiCPO);
  end;

  if aClearup=cuTREE then
    SB_Wire.Enabled:=True;
end;


procedure TForm1.CBVinylChange(Sender: TObject);
var
  I: Integer;
begin
  I := CBVinyl.ItemIndex;
  if I < 1 then Exit;

  if FileExists(OpenedFolder+'\Textures_PC\Vinyls\'+VinylsList[I]) then
    LoadTexturePTX(OpenedFolder+'\Textures_PC\Vinyls\'+VinylsList[I], VinylsTex);
end;


procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if ( MousePos.X >= ClientOrigin.X + RenderPanel.Left ) and
     ( MousePos.X <  ClientOrigin.X + RenderPanel.Left + RenderPanel.Width ) and
     ( MousePos.Y >= ClientOrigin.Y + RenderPanel.Top ) and
     ( MousePos.Y <  ClientOrigin.Y + RenderPanel.Top + RenderPanel.Height )
  then
  begin
    zoom := zoom + WheelDelta / 4000;
    Handled := True;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  log:string;
  aFilename:string;
begin
  aFilename:=ExeDir+'LoadOBJ\clkdtm.obj';
  //aFilename:=ExeDir+'LoadOBJ\oacwr2.obj';
  if not LoadOBJ(aFilename,log) then Exit;
  Memo1.Lines.Add(log);
  ConverseImp_MOX;
  UpdateOpenedFileInfo(aFilename);
end;

procedure TForm1.KnowScale(Sender: TObject);
var
  i:Integer;
  AbsMin,AbsMax:Single;
begin
  AbsMin := MaxSingle;
  AbsMax := -MaxSingle;
  for i := 1 to MOX.Qty.Vertice do
  begin
    AbsMin := min(AbsMin, MOX.Vertice[i].X, MOX.Vertice[i].Y);
    AbsMin := min(AbsMin, MOX.Vertice[i].Z);
    AbsMax := max(AbsMax, MOX.Vertice[i].X, MOX.Vertice[i].Y);
    AbsMax := max(AbsMax, MOX.Vertice[i].Z);
  end;

  zoom := sqrt(5.5 / (AbsMax - AbsMin)); // 5.5 looks about right
end;


procedure TForm1.B_CPOImportClick(Sender: TObject);
var
  log:string;
  i,h,IDnew:Integer;
begin
  if not RunOpenDialog(Open1,'',OpenedFolder,'Lightwave 3D files (*.lwo)|*.lwo') then Exit;
  if not LoadLWO(Open1.FileName,log) then Exit;
  Memo1.Lines.Add(log);

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

  SetRenderObject(RenderObject + [roCPO]);

  LBCPOShapes.ItemIndex := LBCPOShapes.Count-1;
end;

procedure TForm1.B_CPOExportClick(Sender: TObject);
var
  I: Integer;
begin
  I := LBCPOShapes.ItemIndex+1;
  if (I=0)or(CPO[I].Format=2) then
  begin
    MessageBox(Handle, 'Select a freeform shape from list above', 'Error', MB_OK or MB_ICONERROR);
    Exit;
  end;

  if not RunSaveDialog(Save1,Opened3DMask+'.lwo','','Lightwave 3D files (*.lwo)|*.lwo','lwo') then
    Exit;

  Memo1.Lines.Add('Writing CPO>LWO file');
  SaveCPO2LWO(Save1.FileName,I);
  Memo1.Lines.Add('CPO>LWO Save Complete');
end;


procedure TForm1.LBBlinkersDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  MyRect:TRect; MyColor:TColor; ID:Integer; ColorID:Integer;
begin
  ID := Index+1;
  MyRect := Rect;

  MyRect.Left := 1;
  MyRect.Right := 15;
  inc(MyRect.Top);
  dec(MyRect.Bottom,2);

  with (Control as TListBox).Canvas do begin
    MyColor := Brush.Color; //Save default color
    FillRect(Rect);

    if Control.Name='LBBlinkers' then
    begin
      Brush.Color := MOX.Blinkers[ID].R+MOX.Blinkers[ID].G*256+MOX.Blinkers[ID].B*65536;
      FillRect(MyRect);
    end;

    if Control.Name='LBMaterials' then
    begin
      ColorID := CBColor.ItemIndex+1;
      with Material[ID].Color[ColorID].Dif do
      Brush.Color := R + G shl 8 + B shl 16;
      FillRect(MyRect);
      inc(MyRect.Left,5);
      with Material[ID].Color[ColorID].Sp2 do
      Brush.Color := R + G shl 8 + B shl 16;
      FillRect(MyRect);
      inc(MyRect.Left,5);
      with Material[ID].Color[ColorID].Sp1 do
      Brush.Color := R + G shl 8 + B shl 16;
      FillRect(MyRect);
    end;

    Brush.Color:=MyColor;
    TextOut(MyRect.Right+4, Rect.Top, (Control as TListBox).Items[Index]);
  end;
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
  RegisterFileType('mox', Application.ExeName);
  MessageBox(Handle, 'Registered', 'Info', MB_OK or MB_ICONINFORMATION);
end;


end.
