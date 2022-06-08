object Form1: TForm1
  Left = 56
  Top = 143
  HorzScrollBar.Smooth = True
  VertScrollBar.Smooth = True
  Caption = 'PTXTool'
  ClientHeight = 361
  ClientWidth = 721
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
    721
    361)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel_RGB: TBevel
    Left = 191
    Top = 95
    Width = 258
    Height = 258
  end
  object Bevel_A: TBevel
    Left = 454
    Top = 95
    Width = 258
    Height = 258
  end
  object Image_A: TImage
    Left = 455
    Top = 96
    Width = 256
    Height = 256
    OnMouseDown = ShowMenu
  end
  object lbNoAlpha: TLabel
    Left = 551
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
    Left = 289
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
  object Image_RGB: TImage
    Left = 192
    Top = 96
    Width = 256
    Height = 256
    OnMouseDown = ShowMenu
    OnMouseUp = Image_RGBMouseUp
  end
  object gbInfo: TGroupBox
    Left = 192
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
      Width = 60
      Height = 13
      Caption = 'Compression'
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
      Left = 32
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
    object lbCompression: TLabel
      Left = 72
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
      Left = 176
      Top = 34
      Width = 24
      Height = 13
      Caption = '<<>>'
    end
    object SpinMM: TSpinEdit
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
      OnChange = SpinMMChange
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
    Width = 177
    Height = 129
    FileList = FileListBox1
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
  end
  object FileListBox1: TFileListBox
    Left = 8
    Top = 168
    Width = 177
    Height = 185
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    Mask = '*.ptx;*.dds;*.tga;*.2db; *.xtx'
    TabOrder = 2
    OnClick = OpenFile
  end
  object Button1: TButton
    Left = 464
    Top = 104
    Width = 121
    Height = 25
    Caption = 'Export MipMap Level'
    Enabled = False
    TabOrder = 4
    Visible = False
    OnClick = Button1Click
  end
  object CBnonPOT: TCheckBox
    Left = 504
    Top = 52
    Width = 209
    Height = 17
    Caption = 'Allow non-POT images (no use in-game)'
    TabOrder = 5
    OnClick = CBnonPOTClick
  end
  object rgCompressionQuality: TRadioGroup
    Left = 504
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
    Left = 192
    Top = 96
    Width = 169
    Height = 81
    TabOrder = 7
  end
  object Save1: TSaveDialog
    DefaultExt = 'bmp'
    InitialDir = '.'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 663
    Top = 319
  end
  object Open1: TOpenDialog
    InitialDir = '.'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 635
    Top = 319
  end
  object PopupMenu1: TPopupMenu
    Left = 607
    Top = 319
    object ImportBMPRGB: TMenuItem
      Caption = 'Import BMP Image'
      OnClick = ImportBMPClick
    end
    object ImportBMPA: TMenuItem
      Caption = 'Import BMP Mask'
      Enabled = False
      OnClick = ImportBMPClick
    end
    object ImportTGAImageMask1: TMenuItem
      Caption = 'Import TGA Image/Mask'
      OnClick = ImportTGAClick
    end
    object N1: TMenuItem
      Caption = '-'
      Enabled = False
    end
    object ExportBMPRGB: TMenuItem
      Caption = 'Export BMP Image'
      Enabled = False
      OnClick = ExportClick
    end
    object ExportBMPA: TMenuItem
      Caption = 'Export BMP Mask'
      Enabled = False
      OnClick = ExportClick
    end
    object ExportTGA: TMenuItem
      Caption = 'Export TGA Image/Mask'
      Enabled = False
      OnClick = ExportClick
    end
    object N2: TMenuItem
      Caption = '-'
      Enabled = False
    end
    object InvertA: TMenuItem
      Caption = 'Invert Alpha'
      Enabled = False
      OnClick = InvertAlpha
    end
    object ClearA: TMenuItem
      Caption = 'Clear Alpha'
      Enabled = False
      OnClick = ClearAlpha
    end
  end
  object MainMenu1: TMainMenu
    Left = 579
    Top = 319
    object ImportMenu: TMenuItem
      Caption = 'Import'
      object LoadBMPImage1: TMenuItem
        Caption = 'BMP Image ...'
        OnClick = ImportBMPClick
      end
      object LoadBMPMask1: TMenuItem
        Caption = 'BMP Mask ...'
        Enabled = False
        OnClick = ImportBMPClick
      end
      object LoadTGAImageMask1: TMenuItem
        Caption = 'TGA Image/Mask ...'
        OnClick = ImportTGAClick
      end
    end
    object ExportMenu: TMenuItem
      Caption = 'Export'
      object SaveBMPImage1: TMenuItem
        Caption = 'BMP Image ...'
        Enabled = False
        OnClick = ExportClick
      end
      object SaveBMPMask1: TMenuItem
        Caption = 'BMP Mask ...'
        Enabled = False
        OnClick = ExportClick
      end
      object SaveTGAImageMask1: TMenuItem
        Caption = 'TGA Image/Mask ...'
        Enabled = False
        OnClick = ExportClick
      end
    end
    object SaveMenu: TMenuItem
      Caption = 'Save'
      object SaveUncompressedPTX1: TMenuItem
        Caption = 'Uncompressed PTX ...'
        Enabled = False
        OnClick = SaveUncompressedPTX
      end
      object SaveCompressedPTX1: TMenuItem
        Caption = 'Compressed PTX ...'
        Enabled = False
        OnClick = SaveCompressedPTX
      end
    end
    object EditMenu: TMenuItem
      Caption = 'Edit'
      object InvertAlpha1: TMenuItem
        Caption = 'Invert Alpha'
        Enabled = False
        OnClick = InvertAlpha
      end
      object ClearAlpha1: TMenuItem
        Caption = 'Clear Alpha'
        Enabled = False
        OnClick = ClearAlpha
      end
      object Createalphafromcolorkey1: TMenuItem
        Caption = 'Create alpha from color-key'
        OnClick = Createalphafromcolorkey1Click
      end
      object Replacecolorkeywithaveragecolor1: TMenuItem
        Caption = 'Replace color-key with average color'
        OnClick = Replacecolorkeywithaveragecolor1Click
      end
    end
    object AboutMenu: TMenuItem
      Caption = 'About'
      OnClick = AboutClick
    end
  end
end
