object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'DS Explorer'
  ClientHeight = 881
  ClientWidth = 1401
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
  object btnFindAndDisplayDSs: TButton
    Left = 8
    Top = 840
    Width = 177
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Find and display all DSs'
    TabOrder = 0
    OnClick = btnFindAndDisplayDSsClick
  end
  object lvTBs: TListView
    Left = 792
    Top = 8
    Width = 473
    Height = 361
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
        Width = 63
      end
      item
        Caption = 'CondCount'
        Width = 63
      end
      item
        Caption = 'En'
        Width = 63
      end>
    TabOrder = 1
    ViewStyle = vsReport
    OnChange = lvTBsChange
    OnColumnClick = lvTBsColumnClick
    OnCompare = lvTBsCompare
  end
  object lvDSs: TListView
    Left = 8
    Top = 8
    Width = 777
    Height = 361
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Columns = <
      item
        Caption = 'Filename'
        Width = 200
      end
      item
        Caption = 'st'
        Width = 150
      end
      item
        Caption = 'au'
        Width = 63
      end
      item
        Caption = 'En'
        Width = 64
      end>
    TabOrder = 2
    ViewStyle = vsReport
    OnChange = lvDSsChange
  end
  object lvCOs: TListView
    Left = 8
    Top = 376
    Width = 1171
    Height = 457
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
        Width = 63
      end
      item
        Caption = 'SM'
        Width = 188
      end
      item
        Caption = 'ST'
        Width = 188
      end
      item
        Caption = 'IC'
        Width = 188
      end
      item
        Caption = 'SC'
        Width = 188
      end
      item
        Caption = 'En'
        Width = 63
      end>
    TabOrder = 3
    ViewStyle = vsReport
    OnChange = lvCOsChange
    OnColumnClick = lvCOsColumnClick
    OnCompare = lvCOsCompare
  end
  object btnDisplayAll: TButton
    Left = 192
    Top = 840
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
    Left = 1184
    Top = 376
    Width = 211
    Height = 457
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
    Left = 976
    Top = 840
    Width = 99
    Height = 34
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Copy all'
    TabOrder = 6
    OnClick = btnCopyAllClick
  end
  object btnPasteAll: TButton
    Left = 1080
    Top = 839
    Width = 99
    Height = 34
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Paste all'
    TabOrder = 7
    OnClick = btnPasteAllClick
  end
end
