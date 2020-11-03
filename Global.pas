unit Global;

interface

uses
  System.Classes;

const
  Version = ' V20201103';//版本号，
  XYPosOffsetToLastValue = 91;
  TelIndexPos = 14;
  TELXYPosStart = 61;
  TEL_Test_Bin = 765;  //2*256+253
  TEL_Skip_Bin = 1275; //4*256+251
  TEL_Mark_Bin = 2295; //8*256+247
  PosMaxNumber = 99999; //最大的坐标检测数目 上限10w
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
  Bin_80 = 80; //sample标记
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
  LastValuePos: Integer; //末尾最后一个0数据的位置，xx xx xx xx 00 00 00 00
  YFstSize: Integer; //头部数据的长度,4个字节一组xx xx xx xx //xx xx xx xx //mm xx xx xx//00 00 00 00   mm处于的位置。
  YFstDirection: Integer;   //y头部数据的方向，0为正常，1为异常。
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

  //以下为tel数据
  TelXColumns, TelYRows: Integer;
  TelDataArr: array of array of Integer; //加载tel模板使用

  TelSkipAllCount: Integer;
  TelMarkAllCount: Integer;
  TelTestAllCount: Integer;

  //以下是新增pq点数据
  TelMapMaxRow, TelMapMaxColumn: Integer; //tel map图最大的行列数row为Y坐标column为x坐标
  TelMapPPosX, TelMapPPosY: Integer;
  //TelMapQPosX,TelMapQPosY:integer;
  TskMapPPosX, TskMapPPosY: Integer;
  //TskMapQPosX,TskMapQPosY:Integer;//tel tsk pq点坐标
  QData: Boolean = False; //Q点数据，如果只有p点则为false否则为true，默认为false
  ShiftXPos, ShiftYPos: Integer;
  ReadColumnsMax, ReadRowsMax: Integer;
  SysSavePath: string;
  //新增坐标检测功能数据
  TelPosArrNew: array of array of Integer; //检测pos模块是否测试功能的坐标数组
  IsTelDataClear, IsCanDraw: Boolean;  //刷新tel加载的数据，加载成功xls数据
  IsXlsx: Boolean; //xls 65536 xlsx 100w lines
  F2A_Xpos, F2A_Ypos: array of Integer;
  OneSheetRow: Integer;   //单个表格有多少行有效数据

  //以下为xls测试文件覆盖tel模板文件功能数据
  XlsPPointX, XlsPPointY: Integer; //测试文件p点列、行坐标
  XlsTelPPointX, XlsTelPPointY: Integer; //将被转换覆盖的TEL模板的P点列、行坐标

  //以下是wat类的功能数据
  WatCenterX, WatCenterY, WatCenterCol, WatCenterRow: Integer; //储存中心点的坐标
  WatCenterFind: Boolean; //中心点bin80是否为唯一且存在
  TempColDisMin, TempColDisMax, TempRowDisMin, TempRowDisMax: Integer; //使用此值来记录那个die与中心die的距离最近，用来找normal bin的四个边

  //以下是FTP类的功能数据
  FtpD2IP: string; //ftp ip
  FtpUser, FtpPwd{, FtpPort}: string; //ftp user pwd port
  FtpPathProd, FtpPathEng, FtpPathEtc: string; //prod eng ecc 路径
  ProdLimit, ProdDie, {ProdPrb,} ProdTst, ProdWaf: TStrings; //prod file
  EngLimit, EngDie, {EngPrb,} EngTst, EngWaf: TStrings; //eng file
  WatTestPlanProd, WatTestPlanEng: TStrings; //test plan
  FolderLimit, FolderDie, FolderTst, FolderWaf: string;
  PilProdFileName: string; //pil_prod file name
  PilEngFileName: string; //pil_ENG file name
  WatFilePath: string; //wat file download adjust path

implementation

end.

