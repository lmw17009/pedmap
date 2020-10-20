unit WAT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TForm9 = class(TForm)
    edtXIndex: TEdit;
    edtYIndex: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    btn1: TButton;
    btn2: TButton;
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

uses
  Unit1;
{$R *.dfm}

procedure TForm9.btn1Click(Sender: TObject);
var
  TempX, TempY: Integer;
begin
  TempX := StrToInt(edtXIndex.Text);
  TempY := StrToInt(edtYIndex.Text);
  if MessageBox(0, '���д���������ܵ��"�����ļ�"���ܣ�����Ḳ�Ǳ���Device����', '����', MB_YESNO) = mrYes then
  begin
    Form1.WatParInput(TempX, TempY);
    Self.Close;
  end;
end;

procedure TForm9.btn2Click(Sender: TObject);
begin
  edtXIndex.Text := '';
  edtYIndex.Text := '';
end;

procedure TForm9.FormCreate(Sender: TObject);
begin
  Self.Position:=poDesktopCenter;
end;

end.

