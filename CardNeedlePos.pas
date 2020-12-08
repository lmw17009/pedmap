unit CardNeedlePos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.ExtCtrls, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm17 = class(TForm)
    edtCardSize: TEdit;
    edtPadSize: TEdit;
    btnDraw: TButton;
    edtPosShow: TEdit;
    edtPadPos: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    mmo1: TMemo;
    btnCLear: TButton;
    imgScale: TImage;
    trckbr1: TTrackBar;
    edtNeedleSize: TEdit;
    rbDrawNeedle: TRadioButton;
    rbMeasure: TRadioButton;
    chkShowPos: TCheckBox;
    procedure btnDrawClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCLearClick(Sender: TObject);
    procedure trckbr1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MyMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MyMouseLeave(Sender: TObject);
    procedure MyMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  end;

var
  Form17: TForm17;
  ImgCard: TImage;
  CardX, CardY: Integer;
  PadSizeX, PadSizeY: Integer;
  PadPosX, PadPosY: Integer;
  MousePosX, MousePosY: Integer;
  Scale: Integer = 1;
  MeasureList: TStrings;

implementation

uses
  Global;
{$R *.dfm}

procedure TForm17.btnCLearClick(Sender: TObject);
begin
  mmo1.Lines.Clear;
end;

procedure TForm17.btnDrawClick(Sender: TObject);
var
  ArrTemp: TArray<string>;
begin
  if edtCardSize.Text <> '' then
  begin
    ArrTemp := Trim(edtCardSize.Text).Split(['.']);
    CardX := StrToInt(ArrTemp[0]) div Scale;
    CardY := StrToInt(ArrTemp[1]) div Scale;
  end;
  if CardX > 1000 then
  begin
    ShowMessage('PAD尺寸已经超过1000');
    Abort;
  end;
  if CardY > 1000 then
  begin
    ShowMessage('PAD尺寸已经超过1000');
    Abort;
  end;
  if edtPadSize.Text <> '' then
  begin
    ArrTemp := Trim(edtPadSize.Text).Split(['.']);
    PadSizeX := StrToInt(ArrTemp[0]) div Scale;
    PadSizeY := StrToInt(ArrTemp[1]) div Scale;
  end;
  if PadSizeX > 1000 then
  begin
    ShowMessage('G尺寸已经超过1000');
    Abort;
  end;
  if PadSizeY > 1000 then
  begin
    ShowMessage('G尺寸已经超过1000');
    Abort;
  end;

  if edtPadPos.Text <> '' then
  begin
    ArrTemp := Trim(edtPadPos.Text).Split(['.']);
    PadPosX := StrToInt(ArrTemp[0]) div Scale;
    PadPosY := StrToInt(ArrTemp[1]) div Scale;
  end;
  if PadPosX > 1000 then
  begin
    ShowMessage('偏移尺寸已经超过1000');
    Abort;
  end;
  if PadPosY > 1000 then
  begin
    ShowMessage('偏移尺寸已经超过1000');
    Abort;
  end;
  if ImgCard = nil then
  begin
    ImgCard := TImage.Create(Self);
    ImgCard.Parent := Form17;
    ImgCard.Width := 1000; // CardX div 20;
    ImgCard.Height := 1000; // CardY div 20;
    ImgCard.Left := 0;
    ImgCard.Top := 30;
    ImgCard.OnMouseMove := MyMouseMove;
    ImgCard.OnMouseLeave := MyMouseLeave;
    ImgCard.OnMouseUp := MyMouseUp;

  end
  else
  begin
    ImgCard.Free;
    ImgCard := TImage.Create(Self);
    ImgCard.Parent := Form17;
    ImgCard.Width := 1000; //CardX div 20 + 200;
    ImgCard.Height := 1000; //CardY div 20 + 200;
    ImgCard.Left := 0;
    ImgCard.Top := 30;
    ImgCard.OnMouseMove := MyMouseMove;
    ImgCard.OnMouseLeave := MyMouseLeave;
    ImgCard.OnMouseUp := MyMouseUp;
  end;
  with ImgCard.Canvas do
  begin
    Brush.Color := clGray;
    Pen.Color := clRed;
    FillRect(ImgCard.ClientRect);
    Rectangle(50, 50, CardX + 50, CardY + 50);
    Pen.Color := clBlack;
    Rectangle(50 + PadPosX, 50 + CardY - PadSizeY - PadPosY, 50 + PadPosX + PadSizeX, 50 + CardY - PadPosY);
  end;

end;

