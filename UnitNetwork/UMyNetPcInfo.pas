unit UMyNetPcInfo;

interface

uses UChangeInfo, Generics.Collections, SyncObjs, SysUtils, UModelUtil, UMyUtil, Math,
     uDebug, DateUtils, UDataSetInfo, classes;

type

{$Region ' Master��Ϣ, ���ݽṹ ' }

  TMasterInfoAddParams = record
  public
    PcID : string;
    ClientCount : Integer; // �ͻ�����
    StartTime : TDateTime;  // �������п�ʼʱ��
    RanNum : Integer;   // �����
  end;

  TMasterInfo = class
  public
    MaxLock : TCriticalSection;
    MaxPcID : string;
    MaxClientCount : Integer;
    MaxStartTime : TDateTime;
    MaxRanNum : Integer;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure ResetMasterPc;
    procedure AddItem( Params : TMasterInfoAddParams );
  end;

{$EndRegion}


{$Region ' ����ģʽ ���ݽṹ ' }

    // Group ������Ϣ
  TNetworkGroupInfo = class
  public
    GroupName : string;
    Password : string;
  public
    constructor Create( _GroupName : string );
    procedure SetPassword( _Password : string );
  end;
  TNetworkGroupList = class( TObjectList< TNetworkGroupInfo > )end;

    // ConnPc ������Ϣ
  TNetworkPcConnInfo = class
  public
    Domain : string;
    Port : string;
  public
    constructor Create( _Domain, _Port : string );
  end;
  TNetworkPcConnList = class( TObjectList< TNetworkPcConnInfo > )end;

    // ����������Ϣ
  TMyNetworkConnInfo = class( TMyDataInfo )
  public  // Զ����������
    NetworkGroupList : TNetworkGroupList;
    NetworkPcConnList : TNetworkPcConnList;
  public  // ѡ�������������ֵ
    SelectType : string;
    SelectValue1, SelectValue2 : string;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{$EndRegion}

{$Region ' ����ģʽ ���ݽӿ� ' }

    // ���� ���� List �ӿ�
  TNetworkGroupListAccessInfo = class
  protected
    NetworkGroupList : TNetworkGroupList;
  public
    constructor Create;
    destructor Destroy; override;
  end;

    // ���� ���ݽӿ�
  TNetworkGroupAccessInfo = class( TNetworkGroupListAccessInfo )
  public
    GroupName : string;
  protected
    NetworkGroupIndex : Integer;
    NetworkGroupInfo : TNetworkGroupInfo;
  public
    constructor Create( _GroupName : string );
  protected
    function FindNetworkGroupInfo: Boolean;
  end;

    // ���� ���� List �ӿ�
  TNetworkPcConnListAccessInfo = class
  protected
    NetworkPcConnList : TNetworkPcConnList;
  public
    constructor Create;
    destructor Destroy; override;
  end;

    // ���� ���ݽӿ�
  TNetworkPcConnAccessInfo = class( TNetworkPcConnListAccessInfo )
  public
    Domain, Port : string;
  protected
    NetworkPcConnIndex : Integer;
    NetworkPcConnInfo : TNetworkPcConnInfo;
  public
    constructor Create( _Domain, _Port : string );
  protected
    function FindNetworkPcConnInfo: Boolean;
  end;

{$EndRegion }

{$Region ' ����ģʽ Group �����޸� ' }

    // �޸ĸ���
  TNetworkGroupWriteInfo = class( TNetworkGroupAccessInfo )
  end;

    // ���
  TNetworkGroupAddInfo = class( TNetworkGroupWriteInfo )
  public
    Password : string;
  public
    procedure SetPassword( _Password : string );
    procedure Update;
  end;

    // �޸�
  TNetworkGroupSetPasswordInfo = class( TNetworkGroupWriteInfo )
  public
    Password : string;
  public
    procedure SetPassword( _Password : string );
    procedure Update;
  end;


    // ɾ��
  TNetworkGroupRemoveInfo = class( TNetworkGroupWriteInfo )
  public
    procedure Update;
  end;



{$EndRegion}

{$Region ' ����ģʽ ConnPc �����޸� ' }

    // �޸ĸ���
  TNetworkPcConnWriteInfo = class( TNetworkPcConnAccessInfo )
  end;


    // ���
  TNetworkPcConnAddInfo = class( TNetworkPcConnWriteInfo )
  public
    procedure Update;
  end;

    // ɾ��
  TNetworkPcConnRemoveInfo = class( TNetworkPcConnWriteInfo )
  public
    procedure Update;
  end;

{$EndRegion}

{$Region ' ����ģʽ Group ���ݶ�ȡ ' }

    // ��ȡ����
  TNetworkGroupReadInfo = class( TNetworkGroupAccessInfo )
  end;

    // ��ȡ ���Ƿ����
  TNetworkGroupReadIsExist = class( TNetworkGroupReadInfo )
  public
    function get : Boolean;
  end;

    // ��ȡ ����
  TNetworkGroupReadPassword = class( TNetworkGroupReadInfo )
  public
    function get : string;
  end;

    // ���� ����Ϣ ��ȡ
  NetworkGroupInfoReadUtil = class
  public
    class function ReadIsExist( Group : string ): Boolean;
    class function ReadPassword( Group : string ): string;
  end;

{$EndRegion}

{$Region ' ����ģʽ ConnToPc ���ݶ�ȡ ' }

    // ��ȡ����
  TNetworkPcConnReadInfo = class( TNetworkPcConnAccessInfo )
  end;


    // ��ȡ ���Ƿ����
  TNetworkPcConnReadIsExist = class( TNetworkPcConnReadInfo )
  public
    function get : Boolean;
  end;

    // ���� ����Ϣ ��ȡ
  NetworkConnToPcInfoReadUtil = class
  public
    class function ReadIsExist( Ip, Port : string ): Boolean;
  end;

