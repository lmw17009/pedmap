unit FTP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, System.JSON, Vcl.ComCtrls;

type
  TForm11 = class(TForm)
    btnSearchFile: TButton;
    mmo1: TMemo;
    edtTstNumber: TEdit;
    edtPPID: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    idftp2: TIdFTP;
    btnConnect: TButton;
    stat1: TStatusBar;
    btnSearchSub: TButton;
    btnDisConn: TButton;
    rbProd: TRadioButton;
    rbEng: TRadioButton;
    lv1: TListView;
    btn1: TButton;
    procedure btnSearchFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnDisConnClick(Sender: TObject);
    procedure btnSearchSubClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    procedure FtpSetupIni;
    procedure ListFree;
    { Private declarations }
  public
    { Public declarations }
    function FtpConnect: Boolean;
    function ProdList(FtpFileList: TStrings; out List: TStrings): Boolean;
    function TestPlan(ListName: string; out List: TStrings): Boolean;
    procedure MmAdd(MSG: string); overload;
    procedure MmAdd(MSG: TStrings); overload;
    procedure RefreshDownPath;
  end;

var
  Form11: TForm11;
  FtpConnect: Boolean;

implementation

{$R *.dfm}
uses
  Global, JsonAdjust;

procedure TForm11.btnSearchFileClick(Sender: TObject);
var
  Txt: TextFile;
  S: string;
  I, J: Integer;
  ListCount: Integer;
  Arr: TArray<string>;
  ProdLimitBool, ProdTstBool, ProdWafBool, ProdDieBool: Boolean;
  EngLimitBool, EngTstBool, EngWafBool, EngDieBool: Boolean;
  PFindBool, EFindBool: Boolean;
begin
  MmAdd('*******��ʼ���*******');
  if WatTestPlanProd <> nil then
  begin
    MmAdd('PROD��ʼ���....');
    if {Pos('*', edtPPID.Text) = 0} True then
    begin
      ListCount := 0;
      for I := 0 to WatTestPlanProd.Count - 1 do
      begin

        //Mmadd('��ʼ�Ա�testplan....');
        if edtPPID.Text = WatTestPlanProd[I] then
        begin
          PFindBool := True;
          MmAdd(IntToStr(I + 4) + '�з���=>' + WatTestPlanProd[I]);
          MmAdd('������ͬtestplan,��ʼ��ѯ....');
          AssignFile(Txt, WatFilePath + PilProdFileName);
          Reset(Txt);
          while not Eof(Txt) do
          begin
            Readln(Txt, S);
            if ListCount - 3 = I then
            begin
              MmAdd(S);
              //Arr := S.Split([' ']);
              //Mmadd('ARR...');
              //prod check
              MmAdd('Prod��ѯ��....');
              for J := 0 to ProdLimit.Count - 1 do
              begin
                //Mmadd(Trim(Copy(S, 32, 13)));
                //Mmadd(ProdLimit[J]);
                if ProdLimit[J] = Trim(Copy(S, 32, 13)) + '.lim' then
                begin
                  ProdLimitBool := True;
                  Break;
                end;
              end;
              if ProdLimitBool then
              begin
                MmAdd('Prod limit ��ѯ����...');
              end
              else
              begin
                MmAdd('Prod limit ȱʧ����');
              end;

              for J := 0 to ProdTst.Count - 1 do
              begin
                if ProdTst[J] = Trim(Copy(S, 46, 10)) + '.tst' then
                begin
                  ProdTstBool := True;
                  Break;
                end;
              end;
              if ProdTstBool then
              begin
                MmAdd('Prod tst ��ѯ����...');
              end
              else
              begin
                MmAdd('Prod tst ȱʧ����');
              end;

              for J := 0 to ProdWaf.Count - 1 do
              begin
                if ProdWaf[J] = Trim(Copy(S, 57, 10)) + '.waf' then
                begin
                  ProdWafBool := True;
                  Break;
                end;
              end;

              if ProdWafBool then
              begin
                MmAdd('Prod waf ��ѯ����...');
              end
              else
              begin
                MmAdd('Prod waf ȱʧ����');
              end;

              for J := 0 to ProdDie.Count - 1 do
              begin
                if ProdDie[J] = Trim(Copy(S, 68, 10)) + '.die' then
                begin
                  ProdDieBool := True;
                  Break;
                end;
              end;
              if ProdDieBool then
              begin
                MmAdd('Prod die ��ѯ����...');
              end
              else
              begin
                MmAdd('Prod die ȱʧ����');
              end;
              CloseFile(Txt);
              Break;
            end
            else
            begin
              Inc(ListCount);
            end;
          end;

          Break;
        end;

      end;
      if not PFindBool then
      begin
        MmAdd('Prodδ����testplan����');
      end;
    end;
    MmAdd('PROD��ѯ���....');
  end;
  if WatTestPlanEng <> nil then
  begin
    MmAdd('ENG��ʼ���....');
    if {Pos('*', edtPPID.Text) = 0} True then
    begin
      ListCount := 0;
      for I := 0 to WatTestPlanEng.Count - 1 do
      begin
        //Mmadd('��ʼ�Ա�testplan....');
        if edtPPID.Text = WatTestPlanEng[I] then
        begin
          MmAdd(IntToStr(I + 4) + '�з���=>' + WatTestPlanEng[I]);
          MmAdd('������ͬtestplan,��ʼ��ѯ....');
          AssignFile(Txt, WatFilePath + PilEngFileName);
          Reset(Txt);
          while not Eof(Txt) do
          begin
            Readln(Txt, S);
