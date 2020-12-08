unit MapCreate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm15 = class(TForm)
    edtChipX: TEdit;
    edtChipY: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    btn1: TButton;
    grp1: TGroupBox;
    scrlbx1: TScrollBox;
    rb1: TRadioButton;
    rb2: TRadioButton;
    rb3: TRadioButton;
    rb4: TRadioButton;
    trckbr1: TTrackBar;
    mmo1: TMemo;
    procedure btn1Click(Sender: TObject);
    procedure trckbr1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure CreateMap;
    { Private declarations }
  public
    { Public declarations }
    procedure IndexCount(XSize, YSize: Integer; out XCount, YCount: Integer); //use chip size cul indexcount
    procedure CircleStPos(R: Integer; out PosX, PosY: Integer; out Dir: Integer);
    procedure MMAdd(Log: string);
  end;

var
  Form15: TForm15;
  ImgCreate: TImage;

implementation

uses
  Unit1, Global;
{$R *.dfm}

procedure TForm15.btn1Click(Sender: TObject);
begin
  mmo1.Lines.Clear;
  CreateMap;
end;

procedure TForm15.CircleStPos(R: Integer; out PosX, PosY: Integer; out Dir: Integer);
begin
  if rb1.Checked then
  begin
    PosX := ImgCreate.Width div 2;
    PosY := ImgCreate.Height div 2 - R;
    Dir := Dir_0;
    Exit;
  end;
  if rb2.Checked then
  begin
    PosX := ImgCreate.Width div 2 + R;
    PosY := ImgCreate.Height div 2;
    Dir := Dir_90;
    Exit;
  end;
  if rb3.Checked then
  begin
    PosX := ImgCreate.Width div 2;
    PosY := ImgCreate.Height div 2 + R;
    Dir := Dir_180;
    Exit;
  end;
  if rb4.Checked then
  begin
    PosX := ImgCreate.Width div 2 - R;
    PosY := ImgCreate.Height div 2;
    Dir := Dir_270;
    Exit;
  end;

end;

procedure TForm15.CreateMap;
var
  I: Integer;
  TempR: Integer;
  CircleXPos: Integer;
  CircleYPos: Integer;
  Radian: Double;
  a: Integer;
  b: Integer;