{$EndRegion}


{$Region ' ������Ϣ ���ݽṹ ' }

    // ������ Pc ��Ϣ
  TPcInfo = class
  public
    PcID, PcName : string;
    PcHardCode : string;
    Account, Password, ServerIp : string;
    IsLogin : Boolean;
    CopyCount : Integer;
  public
    LanIp, LanPort : string;
    InternetIp, InternetPort : string;
    RealLanIp : string;
  public
    StartTime : TDateTime;
    RanNum : Integer;
  public
    constructor Create;
    procedure SetPcInfo( _PcID, _PcName : string );
    procedure SetPcHardCode( _PcHardCode : string );
    procedure SetLanInfo( _LanIp, _LanPort : string );
    procedure SetInternetInfo( _InternetIp, _InternetPort : string );
    procedure SetSortInfo( _StartTime : TDateTime; _RanNum : Integer );
    procedure SetAccountInfo( _Account, _Password, _ServerIp : string );
    procedure SetIsLogin( _IsLogin : Boolean );
  end;


{$EndRegion}


{$Region ' �ʺ���Ϣ ���ݽṹ ' }

    // �ʺ���Ϣ
  TAccountInfo = class
  public
    ServerIp, AccountName : string;
    BackupList : TStringList;
  public
    constructor Create( _ServerIp, _AccountName : string );
    procedure AddPath( BackupPath : string );
    destructor Destroy; override;
  end;
  TAccountList = class( TObjectList<TAccountInfo> )end;

      // �ҵ��ʺ���Ϣ
  TMyAccountInfo = class( TMyDataInfo )
  public
    AccountList : TAccountList;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{$EndRegion}

{$Region ' �ʺ���Ϣ ���ݷ��� ' }

    // ���� ���� List �ӿ�
  TAccountListAccessInfo = class
  protected
    AccountList : TAccountList;
  public
    constructor Create;
    destructor Destroy; override;
  end;

    // ���� ���ݽӿ�
  TAccountAccessInfo = class( TAccountListAccessInfo )
  public
    ServerIp, AccountName : string;
  protected
    AccountIndex : Integer;
    AccountInfo : TAccountInfo;
  public
    constructor Create( _ServerIp, _AccountName : string );
  protected
    function FindAccountInfo: Boolean;
  end;

    // �޸ĸ���
  TAccountWriteInfo = class( TAccountAccessInfo )
  end;

    // ��ȡ����
  TAccountReadInfo = class( TAccountAccessInfo )
  end;

{$EndRegion}

{$Region ' �ʺ�·�� ���ݷ��� ' }

    // ���� ���ݽӿ�
  TBackupListAccessInfo = class( TAccountAccessInfo )
  public
    BackupPath : string;
  protected
    BackupPathIndex : Integer;
    BackupList : TStringList;
  public
    procedure SetBackupPath( _BackupPath : string );
  protected
    function FindBackupPath: Boolean;
  end;

    // �޸ĸ���
  TBackupListWriteInfo = class( TBackupListAccessInfo )
  end;

    // ��ȡ����
  TBackupListReadInfo = class( TBackupListAccessInfo )
  end;


{$EndRegion}

{$Region ' �ʺ���Ϣ �����޸� ' }

    // ���
  TAccountAddInfo = class( TAccountWriteInfo )
  public
    procedure Update;
  end;

    // ɾ��
  TAccountRemoveInfo = class( TAccountWriteInfo )
  public
    procedure Update;
  end;

{$EndRegion}

{$Region ' �ʺ�·�� ���ݷ��� ' }

    // ���
  TBackupListAddInfo = class( TBackupListWriteInfo )
  public
    procedure Update;
  end;

    // ɾ��
  TBackupListRemoveInfo = class( TBackupListWriteInfo )
  public
    procedure Update;
  end;

{$EndRegion}

{$Region ' �ʺ���Ϣ ���ݶ�ȡ ' }

    // ��ȡ �ʺű�����Ϣ
  TAccountBackupListReadInfo = class( TAccountReadInfo )
  public
    function get : TStringList;
  end;

    // ��ȡ �Ƿ�����ʺű���·��
  TAccountBackupReadExistInfo = class( TBackupListAccessInfo )
  public
    function get : Boolean;
  end;

    // ��ȡ �ʺ�·����Ϣ
  TAccountPathListReadInfo = class( TAccountListAccessInfo )
  private
    Account : string;
  public
    procedure SetAccount( _Account : string );
    function get : TStringList;
  end;

    // �����ʺ�·��
  TAccountPathBackupReasIsExistInfo = class( TAccountListAccessInfo )
  private
    Account, BackupPath : string;
  public
    procedure SetAccount( _Account, _BackupPath : string );
    function get : Boolean;
  end;

    // �ʺű��ݸ�����
  AccountBackupReadUtil = class
  public
    class function ReadBackupList( ServerIp, Account : string ): TStringList;
    class function ReadPathIsExist( ServerIp, Account, BackupPath : string ): Boolean;
  public
    class function ReadAccountPathList( Account : string ): TStringList;
    class function ReadBackupPathIsExist( Account, BackupPath : string ): Boolean;
  end;

{$EndRegion}


{$Region ' ����Pc ���ݽṹ ' }

    // ���� Pc ��Ϣ
  TNetPcInfo = class
  public
    PcID, PcName : string;
    Ip, Port : string;
    IsLanConn, IsConnect : Boolean; // �Ƿ���������ӣ� �Ƿ����ӹ���δ����������ȷ��
    CanConnectTo, CanConnectFrom : Boolean; // �Ƿ��������
  public
    IsActivate, IsOnline, IsServer : Boolean;
  public
    constructor Create( _PcID : string );
    procedure SetPcName( _PcName : string );
    procedure SetSocketInfo( _Ip, _Port : string );
    destructor Destroy; override;
  end;

  TNetPcInfoPair = TPair< string , TNetPcInfo >;
  TNetPcInfoHash = class(TStringDictionary< TNetPcInfo >);