//            if ListCount >= 3 then
//            begin
//              MmAdd(IntToStr(ListCount) + '/' + WatTestPlanEng[ListCount - 3] + '/' + IntToStr(I));
//            end;
            if ListCount - 3 = I then
            begin
              MmAdd(S);
              //eng check
              MmAdd('ENG��ѯ��....');
              for J := 0 to EngLimit.Count - 1 do
              begin
                if EngLimit[J] = Trim(Copy(S, 32, 13)) + '.lim' then
                begin
                  EngLimitBool := True;
                  Break;
                end;
              end;
              if EngLimitBool then
              begin
                MmAdd('Eng limit ��ѯ����...');
              end
              else
              begin
                MmAdd('Eng limit ȱʧ����');
              end;
              for J := 0 to EngTst.Count - 1 do
              begin
                if EngTst[J] = Trim(Copy(S, 46, 10)) + '.tst' then
                begin
                  EngTstBool := True;
                  Break;
                end;
              end;
              if EngTstBool then
              begin
                MmAdd('Eng tst ��ѯ����...');
              end
              else
              begin
                MmAdd('Eng tst ȱʧ����');
              end;

              for J := 0 to EngWaf.Count - 1 do
              begin
                if EngWaf[J] = Trim(Copy(S, 57, 11)) + '.waf' then
                begin
                  EngWafBool := True;
                  Break;
                end;
              end;
              if EngWafBool then
              begin
                MmAdd('Eng waf ��ѯ����...');
              end
              else
              begin
                MmAdd('Eng waf ȱʧ����');
              end;

              for J := 0 to EngDie.Count - 1 do
              begin
                if EngDie[J] = Trim(Copy(S, 68, 11)) + '.die' then
                begin
                  EngDieBool := True;
                  Break;
                end;
              end;
              if EngDieBool then
              begin
                MmAdd('Eng die ��ѯ����...');
              end
              else
              begin
                MmAdd('Eng die ȱʧ����');
              end;
              CloseFile(Txt);
              Break;
            end
            else
            begin
              Inc(ListCount);
            end;
          end;

          Break;
        end;

      end;
      if not EFindBool then
      begin
        MmAdd('Engδ����testplan����');
      end;
    end;
    MmAdd('ENG��ѯ���....');
  end;
  MmAdd('*******��ѯ���*******');
