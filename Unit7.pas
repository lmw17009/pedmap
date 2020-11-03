unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.ODBCDef,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.ODBC, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Win.ComObj, Data.Win.ADODB;

type
  TForm7 = class(TForm)
    btn1: TButton;
    dlgOpen1: TOpenDialog;
    mmo1: TMemo;
    Conn1: TFDConnection;
    Qry1: TFDQuery;
    fdphysdbcdrvrlnk1: TFDPhysODBCDriverLink;
    btn2: TButton;
    con1: TADOConnection;
    qry2: TADOQuery;
    btn3: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ReadXls(path: string): Boolean;
  end;

var
  Form7: TForm7;

implementation

uses
  Global;
{$R *.dfm}

procedure TForm7.btn1Click(Sender: TObject);
var
  dlg: TOpenDialog;
  FileName: TStrings;
  i: Integer;
  SavePath: string;
begin
  SavePath := ExtractFileDir(ParamStr(0)) + '\XlsSave\';
  FileName := TStringList.Create;
  if not DirectoryExists(SavePath) then
  begin
    CreateDir(SavePath);
  end;
  if not FileExists(ExtractFileDir(ParamStr(0)) + '\sample\sample.xls') then
  begin
    ShowMessage('Acco模版xls不存在[\sample\sample.xls]');
    Exit;
  end;

  dlg := TOpenDialog.Create(Self);
  dlg.Filter := '需要转换的Focus文件(*.xls;*xlsx)|*.xls;*xlsx';
  dlg.Options := [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing];
  dlg.InitialDir := 'd:';
  try
    if dlg.Execute then
    begin
      FileName := dlg.Files;
      mmo1.Lines.AddStrings(FileName);
      for i := 0 to FileName.Count - 1 do
      begin
        ReadXls(FileName[i]);
      end;

    end;
  finally
    FreeAndNil(dlg);
    FileName := nil;
  end;

end;

procedure TForm7.btn2Click(Sender: TObject);
var
  Conn: TFDConnection;
  Qry: TFDQuery;
  Tables: TStringList;
begin
  Conn := TFDConnection.Create(Self);
  Tables := TStringList.Create;
  Qry := TFDQuery.Create(Self);
  Qry.Connection := Conn;
  Conn.Params.DriverID := 'ODBC';
  Conn.Params.Values['DataSource'] := 'Excel Files';
  Conn.Params.Database := 'D:\Lidashi\dephixeproject\tskmap\tskmap\Win32\Debug\sample.xls';
  Conn.LoginPrompt := False;
  Conn.Connected := True;
  with Qry do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'create table tmp_rece1( ,姓名 char(20),班级 char(20),dat datetime)';
    ExecSQL;
    mmo1.Lines.Add('ADD OK');
    Close;

  end;
  Conn.Close;
  Qry.Free;
  Conn.Free;
  Tables := nil;

end;

procedure TForm7.btn3Click(Sender: TObject);
var
  dlg: TOpenDialog;
  Ado: TADOConnection;
  Qry: TADOQuery;
  FileName: TStrings;
  i: Integer;
begin

  dlg := TOpenDialog.Create(Self);
  dlg.Filter := '需要转换的Focus文件(*.xls;*xlsx)|*.xls;*xlsx';
  dlg.Options := [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing];
  dlg.InitialDir := 'd:';
  try
    if dlg.Execute then
    begin
      FileName := TStringList.Create;
      FileName := dlg.Files;
      mmo1.Lines.AddStrings(FileName);
      for i := 0 to FileName.Count - 1 do
      begin
        Ado := TADOConnection.Create(Self);
        Ado.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;Password="";Data Source=' + FileName[i] + ';Extended Properties=''Excel 12.0;IMEX=1;HDR=YES'';Persist Security Info=True;';
        Qry.Connection := Ado; //'Provider=Microsoft.ACE.OLEDB.12.0;Password="";Data Source=' + sFileName+';Extended Properties=''Excel 12.0;IMEX=1;HDR=YES'';Persist Security Info=True;';

        Ado.Connected := True;

      end;
      Qry.Close;
      Ado.Connected := False;
      Ado.Free;
      Qry.Free;
    end;
  finally

    FreeAndNil(dlg);
    FileName := nil;
  end;

end;

procedure TForm7.FormCreate(Sender: TObject);
begin
  mmo1.Lines.Clear;
end;

function TForm7.ReadXls(path: string): Boolean;
var
  Conn: TFDConnection;
  Qry: TFDQuery;
  Tables: TStringList;
  i: Integer;
  j: Integer;
  Str, StrTemp, StrTempNew: string;
  ValueCount, FstAccCount: Integer;
  NotAcco: Boolean;
  PPID, Lot, WaferID: string;
  ppid1: TStrings;
  //TableName:string;
  TileArr: TStrings;
  CompanyName: string;
  ConnSam: TFDConnection;
  QrySam: TFDQuery;
