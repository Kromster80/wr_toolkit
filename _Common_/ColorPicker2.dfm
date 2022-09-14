object Form_ColorPicker2: TForm_ColorPicker2
  Left = 412
  Top = 148
  BorderStyle = bsDialog
  Caption = 'Color picker'
  ClientHeight = 353
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object HSImage: TImage
    Left = 8
    Top = 8
    Width = 360
    Height = 256
    OnMouseDown = HSImageMouseDown
    OnMouseMove = HSImageMouseMove
    OnMouseUp = HSImageMouseUp
  end
  object BriImage: TImage
    Left = 380
    Top = 8
    Width = 21
    Height = 256
    Proportional = True
    OnMouseDown = BriImageMouseDown
    OnMouseMove = BriImageMouseMove
    OnMouseUp = BriImageMouseUp
  end
  object Ticker: TShape
    Left = 376
    Top = 133
    Width = 29
    Height = 9
    Brush.Style = bsClear
    Enabled = False
    Pen.Width = 2
  end
  object Shape2: TShape
    Left = 8
    Top = 272
    Width = 113
    Height = 73
  end
  object Shape1: TShape
    Left = 184
    Top = 128
    Width = 9
    Height = 9
    Brush.Style = bsClear
    Enabled = False
    Pen.Style = psDot
    Pen.Width = 2
  end
  object Label1: TLabel
    Left = 182
    Top = 275
    Width = 20
    Height = 13
    Caption = 'Hue'
  end
  object Label2: TLabel
    Left = 182
    Top = 301
    Width = 48
    Height = 13
    Caption = 'Saturation'
  end
  object Label3: TLabel
    Left = 182
    Top = 327
    Width = 49
    Height = 13
    Caption = 'Brightness'
  end
  object Label4: TLabel
    Left = 294
    Top = 275
    Width = 20
    Height = 13
    Caption = 'Red'
  end
  object Label5: TLabel
    Left = 294
    Top = 301
    Width = 29
    Height = 13
    Caption = 'Green'
  end
  object Label6: TLabel
    Left = 294
    Top = 327
    Width = 21
    Height = 13
    Caption = 'Blue'
  end
  object btnReset: TButton
    Left = 344
    Top = 320
    Width = 65
    Height = 25
    Caption = 'Reset'
    TabOrder = 7
    OnClick = btnResetClick
  end
  object SpinR: TSpinEdit
    Left = 240
    Top = 272
    Width = 49
    Height = 22
    MaxValue = 255
    MinValue = 0
    TabOrder = 3
    Value = 0
    OnChange = SpinRGBChange
  end
  object SpinG: TSpinEdit
    Left = 240
    Top = 298
    Width = 49
    Height = 22
    MaxValue = 255
    MinValue = 0
    TabOrder = 4
    Value = 0
    OnChange = SpinRGBChange
  end
  object SpinB: TSpinEdit
    Left = 240
    Top = 324
    Width = 49
    Height = 22
    MaxValue = 255
    MinValue = 0
    TabOrder = 5
    Value = 0
    OnChange = SpinRGBChange
  end
  object SpinS: TSpinEdit
    Left = 128
    Top = 298
    Width = 49
    Height = 22
    MaxValue = 255
    MinValue = 0
    TabOrder = 1
    Value = 0
    OnChange = SpinHSBChange
  end
  object SpinBr: TSpinEdit
    Left = 128
    Top = 324
    Width = 49
    Height = 22
    MaxValue = 255
    MinValue = 0
    TabOrder = 2
    Value = 0
    OnChange = SpinHSBChange
  end
  object btnOk: TButton
    Left = 344
    Top = 288
    Width = 65
    Height = 25
    Caption = 'OK'
    TabOrder = 6
    OnClick = btnOkClick
  end
  object SpinH: TSpinEdit
    Left = 128
    Top = 272
    Width = 49
    Height = 22
    MaxValue = 359
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnChange = SpinHSBChange
  end
end
