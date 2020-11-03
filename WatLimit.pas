unit WatLimit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.Menus,
  Winapi.ShellAPI;

type
  TWatLimitMain = class(TForm)
    mmo1: TMemo;
    btn1: TButton;
    edt1: TEdit;
    lv1: TListView;
    btn2: TButton;
    pm1: TPopupMenu;
    N1: TMenuItem;
    lbl1: TLabel;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edt1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure lv1DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lv1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lv1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure lv1MouseEnter(Sender: TObject);
    procedure lv1MouseLeave(Sender: TObject);
    procedure lv1ColumnRightClick(Sender: TObject; Column: TListColumn; Point: TPoint);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshListView;
  end;
var
  WatLimitMain: TWatLimitMain;
  PosX, PosY: Integer;
  InLv: Boolean;
  MousePos: TPoint;

implementation

{$R *.dfm}
uses
  WatLimitEdit;

procedure TWatLimitMain.btn1Click(Sender: TObject);
var
  Txt: TextFile;
  SavePath: string;
  i: Integer;
  HeadStr: string;
  CaptionStr, SubStrTemp, SubStr: string;
  j: Integer;
  LvCount: Integer;
  FileName: string;
begin
  LvCount := lv1.Items.Count;
  if LvCount = 0 then
  begin
    ShowMessage('测试项为空！');
    Exit;
  end;

  try
    SavePath := ExtractFilePath(ParamStr(0));
    if not DirectoryExists(SavePath + 'Save\') then
    begin
      CreateDir(SavePath + 'Save\');
    end;
    if not DirectoryExists(SavePath + 'Save\') then
    begin
      ShowMessage('\Save文件夹创建失败,请手动创建！');
      Exit;
    end;
    if edt1.Text = '' then
    begin
      AssignFile(Txt, SavePath + 'Save\' + FormatDateTime('yyyy-mm-dd-hh-mm-ss', Now) + '.lim');
      FileName := FormatDateTime('yyyy-mm-dd-hh-mm-ss', Now) + '.lim';
    end
    else
    begin
      if FileExists(SavePath + 'Save\' + edt1.Text + '.lim') then
      begin
        DeleteFile(SavePath + 'Save\' + edt1.Text + '.lim');
      end;
      AssignFile(Txt, SavePath + 'Save\' + edt1.Text + '.lim');
      FileName := edt1.Text + '.lim';
    end;
    HeadStr := 'Par_no Parameter                Unit        VL          V H         S L         S H         CL          CH          CENTER        FLAG  Version';
    Rewrite(Txt);
    Writeln(Txt, HeadStr);
    for i := 0 to LvCount - 1 do
    begin
      SubStr := '';
      CaptionStr := '';
      with lv1.Items[i] do
      begin
        CaptionStr := Caption;
        for j := 0 to SubItems.Count - 1 do
        begin
          SubStr := SubStr + SubItems[j];
        end;
      end;
      Writeln(Txt, CaptionStr + SubStr);
    end;
    Flush(Txt);
    CloseFile(Txt);

  finally
    edt1.Text := '请输入文件名';
    if FileExists(SavePath + 'Save\' + FileName) then
    begin
      ShowMessage('文件生成路径为：' + SavePath + 'Save\' + FileName);
      ShellExecute(0, nil, PChar('explorer.exe'), PChar('/e, ' + '/select,' + SavePath + 'Save\' + FileName), nil, SW_NORMAL);
    end;
  end;

end;

procedure TWatLimitMain.btn2Click(Sender: TObject);
var
  i, j, k: Integer;
  Count: Integer;
  TempBlankStr, TempBlankStr1, TestTitleStr: string;
begin
  //此处为判断标题是否为空
  Count := mmo1.Lines.Count;
  if Count = 0 then
  begin
    ShowMessage('标题栏为空，请输入内容！');
    Exit;
  end;
  //此处开始处理标题内容
  lv1.Clear;
  for i := 0 to Count - 1 do
  begin
    //判断标题长度不能超过25个字符串长度,如果超过25就弹出提示，强制退出过程。
    //空字符串则跳转
    if (Length(Trim(mmo1.Lines[i])) = 0) then
    begin
      Continue;
    end;

    if (Length(mmo1.Lines[i]) > 25) then
    begin
      ShowMessage('标题栏长度超过25！');
      Exit;
    end;

    with lv1.Items.Add do
    begin
      //计算标题空格并填入
      TempBlankStr := '';
      TempBlankStr1 := '';
      TestTitleStr := '';
      for j := 0 to 4 - Length(IntToStr(i + 1)) do
      begin
        TempBlankStr := TempBlankStr + ' ';
      end;
      if Length(mmo1.Lines[i]) < 25 then
      begin
        for k := 0 to 24 - Length(mmo1.Lines[i]) do
        begin
          TempBlankStr1 := TempBlankStr1 + ' ';
        end;
      end;

      TestTitleStr := TempBlankStr + IntToStr(i + 1) + '  ' + mmo1.Lines[i] + TempBlankStr1;
      Caption := TestTitleStr;
      //填入unit unknow
      SubItems.Add('unknow      ');
      //填入VL VH Sl SH CL CH center flag version
      SubItems.Add('-1.E+30     ');
      SubItems.Add('1.E+30      ');
      SubItems.Add('-1.E+30     ');
      SubItems.Add('1.E+30      ');
      SubItems.Add('-1.E+30     ');
      SubItems.Add('1.E+30      ');
      SubItems.Add('1.75          ');
      SubItems.Add('07     ');
      SubItems.Add('0.001     ');

    end;
  end;
  mmo1.Lines.Clear;
  RefreshListView;
end;

procedure TWatLimitMain.edt1Click(Sender: TObject);
begin
  edt1.Text := '';
end;

procedure TWatLimitMain.FormCreate(Sender: TObject);
begin
  Self.Position := poDesktopCenter;
  mmo1.Lines.Clear;
  Self.Caption := Self.Caption + Version;
end;

procedure TWatLimitMain.lv1ColumnRightClick(Sender: TObject; Column: TListColumn; Point: TPoint);
begin

  mmo1.Lines.Add(IntToStr(Column.Index));
end;

procedure TWatLimitMain.lv1DragDrop(Sender, Source: TObject; X, Y: Integer);
var
  Item1, Item2, Item3: TListItem;
  DragItem, DropItem, CurrentItem, NextItem: TListItem;
  Info: TWindowInfo;
begin
  if WatEdit.Visible then
    Exit;

  if Sender = Source then
  begin
    with TListView(Sender) do
    begin
      DropItem := GetItemAt(X, Y);

      CurrentItem := Selected;
      while CurrentItem <> nil do
      begin
        NextItem := GetNextItem(CurrentItem, sdAll, [isSelected]);
        if DropItem = nil then
          DragItem := Items.Add
        else
          DragItem := Items.Insert(DropItem.Index);
        DragItem.Assign(CurrentItem);
        CurrentItem.Free;
        CurrentItem := NextItem;
      end;
    end;
    RefreshListView;
  end
  else
  begin
    ShowMessage('');
  end;
end;

procedure TWatLimitMain.lv1DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = lv1;

end;

procedure TWatLimitMain.lv1MouseEnter(Sender: TObject);
begin
  InLv := True;
end;

procedure TWatLimitMain.lv1MouseLeave(Sender: TObject);
begin
  InLv := False;
end;

procedure TWatLimitMain.lv1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  //mmo1.Lines.Add('x=' + IntToStr(X) + ' y=' + IntToStr(Y));
  if InLv then
  begin
    PosX := X;
    PosY := Y;
  end;
end;

procedure TWatLimitMain.N1Click(Sender: TObject);
begin
  if lv1.SelCount = 0 then
    Exit;

  MousePos := Mouse.CursorPos;
  WatEdit.Show;
  WatEdit.Left := ScreenToClient(Mouse.CursorPos).X + WatLimitMain.Left;
  WatEdit.Top := ScreenToClient(Mouse.CursorPos).Y + WatLimitMain.Top;

end;

procedure TWatLimitMain.N2Click(Sender: TObject);
begin
  if lv1.Items.Count = 0 then
    Exit;
  lv1.Clear;
end;

procedure TWatLimitMain.N3Click(Sender: TObject);
var
  I, j: Integer;
  DeleteLines: TStrings;
  Min, Max, Temp: Integer;
  ListCheck: Boolean;
begin
  if lv1.Items.Count = 0 then
    Exit;
  DeleteLines := TStringList.Create;
  for I := 0 to lv1.Items.Count - 1 do
  begin
    if lv1.Items[I].Checked then
    begin
      DeleteLines.Add(IntToStr(I));
      ListCheck := True;
    end;
  end;
  if not ListCheck then
    Exit;

  if DeleteLines.Count > 1 then
  begin
    for I := 0 to DeleteLines.Count - 1 do
    begin
//      for j := I + 1 to DeleteLines.Count - 1 do
//      begin
//        Min := StrToInt(DeleteLines[I]);
//        Max := StrToInt(DeleteLines[j]);
//        if Min > Max then
//        begin
//          DeleteLines[I] := IntToStr(Max);
//          DeleteLines[j] := IntToStr(Min);
//        end;
//      end;
      lv1.Items[StrToInt(DeleteLines[DeleteLines.Count - I - 1])].Delete;
    end;
  end
  else
  begin
    lv1.Items[StrToInt(DeleteLines[0])].Delete;
  end;
  RefreshListView;
end;

procedure TWatLimitMain.RefreshListView;
var
  I, OldIndex: Integer;
  Str, StrIndex, StrTitle: string;
  StrBlank, NewCaption: string;
begin
  for I := 0 to lv1.Items.Count - 1 do
  begin
    Str := lv1.Items[I].Caption;
    //StrIndex := Copy(Str, 1, 2);
    StrTitle := Copy(Str, 6, Length(Str) - 6);
    //StrBlank := Copy(Str, 2, 1);
    //OldIndex := StrToInt(Trim(StrIndex));
    if I < 9 then
    begin
      lv1.Items[I].Caption := '    ' + IntToStr(I + 1) + StrTitle;
    end
    else
    begin
      lv1.Items[I].Caption := '   ' + IntToStr(I + 1) + StrTitle;
    end;

  end;
end;

end.

