unit UFormLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzTabs, Vcl.StdCtrls, Sockets,
  Vcl.ExtCtrls, RzButton, Vcl.Menus, IniFiles, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ImgList;

type
  TfrmLogin = class(TForm)
    PcMain: TRzPageControl;
    tsSingup: TRzTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtSignupAccount: TEdit;
    edtSignupPassword: TEdit;
    btnSignup: TButton;
    Label7: TLabel;
    edtSignupPassword2: TEdit;
    lbLogin: TLinkLabel;
    tsLogin: TRzTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    tbtnLogin: TRzToolButton;
    edtLoginAccount: TEdit;
    edtLoginPassword: TEdit;
    btnLogin: TButton;
    lbSignup: TLinkLabel;
    pmServer: TPopupMenu;
    miAdd: TMenuItem;
    sl1: TMenuItem;
    ilServer: TImageList;
    sl2: TMenuItem;
    tbtnSignup: TRzToolButton;
    procedure btnLoginClick(Sender: TObject);
    procedure btnLoginCancelClick(Sender: TObject);
    procedure btnSignupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLoginNewClick(Sender: TObject);
    procedure btnMoreClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbSignupLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure lbLoginClick(Sender: TObject);
    procedure PcMainPageChange(Sender: TObject);
    procedure edtLoginAccountKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtLoginPasswordKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSignupAccountKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSignupPasswordKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSignupPassword2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miAddClick(Sender: TObject);
    procedure miSelectClick(Sender: TObject);
  private
    IpList : TStringList;
    procedure SaveIpList;
    procedure LoadIpList;
    function InputIp: string;
  public
    function FindAutoAvaileblePos : Integer;
    function FindManualAvaileblePos : Integer;
    function ReadIsCloudExist( CloudName : string ): Boolean;
    function ReadIsIpExist( IpStr : string ): Boolean;
    procedure AddIpToFace( IpStr, CloudName : string; IsAuto : Boolean );
    procedure RemoveIpFromFace( IpStr : string );
    procedure RemoveInputIpFromFace( IpStr : string );
    procedure ShowIpButton( IpStr, CloudName : string );
    function ReadIpList : TStringList;
  private
    IsOK : Boolean;
    function CheckLogin : Boolean;
    function CheckSignup : Boolean;
  end;



  TSignupAccountHandle = class
  private
    ServerIP : string;
    Account, Password : string;
  private
    TcpSocket : TCustomIpClient;
  public
    constructor Create( _ServerIP : string );
    procedure SetAccountInfo( _Account, _Password : string );
    function Update: Boolean;
    destructor Destroy; override;
  public
    function ConnectToServer : Boolean;
    function Signup : Boolean;
    procedure LoginNow;
  end;

  
var
  frmLogin: TfrmLogin;

implementation

uses UNetworkControl, UMyTcp, UMyUtil, UFormNewSettings, UMainForm, UChangeInfo, ULanguageConst;

{$R *.dfm}

function TfrmLogin.InputIp: string;
begin
  Result := '';
  if not InputQuery( 'Input', 'IP or Domain', Result ) then
    Exit;
  if Result = '' then
    Exit;
  if IpList.IndexOf( Result ) < 0 then
  begin
    IpList.Add( Result );
    AddIpToFace( Result, '', False );
  end
  else
    Result := '';
end;

procedure TfrmLogin.AddIpToFace(IpStr, CloudName: string;
  IsAuto : Boolean);
var
  mi : TMenuItem;
  InsertPos : Integer;
begin
    // 不存在则添加
  if not ReadIsCloudExist( CloudName ) then
  begin
    mi := TMenuItem.Create( pmServer );
    mi.Hint := IpStr;
    mi.OnClick := miSelectClick;
    if CloudName <> '' then
    begin
      mi.Caption := CloudName;
      if IsAuto then
        InsertPos := FindAutoAvaileblePos
      else
        InsertPos := FindManualAvaileblePos;
    end
    else
    begin
      mi.Caption := IpStr;
      InsertPos := pmServer.Items.Count - 2;
      mi.Enabled := False;
    end;
    pmServer.Items.Insert( InsertPos, mi );
    if ( tbtnLogin.Caption = '' ) and ( CloudName <> '' ) then
      ShowIpButton( IpStr, CloudName )
    else
    if ( IpStr = tbtnLogin.Hint ) and ( CloudName = tbtnLogin.Caption ) then
      ShowIpButton( IpStr, CloudName );
  end;
end;