end;

procedure TForm11.btnSearchSubClick(Sender: TObject);
var
  I: Integer;
  Count: Integer;
  Txt: TextFile;
  s: string;
  TitleCount: Integer;
  TitleStr: string;
  RFindBool: Boolean;
begin
  MmAdd('***TST�ļ���ʼ��ѯ***');
  if rbProd.Checked then
  begin
    Count := 0;
    MmAdd('***Prod��ѯ***');
    for I := 0 to ProdTst.Count - 1 do
    begin
      if Pos(UpperCase(edtPPID.Text), ProdTst[I]) > 0 then
      begin
        Inc(Count);
        MmAdd(IntToStr(Count) + '=>' + ProdTst[I]);
      end;
    end;
    if Count = 1 then
    begin
      try
        MmAdd('***TST�ļ�������***');
        MmAdd(WatFilePath + UpperCase(edtPPID.Text));
        idftp2.Get(FtpPathProd + FolderTst + '/' + UpperCase(edtPPID.Text) + '.tst', WatFilePath + UpperCase(edtPPID.Text) + '.tst', True, False);
        MmAdd('***TST�ļ��������***');
        AssignFile(Txt, WatFilePath + UpperCase(edtPPID.Text) + '.tst');
        Reset(Txt);
        RFindBool := False;
        while not Eof(Txt) do
        begin
          Readln(Txt, s);
          //::
          if Pos('::', s) > 0 then
          begin
            Inc(TitleCount);
            TitleStr := Trim(s);
          end;
          if Pos('R[' + edtTstNumber.Text + ']', s) > 0 then
          begin
            MmAdd('find=>' + s);
            RFindBool := True;
            MmAdd('�������R[' + edtTstNumber.Text + ']���������Ϊ' + TitleStr);
            Break;
          end;
        end;
        CloseFile(Txt);
        if not RFindBool then
        begin
          MmAdd('δ��������Ŀ...');
        end;
      except
        MmAdd('***TST�ļ�����ʧ��***');
      end;

    end;
  end;
  if rbEng.Checked then
  begin
    Count := 0;
    MmAdd('***ENG��ѯ***');
    for I := 0 to EngTst.Count - 1 do
    begin
      if Pos(UpperCase(edtPPID.Text), EngTst[I]) > 0 then
      begin
        Inc(Count);
        MmAdd(IntToStr(Count) + '=>' + EngTst[I]);
      end;
    end;
    if Count = 1 then
    begin
      try
        MmAdd('***TST�ļ�������***');
        MmAdd(WatFilePath + UpperCase(edtPPID.Text));
        idftp2.Get(FtpPathEng + FolderTst + '/' + UpperCase(edtPPID.Text) + '.tst', WatFilePath + UpperCase(edtPPID.Text) + '.tst', True, False);
        MmAdd('***TST�ļ��������***');
        AssignFile(Txt, WatFilePath + UpperCase(edtPPID.Text) + '.tst');
        Reset(Txt);
        RFindBool := False;
        while not Eof(Txt) do
        begin
          Readln(Txt, s);
          //::
          if Pos('::', s) > 0 then
          begin
            Inc(TitleCount);
            TitleStr := Trim(s);
          end;
          if Pos('R[' + edtTstNumber.Text + ']', s) > 0 then
          begin
            MmAdd('find=>' + s);
            RFindBool := True;
            MmAdd('�������R[' + edtTstNumber.Text + ']���������Ϊ' + TitleStr);
            Break;
          end;
        end;
        CloseFile(Txt);
        if not RFindBool then
        begin
          MmAdd('δ��������Ŀ...');
        end;
      except
        MmAdd('***TST�ļ�����ʧ��***');
      end;

    end;
  end;
  RefreshDownPath;
  MmAdd('***TST�ļ���ѯ����***');
