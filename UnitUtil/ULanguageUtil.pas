unit ULanguageUtil;

interface

uses Vcl.Forms, Vcl.Controls, virtualtrees, inifiles, SysUtils, rtti, TypInfo, classes, menus, RzButton,
     ComCtrls, RzStatus, ExtCtrls, StdCtrls;

type

{$Region ' 原窗口属性读取与写入 ' }

  {$Region ' 保存窗口 ' }

    // 父类
  TFormLanguageHandle = class
  protected
    Form : TForm;
    IniFile : TIniFile;
  public
    constructor Create( _Form : TForm; FilePath : string );
    destructor Destroy; override;
  protected
    function ReadIsMark( Tag : Integer ): Boolean;overload;
    function ReadIsMark( c : TControl ): Boolean;overload;
    function ReadisShowHint( c : TControl ): Boolean;
  end;

    // 保存窗口
  TFormSaveHandle = class( TFormLanguageHandle )
  public
    procedure Update;
  private
    procedure SaveChildControl( wc : TWinControl );
    procedure SaveVirtualTree( vst : TVirtualStringTree );
    procedure SaveListView( lv : TListView );
    procedure SavePopMenu( pm : TPopupMenu );
    procedure SaveStatusBtn( StatusBtn : TRzGlyphStatus );
    procedure SaveCombobox( cbb : Tcombobox );
    procedure SaveControlPro( c : TControl; ProName : string );
  end;

    // 读取窗口
  TFormLoadHandle = class( TFormLanguageHandle )
  public
    procedure Update;
  private
    procedure LoadChildControl( wc : TWinControl );
    procedure LoadVirtualTree( vst : TVirtualStringTree );
    procedure LoadListView( lv : TListView );
    procedure LoadPopMenu( pm : TPopupMenu );
    procedure LoadStatusBtn( StatusBtn : TRzGlyphStatus );
    procedure LoadCombobox( cbb : Tcombobox );
    procedure LoadControlPro( c : TControl; ProName : string );
  end;

  {$EndRegion}

  {$Region ' 保存托盘 ' }

    // 父类
  TTrayIconLanguageHandle = class
  protected
    ti : TTrayIcon;
    IniFile : TIniFile;
  public
    constructor Create( _ti : TTrayIcon; FilePath : string );
    destructor Destroy; override;
  end;

    // 保存
  TTrayIconLanguageSaveHandle = class( TTrayIconLanguageHandle )
  public
    procedure Update;
  end;

    // 读取
  TTrayIconLanguageLoadHandle = class( TTrayIconLanguageHandle )
  public
    procedure Update;
  end;

  {$EndRegion}

  {$Region ' 保存界面 ' }

      // 父类
  TLanguageHandle = class
  protected
    Obj : TObject;
    FilePath : string;
  protected
    IniFile : TIniFile;
  public
    constructor Create( _Obj : TObject; _FilePath : string );
    destructor Destroy; override;
  end;

    // 保存
  TLanguangeSaveHandle = class( TLanguageHandle )
  public
    procedure Update;
  private
    procedure Save( ProName, ProValue : string );
  end;

    // 读取
  TLanguageLoadHandle = class( TLanguageHandle )
  public
    procedure Update;
  private
    function Load( ProName : string ): string;
  end;

  {$EndRegion}

    // 界面 外部接口
  FormLanguageUtil = class
  public
    class procedure Save( Form : TForm; FilePath : string );
    class procedure Load( Form : TForm; FilePath : string );
  end;

    // 弹出菜单 外部接口
  TrayIconLanguageUtil = class
  public
    class procedure Save( ti : TTrayIcon; FilePath : string );
    class procedure Load( ti : TTrayIcon; FilePath : string );
  end;

    // 对象 外部接口
  ObjectLanguageUtil = class
  public
    class procedure Save( Obj : TObject; FilePath : string );
    class procedure Load( Obj : TObject; FilePath : string );
  end;

{$EndRegion}

