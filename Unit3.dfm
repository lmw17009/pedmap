object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20445#23384'Tel'#22352#26631
  ClientHeight = 407
  ClientWidth = 744
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
  object lbl1: TLabel
    Left = 449
    Top = 47
    Width = 82
    Height = 13
    Caption = 'TelMap'#26368#22823#21015#25968
  end
  object lbl2: TLabel
    Left = 449
    Top = 87
    Width = 82
    Height = 13
    Caption = 'TelMap'#26368#22823#34892#25968
  end
  object btn1: TButton
    Left = 81
    Top = 371
    Width = 120
    Height = 33
    Hint = #36873#25321#21253#21547'TEL'#27169#26495#30340#25991#20214#22841#36827#34892#26816#32034#65288#38656#35201'apl'#21644'map'#20108#20010#25991#20214#22312#19968#36215#65289
    Caption = #36873#25321#25991#20214#22841#36827#34892#26816#32034
    TabOrder = 0
    OnClick = btn1Click
    OnMouseEnter = btn1MouseEnter
  end
  object TelSaveColumn: TEdit
    Left = 545
    Top = 47
    Width = 65
    Height = 21
    NumbersOnly = True
    TabOrder = 1
  end
  object TelSaveRow: TEdit
    Left = 545
    Top = 84
    Width = 65
    Height = 21
    NumbersOnly = True
    TabOrder = 2
  end
  object Log: TMemo
    Left = 415
    Top = 161
    Width = 321
    Height = 204
    Lines.Strings = (
      'Log')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object lv1: TListView
    Left = 8
    Top = 30
    Width = 401
    Height = 335
    Columns = <
      item
        Caption = 'Name'
        Width = 120
      end
      item
        Alignment = taCenter
        Caption = 'Size'
      end
      item
        Alignment = taCenter
        Caption = 'X'
      end
      item
        Alignment = taCenter
        Caption = 'Y'
      end
      item
        Alignment = taCenter
        Caption = #21015#25968
      end
      item
        Caption = #34892#25968
      end>
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 4
    OnClick = lv1Click
  end
  object btn2: TButton
    Left = 224
    Top = 371
    Width = 113
    Height = 33
    Hint = #34892#21015#25968#19981#20026'X'#21017#33021#27491#24120#23548#20986
    Caption = #19968#38190#23548#20986#22352#26631#25991#20214
    TabOrder = 5
    OnClick = btn2Click
    OnMouseEnter = btn2MouseEnter
  end
  object btn3: TButton
    Left = 471
    Top = 122
    Width = 234
    Height = 33
    Hint = #34892#21015#25968#26174#31034'X'#21017#38656#35201#25163#21160#36755#34892#21015#25968#36827#34892#23548#20986#12290
    Caption = #36873#23450#25991#20214#25163#21160#23548#20986#22352#26631
    TabOrder = 6
    OnClick = btn3Click
    OnMouseEnter = btn3MouseEnter
  end
  object SelNameEdit: TEdit
    Left = 431
    Top = 3
    Width = 305
    Height = 21
    ReadOnly = True
    TabOrder = 7
  end
  object CheckPath: TEdit
    Left = 8
    Top = 3
    Width = 401
    Height = 21
    ReadOnly = True
    TabOrder = 8
  end
  object btn4: TButton
    Left = 343
    Top = 371
    Width = 106
    Height = 33
    Caption = #25171#24320#20445#23384#36335#24452
    TabOrder = 9
    OnClick = btn4Click
  end
end