begin
  XChipSize := StrToInt(edtChipX.Text);
  YChipSize := StrToInt(edtChipY.Text);
  MMAdd('XChipSize=' + edtChipX.Text);
  MMAdd('YChipSize=' + edtChipY.Text);
  IndexCount(XChipSize, YChipSize, MapCreate_XCount, MapCreate_YCount);
  MMAdd('XIndexCount=' + IntToStr(MapCreate_XCount));
  MMAdd('YIndexCount=' + IntToStr(MapCreate_YCount));
  MMAdd('Start Create Map...');
  if ImgCreate = nil then
  begin
    ImgCreate := TImage.Create(scrlbx1);
    ImgCreate.Parent := scrlbx1;
    ImgCreate.Left := 0;
    ImgCreate.Top := 0;
    ImgCreate.Width := Round(XChipSize / MapCreateIndexSize) * MapCreate_XCount;
    //ImgCreate.Width := MapCreateIndexSize * MapCreate_XCount;
    //ImgCreate.height := ImgCreate.Width; // MapCreateIndexSize * MapCreate_YCount;
    ImgCreate.height := Round(YChipSize / MapCreateIndexSize) * MapCreate_YCount;
    //    ImgCreate.OnMouseMove := MyMouseMove;
    //    ImgCreate.OnMouseLeave := MyMouseLeave;
    //    ImgCreate.OnMouseUp := MyMouseUp;
    //    ImgCreate.OnMouseDown := MyMouseDown;
    ImgCreate.Parent.DoubleBuffered := True;
  end
  else
  begin
    ImgCreate.Free;
    ImgCreate := TImage.Create(scrlbx1);
    ImgCreate.Parent := scrlbx1;
    ImgCreate.Left := 0;
    ImgCreate.Top := 0;
    ImgCreate.Width := Round(XChipSize / MapCreateIndexSize) * MapCreate_XCount;
    //ImgCreate.Width := MapCreateIndexSize * MapCreate_XCount;
    //ImgCreate.height := ImgCreate.Width; // MapCreateIndexSize * MapCreate_YCount;
    ImgCreate.height := Round(YChipSize / MapCreateIndexSize) * MapCreate_YCount;
    //    ImgCreate.OnMouseMove := MyMouseMove;
    //    ImgCreate.OnMouseLeave := MyMouseLeave;
    //    ImgCreate.OnMouseUp := MyMouseUp;
    //    ImgCreate.OnMouseDown := MyMouseDown;
    ImgCreate.Parent.DoubleBuffered := True;
  end;
  MMAdd('ImgWidth=' + IntToStr(ImgCreate.Width));
  MMAdd('ImgHeight=' + IntToStr(ImgCreate.Height));
  MMAdd('Start Draw Map...');
  with ImgCreate.Canvas do
  begin
    //绘制方格
    MMAdd('Start Draw Block...');
    Brush.Color := clGray;
    FillRect(ImgCreate.ClientRect);
    Pen.Color := clBlack;
    Pen.Width := 2;
    Pen.Style := TPenStyle.psDash;
    for I := 0 to MapCreate_YCount do
    begin
      MoveTo(0, I * (ImgCreate.Height div MapCreate_YCount));
      LineTo(ImgCreate.Width, I * (ImgCreate.Height div MapCreate_YCount));
    end;

    for I := 0 to MapCreate_XCount do
    begin
      MoveTo(I * (ImgCreate.Width div MapCreate_XCount), 0);
      LineTo(I * (ImgCreate.Width div MapCreate_XCount), ImgCreate.Height);
    end;
    //绘制圆形
    Pen.Color := clBlack;
    Pen.Width := 1;
    Pen.Style := TPenStyle.psDash;
    //计算R

    TempR := Round(WaferR / MapCreateIndexSize);
    MMAdd('R=' + IntToStr(TempR));
    //TempR := Round(WaferSize * MapCreateIndexSize / (XChipSize * 2));
    CircleStPos(TempR, CircleXPos, CircleYPos, StDIr);
    //get wafer's direction
    MMAdd('Start Draw Circle...');
    MoveTo(CircleXPos, CircleYPos);
    Brush.Color := clLime;
    Ellipse(CircleXPos - 5, CircleYPos - 5, CircleXPos + 5, CircleYPos + 5);
    Brush.Color := clBlack;
    case StDIr of
      0:
        begin
          for I := 1 to 360 do
          begin
            Radian := I * (Pi / 180);
            a := CircleXPos - Round(Sin(Radian) * TempR);
            b := CircleYPos + Round((1 - Cos(Radian)) * TempR);
            LineTo(a, b);
            Application.ProcessMessages;
          end;
        end;
      1:
        begin
          for I := 1 to 360 do
          begin
            Radian := I * (Pi / 180);
            b := CircleYPos - Round(Sin(Radian) * TempR);
            a := CircleXPos - Round((1 - Cos(Radian)) * TempR);
            LineTo(a, b);
            Application.ProcessMessages;
          end;
        end;
      2:
        begin
          for I := 1 to 360 do
          begin
            Radian := I * (Pi / 180);
            a := CircleXPos + Round(Sin(Radian) * TempR);
            b := CircleYPos - Round((1 - Cos(Radian)) * TempR);
            LineTo(a, b);
            Application.ProcessMessages;
          end;
        end;
      3:
        begin
          for I := 1 to 360 do
          begin
            Radian := I * (Pi / 180);
            a := CircleXPos + Round((1 - Cos(Radian)) * TempR);
            b := CircleYPos + Round(Sin(Radian) * TempR);
            LineTo(a, b);
            Application.ProcessMessages;
          end;
        end;
    end;
  end;
  //开始数据填充核心工作
end;

procedure TForm15.FormCreate(Sender: TObject);
begin
  mmo1.Lines.Clear;
end;

procedure TForm15.IndexCount(XSize, YSize: Integer; out XCount, YCount: Integer);
var
  XValue, YValue: Integer;
begin
  //能否整除 奇数偶数
  XValue := WaferSize div XSize;
  if (WaferSize mod XSize = 0) then
  begin
    if Odd(XValue) then
    begin
      XCount := XValue + 4;
    end
    else
    begin
      XCount := XValue + 3;
    end;
  end
  else
  begin
    if Odd(XValue) then
    begin
      XCount := XValue + 4;
    end
    else
    begin
      XCount := XValue + 3;
    end;
  end;
  YValue := WaferSize div YSize;
  if (WaferSize mod YSize = 0) then
  begin
    if Odd(YValue) then
    begin
      YCount := YValue + 4;
    end
    else
    begin
      YCount := YValue + 3;
    end;
  end
  else
  begin
    if Odd(YValue) then
    begin
      YCount := YValue + 4;
    end
    else
    begin
      YCount := YValue + 3;
    end;
  end;

end;

procedure TForm15.MMAdd(Log: string);
begin
  mmo1.Lines.Add(Log);
end;

procedure TForm15.trckbr1Change(Sender: TObject);
begin
  MapCreateIndexSize := trckbr1.Position;
end;

end.

