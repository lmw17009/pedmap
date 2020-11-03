object Form13: TForm13
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #35774#32622
  ClientHeight = 542
  ClientWidth = 378
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
  object lbl4: TLabel
    Left = 126
    Top = 8
    Width = 71
    Height = 13
    Caption = 'PPID'#25152#22312#20301#32622
  end
  object lbl5: TLabel
    Left = 126
    Top = 49
    Width = 74
    Height = 13
    Caption = 'LotID'#25152#22312#20301#32622
  end
  object lbl6: TLabel
    Left = 126
    Top = 90
    Width = 89
    Height = 13
    Caption = 'WaferID'#25152#22312#20301#32622
  end
  object lbl7: TLabel
    Left = 126
    Top = 131
    Width = 48
    Height = 13
    Caption = #26368#23569#34920#25968
  end
  object lbl8: TLabel
    Left = 126
    Top = 172
    Width = 48
    Height = 13
    Caption = #26368#22823#34920#25968
  end
  object lbl9: TLabel
    Left = 126
    Top = 213
    Width = 72
    Height = 13
    Caption = #21019#24314#26102#38388#20301#32622
  end
  object lbl10: TLabel
    Left = 126
    Top = 254
    Width = 60
    Height = 13
    Caption = #26631#24535#24615#34920#21517
  end
  object lbl11: TLabel
    Left = 126
    Top = 295
    Width = 72
    Height = 13
    Caption = #26631#24535#34920#21517#21306#20998
  end
  object lst1: TListBox
    Left = -1
    Top = 0
    Width = 121
    Height = 201
    ItemHeight = 13
    TabOrder = 0
    OnMouseUp = lst1MouseUp
  end
  object mmo1: TMemo
    Left = -2
    Top = 199
    Width = 122
    Height = 145
    Lines.Strings = (
      'mmo1')
    TabOrder = 1
  end
  object edtPPID: TEdit
    Left = 240
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edtLot: TEdit
    Left = 240
    Top = 46
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object edtWaferID: TEdit
    Left = 240
    Top = 87
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object edtMinTables: TEdit
    Left = 240
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object edtMaxTables: TEdit
    Left = 240
    Top = 169
    Width = 121
    Height = 21
    TabOrder = 6
  end
  object edtCreateTime: TEdit
    Left = 240
    Top = 210
    Width = 121
    Height = 21
    TabOrder = 7
  end
  object edtDiffTables: TEdit
    Left = 240
    Top = 251
    Width = 121
    Height = 21
    TabOrder = 8
  end
  object edtDiffBool: TEdit
    Left = 240
    Top = 292
    Width = 121
    Height = 21
    TabOrder = 9
  end
  object btnUpdate: TButton
    Left = 286
    Top = 319
    Width = 75
    Height = 25
    Caption = #26356#26032
    TabOrder = 10
    OnClick = btnUpdateClick
  end
  object btnUnlock: TButton
    Left = 182
    Top = 319
    Width = 75
    Height = 25
    Caption = #35299#38145
    TabOrder = 11
  end
end
