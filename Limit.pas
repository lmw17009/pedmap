unit Limit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.ODBCDef,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.ODBC, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Menus;

type
  TForm10 = class(TForm)
    mmo1: TMemo;
    btn1: TButton;
    dlgOpen1: TOpenDialog;
    mmo2: TMemo;
    Conn1: TFDConnection;
    Qry1: TFDQuery;
    fdphysdbcdrvrlnk1: TFDPhysODBCDriverLink;
    edtPPIDName: TEdit;
    mm1: TMainMenu;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}
uses
  XlsSetup;

procedure TForm10.btn1Click(Sender: TObject);
var
  Dlg: TOpenDialog;
  FileList: TStrings;
  I, J, K, M, N: Integer;
  MyCon: TFDConnection;
  MyQry: TFDQuery;
  Tables: TStrings;
  StrTemp, StrTempNew: string;
  NotAcco: Boolean;
  FileName: string;
  PPID: string;
  ErrMsg: string;
  TypeList: TStrings;
begin
  if edtPPIDName.Text <> '' then
  begin
    Dlg := TOpenDialog.Create(Self);
    FileList := TStringList.Create;
    TypeList := TStringList.Create;
    Dlg.Filter := '��Ҫ���ĵ��ļ�(*.xls;*xlsx)|*.xls;*xlsx';
    Dlg.Options := [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing];
    Dlg.InitialDir := ExtractFilePath(ParamStr(0)) + 'Limit';

    try
      if Dlg.Execute then
      begin
        FileList := Dlg.Files;
        MyQry := TFDQuery.Create(Self);
        Tables := TStringList.Create;
        ErrMsg := '׼��ѭ���ļ���⣡';
        for I := 0 to FileList.Count - 1 do
        begin
          ErrMsg := IntToStr(I) + '=>' + '��⿪ʼ:';
          MyCon := TFDConnection.Create(Self);
          MyCon.Params.DriverID := 'ODBC';
          MyCon.Params.Values['DataSource'] := 'Excel Files';
          MyCon.LoginPrompt := False;
          NotAcco := False;
          FileName := ExtractFileName(FileList[I]);
          mmo1.Lines.Add(FileName);
          MyCon.Params.Add('DataBase=' + FileList[I]);
          MyQry.Connection := MyCon;
          ErrMsg := IntToStr(I) + '=>' + '׼�����Ӳ���...';
          MyCon.Connected := True;
          mmo1.Lines.AddStrings(Tables);
          MyCon.GetTableNames('', '', '', Tables, [osMy, osSystem, osOther], [tkTable], False);
          ErrMsg := IntToStr(I) + '=>' + '��ȡtables�б�';
          for J := 0 to Tables.Count - 1 do
          begin
            StrTemp := Tables[J];
            for K := 1 to Length(StrTemp) do
            begin
              if (StrTemp[K] in ['0'..'9']) or (StrTemp[K] in ['a'..'z']) or (StrTemp[K] in ['A'..'Z']) or (StrTemp[K] in ['_', '-', '.', '#', ' ', '$']) then
              begin
                StrTempNew := StrTempNew + StrTemp[K];
              end;

            end;
            ErrMsg := IntToStr(I) + '=>' + 'tables�����ַ�������...';
            Tables[J] := StrTempNew;
            if StrTempNew = 'Counter$' then
            begin
              NotAcco := True;
            end;
            StrTempNew := '';

          end;
          ErrMsg := IntToStr(I) + '=>' + '�ж��Ƿ�Acco�ļ�...';
          if not NotAcco then
          begin
            mmo2.Lines.Add('A-' + FileName.Split(['_'])[1]);
            TypeList.Add('A');
          end
          else
          begin
            TypeList.Add('NA');
//          ErrMsg := IntToStr(I) + '=>' + '��Acco�ļ���Ҫ����tables��...';
//          for K := 0 to Tables.Count - 1 do
//          begin
//            if Tables[K] <> 'Counter$' then
//            begin
//              ErrMsg := IntToStr(I) + '=>' + 'Myqry��ѯ��...';
//              with MyQry do
//              begin
//                Close;
//                SQL.Clear;
//                SQL.Text := 'select * from [' + Tables[K] + 'B3:B4]';
//                Open();
//                if RecordCount >= 0 then
//                begin
//                  First;
//                  PPID := Fields[0].AsString;
//                  mmo2.Lines.Add('NA-' + PPID);
//                end;
//              end;
//            end;
//          end;
          end;

        //  FileList[I] := '';
        //��ѯ��ǰ��limit

          ErrMsg := IntToStr(I) + '=>' + '׼����Դ�ͷţ�';
          MyCon.Close;
          MyCon.Connected := False;
          FreeAndNil(MyCon);
          Tables.Clear;
          ErrMsg := IntToStr(I) + '=>' + '��Դ�ͷ���ϣ�';
        end;

      //�ռ��������
        ErrMsg := IntToStr(I) + '=>' + '�ļ����������ռ���ϣ�';
      //���list���͸������ļ�������Ŀ�Ƿ���ȷ
        if TypeList.Count = FileList.Count then
        begin
          if MessageDlg('�Ƿ�һ��������', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          begin
            ErrMsg := '�ļ���������...';
            MyCon := TFDConnection.Create(Self);
            MyCon.Params.DriverID := 'ODBC';
            MyCon.Params.Add('Provider=Microsoft.Ace.OLEDB.12.0;Extended Properties=Excel 12.0;Persist Security Info=True');
            MyCon.Params.Values['DataSource'] := 'Excel Files';
            MyCon.LoginPrompt := False;
            for N := 0 to TypeList.Count - 1 do
            begin
              if TypeList[N] = 'A' then
              begin
                MyCon.Params.Add('DataBase=D:\Lidashi\dephixeproject\tskmap\tskmap\Win32\Debug\Limit\1.XLS'); // + FileList[N]);
                MyQry.Connection := MyCon;
                MyCon.Connected := True;

                with MyQry do
                begin
                  Close;
                  SQL.Clear;
                  //SQL.Text := 'UPDATE [Summary information$] SET [C2:C2]=123';
                  SQL.Text := 'UPDATE [123$] SET [NUMBER]=1 WHERE [ID]=1';
                  ExecSQL;

                end;

              end
              else
              begin

              end;
            end;
          end;
        end
        else
        begin
        //���ѹ���
        end;

        TypeList.Clear;
        FileList.Clear;
        Tables.Clear
      //mmo1.Lines.AddStrings(Dlg.Files);
       //ExtractFileName
      end;
    finally
      FreeAndNil(Dlg);
      //FreeAndNil(FileList);
      FreeAndNil(MyQry);
      FreeAndNil(Tables);
      //FreeAndNil(TypeList);
      ShowMessage(ErrMsg);

    end;
  end;

end;

procedure TForm10.FormCreate(Sender: TObject);
begin
  mmo1.Lines.Clear;
  mmo2.Lines.Clear;
end;

end.

