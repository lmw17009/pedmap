object Form15: TForm15
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Map'#21442#25968#35774#32622
  ClientHeight = 771
  ClientWidth = 1008
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
  object edtChipX: TEdit
    Left = 783
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edtChipY: TEdit
    Left = 783
    Top = 35
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edt3: TEdit
    Left = 783
    Top = 62
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edt4: TEdit
    Left = 783
    Top = 89
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object btn1: TButton
    Left = 817
    Top = 176
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 4
    OnClick = btn1Click
  end
  object grp1: TGroupBox
    Left = 0
    Top = 8
    Width = 750
    Height = 750
    Caption = #32472#22270#21306
    TabOrder = 5
    object scrlbx1: TScrollBox
      Left = 2
      Top = 15
      Width = 746
      Height = 733
      Align = alClient
      TabOrder = 0
    end
  end
  object rb1: TRadioButton
    Left = 769
    Top = 116
    Width = 34
    Height = 17
    Caption = '0'
    Checked = True
    TabOrder = 6
    TabStop = True
  end
  object rb2: TRadioButton
    Left = 801
    Top = 116
    Width = 34
    Height = 17
    Caption = '90'
    TabOrder = 7
  end
  object rb3: TRadioButton
    Left = 835
    Top = 116
    Width = 34
    Height = 17
    Caption = '180'
    TabOrder = 8
  end
  object rb4: TRadioButton
    Left = 871
    Top = 116
    Width = 34
    Height = 17
    Caption = '270'
    TabOrder = 9
  end
  object trckbr1: TTrackBar
    Left = 769
    Top = 139
    Width = 135
    Height = 45
    Max = 100
    Min = 10
    Position = 100
    TabOrder = 10
    OnChange = trckbr1Change
  end
  object mmo1: TMemo
    Left = 756
    Top = 207
    Width = 244
    Height = 202
    Lines.Strings = (
      'mmo1')
    ScrollBars = ssVertical
    TabOrder = 11
  end
end