begin
  TileArr := TStringList.Create;
  NotAcco := False;
  ppid1 := TStringList.Create;
  Conn := TFDConnection.Create(Self);
  Tables := TStringList.Create;
  Qry := TFDQuery.Create(Self);
  Qry.Connection := Conn;
  Conn.Params.DriverID := 'ODBC';
  Conn.Params.Values['DataSource'] := 'Excel Files';
  Conn.Params.Database := path;
  Conn.LoginPrompt := False;
  try
    Conn.Close;
    Conn.Connected := True;
    Conn.GetTableNames('', '', '', Tables, [osMy, osSystem, osOther], [tkTable], False);
    for i := 0 to Tables.Count - 1 do
    begin
      StrTemp := Tables[i];
      for j := 1 to Length(StrTemp) do
      begin
        if (StrTemp[j] in ['0'..'9']) or (StrTemp[j] in ['a'..'z']) or (StrTemp[j] in ['A'..'Z']) or (StrTemp[j] in ['_', '-', '.', '#', ' ', '$']) then
        begin
          StrTempNew := StrTempNew + StrTemp[j];
        end;

      end;
      Tables[i] := StrTempNew;
      if StrTempNew = 'Counter$' then
      begin
        NotAcco := True;
      end;

      StrTempNew := '';

    end;
    if not NotAcco then
    begin
      ShowMessage(path + '是Acco文件');
      Exit;
    end;

    mmo1.Lines.AddStrings(Tables);

    with Qry do
    begin
      for i := 0 to Tables.Count - 1 do
      begin
        if Tables[i] = 'Counter$' then
          Continue;
//        Close;
//        SQL.Clear;
//        SQL.Text := 'select * from [' + Tables[i] + 'A2:A1]';
//        Open();
//
//        if RecordCount >= 0 then
//        begin
//          First;
//          while not Eof do
//          begin
//            mmo1.Lines.Add(Fields[0].AsString);
//            Next;
//          end;
//          //CompanyName := Fields[0].AsString; //Focused Test Inc.
//          Exit;
//        end;
//        if Copy(CompanyName, 1, 5) <> 'Focus' then
//        begin
//          ShowMessage('这不是focus文件');
//          Exit;
//        end;

        Close;
        SQL.Clear;
        SQL.Text := 'select * from [' + Tables[i] + 'B3:B4]';
        Open();
        //获取PPID
        if RecordCount >= 0 then
        begin
          First;
          PPID := Fields[0].AsString;
        end;
        //获取lot waferid
        Close;
        SQL.Clear;
        SQL.Text := 'select * from [' + Tables[i] + 'G2:G4]';
        Open();
        if RecordCount > 0 then
        begin
          First;
          Lot := Fields[0].AsString;
          Next;
          WaferID := Fields[0].AsString;
        end;

        //获取标题
        Close;
        SQL.Clear;
        SQL.Text := 'select * from [' + Tables[i] + 'F12:BA13]';
        Open();

        if RecordCount > 0 then
        begin
          First;
          mmo1.Lines.Add('title数目' + IntToStr(Fields.Count));
          while not Eof do
          begin
            for j := 0 to Fields.Count - 1 do
            begin
              if Fields[j].AsString <> '' then
              begin
                TileArr.Add(Fields[j].AsString);
              end;
            end;

            Next;
          end;
        end;
        mmo1.Lines.Add('标题数目为=' + IntToStr(TileArr.Count));
        mmo1.Lines.AddStrings(TileArr);
        mmo1.Lines.Add('ok');
        Break;
      end;
      //获取数据
      Close;
      SQL.Clear;
      SQL.Text := 'select * from ' + Tables[1] + Fs_Pos_Range + ']';
      ExecSQL;

      if RecordCount > 0 then
      begin
        SetLength(F2A_Xpos, 65535);
        SetLength(F2A_Ypos, 65535);
        First;
        OneSheetRow := 0;
        while not Eof do
        begin
          F2A_Xpos[OneSheetRow] := Fields[0].AsInteger;
          F2A_Ypos[OneSheetRow] := Fields[1].AsInteger;
          Next;
          Inc(OneSheetRow);
        end;
        SetLength(F2A_Xpos, OneSheetRow + 1);
        SetLength(F2A_Ypos, OneSheetRow + 1);
      end;
    end;

    //mmo1.Lines.Add(PPID);
    //mmo1.Lines.Add(Lot);
    //mmo1.Lines.Add(WaferID);
//    Conn.Close;
//    Conn.Params.Database := 'sample.xls';
//    Conn.Connected := True;
//    with Qry do
//    begin
//      Close;
//      SQL.Clear;
//      SQL.Text := 'create table tmp_rece( 学号 char(20),姓名 char(20),班级 char(20),dat datetime)';
//      mmo1.Lines.Add('add...');
//      ExecSQL;
//      Close;
//
//    end;

    ConnSam := TFDConnection.Create(Self);
    QrySam := TFDQuery.Create(Self);
    QrySam.Connection := ConnSam;
    ConnSam.Params.DriverID := 'ODBC';
    ConnSam.Params.Values['DataSource'] := 'Excel Files';
    ConnSam.Params.Database := ExtractFileDir(ParamStr(0)) + '\sample\sample.xls';
    ConnSam.LoginPrompt := False;
    try
     //ConnSam.Connected:=True;
      QrySam.Close;

    except

    end;
  except

  end;
  Qry.Close;
  Conn.Connected := False;
  Conn.Close;
  Qry.Free;
  Conn.Free;
  Tables := nil;

end;

end.