{$EndRegion}

{$Region ' ����Pc ���ݽӿ� ' }

    // ���� ����
  TNetPcAccessInfo = class
  protected
    NetPcInfoHash : TNetPcInfoHash;
  public
    constructor Create;
    destructor Destroy; override;
  end;

    // ���� Item
  TNetPcItemAccessInfo = class( TNetPcAccessInfo )
  public
    PcID : string;
  protected
    NetPcInfo : TNetPcInfo;
  public
    constructor Create( _PcID : string );
  protected
    function FindNetPcInfo: Boolean;
  end;

{$EndRegion}

{$Region ' ����Pc �����޸� ' }

    // �޸�
  TNetPcWriteInfo = class( TNetPcItemAccessInfo )
  end;

  {$Region ' ��ɾ��Ϣ ' }

      // ���� Pc
  TNetPcAddInfo = class( TNetPcWriteInfo )
  public
    PcName : string;
  public
    procedure SetPcName( _PcName : string );
    procedure Update;
  end;

    // ɾ�� Pc
  TNetPcRemoveInfo = class( TNetPcWriteInfo )
  public
    procedure Update;
  end;

  {$EndRegion}

  {$Region ' λ����Ϣ ' }

    // �޸� Socket
  TNetPcSocketInfo = class( TNetPcWriteInfo )
  private
    Ip, Port : string;
    IsLanConn : Boolean;
  public
    procedure SetSocket( _Ip, _Port : string );
    procedure SetIsLanConn( _IsLanConn : Boolean );
    procedure Update;
  end;

      // �Ƿ�����Ӹ� Pc
  TNetPcSetCanConnectToInfo = class( TNetPcWriteInfo )
  private
    CanConnectTo : Boolean;
  public
    procedure SetCanConnectTo( _CanConnectTo : Boolean );
    procedure Update;
  end;

    // �Ƿ�ɱ��� Pc ����
  TNetPcSetCanConnectFromInfo = class( TNetPcWriteInfo )
  private
    CanConnectFrom : Boolean;
  public
    procedure SetCanConnectFrom( _CanConnectFrom : Boolean );
    procedure Update;
  end;

  {$EndRegion}

  {$Region ' ״̬��Ϣ ' }

    // �޸� Online
  TNetPcOnlineInfo = class( TNetPcWriteInfo )
  public
    procedure Update;
  end;

    // �޸� Offline
  TNetPcOfflineInfo = class( TNetPcWriteInfo )
  public
    procedure Update;
  end;

    // �޸� Server
  TNetPcServerInfo = class( TNetPcWriteInfo )
  public
    procedure Update;
  end;

  {$EndRegion}

{$EndRegion}

{$Region ' ����Pc ���ݶ�ȡ ' }

    // ��ȡ��Ϣ ����
  TNetPcReadInfo = class( TNetPcAccessInfo )
  end;

    // ���ߵ� Pc ��Ŀ
  TNetPcReadOnlineCount = class( TNetPcReadInfo )
  public
    function get : Integer;
  end;

    // ��ȡ
  TNetPcReadPcNameByIp = class( TNetPcReadInfo )
  private
    Ip : string;
  public
    procedure SetIp( _Ip : string );
    function get : string;
  end;

    // ��ȡ Item ����
  TNetPcItemReadInfo = class( TNetPcItemAccessInfo )
  end;

    // ��ȡ Pc ��
  TNetPcItemReadName = class( TNetPcItemAccessInfo )
  public
    function get : string;
  end;

    // ��ȡ Ip
  TNetPcItemReadIp = class( TNetPcItemAccessInfo )
  public
    function get : string;
  end;

    // ��ȡ Port
  TNetPcItemReadPort = class( TNetPcItemAccessInfo )
  public
    function get : string;
  end;

    // ��ȡ �Ƿ�����
  TNetPcItemReadIsOnline = class( TNetPcItemAccessInfo )
  public
    function get : Boolean;
  end;

      // ��ȡ �Ƿ��Ѿ����ӹ�
  TNetPcReadIsConnect = class( TNetPcItemAccessInfo )
  public
    function get : Boolean;
  end;

    // ��ȡ �Ƿ� ��������
  TNetPcReadIsCanConnectTo = class( TNetPcItemAccessInfo )
  public
    function get : Boolean;
  end;


      // ��ȡ �Ƿ� ���Ա�����
  TNetPcReadIsCanConnectFrom = class( TNetPcItemAccessInfo )
  public
    function get : Boolean;
  end;

      // ��ȡ �Ƿ� ����������
  TNetPcReadIsLanPc = class( TNetPcItemAccessInfo )
  public
    function get : Boolean;
  end;

    // ��ȡ Pc ���ÿռ�
  TNetPcItemReadAvailableSpace = class( TNetPcItemAccessInfo )
  public
    function get : Int64;
  end;

      // ��ȡ���ڻ�� Pc �б�
  TNetPcReadActivateList = class( TNetPcAccessInfo )
  public
    function get : TStringList;
  end;

    // ��ȡ Pc ����
  TNetPcReadCount = class( TNetPcAccessInfo )
  public
    function get : Integer;
  end;

    // ��ȡ ������
  MyNetPcInfoReadUtil = class
  public
    class function ReadName( PcID : string ): string;
    class function ReadIp( PcID : string ): string;
    class function ReadPort( PcID : string ): string;
    class function ReadIsOnline( PcID : string ): Boolean;
    class function ReadIsConnect( PcID : string ): Boolean;
    class function ReadIsCanConnectTo( PcID : string ): Boolean;
    class function ReadIsCanConnectFrom( PcID : string ): Boolean;
    class function ReadPcNameByIp( Ip : string ): string;
    class function ReadIsLanPc( PcID : string ): Boolean;
  public
    class function ReadDesItemShow( DesItemID : string ): string;
    class function ReadActivatePcList : TStringList;
    class function ReadPcCount : Integer;
  end;

