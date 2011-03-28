unit Unit1;
interface
uses
  dglOpenGL, OpenGL, JPEG, FloatSpinEdit, ValEdit,
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, kromUtils, KromOGLUtils, Unit_Defaults, Math, Menus,
  LoadObjects, Grids,  ImgList, OpenAL, WR_AboutBox, SK_Options, FileCtrl,
  Buttons, Spin, ComCtrls, Unit_Grass, Unit_Streets, Unit_Triggers;

type TCarDrivingMode = (cdm_Sim, cdm_Arcade);
const CarDrivingMode: array[TCarDrivingMode] of string = ('Sim', 'Arcade');


type
  TForm1 = class(TForm)
    OpenDialog: TOpenDialog;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet; TabSheet2: TTabSheet; TabSheet3: TTabSheet;
    ListTrig: TListBox;
    TabSheet5: TTabSheet;
    ListSNIObjects: TListBox;
    TabSheet6: TTabSheet;
    ListLights: TListBox;
    TabSheet7: TTabSheet;
    SaveDialog: TSaveDialog;
    AddTrigger: TButton;
    CBTriggerType: TComboBox;
    TRL_X: TFloatSpinEdit;
    TRL_Y: TFloatSpinEdit;
    TRL_Z: TFloatSpinEdit;
    TRL_S1: TFloatSpinEdit;
    TRL_S2: TFloatSpinEdit;
    TRL_S3: TFloatSpinEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    TRL_R1: TSpinEdit;
    TRL_R2: TSpinEdit;
    TRL_R3: TSpinEdit;
    TRL_Flags: TEdit;
    TRL_P1: TFloatSpinEdit;
    TRL_P2: TFloatSpinEdit;
    TRL_P3: TFloatSpinEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    LVL_SunY: TFloatSpinEdit;
    Label22: TLabel;
    Label23: TLabel;
    TabSheet4: TTabSheet;
    ListObjects: TListBox;
    Label28: TLabel;
    TabSheet8: TTabSheet;
    ListObjects2: TListBox;
    Label29: TLabel;
    TabSheet9: TTabSheet;
    LoadLWOScen: TButton;
    MemoLWO: TMemo;
    Label31: TLabel;
    ObjHit: TEdit;
    ObjFall: TEdit;
    Label34: TLabel;
    Label35: TLabel;
    ObjWeight: TSpinEdit;
    Label36: TLabel;
    TabSheet10: TTabSheet;
    ListMaterials: TListBox;
    Label38: TLabel;
    RGMatMode: TRadioGroup;
    CBTex1: TComboBox;
    CBTex2: TComboBox;
    CBTex3: TComboBox;
    CBShowMat: TCheckBox;
    TabSheet11: TTabSheet;
    ListSounds: TListBox;
    Label39: TLabel;
    PanelMove: TPanel;
    PanelRotate: TPanel;
    PanelZoom: TPanel;
    ImageMove: TImage;
    ImageRotate: TImage;
    ImageZoom: TImage;
    Label40: TLabel;
    MatTexLay: TPageControl;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    Label41: TLabel;
    Label42: TLabel;
    ListSNINodes: TListBox;
    Label46: TLabel;
    Label52: TLabel;
    ListObjectsSNI: TComboBox;
    SNIx1: TSpinEdit;
    SNIx2: TSpinEdit;
    SNIx3: TSpinEdit;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    CBMatFilter: TComboBox;
    TexScaleX: TFloatSpinEdit;
    TexScaleY: TFloatSpinEdit;
    TexMoveX: TFloatSpinEdit;
    TexMoveY: TFloatSpinEdit;
    TabSheet15: TTabSheet;
    ListTextures: TListBox;
    Label58: TLabel;
    AddTexture: TButton;
    RemTexture: TButton;
    ImportTexturesList: TButton;
    ExportTexturesList: TButton;
    CBGrid: TCheckBox;
    SoundPosX: TFloatSpinEdit;
    SoundPosY: TFloatSpinEdit;
    SoundPosZ: TFloatSpinEdit;
    Label18: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    SoundVolume: TSpinEdit;
    SoundPlaySpeed: TSpinEdit;
    SoundRadius: TSpinEdit;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    EditSoundName: TEdit;
    Label68: TLabel;
    SoundX5: TSpinEdit;
    Label65: TLabel;
    Label66: TLabel;
    AddSound: TButton;
    RemSound: TButton;
    ResetViewButton: TButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    About1: TMenuItem;
    CBTraceMat: TCheckBox;
    RGTexMat: TRadioGroup;
    CBShowTexInMat: TCheckBox;
    TabSheet16: TTabSheet;
    SoundX6: TFloatSpinEdit;
    ImportSounds: TButton;
    ExportSounds: TButton;
    RemTrigger: TButton;
    ListGrounds: TListBox;
    SpinEdit1: TSpinEdit;
    SE_GripF: TSpinEdit;
    SE_GripR: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Label70: TLabel;
    AddGround: TButton;
    RemGround: TButton;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    CBShowGround: TCheckBox;
    TabSheet17: TTabSheet;
    ListTOB2: TListBox;
    TOB_X: TFloatSpinEdit;
    Label81: TLabel;
    Label82: TLabel;
    TOB_Y: TFloatSpinEdit;
    TOB_Z: TFloatSpinEdit;
    Label83: TLabel;
    TOB_A: TFloatSpinEdit;
    Label84: TLabel;
    TOB_B: TFloatSpinEdit;
    Label85: TLabel;
    TOB_R1: TSpinEdit;
    Label86: TLabel;
    TOB_R2: TSpinEdit;
    TOB_R3: TSpinEdit;
    AddTOB: TButton;
    RemTOB: TButton;
    Label87: TLabel;
    Label88: TLabel;
    ListObjectsTOB: TComboBox;
    Label90: TLabel;
    RemObject: TButton;
    MemoSave: TMemo;
    EditSNISound: TEdit;
    Label93: TLabel;
    SNI_Node_X: TFloatSpinEdit;
    SNI_Node_Y: TFloatSpinEdit;
    SNI_Node_Z: TFloatSpinEdit;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    SNI_Node_Speed: TFloatSpinEdit;
    Label97: TLabel;
    SNI_Node_B: TFloatSpinEdit;
    Label98: TLabel;
    ObjX: TFloatSpinEdit;
    ObjY: TFloatSpinEdit;
    ObjZ: TFloatSpinEdit;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    ObjSize: TFloatSpinEdit;
    Label104: TLabel;
    ObjAngl: TSpinEdit;
    AddObject: TButton;
    CBObjShape: TRadioGroup;
    CBObjMode: TRadioGroup;
    SoundX4: TRadioGroup;
    AddObjInstance: TButton;
    RemObjInstance: TButton;
    StructMode: TRadioGroup;
    CBTracer: TCheckBox;
    CBSNIMode: TRadioGroup;
    Label32: TLabel;
    Button12: TButton;
    Button15: TButton;
    Gr_Skid: TRadioGroup;
    Gr_Noise: TRadioGroup;
    ExportGrounds: TButton;
    ImportGrounds: TButton;
    ListStreetShape: TListBox;
    TabSheet18: TTabSheet;
    RG_GrassLOD: TRadioGroup;
    STROff1: TFloatSpinEdit;
    STROff2: TFloatSpinEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Button18: TButton;
    Button19: TButton;
    ListSKY: TListBox;
    Label67: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    STRPointZ: TFloatSpinEdit;
    STRPointY: TFloatSpinEdit;
    STRPointX: TFloatSpinEdit;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    STRPointID: TSpinEdit;
    STRPointT: TSpinEdit;
    Label99: TLabel;
    Label106: TLabel;
    STRSplineID1: TSpinEdit;
    Label109: TLabel;
    STRSplineID2: TSpinEdit;
    STRSplineLenA1: TFloatSpinEdit;
    Label110: TLabel;
    STRSplineLenB1: TFloatSpinEdit;
    STRSplineLenA2: TFloatSpinEdit;
    STRSplineLenB2: TFloatSpinEdit;
    Label108: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    CBSplineSymmetry: TCheckBox;
    EditNodes: TSpeedButton;
    AddShape: TButton;
    RemShape: TButton;
    STRLanes: TSpinEdit;
    Label115: TLabel;
    Label117: TLabel;
    CBTrack: TComboBox;
    Label4: TLabel;
    CBShowTrack: TCheckBox;
    LightX: TFloatSpinEdit;
    LightY: TFloatSpinEdit;
    LightZ: TFloatSpinEdit;
    Label120: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    AddLight: TButton;
    RemLight: TButton;
    LightWRad: TSpinEdit;
    Label129: TLabel;
    GroupBox1: TGroupBox;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    LE_Pow: TFloatSpinEdit;
    LE_Mul: TFloatSpinEdit;
    LE_Add: TSpinEdit;
    LE_RGB: TButton;
    LE_Shadow: TButton;
    Label130: TLabel;
    ImportLWOTrack: TButton;
    TabSheet20: TTabSheet;
    ImportMatList: TButton;
    ExportMatList: TButton;
    Label69: TLabel;
    Label89: TLabel;
    Label133: TLabel;
    ImportNFSPUSounds: TButton;
    SC2_Name: TEdit;
    Label134: TLabel;
    SC2_EngName: TEdit;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    SC2_ScnTracks: TSpinEdit;
    Label138: TLabel;
    SC2T_Title: TEdit;
    Label139: TLabel;
    Label140: TLabel;
    SC2T_Direction: TRadioGroup;
    SC2_FreeRideTrack: TSpinEdit;
    Label142: TLabel;
    SC2_TrackList: TListBox;
    SC2_Author: TEdit;
    SC2_Converter: TEdit;
    Label143: TLabel;
    Label144: TLabel;
    SC2_Contact: TEdit;
    Label145: TLabel;
    SC2_Comments: TMemo;
    FillSC2: TBitBtn;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    RenderModeMenu: TMenuItem;
    STRSplineShape1: TSpinEdit;
    STRSplineShape2: TSpinEdit;
    Label147: TLabel;
    STR_Mode: TRadioGroup;
    STRSplineOpt11: TCheckBox;
    STRSplineOpt13: TCheckBox;
    STRSplineOpt23: TCheckBox;
    STRSplineOpt21: TCheckBox;
    Label113: TLabel;
    Label149: TLabel;
    Label150: TLabel;
    Label151: TLabel;
    Label116: TLabel;
    Label152: TLabel;
    RemPoint: TButton;
    RemSpline: TButton;
    STRShapeOpt1_Always0: TCheckBox;
    STRShapeOpt2_Always0: TCheckBox;
    VLBInfo: TValueListEditor;
    RG_GrassMode: TRadioGroup;
    GrassPlainColor: TButton;
    LightRY: TFloatSpinEdit;
    Label153: TLabel;
    LightFreq: TFloatSpinEdit;
    Label155: TLabel;
    LightOffset: TFloatSpinEdit;
    Label156: TLabel;
    LightSize: TFloatSpinEdit;
    Label157: TLabel;
    LightWMode: TCheckBox;
    SpecialFuncions1: TMenuItem;
    MBWRSceneryFix1: TMenuItem;
    ExportLights: TButton;
    ImportLights: TButton;
    Gr_NoColli: TCheckBox;
    LoadLWOLightsButton: TButton;
    MemoLoad: TMemo;
    SaveScenery: TMenuItem;
    LBTrack: TListBox;
    Label59: TLabel;
    AddTrack: TButton;
    TRK_Loop: TCheckBox;
    Button11: TButton;
    LVL_SunXZ: TFloatSpinEdit;
    SwitchVerticeColors1: TMenuItem;
    CopyLight: TBitBtn;
    PasteLight: TBitBtn;
    LightMode: TCheckBox;
    Label24: TLabel;
    CopySound: TBitBtn;
    PasteSound: TBitBtn;
    RemTrack: TButton;
    Label78: TLabel;
    SKY_FogCol: TShape;
    SKY_SunCol: TShape;
    SKY_AmbCol: TShape;
    SKY_WlkAmb: TShape;
    Label127: TLabel;
    SKY_WlkSun: TShape;
    Light_Col: TShape;
    Label131: TLabel;
    RenTexture: TButton;
    CreateNewScen: TButton;
    GenerateGrass: TButton;
    GrassTexture: TEdit;
    Label148: TLabel;
    VLBGrass: TValueListEditor;
    RenObject: TButton;
    ImageList1: TImageList;
    RenGround: TButton;
    AddAniNode: TButton;
    RemAniNode: TButton;
    RG2: TComboBox;
    Label154: TLabel;
    RG1: TComboBox;
    Label158: TLabel;
    F_Left: TPanel;
    F_Right: TPanel;
    F_Bottom: TPanel;
    F_Top: TPanel;
    QADtoUI: TButton;
    MakeSMP: TButton;
    EditSplines: TSpeedButton;
    CBShowObjects: TCheckBox;
    Panel2: TPanel;
    ListObjectsInstances: TComboBox;
    CBMatGrass: TCheckBox;
    ScreenRender: TMenuItem;
    SwitchMBWRVerticeColors1: TMenuItem;
    TexRotX: TFloatSpinEdit;
    TexRotY: TFloatSpinEdit;
    TexRotZ: TFloatSpinEdit;
    Label47: TLabel;
    Button25: TButton;
    Label71: TLabel;
    STRSplineOpt12: TCheckBox;
    STRSplineOpt22: TCheckBox;
    STRShSpeed: TSpinEdit;
    Label80: TLabel;
    AFC11Lightningfix1: TMenuItem;
    CBOptimizeGrass: TCheckBox;
    GrassCol: TShape;
    Label91: TLabel;
    DuplicateTrafficRoutes: TMenuItem;
    CBShowMode: TCheckBox;
    StreetsLength: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    STRPointT2: TSpinEdit;
    N5: TMenuItem;
    LandInstances: TMenuItem;
    GrassTGAColor: TButton;
    Label92: TLabel;
    Label105: TLabel;
    KillShadows: TButton;
    Gr_Unknown: TRadioGroup;
    TraceShadows: TButton;
    CBShowSpan: TCheckBox;
    SC2T_Type: TRadioGroup;
    CBShowTrace: TCheckBox;
    MemoLog: TMemo;
    SC2_BGImage: TEdit;
    SC2_ScnFlag: TEdit;
    Panel7: TPanel;
    ObjInShadow: TCheckBox;
    Applyshadowtesttoobjects1: TMenuItem;
    StatusBar1: TStatusBar;
    PlayTrackControl: TProgressBar;
    Label25: TLabel;
    Label114: TLabel;
    Label26: TLabel;
    Label79: TLabel;
    Label27: TLabel;
    CB2D: TMenuItem;
    CBWire: TMenuItem;
    Options2: TMenuItem;
    CBSelectionBuffer: TMenuItem;
    N7: TMenuItem;
    Label21: TLabel;
    CBRenderMode: TComboBox;
    Label107: TLabel;
    ShowInfo: TMenuItem;
    CBTrace: TCheckBox;
    CBReduceDisplay: TCheckBox;
    ReloadLWO: TBitBtn;
    CBMatEnlite: TCheckBox;
    ReloadAllObjects1: TMenuItem;
    AddAni: TButton;
    RemAni: TButton;
    Rebuildlightning1: TMenuItem;
    Rebuildshadows1: TMenuItem;
    N1: TMenuItem;
    TRKProperty: TPageControl;
    TabSheet19: TTabSheet;
    TabSheet21: TTabSheet;
    ListTurns: TListBox;
    E_BitType: TRadioGroup;
    E_BitSide: TRadioGroup;
    E_Aside: TFloatSpinEdit;
    E_Arrows: TSpinEdit;
    E_Node1: TSpinEdit;
    E_Node2: TSpinEdit;
    AddTurn: TButton;
    RemTurn: TButton;
    Image7: TImage;
    Label3: TLabel;
    Label2: TLabel;
    Image8: TImage;
    Label1: TLabel;
    Label5: TLabel;
    ListWPNodes: TListBox;
    WPNodeX: TFloatSpinEdit;
    AddWPNode: TButton;
    RemWPNode: TButton;
    WPNodeY: TFloatSpinEdit;
    WPNodeZ: TFloatSpinEdit;
    WPNodeCheckPointID: TSpinEdit;
    Label119: TLabel;
    CBCheckers: TMenuItem;
    GroupBox2: TGroupBox;
    Label126: TLabel;
    GroupBox3: TGroupBox;
    SMPPreview: TImage;
    CBTexGrass: TCheckBox;
    CBShowTexGrass: TCheckBox;
    Panel8: TPanel;
    Panel9: TPanel;
    Label146: TLabel;
    Panel10: TPanel;
    Image19: TImage;
    Image20: TImage;
    Image24: TImage;
    AddSkyPreset: TButton;
    RemSkyPreset: TButton;
    DefaultSkyPreset: TButton;
    CBClouds: TComboBox;
    CBFogTable: TComboBox;
    Button16: TButton;
    TraceShadows2: TButton;
    AutoObjects: TButton;
    Button20: TButton;
    RemAniAll: TButton;
    Panel12: TPanel;
    Label48: TLabel;
    RGShadEdge: TRadioGroup;
    SNISnow: TButton;
    SNIx4: TSpinEdit;
    Label33: TLabel;
    AddWPTrack: TButton;
    Label20: TLabel;
    Label37: TLabel;
    Label56: TLabel;
    Image18: TImage;
    Image25: TImage;
    Image26: TImage;
    EraseSMP: TButton;
    RotateInstances: TMenuItem;
    Label57: TLabel;
    Label118: TLabel;
    CBLoadTexList: TCheckBox;
    CBLoadMatList: TCheckBox;
    Label128: TLabel;
    Label159: TLabel;
    WP_P: TFloatSpinEdit;
    Label160: TLabel;
    SwitchVerticeColors2: TMenuItem;
    LevelStreets: TMenuItem;
    TOBMagicDelete: TCheckBox;
    AFC11LightningfixBluelakes1: TMenuItem;
    Light_Amb: TShape;
    Label132: TLabel;
    LightApply: TBitBtn;
    PrintScreenJPG: TMenuItem;
    Button4: TButton;
    Shape1: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape2: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    CopyInstance: TBitBtn;
    Shape10: TShape;
    PasteInstance: TBitBtn;
    Shape11: TShape;
    Button1: TButton;
    TabSheet22: TTabSheet;
    ListMakeTrack: TListBox;
    AddMTNode: TButton;
    RemMTNode: TButton;
    MTX: TFloatSpinEdit;
    MTY: TFloatSpinEdit;
    MTZ: TFloatSpinEdit;
    Label141: TLabel;
    Label161: TLabel;
    Label162: TLabel;
    Image27: TImage;
    Image28: TImage;
    Image29: TImage;
    InitMT: TButton;
    OptimizeVertices: TButton;
    MTW: TFloatSpinEdit;
    Label163: TLabel;
    CB_AutoCross: TCheckBox;
    ScaleInstances: TMenuItem;
    CBMatNoShadow: TCheckBox;
    Panel6: TPanel;
    CopyLightXYZ: TBitBtn;
    PasteLightXYZ: TBitBtn;
    Shape12: TShape;
    Shape13: TShape;
    ImportVRLFolder: TButton;
    Button5: TButton;
    Label164: TLabel;
    Label165: TLabel;
    Label166: TLabel;
    Panel11: TPanel;
    Show2ndFrame: TMenuItem;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label49: TLabel;
    Label167: TLabel;
    Label168: TLabel;
    Label169: TLabel;
    Label170: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    Label173: TLabel;
    Label174: TLabel;
    Label175: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    Label178: TLabel;
    LoadobjectinstancesfromLWO1: TMenuItem;
    OptimizeCullingSpheres: TButton;
    GroupBox4: TGroupBox;
    Label30: TLabel;
    CBDriveMode: TCheckBox;
    RBCarSim: TRadioButton;
    RBCarArc: TRadioButton;
    Label179: TLabel;
    SpeedButton1: TSpeedButton;
    procedure CBReduceDisplayClick(Sender: TObject);
    procedure CBTraceClick(Sender: TObject);
//    procedure RenderInit;
    procedure RenderResize(Sender: TObject);
    procedure RenderResize2(Sender: TObject);
    procedure RenderFrame(Sender: TObject);
    procedure CompileLoaded(Sender:string; ID,Num:integer);
    procedure FormCreate(Sender: TObject);
    procedure FillSceneryList;
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SceneryReload(Sender: TObject);
    procedure ListTrigClick(Sender: TObject);
    procedure ListLightsClick(Sender: TObject);
    procedure AddTurnClick(Sender: TObject);
    procedure ListTracksClick(Sender: TObject);
    procedure ListTurnsClick(Sender: TObject);
    procedure ComputeTurnClick(Sender: TObject);
    procedure E_Node1Change(Sender: TObject);
    procedure RemTurnClick(Sender: TObject);
    procedure TriggerChange(Sender: TObject);
    procedure AddTriggerClick(Sender: TObject);
    procedure ListObjectsClick(Sender: TObject);
    procedure ListObjects2Click(Sender: TObject);
    procedure BrowseLWO(Sender: TObject);
    procedure RemObjectClick(Sender: TObject);
    procedure ButtonPrintScreenClick(Sender: TObject);
    procedure SaveSceneryClick(Sender: TObject);
    procedure ListMaterialsClick(Sender: TObject);
    procedure RGMatModeClick(Sender: TObject);
    procedure SendQADtoUI(aActivePage:TActivePage);
    procedure PanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure CBTexChange(Sender: TObject);
    procedure ListSNIObjectsClick(Sender: TObject);
    procedure PageControl1DrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure TexScaleChange(Sender: TObject);
    procedure Material_ScaleChange(MatID,Lay:integer; rotH,rotP,rotB,sX,sY,mX,mY:single);
    procedure MatTexLayChange(Sender: TObject);
    procedure AddTextureClick(Sender: TObject);
    procedure RenTextureClick(Sender: TObject);
    procedure AddTextureToList(Sender:TTexSend; aText:string);
    procedure RemTextureClick(Sender: TObject);
    procedure ImportTexturesClick(Sender: TObject);
    procedure ExportTexturesListClick(Sender: TObject);
    procedure SwitchMBWRVerticeColors1Click(Sender: TObject);
    procedure CBTraceMatClick(Sender: TObject);
    procedure ListSoundsClick(Sender: TObject);
    procedure AddSoundClick(Sender: TObject);
    procedure SoundsChange(Sender: TObject);
    procedure RemSoundClick(Sender: TObject);
    procedure ResetViewClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure ListTexturesClick(Sender: TObject);
    procedure ListDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure RGTexMatClick(Sender: TObject);
    procedure ExportSoundsClick(Sender: TObject);
    procedure ImportSoundsClick(Sender: TObject);
    procedure RemTriggerClick(Sender: TObject);
    procedure ListGroundsClick(Sender: TObject);
    procedure GroundsChange(Sender: TObject);
    procedure AddGroundClick(Sender: TObject);
    procedure RemGroundClick(Sender: TObject);
    procedure ListTOB2Click(Sender: TObject);
    procedure ListTOBChange(Sender: TObject);
    procedure TOB_Change(Sender: TObject);
    procedure AddTOBClick(Sender: TObject);
    procedure RemTOBClick(Sender: TObject);
    procedure ListSNINodesClick(Sender: TObject);
    procedure ObjChangeInstance(Sender: TObject);
    procedure AddNewObject(TexString:string; ErrorReport:boolean);
    procedure ObjChange(Sender: TObject);
    procedure RemakeQADTable(Sender: TObject);
    procedure RemObjInstanceClick(Sender: TObject);
    procedure AddObjInstanceClick(Sender: TObject);
    procedure ObjectsSNIChange(Sender: TObject);
    procedure CopyInstanceClick(Sender: TObject);
    procedure PasteInstanceClick(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure ExportGroundsClick(Sender: TObject);
    procedure ImportGroundsClick(Sender: TObject);
    procedure MBWRLightBlendFix(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure ImportObjectsClick(Sender: TObject);
    procedure ListSKYClick(Sender: TObject);
    procedure STRPointIDChange(Sender: TObject);
    procedure STRPointXChange(Sender: TObject);
    procedure STRSplineID1Change(Sender: TObject);
    procedure STRSplineLenA1Change(Sender: TObject);
    procedure CBSplineSymmetryClick(Sender: TObject);
    procedure SpeedButton(Sender: TObject);
    procedure AddShapeClick(Sender: TObject);
    procedure ListStreetShapeClick(Sender: TObject);
    procedure StreetShapeChange(Sender: TObject);
    procedure CBTrackChange(Sender: TObject);
    procedure LE_RGBClick(Sender: TObject);
    procedure AddLightClick(Sender: TObject);
    procedure LightsChange(Sender: TObject);
    procedure LightApplyClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ComputeChunkMode(Sender: TObject);
    procedure ImportLWOTrackClick(Sender: TObject);
    procedure ImportMaterialsClick(Sender: TObject);
    procedure ExportMaterialsClick(Sender: TObject);
//    procedure SunTextRMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
//    procedure SunTextRMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LVL_SunXChange(Sender: TObject);
    procedure ImportNFSPUSoundsClick(Sender: TObject);
    procedure CopySoundClick(Sender: TObject);
    procedure PasteSoundClick(Sender: TObject);
    procedure CopyHolderHintUpdate;
    procedure ListSoundsDblClick(Sender: TObject);
    procedure SC2_ScnChange(Sender: TObject);
    procedure SC2_TrackListClick(Sender: TObject);
    procedure SC2T_TrackChange(Sender: TObject);
    procedure FillSC2Click(Sender: TObject);
    procedure ShowChangesInfoClick(Sender: TObject);
    procedure OptionsClick(Sender: TObject);
    procedure RemShapeClick(Sender: TObject);
    procedure RemPointClick(Sender: TObject);
    procedure RemSplineClick(Sender: TObject);
    procedure STR_PrepareToSaveClick(Sender: TObject);
    procedure ShowQADInfo(Sender: TObject);
    procedure RemLightClick(Sender: TObject);
    procedure GrassPlainColorClick(Sender: TObject);
    procedure LoadLWOLights(Sender: TObject);
    procedure CopyLightClick(Sender: TObject);
    procedure PasteLightClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure ExportLightsClick(Sender: TObject);
    procedure ImportLightsClick(Sender: TObject);
    procedure EditSkyChange(Sender: TObject);
    procedure AddTrackClick(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
    procedure TRK_LoopClick(Sender: TObject);
    procedure TRK_MakeIdeal(Sender: TObject);
    procedure RemTrackClick(Sender: TObject);
    procedure ColorShapeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SKY_FogColDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Light_ColDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Light_AmbDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure CreateNewScenClick(Sender: TObject);
    procedure GenerateGrassClick(Sender: TObject);
    procedure GrassTextureChange(Sender: TObject);
    procedure RenObjectClick(Sender: TObject);
    procedure RenGroundClick(Sender: TObject);
    procedure SNI_Node_Change(Sender: TObject);
    procedure AddAniNodeClick(Sender: TObject);
    procedure QADtoUIClick(Sender: TObject);
    procedure MakeSMPClick(Sender: TObject);
    procedure AddObjectClick(Sender: TObject);
    procedure LoadInstancesFromLWOClick(Sender: TObject);
    procedure SwitchC11_VCol(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure SetStreetMode(Sender: string);
    procedure AFC11Lightningfix1Click(Sender: TObject);
    procedure AFC11CTLightningFixClick(Sender: TObject);
    procedure GrassColDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DuplicateTrafficRoutesClick(Sender: TObject);
    procedure CBShowModeClick(Sender: TObject);
    procedure StreetsLengthClick(Sender: TObject);
    procedure LandInstancesClick(Sender: TObject);
    procedure GrassTGAColorClick(Sender: TObject);
    procedure TraceShadowsClick(Sender: TObject);
    procedure KillShadowsClick(Sender: TObject);
    procedure CB2DClick(Sender: TObject);
    procedure MemoLogClick(Sender: TObject);
    procedure SortMaterialModes(Sender: TObject);
    procedure Applyshadowtesttoobjects1Click(Sender: TObject);
    procedure PlayTrackControlMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure PlayTrackControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PlayTrackControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CBRenderModeClick(Sender: TObject);
    procedure CBWireClick(Sender: TObject);
    procedure CBSelectionBufferClick(Sender: TObject);
    procedure ReloadLWOClick(Sender: TObject);
    procedure ReloadAllObjects1Click(Sender: TObject);
    procedure AddAniClick(Sender: TObject);
    procedure SMPPreviewRedraw(Sender: TObject);
    procedure PrepareSMP(Sender: TObject);
    procedure AddWPNodeClick(Sender: TObject);
    procedure RemWPNodeClick(Sender: TObject);
    procedure ListWPNodesClick(Sender: TObject);
    procedure WPNodeChange(Sender: TObject);
    procedure CBCheckersClick(Sender: TObject);
    procedure ShowGrassInfo(Sender: TObject);
    procedure PrintScreenJPGClick(Sender: TObject);
    procedure AddSkyPresetClick(Sender: TObject);
    procedure CBCloudsClick(Sender: TObject);
    procedure RemSkyPresetClick(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure AutoObjectsClick(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure RemAniNodeClick(Sender: TObject);
    procedure RemAniClick(Sender: TObject);
    procedure SNISnowClick(Sender: TObject);
    procedure RGShadEdgeClick(Sender: TObject);
    procedure AddWPTrackClick(Sender: TObject);
    procedure EraseSMPClick(Sender: TObject);
    procedure RotateInstancesClick(Sender: TObject);
    procedure StatusBar1Click(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Memo1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SwitchVerticeColors2Click(Sender: TObject);
    procedure LevelStreetsClick(Sender: TObject);
    procedure LoadSounds(Sender: TObject);
    procedure UpdateListener(Sender: TObject);
    procedure AddSoundToPlaylist(SoundID:integer; X,Y,Z,Rad,Vol,VelX,VelY,VelZ:single);
    procedure Button4Click(Sender: TObject);
    procedure ListMakeTrackClick(Sender: TObject);
    procedure MTXChange(Sender: TObject);
    procedure RecalculatematerialCRC1Click(Sender: TObject);
    procedure AddMTNodeClick(Sender: TObject);
    procedure InitMTClick(Sender: TObject);
    procedure RebuildMTSplines;
    procedure ReverseMTSplines;
    procedure RemMTNodeClick(Sender: TObject);
    procedure ScaleInstancesClick(Sender: TObject);
    procedure CopyLightXYZClick(Sender: TObject);
    procedure PasteLightXYZClick(Sender: TObject);
    procedure ImportVRLFolderClick(Sender: TObject);
    procedure LoadSCGTFolder(Sender: string);
    procedure LoadSCGTFile(Sender: string);
    procedure CreateTrackFromMT(Sender: TObject);
    procedure ListObjects2DblClick(Sender: TObject);
    procedure ListLightsDblClick(Sender: TObject);
    procedure ListMakeTrackDblClick(Sender: TObject);
    procedure ListTurnsDblClick(Sender: TObject);
    procedure ListWPNodesDblClick(Sender: TObject);
    procedure ListTOB2DblClick(Sender: TObject);
    procedure ListSNINodesDblClick(Sender: TObject);
    procedure ListTrigDblClick(Sender: TObject);
    procedure Show2ndFrameClick(Sender: TObject);
    procedure Done(Sender:Tobject);
    procedure OptimizeVerticesClick(Sender: TObject);
    procedure OptimizeCullingSpheresClick(Sender: TObject);
    procedure RG_GrassLODClick(Sender: TObject);
    procedure RBCarSimClick(Sender: TObject);
    procedure CBDriveModeClick(Sender: TObject);

  private     { Private declarations }
    procedure OnIdle(Sender: TObject; var Done: Boolean);
  end;


const
  CarWidth=9.5;         //Half width of car (used in: TRK ideal-line generation, streets width display)
  CarLength=13;
  CarTrackWidth=7;      //Halfwidth for driving sim


var //temp
BlockHi:array of single;
BlockLo:array of single;
Trace2Sun:array of array of word;
ShadowEdgeW:integer;

var
  h_DC: HDC;
  h_RC: HGLRC;
  h_DC2: HDC;
  h_RC2: HGLRC;
  OldTickCount,FrameCount,OldFrameTimes,FrameTime:cardinal;
  OldTime:integer;//time from last call
  PlayTrack:boolean=false;
  PlayTrackPos:single=0;
  PlayTrackPrevX:integer;
  PlayTrackSpeed:single;

  Car:record
    Mode:TCarDrivingMode;
    Speed:single;
    MoveDirection:integer;
    Stopped:boolean;
  end;

  CarWheels:array[1..4]of record
    Diam:single;
    Pos:Vector3f;
    Angle:record H,P,B:integer; end;
  end;

  CarX,CarY,CarZ,CarP,CarB:single;
  CarH:single=180;
  Key1,Key2,Key3,Key4:boolean;

  Zoom: single=0.256;    // Zoom
  ZoomLo: single=0.11;    // Zoom
  ZoomHi: single=1.6;    // Zoom
  YRot: single=270;     // Pitch
  XRot: single;
  xPos,zPos:single;
  yPos: single=-1000;     // Height
  MPos:record X,Y,Z:single; end;
  MouseMoveScale:integer=8;
  MouseAction:TMouseAction;
  MousePos:TPoint;
  ObjectMoveScale:single=1;
  ObjectX,ObjectY:integer;
  SelectionQueue1:array[0..1024]of integer;
  PickCode:packed record
    Mode:byte;
    ID:word;
  end;
  ClickedID:integer;

  TracePt:integer;

  ScnCall,ScnCall2:array[1..65000]of glUint;
  Texture:array[1..512]of glUint;
  TextureCHK:array[1..512]of glUint; //Checkers texture

  ObjCall:array[0..1024]of record //0 for Car
    Call: array of glUint;
    MTLClass:integer;
    Ambi,Diff:array[1..3]of byte;
  end;

  ObjTex:array[0..1024]of array of glUint;
  GrassCall:array[1..4]of integer;

  ChunkMode:array[1..512]of array of word; //512 material qty
  ChunkModeParent:array[1..512]of array of record
    x,z:word; //Parent Block X:Z
  end;

  bmp:array of array[1..4]of byte; //2k x 2k
  pix:array[1..4]of byte;

  Form1: TForm1;
  c:array[1..16777216] of char;
  list_id,list_ogl,list_tx,list_obj,list_sky:integer;
  Scenery,SceneryPath,SceneryVersion:string;
  SaveButton:boolean=true;

  ActivePage:TActivePage;

  IDXQty:integer;
  v:array of array[1..3]of integer;

  VTXQty:array[0..64]of integer;
  VTX:array of record
    X,Y,Z:single;
    nZ,nY,nX,n0:byte;
    U,V:single;
    BlendR,BlendG,BlendB,Shadow,B,G,R,A:byte;
  end;

  SNIHead:record Obj,Node,x1,x2:integer; end; //x1=0 x2=0
  SNIObj:array[1..MaxSNI]of record
    NumNodes,objID,firstNode,Mode:word;
    Sound:array[1..32]of char;
    Volume,Tempo,Radius,x4:word;
  end;
  SNINode:array[1..MaxSNINodes]of record
  X,Y,Z,Speed,B:single;
  end;
  SNISpawnW:array[1..MaxSNI]of record
  Density,Speed,Turbulence,TrackID:integer;
  end;

      SNISubNode:array[1..MaxSNI]of array of record
      X,Y,Z:single;
      end;
      SNISubDist:array[1..MaxSNI]of array of single;
      SNITang:array[1..MaxSNINodes,1..2,1..3]of single;

      SNILen:array[1..MaxSNI]of single;
      SNILoc:array[1..MaxSNI]of single; //2nd value controls number of instances per route

  LVL:record
    a,b,c:single;
    Matrix:array[1..9]of single;
    SunX,SunY,SunZ,SunO:single;
  end;

  SMPHead:record
  A,B:integer;
  Left,ScaleWidth,Bottom,ScaleHeight,NearClip,FullClip:single;
  Matrix:array[1..9]of single;
  end;
  SMPData:array of single;

    STRHead:record
    Header:array[1..4]of char;
    Version,Options:word;
    NumShapes,NumPoints,NumSplines,NumShRefs,NumRoWs:word;
    end;
    STR_Shape:array of record
    Offset:array[1..2]of single;
    Options,NumLanes:word;     //unused (Options=0)
    end;
    STR_Point:array of record
    x,y,z:single;
    tx,ty,tz:single;
    end;
    STR_Spline:array of record
    PtA,PtB:word;
    FirstShRef,NumShRefs:word;
    LenA,LenB,Length:single;
    Density,Options:word;
    OppSpline,PrevSpline:word;
    FirstWay,NumWays:word;
    FirstRoW,NumRoW:word;
    end;
    STR_ShRef:array of record //Is same count as Num_Shapes
    Shape,Speed:word;         //extending each shape with speed limit
    StartU:single;            //unused (always 0)
    end;
    STR_RoW:array of packed record //is same count as NumSplines
    Spline:word;
    Tracks:cardinal;
    end;

//new AFC11CT streets format
    NETHead:record
    Header:array[1..4]of char;
    Version,Options:word;
    Num1,Num2,Num3,Num4,Num5:integer;
    end;
    NET1:array of packed record
    X,Y,Z:single;
    a,NumWays,c,d,e,f:word;
    end;
    NET2:array of packed record
    a,b:word;                   //4
    c:array[1..19]of single;    //76
    d:array[1..75]of single;    //300
    end;
    NET3:array of packed record
    a,b:word;
    X:single;
    c,d,e,f,g,h:word;
    Y:single;
    end;
    NET4:array of packed record
    a,b:word;                   //4
    d:array[1..20]of single;    //80
    end;
    NET5:array of packed record
    d:array[1..32]of single;    //128
    end;

  fGrass:TSGrass;
  fStreets:TSStreets;
  fTriggers:TSTriggersCollection;

  SKYQty:integer;
  SKY:array[1..32]of record
    SkyTex,FogTab:string;
    FogCol,SunCol,AmbCol,WlkAmb,WlkSun:record R,G,B:byte; end;
    CarShd:record A,R,G,B:byte; end;
  end;
  SKYTex:array[1..32,1..2]of GLuint;
  SunTex:GLuint;
//  SKY_MB,SKY_Y:integer;
  SKYIndex:byte;

  TracksQty:integer;
  TRKQty:array[1..MAX_TRACKS]of record
    Nodes,LoopFlag:integer; WR2Flag1,WR2Flag2,u3,u4:word; //Part1
    a1,a2,Turns,a4,Arrows,a6,a7,a8:word;                  //Part2
  end;
  TRK:array[1..MAX_TRACKS]of record
    Route:array of packed record
      X,Y,Z,Delta,CurveRad:single;
      Matrix:array[1..9]of single;
      Ideal,Delta2:single;
      Margin1,Margin2,Tunnel,Column:smallint;
      v1,v2,v3,v4:byte;
    end;
    Turns:array[1..256]of record Node1,Node2,Arrow1,ArrowNum,BitFlag,u1:word;
      Arrows:array[1..256]of record
        X,Y,Z:single;
        Matrix:array[1..9]of single;
        Delta:single;
        BitFlag:integer; //Left/Right/Turn/Junction/etc..
      end;
    end;
  end;
  TrackID,TurnID,TrackWP:integer;

  TOBHead:array[1..MAX_TRACKS]of record
    Qty:word;
    Clear:array[1..14]of byte;
  end;
  TOB:array[1..MAX_TRACKS]of array of packed record
    Name:string[32];
    ID:word;
    TypeID:smallint;
    X,Y,Z:single;
    M:array[1..9]of single;
    A,B:single;
    x1,x2,x3,x4:word;
    M2:array[1..3]of single;
    R1,R2,R3:integer; //rotation angles computed from M
  end;

  TracksQtyWP:integer;
  WTR:array[1..MAX_WP_TRACKS]of record
    NodeQty:integer;
    Empty:array[1..3]of integer;
    Node:array of packed record
      CheckPointID:integer;
      X,Y,Z:single;
      M:array[1..9]of single;
    end;
  end;
  WTRLength:array[1..MAX_WP_TRACKS]of integer;

  MakeTrack:array[1..MAX_TRACKS]of record
    NodeQty:integer;
    Node:array of packed record
      X,Y,Z:single;
      RoadWidth:word;
      ColumnWidth:word; //0 means no column
      Tunnel:boolean;
      Sub:array of vector3f; //runtime temp
    end;
  end;

  EditingFormat:TEditingFormat = ef_WR2;

  BumpTexName:array[1..256]of string;
  CTMaterial:array[0..512]of record
    Tex1,Tex2,Tex3,Clear1,Clear2,Clear3,Clear4,Mode:word; //16byte
    Matrix:array[1..8] of single;                         //32byte
    U1,U2,U3,U4:word; //8byte
  end;

  Qty: record
    WidthX,LengthZ,BlocksX,BlocksZ,BlocksTotal,TexturesTotal:integer;
    TexturesFiles,BumpTexturesFiles:word;
    ObjectFiles,Polys,Materials,ObjectsTotal,GroundTypes,ColliSize:integer;
    Lights,x1,x2,x3:word;
    Sounds:integer;
  end;
  TexName:array[1..256]of string;
  ObjName:array[1..256]of string;
  ObjProp:array[1..256]of record
    Mode,Shape,Weight,p4:word;
    x1,x2,x3:integer;
    HitSound,FallSound:string[48]; end;
  Block:array[1..MAX_BLOCKS_X,1..MAX_BLOCKS_Z]of record
    X,Z:word;
    FirstPoly,NumPoly,FirstTex,NumTex:integer;
    CenterX,CenterY,CenterZ,Rad:single;
    FirstObj,NumObj,FirstLight,NumLight:smallint;
    Chunk65k,x1:smallint; end;
  v05:array[1..65536]of integer;
  v06:array of array of word;
  v07:array of record
    FirstPoly,NumPoly,SurfaceID:integer; end;
  Material:array[0..512]of record
    Tex1,Tex2,Tex3,Mode:word;
    Matrix:array[1..3,1..2,1..4] of single; //3matrices, 1 for each layer
    CRC:array[1..3]of integer; end;
  TextureW:array[0..256]of record Name:string; GrowGrass:byte; end;
  MaterialW:array[0..512]of record
    Name:string;
    GrowGrass:byte;
    Enlite:byte;
    NoShadow:byte;
  end;
  Obj:array[1..MaxObjInst]of record
    Name:string[32];
    ID:integer;
    PosX,PosY,PosZ,Angl,Size:single;
    Matrix2:array[1..9] of single;
    x1,InShadow:word;
    x5:single;
    end;
  ObjW:array[1..MaxObjInst]of record
    ParentBlock:integer; end; //Is not stored in WRK, can be recomputed easily
  Light:array[1..MAX_LIGHTS]of record
    Mode:integer;
    Size,Offset,Freq:single;
    B,G,R,A:byte;
    b1,b2,b3,b4:byte;
    Matrix2:array[1..16] of single;
    end;
  Ground:array[1..MaxGrounds]of record
    Name:string[64];
    Dirt,GripF,GripR,Stick,NoiseID,SkidID:word;
    Clear1:array[1..32] of word; //empty
    NoColliFlag,x8:word;
    Clear2:array[1..6] of word; //empty
    end;
  Tex2Ground:array[1..256]of word;
  Sound:array[1..1024]of record
    X,Y,Z:single;
    Name:string[32];
    Volume,PlaySpeed,Radius,z4,z5,Delay:word;
    misc:array[1..12] of char;
    end;


  //This is a list of all sound instances in scenery, first static, then animated (sni)
  SoundW:array[1..1024]of record
    Name:string; //this value is for reference only
    WaveID:integer; //cossresponding wave index
    IsPlaying:boolean;
    InList:integer;   //if sound is playing this field is the playlist wave index
    Dist:single;
  end;

  //This is a list with all sound files used in scenery
  QtyWave:integer;
  WaveW:array[1..24]of string[32];
  WaveList:array[1..24]of record
    Dist:single;
  end;

  LightW:array[1..MAX_LIGHTS]of record
    Radius:word;
    Mode:word;
    ParentBlock:integer;
  end;

  AmbLightW:record
    R,G,B,A:byte;
  end;

  LWOSceneryFile:string;
  LWQty:record
    Vert,Poly,AddPoly,UV,VW,DUV,RGBA,Surf,Tags:array[0..MAX_LWO_LAYERS] of integer; //max 128 layers
  end;
  LW:record
    XYZ:array of array[1..3]of single;
    UV :array of array[1..2]of single;
    Nv :array of array[1..3]of single; //normal to vertex
    Np :array of array[1..3]of single; //normal to poly
    DUV:array of array[1..3,1..2]of single;
    RGBA:array of array[1..3]of byte;
    Poly:array of array[0..3]of integer;
    PolyAdd:array of record
      ID,invID,v1,v2,v3:integer; //Poly ID, inverse ID, vertices
      u,v:single;
      uv:integer;
    end;
    Surf:array of integer;
    ClipTex:array[1..512]of string;
    SName,SText:array of string;
  end;
  vmad: record
    poly,vert:integer;
  end;

  {RO:array[1..4]of record
    Head:record x1,x2,x3,sizeX,sizeZ,XZ,Qty,Density:integer; end;
    Tex:string[32];
    UV:array[1..4]of record X:array[1..8]of single; end;
    Chunks:array of array of record First,Num:integer; end;
    Grass:array of record
      X,Y,Z:single;
      ID,Size:byte;
      Color:word;
    end;
  end;}
  GrassColorW:record R,G,B,A:byte; end;

  SizeX,SizeZ:integer;       //map dimensions
  pblock:array of integer;                       //Parent block of poly
  pqtyb:array[1..MAX_BLOCK_COUNT,1..2]of integer;                    //First Poly/number polys
  sqtyb:array[1..MAX_BLOCK_COUNT,1..2]of integer;                    //First Surf/number surfs
  repoint,recreat:array of integer;             //sorts polys by appearing in Blocks
  split:array[1..64,1..2]of integer;                    //65K poly group split point
  Cbl:array of array of integer;                      //Polys of collision block

  Bi:array of array[1..256]of integer; //Blocks intersected by poly

  DoubleClick:boolean=false;

  Changes:record
    SMP:boolean;
    TOB,TRK:array[1..MAX_TRACKS]of boolean;
    WTR:array[1..MAX_WP_TRACKS]of boolean;
    IDX,VTX,QAD,SKY,SNI,LVL:boolean;
    STR:boolean;
    SC2,WRK:boolean;
  end;

  CopyHolder:record
    Hint,Name:string;
    X,Y,Z,Angl,Size:single;
    R,G,B,A:byte;
    i1,i2,i3,i4:integer;
    r1:single;
  end;

  EditMode:TEditingMode;

  AutoImportTexturesList:string='';
  AutoImportMaterialsList:string='';

  UseShaders:boolean;
  OpenALInitDone:boolean=false;

  ScnRefresh:boolean=true;
  VerticeRefresh:boolean=false;
  MatRefresh:boolean=false;
  TurnsRefresh:boolean=false;
  TriggersRefresh:boolean=false;
  SoundsRefresh:boolean=false;
  LightsRefresh:boolean=false;
  GroundsRefresh:boolean=false;
  ObjectsRefresh:boolean=false;
  ObjInstanceRefresh:boolean=true;
  TOBRefresh:boolean=false;
  TRKRefresh:boolean=false;
  WTRRefresh:boolean=false;
  MakeTrackRefresh:boolean=false;
  SNIRefresh:boolean=false;
  LVLRefresh:boolean=false;
  SkyRefresh:boolean=false;
  SNINodesRefresh:boolean=false;
  TexListRefresh:boolean=false;
  RefreshSTRSpline:boolean=false;
  BlockRender_STR:boolean=false;
  GrassRefresh:boolean=false;

  fOptions: TSKOptions;

implementation
  {$R *.dfm}

uses LoadSave, Unit_Render, PTXTexture, Load_TRK, Unit_sc2, 
Unit_Options, Unit_RoutineFunctions, Unit_RenderInit, Unit_Tracing,
  ColorPicker, SK_ImportLWO;


procedure TForm1.Done(Sender:Tobject);
var i:integer; s:string;
begin with Sender as TMemo do begin
  s:=Lines.Strings[Lines.Count-1];
  if s<>'' then if s[length(s)]<>'l' then begin //if already failed.
  for i:=length(s) to 30 do s:=s+'.';
  Lines.Delete(Lines.Count-1);
  Lines.Add(s+' done'); end;
end;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  DoClientAreaResize(Self);
  ElapsedTime(@OldTime);

  fOptions := TSKOptions.Create;
  CBTrace.Checked := fOptions.TraceSurface;
  CBReduceDisplay.Checked := fOptions.ReduceDisplay;

  MemoLWO.Lines.Add('ExeDir: '+fOptions.ExeDir);
  MemoLWO.Lines.Add('WorkDir: '+fOptions.WorkDir);

  Form1.Caption:=VersionInfo;
  MemoLog.Left:=Panel1.Left+4;
  PageControl1.OwnerDraw:=true;   //enable here, to keep tab names displayed in developer time

  SetRenderFrame(Panel1.Handle, h_DC, h_RC);

  RenderInit;
  CompileCommonObjects;

  h_DC2 := GetDC(Panel11.Handle);
  if h_DC2=0 then begin MessageBox(h_DC2, 'Unable to get a device context', 'Error', MB_OK or MB_ICONERROR); exit; end;
  if not SetDCPixelFormat(h_DC2) then exit;
  
if not fileexists(fOptions.ExeDir+'unlimiter.'+inttostr(846)) then begin
  CBRenderMode.ItemIndex:=4; //set view to Textured by default
  PageControl1.ActivePageIndex:=0; //always set LWO as start tab
end else begin
  SE_GripF.MaxValue:=120;
  SE_GripR.MaxValue:=120;
end;

  fGrass := TSGrass.Create;
  fStreets := TSStreets.Create;
  fTriggers := TSTriggersCollection.Create;


PageControl1Change(nil);        //get ActivePage name
CBRenderModeClick(nil);             //get RenderMode state
Application.OnIdle:=OnIdle;
MemoLWO.Lines.Add('Misc init done in '+ElapsedTime(@OldTime));
Randomize;
Form1.WindowState:=wsMaximized;

  FillSceneryList;
  RG2.ItemIndex := EnsureRange(RG2.ItemIndex,0,RG2.Items.Count-1);
  if RG2.ItemIndex<>-1 then SceneryReload(nil);

  ResetViewClick(nil);
  ResetViewClick(nil);
end;


procedure TForm1.FillSceneryList;
var i:integer; SearchRec:TSearchRec;
begin
  RG2.Clear;
  if not DirectoryExists(fOptions.WorkDir+'Scenarios\') then exit;

  ChDir(fOptions.WorkDir+'Scenarios\');
  FindFirst('*', faDirectory, SearchRec);
      repeat
      if (SearchRec.Attr and faDirectory=faDirectory)
      and(SearchRec.Name<>'.')and(SearchRec.Name<>'..')
      and(DirectoryExists(fOptions.WorkDir+'Scenarios\'+SearchRec.Name)) then
      RG2.Items.Add(SearchRec.Name);
      until (FindNext(SearchRec)<>0);
  FindClose(SearchRec);

  for i:=0 to RG2.Items.Count-1 do
    if UpperCase(RG2.Items[i]) = UpperCase(fOptions.ActiveScenery) then RG2.ItemIndex := i;

end;


procedure TForm1.CBReduceDisplayClick(Sender: TObject);
begin
  fOptions.ReduceDisplay := CBReduceDisplay.Checked;
end;


procedure TForm1.CBTraceClick(Sender: TObject);
begin
  fOptions.TraceSurface := CBTrace.Checked;
end;


procedure TForm1.RenderResize(Sender: TObject);
begin
if Form1.Width<960 then Form1.Width:=960;
if Form1.Height<744 then Form1.Height:=744;
  if (Panel1.Height = 0) then Panel1.Height := 1;
  if (Panel1.Width = 0) then Panel1.Width := 1;
  glViewport(0, 0, Panel1.Width, Panel1.Height);    // Set the viewport for the OpenGL window
  glMatrixMode(GL_PROJECTION);        // Change Matrix Mode to Projection
  glLoadIdentity;                   // Reset View
  if CB2D.Checked then begin
  glOrtho(-512*Min(Qty.BlocksX,Qty.BlocksZ)*(Panel1.Width/Panel1.Height),
           512*Min(Qty.BlocksX,Qty.BlocksZ)*(Panel1.Width/Panel1.Height),
           512*Min(Qty.BlocksX,Qty.BlocksZ)*(1),
          -512*Min(Qty.BlocksX,Qty.BlocksZ)*(1),-24000,24000);  // Do the perspective calculations. Last value = max clipping depth
  end else
  gluPerspective(80, -Panel1.Width/Panel1.Height, 0.1, 50000.0);  // Do the perspective calculations. Last value = max clipping depth
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
end;


procedure TForm1.RenderResize2(Sender: TObject);
begin
  if (Panel11.Height = 0) then Panel11.Height := 1;
  if (Panel11.Width = 0) then Panel11.Width := 1;
  glViewport(0, 0, Panel11.Width, Panel11.Height);    // Set the viewport for the OpenGL window
  glMatrixMode(GL_PROJECTION);        // Change Matrix Mode to Projection
  glLoadIdentity;                   // Reset View
  if CB2D.Checked then begin
  glOrtho(-512*Min(Qty.BlocksX,Qty.BlocksZ)*(Panel1.Width/Panel1.Height),
           512*Min(Qty.BlocksX,Qty.BlocksZ)*(Panel1.Width/Panel1.Height),
           512*Min(Qty.BlocksX,Qty.BlocksZ)*(1),
          -512*Min(Qty.BlocksX,Qty.BlocksZ)*(1),-24000,24000);  // Do the perspective calculations. Last value = max clipping depth
  end else
  gluPerspective(80, -Panel1.Width/Panel1.Height, 0.1, 50000.0);  // Do the perspective calculations. Last value = max clipping depth
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
end;


procedure TForm1.Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Code:KCode; ID,i,tmp:integer; ss:string; tmpY:single;
begin
ObjectX:=X; ObjectY:=Y;

glReadPixels(X,Panel1.Height-Y-1,1,1,GL_RGB,GL_UNSIGNED_BYTE,@pix);
//Shape1.Brush.Color:=(pix[1]+pix[2]*256+pix[3]*65536);
kGetColorCode(@pix[1],Code,ID);
ClickedID:=ID;

if DoubleClick then begin
//////////////////////////////////////
//Now we process events on DoubleClick
//////////////////////////////////////
if ActivePage=apObjects then
if Code=kObject then begin
  ListObjects.ItemIndex:=Obj[ID].ID; //0..X range
  ListObjectsClick(nil);
  for i:=1 to ListObjects2.Count do begin
    ss:=ListObjects2.Items[i-1];
    decs(ss,-length(ss)+4);
    if ID=strtoint(ss) then begin
      ListObjects2.ItemIndex:=i-1;
      ListObjects2Click(nil);
    end;
  end;
end;

if ActivePage=apTOB then
if Code=kObject then begin
  ListTOB2.ItemIndex:=ID-1; //0..X range
  ListTOB2Click(nil);
end;

if ActivePage=apLights then if Code=kPoint then begin
  ListLights.ItemIndex:=ID-1;
  ListLightsClick(nil);
end;

if ActivePage=apTriggers then if (Code=kObject)or(Code=kPoint) then begin
  if Code=kObject then EditMode:=emTrigger;
  if Code=kPoint  then EditMode:=emTriggerDest;
  ListTrig.ItemIndex:=ID-1;
  ListTrigClick(nil);
end;

if ActivePage=apMaterials then if Code=kSurface then begin
  ListMaterials.ItemIndex:=ID-1;
  ListMaterialsClick(nil);
end;

if ActivePage=apSounds then if Code=kPoint then begin
  ListSounds.ItemIndex:=ID;
  ListSoundsClick(nil);
end;

if ActivePage=apTracksWP then if Code=kPoint then begin
  ListWPNodes.ItemIndex:=ID-1;
  ListWPNodesClick(nil);
end;

if ActivePage=apTracksMT then if Code=kPoint then begin
  ListMakeTrack.ItemIndex:=ID-1;
  ListMakeTrackClick(nil);
end;

if ActivePage=apAnimated then if Code=kPoint then begin
  for i:=1 to SNIHead.Obj do
  if ID<=SNIObj[i].firstNode then break;
  i:=i-1;
  ListSNIObjects.ItemIndex:=i-1;
  ListSNIObjectsClick(nil);
  ListSNINodes.ItemIndex:=EnsureRange(ID-SNIObj[i].firstNode,1,ListSNINodes.Count)-1;
  ListSNINodesClick(nil);
  ListSNINodes.SetFocus;
end;

if ActivePage=apStreets then begin
if Code=kPoint then SetStreetMode('Nodes') else
if Code=kSpline then SetStreetMode('Splines') else

  if (EditMode in [emStreetNode, emStreetSpline]) and (ssLeft in Shift) then
    if (Code=kNil)and(ID=0)and(MPos.x<>0)and(MPos.y<>0)and(MPos.z<>0) then begin //Add new node
    inc(STRHead.NumPoints);
    setlength(STR_Point,STRHead.NumPoints+1);
    STR_Point[STRHead.NumPoints].x:=MPos.X;
    if yRot>180 then
      TraceHeight(MPos.X,0,MPos.Z,pd_Top,@tmpY,@tmp)
    else
      TraceHeight(MPos.X,0,MPos.Z,pd_Bottom,@tmpY,@tmp);
    STR_Point[STRHead.NumPoints].y:=tmpY;
    STR_Point[STRHead.NumPoints].z:=MPos.Z;
    STR_Point[STRHead.NumPoints].tx:=0;
    STR_Point[STRHead.NumPoints].ty:=0;
    STR_Point[STRHead.NumPoints].tz:=1;
    STRPointID.Value:=STRHead.NumPoints;
    end;

end;
end else begin//
//////////////////////////////////////
//Now we process events on SingleClick (aka Dragging)
//////////////////////////////////////
if (ActivePage=apTOB)and(TOBMagicDelete.Checked) then
  if Code=kObject then begin
    ListTOB2.ItemIndex:=ID-1; //0..X range
    RemTOBClick(nil);
  end;
if ActivePage=apStreets then begin
  if (EditMode=emStreetNode)and(ssLeft in Shift) then
    if Code=kPoint then STRPointID.Value:=ID; //Pick node
  if (EditMode=emStreetSpline)and(ssLeft in Shift) then begin
    if Code=kPoint then SelectionQueue1[1]:=ID;
    if Code=kSpline then STRSplineID1.Value:=ID;
    if Code=kSplineAnchor then EditMode:=emStreetAnchor; //Pick anchor
    if Code=kSplineAnchorLength then EditMode:=emStreetAnchorLength; //Pick anchor
    end;
end;
end;
end;

procedure TForm1.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
var vx,vy,vz:TFloatSpinEdit;
    MoveMode:(mmNone,mmFloat,mmInteger,mmAnchors);
    vxi,vyi:TSpinEdit;
    Code:KCode; ID,tmp,PA,PB:integer;
    tx,ty,tz,px,py,pz,LA,LB:single;
begin
  vx:=nil; vy:=nil; vz:=nil; vxi:=nil; vyi:=nil; //Init to calm down Compiler
  px:=0; py:=0; pz:=0; //Init to calm down Compiler

  try
    if not (ssLeft in Shift) and not (ssRight in Shift) then exit;
    if DoubleClick then exit;
    MoveMode := mmNone;

    case ActivePage of
      apAnimated: begin vx:=SNI_Node_X; vy:=SNI_Node_Y; vz:=SNI_Node_Z; MoveMode:=mmFloat; end;
      apSounds:   begin vx:=SoundPosX; vy:=SoundPosY; vz:=SoundPosZ; MoveMode:=mmFloat; end;
      apTOB:      begin vx:=TOB_X; vy:=TOB_Y; vz:=TOB_Z; MoveMode:=mmFloat; end;
      apObjects:  begin vx:=ObjX; vy:=ObjY; vz:=ObjZ; MoveMode:=mmFloat; end;
      apLights:   begin vx:=LightX; vy:=LightY; vz:=LightZ; MoveMode:=mmFloat; end;
      apTracksWP: if TrackWP<>0 then begin vx:=WPNodeX; vy:=WPNodeY; vz:=WPNodeZ; MoveMode:=mmFloat; end;
      apTracksAR: if TrackID<>0 then begin vxi:=E_Node2; vyi:=E_Node1; MoveMode:=mmInteger; end;
      apTracksMT: if TrackID<>0 then begin vx:=MTX; vy:=MTY; vz:=MTZ; MoveMode:=mmFloat; end;
      apTriggers: if EditMode=emTriggerDest then begin
                    vx:=TRL_P1; vy:=TRL_P2; vz:=TRL_P3; MoveMode:=mmFloat;
                  end else begin
                    vx:=TRL_X; vy:=TRL_Y; vz:=TRL_Z; MoveMode:=mmFloat;
                  end;
      apStreets:
                  case EditMode of
                    emStreetNode:
                        begin
                          vx:=STRPointX; vy:=STRPointY; vz:=STRPointZ; MoveMode:=mmFloat;
                        end;

                    emStreetAnchor:
                        if (ssLeft in Shift) then MoveMode:=mmAnchors; //Special mode for anchors

                    emStreetAnchorLength:
                        if (ssLeft in Shift) then MoveMode:=mmAnchors; //Special mode for anchors

                    emStreetSpline:
                        if (ssLeft in Shift) then begin
                          glReadPixels(X,Panel1.Height-Y-1,1,1,GL_RGB,GL_UNSIGNED_BYTE,@pix);
                          kGetColorCode(@pix[1],Code,ID);
                          if (Code<>kPoint) then exit; //ID=0 gets excluded too cos kNil
                          if SelectionQueue1[1]=0 then SelectionQueue1[1]:=ID;
                            if ID<>SelectionQueue1[1] then begin
                            MakeSpline(SelectionQueue1[1],ID);
                            if CBSplineSymmetry.Checked then
                            MakeSpline(ID,SelectionQueue1[1]);
                            SelectionQueue1[1]:=0;
                            end;
                          STR_PrepareToSaveClick(nil);
                          end;
                  end;
    end;

    if MoveMode=mmNone then exit;

    if (ssLeft in Shift)and(MoveMode=mmFloat) then begin
      vx.Value:=vx.Value+(-(ObjectX-X)*ObjectMoveScale*cos(xRot/180*pi)
                          +(ObjectY-Y)*ObjectMoveScale*sin(xRot/180*pi))/power(zoom,3)/4;
      vz.Value:=vz.Value+( (ObjectX-X)*ObjectMoveScale*sin(xRot/180*pi)
                          +(ObjectY-Y)*ObjectMoveScale*cos(xRot/180*pi))/power(zoom,3)/4*sign(yRot-180);
      if (fOptions.TraceSurface)and(not ScnRefresh)and(Qty.Polys>0) then begin
        //if sign(yRot-180)>0 then ss:=pd_Top else ss:=pd_Bottom;
        TraceHeight(vx.Value,vy.Value,vz.Value,pd_Near,@ty,@tmp);
        vy.Value:=ty;
      end;
    end;

if (ssRight in Shift)and(MoveMode=mmFloat) then
vy.Value:=vy.Value+(ObjectY-Y)*ObjectMoveScale/power(zoom,3);

if (ssLeft in Shift)and(MoveMode=mmInteger) then
vxi.Value:=vxi.Value+round(ObjectY-Y);

if (ssRight in Shift)and(MoveMode=mmInteger) then
vyi.Value:=vyi.Value+round(ObjectY-Y);

if (ssLeft in Shift)and(MoveMode=mmAnchors) then begin //Special move without "Value"s
ID:=STRSplineID1.Value;
PA:=STR_Spline[ID].PtA+1;
PB:=STR_Spline[ID].PtB+1;
LA:=STR_Spline[ID].LenA/3;
LB:=-STR_Spline[ID].LenB/3;

if EditMode=emStreetAnchorLength then begin
if ClickedID=PA then begin
STR_Spline[ID].LenA:=STR_Spline[ID].LenA-((ObjectX-X-(ObjectY-Y))*ObjectMoveScale/power(zoom,3)/4)*3*sign(STR_Spline[ID].LenA);
if STR_Spline[ID].OppSpline<>65535 then
STR_Spline[STR_Spline[ID].OppSpline+1].LenB:=-STR_Spline[ID].LenA;
end;
if ClickedID=PB then begin
STR_Spline[ID].LenB:=STR_Spline[ID].LenB-((ObjectX-X-(ObjectY-Y))*ObjectMoveScale/power(zoom,3)/4)*3*sign(STR_Spline[ID].LenB);
if STR_Spline[ID].OppSpline<>65535 then
STR_Spline[STR_Spline[ID].OppSpline+1].LenA:=-STR_Spline[ID].LenB;
end;
end
else begin //if EditMode='StreetAnchors'

    if ClickedID=PA then begin
    px:=STR_Point[PA].x; py:=STR_Point[PA].y; pz:=STR_Point[PA].z;
    tx:=px+STR_Point[PA].tx*LA; ty:=py+STR_Point[PA].ty*LA; tz:=pz+STR_Point[PA].tz*LA;
    end;

    if ClickedID=PB then begin
    px:=STR_Point[PB].x; py:=STR_Point[PB].y; pz:=STR_Point[PB].z;
    tx:=px+STR_Point[PB].tx*LB; ty:=py+STR_Point[PB].ty*LB; tz:=pz+STR_Point[PB].tz*LB;
    end;

tx:=tx+(-(ObjectX-X)*ObjectMoveScale*cos(xRot/180*pi)
        +(ObjectY-Y)*ObjectMoveScale*sin(xRot/180*pi))/power(zoom,3)/4;
tz:=tz+( (ObjectX-X)*ObjectMoveScale*sin(xRot/180*pi)
        +(ObjectY-Y)*ObjectMoveScale*cos(xRot/180*pi))/power(zoom,3)/4*sign(yRot-180);

    if ClickedID=PA then begin
    STR_Spline[ID].LenA:=GetLength(px-tx,py-ty,pz-tz)*3*sign(STR_Spline[ID].LenA);
    if STR_Spline[ID].OppSpline<>65535 then
    STR_Spline[STR_Spline[ID].OppSpline+1].LenB:=-STR_Spline[ID].LenA;
    tx:=(tx-px)/sign(STR_Spline[ID].LenA);
    tz:=(tz-pz)/sign(STR_Spline[ID].LenA);
    Normalize(tx,tz);
    ty:=STR_Point[PA].ty;
    Normalize(tx,ty,tz);
    STR_Point[PA].tx:=tx; STR_Point[PA].ty:=ty; STR_Point[PA].tz:=tz;
    end;

    if ClickedID=PB then begin
    STR_Spline[ID].LenB:=GetLength(px-tx,py-ty,pz-tz)*3*sign(STR_Spline[ID].LenB);
    if STR_Spline[ID].OppSpline<>65535 then
    STR_Spline[STR_Spline[ID].OppSpline+1].LenA:=-STR_Spline[ID].LenB;
    tx:=-(tx-px)/sign(STR_Spline[ID].LenB); //invert length required for B
    tz:=-(tz-pz)/sign(STR_Spline[ID].LenB); //invert length required for B
    Normalize(tx,tz);
    ty:=STR_Point[PB].ty;
    Normalize(tx,ty,tz);
    STR_Point[PB].tx:=tx; STR_Point[PB].ty:=ty; STR_Point[PB].tz:=tz;
    end;
end;
end;

finally
  ObjectX:=X;
  ObjectY:=Y;
end;
end;


procedure TForm1.Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SelectionQueue1[1]:=0; //Clear array after use
  SelectionQueue1[2]:=0;

  if EditMode in [emStreetAnchor, emStreetAnchorLength] then EditMode := emStreetSpline;
  if EditMode = emStreetSpline then STRSplineID1Change(nil);

  if DoubleClick then DoubleClick:=false;
end;


procedure TForm1.OnIdle(Sender: TObject; var Done: Boolean);
begin
  if (Form1=nil)or(Form_ColorPicker=nil)or((not Form1.Active)and(not Form_ColorPicker.Active)) then exit;
  if ScnRefresh then exit;
  done:=false;
  KnowFPS;

  //Process car positioning
  if CBDriveMode.Checked and not Car.Stopped then MoveCarSimple;
  if PlayTrack and (TrackID<>0) then MoveCarAlongTrack(TrackID);

  RenderFrame(Sender);
end;


procedure TForm1.RenderFrame(Sender: TObject);
var Num:byte; v:vector3f; ZoomX:single; ii:integer;
begin
if Show2ndFrame.Checked then begin
  wglMakeCurrent(h_DC, h_RC);
  RenderResize(nil);
end;
                                     
if OpenALInitDone then
  UpdateListener(nil); //Update sounds

if ScnRefresh then exit;
if SKYIndex=0 then SKYIndex:=1;
glClearColor(SKY[SKYIndex].FogCol.R/255,SKY[SKYIndex].FogCol.G/255,SKY[SKYIndex].FogCol.B/255, 0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D,0);
  glLoadIdentity;

  if Sender=ScreenRender then begin //make top-down view
    glRotatef(yRot,-1, 0,0);
    ZoomX:=1;
  end else
  if Sender=MakeSMP then begin //make sun-to-map view
    glRotatef(yRot,-1, 0,0);
    glRotatef(xRot, 0,-1,0);
    ZoomX:=1;
  end else
    if CB2D.Checked then begin //make 2D view
      glTranslatef(0,0,-7); //move away 7m
      glRotatef(yRot,-1, 0,0); //Rotate in
      glRotatef(xRot, 0,-1,0);
      ZoomX:=140*power(zoom,3);
      glkScale(ZoomX);
      glTranslatef(-xPos,-yPos,-zPos);
    end else begin //make normal view
      glTranslatef(0,0,-7); //move away 7m
      glRotatef(180 , 0, 0,1);
      glRotatef(yRot,-1, 0,0); //Rotate in
      glRotatef(xRot, 0,-1,0);
      ZoomX:=0.04*power(zoom,3);                       //0,00005324 .. 0,16384  447px x3077
      glkscale(ZoomX);
      glTranslatef(-xPos,-yPos,-zPos);
    end;

LightPos[0]:=LVL.SunX/ZoomX;
LightPos[1]:=LVL.SunY/ZoomX;
LightPos[2]:=LVL.SunZ/ZoomX;
glLightfv(GL_LIGHT0, GL_POSITION, @LightPos);
//glColor3f(1,1,1); glBegin(GL_Points); glVertex3f(0,0,0); glEnd;

PointSize:=EnsureRange(power(Zoom,3)*75,3,30); //size=16units?
LineWidth:=EnsureRange(power(Zoom,3)*25,1,20);

if not CBSelectionBuffer.Checked then begin

  glDisable(GL_DEPTH_TEST);
  if (Sender<>MakeSMP)and(Sender<>ScreenRender)   then
  if (ActivePage=apSky)or(fOptions.RenderMode>=rmFull)     then RenderSky(SKYIndex);
  if (Sender<>MakeSMP)and(Sender<>ScreenRender)   then RenderBounds;

  gldisable(gl_Lighting);
  glEnable(GL_DEPTH_TEST);

  //Render opaque layer
  if ActivePage=apSounds                          then RenderSounds(1,ListSounds.ItemIndex);
  if ActivePage=apLights                          then RenderLights(1,'',ListLights.ItemIndex+1);
  if ActivePage=apTracksMT                        then RenderMakeTrack(1,ListMakeTrack.ItemIndex+1);
  if ActivePage=apStreets                         then RenderStreets(1,STRPointID.Value,STRSplineID1.Value);
  if ActivePage=apAnimated                        then RenderAnimated(1,'Paths',ListSNIObjects.ItemIndex+1,ListSNINodes.ItemIndex+1)
  else if (fOptions.RenderMode>=rmFull)                    then RenderAnimated(1,'Objects',0,0);
  if ActivePage=apTriggers                        then fTriggers.Render(1,ListTrig.ItemIndex+1, EditMode);

  //Render scenery in shaders
  if(fOptions.RenderMode<>rmSchem)and(fOptions.RenderMode<>rmOpenGL)then RenderShaders(
                                                       'Normal',
                                                       ListTextures.ItemIndex*byte(CBShowTexInMat.Checked),
                                                       fOptions.ReduceDisplay,
                                                       (Sender<>ScreenRender)and((fOptions.RenderMode=rmPrev)or(ActivePage=apSky)),
                                                       CBCheckers.Checked,
                                                       CBShowTexGrass.Checked);

  //Render OpenGL geometry with enabled lightning
  glenable(gl_Lighting);
  Dif[0]:=Sky[SKYIndex].AmbCol.R/255; Dif[1]:=Sky[SKYIndex].AmbCol.G/255; Dif[2]:=Sky[SKYIndex].AmbCol.B/255;
  glLightfv(GL_LIGHT0, GL_AMBIENT, @Dif);
  if fOptions.RenderMode=rmOpenGL                          then RenderOpenGL(CBCheckers.Checked);
  if (ActivePage=apObjects)or(fOptions.RenderMode>=rmFull) then RenderObjects(1,ListObjects.ItemIndex+1,ListObjects2.ItemIndex+1);
  //   (fOptions.RenderMode>=rmFull)  then RenderObjectsShaders(1,ListObjects.ItemIndex+1,ListObjects2.ItemIndex+1);
  if (ActivePage=apTOB)or(fOptions.RenderMode>=rmFull)     then RenderTOB_Objects(TrackID,ListTOB2.ItemIndex+1,1);
  gldisable(gl_Lighting);

  if (ActivePage=apGrass)or(fOptions.RenderMode>=rmFull)   then fGrass.Render(RG_GrassLOD.ItemIndex+1,RG_GrassMode.ItemIndex+1, fOptions.RenderMode);

  if CBWire.Checked                               then RenderWire;

  gldisable(GL_DEPTH_TEST);

  if fOptions.RenderMode>=rmFull                           then RenderLights(1,'OnlyFlares',ListLights.ItemIndex+1);

  if(CBShowTrack.Checked)or(ActivePage=apTracksWP)or(ActivePage=apTracksAR)or
    (ActivePage=apAddonInfo) then if TrackID<>0  then RenderTracks(TrackID,ListTurns.ItemIndex+1,1,TRKQty[TrackID].Nodes)
                              else if TrackWP<>0  then RenderTracksWP(1,TrackWP,ListWPNodes.ItemIndex+1);

  if ActivePage=apStreets           then RenderStreets(0.2,STRPointID.Value,STRSplineID1.Value);
  if ActivePage=apStreets           then RenderRoadNet;
  if ActivePage=apTriggers          then fTriggers.Render(0.2,ListTrig.ItemIndex+1, EditMode);
  if ActivePage=apAnimated          then RenderAnimated(0.2,'Paths',ListSNIObjects.ItemIndex+1,ListSNINodes.ItemIndex+1);
  if ActivePage=apLights            then RenderLights(0.5,'',ListLights.ItemIndex+1);
  if ActivePage=apTracksMT          then RenderMakeTrack(0.5,ListMakeTrack.ItemIndex+1);
  if ActivePage=apSounds            then RenderSounds(0.2,ListSounds.ItemIndex);
  if ActivePage=apStructure         then RenderGrid(StructMode.ItemIndex);
  if ActivePage=apSky               then RenderSunVector;
  if fOptions.TraceSurface          then RenderTarget;
  if CBDriveMode.Checked or PlayTrack then RenderCar;

  swapBuffers(h_DC);

  if (Sender=ScreenRender)or(Sender=MakeSMP)or(Sender=PrintScreenJPG)or(CBDriveMode.Checked or PlayTrack) then exit;

end;

V:=ReadClick(EnsureRange(ObjectX,0,Panel1.Width),EnsureRange(Panel1.Height-ObjectY-1,0,Panel1.Height));
{StatusBar1.Panels[1].Text:='X'+floattostr(round(V.x*10)/10)+
                          ' Y'+floattostr(round(V.y*10)/10)+
                          ' Z'+floattostr(round(V.z*10)/10);}
StatusBar1.Panels[1].Text:='X'+floattostr(round(xPos*10)/10)+
                          ' Y'+floattostr(round(yPos*10)/10)+
                          ' Z'+floattostr(round(zPos*10)/10);
MPos.X:=V.x;
MPos.Y:=V.y;
MPos.Z:=V.z;

//Now we render everything for selection buffer
///////////////////////////////////////////////
  glClearColor(0,0,0,1);                                  //Set clear color to empty
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);    //clear everything
//  glDepthFunc(GL_LEQUAL);
  glDisable(GL_DEPTH_TEST);
  if ActivePage=apStreets               then RenderStreets(0,STRPointID.Value,STRSplineID1.Value);
  glEnable(GL_DEPTH_TEST);
  if ActivePage=apAnimated              then RenderAnimated(0,'Paths',0,0);
//  if ActivePage='Geometry'        then RenderVTX('Points');
  if ActivePage=apTriggers              then fTriggers.Render(0,ListTrig.ItemIndex+1, EditMode);
  if ActivePage=apLights                then RenderLights(0,'',0);
  if ActivePage=apTracksMT              then RenderMakeTrack(0,0);
  if ActivePage=apSounds                then RenderSounds(0,0);
  if ActivePage=apObjects               then RenderObjects(0,ListObjects.ItemIndex+1,ListObjects2.ItemIndex+1);
  if(ActivePage=apTracksWP)and(TrackWP>0) then RenderTracksWP(0,TrackWP,ListWPNodes.ItemIndex+1);
  if ActivePage=apTOB                   then RenderTOB_Objects(TrackID,0,0);
  if ActivePage=apMaterials             then RenderShaders('Materials',0,fOptions.ReduceDisplay,false,true,false);
  if CBSelectionBuffer.Checked          then swapBuffers(h_DC);              //show result on screen (optional)

if fOptions.RenderMode=rmSchem then exit; //do not upload data in this mode, removes loading lag

//compile map pieces upon rendering new frames, makes it feel faster
//than waiting few seconds to load all at once instead
//Perfomance of texture\geometry loading is regarding user using camera controls
if Sender=Panel1 then Num:=5 else Num:=10;

if list_id<Qty.BlocksTotal        then CompileLoaded('Scenery',list_id,Num);
if fOptions.RenderMode=rmBlend             then exit; //do not upload data in this mode, removes loading lag
if list_ogl<Qty.Materials         then CompileLoaded('OpenGLScenery',list_ogl,Num);
if list_tx<Qty.TexturesFiles      then CompileLoaded('Textures',list_tx,Num div 2);
if list_obj<Qty.ObjectFiles       then CompileLoaded('Objects',list_obj,Num div 4);
if(fOptions.RenderMode>=rmFull)
or(ActivePage=apSky)or(list_sky=0)then
               if list_sky<SKYQty then CompileLoaded('Sky',list_sky,1);

  if Show2ndFrame.Checked then begin
    wglMakeCurrent(h_DC2, h_RC);
    RenderResize2(nil);

    glClearColor(0,0,0, 0);
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D,0);
    glLoadIdentity;

      glTranslatef(0,0,-7); //move away 7m
      glRotatef(180 , 0, 0,1);
      glRotatef(yRot,-1, 0,0); //Rotate in
      glRotatef(xRot, 0,-1,0);
      ZoomX:=0.04*power(zoom,3);                       //0,00005324 .. 0,16384  447px x3077
      glkscale(ZoomX);
      glTranslatef(-xPos,-yPos,-zPos);

    gldisable(gl_Lighting);

    RenderBounds;

    RenderOpenGL(false);

    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LEQUAL);

      glLineWidth(1);
      glPolygonMode(GL_FRONT,GL_LINE);
      glBindTexture(GL_TEXTURE_2D,0);
      for ii:=1 to Qty.Materials do glCallList(ScnCall2[ii]);
      glLineWidth(LineWidth);
      glPolygonMode(GL_FRONT,GL_FILL);

    swapBuffers(h_DC2);
  end;
end;


procedure TForm1.SceneryReload(Sender: TObject);
var i:integer;
begin
  if (Sender<>nil)and(not fileexists(fOptions.ExeDir+'unlimiter.'+inttostr(846))) then
    if MessageBox(Form1.Handle,'Any unsaved changes will be lost','Warning',MB_OKCANCEL or MB_ICONEXCLAMATION)=IDCANCEL then exit;

  if RG2.ItemIndex = -1 then exit;

  fOptions.ActiveScenery := RG2.Items.Strings[RG2.ItemIndex];

  EditingFormat:=ef_WR2;

  for i:=1 to MAX_TRACKS do begin Changes.TRK[i]:=false; Changes.TOB[i]:=false; end;
  for i:=1 to MAX_WP_TRACKS do Changes.WTR[i]:=false;
  fGrass.Changed:=false;

  //fTrigger.Changed=false;//Performed on LoadFromFile

  Changes.SMP:=false;
  Changes.IDX:=false; Changes.VTX:=false; Changes.QAD:=false; Changes.SKY:=false;
  Changes.SNI:=false; Changes.LVL:=false; Changes.STR:=false;
  Changes.WRK:=false; Changes.SC2:=false;
  MemoLoad.Clear;
  MemoLoad.Lines.Add('LOADING');

ScnRefresh:=true;
list_id:=0; list_ogl:=0; list_tx:=0; list_obj:=0; list_sky:=0; TracePt:=0;
if UseShaders=false then list_id:=65535; //do not compile lists if Shaders are not supported by GPU

Scenery:=RG2.Items.Strings[RG2.ItemIndex];
SceneryVersion:='V'+inttostr(RG1.ItemIndex+1);

//Disable original maps save
if ((Scenery='Italien')or(Scenery='HHeimRing')or(Scenery='Miami')or
   (Scenery='Egypten')or(Scenery='Hawaii')or(Scenery='Testcenter'))
   and(not fileexists(fOptions.ExeDir+'unlimiter.'+inttostr(846))) then begin
     SaveScenery.Enabled:=false; SaveButton:=false;
   end else begin
     SaveScenery.Enabled:=true;  SaveButton:=true;
   end;

ElapsedTime(@OldTime);
SceneryPath:=fOptions.WorkDir+'Scenarios\'+Scenery+'\'+SceneryVersion+'\';
LoadQAD(SceneryPath+Scenery);                       MemoLoad.Lines.Add('Load QAD in'+ElapsedTime(@OldTime));
//Editing format is set now

if (LoadVTX(SceneryPath+Scenery))and(LoadIDX(SceneryPath+Scenery)) then
  MemoLoad.Lines.Add('Load VTX+IDX in'+ElapsedTime(@OldTime))
else
if LoadGEO(SceneryPath+Scenery) then
  MemoLoad.Lines.Add('Load GEO in'+ElapsedTime(@OldTime));

LoadLVL(SceneryPath+Scenery);                       MemoLoad.Lines.Add('Load LVL in'+ElapsedTime(@OldTime));
ScnRefresh:=false;
if LoadSMP(SceneryPath+'Extra\ShdwMap.smp')    then MemoLoad.Lines.Add('Load SMP in'+ElapsedTime(@OldTime)) else MemoLoad.Lines.Add('SMP missing');
if LoadSNI(SceneryPath+Scenery)                then MemoLoad.Lines.Add('Load SNI in'+ElapsedTime(@OldTime)) else MemoLoad.Lines.Add('SNI missing');
   LoadTRK(SceneryPath+'Tracks\',Scenery);          MemoLoad.Lines.Add('Load TRK in'+ElapsedTime(@OldTime));
   LoadTOB(SceneryPath+'Tracks\',Scenery);          MemoLoad.Lines.Add('Load TOB in'+ElapsedTime(@OldTime));
   LoadWTR(SceneryPath+'Tracks\',Scenery);          MemoLoad.Lines.Add('Load WTR in'+ElapsedTime(@OldTime));
if LoadSKY(SceneryPath+Scenery)                then MemoLoad.Lines.Add('Load SKY in'+ElapsedTime(@OldTime)) else MemoLoad.Lines.Add('SKY missing');

if LoadSTR(fOptions.WorkDir+'Traffic\Streets\'+Scenery) then MemoLoad.Lines.Add('Load STR in'+ElapsedTime(@OldTime)) else MemoLoad.Lines.Add('STR missing');
if LoadNET(SceneryPath+'Tracks\roads.net')     then MemoLoad.Lines.Add('Load NET in'+ElapsedTime(@OldTime));

//if fStreets.LoadFromFile(fOptions.WorkDir+'Traffic\Streets\'+Scenery+'.str') then MemoLoad.Lines.Add('Load STR in'+ElapsedTime(@OldTime)) else MemoLoad.Lines.Add('STR missing');
if fTriggers.LoadFromFile(fOptions.WorkDir+'RaceDat\'+Scenery+'.trl') then MemoLoad.Lines.Add('Load TRL in'+ElapsedTime(@OldTime)) else MemoLoad.Lines.Add('TRL missing');


   LoadWRK(SceneryPath+Scenery+' WorkFile.wrk');    MemoLoad.Lines.Add('Load WRK in'+ElapsedTime(@OldTime));
if LoadSC2(fOptions.WorkDir+'AddOns\Sceneries\'
                  +Scenery+'\EditScenery.sc2') then MemoLoad.Lines.Add('Load SC2 in'+ElapsedTime(@OldTime));

if fGrass.LoadFromFile(SceneryPath+Scenery)      then MemoLoad.Lines.Add('Load RO# in'+ElapsedTime(@OldTime)) else MemoLoad.Lines.Add('RO# missing');


SendQADtoUI(ActivePage);
ShowQADInfo(nil);
CBTrackChange(nil);
MouseMoveScale:=(Qty.BlocksX+Qty.BlocksZ)div 5;
end;


procedure TForm1.CompileLoaded(Sender:string; ID,Num:integer);
var
  f:file;
  i,j,k,h,x,z:integer;
  ap:array[1..2]of pointer;
  bm:array of integer;
  t:single;
  s,s2:string;
begin
if Sender='Scenery' then begin
if ID+Num>Qty.BlocksTotal then Num:=Qty.BlocksTotal-ID;
    for i:=ID to ID+Num-1 do begin //0..x-1
    x:=i mod Qty.BlocksX+1;
    z:=i div Qty.BlocksX+1;
        for j:=Block[z,x].FirstTex+1 to Block[z,x].FirstTex+Block[z,x].NumTex do begin
        if ScnCall[j]<>0 then glDeleteLists(ScnCall[j],1);
        ScnCall[j]:=glGenLists(1);
            glNewList(ScnCall[j], GL_COMPILE);
            glbegin(gl_triangles);
            for k:=v07[j].FirstPoly+1 to v07[j].FirstPoly+v07[j].NumPoly do
            for h:=3 downto 1 do begin
            glColor4f     (VTX[v[k,h]].R/255,VTX[v[k,h]].G/255,VTX[v[k,h]].B/255,1-VTX[v[k,h]].Shadow/255);
            glSecondaryColor3f(VTX[v[k,h]].BlendR/255,VTX[v[k,h]].BlendG/255,VTX[v[k,h]].BlendB/255);
            glTexCoord2fv (@VTX[v[k,h]].U);
            glNormal3f    (VTX[v[k,h]].nX/128-1, VTX[v[k,h]].nY/128-1, VTX[v[k,h]].nZ/128-1);
            glvertex3fv   (@VTX[v[k,h]].X);
            end;
            glEnd;
            glEndList;
        end;
    end;
inc(list_id,Num);
end;

if Sender='OpenGLScenery' then begin
    for i:=ID+1 to min(ID+Num,Qty.Materials) do begin

      glDeleteLists(ScnCall2[i],1);
      ScnCall2[i]:=glGenLists(1);
      glNewList(ScnCall2[i], GL_COMPILE);
      glbegin(gl_triangles);
        for x:=1 to ChunkMode[i,0] do begin
        j:=ChunkMode[i,x];
        for k:=v07[j].FirstPoly+1 to v07[j].FirstPoly+v07[j].NumPoly do
          for h:=3 downto 1 do begin
            t:=max(0.5-(VTX[v[k,h]].Shadow-128)/32,0)+0.75;
            glColor3f     ((VTX[v[k,h]].R/60)*t,(VTX[v[k,h]].G/60)*t,(VTX[v[k,h]].B/60)*t);
            if Material[i].Mode<16 then
              glTexCoord2f(VTX[v[k,h]].X*Material[i].Matrix[1,1,1]+
                           VTX[v[k,h]].Y*Material[i].Matrix[1,1,2]+
                           VTX[v[k,h]].Z*Material[i].Matrix[1,1,3]+
                                         Material[i].Matrix[1,1,4],
                           VTX[v[k,h]].X*Material[i].Matrix[1,2,1]+
                           VTX[v[k,h]].Y*Material[i].Matrix[1,2,2]+
                           VTX[v[k,h]].Z*Material[i].Matrix[1,2,3]+
                                         Material[i].Matrix[1,2,4])
            else
              glTexCoord2fv (@VTX[v[k,h]].U);
            glNormal3f    ( VTX[v[k,h]].nX/128-1,VTX[v[k,h]].nY/128-1,VTX[v[k,h]].nZ/128-1);
            glvertex3fv   (@VTX[v[k,h]].X);
          end;
        end;
      glEnd;
      glEndList;
    end;
inc(list_ogl,Num);
end;

if Sender='Textures' then begin
s2:='';
if ID+Num>Qty.TexturesFiles then Num:=Qty.TexturesFiles-ID;
for i:=ID+1 to ID+Num do begin
  glDeleteTextures(1,@Texture[i]); Texture[i]:=0;
  s:=SceneryPath+'Textures\'+TexName[i]+'.ptx';
  if FileExists(s) then begin
    AssignFile(f,s); FileMode:=0; Reset(f,1); FileMode:=2; //Open ReadOnly
    BlockRead(f,c,12); //Read head
    x:=int2(c[5],c[6]) div 4; z:=int2(c[9],c[10]) div 4; //Make actual tex lower resolution
    CloseFile(f);
    setlength(bm,x*z);
    for k:=0 to z-1 do for h:=0 to x-1 do //Making nice procedural texture :)
    bm[h+k*x]:=$FFFFFF*(integer(k mod 16 < 8) * integer(h mod 16 < 8)+
                        integer(k mod 16 >= 8) * integer(h mod 16 >= 8));
    ap[1]:=@bm[0];
    TextureCHK[i]:=CreateTexture(x,z,0,32,1,ap);

  LoadTexturePTX(s,Texture[i]);
  end else
    s2:=s2+s+eol;
end;
if s2<>'' then
  MessageBox(Form1.Handle,PChar(eol+s2+eol+'above textures are missing'),'Texture is missing',MB_OK or MB_ICONEXCLAMATION);
inc(list_tx,Num);
end;

if Sender='Objects' then begin
  if ID+Num>Qty.ObjectFiles then Num:=Qty.ObjectFiles-ID;
  for i:=ID+1 to ID+Num do begin
    for k:=1 to length(ObjCall[i].Call) do begin
  glDeleteLists(ObjCall[i].Call[k-1],1);
  ObjCall[i].Call[k-1]:=0;
  end;
  s:=ObjName[i];
  if (length(s)>2)and(s[1]+s[2]='T\') then begin
  decs(s,-2); LoadObjectTREE(SceneryPath+'Objects\'+s,i);
  end else
  if (length(s)>2)and(s[1]+s[2]='X\') then begin
  //decs(s,-2); LoadObjectTREE(SceneryPath+'Objects\'+s,i);
  end else
  LoadObjectMOX(SceneryPath+'Objects\'+s,i);
  inc(list_obj);
  end;
end;

if Sender='Sky' then begin
  glDeleteTextures(1,@SunTex); SunTex:=0;
  if FileExists(SceneryPath+'Extra\Sun1.ptx') then
  LoadTexturePTX(SceneryPath+'Extra\Sun1.ptx',SunTex);

  if ID+Num>SKYQty then Num:=SKYQty-ID;
  for i:=ID+1 to ID+Num do begin
  glDeleteTextures(1,@SkyTex[i,1]); SkyTex[i,1]:=0;
  if FileExists(fOptions.WorkDir+'Clouds\'+SKY[i].SkyTex+'.ptx') then
  LoadTexturePTX(fOptions.WorkDir+'Clouds\'+SKY[i].SkyTex+'.ptx',SkyTex[i,1]);
  glDeleteTextures(1,@SkyTex[i,2]); SkyTex[i,2]:=0;
  if FileExists(fOptions.WorkDir+'Clouds\'+SKY[i].FogTab+'.ptx') then
  LoadTexturePTX(fOptions.WorkDir+'Clouds\'+SKY[i].FogTab+'.ptx',SkyTex[i,2]);
  end;
  inc(list_sky,Num);
end;

if (list_id>=Qty.BlocksTotal)and(list_ogl>=Qty.Materials)
and(list_tx>=Qty.TexturesFiles)and(list_obj>=Qty.ObjectFiles)
and((list_sky>=SKYQty)or(list_sky=1)) then begin
MemoLoad.Lines.Add('Load Map in'+ElapsedTime(@OldTime));
end;

if UseShaders then //Show progress including shaders
  StatusBar1.Panels[3].Text:=' Loading ~'+inttostr(round(
  (list_id+list_ogl+list_tx+list_obj)/(Qty.BlocksTotal+Qty.TexturesFiles+Qty.Materials+Qty.ObjectFiles)*100))+'%'
else //show progress without Shaders
  StatusBar1.Panels[3].Text:=' Loading ~'+inttostr(round(
  (list_ogl+list_tx+list_obj)/(Qty.TexturesFiles+Qty.Materials+Qty.ObjectFiles)*100))+'%';
end;


////////////////////////////////////////////////////////////////////////////////
// Tracks arcade direction arrows setup
////////////////////////////////////////////////////////////////////////////////
procedure TForm1.ListTracksClick(Sender: TObject);
var i:integer;
begin
  ListTurns.Clear;
  if TrackID=0 then exit;
  for i:=1 to TRKQty[TrackID].Turns do
    ListTurns.Items.Add(inttostr(i)+'. '+inttostr(TRK[TrackID].Turns[i].Node1)+'>>'+inttostr(TRK[TrackID].Turns[i].Node2));
  ListTurns.ItemIndex := 0;
  ListTurnsClick(nil);
end;

procedure TForm1.ListTurnsClick(Sender: TObject);
begin
  if TrackID=0 then exit;
  TurnID := ListTurns.ItemIndex+1;
  if TurnID = 0 then exit;
  TurnsRefresh := true;
  E_Node1.Value:=TRK[TrackID].Turns[TurnID].Node1;
  E_Node2.Value:=TRK[TrackID].Turns[TurnID].Node2;
  E_Arrows.Value:=TRK[TrackID].Turns[TurnID].ArrowNum;
  E_BitSide.ItemIndex:=(TRK[TrackID].Turns[TurnID].BitFlag mod 16)-1;
  E_BitType.ItemIndex:=(TRK[TrackID].Turns[TurnID].BitFlag div 16)-1;
  TurnsRefresh:=false;
end;

procedure TForm1.ListTurnsDblClick(Sender: TObject);
begin
if TrackID=0 then exit;
if ListTurns.ItemIndex<0 then exit;
TurnID:=ListTurns.ItemIndex+1;
xPos:=(TRK[TrackID].Turns[TurnID].Arrows[1].X+TRK[TrackID].Turns[TurnID].Arrows[TRK[TrackID].Turns[TurnID].ArrowNum].X)/2;
yPos:=(TRK[TrackID].Turns[TurnID].Arrows[1].Y+TRK[TrackID].Turns[TurnID].Arrows[TRK[TrackID].Turns[TurnID].ArrowNum].Y)/2;
zPos:=(TRK[TrackID].Turns[TurnID].Arrows[1].Z+TRK[TrackID].Turns[TurnID].Arrows[TRK[TrackID].Turns[TurnID].ArrowNum].Z)/2;
end;

procedure TForm1.AddTurnClick(Sender: TObject);
var ID:integer;
begin
if TrackID=0 then exit;
if TRKQty[TrackID].Turns=0 then begin //convert to WR2 format
TRKQty[TrackID].WR2Flag1:=1;
TRKQty[TrackID].WR2Flag2:=1;
TRKQty[TrackID].a1:=0;
TRKQty[TrackID].a2:=1;
end;
inc(TRKQty[TrackID].Turns);
ID:=TRKQty[TrackID].Turns;
TRK[TrackID].Turns[ID].Node1:=10;
if ID>1 then TRK[TrackID].Turns[ID].Node1:=TRK[TrackID].Turns[ID-1].Node1+10; //previous+10
TRK[TrackID].Turns[ID].Node2:=TRK[TrackID].Turns[ID].Node1+10;
TRK[TrackID].Turns[ID].Arrow1:=0;
TRK[TrackID].Turns[ID].ArrowNum:=15;
TRK[TrackID].Turns[ID].BitFlag:=1+32; //Left Turn
ListTracksClick(nil);                   //redraw Turns list
ListTurns.ItemIndex:=ListTurns.Items.Count-1;
ListTurnsClick(nil);
E_Node1Change(nil);
ComputeTurnClick(nil);
Changes.TRK[TrackID]:=true;
end;

procedure TForm1.RemTurnClick(Sender: TObject);
begin
if TurnID=0 then exit;
if TrackID=0 then exit;
TRK[TrackID].Turns[TurnID].Node1:=0;
TRK[TrackID].Turns[TurnID].Node2:=0;
TRK[TrackID].Turns[TurnID].ArrowNum:=0;
ListTracksClick(nil);                   //redraw Turns list
ListTurnsClick(nil);
ComputeTurnClick(nil);
Changes.TRK[TrackID]:=true;
end;

procedure TForm1.ComputeTurnClick(Sender: TObject);
var i,B,Mul:integer; Xn:single;
begin
if TurnID=0 then exit;
if TrackID=0 then exit;
if TurnsRefresh then exit;
TRK[TrackID].Turns[TurnID].Node1:=E_Node1.Value;
TRK[TrackID].Turns[TurnID].Node2:=E_Node2.Value;
TRK[TrackID].Turns[TurnID].ArrowNum:=E_Arrows.Value;
TRK[TrackID].Turns[TurnID].BitFlag:=(E_BitSide.ItemIndex+1)+(E_BitType.ItemIndex+1)*16;
if E_BitSide.ItemIndex=2 then
TRK[TrackID].Turns[TurnID].ArrowNum:=TRK[TrackID].Turns[TurnID].ArrowNum div 2;

    for B:=1 to 2 do if (B=1)or(E_BitSide.ItemIndex=2) then begin
    Mul:=(E_BitSide.ItemIndex mod 2)*2-1 + (B-1)*2; //0:-1 1:1 2:1
    for i:=1 to TRK[TrackID].Turns[TurnID].ArrowNum do

        with TRK[TrackID].Turns[TurnID].Arrows[i+TRK[TrackID].Turns[TurnID].ArrowNum*(B-1)] do begin
        Xn:=E_Node1.Value+(E_Node2.Value-E_Node1.Value)*(i/TRK[TrackID].Turns[TurnID].ArrowNum)+1;
        //calculate interpolated position
        X:=TRK[TrackID].Route[trunc(Xn)].X*(1-frac(Xn))+TRK[TrackID].Route[trunc(Xn)+1].X*frac(Xn); //base position
        Y:=TRK[TrackID].Route[trunc(Xn)].Y*(1-frac(Xn))+TRK[TrackID].Route[trunc(Xn)+1].Y*frac(Xn); //on the route,
        Z:=TRK[TrackID].Route[trunc(Xn)].Z*(1-frac(Xn))+TRK[TrackID].Route[trunc(Xn)+1].Z*frac(Xn); //tweaked below
        X:=X+E_Aside.Value*10*(Mul)*TRK[TrackID].Route[round(Xn)].Matrix[1]*(1-frac(Xn))+
             E_Aside.Value*10*(Mul)*TRK[TrackID].Route[trunc(Xn)+1].Matrix[1]*frac(Xn);
        Y:=Y+E_Aside.Value*10*(Mul)*TRK[TrackID].Route[round(Xn)].Matrix[4]*(1-frac(Xn))+
             E_Aside.Value*10*(Mul)*TRK[TrackID].Route[trunc(Xn)+1].Matrix[4]*frac(Xn);
        Z:=Z+E_Aside.Value*10*(Mul)*TRK[TrackID].Route[round(Xn)].Matrix[7]*(1-frac(Xn))+
             E_Aside.Value*10*(Mul)*TRK[TrackID].Route[trunc(Xn)+1].Matrix[7]*frac(Xn);
        Matrix[1]:=TRK[TrackID].Route[round(Xn)].Matrix[1]; //use nearest matrix
        Matrix[2]:=TRK[TrackID].Route[round(Xn)].Matrix[2];
        Matrix[3]:=TRK[TrackID].Route[round(Xn)].Matrix[3];
        Matrix[4]:=TRK[TrackID].Route[round(Xn)].Matrix[4];
        Matrix[5]:=TRK[TrackID].Route[round(Xn)].Matrix[5];
        Matrix[6]:=TRK[TrackID].Route[round(Xn)].Matrix[6];
        Matrix[7]:=TRK[TrackID].Route[round(Xn)].Matrix[7];
        Matrix[8]:=TRK[TrackID].Route[round(Xn)].Matrix[8];
        Matrix[9]:=TRK[TrackID].Route[round(Xn)].Matrix[9];
        Delta:=(i-1)*0.1;
        BitFlag:=TRK[TrackID].Turns[TurnID].BitFlag;
        end;//i:=1..ArrowNum

    end;//B:=1..2

if E_BitSide.ItemIndex=2 then TRK[TrackID].Turns[TurnID].ArrowNum:=TRK[TrackID].Turns[TurnID].ArrowNum * 2;
Changes.TRK[TrackID]:=true;
end;

procedure TForm1.E_Node1Change(Sender: TObject);
begin
if TrackID=0 then exit;
if TurnsRefresh then exit;
if (E_Node1.Text='')or(E_Node2.Text='') then exit;
E_Node1.Value:=EnsureRange(E_Node1.Value,1,TRKQty[TrackID].Nodes-1);
E_Node2.Value:=EnsureRange(E_Node2.Value,1,TRKQty[TrackID].Nodes-1);
if (Sender=E_Node1)and(E_Node1.Value>E_Node2.Value) then E_Node2.Value:=E_Node1.Value;
if (Sender=E_Node2)and(E_Node1.Value>E_Node2.Value) then E_Node1.Value:=E_Node2.Value;
xPos:=(TRK[TrackID].Route[E_Node1.Value].X+TRK[TrackID].Route[E_Node2.Value].X)/2;
yPos:=(TRK[TrackID].Route[E_Node1.Value].Y+TRK[TrackID].Route[E_Node2.Value].Y)/2;
zPos:=(TRK[TrackID].Route[E_Node1.Value].Z+TRK[TrackID].Route[E_Node2.Value].Z)/2;
ComputeTurnClick(nil);
Changes.TRK[TrackID]:=true;
end;


procedure TForm1.ListTrigClick(Sender: TObject);
var ID:integer; T:TSTrigger;
begin
  TriggersRefresh := true;
  ID := ListTrig.ItemIndex+1;
  if ID=0 then exit;

  T := fTriggers[ID];

  CBTriggerType.ItemIndex := T.TriggerType - 1;
  TRL_X.Value := T.Position.X;
  TRL_Y.Value := T.Position.Y;
  TRL_Z.Value := T.Position.Z;
  TRL_S1.Value := T.Scale.X;
  TRL_S2.Value := T.Scale.Y;
  TRL_S3.Value := T.Scale.Z;
  TRL_R1.Value := T.Rotation.X;
  TRL_R2.Value := T.Rotation.Y;
  TRL_R3.Value := T.Rotation.Z;
  TRL_P1.Value := T.Target.X;
  TRL_P2.Value := T.Target.Y;
  TRL_P3.Value := T.Target.Z;
  TRL_Flags.Text := T.Flags;

  if T.TriggerType in [4,8] then Label17.Caption:='Value' else Label17.Caption:='Target X';
  Label17.Enabled := T.TriggerType in [4,5,8,11];
  Label16.Enabled := T.TriggerType in [5,11];
  Label15.Enabled := T.TriggerType in [5,11];
  TRL_P1.Enabled := T.TriggerType in [4,5,8,11];
  TRL_P2.Enabled := T.TriggerType in [5,11];
  TRL_P3.Enabled := T.TriggerType in [5,11];

  xPos := T.Position.X;
  yPos := T.Position.Y;
  zPos := T.Position.Z;

  TriggersRefresh := false;
end;


procedure TForm1.ListTrigDblClick(Sender: TObject);
var ID:integer;
begin
  ID := ListTrig.ItemIndex+1;
  if ID=0 then exit;
  xPos := fTriggers[ID].Position.X;
  yPos := fTriggers[ID].Position.Y;
  zPos := fTriggers[ID].Position.Z;
end;


procedure TForm1.AddTriggerClick(Sender: TObject);
var ID:integer;
begin
  if not fTriggers.AddTrigger(Vectorize(xPos, yPos, zPos)) then exit; //Fill in defaults, error if hit the limit

  ID := fTriggers.Count;
  ListTrig.Items.Add(fTriggers[ID].GetName);
  ListTrig.ItemIndex := ID-1; //The last one
  ListTrig.OnClick(ListTrig);
end;


procedure TForm1.RemTriggerClick(Sender: TObject);
var ID:integer;
begin
  ID := ListTrig.ItemIndex+1;
  if ID=0 then exit;

  fTriggers.RemTrigger(ID);
  ListTrig.Items.Delete(ListTrig.ItemIndex);
  ListTrig.ItemIndex := EnsureRange(ID, 1, ListTrig.Items.Count) - 1;
  ListTrigClick(nil);
end;


procedure TForm1.TriggerChange(Sender: TObject);
var ID:integer; T:TSTrigger;
begin
  if TriggersRefresh then exit;

  ID := ListTrig.ItemIndex+1;
  if ID=0 then exit;

  T := fTriggers[ID];

  T.TriggerType := CBTriggerType.ItemIndex + 1;
  ListTrig.Items[ID-1] := fTriggers.TriggerName(ID);
  T.Position := Vectorize(TRL_X.Value, TRL_Y.Value, TRL_Z.Value);
  T.Scale := Vectorize(TRL_S1.Value, TRL_S2.Value, TRL_S3.Value);
  T.Rotation := Vectorize(TRL_R1.Value, TRL_R2.Value, TRL_R3.Value);
  T.Target := Vectorize(TRL_P1.Value, TRL_P2.Value, TRL_P3.Value);

  fTriggers.ApplyRestrictions;

  if T.TriggerType in [4,8] then Label17.Caption:='Value' else Label17.Caption:='Target X';
  Label17.Enabled := T.TriggerType in [4,5,8,11];
  Label16.Enabled := T.TriggerType in [5,11];
  Label15.Enabled := T.TriggerType in [5,11];
  TRL_P1.Enabled := T.TriggerType in [4,5,8,11];
  TRL_P2.Enabled := T.TriggerType in [5,11];
  TRL_P3.Enabled := T.TriggerType in [5,11];

  if (Sender=TRL_X)or(Sender=TRL_Y)or(Sender=TRL_Z) then
  begin
    xPos := T.Position.X;
    yPos := T.Position.Y;
    zPos := T.Position.Z;
  end;
end;


procedure TForm1.BrowseLWO(Sender: TObject);
begin
  //ChDir(WorkDir+'Scenarios\'+Scenery+'\');
  if not RunOpenDialog(OpenDialog,'',SceneryPath,'Lightwave 3D Models (*.lwo)|*.lwo') then exit;
  LWOSceneryFile:=OpenDialog.FileName;
  //LWOSceneryFile:='C:\Documents and Settings\Krom\Desktop\Normandie\Normandie80_v008.lwo';
  //LWOSceneryFile:='C:\H\Sources\Atlantica\Atlantica_v002.lwo';
  LoadLWO(LWOSceneryFile);
end;


procedure TForm1.ReloadLWOClick(Sender: TObject);
begin
  if FileExists(LWOSceneryFile) then
    LoadLWO(LWOSceneryFile)
  else
    MessageBox(Form1.Handle,'Couldn''t find source LWO file.','Error',MB_OK or MB_ICONEXCLAMATION);
end;


procedure TForm1.ComputeChunkMode(Sender: TObject);
var i,k,x1,z1:integer;
begin
  //Compile a list of chunks vs mapping modes
  //Each row in ChunkMode[] corresponds to MaterialID and contains:
  // - Total count of chunks
  // - Chunk IDs
  //ChunkModeParent[] contains X.Z coords of Block in which chunk is located
  for i:=1 to Qty.Materials do begin
    setlength(ChunkMode[i],10);
    setlength(ChunkModeParent[i],10);
    ChunkMode[i,0]:=0;
  end;

  x1:=1; z1:=1;
  for i:=1 to Qty.TexturesTotal do begin

    Assert(v07[i].NumPoly<>0,'ChunkMode Numpoly=0');

    k:=v07[i].SurfaceID+1;
    inc(ChunkMode[k,0]);
    if length(ChunkMode[k])-1<=ChunkMode[k,0] then setlength(ChunkMode[k],length(ChunkMode[k])+10);
    ChunkMode[k,ChunkMode[k,0]]:=i;

    if length(ChunkModeParent[k])-1<=ChunkMode[k,0] then setlength(ChunkModeParent[k],length(ChunkModeParent[k])+10);

    if Block[z1,x1].FirstTex+Block[z1,x1].NumTex<i then begin
      inc(x1);
      if x1>Qty.BlocksX then begin
        x1:=1;
        inc(z1);
      end;
    end;
    ChunkModeParent[k,ChunkMode[k,0]].x:=x1;
    ChunkModeParent[k,ChunkMode[k,0]].z:=z1;
  end;

end;

procedure TForm1.ListObjectsClick(Sender: TObject);
var ii,kk,ID:integer;
begin
ObjectsRefresh:=true;
ID:=ListObjects.ItemIndex+1;
if ID=0 then exit;

CBObjMode.ItemIndex:=ObjTypes1inv[ObjProp[ID].Mode];
CBObjShape.ItemIndex:=ObjProp[ID].Shape;
ObjWeight.Value:=ObjProp[ID].Weight;
ObjHit.Text:=ObjProp[ID].HitSound;
ObjFall.Text:=ObjProp[ID].FallSound;

kk:=1;
ListObjects2.Clear;
  for ii:=1 to Qty.ObjectsTotal do
  if (Obj[ii].ID+1=ID)or(ID=0) then begin
  ListObjects2.Items.Add(OBJ[ii].Name+' #'+inttostr(kk)+' ID='+int2fix(ii,4));
  inc(kk);
  end;
Label29.Caption:=inttostr(kk-1)+' Object locations:';

ObjectsRefresh:=false;
end;

procedure TForm1.ListObjects2Click(Sender: TObject);
var ID:integer; ss:string; a,b,c:integer;
begin
if ListObjects2.ItemIndex<0 then exit;
ObjInstanceRefresh:=true;
ss:=ListObjects2.Items[ListObjects2.ItemIndex];
decs(ss,-length(ss)+4); //Keep last 4 digits
ID:=strtoint(ss);
ListObjectsInstances.ItemIndex:=Obj[ID].ID;
ObjX.Value:=Obj[ID].PosX;
ObjY.Value:=Obj[ID].PosY;
ObjZ.Value:=Obj[ID].PosZ;
ObjAngl.Value:=round(Obj[ID].Angl/pi*180);
ObjSize.Value:=Obj[ID].Size;
ObjInShadow.Checked:=Obj[ID].InShadow=1;
Matrix2Angles(Obj[ID].Matrix2,9,@a,@b,@c);
Label47.Caption:='Parent block: '+inttostr(ObjW[ID].ParentBlock);
Label105.Caption:=inttostr(Obj[ID].x1)+'  '+floattostr(Obj[ID].x5);//+'  '+inttostr(Obj[ID].x4);
RemakeQADTable(nil);
ObjInstanceRefresh:=false;
end;


procedure TForm1.ListObjects2DblClick(Sender: TObject);
var ID:integer; ss:string;
begin
  if ListObjects2.ItemIndex = -1 then exit;
  ss:=ListObjects2.Items[ListObjects2.ItemIndex];
  decs(ss,-length(ss)+4); //Keep last 4 digits
  ID:=strtoint(ss);
  xPos:=Obj[ID].PosX;
  yPos:=Obj[ID].PosY;
  zPos:=Obj[ID].PosZ;
end;


procedure TForm1.RemObjectClick(Sender: TObject);
var h,i,k,m,ID:integer;
begin
ObjectsRefresh:=true;
ID:=ListObjects.ItemIndex+1; //1..Qty
if ID=0 then exit;
if Qty.ObjectFiles<=1 then begin {RemObject.Enabled:=false;} exit; end;

        m:=0; h:=0; //number of objects to be removed
        for i:=1 to Qty.ObjectsTotal do if Obj[i].ID+1=ID then inc(m);
        for i:=1 to MAX_TRACKS do for k:=1 to TOBHead[i].Qty do if TOB[i,k].ID+1=ID then inc(h);
        k:=0;
        for i:=1 to SNIHead.Obj do if SNIObj[i].objID+1=ID then inc(k);

        if MessageBox(Form1.Handle,PChar(
        'Please confirm removing of:'+eol+' - '+inttostr(m)+' map objects (QAD),'+eol+' - '+inttostr(h)+' track objects (TOB),'+eol+' - '+inttostr(k)+' animated objcts (SNI) ?'),
        PChar('Warning ['+ObjName[ID]+']'), MB_OKCANCEL or MB_ICONWARNING)=IDCANCEL then
        exit;

for i:=ID to Qty.ObjectFiles-1 do begin //shift up
ObjName[i]:=ObjName[i+1];
ObjProp[i]:=ObjProp[i+1];
ObjCall[i]:=ObjCall[i+1];//Render list
ObjTex[i] :=ObjTex[i+1];//Render list
end;
dec(Qty.ObjectFiles);

m:=1; //Remove from scenery
  for h:=1 to Qty.ObjectsTotal do
    if Obj[h].ID+1<>ID then begin
    Obj[m]:=Obj[h];
    if Obj[m].ID+1>ID then begin
    dec(Obj[m].ID);
    Obj[m].Name:=ObjName[Obj[m].ID+1];
    end;
    inc(m);
    end;
Qty.ObjectsTotal:=m-1;

RemakeQADTable(nil); //Rebuild objects

//Remove from TOB list
ListObjectsTOB.Clear;
for i:=1 to Qty.ObjectFiles do
ListObjectsTOB.AddItem(inttostr(i)+'. '+ObjName[i],nil);
ListObjectsTOB.ItemIndex:=0;

//Remove from TRK
for i:=1 to TracksQty do begin
m:=1;
for k:=1 to TOBHead[i].Qty do
if TOB[i,k].ID+1<>ID then begin
TOB[i,m]:=TOB[i,k];
if TOB[i,m].ID+1>ID then dec(TOB[i,m].ID);
inc(m);
end;
TOBHead[i].Qty:=m-1;
Changes.TOB[i]:=true;
end;

//Remove from SNI list
ListObjectsSNI.Clear;
for i:=1 to Qty.ObjectFiles do
ListObjectsSNI.AddItem(inttostr(i)+'. '+ObjName[i],nil);
ListObjectsSNI.ItemIndex:=0;

m:=1;
h:=0;
for k:=1 to SNIHead.Obj do
if SNIObj[k].ObjID+1<>ID then begin
SNIObj[m]:=SNIObj[k];
SNIObj[m].firstNode:=h;
inc(h,SNIObj[m].NumNodes);
if SNIObj[m].ObjID+1>ID then dec(SNIObj[m].ObjID);
inc(m);
end else
for i:=SNIObj[k].firstNode+1 to SNIObj[k].firstNode+SNIObj[k].NumNodes do begin
SNINode[i].X:=0; SNINode[i].Y:=0; SNINode[i].Z:=0;
SNINode[i].Speed:=0; SNINode[i].B:=0;
end;
h:=1;
for i:=1 to SNIHead.Node do
if (SNINode[i].Speed<>0)and(SNINode[i].X<>0)and(SNINode[i].Z<>0) then begin//3matches should be enough
SNINode[h]:=SNINode[i];
inc(h);
end;
SNIHead.Obj:=m-1;
SNIHead.Node:=h-1;
Changes.SNI:=true;
Changes.WRK:=true;

ListObjects.Items.Delete(ListObjects.ItemIndex); //remove from list
ListObjects.ItemIndex:=EnsureRange(ID,1,Qty.ObjectFiles)-1;
ObjectsRefresh:=false;
ListObjectsClick(nil);
Changes.QAD:=true;
end;

procedure TForm1.ButtonPrintScreenClick(Sender: TObject);
var
  f:file;
  SizeH,SizeV,i,k:integer;
  fbo,img,depthbuffer:GLuint;
  bmp4:pointer;
begin
if Sender=MakeSMP then begin
  SizeH:=SMPHead.A;
  if SizeH>2048 then SizeH:=4096 else
  if SizeH>1024 then SizeH:=2048 else
  if SizeH>512  then SizeH:=1024 else
  SizeH:=512;
  SizeV:=SMPHead.B;
  if SizeV>2048 then SizeV:=4096 else
  if SizeV>1024 then SizeV:=2048 else
  if SizeV>512  then SizeV:=1024 else
  SizeV:=512;
end;

if Sender=ScreenRender then begin
  SizeH := fOptions.TopDownRenderV;
  SizeV := fOptions.TopDownRenderV;
end;

glGenTextures(1, @img);
glBindTexture(GL_TEXTURE_2D, img);
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
if Sender=MakeSMP       then glTexImage2D(GL_TEXTURE_2D, 0, GL_DEPTH_COMPONENT, SizeH, SizeV, 0, GL_DEPTH_COMPONENT, GL_FLOAT, nil);
if Sender=ScreenRender  then glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, SizeH, SizeV, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);

glGenFramebuffersEXT(1, @fbo);
glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, fbo);

glGenRenderbuffersEXT(1, @depthbuffer);
glBindRenderbufferEXT(GL_RENDERBUFFER_EXT, depthbuffer);
glRenderbufferStorageEXT(GL_RENDERBUFFER_EXT, GL_DEPTH_COMPONENT, SizeH, SizeV);
glFramebufferRenderbufferEXT(GL_FRAMEBUFFER_EXT, GL_DEPTH_ATTACHMENT_EXT, GL_RENDERBUFFER_EXT, depthbuffer);

if Sender=MakeSMP      then glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_DEPTH_ATTACHMENT_EXT,  GL_TEXTURE_2D, img, 0);
if Sender=ScreenRender then glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_EXT, GL_TEXTURE_2D, img, 0);
glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, fbo);

      if Sender=MakeSMP then begin
        glDrawBuffer(GL_NONE);
        glReadBuffer(GL_NONE);
      end;

      if Sender=ScreenRender then begin
        glViewport(0,0,SizeH, SizeV);
        glMatrixMode(GL_PROJECTION);
        glLoadIdentity;
        glOrtho(-512*Qty.BlocksX,512*Qty.BlocksX,
                512*Qty.BlocksZ,-512*Qty.BlocksZ,-4000,2000);
        glMatrixMode(GL_MODELVIEW);
        glLoadIdentity;
      end;

RenderFrame(Sender);

RenderResize(Form1); //Restore perspective

glBindTexture(GL_TEXTURE_2D,img);

if Sender=MakeSMP then begin
  setlength(SMPData,SizeH*SizeV+1);
  glGetTexImage(GL_TEXTURE_2D,0,GL_DEPTH_COMPONENT,GL_FLOAT,@SMPData[1]);
end;

GetMem(bmp4,1);

if Sender=ScreenRender then begin
  GetMem(bmp4,SizeH*SizeV*4);
  glActiveTexture(GL_TEXTURE0);
  glGetTexImage(GL_TEXTURE_2D,0,GL_BGRA,GL_UNSIGNED_BYTE,bmp4); //BGRA is TGA pixel format
end;

glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, 0);
glBindRenderbufferEXT(GL_RENDERBUFFER_EXT, 0);
glBindTexture(GL_TEXTURE_2D,0);
glDeleteFramebuffersEXT(1, @fbo);
glDeleteRenderbuffersEXT(1, @depthbuffer);
glDeleteTextures(1,@img);

if Sender=ScreenRender then begin
  AssignFile(f,fOptions.ExeDir+'STKit2_screen.tga'); ReWrite(f,1);
  blockwrite(f,(#0#0#2#0#0#0#0#0#0#0#0#0),12);
  blockwrite(f,SizeH,2);
  blockwrite(f,SizeV,2);
  blockwrite(f,#32#0,2);
  blockwrite(f,pinteger(bmp4)^,SizeH*SizeV*4);
  closefile(f);
  MessageBox(Form1.Handle, PChar('Screenshot saved to '+fOptions.ExeDir+'\STKit2_screen.tga'), 'Info', MB_OK or MB_ICONINFORMATION);
end;

FreeMem(bmp4);

if Sender=MakeSMP then begin
  for i:=1 to SMPHead.B do for k:=1 to SMPHead.A do
    SMPData[(i-1)*SMPHead.A+k]:=SMPData[(i-1)*SizeH+k];
  setlength(SMPData,SMPHead.A*SMPHead.B+1);
end;
end;

procedure TForm1.SaveSceneryClick(Sender: TObject);
var i:integer; WSS:string;
begin
if not SaveButton then exit;
case RG1.ItemIndex of
0: SceneryVersion:='V1';
1: SceneryVersion:='V2';
2: SceneryVersion:='V3';
end;
WSS:=fOptions.WorkDir+'Scenarios\'+Scenery+'\';
CreateDir(fOptions.WorkDir+'AddOns\');
CreateDir(fOptions.WorkDir+'AddOns\Sceneries\');
CreateDir(fOptions.WorkDir+'AddOns\Sceneries\'+Scenery+'\');
CreateDir(WSS);
CreateDir(WSS+SceneryVersion+'\');
CreateDir(WSS+SceneryVersion+'\Extra\');
CreateDir(WSS+SceneryVersion+'\Tracks\');
if Changes.QAD then SaveQAD(WSS+SceneryVersion+'\'+Scenery+'.qad');
if Changes.WRK then SaveWRK(WSS+SceneryVersion+'\'+Scenery+' WorkFile.wrk'); //save after qad, to get materials sorted
if Changes.IDX then SaveIDX(WSS+SceneryVersion+'\'+Scenery+'.idx');
if Changes.VTX then SaveVTX(WSS+SceneryVersion+'\'+Scenery+'.vtx');
if Changes.SNI then SaveSNI(WSS+SceneryVersion+'\'+Scenery+'.sni');
if Changes.LVL then SaveLVL(WSS+SceneryVersion+'\'+Scenery+'.lvl');
if Changes.SMP then SaveSMP(WSS+SceneryVersion+'\Extra\ShdwMap.smp');
if Changes.SKY then SaveSKY(WSS+SceneryVersion+'\'+Scenery+'.sky');
if fGrass.Changed then fGrass.SaveToFile(WSS+SceneryVersion+'\'+Scenery,CBOptimizeGrass.Checked);
for i:=1 to MAX_TRACKS do if Changes.TOB[i] then SaveTOB(WSS+SceneryVersion+'\Tracks\'+Scenery+'_'+int2fix(i,2)+'.tob',i);

//Files below are same for all Versions
for i:=1 to MAX_TRACKS do if Changes.TRK[i] then begin
  if DirectoryExists(WSS+'V1\') then SaveTRK(WSS+'V1\Tracks\'+Scenery+'_'+int2fix(i,2)+'.trk',i);
  if DirectoryExists(WSS+'V2\') then SaveTRK(WSS+'V2\Tracks\'+Scenery+'_'+int2fix(i,2)+'.trk',i);
  if DirectoryExists(WSS+'V3\') then SaveTRK(WSS+'V3\Tracks\'+Scenery+'_'+int2fix(i,2)+'.trk',i);
end;
for i:=1 to MAX_WP_TRACKS do if Changes.WTR[i] then begin
  if DirectoryExists(WSS+'V1\') then SaveWTR(WSS+'V1\Tracks\'+Scenery+'_'+int2fix(i,2)+'.wtr',i);
  if DirectoryExists(WSS+'V2\') then SaveWTR(WSS+'V2\Tracks\'+Scenery+'_'+int2fix(i,2)+'.wtr',i);
  if DirectoryExists(WSS+'V3\') then SaveWTR(WSS+'V3\Tracks\'+Scenery+'_'+int2fix(i,2)+'.wtr',i);
end;
if DirectoryExists(WSS+'V1\') then SaveTRK_DAT(WSS+'V1\Tracks\tracks.dat');
if DirectoryExists(WSS+'V2\') then SaveTRK_DAT(WSS+'V2\Tracks\tracks.dat');
if DirectoryExists(WSS+'V3\') then SaveTRK_DAT(WSS+'V3\Tracks\tracks.dat');

if Changes.SC2 then SaveSC2(fOptions.WorkDir+'AddOns\Sceneries\'+Scenery+'\EditScenery.sc2');
if fTriggers.Changed then fTriggers.SaveToFile(fOptions.WorkDir+'RaceDat\'+Scenery+'.trl');
if Changes.STR then SaveSTR(fOptions.WorkDir+'Traffic\Streets\'+Scenery+'.str');

ShowChangesInfoClick(nil);
ShowQADInfo(nil);
end;

procedure TForm1.ListMaterialsClick(Sender: TObject);
var ID:integer;
begin
  MatRefresh:=true;
  ID:=ListMaterials.ItemIndex+1;
  if ID=0 then exit;
  Panel6.Caption:='Material ID.'+inttostr(ID)+' - '+MaterialW[ID].Name+', Mode'+inttostr(Material[ID].Mode);
  RGMatMode.ItemIndex:=Material[ID].Mode div 16;
  CBMatGrass.Checked:=MaterialW[ID].GrowGrass=1;
  CBMatEnlite.Checked:=MaterialW[ID].Enlite=1;
  CBMatNoShadow.Checked:=MaterialW[ID].NoShadow=1;
  CBTex1.ItemIndex:=Material[ID].Tex1;
  CBTex2.ItemIndex:=Material[ID].Tex2;
  CBTex3.ItemIndex:=Material[ID].Tex3;
  MatTexLayChange(nil);
  MatRefresh:=false;
  if CBTraceMat.Checked then CBTraceMatClick(nil);
end;

procedure TForm1.RGMatModeClick(Sender: TObject);
var ID:integer;
begin
if MatRefresh then exit;
ID:=ListMaterials.ItemIndex+1; //already in range 1..256
if ID=0 then exit;
Material[ID].Mode:=RGMatMode.ItemIndex*16;
ListMaterials.Items[ID-1]:=inttostr(ID)+'. '+MaterialW[ID].Name+' ('+TexName[Material[ID].Tex1+1]+')['+inttostr(Material[ID].Mode)+']'; //renaming on-the-fly
MaterialW[ID].GrowGrass:=byte(CBMatGrass.Checked);
MaterialW[ID].Enlite:=byte(CBMatEnlite.Checked);
MaterialW[ID].NoShadow:=byte(CBMatNoShadow.Checked);

ComputeChunkMode(nil);
Changes.QAD:=true;
if (Sender=CBMatGrass)or(Sender=CBMatEnlite) then Changes.WRK:=true;
end;

procedure TForm1.CBTexChange(Sender: TObject);
var MatID,ID:integer;
begin
  if MatRefresh then exit;

  MatID:=ListMaterials.ItemIndex+1;
  if MatID=0 then exit;
  ID:=(Sender as TComboBox).ItemIndex+1;
  if ID=0 then exit;

  case (Sender as TControl).Name[6] of
    '1': Material[MatID].Tex1 := ID-1;
    '2': Material[MatID].Tex2 := ID-1;
    '3': Material[MatID].Tex3 := ID-1;
  end;

  RecalculatematerialCRC1Click(nil);

MatTexLay.ActivePageIndex:=strtoint((Sender as TControl).Name[6])-1;
  MatTexLayChange(nil);
  Changes.QAD:=true;
end;

procedure TForm1.QADtoUIClick(Sender: TObject);
begin //Placeholder, do not remove
end;

procedure TForm1.SendQADtoUI(aActivePage:TActivePage);
var i:integer; s:string;
begin

  case aActivePage of
    apLWO:
        Label128.Caption:='Path '+LWOSceneryFile;

    apTextures:
        begin
          ListTextures.Clear;
          for i:=1 to Qty.TexturesFiles do
            ListTextures.Items.Add(TexName[i]);
          ListTextures.ItemIndex:=-1;
          CBTex1.Clear; CBTex2.Clear; CBTex3.Clear;
          for i:=1 to Qty.TexturesFiles do begin
            CBTex1.Items.Add(TexName[i]);
            CBTex2.Items.Add(TexName[i]);
            CBTex3.Items.Add(TexName[i]);
          end;
          Label58.Caption:='Texture files: '+inttostr(Qty.TexturesFiles);
        end;

    apGrounds:
        begin
          ListGrounds.Clear;
          for i:=1 to Qty.GroundTypes do begin
            ListGrounds.Items.Add(Ground[i].Name);
            RGTexMat.Items[i-1]:=Ground[i].Name;
            RGTexMat.Controls[i-1].Enabled:=true;
          end;
          ListGrounds.ItemIndex := -1;
          for i:=Qty.GroundTypes+1 to RGTexMat.Items.Count do begin
            RGTexMat.Items[i-1]:='none';
            RGTexMat.Controls[i-1].Enabled:=false;
          end;
        end;

    apMaterials:
        begin
          ListMaterials.Clear;
          for i:=1 to Qty.Materials do ListMaterials.Items.Add(MaterialW[i].Name+' ('+TexName[Material[i].Tex1+1]+')');
          ListMaterials.ItemIndex := -1;
        end;

    apObjects:
        begin
          TOBRefresh:=true;
          SNIRefresh:=true;
          ObjInstanceRefresh:=true;
          ListObjects.Clear;
          ListObjectsTOB.Clear;
          ListObjectsSNI.Clear;
          ListObjectsInstances.Clear;
          for i:=1 to Qty.ObjectFiles do begin
            ListObjects.Items.Add(ObjName[i]+' '+inttostr(ObjProp[i].Mode)+' '+inttostr(ObjProp[i].Shape));
            ListObjectsTOB.Items.Add(inttostr(i)+'. '+ObjName[i]);
            ListObjectsSNI.Items.Add(inttostr(i)+'. '+ObjName[i]);
            ListObjectsInstances.Items.Add(inttostr(i)+'. '+ObjName[i]);
          end;
          ListObjects.ItemIndex:=0;    ListObjectsClick(nil);
          ListObjectsTOB.ItemIndex:=0;
          ListObjectsSNI.ItemIndex:=0;
          ListObjectsInstances.ItemIndex:=0;
          TOBRefresh:=false;
          SNIRefresh:=false;
          ObjInstanceRefresh:=false;
          Label28.Caption:=inttostr(Qty.ObjectFiles)+' Object files:';
        end;

    apSounds:
        begin
          ListSounds.Clear;
          ListSounds.Items.Add(' - All - ');
          for i:=1 to Qty.Sounds do
            ListSounds.Items.Add(inttostr(i)+'. '+Sound[i].Name);
          ListSounds.ItemIndex:=0;
        end;

    apLights:
        begin
          ListLights.Clear;
          for i:=1 to Qty.Lights do
            ListLights.Items.Add(inttostr(i)+'. M'+inttostr(Light[i].Mode)+' X'+
          floattostr(round(Light[i].Size*10)/10)+' F'+floattostr(round(Light[i].Freq*100)/100));
          ListLights.ItemIndex:=0;
          Light_Amb.Brush.Color:=AmbLightW.R+AmbLightW.G*256+AmbLightW.B*65536;
        end;

    apSky:
        begin
          ListSKY.Clear;
          for i:=1 to SKYQty do ListSKY.Items.Add(inttostr(i)+'. '+SKY[i].SkyTex);
          if SKYQty>0 then ListSKY.ItemIndex:=0 else ListSKY.ItemIndex:=-1;
          ListSKYClick(nil);
          SKYIndex:=ListSKY.ItemIndex+1;
          RGShadEdge.ItemIndex:=ShadowEdgeW;

          LVLRefresh:=true;
          LVL_SunY.Value:=arcsin(LVL.SunY)*180/pi;
          LVL_SunXZ.Value:=(arctan2(LVL.SunZ,LVL.SunX)*180/pi);
          //LVL_A.Value:=LVL.a; LVL_B.Value:=LVL.b; LVL_C.Value:=LVL.c;
          //LVL1.Value:=LVL.App1; LVL2.Value:=LVL.App2; LVL3.Value:=LVL.App3;
          LVLRefresh:=false;
        end;

    apAnimated:
        begin
          ListSNIObjects.Clear;
          for i:=1 to SNIHead.Obj do
          ListSNIObjects.Items.Add(ObjName[SNIObj[i].objID+1]+' ('+StrPas(@SNIObj[i].Sound)+') '
          +inttostr(SNIObj[i].Mode));
          ListSNIObjects.ItemIndex:=0;
          Label46.Caption:='Routes list: '+inttostr(SNIHead.Obj);
        end;

    apTriggers:
        begin
          CBTriggerType.Clear;
          for i:=1 to 16 do CBTriggerType.AddItem(TRLnames[i],nil);
          ListTrig.Clear;
          for i:=1 to fTriggers.Count do
            ListTrig.Items.Add(fTriggers.TriggerName(i));
          ListTrig.ItemIndex:=-1;
        end;

    apTracksMT,apTracksAR,apTracksWP:
        begin
          CBTrack.Clear;
          LBTrack.Clear;
          for i:=1 to TracksQty do begin
            CBTrack.Items.Add(Scenery+' '+inttostr(i));
            LBTrack.Items.Add(Scenery+' '+inttostr(i)+'  '+inttostr(TRKQty[i].a1)+inttostr(TRKQty[i].a2)+inttostr(TRKQty[i].a4)+inttostr(TRKQty[i].a6)+inttostr(TRKQty[i].a7)+inttostr(TRKQty[i].a8));
          end;
          for i:=1 to TracksQtyWP do begin
            CBTrack.Items.Add(Scenery+' WP'+inttostr(i));
            LBTrack.Items.Add(Scenery+' WP'+inttostr(i));
          end;
          TrackID:=EnsureRange(TrackID,1,TracksQty);
          CBTrack.ItemIndex := TrackID-1;
          LBTrack.ItemIndex := TrackID-1;
        end;

    apStreets:
        begin
          ListStreetShape.Clear;
          for i:=1 to STRHead.NumShapes do begin
          s:=inttostr(round(STR_ShRef[i].Speed*0.0036))+'kmh ';
          s:=s+inttostr(round(STR_Shape[i].Offset[1]))+'m ';
          if STR_Shape[i].NumLanes=2 then s:=s+inttostr(round(STR_Shape[i].Offset[2]))+'m ';
          if (STR_Shape[i].Options and 4096 = 4096) then s:=s+'1' else s:=s+'0';
          if (STR_Shape[i].Options and 8192 = 8192) then s:=s+'1' else s:=s+'0';
          ListStreetShape.Items.Add(s);
          end;
          ListStreetShape.ItemIndex:=-1;
        end;

    apGrass:
        begin
          GrassCol.Brush.Color:=GrassColorW.R+GrassColorW.G*256+GrassColorW.B*65536;
          ShowGrassInfo(nil);
        end;

    apAddonInfo:
        begin
          WriteCommonDataToSC2;
          SendDataToSC2;
        end;
  end;
end;

procedure TForm1.PanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
if Button<>mbLeft then exit; //dunno why, but RMB works wrong, better to forbid it at all
(Sender as TImage).Left:=1;
(Sender as TImage).Top :=1;
if Sender=ImageMove   then begin MouseAction:=tmaMove; PanelMove.BevelOuter  :=bvLowered; end;
if Sender=ImageRotate then begin MouseAction:=tmaRotate; PanelRotate.BevelOuter:=bvLowered; end;
if Sender=ImageZoom   then begin MouseAction:=tmaZoom; PanelZoom.BevelOuter  :=bvLowered; end;
MousePos.X := X;
MousePos.Y := Y;
ShowCursor(false);
end;

procedure TForm1.PanelMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MouseAction:=tmaNone; ShowCursor(true);
PanelMove.BevelOuter   :=bvRaised;
PanelRotate.BevelOuter :=bvRaised;
PanelZoom.BevelOuter   :=bvRaised;
(Sender as TImage).Left:=0;
(Sender as TImage).Top :=0;
end;

procedure TForm1.PanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var dx,dy:integer; b:Boolean;
begin
  if MouseAction=tmaNone then exit;
  dx:=0; dy:=0;
  case MouseAction of
    tmaMove:
        begin
            xPos:=xPos+(-(MousePos.X-X)*MouseMoveScale*cos(xRot/180*pi)
                        +(MousePos.Y-Y)*sign(yRot-180)*MouseMoveScale*sin(xRot/180*pi))/zoom/2;
            zPos:=zPos+( (MousePos.X-X)*MouseMoveScale*sin(xRot/180*pi)
                        +(MousePos.Y-Y)*sign(yRot-180)*MouseMoveScale*cos(xRot/180*pi))/zoom/2;
            xPos:=EnsureRange(xPos,-Qty.BlocksX*512,Qty.BlocksX*512);
            zPos:=EnsureRange(zPos,-Qty.BlocksZ*512,Qty.BlocksZ*512);
            dx:=Form1.ClientOrigin.X+PanelMove.Left+ImageMove.Left+MousePos.X;
            dy:=Form1.ClientOrigin.Y+PanelMove.Top +ImageMove.Top+MousePos.Y;
        end;
    tmaRotate:
        begin
          xRot:=xRot+(MousePos.X-X)/2.4; //a bit slower rotation feels better
          yRot:=yRot+(MousePos.Y-Y)/2.4;
            dx:=Form1.ClientOrigin.X+PanelRotate.Left+ImageRotate.Left+MousePos.X;
            dy:=Form1.ClientOrigin.Y+PanelRotate.Top +ImageRotate.Top+MousePos.Y;
        end;
    tmaZoom:
        begin
            Zoom := EnsureRange(Zoom-(MousePos.X-X)/300, ZoomLo, ZoomHi);
            dx:=Form1.ClientOrigin.X+PanelZoom.Left+ImageZoom.Left+MousePos.X;
            dy:=Form1.ClientOrigin.Y+PanelZoom.Top +ImageZoom.Top+MousePos.Y;
        end;
  end;

  if fOptions.TraceSurface then if (not ScnRefresh)and(Qty.Polys>0) then
    TraceHeight(xPos,yPos,zPos,pd_Near,@yPos,@TracePt);

  if yRot<0 then yRot:=yRot+360;
  if yRot>=360 then yRot:=yRot-360;
  StatusBar1.Panels[2].Text:=' H'+inttostr(round(xRot)mod 360)+
                             ' P'+inttostr(round(yRot))+
                             ' Z'+floattostr(round(Zoom*100)/100);
  StatusBar1.Refresh;
  SetCursorPos(dx,dy); //return cursor to start location = "stick it"
  OnIdle(Panel1,b); //RENDER, otherwise it not works
end;

procedure TForm1.ListSNIObjectsClick(Sender: TObject);
var ii,ID:integer;
begin
SNIRefresh:=true;
ListSNINodes.Clear;
if ListSNIObjects.ItemIndex<0 then exit;
ID:=ListSNIObjects.ItemIndex+1;
  for ii:=SNIObj[ID].firstNode+1 to SNIObj[ID].firstNode+SNIObj[ID].NumNodes do
  ListSNINodes.Items.Add('Node '+int2fix(ii-SNIObj[ID].firstNode,2)+'  ('+int2fix(ii,4)+')');
ListSNINodes.ItemIndex:=0;
ListSNINodesClick(nil);

ListObjectsSNI.ItemIndex:=SNIObj[ID].objID;
CBSNIMode.ItemIndex:=SNIObj[ID].Mode;

//Disable them incase we have spawn route
EditSNISound.Enabled:=SNIObj[ID].Mode<>5;
Label93.Enabled:=SNIObj[ID].Mode<>5;

EditSNISound.Text:=SNIObj[ID].Sound;

if SNIObj[ID].Mode<5 then begin
Label53.Caption:='Volume';
Label54.Caption:='Tempo, %';
Label55.Caption:='Radius, m';
Label33.Caption:='Unknown';
SNIx1.Value:=SNIObj[ID].Volume;
SNIx2.Value:=SNIObj[ID].Tempo;
SNIx3.Value:=SNIObj[ID].Radius*10;
SNIx4.Value:=SNIObj[ID].x4;
end else begin
Label53.Caption:='Spacing, m';
Label54.Caption:='Speed, km/h';
Label55.Caption:='Turbulence, m';
Label33.Caption:='Parent track ID';
SNIx1.Value:=SNISpawnW[ID].Density;
SNIx2.Value:=SNISpawnW[ID].Speed;
SNIx3.Value:=SNISpawnW[ID].Turbulence;
SNIx4.Value:=SNISpawnW[ID].TrackID;
end;

Label52.Caption:='Nodes list: ('+floattostr(round(SNILen[ID])/10)+'m)';
SNIRefresh:=false;
end;


procedure TForm1.PageControl1DrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
var NewRect:TRect; bm:Tbitmap;
begin
  NewRect := Rect;
  bm := TBitmap.Create;
  ImageList1.GetBitmap(TabIndex, bm);
  Control.Canvas.Draw(NewRect.Left-1,NewRect.Top-1,bm);
  inc(NewRect.Top, 30);
  Control.Canvas.Brush.Style := bsClear;
  Control.Canvas.Font.Color := clBlack;
  Control.Canvas.TextOut(NewRect.Left, NewRect.Top, PageShortcut[TabIndex+1]);
  bm.Free;
end;


procedure TForm1.TexScaleChange(Sender: TObject);
var ID,k:integer;
begin
if MatRefresh then exit;
ID:=ListMaterials.ItemIndex+1;
if ID=0 then exit;
k:=MatTexLay.ActivePageIndex+1;
Material_ScaleChange(ID,k,TexRotX.Value,TexRotY.Value,TexRotZ.Value,TexScaleX.Value,TexScaleY.Value,TexMoveX.Value,TexMoveY.Value);
end;

procedure TForm1.Material_ScaleChange(MatID,Lay:integer; rotH,rotP,rotB,sX,sY,mX,mY:single);
var ax,ay,az:single; a,b,c,d,e,f:single;
begin
ax:=rotH/180*pi;
ay:=rotP/180*pi;
az:=rotB/180*pi;
sX:=1/sX;
sY:=1/sY;

a:=cos(ax); b:=sin(ax);
c:=cos(ay); d:=sin(ay);
e:=cos(az); f:=sin(az);

  with Material[MatID] do begin
    Matrix[Lay,1,1]:=C*E*sx;
    Matrix[Lay,1,2]:=-C*F*sx;
    Matrix[Lay,1,3]:=D*sx;
    Matrix[Lay,2,1]:=(-A*D*E+B*F)*sy;
    Matrix[Lay,2,2]:=(A*D*F+B*E)*sy;
    Matrix[Lay,2,3]:=(A*C)*sy;
    Matrix[Lay,1,4]:=TexMoveX.Value;
    Matrix[Lay,2,4]:=TexMoveY.Value;
  end;

RecalculatematerialCRC1Click(nil);

Changes.QAD:=true;
end;

procedure TForm1.RecalculatematerialCRC1Click(Sender: TObject);
var MatID:integer;
begin
for MatID:=1 to Qty.Materials do begin
  Material[MatID].CRC[1]:=Adler32CRC(@Material[MatID].Matrix[1,1,1],32) xor Material[MatID].Tex1 xor (MatID*256);
  Material[MatID].CRC[2]:=Adler32CRC(@Material[MatID].Matrix[2,1,1],32) xor Material[MatID].Tex2 xor (MatID*256);
  Material[MatID].CRC[3]:=Adler32CRC(@Material[MatID].Matrix[3,1,1],32) xor Material[MatID].Tex3 xor (MatID*256);
end;
Changes.QAD:=true;
end;

procedure TForm1.MatTexLayChange(Sender: TObject);
var ID,k:integer; sx,sy,ax,ay,az:single;
begin
MatRefresh:=true;
ID:=ListMaterials.ItemIndex+1;
if ID=0 then exit;
k:=MatTexLay.ActivePageIndex+1;
with Material[ID] do begin
sx:=GetLength(Matrix[k,1,1],Matrix[k,1,2],Matrix[k,1,3]);
sy:=GetLength(Matrix[k,2,1],Matrix[k,2,2],Matrix[k,2,3]);

ay:=arcsin(Matrix[k,1,3]/sx);
if abs(cos(ay))>0.01 then begin //Y in 0..89 else X&Z combine in one
az:=arctan2(-Matrix[k,1,2],Matrix[k,1,1]);
//ax:=arctan2(B,A);
if abs(sin(ay))<0.01 then //Y = 0
  if abs(sin(az))<0.01 then //Z = 0
  ax:=arctan2(Matrix[k,2,2],Matrix[k,2,3]) //+
  //         | 1 0 0 |
  //         | 0 B A |
  else
  ax:=arctan2(Matrix[k,2,1]/sin(az),Matrix[k,2,3]) //+
  //         | E    -F   0 |
  //         | BF   BE   A |    B=BF/F
else
  if abs(sin(az))<0.01 then //Z = 0
  ax:=arctan2(Matrix[k,2,2],Matrix[k,2,3]/cos(ay)) //
  //        |  C     0    D  | A=AC/C=Matrix[k,2,3]/cos(ay);
  //        | -AD    B    AC |
  else
  ax:=arctan2((Matrix[k,2,1]+Matrix[k,2,3]/cos(ay)*sin(ay)*cos(az))/sin(az),Matrix[k,2,3]/cos(ay)); //
  //        |  CE      -CF       D  | A=AC/C=Matrix[k,2,3]/cos(ay);
  //        | -ADE+BF   ADF+BE   AC | B=(21+ADE)/F=A*sin(ay)*cos(az)/sin(az)
  //21=-ADE+BF B=(21+ADE)/F
end else begin
ax:=0;
az:=arctan2(Matrix[k,2,2],-Matrix[k,2,1]);
end;
{a:=cos(ax); b:=sin(ax);//1 0
 c:=cos(ay); d:=sin(ay);
 e:=cos(az); f:=sin(az);//1 0}
   TexRotX.Value:=round(ax*180/pi);
   TexRotY.Value:=round(ay*180/pi);
   TexRotZ.Value:=round(az*180/pi);
   TexScaleX.Value:=1/sx;
   TexScaleY.Value:=1/sy;
   TexMoveX.Value:=Matrix[k,1,4];
   TexMoveY.Value:=Matrix[k,2,4];
end;

MatRefresh:=false;
end;

procedure TForm1.AddTextureClick(Sender: TObject);
begin
AddTextureToList(ts_AddTex,'');
end;

procedure TForm1.RenTextureClick(Sender: TObject);
begin
AddTextureToList(ts_RenTex,'');
end;

procedure TForm1.AddTextureToList(Sender:TTexSend; aText:string);
var i,k,ID:integer;
  st:array[1..256]of string; t1,t2,t3:boolean;
  gr:array[1..256]of byte;
  TexString:string;
begin
if Qty.TexturesFiles>=256 then begin
MessageBox(Form1.Handle, 'WR2 can''t handle more than 256 textures in scenery.', 'Info', MB_OK or MB_ICONINFORMATION);
exit; end;

ID:=ListTextures.ItemIndex+1;
if Sender=ts_RenTex then if ID=0 then begin
MessageBox(Form1.Handle, 'Please select texture to rename first.', 'Info', MB_OK or MB_ICONINFORMATION);
exit; end;

if (Sender=ts_AddTex)and(aText='') then TexString:=InputBox('Add texture','Texture name:','');
if (Sender=ts_AddTex)and(aText<>'') then TexString:=aText;
if Sender=ts_RenTex then TexString:=InputBox('Rename texture','Texture name:',TexName[ID]);
if Sender=ts_RenTex then ListTextures.Items[ID-1]:=TexString;

if aText='' then
for i:=1 to Qty.TexturesFiles do
if (TexString='')or(TexName[i]=TexString) then begin
MessageBox(Form1.Handle, PChar('Texture "'+TexString+'" already exists.'), 'Info', MB_OK or MB_ICONINFORMATION);
exit; end;

for i:=1 to Qty.TexturesFiles do st[i]:=TexName[i];
for i:=1 to Qty.TexturesFiles do gr[i]:=Tex2Ground[i];
if Sender=ts_RenTex then st[ID]:=TexString;
ListTextures.Sorted:=true;
if Sender=ts_AddTex then inc(Qty.TexturesFiles);
if Sender=ts_AddTex then ListTextures.Items.Add(TexString);
if Sender=ts_AddTex then st[Qty.TexturesFiles]:=TexString;
if Sender=ts_AddTex then gr[Qty.TexturesFiles]:=0;
ListTextures.Sorted:=false;
for i:=1 to Qty.TexturesFiles do TexName[i]:=ListTextures.Items[i-1];

//reassign IDs used by Materials
for i:=1 to Qty.Materials do begin
t1:=true; t2:=true; t3:=true;
    for k:=1 to Qty.TexturesFiles do begin
    if (st[Material[i].Tex1+1]=TexName[k])and(t1) then begin
    Material[i].Tex1:=k-1; t1:=false; end;
    if (st[Material[i].Tex2+1]=TexName[k])and(t2) then begin
    Material[i].Tex2:=k-1; t2:=false; end;
    if (st[Material[i].Tex3+1]=TexName[k])and(t3) then begin
    Material[i].Tex3:=k-1; t3:=false; end;
    end; //1..Qty.TexturesFiles
end; //1..Qty.Materials

for i:=1 to Qty.TexturesFiles do
for k:=1 to Qty.TexturesFiles do
if TexName[i]=st[k] then Tex2Ground[i]:=gr[k];

list_tx:=0;

if aText='' then SendQADtoUI(apTextures);
for i:=1 to Qty.TexturesFiles do if TexString=ListTextures.Items[i-1] then
ListTextures.ItemIndex:=i-1;
ListTexturesClick(nil);
Changes.QAD:=true;
end;

procedure TForm1.RemTextureClick(Sender: TObject);
var i,ID:integer;
begin
if Qty.TexturesFiles=1 then begin
MessageBox(Form1.Handle, 'Can''t remove last texture. At least one should remain.', 'Info', MB_OK or MB_ICONINFORMATION);
exit; end;

ID:=ListTextures.ItemIndex+1;
if ID=0 then exit;
ListTextures.Items.Delete(ListTextures.ItemIndex);
for i:=1 to Qty.Materials do begin
if Material[i].Tex1+1=ID then Material[i].Tex1:=0;
if Material[i].Tex2+1=ID then Material[i].Tex2:=0;
if Material[i].Tex3+1=ID then Material[i].Tex3:=0;
if Material[i].Tex1+1>ID then dec(Material[i].Tex1);
if Material[i].Tex2+1>ID then dec(Material[i].Tex2);
if Material[i].Tex3+1>ID then dec(Material[i].Tex3);
end;
dec(Qty.TexturesFiles);
for i:=1 to Qty.TexturesFiles do TexName[i]:=ListTextures.Items[i-1];

for i:=ID to Qty.TexturesFiles do Tex2Ground[i]:=Tex2Ground[i+1];

list_tx:=ID;
if Sender<>nil then SendQADtoUI(apTextures); //Internal senders should not repaint whole list
ListTextures.ItemIndex:=EnsureRange(ID-1,0,Qty.TexturesFiles-1);
Changes.QAD:=true;
end;

procedure TForm1.ImportTexturesClick(Sender: TObject);
var
  ft:textfile;
  ii,kk:integer;
  ID:word;
  s:string;
begin
  if AutoImportTexturesList<>'' then
    OpenDialog.FileName:=AutoImportTexturesList
  else
  if not RunOpenDialog(OpenDialog,'',SceneryPath,'Textures list (TexturesAssignList.dat)|*.dat') then exit;
  AutoImportTexturesList:='';

assignfile(ft,OpenDialog.FileName); reset(ft);
ii:=0;
repeat
inc(ii);
readln(ft,s);
readln(ft,ID);
for kk:=1 to Qty.TexturesFiles do if TexName[kk]=s then Tex2Ground[kk]:=ID;
until((ii=256)or(eof(ft)));
closefile(ft);
//Qty.TexturesFiles:=ii;
SendQADtoUI(apTextures);
//CompileLoaded('Textures',1,Qty.TexturesFiles);
Changes.QAD:=true;
end;

procedure TForm1.ExportTexturesListClick(Sender: TObject);
var
  ft:textfile;
  ii:integer;
begin
if not RunSaveDialog(SaveDialog,Scenery+'_'+SceneryVersion+'_TexturesAssignList.dat',
       SceneryPath,'Textures list (TexturesAssignList.dat)|*.dat') then exit;
assignfile(ft,SaveDialog.FileName); rewrite(ft);
for ii:=1 to Qty.TexturesFiles do begin
writeln(ft,TexName[ii]);
writeln(ft,Tex2Ground[ii]);
end;
closefile(ft);
end;

procedure TForm1.SwitchMBWRVerticeColors1Click(Sender: TObject);
var i:integer;
begin
for i:=1 to VTXQty[64] do VTX[i].BlendR:=VTX[i].BlendG; //123 223
list_id:=0;
Changes.VTX:=true;
end;

procedure TForm1.SwitchC11_VCol(Sender: TObject);
var i:integer; //t:array[0..256,0..256]of integer;
begin
//for i:=0 to 256 do for k:=0 to 256 do t[i,k]:=0;
for i:=1 to VTXQty[64] do begin //123 112
//inc(t[0,VTX[i].Blend2]);
//if VTX[i].Blend2=184 then dec(VTX[i].Blend2,71);
VTX[i].BlendB:=VTX[i].BlendG;
VTX[i].BlendG:=VTX[i].BlendR;
end; //t[64,64]:=1;
list_id:=0;
Changes.VTX:=true;
end;

procedure TForm1.SwitchVerticeColors2Click(Sender: TObject);
var i,t:integer;
begin
for i:=1 to VTXQty[64] do begin
t:=VTX[i].BlendB;
VTX[i].BlendB:=VTX[i].BlendR;
VTX[i].BlendR:=VTX[i].BlendG;
VTX[i].BlendG:=t;
end;
list_id:=0;
Changes.VTX:=true;
end;

procedure TForm1.CBTraceMatClick(Sender: TObject);
var ii,ID:integer;
begin
ID:=ListMaterials.ItemIndex+1;
if ID=0 then exit;
for ii:=1 to Qty.TexturesTotal do if (v07[ii].SurfaceID+1 =ID) then begin
xPos:=VTX[v[v07[ii].FirstPoly+1,1]].X/1;
yPos:=VTX[v[v07[ii].FirstPoly+1,1]].Y/1;
zPos:=VTX[v[v07[ii].FirstPoly+1,1]].Z/1;
exit;
end;
end;

procedure TForm1.ListSoundsClick(Sender: TObject);
var ID:integer;
begin
SoundsRefresh:=true;
ID:=ListSounds.ItemIndex;
fOptions.TraceSurface:=(ID=0);
if ID<>0 then begin
EditSoundName.Text:=Sound[ID].Name;
SoundPosX.Value:=Sound[ID].X;
SoundPosY.Value:=Sound[ID].Y;
SoundPosZ.Value:=Sound[ID].Z;
SoundVolume.Value:=Sound[ID].Volume;
SoundPlaySpeed.Value:=Sound[ID].PlaySpeed;
SoundRadius.Value:=Sound[ID].Radius*10;
SoundX4.ItemIndex:=Sound[ID].z4;
SoundX5.Value:=Sound[ID].z5;
SoundX6.Value:=Sound[ID].Delay/10;
end else begin
SoundPosX.Value:=0;
SoundPosY.Value:=0;
SoundPosZ.Value:=0;
end;
SoundsRefresh:=false;
end;

procedure TForm1.ListSoundsDblClick(Sender: TObject);
var ID:integer;
begin
ID:=ListSounds.ItemIndex;
xPos:=Sound[ID].X;
yPos:=Sound[ID].Y;
zPos:=Sound[ID].Z;
  //todo: sndPlaySound(@(WorkDir+'Sounds\'+Sound[ListSounds.ItemIndex].Name+'.wav')[1],SND_NODEFAULT or SND_ASYNC);
end;

procedure TForm1.SoundsChange(Sender: TObject);
var ID:integer;
begin
if SoundsRefresh then exit;
ID:=ListSounds.ItemIndex;
if ID=-1 then exit;
if ID>0 then begin
  Sound[ID].Name:=EditSoundName.Text;
  if Sender=EditSoundName then ListSounds.Items[ID]:=inttostr(ID)+'. '+Sound[ID].Name; //renaming on-the-fly
  Sound[ID].X:=SoundPosX.Value;
  Sound[ID].Y:=SoundPosY.Value;
  Sound[ID].Z:=SoundPosZ.Value;
  Sound[ID].Volume:=SoundVolume.Value;
  Sound[ID].PlaySpeed:=SoundPlaySpeed.Value;
  Sound[ID].Radius:=SoundRadius.Value div 10;
  Sound[ID].z4:=EnsureRange(SoundX4.ItemIndex,0,3);
  Sound[ID].z5:=SoundX5.Value;
  Sound[ID].Delay:=round(SoundX6.Value*10);
  Sound[ID].misc:=#0+#0+#0+#0+#0+#0+#0+#0+#0+#0+#0+#0; //empty by default
  xPos:=Sound[ID].X;
  yPos:=Sound[ID].Y;
  zPos:=Sound[ID].Z;
end else begin
  SoundPosX.Value:=0;
  SoundPosY.Value:=0;
  SoundPosZ.Value:=0;
end;
Changes.QAD:=true;
end;

procedure TForm1.AddSoundClick(Sender: TObject);
begin
SoundsRefresh:=true;
inc(Qty.Sounds);
ListSounds.Items.Add('placeholder'); //would be renamed later on
ListSounds.ItemIndex:=Qty.Sounds;
SoundsRefresh:=false;
SoundsChange(EditSoundName); //fill new sound object with data from display
Changes.QAD:=true;
end;

procedure TForm1.RemSoundClick(Sender: TObject);
var i,ID:integer;
begin
ID:=ListSounds.ItemIndex;
if ID<1 then exit;
SoundsRefresh:=true;
ListSounds.Items.Delete(ListSounds.ItemIndex);
dec(Qty.Sounds);
for i:=ID to Qty.Sounds do Sound[i]:=Sound[i+1];
SoundsRefresh:=false;
ListSounds.ItemIndex:=EnsureRange(ID,1,Qty.Sounds);
ListSoundsClick(nil);
Changes.QAD:=true;
end;

procedure TForm1.ResetViewClick(Sender: TObject);
begin
  if yRot=270 then begin
    xPos:=0;
    yPos:=-1000;
    zPos:=0;
    Zoom:=0.256;
  end;
  xRot:=0;
  yRot:=270;
end;


procedure TForm1.PageControl1Change(Sender: TObject);
begin
  case PageControl1.ActivePageIndex of
    0: ActivePage := apLWO;
    1: ActivePage := apGrounds;
    2: ActivePage := apTextures;
    3: ActivePage := apMaterials;
    4: ActivePage := apObjects;
    5: ActivePage := apSounds;
    6: ActivePage := apLights;
    7: ActivePage := apStructure;
    8: if TRKProperty.ActivePage.Caption = 'Make track' then        ActivePage := apTracksMT else
       if TRKProperty.ActivePage.Caption = 'Direction arrows' then  ActivePage := apTracksAR else
       if TRKProperty.ActivePage.Caption = 'Waypoint nodes' then    ActivePage := apTracksWP else
       Assert(false, 'TRK Property page control captions are wrong!');
    9: ActivePage := apTOB;
    10:ActivePage := apStreets;
    11:ActivePage := apAnimated;
    12:ActivePage := apSky;
    13:ActivePage := apGrass;
    14:ActivePage := apTriggers;
    15:ActivePage := apAddonInfo;
  end;
  SendQADtoUI(ActivePage); //?
  StatusBar1.Panels[4].Text := PageCaption[ActivePage];
  StatusBar1.Panels[5].Text := ReturnListOfChangedFiles(', ');
end;


procedure TForm1.ListTexturesClick(Sender: TObject);
var ID:integer;
begin
TexListRefresh:=true;
ID:=ListTextures.ItemIndex+1;
if ID=0 then exit;
RGTexMat.ItemIndex:=Tex2Ground[ID];
CBTexGrass.Checked:=TextureW[ID].GrowGrass=1;
TexListRefresh:=false;
end;

procedure TForm1.ListDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var BlRect,MyRect,InRect1,InRect2:TRect; MyColor:TColor; ID:integer;
begin
ID:=Index+1;
MyRect:=Rect;

MyRect.Left:=1; MyRect.Right:=14;
inc(MyRect.Top); dec(MyRect.Bottom,2);

BlRect:=MyRect;
inc(BlRect.Bottom,2);

InRect1:=MyRect;
inc(InRect1.Left,3); dec(InRect1.Right,3);
inc(InRect1.Top,2);  dec(InRect1.Bottom,2);

InRect2:=MyRect;
inc(InRect2.Left,4); dec(InRect2.Right,4);
inc(InRect2.Top,3);  dec(InRect2.Bottom,3);

MyColor:=(Control as TListBox).Canvas.Brush.Color; //Save default color
with (Control as TListBox).Canvas do begin
FillRect(Rect);

if Control.Name='ListMaterials' then begin
  if MaterialW[ID].NoShadow=0 then Brush.Color:=$00 else Brush.Color:=$FFFFFF;
  FillRect(BlRect);
end;

if Control.Name='ListLights' then      Brush.Color:=Light[ID].R+Light[ID].G*256+Light[ID].B*65536;
if Control.Name='ListTextures' then    Brush.Color:=GetPresetColor(Tex2Ground[ID]+1);
if Control.Name='ListMaterials' then   Brush.Color:=GetPresetColor(Material[ID].Mode div 16 +1);
if Control.Name='ListSNIObjects' then  Brush.Color:=GetPresetColor(ID);
if Control.Name='ListStreetShape' then Brush.Color:=GetPresetColor(ID);

FillRect(MyRect);

if ((Control.Name='ListMaterials')and(MaterialW[ID].GrowGrass=1))or
   ((Control.Name='ListTextures')and(TextureW[ID].GrowGrass=1)) then begin
  Brush.Color:=128*256; //dark-green
  FillRect(InRect1);
end;

if Control.Name='ListMaterials' then if MaterialW[ID].Enlite=1 then begin
  Brush.Color:=$FFFFFF; //white
  FillRect(InRect2);
end;

Brush.Color:=MyColor;
TextOut(MyRect.Right+4,Rect.Top,(Control as TListBox).Items[Index]);
end;
end;

procedure TForm1.RGTexMatClick(Sender: TObject);
var ID:integer;
begin
if TexListRefresh then exit;
ID:=ListTextures.ItemIndex+1;
if ID=0 then exit;
Tex2Ground[ID]:=RGTexMat.ItemIndex;
TextureW[ID].GrowGrass:=byte(CBTexGrass.Checked);
ListTextures.Refresh;
Changes.QAD:=true;
Changes.WRK:=true;
end;

procedure TForm1.ExportSoundsClick(Sender: TObject);
var
  f:file;
  ii:integer;
begin
if not RunSaveDialog(SaveDialog,Scenery+'_'+SceneryVersion+'_SoundsList.dat',
       SceneryPath,'Sounds list (SoundsList.dat)|*.dat') then exit;
assignfile(f,SaveDialog.FileName); rewrite(f,1);
blockwrite(f,'STKit2'+#0+#0,8);    //Name
blockwrite(f,Qty.Sounds,4);    //Name
for ii:=1 to Qty.Sounds do begin
blockwrite(f,chr2(Sound[ii].Name,32)[1],32);//Name
blockwrite(f,Sound[ii].X,12);           //XYZ
blockwrite(f,Sound[ii].Volume,24);      //etc..
end;
closefile(f);
end;

procedure TForm1.ImportSoundsClick(Sender: TObject);
var
  f:file;
  ii:integer; ss:string;
begin
if not RunOpenDialog(OpenDialog,'',SceneryPath,'Sounds list (SoundsList.dat)|*.dat') then exit;
assignfile(f,OpenDialog.FileName); reset(f,1);

blockread(f,c,8); ss:=c[1]+c[2]+c[3]+c[4]+c[5]+c[6]+c[7]+c[8];
if ss<>'STKit2'+#0+#0 then begin
MessageBox(Form1.Handle, 'Unknown version.', 'Error', MB_OK or MB_ICONERROR);
closefile(f);
exit;
end;

blockread(f,Qty.Sounds,4);    //Name
for ii:=1 to Qty.Sounds do begin
blockread(f,c,32); Sound[ii].Name:=StrPas(@c);//Name
blockread(f,Sound[ii].X,12);           //XYZ
blockread(f,Sound[ii].Volume,24);      //etc..
end;
closefile(f);
SendQADtoUI(apSounds);
Changes.QAD:=true;
end;

procedure TForm1.ListGroundsClick(Sender: TObject);
var ID:integer;
begin
  GroundsRefresh := true;

  ID := ListGrounds.ItemIndex + 1;
  if ID=0 then exit;

  SpinEdit1.Value   :=Ground[ID].Dirt;
  SE_GripF.Value    :=Ground[ID].GripF;
  SE_GripR.Value    :=Ground[ID].GripR;
  SpinEdit4.Value   :=Ground[ID].Stick;
  Gr_Noise.ItemIndex  :=EnsureRange(Ground[ID].NoiseID,0,3);
  GR_Skid.ItemIndex   :=EnsureRange(Ground[ID].SkidID,0,3);
  Gr_NoColli.Checked  :=Ground[ID].NoColliFlag=1;
  Gr_Unknown.ItemIndex:=EnsureRange(Ground[ID].x8,0,3);

  GroundsRefresh := false;
end;

procedure TForm1.GroundsChange(Sender: TObject);
var ID:integer;
begin
  if GroundsRefresh then exit;

  ID := ListGrounds.ItemIndex + 1;
  if ID=0 then exit;

  ListGrounds.Items[ID-1]:=Ground[ID].Name; //renaming on-the-fly
  Ground[ID].Dirt   := SpinEdit1.Value;
  Ground[ID].GripF  := SE_GripF.Value;
  Ground[ID].GripR  := SE_GripR.Value;
  Ground[ID].Stick  := SpinEdit4.Value;
  Ground[ID].NoiseID  := EnsureRange(Gr_Noise.ItemIndex,0,Gr_Noise.Items.Count-1);
  Ground[ID].SkidID   := EnsureRange(GR_Skid.ItemIndex,0,GR_Skid.Items.Count-1);
  Ground[ID].NoColliFlag  := ord(Gr_NoColli.Checked);
  Ground[ID].x8 := EnsureRange(Gr_Unknown.ItemIndex,0,Gr_Unknown.Items.Count-1);

  Changes.QAD := true;
end;


procedure TForm1.AddGroundClick(Sender: TObject);
var ss:string;
begin
  if Qty.GroundTypes=MaxGrounds then begin
    MessageBox(Form1.Handle, PChar('Number of grounds limited to - '+inttostr(MaxGrounds)), 'Info', MB_OK or MB_ICONINFORMATION);
    exit;
  end;

  ss := InputBox('New Ground','Ground name','');
  if ss='' then begin
    MessageBox(Form1.Handle, 'Please input new ground name.', 'Info', MB_OK or MB_ICONINFORMATION);
    exit;
  end;

  inc(Qty.GroundTypes);
  GroundsRefresh := true;
  Ground[Qty.GroundTypes].Name  := ss;
  Ground[Qty.GroundTypes].GripF := 100;
  Ground[Qty.GroundTypes].GripR := 100;
  Ground[Qty.GroundTypes].NoColliFlag := 0;
  Ground[Qty.GroundTypes].x8    := 0;
  ListGrounds.Items.Add(ss);
  ListGrounds.ItemIndex := Qty.GroundTypes-1;
  ListGroundsClick(nil);
  GroundsRefresh := false;
  Changes.QAD := true;
end;


procedure TForm1.RemGroundClick(Sender: TObject);
var i,ID:integer;
begin
  ID := ListGrounds.ItemIndex+1;

  if ID=0 then begin
    MessageBox(Form1.Handle, 'Please select item to remove.', 'Info', MB_OK or MB_ICONINFORMATION);
    exit;
  end;

  if Qty.GroundTypes=1 then begin
    MessageBox(Form1.Handle, 'At least one ground should remain.', 'Info', MB_OK or MB_ICONINFORMATION);
    exit;
  end;

  dec(Qty.GroundTypes);
  for i:=ID to Qty.GroundTypes do
    Ground[i]:=Ground[i+1];

  SendQADtoUI(apGrounds);
  ListGrounds.ItemIndex := EnsureRange(ID,1,Qty.GroundTypes)-1;
  ListGroundsClick(nil);

  for i:=1 to Qty.TexturesFiles do
    if Tex2Ground[i]=ID-1 then
      dec(Tex2Ground[i]) //could assign any ground assignment here
    else
      if Tex2Ground[i]>ID-1 then
        dec(Tex2Ground[i]);

  Changes.QAD := true;
end;


procedure TForm1.RenGroundClick(Sender: TObject);
var ID:integer;
begin
  ID := ListGrounds.ItemIndex+1;

  if ID = 0 then begin
    MessageBox(Form1.Handle, 'Please select item to rename.', 'Info', MB_OK or MB_ICONINFORMATION);
    exit;
  end;

  Ground[ID].Name := InputBox('Rename ground','Set new name',Ground[ID].Name);
  ListGrounds.Items[ID-1] := Ground[ID].Name;
  Changes.QAD := true;
end;


procedure TForm1.ListTOBChange(Sender: TObject);
var i:integer;
begin
  if TrackID=0 then exit;
  ListTOB2.Clear;
  for i:=1 to TOBHead[TrackID].Qty do
    ListTOB2.Items.Add(inttostr(i)+'. '+ObjName[TOB[TrackID,i].ID+1]);
end;


procedure TForm1.ListTOB2Click(Sender: TObject);
var ID,ID2:integer; a,b,c:integer;
begin
if TrackID=0 then exit;
TOBRefresh:=true;
ID:=TrackID;
ID2:=ListTOB2.ItemIndex+1;
ListObjectsTOB.ItemIndex:=TOB[ID,ID2].ID;
TOB_X.Value:=TOB[ID,ID2].X;
TOB_Y.Value:=TOB[ID,ID2].Y;
TOB_Z.Value:=TOB[ID,ID2].Z;
TOB_A.Value:=TOB[ID,ID2].A;
TOB_B.Value:=TOB[ID,ID2].B;
Matrix2Angles(TOB[ID,ID2].M,9,@a,@b,@c);
TOB_R1.Value:=a;
TOB_R2.Value:=b;
TOB_R3.Value:=c;
TOBRefresh:=false;
end;

procedure TForm1.ListTOB2DblClick(Sender: TObject);
var ID,ID2:integer;
begin
if TrackID=0 then exit;
ID:=TrackID;
ID2:=ListTOB2.ItemIndex+1;
xPos:=TOB[ID,ID2].X;
yPos:=TOB[ID,ID2].Y;
zPos:=TOB[ID,ID2].Z;
end;

procedure TForm1.TOB_Change(Sender: TObject);
var ID,ID2:integer;
begin
if TrackID=0 then exit;
if TOBRefresh then exit;
if ListTOB2.ItemIndex<0 then exit;
ID:=TrackID;
ID2:=ListTOB2.ItemIndex+1;
TOB[ID,ID2].ID:=ListObjectsTOB.ItemIndex;
//if Sender=ListObjectsTOB then EditTOBName.Text:=ObjName[TOB[ID,ID2].ID+1];
TOB[ID,ID2].Name:=ObjName[TOB[ID,ID2].ID+1];
if Sender=ListObjectsTOB then ListTOB2.Items[ID2-1]:=
inttostr(ID2)+'. '+TOB[ID,ID2].Name; //renaming on-the-fly
TOB[ID,ID2].X:=TOB_X.Value;
TOB[ID,ID2].Y:=TOB_Y.Value;
TOB[ID,ID2].Z:=TOB_Z.Value;
TOB[ID,ID2].R1:=TOB_R1.Value;//Updating for render unit
TOB[ID,ID2].R2:=TOB_R2.Value;//Updating for render unit
TOB[ID,ID2].R3:=TOB_R3.Value;//Updating for render unit
Angles2Matrix(TOB_R1.Value,TOB_R2.Value,TOB_R3.Value,@TOB[ID,ID2].M,9);
xPos:=TOB[ID,ID2].X;
yPos:=TOB[ID,ID2].Y;
zPos:=TOB[ID,ID2].Z;
Changes.TOB[ID]:=true;
end;

procedure TForm1.AddTOBClick(Sender: TObject);
var ID:integer;
begin
if TrackID=0 then exit;
TOBRefresh:=true;
ID:=TrackID;
inc(TOBHead[ID].Qty);
ListTOB2.Items.Add('new');
ListTOB2.ItemIndex:=TOBHead[ID].Qty-1;
setlength(TOB[ID],TOBHead[ID].Qty+1);
TOBRefresh:=false;
TOB_Change(ListObjectsTOB); //fill new object with data from display
Changes.TOB[ID]:=true;      //Set sender to rename object in place
end;

procedure TForm1.RemTOBClick(Sender: TObject);
var i,ID,ID2:integer;
begin
if TrackID=0 then exit;
if TOBRefresh then exit;
if ListTOB2.ItemIndex<0 then exit;
ID:=TrackID;
ID2:=ListTOB2.ItemIndex+1;
TOBRefresh:=true;
ListTOB2.Items.Delete(ListTOB2.ItemIndex);
dec(TOBHead[ID].Qty);
for i:=ID2 to TOBHead[ID].Qty do TOB[ID,i]:=TOB[ID,i+1];
TOBRefresh:=false;
ListTOB2.ItemIndex:=EnsureRange(ID2,1,TOBHead[ID].Qty)-1;
ListTOB2Click(nil);
Changes.TOB[ID]:=true;
end;


procedure TForm1.ListSNINodesClick(Sender: TObject);
var ID,ID2:integer;
begin
SNINodesRefresh:=true;
ID:=ListSNIObjects.ItemIndex+1; if ID=0 then exit;
ID2:=ListSNINodes.ItemIndex+1;  if ID2=0 then exit;
SNI_Node_X.Value:=SNINode[SNIObj[ID].firstNode+ID2].X;
SNI_Node_Y.Value:=SNINode[SNIObj[ID].firstNode+ID2].Y;
SNI_Node_Z.Value:=SNINode[SNIObj[ID].firstNode+ID2].Z;
SNI_Node_Speed.Value:=SNINode[SNIObj[ID].firstNode+ID2].Speed;
SNI_Node_B.Value:=SNINode[SNIObj[ID].firstNode+ID2].B;
SNINodesRefresh:=false;
end;


procedure TForm1.ListSNINodesDblClick(Sender: TObject);
var ID,ID2:integer;
begin
ID:=ListSNIObjects.ItemIndex+1; if ID=0 then exit;
ID2:=ListSNINodes.ItemIndex+1;  if ID2=0 then exit;
xPos:=SNINode[SNIObj[ID].firstNode+ID2].X;
yPos:=SNINode[SNIObj[ID].firstNode+ID2].Y;
zPos:=SNINode[SNIObj[ID].firstNode+ID2].Z;
end;


procedure TForm1.ObjChangeInstance(Sender: TObject);
var ID:integer; ss:string;
begin
if ObjInstanceRefresh then exit;
if ListObjects2.ItemIndex=-1 then exit;
ss:=ListObjects2.Items[ListObjects2.ItemIndex];
decs(ss,-length(ss)+4);
ID:=strtoint(ss);
if ID<>EnsureRange(ID,1,Qty.ObjectsTotal) then exit;
Obj[ID].ID:=ListObjectsInstances.ItemIndex;
Obj[ID].Name:=ObjName[Obj[ID].ID+1];
Obj[ID].PosX:=ObjX.Value;
Obj[ID].PosY:=ObjY.Value;
Obj[ID].PosZ:=ObjZ.Value;
Obj[ID].Angl:=ObjAngl.Value/180*pi;
Obj[ID].Size:=ObjSize.Value;
if ObjInShadow.Checked then Obj[ID].InShadow:=1 else Obj[ID].InShadow:=0;
  if Sender=ListObjectsInstances then begin
    ListObjects.ItemIndex:=ListObjectsInstances.ItemIndex;
    ListObjectsClick(nil);
  end;
Changes.QAD:=true;
end;


procedure TForm1.AddObjectClick(Sender: TObject);
begin
AddNewObject(InputBox('Add object','Object name:',''),true);
end;

procedure TForm1.AddNewObject(TexString:string; ErrorReport:boolean);
var i,k,newID:integer;
begin
//if Sender=RenObject then TexString:=InputBox('Rename object','Object name:',ObjName[ID]);

if length(TexString)<=2 then begin
if ErrorReport then MessageBox(Form1.Handle, 'Object name should be at least 3 characters long.', 'Error', MB_OK or MB_ICONERROR);
exit; end;

for i:=1 to Qty.ObjectFiles do if uppercase(TexString)=uppercase(ObjName[i]) then begin
if ErrorReport then MessageBox(Form1.Handle, 'This object name already exists.', 'Error', MB_OK or MB_ICONERROR);
exit; end;

TexString:=UpperCase(TexString[1])+LowerCase(decs(TexString,-1,0));

i:=0;
if TexString[1]+TexString[2]<>'T\' then begin
repeat inc(i); until((i>Qty.ObjectFiles)or(TexString<ObjName[i])or(ObjName[i,1]+ObjName[i,2]='T\'));
end else begin //T\
TexString:='T\'+UpperCase(TexString[3])+LowerCase(decs(TexString,-3,0));
repeat inc(i); until((i>Qty.ObjectFiles)or((TexString<ObjName[i])and(ObjName[i,1]+ObjName[i,2]='T\')));
end;

newID:=i; //is the right ID of new object

//List (temporary placeholder)
ListObjects.Items.Insert(newID-1,TexString);

//Object list
for i:=Qty.ObjectFiles downto newID do begin
ObjName[i+1]:=ObjName[i];
ObjProp[i+1]:=ObjProp[i];
ObjCall[i+1]:=ObjCall[i];
ObjTex[i+1]:=ObjTex[i];
end;

begin
CompileLoaded('Objects',newID,1);
ObjName[newID]:=TexString;
if TexString[1]+TexString[2]='T\' then ObjProp[newID].Mode:=16 else
ObjProp[newID].Mode:=0;
ObjProp[newID].Shape:=0;
ObjProp[newID].Weight:=0;
//ObjProp[newID].p4:=
//ObjProp[newID].x1:=
//ObjProp[newID].x2:=
//ObjProp[newID].x3:=
ObjProp[newID].HitSound:='';
ObjProp[newID].FallSound:='';
end;

//Objects instances
for i:=1 to Qty.ObjectsTotal do
if Obj[i].ID+1>=newID then begin
inc(Obj[i].ID);
//Obj[i]:=
//Obj[i].Name:=ObjName[Obj[i].ID+1];
end;

//Objects in TOB
for i:=1 to 32 do for k:=1 to TOBHead[i].Qty do
if TOB[i,k].ID+1>=newID then begin inc(TOB[i,k].ID); Changes.TOB[i]:=true; end;

//Objects in SNI
for i:=1 to SNIHead.Obj do
if SNIObj[i].ObjID+1>=newID then
inc(SNIObj[i].ObjID);
Changes.SNI:=true;
Changes.WRK:=true;

inc(Qty.ObjectFiles);
SendQADtoUI(apObjects);
ListObjects.ItemIndex:=newID-1;
ListObjectsClick(nil);
Changes.QAD:=true;
end;

procedure TForm1.ObjChange(Sender: TObject);
var ID:integer;
begin
if ObjectsRefresh then exit;
ID:=ListObjects.ItemIndex+1;
if ID=0 then exit;
ObjProp[ID].Mode:=ObjTypes1[CBObjMode.ItemIndex];
ObjProp[ID].Shape:=CBObjShape.ItemIndex;
ListObjects.Items[ID-1]:=ObjName[ID]+' '+inttostr(ObjProp[ID].Mode)+' '+inttostr(ObjProp[ID].Shape); //renaming on-the-fly
ObjProp[ID].Weight:=ObjWeight.Value;
ObjProp[ID].p4:=0;
ObjProp[ID].x1:=0;
ObjProp[ID].x2:=0;
ObjProp[ID].x3:=0;
ObjProp[ID].HitSound:=ObjHit.Text;
ObjProp[ID].FallSound:=ObjFall.Text;
Changes.QAD:=true;
end;

procedure TForm1.RemakeQADTable(Sender: TObject);
var i,k,x,z,q1,q2:integer;
begin
  for k:=1 to Qty.BlocksZ do for i:=1 to Qty.BlocksX do begin
  Block[k,i].FirstObj:=0;
  Block[k,i].NumObj:=0;
  Block[k,i].FirstLight:=0;
  Block[k,i].NumLight:=0;
  end;

  for i:=1 to Qty.ObjectsTotal do begin
  x:=trunc((Obj[i].PosX+512*Qty.BlocksX)/1024)+1;
  z:=trunc((Obj[i].PosZ+512*Qty.BlocksZ)/1024)+1;
  x:=EnsureRange(x,1,Qty.BlocksX);
  z:=EnsureRange(z,1,Qty.BlocksZ);
  Obj[i].Name:=ObjName[Obj[i].ID+1];
  ObjW[i].ParentBlock:=(z-1)*Qty.BlocksX+x;
  inc(Block[z,x].NumObj);
  end;

  for i:=1 to Qty.Lights do begin
  x:=trunc((Light[i].Matrix2[13]+512*Qty.BlocksX)/1024)+1;
  z:=trunc((Light[i].Matrix2[15]+512*Qty.BlocksZ)/1024)+1;
  x:=EnsureRange(x,1,Qty.BlocksX);
  z:=EnsureRange(z,1,Qty.BlocksZ);
  LightW[i].ParentBlock:=(z-1)*Qty.BlocksX+x;
  inc(Block[z,x].NumLight);
  end;

  q1:=0; q2:=0;
  for k:=1 to Qty.BlocksZ do for i:=1 to Qty.BlocksX do begin
    if Block[k,i].NumObj=0 then
    Block[k,i].FirstObj:=-1 else begin
    Block[k,i].FirstObj:=q1;
    inc(q1,Block[k,i].NumObj);
    end;
    if Block[k,i].NumLight=0 then
    Block[k,i].FirstLight:=-1 else begin
    Block[k,i].FirstLight:=q2;
    inc(q2,Block[k,i].NumLight);
    end;
  end;
end;

procedure TForm1.RemObjInstanceClick(Sender: TObject);
var ss:string; i,ID,ID2:integer;
begin
ID2:=ListObjects2.ItemIndex+1;
if ID2=0 then exit;
ss:=ListObjects2.Items[ID2-1];
decs(ss,-length(ss)+4);
ID:=strtoint(ss);
for i:=ID to Qty.ObjectsTotal-1 do //shift up
Obj[i]:=Obj[i+1];
dec(Qty.ObjectsTotal);
ListObjects2.Items.Delete(ListObjects2.ItemIndex);
ListObjects2.ItemIndex:=EnsureRange(ID2,1,ListObjects2.Count)-1;
RemakeQADTable(nil); //Rebuild objects
Changes.QAD:=true;
end;

procedure TForm1.AddObjInstanceClick(Sender: TObject);
var i,ID:integer;
begin
//Appending object instance to the end, Objects get regrouped upon QAD save
ID:=ListObjects.ItemIndex+1;
if ID=0 then exit;
inc(Qty.ObjectsTotal);
i:=Qty.ObjectsTotal;
Obj[i].ID:=ID-1;
Obj[i].Name:=ObjName[ID];
Obj[i].PosX:=xPos;
Obj[i].PosY:=yPos;
Obj[i].PosZ:=zPos;
Obj[i].Angl:=0;
Obj[i].Size:=1;
ObjW[i].ParentBlock:=0;

ListObjects2.Items.Add(Obj[i].Name+' #'+inttostr(0)+' ID='+int2fix(i,4));
ListObjects2.ItemIndex:=ListObjects2.Items.Count-1; //Set focus to new object
ListObjects2Click(nil);
RemakeQADTable(nil); //Rebuild objects
Changes.QAD:=true;
end;

procedure TForm1.ObjectsSNIChange(Sender: TObject);
var ID:integer;
begin
if SNIRefresh then exit;
ID:=ListSNIObjects.ItemIndex+1;
if ID=0 then exit;

SNIObj[ID].objID:=ListObjectsSNI.ItemIndex;
SNIObj[ID].Mode:=CBSNIMode.ItemIndex;

EditSNISound.Enabled:=SNIObj[ID].Mode<5;
Label93.Enabled:=SNIObj[ID].Mode<5;
if SNIObj[ID].Mode<5 then begin
Label53.Caption:='Volume';
Label54.Caption:='Tempo, %';
Label55.Caption:='Radius, m';
Label33.Caption:='Unknown';
end else begin
Label53.Caption:='Spacing, m';
Label54.Caption:='Speed, km/h';
Label55.Caption:='Turbulence, m';
Label33.Caption:='Parent track ID';
end;
SNISpawnW[ID].Density:=SNIx1.Value;
SNISpawnW[ID].Speed:=SNIx2.Value;
SNISpawnW[ID].Turbulence:=SNIx3.Value;
SNISpawnW[ID].TrackID:=SNIx4.Value;

StrPCopy(@SNIObj[ID].Sound,EditSNISound.Text);

ListSNIObjects.Items[ID-1]:=(ObjName[SNIObj[ID].objID+1]+' ('+StrPas(@SNIObj[ID].Sound)+') '
+inttostr(SNIObj[ID].Mode));

SNIObj[ID].Volume:=SNIx1.Value;
SNIObj[ID].Tempo :=SNIx2.Value;
SNIObj[ID].Radius:=round(SNIx3.Value/10);
SNIObj[ID].x4    :=SNIx4.Value;

CalculateSNIRoutes;

Changes.SNI:=true;
Changes.WRK:=true;
end;

procedure TForm1.CopyInstanceClick(Sender: TObject);
begin
PasteInstance.Enabled:=true;
CopyHolder.X:=ObjX.Value;
CopyHolder.Y:=ObjY.Value;
CopyHolder.Z:=ObjZ.Value;
CopyHolder.Angl:=ObjAngl.Value*pi/180;
CopyHolder.Size:=ObjSize.Value;
end;

procedure TForm1.PasteInstanceClick(Sender: TObject);
var ID:integer; ss:string;
begin
ss:=ListObjects2.Items[ListObjects2.ItemIndex];
decs(ss,-length(ss)+4);
ID:=strtoint(ss);
Obj[ID].PosX:=CopyHolder.X;
Obj[ID].PosY:=CopyHolder.Y;
Obj[ID].PosZ:=CopyHolder.Z;
Obj[ID].Angl:=CopyHolder.Angl;
Obj[ID].Size:=CopyHolder.Size;
ListObjects2Click(nil);
Changes.QAD:=true;
end;

procedure TForm1.Button15Click(Sender: TObject);
var
  f:file;
  ii:integer;
begin
if not RunSaveDialog(SaveDialog,Scenery+'_'+SceneryVersion+'_InstancesList.dat',
       SceneryPath,'Objects list (InstancesList.dat)|*.dat') then exit;

assignfile(f,SaveDialog.FileName); rewrite(f,1);
blockwrite(f,'STKit2'+#0+#0,8);    //Name
blockwrite(f,Qty.ObjectsTotal,4);
for ii:=1 to Qty.ObjectsTotal do begin
blockwrite(f,chr2(Obj[ii].Name,32)[1],32);//Name
blockwrite(f,Obj[ii].ID,68);
end;
closefile(f);
end;

procedure TForm1.Button12Click(Sender: TObject);
var
  f:file;
  ii,kk:integer;
  ss:string;
begin
if not RunOpenDialog(OpenDialog,'',SceneryPath,'Objects list (ObjectsList.dat)|*.dat') then exit;
assignfile(f,OpenDialog.FileName); reset(f,1);

blockread(f,c,8); ss:=c[1]+c[2]+c[3]+c[4]+c[5]+c[6]+c[7]+c[8];
if ss<>('STKit2'+#0+#0) then begin
MessageBox(Form1.Handle, 'Unknown version.', 'Error', MB_OK or MB_ICONERROR);
closefile(f);
exit;
end;
Qty.ObjectFiles:=0;

blockread(f,Qty.ObjectsTotal,4);    //Name
for ii:=1 to Qty.ObjectsTotal do begin
blockread(f,c,32); ss:=StrPas(@c);//Name
if ss='Bagger' then
ss:=ss;
blockread(f,Obj[ii].ID,68);
kk:=0; repeat inc(kk);
until((kk>Qty.ObjectFiles)or(ss=ObjName[kk]));
if kk>Qty.ObjectFiles then AddNewObject(ss,false);
kk:=0; repeat inc(kk);
until((kk>Qty.ObjectFiles)or(ss=ObjName[kk]));
if ss=ObjName[kk] then
Obj[ii].ID:=kk-1;
Obj[ii].Name:=ss; //assign Name only after adding new object, since it alerts Names
end;
closefile(f);
SendQADtoUI(apObjects);
CompileLoaded('Objects',1,Qty.ObjectFiles);
Changes.QAD:=true;
end;

procedure TForm1.ExportGroundsClick(Sender: TObject);
var
  f:file;
  ii:integer;
begin
if not RunSaveDialog(SaveDialog,Scenery+'_'+SceneryVersion+'_GroundsList.dat',
       SceneryPath,'Grounds list (GroundsList.dat)|*.dat') then exit;

assignfile(f,SaveDialog.FileName); rewrite(f,1);
blockwrite(f,'STKit2'+#0+#0,8);
blockwrite(f,Qty.GroundTypes,4);
for ii:=1 to Qty.GroundTypes do begin
blockwrite(f,chr2(Ground[ii].Name,64)[1],64);
blockwrite(f,Ground[ii].Dirt,92);
end;
closefile(f);                                  
end;

procedure TForm1.ImportGroundsClick(Sender: TObject);
var
  f:file;
  ii:integer;
  ss:string;
begin
//if AutoImportGroundsList<>'' then
//OpenDialog.FileName:=AutoImportGroundsList
//else
if not RunOpenDialog(OpenDialog,'',SceneryPath,'Grounds list (GroundsList.dat)|*.dat') then exit;
//AutoImportGroundsList:='';

assignfile(f,OpenDialog.FileName); reset(f,1);

blockread(f,c,8); ss:=c[1]+c[2]+c[3]+c[4]+c[5]+c[6]+c[7]+c[8];
if ss<>'STKit2'+#0+#0 then begin
MessageBox(Form1.Handle, 'Unknown version.', 'Error', MB_OK or MB_ICONERROR);
closefile(f); exit;
end;

blockread(f,Qty.GroundTypes,4);    //Name
for ii:=1 to Qty.GroundTypes do begin
blockread(f,c,64); Ground[ii].Name:=StrPas(@c);//Name
blockread(f,Ground[ii].Dirt,92);
end;
closefile(f);
SendQADtoUI(apGrounds);
Changes.QAD:=true;
end;

procedure TForm1.MBWRLightBlendFix(Sender: TObject);
var i:integer;
begin
for i:=1 to VTXQty[64] do begin
  if SceneryVersion='V1' then begin // DarkBlue Morning
    VTX[i].R:=EnsureRange(VTX[i].R+40,0,255); //This way we keep tunnel lights
    VTX[i].G:=EnsureRange(VTX[i].G+45,0,255);
    VTX[i].B:=EnsureRange(VTX[i].B+55,0,255);
  end;
  if SceneryVersion='V2' then begin // LightBlue Noon
    VTX[i].R:=EnsureRange(VTX[i].R+55,0,255);
    VTX[i].G:=EnsureRange(VTX[i].G+60,0,255);
    VTX[i].B:=EnsureRange(VTX[i].B+75,0,255);
  end;
  if SceneryVersion='V3' then begin // LightBlue Evening
    VTX[i].R:=EnsureRange(VTX[i].R+60,0,255);
    VTX[i].G:=EnsureRange(VTX[i].G+60,0,255);
    VTX[i].B:=EnsureRange(VTX[i].B+65,0,255);
  end;
end;
list_id:=0;
Changes.VTX:=true;
end;

procedure TForm1.AFC11Lightningfix1Click(Sender: TObject);
var i,k:integer; ps:array of word;
begin
for i:=1 to VTXQty[64] do begin
if VTX[i].B>VTX[i].G*1.6 then //Remove blue highlight from lakes
VTX[i].B:=EnsureRange(VTX[i].B,0,72);
end;

setlength(ps,Qty.Polys+1); k:=1;
for i:=1 to Qty.Polys do begin
if i=v07[k+1].FirstPoly+1 then inc(k);
ps[i]:=v07[k].SurfaceID+1;
end;

for i:=1 to Qty.Polys do for k:=1 to 3 do
if Material[ps[i]].Mode=224 then
VTX[v[i,k]].BlendB:=255; //Enable water display

list_id:=0;
Changes.VTX:=true;
end;

procedure TForm1.AFC11CTLightningFixClick(Sender: TObject);
var i,k:integer; ps:array of word;
begin
for i:=1 to VTXQty[64] do begin
VTX[i].R:=VTX[i].R div 2;
VTX[i].G:=VTX[i].G div 2;
VTX[i].B:=VTX[i].B div 2;
end;

setlength(ps,Qty.Polys+1); k:=1;
for i:=1 to Qty.Polys do begin
if i=v07[k+1].FirstPoly+1 then inc(k);
ps[i]:=v07[k].SurfaceID+1;
end;

for i:=1 to Qty.Polys do for k:=1 to 3 do
if Material[ps[i]].Mode=224 then
VTX[v[i,k]].BlendB:=255; //Enable water display

list_id:=0;
Changes.VTX:=true;
end;

procedure TForm1.Button18Click(Sender: TObject);
var
  f:file;
  ii:integer;
begin
if not RunSaveDialog(SaveDialog,Scenery+'_'+SceneryVersion+'_ObjectsList.dat',
       SceneryPath,'Objects list (ObjectsList.dat)|*.dat') then exit;

assignfile(f,SaveDialog.FileName); rewrite(f,1);
blockwrite(f,'STKit2'+#0+#0,8);    //Name
blockwrite(f,Qty.ObjectFiles,4);
for ii:=1 to Qty.ObjectFiles do begin
blockwrite(f,chr2(ObjName[ii],32)[1],32);//Name
blockwrite(f,ObjProp[ii],20);
blockwrite(f,chr2(ObjProp[ii].HitSound,48)[1],48);//Name
blockwrite(f,chr2(ObjProp[ii].FallSound,48)[1],48);//Name
end;
closefile(f);       
end;

procedure TForm1.ImportObjectsClick(Sender: TObject);
var
  f:file;
  ii:integer;
  ss:string;
begin
if not RunOpenDialog(OpenDialog,'',SceneryPath,'Objects list (ObjectsList.dat)|*.dat') then exit;
assignfile(f,OpenDialog.FileName); reset(f,1);

blockread(f,c,8); ss:=c[1]+c[2]+c[3]+c[4]+c[5]+c[6]+c[7]+c[8];
if ss<>('STKit2'+#0+#0) then begin
MessageBox(Form1.Handle, 'Unknown version.', 'Error', MB_OK or MB_ICONERROR);
closefile(f); exit;
end;

blockread(f,Qty.ObjectFiles,4);    //Name
for ii:=1 to Qty.ObjectFiles do begin
blockread(f,c,32); ObjName[ii]:=StrPas(@c);//Name
blockread(f,ObjProp[ii],20);
blockread(f,c,48); ObjProp[ii].HitSound:=StrPas(@c);//Name
blockread(f,c,48); ObjProp[ii].FallSound:=StrPas(@c);//Name
end;
closefile(f);
SendQADtoUI(apObjects);
CompileLoaded('Objects',1,Qty.ObjectFiles);
Changes.QAD:=true;
end;

procedure TForm1.ListSKYClick(Sender: TObject);
begin
SKYIndex:=ListSKY.ItemIndex+1;
if SKYIndex=0 then exit;
SkyRefresh:=true;
CBCloudsClick(CBClouds);
CBCloudsClick(CBFogTable);
SKY_FogCol.Brush.Color:=SKY[SKYIndex].FogCol.R+SKY[SKYIndex].FogCol.G*256+SKY[SKYIndex].FogCol.B*65536;
SKY_SunCol.Brush.Color:=SKY[SKYIndex].SunCol.R+SKY[SKYIndex].SunCol.G*256+SKY[SKYIndex].SunCol.B*65536;
SKY_AmbCol.Brush.Color:=SKY[SKYIndex].AmbCol.R+SKY[SKYIndex].AmbCol.G*256+SKY[SKYIndex].AmbCol.B*65536;
SKY_WlkAmb.Brush.Color:=SKY[SKYIndex].WlkAmb.R+SKY[SKYIndex].WlkAmb.G*256+SKY[SKYIndex].WlkAmb.B*65536;
SKY_WlkSun.Brush.Color:=SKY[SKYIndex].WlkSun.R+SKY[SKYIndex].WlkSun.G*256+SKY[SKYIndex].WlkSun.B*65536;
SkyRefresh:=false;
end;

procedure TForm1.STRPointIDChange(Sender: TObject); begin STRPointIDChange_; end;
procedure TForm1.STRPointXChange(Sender: TObject); begin STRPointXChange_; end;

procedure TForm1.STRSplineID1Change(Sender: TObject);
begin
if STRSplineID1.Value=0 then begin
STRSplineID2.Value:=0;
exit; end;
RefreshSTRSpline:=true;

if Sender=STRSplineID1 then begin {
xPos:=(STR_Point[STR_Spline[STRSplineID1.Value].PtA+1].x
      +STR_Point[STR_Spline[STRSplineID1.Value].PtB+1].x)/2;
yPos:=(STR_Point[STR_Spline[STRSplineID1.Value].PtA+1].y
      +STR_Point[STR_Spline[STRSplineID1.Value].PtB+1].y)/2;
zPos:=(STR_Point[STR_Spline[STRSplineID1.Value].PtA+1].z
      +STR_Point[STR_Spline[STRSplineID1.Value].PtB+1].z)/2; }
end;

STRSplineShape1.MaxValue:=STRHead.NumShapes;
STRSplineShape2.MaxValue:=STRHead.NumShapes;

STRSplineID1.Value      :=EnsureRange(STRSplineID1.Value,1,STRHead.NumSplines);
STRSplineLenA1.Value    :=STR_Spline[STRSplineID1.Value].LenA;
STRSplineLenB1.Value    :=STR_Spline[STRSplineID1.Value].LenB;
STRSplineShape1.Value   :=STR_Spline[STRSplineID1.Value].FirstShRef+1;
STRSplineOpt11.Checked  :=(STR_Spline[STRSplineID1.Value].Options and 1)=1;
STRSplineOpt12.Checked  :=(STR_Spline[STRSplineID1.Value].Options and 4)=4;
STRSplineOpt13.Checked  :=(STR_Spline[STRSplineID1.Value].Options and 8)=8;

if STR_Spline[STRSplineID1.Value].OppSpline<>65535 then begin
STRSplineID2.Value      :=STR_Spline[STRSplineID1.Value].OppSpline+1;
STRSplineLenA2.Value    :=STR_Spline[STRSplineID2.Value].LenA;
STRSplineLenB2.Value    :=STR_Spline[STRSplineID2.Value].LenB;
STRSplineShape2.Value   :=STR_Spline[STRSplineID2.Value].FirstShRef+1;
STRSplineOpt21.Checked  :=(STR_Spline[STRSplineID2.Value].Options and 1)=1;
STRSplineOpt22.Checked  :=(STR_Spline[STRSplineID2.Value].Options and 4)=4;
STRSplineOpt23.Checked  :=(STR_Spline[STRSplineID2.Value].Options and 8)=8;
end else
STRSplineID2.Value:=0;

Label151.Caption:='Length - '+inttostr(round(STR_Spline[STRSplineID1.Value].Length/10))+'m';
Label113.Caption:='OppSpline - '+inttostr(STR_Spline[STRSplineID1.Value].OppSpline+1);
Label149.Caption:='PrevSpline - '+inttostr(STR_Spline[STRSplineID1.Value].PrevSpline+1);
Label150.Caption:='NextSpline - '+inttostr(STR_Spline[STRSplineID1.Value].FirstWay+1);
Label71.Caption:='NumWays - '+inttostr(STR_Spline[STRSplineID1.Value].NumWays);
Label146.Caption:='Options - '+inttostr(STR_Spline[STRSplineID1.Value].Options);
Label116.Caption:='FirstRoW - '+inttostr(STR_Spline[STRSplineID1.Value].FirstRoW);
Label152.Caption:='NumRoW - '+inttostr(STR_Spline[STRSplineID1.Value].NumRoW);

RefreshSTRSpline:=false;
end;

procedure TForm1.STRSplineLenA1Change(Sender: TObject);
var ID1,ID2:integer;
begin
if RefreshSTRSpline then exit;
if STRSplineID1.Value=0 then exit;
Changes.STR:=true;
ID1:=STRSplineID1.Value;

STR_Spline[ID1].LenA:=STRSplineLenA1.Value;
STR_Spline[ID1].LenB:=STRSplineLenB1.Value;
STR_Spline[ID1].FirstShRef:=EnsureRange(STRSplineShape1.Value,1,STRHead.NumShapes)-1;
STR_Spline[ID1].Options:=0;
if STRSplineOpt11.Checked then inc(STR_Spline[ID1].Options,1);
if STRSplineOpt12.Checked then inc(STR_Spline[ID1].Options,4);
if STRSplineOpt13.Checked then inc(STR_Spline[ID1].Options,8);

if CBSplineSymmetry.Checked then begin
  RefreshSTRSpline:=true;
  STRSplineLenA2.Value:=-STRSplineLenB1.Value;
  STRSplineLenB2.Value:=-STRSplineLenA1.Value;
  STRSplineShape2.Value:=STRSplineShape1.Value;
  STRSplineOpt21.Checked:=STRSplineOpt11.Checked;
  STRSplineOpt22.Checked:=STRSplineOpt13.Checked;
  STRSplineOpt23.Checked:=STRSplineOpt12.Checked;
  RefreshSTRSpline:=false;
end;

if STRSplineID2.Value=0 then exit;
ID2:=STRSplineID2.Value;
STR_Spline[ID2].LenA:=STRSplineLenA2.Value;
STR_Spline[ID2].LenB:=STRSplineLenB2.Value;
STR_Spline[ID2].FirstShRef:=EnsureRange(STRSplineShape2.Value,1,STRHead.NumShapes)-1;
STR_Spline[ID2].Options:=0;
if STRSplineOpt21.Checked then inc(STR_Spline[ID2].Options,1);
if STRSplineOpt22.Checked then inc(STR_Spline[ID2].Options,4);
if STRSplineOpt23.Checked then inc(STR_Spline[ID2].Options,8);
end;

procedure TForm1.CBSplineSymmetryClick(Sender: TObject);
begin
STRSplineLenA2.Enabled:=not CBSplineSymmetry.Checked;
STRSplineLenB2.Enabled:=not CBSplineSymmetry.Checked;
STRSplineShape2.Enabled:=not CBSplineSymmetry.Checked;
STRSplineOpt21.Enabled :=not CBSplineSymmetry.Checked;
STRSplineOpt22.Enabled :=not CBSplineSymmetry.Checked;
STRSplineOpt23.Enabled :=not CBSplineSymmetry.Checked;
STRSplineID1Change(nil); //symmetrize immediately
end;

procedure TForm1.SpeedButton(Sender: TObject);
begin
STRSplineID1.Value:=0;
STRPointID.Value:=0;
if (Sender as TSpeedButton).Down=false then EditMode:=emNone else
if Sender=EditNodes then EditMode:=emStreetNode else
if Sender=EditSplines then EditMode:=emStreetSpline else
exit;
end;

procedure TForm1.AddShapeClick(Sender: TObject); begin AddShapeClick_; end;
procedure TForm1.RemShapeClick(Sender: TObject); begin RemShapeClick_; end;
procedure TForm1.ListStreetShapeClick(Sender: TObject); begin ListStreetShapeClick_; end;
procedure TForm1.StreetShapeChange(Sender: TObject); begin StreetShapeChange_ end;
procedure TForm1.RemPointClick(Sender: TObject); begin RemPointClick_; end;
procedure TForm1.RemSplineClick(Sender: TObject); begin RemSplineClick_; end;
          
procedure TForm1.CBTrackChange(Sender: TObject);
var i:integer;
  procedure SetWP(A:boolean);
  begin
    ImportLWOTrack.Enabled:=A;
    TRK_Loop.Enabled:=A;
    Button11.Enabled:=A;
    Button16.Enabled:=A;
    TRKProperty.Pages[0].Enabled:=A;
    TRKProperty.Pages[1].Enabled:=A;
    TRKProperty.Pages[2].Enabled:=not A;
  end;
begin
  if Sender=LBTrack then begin
    CBTrack.ItemIndex:=LBTrack.ItemIndex;
    SC2_TrackList.ItemIndex:=LBTrack.ItemIndex;
  end;
  if Sender=CBTrack then begin
    LBTrack.ItemIndex:=CBTrack.ItemIndex;
    SC2_TrackList.ItemIndex:=CBTrack.ItemIndex;
  end;
  if Sender=SC2_TrackList then begin
    CBTrack.ItemIndex:=SC2_TrackList.ItemIndex;
    LBTrack.ItemIndex:=SC2_TrackList.ItemIndex;
  end;

  TrackID := CBTrack.ItemIndex+1;

  if TrackID>TracksQty then begin
    TrackWP:=TrackID-TracksQty;
    TrackID:=0;
  end else
    TrackWP:=0;

  PlayTrackPos:=0;
  if TrackWP <> 0 then begin
    TRKProperty.ActivePageIndex:=2;
    if ActivePage in [apTracksMT,apTracksAR,apTracksWP] then
      ActivePage := apTracksWP; //Tied
    SetWP(false);
    ListWPNodes.Clear;
    for i:=1 to WTR[TrackWP].NodeQty do
    ListWPNodes.Items.Add(int2fix(i,2)+'. '+int2fix(WTR[TrackWP].Node[i].CheckPointID,2));
  end else
  if TrackID <> 0 then begin
    TrackWP := 0;
    TRKProperty.ActivePageIndex:=1;
    if ActivePage in [apTracksMT,apTracksAR,apTracksWP] then
      ActivePage := apTracksAR; //Tied
    SetWP(true);
    TRKRefresh:=true;
    TRK_Loop.Checked:=TRKQty[TrackID].LoopFlag=1;
    ListTracksClick(nil);
    ListTOBChange(nil);
    TRKRefresh:=false;
    MakeTrackRefresh:=true;
      ListMakeTrack.Clear;
      for i:=1 to MakeTrack[TrackID].NodeQty do
      ListMakeTrack.Items.Add(int2fix(i,2)+'. ');
    TurnsRefresh := true;
    Form1.E_Node1.Value:=0;
    Form1.E_Node2.Value:=0;
    TurnsRefresh := false;
    MakeTrackRefresh:=false;
  end;
end;


procedure TForm1.TRK_LoopClick(Sender: TObject);
begin
  if TrackID=0 then exit;
  if TRKRefresh then exit;
  TRKQty[TrackID].LoopFlag := byte(TRK_Loop.Checked);
  Changes.TRK[TrackID] := true;
end;


procedure TForm1.LE_RGBClick(Sender: TObject);
var i:integer; Pow,Mul,Add:single;
begin
Pow:=1/LE_Pow.Value; //inverse to meet 0..1 range of color
Mul:=LE_Mul.Value;
Add:=LE_Add.Value/255;
if Sender=LE_RGB then
for i:=1 to VTXQty[64] do begin
VTX[i].R:=EnsureRange(round((Power((VTX[i].R/255),Pow)*Mul+Add)*255),0,255);
VTX[i].G:=EnsureRange(round((Power((VTX[i].G/255),Pow)*Mul+Add)*255),0,255);
VTX[i].B:=EnsureRange(round((Power((VTX[i].B/255),Pow)*Mul+Add)*255),0,255);
end;

if Sender=LE_Shadow then
for i:=1 to VTXQty[64] do
VTX[i].Shadow:=EnsureRange(round(((
Power(((VTX[i].Shadow/255)*2-1),Pow)//*sign((VTX[i].Shadow/255)*2-1)
*Mul+Add)/2+0.5)*255),0,255);

LE_Pow.Value:=1;
LE_Mul.Value:=1;
LE_Add.Value:=0;

list_id:=0;
Changes.VTX:=true;
end;

////////////////////////////////////////////////////////////////////////////////
//Lights
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.AddLightClick(Sender: TObject);
begin
  LightsRefresh:=true;
  if Qty.Lights>=MAX_LIGHTS then begin
    MessageBox(Form1.Handle,PChar(Format('Can''t have more than %d lights',[MAX_LIGHTS])),'Error',MB_OK or MB_ICONINFORMATION);
    exit; //Clip
  end;
  inc(Qty.Lights);
  ListLights.Items.Add(inttostr(Qty.Lights)+'. ');
  ListLights.ItemIndex:=Qty.Lights-1;
  LightX.Value:=xPos;
  LightY.Value:=yPos;
  LightZ.Value:=zPos;
  LightsRefresh:=false;
  LightsChange(nil); //fill new with data from display
  Changes.QAD:=true;
end;


procedure TForm1.RemLightClick(Sender: TObject);
var i,ID:integer;
begin
  if ListLights.ItemIndex<0 then exit;
  ID:=ListLights.ItemIndex+1;
  for i:=ID+1 to Qty.Lights do begin
    Light[i-1]:=Light[i];
    LightW[i-1]:=LightW[i];
  end;
  dec(Qty.Lights);
  SendQADtoUI(apLights);
  ListLights.ItemIndex:=EnsureRange(ID-1,0,Qty.Lights-1);
  Changes.QAD:=true;
end;

procedure TForm1.ListLightsClick(Sender: TObject);
var ID,a,b,c:integer;
begin
if ListLights.ItemIndex<0 then exit;
ID:=ListLights.ItemIndex+1;
LightsRefresh:=true;
LightMode.Checked:=Light[ID].Mode = 8;
Light_Col.Brush.Color:=Light[ID].R+Light[ID].G*256+Light[ID].B*65536;
LightX.Value:=Light[ID].Matrix2[13];
LightY.Value:=Light[ID].Matrix2[14];
LightZ.Value:=Light[ID].Matrix2[15];
Matrix2Angles(Light[ID].Matrix2,16,@a,@b,@c);
LightRY.Value:=b;
LightOffset.Value:=Light[ID].Offset;
LightFreq.Value:=Light[ID].Freq;
LightSize.Value:=Light[ID].Size;

LightWRad.Value:=LightW[ID].Radius;
LightWMode.Checked:=LightW[ID].Mode=1;

LightsRefresh:=false;
end;

procedure TForm1.ListLightsDblClick(Sender: TObject);
var ID:integer;
begin
if ListLights.ItemIndex<0 then exit;
ID:=ListLights.ItemIndex+1;
xPos:=Light[ID].Matrix2[13];
yPos:=Light[ID].Matrix2[14];
zPos:=Light[ID].Matrix2[15];
end;

procedure TForm1.LightsChange(Sender: TObject);
var ID:integer;
begin
if ListLights.ItemIndex<0 then exit;
if LightsRefresh then exit;
ID:=ListLights.ItemIndex+1;

if LightMode.Checked then Light[ID].Mode:=8 else Light[ID].Mode:=0;
Light[ID].A:=255;
Light[ID].b3:=255;
Light[ID].b4:=255;
Angles2Matrix(0,LightRY.Value,0,@Light[ID].Matrix2,16);
Light[ID].Matrix2[13]:=LightX.Value;
Light[ID].Matrix2[14]:=LightY.Value;
Light[ID].Matrix2[15]:=LightZ.Value;
Light[ID].Offset:=LightOffset.Value;
Light[ID].Freq:=LightFreq.Value;
Light[ID].Size:=LightSize.Value;

LightW[ID].Radius:=LightWRad.Value;
if LightWMode.Checked then LightW[ID].Mode:=1 else LightW[ID].Mode:=0;

xPos:=Light[ID].Matrix2[13];
yPos:=Light[ID].Matrix2[14];
zPos:=Light[ID].Matrix2[15];
Changes.QAD:=true;
Changes.WRK:=true;
end;

procedure TForm1.LightApplyClick(Sender: TObject);
var i,k,R:integer; lx,ly,lz,nx,ny,nz,D,Dot,Boost:single; ps:array of word;
begin
if Sender<>LoadLWOScen then MemoLog.Show;
MemoLog.Clear;
ElapsedTime(@OldTime);
MemoLog.Lines.Add('AmbientColor: R'+inttostr(AmbLightW.R)+' G'+inttostr(AmbLightW.G)+' B'+inttostr(AmbLightW.B));
MemoLog.Lines.Add('Assigned in Sky tab'); MemoLog.Lines.Add('');
MemoLog.Lines.Add('SunlightColor: R'+inttostr(SKY[1].SunCol.R)+' G'+inttostr(SKY[1].SunCol.G)+' B'+inttostr(SKY[1].SunCol.B));
MemoLog.Lines.Add('Assigned in Sky tab 1st sky preset'); MemoLog.Lines.Add('');

MemoLog.Lines.Add('Applying ambient lightning');
for i:=1 to VTXQty[64] do begin
dot:=DotProduct(VTX[i].nX/128-1,VTX[i].nY/128-1,VTX[i].nZ/128-1,LVL.SunX,LVL.SunY,LVL.SunZ)*1.5-0.5; //-3..+1
if Dot<0 then Dot:=0;
Dot:=Dot*(1-LVL.SunY); //Lower sun makes stronger highligt
VTX[i].R:=round(AmbLightW.R*(1-dot)+SKY[1].SunCol.R*dot/2);
VTX[i].G:=round(AmbLightW.G*(1-dot)+SKY[1].SunCol.G*dot/2);
VTX[i].B:=round(AmbLightW.B*(1-dot)+SKY[1].SunCol.B*dot/2);
end;

MemoLog.Lines.Add('Applying light sources');
  for k:=1 to Qty.Lights do begin
  R:=LightW[k].Radius*10;
  if R>0 then
    for i:=1 to VTXQty[64] do
    if (abs(Light[k].Matrix2[13]-VTX[i].X)<R)and
       (abs(Light[k].Matrix2[15]-VTX[i].Z)<R) then begin

     lx:=Light[k].Matrix2[13]-VTX[i].X;
     ly:=Light[k].Matrix2[14]-VTX[i].Y;
     lz:=Light[k].Matrix2[15]-VTX[i].Z;
     D:=GetLength(lx,ly,lz)/R;

       if (D<1)and((LightW[k].Mode=0)or(ly>0)) then begin
       Normalize(lx,ly,lz,@nx,@ny,@nz);
       Dot:=DotProduct(nx,ny,nz,VTX[i].nX/128-1,VTX[i].nY/128-1,VTX[i].nZ/128-1)+0.1;
         if Dot>0 then begin
         Boost:=sqr(1-D)*sqrt(Dot); //enhance Diffuse using sqrt
         VTX[i].R:=EnsureRange(VTX[i].R+round(Boost*Light[k].R),0,255);
         VTX[i].G:=EnsureRange(VTX[i].G+round(Boost*Light[k].G),0,255);
         VTX[i].B:=EnsureRange(VTX[i].B+round(Boost*Light[k].B),0,255);
         end;
       end;
    end;
  end;

MemoLog.Lines.Add('Applying enlite materials');
setlength(ps,Qty.Polys+1); k:=1;
for i:=1 to Qty.Polys do begin
if i=v07[k+1].FirstPoly+1 then inc(k);
ps[i]:=v07[k].SurfaceID+1;
end;

for i:=1 to Qty.Polys do for k:=1 to 3 do
if MaterialW[ps[i]].Enlite=1 then begin
VTX[v[i,k]].R:=160;
VTX[v[i,k]].G:=160;
VTX[v[i,k]].B:=160;
end;

list_id:=0;
MemoLog.Lines.Add('Applied in'+ElapsedTime(@OldTime));
MemoLog.Lines.Add('');
MemoLog.Lines.Add('Click here to remove this frame');
Changes.VTX:=true;
end;


procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := false;
  fOptions.Save;
  CanClose := true;

  //Do not exit if user chose "Cancel"
  if not fileexists(fOptions.ExeDir+'unlimiter.'+inttostr(846)) then
    CanClose := MessageBox(Form1.Handle,PChar('Any unsaved changes will be lost!'+eol+'Exit?'),'Warning',MB_OKCANCEL or MB_ICONEXCLAMATION)=IDOK;
end;


procedure TForm1.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0,0);
  wglDeleteContext(h_RC);
  wglDeleteContext(h_RC2);

  fOptions.Free;
  fTriggers.Free;

  if OpenALInitDone then begin
    AlDeleteBuffers(1, @ALBuffer);
    AlDeleteSources(1, @ALSource);
    AlutExit;
  end;
end;


procedure TForm1.ImportLWOTrackClick(Sender: TObject);
var s:string;
begin
  if not RunOpenDialog(OpenDialog,'',SceneryPath,'Lightwave 3D Models (*.lwo)|*.lwo') then exit;
  s := OpenDialog.FileName;
  //s:='E:\World Racing 2\Scenarios\Industrial\V1\route.lwo';
  //s:='E:\World Racing 2\Scenarios\Test\V1\Test_trk.lwo';

  CBTrackChange(LBTrack); //set TrackID in a right way

  if TrackID = 0 then begin
    MessageBox(0, 'Please select track first', 'No track selected', MB_ICONEXCLAMATION or MB_OK);
    exit;
  end;

  if not FileExists(s) then begin
    MessageBox(0, 'LWO file could not be found', 'No file selected', MB_ICONEXCLAMATION or MB_OK);
    exit;
  end;

  if ImportLWO(s) then
    TRK_MakeIdeal(nil);
end;


procedure TForm1.ImportMaterialsClick(Sender: TObject);
var
  f:file;
  i,k,h,EntryQty,NumRead:integer;
  remap:array[1..512]of integer;
  s:string;
begin
if AutoImportMaterialsList<>'' then
OpenDialog.FileName:=AutoImportMaterialsList
else
if not RunOpenDialog(OpenDialog,'',SceneryPath,'Materials list (MaterialsList.dat)|*.dat') then exit;
AutoImportMaterialsList:='';

{for i:=1 to Qty.Materials do begin
Material[i].Tex1:=0;
Material[i].Tex2:=0;
Material[i].Tex3:=0;
Material[i].Mode:=0;
end;}

for i:=1 to length(remap) do remap[i]:=0;

assignfile(f,OpenDialog.FileName); reset(f,1);
repeat
blockread(f,c,8,NumRead);
if NumRead=0 then break;
s:=c[1]+c[2]+c[3]+c[4]+c[5]+c[6]+c[7]+c[8]; //can't use strpas cos c[7]=#0

if s='STKit2'+#0+#1 then begin
blockread(f,EntryQty,4);
  for k:=1 to EntryQty do begin
  blockread(f,c,32); c[33]:=#0; s:=uppercase(StrPas(@c));

  for i:=1 to Qty.Materials do
    if (uppercase(MaterialW[i].Name)= s)or
      ((uppercase(MaterialW[i].Name)<>s)and(i=Qty.Materials)) then begin
      remap[k]:=i;
      blockread(f,c,32); c[33]:=#0; s:=uppercase(StrPas(@c));
        for h:=1 to Qty.TexturesFiles do if s=uppercase(TexName[h]) then Material[i].Tex1:=h-1;
      blockread(f,c,32); c[33]:=#0; s:=uppercase(StrPas(@c));
        for h:=1 to Qty.TexturesFiles do if s=uppercase(TexName[h]) then Material[i].Tex2:=h-1;
      blockread(f,c,32); c[33]:=#0; s:=uppercase(StrPas(@c));
        for h:=1 to Qty.TexturesFiles do if s=uppercase(TexName[h]) then Material[i].Tex3:=h-1;
      blockread(f,Material[i].Mode,110);
      break;
    end;
  end;
end;

if s='GROWGRAS' then
for k:=1 to EntryQty do
blockread(f,MaterialW[remap[k]].GrowGrass,1);

if s='ENLITE00' then
for k:=1 to EntryQty do
blockread(f,MaterialW[remap[k]].Enlite,1);

until(NumRead=0);
closefile(f);
RecalculatematerialCRC1Click(nil);
SendQADtoUI(apMaterials);
Changes.QAD:=true;
end;

procedure TForm1.ExportMaterialsClick(Sender: TObject);
var
  f:file;
  i:integer;
begin
if not RunSaveDialog(SaveDialog,Scenery+'_'+SceneryVersion+'_MaterialsList.dat',
       SceneryPath,'Materials list (MaterialsList.dat)|*.dat') then exit;

assignfile(f,SaveDialog.FileName); rewrite(f,1);
blockwrite(f,'STKit2'+#0+#1,8);
blockwrite(f,Qty.Materials,4);
for i:=1 to Qty.Materials do begin
blockwrite(f,chr2(MaterialW[i].Name,32)[1],32);
blockwrite(f,chr2(TexName[Material[i].Tex1+1],32)[1],32);
blockwrite(f,chr2(TexName[Material[i].Tex2+1],32)[1],32);
blockwrite(f,chr2(TexName[Material[i].Tex3+1],32)[1],32);
blockwrite(f,Material[i].Mode,110);
end;
blockwrite(f,'GROWGRAS',8);
for i:=1 to Qty.Materials do
blockwrite(f,MaterialW[i].GrowGrass,1);
blockwrite(f,'ENLITE00',8);
for i:=1 to Qty.Materials do
blockwrite(f,MaterialW[i].Enlite,1);
closefile(f);
end;

procedure TForm1.LVL_SunXChange(Sender: TObject);
begin
  if LVLRefresh then exit;
  LVL.SunX:=cos(LVL_SunXZ.Value*pi/180)*cos(LVL_SunY.Value*pi/180);
  LVL.SunZ:=sin(LVL_SunXZ.Value*pi/180)*cos(LVL_SunY.Value*pi/180);
  LVL.SunY:=sin(LVL_SunY.Value*pi/180);
  LVL.SunX:=round(LVL.SunX*1000)/1000;
  LVL.SunZ:=round(LVL.SunZ*1000)/1000;
  LVL.SunY:=round(LVL.SunY*1000)/1000;
  Changes.LVL := true;
end;


procedure TForm1.ImportNFSPUSoundsClick(Sender: TObject);
var
  ft:textfile;
  ii,i1,i2:integer;
  i3,i4:single;
begin
  if not RunOpenDialog(OpenDialog,'',SceneryPath,'NFS-PU sounds list (*_aud.scn)|*.scn') then exit;

  AssignFile(ft,OpenDialog.FileName);
  Reset(ft);

  ii:=1;
  Qty.Sounds:=0;
  repeat
    readln(ft);     //AUDIO_ELEMENT 4
    readln(ft,Sound[ii].X, Sound[ii].Y, Sound[ii].Z);
    readln(ft,i1,i2,i3,i4);

    Sound[ii].Name   := inttostr(i2);
    Sound[ii].Radius := round(i3/10);

    Sound[ii].X := Sound[ii].X*8.5; //I usually had to scale PU sceneries to 85% of original size
    Sound[ii].Y := Sound[ii].Y*8.5;
    Sound[ii].Z := Sound[ii].Z*8.5;

    readln(ft);     //Audio Element
    inc(ii);
    inc(Qty.Sounds);
  until(eof(ft));
  CloseFile(ft);
  
  SendQADtoUI(apSounds);
end;


procedure TForm1.CopySoundClick(Sender: TObject);
begin
  PasteSound.Enabled:=true;
  CopyHolder.Name:=EditSoundName.Text;
  CopyHolder.Angl:=0;
  CopyHolder.Size:=1;
  CopyHolder.i1:=SoundVolume.Value;
  CopyHolder.i2:=SoundPlaySpeed.Value;
  CopyHolder.i3:=SoundRadius.Value;
  CopyHolder.i4:=SoundX4.ItemIndex;
  CopyHolder.r1:=SoundX6.Value;
  CopyHolderHintUpdate;
  CopySound.Hint := CopyHolder.Hint;
end;

procedure TForm1.CopyHolderHintUpdate;
begin
  CopyHolder.Hint:='Position:'+eol+
  floattostr(CopyHolder.X)+eol+
  floattostr(CopyHolder.Y)+eol+
  floattostr(CopyHolder.Z);
end;

procedure TForm1.PasteSoundClick(Sender: TObject);
begin
  SoundsRefresh:=true;
  EditSoundName.Text:=CopyHolder.Name;
  SoundVolume.Value:=CopyHolder.i1;
  SoundPlaySpeed.Value:=CopyHolder.i2;
  SoundRadius.Value:=CopyHolder.i3;
  SoundX4.ItemIndex:=CopyHolder.i4;
  SoundX6.Value:=CopyHolder.r1;
  SoundsRefresh:=false;
  SoundsChange(EditSoundName);
  Changes.QAD:=true;
end;


//Addon Info //Creation and saving of scenery descriptor file EditScenery.sc2
procedure TForm1.SC2_ScnChange(Sender: TObject);begin EditSC2Click(Sender); end;
procedure TForm1.SC2_TrackListClick(Sender: TObject);begin CBTrackChange(SC2_TrackList); SC2TrackListClick(Sender); end;
procedure TForm1.SC2T_TrackChange(Sender: TObject);begin EditSC2TrackClick(Sender); end;
procedure TForm1.FillSC2Click(Sender: TObject);begin AutoFill_SC2(nil); end;

procedure TForm1.ShowChangesInfoClick(Sender: TObject);
var i:integer;
begin
  if Sender=ShowInfo then
    if MemoLoad.Showing then begin
      MemoLoad.Hide;
      MemoSave.Hide;
      ShowInfo.Checked:=false;
      exit;
    end else begin
      MemoLoad.Show;
      MemoSave.Show;
      ShowInfo.Checked:=true;
    end;

  MemoSave.Lines.Clear;
  MemoSave.Lines.Add('Work folder: '+fOptions.WorkDir+eol+'Scenery name: '+Scenery+eol);
  MemoSave.Lines.Add('ERRORS');

  for i:=1 to STRHead.NumSplines do begin
    if STR_Spline[i].FirstWay+1<>EnsureRange(STR_Spline[i].FirstWay+1,1,STRHead.NumSplines) then
      MemoSave.Lines.Add('STR: No way from spline '+inttostr(i));
    if ((STR_Spline[i].Options and 1)=1)and((STR_Spline[STR_Spline[i].FirstWay+1].Options and 1)=1) then
      MemoSave.Lines.Add('STR:Two intersections next to each other at spline '+inttostr(i));
  end;

  MemoSave.Lines.Add(eol+'CHANGES');
  MemoSave.Lines.Add(ReturnListOfChangedFiles(eol));
  StatusBar1.Panels[5].Text:=ReturnListOfChangedFiles(', ');
end;

procedure TForm1.OptionsClick(Sender: TObject); begin FormOptions.Show; end;

procedure TForm1.STR_PrepareToSaveClick(Sender: TObject);
var i:integer;
begin
STRHead.Header:='NRTS';
STRHead.Version:=258; //WR2

if STRHead.NumShapes=0 then AddShapeClick(nil); //Make a shape if there's none

for i:=1 to STRHead.NumSplines do
STR_Spline[i].Length:=ComputeSplineLength(i); //must compute before FirstWay

for i:=1 to STRHead.NumSplines do
STR_Spline[i].FirstWay:=FindFirstWay(i);

for i:=1 to STRHead.NumSplines do begin
STR_Spline[i].Density:=2;
STR_Spline[i].OppSpline:=FindOppSpline(i);
STR_Spline[i].PrevSpline:=FindPrevSpline(i);
STR_Spline[i].FirstRoW:=65535;//i-1;
STR_Spline[i].NumRoW:=0;//1;
end;

//Autoset crosses
if CB_AutoCross.Checked then
for i:=1 to STRHead.NumSplines do begin
STR_Spline[i].Options:=STR_Spline[i].Options AND 13; //1101 (1,4,8)
if ((STR_Spline[i].PrevSpline<>65535)and(STR_Spline[STR_Spline[i].PrevSpline+1].NumWays>1))or
   ((STR_Spline[i].FirstWay<>65535)and(STR_Spline[STR_Spline[i].FirstWay+1].PrevSpline=65535)) then
   STR_Spline[i].Options:=STR_Spline[i].Options OR 1; //
end;

for i:=1 to STRHead.NumRoWs do begin
  STR_RoW[i].Spline:=0;
  STR_RoW[i].Tracks:=4294967295; //all bits "1"
end;

Changes.STR:=true;
end;

procedure TForm1.ShowQADInfo(Sender: TObject);
var i,k,x,z,j,t:integer; Dup:boolean;
begin
t:=0;
for i:=0 to Qty.BlocksTotal-1 do begin
x:=i mod Qty.BlocksX+1;
z:=i div Qty.BlocksX+1;
    for j:=Block[z,x].FirstTex+1 to Block[z,x].FirstTex+Block[z,x].NumTex do begin
    Dup:=false;
        for k:=Block[z,x].FirstTex+1 to j-1 do
        if v07[k].SurfaceID=v07[j].SurfaceID then Dup:=true;
    if Dup then inc(t);
    end;
end;

//VLBInfo.RowCount := 20;
VLBInfo.Cells[1,1]:=inttostr(Qty.WidthX)+'   ('+floattostr(round(Qty.BlocksX*1.024)/10)+' km)';
VLBInfo.Cells[1,2]:=inttostr(Qty.LengthZ)+'   ('+floattostr(round(Qty.BlocksZ*1.024)/10)+' km)';
VLBInfo.Cells[1,3]:=inttostr(Qty.BlocksX);
VLBInfo.Cells[1,4]:=inttostr(Qty.BlocksZ);
VLBInfo.Cells[1,5]:=inttostr(Qty.BlocksTotal);
VLBInfo.Cells[1,6]:=inttostr(Qty.TexturesTotal)+' ('+inttostr(round(100*t/Qty.TexturesTotal))+'%)';
VLBInfo.Cells[1,7]:=inttostr(Qty.TexturesFiles);
VLBInfo.Cells[1,8]:=inttostr(Qty.BumpTexturesFiles);
VLBInfo.Cells[1,9]:=inttostr(Qty.ObjectFiles);
VLBInfo.Cells[1,10]:=inttostr(Qty.Polys);
VLBInfo.Cells[1,11]:=inttostr(Qty.Materials);
VLBInfo.Cells[1,12]:=inttostr(Qty.ObjectsTotal);
VLBInfo.Cells[1,13]:=inttostr(Qty.GroundTypes);
VLBInfo.Cells[1,14]:=inttostr(Qty.ColliSize);
VLBInfo.Cells[1,15]:=inttostr(Qty.Lights);
VLBInfo.Cells[1,16]:=inttostr(Qty.x1);
VLBInfo.Cells[1,17]:=inttostr(Qty.x2);
VLBInfo.Cells[1,18]:=inttostr(Qty.x3);
VLBInfo.Cells[1,19]:=inttostr(Qty.Sounds);
end;


procedure TForm1.GrassPlainColorClick(Sender: TObject);
begin
  fGrass.SetPlainColor(GrassColorW.r,GrassColorW.g,GrassColorW.b);
end;


procedure TForm1.LoadLWOLights(Sender: TObject);
var
  f:file;
  m,ii,chsize:integer;
  chname:string[4];
begin
  if not RunOpenDialog(OpenDialog,'',SceneryPath,'Lightwave 3D Models (*.lwo)|*.lwo') then exit;
  assignfile(f,OpenDialog.FileName); reset(f,1);

  blockread(f,c,12);
  if (c[1]+c[2]+c[3]+c[4]+c[9]+c[10]+c[11]+c[12])<>'FORMLWO2' then begin
    MessageBox(Form1.Handle,'Old or unknown LWO format','Error',MB_OK or MB_ICONERROR);
    closefile(f);
    exit;
  end;

  m:=int2(c[8],c[7],c[6],c[5])-4;

  repeat
    blockread(f,c,8);
    chname:=c[1]+c[2]+c[3]+c[4];
    chsize:=int2(c[8],c[7],c[6],c[5]);
    m:=m-chsize-8;

    if chname='PNTS' then begin
      Qty.Lights:=chsize div 12;
      Qty.Lights := min(Qty.Lights, MAX_LIGHTS); //Clip
      blockread(f,c,12*Qty.Lights);
      for ii:=1 to Qty.Lights do begin
        Light[ii].Matrix2[13]:=real2(c[ii*12-8],c[ii*12-9],c[ii*12-10],c[ii*12-11])*10;
        Light[ii].Matrix2[14]:=real2(c[ii*12-4],c[ii*12-5],c[ii*12-6],c[ii*12-7])*10;
        Light[ii].Matrix2[15]:=real2(c[ii*12-0],c[ii*12-1],c[ii*12-2],c[ii*12-3])*10;

        Light[ii].Mode:=0;
        Light[ii].Size:=0;
        Light[ii].Offset:=0;
        Light[ii].Freq:=0;
        Light[ii].R:=255;
        Light[ii].G:=240;
        Light[ii].B:=200;
        LightW[ii].Radius:=30;
        LightW[ii].Mode:=1;
      end;
    end else

    blockread(f,c,chsize);
  until(m<=0);

  SendQADtoUI(apLights);
  Changes.QAD:=true;
end;

procedure TForm1.CopyLightClick(Sender: TObject);
var ID:integer;
begin
ID:=ListLights.ItemIndex+1;
if ID=0 then exit;
PasteLight.Enabled:=true;
CopyHolder.R:=Light[ID].R;
CopyHolder.G:=Light[ID].G;
CopyHolder.B:=Light[ID].B;
CopyHolder.Size:=LightW[ID].Radius;
CopyHolder.i1:=LightW[ID].Mode;
end;

procedure TForm1.PasteLightClick(Sender: TObject);
var ID:integer;
begin
ID:=ListLights.ItemIndex+1;
if ID=0 then exit;
Light[ID].R:=CopyHolder.R;
Light[ID].G:=CopyHolder.G;
Light[ID].B:=CopyHolder.B;
LightW[ID].Radius:=round(CopyHolder.Size);
LightW[ID].Mode:=CopyHolder.i1;
ListLightsClick(nil);
end;


procedure TForm1.CopyLightXYZClick(Sender: TObject);
var ID:integer;
begin
ID:=ListLights.ItemIndex+1;
if ID=0 then exit;
CopyHolder.X:=Light[ID].Matrix2[13];
CopyHolder.Y:=Light[ID].Matrix2[14];
CopyHolder.Z:=Light[ID].Matrix2[15];
end;


procedure TForm1.PasteLightXYZClick(Sender: TObject);
var ID:integer;
begin
ID:=ListLights.ItemIndex+1;
if ID=0 then exit;
Light[ID].Matrix2[13]:=CopyHolder.X;
Light[ID].Matrix2[14]:=CopyHolder.Y;
Light[ID].Matrix2[15]:=CopyHolder.Z;
ListLightsClick(nil);
end;


procedure TForm1.About1Click(Sender: TObject);
var ver,vfl:integer; s:string;
begin
  glGetIntegerv(GL_SHADING_LANGUAGE_VERSION_ARB,@ver);
  glGetIntegerv(GL_MAX_VARYING_FLOATS_ARB,@vfl);
  s:='OpenGL '+glGetString(GL_VERSION)+' by '+glGetString(GL_RENDERER)+eol+
     'GLSL version '+inttostr(ver)+' with max floats '+inttostr(vfl);
  AboutForm.Show(VersionInfo,s,'STKit2');
end;

procedure TForm1.ExportLightsClick(Sender: TObject);
var
  f:file;
begin
if not RunSaveDialog(SaveDialog,Scenery+'_'+SceneryVersion+'_LightsList.dat',
       SceneryPath,'Lights list (LightsList.dat)|*.dat') then exit;

assignfile(f,SaveDialog.FileName); rewrite(f,1);
blockwrite(f,'STKit2'+#0+#0,8);    //Name
blockwrite(f,Qty.Lights,4);    //Name
blockwrite(f,Light[1].Mode,Qty.Lights*88);
blockwrite(f,LightW[1].Radius,Qty.Lights*4);
closefile(f);
end;

procedure TForm1.ImportLightsClick(Sender: TObject);
var
  f:file;
  ss:string;
begin
//if AutoImportLightsList<>'' then
//OpenDialog.FileName:=AutoImportLightsList
//else
if not RunOpenDialog(OpenDialog,'',SceneryPath,'Lights list (LightsList.dat)|*.dat') then exit;
//AutoImportLightsList:='';

assignfile(f,OpenDialog.FileName); reset(f,1);

blockread(f,c,8); ss:=c[1]+c[2]+c[3]+c[4]+c[5]+c[6]+c[7]+c[8];
if ss<>'STKit2'+#0+#0 then begin
MessageBox(Form1.Handle, 'Unknown version.', 'Error', MB_OK or MB_ICONERROR);
closefile(f); exit; end;

blockread(f,Qty.Lights,4);    //Name
blockread(f,Light[1].Mode,Qty.Lights*88);
blockread(f,LightW[1].Radius,Qty.Lights*4);
closefile(f);
SendQADtoUI(apLights);
Changes.QAD:=true;  
end;

procedure TForm1.EditSkyChange(Sender: TObject);
begin
if SkyRefresh then exit;
SKYIndex:=ListSKY.ItemIndex+1;
if SKYIndex=0 then exit;
SKY[SKYIndex].SkyTex:=CBClouds.Items[CBClouds.ItemIndex];
SKY[SKYIndex].FogTab:=CBFogTable.Items[CBFogTable.ItemIndex];
ListSKY.Items[SKYIndex-1]:=SKY[SKYIndex].SkyTex;
Changes.SKY:=true;
CompileLoaded('Sky',SKYIndex-1,1);
end;

procedure TForm1.AddWPTrackClick(Sender: TObject);
var i:integer;
begin
  if TracksQtyWP >= MAX_WP_TRACKS then begin
    MessageBox(HWND(nil), PChar(Format('World racing 2 can not handle more than %d waypoint tracks.',[MAX_WP_TRACKS])), 'Info', MB_OK);
    exit;
  end;
  inc(TracksQtyWP);
  SendQADtoUI(ActivePage);
  WTR[TracksQtyWP].NodeQty:=2;
  WTR[TracksQtyWP].Empty[1]:=0;
  WTR[TracksQtyWP].Empty[2]:=0;
  WTR[TracksQtyWP].Empty[3]:=0;
  setlength(WTR[TracksQtyWP].Node,2+1);
  for i:=1 to 2 do begin
  WTR[TracksQtyWP].Node[i].CheckPointID:=0;
  WTR[TracksQtyWP].Node[i].X:=i*500;
  WTR[TracksQtyWP].Node[i].Y:=0;
  WTR[TracksQtyWP].Node[i].Z:=i*500;
  Angles2Matrix(0,0,0,@WTR[TracksQtyWP].Node[i].M[1],9);
  end;
  AddonScenery.Track[TracksQty+TracksQtyWP].Name:=''; //Gets auto corrected
  WriteCommonDataToSC2; //Auto correct wrong data if any
  Changes.WTR[TracksQtyWP] := true;
end;


procedure TForm1.AddTrackClick(Sender: TObject);
var i:integer;
begin
  if TracksQty >= MAX_TRACKS then begin
    MessageBox(0, PChar(Format('World racing 2 can not handle more than %d racing tracks.',[MAX_TRACKS])), 'Info', MB_OK);
    exit;
  end;
  inc(TracksQty);
  for i:=TracksQty to TracksQty+TracksQtyWP-1 do
    AddonScenery.Track[i+1]:=AddonScenery.Track[i];
  AddonScenery.Track[TracksQty].Name:=''; //Gets auto corrected
  WriteCommonDataToSC2; //Auto correct wrong data if any
  SendQADtoUI(ActivePage);
  Changes.SC2 := true;
  Changes.WRK := true;
end;


procedure TForm1.RemTrackClick(Sender: TObject);
var i:integer;
begin

  if TrackID<>0 then begin
    for i:=TrackID to TracksQty-1 do begin
      TRKQty[i]      := TRKQty[i+1];
      TRK[i]         := TRK[i+1];
      TOBHead[i]     := TOBHead[i+1];
      TOB[i]         := TOB[i+1];
      MakeTrack[i]   := MakeTrack[i+1];
      Changes.TRK[i] := true;
      Changes.TOB[i] := true;
    end;
    dec(TracksQty);
  end;

  if TrackWP<>0 then begin
    for i:=TrackWP to TracksQtyWP-1 do begin
      WTR[i]         := WTR[i+1];
      Changes.WTR[i] := true;
    end;
    dec(TracksQtyWP);
  end;

  if (TrackID+TrackWP <> 0) then
  for i:=TrackID+TrackWP to TracksQtyWP+TracksQty do
    AddonScenery.Track[i]:=AddonScenery.Track[i+1];

  AddonScenery.TrackQty := TracksQty+TracksQtyWP;

  SendQADtoUI(ActivePage);
  Changes.SC2 := true;
  Changes.WRK := true;
end;

procedure TForm1.Panel1DblClick(Sender: TObject);
begin
  DoubleClick:=true;
end;

procedure TForm1.TRK_MakeIdeal(Sender: TObject);
var
  h,i,k,a,b,c:integer;
  nx1,nx2,nz1,nz2,la,lb,L,M:single;
  ix,iy,iz,Blur,Blur2,Ideal2:array of single;
begin
  if TrackID=0 then exit;

  setlength(ix,TRKQty[TrackID].Nodes+1);
  setlength(iy,TRKQty[TrackID].Nodes+1);
  setlength(iz,TRKQty[TrackID].Nodes+1);
  setlength(Blur,TRKQty[TrackID].Nodes+1);
  setlength(Blur2,TRKQty[TrackID].Nodes+1);
  setlength(Ideal2,TRKQty[TrackID].Nodes+1);

  for k:=1 to TRKQty[TrackID].Nodes do begin
    TRK[TrackID].Route[k].Ideal:=0;
    Blur[k]:=0;
    Blur2[k]:=0;
    Ideal2[k]:=0;
  end;
  ElapsedTime(@OldTime);

  Form1.Refresh;

for i:=0 to 9 do begin
Label78.Caption:='Progress: '+inttostr(i*10)+'%';
Label78.Refresh;

    for k:=1 to 512 do begin

        for h:=1 to TRKQty[TrackID].Nodes do begin
        ix[h]:=TRK[TrackID].Route[h].X+TRK[TrackID].Route[h].Ideal*TRK[TrackID].Route[h].Matrix[1];
        iy[h]:=TRK[TrackID].Route[h].Y+TRK[TrackID].Route[h].Ideal*TRK[TrackID].Route[h].Matrix[4];
        iz[h]:=TRK[TrackID].Route[h].Z+TRK[TrackID].Route[h].Ideal*TRK[TrackID].Route[h].Matrix[7];
        end;

        for h:=1 to TRKQty[TrackID].Nodes do begin
        a:=h-1; if a=0 then a:=TRKQty[TrackID].Nodes-1; //Previous node
        b:=h;                                           //Current node
        c:=h+1; if h=TRKQty[TrackID].Nodes then c:=1+1; //Next node

        //Normal to AB
        nx1:=iz[a]-iz[b]; nz1:=ix[b]-ix[a];
        Normalize(nx1,nz1);
        //Normal to BC
        nx2:=iz[b]-iz[c]; nz2:=ix[c]-ix[b];
        Normalize(nx2,nz2);
        //AC half
        L:=(ix[c]-ix[a])/2;
        M:=(iz[c]-iz[a])/2;

        la:=sqrt(sqr(L)+sqr(M));                   //farther triangle base size
        lb:=sqrt(sqr(L+nx2-nx1)+sqr(M+nz2-nz1));   //closer triangle base size
        //Approximate radius is a bit smaller than the real one
        TRK[TrackID].Route[b].CurveRad:=EnsureRange(-la/(la-lb)/10,-8000,8000) //Rad is ratio of these bases
        end;

        for h:=1 to TRKQty[TrackID].Nodes do begin
        a:=h-1; if a=0 then a:=TRKQty[TrackID].Nodes-1; //Previous node
        b:=h;                                           //Current node
        c:=h+1; if h=TRKQty[TrackID].Nodes then c:=1+1; //Next node

        L:=0;
          if TRK[TrackID].Route[a].CurveRad > 0 then L:= L + 10 / (TRK[TrackID].Route[a].CurveRad + 5);
          if TRK[TrackID].Route[a].CurveRad < 0 then L:= L + 10 / (TRK[TrackID].Route[a].CurveRad - 5);

          if TRK[TrackID].Route[b].CurveRad > 0 then L:= L + 40 / (TRK[TrackID].Route[b].CurveRad + 5);
          if TRK[TrackID].Route[b].CurveRad < 0 then L:= L + 40 / (TRK[TrackID].Route[b].CurveRad - 5);

          if TRK[TrackID].Route[c].CurveRad > 0 then L:= L + 10 / (TRK[TrackID].Route[c].CurveRad + 5);
          if TRK[TrackID].Route[c].CurveRad < 0 then L:= L + 10 / (TRK[TrackID].Route[c].CurveRad - 5);

        L:=L/3;
        L:=L*abs(L);

        Blur[h]:= TRK[TrackID].Route[h].Ideal + L;
        Blur2[h]:= (Ideal2[a] + 2*Ideal2[b] + Ideal2[c]) / 4;
        end;

        for h:=1 to TRKQty[TrackID].Nodes do begin
        L:= Blur[h] + Blur2[h];
        M:= L - TRK[TrackID].Route[h].Ideal;

        TRK[TrackID].Route[h].Ideal:=L;
        Ideal2[h]:=Blur2[h];

            if L<=TRK[TrackID].Route[h].Margin1/10+CarWidth then begin
            TRK[TrackID].Route[h].Ideal:=TRK[TrackID].Route[h].Margin1/10+CarWidth;
            Ideal2[h]:=Ideal2[h]-M;
            end;

            if L>=TRK[TrackID].Route[h].Margin2/10-CarWidth then begin
            TRK[TrackID].Route[h].Ideal:=TRK[TrackID].Route[h].Margin2/10-CarWidth;
            Ideal2[h]:=Ideal2[h]-M;
            end;

        end;

    end; //1..k
end;

    TRK[TrackID].Route[1].Delta2:=0;
    for h:=2 to TRKQty[TrackID].Nodes do begin
    L:=sqrt(sqr(ix[h]-ix[h-1])+sqr(iy[h]-iy[h-1])+sqr(iz[h]-iz[h-1]));
    TRK[TrackID].Route[h].Delta2:=TRK[TrackID].Route[h-1].Delta2+L;
    end;

Label78.Caption:='Complete in '+ElapsedTime(@OldTime);
Changes.TRK[TrackID]:=true;
end;


procedure TForm1.ColorShapeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DefineInputColor((Sender as TShape).Brush.Color,Sender);
end;


procedure TForm1.SKY_FogColDragDrop(Sender, Source: TObject; X,Y: Integer);
var ID:integer;
begin
ID:=ListSKY.ItemIndex+1;
if ID=0 then exit;
Color2RGB(SKY_FogCol.Brush.Color,Sky[ID].FogCol.R,Sky[ID].FogCol.G,Sky[ID].FogCol.B);
Color2RGB(SKY_SunCol.Brush.Color,Sky[ID].SunCol.R,Sky[ID].SunCol.G,Sky[ID].SunCol.B);
Color2RGB(SKY_AmbCol.Brush.Color,Sky[ID].AmbCol.R,Sky[ID].AmbCol.G,Sky[ID].AmbCol.B);
Color2RGB(SKY_WlkAmb.Brush.Color,Sky[ID].WlkAmb.R,Sky[ID].WlkAmb.G,Sky[ID].WlkAmb.B);
Color2RGB(SKY_WlkSun.Brush.Color,Sky[ID].WlkSun.R,Sky[ID].WlkSun.G,Sky[ID].WlkSun.B);
Changes.SKY:=true;
end;

procedure TForm1.Light_ColDragDrop(Sender, Source: TObject; X, Y: Integer);
var ID:integer;
begin
ID:=ListLights.ItemIndex+1;
if ID=0 then exit;
Color2RGB(Light_Col.Brush.Color,Light[ID].R,Light[ID].G,Light[ID].B);
end;

procedure TForm1.Light_AmbDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
Color2RGB(Light_Amb.Brush.Color,AmbLightW.R,AmbLightW.G,AmbLightW.B);
Changes.WRK:=true;
end;


procedure TForm1.CreateNewScenClick(Sender: TObject);
var i:integer; s:string;
begin
  if not FileExists(fOptions.WorkDir+'WR2_PC.exe') then begin
    MessageBox(Form1.Handle,'Please check if path to WR2 folder specified in Options is correct',
               'Unable to access WR2 folder', MB_OK or MB_ICONERROR);
    exit;
  end;

  s := InputBox('Create new scenery','Scenery name:','');
  if s = '' then exit;

  for i:=1 to RG2.Items.Count do if RG2.Items[i-1] = s then begin
    MessageBox(Form1.Handle,'Scenery with such name already exists','Error', MB_OK or MB_ICONERROR);
    exit;
  end;

  RG2.Items.Add(s);
  RG2.ItemIndex := RG2.Items.Count-1;
  SceneryReload(nil);
end;


procedure TForm1.GenerateGrassClick(Sender: TObject);
var Tick1:cardinal;
begin
  Tick1 := GetTickCount;
  fGrass.Generate(Label92);
  Label92.Caption := inttostr(GetTickCount-Tick1)+'ms';
  ShowGrassInfo(nil);
end;


procedure TForm1.ShowGrassInfo(Sender: TObject);
var i,LOD:integer;
begin
  LOD := RG_GrassLOD.ItemIndex+1;
  if LOD = 0 then exit;

  for i:=1 to 8 do
    VLBGrass.Cells[1,i] := fGrass.GetStats(LOD, i);

  GrassRefresh := true;
  GrassTexture.Text := fGrass.TexName;
  GrassRefresh := false;
end;


procedure TForm1.RG_GrassLODClick(Sender: TObject);
begin
  fGrass.ReloadTexture;
  ShowGrassInfo(nil);
end;


procedure TForm1.GrassTextureChange(Sender: TObject);
begin
  if GrassRefresh then exit;
  fGrass.TexName := TruncateExt(GrassTexture.Text);
end;


procedure TForm1.RenObjectClick(Sender: TObject);
var ID:integer;
begin
ID:=ListObjects.ItemIndex+1;
if ID=0 then exit;
AddObjectClick(RenObject);
if ListObjects.ItemIndex>ID-1 then
ListObjects.ItemIndex:=ID-1 else
ListObjects.ItemIndex:=ID;
//RemObjectClick(RenObject);
end;

procedure TForm1.SNI_Node_Change(Sender: TObject);
var ID,ID2:integer;
begin
if SNINodesRefresh then exit;
ID:=ListSNIObjects.ItemIndex+1; if ID=0 then exit;
ID2:=ListSNINodes.ItemIndex+1;  if ID2=0 then exit;
SNINode[SNIObj[ID].firstNode+ID2].X:=SNI_Node_X.Value;
SNINode[SNIObj[ID].firstNode+ID2].Y:=SNI_Node_Y.Value;
SNINode[SNIObj[ID].firstNode+ID2].Z:=SNI_Node_Z.Value;
SNINode[SNIObj[ID].firstNode+ID2].Speed:=SNI_Node_Speed.Value;
SNINode[SNIObj[ID].firstNode+ID2].B:=SNI_Node_B.Value;
CalculateSNIRoutes;
Changes.SNI:=true;
end;

procedure TForm1.AddAniNodeClick(Sender: TObject);
var ID,ID2,i,k:integer;
begin
SNINodesRefresh:=true;
ID:=ListSNIObjects.ItemIndex+1; if ID=0 then exit;
ID2:=ListSNINodes.ItemIndex+1;  if ID2=0 then exit;
if SNIObj[ID].NumNodes>=256 then exit;

inc(SNIObj[ID].NumNodes);

//Shift all following objects nodes +1 down to make free space
for i:=SNIHead.Obj downto 1 do
if SNIObj[i].firstNode+1>SNIObj[ID].firstNode+ID2 then
for k:=SNIObj[i].NumNodes downto 1 do
SNINode[SNIObj[i].firstNode+k+1]:=SNINode[SNIObj[i].firstNode+k];

//Shift all following objects FirstNode value
for i:=1 to SNIHead.Obj do
if SNIObj[i].firstNode+1>SNIObj[ID].firstNode+ID2 then
inc(SNIObj[i].firstNode);

//For current object, make new node to insert right before selected node
for k:=SNIObj[ID].NumNodes downto ID2 do
SNINode[SNIObj[ID].firstNode+k+1]:=SNINode[SNIObj[ID].firstNode+k];

k:=round((ID2-1.5)*fOptions.SplineDetail);
if k<=0 then k:=round((SNIObj[ID].NumNodes-1.5)*fOptions.SplineDetail); //-1.5 since SubNode data not updated till now

SNINode[SNIObj[ID].firstNode+ID2].X:=SNISubNode[ID,k].X;
SNINode[SNIObj[ID].firstNode+ID2].Y:=SNISubNode[ID,k].Y;
SNINode[SNIObj[ID].firstNode+ID2].Z:=SNISubNode[ID,k].Z;

inc(SNIHead.Node);
CalculateSNIRoutes;
SendQADToUI(apAnimated);
ListSNIObjects.ItemIndex:=ID-1; ListSNIObjectsClick(nil);
ListSNINodes.ItemIndex:=ID2-1;  ListSNINodesClick(nil);
SNINodesRefresh:=false;
Changes.SNI:=true;
end;

procedure TForm1.MakeSMPClick(Sender: TObject);
var ReduceDisplay:boolean; x,y:single;
begin
//Remember how it was
ReduceDisplay:=fOptions.ReduceDisplay;
x:=xRot; y:=yRot;

fOptions.ReduceDisplay := false;
MemoLog.Show; MemoLog.Clear;
PrepareSMP(nil); //sets viewport
ButtonPrintScreenClick(MakeSMP); //renders and writes to SMPData

//Restore viewport parameters
fOptions.ReduceDisplay := ReduceDisplay;
xRot:=x; yRot:=y;
SMPPreviewRedraw(nil);
MemoLog.Lines.Add('Done');
MemoLog.Lines.Add('');
MemoLog.Lines.Add('Click here to remove this frame');
Changes.SMP:=true;
end;

procedure TForm1.EraseSMPClick(Sender: TObject);
var x,y:single; i:integer;
begin
  x := xRot;
  y := yRot;
  PrepareSMP(nil); //sets viewport
  for i:=1 to SMPHead.A*SMPHead.B do
    SMPData[i]:=0;
  RenderResize(nil);
  xRot := x;
  yRot := y;
  SMPPreviewRedraw(nil);
  Changes.SMP:=true;
end;

procedure TForm1.LoadInstancesFromLWOClick(Sender: TObject);
var
  f:file;
  m,ii,chsize:integer;
  chname:string[4];
begin
if not RunOpenDialog(OpenDialog,'',SceneryPath,'Lightwave 3D Models (*.lwo)|*.lwo') then exit;
assignfile(f,OpenDialog.FileName); reset(f,1);

blockread(f,c,12);
if (c[1]+c[2]+c[3]+c[4]+c[9]+c[10]+c[11]+c[12])<>'FORMLWO2' then begin
MessageBox(Form1.Handle,'Old or unknown LWO format','Error',MB_OK or MB_ICONERROR);
closefile(f); exit; end;

m:=int2(c[8],c[7],c[6],c[5])-4;

repeat
blockread(f,c,8);
chname:=c[1]+c[2]+c[3]+c[4];
chsize:=int2(c[8],c[7],c[6],c[5]);
m:=m-chsize-8;

if chname='PNTS' then begin
blockread(f,c,chsize);
for ii:=Qty.ObjectsTotal+1 to Qty.ObjectsTotal+chsize div 12 do begin
Obj[ii].Name:=ListObjects.Items[ListObjects.ItemIndex];
Obj[ii].ID:=ListObjects.ItemIndex;
Obj[ii].PosX:=real2(c[ii*12-8],c[ii*12-9],c[ii*12-10],c[ii*12-11])*10;
Obj[ii].PosY:=real2(c[ii*12-4],c[ii*12-5],c[ii*12-6],c[ii*12-7])*10-5;
Obj[ii].PosZ:=real2(c[ii*12-0],c[ii*12-1],c[ii*12-2],c[ii*12-3])*10;
Obj[ii].Angl:=RandomS(3.14);
Obj[ii].Size:=6;
end;
inc(Qty.ObjectsTotal,chsize div 12);
end else

blockread(f,c,chsize);
until(m<=0);
SendQADtoUI(apObjects);
Changes.QAD:=true;

end;

procedure TForm1.Button25Click(Sender: TObject);
var i:integer;
begin
STRHead.NumShRefs:=STRHead.NumShapes;
setlength(STR_ShRef,STRHead.NumShRefs+2);

for i:=1 to STRHead.NumShRefs do begin
  STR_ShRef[i].Shape:=0;
  STR_ShRef[i].Speed:=round(70/0.0036);
  STR_ShRef[i].StartU:=0;
end;

STRHead.NumShapes:=1;

for i:=1 to STRHead.NumShapes do begin
STR_Shape[i].Options:=0;
//STR_Shape[i].NumLanes:=1;
end;

SendQADToUI(apStreets);

for i:=1 to STRHead.NumSplines do begin
  STR_Spline[i].FirstShRef:=0;
  STR_Spline[i].NumShRefs:=1;
  if STR_Spline[i].NumRoW=0 then STR_Spline[i].FirstRoW:=65535;
  STR_Spline[i].Options:=STR_Spline[i].Options AND 1;
end;

Changes.STR:=true;
end;

procedure TForm1.SetStreetMode(Sender: string);
begin
if Sender='Nodes' then begin
EditSplines.Down:=false;
EditNodes.Down:=true;
EditNodes.OnClick(EditNodes);
end;
if Sender='Splines' then begin
EditNodes.Down:=false;
EditSplines.Down:=true;
EditSplines.OnClick(EditSplines);
end;
end;

procedure TForm1.GrassColDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
GrassColorW.R:=(GrassCol.Brush.Color mod 256)div 15 *15;
GrassColorW.G:=(GrassCol.Brush.Color mod 65536 div 256)div 15 *15;
GrassColorW.B:=(GrassCol.Brush.Color mod 16777216 div 65536)div 15 *15;
GrassCol.Brush.Color:=GrassColorW.R+GrassColorW.G*256+GrassColorW.B*65536;
Changes.WRK:=true;
end;

procedure TForm1.DuplicateTrafficRoutesClick(Sender: TObject);
var i:integer;
begin
setlength(STR_Shape,STRHead.NumShapes*2+1);
for i:=STRHead.NumShapes+1 to STRHead.NumShapes*2 do
STR_Shape[i]:=STR_Shape[i-STRHead.NumShapes];

setlength(STR_Point,STRHead.NumPoints*2+1);
for i:=STRHead.NumPoints+1 to STRHead.NumPoints*2 do begin
STR_Point[i]:=STR_Point[i-STRHead.NumPoints];
//STR_Point[i].y:=STR_Point[i].y+15;
end;

setlength(STR_Spline,STRHead.NumSplines*2+1);
for i:=STRHead.NumSplines+1 to STRHead.NumSplines*2 do begin
STR_Spline[i]:=STR_Spline[i-STRHead.NumSplines];
inc(STR_Spline[i].PtA,STRHead.NumPoints);
inc(STR_Spline[i].PtB,STRHead.NumPoints);
inc(STR_Spline[i].FirstShRef,STRHead.NumShapes);
if STR_Spline[i].OppSpline<>65535 then
inc(STR_Spline[i].OppSpline,STRHead.NumSplines);
if STR_Spline[i].PrevSpline<>65535 then
inc(STR_Spline[i].PrevSpline,STRHead.NumSplines);
if STR_Spline[i].FirstWay<>65535 then
inc(STR_Spline[i].FirstWay,STRHead.NumSplines);
//STR_Spline[i].FirstRoW
end;

setlength(STR_ShRef,STRHead.NumShRefs*2+1);
 for i:=STRHead.NumShRefs+1 to STRHead.NumShRefs*2 do begin
STR_ShRef[i]:=STR_ShRef[i-STRHead.NumShRefs];
inc(STR_ShRef[i].Shape,STRHead.NumShapes);
end;

setlength(STR_RoW,STRHead.NumRoWs*2+1);
for i:=STRHead.NumRoWs+1 to STRHead.NumRoWs*2 do
STR_RoW[i]:=STR_RoW[i-STRHead.NumRoWs];

STRHead.NumShapes:=STRHead.NumShapes*2;
STRHead.NumPoints:=STRHead.NumPoints*2;
STRHead.NumSplines:=STRHead.NumSplines*2;
STRHead.NumShRefs:=STRHead.NumShRefs*2;
STRHead.NumRoWs:=STRHead.NumRoWs*2;
SendQADtoUI(apStreets);
end;

procedure TForm1.CBShowModeClick(Sender: TObject);
begin
CBMatFilter.Enabled:=CBShowMode.Checked;
end;


procedure TForm1.StreetsLengthClick(Sender: TObject);
var i,len:integer;
begin
  len:=0;
  for i:=1 to STRHead.NumSplines do
    inc(len,round(Str_Spline[i].Length/10));
  MessageBox(Form1.Handle, PChar(eol+'        '+'Total streets length is - '
  +inttostr(len div 1000)+'.'
  +inttostr(len mod 1000)+'km'+'        '+eol), 'Info', MB_OK or MB_ICONINFORMATION);
end;


procedure TForm1.LandInstancesClick(Sender: TObject);
var i:integer;
begin
for i:=1 to Qty.ObjectsTotal do
if Obj[i].ID+1=ListObjects.ItemIndex+1 then
 Obj[i].PosY:=TraceHeightY(Obj[i].PosX,Obj[i].PosY,Obj[i].PosZ,pd_Near);
end;

procedure TForm1.RotateInstancesClick(Sender: TObject);
var i:integer;
begin
for i:=1 to Qty.ObjectsTotal do
if Obj[i].ID+1=ListObjects.ItemIndex+1 then
Obj[i].Angl:=RandomS(pi);
end;

procedure TForm1.ScaleInstancesClick(Sender: TObject);
var i:integer;
begin
for i:=1 to Qty.ObjectsTotal do
if Obj[i].ID+1=ListObjects.ItemIndex+1 then
Obj[i].Size:=1+RandomS(2)/10;
end;


procedure TForm1.GrassTGAColorClick(Sender: TObject);
begin
  if not RunOpenDialog(OpenDialog,'',SceneryPath,'TGA image (*.tga)|*.tga') then exit;
  fGrass.LoadColorFromTGA(OpenDialog.FileName);
end;


procedure TForm1.TraceShadowsClick(Sender: TObject);
begin
TraceVectorShadows(RGShadEdge.ItemIndex,Sender=TraceShadows2);
end;

procedure TForm1.KillShadowsClick(Sender: TObject);
var K:integer;
begin
for K:=1 to VTXQty[64] do VTX[K].Shadow:=0;
for k:=1 to SMPHead.A*SMPHead.B do SMPData[k]:=1;
Changes.VTX:=true;
Changes.SMP:=true;
list_id:=0;
end;

procedure TForm1.MemoLogClick(Sender: TObject);
begin
MemoLog.Hide;
end;

procedure TForm1.SortMaterialModes(Sender: TObject);
var i,k,h:integer;
begin
for i:=1 to Qty.Materials do for k:=i to Qty.Materials do
    if (Material[k].Mode<Material[i].Mode)or((Material[k].Mode=Material[i].Mode)and(Material[k].Tex1<Material[i].Tex1)) then begin //swap
    Material[0]:=Material[i]; Material[i]:=Material[k]; Material[k]:=Material[0];
    MaterialW[0]:=MaterialW[i]; MaterialW[i]:=MaterialW[k]; MaterialW[k]:=MaterialW[0];
    for h:=1 to Qty.TexturesTotal do
    if v07[h].SurfaceID=k-1 then v07[h].SurfaceID:=i-1 else
    if v07[h].SurfaceID=i-1 then v07[h].SurfaceID:=k-1;
    end;

SendQadToUI(apMaterials);
ComputeChunkMode(nil);
Changes.QAD:=true;
Changes.WRK:=true;
end;

procedure TForm1.Applyshadowtesttoobjects1Click(Sender: TObject);
begin
//
end;

procedure TForm1.PlayTrackControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  PlayTrack:=true;
  //fOptions.TraceSurface:=false;
  PlayTrackPrevX:=X;
end;

procedure TForm1.PlayTrackControlMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  if not PlayTrack then exit;
  PlayTrackSpeed:=EnsureRange((X-PlayTrackPrevX)/15,PlayTrackControl.Min/10,PlayTrackControl.Max/10);
  //Label21.Caption:='Play speed '+floattostr(round(PlayTrackSpeed*10)/10)+'x';
  PlayTrackControl.Position:=round(PlayTrackSpeed*10);
end;

procedure TForm1.PlayTrackControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  PlayTrack:=false;
  PlayTrackSpeed:=0;
  //Label21.Caption:='Play speed '+floattostr(PlayTrackSpeed);
  PlayTrackControl.Position:=round(PlayTrackSpeed);
end;

procedure TForm1.CBRenderModeClick(Sender: TObject);
begin
  if not UseShaders then //Disable unsupported modes for OpenGL-only GPUs
    if CBRenderMode.ItemIndex>=3 then
      CBRenderMode.ItemIndex := 3
    else
    if CBRenderMode.ItemIndex>=0 then
      CBRenderMode.ItemIndex := 0;

  case CBRenderMode.ItemIndex of
    0: fOptions.RenderMode := rmSchem;
    1: fOptions.RenderMode := rmBlend;
    2: fOptions.RenderMode := rmFlat;
    3: fOptions.RenderMode := rmOpenGL;
    4: fOptions.RenderMode := rmShader;
    5: fOptions.RenderMode := rmFull;
    6: fOptions.RenderMode := rmPrev;
  end;

  if fOptions.RenderMode=rmPrev then begin
    PageControl1.Hide;
    F_Top.Hide; F_Bottom.Hide; F_Left.Hide; F_Right.Hide;
    Panel1.Left:=2; Panel1.Width:=Form1.ClientWidth-2-2; //952-2-2
  end else begin
    PageControl1.Show;
    F_Top.Show; F_Bottom.Show; F_Left.Show; F_Right.Show;
    Panel1.Left:=300; Panel1.Width:=Form1.ClientWidth-300-2; //952-300-2
  end;

  RenderResize(nil);
end;

procedure TForm1.CB2DClick(Sender: TObject); begin
CB2D.Checked:=not CB2D.Checked; RenderResize(nil); end;

procedure TForm1.CBCheckersClick(Sender: TObject);
begin CBCheckers.Checked:=not CBCheckers.Checked; end;

procedure TForm1.CBWireClick(Sender: TObject);
begin CBWire.Checked:=not CBWire.Checked; end;

procedure TForm1.CBSelectionBufferClick(Sender: TObject);
begin CBSelectionBuffer.Checked:=not CBSelectionBuffer.Checked; end;

procedure TForm1.ReloadAllObjects1Click(Sender: TObject);
begin list_obj:=0; list_tx:=0; end;

procedure TForm1.AddAniClick(Sender: TObject);
var ID:integer;
begin
if SNIHead.Obj>=256 then exit;
ID:=SNIHead.Obj+1;
SNIObj[ID].NumNodes:=3;
SNIObj[ID].objID:=ListObjectsSNI.ItemIndex;
SNIObj[ID].firstNode:=SNIHead.Node;
SNIObj[ID].Mode:=0;
StrPCopy(@SNIObj[ID].Sound,'');
SNIObj[ID].Volume:=100;
SNIObj[ID].Tempo:=100;
SNIObj[ID].Radius:=50;
SNIObj[ID].x4:=0; //zero
SNINode[SNIObj[ID].firstNode+1].X:=xPos-400;
SNINode[SNIObj[ID].firstNode+1].Y:=yPos;
SNINode[SNIObj[ID].firstNode+1].Z:=zPos-200;
SNINode[SNIObj[ID].firstNode+1].Speed:=60;
SNINode[SNIObj[ID].firstNode+1].B:=0;
SNINode[SNIObj[ID].firstNode+2].X:=xPos;
SNINode[SNIObj[ID].firstNode+2].Y:=yPos;
SNINode[SNIObj[ID].firstNode+2].Z:=zPos+500;
SNINode[SNIObj[ID].firstNode+2].Speed:=60;
SNINode[SNIObj[ID].firstNode+2].B:=0;
SNINode[SNIObj[ID].firstNode+3].X:=xPos+400;
SNINode[SNIObj[ID].firstNode+3].Y:=yPos;
SNINode[SNIObj[ID].firstNode+3].Z:=zPos-200;
SNINode[SNIObj[ID].firstNode+3].Speed:=60;
SNINode[SNIObj[ID].firstNode+3].B:=0;

inc(SNIHead.Obj);
inc(SNIHead.Node,3); //add 3 nodes
CalculateSNIRoutes;
SendQADtoUI(apAnimated);
ListSNIObjects.ItemIndex:=SNIHead.Obj-1;
ListSNIObjectsClick(nil);
Changes.SNI:=true;
Changes.WRK:=true;
end;

procedure TForm1.SMPPreviewRedraw(Sender: TObject);
var i,k,x,y:integer; sc,smp,v:single; t,r,g,b:integer;
begin
if (SMPHead.A=0)or(SMPHead.B=0) then exit;

sc:=Max( SMPHead.A/SMPPreview.Width , SMPHead.B/SMPPreview.Height );

for i:=1 to SMPPreview.Height do for k:=1 to SMPPreview.Width do begin
x:=round(k*sc);
y:=round(i*sc)-1;

if (x>SMPHead.A)or(y>SMPHead.B-1) then smp:=0 else
smp:=SMPData[y*SMPHead.A+x];

r:=0; g:=0; b:=0;
t:=round(smp*300);
V:=255/(360 div 6);

case t of
0..59   :begin R:=255;              G:=round(t*v);       B:=0;                end;
60..119 :begin R:=round((120-t)*v); G:=255;              B:=0;                end;
120..179:begin R:=0;                G:=255;              B:=round((t-120)*v); end;
180..239:begin R:=0;                G:=round((240-t)*v); B:=255;              end;
240..299:begin R:=round((t-240)*v); G:=0;                B:=255;              end;
300..359:begin R:=255;              G:=0;                B:=round((360-t)*v); end;
end;

SMPPreview.Canvas.Pixels[k-1,round(SMPHead.B/sc)-i-1]:=r+g*256+b*65536;
end;
end;

procedure TForm1.PrepareSMP(Sender: TObject);
var dx,dy,dz:single; i:integer;
M:array[1..9]of single; a,b,c,d,e,f:single;
begin
      dx:=LVL.SunX/GetLength(LVL.SunX,LVL.SunZ);
      dy:=LVL.SunY;
      dz:=LVL.SunZ/GetLength(LVL.SunX,LVL.SunZ);

      a:=cos(arcsin(dy));
      b:=sin(arcsin(dy));
      c:=cos(arctan2(dz,dx));
      d:=sin(arctan2(dz,dx));
      e:=0;
      f:=0;

      M[1]:=- d; M[2]:=-b*c;  M[3]:=- a*c;   //  7 -4 -1 //12345... elements are placed in these cells
      M[4]:=0;   M[5]:=a;     M[6]:=- b;     // -8  5  2 //with following sign changes, don't know why
      M[7]:=c;   M[8]:=- b*d; M[9]:=-a*d;    //  9 -6 -3 //but this works fine and matches stock maps well

      for i:=1 to VTXQty[64] do begin
      //if (VTX[i].Y>10000)or(VTX[i].Y<-10000) then
      //VTX[i].Y:=100;
      a:=Min(VTX[i].X*M[1]+VTX[i].Y*M[4]+VTX[i].Z*M[7],a);
      b:=Min(VTX[i].X*M[2]+VTX[i].Y*M[5]+VTX[i].Z*M[8],b);
      c:=Min(VTX[i].X*M[3]+VTX[i].Y*M[6]+VTX[i].Z*M[9],c);
      d:=Max(VTX[i].X*M[1]+VTX[i].Y*M[4]+VTX[i].Z*M[7],d);
      e:=Max(VTX[i].X*M[2]+VTX[i].Y*M[5]+VTX[i].Z*M[8],e);
      f:=Max(VTX[i].X*M[3]+VTX[i].Y*M[6]+VTX[i].Z*M[9],f);
      end;

      SMPHead.A:=round(abs(a)/24);
      SMPHead.B:=round((abs(b)+abs(e))/48);
      SMPHead.Left:=a;
      SMPHead.ScaleWidth:=(-SMPHead.Left*2)/SMPHead.A;
      SMPHead.Bottom:=b;
      SMPHead.ScaleHeight:=(-SMPHead.Bottom+e)/SMPHead.B;
      SMPHead.NearClip:=c;
      SMPHead.FullClip:=f-c;
      setlength(SMPData,SMPHead.A*SMPHead.B+1);

      MemoLog.Lines.Add('Width  '+inttostr(SMPHead.A));
      MemoLog.Lines.Add('Height '+inttostr(SMPHead.B));
      MemoLog.Lines.Add('-X  '+floattostr(a));
      MemoLog.Lines.Add('-Y  '+floattostr(b));
      MemoLog.Lines.Add('-Z  '+floattostr(c));
      MemoLog.Lines.Add('+X  '+floattostr(d));
      MemoLog.Lines.Add('+Y  '+floattostr(e));
      MemoLog.Lines.Add('+Z  '+floattostr(f));

      for i:=1 to 9 do SMPHead.Matrix[i]:=M[i]; //using M is shorter

      glViewport(0,0,SMPHead.A,SMPHead.B);
      glMatrixMode(GL_PROJECTION);
      glLoadIdentity;
      glOrtho(SMPHead.Left,-SMPHead.Left,
      SMPHead.Bottom,e,-SMPHead.NearClip,-SMPHead.FullClip-SMPHead.NearClip);
      glMatrixMode(GL_MODELVIEW);
      glLoadIdentity;

xRot:=180+(arctan2(LVL.SunX,LVL.SunZ)*180/pi);
yRot:=arcsin(LVL.SunY)*180/pi;
end;

procedure TForm1.ListWPNodesClick(Sender: TObject);
var WPNode:integer; a,b,c:integer;
begin
WPNode:=ListWPNodes.ItemIndex+1;
if WPNode=0 then exit;
WTRRefresh:=true;
WPNodeX.Value:=WTR[TrackWP].Node[WPNode].X;
WPNodeY.Value:=WTR[TrackWP].Node[WPNode].Y;
WPNodeZ.Value:=WTR[TrackWP].Node[WPNode].Z;
WPNodeCheckPointID.Value:=WTR[TrackWP].Node[WPNode].CheckPointID;
WP_P.Value:=round(arctan2(WTR[TrackWP].Node[WPNode].M[3],WTR[TrackWP].Node[WPNode].M[1])*180/pi);
Label57.Caption:='Length '+inttostr(WTRLength[TrackWP])+'m';
Matrix2Angles(WTR[TrackWP].Node[WPNode].M,9,@a,@b,@c);
Label159.Caption:='H '+inttostr(a)+' P '+inttostr(b)+' B '+inttostr(c);
WTRRefresh:=false;
end;

procedure TForm1.ListWPNodesDblClick(Sender: TObject);
var WPNode:integer;
begin
WPNode:=ListWPNodes.ItemIndex+1;
if WPNode=0 then exit;
xPos:=WTR[TrackWP].Node[WPNode].X;
yPos:=WTR[TrackWP].Node[WPNode].Y;
zPos:=WTR[TrackWP].Node[WPNode].Z;
end;

procedure TForm1.AddWPNodeClick(Sender: TObject);
var i,WPNode:integer;
begin
WPNode:=ListWPNodes.ItemIndex+1;
if WPNode=0 then exit;
WPNode:=EnsureRange(WPNode,1,WTR[TrackWP].NodeQty-1)+1;
WTRRefresh:=true;
inc(WTR[TrackWP].NodeQty);
setlength(WTR[TrackWP].Node,WTR[TrackWP].NodeQty+1);

for i:=WTR[TrackWP].NodeQty downto WPNode do
WTR[TrackWP].Node[i]:=WTR[TrackWP].Node[i-1];

WTR[TrackWP].Node[WPNode].X:=(WTR[TrackWP].Node[WPNode].X+WTR[TrackWP].Node[WPNode+1].X)/2;
WTR[TrackWP].Node[WPNode].Y:=(WTR[TrackWP].Node[WPNode].Y+WTR[TrackWP].Node[WPNode+1].Y)/2;
WTR[TrackWP].Node[WPNode].Z:=(WTR[TrackWP].Node[WPNode].Z+WTR[TrackWP].Node[WPNode+1].Z)/2;

WTRRefresh:=false;
CBTrackChange(LBTrack);
ListWPNodes.ItemIndex:=WPNode-1;
ListWPNodesClick(nil);
Changes.WTR[TrackWP]:=true;
end;

procedure TForm1.RemWPNodeClick(Sender: TObject);
var i,WPNode:integer;
begin
WPNode:=ListWPNodes.ItemIndex+1;
if WPNode=0 then exit;
if WTR[TrackWP].NodeQty<=2 then exit;
WTRRefresh:=true;

for i:=WPNode to WTR[TrackWP].NodeQty-1 do
WTR[TrackWP].Node[i]:=WTR[TrackWP].Node[i+1];

dec(WTR[TrackWP].NodeQty);
WTRRefresh:=false;
CBTrackChange(LBTrack);
ListWPNodes.ItemIndex:=WPNode-1;
ListWPNodesClick(nil);
Changes.WTR[TrackWP]:=true;
//WTR
end;

procedure TForm1.WPNodeChange(Sender: TObject);
var WPNode,i:integer;
begin
WPNode:=ListWPNodes.ItemIndex+1;
if WPNode=0 then exit;
if WTRRefresh then exit;
WTR[TrackWP].Node[WPNode].X:=WPNodeX.Value;
WTR[TrackWP].Node[WPNode].Y:=WPNodeY.Value;
WTR[TrackWP].Node[WPNode].Z:=WPNodeZ.Value;
WTR[TrackWP].Node[WPNode].CheckPointID:=WPNodeCheckPointID.Value;
Angles2Matrix(0,WP_P.Value,0,@WTR[TrackWP].Node[WPNode].M,9);
//WP_P.Value:=round(arctan2(WTR[TrackWP].Node[WPNode].M[3],WTR[TrackWP].Node[WPNode].M[1])*180/pi);

WTRLength[TrackWP]:=0;
for i:=1 to WTR[TrackWP].NodeQty-1 do
inc(WTRLength[TrackWP],round(GetLength(WTR[TrackWP].Node[i+1].X-WTR[TrackWP].Node[i].X,
                                       WTR[TrackWP].Node[i+1].Y-WTR[TrackWP].Node[i].Y,
                                       WTR[TrackWP].Node[i+1].Z-WTR[TrackWP].Node[i].Z)/10));
Label57.Caption:='Length '+inttostr(WTRLength[TrackWP])+'m';
Changes.WTR[TrackWP]:=true;
end;

procedure TForm1.PrintScreenJPGClick(Sender: TObject);
var sh,sw,i,k,h:integer; t:byte; jpg: TJpegImage; mkbmp:TBitmap; s:string;
begin
sh:=Panel1.Height; sw:=Panel1.Width;

setlength(bmp,sw*sh+1);
RenderFrame(PrintScreenJPG);
glReadPixels(0,0,sw,sh,GL_BGRA,GL_UNSIGNED_BYTE,@bmp[0]);

//Mirror verticaly
for i:=0 to (sh div 2)-1 do for k:=0 to sw-1 do for h:=1 to 4 do begin
t:=bmp[i*sw+k,h]; bmp[i*sw+k,h]:=bmp[((sh-1)-i)*sw+k,h]; bmp[((sh-1)-i)*sw+k,h]:=t; end;

mkbmp:=TBitmap.Create;
mkbmp.Handle:=CreateBitmap(sw,sh,1,32,@bmp[0,1]);

jpg:=TJpegImage.Create;
jpg.assign(mkbmp);
jpg.ProgressiveEncoding:=true;
jpg.ProgressiveDisplay:=true;
jpg.Performance:=jpBestQuality;
jpg.CompressionQuality:=90;
jpg.Compress;
DateTimeToString(s,'yyyy-mm-dd hh-nn-ss',Now); //2007-12-23 15-24-33
jpg.SaveToFile(fOptions.ExeDir+'STKit2_screen '+s+'.jpg');

jpg.Free;
mkbmp.Free;
MessageBox(Form1.Handle, PChar('Screenshot saved to '+fOptions.ExeDir+'STKit2_screen '+s+'.jpg'), 'Info', MB_OK or MB_ICONINFORMATION);
end;

procedure TForm1.AddSkyPresetClick(Sender: TObject);
begin
  if SKYQty>=32 then exit; //limit to 32
  inc(SKYQty);
  SKYIndex:=SKYQty;
  SKY[SKYIndex].SkyTex:='Clouds'+SceneryVersion+'_'+int2fix(SKYIndex,2);
  SKY[SKYIndex].FogTab:='rangefogtable_'+int2fix(SKYIndex,2);
  SKY[SKYIndex].FogCol.R:=$B8;//B8BDCB
  SKY[SKYIndex].FogCol.G:=$BD;
  SKY[SKYIndex].FogCol.B:=$CB;
  SKY[SKYIndex].SunCol.R:=$B0;//b0a090
  SKY[SKYIndex].SunCol.G:=$A0;
  SKY[SKYIndex].SunCol.B:=$90;
  SKY[SKYIndex].AmbCol.R:=$27;//272E34
  SKY[SKYIndex].AmbCol.G:=$2E;
  SKY[SKYIndex].AmbCol.B:=$34;
  SKY[SKYIndex].WlkAmb.R:=$66;//666666
  SKY[SKYIndex].WlkAmb.G:=$66;
  SKY[SKYIndex].WlkAmb.B:=$66;
  SKY[SKYIndex].WlkSun.R:=$4C;//4C4C4C
  SKY[SKYIndex].WlkSun.G:=$4C;
  SKY[SKYIndex].WlkSun.B:=$4C;
  SendQADtoUI(apSky); //resets SKYIndex
  ListSKY.ItemIndex:=SKYQty-1;
  ListSKYClick(nil);
  EditSkyChange(nil); //update current sky textures
  Changes.SKY:=true;
end;

procedure TForm1.CBCloudsClick(Sender: TObject);
var ii:integer; SearchRec:TSearchRec; tmp,s:string;
begin
if not DirectoryExists(fOptions.WorkDir+'Clouds\') then exit;
if Sender=CBClouds then tmp:=SKY[SKYIndex].SkyTex;
if Sender=CBFogTable then tmp:=SKY[SKYIndex].FogTab;
(Sender as TComboBox).Clear;
ChDir(fOptions.WorkDir+'Clouds\');
FindFirst('*.ptx', faAnyFile, SearchRec);
    repeat
    if (SearchRec.Name<>'.')and(SearchRec.Name<>'..') then begin
    s:=SearchRec.Name; decs(s,4); //.ptx
    (Sender as TComboBox).Items.Add(s);
//    if (Sender=CBFogTable)and(s[1]='r')and((Sender as TComboBox).ItemIndex=-1) then
//    (Sender as TComboBox).ItemIndex:=(Sender as TComboBox).Items.Count-1;
    end;
    until (FindNext(SearchRec)<>0);
FindClose(SearchRec);
for ii:=0 to (Sender as TComboBox).Items.Count-1 do
if (tmp=(Sender as TComboBox).Items[ii]) or
((Sender=CBFogTable)and((Sender as TComboBox).Items[ii][1]='r')and((Sender as TComboBox).ItemIndex=-1))
then (Sender as TComboBox).ItemIndex:=ii;
if (Sender as TComboBox).ItemIndex=-1 then (Sender as TComboBox).ItemIndex:=0;
end;

procedure TForm1.RemSkyPresetClick(Sender: TObject);
var i:integer;
begin
if SKYQty<=1 then exit;
for i:=SKYIndex to SKYQty-1 do SKY[i]:=SKY[i+1];
CompileLoaded('Sky',SKYIndex-1,SKYQty-SKYIndex);
ListSKY.Items.Delete(ListSKY.ItemIndex);
dec(SKYQty);
SKYIndex:=EnsureRange(SKYIndex,1,SKYQty);
ListSKY.ItemIndex:=SKYIndex-1;
Changes.SKY:=true;
end;


procedure TForm1.Button16Click(Sender: TObject);
var ii:integer;
begin
  if TrackID=0 then exit;

  for ii:=1 to TRKQTY[TrackID].Nodes do
  begin
    TRK[TrackID].Route[ii].Tunnel := 0;
    TRK[TrackID].Route[ii].Column := 0;
    TRK[TrackID].Route[ii].v1 := 0;
    TRK[TrackID].Route[ii].v2 := 0;
    TRK[TrackID].Route[ii].v3 := 0;
    TRK[TrackID].Route[ii].v4 := 0;
  end;

  Changes.TRK[TrackID] := true;
end;


procedure TForm1.AutoObjectsClick(Sender: TObject);
var SearchRec:TSearchRec; s:string;
begin
  ChDir(fOptions.WorkDir+'Scenarios\'+Scenery+'\'+SceneryVersion+'\Objects\');
  FindFirst('*.mox', faAnyFile, SearchRec);
  repeat
    if (SearchRec.Name<>'')and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then begin
      s := SearchRec.Name;
      decs(s,4); //.mox
      AddNewObject(s,false);
    end;
  until (FindNext(SearchRec)<>0);
  FindClose(SearchRec);
  FindFirst('*.tree', faAnyFile, SearchRec);
  repeat
    if (SearchRec.Name<>'')and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then begin
      s := 'T\'+SearchRec.Name;
      decs(s,5); //.tree
      AddNewObject(s,false);
    end;
  until (FindNext(SearchRec)<>0);
  FindClose(SearchRec);
  list_obj:=0;
  Changes.QAD:=true;
end;

procedure TForm1.Button20Click(Sender: TObject);
var ii:integer;
begin
  STRHead.NumPoints := NETHead.Num1;
  setlength(STR_Point,NETHead.Num1+1);

  for ii:=1 to NETHead.Num1 do begin
    STR_Point[ii].x:=NET1[ii].X;
    STR_Point[ii].y:=NET1[ii].Y;
    STR_Point[ii].z:=NET1[ii].Z;
    STR_Point[ii].tx:=1;
    STR_Point[ii].ty:=0;
    STR_Point[ii].tz:=0;
  end;

  NETHead.Num1:=0;
end;

procedure TForm1.RemAniNodeClick(Sender: TObject);
var ID,ID2,i,k:integer;
begin
  SNINodesRefresh:=true;
  ID:=ListSNIObjects.ItemIndex+1; if ID=0 then exit;
  ID2:=ListSNINodes.ItemIndex+1;  if ID2=0 then exit;
  if SNIObj[ID].NumNodes<=3 then begin
    MessageBox(Form1.Handle, 'At least 3 nodes should remain in route.', 'Info', MB_OK or MB_ICONINFORMATION);
    exit;
  end;

  //For current object, remove node and shift following nodes up
  for k:=ID2 to SNIObj[ID].NumNodes do
    SNINode[SNIObj[ID].firstNode+k]:=SNINode[SNIObj[ID].firstNode+k+1];

  //Shift all following objects nodes 1 up
  for i:=1 to SNIHead.Obj do
    if SNIObj[i].firstNode+1>SNIObj[ID].firstNode+ID2 then
      for k:=1 to SNIObj[i].NumNodes do
        SNINode[SNIObj[i].firstNode+k]:=SNINode[SNIObj[i].firstNode+k+1];

  //Shift all following objects FirstNode value
  for i:=1 to SNIHead.Obj do
    if SNIObj[i].firstNode+1>SNIObj[ID].firstNode+ID2 then
      dec(SNIObj[i].firstNode);

  dec(SNIObj[ID].NumNodes);
  dec(SNIHead.Node);
  CalculateSNIRoutes;
  SendQADToUI(apAnimated);
  ListSNIObjects.ItemIndex:=ID-1; ListSNIObjectsClick(nil);
  ListSNINodes.ItemIndex:=ID2-1;  ListSNINodesClick(nil);
  SNINodesRefresh:=false;
  Changes.SNI:=true;
  Changes.WRK:=true;
end;

procedure TForm1.RemAniClick(Sender: TObject);
var ID,Count,NodeQty,i,k:integer;
begin
SNINodesRefresh:=true;
SNIRefresh:=true;

K:=ListSNIObjects.ItemIndex+1; if K=0 then exit; Count:=0;
if Sender=RemAniAll then begin K:=1; Count:=SNIHead.Obj-1; end;

for ID:=K+Count downto K do
if ((Sender=RemAniAll)and(SNIObj[ID].objID=ListObjectsSNI.ItemIndex))or(Sender=RemAni) then begin
NodeQty:=SNIObj[ID].NumNodes;
//shift nodes
for i:=SNIObj[ID].firstNode+1 to SNIHead.Node-NodeQty do SNINode[i]:=SNINode[i+NodeQty];
for i:=ID to SNIHead.Obj-1 do begin
SNIObj[i]:=SNIObj[i+1];
SNISpawnW[i]:=SNISpawnW[i+1];
end;
//Update firstNode value now
for i:=ID to SNIHead.Obj-1 do dec(SNIObj[i].firstNode,NodeQty);
dec(SNIHead.Obj);
dec(SNIHead.Node,NodeQty);
end;

CalculateSNIRoutes;
SendQADToUI(apAnimated);
ListSNIObjects.ItemIndex:=EnsureRange(K-1,0,SNIHead.Obj-1); ListSNIObjectsClick(nil);
SNINodesRefresh:=false;
SNIRefresh:=false;
Changes.SNI:=true;
Changes.WRK:=true;
end;

procedure TForm1.SNISnowClick(Sender: TObject);
var
n,ID,i,ii,K,SnowCount:integer;
RouteLen,Interval:single;
TargetID:integer;
x,y,z,f:single;
WindX,WindZ,Turbulence,Speed:integer;
begin
WindX:=200;
WindZ:=100;

//Add new object incase it didn't existed before
AddNewObject('Snowflakes',false); TargetID:=0;
for i:=1 to Qty.ObjectFiles do if ObjName[i]='Snowflakes' then TargetID:=i-1; //uppercase ignored
if TargetID=0 then exit; //bug?
//AddNewObject('Raindrops',false); TargetID:=0;
//for i:=1 to Qty.ObjectFiles do if ObjName[i]='Raindrops' then TargetID:=i-1; //uppercase ignored
//if TargetID=0 then exit; //bug?

//Remove all previous instances
for i:=1 to SNIHead.Obj do
if ObjName[SNIObj[i].objID+1]='Snowflakes' then begin
ListSNIObjects.ItemIndex:=i-1;
ListSNIObjectsClick(nil);
break; end;
if ListSNIObjects.ItemIndex<>-1 then
if ObjName[SNIObj[ListSNIObjects.ItemIndex+1].objID+1]='Snowflakes' then
RemAniClick(RemAniAll);

for ii:=1 to SNIHead.Obj do
if (SNIObj[ii].Mode=5)or((SNIObj[ii].Mode=6)and(SNISpawnW[ii].TrackID<>0)) then begin

Speed:=SNISpawnW[ii].Speed;
Turbulence:=SNISpawnW[ii].Turbulence;

RouteLen:=0;
if SNIObj[ii].Mode=5 then RouteLen:=SNILen[ii];
if SNIObj[ii].Mode=6 then RouteLen:=TRK[SNISpawnW[ii].TrackID].Route[TRKQty[SNISpawnW[ii].TrackID].Nodes].Delta;

SnowCount:=round(RouteLen / (SNISpawnW[ii].Density*10));
if SnowCount<>0 then Interval:=RouteLen/SnowCount else Interval:=0;

  for K:=0 to SnowCount do if SNIHead.Obj<255 then begin

  if SNIObj[ii].Mode=5 then
  if SnowCount=0 then GetPositionFromSNI(ii,SNILen[ii]/2,@x,@y,@z) else
                      GetPositionFromSNI(ii,K*Interval,@x,@y,@z);
  if SNIObj[ii].Mode=6 then GetPositionFromTRK(SNISpawnW[ii].TrackID,K*Interval,@n,@x,@y,@z,@f);

  ID:=SNIHead.Obj+1;
  SNIObj[ID].NumNodes:=5;
  SNIObj[ID].objID:=TargetID;
  SNIObj[ID].firstNode:=SNIHead.Node;
  SNIObj[ID].Mode:=0;
  StrPCopy(@SNIObj[ID].Sound,'');
  SNIObj[ID].Volume:=0;
  SNIObj[ID].Tempo:=0;
  SNIObj[ID].Radius:=0;
  SNIObj[ID].x4:=0; //zero
  SNINode[SNIObj[ID].firstNode+1].X:=x+RandomS(Turbulence)-WindX;
  SNINode[SNIObj[ID].firstNode+1].Y:=y+700;
  SNINode[SNIObj[ID].firstNode+1].Z:=z+RandomS(Turbulence)-WindZ;
  SNINode[SNIObj[ID].firstNode+1].Speed:=Speed+RandomS(2);
  SNINode[SNIObj[ID].firstNode+2].X:=x+RandomS(Turbulence/3);
  SNINode[SNIObj[ID].firstNode+2].Y:=y;
  SNINode[SNIObj[ID].firstNode+2].Z:=z+RandomS(Turbulence/3);
  SNINode[SNIObj[ID].firstNode+2].Speed:=Speed+RandomS(2);
  SNINode[SNIObj[ID].firstNode+3].X:=x+RandomS(Turbulence)+WindX;
  SNINode[SNIObj[ID].firstNode+3].Y:=y-700;
  SNINode[SNIObj[ID].firstNode+3].Z:=z+RandomS(Turbulence)+WindZ;
  SNINode[SNIObj[ID].firstNode+3].Speed:=Speed+RandomS(2);

  SNINode[SNIObj[ID].firstNode+4].X:=SNINode[SNIObj[ID].firstNode+3].X;
  SNINode[SNIObj[ID].firstNode+4].Y:=SNINode[SNIObj[ID].firstNode+3].Y-1;
  SNINode[SNIObj[ID].firstNode+4].Z:=SNINode[SNIObj[ID].firstNode+3].Z;
  SNINode[SNIObj[ID].firstNode+4].Speed:=10000;
  SNINode[SNIObj[ID].firstNode+5].X:=SNINode[SNIObj[ID].firstNode+1].X;
  SNINode[SNIObj[ID].firstNode+5].Y:=SNINode[SNIObj[ID].firstNode+1].Y+1;
  SNINode[SNIObj[ID].firstNode+5].Z:=SNINode[SNIObj[ID].firstNode+1].Z;
  SNINode[SNIObj[ID].firstNode+5].Speed:=10000;

  for i:=1 to SNIObj[ID].NumNodes do SNINode[SNIObj[ID].firstNode+i].B:=0;

  //Check if limit is exceeded
  if (SNIHead.Obj<MaxSNI)and((SNIHead.Node+SNIObj[ID].NumNodes<MaxSNINodes)) then begin
  inc(SNIHead.Obj);
  inc(SNIHead.Node,SNIObj[ID].NumNodes);
  end;
  end;
end;

CalculateSNIRoutes;
SendQADtoUI(apAnimated);
ListSNIObjects.ItemIndex:=SNIHead.Obj-1;
ListSNIObjectsClick(nil);
Changes.SNI:=true;
Changes.WRK:=true;
end;

procedure TForm1.RGShadEdgeClick(Sender: TObject);
begin
  ShadowEdgeW:=RGShadEdge.ItemIndex;
  Changes.WRK:=true;
end;

procedure TForm1.StatusBar1Click(Sender: TObject);
begin
  StatusBar1.Panels[5].Text := ReturnListOfChangedFiles(', ');
end;


procedure TForm1.Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if CBDriveMode.Checked then begin
    if Car.Stopped then begin
      CarX:=xPos;
      CarY:=yPos;
      CarZ:=zPos;
      CarH:=xRot-180;
      Car.Stopped:=false;
    end;
    if Key=VK_UP    then Key1:=true;
    if Key=VK_DOWN  then Key2:=true;
    if Key=VK_LEFT  then Key3:=true;
    if Key=VK_RIGHT then Key4:=true;
    Key := 0; //Don't pass it to other controls
  end;
end;


procedure TForm1.Memo1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if CBDriveMode.Checked then begin
    if Key=VK_UP    then Key1:=false;
    if Key=VK_DOWN  then Key2:=false;
    if Key=VK_LEFT  then Key3:=false;
    if Key=VK_RIGHT then Key4:=false;
    Key := 0; //Don't pass it to other controls
  end;
end;


procedure TForm1.LevelStreetsClick(Sender: TObject);
var ID:integer; y1,y2:single; ti:integer;
begin
  for ID:=1 to STRHead.NumPoints do begin
    TraceHeight(STR_Point[ID].x+STR_Point[ID].tx*100,
                STR_Point[ID].y+STR_Point[ID].ty*100,
                STR_Point[ID].z+STR_Point[ID].tz*100,
                pd_Near, @y1, @ti);
    TraceHeight(STR_Point[ID].x-STR_Point[ID].tx*100,
                STR_Point[ID].y-STR_Point[ID].ty*100,
                STR_Point[ID].z-STR_Point[ID].tz*100,
                pd_Near, @y2, @ti);

    Normalize(STR_Point[ID].tx,
              (y1-y2)/150,
              STR_Point[ID].tz,
              @STR_Point[ID].tx,@STR_Point[ID].ty,@STR_Point[ID].tz);
  end;

  Changes.STR:=true;
end;

procedure TForm1.LoadSounds(Sender: TObject);
var i,k:integer; NewWave:boolean;
  format: TALEnum;
  size: TALSizei;
  freq: TALSizei;
  loop: TALInt;
  data: TALVoid;
  argv: array of PalByte;
begin
  argv := nil;

  if not OpenALInitDone then begin
    InitOpenAL; //Initialize OpenAL
    AlutInit(nil, argv);
  end;

QtyWave:=0;

for i:=1 to Qty.Sounds do begin
  NewWave:=true;
  for k:=1 to QtyWave do
    if Sound[i].Name=WaveW[k] then begin
      NewWave:=false;
      SoundW[i].WaveID:=k;
    end;
  if NewWave then begin
    inc(QtyWave);
    WaveW[QtyWave]:=Sound[i].Name;
    SoundW[i].WaveID:=QtyWave;
  end;
  SoundW[i].Name:=Sound[i].Name;
end;

for i:=1 to SNIHead.Obj do
if StrPas(@SNIObj[i].Sound)<>'' then begin
  NewWave:=true;
  for k:=1 to QtyWave do
    if StrPas(@SNIObj[i].Sound)=WaveW[k] then begin
      NewWave:=false;
      SoundW[Qty.Sounds+i].WaveID:=k;
    end;
  if NewWave then begin
    inc(QtyWave);
    WaveW[QtyWave]:=StrPas(@SNIObj[i].Sound);
    SoundW[Qty.Sounds+i].WaveID:=QtyWave;
  end;
  SoundW[Qty.Sounds+i].Name:=StrPas(@SNIObj[i].Sound);
end;

  Assert(QtyWave<=63,'Wave limit exceeded - 64');

  AlGenBuffers(QtyWave+1, @ALBuffer); //64 looks like the limit
  AlGenSources(length(WaveList), @ALSource);

for i:=1 to QtyWave do begin
  AlutLoadWavFile(fOptions.WorkDir+'Sounds\'+WaveW[i]+'.wav', format, data, size, freq, loop);
  AlBufferData(ALBuffer[i], format, data, size, freq);
  AlutUnloadWav(format, data, size, freq);
end;

OpenALInitDone:=true;
end;

procedure TForm1.UpdateListener(Sender: TObject);
var i:integer;
begin
  //That is vector between current and previous location of Listener
  Listener.Vel[1]:=xPos-listener.pos[1];
  Listener.Vel[2]:=yPos-listener.pos[2];
  Listener.Vel[3]:=zPos-listener.pos[3];
  Listener.Pos[1]:=xPos;
  Listener.Pos[2]:=yPos;
  Listener.Pos[3]:=zPos;

  Listener.Ori[1]:=0; Listener.Ori[2]:=0; Listener.Ori[3]:=-1;
  Listener.Ori[4]:=0; Listener.Ori[5]:=1; Listener.Ori[6]:=0;

  AlListenerfv ( AL_POSITION, @Listener.Pos);
  AlListenerfv ( AL_VELOCITY, @Listener.Vel);
  AlListenerfv ( AL_ORIENTATION, @Listener.Ori); //Need to take into account as well

for i:=1 to Qty.Sounds do
  if SoundW[i].WaveID<>0 then
    AddSoundToPlaylist(i,Sound[i].X,Sound[i].Y,Sound[i].Z,Sound[i].Radius,Sound[i].Volume,0,0,0);
 
for i:=1 to SNIHead.Obj do
  if SoundW[Qty.Sounds+i].WaveID<>0 then begin
    GetPositionFromSNI(i,SNILoc[i],@Loc[1],@Loc[2],@Loc[3]);
    AddSoundToPlaylist(Qty.Sounds+i,Loc[1],Loc[2],Loc[3],SNIObj[i].Radius,SNIObj[i].Volume,0,0,0);
  end;

end;

procedure TForm1.AddSoundToPlaylist(SoundID:integer; X,Y,Z,Rad,Vol,VelX,VelY,VelZ:single);
var Dist:single; k:integer;
begin
  Dist:=GetLength(X-xPos,Y-yPos,Z-zPos);
  Dist:=1 - min ( Dist / (Rad*100) ,1 );
  //relative distance in 1..0 bounds, where 0 means that sound is out of reach
  SoundW[SoundID].Dist:=Dist;
  Vol := Vol / 100 ; //0..1 range

  if Dist = 0 then //Stop the sound from playing
    if SoundW[SoundID].IsPlaying then
      begin
        WaveList[SoundW[SoundID].InList].Dist:=0;
        AlSourceStop(ALSource[SoundW[SoundID].InList]);
        SoundW[SoundID].IsPlaying:=false;
        SoundW[SoundID].InList:=0;
      end
    else
  else
    if SoundW[SoundID].IsPlaying then begin //Change playing properties?
      k:=SoundW[SoundID].InList;
      WaveList[k].Dist:=Dist; //use this later to prioritize playlist by loudness?
      AlSourcef ( ALSource[k], AL_GAIN, Vol );
      Loc[1]:=X; Loc[2]:=Y; Loc[3]:=Z;
      AlSourcefv( ALSource[k], AL_POSITION, @Loc[1]);
      Loc[1]:=VelX; Loc[2]:=VelY; Loc[3]:=VelZ;
      AlSourcefv( ALSource[k], AL_VELOCITY, @Loc[1]);
    end else //Start playing
      for k:=1 to length(WaveList) do
        if WaveList[k].Dist=0 then begin //Find an empty place in list
          AlSourcei ( ALSource[k], AL_BUFFER, ALBuffer[SoundW[SoundID].WaveID]);
          AlSourcef ( ALSource[k], AL_PITCH, 1.0 );
          AlSourcef ( ALSource[k], AL_GAIN, Vol );
          Dif[1]:=X; Dif[2]:=Y; Dif[3]:=Z;
          AlSourcefv( ALSource[k], AL_POSITION, @Dif[1]);
          AlSourcef ( ALSource[k], AL_REFERENCE_DISTANCE, 100.0 );
          AlSourcef ( ALSource[k], AL_ROLLOFF_FACTOR, 0.85 );
          Dif[1]:=VelX; Dif[2]:=VelY; Dif[3]:=VelZ;
          AlSourcefv( ALSource[k], AL_VELOCITY, @Dif[1]);
          AlSourcei ( ALSource[k], AL_LOOPING, AL_TRUE);
          AlSourcePlay(ALSource[k]);
          SoundW[SoundID].IsPlaying:=true;
          SoundW[SoundID].InList:=k;
          break;
        end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var SearchRec:TSearchRec; s:string; i,k,count:integer; TexAlreadyExists:boolean;
  Arr:array[0..256]of word;
  ArrS:array[0..256]of string;
begin

  //Make a list of textures that can be added to the list
  ChDir(fOptions.WorkDir+'Scenarios\'+Scenery+'\'+SceneryVersion+'\Textures\');
  FindFirst('*.ptx', faAnyFile, SearchRec);
    count:=0;
    repeat
      if (SearchRec.Name<>'')and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then
      begin
        s:=SearchRec.Name;
        decs(s,4); {.ptx}
        TexAlreadyExists:=false;

        for i:=1 to Qty.TexturesFiles do
          if uppercase(TexName[i])=uppercase(s) then
            TexAlreadyExists:=true;

        if not TexAlreadyExists then begin
          inc(count);
          ArrS[count]:=s;
        end;
      end;
    until (FindNext(SearchRec)<>0);
  FindClose(SearchRec);

  s:='Do you wish to add folowing textures to the list?'+eol;
  for i:=1 to count do
    if i mod 4 = 0 then s:=s+ArrS[i]+eol else s:=s+ArrS[i]+'     ';

  //Now ask if user wants to add them or not
  if count=0 then MessageBox(Form1.Handle, 'No new textures found in Textures folder', 'Info', MB_OK or MB_ICONINFORMATION)
  else
    if MessageBox(Form1.Handle, PChar(s), 'Info', MB_YESNO or MB_ICONINFORMATION) = IDYES then
      for i:=1 to count do
        AddTextureToList(ts_AddTex,ArrS[i]);

  //Make a list of unused textures and then ask user if he wants to remove them
  s:='Do you wish to remove following unused textures from the list?'+eol; Arr[0]:=0;
  for k:=1 to Qty.TexturesFiles do begin
    TexAlreadyExists:=false;
    for i:=1 to Qty.Materials do
      if (Material[i].Tex1+1=k)or(Material[i].Tex2+1=k)or(Material[i].Tex3+1=k) then
        TexAlreadyExists:=true;
    if not TexAlreadyExists then begin
      s:=s+TexName[k]+eol;
      inc(Arr[0]);
      Arr[Arr[0]]:=k;
    end;
  end;

  if Arr[0]=0 then MessageBox(Form1.Handle, 'No unused textures found in Textures list', 'Info', MB_OK or MB_ICONINFORMATION)
  else
  if MessageBox(Form1.Handle, PChar(s), 'Info', MB_YESNO or MB_ICONINFORMATION) = IDYES then
    for i:=Arr[0] downto 1 do begin
      ListTextures.ItemIndex:=Arr[i]-1;
      RemTextureClick(nil);
    end;

  SendQADtoUI(apTextures);
  list_tx:=0;
  Changes.QAD:=true;
end;

procedure TForm1.ListMakeTrackClick(Sender: TObject);
var MTNode:integer;
begin
  MTNode:=ListMakeTrack.ItemIndex+1;
  if MTNode=0 then exit;
  MakeTrackRefresh:=true;
  MTX.Value:=MakeTrack[TrackID].Node[MTNode].X;
  MTY.Value:=MakeTrack[TrackID].Node[MTNode].Y;
  MTZ.Value:=MakeTrack[TrackID].Node[MTNode].Z;
  MTW.Value:=MakeTrack[TrackID].Node[MTNode].RoadWidth/10;
  MakeTrackRefresh:=false;
end;


procedure TForm1.ListMakeTrackDblClick(Sender: TObject);
var MTNode:integer;
begin
MTNode:=ListMakeTrack.ItemIndex+1;
if TrackID=0 then exit;
if MTNode=0 then exit;
xPos:=MakeTrack[TrackID].Node[MTNode].X;
yPos:=MakeTrack[TrackID].Node[MTNode].Y;
zPos:=MakeTrack[TrackID].Node[MTNode].Z;
end;


procedure TForm1.MTXChange(Sender: TObject);
var MTNode:integer;
begin
  if MakeTrackRefresh then exit;

  MTNode:=ListMakeTrack.ItemIndex+1;
  if MTNode=0 then exit;
  
  MakeTrack[TrackID].Node[MTNode].X:=MTX.Value;
  MakeTrack[TrackID].Node[MTNode].Y:=MTY.Value;
  MakeTrack[TrackID].Node[MTNode].Z:=MTZ.Value;
  MakeTrack[TrackID].Node[MTNode].RoadWidth:=round(MTW.Value*10);

  RebuildMTSplines;
  Changes.WRK := true;
end;


procedure TForm1.AddMTNodeClick(Sender: TObject);
var i,MTNode:integer;
begin
  MTNode := ListMakeTrack.ItemIndex+1;
  if MTNode = 0 then exit;
  MTNode := EnsureRange(MTNode,1,MakeTrack[TrackID].NodeQty)+1;
  MakeTrackRefresh := true;
  inc(MakeTrack[TrackID].NodeQty);
  setlength(MakeTrack[TrackID].Node,MakeTrack[TrackID].NodeQty+1);

  for i:=MakeTrack[TrackID].NodeQty downto MTNode do
  MakeTrack[TrackID].Node[i] := MakeTrack[TrackID].Node[i-1];

  //If Node is added inbetween existing nodes - place it inbetween their coords
  //If Node is added after the last Node - place it slightly ahead of last Node
  with MakeTrack[TrackID] do
  if MTNode<>MakeTrack[TrackID].NodeQty then begin
    Node[MTNode].X:=mix(Node[MTNode].X,Node[MTNode+1].X,0.5);
    Node[MTNode].Z:=mix(Node[MTNode].Z,Node[MTNode+1].Z,0.5);
    Node[MTNode].Y:=TraceHeightY(Node[MTNode].X,yPos,Node[MTNode].Z,pd_Near);
  end else begin
    Node[MTNode].X:=mix(Node[MTNode-2].X,Node[MTNode].X,-0.5);
    Node[MTNode].Z:=mix(Node[MTNode-2].Z,Node[MTNode].Z,-0.5);
    Node[MTNode].Y:=TraceHeightY(Node[MTNode].X,yPos,Node[MTNode].Z,pd_Near);
  end;

  MakeTrackRefresh:=false;

  ListMakeTrack.Clear;
  for i:=1 to MakeTrack[TrackID].NodeQty do
    ListMakeTrack.Items.Add(int2fix(i,2)+'. ');

  ListMakeTrack.ItemIndex:=MTNode-1;
  ListMakeTrackClick(nil);
  RebuildMTSplines;
  Changes.WRK:=true;
end;


procedure TForm1.RemMTNodeClick(Sender: TObject);
var i,MTNode:integer;
begin
  MTNode:=ListMakeTrack.ItemIndex+1;
  if MTNode=0 then exit;
  if MakeTrack[TrackID].NodeQty<=3 then begin
    if MessageBox(HWND(nil), PChar('Track should have a least 3 nodes'+eol+eol+'Delete all nodes?'), 'Warning', MB_YESNO) = IDYES then begin
      MakeTrack[TrackID].NodeQty := 0;
      ListMakeTrack.Clear;
    end;
    exit;
  end;

  MakeTrackRefresh:=true;
  for i:=MTNode to MakeTrack[TrackID].NodeQty-1 do
  MakeTrack[TrackID].Node[i]:=MakeTrack[TrackID].Node[i+1];
  dec(MakeTrack[TrackID].NodeQty);
  MakeTrackRefresh:=false;

  //CBTrackChange(LBTrack);
    ListMakeTrack.Clear;
    for i:=1 to MakeTrack[TrackID].NodeQty do
    ListMakeTrack.Items.Add(int2fix(i,2)+'. ');
  ListMakeTrack.ItemIndex:=MTNode-1;
  ListMakeTrackClick(nil);
  Changes.WRK:=true;
end;

procedure TForm1.InitMTClick(Sender: TObject);
var i:integer;
begin   
  MakeTrack[TrackID].NodeQty := 3;
  setlength(MakeTrack[TrackID].Node,MakeTrack[TrackID].NodeQty+1);
  with MakeTrack[TrackID] do begin
    Node[1].X := xPos-200;
    Node[1].Z := zPos+100;
    Node[2].X := xPos+200;
    Node[2].Z := zPos+100;
    Node[3].X := xPos;
    Node[3].Z := zPos-200;
    for i:=1 to 3 do begin
      Node[i].Y:=TraceHeightY(Node[i].X,yPos,Node[i].Z,pd_Near);
      Node[i].RoadWidth := round(MTW.Value*10);
    end;
  end;

  RebuildMTSplines;

  ListMakeTrack.Clear;
  for i:=1 to MakeTrack[TrackID].NodeQty do
    ListMakeTrack.Items.Add(int2fix(i,2)+'. ');

  Changes.WRK := true;
end;

procedure TForm1.ReverseMTSplines;
//var ii,kk,h,n0,n1,n2:integer; t:single;
begin
{  if TrackID=0 then exit;

  for kk:=1 to MakeTrack[TrackID].NodeQty div 2 do begin
    SwapFloat(MakeTrack[TrackID].Node[kk].X,MakeTrack[TrackID].Node[kk].X
  }
end;

procedure TForm1.RebuildMTSplines;
var kk,h,n0,n1,n2:integer; t:single;
    TangA,TangB:array of vector3f;
    MTTang:array of array[1..2]of vector3f;
    ax,bx,cx,x0,x1,x2,x3:single;
    ay,by,cy,y0,y1,y2,y3:single;
    az,bz,cz,z0,z1,z2,z3:single;
begin

  if TrackID=0 then exit;

  setlength(TangA,MakeTrack[TrackID].NodeQty+1);
  setlength(TangB,MakeTrack[TrackID].NodeQty+1);
  setlength(MTTang,MakeTrack[TrackID].NodeQty+1);

  for kk:=1 to MakeTrack[TrackID].NodeQty do
  with MakeTrack[TrackID] do begin
    setlength(Node[kk].Sub,fOptions.SplineDetail+1);

    n0:=kk-1; n1:=kk; n2:=kk+1; //n0-prev, n1-this, n2-next
    if n0=0 then n0:=1;//NodeQty;
    if n2>NodeQty then n2:=NodeQty;//1;

    ax:=Getlength((Node[n1].X-Node[n0].X),(Node[n1].Y-Node[n0].Y),(Node[n1].Z-Node[n0].Z));
    bx:=Getlength((Node[n2].X-Node[n1].X),(Node[n2].Y-Node[n1].Y),(Node[n2].Z-Node[n1].Z));

    TangA[kk].X:=(Node[n2].X-Node[n0].X); //Vector X0-X2
    TangA[kk].Y:=(Node[n2].Y-Node[n0].Y); //Vector X0-X2
    TangA[kk].Z:=(Node[n2].Z-Node[n0].Z); //Vector X0-X2
    Normalize(TangA[kk]);
    TangB[kk].X:=TangA[kk].X*ax/3;
    TangB[kk].Y:=TangA[kk].Y*ax/3;
    TangB[kk].Z:=TangA[kk].Z*ax/3;
    TangA[kk].X:=TangA[kk].X*bx/3;
    TangA[kk].Y:=TangA[kk].Y*bx/3;
    TangA[kk].Z:=TangA[kk].Z*bx/3;
    MTTang[n1,1].X:=Node[n1].X+TangA[kk].X;
    MTTang[n1,1].Y:=Node[n1].Y+TangA[kk].Y;
    MTTang[n1,1].Z:=Node[n1].Z+TangA[kk].Z;
    MTTang[n1,2].X:=Node[n1].X-TangB[kk].X;
    MTTang[n1,2].Y:=Node[n1].Y-TangB[kk].Y;
    MTTang[n1,2].Z:=Node[n1].Z-TangB[kk].Z;
  end;

  
  for kk:=1 to MakeTrack[TrackID].NodeQty do
  with MakeTrack[TrackID] do begin
    n1:=kk;  //n1-this, n2-next
    n2:=kk+1; if n2>NodeQty then n2:=1;
    //Treat the track as Looped, this grants smooth transition between last/first Nodes
    //if it's not Looped it doesn't matter whats inbetween last/first anyway 

    for h:=1 to fOptions.SplineDetail do begin
      t:=(h-1)/fOptions.SplineDetail; //0..0.9
      x0:=Node[n1].X; x1:=x0+TangA[n1].X;  //this
      x3:=Node[n2].X; x2:=x3-TangB[n2].X;  //next
      cx:=3*(x1-x0); bx:=3*(x2-x1)-cx; ax:=x3-x0-cx-bx;
      Node[kk].Sub[h].X:=ax*t*t*t+bx*t*t+cx*t+x0;

      y0:=Node[n1].Y; y1:=y0+TangA[n1].Y;
      y3:=Node[n2].Y; y2:=y3-TangB[n2].Y;
      cy:=3*(y1-y0); by:=3*(y2-y1)-cy; ay:=y3-y0-cy-by;
      Node[kk].Sub[h].Y:=ay*t*t*t+by*t*t+cy*t+y0;

      z0:=Node[n1].Z; z1:=z0+TangA[n1].Z;
      z3:=Node[n2].Z; z2:=z3-TangB[n2].Z;
      cz:=3*(z1-z0); bz:=3*(z2-z1)-cz; az:=z3-z0-cz-bz;
      Node[kk].Sub[h].Z:=az*t*t*t+bz*t*t+cz*t+z0;
    end;
  end;

end;


procedure TForm1.CreateTrackFromMT(Sender: TObject);
var ii,kk,ci:integer; dx,dy,dz,len,ang:single; NodeCount:integer;
begin
  if TrackID = 0 then begin
    MessageBox(HWND(nil), 'Can''t make a track from nodes when no track is selected', 'Error', MB_OK);
    exit;
  end;

  if MakeTrack[TrackID].NodeQty<2 then begin
    MessageBox(HWND(nil), 'Can''t make a track from less that 2 nodes', 'Error', MB_OK);
    exit;
  end;

  RebuildMTSplines;

if TRK_Loop.Checked then
  NodeCount:=MakeTrack[TrackID].NodeQty
else
  NodeCount:=MakeTrack[TrackID].NodeQty-1;

TRKQty[TrackID].Nodes:=NodeCount*fOptions.SplineDetail;
TRKQty[TrackID].LoopFlag:=byte(TRK_Loop.Checked);
//switching to WR2 format right away
TRKQty[TrackID].WR2Flag1:=1;
TRKQty[TrackID].WR2Flag2:=1;
TRKQty[TrackID].a1:=0;
TRKQty[TrackID].a2:=1;
TRKQty[TrackID].Turns:=0;
TRKQty[TrackID].Arrows:=0;

setlength(TRK[TrackID].Route,TRKQty[TrackID].Nodes+1);

TRK[TrackID].Route[1].Delta:=0;
TRK[TrackID].Route[1].Delta2:=0;

ci:=0;
for ii:=1 to NodeCount do
for kk:=1 to fOptions.SplineDetail do begin
  inc(ci);
  TRK[TrackID].Route[ci].X:=MakeTrack[TrackID].Node[ii].Sub[kk].X;
  TRK[TrackID].Route[ci].Y:=MakeTrack[TrackID].Node[ii].Sub[kk].Y;
  TRK[TrackID].Route[ci].Z:=MakeTrack[TrackID].Node[ii].Sub[kk].Z;
  if ci>1 then begin
    dx:=TRK[TrackID].Route[ci].X-TRK[TrackID].Route[ci-1].X;
    dy:=TRK[TrackID].Route[ci].Y-TRK[TrackID].Route[ci-1].Y;
    dz:=TRK[TrackID].Route[ci].Z-TRK[TrackID].Route[ci-1].Z;
    len:=sqrt(dx*dx+dy*dy+dz*dz);
    TRK[TrackID].Route[ci].Delta:=TRK[TrackID].Route[ci-1].Delta+len;
  end;
  len:=mix(MakeTrack[TrackID].Node[ii].RoadWidth,
           MakeTrack[TrackID].Node[ii mod MakeTrack[TrackID].NodeQty +1].RoadWidth,
           1-(kk-1)/fOptions.SplineDetail)/2;
  TRK[TrackID].Route[ci].Margin1:=EnsureRange(-round(len*10),-32768,32767);
  TRK[TrackID].Route[ci].Margin2:=EnsureRange( round(len*10),-32768,32767);

  TRK[TrackID].Route[ci].Tunnel:=0;
  TRK[TrackID].Route[ci].Column:=0;
  TRK[TrackID].Route[ci].v1:=0;
  TRK[TrackID].Route[ci].v2:=0;
  TRK[TrackID].Route[ci].v3:=0;
  TRK[TrackID].Route[ci].v4:=0;
end;

for ii:=1 to TRKQty[TrackID].Nodes do begin
  //we exclude Y from equation since there are no global height changes
  //and it's not very important at all
  dx:=TRK[TrackID].Route[EnsureRange(ii+1,1,TRKQty[TrackID].Nodes)].X-TRK[TrackID].Route[EnsureRange(ii-1,1,TRKQty[TrackID].Nodes)].X;
  dz:=TRK[TrackID].Route[EnsureRange(ii+1,1,TRKQty[TrackID].Nodes)].Z-TRK[TrackID].Route[EnsureRange(ii-1,1,TRKQty[TrackID].Nodes)].Z;
  len:=sqrt(dx*dx+dz*dz);
  dx:=dx/len;
  dz:=dz/len;

  if dx<>0 then
    ang:=arctan2(-dz,dx)
  else
    if dz>0 then
      ang:=-pi/2
    else
      ang:=pi/2;

  ang:=ang+pi/2;
  ang:=ang*180/pi;

  Angles2Matrix(0,ang,0,@TRK[TrackID].Route[ii].Matrix[1],9);
end;
 Changes.TRK[TrackID]:=true;

 TRK_MakeIdeal(nil);
 PageControl1Change(nil);
end;


procedure TForm1.ImportVRLFolderClick(Sender: TObject);
var s:string;
begin
  s:=fOptions.ExeDir;
  if not SelectDirectory('','',s) then exit;
  LoadSCGTFolder(IncludeTrailingPathDelimiter(s));
  //LoadSCGTFolder('C:\Documents and Settings\Krom\Desktop\Delphi\+SportsCar GT MASs Extractor\chta\');
end;

procedure TForm1.LoadSCGTFolder(Sender: string);
var ii,h:integer; SearchRec:TSearchRec;
begin
FillChar(LWQty,SizeOf(LWQty),#0);
FillChar(LW,SizeOf(LW),#0);
ChDir(Sender);

      FindFirst('*', faAnyFile - faDirectory, SearchRec);
      ii:=0;
          repeat
          inc(ii);
          if (SearchRec.Name<>'.')and(SearchRec.Name<>'..')
          and(fileexists(Sender+SearchRec.Name)) then
          if GetFileExt(SearchRec.Name)='VRL' then //Ignore the rest
          LoadSCGTFile(SearchRec.Name);
          until ((ii=800)or(FindNext(SearchRec)<>0));
      FindClose(SearchRec);

for ii:=1 to LWQty.Poly[0] do for h:=1 to 3 do
LW.DUV[ii,h,2]:=1-LW.DUV[ii,h,2];

PrepareLWOData;
end;

procedure TForm1.LoadSCGTFile(Sender: string);
var
  f:file;
  ii,ci,h:integer;
  TriCount:integer;
  s:string;
  Head:record
    VertCount,VertOffset,
    x1,x2,x3,x4,x5,x6,x7,
    IndiceCount,IndiceOffset,UOffset,VOffset,
    x8,
    NormOffset,PolyCount,IndicePerPolyOffset,
    z1,z2,z3,z4,z5,z6,z7,
    TextureAssign,TextureCount,TextureNames:integer;
  end;
  IndicePerPoly,Indices:array[1..1024]of integer;
  SurfRemap:array[1..256]of integer;
begin

  if not fileexists(Sender) then exit;
  ElapsedTime(@OldTime);
  assignfile(f,Sender); reset(f,1);

  blockread(f,Head,60);
  blockread(f,Head,108);

  reset(f,1); seek(f,Head.VertOffset);
  setlength(LW.XYZ ,LWQty.Vert[0]+Head.VertCount+1);
  setlength(LW.UV  ,LWQty.Vert[0]+Head.VertCount+1);
  setlength(LW.RGBA,LWQty.Vert[0]+Head.VertCount+1);
  setlength(LW.Nv  ,LWQty.Vert[0]+Head.VertCount+1);
  for ii:=1 to Head.VertCount do begin
    blockread(f,LW.XYZ[LWQty.Vert[0]+ii,1],12);
    blockread(f,c,4);
    LW.XYZ[LWQty.Vert[0]+ii,1]:=LW.XYZ[LWQty.Vert[0]+ii,1]*10;
    LW.XYZ[LWQty.Vert[0]+ii,2]:=LW.XYZ[LWQty.Vert[0]+ii,2]*10;
    LW.XYZ[LWQty.Vert[0]+ii,3]:=LW.XYZ[LWQty.Vert[0]+ii,3]*10;
  end;

{  reset(f,1); seek(f,Head.VertOffset);
  for ii:=1 to Head.VertCount do begin
    blockread(f,LW.Nv[LWQty.Vert[0]+ii,1],12);
    blockread(f,c,4);
    LW.XYZ[LWQty.Vert[0]+ii,1]:=LW.XYZ[LWQty.Vert[0]+ii,1]*10;
    LW.XYZ[LWQty.Vert[0]+ii,2]:=LW.XYZ[LWQty.Vert[0]+ii,2]*10;
    LW.XYZ[LWQty.Vert[0]+ii,3]:=LW.XYZ[LWQty.Vert[0]+ii,3]*10;
  end;}

  inc(LWQty.Vert[0],Head.VertCount);

  //reset(f,1); seek(f,Head.UOffset);
  //blockread(f,T,20*4);
  //exit;

  reset(f,1); seek(f,Head.IndicePerPolyOffset);
  blockread(f,IndicePerPoly[1],Head.PolyCount*4);

  setlength(LW.Poly, length(LW.Poly)+1000+1);
  reset(f,1); seek(f,Head.IndiceOffset);
  ci:=0;
  for ii:=1 to Head.PolyCount do begin
    blockread(f,Indices,IndicePerPoly[ii]*4);
    for h:=3 to IndicePerPoly[ii] do begin
      inc(ci);
      LW.Poly[LWQty.Poly[0]+ci,0]:=3;
      LW.Poly[LWQty.Poly[0]+ci,1]:=LWQty.Vert[0]-Head.VertCount + Indices[1]+1;
      LW.Poly[LWQty.Poly[0]+ci,3]:=LWQty.Vert[0]-Head.VertCount + Indices[h-1]+1;
      LW.Poly[LWQty.Poly[0]+ci,2]:=LWQty.Vert[0]-Head.VertCount + Indices[h]+1;
    end;
  end;
  inc(LWQty.Poly[0],ci);
  TriCount:=ci;

  //Read used textures
  FillChar(SurfRemap,SizeOf(SurfRemap),#0);
  reset(f,1); seek(f,Head.TextureNames);
  for ii:=1 to Head.TextureCount do begin
    blockread(f,c,12);
    s:=UpperCase(StrPas(@c[1]));
    for h:=1 to LWQty.Surf[0] do
      if s=LW.ClipTex[h] then SurfRemap[ii]:=h;

    if SurfRemap[ii]=0 then begin
      inc(LWQty.Surf[0]);
      Assert(LWQty.Surf[0]<=255,'SCGT texture overflow');
      LW.ClipTex[LWQty.Surf[0]]:=s;
      SurfRemap[ii]:=LWQty.Surf[0];
      setlength(LW.SName,LWQty.Surf[0]+1);
      LW.SName[LWQty.Surf[0]]:=s;
      setlength(LW.SText,LWQty.Surf[0]+1);
      LW.SText[LWQty.Surf[0]]:=s;
    end;

  end;

  reset(f,1); seek(f,Head.TextureAssign);
  blockread(f,Indices,Head.PolyCount*4);
  setlength(LW.Surf,LWQty.Poly[0]+1);
  ci:=0;
  for ii:=1 to Head.PolyCount do begin
    for h:=3 to IndicePerPoly[ii] do begin
    inc(ci);
    LW.Surf[LWQty.Poly[0]-TriCount+ci]:=SurfRemap[Indices[ii]+1];
    end;
  end;

  reset(f,1); seek(f,Head.UOffset);
  setlength(LW.DUV,LWQty.Poly[0]+1);
  ci:=LWQty.Poly[0]-TriCount;
  for ii:=1 to Head.PolyCount do begin
    inc(ci);
    blockread(f,LW.DUV[ci,1,1],4);
    blockread(f,LW.DUV[ci,3,1],4);
    blockread(f,LW.DUV[ci,2,1],4);
    for h:=4 to IndicePerPoly[ii] do begin
    inc(ci);
    LW.DUV[ci,1,1]:=LW.DUV[ci-1,1,1];
    LW.DUV[ci,3,1]:=LW.DUV[ci-1,2,1];
    blockread(f,LW.DUV[ci,2,1],4);
    end;
  end;
  reset(f,1); seek(f,Head.VOffset);
  setlength(LW.DUV,LWQty.Poly[0]+1);
  ci:=LWQty.Poly[0]-TriCount;
  for ii:=1 to Head.PolyCount do begin
    inc(ci);
    blockread(f,LW.DUV[ci,1,2],4);
    blockread(f,LW.DUV[ci,3,2],4);
    blockread(f,LW.DUV[ci,2,2],4);
    for h:=4 to IndicePerPoly[ii] do begin
    inc(ci);
    LW.DUV[ci,1,2]:=LW.DUV[ci-1,1,2];
    LW.DUV[ci,3,2]:=LW.DUV[ci-1,2,2];
    blockread(f,LW.DUV[ci,2,2],4);
    end;
  end;

  LWQty.Tags[0]:=LWQty.Surf[0];

  closefile(f);
end;


procedure TForm1.Show2ndFrameClick(Sender: TObject);
begin
Show2ndFrame.Checked:=not Show2ndFrame.Checked;
Panel11.Visible:=Show2ndFrame.Checked;
Panel11.Width:=Panel1.Width div 2;
Panel11.Height:=Panel1.Height div 2;
wglMakeCurrent(h_DC, h_RC);
RenderResize(nil);
end;

procedure TForm1.OptimizeVerticesClick(Sender: TObject);
begin
  OptimizeVerticesClick_;
end;

procedure TForm1.OptimizeCullingSpheresClick(Sender: TObject);
begin
  OptimizeCullingSpheresClick_;
end;


procedure TForm1.RBCarSimClick(Sender: TObject);
begin
  if Sender = RBCarSim then Car.Mode := cdm_Sim;
  if Sender = RBCarArc then Car.Mode := cdm_Arcade;
end;


procedure TForm1.CBDriveModeClick(Sender: TObject);
begin
  RBCarSim.Enabled := CBDriveMode.Checked;
  RBCarArc.Enabled := CBDriveMode.Checked;
  Form1.ActiveControl := nil;//.FocusControl(Panel1);
end;


end.
