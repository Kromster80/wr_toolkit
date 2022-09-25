program MTkit2;
uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,

  ColorPicker2 in '..\_Common_\ColorPicker2.pas' {Form2},
  KM_Colors in '..\_Common_\KM_Colors.pas',
  KM_Vertexes in '..\_Common_\KM_Vertexes.pas',
  KromUtils in '..\_Common_\KromUtils.pas',

  MTkit2_Unit1 in 'src\MTkit2_Unit1.pas' {Form1},
  MTkit2_COB in 'src\MTkit2_COB.pas',
  MTkit2_CPO in 'src\MTkit2_CPO.pas',
  MTkit2_Defaults in 'src\MTkit2_Defaults.pas',
  MTkit2_IO in 'src\MTkit2_IO.pas',
  MTkit2_MOX in 'src\MTkit2_MOX.pas',
  MTkit2_Tree in 'src\MTkit2_Tree.pas',
  MTkit2_Render in 'src\MTkit2_Render.pas',
  MTkit2_RenderLegacy in 'src\MTkit2_RenderLegacy.pas',
  MTkit2_Textures in 'src\MTkit2_Textures.pas',
  MTkit2_Vertex in 'src\MTkit2_Vertex.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MTKit2';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