{$EndREgion}


    // ���� Pc ��Ϣ ����
  TMyNetPcInfo = class( TMyDataInfo )
  public
    NetPcInfoHash : TNetPcInfoHash; // ���� Pc ��Ϣ
  public
    constructor Create;
    destructor Destroy; override;
  end;

const
  NetworkMode_LAN : string = 'LAN';  // ������
  NetworkMode_Standard : string = 'Standard';  // ��˾��
  NetworkMode_Advance : string = 'Advance';  // Internet

  BackupPriority_Alway = 'Alway';
  BackupPriority_Never = 'Nerver';
  BackupPriority_High = 'High';
  BackupPriority_Normal = 'Normal';
  BackupPriority_Low = 'Low';

var   // ��ʼ�� ��Ϣ
  Time_LastOnlineBackup : TDateTime = 0;

var
  PcInfo : TPcInfo;
  MasterInfo : TMasterInfo;
  MyNetPcInfo : TMyNetPcInfo;
  MyNetworkConnInfo : TMyNetworkConnInfo;
  MyAccountInfo : TMyAccountInfo;

implementation

uses UNetworkFace, USearchServer, USettingInfo, UNetworkControl;

{ TNetPcInfo }

constructor TNetPcInfo.Create( _PcID : string );
begin
  IsOnline := False;
  IsServer := False;
  IsActivate := False;
  IsConnect := False;
  CanConnectTo := True;
  CanConnectFrom := True;
  PcID := _PcID;
end;

destructor TNetPcInfo.Destroy;
begin
  inherited;
end;

procedure TNetPcInfo.SetPcName(_PcName: string);
begin
  PcName := _PcName;
end;

procedure TNetPcInfo.SetSocketInfo(_Ip, _Port: string);
begin
  Ip := _Ip;
  Port := _Port;
end;


{ TMySearchServerInfo }

constructor TMyNetPcInfo.Create;
begin
  inherited;
  NetPcInfoHash := TNetPcInfoHash.Create;
end;

destructor TMyNetPcInfo.Destroy;
begin
  NetPcInfoHash.Free;
  inherited;
end;


{ TSearchPcAddInfo }

procedure TNetPcAddInfo.SetPcName(_PcName: string);
begin
  PcName := _PcName;
end;

{ TNetPcOnlineInfo }

procedure TNetPcOnlineInfo.Update;
begin
    // ������
  if not FindNetPcInfo then
    Exit;

  NetPcInfo.IsOnline := True;
end;

{ TNetPcServerInfo }

procedure TNetPcServerInfo.Update;
begin
    // ������
  if not FindNetPcInfo then
    Exit;

  NetPcInfo.IsServer := True;
end;

{ TNetPcSocketInfo }

procedure TNetPcSocketInfo.SetIsLanConn(_IsLanConn: Boolean);
begin
  IsLanConn := _IsLanConn;
end;

procedure TNetPcSocketInfo.SetSocket(_Ip, _Port: string);
begin
  Ip := _Ip;
  Port := _Port;
end;

procedure TNetPcSocketInfo.Update;
begin
      // ������
  if not FindNetPcInfo then
    Exit;

  NetPcInfo.SetSocketInfo( Ip, Port );
  NetPcInfo.IsLanConn := IsLanConn;
  NetPcInfo.IsConnect := True; // �����ӹ�
end;

{ TNetPcRemoveInfo }

procedure TNetPcRemoveInfo.Update;
begin
    // ������
  if not FindNetPcInfo then
    Exit;

  NetPcInfoHash.Remove( PcID );
end;

procedure TNetPcAddInfo.Update;
begin
    // �������򴴽�
  if not FindNetPcInfo then
  begin
    NetPcInfo := TNetPcInfo.Create( PcID );
    NetPcInfoHash.AddOrSetValue( PcID, NetPcInfo );
  end;
  NetPcInfo.PcName := PcName;  // ����
  NetPcInfo.IsActivate := True; // ����Pc
end;

{ TNetPcOfflineInfo }

procedure TNetPcOfflineInfo.Update;
begin
    // ������
  if not FindNetPcInfo then
    Exit;

  NetPcInfo.IsOnline := False;
  NetPcInfo.IsServer := False;
  NetPcInfo.IsActivate := False;
  NetPcInfo.IsConnect := False;
  NetPcInfo.CanConnectTo := True;
  NetPcInfo.CanConnectFrom := True;
end;

{ TNetPcAccessInfo }

constructor TNetPcAccessInfo.Create;
begin
  MyNetPcInfo.EnterData;
  NetPcInfoHash := MyNetPcInfo.NetPcInfoHash;
end;

destructor TNetPcAccessInfo.Destroy;
begin
  MyNetPcInfo.LeaveData;
  inherited;
end;

{ TNetPcItemAccessInfo }

constructor TNetPcItemAccessInfo.Create(_PcID: string);
begin
  inherited Create;
  PcID := _PcID;
end;

function TNetPcItemAccessInfo.FindNetPcInfo: Boolean;
begin
  Result := NetPcInfoHash.ContainsKey( PcID );
  if Result then
    NetPcInfo := NetPcInfoHash[ PcID ];
end;

{ MyNetPcInfoReadUtil }



class function MyNetPcInfoReadUtil.ReadActivatePcList: TStringList;
var
  NetPcReadActivateList : TNetPcReadActivateList;
begin
  NetPcReadActivateList := TNetPcReadActivateList.Create;
  Result := NetPcReadActivateList.get;
  NetPcReadActivateList.Free;
end;

class function MyNetPcInfoReadUtil.ReadDesItemShow(DesItemID: string): string;
var
  DesPcID, DesPcName : string;