procedure TForm17.FormCreate(Sender: TObject);
begin
  mmo1.Lines.Clear;
  Self.Caption := 'CardNeedlePos' + SubVer_CardNeedlePos;
  MeasureList := TStringList.Create;
end;

procedure TForm17.FormDestroy(Sender: TObject);
begin
  MeasureList.Clear;
end;

procedure TForm17.MyMouseLeave(Sender: TObject);
begin
  edtPosShow.Text := '0/0';
end;

procedure TForm17.MyMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if ImgCard <> nil then
  begin
    edtPosShow.Text := IntToStr((X - 50) * Scale) + '/' + IntToStr((CardY - Y + 50) * Scale);
  end;

  imgScale.Refresh;
  StretchBlt(imgScale.Canvas.Handle, 0, 0, imgScale.Width, imgScale.height, ImgCard.Canvas.Handle, X - 20, Y - 20, 40, 40, SRCCOPY);

  with imgScale.Canvas do
  begin
    Brush.Color := clRed;
    Pen.Color := clYellow;
    Ellipse(48, 48, 52, 52);
  end;
  //  with imgScale.Canvas do
//  begin
//    Brush.Color := clLime;
//    Pen.Color := clBlue;
//    Canvas.Ellipse(45, 45, 55, 55);
//  end;
end;

procedure TForm17.MyMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  PosArr: TArray<string>;
  PosSt_X, PosSt_Y, PosEnd_X, PosEnd_Y: Integer;
  Distance: Integer;
begin
  mmo1.Lines.Add('点击位置=' + IntToStr((X - 50) * Scale) + '/' + IntToStr((CardY - Y + 50) * Scale));
  if rbDrawNeedle.Checked then
  begin
    with ImgCard.Canvas do
    begin
      Brush.Color := clGreen;
      Pen.Color := clWhite;
      Ellipse(X - StrToInt(edtNeedleSize.Text) div 2, Y - StrToInt(edtNeedleSize.Text) div 2, X + StrToInt(edtNeedleSize.Text) div 2, Y + StrToInt(edtNeedleSize.Text) div 2);
    end;
  end;
  if rbMeasure.Checked then
  begin
    with ImgCard.Canvas do
    begin
      Pixels[X, Y] := clWhite;
      //Brush.Color := clGreen;
      //Pen.Color := clWhite;
      //Ellipse(X - StrToInt(edtNeedleSize.Text) div 2, Y - StrToInt(edtNeedleSize.Text) div 2, X + StrToInt(edtNeedleSize.Text) div 2, Y + StrToInt(edtNeedleSize.Text) div 2);

      MeasureList.Add(IntToStr((X - 50) * Scale) + '/' + IntToStr((CardY - Y + 50) * Scale));
      if MeasureList.Count = 2 then
      begin
        PosArr := MeasureList[MeasureList.Count - 1].Split(['/']);
      //PosSt_X,PosSt_Y,PosEnd_X,PosEnd_Y:integer;
        PosEnd_X := StrToInt(PosArr[0]);
        PosEnd_Y := StrToInt(PosArr[1]);
        PosArr := MeasureList[MeasureList.Count - 2].Split(['/']);
        PosSt_X := StrToInt(PosArr[0]);
        PosSt_Y := StrToInt(PosArr[1]);
        Pen.Width := 1;
        Brush.Color := clGray;
        //Brush.Color := clGreen;
        Pen.Color := clWhite;
        if chkShowPos.Checked then
        begin
          TextOut((PosSt_X) div Scale + 50 - 10, CardY - (PosSt_Y) div Scale + 50 + 10, IntToStr(PosSt_X) + '/' + IntToStr(PosSt_Y));
        end;
        MoveTo((PosSt_X) div Scale + 50, CardY - (PosSt_Y) div Scale + 50);
        LineTo(X, Y);
        if chkShowPos.Checked then
        begin
          TextOut((PosEnd_X) div Scale + 50 + 10, CardY - (PosEnd_Y) div Scale + 50 + 10, IntToStr(PosEnd_X) + '/' + IntToStr(PosEnd_Y));
        end;
        Distance := 0;
        Distance := Round(Sqrt(Sqr(PosSt_X - PosEnd_X) + Sqr(PosSt_Y - PosEnd_Y)));
        mmo1.Lines.Add('最近二次点击的测量距离为=' + IntToStr(Distance));
        MeasureList.Clear;
      end;
    end;

  end;

end;

procedure TForm17.trckbr1Change(Sender: TObject);
begin
  edtNeedleSize.Text := trckbr1.Position.ToString;
end;

end.