end;

procedure TForm11.btn1Click(Sender: TObject);
begin
  RefreshDownPath;
end;

procedure TForm11.btnConnectClick(Sender: TObject);
begin
  if not idftp2.Connected then
  begin
    if FtpConnect then
    begin
      btnSearchFile.Enabled := True;
      btnConnect.Enabled := False;
      btnDisConn.Enabled := True;
      btnSearchSub.Enabled := True;
    end;
  end;
end;

procedure TForm11.btnDisConnClick(Sender: TObject);
begin
  if idftp2.Connected then
  begin
    idftp2.Disconnect;
    btnConnect.Enabled := True;
    btnDisConn.Enabled := False;
    btnSearchFile.Enabled := False;
    btnSearchSub.Enabled := False;
    ListFree;
    stat1.Panels[0].Text := '�������ѶϿ�';
    MmAdd('�������ѶϿ�');

  end;
end;

procedure TForm11.FormCreate(Sender: TObject);
begin
  mmo1.Lines.Clear;
  WatFilePath := ExtractFilePath(ParamStr(0)) + 'Wat\';
  if not DirectoryExists(WatFilePath) then
  begin
    CreateDir(WatFilePath);
  end;

end;

procedure TForm11.FormDestroy(Sender: TObject);
begin
  ListFree;
  idftp2.Disconnect;

end;

procedure TForm11.FormShow(Sender: TObject);
begin
  FtpSetupIni;
  stat1.Panels[0].Text := '��ʼ�����';
  stat1.Panels[1].Text := '�ȴ��û�����';
end;

function TForm11.FtpConnect: Boolean;
var
  List: TStrings;
  Msg: string;
