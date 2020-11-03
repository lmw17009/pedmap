unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, FileCtrl, Vcl.ComCtrls, CommCtrl, Winapi.ShellAPI;

type
  TForm3 = class(TForm)
    btn1: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    TelSaveColumn: TEdit;
    TelSaveRow: TEdit;
    Log: TMemo;
    lv1: TListView;
    btn2: TButton;
    btn3: TButton;
    SelNameEdit: TEdit;
    CheckPath: TEdit;
    btn4: TButton;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure lv1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn1MouseEnter(Sender: TObject);
    procedure btn2MouseEnter(Sender: TObject);
    procedure btn3MouseEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ReadColumnRowFun(var Path: string): Boolean;

var
  Form3: TForm3;

implementation

uses
  Unit1, Global;
{$R *.dfm}

function ReadColumnRowFun(var Path: string): Boolean;
var
  GetStream: TFileStream;
  //Buf: Byte;
  Buf4: array[0..3] of Byte;
  //Buf9: array[0..8] of Byte;
  //PosCounts: Integer;
  I: Integer;
  j: Integer;
begin
  Result := False;
  ReadColumnsMax := 0;
  ReadRowsMax := 0;
  try
    GetStream := TFileStream.Create(Path, fmOpenRead or fmShareExclusive);
    with GetStream do
    begin
      Position := 14;
      Read(Buf4, 4);
      ReadColumnsMax := Buf4[1];
      ReadRowsMax := Buf4[3];
      Result := True;
    end;

  except
    Result := False;

  end;
  GetStream.Free;
end;

procedure TForm3.btn1Click(Sender: TObject);
var
  Dlgopen1: TOpenDialog;
  Str, FileName: string;
  Sr: TSearchRec;
  //Txt: TextFile;
  Txtlist: TStringList;
  WaferSize, SizeX, SizeY: string;
  Item: TListItem;
  FilePath: string;