procedure TfrmLogin.btnLoginCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
var
  ShowStr : string;
  ServerIp, Account, Password : string;
  ServerPort : string;
  ServerInfoList : TStringList;
begin
    // 输入信息不正确
  if not CheckLogin then
    Exit;

    // 提取信息
  ServerIp := tbtnLogin.Hint;
  ItemShow_CloudName := tbtnLogin.Caption;
  ServerPort := '8484';
  Account := edtLoginAccount.Text;
  Password := edtLoginPassword.Text;

    // 可能输入服务器端口
  ServerInfoList := MySplitStr.getList( ServerIp, ':' );
  if ServerInfoList.Count = 2 then
  begin
    ServerIp := ServerInfoList[0];
    ServerPort := ServerInfoList[1];
  end;
  ServerInfoList.Free;

    // 添加帐号
  NetworkAccountApi.AddAccount( ServerIp, Account );

    // 记录本次选择
  MyPcInfoApi.SetAccountInfo( Account, Password, ServerIp, ShowStr );

    // 进入网络
  NetworkModeApi.EnterConnToPc( ServerIp, ServerPort );

    // 点击登录
  IsOK := True;

    // 关闭登录窗口
  Close;
end;

procedure TfrmLogin.btnLoginNewClick(Sender: TObject);
begin
  PcMain.ActivePage := tsLogin;
end;

procedure TfrmLogin.btnMoreClick(Sender: TObject);
begin
  frmNewSettings.ShowIpSetting;
end;

procedure TfrmLogin.btnSignupClick(Sender: TObject);
var
  SignupAccountHandle : TSignupAccountHandle;
begin
    // 信息不完善
  if not CheckSignup then
    Exit;
  
  SignupAccountHandle := TSignupAccountHandle.Create( tbtnSignup.Hint );
  SignupAccountHandle.SetAccountInfo( edtSignupAccount.Text, edtSignupPassword.Text );
  SignupAccountHandle.Update;
  SignupAccountHandle.Free;
end;

function TfrmLogin.CheckLogin: Boolean;
begin
  Result := False;
  if edtLoginAccount.Text = '' then
    MyMessageBox.ShowWarnning( LanguageInfo.frmLogin_LoginWarnning_InputAccountName )
  else
  if edtLoginPassword.Text = '' then
    MyMessageBox.ShowWarnning( LanguageInfo.frmLogin_LoginWarnning_InputPassword )
  else
    Result := True;
end;

function TfrmLogin.CheckSignup: Boolean;
begin
  Result := False;
  if edtSignupAccount.Text = '' then
    MyMessageBox.ShowWarnning( LanguageInfo.frmLogin_LoginWarnning_InputAccountName )
  else
  if edtSignupPassword.Text = '' then
    MyMessageBox.ShowWarnning( LanguageInfo.frmLogin_LoginWarnning_InputPassword )
  else
  if edtSignupPassword2.Text <> edtSignupPassword.Text then
    MyMessageBox.ShowWarnning( LanguageInfo.frmLogin_LoginWarnning_PasswordNotMatch )
  else
    Result := True;
end;

procedure TfrmLogin.edtLoginAccountKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
    selectnext(twincontrol(sender),true,true);
end;

procedure TfrmLogin.edtLoginPasswordKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
    selectnext(twincontrol(sender),true,true);
end;

procedure TfrmLogin.edtSignupAccountKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
    selectnext(twincontrol(sender),true,true);
end;

procedure TfrmLogin.edtSignupPassword2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
    selectnext(twincontrol(sender),true,true);
end;

procedure TfrmLogin.edtSignupPasswordKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
    selectnext(twincontrol(sender),true,true);
end;

function TfrmLogin.FindAutoAvaileblePos: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to pmServer.Items.Count - 1 do
    if pmServer.Items[i].Caption = '-' then
    begin
      Result := i;
      Break;
    end;
end;

function TfrmLogin.FindManualAvaileblePos: Integer;
var
  i: Integer;
  IsFind : Boolean;
begin
  Result := 0;
  IsFind := False;
  for i := 0 to pmServer.Items.Count - 1 do
  begin
    if pmServer.Items[i].Caption = '-' then
    begin
      if IsFind then  // 第二条分割线
      begin
        Result := i;
        Break;
      end;
      IsFind := True;
    end;
    if not IsFind then
      Continue;
    if not pmServer.Items[i].Enabled then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    // 成功
  if IsOK then
    frmMainForm.ShowMainForm
  else
  begin
    frmMainForm.tmrExit.Interval := 500;
    frmMainForm.tmrExit.Enabled := True;
  end;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  IpList := TStringList.Create;
  LoadIpList;
