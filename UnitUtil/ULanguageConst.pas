unit ULanguageConst;

interface

type

    // ÓïÑÔÊôÐÔ
  TLanguageInfo = class
  public
    frmLogin_Title_Login : string;
    frmLogin_Title_Signup : string;
    frmMain_SbMyStatus_NotConn : string;
    frmMain_SbMyStatus_Conning : string;
    frmMain_SbMyStatus_Conn : string;
    frmMain_BtnRestore_Hide : string;
    frmMain_BtnRestore_Show : string;
  public
    frmSelectBackup_Title_AddItem : string;
    frmSelectBackup_Title_ItemProperties : string;
    frmSelectBackup_AutoBackup_Min : string;
    frmSelectBackup_AutoBackup_Hour : string;
    frmSelectBackup_AutoBackup_Day : string;
    frmSelectBackup_AutoBackup_Week : string;
    frmSelectBackup_AutoBackup_Month : string;
  public
    frmMain_BackupHint_BackupItem : string;
    frmMain_BackupHint_Destination : string;
    frmMain_BackupHint_LastBackupTime : string;
    frmMain_BackupHint_AutoBackup : string;
    frmMain_BackupHint_AutoBackupInterval : string;
    frmMain_BackupHint_NextAutoBackupTime : string;
    frmMain_BackupHint_BackupAll : string;
    frmMain_BackupHint_SaveDeletedFiles : string;
    frmMain_BackupHint_SaveDeletedEditions : string;
    frmMain_BackupHint_Encrypted : string;
    frmMain_BackupHint_PasswordHints : string;
    frmMain_BackupHint_IncludeFilter : string;
    frmMain_BackupHint_ExcludeFilter : string;
    frmMain_BackupHint_ComputerName : string;
    frmMain_BackupHint_ComputerIP : string;
  public
    frmMain_BackupNodeStatus_WaitingBackup : string;
    frmMain_BackupNodeStatus_Backuping : string;
    frmMain_BackupNodeStatus_Analyizing : string;
    frmMain_BackupNodeStatus_Empty : string;
    frmMain_BackupStatusShow_NotExist : string;
    frmMain_BackupStatusShow_NotWrite : string;
    frmMain_BackupStatusShow_NotSpace : string;
    frmMain_BackupStatusShow_Disable : string;
    frmMain_BackupStatusShow_PcOffline : string;
    frmMain_BackupStatusShow_Analyizing : string;
    frmMain_BackupStatusShow_NotConnect : string;
    frmMain_BackupStatusShow_Busy : string;
    frmMain_BackupStatusShow_Incompleted : string;
    frmMain_BackupStatusShow_Completed : string;
    frmMain_BackupNodeStatus_ReadFileError : string;
    frmMain_BackupNodeStatus_WriteFileError : string;
    frmMain_BackupNodeStatus_SendFileError : string;
    frmMain_BackupNodeStatus_LostConnectError : string;
    frmMain_LogStatus_Busy : string;
    frmMain_LogStatus_NotConn : string;
    frmMain_LogStatus_NotExist : string;
    frmMain_LogStatus_NotPreview : string;
    frmMain_LogStatus_NotRestore : string;
  public
    frmMain_RestoreNodeStatus_WaitingRestore : string;
    frmMain_RestoreNodeStatus_Restoreing : string;
    frmMain_RestoreNodeStatus_Analyizing : string;
    frmMain_RestoreNodeStatus_Empty : string;
    frmMain_RestoreNodeStatus_ReadFileError : string;
    frmMain_RestoreNodeStatus_WriteFileError : string;
    frmMain_RestoreNodeStatus_ReceiveFileError : string;
    frmMain_RestoreNodeStatus_LostConnectFileError : string;
    frmMain_RestoreStatusShow_NotExist : string;
    frmMain_RestoreStatusShow_NotWrite : string;
    frmMain_RestoreStatusShow_NotSpace : string;
    frmMain_RestoreStatusShow_PcOffline : string;
    frmMain_RestoreStatusShow_Analyizing : string;
    frmMain_RestoreStatusShow_DesBusy : string;
    frmMain_RestoreStatusShow_NotConnect : string;
    frmMain_RestoreStatusShow_Incompleted : string;
    frmMain_RestoreStatusShow_Completed : string;
    frmMain_ExplorerStatus_Waiting : string;
    frmMain_ExplorerStatus_Searching : string;
    frmMain_ExplorerStatus_Stop : string;
    frmMain_ExplorerStatus_Busy : string;
    frmMain_ExplorerStatus_NotConn : string;
    frmMain_ExplorerStatus_Encrypted : string;
    frmMain_ExplorerStatus_NotPreview : string;
  public
    frmMain_BackupShowTime_After : string;
    frmMain_BackupShowTime_Years : string;
    frmMain_BackupShowTime_Months : string;
    frmMain_BackupShowTime_Weeks : string;
    frmMain_BackupShowTime_Days : string;
    frmMain_BackupShowTime_Hours : string;
    frmMain_BackupShowTime_Minutes : string;
    frmMain_BackupShowTime_Seconds : string;
  public
    frmMain_RestoreHint_ItemToRestore : string;
    frmMain_RestoreHint_Owner : string;
    frmMain_RestoreHint_RestorePath : string;
    frmMain_RestoreHint_Encrypted : string;
    frmMain_RestoreHint_SaveDeletedFiles : string;
  public
    frmMain_DropFile_Hint : string;
    frmMain_DropFolder_Hint : string;
  public
    frmLogin_SignupWarnning_NotConnect : string;
    frmLogin_SignupWarnning_AccountExist : string;
    frmLogin_SignupWarnning_AccountNotEnough : string;
    frmLogin_SignupWarnning_Completed : string;
    frmLogin_LoginWarnning_InputAccountName : string;
    frmLogin_LoginWarnning_InputPassword : string;
    frmLogin_LoginWarnning_PasswordNotMatch : string;
    frmLogin_ItemCaption_Add : string;
    frmLogin_ItemCaption_AddServerIp : string;
  public
    constructor Create;
  public
    procedure Save( FilePath : string );
    procedure Load( FilePath : string );
  end;

