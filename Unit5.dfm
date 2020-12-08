object Form5: TForm5
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22352#26631#26816#27979
  ClientHeight = 491
  ClientWidth = 926
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object imgScreen: TImage
    Left = 8
    Top = 291
    Width = 100
    Height = 100
  end
  object lbl1: TLabel
    Left = 114
    Top = 368
    Width = 12
    Height = 13
    Caption = 'X5'
  end
  object lbl2: TLabel
    Left = 180
    Top = 368
    Width = 18
    Height = 13
    Caption = 'X15'
  end
  object btn1: TButton
    Left = 8
    Top = 428
    Width = 190
    Height = 25
    Caption = #21152#36733'TEL'#27169#26495
    Enabled = False
    TabOrder = 0
    OnClick = btn1Click
  end
  object mmo3: TMemo
    Left = 8
    Top = 64
    Width = 190
    Height = 221
    Lines.Strings = (
      'mmo2')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object scrlbx1: TScrollBox
    Left = 204
    Top = 8
    Width = 714
    Height = 447
    TabOrder = 2
  end
  object btn3: TButton
    Left = 8
    Top = 397
    Width = 190
    Height = 25
    Caption = #32472#21046
    Enabled = False
    TabOrder = 3
    OnClick = btn3Click
  end
  object trckbr1: TTrackBar
    Left = 114
    Top = 336
    Width = 84
    Height = 31
    Enabled = False
    Max = 15
    Min = 5
    ParentShowHint = False
    Position = 5
    ShowHint = False
    ShowSelRange = False
    TabOrder = 4
    OnChange = trckbr1Change
  end
  object edt1: TEdit
    Left = 114
    Top = 291
    Width = 84
    Height = 21
    Enabled = False
    TabOrder = 5
  end
  object btn6: TButton
    Left = 120
    Top = 8
    Width = 78
    Height = 25
    Caption = #28165#38500'LOG'
    TabOrder = 6
    OnClick = btn6Click
  end
  object btn7: TButton
    Left = 8
    Top = 8
    Width = 106
    Height = 25
    Caption = #21152#36733#27979#35797#25968#25454
    TabOrder = 7
    OnClick = btn7Click
  end
  object btn2: TButton
    Left = 8
    Top = 456
    Width = 190
    Height = 25
    Caption = #37325#22797#28857#31579#36873
    Enabled = False
    TabOrder = 8
    OnClick = btn2Click
  end
  object btn4: TButton
    Left = 8
    Top = 33
    Width = 106
    Height = 25
    Caption = #25163#21160#35299#26512#22352#26631
    TabOrder = 9
    OnClick = btn4Click
  end
  object btnClear: TButton
    Left = 120
    Top = 33
    Width = 75
    Height = 25
    Caption = #28165#38500
    TabOrder = 10
    OnClick = btnClearClick
  end
  object Conn1: TFDConnection
    Params.Strings = (
      'DataSource=Excel Files'
      
        'Database=D:\Lidashi\dephixeproject\tskmap\tskmap\Win32\Debug\3.x' +
        'ls'
      'DriverID=ODBC')
    LoginPrompt = False
    Left = 400
    Top = 256
  end
  object Qry1: TFDQuery
    Connection = Conn1
    Left = 624
    Top = 248
  end
  object fdphysdbcdrvrlnk1: TFDPhysODBCDriverLink
    Left = 536
    Top = 312
  end
end
