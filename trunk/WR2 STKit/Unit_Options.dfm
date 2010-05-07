object FormOptions: TFormOptions
  Left = 474
  Top = 153
  Width = 265
  Height = 287
  Caption = 'STKit2 Options'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    257
    260)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 70
    Top = 59
    Width = 40
    Height = 13
    Caption = 'FPS limit'
  end
  object Label4: TLabel
    Left = 6
    Top = 8
    Width = 55
    Height = 13
    Caption = 'Work folder'
  end
  object Label2: TLabel
    Left = 70
    Top = 91
    Width = 80
    Height = 13
    Caption = 'View distance, m'
  end
  object Label3: TLabel
    Left = 70
    Top = 123
    Width = 57
    Height = 13
    Caption = 'Spline detail'
  end
  object ApplyButton: TButton
    Left = 144
    Top = 229
    Width = 105
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Apply'
    TabOrder = 0
    OnClick = ApplyClick
  end
  object FPSLimit: TSpinEdit
    Left = 4
    Top = 56
    Width = 61
    Height = 22
    MaxValue = 1000
    MinValue = 1
    TabOrder = 1
    Value = 15
  end
  object CancelButton: TButton
    Left = 8
    Top = 229
    Width = 105
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = CancelButtonClick
  end
  object Button1: TButton
    Left = 188
    Top = 23
    Width = 61
    Height = 21
    Caption = 'Browse ...'
    TabOrder = 3
    OnClick = Button1Click
  end
  object WorkFolder: TEdit
    Left = 4
    Top = 23
    Width = 177
    Height = 21
    ReadOnly = True
    TabOrder = 4
    Text = 'WorkFolder'
  end
  object ViewDist: TSpinEdit
    Left = 4
    Top = 88
    Width = 61
    Height = 22
    Increment = 100
    MaxValue = 1500
    MinValue = 100
    TabOrder = 5
    Value = 100
  end
  object SplineDet: TSpinEdit
    Left = 4
    Top = 120
    Width = 61
    Height = 22
    MaxValue = 24
    MinValue = 6
    TabOrder = 6
    Value = 16
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 148
    Width = 165
    Height = 73
    Caption = '  Top-down render resolution '
    TabOrder = 7
    object Label5: TLabel
      Left = 80
      Top = 24
      Width = 47
      Height = 13
      Caption = 'Horizontal'
    end
    object Label6: TLabel
      Left = 80
      Top = 48
      Width = 35
      Height = 13
      Caption = 'Vertical'
    end
    object CB_ResH: TComboBox
      Left = 8
      Top = 20
      Width = 65
      Height = 21
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 0
      Text = '2048'
      Items.Strings = (
        '1024'
        '2048'
        '4096'
        '8192')
    end
    object CB_ResV: TComboBox
      Left = 8
      Top = 44
      Width = 65
      Height = 21
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 1
      Text = '2048'
      Items.Strings = (
        '1024'
        '2048'
        '4096'
        '8192')
    end
  end
end
