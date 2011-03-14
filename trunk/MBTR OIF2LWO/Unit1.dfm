object Form1: TForm1
  Left = 159
  Top = 111
  Width = 313
  Height = 360
  Caption = 'Converter'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 0
    Top = 308
    Width = 305
    Height = 25
    Caption = 'Convert OIF >>> LWO'
    TabOrder = 0
    OnClick = MOX2LWO
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 305
    Height = 305
    Hint = '1'
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object OpenDialog1: TOpenDialog
    Filter = 'MBTR 3D meshes (*.oif)|*.oif|All Files (*.*)|*.*'
    InitialDir = '.'
    Left = 8
    Top = 272
  end
end
