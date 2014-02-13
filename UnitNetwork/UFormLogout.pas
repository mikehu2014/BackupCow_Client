unit UFormLogout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmLogout = class(TForm)
    Label4: TLabel;
    Label5: TLabel;
    lbIp: TLabel;
    lbAccount: TLabel;
    btnLogout: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure SetAccountInfo( ServerIp, Account : string );
  end;

var
  frmLogout: TfrmLogout;

implementation

uses UNetworkControl, UFormLogin, UMainForm, USettingInfo;

{$R *.dfm}

procedure TfrmLogout.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLogout.btnLogoutClick(Sender: TObject);
begin
  Close;

    // ÖØÐÂµÇÂ¼
  NetworkAccountApi.LoginAgain;
end;

procedure TfrmLogout.SetAccountInfo(ServerIp, Account: string);
begin
  lbIp.Caption := ServerIp;
  lbAccount.Caption := Account;
end;

end.
