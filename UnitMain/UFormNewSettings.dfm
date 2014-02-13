object frmNewSettings: TfrmNewSettings
  Tag = 10
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Settings'
  ClientHeight = 223
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001000800680500001600000028000000100000002000
    0000010008000000000000010000000000000000000000010000000100000000
    00009B4C08009A5112009A541300A24C0000A6520000AC550000B45B0B00A157
    1600BE670A00B2631D009E5C24009A633800A3612700A4612C00B76B2100B675
    3E00CE751B00E3760600E37F1400A8704300A0734F00A77D5A00C8803100CA80
    3400D18E3800DA8D3D00E98E3300EDA53D00B3835B00BA967900BE9A7E00CD8B
    4500DF954400D5924A00C8885000CF8F5700D3925700E4974700E09B5000EBA6
    4000F0B25000F4BA5600CC976800C69F7E00DFA46700CBA07A00D5A57A00D3B3
    7F00E3BA7800F5C36800F3CB7200F3CB7F00FDE27E00BC9B8100D7BD8F00EAC2
    8600EBC78C00F3D08C00FFF09900FEEBB200FEF4B900E8DECB00FEFCF6000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000040400000000000000000000020000161919150000360000000000
    072A021F0D29290B1E0C0201000000303B3B2A022929290F090F28021F000000
    303B3B2A3238383A2828280F00000000000D3B3B191919193A28280F0000000D
    0D35351900000000193A280F0F00123F3C3C3C140000000019391C1C1705133F
    3C3C3C080000000019311C1C1706002E1B3C3C080000000019342D0A1D000000
    00213C3C080814193B33172C00000000243C3C3C3C3C3C3C3D3B331000000000
    3F3F3C273C3C3C3C223D3B20000000003E3F2500263F3F1A00233D1100000000
    000000002F3E3E2B00000000000000000000000000373700000000000000FE7F
    0000EC370000C003000080010000C0030000E003000083C1000003C0000003C0
    000083C10000E0030000C0030000C0030000C4230000FC3F0000FE7F0000}
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object plMain: TPanel
    Left = 0
    Top = 0
    Width = 296
    Height = 223
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object plButtons: TPanel
      Left = 0
      Top = 182
      Width = 296
      Height = 41
      Align = alBottom
      BevelEdges = [beTop]
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 0
      object btnOK: TButton
        Tag = 10
        Left = 53
        Top = 8
        Width = 75
        Height = 25
        Caption = 'OK'
        TabOrder = 0
        OnClick = btnOKClick
      end
      object btnCancel: TButton
        Tag = 10
        Left = 174
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Cancel'
        TabOrder = 1
        OnClick = btnCancelClick
      end
    end
    object plCenter: TPanel
      Left = 0
      Top = 0
      Width = 296
      Height = 182
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object lbAccount: TLabel
        Tag = 10
        Left = 39
        Top = 154
        Width = 43
        Height = 13
        Caption = 'Account:'
      end
      object lbAccountName: TLabel
        Left = 89
        Top = 154
        Width = 19
        Height = 13
        Caption = 'Hao'
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 296
        Height = 143
        Align = alTop
        BevelEdges = [beBottom]
        BevelKind = bkFlat
        BevelOuter = bvNone
        TabOrder = 0
        object Label3: TLabel
          Tag = 10
          Left = 22
          Top = 50
          Width = 74
          Height = 13
          Caption = 'Copy Quantity:'
        end
        object lbLanguage: TLabel
          Tag = 10
          Left = 22
          Top = 112
          Width = 51
          Height = 13
          Caption = 'Language:'
        end
        object edtBackupSpeed: TEdit
          Left = 112
          Top = 14
          Width = 108
          Height = 21
          Enabled = False
          NumbersOnly = True
          TabOrder = 0
          Text = '512'
        end
        object edtCopyQuantity: TEdit
          Left = 112
          Top = 47
          Width = 108
          Height = 21
          NumbersOnly = True
          TabOrder = 1
          Text = '2'
        end
        object chkBackupSpeed: TCheckBox
          Tag = 10
          Left = 22
          Top = 16
          Width = 86
          Height = 17
          Caption = 'Backup Speed:'
          TabOrder = 2
          OnClick = chkBackupSpeedClick
        end
        object cbbSpeedType: TComboBox
          Left = 221
          Top = 14
          Width = 51
          Height = 21
          Style = csDropDownList
          Enabled = False
          ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
          ItemIndex = 0
          TabOrder = 3
          Text = 'KB / S'
          Items.Strings = (
            'KB / S'
            'MB / S')
        end
        object chkShowAppExistDialog: TCheckBox
          Tag = 10
          Left = 22
          Top = 79
          Width = 266
          Height = 17
          Caption = 'Start application when Windows starts up.'
          TabOrder = 4
        end
        object cbbLanguage: TComboBox
          Tag = 10
          Left = 112
          Top = 109
          Width = 108
          Height = 21
          Style = csDropDownList
          ItemIndex = 1
          TabOrder = 5
          Text = 'Chinese'
          Items.Strings = (
            'English'
            'Chinese')
        end
      end
      object btnChangePassword: TButton
        Tag = 10
        Left = 175
        Top = 149
        Width = 97
        Height = 25
        Caption = 'Change Password'
        TabOrder = 1
        OnClick = btnChangePasswordClick
      end
    end
  end
end