{$Region ' 多语言窗口处理 ' }

  TVstMultiData = record
  public
    ItemName, ProName : WideString;
    English, Chinese : WideString;
  public
    ShowName : WideString;
  end;
  PVstMultiData = ^TVstMultiData;

    // 父类
  TMultiFormHandle = class
  public
    vst : TVirtualStringTree;
    IniFile : TIniFile;
  public
    constructor Create( _vst : TVirtualStringTree; FilePath : string );
    destructor Destroy; override;
  end;

    // 读取 英文语言包
  TMultiFormLoadEnglishHandle = class( TMultiFormHandle )
  public
    procedure Update;
  private
    procedure AddItem( ItemName, ProName, ProValue : string );
  end;

    // 保存 中文语言包
  TMultiFormSaveChineseHandle = class( TMultiFormHandle )
  public
    procedure Update;
  private
    procedure SaveItem( ItemName, ProName,  ProValue : string );
  end;

    // 读取 中文语言包
  TMultiFormLoadChineseHandle = class( TMultiFormHandle )
  public
    procedure Update;
  private
    function LoadItem( ItemName, ProName : string ):string;
  end;

    // 外部接口
  MutiFormUtil = class
  public
    class procedure LoadEnglish( vst : TVirtualStringTree; FilePath : string );
    class procedure LoadChinese( vst : TVirtualStringTree; FilePath : string );
    class procedure SaveChinese( vst : TVirtualStringTree; FilePath : string );
  end;

{$EndRegion}


const
  Tag_SaveIni = 10;
  ProName_Caption = 'caption';
  ProName_Hint = 'hint';
  ProName_ShowHint = 'showhint';
  Vst_Column = 'Column';
  Cbb_Item = 'Item';

implementation

{ FormLanguageUtil }

class procedure FormLanguageUtil.Load(Form: TForm; FilePath : string);
var
  FormLoadHandle : TFormLoadHandle;
begin
  FormLoadHandle := TFormLoadHandle.Create( Form, FilePath );
  FormLoadHandle.Update;
  FormLoadHandle.Free;
end;

class procedure FormLanguageUtil.Save(Form : TForm; FilePath : string);
var
  FormSaveHandle : TFormSaveHandle;
begin
  FormSaveHandle := TFormSaveHandle.Create( Form, FilePath );
  FormSaveHandle.Update;
  FormSaveHandle.Free;
end;


{ TFormLanguageHandle }

constructor TFormLanguageHandle.Create(_Form: TForm; FilePath : string);
begin
  Form := _Form;
  IniFile := TIniFile.Create( FilePath );
end;

destructor TFormLanguageHandle.Destroy;
begin
  IniFile.Free;
  inherited;
end;

function TFormLanguageHandle.ReadIsMark(Tag: Integer): Boolean;
begin
  Result := Abs( Tag ) >= Tag_SaveIni;
end;

function TFormLanguageHandle.ReadIsMark(c: TControl): Boolean;
begin
  Result := ReadIsMark( c.Tag );
end;

function TFormLanguageHandle.ReadisShowHint(c: TControl): Boolean;
begin
  Result := GetPropValue( c, ProName_ShowHint );
end;

{ TFormSaveHandle }

procedure TFormSaveHandle.SaveCombobox(cbb: Tcombobox);
var
  i: Integer;
begin
  if not ReadIsMark( cbb ) then  // 是否一个需要记录的控件
    Exit;
  for i := 0 to cbb.Items.Count - 1 do
    IniFile.WriteString( Form.Name + '.' + cbb.Name, Cbb_Item + IntToStr(i), cbb.Items[i] );
end;

procedure TFormSaveHandle.SaveControlPro(c: TControl; ProName: string);
var
  SaveName : string;
  ProValue : string;
begin
  if not ReadIsMark( c ) then  // 是否一个需要记录的控件
    Exit;
  if c = Form then
    SaveName := c.Name
  else
    SaveName := Form.Name + '.' + c.Name;
  ProValue := GetPropValue( c, ProName );
  IniFile.WriteString( SaveName, ProName, ProValue );
