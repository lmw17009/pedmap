unit WatLimitEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

const
  Leng_0 = 25;
  leng_1_7 = 12;
  leng_8 = 14;
  leng_9 = 7;
  leng_10 = 10;

type
  TWatEdit = class(TForm)
    edt1: TEdit;
    procedure edt1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    function EdtLvItem: Boolean;
    function StrLengthJudge(Index: Integer; out StringLength: Integer; out Str: string): Boolean;
    function InsertBlank(Index: Integer; Str: string): string;
  end;

var
  WatEdit: TWatEdit;
  StrLg: Integer;
  StrAddBlank: string;

implementation

{$R *.dfm}
uses
  WatLimit;

procedure TWatEdit.edt1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    EdtLvItem;
    Self.Hide;
    edt1.Text := '';

  end;
  if Key = VK_ESCAPE then
  begin
    Self.Hide;
    edt1.Text := '';
  end;

end;

function TWatEdit.EdtLvItem: Boolean;
var
  X, Y, ColWid: Integer;
  XScroPos: Integer;
  Pos: TPoint;
  ItemCount: Integer;
  I: Integer;
  MouseCurIndex: Integer;
begin
  with WatLimitMain do
  begin
    Result := False;
    Pos := lv1.ScreenToClient(MousePos);
    ItemCount := lv1.Columns.Count;
    if ItemCount = 0 then
      Exit;
    XScroPos := GetScrollPos(lv1.Handle, SB_HORZ);
    for I := 0 to ItemCount - 1 do
    begin
      ColWid := lv1.Column[I].Width;
      if Pos.X <= XScroPos + ColWid then
      begin
        Break;
      end;
      XScroPos := XScroPos + ColWid;
    end;
    MouseCurIndex := I;
    if MouseCurIndex = ItemCount then
      Exit;
    if not StrLengthJudge(MouseCurIndex, StrLg, StrAddBlank) then
    begin
      ShowMessage('数据长度超过了' + IntToStr(StrLg) + '!');
      Exit;
    end;
    if MouseCurIndex = 0 then
    begin
      lv1.Selected.Caption := StrAddBlank;
      Result := True;
    end
    else
    begin
      lv1.Selected.SubItems[MouseCurIndex - 1] := StrAddBlank;
      Result := True;
    end;
  end;
end;

function TWatEdit.InsertBlank(Index: Integer; Str: string): string;
begin

end;

function TWatEdit.StrLengthJudge(Index: Integer; out StringLength: Integer; out Str: string): Boolean;
var
  StrLength: Integer;
  TempBlank, TempBlank1: string;
  I, j: Integer;
  SelRow: Integer;
begin
  StrLength := Length(edt1.Text);
  Result := True;
  TempBlank := '';
  SelRow := WatLimitMain.lv1.Selected.Index;
  case Index of
    0:
      begin
        if StrLength > Leng_0 then
        begin
          StringLength := Leng_0;
          Result := False;
        end
        else
        begin
          for j := 0 to 3 - Length(IntToStr(SelRow)) do
          begin
            TempBlank1 := TempBlank1 + ' ';
          end;
          for I := 0 to Leng_0 - 1 - StrLength do
          begin
            TempBlank := TempBlank + ' ';
          end;
          Str := TempBlank1 + IntToStr(SelRow+1) + '  ' + edt1.Text + TempBlank;
        end;
      end;
    8:
      begin
        if StrLength > leng_8 then
        begin
          StringLength := leng_8;
          Result := False;
        end
        else
        begin
          for I := 0 to leng_8 - 1 - StrLength do
          begin
            TempBlank := TempBlank + ' ';
          end;
          Str := edt1.Text + TempBlank;
        end;
      end;
    9:
      begin
        if StrLength > leng_9 then
        begin
          StringLength := leng_9;
          Result := False;
        end
        else
        begin
          for I := 0 to leng_9 - 1 - StrLength do
          begin
            TempBlank := TempBlank + ' ';
          end;
          Str := edt1.Text + TempBlank;
        end;
      end;
    10:
      begin
        if StrLength > leng_10 then
        begin
          StringLength := leng_10;
          Result := False;
        end
        else
        begin
          for I := 0 to leng_10 - 1 - StrLength do
          begin
            TempBlank := TempBlank + ' ';
          end;
          Str := edt1.Text + TempBlank;
        end;
      end
  else
    begin
      if StrLength > leng_1_7 then
      begin
        StringLength := leng_1_7;
        Result := False;
      end
      else
      begin
        for I := 0 to leng_1_7 - 1 - StrLength do
        begin
          TempBlank := TempBlank + ' ';
        end;
        Str := edt1.Text + TempBlank;
      end;
    end;

  end;
end;

end.