end;

procedure TfrmLogin.FormDestroy(Sender: TObject);
begin
  SaveIpList;
  IpList.Free;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  miAdd.Caption := LanguageInfo.frmLogin_ItemCaption_AddServerIp;
  ModalResult := mrCancel;
  PcMain.ActivePage := tsLogin;
  IsOK := False;
end;

procedure TfrmLogin.lbLoginClick(Sender: TObject);
begin
  PcMain.ActivePage := tsLogin;
end;

procedure TfrmLogin.lbSignupLinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  PcMain.ActivePage := tsSingup;
end;

procedure TfrmLogin.LoadIpList;
var
  IniFile : TIniFile;
  IpCount, i: Integer;
  IpStr : string;
  DefIpStr, DefCloudName : string;
begin
  IniFile := TIniFile.Create( MyIniFile.getIniFilePath );
  DefCloudName := IniFile.ReadString( Self.Name, tbtnLogin.Name + 'CloudName', tbtnLogin.Caption );
  DefIpStr := IniFile.ReadString( Self.Name, tbtnLogin.Name + 'IP', tbtnLogin.Hint );
  IpCount := IniFile.ReadInteger( Self.Name, tbtnLogin.Name + 'Count', 0 );
  for i := 0 to IpCount - 1 do
  begin
    IpStr := IniFile.ReadString( Self.Name, tbtnLogin.Name + IntToStr(i), '' );
    if ( IpStr <> '' ) and ( IpList.IndexOf( IpStr ) < 0 ) then
    begin
      IpList.Add( IpStr );
      AddIpToFace( IpStr, '', False );
    end;
  end;
  IniFile.Free;
  ShowIpButton( DefIpStr, DefCloudName );
end;


procedure TfrmLogin.miAddClick(Sender: TObject);
var
  IpStr, CloudName : string;
begin
  IpStr := InputIp;
  if IpStr = '' then
    Exit;
TThread.CreateAnonymousThread(
procedure
begin
  CloudName := MyTcpUtil.ReadCloudName( IpStr, '8484' );
  MyFaceChange.Sync(
  procedure
  begin
    if CloudName <> '' then
    begin
      RemoveIpFromFace( IpStr );
      AddIpToFace( IpStr, CloudName, False );
      ShowIpButton( IpStr, CloudName );
    end;
  end);
end).Start;
end;

procedure TfrmLogin.miSelectClick(Sender: TObject);
var
  mi : TMenuItem;
begin
  mi := Sender as TMenuItem;
  ShowIpButton( mi.Hint, mi.Caption );
end;

procedure TfrmLogin.PcMainPageChange(Sender: TObject);
var
  ShowStr : string;
begin
  ShowStr := 'BackupCow - ';
  if PcMain.ActivePage = tsLogin then
    ShowStr := ShowStr + LanguageInfo.frmLogin_Title_Login
  else
  if PcMain.ActivePage = tsSingup then
    ShowStr := ShowStr + LanguageInfo.frmLogin_Title_Signup;
  Self.Caption := ShowStr;
end;

function TfrmLogin.ReadIpList: TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 0 to IpList.Count - 1 do
    Result.Add( IpList[i] );
end;

