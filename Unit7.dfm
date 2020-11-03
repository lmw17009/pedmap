object Form7: TForm7
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Focus2Acco'
  ClientHeight = 520
  ClientWidth = 869
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = #25171#24320
    TabOrder = 0
    OnClick = btn1Click
  end
  object mmo1: TMemo
    Left = 8
    Top = 39
    Width = 825
    Height = 409
    Lines.Strings = (
      'mmo1')
    TabOrder = 1
  end
  object btn2: TButton
    Left = 336
    Top = 8
    Width = 75
    Height = 25
    Caption = 'btn2'
    TabOrder = 2
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 712
    Top = 8
    Width = 75
    Height = 25
    Caption = 'btn3'
    TabOrder = 3
    OnClick = btn3Click
  end
  object dlgOpen1: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 96
    Top = 40
  end
  object Conn1: TFDConnection
    Params.Strings = (
      
        'Database=D:\Lidashi\dephixeproject\tskmap\tskmap\Win32\Debug\sam' +
        'ple.xls'
      'DataSource=Excel Files'
      'DriverID=ODBC')
    LoginPrompt = False
    Left = 152
    Top = 48
  end
  object Qry1: TFDQuery
    Connection = Conn1
    Left = 232
    Top = 48
  end
  object fdphysdbcdrvrlnk1: TFDPhysODBCDriverLink
    Left = 296
    Top = 56
  end
  object con1: TADOConnection
    Left = 616
    Top = 8
  end
  object qry2: TADOQuery
    Connection = con1
    Parameters = <>
    Left = 648
    Top = 8
  end
end
