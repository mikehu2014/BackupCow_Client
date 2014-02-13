unit UFormNewSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, IniFiles;

type
  TfrmNewSettings = class(TForm)
    plMain: TPanel;
    plButtons: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    plCenter: TPanel;
    Panel1: TPanel;
    Label3: TLabel;
    edtBackupSpeed: TEdit;
    edtCopyQuantity: TEdit;
    chkBackupSpeed: TCheckBox;
    cbbSpeedType: TComboBox;
    chkShowAppExistDialog: TCheckBox;
    lbAccount: TLabel;
    lbAccountName: TLabel;
    btnChangePassword: TButton;
    lbLanguage: TLabel;
    cbbLanguage: TComboBox;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure chkBackupSpeedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnChangePasswordClick(Sender: TObject);
  public
    LastLanguageIndex : Integer;
  private
    LastCopyCount : Integer;
    LastIpList : TStringList;
    IsAutoRun : Boolean;
  private
    procedure SaveToIni;
    procedure LoadFromIni;
  private
    function ReadDefaultLanguage : Integer;
  public
    procedure SetAcccount( AccountName : string );
    function ResetLimit( IsLimit : Boolean; LimitValue, LimitType : Integer ) : Boolean;
  public
    procedure ShowNormalSetting;
    procedure ShowIpSetting;
  end;

    // 点击 OK 处理
  TSettingOKHandle = class
  public
    procedure Update;
  private
    procedure ResetCopyCount;
    procedure ResetBackupSpeed;
    procedure ResetIpList;
    procedure ResetAutoRun;
    procedure ResetLanguage;
  end;

    // 点击 Cancel 取消
  TSettingCancelHandle = class
  public
    procedure Update;
  private
    procedure ResetCopyCount;
    procedure ResetIpList;
    procedure ResetAutoRun;
  end;

const
  LanguageIndex_English = 0;
  LanguageIndex_Chinese = 1;

const
  Ini_NewSettings = 'NewSettings';
  Ini_IpCount = 'IpCount';
  Ini_IpStr = 'IpStr';
  Ini_AutoRun = 'AutoRun';

var
  frmNewSettings: TfrmNewSettings;

implementation

uses UNetworkControl, UMyBackupApiInfo, UMyUtil, URegisterInfoIO, UFormPasswordChange, UMainForm;

{$R *.dfm}

procedure TfrmNewSettings.btnCancelClick(Sender: TObject);
var
  SettingCancelHandle : TSettingCancelHandle;
begin
  SettingCancelHandle := TSettingCancelHandle.Create;
  SettingCancelHandle.Update;
  SettingCancelHandle.Free;

  Close;
end;

procedure TfrmNewSettings.btnChangePasswordClick(Sender: TObject);
begin
  Close;
  frmChangePassword.Show;
end;

procedure TfrmNewSettings.btnOKClick(Sender: TObject);
var
  SettingOKHandle : TSettingOKHandle;
begin
  SettingOKHandle := TSettingOKHandle.Create;
  SettingOKHandle.Update;
  SettingOKHandle.Free;

  Close;
end;

procedure TfrmNewSettings.chkBackupSpeedClick(Sender: TObject);
var
  IsEnable : Boolean;
begin
  IsEnable := chkBackupSpeed.Checked;
  edtBackupSpeed.Enabled := IsEnable;
  cbbSpeedType.Enabled := IsEnable;
end;

procedure TfrmNewSettings.FormCreate(Sender: TObject);
begin
  LastIpList := TStringList.Create;
  LoadFromIni;
end;

procedure TfrmNewSettings.FormDestroy(Sender: TObject);
begin
  SaveToIni;
  LastIpList.Free;
end;

procedure TfrmNewSettings.LoadFromIni;
var
  IniFile : TIniFile;
  IpCount, i: Integer;
  IpStr : string;
  DefaultLanguage : Integer;
begin
    // 程序默认语言
  DefaultLanguage := ReadDefaultLanguage;

  IniFile := TIniFile.Create( MyIniFile.getIniFilePath );
  try
  IpCount := IniFile.ReadInteger( Ini_NewSettings, Ini_IpCount, 0 );
  for i := 0 to IpCount - 1 do
  begin
    IpStr := IniFile.ReadString( Ini_NewSettings, Ini_IpStr + IntToStr( i ), '' );
    if IpStr = '' then
      Continue;
  end;
  IsAutoRun := IniFile.ReadBool( Ini_NewSettings, Ini_AutoRun, False );
  chkShowAppExistDialog.Checked := IsAutoRun;
  cbbLanguage.ItemIndex := IniFile.ReadInteger( Self.Name, cbbLanguage.Name, DefaultLanguage );
  LastLanguageIndex := cbbLanguage.ItemIndex;
  except
  end;
  IniFile.Free;
end;

function TfrmNewSettings.ReadDefaultLanguage: Integer;
var
  FilePath, LanguageStr : string;
  IniFile : TIniFile;
begin
  FilePath := ExtractFilePath( Application.ExeName ) + 'Language\Default.ini';
  IniFile := TIniFile.Create( FilePath );
  LanguageStr := IniFile.ReadString( 'Language', 'Default', Language_English );
  if LanguageStr = Language_English then
    Result := LanguageIndex_English
  else
  if LanguageStr = Language_Chinese then
    Result := LanguageIndex_Chinese;
  IniFile.Free;
