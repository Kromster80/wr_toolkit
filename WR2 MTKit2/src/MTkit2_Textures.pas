unit MTkit2_Textures;
interface
uses
  Buttons, Classes, ComCtrls, Controls, Dialogs, ExtCtrls, FileCtrl, Forms,
  Graphics, INIFiles, Math, Menus, ShellCtrls, Spin, StdCtrls, SysUtils, Windows,
  Messages,

  dglOpenGL, FloatSpinEdit, KromOGLUtils, KromUtils, TGATexture, PTXTexture,

  MTkit2_Defaults, MTkit2_Render, MTkit2_RenderLegacy, MTkit2_IO, MTkit2_MOX, MTkit2_Tree, MTkit2_Vertex;


  function TryToLoadTexture(const aFolder, aFilename: string): cardinal;


implementation


function TryToLoadTexture(const aFolder, aFilename: string): Cardinal;
var
  fname: string;
begin
  Result := 0;

  // Try in following order:
  // Textures_PC\tga > Textures\tga > Textures_PC\ptx > Textures\ptx
  fname := ChangeFileExt(aFileName, '');
  if FileExists(aFolder + '\Textures_PC\' + fname + '.tga') then
    LoadTexture(aFolder + '\Textures_PC\' + fname + '.tga', Result, 0)
  else
  if FileExists(aFolder + '\Textures\' + fname + '.tga') then
    LoadTexture(aFolder + '\Textures\' + fname + '.tga', Result, 0)
  else
  if FileExists(aFolder + '\Textures_PC\' + fname + '.ptx') then
    LoadTexturePTX(aFolder + '\Textures_PC\' + fname + '.ptx', Result)
  else
  if FileExists(aFolder + '\Textures\' + fname + '.ptx') then
    LoadTexturePTX(aFolder + '\Textures\' + fname + '.ptx', Result);
end;


end.
