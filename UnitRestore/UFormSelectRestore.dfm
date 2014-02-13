object frmSelectRestore: TfrmSelectRestore
  Tag = 10
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Restore to...'
  ClientHeight = 131
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001000800680500001600000028000000100000002000
    0000010008000000000000010000000000000000000000010000000100000000
    000045755C00149C2C002E883C00229237001CAC3B0019B0380022AA3E001384
    4C00348E44001EBF400020B2400028BA480034B851002198670025AB74002FA8
    7400548771004ABC7E0027C84C002CC4540031C5580037D264003FD4610047D3
    6F0047DB6A004CDE780055E07B0051E27D0057E87E0048759300497B9D004C7D
    9F00268F8C002DB4BC005ABA9B004F81A1005486A500598CA6005A8CA8006B97
    AE00799CAE004FB0A2002EC1A20056C682005AD3820069DB85006EDB9D005DE7
    84005FEB8A0063EE8D0068EF93007EE79A0076F39E004CD2B7002D9ED60032AA
    E50032AEE60037ADE70026B0E5003CB0E7003DB1E8005BB1D60044B3E30042B3
    E60044B8E70042B4E90049B7EA0045B9E90040BBED0044BAEC0044BEED0049BB
    E9004FBEEA004ABBEC0048BFEC0053BCE90051BEEC0065BFE3007BDDC40063D6
    D9004BC0ED004EC1ED005BC0E70053C1EA0057C1ED0059C2ED005EC5EF005EC9
    F10060CAEF006FCAEF006ACCEF006DCDEF0075C4E00072CEEF0075CDEF0071CE
    F00076CFF10070D1F3007DD2F2007FD8F4009FDFAE00A1DEAE0093E9AC0081ED
    BF00A0F1B8008DB7C8008DB8C80091B8C80094B9C80096BCC9009ABDC900B7E3
    C000B6E9C50080CAE1008DD4EC0082D4F20085D5F30080D5F4008AD7F3008AD8
    F1008DD9F40091D8F10092DAF40094DBF50096DCF400C1ECCC00FDFDFD000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000282611090403011E1F1F24242729000039
    0F0B0D700702083739393A3D3F00002214157E7F660502213C4040434600002B
    1618717F650C060E3F404A4D460000361C1A677F2E130A104D56565647000050
    3331697F3419172A5A5A61615800005A683532301D1C125D7676777962000076
    794F2F2D2C23727779797B7C640000797B7B7B7353414646484D54564E000061
    615C5C593B464B4B4B4B4B543E0000006B6B6B6A6C6C6D6D6D6C6F6F00000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    0000FFFF0000FFFF000080010000800100008001000080010000800100008001
    000080010000800100008001000080010000C0030000FFFF0000FFFF0000}
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Tag = 10
    Left = 10
    Top = 21
    Width = 65
    Height = 13
    Caption = 'Source Path: '
  end
  object Label3: TLabel
    Tag = 10
    Left = 10
    Top = 51
    Width = 58
    Height = 13
    Caption = 'Restore to: '
  end
  object edtPath: TEdit
    Left = 87
    Top = 21
    Width = 237
    Height = 21
    TabStop = False
    BorderStyle = bsNone
    Color = clBtnFace
    ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
    ReadOnly = True
    TabOrder = 0
  end
  object btnBrows: TButton
    Tag = 10
    Left = 327
    Top = 46
    Width = 62
    Height = 25
    Caption = 'Browse...'
    TabOrder = 1
    OnClick = btnBrowsClick
  end
  object btnCancel: TButton
    Tag = 10
    Left = 212
    Top = 88
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnOK: TButton
    Tag = 10
    Left = 100
    Top = 88
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = btnOKClick
  end
  object cbbRestoreTo: TComboBox
    Left = 84
    Top = 48
    Width = 237
    Height = 21
    ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
    TabOrder = 4
  end
  object tmrDetails: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrDetailsTimer
    Left = 336
    Top = 82
  end
end
