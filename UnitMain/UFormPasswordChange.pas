unit UFormPasswordChange;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmChangePassword = class(TForm)
    plMain: TPanel;
    Label1: TLabel;
    edtOldPassword: TEdit;
    Label2: TLabel;
    edtNewPassword: TEdit;
    Label3: TLabel;
    edtNewPassword2: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    procedure edtOldPasswordKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNewPasswordKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNewPassword2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  frmChangePassword: TfrmChangePassword;

implementation

uses UMyNetPcInfo, USearchServer, UMyUtil, UFormSetting, UNetworkControl;

{$R *.dfm}

procedure TfrmChangePassword.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmChangePassword.btnOKClick(Sender: TObject);
begin
    // ‘≠√‹¬Î¥ÌŒÛ
  if PcInfo.Password <> edtOldPassword.Text then
  begin
    MyMessageBox.ShowWarnning( ShowForm_PasswordError );
    Exit;
  end;

    //  ‰»Î√‹¬Î
  if edtNewPassword.Text = '' then
  begin
    MyMessageBox.ShowWarnning( ShowHint_InputPassword );
    Exit;
  end;

    // √‹¬Î≤ª∆•≈‰
  if edtNewPassword.Text <> edtNewPassword2.Text then
  begin
    MyMessageBox.ShowWarnning( ShowHint_PasswordNotMatch );
    Exit;
  end;

    // ∑¢ÀÕ√‹¬Î–ﬁ∏ƒ
  MyMessageBox.ShowOk( 'Completed' );
  NetworkAccountMsgApi.ChangePassword( PcInfo.Account, edtNewPassword.Text );
  Close;
end;

procedure TfrmChangePassword.edtNewPassword2KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Return then
    selectnext(twincontrol(sender),true,true);
end;

procedure TfrmChangePassword.edtNewPasswordKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
    selectnext(twincontrol(sender),true,true);
end;

procedure TfrmChangePassword.edtOldPasswordKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
    selectnext(twincontrol(sender),true,true);
end;

end.