var
  LanguageInfo : TLanguageInfo;

implementation

uses ULanguageUtil;

{ TLanguageInfo }

constructor TLanguageInfo.Create;
begin
  frmLogin_Title_Login := 'Login';
  frmLogin_Title_Signup := 'Signup';
  frmSelectBackup_Title_AddItem := 'Select Files or Folders to Backup';
  frmSelectBackup_Title_ItemProperties := '%s Properies';
  frmMain_SbMyStatus_NotConn := 'Not Connected';
  frmMain_SbMyStatus_Conning := 'Connecting';
  frmMain_SbMyStatus_Conn := 'Connected';
  frmMain_BtnRestore_Show := 'Show >>';
  frmMain_BtnRestore_Hide := '<< Hide';
  frmSelectBackup_AutoBackup_Min := 'Minutes';
  frmSelectBackup_AutoBackup_Hour := 'Hours';
  frmSelectBackup_AutoBackup_Day := 'Days';
  frmSelectBackup_AutoBackup_Week := 'Weeks';
  frmSelectBackup_AutoBackup_Month := 'Months';
  frmMain_BackupHint_BackupItem := 'Backup Item';
  frmMain_BackupHint_Destination := 'Destination';
  frmMain_BackupHint_LastBackupTime := 'Last Backup Time';
  frmMain_BackupHint_AutoBackup := 'Auto Backup';
  frmMain_BackupHint_AutoBackupInterval := 'Auto Backup Interval';
  frmMain_BackupHint_NextAutoBackupTime := 'Next Auto Backup Time';
  frmMain_BackupHint_BackupAll := 'Backup immediately when clicking "Back Up All"';
  frmMain_BackupHint_SaveDeletedFiles := 'Save Deleted Files';
  frmMain_BackupHint_SaveDeletedEditions := 'Save Deleted Editions';
  frmMain_BackupHint_Encrypted := 'Encrypted';
  frmMain_BackupHint_PasswordHints := 'Password Hints';
  frmMain_BackupHint_IncludeFilter := 'Include Filter';
  frmMain_BackupHint_ExcludeFilter := 'Exclude Filter';
  frmMain_BackupHint_ComputerName := 'Computer Name';
  frmMain_BackupHint_ComputerIP := 'Computer IP';
  frmMain_BackupNodeStatus_WaitingBackup := 'Waiting';
  frmMain_BackupNodeStatus_Backuping := 'Backuping';
  frmMain_BackupNodeStatus_Analyizing := 'Analyzing';
  frmMain_BackupNodeStatus_Empty := '';
  frmMain_BackupStatusShow_NotExist := 'Not Exist';
  frmMain_BackupStatusShow_NotWrite := 'Cannot Write';
  frmMain_BackupStatusShow_NotSpace := 'Space Insufficient';
  frmMain_BackupStatusShow_Disable := 'Disable';
  frmMain_BackupStatusShow_PcOffline := 'Offline';
  frmMain_BackupStatusShow_Analyizing := 'Analyzing %s Files';
  frmMain_BackupStatusShow_NotConnect := 'Cannot Connect';
  frmMain_BackupStatusShow_Busy := 'Destination Busy';
  frmMain_BackupStatusShow_Incompleted := 'Incompleted';
  frmMain_BackupStatusShow_Completed := 'Completed';
  frmMain_BackupNodeStatus_ReadFileError := 'Read File Error';
  frmMain_BackupNodeStatus_WriteFileError := 'Write File Error';
  frmMain_BackupNodeStatus_SendFileError := 'Send File Error';
  frmMain_BackupNodeStatus_LostConnectError := 'Lost Connect Error';
  frmMain_LogStatus_Busy := 'Backup Destination PC Busy';
  frmMain_LogStatus_NotConn := 'Cannot Connect to Backup Destination PC';
  frmMain_LogStatus_NotExist := 'Backup file not exist';
  frmMain_LogStatus_NotPreview := 'Cannot preview this file';
  frmMain_LogStatus_NotRestore := 'Cannot restore this file';
  frmMain_RestoreNodeStatus_WaitingRestore := 'Waiting';
  frmMain_RestoreNodeStatus_Restoreing := 'Restoreing';
  frmMain_RestoreNodeStatus_Analyizing := 'Analyzing';
  frmMain_RestoreNodeStatus_Empty := '';
  frmMain_RestoreNodeStatus_ReadFileError := 'Read File Error';
  frmMain_RestoreNodeStatus_WriteFileError := 'Write File Error';
  frmMain_RestoreNodeStatus_ReceiveFileError := 'Receive File Error';
  frmMain_RestoreNodeStatus_LostConnectFileError := 'Lost Connect File Error';
  frmMain_RestoreStatusShow_NotExist := 'Restore Path Not Exist';
  frmMain_RestoreStatusShow_NotWrite := 'Can not Write';
  frmMain_RestoreStatusShow_NotSpace := 'Space Insufficient';
  frmMain_RestoreStatusShow_PcOffline := 'Restore From PC Offline';
  frmMain_RestoreStatusShow_Analyizing := 'Analyzing %s Files';
  frmMain_RestoreStatusShow_DesBusy := 'Restore From PC Busy';
  frmMain_RestoreStatusShow_NotConnect := 'Can not Connect to Restore From PC';
  frmMain_RestoreStatusShow_Incompleted := 'Incompleted';
  frmMain_RestoreStatusShow_Completed := 'Completed';
  frmMain_ExplorerStatus_Waiting := 'Restore directory is Loading...';
  frmMain_ExplorerStatus_Searching := 'Restore directory is Searching...';
  frmMain_ExplorerStatus_Stop := '';
  frmMain_ExplorerStatus_Busy := 'Restore From PC Busy';
  frmMain_ExplorerStatus_NotConn := 'Cannot Connect to Restore From PC';
  frmMain_ExplorerStatus_Encrypted := 'Cannot preview this encrypted file';
  frmMain_ExplorerStatus_NotPreview := 'Cannot preview this file';
  frmMain_BackupShowTime_After := 'After';
  frmMain_BackupShowTime_Years := 'Years';
  frmMain_BackupShowTime_Months := 'Months';
  frmMain_BackupShowTime_Weeks := 'Weeks';
  frmMain_BackupShowTime_Days := 'Days';
  frmMain_BackupShowTime_Hours := 'Hours';
  frmMain_BackupShowTime_Minutes := 'Minutes';
  frmMain_BackupShowTime_Seconds := 'Seconds';
  frmMain_DropFile_Hint := 'Drag and drop files or folders here from Windows Explorer';
  frmMain_DropFolder_Hint := 'Drag and drop folders here from Windows Explorer';
  frmLogin_SignupWarnning_NotConnect := 'Cannot Connect to server';
  frmLogin_SignupWarnning_AccountExist := 'Account Name is exist';
  frmLogin_SignupWarnning_AccountNotEnough := 'The number of your user accounts has reached your current maximum ' + 'quantity. Please purchase licenses in order to create more new accounts.';
  frmLogin_SignupWarnning_Completed := 'Signup is completed';
  frmLogin_LoginWarnning_InputAccountName := 'Please input Account Name';
  frmLogin_LoginWarnning_InputPassword := 'Please input Account Password';
  frmLogin_LoginWarnning_PasswordNotMatch := 'Password and Retype Password are not matched';
  frmLogin_ItemCaption_Add := 'Add';
  frmLogin_ItemCaption_AddServerIp := 'Add Cloud Server Address';
  frmMain_RestoreHint_ItemToRestore := 'Item to Restore';
  frmMain_RestoreHint_Owner := 'Owner';
  frmMain_RestoreHint_RestorePath := 'Restore Path';
  frmMain_RestoreHint_Encrypted := 'Encrypted';
  frmMain_RestoreHint_SaveDeletedFiles := 'Save Deleted Files';
end;

procedure TLanguageInfo.Load(FilePath: string);
begin
  ObjectLanguageUtil.Load( Self, FilePath );
end;

procedure TLanguageInfo.Save(FilePath: string);
begin
  ObjectLanguageUtil.Save( Self, FilePath );
end;

initialization
  LanguageInfo := TLanguageInfo.Create;
finalization
  LanguageInfo.Free;

end.
