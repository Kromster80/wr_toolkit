object Form1: TForm1
  Left = 56
  Top = 143
  Width = 707
  Height = 401
  HorzScrollBar.Smooth = True
  VertScrollBar.Smooth = True
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'PTXTool'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = Form1Init
  OnResize = FormResize
  DesignSize = (
    699
    355)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel_RGB: TBevel
    Left = 176
    Top = 95
    Width = 258
    Height = 258
  end
  object Bevel_A: TBevel
    Left = 439
    Top = 95
    Width = 258
    Height = 258
  end
  object Image_A: TImage
    Left = 440
    Top = 96
    Width = 256
    Height = 256
    OnMouseDown = ShowMenu
  end
  object Label3: TLabel
    Left = 543
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
  object Label4: TLabel
    Left = 281
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
  object Label6: TLabel
    Left = 516
    Top = 64
    Width = 176
    Height = 13
    Caption = 'Replace color-key with average color'
  end
  object Label8: TLabel
    Left = 516
    Top = 40
    Width = 129
    Height = 13
    Caption = 'Create alpha from color-key'
  end
  object Image_RGB: TImage
    Left = 177
    Top = 96
    Width = 256
    Height = 256
    OnMouseDown = ShowMenu
    OnMouseUp = Image_RGBMouseUp
  end
  object GroupBox1: TGroupBox
    Left = 176
    Top = 7
    Width = 305
    Height = 81
    Caption = '  File Name  '
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 18
      Width = 115
      Height = 13
      Caption = 'Size - ____x____ RGBA'
    end
    object LabelCom: TLabel
      Left = 8
      Top = 50
      Width = 60
      Height = 13
      Caption = 'Compression'
    end
    object Label5: TLabel
      Left = 8
      Top = 34
      Width = 68
      Height = 13
      Caption = 'MipMap levels'
    end
    object LabelR: TLabel
      Left = 144
      Top = 18
      Width = 145
      Height = 13
      Caption = 'Fade color  R___  G___  B___'
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
      Width = 24
      Height = 13
      Caption = 'RMS'
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
    Left = 3
    Top = 9
    Width = 129
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 0
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 3
    Top = 32
    Width = 169
    Height = 131
    FileList = FileListBox1
    ItemHeight = 16
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
  end
  object FileListBox1: TFileListBox
    Left = 3
    Top = 166
    Width = 169
    Height = 187
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    Mask = '*.ptx;*.dds;*.tga;*.2db; *.xtx'
    TabOrder = 2
    OnClick = OpenFile
  end
  object Button1: TButton
    Left = 448
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
    Left = 488
    Top = 12
    Width = 209
    Height = 17
    Caption = 'Allow non-POT images (no use in-game)'
    TabOrder = 5
    OnClick = CBnonPOTClick
  end
  object ButtonA: TBitBtn
    Left = 488
    Top = 32
    Width = 25
    Height = 25
    TabOrder = 6
    OnClick = SampleAClick
    Glyph.Data = {
      5A010000424D5A01000000000000760000002800000013000000130000000100
      040000000000E400000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF777777FFFF
      FFFFFFF00000F7777777777FFF0FF0F00000F700077777FFFF0FF0F00000FF07
      70777FFFFF0000F00000FF07770FFFFFFF0FF0F00000FFF07770FFFFFF0FF0F0
      0000FFFF07770FFFFFF00FF00000FFFFF07FF0FFFFFFFFF00000FFFFFF0FFF0F
      FFFFFFF00000FFFFFFF0FFF0F0FFFFF00000FFFFFFFF0FFF00FFFFF00000FFFF
      FFFFF0F0000FFFF00000FFFFFFFFFF000000FFF00000FFFFFFFFF00000000FF0
      0000FFFFFFFFFFF0000000F00000FFFFFFFFFFFF00F000F00000FFFFFFFFFFFF
      F00F00F00000FFFFFFFFFFFFFF000FF00000FFFFFFFFFFFFFFFFFFF00000}
  end
  object ButtonR: TBitBtn
    Left = 488
    Top = 56
    Width = 25
    Height = 25
    TabOrder = 7
    OnClick = SampleRClick
    Glyph.Data = {
      5A010000424D5A01000000000000760000002800000013000000130000000100
      040000000000E400000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF777777FFFF
      FFFFFFF00000F7777777777FF0FF0FF00000F700077777FFF0FF0FF00000FF07
      70777FFFF000FFF00000FF07770FFFFFF0FF0FF00000FFF07770FFFFF0FF0FF0
      0000FFFF07770FFFF000FFF00000FFFFF07FF0FFFFFFFFF00000FFFFFF0FFF0F
      FFFFFFF00000FFFFFFF0FFF0F0FFFFF00000FFFFFFFF0FFF00FFFFF00000FFFF
      FFFFF0F0000FFFF00000FFFFFFFFFF000000FFF00000FFFFFFFFF00000000FF0
      0000FFFFFFFFFFF0000000F00000FFFFFFFFFFFF00F000F00000FFFFFFFFFFFF
      F00F00F00000FFFFFFFFFFFFFF000FF00000FFFFFFFFFFFFFFFFFFF00000}
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
    end
    object AboutMenu: TMenuItem
      Caption = 'About'
      OnClick = AboutClick
    end
  end
end
