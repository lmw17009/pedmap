unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ButtonGroup, Vcl.Buttons, Vcl.Imaging.pngimage,
  System.Math;

type
  TForm1 = class(TForm)
    dlgOpen1: TOpenDialog;
    mm1: TMainMenu;
    N1: TMenuItem;
    E1: TMenuItem;
    Memo1: TMemo;
    Edit1: TEdit;
    scrlbx1: TScrollBox;
    NBBtn: TButton;
    SBtn: TButton;
    MBtn: TButton;
    LBtn: TButton;
    XLBtn: TButton;
    XXLBtn: TButton;
    Magimg1: TImage;
    Edit2: TEdit;
    ButtonGroup1: TButtonGroup;
    Edit3: TEdit;
    AllMBtn: TButton;
    AllNBtn: TButton;
    Button2: TButton;
    F1: TMenuItem;
    A1: TMenuItem;
    N3: TMenuItem;
    BrushBtn: TButton;
    AllSBtn: TButton;
    dlgSave1: TSaveDialog;
    Label1: TLabel;
    Label2: TLabel;
    N2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    EL1: TMenuItem;
    EL2: TMenuItem;
    Focus2Accodata1: TMenuItem;
    Dat1: TMenuItem;
    WATWafer1: TMenuItem;
    chkLockNormal: TCheckBox;
    chkLockSkip: TCheckBox;
    chkLockMark: TCheckBox;
    CPSPEC1: TMenuItem;
    WAT1: TMenuItem;
    FTP1: TMenuItem;
    WatLimit1: TMenuItem;
    XLS1: TMenuItem;
    N6: TMenuItem;
    mniTSKSample: TMenuItem;
    mniN7: TMenuItem;
    procedure E1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NBBtnClick(Sender: TObject);
    procedure SBtnClick(Sender: TObject);
    procedure MBtnClick(Sender: TObject);
    procedure LBtnClick(Sender: TObject);
    procedure XLBtnClick(Sender: TObject);
    procedure XXLBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure scrlbx1MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure ButtonGroup1Items0Click(Sender: TObject);
    procedure ButtonGroup1Items1Click(Sender: TObject);
    procedure ButtonGroup1Items2Click(Sender: TObject);
    procedure AllMBtnClick(Sender: TObject);
    procedure AllNBtnClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure H1Click(Sender: TObject);
    procedure BrushBtnClick(Sender: TObject);
    procedure LoadTelDataClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure AllSBtnClick(Sender: TObject);
    procedure UseTelDatabtnClick(Sender: TObject);
    procedure EL1Click(Sender: TObject);
    procedure EL2Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure BrushBtnMouseEnter(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure Focus2Accodata1Click(Sender: TObject);
    procedure Dat1Click(Sender: TObject);
    procedure WATWafer1Click(Sender: TObject);
    procedure CPSPEC1Click(Sender: TObject);
    procedure FTP1Click(Sender: TObject);
    procedure WatLimit1Click(Sender: TObject);
    procedure XLS1Click(Sender: TObject);
    procedure mniTSKSampleClick(Sender: TObject);
    procedure mniN7Click(Sender: TObject);
  private
    procedure SaveTSKMapFile;

    { Private declarations }

  public
    { Public declarations }
    procedure WatParInput(XIndex, YIndex: Integer);
    procedure DrawMap;
    procedure WatDrawMap;
    procedure MtxRead(var Path: string);
    procedure MyMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MyMouseLeave(Sender: TObject);
    procedure MyMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MyMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    // procedure My2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    // procedure My2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    // procedure My2MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    function MaxMinFun(var N1, N2, Condition: Integer): Integer;
    procedure MMadd(MSG: string);
    procedure ConfigIni;
  end;

function LoadTelMkFile(var Path: string): Boolean;

function SaveTskTestPos(var Path: string): Boolean;

var
  Form1: TForm1;
  img1: TImage;
  GraImg: TImage;
  SelStPosX, SelStPosY, SelEdPosX, SelEdPosY: Integer;
  DrawDown, DrawFirst: Boolean;
  DrawStX, DrawStY, DrawEdX, DrawEdY: Integer;

implementation

{$R *.dfm}

uses
  Global, Unit2, Unit3, Unit5, Unit6, Unit7, Unit8, WAT, Limit, FTP, WatLimit,
  XlsReName, Help;

procedure TForm1.A1Click(Sender: TObject);
begin
  ShowMessage(Self.Caption + #13#10 + 'Develop by Li Mingwei，[感谢PED所有同事的帮助]。' + #13#10 + '2019.11');
end;

procedure TForm1.AllMBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to High(BinArr) do
  begin
    if (BinArr[I] <> 2) and (BinArr[I] <> 3) then
    begin
      BinArr[I] := Bin_128;
    end;
  end;
  DrawMap;
end;

procedure TForm1.AllNBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to High(BinArr) do
  begin
    if (BinArr[I] <> 2) and (BinArr[I] <> 3) then
    begin
      BinArr[I] := Bin_64;
    end;
  end;
  DrawMap;

end;

procedure TForm1.AllSBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to High(BinArr) do
  begin
    if (BinArr[I] <> 2) and (BinArr[I] <> 3) then
    begin
      BinArr[I] := Bin_0;
    end;
  end;
  DrawMap;
end;

procedure TForm1.BrushBtnClick(Sender: TObject);
begin
  if BrushBtn.Caption = '笔触模式' then
  begin
    BrushBtn.Caption := '矩阵模式';
    MMadd('当前为矩阵模式。');
    BrushMode := False;
  end
  else
  begin
    BrushBtn.Caption := '笔触模式';
    MMadd('当前为笔触模式。');
    BrushMode := True;
    FillChar(BrushBinArr, SizeOf(BrushBinArr), 0);
    SetLength(BrushBinArr, XColumns * YRows - 1);
  end;

end;

procedure TForm1.BrushBtnMouseEnter(Sender: TObject);
begin
  Self.ShowHint := True;
end;

function SaveTskTestPos(var Path: string): Boolean;
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
begin
  OtherCount := 0;
  TestCount := 0;
  Markcount := 0;
  SkipCount := 0;

  Form1.MMadd('Reading TEL marking file...');
  GetStream := TFileStream.Create(Path, fmOpenRead or fmShareExclusive);
  SetLength(TelDataArr, 0, 0);
  with GetStream do
  begin
    TelXColumns := TelMapMaxColumn;
    TelYRows := TelMapMaxRow;

    Form1.MMadd('Tel XColumns: ' + IntToStr(TelXColumns));
    Form1.MMadd('Tel YRows: ' + IntToStr(TelYRows));
    SetLength(TelDataArr, TelXColumns, TelYRows);
    Position := TELXYPosStart;
    ReadCount := 0;
    DieCounts := TelXColumns * TelYRows;
    Application.ProcessMessages;
    while ReadCount < DieCounts do
    begin
      XPos := ReadCount mod TelXColumns + 1;
      YPos := ReadCount div TelXColumns + 1;
      Read(Buf9, 9);
      TelDataArr[XPos - 1][YPos - 1] := Buf9[2] * 255 + Buf9[3];
      ReadCount := ReadCount + 1;
      case TelDataArr[XPos - 1][YPos - 1] of
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
    Form1.MMadd('AllCounts: ' + IntToStr(TestCount + SkipCount + Markcount + OtherCount));
    Form1.MMadd('TestCounts: ' + IntToStr(TestCount));
    Form1.MMadd('SkipCounts: ' + IntToStr(SkipCount));
    Form1.MMadd('Markcounts: ' + IntToStr(Markcount));
    Form1.MMadd('OtherCounts: ' + IntToStr(OtherCount));
  end;
  GetStream.Free;

  for J := 0 to TelYRows - 1 do
  begin
    for I := 0 to TelXColumns - 1 do
    begin
      if TelDataArr[I][J] = TEL_Test_Bin then
      begin

      end;
    end;
  end;
  Form1.DrawMap;
  SetLength(TelDataArr, 0);
end;

procedure TForm1.UseTelDatabtnClick(Sender: TObject);
begin
//  Form2.Position := poScreenCenter;
//  Form2.Show;
end;

procedure TForm1.WatDrawMap;
var
  I, j: Integer;
  XYIndex: Integer;
  LastScrPosV, LastScrPosH: Integer;
  CountBin64: Integer;
begin
  CountBin64 := 0;
  LastScrPosV := scrlbx1.VertScrollBar.Position;
  LastScrPosH := scrlbx1.HorzScrollBar.Position;
  scrlbx1.HorzScrollBar.Position := 0;
  scrlbx1.VertScrollBar.Position := 0;
  if img1 = nil then
  begin
    img1 := TImage.Create(scrlbx1);
    img1.Parent := scrlbx1;
    img1.Left := 0;
    img1.Top := 0;
    img1.Width := MapSize * XColumns;
    img1.height := MapSize * YRows;

    img1.OnMouseMove := MyMouseMove;
    img1.OnMouseLeave := MyMouseLeave;
    img1.OnMouseUp := MyMouseUp;
    img1.OnMouseDown := MyMouseDown;
    img1.Parent.DoubleBuffered := True;
  end
  else
  begin
    img1.Free;
    img1 := TImage.Create(scrlbx1);
    img1.Parent := scrlbx1;
    img1.Left := 0;
    img1.Top := 0;
    img1.Width := MapSize * XColumns;
    img1.height := MapSize * YRows;

    img1.OnMouseMove := MyMouseMove;
    img1.OnMouseLeave := MyMouseLeave;
    img1.OnMouseUp := MyMouseUp;
    img1.OnMouseDown := MyMouseDown;
    img1.Parent.DoubleBuffered := True;
  end;
  img1.Canvas.Pen.Color := clBlack;
  XYIndex := 0;
  MMadd('开始绘制..');
  with img1 do
  begin
  //先获取圆心坐标

  //确定需要检测距离的index范围

  //循环检测R半径


  end;

  with img1 do
  begin
    MMadd('Mapsize=' + IntToStr(MapSize));
    for I := 0 to YRows - 1 do
    begin
      for j := 0 to XColumns - 1 do
      begin
        XYIndex := I * XColumns + j;
        case BinArr[XYIndex] of
          Bin_0:
            begin
              Canvas.Brush.Color := clBlue;
            end;
          Bin_1:
            begin
              Canvas.Brush.Color := RGB(150, 99, 57);
            end;
          Bin_2:
            begin
              Canvas.Brush.Color := clRed;
            end;
          Bin_3:
            begin
              Canvas.Brush.Color := clNavy;
            end;
          Bin_4:
            begin
              Canvas.Brush.Color := clSilver;
            end;
          Bin_6:
            begin
              Canvas.Brush.Color := clGray;
            end;
          Bin_8:
            begin
              Canvas.Brush.Color := RGB(39, 65, 199);
            end;
          Bin_10:
            begin
              Canvas.Brush.Color := RGB(125, 25, 105);
            end;
          Bin_11:
            begin
              Canvas.Brush.Color := RGB(200, 50, 77);
            end;
          Bin_14:
            begin
              Canvas.Brush.Color := RGB(125, 0, 0);
            end;

          Bin_64:
            begin
              Canvas.Brush.Color := clGreen;
            end;
          Bin_65:
            begin
              Canvas.Brush.Color := RGB(60, 0, 0);
            end;
          Bin_80:
            begin
              Canvas.Brush.Color := RGB(60, 77, 32);
            end;
          Bin_81:
            begin
              Canvas.Brush.Color := RGB(90, 123, 88);
            end;
          Bin_96:
            begin
              Canvas.Brush.Color := RGB(22, 88, 254);
            end;

          Bin_128:
            begin
              Canvas.Brush.Color := RGB(255, 255, 255);
            end;

        end;
        // MMadd('x='+IntToStr(XIndexPosArr[i*j-1])+' y='+IntToStr(yIndexPosArr[i*j-1])+' bin='+IntToStr(BinArr[i*j-1]));
        Canvas.Rectangle(Rect(j * MapSize, I * MapSize, (j + 1) * MapSize, (I + 1) * MapSize));
        // MMadd(IntToStr(j * MapSize) + ',' + IntToStr(i * MapSize) + ',' + IntToStr((j + 1) * MapSize) + ',' + IntToStr((i + 1) * MapSize));
      end;
    end;
  end;
  scrlbx1.VertScrollBar.Position := LastScrPosV;
  scrlbx1.HorzScrollBar.Position := LastScrPosH;
  MMadd('绘制完成..');
  for I := 0 to High(BinArr) do
  begin
    if BinArr[I] = 64 then
    begin
      CountBin64 := CountBin64 + 1;
    end;

  end;
  MMadd('Bin64(测试颗数): ' + IntToStr(CountBin64));

end;

procedure TForm1.WatLimit1Click(Sender: TObject);
begin
  WatLimitMain.Show;
end;

procedure TForm1.WATWafer1Click(Sender: TObject);
begin
  if img1 <> nil then
  begin
    Form9.edtXIndex.Text := '';
    Form9.edtYIndex.Text := '';
    Form9.Show;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo1.Clear;
  Button2.Enabled := False;

end;

procedure TForm1.E1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.EL1Click(Sender: TObject);
begin
  Form2.Position := poScreenCenter;
  Form2.Show;
end;

procedure TForm1.EL2Click(Sender: TObject);
begin
  ShowMessage('不建议直接操作TEL Control Map原始备份数据目录，以防数据丢失！');
  Form3.Position := poDesktopCenter;
  Form3.Show;
end;

procedure TForm1.F1Click(Sender: TObject);
begin

  dlgOpen1 := TOpenDialog.Create(nil);
  try
    dlgOpen1.Filter := 'TSK File(*.MTX)|*.MTX';
    dlgOpen1.DefaultExt := '*.MTX';
    if dlgOpen1.Execute then
    begin
      Edit1.Text := '';
      Edit2.Text := '';
      Edit3.Text := '';
      SetLength(XIndexPosArr, 0);
      SetLength(YIndexPosArr, 0);
      SetLength(BinArr, 0);
      SetLength(CountBinArr, 0);
      SetLength(BrushBinArr, 0);
      XColumns := 0;
      YRows := 0;
      XStartPos := 0;
      XEndPos := 0;
      YStartPos := 0;
      YEndPos := 0;
      YCount256 := 0;
      LastValuePos := 0;
      YFstSize := 0;
      YFstDirection := 0;
      LastXYPosEndValuePos := 0;
      PosCounts := 0;
      XOffset := 0;
      YOffset := 0;
      LastMinX := 0;
      LastMaxX := 0;
      LastMinY := 0;
      LastMaxY := 0;
      Pathstr := '';
      BrushMode := False;
      SelDown := False;
      SelFirst := False;
      MMadd('已初始化。');
      Pathstr := Trim(dlgOpen1.FileName);
      TskFileName := ExtractFileName(Pathstr);
      MtxRead(Pathstr);
      AllMBtn.Enabled := True;
      AllNBtn.Enabled := True;
      AllSBtn.Enabled := True;
      NBBtn.Enabled := True;
      SBtn.Enabled := True;
      MBtn.Enabled := True;
      LBtn.Enabled := True;
      XLBtn.Enabled := True;
      XXLBtn.Enabled := True;
      BrushBtn.Enabled := True;
      ButtonGroup1.Enabled := True;
      SetLength(BrushBinArr, XColumns * YRows - 1);
      N5.Enabled := True;
      EL1.Enabled := True;
      EL2.Enabled := True;

    end;
  finally
    FreeAndNil(dlgOpen1);
  end;
end;

procedure TForm1.Focus2Accodata1Click(Sender: TObject);
begin

  if not Form7.Visible then
    Form7.Show;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin
  SetLength(XIndexPosArr, 0);
  SetLength(YIndexPosArr, 0);
  SetLength(BinArr, 0);
  SetLength(CountBinArr, 0);
  SetLength(TelDataArr, 0, 0);

  if img1 <> nil then
  begin
    img1.Free;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.Position := poDesktopCenter;
  Self.Caption := Self.Caption + version;
  Memo1.Clear;
  MMadd('点击帮助按钮可参考使用说明，部分按钮已经移入操作菜单。');
  MMadd('请点击打开按钮开始操作。');
  ConfigIni;

  // ShowMessage('1,目前有NB、S、M、L、XL、XXL 六种图显操作。' + #13#10 + '2,M=Mark,S=Skip,N=Normal。' + #13#10 + '3,MarkAll=Mark所有,NormalAll=Normal所有,SkipAll=Skip所有。' + #13#10 + '4,保存文件会以.bak后缀备份文件。' + #13#10 + '5,读取TEL数据可使用TEL的BIN数据一键修改。');
end;

procedure TForm1.FTP1Click(Sender: TObject);
begin
  if MessageDlg('请确保软件与WAT机组处于同一网段！', TMsgDlgType.mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
    Form11.Show;
  end;
end;

procedure TForm1.H1Click(Sender: TObject);
begin
//

end;

procedure TForm1.LBtnClick(Sender: TObject);
begin
  try
    with img1.Canvas do
    begin
      Brush.Color := clWhite;
      FillRect(ClipRect);
    end;
    MapSize := LSize;
    DrawMap;
  except
    ShowMessage('系统内存不足。');
  end;
end;

procedure TForm1.LoadTelDataClick(Sender: TObject);
var
  dlgOpen1: TOpenDialog;
  Str: string;
begin
//  if img1 <> nil then
//  begin
//    dlgOpen1 := TOpenDialog.Create(nil);
//    try
//      dlgOpen1.Filter := 'TEL Marking File(*.map)|*.map';
//      dlgOpen1.DefaultExt := '*.map';
//      if dlgOpen1.Execute then
//      begin
//        Str := Trim(dlgOpen1.FileName);
//        LoadTelMkFile(Str);
//      end;
//    finally
//      FreeAndNil(dlgOpen1);
//    end;
//  end
//  else
//  begin
//    MMadd('请加载TSK文件。');
//  end;
end;

function LoadTelMkFile(var Path: string): Boolean;

// TelXColumns, TelYRows: Integer;
// TelMarkDataArr: array of array of Integer;

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
  RefOffsetX, RefOffsetY: Integer; //基于P点为基准的坐标偏移，tel tsk两者的pq点位置必须一致。
begin
  OtherCount := 0;
  TestCount := 0;
  Markcount := 0;
  SkipCount := 0;

  Form1.MMadd('Reading TEL marking file...');
  GetStream := TFileStream.Create(Path, fmOpenRead or fmShareExclusive);
  SetLength(TelDataArr, 0, 0);
  with GetStream do
  begin

    //Position := TelIndexPos;
    //Read(Buf4, 4);
    TelXColumns := TelMapMaxColumn;
    TelYRows := TelMapMaxRow;

    Form1.MMadd('Tel XColumns: ' + IntToStr(TelXColumns));
    Form1.MMadd('Tel YRows: ' + IntToStr(TelYRows));
    //SetLength(TelDataArr, 5, 5);
    SetLength(TelDataArr, TelXColumns, TelYRows);
    Position := TELXYPosStart;
    ReadCount := 0;
    DieCounts := TelXColumns * TelYRows;
    Application.ProcessMessages;
    while ReadCount < DieCounts do
    begin
      XPos := ReadCount mod TelXColumns + 1;
      YPos := ReadCount div TelXColumns + 1;
      Read(Buf9, 9);
      TelDataArr[XPos - 1][YPos - 1] := Buf9[2] * 255 + Buf9[3];
//       Form1.MMadd('x=' + IntToStr(XPos) + ' y=' + IntToStr(YPos) + ' bin=' + IntToStr(TelDataArr[XPos-1][YPos-1]));
//       Form1.MMadd('postition: ' + IntToStr(Position));
//      if ReadCount>2000 then Exit;
      ReadCount := ReadCount + 1;
      case TelDataArr[XPos - 1][YPos - 1] of
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
    Form1.MMadd('AllCounts: ' + IntToStr(TestCount + SkipCount + Markcount + OtherCount));
    Form1.MMadd('TestCounts: ' + IntToStr(TestCount));
    Form1.MMadd('SkipCounts: ' + IntToStr(SkipCount));
    Form1.MMadd('Markcounts: ' + IntToStr(Markcount));
    Form1.MMadd('OtherCounts: ' + IntToStr(OtherCount));
  end;
  GetStream.Free;

  RefOffsetX := TelMapPPosX - TskMapPPosX;
  RefOffsetY := TelMapPPosY - TskMapPPosY;
  Form1.MMadd('P OffsetX: ' + IntToStr(RefOffsetX));
  Form1.MMadd('P OffsetY: ' + IntToStr(RefOffsetY));
  for J := 0 to TelYRows - 1 do
  begin
    for I := 0 to TelXColumns - 1 do
    begin
      if TelDataArr[I][J] = TEL_Test_Bin then
      begin
        //BinArr[(J - RefOffsetY - 1) * XColumns + I - RefOffsetX - 1] := Bin_64;
        BinArr[(J - RefOffsetY + ShiftYPos) * XColumns + I - RefOffsetX + ShiftXPos] := Bin_64;
      end;
    end;
  end;
  Form1.DrawMap;
  SetLength(TelDataArr, 0);
end;

function TForm1.MaxMinFun(var N1, N2, Condition: Integer): Integer;
begin
  if Condition = 0 then
  begin
    if N1 >= N2 then
    begin
      Result := N2;
    end
    else
    begin
      Result := N1;
    end;
  end;
  if Condition = 1 then
  begin
    if N1 >= N2 then
    begin
      Result := N1;
    end
    else
    begin
      Result := N2;
    end;
  end;
end;

procedure TForm1.MBtnClick(Sender: TObject);
begin
  try
    with img1.Canvas do
    begin
      Brush.Color := clWhite;
      FillRect(ClipRect);
    end;
    MapSize := MSize;
    DrawMap;
  except
    ShowMessage('系统内存不足。');
  end;
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
  if Memo1.Lines.Count > 0 then
  begin
    Button2.Enabled := True;
  end
  else
  begin
    Button2.Enabled := False;
  end;
end;

procedure TForm1.MMadd(Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

procedure TForm1.WatParInput(XIndex, YIndex: Integer);
var
  SmallR: Single;
  I: Integer;
  Tx: Integer;
  Ty: Integer;
  TempR: Single;
  OutRangeDieCount: Integer;
begin
  OutRangeDieCount := 0;
  SmallR := (TempRowDisMax - WatCenterRow) * XIndex + 0.5 * YIndex;
  MMadd('SmallR=' + FloatToStr(SmallR) + 'um');
  for I := 0 to High(BinArr) do
  begin
    if BinArr[I] = Bin_64 then
    begin
      Tx := I div XColumns + 1;
      Ty := I mod XColumns + 1;
      TempR := Sqrt(Power(Abs(Tx - WatCenterCol) * 3870, 2) + Power(Abs(Ty - WatCenterRow) * 3870, 2));
      if TempR > SmallR then
      begin
        Inc(OutRangeDieCount);
        //MMadd('r=' + FloatToStr(TempR));
        BinArr[I] := Bin_0;
      end
      else
      begin
        BinArr[I] := Bin_128;
      end;
    end;
  end;
  MMadd('OutRangeDieCount=' + IntToStr(OutRangeDieCount) + '颗');
  DrawMap;
end;

procedure TForm1.MtxRead(var Path: string);
var
  GetStream: TFileStream;
  Buf: Byte;
  Buf4: array[0..3] of Byte;
  Buf8: array[0..7] of Byte;
  PosCounts: Integer;
  I: Integer;
  j: Integer;
  Bin80Count: Integer; //确定watbin80是否唯一

begin
  GetStream := TFileStream.Create(Path, fmOpenRead or fmShareExclusive);
  with GetStream do
  begin
    Position := SIZE;
    Read(Buf, 1);
    while Buf = 0 do
    begin
      Seek(-2, soCurrent);
      Read(Buf, 1);

    end;
    MMadd('LastNoZeroPos: ' + IntToStr(Position - 1));
    Seek(-8, soCurrent);
    Read(Buf8, 8);
    XOffset := 256 * 256 - Buf8[0] * 256 - Buf8[1];
    YOffset := 256 * 256 - Buf8[2] * 256 - Buf8[3];
    MMadd('xoffset: ' + IntToStr(XOffset));
    MMadd('yoffset: ' + IntToStr(YOffset));
    XColumns := Buf8[4] * 256 + Buf8[5];
    YRows := Buf8[6] * 256 + Buf8[7];
    MMadd('xcolumns: ' + IntToStr(XColumns));
    MMadd('yrows: ' + IntToStr(YRows));
    LastXYPosEndValuePos := Position - 92;
    MMadd('LastXYPosEndValuePos： ' + IntToStr(LastXYPosEndValuePos));
    MMadd('读取信息...');
    PosCounts := (LastXYPosEndValuePos + 4) div 4;

    SetLength(XIndexPosArr, 0);
    SetLength(YIndexPosArr, 0);
    SetLength(BinArr, 0);

    SetLength(XIndexPosArr, PosCounts - 1);
    SetLength(YIndexPosArr, PosCounts - 1);
    SetLength(BinArr, PosCounts - 1);

    Position := 0;
    //从文件头开始以4长度读取数据
    //归零分bin储存数组
    SetLength(CountBinArr, 255);
    for j := 0 to 255 do
    begin
      CountBinArr[j] := 0;
    end;
    // FillChar(CountBinArr, SizeOf(CountBinArr), 0);

    for I := 0 to PosCounts - 1 do
    begin
      Read(Buf4, 4);
      XIndexPosArr[I] := Buf4[0] * 256 + Buf4[1];
      YIndexPosArr[I] := Buf4[3];
      BinArr[I] := Buf4[2];
      if BinArr[I] = WatCenterBin then
      begin
        Inc(Bin80Count);
        WatCenterX := XIndexPosArr[I];
        WatCenterY := YIndexPosArr[I];
        WatCenterCol := (I + 1) mod XColumns;
        WatCenterRow := (I + 1) div XColumns + 1;
        //如果为80的bin值，则认为是wat的中心bin，前提是要bin80count=1
      end;

      // MMadd('x: ' + IntToStr(XIndexPosArr[I]) + ' y: ' + IntToStr(YIndexPosArr[I]) + '  bin: ' + IntToStr(BinArr[I]));
      CountBinArr[Buf4[2]] := CountBinArr[Buf4[2]] + 1;
    end;
    MMadd('读取完成..');
    MMadd('分Bin计数 :');
    MMadd('------------');
    if Bin80Count = 1 then
    begin
      MMadd('Bin80Count=1');
      MMadd('WatCenterX=' + IntToStr(WatCenterX));
      MMadd('WatCenterY=' + IntToStr(WatCenterY));
      MMadd('WatCenterCol=' + IntToStr(WatCenterCol));
      MMadd('WatCenterRow=' + IntToStr(WatCenterRow));
      //计算四边的坐标
      TempColDisMin := 0;
      for I := XColumns * (WatCenterRow - 1) to XColumns * (WatCenterRow - 1) + WatCenterCol - 1 do
      begin
        if BinArr[I] = WatMarkBin then
        begin
          if (I mod XColumns + 1) >= TempColDisMin then
          begin
            TempColDisMin := I mod XColumns + 1 + 1; //离watcenterbin最左的normal点
          end;
        end;
      end;
      MMadd('TempColDisMin=' + IntToStr(TempColDisMin));
      TempColDisMax := 9999;
      for I := XColumns * (WatCenterRow - 1) + WatCenterCol - 1 to XColumns * WatCenterRow - 1 do
      begin
        if BinArr[I] = WatMarkBin then
        begin
          if (I mod XColumns + 1) <= TempColDisMax then
          begin
            TempColDisMax := I mod XColumns + 1 - 1; //离watcenterbin最右的normal点
          end;
        end;
      end;
      MMadd('TempColDisMax=' + IntToStr(TempColDisMax));

      TempRowDisMin := 0;
      for I := 0 to WatCenterRow - 1 do
      begin
        if BinArr[I * XColumns + WatCenterCol - 1] = WatMarkBin then
        begin
          if I + 1 >= TempColDisMin then
          begin
            TempRowDisMin := I + 1 + 1; //离watcenterbin最上的normal点
          end;
        end;
      end;
      MMadd('TempRowDisMin=' + IntToStr(TempRowDisMin));
      TempRowDisMax := 9999;
      for I := WatCenterRow to YRows do
      begin
        if BinArr[(I - 1) * XColumns + WatCenterCol - 1] = WatMarkBin then
        begin
          if I <= TempRowDisMax then
          begin
            TempRowDisMax := I - 1; //离watcenterbin最下边的normal点
          end;
        end;
      end;
      MMadd('TempRowDisMax=' + IntToStr(TempRowDisMax));

      Bin80Count := 0;
    end;

    for I := 0 to 255 do
    begin
      if CountBinArr[I] <> 0 then
      begin
        MMadd('Bin' + IntToStr(I) + ': ' + IntToStr(CountBinArr[I]));
      end;
    end;
    MMadd('------------');
    Edit3.Text := '';
    DrawMap;

  end;
  GetStream.Free;

end;

procedure TForm1.MyMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  SelDown := True;
  SelFirst := False;
  SelStPosX := X div MapSize + 1;
  SelStPosY := Y div MapSize + 1;
  LastMinX := SelStPosX;
  LastMaxX := SelStPosX;
  LastMinY := SelStPosY;
  LastMaxY := SelStPosY;
  for I := 0 to XColumns * YRows - 1 do
  begin
    BrushBinArr[I] := 0;
  end;

end;

// procedure TForm1.My2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
// begin
// DrawDown := True;
// DrawFirst := True;
// DrawStX := X;
// DrawStY := Y;
//
// end;

// procedure TForm1.My2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
// begin
// if DrawDown then
// begin
// with GraImg.Canvas do
// begin
// Pen.Width := 1;
// Pen.Style := psDash;
// Brush.Style := bsClear;
// MoveTo(DrawStX, DrawStY);
// LineTo(X, Y);
// end;
// //GraImg.Refresh;
// end;
//
// end;

// procedure TForm1.My2MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
// begin
// DrawDown := False;
// DrawStX := 0;
// DrawStY := 0;
//
// end;

procedure TForm1.MyMouseLeave(Sender: TObject);
begin
  Magimg1.Canvas.FillRect(Magimg1.Canvas.ClipRect);
end;

procedure TForm1.MyMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  MapX, MapY, DataXPos, DataYPos, I, j, m, n: Integer;
  MinNX, MaxNX, MinNY, MaxNY, PosCount: Integer;
  SelCountTemp: Integer;
begin
  if img1 <> nil then
  begin
    StretchBlt(Magimg1.Canvas.Handle, 0, 0, Magimg1.Width, Magimg1.height, img1.Canvas.Handle, X - 20, Y - 20, 40, 40, SRCCOPY);

    with Magimg1.Canvas do
    begin
      Brush.Color := clRed;
      Pen.Color := clYellow;
      Ellipse(48, 48, 52, 52);
    end;
    Magimg1.Refresh;

    MapX := X div MapSize + 1;
    MapY := Y div MapSize + 1;
    if MapX - 1 > XColumns then
    begin
      MapX := XColumns + 1;
    end;
    if MapY - 1 > YRows then
    begin
      MapY := YRows + 1;
    end;
    DataXPos := XIndexPosArr[(MapY - 1) * XColumns + MapX - 1];
    DataYPos := YIndexPosArr[(MapY - 1) * XColumns + MapX - 1];
    Edit1.Text := IntToStr(MapX) + ' , ' + IntToStr(MapY);
    Edit2.Text := 'X= ' + IntToStr(DataXPos) + ' Y= ' + IntToStr(DataYPos) + ' Bin=' + IntToStr(BinArr[(MapY - 1) * XColumns + MapX - 1]);

    if Edit3.Text <> '' then
    begin

      SelCountTemp := 0;

      if SelDown then
      begin
        if not BrushMode then
        begin
          if SelStPosX >= MapX then
          begin
            MinNX := MapX;
            MaxNX := SelStPosX;
          end
          else
          begin
            MinNX := SelStPosX;
            MaxNX := MapX;

          end;

          if SelStPosY >= MapY then
          begin
            MinNY := MapY;
            MaxNY := SelStPosY;
          end
          else
          begin
            MinNY := SelStPosY;
            MaxNY := MapY;

          end;

          // MMadd('lastminx: ' + IntToStr(LastMinX));
          // MMadd('lastmaxx: ' + IntToStr(LastMaxX));
          // MMadd('lastminy: ' + IntToStr(LastMinY));
          // MMadd('lastmaxy: ' + IntToStr(LastMaxY));

          with img1 do
          begin
            Canvas.Pen.Color := clBlack;
            for m := LastMinY to LastMaxY do
            begin
              for n := LastMinX to LastMaxX do
              begin
                PosCount := (m - 1) * XColumns + n;
                case BinArr[PosCount - 1] of
                  Bin_0:
                    begin
                      Canvas.Brush.Color := clBlue;
                    end;
                  Bin_1:
                    begin
                      Canvas.Brush.Color := RGB(150, 99, 57);
                    end;
                  Bin_2:
                    begin
                      Canvas.Brush.Color := clRed;
                    end;
                  Bin_3:
                    begin
                      Canvas.Brush.Color := clNavy;
                    end;
                  Bin_4:
                    begin
                      Canvas.Brush.Color := clSilver;
                    end;
                  Bin_6:
                    begin
                      Canvas.Brush.Color := clGray;
                    end;
                  Bin_8:
                    begin
                      Canvas.Brush.Color := RGB(39, 65, 199);
                    end;
                  Bin_10:
                    begin
                      Canvas.Brush.Color := RGB(125, 25, 105);
                    end;
                  Bin_11:
                    begin
                      Canvas.Brush.Color := RGB(200, 50, 77);
                    end;
                  Bin_14:
                    begin
                      Canvas.Brush.Color := RGB(125, 0, 0);
                    end;

                  Bin_64:
                    begin
                      Canvas.Brush.Color := clGreen;
                    end;
                  Bin_65:
                    begin
                      Canvas.Brush.Color := RGB(60, 0, 0);
                    end;
                  Bin_80:
                    begin
                      Canvas.Brush.Color := RGB(60, 77, 32);
                    end;
                  Bin_81:
                    begin
                      Canvas.Brush.Color := RGB(90, 123, 88);
                    end;
                  Bin_96:
                    begin
                      Canvas.Brush.Color := RGB(22, 88, 254);
                    end;

                  Bin_128:
                    begin
                      Canvas.Brush.Color := RGB(255, 255, 255);
                    end;

                end;
                // MMadd('x='+IntToStr(XIndexPosArr[i*j-1])+' y='+IntToStr(yIndexPosArr[i*j-1])+' bin='+IntToStr(BinArr[i*j-1]));
                Canvas.Rectangle(Rect((n - 1) * MapSize, (m - 1) * MapSize, n * MapSize, m * MapSize));

                // img1.Refresh;
              end;

            end;
          end;

          for I := MinNY to MaxNY do
          begin
            for j := MinNX to MaxNX do
            begin
              PosCount := (I - 1) * XColumns + j;
              // MMadd(IntToStr(PosCount));
              // MMadd('x=' + IntToStr(j) + ' y=' + IntToStr(i));
              SelCountTemp := SelCountTemp + 1;
              with img1.Canvas do
              begin
                Pen.Color := clGray;
                Brush.Color := clGray;
                Ellipse((j - 1) * MapSize + 1, (I - 1) * MapSize + 1, j * MapSize - 1, I * MapSize - 1);
              end;
              img1.Refresh;
            end;

          end;
          LastMinX := MinNX;
          LastMinY := MinNY;
          LastMaxX := MaxNX;
          LastMaxY := MaxNY;

          MMadd('当前选择Chip数量为：' + IntToStr(SelCountTemp));
        end
        else
        begin

          with img1.Canvas do
          begin
            Pen.Color := clGray;
            Brush.Color := clGray;
            Ellipse((MapX - 1) * MapSize + 1, (MapY - 1) * MapSize + 1, MapX * MapSize - 1, MapY * MapSize - 1);
            BrushBinArr[(MapY - 1) * XColumns + MapX - 1] := 1;
          end;
          img1.Refresh;

        end;

      end;
    end;
  end;

end;

procedure TForm1.MyMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  MapX, MapY, DataXPos, DataYPos: Integer;
  SelArr: array of Integer;
  I, j: Integer;
  PosCount: Integer;
  SelCount: Integer;
  EditCount: Integer;
  MinNX, MaxNX, MinNY, MaxNY: Integer;
begin
  if SelDown then
  begin
    if Edit3.Text = '' then
    begin
      MMadd('请选择编辑模式进行编辑。');
      SelDown := False;
    end
    else
    begin
      if not BrushMode then
      begin
        PosCount := 0;
        SelCount := 0;
        EditCount := 0;
        MinNX := 0;
        MaxNX := 0;
        MinNY := 0;
        MaxNY := 0;
        SetLength(SelArr, XColumns * YRows - 1);
        MapX := X div MapSize + 1;
        MapY := Y div MapSize + 1;
        if MapX - 1 >= XColumns then
        begin
          MapX := XColumns; // + 1;
        end;
        if MapY - 1 >= YRows then
        begin
          MapY := YRows; // + 1;
        end;

        with img1.Canvas do
        begin
          if Edit3.Text <> '' then
          begin
            if SelDown then
            begin

              SelEdPosX := MapX;
              SelEdPosY := MapY;

              // MMadd('seledposx:' + IntToStr(SelEdPosX));
              // MMadd('seledposy:' + IntToStr(SelEdPosY));

              if SelStPosX >= SelEdPosX then
              begin
                MinNX := SelEdPosX;
                MaxNX := SelStPosX;
              end
              else
              begin
                MinNX := SelStPosX;
                MaxNX := SelEdPosX;

              end;

              if SelStPosY >= SelEdPosY then
              begin
                MinNY := SelEdPosY;
                MaxNY := SelStPosY;
              end
              else
              begin
                MinNY := SelStPosY;
                MaxNY := SelEdPosY;

              end;
              // MMadd('MinNX: ' + IntToStr(MinNX));
              // MMadd('MaxNX: ' + IntToStr(MaxNX));
              // MMadd('MaxNY: ' + IntToStr(MaxNY));
              // MMadd('MinNY: ' + IntToStr(MinNY));

              for I := MinNY to MaxNY do
              begin
                // MMadd(IntToStr(i));
                for j := MinNX to MaxNX do
                begin
                  // MMadd(IntToStr(j));
                  PosCount := (I - 1) * XColumns + j;
                  // MMadd('poscount:' + IntToStr(PosCount));
                  SelCount := SelCount + 1;
                  if Edit3.Text = 'M' then
                  begin

                    if (BinArr[PosCount - 1] <> 2) and (BinArr[PosCount - 1] <> 128) then
                    begin
                      // MMadd('oldbin:' + IntToStr(BinArr[PosCount - 1]));
                      BinArr[PosCount - 1] := 128;
                      // MMadd('newbin:' + IntToStr(BinArr[PosCount - 1]));
                      EditCount := EditCount + 1;
                    end;

                  end
                  else
                  begin
                    if Edit3.Text = 'S' then
                    begin
                      if (BinArr[PosCount - 1] <> 2) and (BinArr[PosCount - 1] <> 0) then
                      begin
                        // MMadd('oldbin:' + IntToStr(BinArr[PosCount - 1]));
                        BinArr[PosCount - 1] := 0;
                        // MMadd('newbin:' + IntToStr(BinArr[PosCount - 1]));
                        EditCount := EditCount + 1;
                      end;
                    end
                    else
                    begin
                      if Edit3.Text = 'N' then
                      begin
                        if (BinArr[PosCount - 1] <> 2) and (BinArr[PosCount - 1] <> 64) then
                        begin
                          // MMadd('oldbin:' + IntToStr(BinArr[PosCount - 1]));
                          BinArr[PosCount - 1] := 64;
                          // MMadd('newbin:' + IntToStr(BinArr[PosCount - 1]));
                          EditCount := EditCount + 1;
                        end;
                      end;
                    end;
                  end;

                end;
              end;

              DrawMap;
              MMadd('已选择颗数: ' + IntToStr(SelCount));
              MMadd('已编辑颗数: ' + IntToStr(EditCount));

            end;
          end;
          SelDown := False;

        end;
      end
      else
      begin
        for I := 0 to XColumns * YRows - 1 do
        begin
          if BrushBinArr[I] = 1 then
          begin
            if Edit3.Text = 'M' then
            begin

              if (BinArr[I] <> 2) and (BinArr[I] <> 128) then
              begin
                BinArr[I] := 128;
                EditCount := EditCount + 1;
              end;

            end
            else
            begin
              if Edit3.Text = 'S' then
              begin
                if (BinArr[I] <> 2) and (BinArr[I] <> 0) then
                begin
                  BinArr[I] := 0;
                  EditCount := EditCount + 1;
                end;
              end
              else
              begin
                if Edit3.Text = 'N' then
                begin
                  if (BinArr[I] <> 2) and (BinArr[I] <> 64) then
                  begin
                    BinArr[I] := 64;
                    EditCount := EditCount + 1;
                  end;
                end;
              end;
            end;
          end;
        end;
        DrawMap;
        MMadd('已编辑颗数: ' + IntToStr(EditCount));
        SelDown := False;
      end;
    end;

    {
      if Button = mbLeft then
      begin
      Pen.Color := clWhite;
      Brush.Color := clWhite;
      Ellipse(MapX * MapSize - MapSize div 2 - MapSize div 3, MapY * MapSize - MapSize div 2 - MapSize div 3, MapX * MapSize - MapSize div 2 + MapSize div 3, MapY * MapSize - MapSize div 2 + MapSize div 3);
      end
      else
      begin
      if Button = mbRight then
      begin
      Pen.Color := clRed;
      Brush.Color := clRed;
      Ellipse(MapX * MapSize - MapSize div 2 - MapSize div 3, MapY * MapSize - MapSize div 2 - MapSize div 3, MapX * MapSize - MapSize div 2 + MapSize div 3, MapY * MapSize - MapSize div 2 + MapSize div 3);

      end;
      end;
    }

  end;

end;

procedure TForm1.N4Click(Sender: TObject);
begin
  if not Form5.Visible then
  begin
    Form5.Position := poScreenCenter;
    Form5.Show;
  end;

end;

procedure TForm1.N5Click(Sender: TObject);
var
  LBuffer: TBytes;
  Buf: Byte;
  BackPath: string;
  FileNameTemp: PChar;
begin
  if Pathstr <> '' then
  begin
    BackPath := ExtractFileDir(ParamStr(0)) + '\Back\';
    if not DirectoryExists(BackPath) then
    begin
      CreateDir(BackPath);
    end;
    FileNameTemp := PChar(BackPath + TskFileName + '-' + FormatDateTime('yyyymmddhhnnss', Now));
    if CopyFile(PChar(Pathstr), FileNameTemp, True) then
    begin
      MMadd('文件备份成功。');
      MMadd('路径: ' + #13#10 + ExtractFileDir(ParamStr(0)) + '\Back\' + FileNameTemp);
      SaveTSKMapFile;
    end
    else
    begin
      if MessageDlg('文件未备份成功，请确认是否继续？', TMsgDlgType.mtWarning, [mbYes, mbNo], 0) = mrYes then
      begin
        SaveTSKMapFile;
      end;
    end;

  end;
end;

procedure TForm1.NBBtnClick(Sender: TObject);
begin
  with img1.Canvas do
  begin
    Brush.Color := clWhite;
    FillRect(ClipRect);
  end;
  MapSize := NBSize;

  DrawMap;
end;

procedure TForm1.SaveBtnClick(Sender: TObject);
//var
//  MyStream: TFileStream;
//  I: Integer;
//  LBuffer: TBytes;
//  Buf: Byte;
//  BackPath: string;
begin
//  if Pathstr <> '' then
//  begin
//    BackPath := ExtractFileDir(ParamStr(0)) + '\Back\';
//    if not DirectoryExists(BackPath) then
//    begin
//      CreateDir(BackPath);
//    end;
//
//    CopyFile(PChar(Pathstr), PChar(BackPath + TskFileName + '-' + FormatDateTime('yyyymmddhhnnss', Now)), True);
//    MMadd('文件备份成功。');
//    MMadd('路径: ' + #13#10 + ExtractFileDir(ParamStr(0)) + '\Back\');
//    MyStream := TFileStream.Create(Pathstr, fmOpenWrite or fmShareExclusive);
//    with MyStream do
//    begin
//      Position := 2;
//      for I := 0 to High(BinArr) do
//      begin
//        Buf := BinArr[I];
//        Write(Buf, 1);
//        Seek(3, soFromCurrent);
//      end;
//    end;
//    MyStream.Free;
//    MMadd('文件保存成功。');

//  end;

  // DlgSave1 := TOpenDialog.Create(nil);
  // try
  // DlgSave1.Title:='文件保存路径';
  // DlgSave1.Filter := 'TSK File(*.MTX)|*.MTX';
  // DlgSave1.DefaultExt := '*.MTX';
  // if DlgSave1.Execute then
  // begin
  // MyStream := TFileStream.Create(Pathstr, fmOpenWrite or fmShareExclusive);
  // with MyStream do
  // begin
  // Position := 2;
  // for i := 0 to High(BinArr) do
  // begin
  // Buf := BinArr[i];
  // Write(Buf, 1);
  // Seek(3, soFromCurrent);
  //
  // end;
  // end;
  // MyStream.Free;
  //
  // end;
  // finally
  // FreeAndNil(DlgSave1);
  // end;

end;

procedure TForm1.SBtnClick(Sender: TObject);
begin
  with img1.Canvas do
  begin
    Brush.Color := clWhite;
    FillRect(ClipRect);
  end;
  MapSize := SSize;
  DrawMap;
end;

procedure TForm1.scrlbx1MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if WheelDelta < 0 then
  begin
    if GetAsyncKeyState(VK_CONTROL) < 0 then
    begin
      scrlbx1.Perform(WM_HSCROLL, SB_LEFT, 0);
    end
    else
    begin
      scrlbx1.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
    end;

  end
  else
  begin
    if GetAsyncKeyState(VK_CONTROL) < 0 then
    begin
      scrlbx1.Perform(WM_HSCROLL, SB_RIGHT, 0);
    end
    else
    begin
      scrlbx1.Perform(WM_VSCROLL, SB_LINEUP, 0);
    end;

  end;

end;

procedure TForm1.mniN7Click(Sender: TObject);
begin
  if not Form14.Showing then
  begin
    Form14.Show;
  end;
end;

procedure TForm1.mniTSKSampleClick(Sender: TObject);
begin
  mniTSKSample.Checked := not mniTSKSample.Checked;
end;

procedure TForm1.XLBtnClick(Sender: TObject);
begin
  try
    with img1.Canvas do
    begin
      Brush.Color := clWhite;
      FillRect(ClipRect);
    end;
    MapSize := XLSize;
    DrawMap;
  except
    ShowMessage('系统内存不足。');
  end;
end;

procedure TForm1.XLS1Click(Sender: TObject);
begin
  if not Form12.Showing then
  begin
    Form12.Show;
  end;
end;

procedure TForm1.XXLBtnClick(Sender: TObject);
begin
  try
    with img1.Canvas do
    begin
      Brush.Color := clWhite;
      FillRect(ClipRect);
    end;
    MapSize := XXLSize;
    DrawMap;
  except
    ShowMessage('系统内存不足。');
  end;
end;

procedure TForm1.ButtonGroup1Items0Click(Sender: TObject);
begin
  Edit3.Text := Trim(ButtonGroup1.Items[0].Caption);
end;

procedure TForm1.ButtonGroup1Items1Click(Sender: TObject);
begin
  Edit3.Text := Trim(ButtonGroup1.Items[1].Caption);
end;

procedure TForm1.ButtonGroup1Items2Click(Sender: TObject);
begin
  Edit3.Text := Trim(ButtonGroup1.Items[2].Caption);
end;

procedure TForm1.ConfigIni;
begin
  if not DirectoryExists(ExtractFilePath(ParamStr(0)) + '\Config') then
  begin
    CreateDir(ExtractFilePath(ParamStr(0)) + '\Config');
  end;
end;

procedure TForm1.SaveTSKMapFile;
var
  MyStream: TFileStream;
  Buf80: Byte;
  I: Integer;
begin
  MyStream := TFileStream.Create(Pathstr, fmOpenWrite or fmShareExclusive);
  with MyStream do
  begin
    Position := 2;
    if mniTSKSample.Checked then
    begin
      MMadd('Test已转换为Simple标记，如不需要请取消TSKSample勾选。');
      Buf80 := Byte(80);
      for I := 0 to High(BinArr) do
      begin
        if BinArr[I] = Bin_64 then
        begin
          Write(Buf80, 1);
        end
        else
        begin
          Write(BinArr[I], 1);
        end;
        Seek(3, soFromCurrent);
      end;
    end
    else
    begin
      for I := 0 to High(BinArr) do
      begin
        //Buf := BinArr[I];
        Write(BinArr[I], 1);
        Seek(3, soFromCurrent);
      end;
    end;
  end;
  MyStream.Free;
  MMadd('文件修改成功。');
end;

procedure TForm1.CPSPEC1Click(Sender: TObject);
begin
  ShowMessage('请在程序路径Limit文件夹放入相同批次数据。');
  Form10.Show;
end;

procedure TForm1.Dat1Click(Sender: TObject);
begin
  Form8.Show;
end;

procedure TForm1.DrawMap;
var
  I, j: Integer;
  // MapX, MapY: Integer;
  // ReadedCount: Integer;
  // DrawedRows: Integer;
  // DrawedColumns: Integer;
  XYIndex: Integer;
  LastScrPosV, LastScrPosH: Integer;
  CountBin64: Integer;
begin
  CountBin64 := 0;
  LastScrPosV := scrlbx1.VertScrollBar.Position;
  LastScrPosH := scrlbx1.HorzScrollBar.Position;
  scrlbx1.HorzScrollBar.Position := 0;
  scrlbx1.VertScrollBar.Position := 0;
  if img1 = nil then
  begin
    img1 := TImage.Create(scrlbx1);
    img1.Parent := scrlbx1;
    img1.Left := 0;
    img1.Top := 0;
    img1.Width := MapSize * XColumns;
    img1.height := MapSize * YRows;

    img1.OnMouseMove := MyMouseMove;
    img1.OnMouseLeave := MyMouseLeave;
    img1.OnMouseUp := MyMouseUp;
    img1.OnMouseDown := MyMouseDown;
    img1.Parent.DoubleBuffered := True;
  end
  else
  begin
    img1.Free;
    img1 := TImage.Create(scrlbx1);
    img1.Parent := scrlbx1;
    img1.Left := 0;
    img1.Top := 0;
    img1.Width := MapSize * XColumns;
    img1.height := MapSize * YRows;

    img1.OnMouseMove := MyMouseMove;
    img1.OnMouseLeave := MyMouseLeave;
    img1.OnMouseUp := MyMouseUp;
    img1.OnMouseDown := MyMouseDown;
    img1.Parent.DoubleBuffered := True;
  end;
  {
    if GraImg = nil then
    begin
    GraImg := TImage.Create(scrlbx1);
    GraImg.Parent := scrlbx1;
    GraImg.Left := 0;
    GraImg.Top := 0;
    GraImg.Width := img1.Width;
    GraImg.Height := img1.Height;
    GraImg.OnMouseDown := My2MouseDown;
    GraImg.OnMouseMove := My2MouseMove;
    GraImg.OnMouseUp:=My2MouseUp;
    GraImg.Transparent := True;

    end
    else
    begin
    GraImg.Free;
    GraImg := TImage.Create(scrlbx1);
    GraImg.Parent := scrlbx1;
    GraImg.Left := 0;
    GraImg.Top := 0;
    GraImg.Width := img1.Width;
    GraImg.Height := img1.Height;
    GraImg.OnMouseDown := My2MouseDown;
    GraImg.OnMouseMove := My2MouseMove;
    GraImg.OnMouseUp:=My2MouseUp;
    GraImg.Transparent := True;
    end;
  }
  // img1.Width := MapSize * XColumns;
  // img1.Height := MapSize * YRows;
  // img1.Width := 3000;
  // img1.height := 3000;

  img1.Canvas.Pen.Color := clBlack;

  // MapX := 0;
  // MapY := 0;
  // ReadedCount := 0;
  // DrawedRows := 0;
  // DrawedColumns := 0;
  XYIndex := 0;
  MMadd('开始绘制..');
  with img1 do
  begin

    MMadd('Mapsize=' + IntToStr(MapSize));
    for I := 0 to YRows - 1 do
    begin
      for j := 0 to XColumns - 1 do
      begin
        XYIndex := I * XColumns + j;
        case BinArr[XYIndex] of
          Bin_0:
            begin
              Canvas.Brush.Color := clBlue;
            end;
          Bin_1:
            begin
              Canvas.Brush.Color := RGB(150, 99, 57);
            end;
          Bin_2:
            begin
              Canvas.Brush.Color := clRed;
            end;
          Bin_3:
            begin
              Canvas.Brush.Color := clNavy;
            end;
          Bin_4:
            begin
              Canvas.Brush.Color := clSilver;
            end;
          Bin_6:
            begin
              Canvas.Brush.Color := clGray;
            end;
          Bin_8:
            begin
              Canvas.Brush.Color := RGB(39, 65, 199);
            end;
          Bin_10:
            begin
              Canvas.Brush.Color := RGB(125, 25, 105);
            end;
          Bin_11:
            begin
              Canvas.Brush.Color := RGB(200, 50, 77);
            end;
          Bin_14:
            begin
              Canvas.Brush.Color := RGB(125, 0, 0);
            end;

          Bin_64:
            begin
              Canvas.Brush.Color := clGreen;
            end;
          Bin_65:
            begin
              Canvas.Brush.Color := RGB(60, 0, 0);
            end;
          Bin_80:
            begin
              Canvas.Brush.Color := RGB(60, 77, 32);
            end;
          Bin_81:
            begin
              Canvas.Brush.Color := RGB(90, 123, 88);
            end;
          Bin_96:
            begin
              Canvas.Brush.Color := RGB(22, 88, 254);
            end;

          Bin_128:
            begin
              Canvas.Brush.Color := RGB(255, 255, 255);
            end;

        end;
        // MMadd('x='+IntToStr(XIndexPosArr[i*j-1])+' y='+IntToStr(yIndexPosArr[i*j-1])+' bin='+IntToStr(BinArr[i*j-1]));
        Canvas.Rectangle(Rect(j * MapSize, I * MapSize, (j + 1) * MapSize, (I + 1) * MapSize));
        // MMadd(IntToStr(j * MapSize) + ',' + IntToStr(i * MapSize) + ',' + IntToStr((j + 1) * MapSize) + ',' + IntToStr((i + 1) * MapSize));

      end;

    end;

  end;
  scrlbx1.VertScrollBar.Position := LastScrPosV;
  scrlbx1.HorzScrollBar.Position := LastScrPosH;
  MMadd('绘制完成..');
  for I := 0 to High(BinArr) do
  begin
    if BinArr[I] = 64 then
    begin
      CountBin64 := CountBin64 + 1;
    end;

  end;
  MMadd('Bin64(测试颗数): ' + IntToStr(CountBin64));

end;

end.

