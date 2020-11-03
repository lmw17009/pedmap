object Form8: TForm8
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'DAT'#32534#36753
  ClientHeight = 447
  ClientWidth = 858
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
  object mmo1: TMemo
    Left = 8
    Top = 8
    Width = 241
    Height = 425
    Lines.Strings = (
      'mmo1')
    TabOrder = 0
  end
  object btn1: TButton
    Left = 487
    Top = 8
    Width = 75
    Height = 25
    Caption = #35835#21462
    TabOrder = 1
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 487
    Top = 39
    Width = 75
    Height = 25
    Caption = #26356#25913
    TabOrder = 2
  end
  object mmo2: TMemo
    Left = 255
    Top = 8
    Width = 226
    Height = 425
    Lines.Strings = (
      'mmo2')
    TabOrder = 3
  end
  object btn3: TButton
    Left = 487
    Top = 70
    Width = 75
    Height = 25
    Caption = #20445#23384
    TabOrder = 4
  end
end
