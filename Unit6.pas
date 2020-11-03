unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  ColRowArr = array[0..1] of Integer;

type
  TForm6 = class(TForm)
    edt1: TEdit;
    edt2: TEdit;
    btn1: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    btn2: TButton;
    edt3: TEdit;
    btn3: TButton;
    edt5: TEdit;
    edt6: TEdit;
    edt7: TEdit;
    edt8: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    mmo1: TMemo;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    edt4: TEdit;
    edt9: TEdit;
    lbl7: TLabel;
    lbl8: TLabel;
    edt10: TEdit;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function ReWriteTelFile(Path: string; XOffset: Integer; YOffset: Integer): Boolean;
  public
    { Public declarations }
    function LoadTelMapFile(Path: string): Boolean;
    function ReadColRowForTel(Path: string): ColRowArr;
  end;

var
  Form6: TForm6;

implementation

uses
  Unit5, Global;

{$R *.dfm}

procedure TForm6.btn1Click(Sender: TObject);
var
  dlgopen2: TOpenDialog;
  Str, AplPath: string;
  Temp: ColRowArr;
  Txtlist: TStringList;
  WaferSize, SizeX, SizeY: string;
begin
  SetLength(TelPosArrNew, 0);

  dlgopen2 := TOpenDialog.Create(nil);
  try
    dlgopen2.Filter := 'TEL Marking File(*.map)|*.map';
    dlgopen2.DefaultExt := '*.map';
    //dlgopen2.InitialDir := '\\10.9.64.72\cp\临时文件\WWM';
    if dlgopen2.Execute then
    begin
      Str := Trim(dlgopen2.FileName);
      edt3.Text := Str;
      AplPath := Copy(Str, 1, Length(Str) - 3) + 'apl';
      if not FileExists(AplPath) then
      begin
        ShowMessage(AplPath + '不存在！');
        Exit;
      end;
      Txtlist := TStringList.Create;
      Txtlist.LoadFromFile(AplPath);
      WaferSize := Trim(Copy(Txtlist[1], Length(Txtlist[1]), 1));
      SizeX := Trim(Copy(Txtlist[7], 21, Length(Txtlist[7]) - 20));
      SizeY := Trim(Copy(Txtlist[8], 21, Length(Txtlist[8]) - 20));

      if (StrToInt(SizeX) > 765) and (StrToInt(SizeY) > 765) then
      begin
        Temp := ReadColRowForTel(Str);
        if Temp[0] = 0 then
        begin
          ShowMessage('数据读取错误');
          Exit;
        end;
        edt1.Text := IntToStr(Temp[0]);
        edt2.Text := IntToStr(Temp[1]);
      end
      else
      begin
        ShowMessage('超出自动读取范围，请手动输入最大列数和行数。');
        edt1.Text := '';
        edt2.Text := '';
      end;
      btn2.Enabled := True;
    end;
  finally
    FreeAndNil(dlgopen2);
  end;

end;

procedure TForm6.btn2Click(Sender: TObject);
begin
  TelMaxCol := StrToInt(edt1.Text);
  TelMaxRow := StrToInt(edt2.Text);
  if TelMaxCol < 0 then
    Exit;
  if TelMaxRow < 0 then
    Exit;

  if edt3.Text = '' then
    Exit;
  if LoadTelMapFile(edt3.Text) then
  begin
    Form5.mmo3.Lines.Add('tel data  load success！');
    ShowMessage('tel data  load success');
    IsTelDataClear := False;
  end;
  //Close;

end;

procedure TForm6.btn3Click(Sender: TObject);
var
  Xls2TelOffsetX, Xls2TelOffsetY: Integer;
  dlgopen2: TOpenDialog;
  Str, AplPath: string;
  Temp: ColRowArr;
  Txtlist: TStringList;
  WaferSize, SizeX, SizeY: string;
begin
  SetLength(TelPosArrNew, 0);
  XlsPPointX := StrToInt(edt5.Text);
  XlsPPointY := StrToInt(edt6.Text);
  XlsTelPPointX := StrToInt(edt7.Text);
  XlsTelPPointY := StrToInt(edt8.Text);
  TelMaxCol := StrToInt(edt4.Text);
  TelMaxRow := StrToInt(edt9.Text);

  dlgopen2 := TOpenDialog.Create(nil);
  try
    dlgopen2.Filter := 'TEL Marking File(*.map)|*.map';
    dlgopen2.DefaultExt := '*.map';
    if dlgopen2.Execute then
    begin
      Str := Trim(dlgopen2.FileName);
      edt10.Text := Str;
      //为了数据安全性，自动获取行列的方法有时候在die数超大的时候不可靠。所以屏蔽
