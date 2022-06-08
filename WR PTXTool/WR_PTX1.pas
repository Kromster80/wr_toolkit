unit WR_PTX1;
interface
uses
  Forms, StdCtrls, Controls, FileCtrl, SysUtils, Graphics, Classes,
  ExtCtrls, Dialogs, ComCtrls, Menus, Spin, kromUtils, Math,
  WR_PTX_TDisplayImage, Buttons;

type
  TForm1 = class(TForm)
    Image_A: TImage;
    gbInfo: TGroupBox;
    Label1: TLabel;
    lbNoAlpha: TLabel;
    lbNoRGB: TLabel;
    Bevel_A: TBevel;
    Bevel_RGB: TBevel;
    Save1: TSaveDialog;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Open1: TOpenDialog;
    Label9: TLabel;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    ExportBMPRGB: TMenuItem;
    ExportBMPA: TMenuItem;
    ExportTGA: TMenuItem;
    ImportBMPRGB: TMenuItem;
    ImportBMPA: TMenuItem;
    ImportTGAImageMask1: TMenuItem;
    MainMenu1: TMainMenu;
    ImportMenu: TMenuItem;
    ExportMenu: TMenuItem;
    EditMenu: TMenuItem;
    AboutMenu: TMenuItem;
    InvertAlpha1: TMenuItem;
    ClearAlpha1: TMenuItem;
    SaveBMPImage1: TMenuItem;
    SaveBMPMask1: TMenuItem;
    SaveTGAImageMask1: TMenuItem;
    LoadBMPImage1: TMenuItem;
    LoadBMPMask1: TMenuItem;
    LoadTGAImageMask1: TMenuItem;
    SaveMenu: TMenuItem;
    SaveUncompressedPTX1: TMenuItem;
    SaveCompressedPTX1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    InvertA: TMenuItem;
    ClearA: TMenuItem;
    Label10: TLabel;
    SpinMM: TSpinEdit;
    Label2: TLabel;
    Panel1: TPanel;
    Label7: TLabel;
    Button1: TButton;
    CBnonPOT: TCheckBox;
    Image_RGB: TImage;
    lbSize: TLabel;
    lbMipMaps: TLabel;
    lbCompression: TLabel;
    lbFadeColor: TLabel;
    lbRMS: TLabel;
    Createalphafromcolorkey1: TMenuItem;
    Replacecolorkeywithaveragecolor1: TMenuItem;
    rgCompressionQuality: TRadioGroup;
    procedure ExportClick(Sender: TObject);
    procedure ImportBMPClick(Sender: TObject);
    procedure SaveCompressedPTX(Sender: TObject);
    procedure ClearAlpha(Sender: TObject);
    procedure Form1Create(Sender: TObject);
    procedure AboutClick(Sender: TObject);
    procedure ShowMenu(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SaveUncompressedPTX(Sender: TObject);
    procedure ImportTGAClick(Sender: TObject);
    procedure InvertAlpha(Sender: TObject);
    procedure SetRGB(Value:boolean);
    procedure SetAlpha(Value:boolean);
    procedure OpenFile(Sender: TObject);
    procedure SpinMMChange(Sender: TObject);
    procedure DisplayChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CBnonPOTClick(Sender: TObject);
    procedure SampleAClick(Sender: TObject);
    procedure Image_RGBMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SampleRClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Createalphafromcolorkey1Click(Sender: TObject);
    procedure Replacecolorkeywithaveragecolor1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fVersionInfo: string;
    fStartWidth: Integer;
    fStartHeight: Integer;
    fBitmapRGB: TBitmap;
    fBitmapA: TBitmap;
    fExeDir, fWorkDir: string;
    fDisplayImage: TDisplayImage;
  end;


const
  TOOL_NAME = 'PTXTool';
  TOOL_VERSION = 'Version 2.3';


var
  SampleColorKey: Boolean;
  ReplaceColorKey: Boolean;


implementation
uses
  WR_AboutBox, WR_PTX_TDXT_Color;

{$R *.dfm}


{ TForm1 }
procedure TForm1.Form1Create(Sender: TObject);
var
  I: TCompressionHeuristics;
begin
  fVersionInfo := TOOL_VERSION + ' (' + FormatDateTime('YYY/MM/DD HH:MM', GetExeBuildTime) + ')';

  Caption := TOOL_NAME + ' ' + fVersionInfo;

  DoClientAreaResize(Self);
  fStartWidth := Width;
  fStartHeight := Height;

  fBitmapRGB := TBitmap.Create;
  fBitmapA := TBitmap.Create;
  fDisplayImage := TDisplayImage.Create(fBitmapRGB, fBitmapA, Image_RGB, Image_A);

  //CMDLine:='" " "C:\Documents and Settings\Krom\Desktop\Delphi\World Racing\00_ws_logo.2db"';
  FileListBox1.FileName := ExtractOpenedFileName(CMDLine);
  fExeDir  := ExtractFilePath(Application.ExeName);
  fWorkDir := ExtractFilePath(FileListBox1.FileName);
  if fWorkDir = '' then fWorkDir := fExeDir;
  OpenFile(nil);

  SetFocusedControl(FileListBox1);
                {
  if DebugHook <> 0 then
  begin
    FileListBox1.FileName := 'EnvMap.tga';
    OpenFile(nil);

    for I := Low(TCompressionHeuristics) to High(TCompressionHeuristics) do
    //if I in [chBest, chOld] then
    if I in [chBest, chOld, chDLL] then
    begin
      fDisplayImage.SaveCompressedPTX(Format('EnvMap.%d.ptx', [Ord(I)]), I);
      DeleteFile(Format('EnvMap_ptx(RMS %s %s).ptx', [HEURISTIC_NAME[I], fDisplayImage.GetRMSString]));
      RenameFile(Format('EnvMap.%d.ptx', [Ord(I)]), Format('EnvMap_ptx(RMS %s %s).ptx', [HEURISTIC_NAME[I], fDisplayImage.GetRMSString]));
    end;

    FileListBox1.Update;
  end;   //}
end;


procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDisplayImage);
  FreeAndNil(fBitmapRGB);
  FreeAndNil(fBitmapA);
end;


procedure TForm1.ImportBMPClick(Sender: TObject);
begin
  if not RunOpenDialog(Open1, '', fWorkDir, '24bit BMP files (*.bmp)|*.bmp') then Exit;

  if (Sender=ImportBMPRGB)or(Sender=LoadBMPImage1) then
    fDisplayImage.ImportBitmapRGB(Open1.FileName);
  if (Sender=ImportBMPA)or(Sender=LoadBMPMask1) then
    fDisplayImage.ImportBitmapA(Open1.FileName);

  DisplayChange(nil);
end;


procedure TForm1.ImportTGAClick(Sender: TObject);
begin
  if not RunOpenDialog(Open1, '', fWorkDir, 'TGA image files (*.tga)|*.tga') then Exit;

  fDisplayImage.OpenTGA(Open1.FileName);
  DisplayChange(nil);
end;

procedure TForm1.ExportClick(Sender: TObject);
begin
  if (Sender = ExportBMPA) or (Sender = SaveBMPMask1) then
  begin
    if RunSaveDialog(Save1, fDisplayImage.GetFileMask + '_A.bmp', fWorkDir, '24bit BMP files (*.bmp)|*.bmp', 'bmp') then
      fDisplayImage.ExportBitmapA(Save1.FileName);
  end else
  if (Sender = ExportBMPRGB) or (Sender = SaveBMPImage1) then
  begin
    if RunSaveDialog(Save1, fDisplayImage.GetFileMask + '.bmp', fWorkDir, '24bit BMP files (*.bmp)|*.bmp', 'bmp') then
      fDisplayImage.ExportBitmapRGB(Save1.FileName);
  end else
  if (Sender = ExportTGA) or (Sender = SaveTGAImageMask1) then
  begin
    if RunSaveDialog(Save1, fDisplayImage.GetFileMask + '.tga', fWorkDir, 'TGA files (*.tga)|*.tga', 'tga') then
      fDisplayImage.SaveTGA(Save1.FileName);
  //  fDisplayImage.SaveTGA(fExeDir+'000.tga');
  end;
end;


procedure TForm1.ClearAlpha(Sender: TObject);
begin
  fDisplayImage.ClearAlpha;
  SetAlpha(false);
  lbSize.Caption := fDisplayImage.GetInfoString;
end;


procedure TForm1.Createalphafromcolorkey1Click(Sender: TObject);
begin
  SampleColorKey := not SampleColorKey;
  if SampleColorKey then
    Cursor := crHandPoint
  else
    Cursor := crDefault;
end;

procedure TForm1.SaveCompressedPTX(Sender: TObject);
var
  Save_Cursor: TCursor;
begin
  SpinMMChange(nil);
  if not RunSaveDialog(Save1, fDisplayImage.GetFileMask+'.ptx', fWorkDir, 'PTX files (*.ptx)|*.ptx', 'ptx') then Exit;
  //Save1.FileName:='000.ptx';
  Save_Cursor   := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  case rgCompressionQuality.ItemIndex of
    0:  fDisplayImage.SaveCompressedPTX(Save1.FileName, chOld);
    1:  fDisplayImage.SaveCompressedPTX(Save1.FileName, chBest);
  end;

  FileListBox1.Update;
  FileListBox1.FileName := Save1.FileName;
  OpenFile(nil);
  Screen.Cursor := Save_Cursor;
end;


procedure TForm1.SaveUncompressedPTX(Sender: TObject);
var Save_Cursor:TCursor;
begin
  SpinMMChange(nil);
  if not RunSaveDialog(Save1, fDisplayImage.GetFileMask+'.ptx', fWorkDir, 'PTX files (*.ptx)|*.ptx', 'ptx') then Exit;
  Save_Cursor   := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  fDisplayImage.SaveUncompressedPTX(Save1.FileName);
  FileListBox1.Update;
  FileListBox1.FileName := Save1.FileName;
  FileListBox1.TopIndex := FileListBox1.ItemIndex;
  OpenFile(nil);
  Screen.Cursor := Save_Cursor;
end;


procedure TForm1.AboutClick(Sender: TObject);
const
  DESC = 'Create PTX image files for MBWR/WR2/AFC11' + EOL +
    'Opens: BMP, TGA, DDS, 2DB, PTX' + EOL +
    'Saves: BMP, TGA, PTX' + EOL +
    EOL +
    'Right-click on images to open actions menu';
begin
  AboutForm.Show(TOOL_NAME, fVersionInfo, DESC, TOOL_NAME);
end;


procedure TForm1.ShowMenu(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbRight then Exit;
  if Sender = Image_RGB then PopupMenu1.Popup(Left+Image_RGB.Left+2+X, Top+Image_RGB.Top+40+Y);
  if Sender = Image_A   then PopupMenu1.Popup(Left+Image_A.Left+2+X, Top+Image_A.Top+40+Y);
end;


procedure TForm1.InvertAlpha(Sender: TObject);
begin
  fDisplayImage.InvertAlpha;
end;

procedure TForm1.SetRGB(Value: Boolean);
begin
  SaveUnCompressedPTX1.Enabled  := Value;
  SaveCompressedPTX1.Enabled    := Value;
  ExportBMPRGB.Enabled          := Value;
  SaveBMPImage1.Enabled         := Value;
  ImportBMPA.Enabled            := Value;
  LoadBMPMask1.Enabled          := Value;
  ExportTGA.Enabled             := Value;
  SaveTGAImageMask1.Enabled     := Value;
  SpinMM.Enabled                := Value;
  lbNoAlpha.Visible             := not Value; //Hide
end;


procedure TForm1.SetAlpha(Value: Boolean);
begin
  ClearA.Enabled        := Value;
  ClearAlpha1.Enabled   := Value;
  InvertA.Enabled       := Value;
  InvertAlpha1.Enabled  := Value;
  ExportBMPA.Enabled    := Value;
  SaveBMPMask1.Enabled  := Value;
  lbNoAlpha.Visible     := not Value; //Hide
end;


procedure TForm1.OpenFile(Sender: TObject);
var
  fileName: string;
begin
  fileName := FileListBox1.FileName;
  if not FileExists(fileName) then Exit;
  fWorkDir := ExtractFilePath(FileListBox1.FileName);

  if LowerCase(ExtractFileExt(fileName)) = '.ptx' then fDisplayImage.OpenPTX(fileName);
  if LowerCase(ExtractFileExt(fileName)) = '.dds' then fDisplayImage.OpenDDS(fileName);
  if LowerCase(ExtractFileExt(fileName)) = '.xtx' then fDisplayImage.OpenXTX(fileName);
  if LowerCase(ExtractFileExt(fileName)) = '.tga' then fDisplayImage.OpenTGA(fileName);
  if LowerCase(ExtractFileExt(fileName)) = '.2db' then fDisplayImage.Open2DB(fileName);

  DisplayChange(nil);
end;


procedure TForm1.Replacecolorkeywithaveragecolor1Click(Sender: TObject);
begin
  ReplaceColorKey := not ReplaceColorKey;
  if ReplaceColorKey then
    Cursor := crHandPoint
  else
    Cursor := crDefault;
end;

procedure TForm1.SpinMMChange(Sender: TObject);
begin
  fDisplayImage.SetMipMapQtyUse := (SpinMM.Value);
  //todo: Add FlipVertical! (by Ast)
end;


procedure TForm1.DisplayChange(Sender: TObject);
begin
  if not fDisplayImage.DisplayImage then
  begin
    SetRGB(false);
    SetAlpha(false);
    exit;
  end;
  //Now if DisplayImage didn't failed we assume RGB portion is loaded fine
  //and we can perform all needed tasks upon
  SetRGB(true);
  SetAlpha(fDisplayImage.GetAlpha);

  SpinMM.MaxValue := fDisplayImage.GetMaxMipMapQty;
  SpinMM.Value    := fDisplayImage.GetMipMapQtyUse;

  gbInfo.Caption := ' ' + fDisplayImage.GetFileMask + fDisplayImage.GetChangedString + ' ';
  lbSize.Caption := fDisplayImage.GetInfoString;
  lbMipMaps.Caption := IntToStr(fDisplayImage.GetMipMapQty);
  if fDisplayImage.GetCompression then
    lbCompression.Caption := 'Y'
  else
    lbCompression.Caption := 'Y';
  if fDisplayImage.GetPacked then
    lbCompression.Caption := lbCompression.Caption + '+Packed';
  lbRMS.Caption := fDisplayImage.GetRMSString;
  lbFadeColor.Caption := fDisplayImage.GetFogString;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  fDisplayImage.SaveMipMap(fWorkDir + '000sq.tga', 4);
end;


procedure TForm1.CBnonPOTClick(Sender: TObject);
begin
  fDisplayImage.AllowNonPOTImages := CBnonPOT.Checked;
end;


procedure TForm1.SampleAClick(Sender: TObject);
begin
  SampleColorKey := not SampleColorKey;
  if SampleColorKey then
    Cursor := crHandPoint
  else
    Cursor := crDefault;
end;


procedure TForm1.Image_RGBMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (not SampleColorKey)and(not ReplaceColorKey) then exit;
  if SampleColorKey then fDisplayImage.CreateAlphaFrom(X,Y);
  if ReplaceColorKey then fDisplayImage.ReplaceColorKeyWithAverage(X,Y);
  DisplayChange(nil);
  if SampleColorKey then  SampleAClick(nil); //Release SampleColorKey
  if ReplaceColorKey then SampleRClick(nil); //Release ReplaceColorKey
end;


procedure TForm1.SampleRClick(Sender: TObject);
begin
  ReplaceColorKey := not ReplaceColorKey;
  if ReplaceColorKey then
    Cursor := crHandPoint
  else
    Cursor := crDefault;
end;


procedure TForm1.FormResize(Sender: TObject);
const
  PAD = 8;
var
  fullWidth, halfWidth, fullHeight: Integer;
  imgSize: Integer;
begin
  fullWidth := ClientWidth - Image_RGB.Left - PAD;
  fullHeight := ClientHeight - Image_RGB.Top - PAD;
  halfWidth := (fullWidth - Pad) div 2;
  imgSize := Min(halfWidth, fullHeight);

  Bevel_RGB.Width := halfWidth + 2;
  Bevel_A.Width := halfWidth + 2;
  Image_RGB.Width := imgSize;
  Image_A.Width := imgSize;

  Bevel_A.Left := Image_RGB.Left + halfWidth + PAD - 1;
  Image_A.Left := Image_RGB.Left + halfWidth + PAD;

  Bevel_RGB.Height := fullHeight;
  Bevel_A.Height := fullHeight;
  Image_RGB.Height := imgSize;
  Image_A.Height := imgSize;

  if fDisplayImage <> nil then
    DisplayChange(nil);
end;


end.
