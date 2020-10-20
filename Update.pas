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
interface

implementation

end.