//      AplPath := Copy(Str, 1, Length(Str) - 3) + 'apl';
//      if not FileExists(AplPath) then
//      begin
//        ShowMessage(AplPath + '不存在！');
//        edt10.Text := '';
//        Exit;
//      end;
//      Txtlist := TStringList.Create;
//      Txtlist.LoadFromFile(AplPath);
//      WaferSize := Trim(Copy(Txtlist[1], Length(Txtlist[1]), 1));
//      SizeX := Trim(Copy(Txtlist[7], 21, Length(Txtlist[7]) - 20));
//      SizeY := Trim(Copy(Txtlist[8], 21, Length(Txtlist[8]) - 20));
//
//      if (StrToInt(SizeX) > 765) and (StrToInt(SizeY) > 765) then
//      begin
//        Temp := ReadColRowForTel(Str);
//        if Temp[0] = 0 then
//        begin
//          ShowMessage('数据读取错误');
//          Exit;
//        end;
//        edt4.Text := IntToStr(Temp[0]);
//        edt9.Text := IntToStr(Temp[1]);
//      end
//      else if (edt4.Text = '') or (edt9.Text = '') then
//      begin
//        ShowMessage('超出自动读取范围，请手动输入最大列数和行数。');
//        edt1.Text := '';
//        edt2.Text := '';
//        edt10.Text := '';
//        Exit;
//      end;
  //获得测试文件p点坐标和将要被覆盖的tel模板文件坐标

  //不能小于0
      if (XlsPPointX < 0) or (XlsPPointY < 0) or (XlsTelPPointX < 0) or (XlsTelPPointY < 0) or (TelMaxRow < 0) or (TelMaxCol < 0) then
      begin
        ShowMessage('行列数坐标数据有误！');
        Exit;
      end;

      Xls2TelOffsetX := XlsPPointX - XlsTelPPointX;
      Xls2TelOffsetY := XlsPPointY - XlsTelPPointY;

      if ReWriteTelFile(edt10.Text, Xls2TelOffsetX, Xls2TelOffsetY) then
      begin
        mmo1.Lines.Add('文件覆盖成功！');
      end;
    end;
  finally
    FreeAndNil(dlgopen2);
    Txtlist.Free;
    //Close;
  end;

end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  mmo1.Lines.Clear;
end;

function TForm6.LoadTelMapFile(Path: string): Boolean;
var
  GetStream: TFileStream;
  Buf: Byte;
  Buf4: array[0..3] of Byte;
  Buf9: array[0..8] of Byte;
  PosCounts: Integer;
  I: Integer;
  J: Integer;
  ReadCount: Integer;
  DieCounts: Integer;
  XPos, YPos: Integer;
  OtherCount, TestCount, Markcount, SkipCount: Integer;
  TSKCount: Integer;
  TSKPosX, TSKPosY, TELBin: Integer;
  TelX, TelY: Integer;
begin
  Result := False;
  OtherCount := 0;
  TestCount := 0;
  Markcount := 0;
  SkipCount := 0;

  GetStream := TFileStream.Create(Path, fmOpenRead or fmShareExclusive);
  SetLength(TelPosArrNew, 0, 0);
  with GetStream do
  begin

    SetLength(TelPosArrNew, TelMaxCol, TelMaxRow);
    Position := TELXYPosStart;
    ReadCount := 0;
    DieCounts := TelMaxCol * TelMaxRow;

    Application.ProcessMessages;
    while ReadCount < DieCounts do
    begin
      XPos := ReadCount mod TelMaxCol + 1;
      YPos := ReadCount div TelMaxCol + 1;
      Read(Buf9, 9);
      TelPosArrNew[XPos - 1][YPos - 1] := Buf9[2] * 255 + Buf9[3];
      ReadCount := ReadCount + 1;
      case TelPosArrNew[XPos - 1][YPos - 1] of
        TEL_Test_Bin:
          begin
            TestCount := TestCount + 1;
          end;
        TEL_Skip_Bin:
          begin
            SkipCount := SkipCount + 1;
          end;
        TEL_Mark_Bin:
          begin
            Markcount := Markcount + 1;
          end
      else
        begin
          OtherCount := OtherCount + 1;
        end;
      end;
    end;
    Form5.mmo3.Lines.Add('Test= ' + IntToStr(TestCount));
    Form5.mmo3.Lines.Add('Skip= ' + IntToStr(SkipCount));
    Form5.mmo3.Lines.Add('Mark= ' + IntToStr(Markcount));
    Form5.mmo3.Lines.Add('Other= ' + IntToStr(OtherCount));

  end;
  GetStream.Free;
  Form5.DrawFunMain(Form5.trckbr1.Position, 1);
//  if img2 <> nil then
//  begin
//    Form5.trckbr1.Position := (Form5.trckbr1.Min + Form5.trckbr1.Max) div 2;
//  end;
  Result := True;
end;