end;

procedure TFormSaveHandle.SaveListView(lv: TListView);
var
  i : Integer;
begin
  if not ReadIsMark( lv ) then
    Exit;
  for i := 0 to lv.Columns.Count - 1 do
    IniFile.WriteString( Form.Name + '.' + lv.Name, Vst_Column + IntToStr(i), lv.Columns[i].Caption );
end;

procedure TFormSaveHandle.SavePopMenu(pm: TPopupMenu);
var
  i: Integer;
begin
  if not ReadIsMark( pm.Tag ) then
    Exit;
  for i := 0 to pm.Items.Count - 1 do
    IniFile.WriteString( Form.Name + '.' + pm.Name, pm.Items[i].Name, pm.Items[i].Caption );
end;

procedure TFormSaveHandle.SaveStatusBtn(StatusBtn: TRzGlyphStatus);
begin
  if not ReadIsMark( StatusBtn ) then
    Exit;
  SaveControlPro( StatusBtn, ProName_Hint );
end;

procedure TFormSaveHandle.SaveVirtualTree(vst: TVirtualStringTree);
var
  i : Integer;
begin
  if not ReadIsMark( vst ) then
    Exit;

  for i := 0 to vst.Header.Columns.Count - 1 do
    IniFile.WriteString( Form.Name + '.' + vst.Name, Vst_Column + IntToStr(i), vst.Header.Columns[i].Text );
end;

procedure TFormSaveHandle.SaveChildControl(wc: TWinControl);
var
  i: Integer;
  c : TControl;
begin
  for i := 0 to wc.ControlCount - 1 do
  begin
    c := wc.Controls[i];
    if c.Name = 'tiApp' then
      SaveControlPro( c, ProName_Hint );
    if c is TVirtualStringTree then
      SaveVirtualTree( c as TVirtualStringTree )
    else
    if c is TListView then
      SaveListView( c as TListView )
    else
    if c is TRzGlyphStatus then
      SaveStatusBtn( c as TRzGlyphStatus )
    else
    if c is TComboBox then
      SaveCombobox( c as TComboBox )
    else
    if ( c is TToolButton ) and (( c as TToolButton ).Caption = '' ) and
       (( c as TToolButton ).Hint <> '' )
    then
      SaveControlPro( c, ProName_Hint )
    else
    begin
      SaveControlPro( c, ProName_Caption );
      if c is TRzToolButton and Assigned( ( c as TRzToolButton ).DropDownMenu ) then
        SavePopMenu( ( c as TRzToolButton ).DropDownMenu )
      else
      if c is TWinControl then
        SaveChildControl( c as TWinControl );
    end;
  end;
end;

procedure TFormSaveHandle.Update;
begin
    // 先保存窗口的标题
  SaveControlPro( Form, ProName_Caption );

    // 保存子控件
  SaveChildControl( Form );
end;

{ MutiFormUtil }

class procedure MutiFormUtil.LoadChinese(vst: TVirtualStringTree;
  FilePath: string);
var
  MultiFormLoadChineseHandle : TMultiFormLoadChineseHandle;
begin
  MultiFormLoadChineseHandle := TMultiFormLoadChineseHandle.Create( vst, FilePath );
  MultiFormLoadChineseHandle.Update;
  MultiFormLoadChineseHandle.Free;
  vst.Refresh;
end;

class procedure MutiFormUtil.LoadEnglish(vst: TVirtualStringTree;
  FilePath : string);
var
  MultiFormLoadEnglishHandle : TMultiFormLoadEnglishHandle;
begin
  vst.Clear;
  MultiFormLoadEnglishHandle := TMultiFormLoadEnglishHandle.Create( vst, FilePath );
  MultiFormLoadEnglishHandle.Update;
  MultiFormLoadEnglishHandle.Free;
end;

class procedure MutiFormUtil.SaveChinese(vst: TVirtualStringTree;
  FilePath : string);
var
  MultiFormSaveChineseHandle : TMultiFormSaveChineseHandle;
