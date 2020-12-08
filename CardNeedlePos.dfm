object Form17: TForm17
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'CardNeedlePos'
  ClientHeight = 971
  ClientWidth = 1194
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 24
    Top = 11
    Width = 48
    Height = 13
    Caption = #38024#21345#23610#23544
  end
  object lbl2: TLabel
    Left = 208
    Top = 11
    Width = 44
    Height = 13
    Caption = 'PAD'#23610#23544
  end
  object lbl3: TLabel
    Left = 383
    Top = 13
    Width = 80
    Height = 13
    Caption = 'PAD'#24038#19978#35282#20301#32622
  end
  object imgScale: TImage
    Left = 1008
    Top = 334
    Width = 100
    Height = 100
  end
  object edtCardSize: TEdit
    Left = 85
    Top = 8
    Width = 100
    Height = 21
    TabOrder = 0
    Text = '800.600'
  end
  object edtPadSize: TEdit
    Left = 269
    Top = 8
    Width = 100
    Height = 21
    TabOrder = 1
    Text = '200.200'
  end
  object btnDraw: TButton
    Left = 567
    Top = 8
    Width = 75
    Height = 21
    Caption = #32472#21046
    TabOrder = 3
    OnClick = btnDrawClick
  end
  object edtPosShow: TEdit
    Left = 1008
    Top = 440
    Width = 129
    Height = 21
    Enabled = False
    TabOrder = 2
  end
  object edtPadPos: TEdit
    Left = 461
    Top = 8
    Width = 100
    Height = 21
    TabOrder = 4
    Text = '0.0'
  end
  object mmo1: TMemo
    Left = 1000
    Top = 30
    Width = 200
    Height = 267
    Lines.Strings = (
      'mmo1')
    TabOrder = 5
  end
  object btnCLear: TButton
    Left = 1008
    Top = 303
    Width = 65
    Height = 25
    Caption = #28165#38500
    TabOrder = 6
    OnClick = btnCLearClick
  end
  object trckbr1: TTrackBar
    Left = 648
    Top = 8
    Width = 150
    Height = 33
    Max = 100
    Min = 10
    Position = 10
    ShowSelRange = False
    TabOrder = 7
    OnChange = trckbr1Change
  end
  object edtNeedleSize: TEdit
    Left = 804
    Top = 8
    Width = 37
    Height = 21
    Enabled = False
    TabOrder = 8
    Text = '10'
  end
  object rbDrawNeedle: TRadioButton
    Left = 1024
    Top = 467
    Width = 113
    Height = 17
    Caption = #38024#23574#32472#22270#27169#24335
    Checked = True
    TabOrder = 9
    TabStop = True
  end
  object rbMeasure: TRadioButton
    Left = 1024
    Top = 490
    Width = 113
    Height = 17
    Caption = #27979#37327#27169#24335
    TabOrder = 10
  end
  object chkShowPos: TCheckBox
    Left = 1024
    Top = 513
    Width = 97
    Height = 17
    Caption = #26174#31034#27979#37327#22352#26631
    TabOrder = 11
  end
end
