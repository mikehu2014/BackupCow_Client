object frmChangePassword: TfrmChangePassword
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Change Password'
  ClientHeight = 172
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object plMain: TPanel
    Left = 0
    Top = 0
    Width = 298
    Height = 172
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 88
    ExplicitTop = 112
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Label1: TLabel
      Left = 30
      Top = 32
      Width = 65
      Height = 13
      Caption = 'Old Password'
    end
    object Label2: TLabel
      Left = 30
      Top = 59
      Width = 70
      Height = 13
      Caption = 'New Password'
    end
    object Label3: TLabel
      Left = 30
      Top = 86
      Width = 84
      Height = 13
      Caption = 'Retype Password'
    end
    object edtOldPassword: TEdit
      Left = 117
      Top = 29
      Width = 148
      Height = 21
      TabOrder = 0
      OnKeyUp = edtOldPasswordKeyUp
    end
    object edtNewPassword: TEdit
      Left = 117
      Top = 56
      Width = 148
      Height = 21
      TabOrder = 1
      OnKeyUp = edtNewPasswordKeyUp
    end
    object edtNewPassword2: TEdit
      Left = 117
      Top = 83
      Width = 148
      Height = 21
      TabOrder = 2
      OnKeyUp = edtNewPassword2KeyUp
    end
    object btnOK: TButton
      Left = 55
      Top = 128
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 3
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 171
      Top = 128
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 4
      OnClick = btnCancelClick
    end
  end
end
