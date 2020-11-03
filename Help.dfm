object Form14: TForm14
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #24110#21161#35828#26126
  ClientHeight = 265
  ClientWidth = 392
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
  object lst1: TListBox
    Left = 0
    Top = 0
    Width = 121
    Height = 257
    ItemHeight = 13
    TabOrder = 0
    OnMouseUp = lst1MouseUp
  end
  object mmo1: TMemo
    Left = 127
    Top = 0
    Width = 257
    Height = 257
    Lines.Strings = (
      'mmo1')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
