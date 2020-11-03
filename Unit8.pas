unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, System.Math;

type
  MyByte255 = array[0..255] of Byte;

type
  TForm8 = class(TForm)
    mmo1: TMemo;
    btn1: TButton;
    btn2: TButton;
    mmo2: TMemo;
    btn3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function CombineStr(Byte: MyByte255; DataLength: Integer): string;
    function CombineInteger(Byte: MyByte255; DataLength: Integer): Integer;
  end;

  WaferDatData = record
    FileName: string;
    LotNO: string;
    WaferID: string;
    WaferSize: Integer;
    FlatDirection: Integer;
    Columns: Integer;
    Rows: Integer;
    FailedDies: Integer;
    XIndex: string;
    YIndex: string;
  end;
//  WaferDatDatas=array of WaferDatData;
//  WaferInformation=class
//    List:WaferDatDatas;
//  end;

var
  Form8: TForm8;
  WaferDatInfo: WaferDatData;

implementation

{$R *.dfm}

procedure TForm8.btn1Click(Sender: TObject);
var
  Path: string;
  Fs: TFileStream;
  Byte255: MyByte255;
  I: Integer;
  Str: string;
  Temp: Integer;
  FloatTemp: Single;
begin
  Path := 'D:\PZD01597\MAP_0001.DAT';
  Fs := TFileStream.Create(Path, fmOpenRead or fmShareExclusive);
  with Fs do
  begin
    Position := 0;
    Seek(20, soFromCurrent);
    Read(Byte255, 16);
    WaferDatInfo.FileName := CombineStr(Byte255, 16);
    Read(Byte255, 2);
    Temp := CombineInteger(Byte255, 2);
    if Temp <= 120 then
    begin
      WaferDatInfo.WaferSize := Temp div 10;
    end
    else
    begin
      if Temp > 120 then
      begin
        WaferDatInfo.WaferSize := Temp div 25;
      end;
    end;
    Seek(2, soFromCurrent);
    Read(Byte255, 4);
    FloatTemp := CombineInteger(Byte255, 4) / 100000;
    WaferDatInfo.XIndex := FormatFloat('0.000', FloatTemp);
    Read(Byte255, 4);
    FloatTemp := CombineInteger(Byte255, 4) / 100000;
    WaferDatInfo.YIndex := FormatFloat('0.000', FloatTemp);
    Read(Byte255, 2);
    WaferDatInfo.FlatDirection := CombineInteger(Byte255, 2);
    Seek(2, soFromCurrent);
    Read(Byte255, 2);
    WaferDatInfo.Columns := CombineInteger(Byte255, 2);
    Read(Byte255, 2);
    WaferDatInfo.Rows := CombineInteger(Byte255, 2);
    Seek(4, soFromCurrent);
    Read(Byte255, 21);
    WaferDatInfo.WaferID := CombineStr(Byte255, 21);
    Read(Byte255, 18);
    WaferDatInfo.LotNO := CombineStr(Byte255, 18);
    Position := 214;
    Read(Byte255, 2);
    WaferDatInfo.FailedDies := CombineInteger(Byte255, 2);
  end;

  Fs.Free;

end;

function TForm8.CombineInteger(Byte: MyByte255; DataLength: Integer): Integer;
var
  i: Integer;
  Temp: Integer;
begin
  Result := -1;
  if DataLength <= 256 then
  begin
    for i := 0 to DataLength - 1 do
    begin
      Temp := Temp + Byte[i] * Trunc(Power(256, DataLength - 1 - i));
    end;
    Result := Temp;
  end
  else
  begin
    Result := -1;
  end;

end;

function TForm8.CombineStr(Byte: MyByte255; DataLength: Integer): string;
var
  i: Integer;
  Str: string;
begin
  Result := 'Error';
  if DataLength <= 256 then
  begin
    for i := 0 to DataLength - 1 do
    begin
      Str := Str + Char(Byte[i]);
    end;
    Result := Trim(Str);
  end
  else
  begin
    Result := 'Error';
  end;
end;

procedure TForm8.FormCreate(Sender: TObject);
begin
  mmo2.Lines.Clear;
end;

end.

