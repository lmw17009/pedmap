unit JsonAdjust;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.JSON, XlsSetup;

type
  BarcodeJs = record
    PPID: string;
    LotID: string;
    WaferNumber: string;
    UserID: string;
    EqID: string;
    ProberID: string;
    TesterID: string;
    CardName: string;
  end;

function JsonAdj(JSBarcodeStr: string; out JSBack: BarcodeJs): Boolean;

function JsonXlsParam2Str(TempParam: XlsParam): string;

implementation

function JsonXlsParam2Str(TempParam: XlsParam): string;
var
  JsonObj: TJSONObject;
begin
  Result := '';
  if True then
  begin

    try
      JsonObj := TJSONObject.Create;
      JsonObj.AddPair('PPIDPos', TempParam.PPIDPos);
      JsonObj.AddPair('LotPos', TempParam.LotPos);
      JsonObj.AddPair('WaferIDPos', TempParam.WaferIDPos);
      JsonObj.AddPair('MinTables', IntToStr(TempParam.MinTables));
      JsonObj.AddPair('MaxTables', IntToStr(TempParam.MaxTables));
      JsonObj.AddPair('CreateTime', TempParam.CreateTime);
      JsonObj.AddPair('TableDiff', TempParam.TableDiff);
      JsonObj.AddPair('DiffBool', TempParam.DiffBool.ToInteger.ToString);
    finally
      Result := JsonObj.ToString;
      JsonObj.Free;
    end;

  end;
end;

function JsonAdj(JSBarcodeStr: string; out JSBack: BarcodeJs): Boolean;
var
  JsonObject: TJSONObject;
  I: Integer;
  Temp: BarcodeJs;
  TempArr: TArray<string>;
begin
  Result := False;
  if Length(JSBarcodeStr) > 0 then
  begin
    JsonObject := nil;
    JsonObject := TJSONObject.ParseJSONValue(JSBarcodeStr) as TJSONObject;
    if JsonObject = nil then
    begin
      Exit;
    end;
    if JsonObject.Count > 0 then
    begin
      Temp.PPID := JsonObject.Values['PPID'].Value;
      Temp.LotID := JsonObject.Values['LOTID'].Value;
      Temp.WaferNumber := JsonObject.Values['WAFERIDS'].Value;
      Temp.UserID := JsonObject.Values['USER'].Value;
      Temp.EqID := JsonObject.Values['EQPID'].Value;
      TempArr := Temp.EqID.Split([';']);
      Temp.ProberID := TempArr[0];
      Temp.TesterID := TempArr[1];
      JSBack := Temp;
      Result := True;
    end;
  end;

end;

end.

