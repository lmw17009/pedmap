unit CardSizeShow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Menus;

type
  TForm12 = class(TForm)
    scrlbx1: TScrollBox;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    edt6: TEdit;
    btnDraw: TButton;
    mmo1: TMemo;
    trckbr1: TTrackBar;
    btnClear: TButton;
    procedure btnDrawClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure trckbr1Change(Sender: TObject);
    procedure edt6Click(Sender: TObject);
    procedure edt5Click(Sender: TObject);
    procedure edt4Click(Sender: TObject);
    procedure edt3Click(Sender: TObject);
    procedure edt2Click(Sender: TObject);
    procedure edt1Click(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CardDraw;
    procedure AdjustSize(CardSizeArr, WArr, HArr: array of Integer);
  end;

var
  Form12: TForm12;
  divscale: Integer = 10;
  imgCardmap: TImage;

implementation

uses
  Global;
{$R *.dfm}

procedure TForm12.AdjustSize(CardSizeArr, WArr, HArr: array of Integer);
var
  FstMinValue, SecMinValue: Integer;
  CenterX, CenterY: Integer;
  i: Integer;
  LposX, LPosY, RPosX, RPosY: Integer;
  SameW, SameH: Integer;
begin
  for i := 0 to High(CardSizeArr) do
  begin
    if CardSizeArr[i] <> 0 then
    begin
      FstMinValue := CardSizeArr[i];
      SecMinValue := CardSizeArr[i + 1];
      Break;
    end;

  end;

  SameW := FstMinValue;
  SameH := SecMinValue;
  for i := 0 to 11 do
  begin
    CardSizeArr[i] := CardSizeArr[i] div divscale;
  end;

  for i := 0 to 5 do
  begin
    WArr[i] := WArr[i] div divscale;
    HArr[i] := HArr[i] div divscale;
  end;

  if CardSizeArr[11] > 700 then
  begin
    Self.Width := CardSizeArr[11] + 200;
    Self.Height := CardSizeArr[11] + 200;
  end
  else
  begin
    Self.Width := 800;
    Self.Height := 720;
  end;
  if imgCardmap = nil then
  begin
    imgCardmap := TImage.Create(scrlbx1);
    imgCardmap.Parent := scrlbx1;
    imgCardmap.Width := scrlbx1.Width - 5;
    imgCardmap.Height := scrlbx1.Height - 5;
    imgCardmap.Left := 0;
    imgCardmap.Top := 0;
  end
  else
  begin
    imgCardmap.Free;
    imgCardmap := TImage.Create(scrlbx1);
    imgCardmap.Parent := scrlbx1;
    imgCardmap.Width := scrlbx1.Width - 5;
    imgCardmap.Height := scrlbx1.Height - 5;
    imgCardmap.Left := 0;
    imgCardmap.Top := 0;
  end;

  CenterX := imgCardmap.Width div 2;
  CenterY := imgCardmap.Height div 2;
  //
  with imgCardmap.Canvas do
  begin
    Brush.Color := clBlack;
    FillRect(imgCardmap.ClientRect);
     //绘制相同的区域
    if FstMinValue >= SecMinValue then
    begin
      LposX := CenterX - FstMinValue div 2;
      LPosY := CenterY - SecMinValue div 2;
      RPosX := CenterX + FstMinValue div 2;
      RPosY := CenterY + SecMinValue div 2;
    end
    else
    begin
      LposX := CenterX - SecMinValue div 2;
      LPosY := CenterY - FstMinValue div 2;
      RPosX := CenterX + SecMinValue div 2;
      RPosY := CenterY + FstMinValue div 2;
    end;

    Brush.Color := clGray;
    Pen.Color := clLime;
    Rectangle(LposX, LPosY, RPosX, RPosY);
    if FstMinValue >= SecMinValue then
    begin
      TextOut(CenterX - 20, CenterY - 20, IntToStr(SameW) + 'X' + IntToStr(SameH));
    end
    else
    begin
      TextOut(CenterX - 20, CenterY - 20, IntToStr(SameW) + 'X' + IntToStr(SameH));
    end;

    for i := 0 to High(WArr) do
    begin
      if WArr[i] >= HArr[i] then
      begin
        LposX := CenterX - WArr[i] div 2;
        LPosY := CenterY - HArr[i] div 2;
        RPosX := CenterX + WArr[i] div 2;
        RPosY := CenterY + HArr[i] div 2;
      end
      else
      begin
        LposX := CenterX - HArr[i] div 2;
        LPosY := CenterY - WArr[i] div 2;
        RPosX := CenterX + HArr[i] div 2;
        RPosY := CenterY + WArr[i] div 2;
      end;

      case i of
        0:
          begin
            Pen.Color := clRed;
            Brush.Color := clRed;
            FillRect(Rect(48 + i * 100, 34, 68 + i * 100, 54));
          end;
        1:
          begin
            Pen.Color := clGreen;
            Brush.Color := clGreen;
            FillRect(Rect(48 + i * 100, 34, 68 + i * 100, 54));
          end;
        2:
          begin
            Pen.Color := clBlue;
            Brush.Color := clBlue;
            FillRect(Rect(48 + i * 100, 34, 68 + i * 100, 54));
          end;
        3:
          begin
            Pen.Color := clWhite;
            Brush.Color := clWhite;
            FillRect(Rect(48 + i * 100, 34, 68 + i * 100, 54));
          end;
        4:
          begin
            Pen.Color := clYellow;
            Brush.Color := clYellow;
            FillRect(Rect(48 + i * 100, 34, 68 + i * 100, 54));
          end;
        5:
          begin
            Pen.Color := clPurple;
            Brush.Color := clYellow;
            FillRect(Rect(48 + i * 100, 34, 68 + i * 100, 54));
          end;

      end;
      //DrawTengle(Rect(LposX, LPosY, RPosX, RPosY), clGray, clLime);
      MoveTo(LposX, LPosY);
      LineTo(LposX, RPosY);
      MoveTo(LposX, RPosY);
      LineTo(RPosX, RPosY);
      MoveTo(RPosX, RPosY);
      LineTo(RPosX, LPosY);
      MoveTo(RPosX, LPosY);
      LineTo(LposX, LPosY);

    end;
  end;

end;

procedure TForm12.btnClearClick(Sender: TObject);
begin
  edt1.Text := '';
  edt2.Text := '';
  edt3.Text := '';
  edt4.Text := '';
  edt5.Text := '';
  edt6.Text := '';
end;

procedure TForm12.btnDrawClick(Sender: TObject);
begin
  CardDraw;
end;

procedure TForm12.CardDraw;
var
  WArr, HArr: array[0..5] of Integer;
  CardNumber: array[0..11] of Integer;
  CardArr: TArray<string>;
  MinH, MinW: Integer;
  I, J: Integer;
  TempNum: Integer;
begin
  if edt1.Text <> '' then
  begin
    CardArr := Trim(edt1.Text).Split(['.']);
    WArr[0] := StrToInt(CardArr[0]);
    HArr[0] := StrToInt(CardArr[1]);
    CardNumber[0] := WArr[0];
    CardNumber[1] := HArr[0];
  end;
  if edt2.Text <> '' then
  begin
    CardArr := Trim(edt2.Text).Split(['.']);
    WArr[1] := StrToInt(CardArr[0]);
    HArr[1] := StrToInt(CardArr[1]);
    CardNumber[2] := WArr[1];
    CardNumber[3] := HArr[1];
  end;
  if edt3.Text <> '' then
  begin
    CardArr := Trim(edt3.Text).Split(['.']);
    WArr[2] := StrToInt(CardArr[0]);
    HArr[2] := StrToInt(CardArr[1]);
    CardNumber[4] := WArr[2];
    CardNumber[5] := HArr[2];
  end;
  if edt4.Text <> '' then
  begin
    CardArr := Trim(edt4.Text).Split(['.']);
    WArr[3] := StrToInt(CardArr[0]);
    HArr[3] := StrToInt(CardArr[1]);
    CardNumber[6] := WArr[3];
    CardNumber[7] := HArr[3];
  end;
  if edt5.Text <> '' then
  begin
    CardArr := Trim(edt5.Text).Split(['.']);
    WArr[4] := StrToInt(CardArr[0]);
    HArr[4] := StrToInt(CardArr[1]);
    CardNumber[8] := WArr[4];
    CardNumber[9] := HArr[4];
  end;
  if edt6.Text <> '' then
  begin
    CardArr := Trim(edt6.Text).Split(['.']);
    WArr[5] := StrToInt(CardArr[0]);
    HArr[5] := StrToInt(CardArr[1]);
    CardNumber[10] := WArr[5];
    CardNumber[11] := HArr[5];
  end;
  MinH := 99999;
  MinW := 99999;
  for I := 0 to High(HArr) do
  begin
    if (HArr[I] = 0) or (WArr[I] = 0) then
      Continue;
    if HArr[I] < MinH then
    begin
      MinH := HArr[I];
    end;
    if WArr[I] < MinW then
    begin
      MinH := WArr[I];
    end;
  end;
  TempNum := 0;
  for I := 0 to High(CardNumber) - 1 do
  begin
    for J := I to High(CardNumber) do
    begin
      if CardNumber[I] > CardNumber[J] then
      begin
        TempNum := CardNumber[I];
        CardNumber[I] := CardNumber[J];
        CardNumber[J] := TempNum;
      end;
    end;
  end;
  AdjustSize(CardNumber, WArr, HArr);
end;

procedure TForm12.edt1Click(Sender: TObject);
begin
  edt1.Text := '';
end;

procedure TForm12.edt2Click(Sender: TObject);
begin
  edt2.Text := '';
end;

procedure TForm12.edt3Click(Sender: TObject);
begin
  edt3.Text := '';
end;

procedure TForm12.edt4Click(Sender: TObject);
begin
  edt4.Text := '';
end;

procedure TForm12.edt5Click(Sender: TObject);
begin
  edt5.Text := '';
end;

procedure TForm12.edt6Click(Sender: TObject);
begin
  edt6.Text := '';
end;

procedure TForm12.FormCreate(Sender: TObject);
begin
  mmo1.Lines.Clear;
  Self.Caption := 'ProbeCardSize' + SubVer_CardNeedlePos;
end;

procedure TForm12.trckbr1Change(Sender: TObject);
begin
  divscale := trckbr1.Position;
end;

end.

