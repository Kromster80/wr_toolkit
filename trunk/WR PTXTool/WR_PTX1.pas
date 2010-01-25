unit WR_PTX1;
{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}
interface
uses
{$IFDEF FPC}
  LCLIntf, LResources,
{$ENDIF}
Forms, StdCtrls, Controls, FileCtrl, SysUtils, Graphics, Classes,
ExtCtrls, Dialogs, ComCtrls, Menus, Spin, kromUtils, Math,
WR_PTX_TDisplayImage, Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image_A: TImage;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel_A: TBevel;
    Bevel_RGB: TBevel;
    Save1: TSaveDialog;
{$IFDEF VER140}
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
{$ENDIF}
    FileListBox1: TFileListBox;
    Open1: TOpenDialog;
    LabelCom: TLabel;
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
    LabelR: TLabel;
    SpinMM: TSpinEdit;
    Label2: TLabel;
    Panel1: TPanel;
    Label7: TLabel;
    Button1: TButton;
    CBnonPOT: TCheckBox;
    ButtonA: TBitBtn;
    ButtonR: TBitBtn;
    Label6: TLabel;
    Label8: TLabel;
    Image_RGB: TImage;
    procedure ExportClick(Sender: TObject);
    procedure ImportBMPClick(Sender: TObject);
    procedure SaveCompressedPTX(Sender: TObject);
    procedure ClearAlpha(Sender: TObject);
    procedure Form1Init(Sender: TObject);
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
  end;


const
  VersionInfo = 'Version 2.1b           (24 Apr 2009)';


var
  Form1: TForm1;
  BitmA, Bitm:Tbitmap;
  ExeDir, WorkDir:string;

  fDisplayImage:TDisplayImage;

  SampleColorKey:boolean;
  ReplaceColorKey:boolean;

implementation
{$IFDEF VER140}
  {$R *.dfm}
{$ENDIF}

uses WR_AboutBox;


procedure TForm1.Form1Init(Sender: TObject);
begin
  Bitm  := Tbitmap.Create;
  BitmA := Tbitmap.Create;
  fDisplayImage := TDisplayImage.Create(Bitm, BitmA, Image_RGB, Image_A);

  //CMDLine:='" " "C:\Documents and Settings\Krom\Desktop\Delphi\World Racing\00_ws_logo.2db"';
  FileListBox1.FileName := ExtractOpenedFileName(CMDLine);
  ExeDir  := ExtractFilePath(Application.ExeName);
  WorkDir := ExtractFilePath(FileListBox1.FileName);
  if WorkDir = '' then WorkDir := ExeDir;
  OpenFile(nil);
  //fDisplayImage.SaveCompressedPTX(ExeDir+'000.ptx');
  //FileListBox1.Update;
  //FileListBox1.FileName:='000.ptx';
  //OpenFile(nil);
  Form1.Caption := 'PTXTool ' + VersionInfo;
  {$IFDEF FPC} FileListBox1.Directory := ExeDir; {$ENDIF}
end;

procedure TForm1.ImportBMPClick(Sender: TObject);
begin
  if not RunOpenDialog(Open1,'',WorkDir,'24bit BMP files (*.bmp)|*.bmp') then exit;

  if (Sender=ImportBMPRGB)or(Sender=LoadBMPImage1) then
    fDisplayImage.ImportBitmapRGB(Open1.FileName);
  if (Sender=ImportBMPA)or(Sender=LoadBMPMask1) then
    fDisplayImage.ImportBitmapA(Open1.FileName);

  DisplayChange(nil);
end;

procedure TForm1.ImportTGAClick(Sender: TObject);
begin
  if not RunOpenDialog(Open1,'',WorkDir,'TGA image files (*.tga)|*.tga') then exit;
  fDisplayImage.OpenTGA(Open1.FileName);
  DisplayChange(nil);
end;

procedure TForm1.ExportClick(Sender: TObject);
begin
  if (Sender=ExportBMPA)or(Sender=SaveBMPMask1) then begin
    if not RunSaveDialog(Save1,fDisplayImage.GetFileMask+'_A.bmp',WorkDir,'24bit BMP files (*.bmp)|*.bmp','bmp') then exit;
    fDisplayImage.ExportBitmapA(Save1.FileName)
  end else
  if (Sender=ExportBMPRGB)or(Sender=SaveBMPImage1) then begin
    if not RunSaveDialog(Save1,fDisplayImage.GetFileMask+'.bmp',WorkDir,'24bit BMP files (*.bmp)|*.bmp','bmp') then exit;
    fDisplayImage.ExportBitmapRGB(Save1.FileName)
  end else
  if (Sender=ExportTGA)or(Sender=SaveTGAImageMask1) then begin
    if not RunSaveDialog(Save1,fDisplayImage.GetFileMask+'.tga',WorkDir,'TGA files (*.tga)|*.tga','tga') then exit;
    fDisplayImage.SaveTGA(Save1.FileName);
  //  fDisplayImage.SaveTGA(ExeDir+'000.tga');
  end;
end;

