object Form12: TForm12
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #37325#21629#21517
  ClientHeight = 254
  ClientWidth = 559
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
  object edtCheckPath: TEdit
    Left = 8
    Top = 8
    Width = 465
    Height = 21
    TabOrder = 0
  end
  object btnAddpath: TButton
    Left = 479
    Top = 8
    Width = 72
    Height = 25
    Caption = #28155#21152#36335#24452
    TabOrder = 1
    OnClick = btnAddpathClick
  end
  object btnOpenFile: TButton
    Left = 479
    Top = 39
    Width = 75
    Height = 25
    Caption = #25171#24320#25991#20214
    TabOrder = 2
    OnClick = btnOpenFileClick
  end
  object mmo1: TMemo
    Left = 8
    Top = 35
    Width = 465
    Height = 209
    Lines.Strings = (
      'mmo1')
    TabOrder = 3
  end
  object dlgOpen1: TOpenDialog
    Left = 376
    Top = 56
  end
  object flpndlg1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = []
    Left = 376
    Top = 128
  end
end
