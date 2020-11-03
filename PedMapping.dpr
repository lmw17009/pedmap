program PedMapping;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Global in 'Global.pas',
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Update in 'Update.pas',
  Unit5 in 'Unit5.pas' {Form5},
  Unit6 in 'Unit6.pas' {Form6},
  Unit7 in 'Unit7.pas' {Form7},
  Unit8 in 'Unit8.pas' {Form8},
  WAT in 'WAT.pas' {Form9},
  Limit in 'Limit.pas' {Form10},
  FTP in 'FTP.pas' {Form11},
  WatLimit in 'WatLimit.pas' {WatLimitMain},
  WatLimitEdit in 'WatLimitEdit.pas' {WatEdit},
  XlsReName in 'XlsReName.pas' {Form12},
  XlsSetup in 'XlsSetup.pas' {Form13},
  JsonAdjust in 'JsonAdjust.pas',
  Help in 'Help.pas' {Form14};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm10, Form10);
  Application.CreateForm(TForm11, Form11);
  Application.CreateForm(TWatLimitMain, WatLimitMain);
  Application.CreateForm(TWatEdit, WatEdit);
  Application.CreateForm(TForm12, Form12);
  Application.CreateForm(TForm13, Form13);
  Application.CreateForm(TForm14, Form14);
  Application.Run;
end.

