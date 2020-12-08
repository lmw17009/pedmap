object Form12: TForm12
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'ProbeCardSize'
  ClientHeight = 691
  ClientWidth = 794
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
  object scrlbx1: TScrollBox
    Left = 0
    Top = 0
    Width = 794
    Height = 691
    Align = alClient
    TabOrder = 0
    object trckbr1: TTrackBar
      Left = 646
      Top = 6
      Width = 141
      Height = 45
      Max = 20
      Min = 5
      ParentShowHint = False
      Position = 10
      ShowHint = False
      ShowSelRange = False
      TabOrder = 0
      OnChange = trckbr1Change
    end
    object btnClear: TButton
      Left = 606
      Top = 33
      Width = 42
      Height = 21
      Caption = #28165#38500
      TabOrder = 1
      OnClick = btnClearClick
    end
  end
  object edt1: TEdit
    Left = 8
    Top = 8
    Width = 100
    Height = 21
    TabOrder = 1
    Text = '1000.2000'
    OnClick = edt1Click
  end
  object edt2: TEdit
    Left = 108
    Top = 8
    Width = 100
    Height = 21
    TabOrder = 2
    Text = '3000.2500'
    OnClick = edt2Click
  end
  object edt3: TEdit
    Left = 208
    Top = 8
    Width = 100
    Height = 21
    TabOrder = 3
    Text = '1500.2600'
    OnClick = edt3Click
  end
  object edt4: TEdit
    Left = 308
    Top = 8
    Width = 100
    Height = 21
    TabOrder = 4
    Text = '6000.3050'
    OnClick = edt4Click
  end
  object edt5: TEdit
    Left = 408
    Top = 8
    Width = 100
    Height = 21
    TabOrder = 5
    Text = '4500.3500'
    OnClick = edt5Click
  end
  object edt6: TEdit
    Left = 514
    Top = 8
    Width = 100
    Height = 21
    TabOrder = 6
    Text = '6010.3010'
    OnClick = edt6Click
  end
  object btnDraw: TButton
    Left = 608
    Top = 8
    Width = 42
    Height = 21
    Caption = #32472#21046
    TabOrder = 7
    OnClick = btnDrawClick
  end
  object mmo1: TMemo
    Left = 8
    Top = 99
    Width = 49
    Height = 30
    Lines.Strings = (
      'mm'
      'o1')
    ScrollBars = ssVertical
    TabOrder = 8
    Visible = False
  end
end
