unit Thanks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm16 = class(TForm)
    lv1: TListView;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddFun;
  end;

var
  Form16: TForm16;

implementation

{$R *.dfm}

procedure TForm16.AddFun;
var
  I: Integer;
begin
  for I := 0 to 7 do
  begin
    with lv1.Items.Add do
    begin
      Caption := '';
    end;
  end;
  with lv1 do
  begin
    Items[0].Caption := 'TSK���߱༭/����TEL�༭';
    Items[0].SubItems.Add('������/����/������/��Դ');
    Items[1].Caption := 'TSK Sample Mark';
    Items[1].SubItems.Add('������/��Դ');
    Items[2].Caption := 'CP����������';
    Items[2].SubItems.Add('��Դ');
    Items[3].Caption := 'WAT Limitһ������';
    Items[3].SubItems.Add('���');
    Items[4].Caption := 'CP���������޸�PPID/LotID/FileName';
    Items[4].SubItems.Add('����/������/��Դ');
    Items[5].Caption := 'WAT FTP�����ļ���ѯ';
    Items[5].SubItems.Add('�Ʒ�/���');
    Items[6].Caption := '�뿨�ߴ�����Ա�';
    Items[6].SubItems.Add('���');
    Items[7].Caption := 'PAD�������ߴ���������';
    Items[7].SubItems.Add('���');
  end;

end;

procedure TForm16.FormCreate(Sender: TObject);
begin
  Self.Position := poDesktopCenter;
  AddFun;
end;

end.