end;

function TfrmNewSettings.ResetLimit(IsLimit: Boolean; LimitValue,
  LimitType: Integer): Boolean;
begin
    // 是否限制
  chkBackupSpeed.Checked := IsLimit;

    // 速度信息
  edtBackupSpeed.Text := IntToStr( LimitValue );
  if ( LimitType < cbbSpeedType.Items.Count ) and ( LimitType >= 0 ) then
    cbbSpeedType.ItemIndex := LimitType;
end;

procedure TfrmNewSettings.SaveToIni;
var
  IniFile : TIniFile;
  i: Integer;
begin
  IniFile := TIniFile.Create( MyIniFile.getIniFilePath );
  try
    IniFile.WriteBool( Ini_NewSettings, Ini_AutoRun, IsAutoRun );
    IniFile.WriteInteger( Self.Name, cbbLanguage.Name, cbbLanguage.ItemIndex );
  except
  end;
  IniFile.Free;
end;

procedure TfrmNewSettings.SetAcccount(AccountName: string);
begin
  lbAccountName.Caption := AccountName;
end;

procedure TfrmNewSettings.ShowIpSetting;
begin
  Self.Height := 225;
  Show;
end;

procedure TfrmNewSettings.ShowNormalSetting;
begin
//  plGenernal.Visible := True;
//  Self.Height := 330;
  Show;
end;

{ TSettingOKHandle }

procedure TSettingOKHandle.ResetAutoRun;
var
  IsAutoRun : Boolean;
begin
  IsAutoRun := frmNewSettings.chkShowAppExistDialog.Checked;
  if frmNewSettings.IsAutoRun = IsAutoRun then
    Exit;

    // win 7 需要管理员权限
  if not RunAppStartupUtil.Startup( IsAutoRun ) then
    if not MyAppAdminRunasUtil.StartUp( IsAutoRun ) then // 修改失败, 取消操作
    begin
      frmNewSettings.chkShowAppExistDialog.Checked := not IsAutoRun;
      Exit;
    end;

  frmNewSettings.IsAutoRun := IsAutoRun;
end;

procedure TSettingOKHandle.ResetBackupSpeed;
var
  IsLimit, NewIsLimit : Boolean;
  LimitType, LimitValue : Integer;
  NewLimitType, NewLimitValue : Integer;
begin
    // 旧信息
  IsLimit := BackupSpeedInfoReadUtil.getIsLimit;
  LimitType := BackupSpeedInfoReadUtil.getLimitType;
  LimitValue := BackupSpeedInfoReadUtil.getLimitValue;

    // 新信息
  NewIsLimit := frmNewSettings.chkBackupSpeed.Checked;
  NewLimitType := frmNewSettings.cbbSpeedType.ItemIndex;
  NewLimitValue := StrToIntDef( frmNewSettings.edtBackupSpeed.Text, 1 );

    // 没有发生变化
  if ( IsLimit = NewIsLimit ) and ( LimitType = NewLimitType ) and ( LimitValue = NewLimitValue ) then
    Exit;

    // 重新设置
  BackupSpeedApi.SetLimit( NewIsLimit, NewLimitType, NewLimitValue );
end;

procedure TSettingOKHandle.ResetCopyCount;
var
  CopyCountNow : Integer;
begin
  CopyCountNow := StrToIntDef( frmNewSettings.edtCopyQuantity.Text, 2 );
  if CopyCountNow = frmNewSettings.LastCopyCount then
    Exit;
  NetworkAccountApi.SetRemoteCopyCount( CopyCountNow );
  BackupItemUserApi.BackupAllItem;
  frmNewSettings.LastCopyCount := CopyCountNow;
end;

procedure TSettingOKHandle.ResetIpList;
begin
  frmNewSettings.SaveToIni;
end;

procedure TSettingOKHandle.ResetLanguage;
begin
  with frmNewSettings do
  begin
    if LastLanguageIndex <> cbbLanguage.ItemIndex then
    begin
      if cbbLanguage.ItemIndex = LanguageIndex_English then
        frmMainForm.LoadLangauge( Language_English )
      else
      if cbbLanguage.ItemIndex = LanguageIndex_Chinese then
        frmMainForm.LoadLangauge( Language_Chinese );
      LastLanguageIndex := cbbLanguage.ItemIndex;
    end;
  end;
end;

procedure TSettingOKHandle.Update;
begin
    // 重设 备份副本数
  ResetCopyCount;

    // 重设 备份速度
  ResetBackupSpeed;

    // 重设 Ip列表
  ResetIpList;

    // 重设开机自动运行
  ResetAutoRun;

    // 重设 程序语言
  ResetLanguage;
end;

{ TSettingCancelHandle }

procedure TSettingCancelHandle.ResetAutoRun;
begin
  frmNewSettings.chkShowAppExistDialog.Checked := frmNewSettings.IsAutoRun;
end;

procedure TSettingCancelHandle.ResetCopyCount;
begin
  frmNewSettings.edtCopyQuantity.Text := IntToStr( frmNewSettings.LastCopyCount );
end;

procedure TSettingCancelHandle.ResetIpList;
begin

end;

procedure TSettingCancelHandle.Update;
begin
    // 重设 Copy 数
  ResetCopyCount;

    // 重设 Ip 列表
  ResetIpList;

    // 重设开机自动运行
  ResetAutoRun;
end;

end.
