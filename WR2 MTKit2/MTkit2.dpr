program MTkit2;
uses
  Forms,
  MTkit2_Unit1 in 'src\MTkit2_Unit1.pas' {Form1},
  MTkit2_Defaults in 'src\MTkit2_Defaults.pas',
  MTkit2_IO in 'src\MTkit2_IO.pas',
  MTkit2_MOX in 'src\MTkit2_MOX.pas',
  MTkit2_Tree in 'src\MTkit2_Tree.pas',
  MTkit2_Render in 'src\MTkit2_Render.pas',
  MTkit2_RenderLegacy in 'src\MTkit2_RenderLegacy.pas',
  MTkit2_Textures in 'src\MTkit2_Textures.pas',
  MTkit2_Vertex in 'src\MTkit2_Vertex.pas',
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
