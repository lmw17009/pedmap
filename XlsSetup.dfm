object Form13: TForm13
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #35774#32622
  ClientHeight = 380
  ClientWidth = 479
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
    Left = 392
    Top = 280
    Width = 30
    Height = 16
    Caption = 'JUNO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 392
    Top = 312
    Width = 33
    Height = 16
    Caption = 'Focus'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 392
    Top = 344
    Width = 27
    Height = 16
    Caption = 'Acco'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object chkJuno: TCheckBox
    Left = 240
    Top = 281
    Width = 73
    Height = 17
    Caption = 'chkJuno'
    TabOrder = 0
  end
  object chkFocus: TCheckBox
    Left = 240
    Top = 313
    Width = 73
    Height = 17
    Caption = 'chkFocus'
    TabOrder = 1
  end
  object chkAcco: TCheckBox
    Left = 240
    Top = 345
    Width = 73
    Height = 17
    Caption = 'chkAcco'
    TabOrder = 2
  end
  object lst1: TListBox
    Left = -1
    Top = 0
    Width = 121
    Height = 201
    ItemHeight = 13
    TabOrder = 3
    OnMouseUp = lst1MouseUp
  end
  object mmo1: TMemo
    Left = 126
    Top = 0
    Width = 185
    Height = 201
    Lines.Strings = (
      'mmo1')
    TabOrder = 4
  end
end
