unit SK_Options;
{$IFDEF FPC} {$MODE Delphi} {$ENDIF}

interface
uses
  Windows, Classes, Forms, SysUtils, INIFiles, Defaults, Dialogs, KromUtils;

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
    procedure ReadOptions(aFileName:string);
    procedure WriteOptions(aFileName:string);
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


constructor TSKOptions.Create;
begin
  Inherited;
  fExeDir := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  if not DirectoryExists(fExeDir + STKit2_Data_Path + '\') then
    MyMessageBox(HWND(nil), 'Unable to locate '+STKit2_Data_Path+' folder.'+eol+'You must unpack all STKit2 package contents into one folder.', 'Error', MB_OK or MB_ICONERROR);
  ReadOptions(fExeDir + STKit2_Data_Path + '\' + 'Options.ini');
end;


procedure TSKOptions.ReadOptions(aFileName:string);
var f:TIniFile; IsChanged:boolean;
begin
  IsChanged := not FileExists(aFileName); //No file means new options will be filled

  f := TIniFile.Create(aFileName);

  fWorkDir       := f.ReadString ('STKit2', 'WR2 Folder',  '');

  if not DirectoryExists(fWorkDir) then begin
    SelectDirectory('Folder', fExeDir, fWorkDir); //it's quite likely that EXE is in WR2 folder
    fWorkDir := IncludeTrailingPathDelimiter(fWorkDir);
    if not DirectoryExists(fWorkDir) then
      fWorkDir := ''; //Confirm that it's failed
    IsChanged := true;
  end;

  fActiveScenery := f.ReadString ('STKit2', 'Active Scenery', '');
  fFPSLag        := f.ReadInteger('STKit2', 'Frame Limit',    25); //25ms = 40fps
  fViewDistance  := f.ReadInteger('STKit2', 'ViewDistance',   6500);
  fSplineDetail  := f.ReadInteger('STKit2', 'SplineDetail',   16);
  fTopDownRenderH:= f.ReadInteger('STKit2', 'TopDownRenderH', 1024);
  fTopDownRenderV:= f.ReadInteger('STKit2', 'TopDownRenderV', 1024);
  fRenderMode    := RenderModeTypes(f.ReadInteger('STKit2', 'RenderMode', 3));
  fReduceDisplay := f.ReadBool   ('STKit2', 'ReduceDisplay',  true);
  fTraceSurface  := f.ReadBool   ('STKit2', 'Trace Surface',  true);

  FreeAndNil(f);

  if IsChanged then //Something's changed, e.g. WorkDir
    WriteOptions(aFileName);
end;


procedure TSKOptions.WriteOptions(aFileName:string);
var f:TIniFile;
begin
  f := TIniFile.Create(aFileName);

  f.WriteString ('STKit2', 'WR2 Folder',     fWorkDir);
  f.WriteString ('STKit2', 'Active Scenery', fActiveScenery);
  f.WriteInteger('STKit2', 'Frame Limit',    fFPSLag);
  f.WriteInteger('STKit2', 'ViewDistance',   fViewDistance);
  f.WriteInteger('STKit2', 'SplineDetail',   fSplineDetail);
  f.WriteInteger('STKit2', 'TopDownRenderH', fTopDownRenderH);
  f.WriteInteger('STKit2', 'TopDownRenderV', fTopDownRenderV);
  f.WriteInteger('STKit2', 'RenderMode',     byte(fRenderMode));
  f.WriteBool   ('STKit2', 'ReduceDisplay',  fReduceDisplay);
  f.WriteBool   ('STKit2', 'Trace Surface',  fTraceSurface);

  FreeAndNil(f);
end;


procedure TSKOptions.Save;
begin
  WriteOptions(fExeDir + STKit2_Data_Path + '\' + 'Options.ini');
end;

end.

