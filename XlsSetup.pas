unit XlsSetup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

const
  TstJUNO = 0;
  TstFTI = 1;
  TstACCO = 2;

type
  XlsParam = record
    PPIDPos: string; //ppid' col row in xls
    LotPos: string; //LongInt colrow in xls
    WaferIDPos: string; //id colrow in xls
    MinTables: Integer; //min tables in xls
    MaxTables: Integer; //max tables in xls,because some xls lines up to 65535 lines will become 2 sheets.
    CreateTime: string;
    TableDiff: string; //use which table name to difference from other tester's data xls file?[juno& focus counter$,acco dutu*$]
    DiffBool: Boolean; //has tablesdiff or no tablesdiff
  end;

type
  TForm13 = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    chkJuno: TCheckBox;
    chkFocus: TCheckBox;
    chkAcco: TCheckBox;
    lst1: TListBox;
    mmo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure lst1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    function ShowSetup(Index: Integer): Boolean;
    function LoadTstParam: Boolean;
    procedure Mmadd(MSG: string); overload;
    procedure Mmadd(MSG: string; IsClear: Boolean); overload;
  end;

var
  Form13: TForm13;
  JunoParam, FTIParam, AccoParam: XlsParam;

implementation

{$R *.dfm}

procedure TForm13.FormCreate(Sender: TObject);
begin
  mmo1.Lines.Clear;
  with lst1.Items do
  begin
    Add('JUNO');
    Add('FTI');
    Add('ACCO');
  end;
end;

function TForm13.LoadTstParam: Boolean;
begin
  if FileExists('\Config\XlsSetup.txt') then
  begin

  end
  else
  begin
    JunoParam.PPIDPos := 'C4:C5';
    JunoParam.LotPos := '';
    JunoParam.WaferIDPos := '';
    JunoParam.MinTables := 2;
    JunoParam.MinTables := 3;
    JunoParam.TableDiff := 'Counter$';
    JunoParam.DiffBool := True;

    FTIParam.PPIDPos := 'C4:C5';
    FTIParam.LotPos := '';
    FTIParam.WaferIDPos := '';
    FTIParam.MinTables := 2;
    FTIParam.MinTables := 3;
    FTIParam.TableDiff := 'Counter$';
    FTIParam.DiffBool := True;

    AccoParam.PPIDPos := 'C4:C5';
    AccoParam.LotPos := '';
    AccoParam.WaferIDPos := '';
    AccoParam.MinTables := 3;
    AccoParam.MinTables := 4;
    AccoParam.TableDiff := 'Dutu';
    AccoParam.DiffBool := False;

  end;

end;

procedure TForm13.lst1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if lst1.Selected[TstJUNO] then
  begin
    ShowSetup(TstJUNO);
  end;
  if lst1.Selected[TstFTI] then
  begin
    ShowSetup(TstFTI);
  end;
  if lst1.Selected[TstACCO] then
  begin
    ShowSetup(TstACCO);
  end;
end;

procedure TForm13.Mmadd(Msg: string; IsClear: Boolean);
begin
  if IsClear then
  begin
    mmo1.Lines.Clear;
    mmo1.Lines.Add(Msg);
  end
  else
  begin
    mmo1.Lines.Add(Msg);
  end;
end;

procedure TForm13.Mmadd(Msg: string);
begin
  mmo1.Lines.Add(Msg);
end;

function TForm13.ShowSetup(Index: Integer): Boolean;
begin
   //ʹ��һ����¼�ļ�ȥ��¼��ͬ����xls������

end;

end.