begin
  DesPcID := NetworkDesItemUtil.getPcID( DesItemID );
  DesPcName := ReadName( DesPcID );
  Result := NetworkDesItemUtil.getDesItemShowName( DesItemID, DesPcName );
end;

class function MyNetPcInfoReadUtil.ReadIp(PcID: string): string;
var
  NetPcItemReadIp : TNetPcItemReadIp;
begin
  NetPcItemReadIp := TNetPcItemReadIp.Create( PcID );
  Result := NetPcItemReadIp.get;
  NetPcItemReadIp.Free;
end;

class function MyNetPcInfoReadUtil.ReadIsCanConnectFrom(PcID: string): Boolean;
var
  NetPcReadIsCanConnectFrom : TNetPcReadIsCanConnectFrom;
begin
  NetPcReadIsCanConnectFrom := TNetPcReadIsCanConnectFrom.Create( PcID );
  Result := NetPcReadIsCanConnectFrom.get;
  NetPcReadIsCanConnectFrom.Free;
end;

class function MyNetPcInfoReadUtil.ReadIsCanConnectTo(PcID: string): Boolean;
var
  NetPcReadIsCanConnectTo : TNetPcReadIsCanConnectTo;
begin
  NetPcReadIsCanConnectTo := TNetPcReadIsCanConnectTo.Create( PcID );
  Result := NetPcReadIsCanConnectTo.get;
  NetPcReadIsCanConnectTo.Free;
end;

class function MyNetPcInfoReadUtil.ReadIsConnect(PcID: string): Boolean;
var
  NetPcReadIsConnect : TNetPcReadIsConnect;
begin
  NetPcReadIsConnect := TNetPcReadIsConnect.Create( PcID );
  Result := NetPcReadIsConnect.get;
  NetPcReadIsConnect.Free;
end;

class function MyNetPcInfoReadUtil.ReadIsLanPc(PcID: string): Boolean;
var
  NetPcReadIsLanPc : TNetPcReadIsLanPc;
begin
  NetPcReadIsLanPc := TNetPcReadIsLanPc.Create( PcID );
  Result := NetPcReadIsLanPc.get;
  NetPcReadIsLanPc.Free;
end;

class function MyNetPcInfoReadUtil.ReadIsOnline(PcID: string): Boolean;
var
  NetPcItemReadIsOnline : TNetPcItemReadIsOnline;
begin
  NetPcItemReadIsOnline := TNetPcItemReadIsOnline.Create( PcID );
  Result := NetPcItemReadIsOnline.get;
  NetPcItemReadIsOnline.Free;
end;

class function MyNetPcInfoReadUtil.ReadName(PcID: string): string;
var
  NetPcItemReadName : TNetPcItemReadName;
begin
  NetPcItemReadName := TNetPcItemReadName.Create( PcID );
  Result := NetPcItemReadName.get;
  NetPcItemReadName.Free;
end;

class function MyNetPcInfoReadUtil.ReadPcCount: Integer;
var
  NetPcReadCount : TNetPcReadCount;
begin
  NetPcReadCount := TNetPcReadCount.Create;
  Result := NetPcReadCount.get;
  NetPcReadCount.Free;
end;

class function MyNetPcInfoReadUtil.ReadPort(PcID: string): string;
var
  NetPcItemReadPort : TNetPcItemReadPort;
begin
  NetPcItemReadPort := TNetPcItemReadPort.Create( PcID );
  Result := NetPcItemReadPort.get;
  NetPcItemReadPort.Free;
end;

{ TNetPcItemReadPcName }

function TNetPcItemReadName.get: string;
begin
  if not FindNetPcInfo then
    Result := PcID
  else
    Result := NetPcInfo.PcName;
end;

{ TNetPcItemReadSocket }

function TNetPcItemReadIp.get: string;
begin
  Result := '';
  if not FindNetPcInfo then
    Exit;
  Result := NetPcInfo.Ip;
end;

{ TNetPcItemReadIsOnline }

function TNetPcItemReadIsOnline.get: Boolean;
begin
  Result := False;
  if not FindNetPcInfo then
    Exit;
  Result := NetPcInfo.IsOnline;
end;

{ TNetPcItemReadPort }

function TNetPcItemReadPort.get: string;
begin
  Result := '';
  if not FindNetPcInfo then
    Exit;
  Result := NetPcInfo.Port;
end;

{ TNetPcReadActivateCount }

function TNetPcReadOnlineCount.get: Integer;
var
  p : TNetPcInfoPair;
begin
  Result := 0;
  for p in NetPcInfoHash do
    if p.Value.IsOnline then
      Inc( Result );
end;

{ TNetPcItemReadAvailableSpace }

function TNetPcItemReadAvailableSpace.get: Int64;
begin
  Result := 10000000000;
end;

{ TNetworkGroupInfo }

constructor TNetworkGroupInfo.Create(_GroupName: string);
begin
  GroupName := _GroupName;
end;

procedure TNetworkGroupInfo.SetPassword(_Password: string);
begin
  Password := _Password;
end;

{ TMyNetworkConnInfo }

constructor TMyNetworkConnInfo.Create;
begin
  inherited;
  NetworkGroupList := TNetworkGroupList.Create;
  NetworkPcConnList := TNetworkPcConnList.Create;
  SelectType := SelectConnType_Local;
end;

destructor TMyNetworkConnInfo.Destroy;
begin
  NetworkGroupList.Free;
  NetworkPcConnList.Free;
  inherited;
end;

{ TNetworkPcConnInfo }

constructor TNetworkPcConnInfo.Create(_Domain, _Port: string);
begin
  Domain := _Domain;
  Port := _Port;
end;

{ TNetworkGroupListAccessInfo }

constructor TNetworkGroupListAccessInfo.Create;
begin
  MyNetworkConnInfo.EnterData;
  NetworkGroupList := MyNetworkConnInfo.NetworkGroupList;
