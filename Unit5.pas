unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Menus, RegularExpressions, Vcl.ExtCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCDef, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.ODBC;

type
  TForm5 = class(TForm)
    btn1: TButton;
    mmo3: TMemo;
    scrlbx1: TScrollBox;
    btn3: TButton;
    trckbr1: TTrackBar;
    imgScreen: TImage;
    edt1: TEdit;
    btn6: TButton;
    btn7: TButton;
    Conn1: TFDConnection;
    Qry1: TFDQuery;
    fdphysdbcdrvrlnk1: TFDPhysODBCDriverLink;
    lbl1: TLabel;
    lbl2: TLabel;
    btn2: TButton;
    btn4: TButton;
    btnClear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure trckbr1Change(Sender: TObject);
    function DrawFunMain(Scale: Integer; Mode: Integer): Boolean;
    function GetMaxInArray(A: array of Integer): Integer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn1Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
    procedure MouseMove1(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  public
    { Public declarations }
    function ReadXls(Path: string): Boolean;
    function PosRepeatCheck: Boolean;
  end;

var
  Form5: TForm5;
  TestPosX, TestPosY: array of Integer;
  IsDraw: Boolean;
  img2: TImage;
  MaxRow, MaxCol, Scale: Integer;
  TelMaxRow, TelMaxCol: Integer;
  XInputOk, YInputOk: Boolean;

implementation

uses
  Unit6, Global;

{$R *.dfm}

procedure TForm5.btn1Click(Sender: TObject);
begin
  Form6.Position := poScreenCenter;
  if not Form6.Visible then
  begin
    Form6.Show;
  end;
end;

procedure TForm5.btn2Click(Sender: TObject);

//  function TrimBlank(Str: string): string;
//  var
//    Len: Integer;
//    i: Integer;
//    Str1: string;
//  begin
//    Str := Trim(Str);
//    Len := Length(Str);
//    Str1 := '';
//    if Length(Str) <> 0 then
//    begin
//      for i := 0 to Len - 1 do    //注意字符串第一个str[0]不是字符串
//      begin
//        if (Str[i + 1] in ['0'..'9']) then
//        begin
//          Str1 := Str1 + Str[i + 1];
//        end
//        else
//        begin
//          Str1 := Str1 + '#';
//        end;
//
//      end;
//
//    end;
//    Result := Str1;
//  end;
//
//var
//  PosStr: TStrings;
//  TestCount: Integer;
//  i: Integer;
//  Arr: TArray<string>;
//  Str: string;
//begin
//  if XInputOk and YInputOk then
//  begin
//    btn3.Enabled := True;
//  end
//  else
//  begin
//    mmo3.Lines.Add('请先加载XY坐标文件！');
//  end;
begin
//  if PosRepeatCheck(trckbr1.Position, 1) then
//  begin
//    if trckbr1.Enabled = False then
//    begin
//      trckbr1.Enabled := True;
//    end;
//  end;
  if PosRepeatCheck then
  begin
    mmo3.Lines.Add('未发现重复坐标..')
  end;
end;

procedure TForm5.btn3Click(Sender: TObject);
begin
  if not IsCanDraw then
    Exit;

  if DrawFunMain(trckbr1.Position, 0) then
  begin
    if trckbr1.Enabled = False then
    begin
      trckbr1.Enabled := True;
    end;
    btn1.Enabled := True;

  end;

end;

procedure TForm5.btn4Click(Sender: TObject);
var
  I: Integer;
  S, StrTemp: string;
  J: integer;
  BlankStBool, BlankEdBool: Boolean;
  StIndex, EdIndex: Integer;
//var
//  dlgopen2: TOpenDialog;
//  Path: string;
//  Txt: TextFile;
//  Str: string;
//  StrList: TStringList;
//  MaxCount: Integer;
//  i: Integer;
begin
  if MessageDlg('请确认已经放入xy坐标数据列', TMsgDlgType.mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
    with mmo3 do
    begin
      BlankStBool := False;
      BlankEdBool := False;
      StrTemp := '';
      for I := 0 to (Lines.Count - 1) do
      begin
        S := Lines[I];
        S := Trim(S);
        StIndex := 0;
        EdIndex := 0;
        for J := 0 to Length(S) - 1 do
        begin
          if not BlankStBool then
          begin
            if S[J] = ' ' then
            begin
              BlankStBool := True;
              StIndex := J;
            end;
          end;
          if BlankStBool then
          begin
            if S[J] <> ' ' then
            begin
              BlankEdBool := True;
              EdIndex := J;
              //StrTemp := StrTemp + S[J];
            end;
          end;
          if (not BlankStBool) or (BlankEdBool) then
          begin
            StrTemp := StrTemp + S[J];
          end;

        end;
        Lines[i]:=StrTemp;

      end;
    end;

  end;
//  dlgopen2 := TOpenDialog.Create(nil);
//  try
//    dlgopen2.Filter := '坐标文件(*.txt)|*.txt';
//    dlgopen2.DefaultExt := '*.txt';
//    if dlgopen2.Execute then
//    begin
//      SetLength(TestPosX, 0);
//      Path := Trim(dlgopen2.FileName);
//      StrList := TStringList.Create;
//      AssignFile(Txt, Path);
//      Reset(Txt);
//      while not Eof(Txt) do
//      begin
//        Readln(Txt, Str);
//        StrList.Add(Str);
//      end;
//      MaxCount := StrList.Count;
//      mmo3.Lines.Add('x数目= ' + IntToStr(MaxCount));
//      //SetLength(PosTemp, MaxCount);
//      SetLength(TestPosX, MaxCount);
//      for i := 0 to MaxCount - 1 do
//      begin
//        if StrList[i] = '' then
//          Continue;
//        TestPosX[i] := StrToInt(StrList[i]);
//      end;
//      CloseFile(Txt);
//      mmo3.Lines.Add('x最大数= ' + IntToStr(GetMaxInArray(TestPosX)));
//      XInputOk := True;
//
//    end;
//  finally
//    FreeAndNil(dlgopen2);
//
//  end;

end;

procedure TForm5.btn5Click(Sender: TObject);
var
  dlgopen2: TOpenDialog;
  Path: string;
  Txt: TextFile;
  Str: string;
  StrList: TStringList;
  MaxCount: Integer;
  i: Integer;
begin

  dlgopen2 := TOpenDialog.Create(nil);
  try
    dlgopen2.Filter := '坐标文件(*.txt)|*.txt';
    dlgopen2.DefaultExt := '*.txt';
    if dlgopen2.Execute then
    begin
      SetLength(TestPosY, 0);
      Path := Trim(dlgopen2.FileName);
      StrList := TStringList.Create;
      AssignFile(Txt, Path);
      Reset(Txt);
      while not Eof(Txt) do
      begin
        Readln(Txt, Str);
        StrList.Add(Str);
      end;
      MaxCount := StrList.Count;
      mmo3.Lines.Add('y最大数目= ' + IntToStr(MaxCount));
      //SetLength(PosTemp, MaxCount);
      SetLength(TestPosY, MaxCount);
      for i := 0 to MaxCount - 1 do
      begin
        if StrList[i] = '' then
          Continue;

        TestPosY[i] := StrToInt(StrList[i]);
      end;
      CloseFile(Txt);
      mmo3.Lines.Add('y最大数= ' + IntToStr(GetMaxInArray(TestPosY)));
      YInputOk := True;
    end;
  finally
    FreeAndNil(dlgopen2);

  end;
end;

procedure TForm5.btn6Click(Sender: TObject);
begin
  mmo3.Lines.Clear;
end;

procedure TForm5.btn7Click(Sender: TObject);
var
  dlg: TOpenDialog;
  Path, Str: string;
begin
  if MessageDlg('请确保文件未被打开占用..', TMsgDlgType.mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
    dlg := TOpenDialog.Create(Self);
    mmo3.Lines.Clear;
    try
      dlg.Filter := '测试文件(*.xls;*.xlsx)|*.xls;*.xlsx';
    //dlg.DefaultExt := '*.xls';
    //dlg.InitialDir:='c:\';
      if dlg.Execute then
      begin
        Path := dlg.FileName;
        if Copy(Path, Length(Path) - 2, 3) = 'xls' then
        begin
          IsXlsx := False;     //xlsx最大行超过65536了
        end
        else
        begin
          IsXlsx := True;
        end;

        Self.Caption := '坐标检测[' + Path + ']';
        if ReadXls(Path) then
        begin
          mmo3.Lines.Add('read xls success!');
          IsCanDraw := True;
          IsTelDataClear := True;
          Form6.btn2.Enabled := False;
          Form6.edt1.Text := '';
          Form6.edt2.Text := '';
          Form6.edt3.Text := '';
          TelPosArrNew := nil;
          btn3.Enabled := True;
          btn2.Enabled := True;
        end;
      end;
    except
      ShowMessage('异常...');
    end;
    FreeAndNil(dlg);
  end;

end;

procedure TForm5.btnClearClick(Sender: TObject);
begin
  mmo3.Lines.Clear;
end;

function TForm5.DrawFunMain(Scale: Integer; Mode: Integer): Boolean;
var
  i, j: Integer;
  TempXMax, TempYMax: Integer;
  PosColor: array of array of Integer;
begin
  if Mode = 0 then
  begin
    if img2 = nil then
    begin
      img2 := TImage.Create(scrlbx1);
      img2.Parent := scrlbx1;
      img2.Top := 0;
      img2.Left := 0;
      img2.OnMouseMove := MouseMove1;
    end
    else if img2 <> nil then
    begin
      img2.Free;
      img2 := TImage.Create(scrlbx1);
      img2.Parent := scrlbx1;
      img2.Top := 0;
      img2.Left := 0;
      img2.OnMouseMove := MouseMove1;
    end;
    img2.Width := GetMaxInArray(TestPosX) * Scale;
    img2.height := GetMaxInArray(TestPosY) * Scale;

    with img2 do
    begin
      Canvas.Brush.Color := RGB(58, 65, 68);
      Canvas.Pen.Color := clBlack;
      Canvas.Rectangle(Rect(0, 0, Width, Height));
      Canvas.Brush.Color := RGB(255, 255, 255);

      for i := 1 to (Height div Scale) - 1 do
      begin
        Canvas.MoveTo(0, i * Scale);
        Canvas.LineTo(Width, i * Scale);
        Canvas.MoveTo(0, i * Scale - 1);
        Canvas.LineTo(Width, i * Scale - 1);
      end;
      for i := 1 to (Width div Scale) - 1 do
      begin
        Canvas.MoveTo(i * Scale, 0);
        Canvas.LineTo(i * Scale, Height);
        Canvas.MoveTo(i * Scale - 1, 0);
        Canvas.LineTo(i * Scale - 1, Height);
      end;
      //Canvas.Brush.Color := RGB(0, 255, 0);
      //此处使用累计颜色让重复的点颜色标记

      TempXMax := GetMaxInArray(TestPosX);
      TempYMax := GetMaxInArray(TestPosY);
      SetLength(PosColor, 0, 0);
      SetLength(PosColor, TempXMax, TempYMax);
      for i := 0 to High(TestPosX) - 1 do
      begin
        PosColor[TestPosX[i] - 1, TestPosY[i] - 1] := PosColor[TestPosX[i] - 1, TestPosY[i] - 1] + 1;
      end;
      mmo3.Lines.Add('本次绘制开始...');
      for i := 0 to High(TestPosX) - 1 do
      begin
        Canvas.Brush.Color := RGB(0, PosColor[TestPosX[i] - 1, TestPosY[i] - 1], 0);
        if PosColor[TestPosX[i] - 1, TestPosY[i] - 1] > 1 then
        begin
          mmo3.Lines.Add('发现重复点=' + IntToStr(TestPosX[i]) + '/' + IntToStr(TestPosY[i]));
          Canvas.Brush.Color := RGB(0, 0, 255);
        end
        else
        begin
          Canvas.Brush.Color := RGB(0, 255, 0);
        end;
        Canvas.Rectangle(Rect((TestPosX[i] - 1) * Scale + 2, (TestPosY[i] - 1) * Scale + 2, TestPosX[i] * Scale - 2, TestPosY[i] * Scale - 2));
      end;
      SetLength(PosColor, 0, 0);
    end;
    IsDraw := True;
    Result := True;
  end;
  if Mode = 1 then
  begin
    if IsDraw and (img2 <> nil) then
    begin
      with img2 do
      begin
        Canvas.Brush.Color := RGB(255, 0, 0);
        for j := 0 to TelMaxRow - 1 do
        begin
          for i := 0 to TelMaxCol - 1 do
          begin
            if TelPosArrNew[i][j] = TEL_Test_Bin then
            begin
              Canvas.Ellipse((i) * Scale + 3, (j) * Scale + 3, (i + 1) * Scale - 3, (j + 1) * Scale - 3);
            end;
          end;
        end;

      end;
    end;
    Result := True;
  end;
end;

procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TestPosX := nil;
  TestPosY := nil;
  //SetLength(TestPosX, 0);
  //SetLength(TestPosY, 0);
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  mmo3.Lines.Clear;
  Scale := trckbr1.Position;
end;

function TForm5.GetMaxInArray(A: array of Integer): Integer;
var
  I: Integer;
  tmpMax: Integer;
begin
  tmpMax := A[0];
  for I := Low(A) to High(A) do
  begin
    if A[I] > tmpMax then
      tmpMax := A[I];
  end;
  Result := tmpMax;
end;

procedure TForm5.MouseMove1(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  MapX, MapY: Integer;
begin
  if img2 <> nil then
  begin
    StretchBlt(imgScreen.Canvas.Handle, 0, 0, imgScreen.Width, imgScreen.height, img2.Canvas.Handle, X - 20, Y - 20, 40, 40, SRCCOPY);
    with imgScreen.Canvas do
    begin
      Brush.Color := clRed;
      Pen.Color := clYellow;
      Ellipse(48, 48, 52, 52);
    end;
    imgScreen.Refresh;
    MapX := X div Scale + 1;
    MapY := Y div Scale + 1;
    edt1.Text := '[X= ' + IntToStr(MapX) + ', Y=' + IntToStr(MapY) + ']';
  end;

end;

function TForm5.PosRepeatCheck: Boolean;
var
  i, j: Integer;
  PosColor: array of array of Integer;
  TempXMax, TempYMax: Integer;
begin
  Result := True;
  TempXMax := GetMaxInArray(TestPosX);
  TempYMax := GetMaxInArray(TestPosY);
  SetLength(PosColor, TempXMax, TempYMax);
  for i := 0 to High(TestPosX) - 1 do
  begin
    PosColor[TestPosX[i] - 1, TestPosY[i] - 1] := PosColor[TestPosX[i] - 1, TestPosY[i] - 1] + 120;
  end;
  for i := 0 to High(PosColor) do
  begin
    for j := 0 to High(PosColor[i]) do
    begin
      if PosColor[i, j] > 120 then
      begin
        Result := False;
        mmo3.Lines.Add('重复坐标=' + IntToStr(i + 1) + '/' + IntToStr(j + 1));
      end;
    end;
  end;
  SetLength(PosColor, 0, 0);
end;

function TForm5.ReadXls(Path: string): Boolean;
var
  Conn: TFDConnection;
  Qry: TFDQuery;
  Tables, TablesTemp: TStringList;
  i: Integer;
  j: Integer;
  Str, StrTemp, StrTempNew: string;
  ValueCount, FstAccCount: Integer;
  IsFocusXls, IsAccoXls: Boolean;
  TempFocusTableArr: array[0..1] of string;
  TempAccoTableArr: array[0..2] of string;
  FocusNumber, AccoNumber: Integer;
begin
  Conn := TFDConnection.Create(Self);
  Tables := TStringList.Create;
  TablesTemp := TStringList.Create;
  Qry := TFDQuery.Create(Self);
  Qry.Connection := Conn;
  Conn.Params.DriverID := 'ODBC';
  Conn.Params.Values['DataSource'] := 'Excel Files';
  Conn.Params.Database := Path;
  Conn.LoginPrompt := False;
  try
    Conn.Close;
    Conn.Connected := True;
    Conn.GetTableNames('', '', '', TablesTemp, [osMy, osSystem, osOther], [tkTable], False);
    for i := 0 to TablesTemp.Count - 1 do
    begin
      StrTemp := TablesTemp[i];
      for j := 1 to Length(StrTemp) do
      begin
        if (StrTemp[j] in ['0'..'9']) or (StrTemp[j] in ['a'..'z']) or (StrTemp[j] in ['A'..'Z']) or (StrTemp[j] in ['_', '-', '.', '#', ' ', '$']) then
        begin
          StrTempNew := StrTempNew + StrTemp[j];
        end;

      end;
      if Copy(StrTempNew, Length(StrTempNew), 1) <> '$' then
        Continue;

      //Tables[i] := StrTempNew;
      Tables.Add(StrTempNew);
      StrTempNew := '';

    end;

    case Tables.Count of
      2: //focus or juno,Xpos,Ypos
        for j := 0 to 1 do
        begin
          if Tables[j] <> 'Counter$' then
          begin
            with Qry do
            begin
              Close;
              SQL.Clear;
              if IsXlsx then
              begin
                SQL.Text := 'SELECT * FROM [' + Tables[j] + 'C24:D99999]';
                mmo3.Lines.Add('xlsx文件，上限99999行数据');
              end
              else
              begin
                SQL.Text := 'SELECT * FROM [' + Tables[j] + 'C24:D65535]';
                mmo3.Lines.Add('xls文件，上限65535行数据');
              end;

              //SELECT IR_5V FROM [DUT_DATA$] WHERE IR_5V > 50 OR IR_45V > 50  ';
              Open();
              if RecordCount > 0 then
              begin
                First;
                ValueCount := 0;
                SetLength(TestPosX, PosMaxNumber);
                SetLength(TestPosY, PosMaxNumber);
                while not Eof do
                begin
                  //mmo3.Lines.Add(Qry.Fields[0].asstring);
                  //mmo1.Lines.Add(Qry.Fields[1].asstring);
                  TestPosX[ValueCount] := Fields[0].AsInteger;
                  TestPosY[ValueCount] := Fields[1].AsInteger;
                  Next;
                  Inc(ValueCount);
                end;
                SetLength(TestPosX, ValueCount + 1);
                SetLength(TestPosY, ValueCount + 1);
              end;
              MaxRow := GetMaxInArray(TestPosY);
              MaxCol := GetMaxInArray(TestPosX);
              mmo3.Lines.Add('坐标数据为=' + IntToStr(ValueCount) + '组。');
              mmo3.Lines.Add('XMax坐标=' + IntToStr(MaxCol));
              mmo3.Lines.Add('YMax坐标=' + IntToStr(MaxRow));
            end;
          end;
          Result := True;

        end;
      3: //acco,X_COORD,Y_COORD
        with Qry do
        begin
          IsFocusXls := False;
          IsAccoXls := False;
          FocusNumber := 0;
          AccoNumber := 0;
          //此处判断三个表是focus表还是acco表
          for i := 0 to 2 do
          begin
            if Tables[i] = 'Counter$' then
            begin
              IsFocusXls := True;
              IsAccoXls := False;
              Break;
            end;
            if Tables[i] = 'Summary information$' then
            begin
              IsAccoXls := True;
              IsFocusXls := False;
              Break;
            end;
          end;
          //三个表如果是juno 或者focus的文件会有二个数据表，如果是acco则只有一个数据表
          //acco至少三个表，juno和focus一般是2个表 三个表则是大于65535行的数据,2个数据表
          //因为acco三个表肯定只有一个数据表，所以下面的功能不需要了。
          {if not IsFocusXls and IsAccoXls then
          begin
            for i := 0 to 2 do
            begin
              if Pos('Counter', Tables[i]) = 0 then
              begin
                TempFocusTableArr[FocusNumber] := Tables[i];
                FocusNumber := FocusNumber + 1;
              end;
            end;
          end;}

          if IsFocusXls and not IsAccoXls then
          begin
            for i := 0 to 2 do
            begin
              if Pos('Counter', Tables[i]) = 0 then
              begin
                TempFocusTableArr[FocusNumber] := Tables[i];
                FocusNumber := FocusNumber + 1;
              end;
            end;
          end;

          if IsFocusXls and not IsAccoXls then
          begin
            Close;
            if IsXlsx then
            begin
              SQL.Text := 'SELECT * FROM [' + TempFocusTableArr[0] + 'C24:D99999]';
              mmo3.Lines.Add('xlsx文件，上限99999行数据');
            end
            else
            begin
              SQL.Text := 'SELECT * FROM [' + TempFocusTableArr[0] + 'C24:D65535]';
              mmo3.Lines.Add('xls文件，上限65535行数据');
            end;
            Open();
            if RecordCount > 0 then
            begin
              First;
              ValueCount := 0;
              SetLength(TestPosX, PosMaxNumber);
              SetLength(TestPosY, PosMaxNumber);
              while not Eof do
              begin
                TestPosX[ValueCount] := Fields[0].AsInteger;
                TestPosY[ValueCount] := Fields[1].AsInteger;
                Qry.Next;
                Inc(ValueCount);
                FstAccCount := ValueCount;
              end;

            end;
            Close;
            SQL.Clear;
            if IsXlsx then
            begin
              SQL.Text := 'SELECT * FROM [' + TempFocusTableArr[1] + 'C24:D99999]';
              mmo3.Lines.Add('xlsx文件，上限99999行数据');
            end
            else
            begin
              SQL.Text := 'SELECT * FROM [' + TempFocusTableArr[1] + 'C24:D65535]';
              mmo3.Lines.Add('xls文件，上限65535行数据');
            end;
            Open();
            if RecordCount > 0 then
            begin
              First;
              ValueCount := 0;
              SetLength(TestPosX, PosMaxNumber);
              SetLength(TestPosY, PosMaxNumber);
              while not Eof do
              begin
                TestPosX[FstAccCount + ValueCount] := Fields[0].AsInteger;
                TestPosY[FstAccCount + ValueCount] := Fields[1].AsInteger;
                Qry.Next;
                Inc(ValueCount);
              end;
            end;
            SetLength(TestPosX, FstAccCount + ValueCount + 1);
            SetLength(TestPosY, FstAccCount + ValueCount + 1);
            MaxRow := GetMaxInArray(TestPosY);
            MaxCol := GetMaxInArray(TestPosX);
            mmo3.Lines.Add('坐标数据为=' + IntToStr(FstAccCount + ValueCount) + '组。');
            mmo3.Lines.Add('XMax坐标=' + IntToStr(MaxCol));
            mmo3.Lines.Add('YMax坐标=' + IntToStr(MaxRow));
            FstAccCount := 0;
            Result := True;
          end;
          if not IsFocusXls and IsAccoXls then
          begin
            Close;
            SQL.Text := 'SELECT X_COORD,Y_COORD FROM [DUT_DATA$]';
            Open();
            if RecordCount > 0 then
            begin
            //First;
              Qry.MoveBy(4); //前面四个acc为空值
              ValueCount := 0;
              SetLength(TestPosX, PosMaxNumber);
              SetLength(TestPosY, PosMaxNumber);
              while not Eof do
              begin
                TestPosX[ValueCount] := Fields[0].AsInteger;
                TestPosY[ValueCount] := Fields[1].AsInteger;
              //mmo3.Lines.Add(Fields[0].AsString);
                Qry.Next;
                Inc(ValueCount);
              end;
              SetLength(TestPosX, ValueCount + 1);
              SetLength(TestPosY, ValueCount + 1);
            end;
            MaxRow := GetMaxInArray(TestPosY);
            MaxCol := GetMaxInArray(TestPosX);
            mmo3.Lines.Add('坐标数据为=' + IntToStr(ValueCount) + '组。');
            mmo3.Lines.Add('XMax坐标=' + IntToStr(MaxCol));
            mmo3.Lines.Add('YMax坐标=' + IntToStr(MaxRow));
            Result := True;
          end;
        end;
      4: //acco,X_COORD,Y_COORD   超大XLS文件 二个表头合并的情况
        with Qry do
        begin
          Close;
          SQL.Text := 'SELECT X_COORD,Y_COORD FROM [DUT_DATA$]';
          Open();
          if RecordCount > 0 then
          begin
            //First;
            Qry.MoveBy(4); //前面四个acc为空值
            ValueCount := 0;
            SetLength(TestPosX, PosMaxNumber);
            SetLength(TestPosY, PosMaxNumber);
            while not Eof do
            begin
              TestPosX[ValueCount] := Fields[0].AsInteger;
              TestPosY[ValueCount] := Fields[1].AsInteger;
              Qry.Next;
              Inc(ValueCount);
              FstAccCount := ValueCount;
            end;

          end;
          Close;
          SQL.Clear;
          SQL.Text := 'SELECT X_COORD,Y_COORD FROM [DUT_DATA1$]';
          Open();
          if RecordCount > 0 then
          begin
            //First;
            Qry.MoveBy(4); //前面四个acc为空值
            ValueCount := 0;
            //SetLength(TestPosX, PosMaxNumber);
            //SetLength(TestPosY, PosMaxNumber);
            while not Eof do
            begin
              TestPosX[FstAccCount + ValueCount] := Fields[0].AsInteger;
              TestPosY[FstAccCount + ValueCount] := Fields[1].AsInteger;
              Qry.Next;
              Inc(ValueCount);
            end;

          end;

          SetLength(TestPosX, FstAccCount + ValueCount + 1);
          SetLength(TestPosY, FstAccCount + ValueCount + 1);
          MaxRow := GetMaxInArray(TestPosY);
          MaxCol := GetMaxInArray(TestPosX);
          mmo3.Lines.Add('坐标数据为=' + IntToStr(FstAccCount + ValueCount) + '组。');
          mmo3.Lines.Add('XMax坐标=' + IntToStr(MaxCol));
          mmo3.Lines.Add('YMax坐标=' + IntToStr(MaxRow));
          FstAccCount := 0;
          Result := True;

        end;

    end;

  finally

    Qry.Close;
    Conn.Connected := False;
    Conn.Close;
    Conn.Free;
    Qry.Free;
    Tables.Free;
    TablesTemp.Free;

  end;

end;

procedure TForm5.trckbr1Change(Sender: TObject);
begin

  Scale := trckbr1.Position;
  DrawFunMain(trckbr1.Position, 0);
  if not IsTelDataClear then
  begin
    DrawFunMain(trckbr1.Position, 1);
  end;

end;

end.

