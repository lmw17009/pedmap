unit Global;

interface

uses
  System.Classes;

const
  Version = ' V20201103';//�汾�ţ�
  XYPosOffsetToLastValue = 91;
  TelIndexPos = 14;
  TELXYPosStart = 61;
  TEL_Test_Bin = 765;  //2*256+253
  TEL_Skip_Bin = 1275; //4*256+251
  TEL_Mark_Bin = 2295; //8*256+247
  PosMaxNumber = 99999; //������������Ŀ ����10w
  Bin_0 = 0; //skip
  Bin_1 = 1;
  Bin_2 = 2;
  Bin_3 = 3;
  Bin_4 = 4;
  Bin_6 = 6;
  Bin_8 = 8;
  Bin_10 = 10;
  Bin_11 = 11;
  Bin_14 = 14;
  Bin_64 = 64;   //test
  Bin_65 = 65;
  Bin_80 = 80; //sample���
  Bin_81 = 81;
  Bin_96 = 96;
  Bin_128 = 128;    //mark
  //focus to  acco xls
  Fs_PPID_Col_Row = 'B3:B4';
  Fs_PPID_ArrPos = 1;
  Fs_Lot_WaferID_COl_Row = 'G2:G4';
  Fs_Lot_ArrPos = 0;
  Fs_WaferId_ArrPos = 1;
  Fs_Title_Col_Row = 'F12:BA13';
  Fs_Limit_Col_Row = 'F16:BA13';
  Fs_Data_Col_Row = 'F24:BA65535';
  Fs_Pos_Range = 'C24:D65535';
  WatCenterBin = 80;
  WatMarkBin = 0;
  WatNormalBin = 64;
  //wat folder name

var
  XIndexPosArr: array of Integer;
  YIndexPosArr: array of Integer;
  BinArr: array of Integer;
  XColumns, YRows: Integer;
  XStartPos, XEndPos, YStartPos, YEndPos: Integer;
  YCount256: Integer;
  LastValuePos: Integer; //ĩβ���һ��0���ݵ�λ�ã�xx xx xx xx 00 00 00 00
  YFstSize: Integer; //ͷ�����ݵĳ���,4���ֽ�һ��xx xx xx xx //xx xx xx xx //mm xx xx xx//00 00 00 00   mm���ڵ�λ�á�
  YFstDirection: Integer;   //yͷ�����ݵķ���0Ϊ������1Ϊ�쳣��
  LastXYPosEndValuePos: Integer;
  PosCounts: Integer;
  XOffset, YOffset: Integer;
  MapSize: Integer = 6;
  NBSize: Integer = 4;
  SSize: Integer = 6;
  MSize: Integer = 8;
  LSize: Integer = 12;
  XLSize: Integer = 16;
  XXLSize: Integer = 20;
  CountBinArr: array of Integer;
  LastMinX, LastMaxX, LastMinY, LastMaxY: Integer;
  BrushBinArr: array of Integer;
  Pathstr: string;
  TskFileName: string;
  TSKPathStr: string;
  BrushMode: Boolean;
  SelDown, SelFirst: Boolean;

  //����Ϊtel����
  TelXColumns, TelYRows: Integer;
  TelDataArr: array of array of Integer; //����telģ��ʹ��

  TelSkipAllCount: Integer;
  TelMarkAllCount: Integer;
  TelTestAllCount: Integer;

  //����������pq������
  TelMapMaxRow, TelMapMaxColumn: Integer; //tel mapͼ����������rowΪY����columnΪx����
  TelMapPPosX, TelMapPPosY: Integer;
  //TelMapQPosX,TelMapQPosY:integer;
  TskMapPPosX, TskMapPPosY: Integer;
  //TskMapQPosX,TskMapQPosY:Integer;//tel tsk pq������
  QData: Boolean = False; //Q�����ݣ����ֻ��p����Ϊfalse����Ϊtrue��Ĭ��Ϊfalse
  ShiftXPos, ShiftYPos: Integer;
  ReadColumnsMax, ReadRowsMax: Integer;
  SysSavePath: string;
  //���������⹦������
  TelPosArrNew: array of array of Integer; //���posģ���Ƿ���Թ��ܵ���������
  IsTelDataClear, IsCanDraw: Boolean;  //ˢ��tel���ص����ݣ����سɹ�xls����
  IsXlsx: Boolean; //xls 65536 xlsx 100w lines
  F2A_Xpos, F2A_Ypos: array of Integer;
  OneSheetRow: Integer;   //��������ж�������Ч����

  //����Ϊxls�����ļ�����telģ���ļ���������
  XlsPPointX, XlsPPointY: Integer; //�����ļ�p���С�������
  XlsTelPPointX, XlsTelPPointY: Integer; //����ת�����ǵ�TELģ���P���С�������

  //������wat��Ĺ�������
  WatCenterX, WatCenterY, WatCenterCol, WatCenterRow: Integer; //�������ĵ������
  WatCenterFind: Boolean; //���ĵ�bin80�Ƿ�ΪΨһ�Ҵ���
  TempColDisMin, TempColDisMax, TempRowDisMin, TempRowDisMax: Integer; //ʹ�ô�ֵ����¼�Ǹ�die������die�ľ��������������normal bin���ĸ���

  //������FTP��Ĺ�������
  FtpD2IP: string; //ftp ip
  FtpUser, FtpPwd{, FtpPort}: string; //ftp user pwd port
  FtpPathProd, FtpPathEng, FtpPathEtc: string; //prod eng ecc ·��
  ProdLimit, ProdDie, {ProdPrb,} ProdTst, ProdWaf: TStrings; //prod file
  EngLimit, EngDie, {EngPrb,} EngTst, EngWaf: TStrings; //eng file
  WatTestPlanProd, WatTestPlanEng: TStrings; //test plan
  FolderLimit, FolderDie, FolderTst, FolderWaf: string;
  PilProdFileName: string; //pil_prod file name
  PilEngFileName: string; //pil_ENG file name
  WatFilePath: string; //wat file download adjust path

implementation

end.