begin
  Result := False;
  //ftp connect
  Application.ProcessMessages;
  idftp2.Host := FtpD2IP;
  idftp2.Username := FtpUser;
  idftp2.Password := FtpPwd;
  List := TStringList.Create;

  ProdTst := TStringList.Create;
  ProdLimit := TStringList.Create;
  //ProdPrb := TStringList.Create;
  ProdDie := TStringList.Create;
  ProdWaf := TStringList.Create;

  EngTst := TStringList.Create;
  EngLimit := TStringList.Create;
  //EngPrb := TStringList.Create;
  EngDie := TStringList.Create;
  EngWaf := TStringList.Create;

  WatTestPlanProd := TStringList.Create;
  WatTestPlanEng := TStringList.Create;

  Msg := '׼������';
  stat1.Panels[0].Text := Msg;
  idftp2.Connect;
  if idftp2.Connected then
  begin
    FtpConnect := True;
    Msg := '���ӳɹ�';
    stat1.Panels[0].Text := Msg;
    MmAdd('��ʼ����...');
    Self.Caption := 'WATFTP ��ʼ��ȡ����...';
    MmAdd(idftp2.RetrieveCurrentDir);
    Msg := '׼��ת��·��...';
    idftp2.ChangeDir(FtpPathProd + FolderTst);
    Msg := 'ת�Ƶ�FtpPathProd...';
    idftp2.List(List);
    //����prod�ļ��б�
    if ProdList(List, ProdTst) then
    begin
      Msg := 'Prod-TST=>' + IntToStr(ProdTst.Count);
      MmAdd(Msg);
      //MmaddStrings(ProdTst);
    end;
    List.Clear;
    idftp2.ChangeDir(FtpPathProd + FolderLimit);
    Msg := 'ת�Ƶ�FtpPathProd...';
    idftp2.List(List);
    //����prod�ļ��б�
    if ProdList(List, ProdLimit) then
    begin
      Msg := 'Prod-limit=>' + IntToStr(ProdLimit.Count);
      MmAdd(Msg);
      //MmaddStrings(ProdTst);
    end;

    List.Clear;
    idftp2.ChangeDir(FtpPathProd + FolderWaf);
    Msg := 'ת�Ƶ�FtpPathProd...';
    idftp2.List(List);
    //����prod�ļ��б�
    if ProdList(List, ProdWaf) then
    begin
      Msg := 'Prod-waf=>' + IntToStr(ProdWaf.Count);
      MmAdd(Msg);
      //MmaddStrings(ProdWaf);
    end;
    List.Clear;
    idftp2.ChangeDir(FtpPathProd + FolderDie);
    Msg := 'ת�Ƶ�FtpPathProd...';
    idftp2.List(List);
    //����prod�ļ��б�
    if ProdList(List, ProdDie) then
    begin
      Msg := 'Prod-waf=>' + IntToStr(ProdDie.Count);
      MmAdd(Msg);
      //MmaddStrings(ProdWaf);
    end;
    //eng
    idftp2.ChangeDir('/d2/WATSERV/0_ENG/TST');
    List.Clear;
    idftp2.ChangeDir(FtpPathEng + FolderTst);
    Msg := 'ת�Ƶ�FtpPatheng';
    idftp2.List(List);
    //����eng�ļ��б�

    if ProdList(List, EngTst) then
    begin
      Msg := 'Eng-TST=>' + IntToStr(EngTst.Count);
      MmAdd(Msg);
      //MmaddStrings(ProdTst);
    end;
    List.Clear;
    idftp2.ChangeDir(FtpPathEng + FolderLimit);
    Msg := 'ת�Ƶ�FtpPatheng...';
    idftp2.List(List);
    if ProdList(List, EngLimit) then
    begin
      Msg := 'Eng-limit=>' + IntToStr(EngLimit.Count);
      MmAdd(Msg);
      //MmaddStrings(ProdTst);
    end;

    List.Clear;
    idftp2.ChangeDir(FtpPathEng + FolderWaf);
    Msg := 'ת�Ƶ�FtpPathProd...';
    idftp2.List(List);
    if ProdList(List, EngWaf) then
    begin
      Msg := 'Eng-waf=>' + IntToStr(EngWaf.Count);
      MmAdd(Msg);
      //MmaddStrings(ProdWaf);
    end;
    List.Clear;
    idftp2.ChangeDir(FtpPathEng + FolderDie);
    Msg := 'ת�Ƶ�FtpPatheng...';
    idftp2.List(List);
    if ProdList(List, EngDie) then
    begin
      Msg := 'Eng-die=>' + IntToStr(EngDie.Count);
      MmAdd(Msg);
      //MmaddStrings(ProdWaf);
    end;
    List.Clear;
    //��ȡ�����ļ�
    idftp2.ChangeDir(FtpPathEtc);
    idftp2.Get(FtpPathEtc + '/' + PilProdFileName, WatFilePath + PilProdFileName, True, False);
    MmAdd('PIL_PROD�ļ���ȡ�ɹ�...');
    idftp2.Get(FtpPathEtc + '/' + PilEngFileName, WatFilePath + PilEngFileName, True, False);
    MmAdd('PIL_ENG�ļ���ȡ�ɹ�...');
    //����pil_Prod�ļ�

    TestPlan(PilProdFileName, WatTestPlanProd);
    TestPlan(PilEngFileName, WatTestPlanEng);
    Self.Caption := 'WATFTP';
    Result := True;
  end
  else
  begin
    Msg := '����δ�ɹ�...';
  end;

end;

procedure TForm11.FtpSetupIni;
var
  Txt: TextFile;
  S: string;
  Json: TJSONObject;
