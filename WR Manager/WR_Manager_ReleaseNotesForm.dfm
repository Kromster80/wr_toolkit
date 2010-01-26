object Form4: TForm4
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Release Notes'
  ClientHeight = 413
  ClientWidth = 532
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 4
    Top = 4
    Width = 525
    Height = 377
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 229
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
end
