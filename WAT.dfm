object Form9: TForm9
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Wat'#21442#25968#35774#32622
  ClientHeight = 102
  ClientWidth = 185
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
    Left = 8
    Top = 12
    Width = 34
    Height = 13
    Caption = 'XIndex'
  end
  object lbl2: TLabel
    Left = 8
    Top = 43
    Width = 34
    Height = 13
    Caption = 'YIndex'
  end
  object edtXIndex: TEdit
    Left = 48
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edtYIndex: TEdit
    Left = 48
    Top = 39
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object btn1: TButton
    Left = 112
    Top = 66
    Width = 58
    Height = 25
    Caption = #30830#23450
    TabOrder = 2
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 48
    Top = 66
    Width = 58
    Height = 25
    Caption = #28165#38500
    TabOrder = 3
    OnClick = btn2Click
  end
end