end;

destructor TNetworkGroupListAccessInfo.Destroy;
begin
  MyNetworkConnInfo.LeaveData;
  inherited;
end;

{ TNetworkGroupAccessInfo }

constructor TNetworkGroupAccessInfo.Create( _GroupName : string );
begin
  inherited Create;
  GroupName := _GroupName;
end;

function TNetworkGroupAccessInfo.FindNetworkGroupInfo: Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to NetworkGroupList.Count - 1 do
    if ( NetworkGroupList[i].GroupName = GroupName ) then
    begin
      Result := True;
      NetworkGroupIndex := i;
      NetworkGroupInfo := NetworkGroupList[i];
      break;
    end;
end;

{ TNetworkGroupAddInfo }

procedure TNetworkGroupAddInfo.SetPassword( _Password : string );
begin
  Password := _Password;
end;

procedure TNetworkGroupAddInfo.Update;
begin
  if FindNetworkGroupInfo then
    Exit;

  NetworkGroupInfo := TNetworkGroupInfo.Create( GroupName );
  NetworkGroupInfo.SetPassword( Password );
  NetworkGroupList.Add( NetworkGroupInfo );
end;

{ TNetworkGroupRemoveInfo }

procedure TNetworkGroupRemoveInfo.Update;
begin
  if not FindNetworkGroupInfo then
    Exit;

  NetworkGroupList.Delete( NetworkGroupIndex );
end;


{ TNetworkGroupSetPasswordInfo }

procedure TNetworkGroupSetPasswordInfo.SetPassword( _Password : string );
begin
  Password := _Password;
end;

procedure TNetworkGroupSetPasswordInfo.Update;
begin
  if not FindNetworkGroupInfo then
    Exit;
  NetworkGroupInfo.Password := Password;
end;

{ TNetworkPcConnListAccessInfo }

constructor TNetworkPcConnListAccessInfo.Create;
begin
  MyNetworkConnInfo.EnterData;
  NetworkPcConnList := MyNetworkConnInfo.NetworkPcConnList;
end;

destructor TNetworkPcConnListAccessInfo.Destroy;
begin
  MyNetworkConnInfo.LeaveData;
  inherited;
end;

{ TNetworkPcConnAccessInfo }

constructor TNetworkPcConnAccessInfo.Create( _Domain, _Port : string );
begin
  inherited Create;
  Domain := _Domain;
  Port := _Port;
end;

function TNetworkPcConnAccessInfo.FindNetworkPcConnInfo: Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to NetworkPcConnList.Count - 1 do
    if ( NetworkPcConnList[i].Domain = Domain ) and ( NetworkPcConnList[i].Port = Port ) then
    begin
      Result := True;
      NetworkPcConnIndex := i;
      NetworkPcConnInfo := NetworkPcConnList[i];
      break;
    end;
end;

{ TNetworkPcConnAddInfo }

procedure TNetworkPcConnAddInfo.Update;
begin
  if FindNetworkPcConnInfo then
    Exit;

  NetworkPcConnInfo := TNetworkPcConnInfo.Create( Domain, Port );
  NetworkPcConnList.Add( NetworkPcConnInfo );
end;

{ TNetworkPcConnRemoveInfo }

procedure TNetworkPcConnRemoveInfo.Update;
begin
  if not FindNetworkPcConnInfo then
    Exit;

  NetworkPcConnList.Delete( NetworkPcConnIndex );
end;




{ NetworkGroupInfoReadUtil }

class function NetworkGroupInfoReadUtil.ReadIsExist(Group: string): Boolean;
var
  NetworkGroupReadIsExist : TNetworkGroupReadIsExist;
begin
  NetworkGroupReadIsExist := TNetworkGroupReadIsExist.Create( Group );
  Result := NetworkGroupReadIsExist.get;
  NetworkGroupReadIsExist.Free;
end;

class function NetworkGroupInfoReadUtil.ReadPassword(Group: string): string;
var
  NetworkGroupReadPassword : TNetworkGroupReadPassword;
begin
  NetworkGroupReadPassword := TNetworkGroupReadPassword.Create( Group );
  Result := NetworkGroupReadPassword.get;
  NetworkGroupReadPassword.Free;
end;

{ TNetworkGroupReadIsExist }

function TNetworkGroupReadIsExist.get: Boolean;
begin
  Result := FindNetworkGroupInfo;
end;

{ TNetworkGroupReadPassword }

function TNetworkGroupReadPassword.get: string;
begin
  Result := '';
  if not FindNetworkGroupInfo then
    Exit;
  Result := NetworkGroupInfo.Password;
end;

{ TNetworkPcConnReadIsExist }

function TNetworkPcConnReadIsExist.get: Boolean;
begin
  Result := FindNetworkPcConnInfo;
end;

{ NetworkConnToPcInfoReadUtil }

class function NetworkConnToPcInfoReadUtil.ReadIsExist(Ip,
  Port: string): Boolean;
var
  NetworkPcConnReadIsExist : TNetworkPcConnReadIsExist;
begin
  NetworkPcConnReadIsExist := TNetworkPcConnReadIsExist.Create( Ip, Port );
  Result := NetworkPcConnReadIsExist.get;
  NetworkPcConnReadIsExist.Free;
end;

{ TPcInfo }

constructor TPcInfo.Create;
begin
  IsLogin := False;
end;

procedure TPcInfo.SetAccountInfo(_Account, _Password, _ServerIp: string);
begin
  Account := _Account;
  Password := _Password;
  ServerIp := _ServerIp;
end;

procedure TPcInfo.SetInternetInfo(_InternetIp, _InternetPort: string);
begin
  InternetIp := _InternetIp;
  InternetPort := _InternetPort;
end;

procedure TPcInfo.SetIsLogin(_IsLogin: Boolean);
begin
  IsLogin := _IsLogin;
