unit WR_PTX1;
interface
uses
  Forms, StdCtrls, Controls, FileCtrl, SysUtils, Graphics, Classes, Buttons,
  ExtCtrls, Dialogs, ComCtrls, Menus, Spin, Math, MMSystem,
  KromUtils,
  WR_PTX_TDisplayImage;

type
  TfmPTXTool = class(TForm)
    imgA: TImage;
    gbInfo: TGroupBox;
    Label1: TLabel;
    lbNoAlpha: TLabel;
    lbNoRGB: TLabel;
    Bevel_A: TBevel;
    Bevel_RGB: TBevel;
    sdSave: TSaveDialog;
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
    ImportBMPA: TMenuItem;
    MainMenu1: TMainMenu;
    ImportMenu: TMenuItem;
    ExportMenu: TMenuItem;
    mnuEdit: TMenuItem;
    mnuAbout: TMenuItem;
    mnuEditInvertAlpha: TMenuItem;
    mnuEditClearAlpha: TMenuItem;
    mnuExportBMPImage: TMenuItem;
    mnuExportBMPMask: TMenuItem;
    mnuExportTGAImageMask: TMenuItem;
    mnuImportBMPMask: TMenuItem;
    SaveMenu: TMenuItem;
    mnuSaveUncompressedPTX: TMenuItem;
    mnuSaveCompressedPTX: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    InvertA: TMenuItem;
    ClearA: TMenuItem;
    Label10: TLabel;
    seMipMapCount: TSpinEdit;
    Label2: TLabel;
    Panel1: TPanel;
    Label7: TLabel;
    Button1: TButton;
    CBnonPOT: TCheckBox;
    imgRGB: TImage;
    lbSize: TLabel;
    lbMipMaps: TLabel;
    lbCompression: TLabel;
    lbFadeColor: TLabel;
    lbRMS: TLabel;
    mnuEditAlphaFromColorKey: TMenuItem;
    mnuEditReplaceColorKeyWithAverage: TMenuItem;
    rgCompressionQuality: TRadioGroup;
    meLog: TMemo;
    procedure ExportClick(Sender: TObject);
    procedure ImportBMPClick(Sender: TObject);
    procedure SaveCompressedPTX(Sender: TObject);
    procedure ClearAlpha(Sender: TObject);
    procedure Form1Create(Sender: TObject);
    procedure AboutClick(Sender: TObject);
    procedure ShowMenu(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SaveUncompressedPTX(Sender: TObject);
    procedure InvertAlpha(Sender: TObject);
    procedure OpenFile(Sender: TObject);
    procedure seMipMapCountChange(Sender: TObject);
    procedure DisplayChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CBnonPOTClick(Sender: TObject);
    procedure SampleAClick(Sender: TObject);
    procedure imgRGBMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SampleRClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure mnuEditAlphaFromColorKeyClick(Sender: TObject);
    procedure mnuEditReplaceColorKeyWithAverageClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fVersionInfo: string;
    fStartWidth: Integer;
    fStartHeight: Integer;
    fExeDir, fWorkDir: string;
    fDisplayImage: TDisplayImage;

  fSampleColorKey: Boolean;
  fReplaceColorKey: Boolean;

    procedure SetRGB(aValue: Boolean);
    procedure SetAlpha(aValue: Boolean);
  end;


const
  TOOL_NAME = 'PTXTool';
  TOOL_VERSION = 'Version 2.3';


implementation
uses
  WR_AboutBox, WR_DXTCompressorColor;

{$R *.dfm}


{ TfmPTXTool }
procedure TfmPTXTool.Form1Create(Sender: TObject);
var
  I: TDXTCompressionHeuristics;
  t: Cardinal;
begin
  fVersionInfo := TOOL_VERSION + ' (' + FormatDateTime('YYY/MM/DD HH:MM', GetExeBuildTime) + ')';

  Caption := TOOL_NAME + ' ' + fVersionInfo;

  DoClientAreaResize(Self);
  fStartWidth := Width;
  fStartHeight := Height;

  fDisplayImage := TDisplayImage.Create(imgRGB, imgA);

  //CMDLine:='" " "C:\Documents and Settings\Krom\Desktop\Delphi\World Racing\00_ws_logo.2db"';
  FileListBox1.FileName := ExtractOpenedFileName(CMDLine);
  fExeDir  := ExtractFilePath(Application.ExeName);
  fWorkDir := ExtractFilePath(FileListBox1.FileName);
  if fWorkDir = '' then fWorkDir := fExeDir;
  OpenFile(nil);

  SetFocusedControl(FileListBox1);

  timeBeginPeriod(0);
                {
  meLog.Visible := DebugHook <> 0;

  if DebugHook <> 0 then
  begin
    FileListBox1.FileName := 'EnvMap.tga';
    OpenFile(nil);

    for I := Low(TDXTCompressionHeuristics) to High(TDXTCompressionHeuristics) do
    //if I in [chBest, chOld] then
    //if I in [chBest, chOld, chDLL] then
    begin
      t := timeGetTime;

      fDisplayImage.SaveCompressedPTX(Format('tmp%d.ptx', [Ord(I)]), I);

      meLog.Lines.Append(Format('%s - %s in %dms', [HEURISTIC_NAME[I], fDisplayImage.GetRMSString, timeGetTime - t]));

      DeleteFile(Format('EnvMap_ptx(RMS %s %s).ptx', [HEURISTIC_NAME[I], fDisplayImage.GetRMSString]));
      RenameFile(Format('tmp%d.ptx', [Ord(I)]), Format('EnvMap_ptx(RMS %s %s).ptx', [HEURISTIC_NAME[I], fDisplayImage.GetRMSString]));
    end;

    FileListBox1.Update;
  end;   //}
end;


procedure TfmPTXTool.FormDestroy(Sender: TObject);
begin
  timeEndPeriod(0);

  FreeAndNil(fDisplayImage);
end;


procedure TfmPTXTool.ImportBMPClick(Sender: TObject);
begin
  if not RunOpenDialog(Open1, '', fWorkDir, '24bit BMP files (*.bmp)|*.bmp') then Exit;

  if (Sender = ImportBMPA) or (Sender = mnuImportBMPMask) then
    fDisplayImage.ImportBitmapA(Open1.FileName);

  DisplayChange(nil);
end;


procedure TfmPTXTool.ExportClick(Sender: TObject);
begin
  if (Sender = ExportBMPA) or (Sender = mnuExportBMPMask) then
  begin
    if RunSaveDialog(sdSave, fDisplayImage.GetFileMask + '_A.bmp', fWorkDir, '24bit BMP files (*.bmp)|*.bmp', 'bmp') then
      fDisplayImage.ExportBitmapA(sdSave.FileName);
  end else
  if (Sender = ExportBMPRGB) or (Sender = mnuExportBMPImage) then
  begin
    if RunSaveDialog(sdSave, fDisplayImage.GetFileMask + '.bmp', fWorkDir, '24bit BMP files (*.bmp)|*.bmp', 'bmp') then
      fDisplayImage.ExportBitmapRGB(sdSave.FileName);
  end else
  if (Sender = ExportTGA) or (Sender = mnuExportTGAImageMask) then
  begin
    if RunSaveDialog(sdSave, fDisplayImage.GetFileMask + '.tga', fWorkDir, 'TGA files (*.tga)|*.tga', 'tga') then
      fDisplayImage.SaveTGA(sdSave.FileName);
  //  fDisplayImage.SaveTGA(fExeDir+'000.tga');
  end;
end;


procedure TfmPTXTool.ClearAlpha(Sender: TObject);
begin
  fDisplayImage.EditAlphaClear;
  SetAlpha(false);
  lbSize.Caption := fDisplayImage.GetInfoString;
end;


procedure TfmPTXTool.mnuEditAlphaFromColorKeyClick(Sender: TObject);
begin
  fSampleColorKey := not fSampleColorKey;
  if fSampleColorKey then
    Cursor := crHandPoint
  else
    Cursor := crDefault;
end;

procedure TfmPTXTool.SaveCompressedPTX(Sender: TObject);
var
  prevCursor: TCursor;
begin
  if not RunSaveDialog(sdSave, fDisplayImage.GetFileMask + '.ptx', fWorkDir, 'PTX files (*.ptx)|*.ptx', 'ptx') then Exit;
  //sdSave.FileName:='000.ptx';
  prevCursor   := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  seMipMapCountChange(nil);
  case rgCompressionQuality.ItemIndex of
    0:  fDisplayImage.SavePTXCompressed(sdSave.FileName, chOriginal);
    1:  fDisplayImage.SavePTXCompressed(sdSave.FileName, chBestPick);
  end;

  FileListBox1.Update;
  FileListBox1.FileName := sdSave.FileName;
  OpenFile(nil);
  Screen.Cursor := prevCursor;
end;


procedure TfmPTXTool.SaveUncompressedPTX(Sender: TObject);
var
  prevCursor: TCursor;
begin
  if not RunSaveDialog(sdSave, fDisplayImage.GetFileMask + '.ptx', fWorkDir, 'PTX files (*.ptx)|*.ptx', 'ptx') then Exit;

  prevCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  seMipMapCountChange(nil);
  fDisplayImage.SavePTXUncompressed(sdSave.FileName);
  FileListBox1.Update;
  FileListBox1.FileName := sdSave.FileName;
  FileListBox1.TopIndex := FileListBox1.ItemIndex;
  OpenFile(nil);

  Screen.Cursor := prevCursor;
end;


procedure TfmPTXTool.AboutClick(Sender: TObject);
const
  DESC = 'Create PTX image files for MBWR/WR2/AFC11' + EOL +
    'Opens: BMP, TGA, DDS, 2DB, PTX' + EOL +
    'Saves: BMP, TGA, PTX' + EOL +
    EOL +
    'Right-click on images to open actions menu';
begin
  AboutForm.Show(TOOL_NAME, fVersionInfo, DESC, TOOL_NAME);
end;


procedure TfmPTXTool.ShowMenu(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbRight then Exit;
  if Sender = imgRGB then PopupMenu1.Popup(Left+imgRGB.Left+2+X, Top+imgRGB.Top+40+Y);
  if Sender = imgA   then PopupMenu1.Popup(Left+imgA.Left+2+X, Top+imgA.Top+40+Y);
end;


procedure TfmPTXTool.InvertAlpha(Sender: TObject);
begin
  fDisplayImage.EditAlphaInvert;
end;


procedure TfmPTXTool.SetRGB(aValue: Boolean);
begin
  mnuSaveUncompressedPTX.Enabled  := aValue;
  mnuSaveCompressedPTX.Enabled    := aValue;
  ExportBMPRGB.Enabled            := aValue;
  mnuExportBMPImage.Enabled       := aValue;
  ImportBMPA.Enabled              := aValue;
  mnuImportBMPMask.Enabled        := aValue;
  ExportTGA.Enabled               := aValue;
  mnuExportTGAImageMask.Enabled   := aValue;
  seMipMapCount.Enabled                  := aValue;
  lbNoRGB.Visible                 := not aValue;
end;


procedure TfmPTXTool.SetAlpha(aValue: Boolean);
begin
  ClearA.Enabled              := aValue;
  mnuEditClearAlpha.Enabled   := aValue;
  InvertA.Enabled             := aValue;
  mnuEditInvertAlpha.Enabled  := aValue;
  ExportBMPA.Enabled          := aValue;
  mnuExportBMPMask.Enabled    := aValue;
  lbNoAlpha.Visible           := not aValue;
end;


procedure TfmPTXTool.OpenFile(Sender: TObject);
var
  fileName: string;
begin
  fileName := FileListBox1.FileName;
  if not FileExists(fileName) then Exit;
  fWorkDir := ExtractFilePath(FileListBox1.FileName);

  if LowerCase(ExtractFileExt(fileName)) = '.bmp' then fDisplayImage.OpenBMP(fileName);
  if LowerCase(ExtractFileExt(fileName)) = '.ptx' then fDisplayImage.OpenPTX(fileName);
  if LowerCase(ExtractFileExt(fileName)) = '.dds' then fDisplayImage.OpenDDS(fileName);
  if LowerCase(ExtractFileExt(fileName)) = '.xtx' then fDisplayImage.OpenXTX(fileName);
  if LowerCase(ExtractFileExt(fileName)) = '.tga' then fDisplayImage.OpenTGA(fileName);
  if LowerCase(ExtractFileExt(fileName)) = '.2db' then fDisplayImage.Open2DB(fileName);

  DisplayChange(nil);
end;


procedure TfmPTXTool.mnuEditReplaceColorKeyWithAverageClick(Sender: TObject);
begin
  fReplaceColorKey := not fReplaceColorKey;
  if fReplaceColorKey then
    Cursor := crHandPoint
  else
    Cursor := crDefault;
end;


procedure TfmPTXTool.seMipMapCountChange(Sender: TObject);
begin
  fDisplayImage.MipMapCount := seMipMapCount.Value;
  //todo: Add FlipVertical! (by Ast)
end;


procedure TfmPTXTool.DisplayChange(Sender: TObject);
begin
  if not fDisplayImage.DisplayImage then
  begin
    SetRGB(False);
    SetAlpha(False);
    Exit;
  end;

  // Now if DisplayImage didn't failed we assume RGB portion is loaded fine
  // and we can perform all needed tasks upon
  SetRGB(true);
  SetAlpha(fDisplayImage.GetAlpha);

  seMipMapCount.MaxValue := fDisplayImage.MaxMipMapCount;
  seMipMapCount.Value    := fDisplayImage.MipMapCount;

  gbInfo.Caption := ' ' + fDisplayImage.GetFileMask + fDisplayImage.GetChangedString + ' ';
  lbSize.Caption := fDisplayImage.GetInfoString;
  lbMipMaps.Caption := IntToStr(fDisplayImage.MipMapCount);
  lbCompression.Caption := fDisplayImage.GetFormatString;
  lbRMS.Caption := fDisplayImage.GetRMSString;
  lbFadeColor.Caption := fDisplayImage.GetFogString;
end;


procedure TfmPTXTool.Button1Click(Sender: TObject);
begin
  fDisplayImage.SaveMipMap(fWorkDir + '000sq.tga', 4);
end;


procedure TfmPTXTool.CBnonPOTClick(Sender: TObject);
begin
  fDisplayImage.AllowNonPOT := CBnonPOT.Checked;
end;


procedure TfmPTXTool.SampleAClick(Sender: TObject);
begin
  fSampleColorKey := not fSampleColorKey;
  if fSampleColorKey then
    Cursor := crHandPoint
  else
    Cursor := crDefault;
end;


procedure TfmPTXTool.imgRGBMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (not fSampleColorKey)and(not fReplaceColorKey) then exit;
  if fSampleColorKey then fDisplayImage.EditAlphaCreateFrom(X,Y);
  if fReplaceColorKey then fDisplayImage.EditColorReplaceWithAverage(X,Y);
  DisplayChange(nil);
  if fSampleColorKey then  SampleAClick(nil); //Release fSampleColorKey
  if fReplaceColorKey then SampleRClick(nil); //Release fReplaceColorKey
end;


procedure TfmPTXTool.SampleRClick(Sender: TObject);
begin
  fReplaceColorKey := not fReplaceColorKey;
  if fReplaceColorKey then
    Cursor := crHandPoint
  else
    Cursor := crDefault;
end;


procedure TfmPTXTool.FormResize(Sender: TObject);
const
  PAD = 8;
var
  fullWidth, halfWidth, fullHeight: Integer;
  imgSize: Integer;
begin
  fullWidth := ClientWidth - imgRGB.Left - PAD;
  fullHeight := ClientHeight - imgRGB.Top - PAD;
  halfWidth := (fullWidth - Pad) div 2;
  imgSize := Min(halfWidth, fullHeight);

  FileListBox1.Height := ClientHeight - FileListBox1.Top - PAD;

  Bevel_RGB.Width := halfWidth + 2;
  Bevel_A.Width := halfWidth + 2;
  imgRGB.Width := imgSize;
  imgA.Width := imgSize;
  meLog.Width := fullWidth;

  Bevel_A.Left := imgRGB.Left + halfWidth + PAD - 1;
  imgA.Left := imgRGB.Left + halfWidth + PAD;

  Bevel_RGB.Height := fullHeight;
  Bevel_A.Height := fullHeight;
  imgRGB.Height := imgSize;
  imgA.Height := imgSize;
  meLog.Height := fullHeight;

  // Center labels
  lbNoRGB.Left := imgRGB.Left + (imgSize - lbNoRGB.Width) div 2;
  lbNoAlpha.Left := imgA.Left + (imgSize - lbNoAlpha.Width) div 2;
  lbNoRGB.Top := imgRGB.Top + (imgSize - lbNoRGB.Height) div 2;
  lbNoAlpha.Top := imgA.Top + (imgSize - lbNoAlpha.Height) div 2;

  if fDisplayImage <> nil then
    DisplayChange(nil);
end;


end.
