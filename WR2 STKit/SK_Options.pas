unit SK_Options;
interface
uses
  Windows, Classes, Forms, SysUtils, INIFiles, Unit_Defaults, Dialogs, KromUtils, FileCtrl;

{STKit2 global options}
type
  TSKOptions = class
  private
    fExeDir:string;
    fWorkDir:string;
    fActiveScenery:string;
    fFPSLag:word;
    fViewDistance:word;
    fSplineDetail:word; //How many interpolated points are between Nodes (SNI, Streets, etc..)
    fTopDownRenderH:word;
    fTopDownRenderV:word;
    fRenderMode:RenderModeTypes;
    fReduceDisplay:boolean;
    fTraceSurface:boolean;
    procedure ReadOptions(const aFileName: string);
    procedure WriteOptions(const aFileName: string);
  public
    constructor Create;
    property ExeDir:string read fExeDir;
    property WorkDir:string read fWorkDir write fWorkDir;
    property ActiveScenery:string read fActiveScenery write fActiveScenery;
    property FPSLag:word read fFPSLag write fFPSLag;
    property ViewDistance:word read fViewDistance write fViewDistance;
    property SplineDetail:word read fSplineDetail write fSplineDetail;
    property TopDownRenderH:word read fTopDownRenderH write fTopDownRenderH;
    property TopDownRenderV:word read fTopDownRenderV write fTopDownRenderV;
    property RenderMode:RenderModeTypes read fRenderMode write fRenderMode;
    property ReduceDisplay:boolean read fReduceDisplay write fReduceDisplay;
    property TraceSurface:boolean read fTraceSurface write fTraceSurface;
    procedure Save;
  end;

implementation


{ TSKOptions }
constructor TSKOptions.Create;
begin
  inherited;

  fExeDir := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));

  if not DirectoryExists(fExeDir + STKit2_Data_Path + '\') then
    MessageBox(0,
      PChar('Unable to locate '+STKit2_Data_Path+' folder.'+eol+
      'You must unpack all STKit2 package contents into one folder.'),
      'Error', MB_OK or MB_ICONERROR);

  ReadOptions(fExeDir + STKit2_Data_Path + '\' + 'Options.ini');
end;


procedure TSKOptions.ReadOptions(const aFileName: string);
var
  iniFile: TIniFile;
  IsChanged: Boolean;
begin
  IsChanged := not FileExists(aFileName); //No file means new options will be filled

  iniFile := TIniFile.Create(aFileName);

  fWorkDir       := iniFile.ReadString ('STKit2', 'WR2 Folder',  '');

  if not DirectoryExists(fWorkDir) then begin
    SelectDirectory('Browse for World Racing 2 folder', '', fWorkDir); //it's quite likely that EXE is in WR2 folder
    fWorkDir := IncludeTrailingPathDelimiter(fWorkDir);
    if not DirectoryExists(fWorkDir) then
      fWorkDir := ''; //Confirm that it's failed
    IsChanged := true;
  end;

  fActiveScenery := iniFile.ReadString ('STKit2', 'Active Scenery', '');
  fFPSLag        := iniFile.ReadInteger('STKit2', 'Frame Limit',    25); //25ms = 40fps
  fViewDistance  := iniFile.ReadInteger('STKit2', 'ViewDistance',   6500);
  fSplineDetail  := iniFile.ReadInteger('STKit2', 'SplineDetail',   16);
  fTopDownRenderH:= iniFile.ReadInteger('STKit2', 'TopDownRenderH', 1024);
  fTopDownRenderV:= iniFile.ReadInteger('STKit2', 'TopDownRenderV', 1024);
  fRenderMode    := RenderModeTypes(iniFile.ReadInteger('STKit2', 'RenderMode', 3));
  fReduceDisplay := iniFile.ReadBool   ('STKit2', 'ReduceDisplay',  true);
  fTraceSurface  := iniFile.ReadBool   ('STKit2', 'Trace Surface',  true);

  iniFile.Free;

  if IsChanged then //Something's changed, e.g. WorkDir
    WriteOptions(aFileName);
end;


procedure TSKOptions.WriteOptions(const aFileName: string);
var iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(aFileName);

  iniFile.WriteString ('STKit2', 'WR2 Folder',     fWorkDir);
  iniFile.WriteString ('STKit2', 'Active Scenery', fActiveScenery);
  iniFile.WriteInteger('STKit2', 'Frame Limit',    fFPSLag);
  iniFile.WriteInteger('STKit2', 'ViewDistance',   fViewDistance);
  iniFile.WriteInteger('STKit2', 'SplineDetail',   fSplineDetail);
  iniFile.WriteInteger('STKit2', 'TopDownRenderH', fTopDownRenderH);
  iniFile.WriteInteger('STKit2', 'TopDownRenderV', fTopDownRenderV);
  iniFile.WriteInteger('STKit2', 'RenderMode',     byte(fRenderMode));
  iniFile.WriteBool   ('STKit2', 'ReduceDisplay',  fReduceDisplay);
  iniFile.WriteBool   ('STKit2', 'Trace Surface',  fTraceSurface);

  iniFile.Free;
end;


procedure TSKOptions.Save;
begin
  WriteOptions(fExeDir + STKit2_Data_Path + '\' + 'Options.ini');
end;


end.