begin
  MultiFormSaveChineseHandle := TMultiFormSaveChineseHandle.Create( vst, FilePath );
  MultiFormSaveChineseHandle.Update;
  MultiFormSaveChineseHandle.Free;
end;

{ TMultiFormHandle }

constructor TMultiFormHandle.Create(_vst: TVirtualStringTree; FilePath: string);
begin
  vst := _vst;
  IniFile := TIniFile.Create( FilePath );
end;

destructor TMultiFormHandle.Destroy;
begin
  IniFile.Free;
  inherited;
end;

{ TMultiFormLoadHandle }

procedure TMultiFormLoadEnglishHandle.AddItem(ItemName, ProName, ProValue: string);
var
  NewNode : PVirtualNode;
  NodeData : PVstMultiData;
begin
  NewNode := vst.AddChild( vst.RootNode );
  NodeData := vst.GetNodeData( NewNode );
  NodeData.ItemName := ItemName;
  NodeData.ProName := ProName;
  NodeData.ShowName := ItemName + '.' + ProName;
  NodeData.English := ProValue;
end;

procedure TMultiFormLoadEnglishHandle.Update;
var
  i : Integer;
  SectionList, ProList : TStrings;
  SectionName, ProName, ProValue : string;
  j: Integer;
begin
  SectionList := TStringList.Create;
  IniFile.ReadSections( SectionList );
  for i := 0 to SectionList.Count - 1 do
  begin
    SectionName := SectionList[i];
    ProList := TStringList.Create;
    IniFile.ReadSection( SectionName, ProList );
    for j := 0 to ProList.Count - 1 do
    begin
      ProName := ProList[j];
      ProValue := IniFile.ReadString( SectionName, ProName, '' );
      AddItem( SectionName, ProName, ProValue );
    end;
    ProList.Free;
  end;
  SectionList.Free;
end;

{ TMultiFormSaveChineseHandle }

procedure TMultiFormSaveChineseHandle.SaveItem(ItemName, ProName,
  ProValue: string);
begin
  IniFile.WriteString( ItemName, ProName, ProValue );
end;

procedure TMultiFormSaveChineseHandle.Update;
var
  SelectNode : PVirtualNode;
  NodeData : PVstMultiData;
begin
  SelectNode := vst.RootNode.FirstChild;
  while( Assigned( SelectNode ) )do
  begin
    NodeData := vst.GetNodeData( SelectNode );
    SaveItem( NodeData.ItemName, NodeData.ProName, NodeData.Chinese );
    SelectNode := SelectNode.NextSibling;
  end;
end;

{ TMultiFormLoadChineseHandle }

function TMultiFormLoadChineseHandle.LoadItem(ItemName, ProName : string): string;
begin
  Result := IniFile.ReadString( ItemName, ProName, '' );
end;

procedure TMultiFormLoadChineseHandle.Update;
var
  SelectNode : PVirtualNode;
  NodeData : PVstMultiData;
begin
  SelectNode := vst.RootNode.FirstChild;
  while( Assigned( SelectNode ) )do
  begin
    NodeData := vst.GetNodeData( SelectNode );
    NodeData.Chinese := LoadItem( NodeData.ItemName, NodeData.ProName );
    SelectNode := SelectNode.NextSibling;
  end;
end;

{ TFormLoadHandle }

procedure TFormLoadHandle.LoadChildControl(wc: TWinControl);
var
  i: Integer;
  c : TControl;
begin
  for i := 0 to wc.ControlCount - 1 do
  begin
    c := wc.Controls[i];
    if c is TVirtualStringTree then
      LoadVirtualTree( c as TVirtualStringTree )
    else
    if c is TListView then
      LoadListView( c as TListView )
    else
    if c is TRzGlyphStatus then
      LoadStatusBtn( c as TRzGlyphStatus )
    else
    if c is TComboBox then
      LoadCombobox( c as TComboBox )
    else
    if ( c is TToolButton ) and (( c as TToolButton ).Caption = '' ) and
       (( c as TToolButton ).Hint <> '' )
    then
      LoadControlPro( c, ProName_Hint )
    else
    begin
      LoadControlPro( c, ProName_Caption );
      if c is TRzToolButton and Assigned( ( c as TRzToolButton ).DropDownMenu ) then
        LoadPopMenu( ( c as TRzToolButton ).DropDownMenu )
      else
      if c is TWinControl then
        LoadChildControl( c as TWinControl );
    end;
  end;