begin
  //FTP�����ļ����
  if not FileExists('WatFtp.txt') then
  begin
    AssignFile(Txt, 'WatFtp.txt');
    Rewrite(Txt);
    Json := TJSONObject.Create;
    Json.AddPair('ip', '10.9.14.16');
    Json.AddPair('user', 'device');
    Json.AddPair('pwd', 'device');
    Json.AddPair('prodpath', '/d2/WATSERV/0_PROD');
    Json.AddPair('engpath', '/d2/WATSERV/0_ENG');
    Json.AddPair('etcpath', '/d2/WATSERV/etc');
    Json.AddPair('limit', '/0_LIMIT_FILE');
    Json.AddPair('die', '/DIE');
    Json.AddPair('tst', '/TST');
    Json.AddPair('waf', '/WAF');
    Json.AddPair('pil_prod', 'PIL_PROD');
    Json.AddPair('pil_eng', 'PIL_ENG');
    Writeln(Txt, '#FTP��ַ���û��������룬Prod·����Eng·��,pil_prod·��');
//    Writeln(Txt, '10.9.14.16');
//    Writeln(Txt, 'device');
//    Writeln(Txt, 'device');
//    Writeln(Txt, '21');
//    Writeln(Txt, '/d2/WATSERV/0_PROD');
//    Writeln(Txt, '/d2/WATSERV/0_ENG');
//    Writeln(Txt, '/d2/WATSERV/etc');
    Writeln(Txt, Json.ToString);
    Flush(Txt);
    CloseFile(Txt);
    FtpD2IP := '10.9.14.16';
    FtpUser := 'device';
    FtpPwd := 'device';
    //FtpPort := '21';
    FtpPathProd := '/d2/WATSERV/0_PROD';
    FtpPathEng := '/d2/WATSERV/0_ENG';
    FtpPathEtc := '/d2/WATSERV/etc';
    FolderLimit := '/0_LIMIT_FILE';
    FolderDie := '/DIE';
    FolderTst := '/TST';
    FolderWaf := '/WAF';
    PilProdFileName := 'PIL_PROD';
    PilEngFileName := 'PIL_ENG';
    MmAdd('FtpD2IP=' + FtpD2IP);
    MmAdd('FtpUser=' + FtpUser);
    MmAdd('FtpPwd=' + FtpPwd);
    MmAdd('FtpPathProd=' + FtpPathProd);
    MmAdd('FtpPathEng=' + FtpPathEng);
    MmAdd('PilProdFileName=' + PilProdFileName);
    MmAdd('PilEngFileName=' + PilEngFileName);
    MmAdd('limit=' + FolderLimit);
    MmAdd('waf=' + FolderWaf);
    MmAdd('die=' + FolderDie);
    MmAdd('tst=' + FolderTst);
    Json.Free;
  end
  else
  begin
    AssignFile(Txt, 'WatFtp.txt');
    Reset(Txt);
    Readln(Txt, S);
    Readln(Txt, S);
    //json:=TJSONObject.Create;
    Json := TJSONObject.ParseJSONValue(Trim(S)) as TJSONObject;
    if Json.Count > 0 then
    begin
      //ShowMessage(IntToStr(Json.Count));
      FtpD2IP := Json.GetValue('ip').Value;
      FtpUser := Json.GetValue('user').Value;
      FtpPwd := Json.GetValue('pwd').Value;
      FtpPathProd := Json.GetValue('prodpath').Value;
      FtpPathEng := Json.GetValue('engpath').Value;
      FtpPathEtc := Json.GetValue('etcpath').Value;
      FolderLimit := Json.GetValue('limit').Value;
      FolderDie := Json.GetValue('die').Value;
      FolderTst := Json.GetValue('tst').Value;
      FolderWaf := Json.GetValue('waf').Value;
      PilProdFileName := Json.GetValue('pil_prod').Value;
      PilEngFileName := Json.GetValue('pil_eng').Value;
      MmAdd('FtpD2IP=' + FtpD2IP);
      MmAdd('FtpUser=' + FtpUser);
      MmAdd('FtpPwd=' + FtpPwd);
      MmAdd('FtpPathProd=' + FtpPathProd);
      MmAdd('FtpPathEng=' + FtpPathEng);
      MmAdd('FtpPathEtc=' + FtpPathEtc);
      MmAdd('PilProdFileName=' + PilProdFileName);
      MmAdd('PilEngFileName=' + PilEngFileName);
      MmAdd('limit=' + FolderLimit);
      MmAdd('waf=' + FolderWaf);
      MmAdd('die=' + FolderDie);
      MmAdd('tst=' + FolderTst);
    end;
    CloseFile(Txt);
  end;
