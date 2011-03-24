program STKit2;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit_Defaults in 'Unit_Defaults.pas',
  Unit_Render in 'Unit_Render.pas',
  PTXTexture in '..\_Common_\PTXTexture.pas',
  LoadObjects in 'LoadObjects.pas',
  LoadSave in 'LoadSave.pas',
  Load_TRK in 'Load_TRK.pas',
  Unit_sc2 in 'Unit_sc2.pas',
  Unit_Streets in 'Unit_Streets.pas',
  Unit_Options in 'Unit_Options.pas' {FormOptions},
  Unit_RoutineFunctions in 'Unit_RoutineFunctions.pas',
  Unit_Triggers in 'Unit_Triggers.pas',
  ColorPicker in '..\_Common_\ColorPicker.pas' {Form_ColorPicker},
  Unit_RenderInit in 'Unit_RenderInit.pas',
  Unit_Tracing in 'Unit_Tracing.pas',
  WR_AboutBox in '..\_Common_\WR_AboutBox.pas' {AboutForm},
  SK_Options in 'SK_Options.pas',
  SK_ImportLWO in 'SK_ImportLWO.pas',
  Unit_Grass in 'Unit_Grass.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'STKit2';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormOptions, FormOptions);
  Application.CreateForm(TForm_ColorPicker, Form_ColorPicker);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;

end.