end;

procedure TFormLoadHandle.LoadCombobox(cbb: Tcombobox);
var
  i, SelectIndex: Integer;
begin
  if not ReadIsMark( cbb ) then  // 是否一个需要记录的控件
    Exit;
  SelectIndex := cbb.ItemIndex;
  for i := 0 to cbb.Items.Count - 1 do
    cbb.Items[i] := IniFile.ReadString( Form.Name + '.' + cbb.Name, Cbb_Item + IntToStr(i), cbb.Items[i] );
  cbb.ItemIndex := SelectIndex;
end;

procedure TFormLoadHandle.LoadControlPro(c: TControl; ProName: string);
var
  LoadName, ProValue : string;
begin
  if not ReadIsMark( c ) then  // 是否一个需要记录的控件
    Exit;
  if c = Form then
    LoadName := c.Name
  else
    LoadName := Form.Name + '.' + c.Name;
  ProValue := IniFile.ReadString( LoadName, ProName, ProValue );
  SetPropValue( c, ProName, ProValue );
end;

procedure TFormLoadHandle.LoadListView(lv: TListView);
var
  i : Integer;
begin
  if not ReadIsMark( lv ) then
    Exit;
  for i := 0 to lv.Columns.Count - 1 do
    lv.Columns[i].Caption := IniFile.ReadString( Form.Name + '.' + lv.Name, Vst_Column + IntToStr(i), lv.Columns[i].Caption );
end;

procedure TFormLoadHandle.LoadPopMenu(pm: TPopupMenu);
var
  i: Integer;
begin
  if not ReadIsMark( pm.Tag ) then
    Exit;
  for i := 0 to pm.Items.Count - 1 do
    pm.Items[i].Caption := IniFile.ReadString( Form.Name + '.' + pm.Name, pm.Items[i].Name, pm.Items[i].Caption );
end;

procedure TFormLoadHandle.LoadStatusBtn(StatusBtn: TRzGlyphStatus);
begin
  if not ReadIsMark( StatusBtn ) then
    Exit;
  LoadControlPro( StatusBtn, ProName_Hint );
end;

procedure TFormLoadHandle.LoadVirtualTree(vst: TVirtualStringTree);
var
  i : Integer;
begin
  if not ReadIsMark( vst ) then
    Exit;

  for i := 0 to vst.Header.Columns.Count - 1 do
    vst.Header.Columns[i].Text := IniFile.ReadString( Form.Name + '.' + vst.Name, Vst_Column + IntToStr(i), vst.Header.Columns[i].Text );
end;

procedure TFormLoadHandle.Update;
begin
    // 先保存窗口的标题
  LoadControlPro( Form, ProName_Caption );

    // 保存子控件
  LoadChildControl( Form );
end;

{ ObjectLanguageUtil }

class procedure ObjectLanguageUtil.Load(Obj: TObject; FilePath: string);
var
  LanguageLoadHandle : TLanguageLoadHandle;
begin
  LanguageLoadHandle := TLanguageLoadHandle.Create( Obj, FilePath );
  LanguageLoadHandle.Update;
  LanguageLoadHandle.Free;
end;


class procedure ObjectLanguageUtil.Save(Obj: TObject; FilePath: string);
var
  LanguangeSaveHandle : TLanguangeSaveHandle;
begin
  LanguangeSaveHandle := TLanguangeSaveHandle.Create( Obj, FilePath );
  LanguangeSaveHandle.Update;
  LanguangeSaveHandle.Free;
end;

{ TLanguageHandle }

