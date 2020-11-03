object WatEdit: TWatEdit
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'WatEdit'
  ClientHeight = 22
  ClientWidth = 162
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object edt1: TEdit
    Left = 0
    Top = 0
    Width = 161
    Height = 21
    BevelInner = bvSpace
    TabOrder = 0
    OnKeyUp = edt1KeyUp
  end
end