function TfrmLogin.ReadIsCloudExist(CloudName: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to pmServer.Items.Count - 1 do
    if pmServer.Items[i].Caption = CloudName then
    begin
      Result := True;
      Break;
    end;
end;

function TfrmLogin.ReadIsIpExist(IpStr: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to pmServer.Items.Count - 1 do
    if pmServer.Items[i].Hint = IpStr then
    begin
      Result := True;
      Break;
    end;
end;

procedure TfrmLogin.RemoveInputIpFromFace(IpStr: string);
var
  i: Integer;
begin
  for i := pmServer.Items.Count - 1 downto 0 do
    if not pmServer.Items[i].Enabled and ( pmServer.Items[i].Hint = IpStr ) then
    begin
      pmServer.Items.Delete( i );
      Break;
    end;
end;

procedure TfrmLogin.RemoveIpFromFace(IpStr: string);
var
  i: Integer;
begin
  for i := pmServer.Items.Count - 1 downto 0 do
    if pmServer.Items[i].Hint = IpStr then
    begin
      pmServer.Items.Delete( i );
      Break;
    end;
end;

procedure TfrmLogin.SaveIpList;
var
  IniFile : TIniFile;
  i: Integer;
begin
  IniFile := TIniFile.Create( MyIniFile.getIniFilePath );
  IniFile.WriteString( Self.Name, tbtnLogin.Name + 'CloudName', tbtnLogin.Caption );
  IniFile.WriteString( Self.Name, tbtnLogin.Name + 'IP', tbtnLogin.Hint );
  IniFile.WriteInteger( Self.Name, tbtnLogin.Name + 'Count', IpList.Count );
  for i := 0 to IpList.Count - 1 do
    IniFile.WriteString( Self.Name, tbtnLogin.Name + IntToStr(i), IpList[i] );
  IniFile.Free;
end;

procedure TfrmLogin.ShowIpButton(IpStr, CloudName: string);
var
  i: Integer;
  IsSelected : Boolean;
begin
  tbtnLogin.Caption := CloudName;
  tbtnLogin.Hint := IpStr;
  tbtnSignup.Caption := CloudName;
  tbtnSignup.Hint := IpStr;

  for i := 0 to pmServer.Items.Count - 2 do
  begin
    IsSelected := pmServer.Items[i].Caption = CloudName;;
    pmServer.Items[i].Checked := IsSelected;
    pmServer.Items[i].Default := IsSelected;
  end;
end;

{ TSignupAccountHandle }

function TSignupAccountHandle.ConnectToServer: Boolean;
var
  ServerPort : string;
  ServerInfoList : TStringList;
  MyTcpConn : TMyTcpConn;
  DomainStr : string;
begin
  ServerIp := MyServerUtil.getIp( ServerIP );

    // 默认端口
  ServerPort := '8484';

    // 可能输入服务器端口
  ServerInfoList := MySplitStr.getList( ServerIp, ':' );
  if ServerInfoList.Count = 2 then
  begin
    ServerIp := ServerInfoList[0];
    ServerPort := ServerInfoList[1];
  end;
  ServerInfoList.Free;

    // 域名
  if not MyParseHost.IsIpStr( ServerIP ) then
  begin
    DomainStr := ServerIP;
    if not MyParseHost.HostToIP( DomainStr, ServerIP ) then  // 无法解析
    begin
      MyMessageBox.ShowWarnning( LanguageInfo.frmLogin_SignupWarnning_NotConnect );
      Exit;
    end;
  end;


    // 连接对方
  MyTcpConn := TMyTcpConn.Create( TcpSocket );
  MyTcpConn.SetConnSocket( ServerIP, ServerPort );
  MyTcpConn.SetConnType( ConnType_AccountSignup );
  Result := MyTcpConn.Conn;
  MyTcpConn.Free;

    // 无法连接
  if not Result then
    MyMessageBox.ShowWarnning( LanguageInfo.frmLogin_SignupWarnning_NotConnect );
end;

constructor TSignupAccountHandle.Create(_ServerIP: string);
begin
  ServerIP := _ServerIP;
  TcpSocket := TCustomIpClient.Create( nil );
end;

destructor TSignupAccountHandle.Destroy;
begin
  TcpSocket.Free;
  inherited;
end;

procedure TSignupAccountHandle.LoginNow;
begin
  with frmLogin do
  begin
    edtLoginAccount.Text := Account;
    edtLoginPassword.Text := Password;
    btnLogin.Click;
  end;
end;

procedure TSignupAccountHandle.SetAccountInfo(_Account, _Password: string);
begin
  Account := _Account;
  Password := _Password;
end;

function TSignupAccountHandle.Signup: Boolean;
var
  SignupResult : string;
begin
    // 发送注册信息
  MySocketUtil.SendJsonStr( TcpSocket, JsonMsgType_SignupAccount, Account );
  MySocketUtil.SendJsonStr( TcpSocket, JsonMsgType_SignupPassword, Password );
  SignupResult := MySocketUtil.RevJsonStr( TcpSocket );
  Result := SignupResult = SignupResult_Completed;

    // 判断注册结果
  if SignupResult = SignupResult_AccountExist then
    MyMessageBox.ShowWarnning( LanguageInfo.frmLogin_SignupWarnning_AccountExist )
  else
  if SignupResult = SignupResult_AccountNotEnough then
    MyMessageBox.ShowWarnning( LanguageInfo.frmLogin_SignupWarnning_AccountNotEnough )
  else
  if SignupResult = SignupResult_Completed then
    MyMessageBox.ShowOk( LanguageInfo.frmLogin_SignupWarnning_Completed );
end;

function TSignupAccountHandle.Update: Boolean;
begin
  Result := ConnectToServer and Signup;
  if Result then  // 立刻登录
    LoginNow;
end;

end.