begin
//  Dlgopen1 := TOpenDialog.Create(nil);
//  try
//    //Dlgopen1.Filter := 'TEL Marking File(*.map)|*.map';
//    //Dlgopen1.DefaultExt := '*.map';
//    if Dlgopen1.Execute then
//    begin
//      Str := Trim(Dlgopen1.FileName);
//      Log.Lines.Add(Str);
//      //SaveTskTestPos(Str);
//    end;
//  finally
//    FreeAndNil(Dlgopen1);
//  end;
  begin
    if SelectDirectory('选择文件提取路径', '', Str) then
    begin
      Log.Lines.Add('已选定[' + Str + ']为检索目录');
      CheckPath.Text := Str;
    end
    else
    begin
      Exit;
    end;
    lv1.Clear;
    Txtlist := TStringList.Create;
    if FindFirst(Str + '\*.map', faAnyFile, Sr) = 0 then
      repeat
        if (Sr.Name = '.') then
          Continue;
        if Sr.Name = '..' then
          Continue;

        if Sr.Attr >= faDirectory then
        begin
          //TelMapList.Lines.Add(ExtractFileName(Sr.Name));
          FileName := Copy(Sr.Name, 1, Length(Sr.Name) - 4);

          Txtlist.LoadFromFile(Str + '\' + FileName + '.apl');
          //ColumnsRowList.Lines.Add(Txtlist[7]);
          WaferSize := Copy(Txtlist[1], Length(Txtlist[1]), 1);
          SizeX := Copy(Txtlist[7], 21, Length(Txtlist[7]) - 20);
          SizeY := Copy(Txtlist[8], 21, Length(Txtlist[8]) - 20);
          Item := lv1.Items.Add;
          Item.Caption := FileName;
          Item.SubItems.Add(WaferSize);
          Item.SubItems.Add(SizeX);
          Item.SubItems.Add(SizeY);
          if (StrToInt(SizeX) > 765) and (StrToInt(SizeY) > 765) then
          begin
            FilePath := Str + '\' + Sr.Name;
            if ReadColumnRowFun(FilePath) then
            begin
              Item.SubItems.Add(IntToStr(ReadColumnsMax));
              Item.SubItems.Add(IntToStr(ReadRowsMax));
            end;
          end
          else
          begin
            Item.SubItems.Add('X');
            Item.SubItems.Add('X');
          end;

        end;
      until FindNext(Sr) <> 0;

  end;
  Txtlist.Free;

end;

procedure TForm3.btn1MouseEnter(Sender: TObject);
begin
  Self.ShowHint := True;
end;

procedure TForm3.btn2Click(Sender: TObject);
var
  SavePath: string;
  i, j: Integer;
  //TxtFile: TFileStream;
  Fs: TFileStream;
  NameStr: string;
  Col, Row: Integer;
  Xpos, YPos: Integer;
  ReadCount: Integer;
  Buf9: array[0..8] of Byte;
  Bin: Integer;
  WriteStr: string;
  TestCount: Integer;
begin
//  ShowMessage(lv1.Items[0].SubItems.strings[0]);
//  ShowMessage(lv1.Items[0].Caption);
//  Exit;
  if lv1.Items.Count = 0 then
  begin
    Exit;
  end;

  SavePath := ExtractFileDir(ParamStr(0)) + '\SavePos\';
  if not DirectoryExists(SavePath) then
  begin
    CreateDir(SavePath);
    SysSavePath := SavePath;
  end;
  for i := 0 to lv1.Items.Count - 1 do
  begin
    if lv1.Items[i].SubItems.strings[3] = 'X' then
      Continue;
    with lv1 do
    begin
      NameStr := DateToStr(Now);

      with TStringList.Create do
      try

        Fs := TFileStream.Create(CheckPath.Text + '\' + Items[i].Caption + '.map', fmOpenRead or fmShareExclusive);
        Col := StrToInt(lv1.Items[i].SubItems.strings[3]);
        Row := StrToInt(lv1.Items[i].SubItems.strings[4]);
        Fs.Position := TELXYPosStart;
        Xpos := 1;
        YPos := 1;
        ReadCount := 0;
        TestCount := 0;
        while ReadCount <= Col * Row do
        begin
          Fs.Read(Buf9, 9);
          Bin := Buf9[2] * 255 + Buf9[3];

          if Bin = TEL_Test_Bin then
          begin
            WriteStr := IntToStr(Xpos) + ',' + IntToStr(YPos);
            TestCount := TestCount + 1;
            Add(WriteStr);
          end;
          ReadCount := ReadCount + 1;
          Xpos := ReadCount mod Col + 1;
          YPos := ReadCount div Col + 1;
        end;
        Add('All Test Die: ' + IntToStr(TestCount));
        SaveToFile(SavePath + Items[i].Caption + '-' + NameStr + '.txt');
        Log.Lines.Add(SavePath + Items[i].Caption + '-' + NameStr + '.txt' + '==>已完成!')
      finally
        Free;
        Fs.Free;
      end;
    end;
  end;
  Log.Lines.Add('提取完成。')

end;

procedure TForm3.btn2MouseEnter(Sender: TObject);
begin
  Self.ShowHint := True;
end;

procedure TForm3.btn3Click(Sender: TObject);
var
  Col, Row: Integer;
  fs: TFileStream;
  Buf9: array[0..8] of Byte;
  ReadCount, TestCount, Bin: Integer;
  XPos, YPos: Integer;
  WriteStr, SavePath, NameStr: string;
begin
  if TelSaveColumn.Text = '0' then
    Exit;
  if TelSaveRow.Text = '0' then
    Exit;
  Col := StrToInt(TelSaveColumn.Text);
  Row := StrToInt(TelSaveRow.Text);
  SavePath := ExtractFileDir(ParamStr(0)) + '\SavePos\';
  if not DirectoryExists(SavePath) then
  begin
    CreateDir(SavePath);
    SysSavePath := SavePath;
  end;
  NameStr := DateToStr(Now);
  with TStringList.Create do
  try
    fs := TFileStream.Create(CheckPath.Text + '\' + SelNameEdit.Text + '.map', fmOpenRead or fmShareExclusive);
    with fs do
    begin
      Position := TELXYPosStart;
      ReadCount := 0;
      TestCount := 0;
      XPos := 1;
      YPos := 1;
      while ReadCount <= Col * Row do
      begin
        fs.Read(Buf9, 9);
        Bin := Buf9[2] * 255 + Buf9[3];

        if Bin = TEL_Test_Bin then
        begin
          WriteStr := IntToStr(XPos) + ',' + IntToStr(YPos);
          TestCount := TestCount + 1;
          Add(WriteStr);
        end;
        ReadCount := ReadCount + 1;
        XPos := ReadCount mod Col + 1;
        YPos := ReadCount div Col + 1;
      end;
      Add('All Test Die: ' + IntToStr(TestCount));
      SaveToFile(SavePath + SelNameEdit.Text + '-' + NameStr + '.txt');
      Log.Lines.Add(SavePath + SelNameEdit.Text + '-' + NameStr + '.txt' + '==>已完成!');

    end;
    fs.Free;
  finally
    Free;
  end;

end;

procedure TForm3.btn3MouseEnter(Sender: TObject);
begin
  Self.ShowHint := True;
end;

procedure TForm3.btn4Click(Sender: TObject);
//var
//  str: string;
begin
//  if SelectDirectory('选择文件提取路径', 'o:\', str) then
//  begin
//
//  end;
//if SysSavePath<>'' then
//begin
//ShellExecute(Handle, 'open', '', PChar(GetCurrentDir), nil, SW_NORMAL);
//end
//else
//begin
//ShellExecute(Handle, 'open', '', PChar(SysSavePath), nil, SW_NORMAL);
//end;
  if not DirectoryExists(GetCurrentDir + '\SavePos\') then
  begin
    ShellExecute(Handle, 'open', 'Explorer.exe', PChar(GetCurrentDir), nil, SW_NORMAL);
  end
  else
  begin
    ShellExecute(Handle, 'open', 'Explorer.exe', PChar(GetCurrentDir + '\SavePos\'), nil, SW_NORMAL);
  end;

end;

procedure TForm3.FormCreate(Sender: TObject);
begin

  lv1.ViewStyle := vsReport;
  lv1.GridLines := True;         {非默认}
  lv1.ShowColumnHeaders := True; {默认}
  Log.Lines.Clear;

end;

procedure TForm3.lv1Click(Sender: TObject);
begin
  if Assigned(lv1.Selected) then
  begin
    SelNameEdit.Text := lv1.Selected.Caption;
    TelSaveRow.Text := '';
    TelSaveColumn.Text := '';
  end;
end;

end.

