object Form1: TForm1
  Left = 388
  Top = 90
  Width = 956
  Height = 730
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = RenderResize
  DesignSize = (
    948
    684)
  PixelsPerInch = 96
  TextHeight = 13
  object Label154: TLabel
    Left = 6
    Top = 0
    Width = 42
    Height = 13
    Caption = 'Scenery:'
  end
  object Label158: TLabel
    Left = 130
    Top = 0
    Width = 38
    Height = 13
    Caption = 'Version:'
  end
  object Label114: TLabel
    Left = 677
    Top = 28
    Width = 18
    Height = 13
    Caption = '<<<'
  end
  object Label26: TLabel
    Left = 700
    Top = 28
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label79: TLabel
    Left = 712
    Top = 28
    Width = 18
    Height = 13
    Caption = '>>>'
  end
  object Label27: TLabel
    Left = 760
    Top = 28
    Width = 11
    Height = 13
    Caption = '5x'
  end
  object Label25: TLabel
    Left = 632
    Top = 28
    Width = 14
    Height = 13
    Caption = '-5x'
  end
  object Label21: TLabel
    Left = 632
    Top = -2
    Width = 47
    Height = 13
    Caption = 'Test-drive'
  end
  object Label107: TLabel
    Left = 308
    Top = 0
    Width = 67
    Height = 13
    Caption = 'Render mode:'
  end
  object Panel1: TPanel
    Left = 300
    Top = 40
    Width = 646
    Height = 622
    Cursor = crCross
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = clBlack
    TabOrder = 0
    OnClick = RenderFrame
    OnDblClick = Panel1DblClick
    OnMouseDown = Panel1MouseDown
    OnMouseMove = Panel1MouseMove
    OnMouseUp = Panel1MouseUp
  end
  object MemoLog: TMemo
    Left = 304
    Top = 116
    Width = 177
    Height = 301
    Anchors = [akLeft, akBottom]
    Lines.Strings = (
      'Temp Log:')
    TabOrder = 18
    Visible = False
    OnClick = MemoLogClick
  end
  object PageControl1: TPageControl
    Left = 2
    Top = 40
    Width = 296
    Height = 623
    ActivePage = TabSheet18
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    Style = tsButtons
    TabHeight = 47
    TabIndex = 13
    TabOrder = 1
    TabStop = False
    TabWidth = 34
    OnChange = PageControl1Change
    OnDrawTab = PageControl1DrawTab
    object TabSheet9: TTabSheet
      Caption = 'LWO'
      DesignSize = (
        288
        516)
      object Label128: TLabel
        Left = 32
        Top = 64
        Width = 22
        Height = 13
        Caption = 'Path'
      end
      object MemoLWO: TMemo
        Left = 2
        Top = 120
        Width = 284
        Height = 391
        Hint = '1'
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 4
      end
      object CreateNewScen: TButton
        Left = 2
        Top = 2
        Width = 137
        Height = 25
        Caption = 'Create new scenery'
        TabOrder = 6
        OnClick = CreateNewScenClick
      end
      object LoadLWOScen: TButton
        Left = 2
        Top = 32
        Width = 137
        Height = 25
        Caption = 'Import LWO ...'
        TabOrder = 0
        OnClick = BrowseLWO
      end
      object Button6: TButton
        Left = 146
        Top = 124
        Width = 137
        Height = 17
        Caption = 'Prepare'
        Enabled = False
        TabOrder = 1
        Visible = False
        OnClick = PrepareLWOData
      end
      object Button9: TButton
        Left = 146
        Top = 140
        Width = 137
        Height = 17
        Caption = 'Compile VTX\IDX'
        Enabled = False
        TabOrder = 3
        Visible = False
        OnClick = CompileVTX_IDX
      end
      object Button8: TButton
        Left = 146
        Top = 156
        Width = 137
        Height = 17
        Caption = 'Compile QAD'
        Enabled = False
        TabOrder = 2
        Visible = False
        OnClick = CompileQAD
      end
      object Button7: TButton
        Left = 146
        Top = 172
        Width = 137
        Height = 17
        Caption = 'Prepare Other Data'
        Enabled = False
        TabOrder = 5
        Visible = False
        OnClick = PrepareOtherData
      end
      object ReloadLWO: TBitBtn
        Left = 2
        Top = 56
        Width = 25
        Height = 25
        ModalResult = 4
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = ReloadLWOClick
        Glyph.Data = {
          AA030000424DAA03000000000000360000002800000011000000110000000100
          18000000000074030000C40E0000C40E00000000000000000000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D400C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4C8D0D4C8
          D0D4008000008000008000008000008000008000008000008000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4008000008000C8D0D4C8D0D4C8D0D4C8D0D400C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4008000008000C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4C8D0D4000080C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4008000C8D0D4C8
          D0D4C8D0D400C8D0D4C8D0D4000080000080000080C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4008000008000C8D0D4008000C8D0D400800000800000C8D0D4000080
          000080000080000080000080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40080000080
          00008000008000008000C8D0D400000080000080C8D0D4000080C8D0D4000080
          000080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4008000008000008000C8D0D4C8D0
          D400C8D0D4C8D0D4C8D0D4000080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4008000C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4C8D0D400
          0080000080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4C8D0D4C8D0D4000080000080C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D400008000008000008000008000008000008000
          0080000080C8D0D4C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D400C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D400}
        Layout = blGlyphBottom
        Spacing = 0
      end
      object CBLoadTexList: TCheckBox
        Left = 4
        Top = 86
        Width = 125
        Height = 17
        Caption = 'Load TexturesList.dat'
        Checked = True
        State = cbChecked
        TabOrder = 8
      end
      object CBLoadMatList: TCheckBox
        Left = 4
        Top = 102
        Width = 125
        Height = 17
        Caption = 'Load MaterialsList.dat'
        Checked = True
        State = cbChecked
        TabOrder = 9
      end
      object Button2: TButton
        Left = 146
        Top = 100
        Width = 137
        Height = 17
        Caption = 'Optimize vertices'
        TabOrder = 10
        OnClick = OptimizeVerticesClick
      end
      object Button3: TButton
        Left = 144
        Top = 32
        Width = 137
        Height = 25
        Caption = 'Import VRL folder ...'
        TabOrder = 11
        OnClick = Button3Click
      end
    end
    object TabSheet16: TTabSheet
      Caption = 'Grounds'
      ImageIndex = 1
      object Label70: TLabel
        Left = 6
        Top = 0
        Width = 58
        Height = 13
        Caption = 'Grounds list:'
      end
      object Label72: TLabel
        Left = 202
        Top = 43
        Width = 40
        Height = 13
        Caption = 'Dirtiness'
      end
      object Label73: TLabel
        Left = 202
        Top = 67
        Width = 44
        Height = 13
        Caption = 'Front grip'
      end
      object Label74: TLabel
        Left = 202
        Top = 91
        Width = 43
        Height = 13
        Caption = 'Rear grip'
      end
      object Label75: TLabel
        Left = 202
        Top = 115
        Width = 48
        Height = 13
        Caption = 'Stickiness'
      end
      object ListGrounds: TListBox
        Left = 2
        Top = 16
        Width = 133
        Height = 161
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListGroundsClick
      end
      object SpinEdit1: TSpinEdit
        Left = 140
        Top = 40
        Width = 57
        Height = 22
        Increment = 5
        MaxValue = 100
        MinValue = 0
        TabOrder = 1
        Value = 0
        OnChange = GroundsChange
      end
      object SE_GripF: TSpinEdit
        Left = 140
        Top = 64
        Width = 57
        Height = 22
        Increment = 5
        MaxValue = 100
        MinValue = 0
        TabOrder = 2
        Value = 0
        OnChange = GroundsChange
      end
      object SE_GripR: TSpinEdit
        Left = 140
        Top = 88
        Width = 57
        Height = 22
        Increment = 5
        MaxValue = 100
        MinValue = 0
        TabOrder = 3
        Value = 0
        OnChange = GroundsChange
      end
      object SpinEdit4: TSpinEdit
        Left = 140
        Top = 112
        Width = 57
        Height = 22
        Increment = 5
        MaxValue = 100
        MinValue = 0
        TabOrder = 4
        Value = 0
        OnChange = GroundsChange
      end
      object AddGround: TButton
        Left = 140
        Top = 16
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = AddGroundClick
      end
      object RemGround: TButton
        Left = 160
        Top = 16
        Width = 21
        Height = 21
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = RemGroundClick
      end
      object CBShowGround: TCheckBox
        Left = 140
        Top = 0
        Width = 91
        Height = 13
        Caption = 'Show selected'
        TabOrder = 7
      end
      object Gr_Skid: TRadioGroup
        Left = 92
        Top = 184
        Width = 93
        Height = 73
        Caption = '  Skidmarks  '
        Items.Strings = (
          'None'
          'Hard'
          'Always soft'
          'Always hard')
        TabOrder = 8
        OnClick = GroundsChange
      end
      object Gr_Noise: TRadioGroup
        Left = 4
        Top = 184
        Width = 85
        Height = 73
        Caption = '  Noise  '
        Items.Strings = (
          'Asphalt'
          'Grass'
          'Sand'
          'Unknown')
        TabOrder = 9
        OnClick = GroundsChange
      end
      object ExportGrounds: TButton
        Left = 140
        Top = 397
        Width = 133
        Height = 25
        Caption = 'Export grounds list ...'
        TabOrder = 10
        OnClick = ExportGroundsClick
      end
      object ImportGrounds: TButton
        Left = 2
        Top = 397
        Width = 133
        Height = 25
        Caption = 'Import grounds list ...'
        TabOrder = 11
        OnClick = ImportGroundsClick
      end
      object Gr_NoColli: TCheckBox
        Left = 140
        Top = 140
        Width = 73
        Height = 17
        Caption = 'No collision'
        TabOrder = 12
        OnClick = GroundsChange
      end
      object RenGround: TButton
        Left = 180
        Top = 16
        Width = 61
        Height = 21
        Caption = 'Rename'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        OnClick = RenGroundClick
      end
      object Gr_Unknown: TRadioGroup
        Left = 188
        Top = 184
        Width = 85
        Height = 73
        Caption = '  Unknown  '
        Items.Strings = (
          'None'
          'Unknown'
          'Unknown'
          'Unknown')
        TabOrder = 14
        OnClick = GroundsChange
      end
    end
    object TabSheet15: TTabSheet
      Caption = 'Textures'
      ImageIndex = 2
      DesignSize = (
        288
        516)
      object Label58: TLabel
        Left = 6
        Top = 0
        Width = 65
        Height = 13
        Caption = 'Textures files:'
      end
      object ListTextures: TListBox
        Left = 2
        Top = 16
        Width = 133
        Height = 441
        Style = lbOwnerDrawFixed
        Anchors = [akLeft, akTop, akBottom]
        ExtendedSelect = False
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListTexturesClick
        OnDrawItem = ListDrawItem
      end
      object AddTexture: TButton
        Left = 140
        Top = 32
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = AddTextureClick
      end
      object RemTexture: TButton
        Left = 160
        Top = 32
        Width = 21
        Height = 21
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = RemTextureClick
      end
      object ImportTexturesList: TButton
        Left = 2
        Top = 489
        Width = 133
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Import assignments list ...'
        TabOrder = 3
        OnClick = ImportTexturesClick
      end
      object ExportTexturesList: TButton
        Left = 140
        Top = 489
        Width = 133
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Export assignments list ...'
        TabOrder = 4
        OnClick = ExportTexturesListClick
      end
      object RGTexMat: TRadioGroup
        Left = 140
        Top = 56
        Width = 145
        Height = 201
        Caption = '  Assign to ground:  '
        Items.Strings = (
          'Asphalt'
          'Grass'
          'Ground'
          'Sand'
          'etc..'
          'etc..'
          'etc..'
          'etc..'
          'etc..'
          'etc..'
          'etc..'
          'etc..')
        TabOrder = 5
        OnClick = RGTexMatClick
      end
      object CBShowTexInMat: TCheckBox
        Left = 140
        Top = 0
        Width = 92
        Height = 13
        Caption = 'Show selected'
        TabOrder = 6
      end
      object RenTexture: TButton
        Left = 180
        Top = 32
        Width = 61
        Height = 21
        Caption = 'Rename'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = RenTextureClick
      end
      object CBTexGrass: TCheckBox
        Left = 140
        Top = 260
        Width = 73
        Height = 17
        Caption = 'Has grass'
        TabOrder = 8
        OnClick = RGTexMatClick
      end
      object CBShowTexGrass: TCheckBox
        Left = 140
        Top = 14
        Width = 141
        Height = 17
        Caption = 'Show textures with grass'
        TabOrder = 9
      end
      object Button4: TButton
        Left = 240
        Top = 32
        Width = 41
        Height = 21
        Caption = 'Auto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnClick = Button4Click
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'Materials'
      ImageIndex = 3
      DesignSize = (
        288
        516)
      object Label38: TLabel
        Left = 6
        Top = 0
        Width = 60
        Height = 13
        Caption = 'Materials list:'
      end
      object Label40: TLabel
        Left = 6
        Top = 335
        Width = 45
        Height = 13
        Caption = 'Texture 1'
      end
      object Label41: TLabel
        Left = 102
        Top = 335
        Width = 45
        Height = 13
        Caption = 'Texture 2'
      end
      object Label42: TLabel
        Left = 198
        Top = 335
        Width = 45
        Height = 13
        Caption = 'Texture 3'
      end
      object Label49: TLabel
        Left = 222
        Top = 473
        Width = 27
        Height = 13
        Caption = 'Move'
      end
      object Label50: TLabel
        Left = 222
        Top = 425
        Width = 32
        Height = 13
        Caption = 'Rotate'
      end
      object Label51: TLabel
        Left = 222
        Top = 449
        Width = 27
        Height = 13
        Caption = 'Scale'
      end
      object Label43: TLabel
        Left = 10
        Top = 406
        Width = 28
        Height = 13
        Caption = 'X axis'
      end
      object Label44: TLabel
        Left = 82
        Top = 406
        Width = 28
        Height = 13
        Caption = 'Y axis'
      end
      object Label45: TLabel
        Left = 154
        Top = 406
        Width = 28
        Height = 13
        Caption = 'Z axis'
      end
      object MatTexLay: TPageControl
        Left = 2
        Top = 376
        Width = 285
        Height = 25
        ActivePage = TabSheet12
        TabIndex = 0
        TabOrder = 6
        OnChange = MatTexLayChange
        object TabSheet12: TTabSheet
          Caption = '   Texture 1   '
        end
        object TabSheet13: TTabSheet
          Caption = '   Texture 2   '
          ImageIndex = 1
        end
        object TabSheet14: TTabSheet
          Caption = '   Texture 3   '
          ImageIndex = 2
        end
      end
      object ListMaterials: TListBox
        Left = 2
        Top = 16
        Width = 151
        Height = 297
        Style = lbOwnerDrawFixed
        ExtendedSelect = False
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListMaterialsClick
        OnDrawItem = ListDrawItem
      end
      object RGMatMode: TRadioGroup
        Left = 157
        Top = 60
        Width = 129
        Height = 221
        Caption = '  Mapping Mode  '
        Items.Strings = (
          '0  Terrain, 3 textures'
          '16 UV+Terrain'
          '32 Only UV'
          '48 '
          '64 '
          '80 '
          '96 '
          '112 Reflective UV'
          '128 Roads'
          '144 Roads'
          '160 Roads'
          '176 Roads'
          '192'
          '208 Color-key mask'
          '224 Water surface'
          '240 Smooth mask')
        TabOrder = 1
        OnClick = RGMatModeClick
      end
      object CBTex1: TComboBox
        Left = 2
        Top = 348
        Width = 94
        Height = 21
        Style = csDropDownList
        DropDownCount = 24
        ItemHeight = 0
        TabOrder = 2
        OnChange = CBTexChange
      end
      object CBTex2: TComboBox
        Left = 98
        Top = 348
        Width = 94
        Height = 21
        Style = csDropDownList
        DropDownCount = 24
        ItemHeight = 0
        TabOrder = 3
        OnChange = CBTexChange
      end
      object CBTex3: TComboBox
        Left = 194
        Top = 348
        Width = 94
        Height = 21
        Style = csDropDownList
        DropDownCount = 24
        ItemHeight = 0
        TabOrder = 4
        OnChange = CBTexChange
      end
      object CBShowMat: TCheckBox
        Left = 160
        Top = 26
        Width = 91
        Height = 17
        Caption = 'Show selected'
        TabOrder = 5
      end
      object CBMatFilter: TComboBox
        Left = 240
        Top = 2
        Width = 45
        Height = 21
        Style = csDropDownList
        DropDownCount = 32
        Enabled = False
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 7
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '16'
          '17'
          '18'
          '32'
          '33'
          '48'
          '64'
          '80'
          '96'
          '112'
          '128'
          '144'
          '160'
          '176'
          '192'
          '208'
          '224'
          '240'
          'Grass')
      end
      object TexScaleX: TFloatSpinEdit
        Left = 6
        Top = 446
        Width = 67
        Height = 22
        Accuracy = 1
        Increment = 1
        TabOrder = 8
        OnChange = TexScaleChange
      end
      object TexScaleY: TFloatSpinEdit
        Left = 150
        Top = 446
        Width = 67
        Height = 22
        Accuracy = 1
        Increment = 1
        TabOrder = 9
        OnChange = TexScaleChange
      end
      object TexMoveX: TFloatSpinEdit
        Left = 6
        Top = 470
        Width = 67
        Height = 22
        Accuracy = 2
        Increment = 0.1
        TabOrder = 10
        OnChange = TexScaleChange
      end
      object TexMoveY: TFloatSpinEdit
        Left = 150
        Top = 470
        Width = 67
        Height = 22
        Accuracy = 2
        Increment = 0.1
        TabOrder = 11
        OnChange = TexScaleChange
      end
      object CBTraceMat: TCheckBox
        Left = 160
        Top = 42
        Width = 105
        Height = 17
        Caption = 'Focus on selected'
        TabOrder = 12
        OnClick = CBTraceMatClick
      end
      object ImportMatList: TButton
        Left = 2
        Top = 489
        Width = 133
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Import materials list ...'
        TabOrder = 13
        OnClick = ImportMaterialsClick
      end
      object ExportMatList: TButton
        Left = 140
        Top = 489
        Width = 133
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Export materials list ...'
        TabOrder = 14
        OnClick = ExportMaterialsClick
      end
      object CBMatGrass: TCheckBox
        Left = 160
        Top = 282
        Width = 73
        Height = 17
        Caption = 'Has grass'
        TabOrder = 15
        OnClick = RGMatModeClick
      end
      object TexRotX: TFloatSpinEdit
        Left = 6
        Top = 422
        Width = 67
        Height = 22
        Accuracy = 0
        Increment = 1
        TabOrder = 16
        OnChange = TexScaleChange
      end
      object TexRotY: TFloatSpinEdit
        Left = 78
        Top = 422
        Width = 67
        Height = 22
        Accuracy = 0
        Increment = 1
        TabOrder = 17
        OnChange = TexScaleChange
      end
      object TexRotZ: TFloatSpinEdit
        Left = 150
        Top = 422
        Width = 67
        Height = 22
        Accuracy = 0
        Increment = 1
        TabOrder = 18
        OnChange = TexScaleChange
      end
      object CBShowMode: TCheckBox
        Left = 160
        Top = 4
        Width = 75
        Height = 17
        Caption = 'Show mode'
        TabOrder = 19
        OnClick = CBShowModeClick
      end
      object CBMatEnlite: TCheckBox
        Left = 232
        Top = 282
        Width = 49
        Height = 17
        Caption = 'Enlite'
        TabOrder = 20
        OnClick = RGMatModeClick
      end
      object CBMatNoShadow: TCheckBox
        Left = 160
        Top = 298
        Width = 97
        Height = 17
        Caption = 'Cast no shadow'
        TabOrder = 21
        OnClick = RGMatModeClick
      end
      object Panel6: TPanel
        Left = -2
        Top = 316
        Width = 292
        Height = 18
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'Sky presets'
        TabOrder = 22
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Objects'
      ImageIndex = 4
      DesignSize = (
        288
        516)
      object Label28: TLabel
        Left = 6
        Top = 0
        Width = 55
        Height = 13
        Caption = 'Object files:'
      end
      object Label29: TLabel
        Left = 6
        Top = 288
        Width = 82
        Height = 13
        Caption = 'Object instances:'
      end
      object Label34: TLabel
        Left = 238
        Top = 213
        Width = 45
        Height = 13
        Caption = 'Hit sound'
      end
      object Label35: TLabel
        Left = 238
        Top = 237
        Width = 48
        Height = 13
        Caption = 'Fall sound'
      end
      object Label36: TLabel
        Left = 206
        Top = 189
        Width = 34
        Height = 13
        Caption = 'Weight'
      end
      object Label100: TLabel
        Left = 218
        Top = 415
        Width = 47
        Height = 13
        Caption = 'Position Z'
      end
      object Label101: TLabel
        Left = 218
        Top = 391
        Width = 47
        Height = 13
        Caption = 'Position Y'
      end
      object Label102: TLabel
        Left = 218
        Top = 367
        Width = 47
        Height = 13
        Caption = 'Position X'
      end
      object Label103: TLabel
        Left = 218
        Top = 439
        Width = 27
        Height = 13
        Caption = 'Angle'
      end
      object Label104: TLabel
        Left = 218
        Top = 463
        Width = 20
        Height = 13
        Caption = 'Size'
      end
      object Image9: TImage
        Left = 268
        Top = 365
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
          FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
          404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
          40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
          8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Image10: TImage
        Left = 268
        Top = 389
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040404040
          404040FFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFF
          FFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040FFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFF
          FFFFFFFFFF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFF40404080808080
          8080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFF404040808080808080808080808080404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040FFFFFFFFFFFFFFFFFF4040408080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Image11: TImage
        Left = 268
        Top = 413
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
          FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
          404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
          40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
          8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Label30: TLabel
        Left = 144
        Top = 324
        Width = 60
        Height = 13
        Caption = 'Object name'
      end
      object Label47: TLabel
        Left = 140
        Top = 500
        Width = 63
        Height = 13
        Caption = 'Parent block:'
      end
      object Label105: TLabel
        Left = 140
        Top = 516
        Width = 63
        Height = 13
        Caption = 'Parent block:'
      end
      object Shape10: TShape
        Left = 233
        Top = 302
        Width = 56
        Height = 30
        Brush.Color = clSkyBlue
        Pen.Style = psClear
        Pen.Width = 0
      end
      object Shape11: TShape
        Left = 137
        Top = 362
        Width = 80
        Height = 124
        Brush.Color = clSkyBlue
        Pen.Style = psClear
        Pen.Width = 0
      end
      object ListObjects: TListBox
        Left = 2
        Top = 16
        Width = 133
        Height = 239
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListObjectsClick
      end
      object ListObjects2: TListBox
        Left = 2
        Top = 304
        Width = 133
        Height = 153
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        TabOrder = 1
        OnClick = ListObjects2Click
        OnDblClick = ListObjects2DblClick
      end
      object ObjHit: TEdit
        Left = 140
        Top = 210
        Width = 93
        Height = 21
        TabOrder = 2
        OnChange = ObjChange
      end
      object ObjFall: TEdit
        Left = 140
        Top = 234
        Width = 93
        Height = 21
        TabOrder = 3
        OnChange = ObjChange
      end
      object ObjWeight: TSpinEdit
        Left = 140
        Top = 186
        Width = 61
        Height = 22
        Increment = 10
        MaxValue = 50000
        MinValue = 0
        TabOrder = 4
        Value = 0
        OnChange = ObjChange
      end
      object ObjX: TFloatSpinEdit
        Left = 140
        Top = 364
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 6
        OnChange = ObjChangeInstance
      end
      object ObjY: TFloatSpinEdit
        Left = 140
        Top = 388
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 7
        OnChange = ObjChangeInstance
      end
      object ObjZ: TFloatSpinEdit
        Left = 140
        Top = 412
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 8
        OnChange = ObjChangeInstance
      end
      object ObjSize: TFloatSpinEdit
        Left = 140
        Top = 460
        Width = 73
        Height = 22
        Accuracy = 2
        Increment = 0.1
        TabOrder = 9
        OnChange = ObjChangeInstance
      end
      object ObjAngl: TSpinEdit
        Left = 140
        Top = 436
        Width = 73
        Height = 22
        Increment = 5
        MaxValue = 0
        MinValue = 0
        TabOrder = 10
        Value = 0
        OnChange = ObjChangeInstance
      end
      object AddObject: TButton
        Left = 140
        Top = 16
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnClick = AddObjectClick
      end
      object RemObject: TButton
        Left = 160
        Top = 16
        Width = 21
        Height = 21
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = RemObjectClick
      end
      object CBObjShape: TRadioGroup
        Left = 140
        Top = 124
        Width = 145
        Height = 57
        Caption = '  Collision shape  '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Self'
          'Pylon'
          'Bake'
          'Heavybox'
          'Lightbox')
        TabOrder = 12
        OnClick = ObjChange
      end
      object CBObjMode: TRadioGroup
        Left = 140
        Top = 40
        Width = 145
        Height = 81
        Caption = '  Mode  '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          '0 Static'
          '3 Sprite'
          '4 Wave'
          '5'
          '6 Sway'
          '7 Propeller'
          '8 Sprite'
          '16 Tree'
          '17 XTree')
        TabOrder = 13
        OnClick = ObjChange
      end
      object AddObjInstance: TButton
        Left = 140
        Top = 304
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        OnClick = AddObjInstanceClick
      end
      object RemObjInstance: TButton
        Left = 160
        Top = 304
        Width = 21
        Height = 21
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        OnClick = RemObjInstanceClick
      end
      object Button12: TButton
        Left = 2
        Top = 489
        Width = 133
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Load instances list ...'
        TabOrder = 16
        OnClick = Button12Click
      end
      object Button15: TButton
        Left = 140
        Top = 489
        Width = 133
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Save instances list ...'
        TabOrder = 17
        OnClick = Button15Click
      end
      object Button18: TButton
        Left = 140
        Top = 260
        Width = 133
        Height = 25
        Caption = 'Save objects list ...'
        TabOrder = 18
        OnClick = Button18Click
      end
      object Button19: TButton
        Left = 2
        Top = 260
        Width = 133
        Height = 25
        Caption = 'Load objects list ...'
        TabOrder = 19
        OnClick = ImportObjectsClick
      end
      object RenObject: TButton
        Left = 180
        Top = 16
        Width = 61
        Height = 21
        Caption = 'Rename'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 20
        OnClick = RenObjectClick
      end
      object CBShowObjects: TCheckBox
        Left = 140
        Top = 0
        Width = 92
        Height = 13
        Caption = 'Show selected'
        TabOrder = 21
      end
      object LoadInstancesFromLWO: TButton
        Left = 2
        Top = 463
        Width = 133
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Load LWO ...'
        TabOrder = 22
        OnClick = LoadInstancesFromLWOClick
      end
      object ListObjectsInstances: TComboBox
        Left = 140
        Top = 340
        Width = 141
        Height = 21
        Style = csDropDownList
        DropDownCount = 16
        ItemHeight = 0
        TabOrder = 23
        OnChange = ObjChangeInstance
      end
      object ObjInShadow: TCheckBox
        Left = 140
        Top = 484
        Width = 101
        Height = 17
        Caption = 'Dark (in shadow)'
        TabOrder = 24
        OnClick = ObjChangeInstance
      end
      object AutoObjects: TButton
        Left = 240
        Top = 16
        Width = 41
        Height = 21
        Caption = 'Auto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 25
        OnClick = AutoObjectsClick
      end
      object CopyInstance: TBitBtn
        Left = 236
        Top = 304
        Width = 25
        Height = 25
        TabOrder = 26
        OnClick = CopyInstanceClick
        Glyph.Data = {
          5A010000424D5A01000000000000760000002800000013000000130000000100
          040000000000E400000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF777777FFFF
          FFFFFFF00000F7777777777FFFFFFFF00000F700077777FFFFFFFFF00000FF07
          70777FFFFFFFFFF00000FF07770FFFFFFFFFFFF00000FFF07770FFFFFFFFFFF0
          0000FFFF07770FFFFFFFFFF00000FFFFF07FF0FFFFFFFFF00000FFFFFF0FFF0F
          FFFFFFF00000FFFFFFF0FFF0F0FFFFF00000FFFFFFFF0FFF00FFFFF00000FFFF
          FFFFF0F0000FFFF00000FFFFFFFFFF000000FFF00000FFFFFFFFF00000000FF0
          0000FFFFFFFFFFF0000000F00000FFFFFFFFFFFF00F000F00000FFFFFFFFFFFF
          F00F00F00000FFFFFFFFFFFFFF000FF00000FFFFFFFFFFFFFFFFFFF00000}
        Margin = 0
        Spacing = 0
      end
      object PasteInstance: TBitBtn
        Left = 260
        Top = 304
        Width = 25
        Height = 25
        TabOrder = 27
        OnClick = PasteInstanceClick
        Glyph.Data = {
          AA040000424DAA04000000000000360000002800000013000000130000000100
          18000000000074040000C40E0000C40E00000000000000000000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000000000000000000000
          000000000000000000000000C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0000000C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0000000C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400
          0000C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000
          C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4000000000000000000000000C0C0
          C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D400
          0000C8D0D4C8D0D4C8D0D4C8D0D4000000C0C0C0C0C0C0000000C0C0C0C0C0C0
          000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4000000C8D0
          D4000000000000000000000000C0C0C0C0C0C0000000C0C0C0C0C0C0000000C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4000000C8D0D4000000
          C0C0C0C0C0C0000000C0C0C0C0C0C0000000C0C0C0C0C0C00000000000000000
          00000000000000000000000000000000C8D0D4000000C8D0D4000000C0C0C0C0
          C0C0000000C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0000000C8D0D4C8D0D4C8D0D4000000C8D0D4000000C0C0C0C0C0C00000
          00C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000C8D0D4C8D0D4C8D0D4000000C8D0D4000000C0C0C0C0C0C0000000C0C0C0
          C0C0C0000000000000000000000000000000000000000000000000000000C8D0
          D4C8D0D4C8D0D4000000C8D0D4000000C0C0C0C0C0C0000000C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4000000C8D0D4000000C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400
          0000C8D0D4000000C0C0C0C0C0C0000000000000000000000000000000000000
          000000000000000000000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0
          D4000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D4000000
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D400000000000000
          0000000000000000000000000000000000000000000000000000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4000000}
        Margin = 0
        Spacing = 0
      end
    end
    object TabSheet11: TTabSheet
      Caption = 'Sounds'
      ImageIndex = 5
      DesignSize = (
        288
        516)
      object Label39: TLabel
        Left = 6
        Top = 0
        Width = 79
        Height = 13
        Caption = 'Sound locations:'
      end
      object Label18: TLabel
        Left = 218
        Top = 117
        Width = 47
        Height = 13
        Caption = 'Position Z'
      end
      object Label60: TLabel
        Left = 218
        Top = 93
        Width = 47
        Height = 13
        Caption = 'Position Y'
      end
      object Label61: TLabel
        Left = 218
        Top = 69
        Width = 47
        Height = 13
        Caption = 'Position X'
      end
      object Label62: TLabel
        Left = 202
        Top = 219
        Width = 47
        Height = 13
        Caption = 'Radius, m'
      end
      object Label63: TLabel
        Left = 202
        Top = 195
        Width = 47
        Height = 13
        Caption = 'Tempo, %'
      end
      object Label64: TLabel
        Left = 202
        Top = 171
        Width = 35
        Height = 13
        Caption = 'Volume'
      end
      object Label68: TLabel
        Left = 248
        Top = 48
        Width = 27
        Height = 13
        Caption = 'Entry:'
      end
      object Label65: TLabel
        Left = 202
        Top = 343
        Width = 50
        Height = 13
        Caption = 'Delay, sec'
      end
      object Label66: TLabel
        Left = 202
        Top = 319
        Width = 46
        Height = 13
        Caption = 'Unknown'
      end
      object Image1: TImage
        Left = 268
        Top = 67
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
          FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
          404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
          40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
          8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Image2: TImage
        Left = 268
        Top = 115
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
          FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
          404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
          40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
          8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Image3: TImage
        Left = 268
        Top = 91
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040404040
          404040FFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFF
          FFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040FFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFF
          FFFFFFFFFF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFF40404080808080
          8080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFF404040808080808080808080808080404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040FFFFFFFFFFFFFFFFFF4040408080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Shape5: TShape
        Left = 137
        Top = 138
        Width = 56
        Height = 30
        Brush.Color = clSkyBlue
        Pen.Style = psClear
        Pen.Width = 0
      end
      object Shape6: TShape
        Left = 137
        Top = 37
        Width = 108
        Height = 28
        Brush.Color = clSkyBlue
        Pen.Style = psClear
        Pen.Width = 0
      end
      object Shape7: TShape
        Left = 137
        Top = 165
        Width = 64
        Height = 76
        Brush.Color = clSkyBlue
        Pen.Style = psClear
        Pen.Width = 0
      end
      object Shape8: TShape
        Left = 137
        Top = 237
        Width = 152
        Height = 76
        Brush.Color = clSkyBlue
        Pen.Style = psClear
        Pen.Width = 0
      end
      object Shape9: TShape
        Left = 137
        Top = 338
        Width = 64
        Height = 28
        Brush.Color = clSkyBlue
        Pen.Style = psClear
        Pen.Width = 0
      end
      object ListSounds: TListBox
        Left = 2
        Top = 16
        Width = 133
        Height = 342
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListSoundsClick
        OnDblClick = ListSoundsDblClick
      end
      object SoundPosX: TFloatSpinEdit
        Left = 140
        Top = 66
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 1
        OnChange = SoundsChange
      end
      object SoundPosY: TFloatSpinEdit
        Left = 140
        Top = 90
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 2
        OnChange = SoundsChange
      end
      object SoundPosZ: TFloatSpinEdit
        Left = 140
        Top = 114
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 3
        OnChange = SoundsChange
      end
      object SoundVolume: TSpinEdit
        Left = 140
        Top = 168
        Width = 57
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 4
        Value = 0
        OnChange = SoundsChange
      end
      object SoundPlaySpeed: TSpinEdit
        Left = 140
        Top = 192
        Width = 57
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 5
        Value = 0
        OnChange = SoundsChange
      end
      object SoundRadius: TSpinEdit
        Left = 140
        Top = 216
        Width = 57
        Height = 22
        Increment = 10
        MaxValue = 0
        MinValue = 0
        TabOrder = 6
        Value = 0
        OnChange = SoundsChange
      end
      object EditSoundName: TEdit
        Left = 140
        Top = 40
        Width = 101
        Height = 21
        TabOrder = 7
        OnChange = SoundsChange
      end
      object SoundX5: TSpinEdit
        Left = 140
        Top = 316
        Width = 57
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 8
        Value = 0
        OnChange = SoundsChange
      end
      object AddSound: TButton
        Left = 140
        Top = 16
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = AddSoundClick
      end
      object RemSound: TButton
        Left = 160
        Top = 16
        Width = 21
        Height = 21
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnClick = RemSoundClick
      end
      object SoundX6: TFloatSpinEdit
        Left = 140
        Top = 340
        Width = 57
        Height = 22
        Accuracy = 1
        Increment = 0.1
        TabOrder = 11
        OnChange = SoundsChange
      end
      object ImportSounds: TButton
        Left = 2
        Top = 489
        Width = 137
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Import sounds list ...'
        TabOrder = 12
        OnClick = ImportSoundsClick
      end
      object ExportSounds: TButton
        Left = 144
        Top = 489
        Width = 137
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Export sounds list ...'
        TabOrder = 13
        OnClick = ExportSoundsClick
      end
      object SoundX4: TRadioGroup
        Left = 140
        Top = 240
        Width = 147
        Height = 69
        Caption = '  Switch  '
        Items.Strings = (
          '0 Loop'
          '1 Jitter position'
          '2 Loop'
          '3 Jitter position/frequency')
        TabOrder = 14
        OnClick = SoundsChange
      end
      object ImportNFSPUSounds: TButton
        Left = 2
        Top = 461
        Width = 137
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Load NFS-PU ... '
        Enabled = False
        TabOrder = 15
        Visible = False
        OnClick = ImportNFSPUSoundsClick
      end
      object CopySound: TBitBtn
        Left = 140
        Top = 140
        Width = 25
        Height = 25
        TabOrder = 16
        OnClick = CopySoundClick
        Glyph.Data = {
          5A010000424D5A01000000000000760000002800000013000000130000000100
          040000000000E400000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF777777FFFF
          FFFFFFF00000F7777777777FFFFFFFF00000F700077777FFFFFFFFF00000FF07
          70777FFFFFFFFFF00000FF07770FFFFFFFFFFFF00000FFF07770FFFFFFFFFFF0
          0000FFFF07770FFFFFFFFFF00000FFFFF07FF0FFFFFFFFF00000FFFFFF0FFF0F
          FFFFFFF00000FFFFFFF0FFF0F0FFFFF00000FFFFFFFF0FFF00FFFFF00000FFFF
          FFFFF0F0000FFFF00000FFFFFFFFFF000000FFF00000FFFFFFFFF00000000FF0
          0000FFFFFFFFFFF0000000F00000FFFFFFFFFFFF00F000F00000FFFFFFFFFFFF
          F00F00F00000FFFFFFFFFFFFFF000FF00000FFFFFFFFFFFFFFFFFFF00000}
        Margin = 0
        Spacing = 0
      end
      object PasteSound: TBitBtn
        Left = 164
        Top = 140
        Width = 25
        Height = 25
        Enabled = False
        TabOrder = 17
        OnClick = PasteSoundClick
        Glyph.Data = {
          AA040000424DAA04000000000000360000002800000013000000130000000100
          18000000000074040000C40E0000C40E00000000000000000000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000000000000000000000
          000000000000000000000000C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0000000C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0000000C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400
          0000C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000
          C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4000000000000000000000000C0C0
          C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D400
          0000C8D0D4C8D0D4C8D0D4C8D0D4000000C0C0C0C0C0C0000000C0C0C0C0C0C0
          000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4000000C8D0
          D4000000000000000000000000C0C0C0C0C0C0000000C0C0C0C0C0C0000000C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4000000C8D0D4000000
          C0C0C0C0C0C0000000C0C0C0C0C0C0000000C0C0C0C0C0C00000000000000000
          00000000000000000000000000000000C8D0D4000000C8D0D4000000C0C0C0C0
          C0C0000000C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0000000C8D0D4C8D0D4C8D0D4000000C8D0D4000000C0C0C0C0C0C00000
          00C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000C8D0D4C8D0D4C8D0D4000000C8D0D4000000C0C0C0C0C0C0000000C0C0C0
          C0C0C0000000000000000000000000000000000000000000000000000000C8D0
          D4C8D0D4C8D0D4000000C8D0D4000000C0C0C0C0C0C0000000C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4000000C8D0D4000000C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400
          0000C8D0D4000000C0C0C0C0C0C0000000000000000000000000000000000000
          000000000000000000000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0
          D4000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D4000000
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D400000000000000
          0000000000000000000000000000000000000000000000000000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4000000}
        Margin = 0
        Spacing = 0
      end
      object Button1: TButton
        Left = 144
        Top = 405
        Width = 89
        Height = 25
        Caption = 'Load sounds'
        TabOrder = 18
        OnClick = LoadSounds
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Lights'
      ImageIndex = 6
      DesignSize = (
        288
        516)
      object Shape1: TShape
        Left = 137
        Top = 141
        Width = 32
        Height = 32
        Brush.Color = clSkyBlue
        Pen.Style = psClear
        Pen.Width = 0
      end
      object Label120: TLabel
        Left = 218
        Top = 117
        Width = 47
        Height = 13
        Caption = 'Position Z'
      end
      object Label124: TLabel
        Left = 218
        Top = 93
        Width = 47
        Height = 13
        Caption = 'Position Y'
      end
      object Label125: TLabel
        Left = 218
        Top = 69
        Width = 47
        Height = 13
        Caption = 'Position X'
      end
      object Image21: TImage
        Left = 268
        Top = 67
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
          FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
          404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
          40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
          8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Image22: TImage
        Left = 268
        Top = 91
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040404040
          404040FFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFF
          FFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040FFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFF
          FFFFFFFFFF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFF40404080808080
          8080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFF404040808080808080808080808080404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040FFFFFFFFFFFFFFFFFF4040408080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Image23: TImage
        Left = 268
        Top = 115
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
          FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
          404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
          40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
          8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Label129: TLabel
        Left = 206
        Top = 295
        Width = 68
        Height = 13
        Caption = 'Light radius, m'
      end
      object Label130: TLabel
        Left = 6
        Top = 0
        Width = 76
        Height = 13
        Caption = 'Lights locations:'
      end
      object Label153: TLabel
        Left = 190
        Top = 195
        Width = 42
        Height = 13
        Caption = 'Rotate Y'
      end
      object Label155: TLabel
        Left = 206
        Top = 243
        Width = 75
        Height = 13
        Caption = 'Blink duration, s'
      end
      object Label156: TLabel
        Left = 206
        Top = 219
        Width = 63
        Height = 13
        Caption = 'Blink offset, s'
      end
      object Label157: TLabel
        Left = 206
        Top = 267
        Width = 44
        Height = 13
        Caption = 'Blink size'
      end
      object Label24: TLabel
        Left = 144
        Top = 0
        Width = 27
        Height = 13
        Caption = 'Entry:'
      end
      object Light_Col: TShape
        Left = 140
        Top = 144
        Width = 25
        Height = 25
        OnDragDrop = Light_ColDragDrop
        OnMouseUp = ColorShapeMouseUp
      end
      object Label131: TLabel
        Left = 170
        Top = 150
        Width = 49
        Height = 13
        Caption = 'Light color'
      end
      object Shape3: TShape
        Left = 234
        Top = 141
        Width = 57
        Height = 32
        Brush.Color = clSkyBlue
        Pen.Style = psClear
        Pen.Width = 0
      end
      object Shape4: TShape
        Left = 137
        Top = 289
        Width = 68
        Height = 29
        Brush.Color = clSkyBlue
        Pen.Style = psClear
        Pen.Width = 0
      end
      object Shape2: TShape
        Left = 137
        Top = 313
        Width = 108
        Height = 24
        Brush.Color = clSkyBlue
        Pen.Style = psClear
        Pen.Width = 0
      end
      object Shape12: TShape
        Left = 137
        Top = 34
        Width = 56
        Height = 30
        Brush.Color = clCream
        Pen.Style = psClear
        Pen.Width = 0
      end
      object Shape13: TShape
        Left = 137
        Top = 64
        Width = 79
        Height = 75
        Brush.Color = clCream
        Pen.Style = psClear
        Pen.Width = 0
      end
      object ListLights: TListBox
        Left = 2
        Top = 16
        Width = 133
        Height = 279
        Style = lbOwnerDrawFixed
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListLightsClick
        OnDblClick = ListLightsDblClick
        OnDrawItem = ListDrawItem
      end
      object LightX: TFloatSpinEdit
        Left = 140
        Top = 66
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 1
        OnChange = LightsChange
      end
      object LightY: TFloatSpinEdit
        Left = 140
        Top = 90
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 2
        OnChange = LightsChange
      end
      object LightZ: TFloatSpinEdit
        Left = 140
        Top = 114
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 3
        OnChange = LightsChange
      end
      object AddLight: TButton
        Left = 246
        Top = 8
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = AddLightClick
      end
      object RemLight: TButton
        Left = 266
        Top = 8
        Width = 21
        Height = 21
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = RemLightClick
      end
      object LightWRad: TSpinEdit
        Left = 140
        Top = 292
        Width = 61
        Height = 22
        Increment = 5
        MaxValue = 1000
        MinValue = 0
        TabOrder = 6
        Value = 25
        OnChange = LightsChange
      end
      object GroupBox1: TGroupBox
        Left = 2
        Top = 340
        Width = 285
        Height = 71
        Caption = '  Global lightning tweak:  '
        TabOrder = 7
        object Label121: TLabel
          Left = 8
          Top = 18
          Width = 33
          Height = 13
          Caption = 'Color ^'
        end
        object Label122: TLabel
          Left = 106
          Top = 18
          Width = 5
          Height = 13
          Caption = 'x'
        end
        object Label123: TLabel
          Left = 178
          Top = 18
          Width = 6
          Height = 13
          Caption = '+'
        end
        object LE_Pow: TFloatSpinEdit
          Left = 46
          Top = 16
          Width = 53
          Height = 22
          Accuracy = 2
          Increment = 0.01
          MaxValue = 10
          MinValue = 0.01
          TabOrder = 0
          Value = 1
        end
        object LE_Mul: TFloatSpinEdit
          Left = 118
          Top = 16
          Width = 53
          Height = 22
          Accuracy = 2
          Increment = 0.01
          MaxValue = 10
          MinValue = 0.01
          TabOrder = 1
          Value = 1
        end
        object LE_Add: TSpinEdit
          Left = 190
          Top = 16
          Width = 53
          Height = 22
          MaxValue = 255
          MinValue = -255
          TabOrder = 2
          Value = 0
        end
        object LE_RGB: TButton
          Left = 8
          Top = 40
          Width = 113
          Height = 25
          Caption = 'Tweak RGB'
          TabOrder = 3
          OnClick = LE_RGBClick
        end
        object LE_Shadow: TButton
          Left = 128
          Top = 40
          Width = 113
          Height = 25
          Caption = 'Tweak Shadows'
          TabOrder = 4
          OnClick = LE_RGBClick
        end
      end
      object LightRY: TFloatSpinEdit
        Left = 140
        Top = 192
        Width = 45
        Height = 22
        Accuracy = 0
        Increment = 10
        TabOrder = 8
        OnChange = LightsChange
      end
      object LightFreq: TFloatSpinEdit
        Left = 140
        Top = 240
        Width = 61
        Height = 22
        Accuracy = 2
        Increment = 0.1
        MaxValue = 1
        TabOrder = 9
        OnChange = LightsChange
      end
      object LightOffset: TFloatSpinEdit
        Left = 140
        Top = 216
        Width = 61
        Height = 22
        Accuracy = 2
        Increment = 0.1
        MaxValue = 10
        TabOrder = 10
        OnChange = LightsChange
      end
      object LightSize: TFloatSpinEdit
        Left = 140
        Top = 264
        Width = 61
        Height = 22
        Accuracy = 2
        Increment = 1
        MaxValue = 50
        TabOrder = 11
        OnChange = LightsChange
      end
      object LightWMode: TCheckBox
        Left = 140
        Top = 316
        Width = 101
        Height = 17
        Caption = 'Hemisphere light'
        TabOrder = 12
        OnClick = LightsChange
      end
      object ExportLights: TButton
        Left = 144
        Top = 489
        Width = 137
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Export lights list ...'
        TabOrder = 13
        OnClick = ExportLightsClick
      end
      object ImportLights: TButton
        Left = 2
        Top = 489
        Width = 133
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Import lights list ...'
        TabOrder = 14
        OnClick = ImportLightsClick
      end
      object LoadLWOLightsButton: TButton
        Left = 2
        Top = 463
        Width = 133
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Load LWO ...'
        TabOrder = 15
        OnClick = LoadLWOLights
      end
      object CopyLight: TBitBtn
        Left = 238
        Top = 144
        Width = 25
        Height = 25
        TabOrder = 16
        OnClick = CopyLightClick
        Glyph.Data = {
          5A010000424D5A01000000000000760000002800000013000000130000000100
          040000000000E400000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF777777FFFF
          FFFFFFF00000F7777777777FFFFFFFF00000F700077777FFFFFFFFF00000FF07
          70777FFFFFFFFFF00000FF07770FFFFFFFFFFFF00000FFF07770FFFFFFFFFFF0
          0000FFFF07770FFFFFFFFFF00000FFFFF07FF0FFFFFFFFF00000FFFFFF0FFF0F
          FFFFFFF00000FFFFFFF0FFF0F0FFFFF00000FFFFFFFF0FFF00FFFFF00000FFFF
          FFFFF0F0000FFFF00000FFFFFFFFFF000000FFF00000FFFFFFFFF00000000FF0
          0000FFFFFFFFFFF0000000F00000FFFFFFFFFFFF00F000F00000FFFFFFFFFFFF
          F00F00F00000FFFFFFFFFFFFFF000FF00000FFFFFFFFFFFFFFFFFFF00000}
        Margin = 0
        Spacing = 0
      end
      object PasteLight: TBitBtn
        Left = 262
        Top = 144
        Width = 25
        Height = 25
        Enabled = False
        TabOrder = 17
        OnClick = PasteLightClick
        Glyph.Data = {
          AA040000424DAA04000000000000360000002800000013000000130000000100
          18000000000074040000C40E0000C40E00000000000000000000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000000000000000000000
          000000000000000000000000C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0000000C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0000000C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400
          0000C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000
          C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4000000000000000000000000C0C0
          C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D400
          0000C8D0D4C8D0D4C8D0D4C8D0D4000000C0C0C0C0C0C0000000C0C0C0C0C0C0
          000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4000000C8D0
          D4000000000000000000000000C0C0C0C0C0C0000000C0C0C0C0C0C0000000C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4000000C8D0D4000000
          C0C0C0C0C0C0000000C0C0C0C0C0C0000000C0C0C0C0C0C00000000000000000
          00000000000000000000000000000000C8D0D4000000C8D0D4000000C0C0C0C0
          C0C0000000C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0000000C8D0D4C8D0D4C8D0D4000000C8D0D4000000C0C0C0C0C0C00000
          00C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000C8D0D4C8D0D4C8D0D4000000C8D0D4000000C0C0C0C0C0C0000000C0C0C0
          C0C0C0000000000000000000000000000000000000000000000000000000C8D0
          D4C8D0D4C8D0D4000000C8D0D4000000C0C0C0C0C0C0000000C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4000000C8D0D4000000C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400
          0000C8D0D4000000C0C0C0C0C0C0000000000000000000000000000000000000
          000000000000000000000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0
          D4000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D4000000
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D400000000000000
          0000000000000000000000000000000000000000000000000000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4000000}
        Margin = 0
        Spacing = 0
      end
      object LightMode: TCheckBox
        Left = 140
        Top = 174
        Width = 45
        Height = 17
        Caption = 'Flare'
        TabOrder = 18
        OnClick = LightsChange
      end
      object CopyLightXYZ: TBitBtn
        Left = 140
        Top = 36
        Width = 25
        Height = 25
        TabOrder = 19
        OnClick = CopyLightXYZClick
        Glyph.Data = {
          5A010000424D5A01000000000000760000002800000013000000130000000100
          040000000000E400000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF777777FFFF
          FFFFFFF00000F7777777777FFFFFFFF00000F700077777FFFFFFFFF00000FF07
          70777FFFFFFFFFF00000FF07770FFFFFFFFFFFF00000FFF07770FFFFFFFFFFF0
          0000FFFF07770FFFFFFFFFF00000FFFFF07FF0FFFFFFFFF00000FFFFFF0FFF0F
          FFFFFFF00000FFFFFFF0FFF0F0FFFFF00000FFFFFFFF0FFF00FFFFF00000FFFF
          FFFFF0F0000FFFF00000FFFFFFFFFF000000FFF00000FFFFFFFFF00000000FF0
          0000FFFFFFFFFFF0000000F00000FFFFFFFFFFFF00F000F00000FFFFFFFFFFFF
          F00F00F00000FFFFFFFFFFFFFF000FF00000FFFFFFFFFFFFFFFFFFF00000}
        Margin = 0
        Spacing = 0
      end
      object PasteLightXYZ: TBitBtn
        Left = 164
        Top = 36
        Width = 25
        Height = 25
        TabOrder = 20
        OnClick = PasteLightXYZClick
        Glyph.Data = {
          AA040000424DAA04000000000000360000002800000013000000130000000100
          18000000000074040000C40E0000C40E00000000000000000000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000000000000000000000
          000000000000000000000000C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0000000C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0000000C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400
          0000C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000
          C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4000000000000000000000000C0C0
          C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D400
          0000C8D0D4C8D0D4C8D0D4C8D0D4000000C0C0C0C0C0C0000000C0C0C0C0C0C0
          000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4000000C8D0
          D4000000000000000000000000C0C0C0C0C0C0000000C0C0C0C0C0C0000000C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4000000C8D0D4000000
          C0C0C0C0C0C0000000C0C0C0C0C0C0000000C0C0C0C0C0C00000000000000000
          00000000000000000000000000000000C8D0D4000000C8D0D4000000C0C0C0C0
          C0C0000000C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0000000C8D0D4C8D0D4C8D0D4000000C8D0D4000000C0C0C0C0C0C00000
          00C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000C8D0D4C8D0D4C8D0D4000000C8D0D4000000C0C0C0C0C0C0000000C0C0C0
          C0C0C0000000000000000000000000000000000000000000000000000000C8D0
          D4C8D0D4C8D0D4000000C8D0D4000000C0C0C0C0C0C0000000C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4000000C8D0D4000000C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400
          0000C8D0D4000000C0C0C0C0C0C0000000000000000000000000000000000000
          000000000000000000000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0
          D4000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D4000000
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D400000000000000
          0000000000000000000000000000000000000000000000000000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4000000C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4000000}
        Margin = 0
        Spacing = 0
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'Structure'
      ImageIndex = 13
      object CBGrid: TCheckBox
        Left = 198
        Top = 195
        Width = 75
        Height = 17
        Caption = 'Show grid'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object StructMode: TRadioGroup
        Left = 198
        Top = -1
        Width = 89
        Height = 194
        Caption = ' StructMode  '
        ItemIndex = 0
        Items.Strings = (
          'none'
          '1st Poly'
          '# Poly'
          '1st Tex'
          '# Tex'
          '1st Obj'
          '# Obj'
          '1st Light'
          '# Light'
          'Chunk65k'
          'Unused ?'
          'BlockRad'
          'Block-Y')
        TabOrder = 1
      end
      object CBTracer: TCheckBox
        Left = 198
        Top = 211
        Width = 75
        Height = 17
        Caption = 'Show tracer'
        TabOrder = 2
      end
      object VLBInfo: TValueListEditor
        Left = 2
        Top = 4
        Width = 191
        Height = 344
        DefaultColWidth = 120
        DefaultRowHeight = 16
        DisplayOptions = [doColumnTitles, doKeyColFixed]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goAlwaysShowEditor, goThumbTracking]
        ParentFont = False
        Strings.Strings = (
          'Scenario width (X)='
          'Scenario length (Z)='
          'X Blocks='
          'Z Blocks='
          'Total blocks='
          'Total surface chunks='
          'Texture files='
          'Bump texture files='
          'Object files='
          'Total polys='
          'Surfaces='
          'Objects instances='
          'Grounds='
          'Collision lenght='
          'Lights='
          'x1='
          'x2='
          'x3='
          'Sounds=')
        TabOrder = 3
        OnClick = ShowQADInfo
        ColWidths = (
          106
          79)
      end
      object CBShowSpan: TCheckBox
        Left = 198
        Top = 227
        Width = 75
        Height = 17
        Caption = 'Show span'
        TabOrder = 4
      end
      object CBShowTrace: TCheckBox
        Left = 198
        Top = 243
        Width = 75
        Height = 17
        Caption = 'Show trace'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Tracks'
      ImageIndex = 8
      DesignSize = (
        288
        516)
      object Label59: TLabel
        Left = 6
        Top = 0
        Width = 36
        Height = 13
        Caption = 'Tracks:'
      end
      object Label78: TLabel
        Left = 144
        Top = 154
        Width = 41
        Height = 13
        Caption = 'Progress'
      end
      object OpenLWO_TRK: TButton
        Left = 144
        Top = 128
        Width = 137
        Height = 25
        Caption = 'Load LWO ...'
        TabOrder = 0
        OnClick = OpenLWO_TRKClick
      end
      object LBTrack: TListBox
        Left = 2
        Top = 16
        Width = 135
        Height = 209
        ItemHeight = 13
        TabOrder = 1
        OnClick = CBTrackChange
      end
      object AddTrack: TButton
        Left = 144
        Top = 16
        Width = 113
        Height = 21
        Caption = 'Add race track'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = AddTrackClick
      end
      object TRK_Loop: TCheckBox
        Left = 144
        Top = 80
        Width = 73
        Height = 17
        Caption = 'Loop track'
        TabOrder = 3
        OnClick = TRK_LoopClick
      end
      object Button11: TButton
        Left = 144
        Top = 168
        Width = 97
        Height = 17
        Caption = 'Make Ideal Line'
        TabOrder = 4
        OnClick = TRK_MakeIdeal
      end
      object TRKProperty: TPageControl
        Left = 2
        Top = 232
        Width = 283
        Height = 281
        ActivePage = TabSheet22
        Anchors = [akLeft, akTop, akBottom]
        TabIndex = 0
        TabOrder = 6
        OnChange = PageControl1Change
        object TabSheet22: TTabSheet
          Caption = 'Make track'
          ImageIndex = 2
          DesignSize = (
            275
            253)
          object Label141: TLabel
            Left = 202
            Top = 97
            Width = 47
            Height = 13
            Caption = 'Position Z'
          end
          object Label161: TLabel
            Left = 202
            Top = 73
            Width = 47
            Height = 13
            Caption = 'Position Y'
          end
          object Label162: TLabel
            Left = 202
            Top = 49
            Width = 47
            Height = 13
            Caption = 'Position X'
          end
          object Image27: TImage
            Left = 252
            Top = 47
            Width = 17
            Height = 15
            AutoSize = True
            Picture.Data = {
              07544269746D617042030000424D420300000000000036000000280000001100
              00000F00000001001800000000000C0300000000000000000000000000000000
              0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
              FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
              FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
              40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
              FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
              404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
              40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
              FF00404040404040404040404040404040404040404040404040404040404040
              808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
              8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
              FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
              40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
              80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
              FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
              404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFF00}
            Transparent = True
          end
          object Image28: TImage
            Left = 252
            Top = 71
            Width = 17
            Height = 15
            AutoSize = True
            Picture.Data = {
              07544269746D617042030000424D420300000000000036000000280000001100
              00000F00000001001800000000000C0300000000000000000000000000000000
              0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
              FFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040404040
              404040FFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF004040
              40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FF
              FFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFF
              FFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFF
              FF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040FFFFFFFFFF
              FF00404040404040404040404040404040404040404040404040404040404040
              404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFF
              FFFFFFFFFF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFF40404080808080
              8080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
              40FFFFFFFFFFFFFFFFFFFFFFFF404040808080808080808080808080404040FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
              FF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF00FFFFFF404040FFFFFFFFFFFFFFFFFF4040408080808080808080
              80404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
              404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFF00}
            Transparent = True
          end
          object Image29: TImage
            Left = 252
            Top = 95
            Width = 17
            Height = 15
            AutoSize = True
            Picture.Data = {
              07544269746D617042030000424D420300000000000036000000280000001100
              00000F00000001001800000000000C0300000000000000000000000000000000
              0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
              FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
              FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
              40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
              FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
              404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
              40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
              FF00404040404040404040404040404040404040404040404040404040404040
              808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
              8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
              FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
              40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
              80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
              FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
              404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFF00}
            Transparent = True
          end
          object Label163: TLabel
            Left = 202
            Top = 129
            Width = 28
            Height = 13
            Caption = 'Width'
          end
          object Label164: TLabel
            Left = 6
            Top = 0
            Width = 34
            Height = 13
            Caption = 'Nodes:'
          end
          object ListMakeTrack: TListBox
            Left = 0
            Top = 16
            Width = 135
            Height = 233
            Anchors = [akLeft, akTop, akBottom]
            ItemHeight = 13
            TabOrder = 0
            OnClick = ListMakeTrackClick
            OnDblClick = ListMakeTrackDblClick
          end
          object MTX: TFloatSpinEdit
            Left = 140
            Top = 44
            Width = 57
            Height = 22
            Accuracy = 1
            Increment = 10
            TabOrder = 3
            OnChange = MTXChange
          end
          object MTY: TFloatSpinEdit
            Left = 140
            Top = 68
            Width = 57
            Height = 22
            Accuracy = 1
            Increment = 10
            TabOrder = 4
            OnChange = MTXChange
          end
          object MTZ: TFloatSpinEdit
            Left = 140
            Top = 92
            Width = 57
            Height = 22
            Accuracy = 1
            Increment = 10
            TabOrder = 5
            OnChange = MTXChange
          end
          object InitMT: TButton
            Left = 140
            Top = 16
            Width = 41
            Height = 21
            Caption = 'Init'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnClick = InitMTClick
          end
          object AddMTNode: TButton
            Left = 186
            Top = 16
            Width = 21
            Height = 21
            Caption = '+'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = AddMTNodeClick
          end
          object RemMTNode: TButton
            Left = 206
            Top = 16
            Width = 21
            Height = 21
            Caption = '-'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = RemMTNodeClick
          end
          object MTW: TFloatSpinEdit
            Left = 140
            Top = 124
            Width = 57
            Height = 22
            Accuracy = 1
            Increment = 1
            MaxValue = 1000
            MinValue = 5
            TabOrder = 7
            Value = 10
            OnChange = MTXChange
          end
          object Button5: TButton
            Left = 232
            Top = 16
            Width = 41
            Height = 21
            Caption = 'Gen'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            OnClick = GenTrackFromMT
          end
        end
        object TabSheet19: TTabSheet
          Caption = 'Direction arrows'
          DesignSize = (
            275
            253)
          object Image7: TImage
            Left = 254
            Top = 45
            Width = 17
            Height = 15
            AutoSize = True
            Picture.Data = {
              07544269746D617042030000424D420300000000000036000000280000001100
              00000F00000001001800000000000C0300000000000000000000000000000000
              0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
              FFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040404040
              404040FFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF004040
              40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FF
              FFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFF
              FFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFF
              FF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040FFFFFFFFFF
              FF00404040404040404040404040404040404040404040404040404040404040
              404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF0040404080808080808080
              8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
              FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
              40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
              80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
              FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
              404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFF00}
            Transparent = True
          end
          object Label3: TLabel
            Left = 202
            Top = 47
            Width = 47
            Height = 13
            Caption = 'Last node'
          end
          object Label2: TLabel
            Left = 202
            Top = 71
            Width = 46
            Height = 13
            Caption = 'First node'
          end
          object Image8: TImage
            Left = 254
            Top = 69
            Width = 17
            Height = 15
            AutoSize = True
            Picture.Data = {
              07544269746D617042030000424D420300000000000036000000280000001100
              00000F00000001001800000000000C0300000000000000000000000000000000
              0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
              FFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040404040
              404040FFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF004040
              40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FF
              FFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFF
              FFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFF
              FF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040FFFFFFFFFF
              FF00404040404040404040404040404040404040404040404040404040404040
              404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFF
              FFFFFFFFFF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFF40404080808080
              8080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
              40FFFFFFFFFFFFFFFFFFFFFFFF404040808080808080808080808080404040FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
              FF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF00FFFFFF404040FFFFFFFFFFFFFFFFFF4040408080808080808080
              80404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
              404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFF00}
            Transparent = True
          end
          object Label1: TLabel
            Left = 202
            Top = 95
            Width = 62
            Height = 13
            Caption = 'Arrows count'
          end
          object Label5: TLabel
            Left = 202
            Top = 119
            Width = 69
            Height = 13
            Caption = 'Move aside, m'
          end
          object Label165: TLabel
            Left = 6
            Top = 0
            Width = 35
            Height = 13
            Caption = 'Arrows:'
          end
          object ListTurns: TListBox
            Left = 0
            Top = 16
            Width = 135
            Height = 233
            Anchors = [akLeft, akTop, akBottom]
            ItemHeight = 13
            TabOrder = 0
            OnClick = ListTurnsChange
            OnDblClick = ListTurnsDblClick
          end
          object E_BitType: TRadioGroup
            Left = 140
            Top = 204
            Width = 73
            Height = 49
            Caption = '  Type  '
            ItemIndex = 1
            Items.Strings = (
              'Cross'
              'Turn')
            TabOrder = 1
            OnClick = ComputeTurnClick
          end
          object E_BitSide: TRadioGroup
            Left = 140
            Top = 140
            Width = 73
            Height = 61
            Caption = '  Side  '
            ItemIndex = 0
            Items.Strings = (
              'Left'
              'Right'
              'X Both')
            TabOrder = 2
            OnClick = ComputeTurnClick
          end
          object E_Aside: TFloatSpinEdit
            Left = 140
            Top = 116
            Width = 57
            Height = 22
            Accuracy = 1
            Increment = 0.5
            MaxValue = 50
            TabOrder = 3
            Value = 6
            OnChange = ComputeTurnClick
          end
          object E_Arrows: TSpinEdit
            Left = 140
            Top = 92
            Width = 57
            Height = 22
            MaxValue = 128
            MinValue = 0
            TabOrder = 4
            Value = 15
            OnChange = ComputeTurnClick
          end
          object E_Node1: TSpinEdit
            Left = 140
            Top = 68
            Width = 57
            Height = 22
            MaxValue = 10000
            MinValue = 0
            TabOrder = 5
            Value = 0
            OnChange = E_Node1Change
          end
          object E_Node2: TSpinEdit
            Left = 140
            Top = 44
            Width = 57
            Height = 22
            MaxValue = 10000
            MinValue = 0
            TabOrder = 6
            Value = 0
            OnChange = E_Node1Change
          end
          object AddTurn: TButton
            Left = 140
            Top = 16
            Width = 21
            Height = 21
            Caption = '+'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            OnClick = AddTurnClick
          end
          object RemTurn: TButton
            Left = 160
            Top = 16
            Width = 21
            Height = 21
            Caption = '-'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            OnClick = RemTurnClick
          end
        end
        object TabSheet21: TTabSheet
          Caption = 'Waypoint nodes'
          ImageIndex = 1
          DesignSize = (
            275
            253)
          object Label119: TLabel
            Left = 202
            Top = 125
            Width = 45
            Height = 13
            Caption = 'Object ID'
          end
          object Label20: TLabel
            Left = 202
            Top = 49
            Width = 47
            Height = 13
            Caption = 'Position X'
          end
          object Label37: TLabel
            Left = 202
            Top = 73
            Width = 47
            Height = 13
            Caption = 'Position Y'
          end
          object Label56: TLabel
            Left = 202
            Top = 97
            Width = 47
            Height = 13
            Caption = 'Position Z'
          end
          object Image18: TImage
            Left = 252
            Top = 95
            Width = 17
            Height = 15
            AutoSize = True
            Picture.Data = {
              07544269746D617042030000424D420300000000000036000000280000001100
              00000F00000001001800000000000C0300000000000000000000000000000000
              0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
              FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
              FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
              40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
              FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
              404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
              40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
              FF00404040404040404040404040404040404040404040404040404040404040
              808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
              8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
              FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
              40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
              80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
              FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
              404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFF00}
            Transparent = True
          end
          object Image25: TImage
            Left = 252
            Top = 71
            Width = 17
            Height = 15
            AutoSize = True
            Picture.Data = {
              07544269746D617042030000424D420300000000000036000000280000001100
              00000F00000001001800000000000C0300000000000000000000000000000000
              0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
              FFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040404040
              404040FFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF004040
              40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FF
              FFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFF
              FFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFF
              FF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040FFFFFFFFFF
              FF00404040404040404040404040404040404040404040404040404040404040
              404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFF
              FFFFFFFFFF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFF40404080808080
              8080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
              40FFFFFFFFFFFFFFFFFFFFFFFF404040808080808080808080808080404040FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
              FF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF00FFFFFF404040FFFFFFFFFFFFFFFFFF4040408080808080808080
              80404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
              404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFF00}
            Transparent = True
          end
          object Image26: TImage
            Left = 252
            Top = 47
            Width = 17
            Height = 15
            AutoSize = True
            Picture.Data = {
              07544269746D617042030000424D420300000000000036000000280000001100
              00000F00000001001800000000000C0300000000000000000000000000000000
              0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
              FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
              FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
              40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
              FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
              404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
              40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
              FF00404040404040404040404040404040404040404040404040404040404040
              808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
              8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
              FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
              40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
              80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
              FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
              404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFF00}
            Transparent = True
          end
          object Label57: TLabel
            Left = 140
            Top = 181
            Width = 62
            Height = 13
            Caption = 'Length 100m'
          end
          object Label159: TLabel
            Left = 140
            Top = 197
            Width = 34
            Height = 13
            Caption = 'H  P  B'
          end
          object Label160: TLabel
            Left = 202
            Top = 153
            Width = 32
            Height = 13
            Caption = 'Rotate'
          end
          object Label166: TLabel
            Left = 6
            Top = 0
            Width = 34
            Height = 13
            Caption = 'Nodes:'
          end
          object ListWPNodes: TListBox
            Left = 0
            Top = 16
            Width = 135
            Height = 233
            Anchors = [akLeft, akTop, akBottom]
            ItemHeight = 13
            TabOrder = 0
            OnClick = ListWPNodesClick
            OnDblClick = ListWPNodesDblClick
          end
          object WPNodeX: TFloatSpinEdit
            Left = 140
            Top = 44
            Width = 57
            Height = 22
            Accuracy = 1
            Increment = 10
            TabOrder = 1
            OnChange = WPNodeChange
          end
          object AddWPNode: TButton
            Left = 140
            Top = 16
            Width = 21
            Height = 21
            Caption = '+'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = AddWPNodeClick
          end
          object RemWPNode: TButton
            Left = 160
            Top = 16
            Width = 21
            Height = 21
            Caption = '-'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = RemWPNodeClick
          end
          object WPNodeY: TFloatSpinEdit
            Left = 140
            Top = 68
            Width = 57
            Height = 22
            Accuracy = 1
            Increment = 10
            TabOrder = 4
            OnChange = WPNodeChange
          end
          object WPNodeZ: TFloatSpinEdit
            Left = 140
            Top = 92
            Width = 57
            Height = 22
            Accuracy = 1
            Increment = 10
            TabOrder = 5
            OnChange = WPNodeChange
          end
          object WPNodeCheckPointID: TSpinEdit
            Left = 140
            Top = 122
            Width = 57
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 6
            Value = 0
            OnChange = WPNodeChange
          end
          object WP_P: TFloatSpinEdit
            Left = 140
            Top = 152
            Width = 57
            Height = 22
            Accuracy = 1
            Increment = 10
            TabOrder = 7
            OnChange = WPNodeChange
          end
        end
      end
      object Button16: TButton
        Left = 144
        Top = 184
        Width = 97
        Height = 17
        Caption = 'Reset route flags'
        TabOrder = 7
        OnClick = Button16Click
      end
      object AddWPTrack: TButton
        Left = 144
        Top = 36
        Width = 113
        Height = 21
        Caption = 'Add waypoint track'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnClick = AddWPTrackClick
      end
      object RemTrack: TButton
        Left = 144
        Top = 56
        Width = 113
        Height = 21
        Caption = 'Remove track'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = RemTrackClick
      end
    end
    object TabSheet17: TTabSheet
      Caption = 'TOB'
      ImageIndex = 9
      DesignSize = (
        288
        516)
      object Label81: TLabel
        Left = 218
        Top = 87
        Width = 47
        Height = 13
        Caption = 'Position X'
      end
      object Label82: TLabel
        Left = 218
        Top = 111
        Width = 47
        Height = 13
        Caption = 'Position Y'
      end
      object Label83: TLabel
        Left = 218
        Top = 135
        Width = 47
        Height = 13
        Caption = 'Position Z'
      end
      object Label84: TLabel
        Left = 218
        Top = 163
        Width = 7
        Height = 13
        Caption = 'A'
      end
      object Label85: TLabel
        Left = 218
        Top = 187
        Width = 7
        Height = 13
        Caption = 'B'
      end
      object Label86: TLabel
        Left = 202
        Top = 215
        Width = 49
        Height = 13
        Caption = 'Rotate YZ'
      end
      object Label87: TLabel
        Left = 202
        Top = 239
        Width = 49
        Height = 13
        Caption = 'Rotate XZ'
      end
      object Label88: TLabel
        Left = 202
        Top = 263
        Width = 49
        Height = 13
        Caption = 'Rotate XY'
      end
      object Label90: TLabel
        Left = 144
        Top = 40
        Width = 34
        Height = 13
        Caption = 'Object:'
      end
      object Image12: TImage
        Left = 268
        Top = 85
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
          FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
          404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
          40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
          8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Image13: TImage
        Left = 268
        Top = 109
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040404040
          404040FFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFF
          FFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040FFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFF
          FFFFFFFFFF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFF40404080808080
          8080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFF404040808080808080808080808080404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040FFFFFFFFFFFFFFFFFF4040408080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Image14: TImage
        Left = 268
        Top = 133
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
          FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
          404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
          40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
          8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Label4: TLabel
        Left = 6
        Top = 0
        Width = 68
        Height = 13
        Caption = 'Track objects:'
      end
      object ListTOB2: TListBox
        Left = 2
        Top = 16
        Width = 135
        Height = 436
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListTOB2Click
        OnDblClick = ListTOB2DblClick
      end
      object TOB_X: TFloatSpinEdit
        Left = 140
        Top = 84
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 1
        OnChange = TOB_Change
      end
      object TOB_Y: TFloatSpinEdit
        Left = 140
        Top = 108
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 2
        OnChange = TOB_Change
      end
      object TOB_Z: TFloatSpinEdit
        Left = 140
        Top = 132
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 3
        OnChange = TOB_Change
      end
      object TOB_A: TFloatSpinEdit
        Left = 140
        Top = 160
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 4
        OnChange = TOB_Change
      end
      object TOB_B: TFloatSpinEdit
        Left = 140
        Top = 184
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 5
        OnChange = TOB_Change
      end
      object TOB_R1: TSpinEdit
        Left = 140
        Top = 212
        Width = 57
        Height = 22
        Increment = 5
        MaxValue = 0
        MinValue = 0
        TabOrder = 6
        Value = 0
        OnChange = TOB_Change
      end
      object TOB_R2: TSpinEdit
        Left = 140
        Top = 236
        Width = 57
        Height = 22
        Increment = 5
        MaxValue = 0
        MinValue = 0
        TabOrder = 7
        Value = 0
        OnChange = TOB_Change
      end
      object TOB_R3: TSpinEdit
        Left = 140
        Top = 260
        Width = 57
        Height = 22
        Increment = 5
        MaxValue = 0
        MinValue = 0
        TabOrder = 8
        Value = 0
        OnChange = TOB_Change
      end
      object AddTOB: TButton
        Left = 142
        Top = 16
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = AddTOBClick
      end
      object RemTOB: TButton
        Left = 162
        Top = 16
        Width = 21
        Height = 21
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnClick = RemTOBClick
      end
      object ListObjectsTOB: TComboBox
        Left = 140
        Top = 56
        Width = 141
        Height = 21
        Style = csDropDownList
        DropDownCount = 16
        ItemHeight = 0
        TabOrder = 11
        OnChange = TOB_Change
      end
      object TOBMagicDelete: TCheckBox
        Left = 188
        Top = 22
        Width = 97
        Height = 17
        Caption = 'OneClick delete'
        TabOrder = 12
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Streets'
      ImageIndex = 10
      object Label67: TLabel
        Left = 80
        Top = 165
        Width = 47
        Height = 13
        Caption = 'Position X'
      end
      object Label76: TLabel
        Left = 80
        Top = 189
        Width = 47
        Height = 13
        Caption = 'Position Y'
      end
      object Label77: TLabel
        Left = 80
        Top = 213
        Width = 47
        Height = 13
        Caption = 'Position Z'
      end
      object Image15: TImage
        Left = 130
        Top = 163
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
          FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
          404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
          40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
          8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Image16: TImage
        Left = 130
        Top = 187
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040404040
          404040FFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFF
          FFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040FFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFF
          FFFFFFFFFF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFF40404080808080
          8080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFF404040808080808080808080808080404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040FFFFFFFFFFFFFFFFFF4040408080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Image17: TImage
        Left = 130
        Top = 211
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
          FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
          404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
          40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
          8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Label99: TLabel
        Left = 68
        Top = 141
        Width = 38
        Height = 13
        Caption = 'Point ID'
      end
      object Label106: TLabel
        Left = 106
        Top = 237
        Width = 71
        Height = 13
        Caption = 'Rotate tangent'
      end
      object Label109: TLabel
        Left = 130
        Top = 299
        Width = 43
        Height = 13
        Caption = 'Spline ID'
      end
      object Label110: TLabel
        Left = 130
        Top = 323
        Width = 53
        Height = 13
        Caption = '1st tangent'
      end
      object Label108: TLabel
        Left = 2
        Top = 280
        Width = 38
        Height = 13
        Caption = 'Forward'
      end
      object Label111: TLabel
        Left = 66
        Top = 280
        Width = 42
        Height = 13
        Caption = 'Opposite'
      end
      object Label112: TLabel
        Left = 130
        Top = 347
        Width = 57
        Height = 13
        Caption = '2nd tangent'
      end
      object EditNodes: TSpeedButton
        Left = 184
        Top = 138
        Width = 81
        Height = 21
        AllowAllUp = True
        GroupIndex = 5
        Caption = 'Nodes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Spacing = -1
        OnClick = SpeedButton
      end
      object Label115: TLabel
        Left = 238
        Top = 75
        Width = 28
        Height = 13
        Caption = 'Offset'
      end
      object Label117: TLabel
        Left = 182
        Top = 27
        Width = 29
        Height = 13
        Caption = 'Lanes'
      end
      object Label147: TLabel
        Left = 130
        Top = 371
        Width = 45
        Height = 13
        Caption = 'Shape ID'
      end
      object Label113: TLabel
        Left = 98
        Top = 443
        Width = 49
        Height = 13
        Caption = 'OppSpline'
      end
      object Label149: TLabel
        Left = 2
        Top = 459
        Width = 51
        Height = 13
        Caption = 'PrevSpline'
      end
      object Label150: TLabel
        Left = 98
        Top = 459
        Width = 51
        Height = 13
        Caption = 'NextSpline'
      end
      object Label151: TLabel
        Left = 2
        Top = 443
        Width = 33
        Height = 13
        Caption = 'Length'
      end
      object Label116: TLabel
        Left = 2
        Top = 491
        Width = 44
        Height = 13
        Caption = 'FirstRoW'
      end
      object Label152: TLabel
        Left = 98
        Top = 491
        Width = 47
        Height = 13
        Caption = 'NumRoW'
      end
      object Label71: TLabel
        Left = 98
        Top = 475
        Width = 49
        Height = 13
        Caption = 'NumWays'
      end
      object Label80: TLabel
        Left = 182
        Top = 51
        Width = 57
        Height = 13
        Caption = 'Speed, kmh'
      end
      object EditSplines: TSpeedButton
        Left = 184
        Top = 282
        Width = 81
        Height = 21
        AllowAllUp = True
        GroupIndex = 5
        Caption = 'Splines'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Spacing = -1
        OnClick = SpeedButton
      end
      object Label146: TLabel
        Left = 2
        Top = 475
        Width = 36
        Height = 13
        Caption = 'Options'
      end
      object ListStreetShape: TListBox
        Left = 2
        Top = 24
        Width = 119
        Height = 89
        Style = lbOwnerDrawFixed
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListStreetShapeClick
        OnDrawItem = ListDrawItem
      end
      object STROff1: TFloatSpinEdit
        Left = 124
        Top = 72
        Width = 53
        Height = 22
        Accuracy = 0
        Increment = 5
        TabOrder = 1
        OnChange = StreetShapeChange
      end
      object STROff2: TFloatSpinEdit
        Left = 180
        Top = 72
        Width = 53
        Height = 22
        Accuracy = 0
        Increment = 5
        TabOrder = 2
        OnChange = StreetShapeChange
      end
      object STRPointZ: TFloatSpinEdit
        Left = 2
        Top = 210
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 3
        OnChange = STRPointXChange
      end
      object STRPointY: TFloatSpinEdit
        Left = 2
        Top = 186
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 5
        TabOrder = 4
        OnChange = STRPointXChange
      end
      object STRPointX: TFloatSpinEdit
        Left = 2
        Top = 162
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 5
        OnChange = STRPointXChange
      end
      object STRPointID: TSpinEdit
        Left = 2
        Top = 138
        Width = 61
        Height = 22
        MaxValue = 10000
        MinValue = 0
        TabOrder = 6
        Value = 0
        OnChange = STRPointIDChange
      end
      object STRPointT: TSpinEdit
        Left = 2
        Top = 234
        Width = 47
        Height = 22
        Increment = 5
        MaxValue = 0
        MinValue = 0
        TabOrder = 7
        Value = 360
        OnChange = STRPointXChange
      end
      object STRSplineID1: TSpinEdit
        Left = 0
        Top = 296
        Width = 61
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 8
        Value = 0
        OnChange = STRSplineID1Change
      end
      object STRSplineID2: TSpinEdit
        Left = 64
        Top = 296
        Width = 61
        Height = 22
        Enabled = False
        MaxValue = 0
        MinValue = 0
        TabOrder = 9
        Value = 0
        OnChange = STRSplineID1Change
      end
      object STRSplineLenA1: TFloatSpinEdit
        Left = 0
        Top = 320
        Width = 61
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 10
        OnChange = STRSplineLenA1Change
      end
      object STRSplineLenB1: TFloatSpinEdit
        Left = 0
        Top = 344
        Width = 61
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 11
        OnChange = STRSplineLenA1Change
      end
      object STRSplineLenA2: TFloatSpinEdit
        Left = 64
        Top = 320
        Width = 61
        Height = 22
        Accuracy = 1
        Enabled = False
        Increment = 10
        TabOrder = 12
        OnChange = STRSplineLenA1Change
      end
      object STRSplineLenB2: TFloatSpinEdit
        Left = 64
        Top = 344
        Width = 61
        Height = 22
        Accuracy = 1
        Enabled = False
        Increment = 10
        TabOrder = 13
        OnChange = STRSplineLenA1Change
      end
      object CBSplineSymmetry: TCheckBox
        Left = 202
        Top = 307
        Width = 65
        Height = 17
        Caption = 'Symmetry'
        Checked = True
        State = cbChecked
        TabOrder = 14
        OnClick = CBSplineSymmetryClick
      end
      object AddShape: TButton
        Left = 244
        Top = 24
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        OnClick = AddShapeClick
      end
      object RemShape: TButton
        Left = 264
        Top = 24
        Width = 21
        Height = 21
        Caption = '-'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
        OnClick = RemShapeClick
      end
      object STRLanes: TSpinEdit
        Left = 124
        Top = 24
        Width = 53
        Height = 22
        MaxValue = 2
        MinValue = 1
        TabOrder = 17
        Value = 1
        OnChange = StreetShapeChange
      end
      object STRSplineShape1: TSpinEdit
        Left = 0
        Top = 368
        Width = 61
        Height = 22
        MaxValue = 1
        MinValue = 1
        TabOrder = 18
        Value = 0
        OnChange = STRSplineLenA1Change
      end
      object STRSplineShape2: TSpinEdit
        Left = 64
        Top = 368
        Width = 61
        Height = 22
        Enabled = False
        MaxValue = 1
        MinValue = 1
        TabOrder = 19
        Value = 0
        OnChange = STRSplineLenA1Change
      end
      object STR_Mode: TRadioGroup
        Left = 192
        Top = 376
        Width = 89
        Height = 73
        Caption = ' Display Mode  '
        ItemIndex = 0
        Items.Strings = (
          'Shape'
          'Speed'
          'Options'
          'NumWays')
        TabOrder = 20
      end
      object STRSplineOpt11: TCheckBox
        Left = 0
        Top = 392
        Width = 49
        Height = 17
        Caption = 'Cross'
        TabOrder = 21
        OnClick = STRSplineLenA1Change
      end
      object STRSplineOpt13: TCheckBox
        Left = 0
        Top = 424
        Width = 49
        Height = 17
        Caption = 'Right'
        TabOrder = 22
        OnClick = STRSplineLenA1Change
      end
      object STRSplineOpt23: TCheckBox
        Left = 64
        Top = 424
        Width = 49
        Height = 17
        Caption = 'Right'
        Enabled = False
        TabOrder = 23
        OnClick = STRSplineLenA1Change
      end
      object STRSplineOpt21: TCheckBox
        Left = 64
        Top = 392
        Width = 49
        Height = 17
        Caption = 'Cross'
        Enabled = False
        TabOrder = 24
        OnClick = STRSplineLenA1Change
      end
      object RemPoint: TButton
        Left = 264
        Top = 138
        Width = 21
        Height = 21
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 25
        OnClick = RemPointClick
      end
      object RemSpline: TButton
        Left = 264
        Top = 282
        Width = 21
        Height = 21
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 26
        OnClick = RemSplineClick
      end
      object STRShapeOpt1_Always0: TCheckBox
        Left = 124
        Top = 96
        Width = 65
        Height = 17
        Caption = 'Option1?'
        Enabled = False
        TabOrder = 27
        Visible = False
        OnClick = StreetShapeChange
      end
      object STRShapeOpt2_Always0: TCheckBox
        Left = 188
        Top = 96
        Width = 65
        Height = 17
        Caption = 'Option2?'
        Enabled = False
        TabOrder = 28
        Visible = False
        OnClick = StreetShapeChange
      end
      object Button25: TButton
        Left = 184
        Top = 96
        Width = 101
        Height = 17
        Caption = 'Reset shapes full'
        TabOrder = 29
        OnClick = Button25Click
      end
      object STRSplineOpt12: TCheckBox
        Left = 0
        Top = 408
        Width = 41
        Height = 17
        Caption = 'Left'
        TabOrder = 30
        OnClick = STRSplineLenA1Change
      end
      object STRSplineOpt22: TCheckBox
        Left = 64
        Top = 408
        Width = 41
        Height = 17
        Caption = 'Left'
        Enabled = False
        TabOrder = 31
        OnClick = STRSplineLenA1Change
      end
      object STRShSpeed: TSpinEdit
        Left = 124
        Top = 48
        Width = 53
        Height = 22
        Increment = 5
        MaxValue = 235
        MinValue = 5
        TabOrder = 32
        Value = 5
        OnChange = StreetShapeChange
      end
      object STRPointT2: TSpinEdit
        Left = 52
        Top = 234
        Width = 47
        Height = 22
        Enabled = False
        MaxValue = 0
        MinValue = 0
        TabOrder = 33
        Value = 0
        OnChange = STRPointXChange
      end
      object Panel8: TPanel
        Left = -2
        Top = 116
        Width = 292
        Height = 18
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'Nodes'
        TabOrder = 34
      end
      object Panel9: TPanel
        Left = -2
        Top = 260
        Width = 292
        Height = 18
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'Splines'
        TabOrder = 35
      end
      object Panel10: TPanel
        Left = -2
        Top = 2
        Width = 292
        Height = 18
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'Shapes'
        TabOrder = 36
      end
      object Button20: TButton
        Left = 184
        Top = 158
        Width = 81
        Height = 17
        Caption = 'NET to Nodes'
        Enabled = False
        TabOrder = 37
        Visible = False
        OnClick = Button20Click
      end
      object CB_AutoCross: TCheckBox
        Left = 202
        Top = 323
        Width = 79
        Height = 17
        Caption = 'Auto-crosses'
        Checked = True
        State = cbChecked
        TabOrder = 38
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Animated'
      ImageIndex = 11
      DesignSize = (
        288
        516)
      object Label46: TLabel
        Left = 6
        Top = 0
        Width = 52
        Height = 13
        Caption = 'Routes list:'
      end
      object Label52: TLabel
        Left = 6
        Top = 296
        Width = 44
        Height = 13
        Caption = 'Node list:'
      end
      object Label53: TLabel
        Left = 194
        Top = 203
        Width = 35
        Height = 13
        Caption = 'Volume'
      end
      object Label54: TLabel
        Left = 194
        Top = 227
        Width = 47
        Height = 13
        Caption = 'Tempo, %'
      end
      object Label55: TLabel
        Left = 194
        Top = 251
        Width = 47
        Height = 13
        Caption = 'Radius, m'
      end
      object Label93: TLabel
        Left = 246
        Top = 179
        Width = 31
        Height = 13
        Caption = 'Sound'
      end
      object Label94: TLabel
        Left = 218
        Top = 387
        Width = 47
        Height = 13
        Caption = 'Position Z'
      end
      object Label95: TLabel
        Left = 218
        Top = 363
        Width = 47
        Height = 13
        Caption = 'Position Y'
      end
      object Label96: TLabel
        Left = 218
        Top = 339
        Width = 47
        Height = 13
        Caption = 'Position X'
      end
      object Label97: TLabel
        Left = 202
        Top = 411
        Width = 62
        Height = 13
        Caption = 'Speed, km/h'
      end
      object Label98: TLabel
        Left = 202
        Top = 435
        Width = 70
        Height = 13
        Caption = 'Unknown 0-18'
      end
      object Label32: TLabel
        Left = 144
        Top = 0
        Width = 34
        Height = 13
        Caption = 'Object:'
      end
      object Image19: TImage
        Left = 268
        Top = 337
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
          FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
          404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
          40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
          8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Image20: TImage
        Left = 268
        Top = 361
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040404040
          404040FFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFF
          FFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040FFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFF
          FFFFFFFFFF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFF40404080808080
          8080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFF404040808080808080808080808080404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040FFFFFFFFFFFFFFFFFF4040408080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Image24: TImage
        Left = 268
        Top = 385
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
          FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
          404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
          40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
          8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Label33: TLabel
        Left = 194
        Top = 275
        Width = 46
        Height = 13
        Caption = 'Unknown'
      end
      object ListSNIObjects: TListBox
        Left = 2
        Top = 16
        Width = 133
        Height = 277
        Style = lbOwnerDrawFixed
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListSNIObjectsClick
        OnDrawItem = ListDrawItem
      end
      object ListSNINodes: TListBox
        Left = 2
        Top = 312
        Width = 133
        Height = 137
        Style = lbOwnerDrawFixed
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        TabOrder = 1
        OnClick = ListSNINodesClick
        OnDblClick = ListSNINodesDblClick
      end
      object ListObjectsSNI: TComboBox
        Left = 140
        Top = 40
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        OnChange = ObjectsSNIChange
        Items.Strings = (
          '0 nil'
          '1'
          '2'
          '3'
          '4'
          '5')
      end
      object SNIx1: TSpinEdit
        Left = 140
        Top = 200
        Width = 49
        Height = 22
        MaxValue = 10000
        MinValue = 0
        TabOrder = 3
        Value = 0
        OnChange = ObjectsSNIChange
      end
      object SNIx2: TSpinEdit
        Left = 140
        Top = 224
        Width = 49
        Height = 22
        MaxValue = 10000
        MinValue = 0
        TabOrder = 4
        Value = 0
        OnChange = ObjectsSNIChange
      end
      object SNIx3: TSpinEdit
        Left = 140
        Top = 248
        Width = 49
        Height = 22
        MaxValue = 10000
        MinValue = 0
        TabOrder = 5
        Value = 0
        OnChange = ObjectsSNIChange
      end
      object EditSNISound: TEdit
        Left = 140
        Top = 176
        Width = 101
        Height = 21
        TabOrder = 6
        OnChange = ObjectsSNIChange
      end
      object SNI_Node_X: TFloatSpinEdit
        Left = 140
        Top = 336
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 7
        OnChange = SNI_Node_Change
      end
      object SNI_Node_Y: TFloatSpinEdit
        Left = 140
        Top = 360
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 8
        OnChange = SNI_Node_Change
      end
      object SNI_Node_Z: TFloatSpinEdit
        Left = 140
        Top = 384
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 9
        OnChange = SNI_Node_Change
      end
      object SNI_Node_Speed: TFloatSpinEdit
        Left = 140
        Top = 408
        Width = 57
        Height = 22
        Accuracy = 0
        Increment = 10
        TabOrder = 10
        OnChange = SNI_Node_Change
      end
      object SNI_Node_B: TFloatSpinEdit
        Left = 140
        Top = 432
        Width = 57
        Height = 22
        Accuracy = 1
        Increment = 0.1
        MaxValue = 18
        TabOrder = 11
        OnChange = SNI_Node_Change
      end
      object CBSNIMode: TRadioGroup
        Left = 140
        Top = 64
        Width = 145
        Height = 109
        Caption = '  Mode  '
        Items.Strings = (
          '0 Heading, no roll'
          '1 Heading, no roll'
          '2 Heading, roll x2'
          '3 No heading, no roll'
          '4 Heading, roll'
          'X Snow spawn'
          'X Snow spawn by TRK')
        TabOrder = 12
        OnClick = ObjectsSNIChange
      end
      object AddAniNode: TButton
        Left = 140
        Top = 312
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        OnClick = AddAniNodeClick
      end
      object RemAniNode: TButton
        Left = 160
        Top = 312
        Width = 21
        Height = 21
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        OnClick = RemAniNodeClick
      end
      object AddAni: TButton
        Left = 140
        Top = 16
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        OnClick = AddAniClick
      end
      object RemAni: TButton
        Left = 160
        Top = 16
        Width = 21
        Height = 21
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
        OnClick = RemAniClick
      end
      object RemAniAll: TButton
        Left = 180
        Top = 16
        Width = 69
        Height = 21
        Caption = 'Remove all*'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        OnClick = RemAniClick
      end
      object SNISnow: TButton
        Left = 140
        Top = 464
        Width = 73
        Height = 25
        Caption = 'Generate'
        TabOrder = 18
        OnClick = SNISnowClick
      end
      object SNIx4: TSpinEdit
        Left = 140
        Top = 272
        Width = 49
        Height = 22
        MaxValue = 32
        MinValue = 1
        TabOrder = 19
        Value = 1
        OnChange = ObjectsSNIChange
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Sky'
      ImageIndex = 12
      DesignSize = (
        288
        516)
      object Label22: TLabel
        Left = 66
        Top = 7
        Width = 59
        Height = 13
        Caption = 'Sun Azimuth'
      end
      object Label23: TLabel
        Left = 202
        Top = 7
        Width = 53
        Height = 13
        Caption = 'Sun Height'
      end
      object Label69: TLabel
        Left = 156
        Top = 200
        Width = 81
        Height = 13
        Caption = 'Ambient (objects)'
      end
      object Label89: TLabel
        Left = 156
        Top = 178
        Width = 45
        Height = 13
        Caption = 'Sun color'
      end
      object Label133: TLabel
        Left = 156
        Top = 156
        Width = 44
        Height = 13
        Caption = 'Fog color'
      end
      object SKY_FogCol: TShape
        Left = 126
        Top = 152
        Width = 25
        Height = 21
        OnDragDrop = SKY_FogColDragDrop
        OnMouseUp = ColorShapeMouseUp
      end
      object SKY_SunCol: TShape
        Left = 126
        Top = 174
        Width = 25
        Height = 21
        OnDragDrop = SKY_FogColDragDrop
        OnMouseUp = ColorShapeMouseUp
      end
      object SKY_AmbCol: TShape
        Left = 126
        Top = 196
        Width = 25
        Height = 21
        OnDragDrop = SKY_FogColDragDrop
        OnMouseUp = ColorShapeMouseUp
      end
      object SKY_WlkAmb: TShape
        Left = 126
        Top = 218
        Width = 25
        Height = 21
        OnDragDrop = SKY_FogColDragDrop
        OnMouseUp = ColorShapeMouseUp
      end
      object Label127: TLabel
        Left = 156
        Top = 222
        Width = 98
        Height = 13
        Caption = 'Ambient (dustclouds)'
      end
      object SKY_WlkSun: TShape
        Left = 126
        Top = 240
        Width = 25
        Height = 21
        OnDragDrop = SKY_FogColDragDrop
        OnMouseUp = ColorShapeMouseUp
      end
      object Label48: TLabel
        Left = 156
        Top = 244
        Width = 98
        Height = 13
        Caption = 'Ambient (dustclouds)'
      end
      object Light_Amb: TShape
        Left = 2
        Top = 28
        Width = 25
        Height = 25
        OnDragDrop = Light_AmbDragDrop
        OnMouseUp = ColorShapeMouseUp
      end
      object Label132: TLabel
        Left = 32
        Top = 34
        Width = 86
        Height = 13
        Caption = 'Ambient light color'
      end
      object LVL_SunY: TFloatSpinEdit
        Left = 140
        Top = 4
        Width = 57
        Height = 22
        Accuracy = 1
        Increment = 5
        MaxValue = 90
        TabOrder = 0
        OnChange = LVL_SunXChange
      end
      object ListSKY: TListBox
        Left = 2
        Top = 80
        Width = 119
        Height = 181
        ItemHeight = 13
        TabOrder = 1
        OnClick = ListSKYClick
      end
      object LVL_SunXZ: TFloatSpinEdit
        Left = 4
        Top = 4
        Width = 57
        Height = 22
        Accuracy = 1
        Increment = 5
        TabOrder = 2
        Value = 360
        OnChange = LVL_SunXChange
      end
      object TraceShadows: TButton
        Left = 102
        Top = 292
        Width = 99
        Height = 21
        Caption = 'Trace shadows'
        TabOrder = 5
        OnClick = TraceShadowsClick
      end
      object Panel7: TPanel
        Left = -2
        Top = 56
        Width = 292
        Height = 18
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'Sky presets'
        TabOrder = 6
      end
      object GroupBox3: TGroupBox
        Left = 2
        Top = 376
        Width = 284
        Height = 139
        Anchors = [akLeft, akTop, akBottom]
        Caption = '  Click to see shadow map preview  '
        TabOrder = 7
        DesignSize = (
          284
          139)
        object SMPPreview: TImage
          Left = 4
          Top = 14
          Width = 275
          Height = 120
          Anchors = [akLeft, akTop, akRight, akBottom]
          OnClick = SMPPreviewRedraw
        end
      end
      object AddSkyPreset: TButton
        Left = 126
        Top = 80
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnClick = AddSkyPresetClick
      end
      object RemSkyPreset: TButton
        Left = 146
        Top = 80
        Width = 21
        Height = 21
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = RemSkyPresetClick
      end
      object DefaultSkyPreset: TButton
        Left = 166
        Top = 80
        Width = 51
        Height = 21
        Caption = 'Default'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object CBClouds: TComboBox
        Left = 126
        Top = 104
        Width = 155
        Height = 21
        Style = csDropDownList
        DropDownCount = 12
        ItemHeight = 0
        Sorted = True
        TabOrder = 11
        OnChange = EditSkyChange
        OnDropDown = CBCloudsClick
      end
      object CBFogTable: TComboBox
        Left = 126
        Top = 128
        Width = 155
        Height = 21
        Style = csDropDownList
        DropDownCount = 12
        ItemHeight = 0
        Sorted = True
        TabOrder = 12
        OnChange = EditSkyChange
        OnDropDown = CBCloudsClick
      end
      object TraceShadows2: TButton
        Left = 102
        Top = 312
        Width = 99
        Height = 21
        Caption = 'Trace shadows II'
        TabOrder = 13
        OnClick = TraceShadowsClick
      end
      object Panel12: TPanel
        Left = -2
        Top = 268
        Width = 292
        Height = 18
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'Shading'
        TabOrder = 14
      end
      object MakeSMP: TButton
        Left = 2
        Top = 348
        Width = 99
        Height = 25
        Caption = 'Build shadow map'
        TabOrder = 3
        OnClick = MakeSMPClick
      end
      object RGShadEdge: TRadioGroup
        Left = 2
        Top = 288
        Width = 95
        Height = 57
        Caption = ' Shadow edge  '
        ItemIndex = 0
        Items.Strings = (
          'Soft'
          'Medium'
          'Hard')
        TabOrder = 15
        OnClick = RGShadEdgeClick
      end
      object EraseSMP: TButton
        Left = 102
        Top = 348
        Width = 99
        Height = 25
        Caption = 'Fill shadow map 0'
        TabOrder = 16
        OnClick = EraseSMPClick
      end
      object KillShadows: TButton
        Left = 200
        Top = 292
        Width = 85
        Height = 41
        Caption = 'Erase shadows'
        TabOrder = 4
        OnClick = KillShadowsClick
      end
      object LightApply: TBitBtn
        Left = 198
        Top = 28
        Width = 87
        Height = 25
        Caption = 'Rebuild'
        TabOrder = 17
        OnClick = LightApplyClick
        Glyph.Data = {
          5A010000424D5A01000000000000760000002800000013000000130000000100
          040000000000E400000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFF00000FFFFFFFFF0FFFFFFFFF00000FF0FFFFFF0FFFFFF0FF00000FFF0
          FFFFF0FFFFF0FFF00000FFFF0FFFF0FFFF0FFFF00000FFFFF0FFFFFFF0FFFFF0
          0000FFFFFFFF000FFFFFFFF00000FFFFFFF0BBB0FFFFFFF00000FFFFFF0BBBBB
          0FFFFFF00000F0000F0BBBBB0F0000F00000FFFFFF0BBBBB0FFFFFF00000FFFF
          FFF0BBB0FFFFFFF00000FFFFFFFF000FFFFFFFF00000FFFFF0FFFFFFF0FFFFF0
          0000FFFF0FFFF0FFFF0FFFF00000FFF0FFFFF0FFFFF0FFF00000FF0FFFFFF0FF
          FFFF0FF00000FFFFFFFFF0FFFFFFFFF00000FFFFFFFFFFFFFFFFFFF00000}
      end
    end
    object TabSheet18: TTabSheet
      Caption = 'Grass'
      ImageIndex = 14
      object Label148: TLabel
        Left = 118
        Top = 171
        Width = 62
        Height = 13
        Caption = 'Grass texture'
      end
      object GrassCol: TShape
        Left = 2
        Top = 236
        Width = 25
        Height = 25
        OnDragDrop = GrassColDragDrop
        OnMouseUp = ColorShapeMouseUp
      end
      object Label91: TLabel
        Left = 32
        Top = 242
        Width = 53
        Height = 13
        Caption = 'Grass color'
      end
      object Label92: TLabel
        Left = 120
        Top = 200
        Width = 20
        Height = 13
        Caption = '00%'
      end
      object RG_GrassLOD: TRadioGroup
        Left = 196
        Top = 0
        Width = 87
        Height = 85
        Caption = ' Grass LOD  '
        Items.Strings = (
          'Level 1'
          'Level 2'
          'Level 3'
          'Level 4')
        TabOrder = 0
        OnClick = RG_GrassLODClick
      end
      object RG_GrassMode: TRadioGroup
        Left = 196
        Top = 91
        Width = 87
        Height = 69
        Caption = ' Display mode  '
        ItemIndex = 2
        Items.Strings = (
          'Type'
          'Size'
          'Color')
        TabOrder = 1
      end
      object GrassPlainColor: TButton
        Left = 2
        Top = 264
        Width = 147
        Height = 25
        Caption = 'Use plain color'
        TabOrder = 2
        OnClick = GrassPlainColorClick
      end
      object GenerateGrass: TButton
        Left = 2
        Top = 194
        Width = 105
        Height = 25
        Caption = 'Generate Grass'
        TabOrder = 3
        OnClick = GenerateGrassClick
      end
      object GrassTexture: TEdit
        Left = 2
        Top = 168
        Width = 111
        Height = 21
        TabOrder = 4
        Text = 'GrassTexture'
        OnChange = GrassTextureChange
      end
      object VLBGrass: TValueListEditor
        Left = 2
        Top = 4
        Width = 191
        Height = 156
        DefaultColWidth = 120
        DefaultRowHeight = 16
        DisplayOptions = [doColumnTitles, doKeyColFixed]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goAlwaysShowEditor, goThumbTracking]
        ParentFont = False
        Strings.Strings = (
          'x1='
          'x2='
          'x3='
          'Size X='
          'Size Z='
          'Total chunks='
          'Count='
          'Density=')
        TabOrder = 5
        OnClick = ShowGrassInfo
        ColWidths = (
          110
          75)
      end
      object CBOptimizeGrass: TCheckBox
        Left = 2
        Top = 340
        Width = 153
        Height = 17
        Caption = 'Optimize grass for archiving'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object GrassTGAColor: TButton
        Left = 2
        Top = 288
        Width = 147
        Height = 25
        Caption = 'Use color from TGA image ...'
        TabOrder = 7
        OnClick = GrassTGAColorClick
      end
      object GroupBox2: TGroupBox
        Left = 152
        Top = 192
        Width = 129
        Height = 65
        Caption = '  Hint  '
        TabOrder = 8
        object Label126: TLabel
          Left = 8
          Top = 16
          Width = 110
          Height = 39
          Caption = 'Define materials where grass should grow in Materials tab'
          WordWrap = True
        end
      end
      object GenerateGrass3: TButton
        Left = 2
        Top = 312
        Width = 147
        Height = 25
        Caption = 'Apply TGA mask ...'
        TabOrder = 9
        OnClick = GrassTGAMask
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Triggers'
      ImageIndex = 7
      DesignSize = (
        288
        516)
      object Label6: TLabel
        Left = 218
        Top = 47
        Width = 47
        Height = 13
        Caption = 'Position X'
      end
      object Label7: TLabel
        Left = 218
        Top = 71
        Width = 47
        Height = 13
        Caption = 'Position Y'
      end
      object Label8: TLabel
        Left = 218
        Top = 95
        Width = 47
        Height = 13
        Caption = 'Position Z'
      end
      object Label9: TLabel
        Left = 202
        Top = 123
        Width = 42
        Height = 13
        Caption = 'Rotate X'
      end
      object Label10: TLabel
        Left = 202
        Top = 147
        Width = 42
        Height = 13
        Caption = 'Rotate Y'
      end
      object Label11: TLabel
        Left = 202
        Top = 171
        Width = 42
        Height = 13
        Caption = 'Rotate Z'
      end
      object Label12: TLabel
        Left = 202
        Top = 199
        Width = 37
        Height = 13
        Caption = 'Scale X'
      end
      object Label13: TLabel
        Left = 202
        Top = 223
        Width = 37
        Height = 13
        Caption = 'Scale Y'
      end
      object Label14: TLabel
        Left = 202
        Top = 247
        Width = 37
        Height = 13
        Caption = 'Scale Z'
      end
      object Label15: TLabel
        Left = 218
        Top = 323
        Width = 41
        Height = 13
        Caption = 'Target Z'
      end
      object Label16: TLabel
        Left = 218
        Top = 299
        Width = 41
        Height = 13
        Caption = 'Target Y'
      end
      object Label17: TLabel
        Left = 218
        Top = 275
        Width = 41
        Height = 13
        Caption = 'Target X'
      end
      object Label31: TLabel
        Left = 6
        Top = 0
        Width = 56
        Height = 13
        Caption = 'Triggers list:'
      end
      object Image4: TImage
        Left = 268
        Top = 45
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
          FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
          404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
          40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
          8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Image5: TImage
        Left = 268
        Top = 69
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040404040
          404040FFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFF
          FFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040FFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          404040FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFF
          FFFFFFFFFF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFF40404080808080
          8080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFF404040808080808080808080808080404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FF404040808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040FFFFFFFFFFFFFFFFFF4040408080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object Image6: TImage
        Left = 268
        Top = 93
        Width = 17
        Height = 15
        AutoSize = True
        Picture.Data = {
          07544269746D617042030000424D420300000000000036000000280000001100
          00000F00000001001800000000000C0300000000000000000000000000000000
          0000FFFFFFFFFFFF404040404040404040404040404040404040404040FFFFFF
          FFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF404040FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFF404040404040404040
          FFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF004040
          40FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080FF
          FFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40404040404040404040404040404040404040404040
          404040404000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF404040808080FFFFFF404040FFFFFFFFFFFF404040FFFFFF00404040FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF4040
          40FFFFFFFFFFFFFFFFFFFFFFFF00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF808080404040404040404040FFFFFFFFFFFFFFFF
          FF00404040404040404040404040404040404040404040404040404040404040
          808080FFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFF0040404080808080808080
          8080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00404040808080808080808080808080404040FFFFFFFF
          FFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040
          40808080808080808080808080404040FFFFFFFFFFFFFFFFFFFFFFFF404040FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF004040408080808080808080808080
          80404040FFFFFFFFFFFFFFFFFFFFFFFF404040FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFF404040808080808080808080404040FFFFFFFFFFFFFFFF
          FF404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          404040404040404040404040404040404040404040FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        Transparent = True
      end
      object ListTrig: TListBox
        Left = 2
        Top = 16
        Width = 133
        Height = 345
        Anchors = [akLeft, akTop, akBottom]
        ExtendedSelect = False
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListTrigClick
        OnDblClick = ListTrigDblClick
      end
      object AddTrigger: TButton
        Left = 246
        Top = 16
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = AddTriggerClick
      end
      object CBTriggerType: TComboBox
        Left = 140
        Top = 16
        Width = 101
        Height = 21
        Style = csDropDownList
        DropDownCount = 24
        ItemHeight = 13
        TabOrder = 2
        OnChange = ComputeTriggerClick
        Items.Strings = (
          #39' (1)'#39','
          #39' (2)'#39','
          #39'Jump Tunnel (3)'#39','
          #39'Zero gravity (4)'#39','
          #39'Jump "Origin-Aim" (5)'#39','
          #39'Jump Checkpoint (6)'#39','
          #39'Car repair (7)'#39','
          #39'Nitro bottle(8)'#39','
          #39'Jump ahead signal (9)'#39','
          #39'Suspension lift (10)'#39','
          #39'Teleport (11)'#39','
          #39' (12)'#39','
          #39' (13)'#39','
          #39'Carwash (14)'#39','
          #39'Refuel nitro(15)'#39','
          #39'?Parking lot (16)'#39)
      end
      object TRL_X: TFloatSpinEdit
        Left = 140
        Top = 44
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 3
        OnChange = ComputeTriggerClick
      end
      object TRL_Y: TFloatSpinEdit
        Left = 140
        Top = 68
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 4
        OnChange = ComputeTriggerClick
      end
      object TRL_Z: TFloatSpinEdit
        Left = 140
        Top = 92
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 10
        TabOrder = 5
        OnChange = ComputeTriggerClick
      end
      object TRL_S1: TFloatSpinEdit
        Left = 140
        Top = 196
        Width = 57
        Height = 22
        Accuracy = 1
        Increment = 1
        MaxValue = 1000
        MinValue = 1
        TabOrder = 6
        Value = 1
        OnChange = ComputeTriggerClick
      end
      object TRL_S2: TFloatSpinEdit
        Left = 140
        Top = 220
        Width = 57
        Height = 22
        Accuracy = 1
        Increment = 1
        MaxValue = 1000
        MinValue = 1
        TabOrder = 7
        Value = 1
        OnChange = ComputeTriggerClick
      end
      object TRL_S3: TFloatSpinEdit
        Left = 140
        Top = 244
        Width = 57
        Height = 22
        Accuracy = 1
        Increment = 1
        MaxValue = 1000
        MinValue = 1
        TabOrder = 8
        Value = 1
        OnChange = ComputeTriggerClick
      end
      object TRL_R1: TSpinEdit
        Left = 140
        Top = 120
        Width = 57
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 9
        Value = 0
        OnChange = ComputeTriggerClick
      end
      object TRL_R2: TSpinEdit
        Left = 140
        Top = 144
        Width = 57
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 10
        Value = 0
        OnChange = ComputeTriggerClick
      end
      object TRL_R3: TSpinEdit
        Left = 140
        Top = 168
        Width = 57
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 11
        Value = 0
        OnChange = ComputeTriggerClick
      end
      object TRL_Flags: TEdit
        Left = 140
        Top = 344
        Width = 121
        Height = 21
        TabOrder = 12
        Text = 'TRL_Flags'
        Visible = False
      end
      object TRL_P1: TFloatSpinEdit
        Left = 140
        Top = 272
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 1
        TabOrder = 13
        OnChange = ComputeTriggerClick
      end
      object TRL_P2: TFloatSpinEdit
        Left = 140
        Top = 296
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 1
        TabOrder = 14
        OnChange = ComputeTriggerClick
      end
      object TRL_P3: TFloatSpinEdit
        Left = 140
        Top = 320
        Width = 73
        Height = 22
        Accuracy = 1
        Increment = 1
        TabOrder = 15
        OnChange = ComputeTriggerClick
      end
      object RemTrigger: TButton
        Left = 266
        Top = 16
        Width = 21
        Height = 21
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
        OnClick = RemTriggerClick
      end
    end
    object TabSheet20: TTabSheet
      Caption = 'Addon Info'
      ImageIndex = 15
      object Label134: TLabel
        Left = 150
        Top = 51
        Width = 54
        Height = 13
        Caption = 'Ingame title'
      end
      object Label135: TLabel
        Left = 150
        Top = 27
        Width = 60
        Height = 13
        Caption = 'Folder/Mask'
      end
      object Label136: TLabel
        Left = 150
        Top = 75
        Width = 89
        Height = 13
        Caption = 'Background image'
      end
      object Label137: TLabel
        Left = 150
        Top = 99
        Width = 59
        Height = 13
        Caption = 'Scenery flag'
      end
      object Label138: TLabel
        Left = 54
        Top = 123
        Width = 56
        Height = 13
        Caption = 'Total tracks'
      end
      object Label139: TLabel
        Left = 254
        Top = 175
        Width = 20
        Height = 13
        Caption = 'Title'
      end
      object Label140: TLabel
        Left = 126
        Top = 335
        Width = 47
        Height = 13
        Caption = 'Length, m'
      end
      object Label142: TLabel
        Left = 174
        Top = 123
        Width = 79
        Height = 13
        Caption = 'Freeride track ID'
      end
      object Label143: TLabel
        Left = 150
        Top = 427
        Width = 87
        Height = 13
        Caption = 'Scenery converter'
      end
      object Label144: TLabel
        Left = 150
        Top = 403
        Width = 72
        Height = 13
        Caption = 'Scenery author'
      end
      object Label145: TLabel
        Left = 150
        Top = 451
        Width = 57
        Height = 13
        Caption = 'Contact info'
      end
      object Label19: TLabel
        Left = 254
        Top = 199
        Width = 29
        Height = 13
        Caption = 'Image'
      end
      object Label118: TLabel
        Left = 126
        Top = 351
        Width = 48
        Height = 13
        Caption = 'Waypoint,'
      end
      object SC2_Name: TEdit
        Left = 2
        Top = 48
        Width = 143
        Height = 21
        TabOrder = 0
        Text = 'Test Map'
        OnChange = SC2_ScnChange
      end
      object SC2_EngName: TEdit
        Left = 2
        Top = 24
        Width = 143
        Height = 21
        TabOrder = 1
        Text = 'TEST_MAP'
        OnChange = SC2_ScnChange
      end
      object SC2_ScnTracks: TSpinEdit
        Left = 2
        Top = 120
        Width = 47
        Height = 22
        MaxValue = 32
        MinValue = 1
        ReadOnly = True
        TabOrder = 2
        Value = 1
        OnChange = SC2_ScnChange
      end
      object SC2T_Title: TEdit
        Left = 122
        Top = 172
        Width = 127
        Height = 21
        TabOrder = 3
        Text = 'Test Map'
        OnChange = SC2T_TrackChange
      end
      object SC2T_Direction: TRadioGroup
        Left = 122
        Top = 218
        Width = 127
        Height = 45
        Caption = ' Direction  '
        Items.Strings = (
          'Clockwise'
          'Counter-clockwise')
        TabOrder = 4
        OnClick = SC2T_TrackChange
      end
      object SC2_FreeRideTrack: TSpinEdit
        Left = 122
        Top = 120
        Width = 47
        Height = 22
        MaxValue = 32
        MinValue = 1
        TabOrder = 5
        Value = 1
        OnChange = SC2_ScnChange
      end
      object SC2_TrackList: TListBox
        Left = 2
        Top = 172
        Width = 115
        Height = 197
        ItemHeight = 13
        TabOrder = 6
        OnClick = SC2_TrackListClick
      end
      object SC2_Author: TEdit
        Left = 2
        Top = 400
        Width = 143
        Height = 21
        TabOrder = 7
        OnChange = SC2_ScnChange
      end
      object SC2_Converter: TEdit
        Left = 2
        Top = 424
        Width = 143
        Height = 21
        TabOrder = 8
        OnChange = SC2_ScnChange
      end
      object SC2_Contact: TEdit
        Left = 2
        Top = 448
        Width = 143
        Height = 21
        TabOrder = 9
        OnChange = SC2_ScnChange
      end
      object SC2_Comments: TMemo
        Left = 2
        Top = 472
        Width = 285
        Height = 49
        Lines.Strings = (
          'Comments')
        TabOrder = 10
        OnChange = SC2_ScnChange
      end
      object FillSC2: TBitBtn
        Left = 250
        Top = 24
        Width = 33
        Height = 33
        Hint = 'Auto fill'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
        OnClick = FillSC2Click
        Glyph.Data = {
          56080000424D560800000000000036000000280000001A0000001A0000000100
          18000000000020080000120B0000120B00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F7F
          7F7F7F7F7F7F7F7F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F7F7F7F7F7F7F
          7F7F7F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFCC009933009933009933009933007F7F7F7F7F7FFFFF
          FFFFFFFF9933009933009933009933009933007F7F7FFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCC00FF9000FF
          9000FF9000FF90009933007F7F7FFFFFFFFFCC00FF9000FF9000FF9000FF9000
          9933007F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFCC00FF9000FF9000FF9000FF90009933007F7F7FFFFF
          FFFFCC00FF9000FF9000FF9000FF90009933007F7F7FFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCC00FF9000FF
          9000FF90009933007F7F7FFFFFFFFFFFFFFFFFFFFFCC00FF9000FF9000FF9000
          9933007F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF7F7F7F
          7F7F7F7F7F7FFFFFFFFFCC00FF9000FF9000FF90009933007F7F7F7F7F7F7F7F
          7F7F7F7FFFCC00FF9000FF9000FF90009933007F7F7FFFFFFFFFFFFF7F7F7F7F
          7F7FFFFFFFFFFFFF0000FFFFFF9933009933007F7F7F7F7F7FFFCC00FF9000FF
          9000FF9000FF9000993300993300993300993300FF9000FF9000FF9000FF9000
          9933007F7F7F7F7F7F9933009933007F7F7F7F7F7FFFFFFF0000FFCC00FF9000
          FF9000993300993300FF9000FF9000FF9000FF9000FF9000FF9000FF9000FF90
          00FF9000FF9000FF9000FF9000FF9000FF9000993300993300FF9000FF900099
          33007F7F7FFFFFFF0000FFCC00FF9000FF9000FF9000FF9000FF9000FF9000FF
          9000FF9000FF9000FF9000FF9000FF9000FF9000FF9000FF9000FF9000FF9000
          FF9000FF9000FF9000FF9000FF90009933007F7F7FFFFFFF0000FFCC00FF9000
          FF9000FF9000FF9000FF9000FF9000FF9000FF9000FF9000FF9000FF9000FF90
          00FF9000FF9000FF9000FF9000FF9000FF9000FF9000FF9000FF9000FF900099
          33007F7F7FFFFFFF0000FFCC00FF9000FF9000FFCC00FFCC00FF9000FF9000FF
          9000FF9000FF9000FF9000FF9000FF9000FF9000FF9000FF9000FF9000FF9000
          FF9000FFCC00FFCC00FF9000FF9000993300FFFFFFFFFFFF0000FFFFFFFFCC00
          FFCC00FFFFFFFFFFFFFFCC00FF9000FF9000FF9000FF9000FFCC00FFCC00FFCC
          00FFCC00FF9000FF9000FF9000FF90009933007F7F7FFFFFFFFFCC00FFCC00FF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCC00FF9000FF
          9000FF90009933007F7F7FFFFFFFFFFFFFFFFFFFFFCC00FF9000FF9000FF9000
          9933007F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFCC00FF9000FF9000FF90009933007F7F7F7F7F7FFFFF
          FFFFFFFFFFCC00FF9000FF9000FF90009933007F7F7FFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCC00FF9000FF
          9000FF9000FF90009933007F7F7FFFFFFFFFCC00FF9000FF9000FF9000FF9000
          9933007F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFCC00FF9000FF9000FF9000FF9000993300FFFFFFFFFF
          FFFFCC00FF9000FF9000FF9000FF90009933007F7F7FFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCC00FFCC00FF
          CC00FFCC00FFCC00FFFFFFFFFFFFFFFFFFFFFFFFFFCC00FFCC00FFCC00FFCC00
          FFCC00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
        Layout = blGlyphBottom
        Margin = 0
        Spacing = 0
      end
      object Panel3: TPanel
        Left = -2
        Top = 150
        Width = 293
        Height = 17
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'Tracks'
        TabOrder = 12
      end
      object Panel4: TPanel
        Left = -2
        Top = 378
        Width = 293
        Height = 17
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'Info'
        TabOrder = 13
      end
      object Panel5: TPanel
        Left = -2
        Top = 2
        Width = 293
        Height = 17
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'Scenery'
        TabOrder = 14
      end
      object SC2T_Type: TRadioGroup
        Left = 122
        Top = 264
        Width = 127
        Height = 69
        Caption = ' Car filter  '
        Items.Strings = (
          'All'
          'Series'
          'Rally'
          'Off-Road only')
        TabOrder = 15
        OnClick = SC2T_TrackChange
      end
      object SC2_BGImage: TEdit
        Left = 2
        Top = 72
        Width = 143
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 16
        Text = '..\..\..\BG_TEST_MAP.tga'
      end
      object SC2_ScnFlag: TEdit
        Left = 2
        Top = 96
        Width = 143
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 17
        Text = '..\..\..\Flag_TEST_MAP.tga'
      end
      object SC2T_Image: TEdit
        Left = 122
        Top = 196
        Width = 127
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 18
        OnChange = SC2T_TrackChange
      end
    end
  end
  object ResetViewButton: TButton
    Left = 874
    Top = 0
    Width = 72
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Reset'
    TabOrder = 5
    OnClick = ResetViewClick
  end
  object PanelMove: TPanel
    Left = 874
    Top = 16
    Width = 24
    Height = 24
    Anchors = [akTop, akRight]
    TabOrder = 2
    object ImageMove: TImage
      Left = 0
      Top = 0
      Width = 24
      Height = 24
      Center = True
      Picture.Data = {
        07544269746D61708A000000424D8A000000000000003E000000280000001300
        00001300000001000100000000004C0000000000000000000000020000000000
        000000000000FFFFFF00FFFFE000FFFFE000FFBFE000FF1FE000FE0FE000FFBF
        E000FFBFE000F7BDE000E7BCE000C0006000E7BCE000F7BDE000FFBFE000FFBF
        E000FE0FE000FF1FE000FFBFE000FFFFE000FFFFE000}
      Transparent = True
      OnMouseDown = PanelMouseDown
      OnMouseMove = PanelMouseMove
      OnMouseUp = PanelMouseUp
    end
  end
  object PanelRotate: TPanel
    Left = 898
    Top = 16
    Width = 24
    Height = 24
    Anchors = [akTop, akRight]
    TabOrder = 3
    object ImageRotate: TImage
      Left = 0
      Top = 0
      Width = 24
      Height = 24
      Center = True
      Picture.Data = {
        07544269746D61708A000000424D8A000000000000003E000000280000001300
        00001300000001000100000000004C0000000000000000000000020000000000
        000000000000FFFFFF00FFFFE000FFFFE000FFFFE000FFDFE000FFCFE000F807
        E000E7CFE000DFDFE000DFFEE000DFFF6000EFFF6000FF7F6000FE7CE000FC03
        E000FE7FE000FF7FE000FFFFE000FFFFE000FFFFE000}
      Transparent = True
      OnMouseDown = PanelMouseDown
      OnMouseMove = PanelMouseMove
      OnMouseUp = PanelMouseUp
    end
  end
  object PanelZoom: TPanel
    Left = 922
    Top = 16
    Width = 24
    Height = 24
    Anchors = [akTop, akRight]
    TabOrder = 4
    object ImageZoom: TImage
      Left = 0
      Top = 0
      Width = 24
      Height = 24
      Center = True
      Picture.Data = {
        07544269746D61708A000000424D8A000000000000003E000000280000001300
        00001300000001000100000000004C0000000000000000000000020000000000
        000000000000FFFFFF00FFFFE000FFFFE000FFFFE000FFFDE000FFF8E000FFF1
        E000FFE3E000F847E000F78FE000EFDFE000DFEFE000DFEFE000DFEFE000DFEF
        E000EFDFE000F7BFE000F87FE000FFFFE000FFFFE000}
      Transparent = True
      OnMouseDown = PanelMouseDown
      OnMouseMove = PanelMouseMove
      OnMouseUp = PanelMouseUp
    end
  end
  object MemoSave: TMemo
    Left = 482
    Top = 418
    Width = 313
    Height = 239
    Anchors = [akLeft, akBottom]
    Lines.Strings = (
      'Saving info:')
    TabOrder = 6
    Visible = False
    OnClick = ShowChangesInfoClick
  end
  object CBTrack: TComboBox
    Left = 178
    Top = 16
    Width = 117
    Height = 21
    Style = csDropDownList
    DropDownCount = 16
    ItemHeight = 13
    TabOrder = 7
    OnChange = CBTrackChange
    OnClick = ListTracksClick
  end
  object CBShowTrack: TCheckBox
    Left = 182
    Top = -1
    Width = 73
    Height = 17
    Caption = 'Show track'
    TabOrder = 8
  end
  object MemoLoad: TMemo
    Left = 304
    Top = 418
    Width = 177
    Height = 239
    Anchors = [akLeft, akBottom]
    Lines.Strings = (
      'Loading info:')
    TabOrder = 9
    Visible = False
    OnClick = ShowChangesInfoClick
  end
  object RG2: TComboBox
    Left = 2
    Top = 16
    Width = 121
    Height = 21
    Style = csDropDownList
    DropDownCount = 32
    ItemHeight = 13
    TabOrder = 10
    OnChange = SceneryReload
  end
  object RG1: TComboBox
    Left = 126
    Top = 16
    Width = 49
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 11
    Text = 'V1'
    OnChange = SceneryReload
    Items.Strings = (
      'V1'
      'V2'
      'V3')
  end
  object F_Top: TPanel
    Left = 2
    Top = 139
    Width = 295
    Height = 2
    TabOrder = 15
  end
  object F_Left: TPanel
    Left = 2
    Top = 140
    Width = 2
    Height = 523
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 12
  end
  object F_Right: TPanel
    Left = 295
    Top = 140
    Width = 2
    Height = 523
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 13
  end
  object F_Bottom: TPanel
    Left = 2
    Top = 661
    Width = 295
    Height = 2
    Anchors = [akLeft, akBottom]
    TabOrder = 14
  end
  object Panel2: TPanel
    Left = 297
    Top = 2
    Width = 2
    Height = 33
    BevelOuter = bvLowered
    TabOrder = 17
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 665
    Width = 948
    Height = 19
    Panels = <
      item
        Text = '100 fps (100)'
        Width = 80
      end
      item
        Text = 'X11098.0 Y1234.5 Z-11652.3'
        Width = 150
      end
      item
        Text = 'H180 P180 Z0.01'
        Width = 96
      end
      item
        Text = 'Map loaded ~100%'
        Width = 112
      end
      item
        Text = '[LWO] Open LWO'
        Width = 240
      end
      item
        Text = 'QAD, VTX, IDX, '
        Width = 50
      end>
    SimplePanel = False
    OnClick = StatusBar1Click
  end
  object CBRenderMode: TComboBox
    Left = 303
    Top = 16
    Width = 94
    Height = 21
    Style = csDropDownList
    DropDownCount = 16
    ItemHeight = 13
    ItemIndex = 4
    TabOrder = 21
    Text = 'Textured'
    OnChange = CBRenderModeClick
    OnClick = CBRenderModeClick
    Items.Strings = (
      'Schematic'
      'Blend'
      'Smoothshade'
      'OpenGL'
      'Textured'
      'Full'
      'Preview')
  end
  object CBTrace: TCheckBox
    Left = 400
    Top = 6
    Width = 89
    Height = 17
    Caption = 'Trace surface'
    TabOrder = 22
  end
  object CBReduceDisplay: TCheckBox
    Left = 400
    Top = 22
    Width = 97
    Height = 17
    Caption = 'Reduce display'
    TabOrder = 23
  end
  object CBShowCar: TCheckBox
    Left = 710
    Top = -2
    Width = 65
    Height = 17
    Caption = 'Show car'
    TabOrder = 24
    OnClick = CBShowCarClick
  end
  object Memo1: TMemo
    Left = 504
    Top = 4
    Width = 121
    Height = 33
    Lines.Strings = (
      'Speed'
      'Mode')
    TabOrder = 25
    OnKeyDown = Memo1KeyDown
    OnKeyUp = Memo1KeyUp
  end
  object PlayTrackControl: TProgressBar
    Left = 632
    Top = 14
    Width = 142
    Height = 16
    Min = -150
    Max = 150
    Position = -150
    Smooth = True
    TabOrder = 20
    OnMouseDown = PlayTrackControlMouseDown
    OnMouseMove = PlayTrackControlMouseMove
    OnMouseUp = PlayTrackControlMouseUp
  end
  object Panel11: TPanel
    Left = 300
    Top = 40
    Width = 181
    Height = 73
    BevelOuter = bvNone
    Caption = 'Panel11'
    Color = clMaroon
    TabOrder = 26
    Visible = False
  end
  object QADtoUI: TButton
    Left = 304
    Top = 44
    Width = 75
    Height = 17
    Caption = 'QADtoUI'
    Enabled = False
    TabOrder = 16
    Visible = False
    OnClick = QADtoUIClick
  end
  object OpenDialog: TOpenDialog
    InitialDir = '.'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 304
    Top = 88
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofPathMustExist, ofEnableSizing]
    Left = 332
    Top = 88
  end
  object MainMenu1: TMainMenu
    Left = 304
    Top = 60
    object File1: TMenuItem
      Caption = '   File'
      object ShowInfo: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF
          8000FF8000FF8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FF8000FF8000FF8000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF
          8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Caption = 'Show map info'
        OnClick = ShowChangesInfoClick
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object SaveScenery: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFF8A4200
          8A4200813E008A42008A42008A42008A42008A42008A42008A42008A42008A42
          008A42008A4200FFFFFFEFB640BC7800BE7C008C4400CAD1DACAD1DACAD1DACA
          D1DACAD1DACAD1DAAB6600CD8D00CD8D008A4200BE7C008A4200EFB43BBA7A00
          BE7C008A4200CAD1DA7D622A7D622ACAD1DACAD1DACAD1DAAB6600CD8D00CD8D
          008A4200BE7C008A4200F2AE52BA7A00BE7C008A4200CAD1DA7D622A7D622ACA
          D1DACAD1DACAD1DAAB6600CD8D00CD8D008A4200BE7C008A4200F2AE52BA7A00
          BE7C008A4200CAD1DACAD1DACAD1DACAD1DACAD1DACAD1DAAB6600CD8D00CD8D
          008A4200BE7C008A4200F2AE52BA7A00BE7C008A42008A42008A42008A42008A
          42008A42008A42008A42008A42008A42008A4200BE7C008A4200F2AE52B97A00
          BE7C00BE7C00BE7C00BE7C00BE7C00BE7C00BE7C00BE7C00BE7C00BE7C00BE7C
          00BE7C00BE7C008A4200F2AE52BC7B008A4200F2AE52F2AE52F2AE52F2AE52F2
          AE52F2AE52F2AE52F2AE52F2AE52F2AE52F28D17BE7C008A4200F2AE52BE7C00
          8A4200E2C17BE2C17BE2C17BE2C17BE2C17BE2C17BE2C17BE2C17BE2C17BE2C1
          7BF2AE52BE7C008A4200F2AE52BE7C008A4200E2C17B8A42008A42008A42008A
          42008A42008A42008A42008A4200E2C17BF2AE52BE7C008A4200F2AE52BE7C00
          8A4200E2C17BE2C17BE2C17BE2C17BE2C17BE2C17BE2C17BE2C17BE2C17BE2C1
          7BF2AE52BE7C008A4200F2AE52BE7C008A4200E2C17BE2C17BE2C17BE2C17BE2
          C17BE2C17BE2C17BE2C17BE2C17BE2C17BF2AE52BE7C008A4200F2AE52BE7C00
          8A4200E2C17B8A42008A42008A42008A42008A42008A42008A42008A4200E2C1
          7BF2AE52BE7C008A4200F2AE52BE7C008A4200E2C17BE2C17BE2C17BE2C17BE2
          C17BE2C17BE2C17BE2C17BE2C17BE2C17BF2AE52BE7C008A4200EDB136B97800
          8A4200E2C17BE2C17BE2C17BE2C17BE2C17BE2C17BE2C17BE2C17BE2C17BE2C1
          7BF2AE52BE7C008A4200FFFFFFF2AE52F2AE52F2AE52F2AE52F2AE52F2AE52F2
          AE52F2AE52F2AE52F2AE52F2AE52F2AE52F2AE52F2AE52FFFFFF}
        Caption = 'Save scenery'
        OnClick = SaveSceneryClick
      end
    end
    object SpecialFuncions1: TMenuItem
      Caption = 'Special actions'
      object MBWRSceneryFix1: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000FF
          FFFFFFFFFF463C32463C32463C32463C32463C32463C32463C32000000000000
          000000000000000000000000000000FFFFFFFFFFFF463C32463C32463C32463C
          32463C32463C32463C32000000000000000000000000000000000000000000FF
          FFFFFFFFFF463C32463C32463C32463C32463C32463C32463C32000000000000
          000000000000000000000000000000FFFFFFFFFFFF463C32463C32463C32463C
          32463C32463C32463C32000000000000000000000000000000000000000000FF
          FFFFFFFFFF463C32463C32463C32463C32463C32463C32463C32000000000000
          000000000000000000000000000000FFFFFF000000FFFFFF463C32463C32463C
          32463C32463C32463C32000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF000000FFFFFF463C32463C32463C32463C32463C32C0C0C0C0C0C0
          C0C0C0FFFFFF000000000000000000000000000000000000000000FFFFFFC8B4
          A0C8B4A0C8B4A0C8B4A0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF000000FFFFFFC8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF000000FFFFFFC8B4A0C8B4A0C8B4
          A0C8B4A0C8B4A0C8B4A0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FF
          FFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4
          A0C8B4A0C8B4A0C8B4A0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FF
          FFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4
          A0C8B4A0C8B4A0C8B4A0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FF
          FFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A0}
        Caption = 'MBWR Lightning fix (Ambient add)'
        OnClick = MBWRLightBlendFix
      end
      object AFC11LightningfixBluelakes1: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF6000FF6000FF6000FF6000FF6000FF6000FF6000FF
          FFFFFFFFFF64503C64503C64503C64503C463C32463C32463C32FF6000FF6000
          FF6000FF6000FF6000FF6000FF6000FFFFFFFFFFFF463C32463C32463C32463C
          3264503C64503C64503CFF6000FF6000FF6000FF6000FF6000FF6000FF6000FF
          FFFFFFFFFF64503C64503C64503C463C32463C32463C32463C32FF6000FF6000
          FF6000FF6000FF6000FF6000FF6000FFFFFFFFFFFF463C32463C32463C326450
          3C64503C64503C463C32FF6000FF6000FF6000FF6000FF6000FF6000FF6000FF
          FFFFFFFFFF64503C463C32463C32463C32463C32463C3264503CFF6000FF6000
          FF6000FF6000FF6000FF6000FF6000FFFFFF000000FFFFFF64503C64503C6450
          3C463C32463C32463C32FF6000FF6000FF6000FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF000000FFFFFF463C32463C3264503C64503C64503C80FF0080FF00
          80FF00FFFFFF000000000000000000000000000000000000000000FFFFFFC8B4
          A0C8B4A0C8B4A0C8B4A080FF0080FF0080FF00FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF000000FFFFFFC8B4A0C8B4A0C8B4A0C8B4A0C8B4A080FF0080FF00
          80FF0080FF0080FF0080FF0080FF00FFFFFF000000FFFFFFC8B4A0C8B4A0C8B4
          A0C8B4A0C8B4A0C8B4A080FF0080FF0080FF0080FF0080FF0080FF0080FF00FF
          FFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A080FF0080FF00
          80FF0080FF0080FF0080FF0080FF00FFFFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4
          A0C8B4A0C8B4A0C8B4A080FF0080FF0080FF0080FF0080FF0080FF0080FF00FF
          FFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A080FF0080FF00
          80FF0080FF0080FF0080FF0080FF00FFFFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4
          A0C8B4A0C8B4A0C8B4A080FF0080FF0080FF0080FF0080FF0080FF0080FF00FF
          FFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A0}
        Caption = 'AFC11 Lightning fix (Blue lakes)'
        OnClick = AFC11Lightningfix1Click
      end
      object AFC11Lightningfix1: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF6000FF6000FF6000FF6000FF6000FF6000FF6000FF
          FFFFFFFFFF64503C64503C64503C64503C463C32463C32463C32FF6000FF6000
          FF6000FF6000FF6000FF6000FF6000FFFFFFFFFFFF463C32463C32463C32463C
          3264503C64503C64503CFF6000FF6000FF6000FF6000FF6000FF6000FF6000FF
          FFFFFFFFFF64503C64503C64503C463C32463C32463C32463C32FF6000FF6000
          FF6000FF6000FF6000FF6000FF6000FFFFFFFFFFFF463C32463C32463C326450
          3C64503C64503C463C32FF6000FF6000FF6000FF6000FF6000FF6000FF6000FF
          FFFFFFFFFF64503C463C32463C32463C32463C32463C3264503CFF6000FF6000
          FF6000FF6000FF6000FF6000FF6000FFFFFF000000FFFFFF64503C64503C6450
          3C463C32463C32463C32FF6000FF6000FF6000FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF000000FFFFFF463C32463C3264503C64503C64503C80FF0080FF00
          80FF00FFFFFF000000000000000000000000000000000000000000FFFFFFC8B4
          A0C8B4A0C8B4A0C8B4A080FF0080FF0080FF00FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF000000FFFFFFC8B4A0C8B4A0C8B4A0C8B4A0C8B4A080FF0080FF00
          80FF0080FF0080FF0080FF0080FF00FFFFFF000000FFFFFFC8B4A0C8B4A0C8B4
          A0C8B4A0C8B4A0C8B4A080FF0080FF0080FF0080FF0080FF0080FF0080FF00FF
          FFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A080FF0080FF00
          80FF0080FF0080FF0080FF0080FF00FFFFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4
          A0C8B4A0C8B4A0C8B4A080FF0080FF0080FF0080FF0080FF0080FF0080FF00FF
          FFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A080FF0080FF00
          80FF0080FF0080FF0080FF0080FF00FFFFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4
          A0C8B4A0C8B4A0C8B4A080FF0080FF0080FF0080FF0080FF0080FF0080FF00FF
          FFFFFFFFFFC8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A0C8B4A0}
        Caption = 'AFC11CT Lightning fix'
        OnClick = AFC11CTLightningFixClick
      end
      object N2: TMenuItem
        Caption = '-'
        RadioItem = True
      end
      object SwitchMBWRVerticeColors1: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F00000F00000F00000F00000F00000F0
          00FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          F00000F00000F00000F00000F00000F000FF0000FF0000FF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F00000F00000F00000F00000F00000F0
          00FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          F00000F00000F00000F00000F00000F000FF0000FF0000FF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F00000F00000F00000F00000F00000F0
          00FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          F00000F00000F00000F00000F00000F000FF0000FF0000FF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F00000F00000F00000F00000F00000F0
          00FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          F00000F00000F00000F00000F00000F000FF0000FF0000FF00000000FF0000FF
          0000FF00F00000F00000F000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFF0000
          00FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF00F00000F00000F000FF0000FF
          0000FF0000FFFFFFFFFFFF000000000000000000FFFFFFFFFFFF0000FF0000FF
          0000FF00F00000F00000F000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFF0000
          00FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF00F00000F00000F000FF0000FF
          0000FF0000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF0000FF0000FF
          0000FF00F00000F00000F000FF0000FF0000FF00000000000000000000000000
          00FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF00F00000F00000F000FF0000FF
          0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF
          0000FF00F00000F00000F000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF00F00000F00000F000FF0000FF
          0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Caption = 'Switch MBWR blending masks'
        OnClick = SwitchMBWRVerticeColors1Click
      end
      object SwitchVerticeColors1: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000
          FF00F00000F00000F000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000FF0000FF0000FF0000FF0000FF00F00000F00000F000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000
          FF00F00000F00000F000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000FF0000FF0000FF0000FF0000FF00F00000F00000F000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000
          FF00F00000F00000F000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000FF0000FF0000FF0000FF0000FF00F00000F00000F000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000
          FF00F00000F00000F000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000FF0000FF0000FF0000FF0000FF00F00000F00000F0000000FF0000FF
          0000FF00F00000F00000F000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFF0000
          00FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF00F00000F00000F000FF0000FF
          0000FF0000FFFFFFFFFFFF000000000000000000FFFFFFFFFFFF0000FF0000FF
          0000FF00F00000F00000F000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFF0000
          00FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF00F00000F00000F000FF0000FF
          0000FF0000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF0000FF0000FF
          0000FF00F00000F00000F000FF0000FF0000FF00000000000000000000000000
          00FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF00F00000F00000F000FF0000FF
          0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF
          0000FF00F00000F00000F000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF00F00000F00000F000FF0000FF
          0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Caption = 'Switch AFC11N blending masks'
        OnClick = SwitchC11_VCol
      end
      object SwitchVerticeColors2: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F00000F00000F000FF0000FF0000FF00
          000000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          F00000F00000F000FF0000FF0000FF00000000FF0000FF0000FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F00000F00000F000FF0000FF0000FF00
          000000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          F00000F00000F000FF0000FF0000FF00000000FF0000FF0000FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F00000F00000F000FF0000FF0000FF00
          000000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          F00000F00000F000FF0000FF0000FF00000000FF0000FF0000FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F00000F00000F000FF0000FF0000FF00
          000000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          F00000F00000F000FF0000FF0000FF00000000FF0000FF0000FF0000FF0000FF
          0000FF00F00000F00000F000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFF0000
          00FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF00F00000F00000F000FF0000FF
          0000FF0000FFFFFFFFFFFF000000000000000000FFFFFFFFFFFF0000FF0000FF
          0000FF00F00000F00000F000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFF0000
          00FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF00F00000F00000F000FF0000FF
          0000FF0000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF0000FF0000FF
          0000FF00F00000F00000F000FF0000FF0000FF00000000000000000000000000
          00FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF00F00000F00000F000FF0000FF
          0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF
          0000FF00F00000F00000F000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF00F00000F00000F000FF0000FF
          0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Caption = 'Switch AFC11CT blending masks'
        OnClick = SwitchVerticeColors2Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Rebuildlightning1: TMenuItem
        Bitmap.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFF0FFFFFFFFF0FFFFF0FFFFF0FFFF0FFFF0FFFF0FFFFFF0FFFFFFF0
          FFFFFFFFFF000FFFFFFFFFFFF0BBB0FFFFFFFFFF0BBBBB0FFFFF000F0BBBBB0F
          000FFFFF0BBBBB0FFFFFFFFFF0BBB0FFFFFFFFFFFF000FFFFFFFFFF0FFFFFFF0
          FFFFFF0FFFF0FFFF0FFFF0FFFFF0FFFFF0FFFFFFFFF0FFFFFFFF}
        Caption = 'Rebuild lightning'
        OnClick = LightApplyClick
      end
      object Rebuildshadows1: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8080808080808080800000000000
          00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF80808080
          8080808080808080808080000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF808080808080808080808080808080FFFFFFFFFFFF0000000000
          00000000FFFFFFFFFFFFFFFFFFFFFFFF808080808080808080808080808080FF
          FFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFF808080
          808080808080808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000
          00000000FFFFFFFFFFFFFFFFFF808080808080FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000
          00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000
          00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000
          00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Caption = 'Rebuild shadows'
        OnClick = TraceShadowsClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Applyshadowtesttoobjects1: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0808080808080808080808080808080808080808080808080C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C08080808080808080808080808080
          80808080808080808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0808080808080808080808080808080808080808080808080C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C08080808080808080808080808080
          80808080808080808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0808080808080808080808080808080808080808080808080C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C08080808080808080808080808080
          80808080808080808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0808080808080808080808080808080808080808080808080C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C08080808080808080808080808080
          80808080808080808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0808080808080808080808080808080808080808080808080C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C08080808080808080808080808080
          80808080808080808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0808080808080808080808080808080808080808080808080C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C08080808080808080808080808080
          80808080808080808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0808080808080808080808080808080808080808080808080C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C08080808080808080808080808080
          80808080808080808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0808080808080808080808080808080808080808080808080}
        Caption = 'Apply shadow test to all objects'
        Enabled = False
        OnClick = Applyshadowtesttoobjects1Click
      end
      object LandInstances: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          00FF0000FF0000FFFFFFFF000000C0C0C0C0C0C0C0C0C0000000000000C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C00000000000FF0000FF0000FFFFFFFF0000FF0000
          FF0000FF000000FFFFFFFFFFFF0000000000FF0000FF0000FF000000FFFFFF00
          00FF0000FF0000FFFFFFFF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000
          FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Caption = 'Land current object instances'
        OnClick = LandInstancesClick
      end
      object RotateInstances: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
          FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
          FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FF
          FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Caption = 'Rotate current object instances (0 - 360)'
        OnClick = RotateInstancesClick
      end
      object ScaleInstances: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF80808080808080808080808080808080808080808080
          8080808080808080808080808080808080808080808080808080000000FFFFFF
          FFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF0000
          00FFFFFFFFFFFF000000000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000FF
          FFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFF
          FFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF0000
          00FFFFFFFFFFFF000000000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000FF
          FFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFF
          FFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF0000
          00FFFFFFFFFFFF000000000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000FF
          FFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFF
          FFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF0000
          00FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
          FFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
          00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Caption = 'Scale current object instances (0.8 - 1.2)'
        OnClick = ScaleInstancesClick
      end
      object ReloadAllObjects1: TMenuItem
        Bitmap.Data = {
          AA030000424DAA03000000000000360000002800000011000000110000000100
          18000000000074030000C40E0000C40E00000000000000000000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D400C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4C8D0D4C8
          D0D4008000008000008000008000008000008000008000008000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4008000008000C8D0D4C8D0D4C8D0D4C8D0D400C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4008000008000C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4C8D0D4000080C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4008000C8D0D4C8
          D0D4C8D0D400C8D0D4C8D0D4000080000080000080C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4008000008000C8D0D4008000C8D0D400800000800000C8D0D4000080
          000080000080000080000080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40080000080
          00008000008000008000C8D0D400000080000080C8D0D4000080C8D0D4000080
          000080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4008000008000008000C8D0D4C8D0
          D400C8D0D4C8D0D4C8D0D4000080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4008000C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4C8D0D400
          0080000080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4C8D0D4C8D0D4000080000080C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D400008000008000008000008000008000008000
          0080000080C8D0D4C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D400C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D400}
        Caption = 'Reload all objects/textures'
        OnClick = ReloadAllObjects1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object DuplicateTrafficRoutes: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFF000080
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FFFFFFFFFF
          FFFFFFFF000080FFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFF000080FFFFFFFFFFFF000080
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FFFFFFFFFF
          FFFFFFFF000080FFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFF000080FFFFFFFFFFFF000080
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FFFFFFFFFF
          FFFFFFFF000080FFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFF000000FF
          FFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFF000080FFFFFF0000FF0000FF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF0000FF0000FF0000FF0000
          FF0000FF0000FF0000FF0000FF0000FF0000FF00000000000000000000000000
          00000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF0000FF0000FF0000FF0000
          FF0000FF0000FF0000FFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFF000000FF
          FFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFF000080FFFFFFFFFFFF000080
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FFFFFFFFFF
          FFFFFFFF000080FFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFF000080FFFFFFFFFFFF000080
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FFFFFFFFFF
          FFFFFFFF000080FFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFF000080FFFFFFFFFFFF000080
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FFFFFFFFFF
          FFFFFFFF000080FFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFF000080FFFFFF}
        Caption = 'Duplicate traffic routes'
        OnClick = DuplicateTrafficRoutesClick
      end
      object LevelStreets: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000000000FFFFFFFFFFFF000000C0C0C0C0C0C0C0C0C0000000000000C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFFFFFFFF0000FF0000FFFFFFFF0000
          00000000000000FFFFFFFFFFFF000000000000000000000000000000FFFFFF00
          00FF0000FFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
          FF0000FF0000FFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Caption = 'Level streets'
        OnClick = LevelStreetsClick
      end
      object StreetsLength: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF000000FFFFFF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000FFFFFF000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF000000FFFFFF000000FFFFFF000000FFFFFF000000FFFFFF000000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF00
          0000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF000000000000FFFFFFFFFFFF000000FFFFFF000000FFFFFF000000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF00
          0000000000FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Caption = 'Show streets length'
        OnClick = StreetsLengthClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object ScreenRender: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000FFFFFF000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000000000000000000000000000
          00000000C0C0C0000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000808080808080808080808080808080000000C0C0C0000000000000C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000008080808080808080808080808080
          80000000C0C0C0000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000808080FFFFFF808080808080808080000000C0C0C0000000000000C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000808080FFFFFFFFFFFF8080808080
          80000000C0C0C0000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000808080808080808080808080808080000000C0C0C0000000000000C0C0C0
          000080000080C0C0C0C0C0C0C0C0C00000000000000000000000000000000000
          00000000C0C0C0000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000FFFFFFFFFFFFFFFFFFFFFFFF808080808080FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Caption = 'Make top-down render'
        OnClick = ButtonPrintScreenClick
      end
      object PrintScreenJPG: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000FFFFFF000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000000000C0C0
          C0C0C0C0C0C0C0000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0000000808080808080808080000000C0C0C0C0C0C0000000000000C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000008080808080808080808080808080
          80000000C0C0C0000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000808080FFFFFF808080808080808080000000C0C0C0000000000000C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000808080FFFFFFFFFFFF8080808080
          80000000C0C0C0000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0000000808080808080808080000000C0C0C0C0C0C0000000000000C0C0C0
          000080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000000000C0C0
          C0C0C0C0C0C0C0000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000FFFFFFFFFFFFFFFFFFFFFFFF808080808080FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Caption = 'Print screen JPG'
        OnClick = PrintScreenJPGClick
      end
    end
    object RenderModeMenu: TMenuItem
      Caption = 'Render mode'
      object CB2D: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000
          0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000
          00000000000000FFFFFFFFFFFF000000FFFFFFFFFFFFC0C0C0FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000
          FFFFFFFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
          FFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFFC0C0C0FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000
          FFFFFFFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
          FFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFFC0C0C0FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000
          FFFFFFFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
          FFFFFFFF000000FFFFFFFFFFFF00000000000000000000000000000000000000
          0000000000000000000000000000FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF0000000000000000000000000000000000000000000000000000
          00000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Caption = '2D'
        OnClick = CB2DClick
      end
      object CBCheckers: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000
          00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000
          00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000
          000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFF
          FFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFF
          FFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000
          000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFF
          FFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFF
          FFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000
          00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000
          00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000
          000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFF
          FFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFF
          FFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000
          000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFF
          FFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFF
          FFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF}
        Caption = 'Checkers'
        OnClick = CBCheckersClick
      end
      object CBWire: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000
          0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
          505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000
          00FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF505050FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFF505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
          FFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF50505050505050
          5050505050505050505050000000505050505050505050000000FFFFFF000000
          FFFFFFFFFFFFFFFFFF505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
          FFFFFFFFFFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFF505050FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF000000
          FFFFFFFFFFFFFFFFFF505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
          FFFFFFFFFFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFF505050FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF000000
          FFFFFFFFFFFFFFFFFF505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
          FFFFFFFFFFFFFF000000FFFFFF00000000000000000000000000000000000000
          0000000000000000000000000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
          000000FFFFFFFFFFFF505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
          00FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF505050FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFFFFFFFF
          FFFFFFFFFFFF000000505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
          0000000000000000000000000000000000000000000000000000}
        Caption = 'Wireframe'
        OnClick = CBWireClick
      end
      object CBSelectionBuffer: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF40004040004040004040004040004040004040004040
          0040400040400040400040400040800040800040800040800040400040400040
          4000404000404000408000FF8000FF4000404000404000404000408000408000
          408000408000408000404000408000FF8000FF8000FF8000FF8000FF8000FFFF
          0080FF0080FF00808000408000408000408000408000408000408000FF8000FF
          8000FF8000FF8000FF8000FF8000FF8000FFFF0080FF0080FF0080FF0080FF00
          808000408000408000408000FF8000FF8000FF8000FF8000FF8000FF80008080
          0080FF0080FF0080FF0080FF0080FF0080FF0080FF00808000408000FF8000FF
          8000FF8000FF800080800080800080800080800080FF0080FF0080FF0080FF00
          80FF0080FF0080FF00808000FF8000FF00000080008080008080008080008080
          0080800080FF0080FF0080FF0080FF0080FF0080FF00804000808000FF000000
          000000000000000000800080800080800080800080800080800080FF0080FF00
          80FF008040008040008000000000000000000000000000000000000080008080
          0080800080800080800080000000000000400080400080400080000000000000
          0000000000000000000000000000000000008000808000800000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Caption = 'Selection buffer'
        OnClick = CBSelectionBufferClick
      end
      object Show2ndFrame: TMenuItem
        Caption = 'Show 2nd frame'
        OnClick = Show2ndFrameClick
      end
    end
    object Options2: TMenuItem
      Caption = 'Options...'
      OnClick = OptionsClick
    end
    object About1: TMenuItem
      Caption = 'About...'
      OnClick = About1Click
    end
  end
  object ImageList1: TImageList
    AllocBy = 1
    Height = 32
    Masked = False
    ShareImages = True
    Width = 32
    Left = 332
    Top = 60
    Bitmap = {
      494C010110001300040020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000080000000A000000001002000000000000040
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFE6D900FFCCB200FFCCB200FFCC
      B200FFCCB200FFCCB200FFCCB200FFCCB200FFCCB200FFCCB200FFCCB200FFCC
      B200FFCCB200FFCCB200FFCCB200FFCCB200FFCCB200FFCCB200FFCCB200FFCC
      B200FFCCB200FFCCB200FFCCB200FFCCB200FFCCB200FFCCB200FFCCB200FFCC
      B200FFCCB200FFCCB200FFCCB200FFE6D9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFCEB500FF9D6C00FF9D6C00FF9D
      6C00FF9D6C00FF9D6C00FF9D6C00FF9D6C00FF9D6C00FF9D6C00FF9D6C00FF9D
      6C00FF9D6C00FF9D6C00FF9D6C00FF9D6C00FF9D6C00FF9D6C00FF9D6C00FF9D
      6C00FF9D6C00FF9D6C00FF9D6C00FF9D6C00FF9D6C00FF9D6C00FF9D6C00FF9D
      6C00FF9D6C00FF9D6C00FF9D6C00FFCFB600000000004DA9330084C7740085D6
      80003BC1350066B447004DA7220076D866008ED47B0053A928003BA2110074BE
      6400509925006CB6550052AE2E0051AB290042BB2E0081C9770084A46600418D
      160037B21E006EC55900C3DDB500498E1F004FAB3B006AD96A008CD37D00518A
      2600E6ECE0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFD0B800FFA17200FFA17200FFA1
      7200FFA17200FFA17200FFA17200FFA17200FFA17200FFA17200FFA17200FFA1
      7200FFA17200FFA17200FFA17200FFA17200FFA17200FFA17200FFA17200FFA1
      7200FFA17200FFA17200FFA17200FFA17200FFA17200FFA17200FFA17200FFA1
      7200FFA17200FFA17200FFA17200FFD1B9000000000033A11C0041B7310052CC
      4F0034B92B003C971200409F100048CC390051C73C0044A2160034A00A00479E
      2D00398208003E901C0035A81100389E090036BC260055B74700457417003373
      020033B0170047BB31008EC47400338A00003982140052D352004FB033004183
      1200BACBA9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFD2BC00FFA57900FFA57900FFA5
      7900FFA57900FFA57900FFA57900FFA57900FFA57900FFA57900FFA57900FFA5
      7900FFA57900FFA57900FFA57900FFA57900FFA57900FFA57900FFA57900FFA5
      7900FFA57900FFA57900FFA57900FFA57900FFA57900FFA57900FFA57900FFA5
      7900FFA57900FFA57900FFA57900FFD3BD0000000000349F1D0038BA2C005CCD
      580035BE2E003B9415003C9D0C0043C8360046CA380044A1160035A10B0041A2
      29003A8309003C84150033B51D00379B050036B31D0048C3410048761B003372
      030033AF170047B62C007EC56900348E0200387B0F004FCF4D0050B837004189
      120095B07B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFD5BF00FFAA7F00FFAA7F00FFAA
      7F00FFAA7F00FFAA7F00FFAA7F00FFAA7F00FFAA7F00FFAA7F00FFAA7F00FFAA
      7F00FFAA7F00FFAA7F00FFAA7F00FFAA7F00FFAA7F00FFAA7F00FFAA7F00FFAA
      7F00FFAA7F00FFAA7F00FFAA7F00FFAA7F00FFAA7F00FFAA7F00FFAA7F00FFAA
      7F00FFAA7F00FFAA7F00FFAA7F00FFD5C0000000000037A1200040B4310052BF
      400036BB2D003790160047A31A0041BB280042CB36004DA9230036A10C0040B6
      31003C7D0B003A780C0036B21B00369C060033A20B0039CA3800537E28003371
      030033AB140041AA1C0059CA4F00358D03003C80140044C03C004DC13C003C92
      0C00688E42000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFD7C200FFAE8500FFAE8500FFAE
      8500FFAE8500FFAE8500FFAE8500FFAE8500FFAE8500FFAE8500FFAE8500FFAE
      8500FFAE8500FFAE8500FFAE8500FFAE8500FFAE8500FFAE8500FFAE8500FFAE
      8500FFAE8500FFAE8500FFAE8500FFAE8500FFAE8500FFAE8500FFAE8500FFAE
      8500FFAE8500FFAE8500FFAE8500FFD7C300000000003BA3240042A12A0042B9
      2D0039AF2A00349417006BB749003AA40F006BCC55004BC5350036A10B003FB6
      2D003C760D0037770700419E130034A0090033A10A0048C640004D9D3300346F
      0400349E0C0034A30C0048C84000388A07003E8C1900388E190043C73B003B95
      0B007D9E5D00DEE6D60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E5BEA200CD8F6300CD8F6300CD8F
      6300CD8F6300CD8F6300CD8F6300CD8F6300CD8F6300CD8F6300CD8F6300CD8F
      6300CD8F6300CD8F6300CD8F6300CD8F6300CD8F6300CD8F6300CD8F6300CD8F
      6300CD8F6300CD8F6300CD8F6300D9976B00FFB28C00FFB28C00FFB28C00FFB2
      8C00FFB28C00FFB28C00FFB28C00FFD9C6000000000045A12D00447F19003DC5
      350037A01E003BB62C0048B03400399E09006BC44F003FCB3500369E08004DA5
      2600349F1D004E9427003A880A0041A4160033A30B005CAE3A0037C63400346B
      03003792090034B31B004CA9250037AA1E0036890700387E110046C63D00449F
      2100A5C58F0086A4680000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DBC4A000BFAF7F00BFAF7F00BFAF
      7F00BFAF7F00BFAF7F00BFAF7F00BFAF7F00BFAF7F00BFAF7F00BFAF7F00BFAF
      7F00BFAF7F00BFAF7F00BFAF7F00BFAF7F00BFAF7F00BFAF7F00BFAF7F00BFAF
      7F00BFAF7F00BFAF7F00B9A47400AF845400EFAA8300FFB69200FFB69200FFB6
      9200FFB69200FFB69200FFB69200FFDBC90000000000539E3700459022006CCB
      650034AD1A004FC444003B8D170050BB35003AA00D0076C353003BC73100399A
      090036BA2A0087B26F003372010051A7270038B21D00399E0B0043B233003495
      1800357D070039B11D004EB12D0035AB1800359307004FA539003F99230044C1
      3C0090C0750082A16300DBE4D300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EAD9BC00D5D5AB00D5D5AB00D5D5
      AB00D5D5AB00D5D5AB00D5D5AB00D5D5AB00D5D5AB00D5D5AB00D5D5AB00D5D5
      AB00D5D5AB00D5D5AB00D5D5AB00D5D5AB00D5D5AB00D5D5AB00D5D5AB00D5D5
      AB00D5D5AB00D5D5AB00D5D5AB00B1875800F4B28E00FFBB9900FFBB9900FFBB
      9900FFBB9900FFBB9900FFBB9900FFDECD0000000000689D4A0042B42F0094C2
      830035C0300062BA470038B928007BCB6E0038A50E0056A92B004BC5310045AD
      27003D9E15005DC7540038820A004395140039A20E0073D36F00359A05003AC2
      33003375060054B9390047C93F004093120034B0200063C153005BB144004190
      210079C96F0000000000A4BA8D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECDCC100D9D9B300D9D9B300D9D9
      B300D9D9B300D9D9B300D9D9B300D9D9B300D9D9B300D9D9B300D9D9B300D9D9
      B300D9D9B300D9D9B300D9D9B300D9D9B300D9D9B300D9D9B300D9D9B300D9D9
      B300C8BA9100D2CCA500C3AE8300B6835500FFBF9F00FFBF9F00FFBF9F00FFBF
      9F00FFBF9F00FFBF9F00FFBF9F00FFE0D0000000000086A86A003DC13300DEF4
      DD0042BC380047CA430034B01900AEE9AD003DC22E0044A1150059B236004DB4
      34003CA7140064B14B0040C234003C880C004FB12E0043AE2100459C2900609D
      3D0033C22C005DAB3E0052B2310038B8270045801D0046D046007DD2710064C0
      54003D891B0091E3910000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFE0C800DEDEBD00DEDEBD00DEDE
      BD00DEDEBD00DEDEBD00DEDEBD00DEDEBD00DEDEBD00DEDEBD00DEDEBD00DEDE
      BD00DEDEBD00DEDEBD00DEDEBD00DEDEBD00DEDEBD00DEDEBD00DEDEBD00DEDE
      BD00AC7D4E00B8875B00D49E7700FFC3A500FFC3A500FFC3A500FFC3A500FFC3
      A500FFC3A500FFC3A500FFC3A500FFE2D3000000000097B17D0044C33B00BFE2
      B50047C5410074BA64003BAD1A009CE39A004CCF43004CA9220047A41C004CB1
      3B007ABF660049A8250064BF4C0044A81C004EAA25003BAC190056882B006B94
      46003BBB2A0044C2370089DC850035A9140046A8320083D57E005BD1570093C7
      790045B33600CCF2CC00DBF6DB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E6D3BC00C7AE8900C8B18C00E3E3
      C700E3E3C700E3E3C700E3E3C700E3E3C700E3E3C700E3E3C700E3E3C700E3E3
      C700E3E3C700E3E3C700E3E3C700E3E3C700E3E3C700E3E3C700D9D3B400BA97
      6E00EBB59500FFC7AC00FFC7AC00FFC7AC00FFC7AC00FFC7AC00FFC7AC00FFC7
      AC00FFC7AC00FFC7AC00FFC7AC00FFE4D60000000000ADC2990058C14C0084CC
      6F0056CD52004EA1340055AA2B00B1D79D0048CF43005AC546004AA51D0046B8
      3400AAC695004C872000AEE0A40045A71C0055A92A003DCE3D00439914005F89
      38004ABB350042A518004DD24D00469B18004B9C210058BF4D006DD76A007CBD
      5B0077995500E7EDE100FDFEFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E3C4AC00D9A68200B4845800E2DF
      C600E7E7CF00E7E7CF00E7E7CF00E7E7CF00E7E7CF00E7E7CF00E7E7CF00E7E7
      CF00E6E5CD00B9976F00DBD3B700E7E7CF00E7E7CF00D9D0B400C2A17B00E5B4
      9400FFCCB200FFCCB200E0AD8C00E0AD8C00E0AD8C00E0AD8C00E0AD8C00E0AD
      8C00E0AD8C00E0AD8C00E0AD8C00EFD3C00000000000C5D3B7006FBA5F0052BD
      3B007CD97A00419726007BBE5C006FB74C00B5E9AA0057CE4A0061B03A0043B3
      2900A5BF91003D760D00F0F7ED003CA6140050A7240051D150007BB869003992
      080051B735003AA5120059D055004BA11F0084AD670049A131005ED65E0064B1
      3D00B0C49D00ADC2990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFE7DB00FFCEB600EEBDA100BB96
      6E00DDD4BC00ECECD900ECECD900ECECD900ECECD900ECECD900ECECD900E2DC
      C600CDB59500D7A68400BE906700AD805300AE805400C0926A00E4B39400FFCE
      B600FFCEB600FFCEB600AA7C4D00B69B6900B69B6900B69B6900B69B6900B69B
      6900B69B6900B69B6900B69B6900D5BF9C0000000000DEE6D6007AA15C004DCB
      46008FDA8700429F29008ACF79004DA52000F5FAF30045CE3C0061B039006BC2
      55005BA2410049841B00D2E0C70046A91E0045A3180076D26C005EC958004977
      1C0046A41B003DAF1E0085CE730051AD2E0085AB660045841F0075DC75006EBE
      5200D5E5CB0070944C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFE8DD00FFD1BA00FFD1BA00F0C2
      A700C29F7B00E3DBC800F1F1E300F1F1E300F1F1E300F1F1E300EEEDDE00D8C4
      AA00E1B69800FFD1BA00FFD1BA00FFD1BA00FFD1BA00FFD1BA00FFD1BA00FFD1
      BA00FFD1BA00EABB9F00B6936600D2D2A500D2D2A500D2D2A500D2D2A500D2D2
      A500D2D2A500D2D2A500D2D2A500E9DEC10000000000F5F7F300698E430057D1
      530084CA6E004CBA400069C65E0050A72400C2E0B3005BD24D0050AF2A0074C0
      58004BA936006799410098BC7F006CB84A0047AA200078BF5A0040CE3F004574
      17009AC6820045C136004FA9260057BD41005D993400558F320081D47B006FCB
      6000C6E2B80076985400E7EDE200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFEADF00FFD4BE00FFD4BE00FFD4
      BE00E8BB9F00BE936C00B9946D00CEB69900D2BDA200C5A68600B1855B00CEA0
      7D00FFD4BE00FFD4BE00FFD4BE00FFD4BE00FFD4BE00FFD4BE00FFD4BE00FFD4
      BE00FFD4BE00FCD0BA00AD825400D8D8B100D8D8B100D8D8B100D8D8B100D8D8
      B100D8D8B100D8D8B100D8D8B100ECE1C800000000000000000062893A0094E3
      940054B737004ECA4A0055AA400059AC300076BA54009BE28C0065CF55004CA6
      200065D86500A5C38F005E9536009ECE860054BF3E0042A013004DD24D004882
      20009ABA81005AC94D0055AD2E0055C1420046921A0096BB82005EB04B0077DC
      7700FCFDFC00C0D0B1009DB68500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFEBE100FFD6C200FFD6C200FFD6
      C200FFD6C200FFD6C200F3C8B100DBAF9000D7AA8A00E5BA9E00FFD6C200FFD6
      C200FFD6C200FFD6C200FFD6C200FFD6C200FFD6C200FFD6C200FFD6C200FFD6
      C200FFD6C200FFD6C200DAAF9000C7A98300BEAF8A00BEA88200C4AD8600DFDF
      BF00DFDFBF00DFDFBF00DFDFBF00F0E5D0000000000000000000799B5800C1E4
      BC0064CF5B0061CB5800569E3B0065BB480069B44400D6ECCB0049CF410049A4
      1C006FD26700D2ECCE003F7B1000C9E4BC0076C25C003C9F0E0083DA7D004DB6
      3F006A8F450054B837008BDA840061B6400045A41E00D0DBC5003D7F160065D8
      6500F7FDF700000000005F873700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFECE300FFD9C600FFD9C600FFD9
      C600FFD9C600FFD9C600FFD9C600FFD9C600FFD9C600FFD9C600FFD9C600FFD9
      C600FFD9C600FFD9C600FFD9C600FFD9C600FFD9C600FFD9C600FFD9C600FFD9
      C600FFD9C600FFD9C600FFD9C600FFD9C6005FA6A700BAB09C00AE805400E5E5
      CB00E5E5CB00E5E5CB00E5E5CB00F3E9D7000000000000000000D1DCC600E0E8
      D90062D7620053B8360076CA6D0052C343008EC67200C4E1B6006AD65E0073C2
      56009AD68B0098E5980053832800A3CE8D006DB6480048B42C0069B7470040CB
      3E00769A55007CBF5D005ED45C00FDFEFD0051C24000F7FBF6005A943A0070CB
      6900C0EFC00000000000D9E2D000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFEEE500FFDCCA00FFDCCA00FFDC
      CA00FFDCCA00FFDCCA00FFDCCA00FFDCCA00FFDCCA00FFDCCA00FFDCCA00FFDC
      CA00FFDCCA00FFDCCA00FFDCCA00FFDCCA00FFDCCA00FFDCCA009FD6DD00C5D8
      D600FFDCCA00FFDCCA00FFDCCA00FFDCCA003CCFF200CBD8D400FFDCCA00AD82
      5600E2DEC600EBEBD700EBEBD700F3ECDE000000000000000000000000000000
      0000A2E7A20080D0720051CF4D00DEF5DD0047AA200000000000BCEBB2005CCD
      4D0075BA52005FD75F0089AA6B0069A5430069B44300EEF7EC0040A617007CDE
      7C003E8C1E00BEDEAE005BCD5200E0F7E0009DE69D00C0EFC000C0D7B4004B99
      2F007CDE7C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFEFE700FFDECE00FFDECE00FFDE
      CE00FFDECE00FFDECE00FFDECE00FFDECE00FFDECE00FFDECE00FFDECE00FFDE
      CE00FFDECE00FFDECE00FFDECE00FFDECE00FFDECE00FFDECE00C3D9D90019CD
      FA00C3D9D900FFDECE00FFDECE00FFDECE00B3D8DC00EBDCD100FFDECE00FBD9
      C700B78E6700A5957500B9A78A00DFCAB5000000000000000000000000000000
      0000EEFAEE0070DB70005BCB5000BCE7B50086C26800D7EBCE00000000006CD6
      5E004EAA2400A2E7A200B1E4AE0055932A00A5D29000ACD59800F6FAF400CBF1
      CA006ECA6600DAE4D10056B93A009BE69B00F5FCF50069D96900000000004786
      22007CD87900CFF3CF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFF0E900FFE1D200FFE1D200FFE1
      D200FFE1D200E7C4AD00C69E7A00C49D7800C49D7800C49D7800C49D7800C49D
      7800C49D7800C49D7800C49D7800C49D7800C49D7800C49D7800C49D7800AD9B
      7C006A958800D2BDA700FFE1D200FFE1D200EDDAD500F3DCD400FFE1D200FFE1
      D20067D4EC0069C4D200E2C0A800F3E1D5000000000000000000000000000000
      000000000000ADEAAD0093E493008DE28D00CFE7C4008EC6720000000000BFEC
      B70051C03800A4D18D006DDA6D00BEE1B10084C1660082C06300000000000000
      000066D86600F7FDF70085C2670057D2550000000000CFF3CF008FE38F00E6ED
      E1004FC0460092E3920000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFF2EB00FFE4D600FFE4D600FFE4
      D600FFE4D600D1AC8E00BFAD7E00C3B78800C3B78800C3B78800C3B78800C3B7
      8800C3B78800C3B78800C3B78800C3B78800C3B78800C3B78800C3B78800C3B7
      8800C3B78800B79C6D00C7A481004FAAF80042ABF90048AAF9008BBEEC00FFE4
      D600EBE2D900FDE3D600FFE4D600FFF2EB000000000000000000000000000000
      000000000000F9FDF900D8F5D80065D86500F9FDF90064B13D00FAFCF9000000
      000058CE49005EB23900E7F9E700E9F9E900B4D9A20057AA2D00FAFCF9000000
      0000B8EDB800A5E8A500D4E9CA005DC84F00C6F0C60000000000D3F4D3000000
      0000DDF6DD0068D96800F3FCF300000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFF3ED00FFE6DA00FFE6DA00FFE6
      DA00FFE6DA00BA926B00CFC89F00D7D7AF00D7D7AF00D7D7AF00D7D7AF00D7D7
      AF00D7D7AF00D7D7AF00D7D7AF00D7D7AF00D7D7AF00D7D7AF00D7D7AF00D7D7
      AF00D7D7AF00D3D0A8009D8B6C001AB9DD0000CCFE0000CCFE0017BDFD0073B8
      F100FFE6DA00FFE6DA00FFE6DA00FFF3ED000000000000000000000000000000
      0000000000000000000000000000B0EBB000ADEAAD00AED69A00B0D79C000000
      0000F8FCF600B7E1A300F7FBF5000000000000000000A1D08A00BCDDAC000000
      00000000000060D76000FEFEFE0083C66A0065D4610000000000000000000000
      000000000000FBFEFB00FBFEFB00000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFF4EF00FFE9DE00FFE9DE00FFE9
      DE00FFE9DE00D1AF9200C8B68F00DDDDBB00DDDDBB00DBDAB700D7D3AF00DDDD
      BB00DDDDBB00DDDDBB00DDDDBB00DDDDBB00DDDDBB00DDDDBB00DDDDBB00DDDD
      BB00DDDDBB00DDDDBB00999372001ABADA0000CCFE0000CCFE0000CCFE0030B0
      FC00D8DAE400FFE9DE00FFE9DE00FFF5EF000000000000000000000000000000
      0000000000000000000000000000FDFEFD0061D76100FBFDFB0062B03B000000
      00000000000000000000000000000000000000000000EBF5E60073B950000000
      000000000000B5ECB500A8E9A800D0E7C50056C94B00DBF6DB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFF6F100FFECE200FFECE200FFEC
      E200FFECE200FFECE200C19D7900B38E6400B8966D00AC825600D3C9A700E2E2
      C500E2E2C500E2E2C500E2E2C500E2E2C500E2E2C500D4CBAA00D0C3A100E2E2
      C500E2E2C500D7D0B0007A8E770000CCFE0000CCFE0000CCFE0000CCFE000FBD
      FE0093C2F000FFECE20045D4F700CEEDF3000000000000000000000000000000
      000000000000000000000000000000000000DAF5DA009BE69B00A0CF8800BEDE
      AE000000000000000000000000000000000000000000000000007ABC5900E3F1
      DC0000000000000000009EE69E00D7F5D700C0DFB0006CD76A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFF7F300FFEEE600FFEEE600FFEE
      E600FFEEE600FFEEE600FFEEE600F6E2D600EFD9CA00EAD2C200BE9E7A00D9D0
      B300E8E8D100E8E8D100E8E8D100E8E8D100E8E8D100BDA58200A5825A00B08C
      6300B6936C008F7B620000CCFE0000CCFE0000CCFE0000CCFE0000CCFE0019BC
      FD00A1C6F100FFEEE600CEE7EA00F2F4F3000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B2D8
      9F00000000000000000000000000000000000000000000000000CEE6C20090C7
      7400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFF8F500FFF1EA00FFF1EA00FFF1
      EA00FFF1EA00FFF1EA00FFF1EA00FFF1EA00FFF1EA00FFF1EA00F1DFD200B590
      6900E6E1CD00EEEEDD00EEEEDD00ECEBD900C2A68300E2CCB800FFF1EA00F8E8
      DE00F3E0D40088C2F50016BEFD0001CAFE0000CCFE0000CCFE0000CCFE0042A8
      FC00FFF1EA00FFF1EA00FFF1EA00FFF9F5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000069B4
      4400F4F9F2000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFAF700FFF4EE00FFF4EE00FFF4
      EE00FFF4EE00FFF4EE00FFF4EE00FFF4EE00FFF4EE00FFF4EE00FFF4EE00F6E8
      DE00B9936E00B0886000B48D6600B1886000E6D1C000FFF4EE00FFF4EE00FFF4
      EE00FFF4EE00FFF4EE0074BEF80030AFFD000FBDFE001BBAFD0045ABFC00F1EF
      EE00FCF2EE00FFF4EE00FFF4EE00FFFAF7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C2E0
      B3009CCD83000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFBF900FFF6F200FFF6F200FFF6
      F200FFF6F200FFF6F200FFF6F200FFF6F200FFF6F200FFF6F200FFF6F200FFF6
      F200FFF6F200FDF3EE00F9EEE700FFF6F200FFF6F200FFF6F200FFF6F200F7F4
      F20067DDF900EBF2F300FFF6F200DCE6F40093C6F800A9CEF700F5F1F200FFF6
      F20087E2F800C3ECF500FFF6F200FFFBF9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ACD59700DAECD10000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFCFB00FFF9F600FFF9F600FFF9
      F600FFF9F600FFF9F600FFF9F600FFF9F600FFF9F600FFF9F600FFF9F600FFF9
      F600FFF9F600FFF9F600FFF9F600FFF9F600FFF9F600FFF9F600F7F7F60048D8
      FC0062DDFB00FDF8F600FFF9F600FFF9F600FFF9F600FFF9F600FFF9F600FFF9
      F600C3EEF80019D0FE00C3EEF800FFFDFB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFEFD00FFFCFA00FFFCFA00FFFC
      FA00FFFCFA00FFFCFA00FFFCFA00FFFCFA00FFFCFA00FFFCFA00FFFCFA00FFFC
      FA00FFFCFA00FFFCFA00FFFCFA00FFFCFA00FFFCFA00FFFCFA0077E2FC0063DE
      FD00FDFBFA00FFFCFA00FFFCFA00FFFCFA0045D9FD00CEF2FA00FFFCFA00FFFC
      FA00FFFCFA00C5F1FB0021D2FE00F9FCFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9FDFF00FEFE
      FF0000000000000000000000000000000000CEF5FF00F2FCFF00000000000000
      00000000000000000000F9FDFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BEBEBE007E7E7E007E7E7E007E7E
      7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E
      7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E
      7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E
      7E007E7E7E007E7E7E007E7E7E00BEBEBE00E5E5E500CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00E5E5E5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990091919100969696009696960096969600999999009999
      9900999999009999990099999900CCCCCC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005A5A
      5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A
      5A005A5A5A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A9A9A90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D0D0D000ADADAD000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002A2A
      2A0095959500BBBBBB00BABABA00818181000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      9900999999009999990099999900999999008999810070995C0099999900AAAA
      AA00D4D4D400E3E3E300E3E3E300CCCCCC009999990099999900999999009999
      990099999900999999001C1F22000F161D001010170063636300999999009999
      9900999999009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF00BFBFBF00ABABAB0094949400949494009494940094949400ABABAB00BFBF
      BF00BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C9C9C90081818100E8E8E800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A1A1A100DFDFDF00BABABA00F0F0F00000000000000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000828282009C9C
      9C00313131000B0B0B000C0C0C00454545007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      990099999900999999008C9985006A9953008D9987007B996C00CDCDCD00D7D7
      D700ACACAC009D9D9D009E9E9E00B4B4B400CACACA0099999900999999009999
      99009999990099999900181D22000032640003031F0063636300999999009999
      9900999999009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF00BFBFBF00ABABAB00377C3500377C3500377C3500377C3500ABABAB00BFBF
      BF00BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7E7E700C3C3C300EFEFEF0093939300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADADAD0000000000F8F8F800B7B7B70000000000000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000000000
      00000000000000000000000000000000000000000000AEAEAE00444444000000
      00000000000000000000000000000E0E0E00777777004F4F4F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      9900999999009999990091998D007B996C0099999900DEDEDE00B4B4B4009999
      9900999999005F99420094999200969D9200BDC4B900B8B8B800999999009999
      99009999990099999900181D22000032640003031F0063636300999999009999
      9900999999009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF00BFBFBF00377C350043CA000043CA000043CA000043CA0000377C3500BFBF
      BF00BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A4A4A40000000000000000008A8A8A00F5F5F5000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ABABAB000000000000000000A6A6A60000000000000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000000000
      000000000000000000000000000036363600C7C7C70018181800000000000000
      00000000000000000000000000000000000000000000C3C3C300030303000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      9900999999006C99560083997900AEAEAE00E8E8E800A2A2A200999999009999
      99009999990079996900969995006F995B006A935700CFCFCF008A8A8A008989
      89008989890089898900151A1E00002C590002021B0058585800898989008989
      8900898989007F7F7F0089898900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF003A7A380043CA000043CA000043CA000039BC000039BC000043CA00003A7A
      3800BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000AFAFAF000000000000000000C7C7C700ADADAD000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ABABAB000000000000000000E0E0E000DDDDDD00000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000000000
      000000000000000000001E1E1E00A8A8A8000A0A0A0000000000000000000000
      000000000000000000000000000000000000000000003F3F3F00888888000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      9900999999008399790099A39400DCDCDC009D9D9D0099999900999999009999
      9900999999007B996C0072995F009999990097979700232821002E4422002940
      1E002A411F00283E1C00172E0D00112D10000D240500142A0900182C0F001829
      0F0016240F001B25160066666600CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF000000000043CA000043CA000043CA000043CA000039BC000043CA00000000
      0000BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B8B8B800F8F8F80000000000FBFBFB0094949400FEFE
      FE00000000000000000000000000000000000000000000000000000000000000
      000000000000AEAEAE000000000000000000E4E4E40089898900D1D1D1000000
      0000000000000000000000000000000000007F7F7F0000000000000000000000
      00000000000000000000979797002F2F2F000000000000000000000000000000
      0000000000000000000000000000000000000000000013131300B3B3B3000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      99009999990099999900D5D5D50097A88E0092998F0099999900999999009999
      9900999999008C9986008999810099999900999999008F8F8F002E45230074DA
      41007BE2480074DA410065CB320052B81E003DA40A00309200002B810000246F
      00001A4C0200353A330099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000363636005A5A5A00BFBF
      BF000000000043CA00000000000043CA000043CA000043CA000043CA00000000
      0000BFBFBF005A5A5A0036363600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C9C9C900E8E8E8000000000000000000BCBCBC00BEBE
      BE00000000000000000000000000000000000000000000000000000000000000
      000000000000AFAFAF00E9E9E900CDCDCD00BFBFBF00F6F6F600E2E2E200A8A8
      A800AFAFAF00E8E8E80000000000000000007F7F7F0000000000000000000000
      0000000000005252520074747400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000464646000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      990099999900BABABA00C7C7C7006299470085997C0099999900999999009999
      99009999990099999900999999009999990099999900CCCCCC0070756E004378
      290077DD440079DF46006AD0370054BB21003DA40A0030900000297C00002166
      0000151B12009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000036363600949494005A5A5A00BFBF
      BF000000000043CA0000000000000000000043CA000043CA000043CA00000000
      0000BFBFBF005A5A5A0094949400363636000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D8D8D800D6D6D6000000000000000000E6E6E600A3A3
      A300000000000000000000000000000000000000000000000000000000000000
      0000F0F0F00099999900EFEFEF0000000000CDCDCD0000000000000000000000
      0000FDFDFD00B9B9B900B1B1B100000000007F7F7F0000000000000000000000
      0000000000009393930033333300000000000000000000000000000000000000
      000000000000000000000606060076767600B2B2B20000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      990099999900D3D3D300ADADAD008399780091998D0099999900999999009999
      990099999900999999009B9B9B00C8C8C800E0E0E0009999990099999900343E
      30005DB2320078DE450073D9400058BE25003DA30A002E8C0000246F00001626
      0E00818281009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000003636360094949400949494005A5A5A00BFBF
      BF00BFBFBF000000000043CA000043CA000043CA000043CA000000000000BFBF
      BF00BFBFBF005A5A5A0094949400949494003636360000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EAEAEA00C6C6C600000000000000000000000000BEBE
      BE00C8C8C800000000000000000000000000000000000000000000000000DBDB
      DB00A7A7A7000000000000000000E5E5E500F6F6F60000000000000000000000
      000000000000CDCDCD00E4E4E400000000007F7F7F0000000000000000000000
      0000000000008E8E8E0038383800000000000000000000000000000000000000
      000000000000000000008C8C8C00505050001414140000000000000000000000
      00000000000070707000BBBBBB00C0C0C000BBBBBB00A6A6A600616161000404
      04000000000000000000000000007F7F7F00CCCCCC0099999900999999009599
      93007B996D00D1D1D100AFAFAF0067994E0087997E0099999900999999009999
      99009999990099999900D1D1D100B9B9B900A1A1A1008A8A8A00737373007373
      7300151E100055A22E005AA83400479521002E7B070021650000153306003E41
      3D00737373007373730099999900CCCCCC000000000000000000000000000000
      00000000000000000000363636003636360036363600363636005A5A5A00BFBF
      BF00BFBFBF00ABABAB0000000000000000000000000000000000ABABAB00BFBF
      BF00BFBFBF005A5A5A0036363600363636003636360036363600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FAFAFA00B8B8B800000000000000000000000000D7D7
      D700AEAEAE000000000000000000000000000000000000000000C5C5C500B3B3
      B30000000000000000000000000093939300B0B0B000ACACAC00ABABAB00ABAB
      AB00A9A9A900B1B1B10000000000000000007F7F7F0000000000000000000000
      0000000000009595950031313100000000000000000000000000000000000000
      0000000000008585850041414100000000000000000000000000000000001111
      1100B5B5B500565656000B0B0B00060606000B0B0B002020200065656500C2C2
      C2000000000000000000000000007F7F7F00CCCCCC0099999900999999009199
      8D0060994400D4D4D400ACACAC00999999009999990099999900999999009999
      990099999900CECECE00B3B3B3009999990099999900949494001F231C00345C
      200038602400335D1E0035651E002B5B14001E4D060015400000123302001D38
      100022321A005656560099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF00BFBFBF00ABABAB0094949400949494009494940094949400ABABAB00BFBF
      BF00BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ADADAD00000000000000000000000000EBEB
      EB00CACACA00CECECE00000000000000000000000000B6B6B600C5C5C5000000
      000000000000000000009E9E9E00000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000000000
      00002E2E2E009898980000000000000000000000000000000000000000000000
      0000272727009F9F9F0000000000000000000000000000000000000000000000
      0000BDBDBD000909090000000000000000000000000000000000000000005B5B
      5B008888880000000000000000007F7F7F00CCCCCC0099999900959993007599
      6300ABABAB00D5D5D50099999900999999009999990099999900999999009999
      9900A8A8A800D8D8D80099999900999999009999990099999900989898001B27
      16006CD2390073DA40007FE54B0061C72E0043A90F002F8F0000257000001A3C
      0A006E726C009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF00BFBFBF00ABABAB001072A0001072A0001072A0001072A000ABABAB00BFBF
      BF00BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A9A9A9000000000000000000000000000000
      0000D9D9D900B1B1B1000000000000000000A5A5A500D9D9D900000000000000
      000000000000A3A3A300F1F1F100000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000000000
      0000B8B8B8000E0E0E0000000000000000000000000000000000000000000000
      0000878787004040400000000000000000000000000000000000000000000000
      00005E5E5E006868680000000000000000000000000000000000000000009393
      93003333330000000000000000007F7F7F00CCCCCC0099999900939991006499
      4A00E2E2E2009E9E9E0099999900999999009999990099999900999999009999
      9900CFCFCF00B2B2B20099999900999999009999990099999900999999008284
      82002C471F0068CE350076DC43006CD2390044A912002B8200001A4E01003F44
      3C00ADADAD009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF00BFBFBF001072A00008CDFF0008CDFF0008CDFF0008CDFF001072A000BFBF
      BF00BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ADADAD000000000000000000000000000000
      0000DBDBDB00DEDEDE00CCCCCC00AAAAAA00ECECEC0000000000000000000000
      0000B1B1B100DEDEDE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000006464
      6400626262000000000000000000000000000000000000000000000000000000
      000059595900C7C7C70000000000000000000000000000000000000000000000
      000000000000A2A2A200242424000000000000000000000000002E2E2E009898
      98000000000000000000000000007F7F7F00CCCCCC009999990099999900C1C1
      C100C0C0C0009999990099999900999999009999990099999900999999009999
      9900BCBCBC00E8E8E80099999900999999009999990099999900999999009999
      990061665F00407227006BD1380072D83F0045AA130026740000181E1500D5D5
      D500999999009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF001072A00008CDFF0008CDFF0008CDFF0000C8FD0000C8FD0008CDFF001072
      A000BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B8B8B800F9F9F90000000000000000000000
      0000FDFDFD00D1D1D1008D8D8D0000000000000000000000000000000000C3C3
      C300CACACA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F000000000007070700BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      00003535350037373700AAAAAA00828282000000000000000000000000000000
      00000000000012121200B4B4B400000000000000000000000000A7A7A7001F1F
      1F000000000000000000000000007F7F7F00CCCCCC00999999009C9C9C00E5E5
      E500999999009999990099999900999999009999990099999900999999009999
      9900AEAEAE00AFAFAF00DDDDDD00CDCDCD009999990099999900999999008E8E
      8E0072727200282D2500305F1900448225002B670D000D150900797979009B9B
      9B00999999009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF000000000008CDFF0008CDFF0008CDFF0008CDFF0000C8FD0008CDFF000000
      0000BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C9C9C900E8E8E80000000000000000000000
      0000FBFBFB008D8D8D0000000000000000000000000000000000D7D7D700B7B7
      B700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F0000000000636363006363
      6300000000000000000000000000000000000000000000000000000000000000
      000000000000000000001C1C1C0044444400C4C4C4000C0C0C00000000000000
      00000000000000000000B2B2B200141414000000000000000000B3B3B3001313
      13000000000000000000000000007F7F7F00CCCCCC0099999900C0C0C000C0C0
      C0007799670086997D0099999900999999009999990099999900999999009999
      99009999990099999900A4A4A400B4B4B400E7E7E7009E9E9E00999999007F7F
      7F003842330031621900428123004A882B002E6C0F001A5100001D2B16006060
      6000999999009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000363636005A5A5A00BFBF
      BF000000000008CDFF000000000008CDFF0008CDFF0008CDFF0008CDFF000000
      0000BFBFBF005A5A5A0036363600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D8D8D800D6D6D6000000000000000000F6F6
      F6009E9E9E0000000000000000000000000000000000F1F1F100B5B5B5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F00000000008C8C8C003A3A
      3A00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000025252500A1A1A100000000000000
      000000000000000000009F9F9F00272727000000000000000000A7A7A7001F1F
      1F000000000000000000000000007F7F7F00CCCCCC0099999900D1D1D100B0B0
      B0007B996D008899800099999900999999009999990099999900999999009999
      990099999900999999009999990099999900A8A8A800D9D9D900999999009999
      990099999900283223005BB62C0072D83F0050B21E001A320E00A4A6A400A5A5
      A500999999009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000036363600949494005A5A5A00BFBF
      BF000000000008CDFF00000000000000000008CDFF0008CDFF0008CDFF000000
      0000BFBFBF005A5A5A0094949400363636000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EAEAEA00C8C8C80000000000F6F6F6009E9E
      9E00000000000000000000000000000000000000000087878700D3D3D3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F00000000007E7E7E004848
      4800000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000001010100C5C5C500000000000000
      00000000000002020200C4C4C40000000000000000000000000000000000BCBC
      BC00BABABA00B5B5B500000000007F7F7F00CCCCCC0099999900CBCBCB00B6B6
      B600739961008499790099999900999999009999990099999900999999009999
      99009999990099999900999999009999990099999900E7E7E700999999009999
      9900999999009A9A9A002530200060C52E002F5B19005D615B0099999900E4E4
      E400E3E3E300E1E1E10099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000003636360094949400949494005A5A5A00BFBF
      BF00BFBFBF000000000008CDFF0008CDFF0008CDFF0008CDFF0000000000BFBF
      BF00BFBFBF005A5A5A0094949400949494003636360000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FCFCFC00C5C5C500000000009C9C9C000000
      0000000000000000000000000000F8F8F8008B8B8B00DCDCDC00D8D8D800B1B1
      B100C7C7C7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F00000000001A1A1A00ACAC
      AC00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008A8A8A003C3C3C000000
      0000000000004141410085858500000000000000000000000000000000000000
      00000C0C0C00585858006E6E6E007F7F7F00CCCCCC0099999900A3A3A300DDDD
      DD007F997300889980008E998900999999009999990099999900999999009999
      99009999990099999900999999009999990099999900D0D0D000B1B1B1009999
      990099999900B3B3B300CECECE00293D20007681700099999900999999009999
      99009E9E9E00BCBCBC00C5C5C500CCCCCC000000000000000000000000000000
      00000000000000000000363636003636360036363600363636005A5A5A00BFBF
      BF00BFBFBF00ABABAB0000000000000000000000000000000000ABABAB00BFBF
      BF00BFBFBF005A5A5A0036363600363636003636360036363600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009E9E9E00AEAEAE00000000000000
      00000000000000000000F4F4F4009F9F9F0000000000FDFDFD00DBDBDB00D8D8
      D800C9C9C900AFAFAF00C0C0C000FAFAFA000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000008989
      89003D3D3D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000969696009191
      91005C5C5C007A7A7A0000000000000000000000000000000000000000000000
      0000000000008A8A8A003C3C3C007F7F7F00CCCCCC009999990099999900CFCF
      CF00B1B1B1008999820054993200999999009999990099999900999999009999
      9900999999009999990099999900999999009999990099999900D5D5D500D3D3
      D300BEBEBE00CACACA0099999900999999009999990099999900999999009999
      990099999900D0D0D000B1B1B100CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF00BFBFBF00ABABAB0094949400949494009494940094949400ABABAB00BFBF
      BF00BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FDFDFD008B8B8B0000000000000000000000
      000000000000F4F4F4009E9E9E00000000000000000000000000000000000000
      0000EDEDED00DADADA00C3C3C300A4A4A400B6B6B600F5F5F500000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000000606
      0600BBBBBB003939390015151500000000000000000000000000000000000000
      0000000000003D3D3D0005050500000000000000000000000000000000003535
      35006A6A6A000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600000000007F7F7F00CCCCCC009999990072995F007E9A
      7000E3E3E300B0B0B000A1A1A100999999009999990099999900999999009999
      990099999900B1B1B1009B9B9B0099999900999999009999990099999900AEAE
      AE00C3C3C3009999990099999900999999009999990099999900999999009999
      990099999900E8E8E80099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF00BFBFBF00ABABAB000F0F96000F0F96000F0F96000F0F9600ABABAB00BFBF
      BF00BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F6F6F6009F9F9F000000000000000000000000000000
      0000F4F4F4009C9C9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000E7E7E700C0C0C00095959500A5A5A500EBEB
      EB00000000000000000000000000000000007F7F7F0000000000000000000000
      0000000000008D8D8D00B1B1B100C6C6C600C7C7C700C2C2C200AAAAAA006969
      69003E3E3E008B8B8B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000686868005E5E5E00000000007F7F7F00CCCCCC009999990087997E008C99
      850099999900D1D1D100DFDFDF00E8E8E800E8E8E800E6E6E600DDDDDD00C3C3
      C300B1B1B100D0D0D0008E9989008D9987009999990099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900C2C2C200BEBEBE0099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF00BFBFBF000F0F96000000D5000000D5000000D5000000D5000F0F9600BFBF
      BF00BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F6F6F6009E9E9E0000000000000000000000000000000000F9F9
      F900ABABAB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CECECE008D8D
      8D008D8D8D00DFDFDF0000000000000000007F7F7F0000000000000000000000
      00000000000000000000000000000000000000000000040404001C1C1C005D5D
      5D00F0F0F0002727270000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000F0F
      0F00B7B7B70000000000000000007F7F7F00CCCCCC0099999900999999009999
      99009999990099999900899981005F9942009999990085997B009EA39B00BEBE
      BE00F9F9F900A8A8A8007599640071995D009999990099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009F9F
      9F00E2E2E2009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF000F0F96000000D5000000D5000000D5000000BC000000BC000000D5000F0F
      9600BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F6F6F6009E9E9E0000000000000000000000000000000000F9F9F9008787
      8700A9A9A900B8B8B800BCBCBC00CDCDCD00DDDDDD00EFEFEF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F3F3F3007D7D7D00B8B8B800000000007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006161
      610065656500A5A5A50035353500000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B0B0
      B0001616160000000000000000007F7F7F00CCCCCC0099999900999999009999
      990099999900999999009399910086997C00999999005F9942008B998400C0C0
      C000C1C1C100DBDBDB00AEAEAE00999999009999990099999900999999009999
      990099999900999999009999990099999900999999009999990099999900DFDF
      DF00A2A2A2009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00BFBF
      BF00000000000000D5000000D5000000D5000000D5000000BC000000D5000000
      0000BFBFBF005A5A5A0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F6F6
      F6009E9E9E0000000000000000000000000000000000F4F4F4009F9F9F000000
      00000000000000000000F2F2F200E3E3E300D1D1D100C1C1C100B2B2B200AAAA
      AA00AAAAAA00B0B0B000BCBCBC00CDCDCD00DDDDDD00EFEFEF0000000000FAFA
      FA00B2B2B200DBDBDB0000000000000000007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000101010007777
      7700000000000000000091919100959595000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000797979004D4D
      4D000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      99009999990099999900999999009999990099999900999999009F9F9F00C8C8
      C8009999990099999900D3D3D300D4D4D4009999990099999900999999009999
      9900999999009999990091998E00809974009999990099999900C9C9C900B8B8
      B800999999009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000363636005A5A5A00BFBF
      BF00000000000000D500000000000000D5000000D5000000D5000000D5000000
      0000BFBFBF005A5A5A0036363600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7F7F700A2A2
      A20000000000000000000000000000000000F4F4F4009E9E9E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F2F2F200E3E3E300D1D1D100C1C1C100B3B3B300ADAD
      AD00F8F8F8000000000000000000000000007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000031313100B8B8B8001A1A1A00000000000000
      00000000000000000000000000000000000000000000C7C7C7001D1D1D000000
      00000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990077996700AAABA900E2E2E200A3A3A300999999009999
      9900939990007C996D008999820066994D0099999900E8E8E800A4A4A4009999
      9900999999009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000036363600BFBFBF005A5A5A00BFBF
      BF00000000000000D50000000000000000000000D5000000D5000000D5000000
      0000BFBFBF005A5A5A0094949400363636000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AAAAAA00E1E1
      E100000000000000000000000000F4F4F4009E9E9E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000E0E0E00ACACAC007D7D7D000E0E
      0E0000000000000000000000000011111100BCBCBC00060606000C0C0C000000
      00000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      990099999900999999005D993F00969995009E9E9E00DDDDDD00CBCBCB009E9E
      9E008E99890065994B0099999900A0A0A000E4E4E4009B9B9B009E9E9E009999
      9900999999009999990099999900CCCCCC000000000000000000000000000000
      000000000000000000000000000036363600BFBFBF00BFBFBF005A5A5A00BFBF
      BF00BFBFBF00000000000000D5000000D5000000D5000000D50000000000BFBF
      BF00BFBFBF005A5A5A0094949400949494003636360000000000000000000000
      0000000000000000000000000000000000000000000000000000B8B8B800D3D3
      D3000000000000000000F5F5F5009E9E9E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000049494900B8B8
      B800B1B1B100A5A5A500C5C5C500B5B5B5000A0A0A0000000000000000000000
      00000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990099999900999999009999990099999900B6B6B600E2E2
      E200DFDFDF00DBDBDB00E7E7E700E1E1E1009D9D9D0050992C00899981009999
      9900999999009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000363636003636360036363600363636005A5A5A00BFBF
      BF00BFBFBF00BFBFBF0000000000000000000000000000000000BFBFBF00BFBF
      BF00BFBFBF005A5A5A0036363600363636003636360036363600000000000000
      0000000000000000000000000000000000000000000000000000B1B1B100DFDF
      DF00CECECE00D4D4D400A3A3A300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000151515002222220002020200000000000000000000000000000000000000
      00000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      99009999990099999900999999009999990099999900999999008F998B004699
      1D00A1A1A100A6A6A6009A9A9A00999999009999990092998E00979996009999
      9900999999009999990099999900CCCCCC000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A005A5A
      5A00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF005A5A5A005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BBBBBB00B7B7
      B700B9B9B900B3B3B30000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F00CCCCCC0099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990099999900999999009999990099999900989997009499
      9200999999009999990099999900999999009999990099999900999999009999
      9900999999009999990099999900CCCCCC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A
      5A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BEBEBE007E7E7E007E7E7E007E7E
      7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E
      7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E
      7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E
      7E007E7E7E007E7E7E007E7E7E00BEBEBE00E5E5E500CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00E5E5E5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFFFF00F5FFFF00E5FF
      FF00D2FFFF00BEFFFF00ABFFFF009AFFFF008AFFFF007AFFFF006DFFFF0061FF
      FF0057FFFF004EFFFF0049FFFF0047FFFF0047FFFF0049FFFF004EFFFF0057FF
      FF0061FFFF006DFFFF007AFFFF008AFFFF009AFFFF00ABFFFF00BEFFFF00D2FF
      FF00E5FFFF00F5FFFF00FEFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F3F3F300FAFAFA00FAFAFA00FAFAFA000000
      0000000000000000000000000000000000000000000000000000FAFAFA00FAFA
      FA00FAFAFA00F5F5F50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7FFFF00E0FFFF00CAFF
      FF00B6FFFF00A1FFFF008DFFFF007AFFFF0069FFFF0059FFFF0049FFFF003DFF
      FF0032FFFF0029FFFF0023FFFF0021FFFF0021FFFF0023FFFF0029FFFF0032FF
      FF003DFFFF0049FFFF0059FFFF0069FFFF007AFFFF008DFFFF00A1FFFF00B6FF
      FF00CAFFFF00E0FFFF00F7FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002C2F32001A2128001C232A00A9A9A9000000
      00000000000000000000000000000000000000000000F8F8F8002A2D31001E24
      2B001A2128004043460000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002A2C2D009B9B
      9B00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFFFF00EAFFFF00D3FFFF00BCFF
      FF00A6FFFF0091FFFF007CFFFF0068FFFF0056FFFF0044FFFF0033FFFF0027FF
      FF001AFFFF0011FFFF000BFFFF000CFAFA000CFAFA000BFFFF0011FFFF001AFF
      FF0027FFFF0033FFFF0044FFFF0056FFFF0068FFFF007CFFFF0091FFFF00A6FF
      FF00BCFFFF00D3FFFF00EAFFFF00FEFFFF000000000000800000008000000080
      0000008000000080000000800000008000000080000000800000008000000080
      0000008000000080000000800000008000000080000000800000008000000080
      0000008000000080000000800000008000000080000000800000008000000080
      0000008000000080000000000000000000000000000000000000000000000000
      000000000000000000000000000023282E000032650007223D00A9A9A9000000
      00000000000000000000000000000000000000000000F8F8F800212930001A4D
      8000002E5C00343A3F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003D4C51000A1A1F003636
      3600FBFBFB000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAFFFF00DDFFFF00C7FFFF00B0FF
      FF0098FFFF0083FFFF006DFFFF0058FFFF0043FFFF0030FFFF001FFFFF0015F8
      F80042C0C200659DA0006C979B006C9AA0006D999F006C979B00649DA00041C0
      C20015F8F8001FFFFF0030FFFF0043FFFF0058FFFF006DFFFF0083FFFF0098FF
      FF00B0FFFF00C7FFFF00DDFFFF00FAFFFF000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      000000000000000000000000000023282E000032650007223D00A9A9A9000000
      00000000000000000000000000000000000000000000F8F8F800212930001A4D
      8000002E5C00343A3F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000314146000265840029383C005151
      5100E5E5E5000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3FFFF00D3FFFF00BBFFFF00A4FF
      FF008CFFFF0075FFFF005FFFFF0048FFFF0033FFFF001FFFFF0055AFB2006F99
      A10072BAD70074D1F90079D6FF0079D6FF0079D6FF0074D5FF0070D0F9006DB8
      D7006E98A1003FC9CD001FFFFF0033FFFF0048FFFF005FFFFF0075FFFF008CFF
      FF00A4FFFF00BBFFFF00D3FFFF00F3FFFF000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      00000000000000800000000000000000000000000000F4F4F400E5E5E500E5E5
      E500E5E5E500E5E5E500E5E5E5001F232900002C5A00061E360097979700E5E5
      E500E5E5E500E5E5E500D3D3D300E5E5E50000000000F8F8F800212930001A4D
      8000002E5C00343A3F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FEFEFE00223237000191BC00006686004E5456006D6D
      6D00C9C9C9000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EEFFFF00CCFFFF00B3FFFF009AFF
      FF0081FFFF0069FFFF0053FFFF003BFFFF0026FBFB0054B5BC0069C3E80071D4
      FF0079D6FF0083D9FF008FDDFF008FDDFF008FDDFF0083D9FF0079D6FF0071D4
      FF0069D1FF0069B0CD0053B5BC0026FBFB003BFFFF0053FFFF0069FFFF0081FF
      FF009AFFFF00B3FFFF00CCFFFF00EEFFFF000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      00000000000000800000000000000000000000000000FAFAFA0030352E003349
      2800334A2800344B290032482700182F0E00112D10000E2708001C3110002438
      190024361900243319002E382500B1B1B10000000000F8F8F800212930001A4D
      8000002E5C00343A3F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F1F2F2001B2D32000099C800009CCC0003567000767676008989
      8900ADADAD000000000000000000EBEBEB000000000000000000000000000000
      000000000000000000000000000000000000E7FFFF00C4FFFF00ABFFFF0092FF
      FF0079FFFF0060FFFF0047FFFF002FFFFF005AAEB10067C3E90070D4FF0079D6
      FF008BDBFF009FE2FF00ABE5FF00AFE6FF00ABE5FF009FE2FF008BDBFF0079D6
      FF0070D4FF0066D0FF005FC2E9005FA7AA002FFFFF0047FFFF0060FFFF0079FF
      FF0092FFFF00ABFFFF00C4FFFF00E7FFFF000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000E1E1E100334B
      270074DA41007BE2480074DA410065CB320052B81E003DA40A00339400003389
      0000337D00002A5B0300595D5400EEEEEE00EEEEEE00E7E7E7001E262C001847
      7700002A550030363A00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EDEDED00F8F8F8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DDE0E1001A353C00009DCC00009BCC00009ACC0007455A0095959500A3A3
      A300939393000000000000000000CACACA0059595900EBEBEB00000000000000
      000000000000000000000000000000000000E2FFFF00BFFFFF00A5FFFF008AFF
      FF0072FFFF0058FFFF003FFFFF0033EDED006AA0AC006AD2FF0074D5FF0083D9
      FF009FE2FF00B7E8FF00CBEEFF00CFF0FF00CBEEFF00B7E8FF009FE2FF0083D9
      FF0074D5FF006AD2FF005FCEFF0062A8B7003AE2E2003FFFFF0058FFFF0072FF
      FF008AFFFF00A5FFFF00BFFFFF00E3FFFF000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      000000000000008000000000000000000000000000000000000000000000979D
      95004B82300077DD440079DF46006AD0370054BB21003DA40A00339300003386
      0000327600000B130400304327002F4125002C3F23002A3D2000112409000D25
      0F00091F09000E1F060023321A0023301A00232F1A00232E1A00232C1A00232D
      1A00232D1A00232E1A0030322E00FEFEFE000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C5CA
      CC001A3F4900009CCC00009BCC00009ACC00009BCD0007394900B1B1B100BABA
      BA007C7C7C00000000000000000000000000D6D6D6006A6A6A00000000000000
      000000000000000000000000000000000000E0FFFF00BBFFFF00A1FFFF0086FF
      FF006DFFFF0053FFFF0039FFFF004CC3C50069B6D5006DD3FF0079D6FF0084D4
      FF0094D4FF00CBEEFF00E3F6FF0091C0FF008ABDFF00CBEEFF00ABE5FF007BCC
      FF0070CEFF006DD3FF0062CFFF0064B0CE0046CACB0039FFFF0053FFFF006DFF
      FF0086FFFF00A1FFFF00BBFFFF00E0FFFF000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      00004E5749005FB7340078DE450073D9400058BE25003DA30A0033900000337D
      00001730050065BE38007CE2490076DC420068CF35005DC42A004EB51B003DA4
      0A0033950000338B00003380000033760000337100003367000033690000336B
      0000336E000021291A00FBFBFB00000000000000000000000000000000000000
      0000C4C4C400C9C9C900C9C9C900C9C9C900C9C9C900B6B6B600949C9E001548
      5600009CCC00009ACC00009ACC00009CCE0000A1D20006313D00CACACA00C8C8
      C8006E6E6E00E1E1E100000000000000000000000000E0E0E000565656000000
      000000000000000000000000000000000000DDFFFF00B9FFFF009EFFFF0084FF
      FF006AFFFF0051FFFF0037FFFF005BAEB10067C0E8006DD3FF0079D6FF008FDD
      FF002984FF00CAEDFF00EFFAFF003C8AFF003889FF00CFF0FF00ABE3FF002282
      FF0079D6FF006DD3FF0062CFFF005EBBE40057B2B60037FFFF0051FFFF006AFF
      FF0084FFFF009EFFFF00B9FFFF00DDFFFF00000000000080000000FF000000FF
      000000FF000000FF000000FF000000FF00000080000000FF000000FF000000FF
      000000FF000000FF000000FF00000080000000FF000000FF000000FF000000FF
      000000FF000000FF00000080000000FF000000FF000000FF000000FF000000FF
      000000FF00000080000000000000000000000000000000000000E4E4E400C1C1
      C100BFBFBF001D27190055A22E005AA83400479521002E7B0700266A00001736
      00002E5B160055A22E005AA733007AE047006FD53C0061C72E0051B71E003EA4
      0B003393000033870000337A0000337200003368000033680000336B0000336E
      000025331900E0E1DF0000000000000000000000000000000000000000000000
      00001B2F3400144E5B00144E5B00144E5B00144E5B00134B5700011C2400009C
      CC00009ACC00009BCD00009FD00000A7D50000ACD900052B3300DEDEDE00D4D4
      D40062626200BFBFBF007E7E7E00000000000000000000000000C3C3C3007373
      730000000000000000000000000000000000DDFFFF00B7FFFF009DFFFF0084FF
      FF006AFFFF0050FFFF0035FFFF005CACB00066C1EA006DD3FF0079D6FF008FDD
      FF007EC4FF0060A6FF0088BCFF0093C1FF008CBEFF007AB7FF0051A2FF006ABE
      FF0079D6FF006DD3FF0062CFFF005CBFE9005BADB00035FFFF0050FFFF006AFF
      FF0084FFFF009DFFFF00B7FFFF00DDFFFF000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000F5F5F5003035
      2D003B6327003A622600345E1E0035651E002B5B14001E4D0600174200001636
      01001939030021430A00437F25007AE0470076DC430063C9300053B920003EA4
      0B00339100003384000033750000336D000033670000336B0000336E00002941
      1600B9BBB700000000000000000000000000000000000000000000000000BEBE
      BE0011506400009CCC00009CCC00009CCC00009CCC00004B620000648200009A
      CC00009CCE0000A4D30000ADD90000B2DC0000B6E00005262D00ECECEC00DDDD
      DD0059595900F2F2F200E2E2E2003B3B3B000000000000000000000000003939
      3900FDFDFD00000000000000000000000000DFFFFF00BBFFFF00A0FFFF0086FF
      FF006CFFFF0052FFFF0038FFFF0052BBBB0066BADE006AD2FF0074D5FF0083D9
      FF009FE2FF003D91FF003187FF00CFF0FF00CBEEFF002D85FF00358FFF0083D9
      FF0074D5FF006AD2FF005FCEFF005DBAE10054B8B80038FFFF0052FFFF006CFF
      FF0086FFFF00A0FFFF00BBFFFF00E0FFFF000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      000000000000008000000000000000000000000000000000000000000000FDFD
      FD00263320006CD2390073DA40007FE54B0061C72E0043A90F0033930000337E
      00002041040034651A006ED43B0076DC430079DF46006AD0370055BB22003EA4
      0B0033900000337E00003373000033670000336A0000336E00002B4C10008F93
      8B0000000000000000000000000000000000000000000000000000000000A2A2
      A20008627D0000A5D40000A5D40000A5D40000A5D400003B4C000074990000A2
      D20000ACD90000B2DC0000B9E10000BFE50000C4E80000202600D1D1D100E5E5
      E5005151510000000000000000007D7D7D00B9B9B90000000000000000009B9B
      9B009B9B9B00000000000000000000000000E1FFFF00BDFFFF00A2FFFF0089FF
      FF0070FFFF0056FFFF003DFFFF003ADEDE0068A8BC0066D0FF0070D4FF0079D6
      FF008BDBFF0063A5E6005495E300AFE6FF00ABE5FF004F93E3005AA2E60079D6
      FF0070D4FF0066D0FF005CCEFF0063A6BC003ADEDE003DFFFF0056FFFF0070FF
      FF0089FFFF00A2FFFF00BDFFFF00E2FFFF000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000D6D7D5003451260068CE350076DC43006CD2390045AA1200338A00002D5F
      040052574D00323D2D0064C6330070D63D0079DF460070D63D0059BF26003EA4
      0B00338D0000337A0000336C000033680000336D00002C580800656A60000000
      0000000000000000000000000000000000000000000000000000000000008D8E
      8E00017A950000B8E10000B8E10000B8E10000B8E10000333F00008BB20000B3
      DE0000BCE30000C3E80000C8EB0000CBED0000CEF000022025003C3C3C00D4D4
      D4004C4C4C000000000000000000F5F5F500414141000000000000000000EDED
      ED0049494900000000000000000000000000E5FFFF00C1FFFF00A9FFFF008FFF
      FF0076FFFF005EFFFF0045FFFF002EF9F9006A9AA00060CFFF0069D1FF0071D4
      FF0079D6FF0082D1F400839BA5008FDDFF008FDDFF00809AA50079CEF40071D4
      FF0069D1FF0060CFFF0058C7F700679CA2002BFFFF0045FFFF005EFFFF0076FF
      FF008FFFFF00A9FFFF00C1FFFF00E5FFFF000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000000000009BA0980044782A006BD1380072D83F0046AB1300327F0000272D
      220000000000FDFDFD00263320006AD0370073D9400078DE45005CC229003FA4
      0C00338A00003374000033670000336D00002E64020041483C00000000000000
      0000000000000000000000000000000000000000000000000000000000008185
      8600008BA30000CAED0000CAED0000CAED0000CAED000030390000A8C90000C8
      EC0000CEEF0000D1F10000D3F30000D7F50000DAF700031F23005D5D5D008787
      87004B4B4B0000000000000000000000000061616100D5D5D500000000000000
      000040404000F6F6F6000000000000000000EAFFFF00C8FFFF00B0FFFF0097FF
      FF007EFFFF0066FFFF004EFFFF0036FFFF0042D0D10063B0C90062CFFF0069D1
      FF0070D4FF0074D5FF007D929C0079D5FE0079D5FE007C929C0070D4FF0069D1
      FF0062CFFF0059CDFF00699FB10030E7E80036FFFF004EFFFF0066FFFF007EFF
      FF0097FFFF00B0FFFF00C8FFFF00EBFFFF000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000EBEBEB00BEBEBE00393F370031611900448225002C680D0011190B005455
      5300848682008B8D89007C7F7B001B2A14003B751F00417B250038711B00235C
      06001C4A00001C3C00001C3C00001B3E0000151B1100898B8700898A8700898A
      8700AFB0AE00F6F6F6000000000000000000000000000000000000000000747E
      7F00009EB20000DCF90000DCF90000DCF90000DCF90000343B0000C1DB0001DE
      FA0003E0FB0004E2FD0006E5FE0008E5FF000AE5FF00041E2100919191003737
      37004848480000000000000000000000000091919100A5A5A500000000000000
      000056565600E0E0E0000000000000000000F2FFFF00D1FFFF00B8FFFF00A0FF
      FF0088FFFF0071FFFF005AFFFF0042FFFF002DFFFF005EAAAF005EC1EB0060CF
      FF0066D0FF006AD2FF00789DAD006FC7ED006FC7ED00779CAD0066D0FF0060CF
      FF0059CDFF005DB7DD0053B6BC002DFFFF0043FFFF005AFFFF0071FFFF0088FF
      FF00A0FFFF00B8FFFF00D1FFFF00F2FFFF000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000D2D2D2005660510032651A00428123004A882B002E6C0F001F550000101F
      0500274D1300478B26004D902B004F932E0050942E004B8F2A003F831D003679
      1400286C0700216300002159000021530000214C000021460000214300001D36
      070071766C00DBDBDB000000000000000000000000000000000000000000767F
      7F0019A6B70024E8FF0024E8FF0024E8FF0024E8FF0009383E0026CDE1002CE9
      FF002CE9FF002CE9FF002CE9FF002CE9FF002CE9FF00081E2100919191003737
      37004949490000000000000000000000000090909000A6A6A600000000000000
      000055555500E1E1E1000000000000000000F7FFFF00DAFFFF00C2FFFF00ACFF
      FF0094FFFF007EFFFF0067FFFF0053FFFF003EFFFF002BFDFD006E959D0056CC
      FF005CCEFF005FCEFF006FA8C100749AAB00749AAA006EA8C2005CCEFF0056CC
      FF0051CAFF006E949B002AFEFE003EFFFF0053FFFF0067FFFF007EFFFF0094FF
      FF00ACFFFF00C2FFFF00DAFFFF00F7FFFF000000000000800000008000000080
      0000008000000080000000800000008000000080000000800000008000000080
      000000800000008000000080000000FF00000080000000800000008000000080
      0000008000000080000000800000008000000080000000800000008000000080
      0000008000000080000000000000000000000000000000000000000000000000
      000000000000000000003A4535005CBA2D0072D83F0051B41E0028401800C4C6
      C3002A35250069CE37006FD53B0076DC43007CE2480076DD430065CB320054BA
      21003DA30A003394000033860000337C000033700000336600002E580600545A
      4F00000000000000000000000000000000000000000000000000000000008285
      850041A5B1005EEEFF005EEEFF005EEEFF005EEEFF001A3D41005FCFDC0063EE
      FF005DEEFF0058EDFF0052EDFF0050ECFF004EECFF000C212400656565007C7C
      7C004A4A4A0000000000000000000000000075757500C1C1C100000000000000
      000045454500F1F1F1000000000000000000FDFFFF00E6FFFF00CFFFFF00B8FF
      FF00A1FFFF008BFFFF0077FFFF0063FFFF004FFFFF003CFFFF0041DCE00066A1
      BA0051CAFF0055CBFF0064B0D0006E9EB40075909D006D9DB30051CAFF004CC8
      FF0064A0B90041DCE0003CFFFF004FFFFF0063FFFF0077FFFF008BFFFF00A1FF
      FF00B8FFFF00CFFFFF00E6FFFF00FDFFFF000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      00000000000000000000000000002732210061C62E0039642100A0A49D000000
      0000FAFAFA002836210068CE35006DD33A0076DC43007AE047006DD33A0057BD
      24003FA40C00339000003381000033730000336700002F6002003C4237000000
      0000000000000000000000000000000000000000000000000000000000009393
      9300629CA30099F4FF0099F4FF0099F4FF0099F4FF002D44470095CDD500A3F5
      FF0092F3FF0085F2FF007CF1FF0070EFFF006BEFFF001124260043434300C6C6
      C6004D4D4D000000000000000000F6F6F600404040000000000000000000FAFA
      FA003C3C3C0000000000000000000000000000000000F2FFFF00DBFFFF00C5FF
      FF00B0FFFF009BFFFF0087FFFF0074FFFF0062FFFF0051FFFF0043FAFA006E95
      A00046C7FF0049C8FF005DADD10060A9C90060A9C9005CADD10046C7FF0042C6
      FF00659EAE004AECEC0051FFFF0062FFFF0074FFFF0087FFFF009BFFFF00B0FF
      FF00C5FFFF00DBFFFF00F2FFFF00000000000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000394C2F00C5D0BE00000000000000
      000000000000E8E9E8002F43240069CF360070D63D0079DF460074DA410059BF
      26003FA50C00338E0000337C0000336B0000316400002A302500000000000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C0085989A00DAFBFF00DAFBFF00DAFBFF00DAFBFF004F5B5C00AEBDBF00D3F9
      FF00BEF7FF00AFF6FF00A5F5FF009DF4FF0091F3FF0015272800F3F3F300E5E5
      E500515151000000000000000000AFAFAF00878787000000000000000000C2C2
      C2007474740000000000000000000000000000000000FCFFFF00E9FFFF00D4FF
      FF00C0FFFF00ACFFFF0098FFFF0087FFFF0076FFFF0066FFFF0058FFFF006F97
      9E003BC1FB003DC4FF0056ABD1005AA7C9005AA7C90054ABD1003AC3FF0039BE
      F8006D99A10058FFFF0066FFFF0076FFFF0087FFFF0098FFFF00ACFFFF00C0FF
      FF00D4FFFF00E9FFFF00FCFFFF00000000000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D0D3D000365428006AD0370073D9400079DF46005FC5
      2C0040A50D00338A0000337500003367000020271A0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C00062747600CCFAFF00CCFAFF00CCFAFF00CCFAFF00667D8000809CA000EFFD
      FF00E9FCFF00D7FAFF00C3F8FF00B8F7FF00AEF6FF00212F3100ECECEC00DFDF
      DF005757570000000000ABABAB003A3A3A000000000000000000000000006767
      6700CFCFCF000000000000000000000000000000000000000000F9FFFF00E5FF
      FF00D1FFFF00BDFFFF00ACFFFF009BFFFF008AFFFF007CFFFF006FFFFF006CB1
      B80041B1E10032C1FF004EA9D10053A5C90053A5C9004DA9D1002FC0FF0041AE
      DE006AB4BC006FFFFF007CFFFF008AFFFF009BFFFF00ACFFFF00BDFFFF00D1FF
      FF00E5FFFF00F9FFFF0000000000000000000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B4B9B2003F682B006AD0370078DE450067CD
      340040A50D0033850000336A0000232C1A00F1F1F00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001B373A0014636C0014636C0014636C0014636C00135F68001E323400BAF8
      FF00E2FCFF00F0FDFF00EAFCFF00D7FAFF00C8F8FF002A373800E0E0E000D6D6
      D6005F5F5F00C8C8C8008B8B8B00000000000000000000000000ADADAD008989
      890000000000000000000000000000000000000000000000000000000000F5FF
      FF00E1FFFF00D0FFFF00C0FFFF00B0FFFF00A0FFFF0092FFFF0086FFFF0079CF
      D0004BA4C90026BDFF0047A7D1004CA3C9004CA3C90045A6D10025BDFF004BA1
      C6007AD2D30086FFFF0092FFFF00A0FFFF00B0FFFF00C0FFFF00D0FFFF00E1FF
      FF00F5FFFF000000000000000000000000000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AAAAAA004E544A005A625500394434001F381200295214002850
      13001840040014310000101A0700474D420054584F0065686100E5E5E5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C5C5C500CACACA00CACACA00CACACA00CACACA00CACACA009CA2A3004565
      6800B0F7FF00D3FBFF00EEFDFF00F0FDFF00EAFCFF0039444500CCCCCC00C7C7
      C7006F6F6F00E1E1E100000000000000000000000000C7C7C7006F6F6F000000
      000000000000000000000000000000000000000000000000000000000000FEFF
      FF00F5FFFF00E4FFFF00D4FFFF00C4FFFF00B6FFFF00AAFFFF009DFFFF008FE6
      E600619EB3001BBAFF003FA4D10045A1C90045A1C9003EA4D10019B9FF00629C
      B00090E9E9009DFFFF00AAFFFF00B6FFFF00C4FFFF00D4FFFF00E4FFFF00F5FF
      FF00FEFFFF000000000000000000000000000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CECECE00404B3B0056A2300065BA3B005CB03200499D1F003488
      0A002976000029690000295E00002953000024410900797E7500E4E4E4000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C9CD
      CD003B535500AAF7FF00C4F9FF00E8FDFF00EFFDFF0054575800B1B1B100BEBE
      BE0078787800000000000000000000000000E9E9E9005E5E5E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F8FFFF00E8FFFF00DAFFFF00CDFFFF00C1FFFF00B5FFFF00ABFB
      FB0057767A00495B6200527A8A004E7D91004E7E930051778700475155005579
      7F00ADFFFF00B5FFFF00C1FFFF00CDFFFF00DAFFFF00E8FFFF00F8FFFF000000
      000000000000000000000000000000000000000000000080000000FF000000FF
      000000FF000000FF000000FF000000FF00000080000000FF000000FF000000FF
      000000FF000000FF000000FF00000080000000FF000000FF000000FF000000FF
      000000FF000000FF00000080000000FF000000FF000000FF000000FF000000FF
      000000FF00000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002A35250075DB42007AE046005EC42A0040A6
      0D00338E0000337B0000336900002D59050054594E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DFE1E10032434400A4F6FF00BBF9FF00D9FBFF006065660097979700A4A4
      A400929292000000000000000000CACACA004D4D4D0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FCFFFF00F0FFFF00E4FFFF00D8FFFF00CDFFFF00C5FF
      FF00505B5B009191910097979700787878006869690063646400424242004A53
      5300C5FFFF00CDFFFF00D8FFFF00E4FFFF00F0FFFF00FCFFFF00000000000000
      0000000000000000000000000000000000000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F4F4F4002B3B230078DE450068CE350040A6
      0D0033860000336C00003064000033392E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F2F2F2002B3738009AF0FA00BAF8FF006D7D7E00787878008787
      8700AFAFAF000000000000000000EBEBEB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FEFFFF00F9FFFF00EFFFFF00E6FFFF00DFFF
      FF00555B5B00BFBFBF00F8F8F800D7D7D700B3B3B300929292004A4A4A005056
      5600DFFFFF00E6FFFF00EFFFFF00F9FFFF00FEFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D5D7D4003753290071D73E0042A6
      0F00337D00003369000021281C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FEFEFE00303B3C008DE2EB00749B9F00565757007777
      7700BEBEBE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FCFFFF00F7FF
      FF00585B5B00BFBFBF00F8F8F800D7D7D700B3B3B300929292004A4A4A005456
      5600F7FFFF00FCFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B0B4AE00456F2F0046A8
      130033720000232E1A00EEEEED00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F4A4B00689EA400393F3F004848
      4800EEEEEE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005B5B5B00BFBFBF00F8F8F800D7D7D700B3B3B300929292004A4A4A005656
      5600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000878E84003C6F
      1E00283C1800CBCCC90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004C5557001D2728003434
      3400FEFEFE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005C5C5C00BFBFBF00F8F8F800D7D7D700B3B3B300929292004A4A4A005858
      5800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006A72
      6500B0B4AD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002D2E2E009B9B
      9B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BEBEBE00575757007A7A7A008D8D8D00737373005454540047474700BEBE
      BE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000800000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FAFAFA00DEDE
      DE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E7E7E700FBFBFB00666666004F4F4F004444440066666600FBFBFB00E7E7
      E700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000800000008000000080
      0000008000000080000000800000008000000080000000800000008000000080
      0000008000000080000000800000008000000080000000800000008000000080
      0000008000000080000000800000008000000080000000800000008000000080
      0000008000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FEFEFE00FEFEFE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000010100151415001615
      15002A271600413B2C00413B3F002C282A0015141500413C3F00554E5500554E
      5500554E5500554E4100413B2C002A271600000000000000000015141500413B
      2C00553C4100413B2C00413B2C00161515000001010000000000000000000101
      0100161515003F3B2C00554E410016272A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFDFD00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FAFAFA00FAFAFA00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FDFDFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001615160095766A00BE8B9400BE8B
      9400C09D9400C09D9500C09E950094636A00413B2C00C09D9400D5B2AA00D3B1
      AA00D3B1AA00C09D9500A9766B00563C3F0016141500161415007F505500C09D
      9500BE8B8000AA776B00563C3F002A1515001614150016141500161415001615
      1500161415002C272A0094766A00554E55000000000000408000808080000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000808080000040800000000000FDFDFD00282B2E001A2026001A20
      26001A2026001A2026001A2026001A2026001A2026001A2026001A2026001A20
      26001A2026001A2026001A20260010171D001A2222002C3838002C3838002C38
      38002C3838002C3838002C3838002C3838002C3838002C3838002C3838002C38
      38002C3838002C38380032383800FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FAFAFA00FCFCFC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000100002C272A006B505500D3B2
      BE00FED9E900EAD8D500D5C4BE0094636A00553B2C00C09E9500D5B2BE00D3B1
      AA00D3B1AA00C09D9400A9766A0041282A00161415002C272A0095766A00C09E
      A900A9776B007F5055002A151500161415001614150016151500413B2C002C27
      2A00161415001614150016151500161415000000000000408000808080000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000808080000040800000000000FEFEFE001A202600003366000033
      6600003366000033660000336600003366000033660000336600003366000033
      6600003366000033660000336600001F3E00385E5E0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF002C383800FEFEFE000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CACA
      CA0069696E003A3A4800222230001E1E30001D1D2F0021212E00343441007171
      7600C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000016141500161415002C27
      2A006B505500EAD8D500FEEBEA0094636A00563C3F00D39EA900D5B2BE00D5B2
      BE00D5B2BE00BE8B940095636A0041282A00161415003F272A00BE8B8000C09D
      950095766A0041282C00161415001614150016141500553B2C007F5055002A27
      1600161415001614150016141500000000000000000080808000808080000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000808080000040800000000000FEFEFE001A202600003366000033
      6600003366000033660000336600003366000033660000336600003366000033
      6600003366000033660000336600001F3E00385E5E0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF002C383800FEFEFE000000000000000000000000000000
      00000000000000000000000000000000000000000000D2D2D400313141001C1C
      4C0003037700000088000000970000009900000099000000990000008D000303
      73001F1F530023232F00BFBFC100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000016141500161415001614
      150016151500563C3F00EAD9E90080636A00563C3F00D3B1AA00D5C4BE00D5C4
      BE00D5B2AA00BE8B800094636A0041282A00161415002C272A00C09EA900C09D
      950095636A003F272A001614150016141500161415007F505500A9766B004128
      2C00161415001614150016141500000000000000000000408000808080000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000808080000040800000000000FEFEFE001A202600003366000033
      6600003366000033660000336600003366000033660000336600003366000033
      6600003366000033660000336600001F3E00385E5E0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF002C383800FEFEFE000000000000000000000000000000
      000000000000000000000000000000000000393945001212420000008C000000
      9900000099000000990000009900000099000000990000009900000099000000
      9900000099000000990015154F002A2A33000000000000000000000000000000
      0000000000000000000000000000000000000000000016141500161415001614
      150016141500161515007F6256006B505500413B2C00D3B1AA00D5C4BE00D5C4
      BE00D5B2BE00C09D9400A9766A0041282C00161415003F272A00D39EA900C09E
      950095766A0041282A001614150016141500161515007F505500D3B1AA009463
      6A006B504100413B2C002A151600000000000000000000408000808080000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000808080000040800000000000FEFEFE001A202600003366000033
      6600003366000033660000336600003366000033660000336600003366000033
      6600003366000033660000336600001F3E00385E5E0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF002C383800FEFEFE000000000000000000000000000000
      00000000000000000000FEFEFF0027273D0001018C0000009900000099000000
      9900000099000000990000009900000099000000990000009900000099000000
      9900000099000000990000009900010198001D1D2D00FEFEFF00000000000000
      0000000000000000000000000000000000000000000016141500161415001614
      15001614150016141500161515002A15160041282A00D3B1AA00E9C5D300D5C4
      BE00D5C4BE00C09E9500AA776B00553B2C00161415003F272A00C09E9500D5B2
      BE00A9766B0041282C001614150016141500161415002A271600BE9EA900D5C4
      BE00BE8B8000AA776B0080625600011401000000000000408000808080000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000808080008080800000000000FEFEFE001A202600003366000033
      6600003366000033660000336600003366000033660000336600003366000033
      6600003366000033660000336600001F3E00385E5E0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF002C383800FEFEFE000000000000000000000000000000
      000000000000A6A6A7002323450000008D0004049A0006069B0009099C000909
      9C0009099C0006069B0004049A00000099000000990000009900000099000000
      9900000099000000990000009900000099000000990015152A00D0D0D1000000
      0000000000000000000000000000000000000000000016141500161415001614
      15001614150016141500161415001614150041282A00C09D9500EAD8D500D5C4
      BE00D5C4BE00D3B1AA00AA897F007F5055001614150016151500A9897F00EAD8
      D500AA897F007F5055002A1515001614150016141500161415002A2716008063
      6A00E9C5D300C09D9400AA776B002A2716000000000080808000808080000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000808080008080800000000000FEFEFE001A202600003366000033
      6600003366000033660000336600003366000033660000336600003366000033
      6600003366000033660000336600001F3E00385E5E0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF002C383800FEFEFE000000000000000000000000000000
      0000E9E9E90029293F0007077D000F0F9F001717A2001919A3001C1CA4001C1C
      A4001C1CA4001919A3001717A2000F0F9F0009099C0002029900000099000000
      9900000099000000990000009900000099000000990000008B0028283F000000
      0000000000000000000000000000000000000000000016141500161415001614
      150016141500161415002A271600413B2C002A151500A9897F00EAD9E900E9C5
      D300D5C4BE00D5B2BE00C09D9400A9766A00413B2C00161415006A4E4100FEEB
      EA00D39EA900A9766A00553B2C00161515001614150016141500161415001615
      15007F505500D39EA900AA776B0041282A000000000000408000808080000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000808080008080800000000000FEFEFE001A202600003366000033
      6600003366000033660000336600003366000033660000336600003366000033
      6600003366000033660000336600001F3E00385E5E0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF002C383800FEFEFE000000000000000000000000000000
      00003C3C4900111190001C1CA4002323A7002828A9002D2DAB003030AC003030
      AC003030AC002D2DAB002828A9002323A7001C1CA4001212A00009099C000000
      990000009900000099000000990000009900000099000000990001016B006161
      7600000000000000000000000000000000000000000016141500161415001614
      150016141500161415006B4E410094636A003F272A006B504100EAD9E900E9C5
      D300E9C5D300D5C4C000D3B1A900AA777F007F5055002A1515002A151500BE9D
      9400FEEBEA00BE8B9400A9766A00563C3F001614150016141500161415002A15
      150080625600C09D9400A9766B002C282A000000000000408000808080000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000808080000040800000000000FEFEFE001A202600003366000033
      6600003366000033660000336600003366000033660000336600003366000033
      6600003366000033660000336600001F3E00385E5E0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF002C383800FEFEFE00000000000000000000000000B7B7
      B800212159002323A7002D2DAB003535AE003C3CB1004141B3004444B4004444
      B4004444B4004141B3003C3CB1003535AE002D2DAB002323A7001919A3000D0D
      9E00020299000000990000009900000099000000990000009900000099001111
      4100D4D4D6000000000000000000000000000000000016141500161415001614
      150016141500413B2C00AA776B00C09E95006A3C3F0041282A00D5C4BE00EAD9
      E900E9C5D300D5C4C000D5B2BE00C09D9500A9766A00553B2C00161515004128
      2C00D5C4BE00FED9E900C09D9400AA776B0080625600563C3F006A4E41009463
      6A00BE8B8000AA897F00A9766B00161515000000000000408000808080000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000808080000040800000000000FEFEFE001A202600003366000033
      6600003366000033660000336600003366000033660000336600003366000033
      6600003366000033660000336600001F3E00385E5E0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF002C383800FEFEFE000000000000000000000000002F2F
      3C0025259F003535AE003F3FB2004949B6005050B9005555BB005757BC005757
      BC005757BC005555BB005050B9004949B6003F3FB2003535AE002828A9001C1C
      A4000F0F9F000202990000009900000099000000990000009900000099000000
      8B00313142000000000000000000000000000000000016141500161415001614
      15003F272A00A9766B00D3B1AA00D5C4C000A9777F003F272A0095776B00FFED
      FE00E9C5D300D5C4C000D5C4C000D5B2AA00BE8B8000A9766A0041282C001614
      150041282A00BE9D9400FEEBFE00E9C5D500D39EA900C09D9400C09D9400C09D
      9400BE8B8000AA897F006A4E4100000101000000000000408000808080000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000004080008080800000000000FEFEFE001A202600003366000033
      6600003366000033660000336600003366000033660000336600003366000033
      6600003366000033660000336600001F3E00385E5E0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF002C383800FEFEFE000000000000000000CECECE002828
      4F003737AF004444B4005050B9005959BD006161C0006868C3006B6BC4006B6B
      C4006B6BC4006868C3006161C0005959BD005050B9004444B4003737AF002B2B
      AA001C1CA4000D0D9E0000009900000099000000990000009900000099000000
      99001C1C4B00CCCCCC000000000000000000000000001614150016141500413B
      2C00A9766B00D3B2AA00FED9E900FEEBEA00D5B2BE00563C3F00413B2C00EAD9
      E900FEEBEA00E9C5D300D5C4C000D5C4C000D3B1A900AA897F0094636A004128
      2C00161415002A1516007F625600C09EA900D5C4C000D5C4C000D3B1AA00BE8B
      800095766A006A3C3F0016151500000000000000000000408000808080000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000004080008080800000000000FEFEFE001A202600003366000033
      6600003366000033660000336600003366000033660000336600003366000033
      6600003366000033660000336600001F3E00385E5E0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF002C383800FEFEFE000000000000000000747479002B2B
      81004646B5005555BB006161C0006B6BC4007575C8007979C9007E7ECB007E7E
      CB007E7ECB007979C9007575C8006B6BC4006161C0005555BB004646B5003737
      AF002828A9001919A30009099C00000099000000990000009900000099000000
      9900030376006B6B700000000000000000000000000016151500553B2C00BE8B
      9400EAD8E900EAD9E900FEEBEA0000000000FFEDFE0094636A00161515009577
      6B0000000000E9C5D500D5C4C000D5C4BE00D5C4BE00C09E9500AA897F00A976
      6A00563C3F002A151500161415002A15160041282A0041282C0041282C004128
      2A002A1515001614150016141500000000000000000000408000808080000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000004080000040800000000000FEFEFE001A202600003366000033
      6600003366000033660000336600003366000033660000336600003366000033
      6600003366000033660000336600001F3E00385E5E0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF002C383800FEFEFE000000000000000000363640003F3F
      A8005555BB006363C1007070C6007C7CCA008585CE008D8DD1009292D3009292
      D3009292D3008D8DD1008585CE007C7CCA007070C6006363C1005555BB004444
      B4003535AE002323A7001212A000020299000000990000009900000099000000
      9900000088003A3A49000000000000000000000101006A3C3F0094636A006B50
      550041282C002A2716002C272A006A4E4100BE9D9500BE9D94003F272A003F27
      2A00D3B2BE00FFEDFE00E9C5D300D5C4C000D5C4C000D5B2BE00D39EA900BE8B
      8000AA777F0094635600413B2C002A1515001614150016141500161415001614
      1500161415001614150041282A002C282A000000000000408000808080000000
      0000000000008080800080808000004080008080800080808000004080008080
      8000808080008080800080808000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000808080000040800000000000FEFEFE001A202600003366000033
      6600003366000033660000336600003366000033660000336600003366000033
      6600003366000033660000336600001F3E00385E5E0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF002C383800FEFEFE000000000000000000272731004F4F
      B8006161C0007070C6007E7ECB008A8AD0009797D5009E9ED800A5A5DB00A5A5
      DB00A5A5DB009E9ED8009797D5008A8AD0007E7ECB007070C6006161C0005050
      B9003F3FB2002D2DAB001C1CA40009099C000000990000009900000099000000
      990000009700222231000000000000000000010101002A271600161515001614
      1500161415001614150016141500161415002A151600553B2C003F272A001614
      15006A3C3F00FEEBEA00FEEBFE00E9C5D300E9C5D300D5C4C000D5C4BE00D3B1
      A900C09D9400AA897F00AA777F0094636A006A4E4100413B2C0041282C00413B
      2C00553B2C0080625600BE8B8000413C3F000000000000408000808080000040
      8000000000008080800080808000808080008080800080808000808080000040
      8000808080008080800080808000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      000000000000808080000040800000000000FAFAFA0010171D00001F3E00001F
      3E00001F3E00001F3E00001F3E00001F3E00001F3E00001F3E00001F3E00001F
      3E00001F3E00001F3E00001F3E0000152A00263F3F005D9B9B005D9B9B005D9B
      9B005D9B9B005D9B9B005D9B9B005D9B9B005D9B9B005D9B9B005D9B9B005D9B
      9B005D9B9B005D9B9B00232F2F00FCFCFC0000000000FAFAFA00262633005959
      BD006B6BC4007C7CCA008A8AD0009999D600A5A5DB00B1B1E000B9B9E300B9B9
      E300B9B9E300B1B1E000A5A5DB009999D6008A8AD0007C7CCA006B6BC4005959
      BD004949B6003535AE002323A7000F0F9F000000990000009900000099000000
      9900000099001D1D3000FAFAFA00000000000001000016141500161415001614
      1500161415001614150016141500161415001614150016141500161415002A15
      1600161415007F625600FEEBFE00FEEBFE00EAD8D500E9C5D300D5C4C000D5C4
      C000D5B2BE00D3B1A900C09D9400BE8B8000BE8B8000AA897F00AA777F00AA89
      7F00BE8B8000C09D9400C09E9500554E55000000000000408000808080000000
      0000000000000040800080808000808080008080800000408000808080008080
      8000808080000040800080808000000000000000000080808000808080000040
      8000808080008080800000408000808080008080800080808000808080000040
      800000000000004080000040800000000000FAFAFA00181818002E2E2E002E2E
      2E002E2E2E002E2E2E002E2E2E002E2E2E002E2E2E002E2E2E002E2E2E002E2E
      2E002E2E2E002E2E2E002E2E2E000F0F0F00091E000012380000123800001238
      0000123800001238000012380000123800001238000012380000123800001238
      00001238000012380000131A0F00FCFCFC0000000000FCFCFC00262632006161
      C0007575C8008585CE009797D500A5A5DB00B6B6E200C3C3E700CACAEA00CDCD
      EB00CACAEA00C3C3E700B6B6E200A5A5DB009797D5008585CE007575C8006161
      C0005050B9003C3CB1002828A9001717A20004049A0000009900000099000000
      9900000099001C1C2E00FCFCFC00000000000000000016141500161415001614
      1500161415001614150016141500161415001614150016141500161515006B50
      550041282C002A15160080636A00FFEDFE0000000000EAD9E900EAD8D500E9C5
      D500E9C5D300D5C4C000D5C4BE00D5B2AA00D3B1AA00D3B1A900D3B1AA00D3B1
      AA00D3B1AA00D5B2BE00D5C4BE00565055000000000000408000004080000000
      0000004080000040800080808000004080008080800080808000808080000040
      8000808080000040800080808000004080000000000080808000808080008080
      8000808080000040800080808000808080008080800000408000808080000000
      000000000000004080000040800000000000FEFEFE00292929007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F002E2E2E001F5D000033990000339900003399
      0000339900003399000033990000339900003399000033990000339900003399
      00003399000033990000202C1A00FEFEFE000000000000000000292933006666
      C0007979C9008D8DD1009E9ED800B1B1E000C3C3E700D2D2ED00DEDEF200E1E1
      F300DEDEF200D2D2ED00C3C3E700B1B1E0009E9ED8008D8DD1007979C9006868
      C3005555BB004141B3002D2DAB001919A30006069B0000009900000099000000
      99000000990020202E0000000000000000000000000016141500161415001614
      15001614150016141500161415001614150016141500161415002A151500A977
      7F00BE9D9500553C3F002A1516007F625600EAD8E90000000000FFEDFE00FEEB
      EA00FED9E900FED9E900EAD8D500EAD8E900EAD8D500EAD8D500E9C5D500E9C5
      D500E9C5D500E9C5D300D39EA9002A272A000000000000408000808080000040
      8000004080008080800000408000004080008080800000408000004080000040
      8000808080008080800080808000000000000040800080808000004080008080
      8000808080008080800080808000808080000040800080808000808080000040
      800000000000004080000040800000000000FEFEFE00292929007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F0088888800828282007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F002E2E2E001F5D000033990000339900003399
      0000339900003399000033990000339900003399000033990000339900003399
      00003399000033990000202C1A00FEFEFE00000000000000000042424C005F5F
      AF007E7ECB009292D300A5A5DB00B9B9E300CACAEA00DEDEF200EDEDF800F5F5
      FB00EDEDF800DEDEF200CACAEA00B9B9E300A5A5DB009292D3007E7ECB006B6B
      C4005757BC004444B4003030AC001C1CA40009099C0000009900000099000000
      990000008D003434420000000000000000000000000016141500161415001614
      150016141500161415001614150016141500161415001614150016151500A977
      7F00FED9E900BE9D95006A3C3F0016141500563C3F00E9C5D300000000000000
      000000000000FFEDFE00FFEDFE00FEEBFE00FEEBEA00FEEBEA00FED9E900EAD8
      D500EAD8D500D5B2BE00564E3F00000000000000000000408000004080000040
      8000004080000040800000408000004080000040800000408000004080008080
      8000004080000040800000408000004080000040800000408000808080000040
      8000004080008080800000408000004080000040800000408000808080000040
      800000408000004080000040800000000000FEFEFE00292929007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00DFDFDF009B9B9B007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F002E2E2E001F5D000033990000339900003399
      0000339900003399000033990000339900003399000033990000339900003399
      00003399000033990000202C1A00FEFEFE0000000000000000006C6C6F005555
      98007E7ECB009292D300A5A5DB00B9B9E300CDCDEB00E1E1F300F5F5FB000000
      0000F5F5FB00E1E1F300CDCDEB00B9B9E300A5A5DB009292D3007E7ECB006B6B
      C4005757BC004444B4003030AC001C1CA40009099C0000009900000099000000
      9900030372007272770000000000000000000000000016141500161415001614
      15001614150016141500161415001614150016141500161415002A151600AA89
      8000FEEBFE00E9C5D300BE8B9400563C3F001614150041282A00A9897F00FEEB
      EA0000000000000000000000000000000000FEEBFE00FEEBEA00FEEBEA00FED9
      E900EAD8E900D5B2BE006B625600000101000000000000408000004080008080
      8000004080000040800080808000004080000040800080808000004080000040
      8000004080000040800080808000004080008080800000408000004080000040
      8000808080000040800080808000004080000040800000408000004080000040
      800080808000004080000040800000000000FEFEFE00292929007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00DFDFDF009B9B9B007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F002E2E2E001F5D000033990000339900003399
      0000339900003399000033990000339900003399000033990000339900003399
      00003399000033990000202C1A00FEFEFE000000000000000000CACACA003E3E
      5A007E7ECB009292D300A5A5DB00B9B9E300CACAEA00DEDEF200EDEDF800F5F5
      FB00EDEDF800DEDEF200CACAEA00B9B9E300A5A5DB009292D3007E7ECB006B6B
      C4005757BC004444B4003030AC001C1CA40009099C0000009900000099000000
      99001F1F5200C1C1C10000000000000000000000000016141500161415001614
      15001614150016141500161415001614150016141500161415002C272A00C09E
      A900FEEBEA00D5B2BE00D39EA900A9776B00413B2C001615150016141500413B
      2C00AA8B8000EAD8E90000000000000000000000000000000000FEEBFE00FEEB
      EA00FED9E900E9C5D300D5B2BE006A626A000000000000408000004080000040
      8000004080000040800000408000808080000040800000408000004080000040
      8000004080008080800000408000004080000040800000408000004080008080
      8000004080000040800000408000004080008080800000408000808080000040
      800000408000004080000040800000000000FEFEFE00292929007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00DFDFDF009B9B9B007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F002E2E2E001F5D000033990000339900003399
      0000339900003399000033990000339900003399000033990000339900003399
      00003399000033990000202C1A00FEFEFE000000000000000000000000003C3C
      46006F6FB8008D8DD1009E9ED800B1B1E000C3C3E700D2D2ED00DEDEF200E1E1
      F300DEDEF200D2D2ED00C3C3E700B1B1E0009E9ED8008D8DD1007979C9006868
      C3005555BB004141B3002D2DAB001919A30006069B0000009900000099000000
      990023232F000000000000000000000000000000000016141500161415001614
      150016141500161415001614150016141500161415001614150041282A00E9C5
      D300D3B1AA0080625600553B2C0041282C003F272A0016141500161415001614
      15002A151500413B2C0094635600BE9EA900EAD8D500FFEDFE00FEEBFE00FEEB
      EA00FED9E900EAD8D500D5C4C000565055000000000000408000004080000040
      8000808080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      800000408000004080000040800000000000FEFEFE00292929007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00CACACA00959595007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F002E2E2E001F5D000033990000339900003399
      0000339900003399000033990000339900003399000033990000339900003399
      00003399000033990000202C1A00FEFEFE00000000000000000000000000D3D3
      D400363651008585CE009797D500A5A5DB00B6B6E200C3C3E700CACAEA00CDCD
      EB00CACAEA00C3C3E700B6B6E200A5A5DB009797D5008585CE007575C8006161
      C0005050B9003C3CB1002828A9001717A20004049A0000009900000099001515
      4E00C0C0C2000000000000000000000000000000000016141500161415001614
      1500161415001614150016141500161415001614150016141500563C3F00D5C4
      BE006B5055002A1515001614150016141500161415002A1516007F5055008062
      5600553B2C0041282A002A1515002A15160041282A00563C3F0080636A009577
      6B00BE8B9400BE8B9400BE8B8000413B3F000000000000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      800000408000004080000040800000000000FEFEFE00292929007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F002E2E2E001F5D000033990000339900003399
      0000339900003399000033990000339900003399000033990000339900003399
      00003399000033990000202C1A00FEFEFE000000000000000000000000000000
      0000414149007272B9008A8AD0009999D600A5A5DB00B1B1E000B9B9E300B9B9
      E300B9B9E300B1B1E000A5A5DB009999D6008A8AD0007C7CCA006B6BC4005959
      BD004949B6003535AE002323A7000F0F9F000000990000009900010198002A2A
      3300000000000000000000000000000000000000000016141500161415001614
      150016141500161415001614150016141500161415001614150094636A008063
      6A00161515001614150016141500161415001614150016141500553B2C00EAD9
      E900E9C5D300BE8B8000946356006B4E410041282A0015141500161515002A15
      1600161516002A15150016151600000101000000000000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      800000408000004080000040800000000000FEFEFE00292929007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F002E2E2E001F5D000033990000339900003399
      0000339900003399000033990000339900003399000033990000339900003399
      00003399000033990000202C1A00FEFEFE000000000000000000000000000000
      000000000000373743007474BB008A8AD0009797D5009E9ED800A5A5DB00A5A5
      DB00A5A5DB009E9ED8009797D5008A8AD0007E7ECB007070C6006161C0005050
      B9003F3FB2002D2DAB001C1CA40009099C0000009900000099001D1D2D000000
      0000000000000000000000000000000000000000000016141500161415001614
      150016141500161415001614150016141500161415002A2716007F6256002A15
      1600161415001614150016141500161415001614150016151500161415007F63
      560000000000D5B2BE00BE8B9400AA776B00806255002C272A00161415001614
      1500161415001614150016141500000000000000000000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      800000408000004080000040800000000000FEFEFE00292929007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F009D9D9D00888888007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F002E2E2E001F5D000033990000339900003399
      0000339900003399000033990000339900003399000033990000339900003399
      00003399000033990000202C1A00FEFEFE000000000000000000000000000000
      000000000000000000003B3B4E006363A2008585CE008D8DD1009292D3009292
      D3009292D3008D8DD1008585CE007C7CCA007070C6006363C1005555BB004444
      B4003535AE002323A7001212A0000202990000008B0015152A00FEFEFF000000
      0000000000000000000000000000000000000000000016141500161415001614
      1500161415001614150016141500161415001614150041282A0041282A001614
      1500161415001614150016141500161415001614150016141500161415002A27
      1600D3B2BE00FED9E900BE8B8000A9766A0041282A0016141500161415001614
      1500161415001614150016141500000000000000000000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      800000408000004080000040800000000000FEFEFE00292929007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00DFDFDF009B9B9B007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F002E2E2E001F5D000033990000339900003399
      0000339900003399000033990000339900003399000033990000339900003399
      00003399000033990000202C1A00FEFEFE000000000000000000000000000000
      00000000000000000000A8A8A800373744006969B3007979C9007E7ECB007E7E
      CB007E7ECB007979C9007575C8006B6BC4006161C0005555BB004646B5003737
      AF002828A9001919A30009099C0001016B0028283F00D0D0D100000000000000
      0000000000000000000000000000000000000000000016141500161415001614
      1500161415001614150016141500161415001614150041282A00161415001614
      1500161415001614150016141500161415001614150016141500161415001614
      150080625600FEEBEA00BE8B80006B5055001615150016141500161415001614
      1500161415001614150016141500000000000000000000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      800000408000004080000040800000000000FEFEFE00292929007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00DFDFDF009B9B9B007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F002E2E2E001F5D000033990000339900003399
      0000339900003399000033990000339900003399000033990000339900003399
      00003399000033990000202C1A00FEFEFE000000000000000000000000000000
      0000000000000000000000000000EAEAEA0045454D00404065006464B8006B6B
      C4006B6BC4006868C3006161C0005959BD005050B9004444B4003737AF002B2B
      AA001C1CA4000B0B8F0011114100626276000000000000000000000000000000
      0000000000000000000000000000000000000000000016141500161415001614
      1500161415001614150016141500161415001614150016151500161415001614
      1500161415001614150016141500161415001614150016141500161415001614
      15002C272A00D5C4BE00BE8B940041282C001614150016141500161415001614
      1500161415001614150016141500000000000000000000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      800000408000004080000040800000000000FEFEFE00292929007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00DFDFDF009B9B9B007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F002E2E2E001F5D000033990000339900003399
      0000339900003399000033990000339900003399000033990000339900003399
      00003399000033990000202C1A00FEFEFE000000000000000000000000000000
      00000000000000000000000000000000000000000000B8B8B900363640003636
      540041418A004F4FAE004F4FB8004949B6003F3FB2003434AB00232396001818
      7F0021214D0031314200D4D4D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000016141500161415001614
      1500161415001614150016141500161415001614150016141500161415001614
      1500161415001614150016141500161415001614150016141500161415001614
      15001614150080636A00BE8B94003F272A001614150016141500161415001614
      1500161415001614150016141500000000000000000000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      800000408000004080000040800000000000FEFEFE00292929007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00B5B5B5008F8F8F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F002E2E2E001F5D000033990000339900003399
      0000339900003399000033990000339900003399000033990000339900003399
      00003399000033990000202C1A00FEFEFE000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CECE
      CE0076767A0038384200272731002424320022223100262632003D3D4A006C6C
      7000CCCCCC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000016141500161415001614
      1500161415001614150016141500161415001614150016141500161415001614
      1500161415001614150016141500161415001614150016141500161415001614
      15001614150041282A00A9776B002A2716001614150016141500161415001614
      1500161415001614150016141500000000000000000000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      8000004080000040800000408000004080000040800000408000004080000040
      800000408000004080000040800000000000FDFDFD0030303000292929002929
      2900292929002929290029292900292929002929290029292900292929002929
      29002929290029292900292929001A1A1A0016221000202C1A00202C1A00202C
      1A00202C1A00202C1A00202C1A00202C1A00202C1A00202C1A00202C1A00202C
      1A00202C1A00202C1A002B322800FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FAFAFA00FCFCFC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000100002C282A00000100000001000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FCFCFC00FCFCFC00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000A00000000100010000000000000A00000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF
      0000000080000007C0003FFFF800001F0000000080000007DFFFBFFFFBFFFFDF
      0000000080000007DFFFBC1FFBFFFFDF0000000080000007DFFFBBEFFBFFFFDF
      0000000080000003DE07B7F7FB8001DF0000000080000003DEF7B7F7FBFFFFDF
      0000000080000001DEF7B7F7FBFFFFDF0000000080000005DEF7B7F7FB8001DF
      0000000080000003DEF7BB6FFBFFFFDF0000000080000001DEF7BD5FFBFFFFDF
      0000000080000001DEF7BF7FFB8001DF0000000080000003DEF7BF7FFBFFFFDF
      0000000080000003DEF7BFFFFBFFFFDF0000000080000001DEF7BFFFFB8001DF
      00000000C0000001DEF7BFFFFBFFFFDF00000000C0000005DE07BFFFFBFFFFDF
      00000000C0000005DE07BFFFFB8001DF00000000F0400007DE07BFFFFBFFFFDF
      00000000F0200023DE07BFFFFBFFFFDF00000000F8203083DE07BFFFFB8001DF
      00000000F8101051DE07BFFFFBFFFFDF00000000FE119879DE07BFFFFBFFFFDF
      00000000FE1F983FDE07BFFFFB80601F00000000FF0FCC3FDE07BF7FFBFFEFBF
      00000000FFEFCFFFDE07BF7FFBFFEF7F00000000FFFFE7FFDFFFBF7FFB806EFF
      00000000FFFFE7FFDFFFBF7FFBFFEDFF00000000FFFFF3FFDFFFBF7FFBFFEBFF
      00000000FFFFFFFFDFFFBF7FFBFFE7FF00000000FFFFFFFFC0003FFFF8000FFF
      FFFFCF3DFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF
      0000000000000000FFE007FFFF7FFCFF0000000000000000FFC003FFFE3FF87F
      0000000000000000FFC003FFFC3FFA7F0000000000000000FFC003FFFD9FFB7F
      0000000000000000FFC003FFFD9FFB3F0000000000000000FFC003FFFC8FFB1F
      0000000000000000FF8201FFFCCFF8030000000000000000FF0300FFFCCFF171
      0000000000000000FE00007FFCE7E6790000000000000000FC00003FFCE7CE03
      0000000000000000FFC003FFFEE39DFF0000000000000000FFC003FFFEF339FF
      0000000000000000FFC003FFFEF073FF0000000000000000FFC003FFFE71E7FF
      0000000000000000FFC003FFFE73CFFF0000000000000000FF8201FFFE679FFF
      0000000000000000FF0300FFFE4F9FFF0000000000000000FE00007FFE5E07FF
      0000000000000000FC00003FFF3C80FF0000000000000000FFC003FFFE79F03F
      0000000000000000FFC003FFFCF3FE0F0000000000000000FFC003FFF9E7FFC3
      0000000000000000FFC003FFF3C03FF10000000000000000FFC003FFE79C0023
      0000000000000000FF8201FFCF3FFC070000000000000000FF0300FFCE7FFFFF
      0000000000000000FE00007FCCFFFFFF0000000000000000FC00003FC1FFFFFF
      0000000000000000FFC003FFC3FFFFFF0000000000000000FFF00FFFFFFFFFFF
      0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF80000001FFFFFFFF
      FE1FC3FFFFFFFFFF80000001FFFFFFFFFE1F83FFFFFFCFFF0000000080000003
      FE1F83FFFFFF87FF0000000080000003FE1F83FFFFFF07FF0000000080000003
      800083FFFFFC07FF0000000080000003800083FFFFF806FF0000000080000003
      C0000000FFF0063F0000000080000003E0000000FFE0073F0000000080000003
      F0000001F000039F0000000080000003C0000003F00001CF0000000080000003
      C0000007E00000E70000000080000003E000000FE00006670000000080000003
      F000001FE00006670000000080000003F808003FE00007330000000080000003
      F0000003E00007330000000080000003F0000003E00007330000000080000003
      FC00000FE00007330000000080000003FE10001FE00006678000000180000003
      FF38003FE00006678000000180000003FFFC007FE00004E7C000000380000003
      FFFE007FF00001CFE000000780000003FFF8001FF000039FE000000780000003
      FFF8001FFFE0073FF800001F80000003FFFE007FFFF0067FFC00003F80000003
      FFFE00FFFFF806FFFE00007F80000003FFFF01FFFFFC07FFFFC003FF80000003
      FFFF81FFFFFF07FFFFF00FFF80000003FFFFC3FFFFFF87FFFFF00FFF80000003
      FFFFE7FFFFFFCFFFFFF00FFF80000003FFFFFFFFFFFFCFFFFFF00FFF80000003
      FFFFFFFFFFFFFFFFFFFE7FFFFFFFFFFF00000000FFFFFFFF80000001FFFFFFFF
      000000009801801900000000FFFE7FFF000000009801801900000000FFE007FF
      000000009801801900000000FF8001FF000000009801801900000000FF0000FF
      000000009801801900000000FC00003F000000009801801900000000F800001F
      000000009800001900000000F000001F000000009800001900000000F000000F
      000000009800001900000000E0000007000000009800001900000000E0000007
      000000009800001900000000C0000003000000009801801900000000C0000003
      010800009801801900000000C0000003000000009801801900000000C0000003
      0000000088018019000000008000000100000000980180090000000080000001
      000080009000801900000000C0000003000040008001000900000000C0000003
      000038008000000100000000C010000300000F008000000100000000C0000003
      000003C08000000100000000E0000007000000008000000100000000E0000007
      000000008000000100000000F000000F000000008000000100000000F800001F
      000008008000000100000000FC00001F000000008000000100000000FC00003F
      000000008000000100000000FE0000FF000000008000000100000000FF8001FF
      000000008000000100000000FFE007FF000000008000000100000000FFFE7FFF
      00000000FFFFFFFF80000001FFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end