end;

function TForm11.ProdList(FtpFileList: TStrings; out List: TStrings): Boolean;
var
  i: Integer;
  Arr: TArray<string>;
begin
  Result := True;
  if FtpFileList.Count > 0 then
  begin
    for i := 0 to FtpFileList.Count - 1 do
    begin
      Arr := FtpFileList[i].Split([' ']);
      //Self.Caption := 'WATFTP ' + IntToStr(i + 1) + '/' + IntToStr(FtpFileList.Count);
      //stat1.Panels[1].Text := IntToStr(i) + '/' + IntToStr(FtpFileList.Count);
      List.Add(Arr[High(Arr)]);
    end;
    if List.Count = 0 then
    begin
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;
end;

procedure TForm11.RefreshDownPath;
var
  FileName, S: string;
  FindIndex: Integer;
  Rc: TSearchRec;
begin
  FindIndex := FindFirst(WatFilePath + '*.tst', faAnyFile, Rc);
  lv1.Clear;
//  while FindIndex = 0 do
//  begin
//    if (Rc.Name <> '.') and (Rc.Name <> '..') and ((Rc.Attr and faDirectory) <> 0) then
//    begin
////      FindIndex := FindNext(Rc);
////    end
////    else
////    begin
//      with lv1.Items.Add do
//      begin
//        Caption := Rc.Name;
//        MmAdd(Rc.Name);
//        FindIndex := FindNext(Rc);
//      end;
//    end;
//  end;
  //lv1.Columns.Add;
  //lv1.Column[0].Caption:='123';
  if FindIndex = 0 then
  begin
    repeat
      if (Rc.Name = '.') or (Rc.Name = '..') then
        Continue;
      if Rc.Attr >= faDirectory then
      begin
        with lv1.Items.Add do
        begin
          Caption := Rc.Name;
        end;
      end;
    until (FindNext(Rc) <> 0);
    FindClose(Rc);
  end;
end;

function TForm11.TestPlan(ListName: string; out List: TStrings): Boolean;
var
  Txt: TextFile;
  S, S1: string;
  Count: Integer;
begin
//WatTestPlan
  Result := False;
  List.Clear;
  Count := 0;
  MmAdd('PIL��ȡ...' + ListName);
  if FileExists(WatFilePath + ListName) then
  begin
    AssignFile(Txt, WatFilePath + ListName);
    Reset(Txt);
    Readln(Txt, S);
    Readln(Txt, S);
    Readln(Txt, S);
    while not Eof(Txt) do
    begin
      Readln(Txt, S);
      S1 := Trim(Copy(S, 1, 17));
      if S <> '' then
      begin
        List.Add(S1);
      end;
      Inc(Count);
    end;
    CloseFile(Txt);
    if List.Count > 0 then
    begin
      Result := True;
    end;

  end;
end;

procedure TForm11.ListFree;
begin
  FreeAndNil(ProdLimit);
  FreeAndNil(ProdDie);
  FreeAndNil(ProdWaf);
  FreeAndNil(ProdTst);
  FreeAndNil(EngLimit);
  FreeAndNil(EngDie);
  FreeAndNil(EngTst);
  FreeAndNil(EngWaf);
  FreeAndNil(WatTestPlanProd);
  FreeAndNil(WatTestPlanEng);
end;

procedure TForm11.MmAdd(MSG: TStrings);
begin
  mmo1.Lines.AddStrings(MSG);
end;

procedure TForm11.MmAdd(Msg: string);
begin
  mmo1.Lines.Add(Msg);
end;

end.

