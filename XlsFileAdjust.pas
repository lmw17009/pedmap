unit XlsFileAdjust;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Winapi.ShellAPI, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait,
  FireDAC.Phys.ODBCDef, FireDAC.Phys.ODBCBase, FireDAC.Phys.ODBC,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Menus, RegularExpressions, System.StrUtils,
  System.Win.ComObj;

const
  XlsDiffTableName = 'Counter$';
  XlsDiffTablesNameAcco = 'Summary information$';
  AccoXls_0 = 'Summary information';
  JunoFocusXLs_0 = 'Counter';
  XlsAccoTitle = 'STS8202 StationA';
  XlsJunoTitle = 'ShangHai JUNO Corporation Electronics Co.,LTD';
  XlsFocusTitle = 'Focused Test Inc.';
  EasOWPath = '\\10.9.64.72\cp\CP_OW\EAS01\重测数据放置文件夹\';
  AccoOWPath = '\\10.9.64.72\cp\CP_OW\ACCO01-8S\';
  FocusOWPath = '\\10.9.64.72\cp\CP_OW\Focus02\';
  JunoOWPath = '\\10.9.64.72\cp\CP_OW\JUNO01\重测数据放置文件夹\';

type
  TXls = record
    FilePath: string; //文件路径
    FileName: string; //文件名
    Tables: TStrings; //sheet 表名列表
    TablesCount: Integer; //sheet表数量
    PPID: string;    //PPID
    LotID: string; //LotID
    ID: string; //Wafer ID
    IsAccoType: Boolean; //xls是否是acco格式？
    CompanyIndex: Integer; //1 acco 2 juno 3 fti focus
    DataOut: Boolean;
    IsEas: Boolean;
  end;

  pTXls = ^TXls;

  TXlsArr = array of TXls;

  pTXlsArr = ^TXlsArr;

  TXlsList = class(TObject)
  private
    FList: TXlsArr; //xls文件组
    FMaxCount: Integer; //最大列表数目
    FCount: Integer; //文件数目
    function Get(Index: Integer): pTXls;
    procedure SetMaxCount(Value: Integer);
    procedure InitialProcess;
    procedure Finalize;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(out Item: pTXls): Integer;
    procedure Clear;
    property MaxCount: Integer read FMaxCount write SetMaxCount;
    property Count: Integer read FCount;
    property Items[Index: Integer]: pTXls read Get; Default;
  end;

