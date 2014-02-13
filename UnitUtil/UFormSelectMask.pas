unit UFormSelectMask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFrmEnterMask = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    mmoMask: TMemo;
    Panel2: TPanel;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtMaskKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    function getMaskList : TStringList;
  end;

var
  FrmEnterMask: TFrmEnterMask;

implementation

uses UFormUtil;

{$R *.dfm}

procedure TFrmEnterMask.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmEnterMask.btnOKClick(Sender: TObject);
begin
  Close;
  ModalResult := mrOk;
end;

procedure TFrmEnterMask.edtMaskKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
    btnOK.Click;
end;

procedure TFrmEnterMask.FormShow(Sender: TObject);
begin
  ModalResult := mrCancel;
  mmoMask.Clear;
  FormUtil.SetFocuse( mmoMask );
end;

function TFrmEnterMask.getMaskList: TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 0 to mmoMask.Lines.Count - 1 do
    Result.Add( Trim( mmoMask.Lines[i] ) );
end;

end.
