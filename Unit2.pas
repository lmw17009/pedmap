unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    TelXIndex: TEdit;
    TelYIndex: TEdit;
    lbl1: TLabel;
    Label1: TLabel;
    TelPPosX: TEdit;
    lbl2: TLabel;
    Label3: TLabel;
    TskPPosX: TEdit;
    LoadTelDataBtn: TButton;
    TelPPosY: TEdit;
    TskPPosY: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    ShiftX: TEdit;
    ShiftY: TEdit;
    lbl7: TLabel;
    procedure LoadTelDataBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form2: TForm2;

implementation

uses
  Unit1, Global;

{$R *.dfm}

procedure TForm2.LoadTelDataBtnClick(Sender: TObject);
var
  dlgopen1: TOpenDialog;
  str: string;
begin
//  if (TelXIndex.text = '') or (StrToInt(TelXIndex.Text) < 1) then
//  begin
//    ShowMessage(IntToStr(StrToInt(TelXIndex.Text)));
//    ShowMessage('TelMap��������');
//    Exit;
//  end;
//  if (TelYIndex.text = '') or (StrToInt(TelXIndex.Text) < 1) then
//  begin
//    ShowMessage('TelMap��������');
//
//    Exit;
//  end;
//  if (TelPPosX.text = '') or (StrToInt(TelXIndex.Text) < 1) then
//  begin
//    ShowMessage('TelP�����ݴ���');
//    Exit;
//  end;
//  if (TelPPosY.text = '') or (StrToInt(TelXIndex.Text) < 1) then
//  begin
//    ShowMessage('TelP�����ݴ���');
//    Exit;
//  end;
//  if (TskPPosX.text = '') or (StrToInt(TelXIndex.Text) < 1) then
//  begin
//    ShowMessage('TskP�����ݴ���');
//    Exit;
//  end;
//  if (TskPPosY.text = '') or (StrToInt(TelXIndex.Text) < 1) then
//  begin
//    ShowMessage('TskP�����ݴ���');
//    Exit;
//  end;
  try

    TelMapMaxColumn := StrToInt(TelXIndex.Text);
    TelMapMaxRow := StrToInt(TelYIndex.Text);
    TelMapPPosX := StrToInt(TelPPosX.Text);
    TelMapPPosY := StrToInt(TelPPosY.Text);
    TskMapPPosX := StrToInt(TskPPosX.Text);
    TskMapPPosY := StrToInt(TskPPosY.Text);
    ShiftXPos := StrToInt(ShiftX.Text);
    ShiftYPos := StrToInt(ShiftY.Text);

    if img1 <> nil then
    begin
      dlgopen1 := TOpenDialog.Create(nil);
      try
        dlgopen1.Filter := 'TEL Marking File(*.map)|*.map';
        dlgopen1.DefaultExt := '*.map';
        if dlgopen1.Execute then
        begin
          str := Trim(dlgopen1.FileName);
          LoadTelMkFile(str);
        end;
      finally
        FreeAndNil(dlgopen1);
      end;
    end
    else
    begin
      ShowMessage('�����TSK�ļ���');
    end;
    ShiftX.Text := '0';
    ShiftY.Text := '0';
  except
    ShowMessage('ת����������');

  end;
end;

end.

