unit SK_Options;
{$mode objfpc}{$H+}

interface

uses
  Classes, Forms, SysUtils, INIFiles, Defaults, Dialogs;

type
  TSKOptions = class
  private
    fExeDir:string;
    fWorkDir:string;
    fActiveScenery:string;
    fFPSLag:word;
    fViewDistance:word;
    fSplineDetail:word;
    fTopDownRenderH:word;
    fTopDownRenderV:word;
    fRenderMode:word;
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
    procedure Save;
  end;

implementation


constructor TSKOptions.Create;
begin
  Inherited;
  fExeDir        := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  ReadOptions(fExeDir + STKit2_Data_Path + '\' + 'Options.ini');
end;


procedure TSKOptions.ReadOptions(aFileName:string);
var f:TIniFile; IsChanged:boolean;
begin
  IsChanged := not FileExists(aFileName); //No file means new options will be filled

  f := TIniFile.Create(aFileName);

  fWorkDir       := f.ReadString ('STKit2', 'WR2 Folder',     '');

  if not DirectoryExists(fWorkDir) then begin
    SelectDirectory('Folder', '', fWorkDir);
    fWorkDir := IncludeTrailingPathDelimiter(fWorkDir);
    if not DirectoryExists(fWorkDir) then
      fWorkDir := ''; //Confirm that it's failed
    IsChanged := true;
  end;

  fActiveScenery := f.ReadString ('STKit2', 'Active Scenery', '');
  fFPSLag        := f.ReadInteger('STKit2', 'Frame Limit',    25); //25ms = 40fps

  {
  fAutosave      := f.ReadInteger('STKit2', 'ViewDistance',   650);
  fFastScroll    := f.ReadInteger('STKit2', 'SplineDetail',   5);
  fMouseSpeed    := f.ReadInteger('STKit2', 'TopDownRenderH', 1024);
  fLocale        := f.ReadInteger('STKit2', 'TopDownRenderV', 1024);
  fPace          := f.ReadInteger('STKit2', 'RenderMode',     3);
  fSpeedup       := f.ReadBool   ('STKit2', 'ReduceDisplay',  true);
  fSoundFXVolume := f.ReadBool   ('STKit2', 'Trace Surface',  true);
  }
  FreeAndNil(f);

  if IsChanged then //Something's changed, e.g. WorkDir
    WriteOptions(aFileName);
end;


procedure TSKOptions.WriteOptions(aFileName:string);
var f:TIniFile;
begin
  f := TIniFile.Create(aFileName);

  f.WriteString  ('STKit2', 'WR2 Folder',     fWorkDir);
  f.WriteString  ('STKit2', 'Active Scenery', fActiveScenery);
  f.WriteInteger ('STKit2', 'Frame Limit',    fFPSLag);


  fViewDistance  := f.ReadInteger('STKit2', 'ViewDistance',   650);
  fSplineDetail  := f.ReadInteger('STKit2', 'SplineDetail',   5);
  fTopDownRenderH:= f.ReadInteger('STKit2', 'TopDownRenderH', 1024);
  fTopDownRenderV:= f.ReadInteger('STKit2', 'TopDownRenderV', 1024);
  fRenderMode    := f.ReadInteger('STKit2', 'RenderMode',     3);
  fReduceDisplay := f.ReadBool   ('STKit2', 'ReduceDisplay',  true);
  fTraceSurface  := f.ReadBool   ('STKit2', 'Trace Surface',  true);

  FreeAndNil(f);
end;


procedure TSKOptions.Save;
begin
  WriteOptions(fExeDir + STKit2_Data_Path + '\' + 'Options.ini');
end;

end.

