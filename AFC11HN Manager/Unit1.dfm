object Form1: TForm1
  Left = 248
  Top = 101
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'AFC11HN Manager'
  ClientHeight = 443
  ClientWidth = 544
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 2
    Top = 16
    Width = 540
    Height = 425
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 0
    object Label3: TLabel
      Left = 15
      Top = 4
      Width = 24
      Height = 13
      Caption = 'Cars:'
    end
    object CLBCars: TCheckListBox
      Left = 7
      Top = 18
      Width = 300
      Height = 399
      AutoComplete = False
      Flat = False
      ItemHeight = 13
      TabOrder = 0
      OnClick = CLBCarsClick
    end
    object SaveChanges: TBitBtn
      Left = 315
      Top = 296
      Width = 217
      Height = 41
      Caption = 'Apply changes'
      TabOrder = 1
      OnClick = SaveDS
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000C30E0000C30E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF040404
        0404040404040404040404040404040404040404040404040404040404040404
        0404040404040404040404040404040404040404040404040404040404040404
        0404040404040404040404FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF868686868686
        8686868686868686868686868686868686868686868686868686868686868686
        8686868686868686868686868686868686868686868686868686868686868686
        8686868686868686999999040404FFFFFFFFFFFFFFFFFFFFFFFF868686FFFFFF
        E3E3E3A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0
        A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4
        A0A0A4A0A0A4A0A0969696868686040404FFFFFFFFFFFFFFFFFF868686FFFFFF
        E3E3E3E3E3E3E3E3E3E3E3E3DDDDDDDDDDDDC0C0C0FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFF1F1F1C0C0C0CCCCCCC0C0C0CCCCCCC0C0C0C0C0C0C0
        C0C0C0C0C0A4A0A0999999868686777777040404FFFFFFFFFFFF868686FFFFFF
        E3E3E3F1F1F1E3E3E3F1F1F1E3E3E3CCCCCCE3E3E30404040404040404040404
        04040404040404040404040404F1F1F1F0FBFFF1F1F1F0FBFFFFFFFFF0FBFFCC
        CCCCC0C0C0A4A0A0999999868686777777040404FFFFFFFFFFFF868686FFFFFF
        DDDDDD8686868686868686868686868686868686860404040404040404040404
        04040404040404040404040404868686868686868686868686868686868686C0
        C0C0C0C0C0A4A0A0999999868686777777040404FFFFFFFFFFFF868686FFFFFF
        E3E3E3DDDDDDE3E3E3DDDDDDCCCCCCE3E3E3DDDDDD8686868686868686868686
        86868686868686868686868686CCCCCCB2B2B2CCCCCCC0C0C0CCCCCCC0C0C0CC
        CCCCC0C0C0A4A0A0969696868686777777040404FFFFFFFFFFFF868686FFFFFF
        DDDDDDE3E3E3DDDDDDE3E3E3D7D7D7E3E3E3CCCCCCE3E3E3C0C0C0D7D7D7C0C0
        C0D7D7D7C0C0C0C0C0C0CCCCCCB2B2B2CCCCCCB2B2B2CCCCCC003399000080C0
        C0C0C0C0C0A4A0A0999999868686777777040404FFFFFFFFFFFF868686F0FBFF
        E3E3E3DDDDDDE3E3E3DDDDDDE3E3E3DDDDDDE3E3E3C0C0C0D7D7D7C0C0C0D7D7
        D7C0C0C0C0C0C0CCCCCCB2B2B2CCCCCCB2B2B2CCCCCCB2B2B20000FF003399C0
        C0C0C0C0C0A4A0A0969696868686777777040404FFFFFFFFFFFF868686FFFFFF
        EAEAEAE3E3E3DDDDDDE3E3E3DDDDDDE3E3E3DDDDDDCCCCCCCCCCCCD7D7D7C0C0
        C0D7D7D7CCCCCCB2B2B204040404040404040404040404040404040404040404
        0404040404040404040404040404040404040404040404040404868686FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF66666677777786868677777777777777777766666677
        7777666666777777777777666666666666666666666666040404FFFFFF868686
        B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
        B2B2B2B2B2B2B2B2B2B266666686868677777786868677777777777777777766
        6666040404CCCCCC666666777777666666777777666666040404FFFFFFFFFFFF
        868686A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0A0A4A0
        A0A4A0A0A4A0A0A4A0A066666677777786868677777786868677777766666677
        7777040404CCCCCC777777666666777777666666666666040404FFFFFFFFFFFF
        FFFFFF8686868686868686868686868686868686868686868686868686868686
        8686868686868686868666666686868677777786868677777777777777777766
        6666040404CCCCCC666666777777666666777777666666040404FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF66666677777786868677777786868677777777777777
        7777666666666666777777666666777777666666777777040404FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF66666686868677777786868677777786868677777799
        9999F1F1F1F1F1F1666666777777666666777777666666040404FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF66666677777786868677777786868677777766666677
        7777777777777777FFFFFF666666777777666666777777040404FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF66666686868677777786868677777786868604040486
        8686FFFFFF777777F1F1F1777777666666777777666666040404FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF66666677777786868677777786868677777704040477
        7777868686868686999999666666777777666666777777040404FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF66666686868677777786868677777786868677777704
        0404040404999999777777777777666666777777666666040404FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF666666FFFFFF99FFFF99FFFFD7D7D799FFFFD7D7D799
        FFFF66CCCC99FFFF66CCCC66CCCC66CCCC66CCCC66CCCC040404FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF66666699FFFFFFFFFF99FFFF99FFFFD7D7D799FFFFD7
        D7D799FFFF66CCCC99FFFF66CCCC99FFFF66CCCC66CCCC040404FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF666666F0FBFF99FFFFE3E3E399FFFF99FFFFD7D7D799
        FFFFD7D7D799FFFF66CCCC99FFFF66CCCC66CCCC66CCCC040404FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF66666699FFFFF0FBFF99FFFFE3E3E399FFFF99FFFFD7
        D7D799FFFFD7D7D799FFFF66CCCC99FFFF66CCCC66CCCC040404FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF66666666666666666666666666666666666666666666
        6666666666666666666666666666666666666666666666040404FFFFFFFFFFFF
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
    end
    object BitBtn2: TBitBtn
      Left = 315
      Top = 336
      Width = 217
      Height = 41
      Caption = 'Apply && Run Cobra11'
      TabOrder = 2
      OnClick = SaveDSRun
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFE5E7EB86888E7F7F817F7F817F7F818F8F8FF6F6F6FCFCFC9B9DA27F
        87947F86937F8693828995D7DBE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFB6BABF0E00771600C61500BC1600C80C0065C7C7C7EFEFEF07003B16
        00BF1500B71600BD120097757C89FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C6C68E8E8E8686868C8C8C9AA6B1ACB9
        C797ACBE788D970F01831B02F61A02E81B02F41201A3868686F8F8F82E29521A
        02EB1A02EA1A02ED1801D24A4F61FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFF9F9F9BABABADBDBDBB5B5B55E5E5E474544434B513D78
        9784A3B8447A890D08661B05ED1A06E21B06EA1505B82F2F30BDBDBD49475D19
        06DB1A06E51A06E41A05E133345FFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFCAD3DB65727B5A5A5AFFFFFFEDEDED8484845D5D5D6663622B5A
        6E679FB83A7788090E461B0AE61A0CE41B0CE9170BC902020B18181722212C18
        0BCC1B0CE81A0CE31B0CEC242364F5F6F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFCDD6DD164F72003A5E242A2E5B59593939393E3E3E6868685656550E11
        120B4D6A073F5D060D391B10DD1B13E61C13E71B12DE04032054545443434315
        0EAC1C14EE1B13E41D13F0130F65DCE0E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        EFF1F426597A013E63014C740D415C2925232C2C2C1B1B1B2E2E2E2E2E2E3C3A
        3A181E2800082903021F1B19D61D1BE91C1BE61D1CEE0808412424240C0C0C13
        11941E1CF11D1BE51F1DF3100D7C656C6CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        6B8CA20140670251780260881278A2193B49110C09141414383838656565A7A7
        A71C1C1C2F32393B4047191DBA1F26EF1E24E61F26F20B0E581717170A0A0A11
        147F2027F51E24E61F26F1161AA7575E60CBD1D6FFFFFFFFFFFFFFFFFFCFCFCF
        042E46015A8401648D046A950A77A3056084060A0C201F1F5959594141411111
        110000000707080F0F0F16209F2131F41F2FE82132F60F17710000000000000C
        135B2132F51F2FE82031F01A27BF010004070A0EBEC8CFFFFFFFFFFFFF5F5F5F
        00080D005A82016B9901669200618A015B8501293F0000000000000000000000
        0000000000000000000014238B233EF7213AE9233DF616279B00000000000008
        0E37223CEE213BEB223CEF1E35D1020313000015495872FFFFFFE6E6E60F0F0F
        000000002638006795005E8600537C004770003A60000A120000000000000000
        0000000000000000000010216F254BF92346EB2449F41B38BB00000800000005
        0B242245E62347EE2347EE2245E7060C2A000021070E40D7DDE3A2A2A2000000
        000000000000004361005C8600426300304D002441000B1F0000000000000000
        000000000000000000000A18442656F62453EE2555F41F48CA01051F00001003
        050F224DDC2555F22453ED2557F70B194400000B000238909DB0616161000000
        00000000000000090B0024380920460E275F0F27610E245C0A183E02050E0000
        0000000000000000000007122C265EEE265FF12660F32459DF040F2900103100
        02051E4ABB2762F8265EEE2864FC0F265E0000000000234B5C7B3D3D3D000000
        0000000000000B1B3F2051C02866F1296AFA296AFA296BFA2869F7245FDE1536
        7E000000000000000000050C1B2562E52868F32767F12868F40A1F4600193800
        0B191A439D296CFC2767F0296DFE14347A00000000000426314E1B1B1B000000
        000000091834276DEF2A73FE286FF2286FF12971F62973FB2972F82A75FF2464
        DC020409000000010000020407225ECE2972F8286EF12A73FC0E2A5C000F2D00
        0821173F8A2A75FF286FF12A74FD1B4CA700000001000016182A111111000000
        0000001D53AA2B7EFF2976F22976F22A7BFA266CDD205BBA2364CE2873EC2C7F
        FF0B1D3B0100000302020000001D55AD2B7CFE2977F22B7EFF13366E00001C00
        001F12346C2B7DFF2976F22B7BFB215FC3020202000000121212111E24000000
        040D182878E72B81F72A7EF32C84FC205EB405142600142403192E07203C1640
        7D0E284F0301000707070300001A4E972D87FF2B80F62D87FF1A4D94000E2201
        16340B24462C83FC2A80F62C84FC2570D803070B0000001212121D5874000000
        091A2F2B87F52B87F62B87F62C89F90B234000203B02355F03385F043D600434
        4A071A250D09081010100A05001441772A8AF82882EE2A88F81E5EAF062B3C09
        4D6C09233C297CE32A82ED2B85F2287FE706111F000000171717407D9B001E2C
        0A1D342D91FB2C8FF72D91FB2983E303080D011729043F6807476B0B5578106A
        8D1572941A282E1E1B191D1C1B0F161D1324361323351221320F2B3E125B7515
        71950A3A500A2C45092A4509182A0A192B05080C0101012828286592A8004969
        0B28422E96F82D96F82E99FD2987DE03070C03020307405D0C61851474971D8C
        B026A7CF2D829D322D2D3A3A3A41413F44413E403D3937302C2F40442791B31E
        85A81776991065860B5E80082C3A0F0701090807000000505050A8BDCA005277
        092E482E99F12E9EFA2FA0FC2B92E7040E150500000C232D1580A62199BF2EAE
        D43ABFE548D2F6577F8B615A586465656161615858584D4E4E423B39366C7D2B
        A3C7218AAE197DA014779B127499142026050201030303959595EAEDF0115175
        06253C2D9BEB30A6FC2FA5FB2FA4F80B2132090401130E0C206B8430B8E044C8
        ED5ADBFC6CE8FF77D7EE7C80827D7B7A7878786F6F6F63646455545447484939
        9AB72DA6CB228FB31881A61583AC13506B0804030B0A0ADCDCDCFFFFFF65869D
        02192C2A90D231B0FF30ABFA31B2FF123851120C081B18162F3A3E4AC1E264E4
        FF77E6FF84E7FF8CEFFF90C0CD8F8A898A8B8B83838377777768696959535148
        656F36B1D6289EC31F8FB51880A50F749B082835535252FFFFFFFFFFFFD5DDE3
        0720352175A533BBFF31B1FA33BBFF154E6F1A120E3435354A434161909D77EB
        FF85E7FF91EAFF98ECFF9AECFD9AAAAE9593928E8F8F84858577787865666550
        4A493D859C2DADD32195BA1885AB0F78A1095E82C8C9C9FFFFFFFFFFFFFFFFFF
        7C8F9C16547234C2FF31B8FC34C1FF1F7EAF241E1B4D4E4D5A5A5A6D6A6A81CB
        DF8DF1FF9CF5FF9DF0FF9BF0FF9AD9E9979695919191898A8A7E7E7E6B6C6C51
        4F4E3C45482C98BA1F91BA1279A207719D659BB5FFFFFFFFFFFFFFFFFFFFFFFF
        F6F7F82F495731B7F333BFFF33C0FE2EB4EE152730554E4B6B6B6B7671708F9C
        A08CDAEA649CA888D0E19BEFFF97EFFF93B7C18D88868787878080806B6B6B4D
        4E4E393331284F5E1D8AB32784A9408FAEF0F2F4FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF9CA1A7217DA136D0FF33C2FD35CBFF238EB82E3334655E5B5A514F605B
        592F4D570A3F565B8D9A9EEAFA8AE7FC81E2F77985896F6C6B6567675757574B
        4C4C4A4B4A6C6A6992AEBAADCAD7EFF2F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF6F7F834495231BCEB35CFFF33C7FE36CFFF2AABDA196D8B17647F218B
        B22EBEE92596C06B909CA8DAEB79DAF571DCF778ADBE79747382838388888881
        8181B1B1B1D8D8D8E6E7E7F5F6F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFCDD0D51A445233C7F037D8FF34CDFF35D1FF37D7FF37D8FF36D5
        FF38DBFF2285A67493A0AFD4E2A8CCDAAFCBD8B2CCD8D9DDDEE5E5E5E9E9E9FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFC0C4C92C48532796B335CFF938DAFF38DDFF38DDFF37DA
        FF37DAFE1B687F728C96AFCFDC9FC4D390BCCF88BDD1A0BECBC8C8C8F2F2F2FD
        FDFDFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFECEDF0858B933F59651F56651E6C811F6B811F56
        643A5259737576ECECECFCFCFCF2F4F6FAFAFBF8F9FAEDF0F3FFFFFFFFFFFFFE
        FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2E2E4D5D5D5D5D5D5E2E2
        E2FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    end
    object BitBtn1: TBitBtn
      Left = 315
      Top = 376
      Width = 217
      Height = 41
      Caption = 'About manager ...'
      TabOrder = 3
      OnClick = AboutClick
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C000000000000000000000000000000000000C8D0D4C8D0D4
        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
        D4C8D0D4C8D0D4C8D0D4C8D0D4C6CDD1A19A978E7C74AAA5A3C6CDD1C8D0D4C8
        D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
        D4C8D0D4C8D0D4C8D0D4BDC2C489726493613A643E2A978A85C5CCD0C8D0D4C8
        D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
        D4C8D0D4C8D0D4AEACAC765644D3A270DFAA725F341E978A85C6CDD1C8D0D4C8
        D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
        D4C8D0D4A6A19F623B27B98A5CF3CCA1D6A16E5E37239A8E89C8D0D4C8D0D4C8
        D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
        D4B5B6B6633F2DBE9165E0BA91F9CFA5D5A171603B289B908DC6CED2C8D0D4C8
        D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C0C6C9C0C5C8C0C5C8ADAB
        AA68493D7E5035D3B28CE6BE94FBD2A7D7A87C5B34207F6960A7A09DB8B8B8C3
        C9CCC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C0C6C9A9A5A3897870795D4F74523D653C
        25744A31B39071CCAA89ECC399F4CBA2CEA5806335194A22115F3E30795F5395
        8680B1AEAEC2C8CBC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C8D0D4C8D0D4C8D0D4B2B0B08A7971815D46865C3DA37E5FBC9A79BC9B
        7BBF9F7FC0A081CDAD8AEEC69FECC39CD4AF8AB9926C8E623F7B4B2845190756
        2F1F73574A978B84B8B8B8C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C8D0D4C4CBCFA39A96866856B18C67BFA285C4AA8DC4AA8BC7A685CAAA
        86CCAB89D3B291E7C29FFCD4ADF3CDA6DBB896CFAF90CBAC89C5A580B48A6071
        43264F210C5A3323846E64ADA9A7C5CCD0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C7CFD39D908AAA8663C6AD8CC3AD95CAAE94D3B598D8BA9BE5C5A5F5D5
        B1F9D9B6FADBB8FFE3BEFFE7C0FFE2BBF8D5B0E4C19ED7B593CCAD8FCAAD8ECB
        A983AC7F565427104F2715795F52AAA4A2C5CCD0C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4A7978ABD9C7AC5B098C8B198D6BA9EE6C7A9F6D4B3FFE1BEF8D2B0F1C1
        9DFFD8B1FAD0A9F6CAA4F6CAA3FFE5BDFFD0A7F7CDA7F8D5B1E8C5A1DABA98CF
        B191CEB092BE956F7343244B24107B6157B0ACABC8D0D4C8D0D4C8D0D4C8D0D4
        B1A79FC5A888C2AE99CEB49DE1C6ABF6D7B9FFE1C2FFE4C4FFF3D3CF9F7C6607
        009A2700BE501BCC5F2BCC5D28BD4E1A8F3002DAA880FFE7C3FFDCB8F8D3AFE6
        C3A2D3B595CDB294C6A0786D3F22502818877268BBBDBFC8D0D4C8D0D4BFC4C7
        BFA283C2B09CCCB7A2E3CAB1FADEC2FFE7C8FFE4C6FFE3C5FFE5C7FFE8CAF4D9
        BA893E189A2E00A63E0A9930038D431CF1D8B6FFE5C3FFDFBFFFE0BBFFDFBCFE
        DAB6E8C7A7D4B799CDB396C09A7352240E603C2C9E948FC5CCD0C8D0D4B9A28D
        CABAA7CCB8A5E3CCB3FDE1C6FFE9CDFFE5C9FFE4C8FFE4C6FFE4C8FFEBCDFFFB
        DF9F6442841900972A007E1800C18D69FFFFE1FFE4C4FFE1C0FFDEBCFFDEBDFF
        E1BFFDDCB9E8C7AAD5B99ED8BD9EA77C56491C0A80695FBABCBEBBBDBDD6C0A7
        CABAA9DFC9B4FBE0C9FFE9D1FFE8CDFFE6CDFFE6CAFFE5CBFFE4CAFFE9CEFFF4
        DC9B613E851D009C3000811C00CA9774FFF6DAFFE3C6FFE2C3FFE1C2FFE1C1FF
        E0C0FFE2C0FDDDBBE7C9ACD7BFA3D4B592693B20614032A8A29FB9AEA3C9BCAA
        D5C4B1F1DAC7FFECD4FFEAD3FFE8CFFFE8D0FFE8CEFFE7CFFFE7CDFFEBD2FFF6
        DE9B6140861D009C3000821C00C89675FFF8DFFFE5C9FFE3C6FFE1C4FFE3C5FF
        E0C4FFE3C5FFE4C6F6D8B9E0C5ABDEC6AB956D51522816988A84CFB9A2CDBFB2
        E2D0BEFCE9D2FFEED7FFEAD5FFEBD4FFEAD2FFEAD3FFE7D2FFE9D1FFEDD5FFF8
        E19B6241861D009D3000821B00C89777FFFBE3FFE7CDFFE3CAFFE4C9FFE4C7FF
        E2C8FFE3C7FFE5C9FFE2C5EBCFB4DEC6B0D8B693572D1893837CC9B7A7D3C6B8
        EEDBCCFFF0DDFFEEDBFFECDAFFECD8FFECD7FFEBD7FFEBD4FFEBD5FFEFD9FFFA
        E69B6142861C009C3000821A00C89879FFFCE6FFE9D0FFE7CEFFE6CBFFE4CAFF
        E6CCFFE5CBFFE5CAFFE8CDF5DAC1E3CCB5E2C6A9552D1992837BCBC0B2D6C8BC
        F1E1D1FFF3E1FFF0DDFFEEDCFFEEDCFFEDDBFFEDDAFFEDD9FFEDD8FFF0DCFFFB
        EB9B6343851D009C3000821A00C89A7BFFFEE9FFEBD3FFE8CFFFE8D0FFE6D0FF
        E8CDFFE7CEFFE7CDFFEBD1F9E0C7E4CEB6E6CFB7562D1A92837BCCC2B6D6C9BE
        F2E4D6FFF4E5FFF0E1FFF0E0FFEFDFFFEFDFFFEFDEFFEFDDFFEFDDFFF4E3FFFF
        F4A26C4D871C009D3000821A00C89A7CFFFFEDFFECD7FFEAD5FFE8D4FFE9D1FF
        E9D1FFE9D2FFE7D1FFEDD6F9E1CAE4CEB8E7D3BD572E1B92837BCBC1B7D7CDC3
        F3E6DAFFF7EAFFF3E5FFF2E4FFF1E3FFF1E3FFEFE2FFF2E2FFF4E4FFFFF5FFFF
        F593471F9226009F3000841900C99C7FFFFFF2FFEEDBFFEDD8FFECD7FFEBD5FF
        EBD4FFE9D4FFE9D3FFF1DAF9E4CEE6D3BDE6D4BD59301D968883CEC3B7DAD3CA
        F3E8DEFFFAEEFFF7EBFFF2E6FFF2E7FFF4E7FFF3E5FFF5E7FFFBEFC89F87812C
        047C0B008A1C008D20006D0A00C0957AFFFFF5FFF0DEFFEEDCFFEDDBFFEDDAFF
        EDD8FFEAD8FFEBD7FFF8E4FAE8D5EBD8C7E7D2BB674535A6A09ED7CBBCDDD8D2
        EEE5DFFFFBF2FFFBF1FFF4EBFFF6EBFFF3EAFFF3E9FFF7EBFFFBEFA781696F37
        1E84492B854F316D33134F1100BD9C88FFFFF5FFF1E3FFF0E0FFEFDDFFEFDEFF
        EEDCFFEBDAFFF3E1FFFEEDF9E5D3F2E2D2E1C7AC7F655ABABCBDCECCC8DAD7D4
        E8E1DBFBF3ECFFFFFDFFF8EFFFF8EDFFF7EEFFF7EDFFF8EDFFF9F0FFFFF9FFFF
        F6FFFFF9FFFFFEFFFEF5FBF1E5FFF7E9FFF7E9FFF3E5FFF2E4FFF1E3FFF0E1FF
        EFE0FFF0DFFFFFF6FFF9E9F3E1D2FEF2E193725D9B918DC5CCD0C8CFD3DDD3CA
        E0DEDCF1EBE4FFFFFDFFFFFFFFF8F2FFF7F0FFF9F1FFF9F0FFF9F0FFFCF3FFFF
        FAFFFFFFFFFFFFFFFFF7FFFFFFFFFFF7FFF6EAFFF4E8FFF4E8FFF4E6FFF1E4FF
        F2E1FFFFF4FFFFFFF9EBDCF6EADEECDBC58C7568BCBFC1C8D0D4C8D0D4D4D0CA
        DEDEDCE9E5E2F8F2EDFFFFFFFFFFFFFFFBF5FFF9F2FFFAF4FFF9F3FFFDF6FFFF
        FFC79D85AA491AE38551C98763FFFFFAFFFCF4FFF7EDFFF5EAFFF3E9FFF5E9FF
        FEF8FFFFFFFCF4E9F5E9DDFFF8EBAC917CAFADAEC8D0D4C8D0D4C8D0D4C8D0D4
        DED6CCE2E3E3EBE8E6F9F4F1FFFFFFFFFFFFFFFDFAFFFAF5FFFCF6FFFFFFF3EA
        E36208009C2F00DF864EA32F00D4AE99FFFFFFFFF9F1FFF6ECFFFAF1FFFFFFFF
        FFFFFDF7EFF5EBE1FCF6EED8C2ADA6A09FC6CED2C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4E3DBD2E2E5E6EBEAE9FAF8F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFD1
        C9480000841B008D1A00630000B48A70FFFFFFFFFFFAFFFFFFFFFFFFFFFFFFFE
        F9F4F6EDE7FFFBF8EFDDCBAAA29CC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C7CFD3DDD6CDE7E7E8EEF0F0F6F5F4FEFEFDFFFFFFFFFFFFFFFFFFFFFF
        FF78523D3B00003D0000571D02FAFAF7FFFFFFFFFFFFFFFFFFFFFFFCFDF7F1F9
        F6F2FFFFFBD3C3B6B3B0ADC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C8D0D4C8D0D4D9D8D5EAE6E2F5F9FBF6F8FAF8F8F6FCFCFBFFFFFFFFFF
        FFFFFFFFCAC2BBBDAFAAF6F7F4FFFFFFFFFFFFFFFDFBFDF9F6FCFAF9FFFFFFFE
        F9F1BBACA1C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8C1BDDED6D0F2F4F5F0F3F5F5F6F7FCFC
        FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF9F9F9F7F8F8FFFFFFFDFAF4BAAEA5BC
        BEC0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C7CDD0D2D6D7DFD7CEE8E4DEEBEA
        EAEBEBEBEBECECEBECECECEBECECEAE9EEE9E2E4DDD4BCBAB7BABDBEC8D0D4C8
        D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4}
    end
    object SAll: TButton
      Left = 316
      Top = 256
      Width = 108
      Height = 25
      Caption = 'Select all'
      TabOrder = 4
      OnClick = SAllClick
    end
    object SNone: TButton
      Left = 423
      Top = 256
      Width = 108
      Height = 25
      Caption = 'Select none'
      TabOrder = 5
      OnClick = SAllClick
    end
    object GroupBox1: TGroupBox
      Left = 320
      Top = 16
      Width = 209
      Height = 177
      Caption = ' Car Info  '
      TabOrder = 6
      object Label1: TLabel
        Left = 56
        Top = 32
        Width = 24
        Height = 13
        Caption = 'none'
      end
      object Label2: TLabel
        Left = 56
        Top = 64
        Width = 24
        Height = 13
        Caption = 'none'
      end
      object Label4: TLabel
        Left = 56
        Top = 96
        Width = 24
        Height = 13
        Caption = 'none'
      end
      object Label5: TLabel
        Left = 8
        Top = 32
        Width = 32
        Height = 13
        Caption = 'Folder:'
      end
      object Label6: TLabel
        Left = 8
        Top = 64
        Width = 38
        Height = 13
        Caption = 'Factory:'
      end
      object Label7: TLabel
        Left = 8
        Top = 96
        Width = 32
        Height = 13
        Caption = 'Model:'
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofExtensionDifferent, ofPathMustExist, ofEnableSizing]
    Left = 664
    Top = 432
  end
  object OpenDialog1: TOpenDialog
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 640
    Top = 432
  end
end