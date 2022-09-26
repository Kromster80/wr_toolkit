unit MTkit2_Textures;
interface
uses
  SysUtils,
  TGATexture, PTXTexture;


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
