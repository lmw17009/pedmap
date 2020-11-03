unit Update;

//1,修复listview空白点击会报错的故障。Assigned(list.selected)=true
//2,修复打开索引目录错误。SelectDirectory('选择文件提取路径', '', Str)
//3,修复打开保存路径的错误。ShellExecute(Handle, 'open', 'Explorer.exe', PChar(GetCurrentDir), nil, SW_NORMAL);
//2020-3-09 v1.1
//  修改了UI，增加了部分操作提示。
//  增加了测试数据对比模版的功能，可以轻松找到测试数据坐标里面与模版不同的地方。
//  acco的大型文件为二个dut文件合并，检测到四个表就使用合并的模式，另外65536的模式 xls，如果是xlsx的格式则为99999上限
//2020-3-27 v1.2
//修复了focus二个文件拼合表头不识别的异常。
//2020-4-07 v1.3
//新增功能：从xls数据导会tel controlmap数据

//新增wat检测tst die wfer limit文件等功能
//新增cp测试数据重复点筛选功能

//V20201103
//新增TSK sample mark功能，将test转成sample方便机台根据点位设计移动路线，需在勾选参数下打勾TSKSample，保存文件则自动转换，缺省未开启，本功能需更改机台设置。
//新增help窗体，对一些功能进行提示说明。
//新增保存文件提示，如未备份文件成功则提示用户是否继续操作。

interface

const
  HelpSample = '如果勾选TSKSample功能，则会将MAP标记中的test编程sample，方便机台自行设计走位模式。';
  TEl2TSK = '必须先有TEL的control map数据，再把产品在TSK机台上新建一个产品档，只需要做四边和PQ点，并记下PQ点再屏幕上的坐标显示，然后将产品档拷贝出来加载入本软件，灌入tel的control数据，以PQ点对齐两套map坐标。';
  WATFtp = '主要使用它来检测一个产品在prod或者eng目录下的连接文件是否完整tst die waf limit文件，以及查看tst文件内需要测试的某一项功能是否被打开。';
  ReTest = '检测xls中重复坐标，以绘图的方式，可以单独呈现也可以比对control map的数据是否一致。';
  WatLimit = '一键生成wat limit文件，支持随意删除，移动位置。';

implementation

end.