end;

procedure TPcInfo.SetLanInfo(_LanIp, _LanPort: string);
begin
  LanIp := _LanIp;
  LanPort := _LanPort;

  RealLanIp := LanIp;
end;

procedure TPcInfo.SetPcHardCode(_PcHardCode: string);
begin
  PcHardCode := _PcHardCode;
end;

procedure TPcInfo.SetPcInfo(_PcID, _PcName: string);
begin
  PcID := _PcID;
  PcName := _PcName;
end;

procedure TPcInfo.SetSortInfo(_StartTime: TDateTime; _RanNum: Integer);
begin
  StartTime := _StartTime;
  RanNum := _RanNum;
end;

{ TMasterInfo }

procedure TMasterInfo.AddItem(Params: TMasterInfoAddParams);
var
  IsBigger : Boolean;
begin
    // ����
  if Params.PcID = PcInfo.PcID then
    Exit;

    // ����Ƿ����� Pc
  MaxLock.Enter;
  IsBigger := False;
  if Params.ClientCount > MaxClientCount then
    IsBigger := True
  else
  if Params.ClientCount = MaxClientCount then
  begin
    if Params.StartTime < MaxStartTime then
      IsBigger := True
    else
    if MaxStartTime = Params.StartTime then
      IsBigger := Params.RanNum > MaxRanNum;
  end;
  if IsBigger then
  begin
    MaxPcID := Params.PcID;
    MaxClientCount := Params.ClientCount;
    MaxStartTime := Params.StartTime;
    MaxRanNum := Params.RanNum;
  end;
  MaxLock.Leave;
end;

constructor TMasterInfo.Create;
begin
  MaxLock := TCriticalSection.Create;
end;

destructor TMasterInfo.Destroy;
begin
  MaxLock.Free;
  inherited;
end;

procedure TMasterInfo.ResetMasterPc;
begin
  MaxLock.Enter;
  MaxPcID := PcInfo.PcID;
  MaxClientCount := 0;
  MaxStartTime := PcInfo.StartTime;
  MaxRanNum := PcInfo.RanNum;
  MaxLock.Leave;
end;



{ TNetPcReadActivateList }

function TNetPcReadActivateList.get: TStringList;
var
  p : TNetPcInfoPair;
begin
  Result := TStringList.Create;
  for p in NetPcInfoHash do
    if p.Value.IsActivate then
      Result.Add( p.Value.PcID );
end;

{ TNetPcSetCanConnectToInfo }

procedure TNetPcSetCanConnectToInfo.SetCanConnectTo(_CanConnectTo: Boolean);
begin
  CanConnectTo := _CanConnectTo;
end;

procedure TNetPcSetCanConnectToInfo.Update;
begin
  if not FindNetPcInfo then
    Exit;

  NetPcInfo.CanConnectTo := CanConnectTo;
end;

{ TNetPcSetCanConnectFromInfo }

procedure TNetPcSetCanConnectFromInfo.SetCanConnectFrom(_CanConnectFrom: Boolean);
begin
  CanConnectFrom := _CanConnectFrom;
end;

procedure TNetPcSetCanConnectFromInfo.Update;
begin
  if not FindNetPcInfo then
    Exit;

  NetPcInfo.CanConnectFrom := CanConnectFrom;
end;

{ TNetPcReadIsConnect }

function TNetPcReadIsConnect.get: Boolean;
begin
  Result := False;
  if not FindNetPcInfo then
    Exit;
  Result := NetPcInfo.IsConnect;
end;

{ TNetPcReadIsCanConnectTo }

function TNetPcReadIsCanConnectTo.get: Boolean;
begin
  Result := False;
  if not FindNetPcInfo then
    Exit;
  Result := NetPcInfo.CanConnectTo;
end;

{ TNetPcReadIsCanConnectFrom }

function TNetPcReadIsCanConnectFrom.get: Boolean;
begin
  Result := False;
  if not FindNetPcInfo then
    Exit;
  Result := NetPcInfo.CanConnectFrom;
end;

{ TNetPcReadCount }

function TNetPcReadCount.get: Integer;
begin
  Result := NetPcInfoHash.Count;
end;

{ TNetPcReadPcIDByIp }

function TNetPcReadPcNameByIp.get: string;
var
  p : TNetPcInfoPair;
begin
  Result := '';
  for p in NetPcInfoHash do
    if p.Value.Ip = Ip then
      Result := p.Value.PcName;
end;

procedure TNetPcReadPcNameByIp.SetIp(_Ip: string);
begin
  Ip := _Ip;
end;

class function MyNetPcInfoReadUtil.ReadPcNameByIp(Ip: string): string;
var
  NetPcReadPcNameByIp : TNetPcReadPcNameByIp;
begin
  NetPcReadPcNameByIp := TNetPcReadPcNameByIp.Create;
  NetPcReadPcNameByIp.SetIp( Ip );
  Result := NetPcReadPcNameByIp.get;
  NetPcReadPcNameByIp.Free;
end;

{ TNetPcReadIsLanPc }

function TNetPcReadIsLanPc.get: Boolean;
begin
  Result := True;
  if not FindNetPcInfo then
    Exit;
  Result := MyNetworkConnUtil.getIsLanIp( NetPcInfo.Ip );
end;

{ TAccountInfo }

procedure TAccountInfo.AddPath(BackupPath: string);
begin
  BackupList.Add( BackupPath );
end;

constructor TAccountInfo.Create( _ServerIp, _AccountName : string );
begin
  ServerIp := _ServerIp;
  AccountName := _AccountName;
  BackupList := TStringList.Create;
end;

destructor TAccountInfo.Destroy;
begin
  BackupList.Free;
  inherited;
end;

{ TMyAccountInfo }

constructor TMyAccountInfo.Create;
begin
  inherited;
  AccountList := TAccountList.Create;
end;

