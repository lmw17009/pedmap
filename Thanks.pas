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
    Items[0].Caption := 'TSK离线编辑/联动TEL编辑';
    Items[0].SubItems.Add('范德新/何奇/汪建阳/张源');
    Items[1].Caption := 'TSK Sample Mark';
    Items[1].SubItems.Add('汪建阳/张源');
    Items[2].Caption := 'CP数据坐标检测';
    Items[2].SubItems.Add('张源');
    Items[3].Caption := 'WAT Limit一键创建';
    Items[3].SubItems.Add('向睿');
    Items[4].Caption := 'CP数据批量修改PPID/LotID/FileName';
    Items[4].SubItems.Add('郭丹/王均婷/张源');
    Items[5].Caption := 'WAT FTP关联文件查询';
    Items[5].SubItems.Add('唐飞/向睿');
    Items[6].Caption := '针卡尺寸区域对比';
    Items[6].SubItems.Add('向睿');
    Items[7].Caption := 'PAD区域针尖尺寸绘制与测量';
    Items[7].SubItems.Add('向睿');
  end;

end;

procedure TForm16.FormCreate(Sender: TObject);
begin
  Self.Position := poDesktopCenter;
  AddFun;
end;

end.

