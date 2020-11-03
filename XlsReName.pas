unit XlsReName;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TForm12 = class(TForm)
    edtCheckPath: TEdit;
    btnAddpath: TButton;
    btnOpenFile: TButton;
    mmo1: TMemo;
    dlgOpen1: TOpenDialog;
    flpndlg1: TFileOpenDialog;
    procedure btnAddpathClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOpenFileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

{$R *.dfm}

procedure TForm12.btnAddpathClick(Sender: TObject);
var
  Dlg: TFileOpenDialog;
  FolderPath: string;
begin
  Dlg := TFileOpenDialog.Create(Self);
  try
    Dlg.Options := Dlg.Options + [fdoPickFolders];
    if not Dlg.Execute then
      Abort;
    FolderPath := Dlg.FileName;
    edtCheckPath.Text := FolderPath;

  finally
    Dlg.Free;
  end;
end;

procedure TForm12.btnOpenFileClick(Sender: TObject);
var
  Dlg: TOpenDialog;
  FileList: TStrings;
begin

  try
    Dlg := TOpenDialog.Create(Self);
    FileList := TStringList.Create;
    Dlg.Options := Dlg.Options + [ofAllowMultiSelect];
    if not Dlg.Execute then
      Abort;
    mmo1.Lines.AddStrings(Dlg.Files);
    FileList := Dlg.Files;

  finally
    Dlg.Free;
    FreeAndNil(FileList);
  end;

end;

procedure TForm12.FormCreate(Sender: TObject);
begin
  mmo1.Lines.Clear;
end;

end.