constructor TLanguageHandle.Create(_Obj: TObject; _FilePath: string);
begin
  Obj := _Obj;
  FilePath := _FilePath;
  IniFile := TIniFile.Create( FilePath );
end;

destructor TLanguageHandle.Destroy;
begin
  IniFile.Free;
  inherited;
end;

{ TLanguangeSaveHandle }

procedure TLanguangeSaveHandle.Save(ProName, ProValue: string);
begin
  IniFile.WriteString( Obj.ClassName, ProName, ProValue );
end;

procedure TLanguangeSaveHandle.Update;
var
  ctx: TRttiContext;
  t: TRttiType;
  f : TRttiField;
  value : TValue;
  ProValue : Variant;
begin
  t := ctx.GetType( Obj.ClassType );
  for f in t.GetFields do
  begin
    value := f.GetValue( Obj );
    if value.IsOrdinal then
      ProValue := value.AsOrdinal
    else
      ProValue := value.AsVariant;
    Save( f.Name, ProValue );
  end;
end;

{ TLanguageLoadHandle }

function TLanguageLoadHandle.Load(ProName: string): string;
begin
  Result := IniFile.ReadString( Obj.ClassName, ProName, '' );
end;

procedure TLanguageLoadHandle.Update;
var
  ctx: TRttiContext;
  t: TRttiType;
  f : TRttiField;
  ProName : string;
  ProValue : string;
begin
  t := ctx.GetType( Obj.ClassType );
  for f in t.GetFields do
  begin
    ProValue := Load( f.Name );
    f.SetValue( Obj, ProValue );
  end;
end;

{ PopMenuLanguageUtil }

class procedure TrayIconLanguageUtil.Load( ti : TTrayIcon;
  FilePath: string);
var
  TrayIconLanguageLoadHandle : TTrayIconLanguageLoadHandle;
begin
  TrayIconLanguageLoadHandle := TTrayIconLanguageLoadHandle.Create( ti, FilePath );
  TrayIconLanguageLoadHandle.Update;
  TrayIconLanguageLoadHandle.Free;
end;

class procedure TrayIconLanguageUtil.Save( ti : TTrayIcon;
  FilePath: string);
var
  TrayIconLanguageSaveHandle : TTrayIconLanguageSaveHandle;
begin
  TrayIconLanguageSaveHandle := TTrayIconLanguageSaveHandle.Create( ti, FilePath );
  TrayIconLanguageSaveHandle.Update;
  TrayIconLanguageSaveHandle.Free;
end;

{ TTrayIconLanguageHandle }

constructor TTrayIconLanguageHandle.Create(_ti: TTrayIcon;
  FilePath: string);
begin
  ti := _ti;
  IniFile := TIniFile.Create( FilePath );
end;

destructor TTrayIconLanguageHandle.Destroy;
begin
  IniFile.Free;
  inherited;
end;

{ TTrayIconLanguageSaveHandle }

procedure TTrayIconLanguageSaveHandle.Update;
var
  pm : TPopupMenu;
  i: Integer;
begin
  IniFile.WriteString( ti.Name, ProName_Hint, ti.Hint );
  pm := ti.PopupMenu;
  if not Assigned( pm ) then
    Exit;
  for i := 0 to pm.Items.Count - 1 do
    IniFile.WriteString( ti.Name + '.' + pm.Name, pm.Items[i].Name, pm.Items[i].Caption );
end;

{ TTrayIconLanguageLoadHandle }

procedure TTrayIconLanguageLoadHandle.Update;
var
  pm : TPopupMenu;
  i: Integer;
begin
  ti.Hint := IniFile.ReadString( ti.Name, ProName_Hint, ti.Hint );
  pm := ti.PopupMenu;
  if not Assigned( pm ) then
    Exit;
  for i := 0 to pm.Items.Count - 1 do
    pm.Items[i].Caption := IniFile.ReadString( ti.Name + '.' + pm.Name, pm.Items[i].Name, pm.Items[i].Caption );
end;

end.
