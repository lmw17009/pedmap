unit Help;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TForm14 = class(TForm)
    lst1: TListBox;
    mmo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure lst1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form14: TForm14;

implementation

uses
  Update;
{$R *.dfm}

procedure TForm14.FormCreate(Sender: TObject);
begin
  mmo1.Lines.Clear;
  lst1.Items.Add('TSKSample');
  lst1.Items.Add('TEL与TSK的MAP转换');
  lst1.Items.Add('WAT FTP');
  lst1.Items.Add('重复点筛选功能');
  lst1.Items.Add('WATLimit创建功能');

end;

procedure TForm14.lst1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if lst1.Selected[0] then
  begin
    mmo1.Lines.Clear;
    mmo1.Lines.Add(HelpSample);
  end;
  if lst1.Selected[1] then
  begin
    mmo1.Lines.Clear;
    mmo1.Lines.Add(TEl2TSK);
  end;
    if lst1.Selected[2] then
  begin
    mmo1.Lines.Clear;
    mmo1.Lines.Add(WATFtp);
  end;
    if lst1.Selected[3] then
  begin
    mmo1.Lines.Clear;
    mmo1.Lines.Add(ReTest);
  end;
    if lst1.Selected[4] then
  begin
    mmo1.Lines.Clear;
    mmo1.Lines.Add(WatLimit);
  end;

end;

end.