function TForm6.ReadColRowForTel(Path: string): ColRowArr;
var
  GetStream: TFileStream;
  Buf4: array[0..3] of Byte;
  I: Integer;
  j: Integer;
  ColRow: ColRowArr;
begin
  ColRow[0] := 0;
  ColRow[1] := 0;
  ReadColumnsMax := 0;
  ReadRowsMax := 0;
  try
    GetStream := TFileStream.Create(Path, fmOpenRead or fmShareExclusive);
    with GetStream do
    begin
      Position := 14;
      Read(Buf4, 4);
      //ReadColumnsMax := Buf4[1];
      //ReadRowsMax := Buf4[3];
      ColRow[0] := Buf4[1];
      ColRow[1] := Buf4[3];
      Result := ColRow;
    end;

  except
    Result := ColRow;

  end;
  GetStream.Free;

end;

function TForm6.ReWriteTelFile(Path: string; Xoffset: Integer; Yoffset: Integer): Boolean;
var
  MyStream: TFileStream;
  Buf_9: array[0..8] of Byte; //tel 文件每次以9字节读取为一个die的数据
  Buf1: Byte;
  Buf2: Byte;
  I: Integer;
  TempX, TempY, TempPos: Integer;
  BackPath: string;
  ReadCount: Integer;
  HasReadCount: Integer;
  ReadPos, HasWriteCount: Integer;
  MarkDieArr: array of Boolean;
begin
  Result := False;
  HasReadCount := 0;
  HasWriteCount := 0;
  ReadCount := TelMaxCol * TelMaxRow;
  SetLength(MarkDieArr, ReadCount);
  //FillChar(MarkDieArr, ReadCount, False);
  Buf1 := $09;
  Buf2 := $03;
  BackPath := ExtractFileDir(ParamStr(0)) + '\Back\';
  if not DirectoryExists(BackPath) then
  begin
    CreateDir(BackPath);
  end;
  mmo1.Lines.Clear;
  CopyFile(PChar(Path), PChar(BackPath + FormatDateTime('yyyymmddhhnnss', Now)+'.map'), True);
  mmo1.Lines.Add('文件备份成功。');
  mmo1.Lines.Add('路径: ' + #13#10 + ExtractFileDir(ParamStr(0)) + '\Back\');
  //提取test die
  MyStream := TFileStream.Create(Path, fmOpenRead or fmShareExclusive);
  with MyStream do
  begin
    Position := TELXYPosStart;
    while (ReadCount > 0) do
    begin
      Read(Buf_9, 9);

      if (Buf_9[2] = $03) then
      begin
        //Seek(-7, soFromEnd);
        //Write(Buf1, 1);
        //Seek(6, soFromEnd);
        MarkDieArr[HasReadCount] := True;
      end;
      Dec(ReadCount);
      Inc(HasReadCount);

    end;

  end;
  MyStream.Free;
  //把test die 全改为mark点
  //再根据xls的测试数据把对应坐标的die改为test点
  MyStream := TFileStream.Create(Path, fmOpenWrite or fmShareExclusive);
  with MyStream do
  begin
    for I := 0 to High(MarkDieArr) do
    begin
      if MarkDieArr[I] then
      begin
        //Seek(9 * I + 2, soFromEnd);
        Position := 9 * I + 2 + TELXYPosStart;
        Write(Buf1, 1);
        Seek(6, soFromEnd);
      end;

    end;
    mmo1.Lines.Add('Tel文件Mark标记归零成功！');
    Position := TELXYPosStart;
    for I := 0 to High(TestPosX) - 1 do
    begin
      TempX := TestPosX[I];
      TempY := TestPosY[I];
      if TempX = 0 then
        Continue;
      if TempY = 0 then
        Continue;
      //xls文件坐标根据p点偏移量算出在tel上的坐标，这个坐标在telmaxcol X telmaxrow 这样的矩形上用下面的方式得出实际的字节位置
      //TELXYPosStart是坐标文件开始的读取地址
      TempPos := (TempX - Xoffset - 1 + (TempY - Yoffset - 1) * TelMaxCol) * 9 + TELXYPosStart;
      Position := TempPos; //移动到这个这个die的读取坐标
      Seek(2, soFromCurrent); //9个字节里面的第三个数据改为$03即为test点
      //02 64 09 00 00 00 00 00 00 mark
      //02 64 03 00 00 00 00 00 00 test
      Write(Buf2, 1); //第三个字节写入$03
//      Inc(HasWriteCount);
//      if HasWriteCount = 42842 then
//      begin
//        MyStream.Free;
//
//        SetLength(MarkDieArr, 0);
//        Exit;
//      end;

    end;
  end;
  MyStream.Free;
  mmo1.Lines.Add('Tel文件覆盖操作成功！');
  SetLength(MarkDieArr, 0);

end;

end.