type
  TXlsFileRename = class(TForm)
    lv1: TListView;
    Conn1: TFDConnection;
    Qry1: TFDQuery;
    fdgxwtcrsr1: TFDGUIxWaitCursor;
    fdphysdbcdrvrlnk1: TFDPhysODBCDriverLink;
    cbb1: TComboBox;
    cbb2: TComboBox;
    edtAccoPPID: TEdit;
    edtACCOLotID: TEdit;
    lbl2: TLabel;
    cbb3: TComboBox;
    cbb4: TComboBox;
    edtFocusPPID: TEdit;
    edtFocusLotID: TEdit;
    grp1: TGroupBox;
    grp2: TGroupBox;
    btnYes: TButton;
    mm1: TMainMenu;
    N1: TMenuItem;
    dlgOpen1: TOpenDialog;
    edtAdjPPID: TEdit;
    edtAdjLotID: TEdit;
    grp3: TGroupBox;
    edtJUNOLotID: TEdit;
    edtJUNOPPID: TEdit;
    cbb6: TComboBox;
    cbb5: TComboBox;
    edtFocusAdjustPPID: TEdit;
    pm1: TPopupMenu;
    N2: TMenuItem;
    btnMoveFileOW: TButton;
    chkAutoOpenOW: TCheckBox;
    btnFileNameChane: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbb1Select(Sender: TObject);
    procedure cbb2Select(Sender: TObject);
    procedure cbb3Select(Sender: TObject);
    procedure cbb4Select(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure edtAccoPPIDChange(Sender: TObject);
    procedure edtACCOLotIDChange(Sender: TObject);
    procedure btnYesClick(Sender: TObject);
    procedure edtFocusPPIDChange(Sender: TObject);
    procedure cbb5Select(Sender: TObject);
    procedure cbb6Select(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure btnMoveFileOWClick(Sender: TObject);
    procedure btnFileNameChaneClick(Sender: TObject);
  private
    procedure ChangeXlsData(out XlsCount: Integer);
    procedure XlsAddList;
    { Private declarations }
  public
    { Public declarations }
    procedure DropFiles(var MSG: TMessage); message WM_DROPFILES;
    function XlsFileRead(FileList: TStrings): Boolean;
    function XlsRead(FilePath: string): Boolean;
    //function GotXlsMsg(FilePath: string): Boolean;
    procedure TablesAdj(out Table: TStrings; out IsAcco: Boolean);
    procedure DataIni;
    function ReXlsName(List: TXlsList; out Count: Integer): Boolean;
    procedure PosStr(Str: string; StrFind: string; Pos: Integer; out SplitStr_1: string);
    function StrCount(SubStr, Str: string): Integer; overload;
    function StrCount(SubStr, Str: string; IndexPos: Integer; Direction: Integer): Integer; overload;
    function ApcXls2List(Path: string): TStrings;
    function XlsDataChange(FilePathList: TXlsList): Boolean;
  end;

var
  XlsFileRename: TXlsFileRename;
  PedXlsList: TXlsList;
  TempXlsList: TStrings; //xls文件列表
  //XlsTables: TStrings; //tables list
  DataOutWarn: Boolean; //是否开启out警告？

implementation

uses
  Global;
{$R *.dfm}

{ TXlsFileRename }

function TXlsFileRename.ApcXls2List(Path: string): TStrings;
var
  Con1: TFDConnection;
  Qry1: TFDQuery;
begin
  Con1 := TFDConnection.Create(Self);
  Qry1 := TFDQuery.Create(Self);
  Con1.Params.DriverID := 'ODBC';
  Con1.Params.Values['DataSource'] := 'Excel Files';
  Con1.LoginPrompt := False;
  Con1.Params.Add('DataBase=' + Path);
  Con1.Connected := True;
  Qry1 := TFDQuery.Create(Self);
  Qry1.Connection := Con1;
  Con1.Free;
  Qry1.Free;
end;

procedure TXlsFileRename.btnFileNameChaneClick(Sender: TObject);
var
  I: Integer;
  XlsNameLength, FucosFilterPos: Integer;
  FileName, FileName_1: string;
  Count: Integer;
begin
  ShowMessage('ACCO结尾标识符="12_.xls"或者"1_.xls"' + #13 + 'JUNO结尾标识符="-Data.xls"' + #13 + 'Focus=结尾标识符"_FT.xls"' + #13 + '如有无法修改的情况请及时告知于我。');
  Count := 0;
  for I := 0 to PedXlsList.Count - 1 do
  begin
    FileName := PedXlsList[I].FileName;
    XlsNameLength := Length(FileName);
    case PedXlsList[I].CompanyIndex of
      1:
        begin
        //acco
          if FileName[XlsNameLength - 3] = '.' then
          begin
             //确定后缀一定是.xls
            if FileName[XlsNameLength - 4] <> '_' then
            begin
               //异常文件名需更改
               //去掉文件后缀
                //从右往左检测相邻二个"_"的位置差
              if StrCount('_', FileName, 1, 1) - StrCount('_', FileName, 2, 1) > 3 then
              begin
                //需要再去掉2次长后缀字符串20201110062410_waferout.xls
                FileName_1 := Copy(FileName, 1, StrCount('_', FileName, 2, 1));
              end
              else
              begin
              //需要再去掉1次长后缀字符串20201110062410.xls
                FileName_1 := Copy(FileName, 1, StrCount('_', FileName, 1, 1));
              end;
              FileName := FileName_1 + '.xls';
            end;
           //rename
            RenameFile(PedXlsList[I].FilePath, ExtractFileDir(PedXlsList[I].FilePath) + '\' + FileName);
            TempXlsList[I] := ExtractFileDir(PedXlsList[I].FilePath) + '\' + FileName;
            Inc(Count);
          end;
        end;
      2:
        begin
        //juno
          FileName := Copy(FileName, 1, StrCount('-', FileName, 1, 1) + 4) + '.xls';
          RenameFile(PedXlsList[I].FilePath, ExtractFileDir(PedXlsList[I].FilePath) + '\' + FileName);
          TempXlsList[I] := ExtractFileDir(PedXlsList[I].FilePath) + '\' + FileName;
          Inc(Count);
        end;
      3:
        begin
        //focus
          if Copy(FileName, Length(FileName) - 5, 2) <> 'FT' then
          begin
            FucosFilterPos := StrCount('_', FileName, 1, 1);
            if Copy(FileName, FucosFilterPos + 1, 2) = 'FT' then
            begin
              FileName_1 := Copy(FileName, 1, FucosFilterPos + 2) + '.xls';
            end
            else
            begin
              FucosFilterPos := StrCount('_', FileName, 2, 1);
              if Copy(FileName, FucosFilterPos + 1, 2) = 'FT' then
              begin
                FileName_1 := Copy(FileName, 1, FucosFilterPos + 2) + '.xls';
              end;
            end;
            FileName := FileName_1;
            RenameFile(PedXlsList[I].FilePath, ExtractFileDir(PedXlsList[I].FilePath) + '\' + FileName);
            TempXlsList[I] := ExtractFileDir(PedXlsList[I].FilePath) + '\' + FileName;
            Inc(Count);
          end;
        end;

    end;
  end;
  if Count <> 0 then
  begin
    DataIni;
    for I := 0 to TempXlsList.Count - 1 do
    begin
      XlsRead(TempXlsList[I]);
    end;
  end;
  ShowMessage('共修改了' + IntToStr(Count) + '个文件！');
end;

procedure TXlsFileRename.btnMoveFileOWClick(Sender: TObject);
var
  I: Integer;
  EasFile, AccoFile, FocusFile, JunoFile: Integer;
begin
  ShowMessage('如还未修改数据请点击取消！');
  ShowMessage('EAS=' + EasOWPath + #13 + 'ACCO=' + AccoOWPath + #13 + 'JUNO=' + JunoOWPath + #13 + 'Focus=' + FocusOWPath);
  if MessageDlg('请确认处于跳板机系统，且可直接访问10.9.64.72！', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, mbNo], 0) = mrYes then
  begin
    if MessageDlg('此操作会按不同机台类型直接移动数据文件到各OW路径，请确认！', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, mbNo], 0) = mrYes then
    begin
      if PedXlsList.Count <> 0 then
      begin
        EasFile := 0;
        AccoFile := 0;
        FocusFile := 0;
        JunoFile := 0;
        for I := 0 to PedXlsList.Count - 1 do
        begin
          if PedXlsList[I].IsEas then
          begin
            MoveFile(PWideChar(PedXlsList[I].FilePath), PWideChar(EasOWPath + PedXlsList[I].FileName));
            Inc(EasFile);
            Continue;
          end
          else
          begin
            case PedXlsList[I].CompanyIndex of
              1:
                begin
               //acco
                  MoveFile(PWideChar(PedXlsList[I].FilePath), PWideChar(AccoOWPath + PedXlsList[I].FileName));
                  Inc(AccoFile);
                  Continue;
                end;
              2:
                begin
               //juno
                  MoveFile(PWideChar(PedXlsList[I].FilePath), PWideChar(JunoOWPath + PedXlsList[I].FileName));
                  Inc(JunoFile);
                  Continue;
                end;
              3:
                begin
               //focus
                  MoveFile(PWideChar(PedXlsList[I].FilePath), PWideChar(FocusOWPath + PedXlsList[I].FileName));
                  Inc(FocusFile);
                  Continue;
                end;

            end;
          end;
        end;
        if chkAutoOpenOW.Checked then
        begin
          if EasFile > 0 then
          begin
            ShellExecute(Handle, 'open', 'Explorer.exe', PChar(EasOWPath), nil, SW_NORMAL);
          end;
          if AccoFile > 0 then
          begin
            ShellExecute(Handle, 'open', 'Explorer.exe', PChar(AccoOWPath), nil, SW_NORMAL);
          end;
          if JunoFile > 0 then
          begin
            ShellExecute(Handle, 'open', 'Explorer.exe', PChar(JunoOWPath), nil, SW_NORMAL);
          end;
          if FocusFile > 0 then
          begin
            ShellExecute(Handle, 'open', 'Explorer.exe', PChar(FocusOWPath), nil, SW_NORMAL);
          end;
        end;

      end
      else
      begin
        ShowMessage('无可移动数据文件。');
      end;
    end;
  end;

end;

procedure TXlsFileRename.btnYesClick(Sender: TObject);
var
  Count, i, AdjCount: Integer;
begin
  //ChangeXlsData(AdjCount);--有问题 部分表名和第一行暂时没法修改。
  if DataOutWarn then
  begin
    ShowMessage('发现有out数据，请注意处理！');
  end;
  XlsDataChange(PedXlsList);
  //ReXlsName(PedXlsList, Count);
  DataIni;
  for i := 0 to TempXlsList.Count - 1 do
  begin
    XlsRead(TempXlsList[i]);
  end;
  XlsAddList;

end;

procedure TXlsFileRename.cbb1Select(Sender: TObject);
begin
  edtAccoPPID.Text := cbb1.Items[cbb1.ItemIndex];
end;

procedure TXlsFileRename.cbb2Select(Sender: TObject);
begin
  edtACCOLotID.Text := cbb2.Items[cbb2.ItemIndex];
end;

procedure TXlsFileRename.cbb3Select(Sender: TObject);
begin
  edtFocusPPID.Text := cbb3.Items[cbb3.ItemIndex];
end;

procedure TXlsFileRename.cbb4Select(Sender: TObject);
begin
  edtFocusLotID.Text := cbb4.Items[cbb4.ItemIndex];
end;

procedure TXlsFileRename.cbb5Select(Sender: TObject);
begin
  edtJUNOPPID.Text := cbb5.Items[cbb5.ItemIndex];
end;

procedure TXlsFileRename.cbb6Select(Sender: TObject);
begin
  edtJUNOLotID.Text := cbb6.Items[cbb6.ItemIndex];
end;

procedure TXlsFileRename.DataIni;
begin
  cbb1.Clear;
  cbb2.Clear;
  cbb3.Clear;
  cbb4.Clear;
  cbb5.Clear;
  cbb6.Clear;
  cbb1.Text := '请选择ACCOPPID';
  cbb2.Text := '请选择ACCOLotID';
  cbb3.Text := '请选择FocusPPID';
  cbb4.Text := '请选择FocusLotID';
  cbb5.Text := '请选择JUNOPPID';
  cbb6.Text := '请选择JUNOLotID';
  lv1.Clear;
  PedXlsList.Clear;
  edtAdjPPID.Text := '';
  edtAdjLotID.Text := '';
  edtAccoPPID.Text := '';
  edtACCOLotID.Text := '';
  edtFocusPPID.Text := '';
  edtFocusLotID.Text := '';
  edtJUNOPPID.Text := '';
  edtJUNOLotID.Text := '';
  edtFocusAdjustPPID.Text := '';
end;

procedure TXlsFileRename.ChangeXlsData(out XlsCount: Integer);
var
  APPIDAll: string;
  APPID: string;
  ALotIDAll: string;
  ALotID: string;
  FocusPPID: string;
  FocusLotID: string;
  JunoPPID: string;
  JunoLotID: string;
  I: Integer;
  StrSql: string;
  NormalTable: string;
  J: Integer;
begin
  if PedXlsList.Count = 0 then
    Abort;
  APPIDAll := edtAccoPPID.Text;
  APPID := edtAdjPPID.Text;
  ALotIDAll := edtACCOLotID.Text;
  ALotID := edtAdjLotID.Text;
  FocusPPID := edtFocusPPID.Text;
  FocusLotID := edtFocusLotID.Text;
  JunoPPID := edtJUNOPPID.Text;
  JunoLotID := edtJUNOLotID.Text;
  XlsCount := 0;
  for I := 0 to lv1.Items.Count - 1 do
  begin
    if lv1.Items[I].Checked then
    begin
      case PedXlsList[I].CompanyIndex of
        1:
          begin
            //acco file edit
            //check ppid is or not new?
            Conn1 := TFDConnection.Create(Self);
            Conn1.Params.DriverID := 'ODBC';
            Conn1.Params.Values['DataSource'] := 'Excel Files';
            Conn1.LoginPrompt := False;
            Conn1.Params.Add('DataBase=' + PedXlsList[I].FilePath);
            Conn1.Connected := True;
            Qry1 := TFDQuery.Create(Self);
            Qry1.Connection := Conn1;
            //acco文件只需要修改summary information$即可
            if (PedXlsList[I].PPID <> APPIDAll) and (APPIDAll <> '') then
            begin
              //change ppid
              with Qry1 do
              begin
                Close;
                SQL.Clear;
                StrSql := 'update [' + XlsDiffTablesNameAcco + '] set [' + XlsAccoTitle + ']=''' + APPIDAll + ''' where [' + XlsAccoTitle + ']=''' + PedXlsList[I].PPID + '''';
                SQL.Text := StrSql;
                ExecSQL;

              end;
            end;
            //change lotid
            if (PedXlsList[I].LotID <> ALotIDAll) and (ALotIDAll <> '') then
            begin
              //change ppid
              with Qry1 do
              begin
                Close;
                SQL.Clear;
                SQL.Text := 'update [' + XlsDiffTablesNameAcco + '] set [' + XlsAccoTitle + ']=''' + ALotIDAll + ''' where [' + XlsAccoTitle + ']=''' + PedXlsList[I].LotID + '''';
                ExecSQL;
              end;
            end;
            Inc(XlsCount);
            Conn1.Close;
            Conn1.Free;
            Qry1.Close;
            Qry1.Free;
          end;
        2:
          begin
            //juno
            Conn1 := TFDConnection.Create(Self);
            Conn1.Params.DriverID := 'ODBC';
            Conn1.Params.Values['DataSource'] := 'Excel Files';
            Conn1.LoginPrompt := False;
            Conn1.Params.Add('DataBase=' + PedXlsList[I].FilePath);
            Conn1.Connected := True;
            Qry1 := TFDQuery.Create(Self);
            Qry1.Connection := Conn1;
            case PedXlsList[I].TablesCount of
              2:
                begin
                  //edit data sheet sheet
                  NormalTable := '';
                  for J := 0 to 1 do
                  begin
                    if PedXlsList[I].Tables[J] <> 'Counter$' then
                    begin
                      NormalTable := PedXlsList[I].Tables[J];
                    end;
                  end;
                  if (PedXlsList[I].PPID <> JunoPPID) and (JunoPPID <> '') then
                  begin
                    //change ppid
                    with Qry1 do
                    begin
                      Close;
                      SQL.Clear;
                      StrSql := 'update [' + NormalTable + '] set F2=''' + JunoPPID + ''' where F2=''' + PedXlsList[I].PPID + '''';
                      SQL.Text := StrSql;
                      ExecSQL;
                    end;
                  end;
                  //change lotid
                  if (PedXlsList[I].LotID <> JunoLotID) and (JunoLotID <> '') then
                  begin
                    //change ppid
                    with Qry1 do
                    begin
                      Close;
                      SQL.Clear;
                      SQL.Text := 'update [' + NormalTable + '] set F7=''' + JunoLotID + ''' where F7=''' + PedXlsList[I].LotID + '''';
                      ExecSQL;
                    end;
                  end;
                  Inc(XlsCount);
                end;
              3:
                begin
                  //非acco格式文件如果是3个表则需要修改二个数据表的内容
                  for J := 0 to 2 do
                  begin
                    if PedXlsList[I].Tables[J] <> 'Counter$' then
                    begin
                      NormalTable := PedXlsList[I].Tables[J];
                      if (PedXlsList[I].PPID <> JunoPPID) and (JunoPPID <> '') then
                      begin
                        //change ppid
                        with Qry1 do
                        begin
                          Close;
                          SQL.Clear;
                          StrSql := 'update [' + NormalTable + '] set F2=''' + JunoPPID + ''' where F2=''' + PedXlsList[I].PPID + '''';
                          SQL.Text := StrSql;
                          ExecSQL;
                        end;
                      end;
                      //change lotid
                      if (PedXlsList[I].LotID <> JunoLotID) and (JunoLotID <> '') then
                      begin
                        //change ppid
                        with Qry1 do
                        begin
                          Close;
                          SQL.Clear;
                          SQL.Text := 'update [' + NormalTable + '] set F7=''' + JunoLotID + ''' where F7=''' + PedXlsList[I].LotID + '''';
                          ExecSQL;
                        end;
                      end;
                    end;
                  end;
                  Inc(XlsCount);
                end;
            end;
            Conn1.Connected := False;
            Conn1.Close;
            Conn1.Free;
            Qry1.Close;
            Qry1.Free;
          end;
        3:
          begin
            //Focus
            Conn1 := TFDConnection.Create(Self);
            Conn1.Params.DriverID := 'ODBC';
            Conn1.Params.Values['DataSource'] := 'Excel Files';
            Conn1.LoginPrompt := False;
            Conn1.Params.Add('DataBase=' + PedXlsList[I].FilePath);
            Conn1.Connected := True;
            Qry1 := TFDQuery.Create(Self);
            Qry1.Connection := Conn1;
            case PedXlsList[I].TablesCount of
              2:
                begin
                  //edit data sheet sheet
                  NormalTable := '';
                  for J := 0 to 1 do
                  begin
                    if PedXlsList[I].Tables[J] <> 'Counter$' then
                    begin
                      NormalTable := PedXlsList[I].Tables[J];
                    end;
                  end;
                  if (PedXlsList[I].PPID <> FocusPPID) and (FocusPPID <> '') then
                  begin
                    //change ppid
                    with Qry1 do
                    begin
                      Close;
                      SQL.Clear;
                      StrSql := 'update [' + NormalTable + '] set F2=''' + FocusPPID + ''' where F2=''' + PedXlsList[I].PPID + '''';
                      SQL.Text := StrSql;
                      ExecSQL;
                    end;
                  end;
                  //change lotid
                  if (PedXlsList[I].LotID <> FocusLotID) and (FocusLotID <> '') then
                  begin
                    //change ppid
                    with Qry1 do
                    begin
                      Close;
                      SQL.Clear;
                      SQL.Text := 'update [' + NormalTable + '] set F7=''' + FocusLotID + ''' where F7=''' + PedXlsList[I].LotID + '''';
                      ExecSQL;
                    end;
                  end;
                  Inc(XlsCount);
                end;
              3:
                begin
                  //非acco格式文件如果是3个表则需要修改二个数据表的内容
                  NormalTable := '';
                  for J := 0 to 2 do
                  begin
                    if PedXlsList[I].Tables[J] <> 'Counter$' then
                    begin
                      NormalTable := PedXlsList[I].Tables[J];
                      if (PedXlsList[I].PPID <> FocusPPID) and (FocusPPID <> '') then
                      begin
                        //change ppid
                        with Qry1 do
                        begin
                          Close;
                          SQL.Clear;
                          StrSql := 'update [' + NormalTable + '] set F2=''' + FocusPPID + ''' where F2=''' + PedXlsList[I].PPID + '''';
                          SQL.Text := StrSql;
                          ExecSQL;
                        end;
                      end;
                      //change lotid
                      if (PedXlsList[I].LotID <> FocusLotID) and (FocusLotID <> '') then
                      begin
                        //change ppid
                        with Qry1 do
                        begin
                          Close;
                          SQL.Clear;
                          SQL.Text := 'update [' + NormalTable + '] set F7=''' + FocusLotID + ''' where F7=''' + PedXlsList[I].LotID + '''';
                          ExecSQL;
                        end;
                      end;
                    end;
                  end;
                  Inc(XlsCount);
                end;
            end;
            Conn1.Connected := False;
            Conn1.Close;
            Conn1.Free;
            Qry1.Close;
            Qry1.Free;
          end;
      end;
    end;
  end;
end;

procedure TXlsFileRename.DropFiles(var MSG: TMessage);
var
  buffer: array[0..1024] of Char;
  FileCount: Integer;
  I: Integer;
  DragFileList: TStrings;
begin
  inherited;
  FileCount := DragQueryFile(MSG.WParam, $FFFFFFFF, nil, 0);
  if FileCount > 0 then
  begin
    DragFileList := TStringList.Create;
  end;
  for I := 0 to FileCount - 1 do
  begin
    buffer[0] := #0;
    DragQueryFile(MSG.WParam, I, buffer, SizeOf(buffer)); //第一个文件
    DragFileList.Add(buffer);
  end;
  if TempXlsList = nil then
  begin
    TempXlsList := TStringList.Create;
  end
  else
  begin
    TempXlsList.Clear;
    DataIni;
  end;
  TempXlsList := DragFileList; //存起来做为更新成功后刷新数据检查使用
  //XlsFileRead(DragFileList);
  for I := 0 to DragFileList.Count - 1 do
  begin
    XlsRead(DragFileList[I]);
  end;
  XlsAddList;
end;

procedure TXlsFileRename.edtACCOLotIDChange(Sender: TObject);
var
  Arr: TArray<string>;
begin
  try
    if edtACCOLotID.Text = '' then
      Abort;
    if Pos(':', Trim(edtACCOLotID.Text)) = 0 then
      Abort;
    Arr := Trim(edtACCOLotID.Text).Split([':']);
    edtAdjLotID.Text := Arr[1];
  except

  end;

end;

procedure TXlsFileRename.edtAccoPPIDChange(Sender: TObject);
var
  Arr, Arr2: TArray<string>;
  Index: Integer;
  Str: string;
begin
  try
    Str := Trim(edtAccoPPID.Text);
    if Str = '' then
      Abort;
    if Pos('\', Str) = 0 then
      Abort;
    Index := StrCount('\', Str, 1, 1);
    edtAdjPPID.Text := Copy(Str, Index + 1, Length(Str) - Index);
  except

  end;
end;

procedure TXlsFileRename.edtFocusPPIDChange(Sender: TObject);
var
  Arr: TArray<string>;
begin
  try
    if edtFocusPPID.Text = '' then
      Abort;
    if Pos('.', Trim(edtFocusPPID.Text)) = 0 then
      Abort;
    Arr := Trim(edtFocusPPID.Text).Split(['.']);
    edtFocusAdjustPPID.Text := Arr[0];
  except

  end;

end;

procedure TXlsFileRename.FormCreate(Sender: TObject);
begin
  Self.Caption := 'Xls批量修改' + SubVer_XlsBat;
  ChangeWindowMessageFilter(WM_DROPFILES, MSGFLT_ADD);
  ChangeWindowMessageFilter(WM_COPYDATA, MSGFLT_ADD);
  ChangeWindowMessageFilter(WM_COPYGLOBALDATA, MSGFLT_ADD);
  DragAcceptFiles(Handle, True); //第二个参数为False时，不启用文件拖放
  PedXlsList := TXlsList.Create;
end;

procedure TXlsFileRename.FormDestroy(Sender: TObject);
begin
  PedXlsList.Destroy;
  FreeAndNil(TempXlsList);
end;

procedure TXlsFileRename.N1Click(Sender: TObject);
var
  Dlg: TOpenDialog;
  List: TStrings;
  i: Integer;
begin
  try
    Dlg := TOpenDialog.Create(Self);
    Dlg.Filter := '*.xls|*.xls;*.xlsx|*.xlsx';
    Dlg.Options := [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing];
    if Dlg.Execute then
    begin
      List := TStringList.Create;
      List := Dlg.Files;
      if TempXlsList = nil then
      begin
        TempXlsList := TStringList.Create;
      end
      else
      begin
        TempXlsList.Clear;
      end;
      DataIni;
      if List <> nil then
      begin
        for i := 0 to List.Count - 1 do
        begin
          XlsRead(List[i]);
          TempXlsList.Add(List[i]);
        end;
        XlsAddList;
      end;
    end;
  finally
    Dlg.Free;
  end;

end;

procedure TXlsFileRename.N2Click(Sender: TObject);
var
  I: Integer;
begin
  PedXlsList.Clear;
  lv1.Clear;
end;

procedure TXlsFileRename.PosStr(Str: string; StrFind: string; Pos: Integer; out SplitStr_1: string);
var
  StrTemp: string;
  Count: Integer;
  I: Integer;
begin
  if Length(StrFind) <> 1 then
    Abort;
  if Length(Str) < 2 then
    Abort;
  if Pos = 0 then
    Abort;
  if Pos > Length(Str) then
    Abort;
  Count := 0;
  for I := 1 to Length(Str) do
  begin
    if Str[I] = StrFind then
    begin
      Inc(Count);
      if Count = Pos then
      begin
        StrTemp := Copy(Str, I, Length(Str) - I + 1);
        SplitStr_1 := StrTemp;
        Break;
      end;
    end;

  end;
end;

procedure TXlsFileRename.XlsAddList;
var
  I: Integer;
begin
  cbb1.Clear;
  cbb2.Clear;
  cbb3.Clear;
  cbb4.Clear;
  cbb5.Clear;
  cbb6.Clear;
  cbb1.Text := '请选择ACCOPPID';
  cbb2.Text := '请选择ACCOLotID';
  cbb3.Text := '请选择FocusPPID';
  cbb4.Text := '请选择FocusLotID';
  cbb5.Text := '请选择JUNOPPID';
  cbb6.Text := '请选择JUNOLotID';
  for I := 0 to PedXlsList.Count - 1 do
  begin
    case PedXlsList[I].CompanyIndex of
      1:
        begin
          cbb1.Items.Add(PedXlsList[I].PPID);
          cbb2.Items.Add(PedXlsList[I].LotID);
        end;
      3:
        begin
          cbb3.Items.Add(PedXlsList[I].PPID);
          cbb4.items.Add(PedXlsList[I].LotID);
        end;
      2:
        begin
          cbb5.Items.Add(PedXlsList[I].PPID);
          cbb6.items.Add(PedXlsList[I].LotID);
        end;
    end;
  end;
  cbb1.ItemIndex := 0;
  cbb2.ItemIndex := 0;
  cbb3.ItemIndex := 0;
  cbb4.ItemIndex := 0;
  cbb5.ItemIndex := 0;
  cbb6.ItemIndex := 0;

end;

function TXlsFileRename.XlsDataChange(FilePathList: TXlsList): Boolean;
var
  I, J, Count: Integer;
  APPIDAll, APPID, ALotIDAll, ALotID: string;
  FocusPPID, FocusLotID: string;
  JunoPPID, JunoLotID: string;
  ExcelApp: Variant;
  XlsName, OldNamePart, AccoStr, NewName, NewName_1, NewNameNoExt, XlsDir: string;
  SheetOldName, SheetNewName: string;
  XlsNameLength: Integer; //xlsname length
  ErrFileFilterPos: Integer; //文件名中'_'的位置
  TempLength: Integer;
  FucosFilterPos: Integer;
begin
  Result := False;
  Count := 0;
  if FilePathList.Count = 0 then
    Abort;
  APPIDAll := edtAccoPPID.Text;
  APPID := edtAdjPPID.Text;
  ALotIDAll := edtACCOLotID.Text;
  ALotID := edtAdjLotID.Text;
  FocusPPID := edtFocusPPID.Text;
  FocusLotID := edtFocusLotID.Text;
  JunoPPID := edtJUNOPPID.Text;
  JunoLotID := edtJUNOLotID.Text;
  ExcelApp := CreateOleObject('Excel.Application');
  //ExcelApp.Visible := True;
  for I := 0 to FilePathList.Count - 1 do
  begin
    case FilePathList[I].CompanyIndex of
      1:
        begin
        //acco
        //默认ppid lotid必选
          if (APPIDAll = '') or (ALotIDAll = '') then
            Continue;
          if (APPIDAll = FilePathList[I].PPID) or (ALotIDAll = FilePathList[I].LotID) then
            Continue;
          ExcelApp.WorkBooks.Open(FilePathList[I].FilePath);
          ExcelApp.WorkSheets[AccoXls_0].Activate;
          if ExcelApp.Cells[5, 1].value <> APPIDAll then
          begin
            ExcelApp.Cells[5, 1].value := APPIDAll;
          end;
          if ExcelApp.Cells[9, 1].value <> ALotIDAll then
          begin
            ExcelApp.Cells[9, 1].value := ALotIDAll;
          end;
          //rename
          XlsName := ExtractFileName(FilePathList[I].FilePath);
          XlsDir := ExtractFilePath(FilePathList[I].FilePath);
          PosStr(XlsName, '_', 3, OldNamePart);
          AccoStr := edtAdjPPID.Text;
          NewName := Copy(AccoStr, 1, Length(AccoStr) - 4) + '_' + edtAdjLotID.Text + OldNamePart;

          //文件名检测12—_;12_20181110;12_20181110_cpout
          //PBB_CPN60F_PBB02075.1_25_2020-11-10_5_43_8_20201110062410_waferout.xls
          //PBB_CPN60F_PBB02075.1_25_2020-11-10_5_43_8_20201110062410.xls
         //PBB_CPN60F_PBB02075.1_25_2020-11-10_5_43_8_.xls ==ok!!
          XlsNameLength := Length(NewName);
          if NewName[XlsNameLength - 3] = '.' then
          begin
             //确定后缀一定是.xls
            if NewName[XlsNameLength - 4] <> '_' then
            begin
               //异常文件名需更改
               //去掉文件后缀
                //从右往左检测相邻二个"_"的位置差
              if StrCount('_', NewName, 1, 1) - StrCount('_', NewName, 2, 1) > 3 then
              begin
                //需要再去掉2次长后缀字符串20201110062410_waferout.xls
                NewName_1 := Copy(NewName, 1, StrCount('_', NewName, 2, 1));
              end
              else
              begin
              //需要再去掉1次长后缀字符串20201110062410.xls
                NewName_1 := Copy(NewName, 1, StrCount('_', NewName, 1, 1));
              end;
              NewName := NewName_1 + '.xls';
            end;
          end;

          //XlsDir+NewName;
          ExcelApp.ActiveWorkBook.Saved := False;
          ExcelApp.DisplayAlerts := False;
          ExcelApp.ActiveWorkBook.save;
          ExcelApp.WorkBooks.close;
          RenameFile(FilePathList[I].FilePath, XlsDir + NewName);
          TempXlsList[I] := XlsDir + NewName;
          Inc(Count);
        end;
      2:
      //juno
        begin
          if (JunoPPID = '') or (JunoLotID = '') then
            Break;
          if (JunoPPID = PedXlsList[I].PPID) or (JunoLotID = PedXlsList[I].LotID) then
            Break;
          ExcelApp.WorkBooks.Open(FilePathList[I].FilePath);
          case FilePathList[I].TablesCount of
            2:
              begin
                if ExcelApp.WorkSheets[1].Name <> JunoFocusXLs_0 then
                begin
                 //数据表修改数据
                  ExcelApp.WorkSheets[1].Activate;
                  if ExcelApp.Cells[4, 2].value <> JunoPPID then
                  begin
                    ExcelApp.Cells[4, 2].value := JunoPPID;
                  end;
                  if ExcelApp.Cells[3, 7].value <> JunoLotID then
                  begin
                    ExcelApp.Cells[3, 7].value := JunoLotID;
                  end;
                  SheetOldName := ExcelApp.WorkSheets[1].Name;
                  OldNamePart := '';
                  PosStr(SheetOldName, '-', 1, OldNamePart);
                  SheetNewName := JunoLotID + OldNamePart;
                  ExcelApp.WorkSheets[1].Name := SheetNewName;
                end
                else
                begin
                 //如果第一个表是counter，这种情况基本不太会有
                  ExcelApp.WorkSheets[2].Activate;
                  if ExcelApp.Cells[4, 1].value <> JunoPPID then
                  begin
                    ExcelApp.Cells[4, 1].value := JunoPPID;
                  end;
                  if ExcelApp.Cells[3, 7].value <> JunoLotID then
                  begin
                    ExcelApp.Cells[3, 7].value := JunoLotID;
                  end;
                  SheetOldName := ExcelApp.WorkSheets[2].Name;
                  OldNamePart := '';
                  PosStr(SheetOldName, '-', 1, OldNamePart);
                  SheetNewName := JunoLotID + OldNamePart;
                  ExcelApp.WorkSheets[2].Name := SheetNewName;
                end;
              //修改Counter表的信息
                ExcelApp.WorkSheets[JunoFocusXLs_0].Activate;
                if ExcelApp.Cells[1, 2].value <> JunoLotID then
                begin
                  ExcelApp.Cells[1, 2].value := JunoLotID;
                end;
              //save
                //W8B10667.1-019-Data20201103110013_cpout.xls
                //W8B10667.1-020-Data20201103152211.xls
                //W8B10667.1-020-Data.xls==>ok!
                XlsName := ExtractFileName(FilePathList[I].FilePath);
                XlsDir := ExtractFilePath(FilePathList[I].FilePath);
                PosStr(XlsName, '-', 1, OldNamePart);
                NewName := JunoLotID + OldNamePart;
                ExcelApp.ActiveWorkBook.Saved := False;
                ExcelApp.DisplayAlerts := False;
                ExcelApp.ActiveWorkBook.save;
                ExcelApp.WorkBooks.close;
                NewName := Copy(NewName, 1, StrCount('-', NewName, 1, 1) + 4) + '.xls';
                RenameFile(FilePathList[I].FilePath, XlsDir + NewName);
                TempXlsList[I] := XlsDir + NewName;
                Inc(Count);
              end;
            3:
              begin
                for J := 1 to 3 do
                begin
                  if ExcelApp.WorkSheets[J].Name <> JunoFocusXLs_0 then
                  begin
                    ExcelApp.WorkSheets[J].Activate;
                    if ExcelApp.Cells[4, 2].value <> JunoPPID then
                    begin
                      ExcelApp.Cells[4, 2].value := JunoPPID;
                    end;
                    if ExcelApp.Cells[3, 7].value <> JunoLotID then
                    begin
                      ExcelApp.Cells[3, 7].value := JunoLotID;
                    end;
                    SheetOldName := ExcelApp.WorkSheets[J].Name;
                    OldNamePart := '';
                    PosStr(SheetOldName, '-', 1, OldNamePart);
                    SheetNewName := JunoLotID + OldNamePart;
                    ExcelApp.WorkSheets[J].Name := SheetNewName;
                  end;
                end;
              //修改Counter表的信息
                ExcelApp.WorkSheets[JunoFocusXLs_0].Activate;
                if ExcelApp.Cells[1, 2].value <> JunoLotID then
                begin
                  ExcelApp.Cells[1, 2].value := JunoLotID;
                end;
              //save
                XlsName := ExtractFileName(FilePathList[I].FilePath);
                XlsDir := ExtractFilePath(FilePathList[I].FilePath);
                PosStr(XlsName, '-', 1, OldNamePart);
                NewName := JunoLotID + OldNamePart;
                ExcelApp.ActiveWorkBook.Saved := False;
                ExcelApp.DisplayAlerts := False;
                ExcelApp.ActiveWorkBook.save;
                ExcelApp.WorkBooks.close;
                NewName := Copy(NewName, 1, StrCount('-', NewName, 1, 1) + 4) + '.xls';
                RenameFile(FilePathList[I].FilePath, XlsDir + NewName);
                TempXlsList[I] := XlsDir + NewName;
                Inc(Count);
              end;

          end;
        end;
      3:
        begin
        //focus
          if (FocusPPID = '') or (FocusLotID = '') then
            Break;
          if (FocusPPID = PedXlsList[I].PPID) or (FocusLotID = PedXlsList[I].LotID) then
            Break;
          ExcelApp.WorkBooks.Open(FilePathList[I].FilePath);
          case FilePathList[I].TablesCount of
            2:
              begin
                if ExcelApp.WorkSheets[1].Name <> JunoFocusXLs_0 then
                begin
                 //数据表修改数据
                  ExcelApp.WorkSheets[1].Activate;
                  if ExcelApp.Cells[4, 2].value <> FocusPPID then
                  begin
                    ExcelApp.Cells[4, 2].value := FocusPPID;
                  end;
                  if ExcelApp.Cells[3, 7].value <> FocusLotID then
                  begin
                    ExcelApp.Cells[3, 7].value := FocusLotID;
                  end;
                  SheetOldName := ExcelApp.WorkSheets[1].Name;
                  OldNamePart := '';
                  PosStr(SheetOldName, '-', 1, OldNamePart);
                  SheetNewName := FocusLotID + OldNamePart;
                  ExcelApp.WorkSheets[1].Name := SheetNewName;
                end
                else
                begin
                 //如果第一个表是counter，这种情况基本不太会有
                  ExcelApp.WorkSheets[2].Activate;
                  if ExcelApp.Cells[4, 1].value <> FocusPPID then
                  begin
                    ExcelApp.Cells[4, 1].value := FocusPPID;
                  end;
                  if ExcelApp.Cells[3, 7].value <> FocusLotID then
                  begin
                    ExcelApp.Cells[3, 7].value := FocusLotID;
                  end;
                  SheetOldName := ExcelApp.WorkSheets[2].Name;
                  OldNamePart := '';
                  PosStr(SheetOldName, '-', 1, OldNamePart);
                  SheetNewName := FocusLotID + OldNamePart;
                  ExcelApp.WorkSheets[2].Name := SheetNewName;
                end;
              //修改Counter表的信息
                ExcelApp.WorkSheets[JunoFocusXLs_0].Activate;
                if ExcelApp.Cells[1, 2].value <> FocusLotID then
                begin
                  ExcelApp.Cells[1, 2].value := FocusLotID;
                end;
              //save
                XlsName := ExtractFileName(FilePathList[I].FilePath);
                XlsDir := ExtractFilePath(FilePathList[I].FilePath);
                PosStr(XlsName, '_', 1, OldNamePart);
                NewName := FocusLotID + OldNamePart;
                ExcelApp.ActiveWorkBook.Saved := False;
                ExcelApp.DisplayAlerts := False;
                ExcelApp.ActiveWorkBook.save;
                ExcelApp.WorkBooks.close;
                //W4B05504.1_PartType_01_2020.11.13_19.25.17_2020.11.13_19.29.31_FT20201113192610.xls
                if Copy(NewName, Length(NewName) - 5, 2) <> 'FT' then
                begin
                  FucosFilterPos := StrCount('_', NewName, 1, 1);
                  if Copy(NewName, FucosFilterPos + 1, 2) = 'FT' then
                  begin
                    NewName := Copy(NewName, 1, FucosFilterPos + 2) + '.xls';
                  end
                  else
                  begin
                    FucosFilterPos := StrCount('_', NewName, 2, 1);
                    if Copy(NewName, FucosFilterPos + 1, 2) = 'FT' then
                    begin
                      NewName := Copy(NewName, 1, FucosFilterPos + 2) + '.xls';
                    end;
                  end;
                end;

                RenameFile(FilePathList[I].FilePath, XlsDir + NewName);
                TempXlsList[I] := XlsDir + NewName;
                Inc(Count);
              end;
            3:
              begin
                for J := 1 to 3 do
                begin
                  if ExcelApp.WorkSheets[J].Name <> JunoFocusXLs_0 then
                  begin
                    ExcelApp.WorkSheets[J].Activate;
                    if ExcelApp.Cells[4, 2].value <> FocusPPID then
                    begin
                      ExcelApp.Cells[4, 2].value := FocusPPID;
                    end;
                    if ExcelApp.Cells[3, 7].value <> FocusLotID then
                    begin
                      ExcelApp.Cells[3, 7].value := FocusLotID;
                    end;
                    SheetOldName := ExcelApp.WorkSheets[J].Name;
                    OldNamePart := '';
                    PosStr(SheetOldName, '-', 1, OldNamePart);
                    SheetNewName := FocusLotID + OldNamePart;
                    ExcelApp.WorkSheets[J].Name := SheetNewName;
                  end;
                end;
              //修改Counter表的信息
                ExcelApp.WorkSheets[JunoFocusXLs_0].Activate;
                if ExcelApp.Cells[1, 2].value <> FocusLotID then
                begin
                  ExcelApp.Cells[1, 2].value := FocusLotID;
                end;
              //save
                XlsName := ExtractFileName(FilePathList[I].FilePath);
                XlsDir := ExtractFilePath(FilePathList[I].FilePath);
                PosStr(XlsName, '_', 1, OldNamePart);
                NewName := FocusPPID + OldNamePart;
                ExcelApp.ActiveWorkBook.Saved := False;
                ExcelApp.DisplayAlerts := False;
                ExcelApp.ActiveWorkBook.save;
                ExcelApp.WorkBooks.close;
                if Copy(NewName, Length(NewName) - 5, 2) <> 'FT' then
                begin
                  FucosFilterPos := StrCount('_', NewName, 1, 1);
                  if Copy(NewName, FucosFilterPos + 1, 2) = 'FT' then
                  begin
                    NewName := Copy(NewName, 1, FucosFilterPos + 2) + '.xls';
                  end
                  else
                  begin
                    FucosFilterPos := StrCount('_', NewName, 2, 1);
                    if Copy(NewName, FucosFilterPos + 1, 2) = 'FT' then
                    begin
                      NewName := Copy(NewName, 1, FucosFilterPos + 2) + '.xls';
                    end;
                  end;
                end;
                RenameFile(FilePathList[I].FilePath, XlsDir + NewName);
                TempXlsList[I] := XlsDir + NewName;
                Inc(Count);
              end;
          end;
        end;
    end;
  end;
  ExcelApp.Quit;
  ExcelApp := Unassigned;
  ShowMessage('总共修改了' + IntToStr(Count) + '个文件！');
end;

function TXlsFileRename.ReXlsName(List: TXlsList; out Count: Integer): Boolean;
var
  I: Integer;
  Path, XlsDir, XlsName: string;
  NewName: string;
  XlsArr: TArray<string>;
  OldNamePart: string;
  AccoStr: string;
begin
  Count := 0;
  Result := True;
  for I := 0 to List.Count - 1 do
  begin
    try
      //Rename();
      Path := List[I].FilePath;
      XlsDir := ExtractFilePath(Path);
      XlsName := ExtractFileName(Path);
      case List[I].CompanyIndex of
        2: //juno
          begin
            if edtJUNOLotID.Text <> List[I].LotID then
            begin
              PosStr(XlsName, '-', 1, OldNamePart);
              NewName := edtJUNOLotID.Text + OldNamePart;
              if RenameFile(Path, XlsDir + NewName) then
              begin
                Inc(Count);
                TempXlsList[I] := XlsDir + NewName;
              end;
            end;
          end;
        3: //focus
          begin
            if edtFocusLotID.Text <> List[I].LotID then
            begin
              PosStr(XlsName, '_', 1, OldNamePart);
              NewName := edtFocusLotID.Text + OldNamePart;
              if RenameFile(Path, XlsDir + NewName) then
              begin
                Inc(Count);
                TempXlsList[I] := XlsDir + NewName;
              end;
            end;
          end;
        1: //acco
          begin
            if (edtAccoPPID.Text <> List[I].PPID) or (edtACCOLotID.Text <> List[I].LotID) then
            begin
              PosStr(XlsName, '_', 3, OldNamePart);
              AccoStr := edtAdjPPID.Text;

              NewName := Copy(AccoStr, 1, Length(AccoStr) - 4) + '_' + edtAdjLotID.Text + OldNamePart;
              if RenameFile(Path, XlsDir + NewName) then
              begin
                Inc(Count);
                TempXlsList[I] := XlsDir + NewName;
              end;
            end;

          end;

      end;

    except
      Result := False;
    end;
  end;
  ShowMessage('一共修改了' + IntToStr(Count) + '个文件！');

end;

function TXlsFileRename.StrCount(SubStr, Str: string; IndexPos: Integer; Direction: Integer): Integer;
var
  i, j, Count, RightPos: Integer;
  List: TStrings;
begin
  //Direction=0 从左往右计数。=1从右往左计数
  Result := 0;
  Count := 0;
  RightPos := 0;
  List := TStringList.Create;
  for i := 1 to Length(Str) do
  begin
    if Str[i] = SubStr then
    begin
      Inc(Count);
      List.Add(IntToStr(i));
    end;
    case Direction of
      0:
        begin
          if Count = IndexPos then
          begin
            Result := i;
            Break;
          end;
        end;
      1:
        begin

        end;
    end;
  end;
  if (Direction = 1) and (IndexPos <= Count) then
  begin
    Result := StrToInt(List[Count - IndexPos]);
  end;
end;

function TXlsFileRename.StrCount(SubStr, Str: string): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(Str) do
  begin
    if Str[i] = SubStr then
    begin
      Inc(Result);
    end;
  end;
end;

procedure TXlsFileRename.TablesAdj(out Table: TStrings; out IsAcco: Boolean);
var
  j, k: Integer;
  StrTemp, StrTempNew: string;
begin
  IsAcco := True;
  for j := 0 to Table.Count - 1 do
  begin
    StrTemp := Table[j];
    StrTempNew := '';

    for k := 1 to Length(StrTemp) do
    begin
      if (StrTemp[k] in ['0'..'9']) or (StrTemp[k] in ['a'..'z']) or (StrTemp[k] in ['A'..'Z']) or (StrTemp[k] in ['_', '-', '.', '#', ' ', '$']) then
      begin
        StrTempNew := StrTempNew + StrTemp[k];
      end;
    end;
    Table[j] := StrTempNew;
    if StrTempNew = XlsDiffTableName then
    begin
      IsAcco := False;
    end;

  end;
end;

function TXlsFileRename.XlsFileRead(FileList: TStrings): Boolean;
var
  I, J, K: Integer;
  XlsItem: pTXls;
  QryTableName: string;
  XlsTables: TStrings; //tables list
begin
  Result := False;
  if XlsTables = nil then
  begin
    XlsTables := TStringList.Create;
  end
  else
  begin
    XlsTables.Clear;
  end;
  for I := 0 to FileList.Count - 1 do
  begin
    if PedXlsList.Add(XlsItem) > 0 then
    begin
      XlsItem.FilePath := FileList[I];
      XlsItem.FileName := ExtractFileName(FileList[I]);

      try
        Conn1 := TFDConnection.Create(Self);
        Conn1.Params.DriverID := 'ODBC';
        Conn1.Params.Values['DataSource'] := 'Excel Files';
        Conn1.LoginPrompt := False;
        Conn1.Params.Add('DataBase=' + FileList[I]);
        Conn1.Connected := True;
        Conn1.GetTableNames('', '', '', XlsTables, [osMy, osSystem, osOther], [tkTable], False);
        TablesAdj(XlsTables, XlsItem.IsAccoType);
        for K := 0 to XlsTables.Count - 1 do
        begin
          XlsItem.Tables.Add(XlsTables[K]);
          Inc(XlsItem.TablesCount);
        end;
        with lv1.Items.Add do
        begin
          Caption := XlsItem.FileName;
          Qry1 := TFDQuery.Create(Self);
          Qry1.Connection := Conn1;
          if (not XlsItem.IsAccoType) and (XlsItem.TablesCount <= 3) then
          begin
            for J := 0 to XlsItem.TablesCount - 1 do
            begin
              if XlsItem.Tables[J] <> XlsDiffTableName then
              begin
                QryTableName := XlsItem.Tables[J];
                with Qry1 do
                begin
              //ppid
                  Close;
                  SQL.Clear;
                  SQL.Text := 'select * from [' + QryTableName + 'B3:B4]';
                  Open;
                  if RecordCount > 0 then
                  begin
                    XlsItem.PPID := Fields[0].Value;
                  end;
                //lotid
                  Close;
                  SQL.Clear;
                  SQL.Text := 'select * from [' + QryTableName + 'G2:G3]';
                  Open;
                  if RecordCount > 0 then
                  begin
                    XlsItem.LotID := Fields[0].Value;
                  end;
                //WaferID
                  Close;
                  SQL.Clear;
                  SQL.Text := 'select * from [' + QryTableName + 'G3:G4]';
                  Open;
                  if RecordCount > 0 then
                  begin
                    XlsItem.ID := Fields[0].Value;
                  end;
                //company
                  if Pos('.xml', XlsItem.PPID) > 0 then
                  begin
                    XlsItem.CompanyIndex := 3;
                  end
                  else
                  begin
                    XlsItem.CompanyIndex := 2;
                  end;
                  SubItems.Add(XlsItem.PPID);
                  SubItems.Add(XlsItem.LotID);
                  SubItems.Add(XlsItem.ID);
                  //SubItems.Add('NotAcco');
                  case XlsItem.CompanyIndex of
                    2:
                      begin
                        SubItems.Add('JUNO');
                      end;
                    3:
                      begin
                        SubItems.Add('Focus');
                      end;

                  end;
                end;
                Break;
              end;
            end;
          end
          else
          begin
            //acco xls file
            if XlsItem.IsAccoType then
            begin
              XlsItem.CompanyIndex := 1;
              with Qry1 do
              begin
              //ppid
                Close;
                SQL.Clear;
                SQL.Text := 'Select * from [' + XlsDiffTablesNameAcco + 'A4:A5]';
                Open();
                if RecordCount > 0 then
                begin
                  XlsItem.PPID := Fields[0].Value;
                end;
              //Lotid
                Close;
                SQL.Clear;
                SQL.Text := 'Select * from [' + XlsDiffTablesNameAcco + 'A8:A9]';
                Open();
                if RecordCount > 0 then
                begin
                  XlsItem.LotID := Fields[0].Value;
                end;
              //waferid
                Close;
                SQL.Clear;
                SQL.Text := 'Select * from [' + XlsDiffTablesNameAcco + 'A7:A8]';
                Open();
                if RecordCount > 0 then
                begin
                  XlsItem.ID := Fields[0].Value;
                end;
                SubItems.Add(XlsItem.PPID);
                SubItems.Add(XlsItem.LotID);
                SubItems.Add(XlsItem.ID);
                SubItems.Add('Acco');
              end;
            end;
          end;

        end;

        Conn1.Close;
      finally
        Conn1.Free;
        Qry1.Free;

      end;
    end;

  end;
  cbb1.Clear;
  cbb2.Clear;
  cbb3.Clear;
  cbb4.Clear;
  cbb5.Clear;
  cbb6.Clear;
  cbb1.Text := '请选择ACCOPPID';
  cbb2.Text := '请选择ACCOLotID';
  cbb3.Text := '请选择FocusPPID';
  cbb4.Text := '请选择FocusLotID';
  cbb5.Text := '请选择JUNOPPID';
  cbb6.Text := '请选择JUNOLotID';
  for I := 0 to PedXlsList.Count - 1 do
  begin
    case PedXlsList[I].CompanyIndex of
      1:
        begin
          cbb1.Items.Add(PedXlsList[I].PPID);
          cbb2.Items.Add(PedXlsList[I].LotID);
        end;
      3:
        begin
          cbb3.Items.Add(PedXlsList[I].PPID);
          cbb4.items.Add(PedXlsList[I].LotID);
        end;
      2:
        begin
          cbb5.Items.Add(PedXlsList[I].PPID);
          cbb6.items.Add(PedXlsList[I].LotID);
        end;
    end;
  end;
end;

function TXlsFileRename.XlsRead(FilePath: string): Boolean;
var
  I, J, K: Integer;
  XlsItem: pTXls;
  QryTableName: string;
  XlsTables: TStrings; //tables list
begin
  Result := False;
  DataOutWarn := False;
  XlsTables := TStringList.Create;

  if PedXlsList.Add(XlsItem) > 0 then
  begin
    XlsItem.FilePath := FilePath;
    XlsItem.FileName := ExtractFileName(FilePath);
    if Pos('out', XlsItem.FileName) > 0 then
    begin
      XlsItem.DataOut := True;
      if not DataOutWarn then
      begin
        DataOutWarn := True;
      end;
    end;
    if Pos('EAS', XlsItem.FileName) > 0 then
    begin
      XlsItem.IsEas := True;
    end;

    try
      Conn1 := TFDConnection.Create(Self);
      Conn1.Params.DriverID := 'ODBC';
      Conn1.Params.Values['DataSource'] := 'Excel Files';
      Conn1.LoginPrompt := False;
      Conn1.Params.Add('DataBase=' + FilePath);
      Conn1.Connected := True;
      Conn1.GetTableNames('', '', '', XlsTables, [osMy, osSystem, osOther], [tkTable], False);
      TablesAdj(XlsTables, XlsItem.IsAccoType);
      for K := 0 to XlsTables.Count - 1 do
      begin
        XlsItem.Tables.Add(XlsTables[K]);
        Inc(XlsItem.TablesCount);
      end;
//      XlsItem.Tables := XlsTables;
//      XlsItem.TablesCount := XlsTables.Count;
      with lv1.Items.Add do
      begin
        Caption := XlsItem.FileName;
        Qry1 := TFDQuery.Create(Self);
        Qry1.Connection := Conn1;
        if (not XlsItem.IsAccoType) and (XlsItem.TablesCount <= 3) then
        begin
          for J := 0 to XlsItem.TablesCount - 1 do
          begin
            if XlsItem.Tables[J] <> XlsDiffTableName then
            begin
              QryTableName := XlsItem.Tables[J];
              with Qry1 do
              begin
              //ppid
                Close;
                SQL.Clear;
                SQL.Text := 'select * from [' + QryTableName + 'B3:B4]';
                Open;
                if RecordCount > 0 then
                begin
                  XlsItem.PPID := Fields[0].Value;
                end;
                //lotid
                Close;
                SQL.Clear;
                SQL.Text := 'select * from [' + QryTableName + 'G2:G3]';
                Open;
                if RecordCount > 0 then
                begin
                  XlsItem.LotID := Fields[0].Value;
                end;
                //WaferID
                Close;
                SQL.Clear;
                SQL.Text := 'select * from [' + QryTableName + 'G3:G4]';
                Open;
                if RecordCount > 0 then
                begin
                  XlsItem.ID := Fields[0].Value;
                end;
                //company
                if Pos('.xml', XlsItem.PPID) > 0 then
                begin
                  XlsItem.CompanyIndex := 3;
                end
                else
                begin
                  XlsItem.CompanyIndex := 2;
                end;
                SubItems.Add(XlsItem.PPID);
                SubItems.Add(XlsItem.LotID);
                SubItems.Add(XlsItem.ID);
                  //SubItems.Add('NotAcco');
                case XlsItem.CompanyIndex of
                  2:
                    begin
                      SubItems.Add('JUNO');
                    end;
                  3:
                    begin
                      SubItems.Add('Focus');
                    end;

                end;
                if XlsItem.DataOut then
                begin
                  SubItems.Add('Out');
                end
                else
                begin
                  SubItems.Add('Normal');
                end;
              end;
              Break;
            end;
          end;
        end
        else
        begin
            //acco xls file
          if XlsItem.IsAccoType then
          begin
            XlsItem.CompanyIndex := 1;
            with Qry1 do
            begin
              //ppid
              Close;
              SQL.Clear;
              SQL.Text := 'Select * from [' + XlsDiffTablesNameAcco + 'A4:A5]';
              Open();
              if RecordCount > 0 then
              begin
                XlsItem.PPID := Fields[0].Value;
              end;
              //Lotid
              Close;
              SQL.Clear;
              SQL.Text := 'Select * from [' + XlsDiffTablesNameAcco + 'A8:A9]';
              Open();
              if RecordCount > 0 then
              begin
                XlsItem.LotID := Fields[0].Value;
              end;
              //waferid
              Close;
              SQL.Clear;
              SQL.Text := 'Select * from [' + XlsDiffTablesNameAcco + 'A7:A8]';
              Open();
              if RecordCount > 0 then
              begin
                XlsItem.ID := Fields[0].Value;
              end;
              SubItems.Add(XlsItem.PPID);
              SubItems.Add(XlsItem.LotID);
              SubItems.Add(XlsItem.ID);
              SubItems.Add('Acco');
              if XlsItem.DataOut then
              begin
                SubItems.Add('Out');
              end
              else
              begin
                SubItems.Add('Normal');
              end;
            end;
          end;
        end;

      end;

      Conn1.Close;
    finally
      Conn1.Connected := False;
      Conn1.Close;
      Conn1.Free;
      Qry1.Free;
    end;
  end;
  XlsTables.Clear;

end;

{ TXlsList }

function TXlsList.Add(out Item: pTXls): Integer;
var
  Index: Integer;
begin
  Result := -1;
  Index := FCount;
  if (Index >= 0) and (Index < FMaxCount) then
  begin
    Item := @FList[Index];
    Inc(FCount);
    Result := FCount;
  end;
end;

procedure TXlsList.Clear;
var
  Index: Integer;
begin
  for Index := 0 to FMaxCount - 1 do
  begin
    FList[Index].FilePath := '';
    FList[Index].FileName := '';
    FList[Index].Tables.Clear;
    FList[Index].TablesCount := 0;
    FList[Index].PPID := '';
    FList[Index].LotID := '';
    FList[Index].ID := '';
    FList[Index].CompanyIndex := 0;
    FList[Index].DataOut := False;
    FList[Index].IsEas := False;
  end;
  FCount := 0;

end;

constructor TXlsList.Create;
begin
  inherited;
  FCount := 0;
  FMaxCount := 100;
  SetLength(FList, FMaxCount);
  InitialProcess();
end;

destructor TXlsList.Destroy;
var
  Index: Integer;
begin
  for Index := 0 to FMaxCount - 1 do
  begin
    FList[Index].Tables.Clear;
  end;
  SetLength(FList, 0);
  inherited;
end;

procedure TXlsList.Finalize;
var
  Index: Integer;
begin
  for Index := 0 to FMaxCount - 1 do
  begin
    FList[Index].FilePath := '';
    FList[Index].FileName := '';
    FList[Index].Tables.Free;
    FList[Index].TablesCount := 0;
    FList[Index].PPID := '';
    FList[Index].LotID := '';
    FList[Index].ID := '';
    FList[Index].CompanyIndex := 0;
    FList[Index].DataOut := False;
    FList[Index].IsEas := False;
  end;

end;

function TXlsList.Get(Index: Integer): pTXls;
begin
  if (Index >= 0) and (Index < FMaxCount) then
  begin
    Result := @FList[Index];
  end
  else
  begin
    Result := nil;
  end;
end;

procedure TXlsList.InitialProcess;
var
  Index: Integer;
begin
  for Index := 0 to FMaxCount - 1 do
  begin
    FList[Index].FilePath := '';
    FList[Index].FileName := '';
    FList[Index].Tables := TStringList.Create;
    FList[Index].TablesCount := 0;
    FList[Index].PPID := '';
    FList[Index].LotID := '';
    FList[Index].ID := '';
    FList[Index].IsAccoType := False;
    FList[Index].CompanyIndex := 0;
    FList[Index].DataOut := False;
    FList[Index].IsEas := False;
  end;
end;

procedure TXlsList.SetMaxCount(Value: Integer);
begin
  if FMaxCount <> Value then
  begin
    Finalize;
    FMaxCount := Value;
    SetLength(FList, FMaxCount);
    InitialProcess;
  end;
end;

end.

