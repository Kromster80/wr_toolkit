object Form1: TForm1
  Left = 299
  Top = 79
  BorderStyle = bsSingle
  Caption = 'WR2 Mission Maker'
  ClientHeight = 539
  ClientWidth = 723
  Color = clBtnFace
  DragKind = dkDock
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    723
    539)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 2
    Top = 8
    Width = 719
    Height = 529
    ActivePage = TabSheet4
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'Cars'
      ImageIndex = 1
      TabVisible = False
      DesignSize = (
        711
        501)
      object Label86: TLabel
        Left = 424
        Top = 4
        Width = 60
        Height = 13
        Caption = '0+0 = 0 Cars'
      end
      object Label140: TLabel
        Left = 426
        Top = 72
        Width = 91
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Cars menu ordering'
      end
      object Label141: TLabel
        Left = 426
        Top = 24
        Width = 79
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Cars list by name'
      end
      object GroupBoxCar: TGroupBox
        Left = 6
        Top = 8
        Width = 251
        Height = 73
        Caption = '  Car Info  '
        TabOrder = 0
        object Label31: TLabel
          Left = 8
          Top = 15
          Width = 29
          Height = 13
          Caption = 'Folder'
        end
        object Label32: TLabel
          Left = 8
          Top = 31
          Width = 28
          Height = 13
          Caption = 'Score'
        end
        object Label33: TLabel
          Left = 8
          Top = 47
          Width = 55
          Height = 13
          Caption = 'Menu Class'
        end
        object Label41: TLabel
          Left = 96
          Top = 15
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label42: TLabel
          Left = 96
          Top = 31
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label43: TLabel
          Left = 96
          Top = 47
          Width = 10
          Height = 13
          Caption = 'nil'
        end
      end
      object ListCars2: TListBox
        Left = 424
        Top = 88
        Width = 281
        Height = 409
        Anchors = [akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 1
        OnClick = ListCars0Click
      end
      object CBCars: TComboBox
        Left = 424
        Top = 40
        Width = 281
        Height = 21
        AutoComplete = False
        Style = csDropDownList
        Anchors = [akTop, akRight]
        DropDownCount = 28
        Sorted = True
        TabOrder = 2
        OnChange = CBCarsChange
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Sceneries'
      ImageIndex = 2
      TabVisible = False
      DesignSize = (
        711
        501)
      object Label47: TLabel
        Left = 162
        Top = 8
        Width = 117
        Height = 13
        Caption = 'Total of 0 + 0 = 0 Tracks'
        Visible = False
      end
      object Label127: TLabel
        Left = 4
        Top = 8
        Width = 94
        Height = 13
        Caption = 'Available sceneries:'
      end
      object Label128: TLabel
        Left = 4
        Top = 192
        Width = 74
        Height = 13
        Caption = 'Scenery tracks:'
      end
      object CLBSceneries: TCheckListBox
        Left = 2
        Top = 24
        Width = 297
        Height = 161
        ItemHeight = 13
        TabOrder = 0
        OnClick = CLBSceneriesClick
      end
      object GBScenery: TGroupBox
        Left = 304
        Top = 18
        Width = 251
        Height = 169
        Caption = '  Scenery Info  '
        TabOrder = 1
        object Label2: TLabel
          Left = 8
          Top = 20
          Width = 64
          Height = 13
          Caption = 'Engine Name'
        end
        object Label5: TLabel
          Left = 8
          Top = 36
          Width = 62
          Height = 13
          Caption = 'Scenery Flag'
        end
        object Label6: TLabel
          Left = 8
          Top = 52
          Width = 74
          Height = 13
          Caption = 'FreeRide Track'
        end
        object Label8: TLabel
          Left = 96
          Top = 20
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label11: TLabel
          Left = 96
          Top = 36
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label12: TLabel
          Left = 96
          Top = 52
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label45: TLabel
          Left = 8
          Top = 132
          Width = 44
          Height = 13
          Caption = 'Comment'
        end
        object Label38: TLabel
          Left = 8
          Top = 116
          Width = 37
          Height = 13
          Caption = 'Contact'
        end
        object Label37: TLabel
          Left = 8
          Top = 100
          Width = 46
          Height = 13
          Caption = 'Converter'
        end
        object Label36: TLabel
          Left = 8
          Top = 84
          Width = 31
          Height = 13
          Caption = 'Author'
        end
        object Label39: TLabel
          Left = 96
          Top = 84
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label40: TLabel
          Left = 96
          Top = 100
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label44: TLabel
          Left = 96
          Top = 116
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label46: TLabel
          Left = 96
          Top = 132
          Width = 145
          Height = 13
          Caption = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
          WordWrap = True
        end
      end
      object LBTracks: TListBox
        Left = 2
        Top = 208
        Width = 297
        Height = 289
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        TabOrder = 2
        OnClick = LBTracksClick
      end
      object GBTrack: TGroupBox
        Left = 304
        Top = 202
        Width = 251
        Height = 153
        Caption = '  Track Info  '
        TabOrder = 3
        object Label1: TLabel
          Left = 8
          Top = 20
          Width = 42
          Height = 13
          Caption = 'Track ID'
        end
        object Label13: TLabel
          Left = 8
          Top = 36
          Width = 54
          Height = 13
          Caption = 'Checkpoint'
        end
        object Label14: TLabel
          Left = 8
          Top = 52
          Width = 33
          Height = 13
          Caption = 'Length'
        end
        object Label15: TLabel
          Left = 8
          Top = 68
          Width = 42
          Height = 13
          Caption = 'Direction'
        end
        object Label16: TLabel
          Left = 8
          Top = 84
          Width = 45
          Height = 13
          Caption = 'Waypoint'
        end
        object Label17: TLabel
          Left = 8
          Top = 100
          Width = 59
          Height = 13
          Caption = 'Menu Image'
        end
        object Label18: TLabel
          Left = 8
          Top = 116
          Width = 24
          Height = 13
          Caption = 'Type'
        end
        object Label19: TLabel
          Left = 8
          Top = 132
          Width = 41
          Height = 13
          Caption = 'Sections'
        end
        object Label21: TLabel
          Left = 96
          Top = 20
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label23: TLabel
          Left = 96
          Top = 36
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label24: TLabel
          Left = 96
          Top = 52
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label25: TLabel
          Left = 96
          Top = 68
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label26: TLabel
          Left = 96
          Top = 84
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label27: TLabel
          Left = 96
          Top = 100
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label28: TLabel
          Left = 96
          Top = 116
          Width = 10
          Height = 13
          Caption = 'nil'
        end
        object Label29: TLabel
          Left = 96
          Top = 132
          Width = 10
          Height = 13
          Caption = 'nil'
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Custom Mission'
      ImageIndex = 3
      object Button1: TButton
        Left = 76
        Top = 4
        Width = 67
        Height = 25
        Caption = 'Save ...'
        TabOrder = 0
        OnClick = Button1Click
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 32
        Width = 141
        Height = 337
        TabOrder = 2
        object Label70: TLabel
          Left = 12
          Top = 140
          Width = 88
          Height = 13
          Caption = 'Sim/Arcade 100/0'
        end
        object Label85: TLabel
          Left = 12
          Top = 188
          Width = 76
          Height = 13
          Caption = 'AI Strength 80%'
        end
        object Label34: TLabel
          Left = 12
          Top = 236
          Width = 80
          Height = 13
          Caption = 'Max Damage 0%'
        end
        object Label48: TLabel
          Left = 12
          Top = 284
          Width = 39
          Height = 13
          Caption = 'Nitro 0%'
        end
        object Label72: TLabel
          Left = 10
          Top = 40
          Width = 56
          Height = 13
          Caption = 'Race Mode'
        end
        object Label71: TLabel
          Left = 10
          Top = 88
          Width = 16
          Height = 13
          Caption = 'Car'
          Enabled = False
        end
        object TBSimulation: TTrackBar
          Left = 4
          Top = 152
          Width = 123
          Height = 33
          LineSize = 10
          Max = 100
          PageSize = 30
          Frequency = 10
          TabOrder = 0
          ThumbLength = 15
          OnChange = TBChange
        end
        object TBAI: TTrackBar
          Left = 4
          Top = 200
          Width = 123
          Height = 33
          LineSize = 5
          Max = 100
          Min = 50
          PageSize = 15
          Frequency = 5
          Position = 80
          TabOrder = 1
          ThumbLength = 15
          OnChange = TBChange
        end
        object TBMaxDam: TTrackBar
          Left = 4
          Top = 248
          Width = 123
          Height = 33
          LineSize = 10
          Max = 100
          PageSize = 10
          Frequency = 10
          TabOrder = 2
          ThumbLength = 15
          OnChange = TBChange
        end
        object TBNitro: TTrackBar
          Left = 4
          Top = 296
          Width = 123
          Height = 33
          LineSize = 10
          Max = 4
          PageSize = 10
          TabOrder = 3
          ThumbLength = 15
          OnChange = TBChange
        end
        object RandAddons: TCheckBox
          Left = 8
          Top = 16
          Width = 57
          Height = 17
          Caption = 'Add-ons'
          Enabled = False
          TabOrder = 4
          OnClick = RefreshSceneryList
        end
        object CBRaceMode: TComboBox
          Left = 8
          Top = 56
          Width = 97
          Height = 21
          ItemIndex = 1
          TabOrder = 5
          Text = 'Championship'
          OnChange = CBRaceModeChange
          Items.Strings = (
            'Simple Race'
            'Championship'
            'Knockout')
        end
        object CBCar: TComboBox
          Left = 8
          Top = 104
          Width = 113
          Height = 21
          Enabled = False
          TabOrder = 6
          Text = 'ComboBox1'
        end
        object CBAnyCar: TCheckBox
          Left = 84
          Top = 87
          Width = 37
          Height = 17
          Caption = 'Any'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 7
        end
      end
      object GroupBox1: TGroupBox
        Left = 148
        Top = 32
        Width = 561
        Height = 337
        TabOrder = 1
        object Label59: TLabel
          Left = 80
          Top = 16
          Width = 39
          Height = 13
          Caption = 'Scenery'
        end
        object Label60: TLabel
          Left = 200
          Top = 16
          Width = 28
          Height = 13
          Caption = 'Track'
        end
        object Label69: TLabel
          Left = 320
          Top = 16
          Width = 23
          Height = 13
          Caption = 'Laps'
        end
        object Label73: TLabel
          Left = 432
          Top = 16
          Width = 21
          Height = 13
          Caption = 'Cars'
        end
        object Label75: TLabel
          Left = 480
          Top = 16
          Width = 30
          Height = 13
          Caption = 'Traffic'
        end
        object Label76: TLabel
          Left = 48
          Top = 35
          Width = 9
          Height = 13
          Caption = '1.'
        end
        object Label77: TLabel
          Left = 48
          Top = 59
          Width = 9
          Height = 13
          Caption = '2.'
        end
        object Label78: TLabel
          Left = 48
          Top = 83
          Width = 9
          Height = 13
          Caption = '3.'
        end
        object Label79: TLabel
          Left = 48
          Top = 107
          Width = 9
          Height = 13
          Caption = '4.'
        end
        object Label80: TLabel
          Left = 48
          Top = 131
          Width = 9
          Height = 13
          Caption = '5.'
        end
        object Label81: TLabel
          Left = 48
          Top = 155
          Width = 9
          Height = 13
          Caption = '6.'
        end
        object Label84: TLabel
          Left = 24
          Top = 16
          Width = 31
          Height = 13
          Caption = 'Races'
        end
        object Label35: TLabel
          Left = 368
          Top = 16
          Width = 33
          Height = 13
          Caption = 'Length'
        end
        object AllRandom: TButton
          Left = 8
          Top = 200
          Width = 65
          Height = 85
          Caption = 'Random'
          TabOrder = 0
          OnClick = AllRandomClick
        end
        object ScnSame: TButton
          Left = 72
          Top = 200
          Width = 241
          Height = 22
          Caption = 'Same'
          TabOrder = 1
          OnClick = SceneryRandom
        end
        object ScnSameRandom: TButton
          Left = 72
          Top = 221
          Width = 241
          Height = 22
          Caption = '    Same   ||   Random'
          TabOrder = 2
          OnClick = SceneryRandom
        end
        object ScnRandom: TButton
          Left = 72
          Top = 242
          Width = 241
          Height = 22
          Caption = 'Random'
          TabOrder = 3
          OnClick = SceneryRandom
        end
        object Button10: TButton
          Left = 72
          Top = 263
          Width = 241
          Height = 22
          Enabled = False
          TabOrder = 4
        end
        object LapSame: TButton
          Left = 312
          Top = 200
          Width = 49
          Height = 22
          Caption = 'Same'
          TabOrder = 5
          OnClick = LapRandom
        end
        object Lap1_5: TButton
          Left = 312
          Top = 221
          Width = 49
          Height = 22
          Caption = '1-5'
          TabOrder = 6
          OnClick = LapRandom
        end
        object Lap4_10: TButton
          Left = 312
          Top = 242
          Width = 49
          Height = 22
          Caption = '4-10'
          TabOrder = 7
          OnClick = LapRandom
        end
        object Lap10_30: TButton
          Left = 312
          Top = 263
          Width = 49
          Height = 22
          Caption = '10-30'
          TabOrder = 8
          OnClick = LapRandom
        end
        object TBRaceQty: TTrackBar
          Left = 16
          Top = 32
          Width = 33
          Height = 141
          Max = 6
          Min = 1
          Orientation = trVertical
          Position = 6
          TabOrder = 9
          OnChange = RefreshSceneryList
        end
        object Scn1: TComboBox
          Left = 72
          Top = 32
          Width = 121
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Style = csDropDownList
          Ctl3D = True
          DropDownCount = 12
          ItemIndex = 0
          ParentCtl3D = False
          TabOrder = 10
          Text = 'Italy'
          OnChange = RefreshSceneryList
          Items.Strings = (
            'Italy'
            'Egypt'
            'Hawaii'
            'Miami'
            'Test Center'
            'Hockenheim Ring')
        end
        object Trk1: TComboBox
          Left = 192
          Top = 32
          Width = 121
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 11
          Text = 'Italy 1'
          OnChange = RefreshLengths
          Items.Strings = (
            'Italy 1')
        end
        object Scn2: TComboBox
          Left = 72
          Top = 56
          Width = 121
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Style = csDropDownList
          Ctl3D = True
          DropDownCount = 12
          Enabled = False
          ItemIndex = 0
          ParentCtl3D = False
          TabOrder = 12
          Text = 'Italy'
          OnChange = RefreshSceneryList
          Items.Strings = (
            'Italy'
            'Egypt'
            'Hawaii'
            'Miami'
            'Test Center'
            'Hockenheim Ring')
        end
        object Trk2: TComboBox
          Left = 192
          Top = 56
          Width = 121
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Style = csDropDownList
          Enabled = False
          ItemIndex = 0
          TabOrder = 13
          Text = 'Italy 1'
          OnChange = RefreshLengths
          Items.Strings = (
            'Italy 1')
        end
        object L2: TSpinEdit
          Left = 312
          Top = 56
          Width = 49
          Height = 22
          Ctl3D = False
          Enabled = False
          MaxValue = 30
          MinValue = 1
          ParentCtl3D = False
          TabOrder = 14
          Value = 2
          OnChange = RefreshLengths
        end
        object C2: TSpinEdit
          Left = 424
          Top = 56
          Width = 49
          Height = 22
          Ctl3D = False
          Enabled = False
          MaxLength = 6
          MaxValue = 0
          MinValue = 0
          ParentCtl3D = False
          TabOrder = 15
          Value = 6
        end
        object T2: TComboBox
          Left = 472
          Top = 56
          Width = 81
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Enabled = False
          ItemIndex = 4
          TabOrder = 16
          Text = 'Rush Hour'
          Items.Strings = (
            'No'
            'Low'
            'Medium'
            'High'
            'Rush Hour')
        end
        object Scn3: TComboBox
          Left = 72
          Top = 80
          Width = 121
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Style = csDropDownList
          Ctl3D = True
          DropDownCount = 12
          Enabled = False
          ItemIndex = 0
          ParentCtl3D = False
          TabOrder = 17
          Text = 'Italy'
          OnChange = RefreshSceneryList
          Items.Strings = (
            'Italy'
            'Egypt'
            'Hawaii'
            'Miami'
            'Test Center'
            'Hockenheim Ring')
        end
        object Trk3: TComboBox
          Left = 192
          Top = 80
          Width = 121
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Style = csDropDownList
          Enabled = False
          ItemIndex = 0
          TabOrder = 18
          Text = 'Italy 1'
          OnChange = RefreshLengths
          Items.Strings = (
            'Italy 1')
        end
        object L3: TSpinEdit
          Left = 312
          Top = 80
          Width = 49
          Height = 22
          Ctl3D = False
          Enabled = False
          MaxValue = 30
          MinValue = 1
          ParentCtl3D = False
          TabOrder = 19
          Value = 2
          OnChange = RefreshLengths
        end
        object C3: TSpinEdit
          Left = 424
          Top = 80
          Width = 49
          Height = 22
          Ctl3D = False
          Enabled = False
          MaxLength = 6
          MaxValue = 0
          MinValue = 0
          ParentCtl3D = False
          TabOrder = 20
          Value = 6
        end
        object T3: TComboBox
          Left = 472
          Top = 80
          Width = 81
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Enabled = False
          ItemIndex = 4
          TabOrder = 21
          Text = 'Rush Hour'
          Items.Strings = (
            'No'
            'Low'
            'Medium'
            'High'
            'Rush Hour')
        end
        object Scn4: TComboBox
          Left = 72
          Top = 104
          Width = 121
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Style = csDropDownList
          Ctl3D = True
          DropDownCount = 12
          Enabled = False
          ItemIndex = 0
          ParentCtl3D = False
          TabOrder = 22
          Text = 'Italy'
          OnChange = RefreshSceneryList
          Items.Strings = (
            'Italy'
            'Egypt'
            'Hawaii'
            'Miami'
            'Test Center'
            'Hockenheim Ring')
        end
        object Trk4: TComboBox
          Left = 192
          Top = 104
          Width = 121
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Style = csDropDownList
          Enabled = False
          ItemIndex = 0
          TabOrder = 23
          Text = 'Italy 1'
          OnChange = RefreshLengths
          Items.Strings = (
            'Italy 1')
        end
        object L4: TSpinEdit
          Left = 312
          Top = 104
          Width = 49
          Height = 22
          Ctl3D = False
          Enabled = False
          MaxValue = 30
          MinValue = 1
          ParentCtl3D = False
          TabOrder = 24
          Value = 2
          OnChange = RefreshLengths
        end
        object C4: TSpinEdit
          Left = 424
          Top = 104
          Width = 49
          Height = 22
          Ctl3D = False
          Enabled = False
          MaxLength = 6
          MaxValue = 0
          MinValue = 0
          ParentCtl3D = False
          TabOrder = 25
          Value = 6
        end
        object T4: TComboBox
          Left = 472
          Top = 104
          Width = 81
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Enabled = False
          TabOrder = 26
          Text = 'Rush Hour'
          Items.Strings = (
            'No'
            'Low'
            'Medium'
            'High'
            'Rush Hour')
        end
        object Scn5: TComboBox
          Left = 72
          Top = 128
          Width = 121
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Style = csDropDownList
          Ctl3D = True
          DropDownCount = 12
          Enabled = False
          ItemIndex = 0
          ParentCtl3D = False
          TabOrder = 27
          Text = 'Italy'
          OnChange = RefreshSceneryList
          Items.Strings = (
            'Italy'
            'Egypt'
            'Hawaii'
            'Miami'
            'Test Center'
            'Hockenheim Ring')
        end
        object Trk5: TComboBox
          Left = 192
          Top = 128
          Width = 121
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Style = csDropDownList
          Enabled = False
          ItemIndex = 0
          TabOrder = 28
          Text = 'Italy 1'
          OnChange = RefreshLengths
          Items.Strings = (
            'Italy 1')
        end
        object L5: TSpinEdit
          Left = 312
          Top = 128
          Width = 49
          Height = 22
          Ctl3D = False
          Enabled = False
          MaxValue = 30
          MinValue = 1
          ParentCtl3D = False
          TabOrder = 29
          Value = 2
          OnChange = RefreshLengths
        end
        object C5: TSpinEdit
          Left = 424
          Top = 128
          Width = 49
          Height = 22
          Ctl3D = False
          Enabled = False
          MaxLength = 6
          MaxValue = 0
          MinValue = 0
          ParentCtl3D = False
          TabOrder = 30
          Value = 6
        end
        object T5: TComboBox
          Left = 472
          Top = 128
          Width = 81
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Enabled = False
          ItemIndex = 4
          TabOrder = 31
          Text = 'Rush Hour'
          Items.Strings = (
            'No'
            'Low'
            'Medium'
            'High'
            'Rush Hour')
        end
        object Scn6: TComboBox
          Left = 72
          Top = 152
          Width = 121
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Style = csDropDownList
          Ctl3D = True
          DropDownCount = 12
          Enabled = False
          ItemIndex = 0
          ParentCtl3D = False
          TabOrder = 32
          Text = 'Italy'
          OnChange = RefreshSceneryList
          Items.Strings = (
            'Italy'
            'Egypt'
            'Hawaii'
            'Miami'
            'Test Center'
            'Hockenheim Ring')
        end
        object Trk6: TComboBox
          Left = 192
          Top = 152
          Width = 121
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Style = csDropDownList
          Enabled = False
          ItemIndex = 0
          TabOrder = 33
          Text = 'Italy 1'
          OnChange = RefreshLengths
          Items.Strings = (
            'Italy 1')
        end
        object L6: TSpinEdit
          Left = 312
          Top = 152
          Width = 49
          Height = 22
          Ctl3D = False
          Enabled = False
          MaxValue = 30
          MinValue = 1
          ParentCtl3D = False
          TabOrder = 34
          Value = 2
          OnChange = RefreshLengths
        end
        object C6: TSpinEdit
          Left = 424
          Top = 152
          Width = 49
          Height = 22
          Ctl3D = False
          Enabled = False
          MaxLength = 6
          MaxValue = 0
          MinValue = 0
          ParentCtl3D = False
          TabOrder = 35
          Value = 6
        end
        object T6: TComboBox
          Left = 472
          Top = 152
          Width = 81
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Enabled = False
          ItemIndex = 4
          TabOrder = 36
          Text = 'Rush Hour'
          Items.Strings = (
            'No'
            'Low'
            'Medium'
            'High'
            'Rush Hour')
        end
        object L1: TSpinEdit
          Left = 312
          Top = 32
          Width = 49
          Height = 22
          AutoSize = False
          Ctl3D = False
          MaxValue = 30
          MinValue = 1
          ParentCtl3D = False
          TabOrder = 37
          Value = 2
          OnChange = RefreshLengths
        end
        object C1: TSpinEdit
          Left = 424
          Top = 32
          Width = 49
          Height = 22
          Ctl3D = False
          MaxLength = 6
          MaxValue = 0
          MinValue = 0
          ParentCtl3D = False
          TabOrder = 38
          Value = 6
        end
        object T1: TComboBox
          Left = 472
          Top = 32
          Width = 81
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          ItemIndex = 4
          TabOrder = 39
          Text = 'Rush Hour'
          Items.Strings = (
            'No'
            'Low'
            'Medium'
            'High'
            'Rush Hour')
        end
        object Len1: TEdit
          Left = 360
          Top = 32
          Width = 65
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 47
        end
        object Len2: TEdit
          Left = 360
          Top = 56
          Width = 65
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 48
        end
        object Len3: TEdit
          Left = 360
          Top = 80
          Width = 65
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 49
        end
        object Len4: TEdit
          Left = 360
          Top = 104
          Width = 65
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 50
        end
        object Len5: TEdit
          Left = 360
          Top = 128
          Width = 65
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 51
        end
        object Len6: TEdit
          Left = 360
          Top = 152
          Width = 65
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 52
        end
        object Scn7: TComboBox
          Left = 72
          Top = 176
          Width = 121
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Style = csDropDownList
          Ctl3D = True
          DropDownCount = 12
          Enabled = False
          ItemIndex = 0
          ParentCtl3D = False
          TabOrder = 53
          Text = 'Italy'
          Visible = False
          OnChange = RefreshSceneryList
          Items.Strings = (
            'Italy'
            'Egypt'
            'Hawaii'
            'Miami'
            'Test Center'
            'Hockenheim Ring')
        end
        object Trk7: TComboBox
          Left = 192
          Top = 176
          Width = 121
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Style = csDropDownList
          Enabled = False
          ItemIndex = 0
          TabOrder = 54
          Text = 'Italy 1'
          Visible = False
          OnChange = RefreshLengths
          Items.Strings = (
            'Italy 1')
        end
        object L7: TSpinEdit
          Left = 312
          Top = 176
          Width = 49
          Height = 22
          Ctl3D = False
          Enabled = False
          MaxValue = 30
          MinValue = 1
          ParentCtl3D = False
          TabOrder = 55
          Value = 2
          Visible = False
          OnChange = RefreshLengths
        end
        object Len7: TEdit
          Left = 360
          Top = 176
          Width = 65
          Height = 19
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          TabOrder = 56
          Visible = False
        end
        object C7: TSpinEdit
          Left = 424
          Top = 176
          Width = 49
          Height = 22
          Ctl3D = False
          Enabled = False
          MaxLength = 6
          MaxValue = 0
          MinValue = 0
          ParentCtl3D = False
          TabOrder = 57
          Value = 6
          Visible = False
        end
        object T7: TComboBox
          Left = 472
          Top = 176
          Width = 81
          Height = 21
          AutoComplete = False
          BevelInner = bvNone
          BevelKind = bkTile
          Enabled = False
          ItemIndex = 4
          TabOrder = 58
          Text = 'Rush Hour'
          Visible = False
          Items.Strings = (
            'No'
            'Low'
            'Medium'
            'High'
            'Rush Hour')
        end
        object DistSame: TBitBtn
          Left = 360
          Top = 200
          Width = 65
          Height = 22
          Caption = 'Same'
          Enabled = False
          TabOrder = 59
        end
        object Dist_5km: TBitBtn
          Left = 360
          Top = 221
          Width = 65
          Height = 22
          Caption = '<5 km'
          Enabled = False
          TabOrder = 60
        end
        object Dist_40km: TBitBtn
          Left = 360
          Top = 242
          Width = 65
          Height = 22
          Caption = '<40 km'
          Enabled = False
          TabOrder = 61
        end
        object Dist_100km: TBitBtn
          Left = 360
          Top = 263
          Width = 65
          Height = 22
          Caption = '<100 km'
          Enabled = False
          TabOrder = 62
        end
        object CarSame: TButton
          Left = 424
          Top = 200
          Width = 49
          Height = 22
          Caption = 'Same'
          TabOrder = 40
          OnClick = CarRandom
        end
        object Car2_6: TButton
          Left = 424
          Top = 221
          Width = 49
          Height = 22
          Caption = 'Random'
          TabOrder = 41
          OnClick = CarRandom
        end
        object Button11: TButton
          Left = 424
          Top = 242
          Width = 49
          Height = 43
          Enabled = False
          TabOrder = 44
        end
        object TraSame: TButton
          Left = 472
          Top = 200
          Width = 81
          Height = 22
          Caption = 'Same'
          TabOrder = 42
          OnClick = TrafficRandom
        end
        object TraRandom1: TButton
          Left = 472
          Top = 221
          Width = 81
          Height = 22
          Caption = 'Random Low'
          TabOrder = 43
          OnClick = TrafficRandom
        end
        object TraRandom2: TButton
          Left = 472
          Top = 242
          Width = 81
          Height = 22
          Caption = 'Random High'
          TabOrder = 45
          OnClick = TrafficRandom
        end
        object Button14: TButton
          Left = 472
          Top = 263
          Width = 81
          Height = 22
          Enabled = False
          TabOrder = 46
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Mission Maker'
      ImageIndex = 4
      object LoadMission: TButton
        Left = 4
        Top = 4
        Width = 67
        Height = 25
        Caption = 'Load ...'
        TabOrder = 0
        OnClick = LoadMissionClick
      end
      object Button13: TButton
        Left = 76
        Top = 4
        Width = 67
        Height = 25
        Caption = 'Save ...'
        TabOrder = 1
        OnClick = Button13Click
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 32
        Width = 221
        Height = 465
        TabOrder = 2
        object Label139: TLabel
          Left = 6
          Top = 11
          Width = 64
          Height = 13
          Caption = 'Mission setup'
        end
        object Label9: TLabel
          Left = 174
          Top = 31
          Width = 20
          Height = 13
          Caption = 'Title'
        end
        object Label10: TLabel
          Left = 134
          Top = 55
          Width = 53
          Height = 13
          Caption = 'Result type'
        end
        object Label7: TLabel
          Left = 74
          Top = 79
          Width = 78
          Height = 13
          Caption = 'Number of races'
        end
        object Label50: TLabel
          Left = 74
          Top = 103
          Width = 62
          Height = 13
          Caption = 'Mission class'
        end
        object Label4: TLabel
          Left = 74
          Top = 127
          Width = 67
          Height = 13
          Caption = 'Score to open'
        end
        object Label74: TLabel
          Left = 74
          Top = 151
          Width = 56
          Height = 13
          Caption = 'Award cash'
        end
        object Label22: TLabel
          Left = 174
          Top = 175
          Width = 22
          Height = 13
          Caption = 'Gold'
        end
        object Label30: TLabel
          Left = 174
          Top = 223
          Width = 26
          Height = 13
          Caption = 'Silver'
        end
        object Label49: TLabel
          Left = 174
          Top = 271
          Width = 33
          Height = 13
          Caption = 'Bronze'
        end
        object Label20: TLabel
          Left = 174
          Top = 319
          Width = 16
          Height = 13
          Caption = 'Fail'
        end
        object Label68: TLabel
          Left = 174
          Top = 439
          Width = 37
          Height = 13
          Caption = 'Contact'
        end
        object Label58: TLabel
          Left = 174
          Top = 415
          Width = 31
          Height = 13
          Caption = 'Author'
        end
        object Label82: TLabel
          Left = 134
          Top = 391
          Width = 42
          Height = 13
          Caption = 'InitCShip'
          Enabled = False
        end
        object Label3: TLabel
          Left = 134
          Top = 367
          Width = 55
          Height = 13
          Caption = 'Event code'
          Enabled = False
        end
        object M_Name: TEdit
          Left = 4
          Top = 28
          Width = 165
          Height = 21
          TabOrder = 0
          Text = 'New Mission'
        end
        object M_ResultTyp: TComboBox
          Left = 4
          Top = 52
          Width = 125
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 1
          Text = 'Gold/Silver/Bronze'
          Items.Strings = (
            'Gold/Silver/Bronze'
            'Special Test'
            'x Multi Speedbucks')
        end
        object M_Cash: TSpinEdit
          Left = 4
          Top = 148
          Width = 65
          Height = 22
          Increment = 100
          MaxValue = 5000
          MinValue = 0
          TabOrder = 2
          Value = 100
        end
        object M_Score: TSpinEdit
          Left = 4
          Top = 124
          Width = 65
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 3
          Value = 0
        end
        object M_Class: TSpinEdit
          Left = 4
          Top = 100
          Width = 65
          Height = 22
          MaxValue = 999
          MinValue = 74
          TabOrder = 4
          Value = 74
        end
        object M_NumRaces: TSpinEdit
          Left = 4
          Top = 76
          Width = 65
          Height = 22
          MaxValue = 6
          MinValue = 1
          TabOrder = 5
          Value = 1
          OnChange = M_NumRacesChange
        end
        object M_Gold: TMemo
          Left = 4
          Top = 172
          Width = 165
          Height = 45
          Lines.Strings = (
            'You won without a doubt!')
          ScrollBars = ssVertical
          TabOrder = 6
        end
        object M_Silver: TMemo
          Left = 4
          Top = 220
          Width = 165
          Height = 45
          Lines.Strings = (
            'Silver, not bad :-)')
          ScrollBars = ssVertical
          TabOrder = 7
        end
        object M_Bronze: TMemo
          Left = 4
          Top = 268
          Width = 165
          Height = 45
          Lines.Strings = (
            'It'#39's Bronze. You need more '
            'training for better results.')
          ScrollBars = ssVertical
          TabOrder = 8
        end
        object M_Fail: TMemo
          Left = 4
          Top = 316
          Width = 165
          Height = 45
          Lines.Strings = (
            'You failed to win the mission. '
            'Better luck next time!')
          ScrollBars = ssVertical
          TabOrder = 9
        end
        object M_EventCode: TComboBox
          Left = 4
          Top = 364
          Width = 125
          Height = 21
          Style = csDropDownList
          DropDownCount = 12
          ItemIndex = 0
          TabOrder = 10
          Text = '1. Qualification Test'
          Items.Strings = (
            '1. Qualification Test'
            '2'
            '3'
            '4'
            '5'
            '6. Special Test'
            '7'
            '8'
            '9'
            '10. Mutli Speedbucks'
            '11')
        end
        object M_InitCShip: TComboBox
          Left = 4
          Top = 388
          Width = 125
          Height = 21
          Style = csDropDownList
          DropDownCount = 12
          ItemIndex = 0
          TabOrder = 11
          Text = '0. Common value'
          Items.Strings = (
            '0. Common value'
            '1. '
            '2'
            '3'
            '4'
            '5'
            '6. Used')
        end
        object M_Author: TEdit
          Left = 4
          Top = 412
          Width = 165
          Height = 21
          TabOrder = 12
        end
        object M_Contact: TEdit
          Left = 4
          Top = 436
          Width = 165
          Height = 21
          TabOrder = 13
        end
      end
      object GroupBox4: TGroupBox
        Left = 224
        Top = 0
        Width = 473
        Height = 497
        TabOrder = 3
        object Label87: TLabel
          Left = 278
          Top = 298
          Width = 44
          Height = 13
          Caption = 'Bonus ID'
        end
        object Label88: TLabel
          Left = 150
          Top = 58
          Width = 16
          Height = 13
          Caption = 'Car'
        end
        object Label89: TLabel
          Left = 150
          Top = 82
          Width = 28
          Height = 13
          Caption = 'Track'
        end
        object Label90: TLabel
          Left = 429
          Top = 58
          Width = 28
          Height = 13
          Caption = 'Count'
        end
        object Label91: TLabel
          Left = 78
          Top = 178
          Width = 23
          Height = 13
          Caption = 'Laps'
        end
        object Label92: TLabel
          Left = 78
          Top = 202
          Width = 61
          Height = 13
          Caption = 'Start position'
        end
        object Label93: TLabel
          Left = 78
          Top = 226
          Width = 56
          Height = 13
          Caption = 'AI lead, sec'
        end
        object Label94: TLabel
          Left = 78
          Top = 250
          Width = 65
          Height = 13
          Caption = 'AI lead, meter'
        end
        object Label95: TLabel
          Left = 78
          Top = 274
          Width = 71
          Height = 13
          Caption = 'Lead, positions'
        end
        object Label96: TLabel
          Left = 78
          Top = 346
          Width = 44
          Height = 13
          Caption = 'Traffic, %'
        end
        object Label97: TLabel
          Left = 78
          Top = 322
          Width = 36
          Height = 13
          Caption = 'Nitro, %'
        end
        object Label98: TLabel
          Left = 150
          Top = 106
          Width = 27
          Height = 13
          Caption = 'Mode'
        end
        object Label100: TLabel
          Left = 254
          Top = 250
          Width = 61
          Height = 13
          Caption = 'Max damage'
        end
        object Label101: TLabel
          Left = 254
          Top = 82
          Width = 72
          Height = 13
          Caption = 'Finish lead time'
        end
        object Label102: TLabel
          Left = 254
          Top = 226
          Width = 24
          Height = 13
          Caption = 'Drifts'
        end
        object Label103: TLabel
          Left = 254
          Top = 202
          Width = 72
          Height = 13
          Caption = 'Average speed'
        end
        object Label104: TLabel
          Left = 254
          Top = 58
          Width = 46
          Height = 13
          Caption = 'Min place'
        end
        object Label105: TLabel
          Left = 392
          Top = 106
          Width = 65
          Height = 13
          Caption = 'AI strength, %'
        end
        object Label106: TLabel
          Left = 254
          Top = 178
          Width = 64
          Height = 13
          Caption = 'Top speed, #'
        end
        object Label107: TLabel
          Left = 254
          Top = 154
          Width = 77
          Height = 13
          Caption = 'Top speed, kmh'
        end
        object Label108: TLabel
          Left = 254
          Top = 106
          Width = 63
          Height = 13
          Caption = 'Lap time, sec'
        end
        object Label109: TLabel
          Left = 254
          Top = 130
          Width = 71
          Height = 13
          Caption = 'Race time, sec'
        end
        object Label110: TLabel
          Left = 78
          Top = 298
          Width = 77
          Height = 13
          Caption = 'Sim .. Arcade, %'
        end
        object Label111: TLabel
          Left = 444
          Top = 130
          Width = 13
          Height = 13
          Caption = '#1'
        end
        object Label112: TLabel
          Left = 430
          Top = 82
          Width = 21
          Height = 13
          Caption = 'Cars'
        end
        object Label113: TLabel
          Left = 278
          Top = 274
          Width = 55
          Height = 13
          Caption = 'Event code'
          Enabled = False
        end
        object Label114: TLabel
          Left = 78
          Top = 154
          Width = 50
          Height = 13
          Caption = 'Track filter'
        end
        object Label115: TLabel
          Left = 78
          Top = 130
          Width = 38
          Height = 13
          Caption = 'Car filter'
        end
        object Label116: TLabel
          Left = 78
          Top = 410
          Width = 53
          Height = 13
          Caption = 'Race order'
          Enabled = False
        end
        object Label117: TLabel
          Left = 78
          Top = 386
          Width = 49
          Height = 13
          Caption = 'Mission ID'
          Enabled = False
        end
        object Label118: TLabel
          Left = 444
          Top = 154
          Width = 13
          Height = 13
          Caption = '#2'
        end
        object Label119: TLabel
          Left = 444
          Top = 226
          Width = 13
          Height = 13
          Caption = '#5'
        end
        object Label120: TLabel
          Left = 444
          Top = 202
          Width = 13
          Height = 13
          Caption = '#4'
        end
        object Label121: TLabel
          Left = 444
          Top = 178
          Width = 13
          Height = 13
          Caption = '#3'
        end
        object Label122: TLabel
          Left = 10
          Top = 38
          Width = 58
          Height = 13
          Caption = 'Player setup'
        end
        object Label150: TLabel
          Left = 186
          Top = 38
          Width = 27
          Height = 13
          Caption = 'Goals'
        end
        object Label124: TLabel
          Left = 338
          Top = 38
          Width = 52
          Height = 13
          Caption = 'Opponents'
        end
        object Label125: TLabel
          Left = 78
          Top = 434
          Width = 39
          Height = 13
          Caption = 'InitCode'
          Enabled = False
        end
        object Label83: TLabel
          Left = 364
          Top = 338
          Width = 42
          Height = 13
          Caption = 'Headline'
        end
        object Label99: TLabel
          Left = 364
          Top = 378
          Width = 35
          Height = 13
          Caption = 'Briefing'
        end
        object Label123: TLabel
          Left = 364
          Top = 458
          Width = 16
          Height = 13
          Caption = 'Fail'
        end
        object Label126: TLabel
          Left = 364
          Top = 418
          Width = 41
          Height = 13
          Caption = 'Success'
        end
        object M_BonusID: TComboBox
          Left = 184
          Top = 295
          Width = 89
          Height = 21
          ItemIndex = 0
          TabOrder = 0
          Text = '0 '
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
          Items.Strings = (
            '0 '
            '1'
            '2+'
            '3+'
            '4'
            '5'
            '6+'
            '7+'
            '8+'
            '9'
            '10+'
            '11+')
        end
        object M_CarID: TComboBox
          Left = 8
          Top = 55
          Width = 137
          Height = 21
          AutoComplete = False
          Style = csDropDownList
          DropDownCount = 24
          Sorted = True
          TabOrder = 1
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_TrackID: TComboBox
          Left = 8
          Top = 79
          Width = 137
          Height = 21
          AutoComplete = False
          Style = csDropDownList
          DropDownCount = 24
          ItemIndex = 1
          Sorted = True
          TabOrder = 2
          Text = 'Italy 2'
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
          Items.Strings = (
            'Italy 1'
            'Italy 2')
        end
        object M_Laps: TSpinEdit
          Left = 8
          Top = 175
          Width = 65
          Height = 22
          MaxValue = 100
          MinValue = 1
          TabOrder = 3
          Value = 1
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_StartPos: TSpinEdit
          Left = 8
          Top = 199
          Width = 65
          Height = 22
          MaxValue = 6
          MinValue = 0
          TabOrder = 4
          Value = 6
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_LeadMeter: TSpinEdit
          Left = 8
          Top = 247
          Width = 65
          Height = 22
          MaxValue = 100000
          MinValue = 0
          TabOrder = 5
          Value = 0
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_LeadPos: TSpinEdit
          Left = 8
          Top = 271
          Width = 65
          Height = 22
          MaxValue = 100000
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_Nitro: TSpinEdit
          Left = 8
          Top = 319
          Width = 65
          Height = 22
          Increment = 10
          MaxValue = 100
          MinValue = 0
          TabOrder = 7
          Value = 0
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_Traffic: TSpinEdit
          Left = 8
          Top = 343
          Width = 65
          Height = 22
          Increment = 10
          MaxValue = 100
          MinValue = 0
          TabOrder = 8
          Value = 0
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_RaceMode: TComboBox
          Left = 8
          Top = 103
          Width = 137
          Height = 21
          AutoComplete = False
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 9
          Text = 'Default Race'
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
          Items.Strings = (
            'Default Race'
            'Training'
            'Waypoints Race'
            'Checkpoints Race Off Road'
            'Checkpoints Race'
            'JoyRide'
            'KO Race')
        end
        object M_MinPlace: TSpinEdit
          Left = 184
          Top = 55
          Width = 65
          Height = 22
          MaxValue = 5
          MinValue = 0
          TabOrder = 10
          Value = 0
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_AvSpeed: TSpinEdit
          Left = 184
          Top = 199
          Width = 65
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 11
          Value = 0
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_Drifts: TSpinEdit
          Left = 184
          Top = 223
          Width = 65
          Height = 22
          Increment = 50
          MaxValue = 10000
          MinValue = 0
          TabOrder = 12
          Value = 0
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_FinishLeadTime: TSpinEdit
          Left = 184
          Top = 79
          Width = 65
          Height = 22
          MaxValue = 100000
          MinValue = 0
          TabOrder = 13
          Value = 0
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_MaxDamage: TSpinEdit
          Left = 184
          Top = 247
          Width = 65
          Height = 22
          MaxValue = 100
          MinValue = 0
          TabOrder = 14
          Value = 0
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_TopSpeed: TSpinEdit
          Left = 184
          Top = 151
          Width = 65
          Height = 22
          MaxValue = 1000
          MinValue = 0
          TabOrder = 15
          Value = 0
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_TopSpeedNum: TSpinEdit
          Left = 184
          Top = 175
          Width = 65
          Height = 22
          MaxValue = 100
          MinValue = 0
          TabOrder = 16
          Value = 0
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_OppStrength: TSpinEdit
          Left = 336
          Top = 103
          Width = 65
          Height = 22
          MaxValue = 100
          MinValue = 50
          TabOrder = 17
          Value = 80
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_DriveModel: TSpinEdit
          Left = 8
          Top = 295
          Width = 65
          Height = 22
          Increment = 10
          MaxValue = 100
          MinValue = 0
          TabOrder = 18
          Value = 0
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object SpinEdit20: TSpinEdit
          Left = 8
          Top = 383
          Width = 65
          Height = 22
          Enabled = False
          MaxValue = 6
          MinValue = 1
          TabOrder = 19
          Value = 1
        end
        object SpinEdit21: TSpinEdit
          Left = 8
          Top = 407
          Width = 65
          Height = 22
          Enabled = False
          MaxValue = 6
          MinValue = 1
          TabOrder = 20
          Value = 1
        end
        object M_CarFilter: TSpinEdit
          Left = 8
          Top = 127
          Width = 65
          Height = 22
          MaxValue = 100000
          MinValue = 0
          TabOrder = 21
          Value = 0
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_TrackFilter: TSpinEdit
          Left = 8
          Top = 151
          Width = 65
          Height = 22
          MaxValue = 100000
          MinValue = 0
          TabOrder = 22
          Value = 0
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_OppCar1: TComboBox
          Left = 336
          Top = 127
          Width = 129
          Height = 21
          Style = csDropDownList
          DropDownCount = 24
          ItemIndex = 0
          Sorted = True
          TabOrder = 23
          Text = ' Same car'
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
          Items.Strings = (
            ' Same car')
        end
        object M_OppCar2: TComboBox
          Left = 336
          Top = 151
          Width = 129
          Height = 21
          Style = csDropDownList
          DropDownCount = 24
          ItemIndex = 0
          Sorted = True
          TabOrder = 24
          Text = ' Same car'
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
          Items.Strings = (
            ' Same car')
        end
        object M_OppCar3: TComboBox
          Left = 336
          Top = 175
          Width = 129
          Height = 21
          Style = csDropDownList
          DropDownCount = 24
          ItemIndex = 0
          Sorted = True
          TabOrder = 25
          Text = ' Same car'
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
          Items.Strings = (
            ' Same car')
        end
        object M_OppCar4: TComboBox
          Left = 336
          Top = 199
          Width = 129
          Height = 21
          Style = csDropDownList
          DropDownCount = 24
          ItemIndex = 0
          Sorted = True
          TabOrder = 26
          Text = ' Same car'
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
          Items.Strings = (
            ' Same car')
        end
        object M_OppCar5: TComboBox
          Left = 336
          Top = 223
          Width = 129
          Height = 21
          Style = csDropDownList
          DropDownCount = 24
          ItemIndex = 0
          Sorted = True
          TabOrder = 27
          Text = ' Same car'
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
          Items.Strings = (
            ' Same car')
        end
        object M_InitCode: TSpinEdit
          Left = 8
          Top = 431
          Width = 65
          Height = 22
          Enabled = False
          MaxValue = 10
          MinValue = 0
          TabOrder = 28
          Value = 0
        end
        object M_HeadlineText: TMemo
          Left = 184
          Top = 335
          Width = 177
          Height = 37
          Lines.Strings = (
            'HeadLine text')
          ScrollBars = ssVertical
          TabOrder = 29
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_MissionText: TMemo
          Left = 184
          Top = 375
          Width = 177
          Height = 37
          Lines.Strings = (
            'Mission briefing')
          ScrollBars = ssVertical
          TabOrder = 30
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_SuccessText: TMemo
          Left = 184
          Top = 415
          Width = 177
          Height = 37
          Lines.Strings = (
            'Success !')
          ScrollBars = ssVertical
          TabOrder = 31
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_FailText: TMemo
          Left = 184
          Top = 455
          Width = 177
          Height = 37
          Lines.Strings = (
            'Failed')
          ScrollBars = ssVertical
          TabOrder = 32
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_Leadtime: TFloatSpinEdit
          Left = 8
          Top = 223
          Width = 65
          Height = 22
          Accuracy = 1
          Increment = 0.100000000000000000
          TabOrder = 33
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_MaxLapTime: TFloatSpinEdit
          Left = 184
          Top = 103
          Width = 65
          Height = 22
          Accuracy = 1
          Increment = 0.100000000000000000
          TabOrder = 34
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_RaceTime: TFloatSpinEdit
          Left = 184
          Top = 127
          Width = 65
          Height = 22
          Accuracy = 1
          Increment = 0.100000000000000000
          TabOrder = 35
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
        end
        object M_EventC: TComboBox
          Left = 184
          Top = 271
          Width = 89
          Height = 21
          ItemIndex = 0
          TabOrder = 36
          Text = '0'
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
          Items.Strings = (
            '0'
            '1+'
            '2+'
            '3+'
            '4+'
            '5'
            '6+'
            '7+'
            '8+  72-80-82-97')
        end
        object M_InitOppCars: TComboBox
          Left = 336
          Top = 79
          Width = 89
          Height = 21
          ItemIndex = 0
          TabOrder = 37
          Text = 'Specified'
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
          Items.Strings = (
            'Specified'
            'Same car'
            'Equal car')
        end
        object M_NumDrivers: TComboBox
          Left = 336
          Top = 55
          Width = 89
          Height = 21
          ItemIndex = 5
          TabOrder = 38
          Text = '5'
          OnChange = GetDataFromUI
          OnClick = GetDataFromUI
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5')
        end
        object TC_Race: TTabControl
          Left = 6
          Top = 13
          Width = 459
          Height = 22
          TabOrder = 39
          Tabs.Strings = (
            '  1-st race        '
            '  2-nd race       '
            '  3-rd race       '
            '  4-th race       '
            '  5-th race       '
            '  6-th race       ')
          TabIndex = 0
          TabWidth = 72
          OnChange = TC_RaceChange
        end
      end
    end
  end
  object Button2: TButton
    Left = 430
    Top = 8
    Width = 97
    Height = 17
    Caption = 'SearchAutos'
    TabOrder = 1
    Visible = False
    OnClick = SearchAutos
  end
  object Button3: TButton
    Left = 526
    Top = 8
    Width = 97
    Height = 17
    Caption = 'Search Sceneries'
    TabOrder = 2
    Visible = False
    OnClick = SearchSceneries
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofExtensionDifferent, ofPathMustExist, ofEnableSizing]
    Left = 392
    Top = 8
  end
  object OpenDialog1: TOpenDialog
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 360
    Top = 8
  end
end
