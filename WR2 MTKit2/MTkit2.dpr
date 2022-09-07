program MTkit2;
uses
  Forms,
  MTkit2_Unit1 in 'MTkit2_Unit1.pas' {Form1},
  MTkit2_Defaults in 'MTkit2_Defaults.pas',
  MTkit2_IO in 'MTkit2_IO.pas',
  MTkit2_Render in 'MTkit2_Render.pas',
  MTkit2_RenderLegacy in 'MTkit2_RenderLegacy.pas',
  KromUtils in '..\_Common_\KromUtils.pas',
  ColorPicker in '..\_Common_\ColorPicker.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MTKit2';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm_ColorPicker, Form_ColorPicker);
  Application.Run;
end.
