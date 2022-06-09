object fmPTXTool: TfmPTXTool
  Left = 56
  Top = 143
  HorzScrollBar.Smooth = True
  VertScrollBar.Smooth = True
  Caption = 'PTXTool'
  ClientHeight = 361
  ClientWidth = 737
  Color = clBtnFace
  Constraints.MinHeight = 419
  Constraints.MinWidth = 737
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = Form1Create
  OnDestroy = FormDestroy
  OnResize = FormResize
  DesignSize = (
    737
    361)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel_RGB: TBevel
    Left = 207
    Top = 95
    Width = 258
    Height = 258
  end
  object Bevel_A: TBevel
    Left = 470
    Top = 95
    Width = 258
    Height = 258
  end
  object imgA: TImage
    Left = 471
    Top = 96
    Width = 256
    Height = 256
    OnMouseDown = imgMouseDown
  end
  object imgRGB: TImage
    Left = 208
    Top = 96
    Width = 256
    Height = 256
    OnMouseDown = imgMouseDown
    OnMouseUp = imgMouseUp
  end
  object lbNoAlpha: TLabel
    Left = 567
    Top = 218
    Width = 50
    Height = 13
    Caption = ' No Alpha '
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object lbNoRGB: TLabel
    Left = 305
    Top = 218
    Width = 46
    Height = 13
    Caption = ' No RGB '
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object gbInfo: TGroupBox
    Left = 208
    Top = 7
    Width = 305
    Height = 81
    Caption = '  File Name  '
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 18
      Width = 23
      Height = 13
      Caption = 'Size:'
    end
    object Label9: TLabel
      Left = 8
      Top = 50
      Width = 35
      Height = 13
      Caption = 'Format:'
    end
    object Label5: TLabel
      Left = 8
      Top = 34
      Width = 46
      Height = 13
      Caption = 'MipMaps:'
    end
    object Label10: TLabel
      Left = 144
      Top = 18
      Width = 53
      Height = 13
      Caption = 'Fade color:'
    end
    object Label2: TLabel
      Left = 198
      Top = 53
      Width = 87
      Height = 13
      Caption = 'Set MipMap levels'
    end
    object Label7: TLabel
      Left = 144
      Top = 34
      Width = 27
      Height = 13
      Caption = 'RMS:'
    end
    object lbSize: TLabel
      Left = 34
      Top = 18
      Width = 94
      Height = 13
      Caption = '<<>> x <<>> x <<>>'
    end
    object lbMipMaps: TLabel
      Left = 56
      Top = 34
      Width = 24
      Height = 13
      Caption = '<<>>'
    end
    object lbFormat: TLabel
      Left = 46
      Top = 50
      Width = 24
      Height = 13
      Caption = '<<>>'
    end
    object lbFadeColor: TLabel
      Left = 200
      Top = 18
      Width = 24
      Height = 13
      Caption = '<<>>'
    end
    object lbRMS: TLabel
      Left = 174
      Top = 34
      Width = 24
      Height = 13
      Caption = '<<>>'
    end
    object seMipMapCount: TSpinEdit
      Left = 144
      Top = 50
      Width = 49
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 16
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Value = 16
      OnChange = seMipMapCountChange
    end
    object Panel1: TPanel
      Left = 136
      Top = 16
      Width = 2
      Height = 57
      BevelOuter = bvLowered
      Caption = 'Panel1'
      TabOrder = 1
    end
  end
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 9
    Width = 129
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 0
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 32
    Width = 193
    Height = 129
    FileList = FileListBox1
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
  end
  object FileListBox1: TFileListBox
    Left = 8
    Top = 168
    Width = 193
    Height = 185
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    Mask = '*.bmp;*.ptx;*.dds;*.tga;*.2db;*.xtx'
    TabOrder = 2
    OnClick = OpenFile
  end
  object btnSaveMipMap: TButton
    Left = 480
    Top = 104
    Width = 121
    Height = 25
    Caption = 'Export MipMap Level'
    Enabled = False
    TabOrder = 4
    Visible = False
    OnClick = btnSaveMipMapClick
  end
  object cbAllowNPOT: TCheckBox
    Left = 520
    Top = 52
    Width = 209
    Height = 17
    Caption = 'Allow non-POT images (no use in-game)'
    TabOrder = 5
    OnClick = cbAllowNPOTClick
  end
  object rgCompressionQuality: TRadioGroup
    Left = 520
    Top = 8
    Width = 201
    Height = 41
    Caption = ' Compression quality '
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Low (fast)'
      'High (slow)')
    TabOrder = 6
  end
  object meLog: TMemo
    Left = 208
    Top = 96
    Width = 169
    Height = 81
    TabOrder = 7
    Visible = False
  end
  object sdSave: TSaveDialog
    DefaultExt = 'bmp'
    InitialDir = '.'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 679
    Top = 319
  end
  object Open1: TOpenDialog
    InitialDir = '.'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 651
    Top = 319
  end
  object pmMenu: TPopupMenu
    Left = 623
    Top = 319
    object pmImportBMPA: TMenuItem
      Caption = 'Import BMP Mask'
      Enabled = False
      OnClick = ImportBMPClick
    end
    object N1: TMenuItem
      Caption = '-'
      Enabled = False
    end
    object pmExportBMPRGB: TMenuItem
      Caption = 'Export BMP Image'
      Enabled = False
      OnClick = ExportClick
    end
    object pmExportBMPA: TMenuItem
      Caption = 'Export BMP Mask'
      Enabled = False
      OnClick = ExportClick
    end
    object pmExportTGA: TMenuItem
      Caption = 'Export TGA Image/Mask'
      Enabled = False
      OnClick = ExportClick
    end
    object N2: TMenuItem
      Caption = '-'
      Enabled = False
    end
    object pmInvertAlpha: TMenuItem
      Caption = 'Invert Alpha'
      Enabled = False
      OnClick = btnAlphaInvertClick
    end
    object pmClearAlpha: TMenuItem
      Caption = 'Clear Alpha'
      Enabled = False
      OnClick = btnAlphaClearClick
    end
  end
  object MainMenu1: TMainMenu
    Left = 595
    Top = 319
    object ImportMenu: TMenuItem
      Caption = 'Import'
      object mnuImportBMPMask: TMenuItem
        Caption = 'BMP Mask ...'
        Enabled = False
        OnClick = ImportBMPClick
      end
    end
    object ExportMenu: TMenuItem
      Caption = 'Export'
      object mnuExportBMPImage: TMenuItem
        Caption = 'BMP Image ...'
        Enabled = False
        OnClick = ExportClick
      end
      object mnuExportBMPMask: TMenuItem
        Caption = 'BMP Mask ...'
        Enabled = False
        OnClick = ExportClick
      end
      object mnuExportTGAImageMask: TMenuItem
        Caption = 'TGA Image/Mask ...'
        Enabled = False
        OnClick = ExportClick
      end
    end
    object SaveMenu: TMenuItem
      Caption = 'Save'
      object mnuSaveUncompressedPTX: TMenuItem
        Caption = 'Uncompressed PTX ...'
        Enabled = False
        OnClick = SaveUncompressedPTX
      end
      object mnuSaveCompressedPTX: TMenuItem
        Caption = 'Compressed PTX ...'
        Enabled = False
        OnClick = SaveCompressedPTX
      end
    end
    object mnuEdit: TMenuItem
      Caption = 'Edit'
      object mnuEditInvertAlpha: TMenuItem
        Caption = 'Invert Alpha'
        Enabled = False
        OnClick = btnAlphaInvertClick
      end
      object mnuEditClearAlpha: TMenuItem
        Caption = 'Clear Alpha'
        Enabled = False
        OnClick = btnAlphaClearClick
      end
      object mnuEditAlphaFromColorKey: TMenuItem
        Caption = 'Create alpha from color-key'
        OnClick = mnuEditAlphaFromColorKeyClick
      end
      object mnuEditReplaceColorKeyWithAverage: TMenuItem
        Caption = 'Replace color-key with average color'
        OnClick = mnuEditReplaceColorKeyWithAverageClick
      end
    end
    object mnuAbout: TMenuItem
      Caption = 'About'
      OnClick = AboutClick
    end
  end
end
