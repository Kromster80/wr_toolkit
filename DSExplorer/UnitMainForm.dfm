object Form7: TForm7
  Left = 0
  Top = 0
  ClientHeight = 865
  ClientWidth = 1185
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 17
  object Label2: TLabel
    Left = 704
    Top = 8
    Width = 22
    Height = 17
    Caption = 'TBs'
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 24
    Height = 17
    Caption = 'DSs'
  end
  object Label3: TLabel
    Left = 8
    Top = 416
    Width = 25
    Height = 17
    Caption = 'COs'
  end
  object Label4: TLabel
    Left = 968
    Top = 416
    Width = 38
    Height = 17
    Caption = 'Values'
  end
  object btnFindAndDisplayDSs: TButton
    Left = 8
    Top = 376
    Width = 177
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Scan folder for DSs'
    TabOrder = 0
    OnClick = btnFindAndDisplayDSsClick
  end
  object lvTBs: TListView
    Left = 704
    Top = 32
    Width = 473
    Height = 337
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Columns = <
      item
        Caption = 'Label'
        Width = 188
      end
      item
        Caption = 'Index'
        Width = 63
      end
      item
        Caption = 'iC'
        Width = 40
      end
      item
        Caption = 'CondCount'
        Width = 63
      end
      item
        Caption = 'En'
        Width = 60
      end>
    TabOrder = 1
    ViewStyle = vsReport
    OnChange = lvTBsChange
    OnColumnClick = lvTBsColumnClick
    OnCompare = lvTBsCompare
  end
  object lvDSs: TListView
    Left = 8
    Top = 32
    Width = 689
    Height = 337
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Columns = <
      item
        Caption = 'Filename'
        Width = 300
      end
      item
        Caption = 'st'
        Width = 150
      end
      item
        Caption = 'au'
        Width = 40
      end
      item
        Caption = 'En'
        Width = 60
      end>
    TabOrder = 2
    ViewStyle = vsReport
    OnChange = lvDSsChange
  end
  object lvCOs: TListView
    Left = 8
    Top = 440
    Width = 953
    Height = 417
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Columns = <
      item
        Caption = 'Label'
        Width = 188
      end
      item
        Caption = 'Index'
        Width = 48
      end
      item
        Caption = 'iU'
        Width = 40
      end
      item
        Caption = 'SM'
        Width = 188
      end
      item
        Caption = 'ST'
        Width = 110
      end
      item
        Caption = 'IC'
        Width = 90
      end
      item
        Caption = 'SC'
        Width = 188
      end
      item
        Caption = 'En'
        Width = 60
      end>
    TabOrder = 3
    ViewStyle = vsReport
    OnChange = lvCOsChange
    OnColumnClick = lvCOsColumnClick
    OnCompare = lvCOsCompare
  end
  object btnDisplayAll: TButton
    Left = 704
    Top = 376
    Width = 137
    Height = 34
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Display all entries'
    TabOrder = 4
    OnClick = btnDisplayAllClick
  end
  object lvValues: TListView
    Left = 968
    Top = 440
    Width = 211
    Height = 417
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Columns = <
      item
        Caption = 'Typ'
      end
      item
        Caption = 'Value'
        Width = 125
      end>
    TabOrder = 5
    ViewStyle = vsReport
  end
  object btnCopyAll: TButton
    Left = 848
    Top = 376
    Width = 131
    Height = 34
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Copy all values'
    TabOrder = 6
    OnClick = btnCopyAllClick
  end
  object btnPasteAll: TButton
    Left = 984
    Top = 376
    Width = 131
    Height = 34
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Paste all values'
    TabOrder = 7
    OnClick = btnPasteAllClick
  end
  object btnSaveDS: TButton
    Left = 192
    Top = 375
    Width = 171
    Height = 34
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Save current DS'
    TabOrder = 8
    OnClick = btnSaveDSClick
  end
end
