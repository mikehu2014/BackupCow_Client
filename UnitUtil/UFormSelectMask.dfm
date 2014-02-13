object FrmEnterMask: TFrmEnterMask
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 5
  Caption = 'Enter a Mask'
  ClientHeight = 247
  ClientWidth = 247
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001000800680500001600000028000000100000002000
    0000010008000000000000010000000000000000000000010000000100000000
    0000AE5B1200BF6B1500B4641B00B9671900BC6B1D00B5692200C2701A00C170
    2100C4752400C9772100CC7D2500C97D2900CE7F290099664400CF852B00CD83
    2D00D3872E00DA942500DE9D2B00DF9E2E00CB893500CD8E3B00D38A3100D78B
    3100DA8F3100DC943600D8943800DB993D00DD983D00DFA02F00E0A03200E1A2
    3500E0A53900B79C7300B9A07900C38A4300CF924100CA984F00D2974700D59B
    4A00DCA34A00D9A15000DBA55500DCA65700D8A45A00E3AC4300E4AC4400E1AC
    4C00E6AE4E00E6B14B00E8B24F00E4AE5300E5B05100E9B75600EABB5C00EBBC
    5F00ECBD5E00C3A06200CEA76A00DAA86200D3B37700D2B37E00E2B16300ECBE
    6200E5B97200EDC06400EFC36800EFC56A00EEC56C00F0C66B00F0C66D00F1C9
    6F00E9C17700F2CB7100F2CE7F00D0B78D00DAC29700D5C09E00F4D48A00E4D2
    A400E8D6AC00F5DFAD00F6E3B400F5E4BD00E6DDC700ECE0C900EEE3D000EEE6
    D300F1E7D300F3E8D200F2EEE300F6F0E400F9F0E000FEFFFF00000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000060300000000000000000000000000001512010E0000000000000000
    00000000161E0204000000000000000000000000252107050000000000000000
    00000000272F0A0800000000000000000000000028320B080000000000000000
    000000002A360F0C0000000000000000000000002A3917100000000000000000
    0000000049381C0C00000000000000000000003E453834112400000000000000
    0000414B4745421C181B000000000000003B4F4A48474731181A260000000000
    3F5253545A5957573C2D2A29000000235D5E5C5B585150554D3D4C4E22000035
    2F1313131F1F1F1F1F1F1F213100003A3336383939454239393839323A00FCFF
    0000FC3F0000FC3F0000FC3F0000FC3F0000FC3F0000FC3F0000FC3F0000FC3F
    0000F81F0000F00F0000E0070000C0030000800100008001000080010000}
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 247
    Height = 105
    Align = alTop
    AutoSize = False
    Caption = 
      'Examples:'#13#13'  *.doc '#8211' all Microsoft Word documents'#13#13'  *.xls '#8211' all' +
      ' Microsoft Excel spreadsheets'#13#13'  *.htm '#8211' all HTML files'
    WordWrap = True
    ExplicitWidth = 294
  end
  object Panel1: TPanel
    Left = 0
    Top = 105
    Width = 247
    Height = 110
    Align = alClient
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 281
    ExplicitHeight = 41
    object Label2: TLabel
      Left = 0
      Top = 4
      Width = 31
      Height = 13
      Caption = ' Mask:'
    end
    object mmoMask: TMemo
      Left = 0
      Top = 23
      Width = 247
      Height = 85
      Align = alBottom
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 215
    Width = 247
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 214
    object btnCancel: TButton
      Left = 144
      Top = 7
      Width = 58
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnOK: TButton
      Left = 51
      Top = 7
      Width = 58
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = btnOKClick
    end
  end
end