procedure TForm1.ClearAlpha(Sender: TObject);
begin
  fDisplayImage.ClearAlpha;
  SetAlpha(false);
  Label1.Caption := fDisplayImage.GetInfoString;
end;

procedure TForm1.SaveCompressedPTX(Sender: TObject);
var Save_Cursor:TCursor;
begin
  SpinMMChange(nil);
  if not RunSaveDialog(Save1, fDisplayImage.GetFileMask+'.ptx', WorkDir, 'PTX files (*.ptx)|*.ptx', 'ptx') then exit;
  //Save1.FileName:='000.ptx';
  Save_Cursor   := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  fDisplayImage.SaveCompressedPTX(Save1.FileName);
  FileListBox1.Update;
  FileListBox1.FileName := Save1.FileName;
  OpenFile(nil);
  Screen.Cursor := Save_Cursor;
end;

procedure TForm1.SaveUncompressedPTX(Sender: TObject);
var Save_Cursor:TCursor;
begin
  SpinMMChange(nil);
  if not RunSaveDialog(Save1, fDisplayImage.GetFileMask+'.ptx', WorkDir, 'PTX files (*.ptx)|*.ptx', 'ptx') then exit;
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
var s:string;
begin
s:='Create PTX image files for MBWR/WR2/AFC11'+eol+
   'Opens: BMP, TGA, DDS, 2DB, PTX'+eol+
   'Saves: BMP, TGA, PTX'+eol+eol+
   'Right-click on images to open actions menu';
AboutForm.Show(VersionInfo, s, 'PTXTool');
end;

procedure TForm1.ShowMenu(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbRight then exit;
  if Sender = Image_RGB then PopupMenu1.Popup(Form1.Left+Image_RGB.Left+2+X,Form1.Top+Image_RGB.Top+40+Y);
  if Sender = Image_A   then PopupMenu1.Popup(Form1.Left+Image_A.Left+2+X,Form1.Top+Image_A.Top+40+Y);
end;


procedure TForm1.InvertAlpha(Sender: TObject);
begin
  fDisplayImage.InvertAlpha;
end;

procedure TForm1.SetRGB(Value:boolean);
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
  Label4.Visible                := not Value; //Hide
end;

procedure TForm1.SetAlpha(Value:boolean);
begin
  ClearA.Enabled        := Value;
  ClearAlpha1.Enabled   := Value;
  InvertA.Enabled       := Value;
  InvertAlpha1.Enabled  := Value;
  ExportBMPA.Enabled    := Value;
  SaveBMPMask1.Enabled  := Value;
  Label3.Visible        := not Value; //Hide
end;

procedure TForm1.OpenFile(Sender: TObject);
var FileName:string;
begin
  FileName := FileListBox1.FileName;
  if not fileexists(FileName) then exit;
  WorkDir := ExtractFilePath(FileListBox1.FileName);
  if GetFileExt(FileName)='PTX' then fDisplayImage.OpenPTX(FileName);
  if GetFileExt(FileName)='DDS' then fDisplayImage.OpenDDS(FileName);
  if GetFileExt(FileName)='TGA' then fDisplayImage.OpenTGA(FileName);
  if GetFileExt(FileName)='2DB' then fDisplayImage.Open2DB(FileName);
  DisplayChange(nil);
end;

procedure TForm1.SpinMMChange(Sender: TObject);
begin
  fDisplayImage.SetMipMapQtyUse:=(SpinMM.Value);
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

  GroupBox1.Caption := ' '+fDisplayImage.GetFileMask+fDisplayImage.GetChangedString+' ';
  Label1.Caption := fDisplayImage.GetInfoString;
  Label5.Caption := inttostr(fDisplayImage.GetMipMapQty)+' MipMap levels';
  if fDisplayImage.GetCompression then
    LabelCom.Caption:='Compressed'
  else
    LabelCom.Caption:='Uncompressed';
  if fDisplayImage.GetPacked then
    LabelCom.Caption:=LabelCom.Caption+' Packed';
  Label7.Caption := fDisplayImage.GetRMSString;
  LabelR.Caption := 'Fade color  '+fDisplayImage.GetFogString;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  fDisplayImage.SaveMipMap(WorkDir+'000sq.tga', 4);
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
  if ReplaceColorKey then fDisplayImage.ReplaceColorKeyFrom(X,Y);
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
var AddSize:integer;
begin
  AddSize := Math.min((Form1.Width-707) div 2, Form1.Height-401);

  Bevel_RGB.Width := 258 + AddSize;
  Image_RGB.Width := 256 + AddSize;
  Bevel_A.Width := 258 + AddSize;
  Image_A.Width := 256 + AddSize;
  Bevel_A.Left := 439 + AddSize;
  Image_A.Left := 440 + AddSize;

  Bevel_RGB.Height := 258 + AddSize;
  Image_RGB.Height := 256 + AddSize;
  Bevel_A.Height := 258 + AddSize;
  Image_A.Height := 256 + AddSize;

  DisplayChange(nil);
end;

initialization
{$IFDEF FPC}
  {$I WR_PTX1.lrs}
{$ENDIF}


end.
