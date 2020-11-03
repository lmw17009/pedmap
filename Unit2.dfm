object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #36716#25442#30028#38754
  ClientHeight = 251
  ClientWidth = 366
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 9
    Width = 82
    Height = 13
    Caption = 'TelMap'#26368#22823#21015#25968
  end
  object Label1: TLabel
    Left = 8
    Top = 36
    Width = 82
    Height = 13
    Caption = 'TelMap'#26368#22823#34892#25968
  end
  object lbl2: TLabel
    Left = 8
    Top = 63
    Width = 62
    Height = 13
    Caption = 'TelP'#28857#22352#26631'X'
  end
  object Label3: TLabel
    Left = 8
    Top = 117
    Width = 96
    Height = 13
    Caption = 'TskMap'#22270'P'#28857#22352#26631'X'
  end
  object lbl3: TLabel
    Left = 8
    Top = 90
    Width = 62
    Height = 13
    Caption = 'TelP'#28857#22352#26631'Y'
  end
  object lbl4: TLabel
    Left = 8
    Top = 144
    Width = 96
    Height = 13
    Caption = 'TskMap'#22270'P'#28857#22352#26631'Y'
  end
  object lbl5: TLabel
    Left = 199
    Top = 23
    Width = 52
    Height = 13
    Caption = 'ShiftX'#20559#31227
  end
  object lbl6: TLabel
    Left = 199
    Top = 50
    Width = 52
    Height = 13
    Caption = 'ShiftY'#20559#31227
  end
  object lbl7: TLabel
    Left = 200
    Top = 76
    Width = 140
    Height = 69
    Caption = 'shift'#20559#31227#20540#29992#20110#23454#38469'PQ'#28857#13#10#20559#31227#65292#40664#35748#65288'0'#65292'0'#65289#65292#36127#13#10#20540#20026'TSK'#30340'PQ'#28857#24448#24038#24448#19978#65292#13#10#27491#20540#20026'TSK'#30340'PQ'#28857#24448#21491#24448#19979#13#10#12290
  end
  object TelXIndex: TEdit
    Left = 115
    Top = 6
    Width = 65
    Height = 21
    NumbersOnly = True
    TabOrder = 0
  end
  object TelYIndex: TEdit
    Left = 115
    Top = 33
    Width = 65
    Height = 21
    NumbersOnly = True
    TabOrder = 1
  end
  object TelPPosX: TEdit
    Left = 115
    Top = 60
    Width = 65
    Height = 21
    NumbersOnly = True
    TabOrder = 2
  end
  object TskPPosX: TEdit
    Left = 115
    Top = 114
    Width = 65
    Height = 21
    NumbersOnly = True
    TabOrder = 4
  end
  object LoadTelDataBtn: TButton
    Left = 8
    Top = 177
    Width = 340
    Height = 57
    Caption = #28857#20987#21152#36733'TELMap'#25968#25454
    TabOrder = 6
    OnClick = LoadTelDataBtnClick
  end
  object TelPPosY: TEdit
    Left = 115
    Top = 87
    Width = 65
    Height = 21
    TabOrder = 3
  end
  object TskPPosY: TEdit
    Left = 115
    Top = 141
    Width = 64
    Height = 21
    TabOrder = 5
  end
  object ShiftX: TEdit
    Left = 259
    Top = 20
    Width = 57
    Height = 21
    TabOrder = 7
    Text = '0'
  end
  object ShiftY: TEdit
    Left = 259
    Top = 47
    Width = 57
    Height = 21
    TabOrder = 8
    Text = '0'
  end
end