destructor TMyAccountInfo.Destroy;
begin
  AccountList.Free;
  inherited;
end;

{ TAccountListAccessInfo }

constructor TAccountListAccessInfo.Create;
begin
  MyAccountInfo.EnterData;
  AccountList := MyAccountInfo.AccountList;
end;

destructor TAccountListAccessInfo.Destroy;
begin
  MyAccountInfo.LeaveData;
  inherited;
end;

{ TAccountAccessInfo }

constructor TAccountAccessInfo.Create( _ServerIp, _AccountName : string );
begin
  inherited Create;
  ServerIp := _ServerIp;
  AccountName := _AccountName;
end;

function TAccountAccessInfo.FindAccountInfo: Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to AccountList.Count - 1 do
    if ( AccountList[i].ServerIp = ServerIp ) and
       ( AccountList[i].AccountName = AccountName )
    then
    begin
      Result := True;
      AccountIndex := i;
      AccountInfo := AccountList[i];
      break;
    end;
end;

{ TAccountAddInfo }

procedure TAccountAddInfo.Update;
begin
  if FindAccountInfo then
    Exit;

  AccountInfo := TAccountInfo.Create( ServerIp, AccountName );
  AccountList.Add( AccountInfo );
end;

{ TAccountRemoveInfo }

procedure TAccountRemoveInfo.Update;
begin
  if not FindAccountInfo then
    Exit;

  AccountList.Delete( AccountIndex );
end;

{ TBackupListAccessInfo }

procedure TBackupListAccessInfo.SetBackupPath( _BackupPath : string );
begin
  BackupPath := _BackupPath;
end;


function TBackupListAccessInfo.FindBackupPath: Boolean;
var
  i : Integer;
begin
  Result := False;
  if not FindAccountInfo then
    Exit;
  BackupList := AccountInfo.BackupList;
  for i := 0 to BackupList.Count - 1 do
    if BackupList[i] = BackupPath then
    begin
      Result := True;
      BackupPathIndex := i;
      break;
    end;
end;

{ TBackupListAddInfo }

procedure TBackupListAddInfo.Update;
begin
  if FindBackupPath then
    Exit;

  BackupList.Add( BackupPath );
end;

{ TBackupListRemoveInfo }

procedure TBackupListRemoveInfo.Update;
begin
  if not FindBackupPath then
    Exit;

  BackupList.Delete( BackupPathIndex );
end;




{ TAccountBackupListReadInfo }

function TAccountBackupListReadInfo.get: TStringList;
var
  BackupList : TStringList;
  i: Integer;
begin
  Result := TStringList.Create;
  if not FindAccountInfo then
    Exit;
  BackupList := AccountInfo.BackupList;
  for i := 0 to BackupList.Count - 1 do
    Result.Add( BackupList[i] );
end;

{ AccountBackupReadUtil }

class function AccountBackupReadUtil.ReadAccountPathList(
  Account: string): TStringList;
var
  AccountPathListReadInfo : TAccountPathListReadInfo;
begin
  AccountPathListReadInfo := TAccountPathListReadInfo.Create;
  AccountPathListReadInfo.SetAccount( Account );
  Result := AccountPathListReadInfo.get;
  AccountPathListReadInfo.Free;
end;

class function AccountBackupReadUtil.ReadBackupList(
  ServerIp, Account: string): TStringList;
var
  AccountBackupListReadInfo : TAccountBackupListReadInfo;
begin
  AccountBackupListReadInfo := TAccountBackupListReadInfo.Create( ServerIp, Account );
  Result := AccountBackupListReadInfo.get;
  AccountBackupListReadInfo.Free;
end;

class function AccountBackupReadUtil.ReadBackupPathIsExist(Account,
  BackupPath: string): Boolean;
var
  AccountPathBackupReasIsExistInfo : TAccountPathBackupReasIsExistInfo;
begin
  AccountPathBackupReasIsExistInfo := TAccountPathBackupReasIsExistInfo.Create;
  AccountPathBackupReasIsExistInfo.SetAccount( Account, BackupPath );
  Result := AccountPathBackupReasIsExistInfo.get;
  AccountPathBackupReasIsExistInfo.Free;
end;

class function AccountBackupReadUtil.ReadPathIsExist(ServerIp, Account,
  BackupPath: string): Boolean;
var
  AccountBackupReadExistInfo : TAccountBackupReadExistInfo;
begin
  AccountBackupReadExistInfo := TAccountBackupReadExistInfo.Create( ServerIp, Account );
  AccountBackupReadExistInfo.SetBackupPath( BackupPath );
  Result := AccountBackupReadExistInfo.get;
  AccountBackupReadExistInfo.Free;
end;

{ TAccountBackupReadExistInfo }

function TAccountBackupReadExistInfo.get: Boolean;
begin
  Result := FindBackupPath;
end;

{ TAccountPathListReadInfo }

function TAccountPathListReadInfo.get: TStringList;
var
  i: Integer;
  j: Integer;
begin
  Result := TStringList.Create;
  for i := 0 to AccountList.Count - 1 do
    if AccountList[i].AccountName = Account then
      for j := 0 to AccountList[i].BackupList.Count - 1 do
        Result.Add( AccountList[i].BackupList[j] );
end;

procedure TAccountPathListReadInfo.SetAccount(_Account: string);
begin
  Account := _Account;
end;

{ TAccountPathBackupReasIsExistInfo }

function TAccountPathBackupReasIsExistInfo.get: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to AccountList.Count - 1 do
    if ( AccountList[i].AccountName = Account ) and
       ( AccountList[i].BackupList.IndexOf( BackupPath ) >= 0 )
    then
    begin
      Result := True;
      Break;
    end;
end;

procedure TAccountPathBackupReasIsExistInfo.SetAccount(_Account, _BackupPath: string);
begin
  Account := _Account;
  BackupPath := _BackupPath;
end;

end.
