object Form6: TForm6
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'TEL'#27169#26495#21152#36733
  ClientHeight = 353
  ClientWidth = 529
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
  object pgc1: TPageControl
    Left = 8
    Top = 8
    Width = 513
    Height = 337
    ActivePage = ts1
    TabOrder = 0
    TabStop = False
    object ts1: TTabSheet
      Caption = #21152#36733#27169#26495#25214#23547#28431#28857
      object lbl1: TLabel
        Left = 8
        Top = 94
        Width = 86
        Height = 13
        Caption = 'TELMAP'#26368#22823#21015#25968
      end
      object lbl2: TLabel
        Left = 8
        Top = 121
        Width = 86
        Height = 13
        Caption = 'TELMAP'#26368#22823#34892#25968
      end
      object btn1: TButton
        Left = 8
        Top = 0
        Width = 213
        Height = 48
        Caption = #28857#20987#21152#36733'TEL'#27169#26495
        TabOrder = 0
        OnClick = btn1Click
      end
      object btn2: TButton
        Left = 146
        Top = 145
        Width = 75
        Height = 25
        Caption = #30830#23450
        Enabled = False
        TabOrder = 1
        OnClick = btn2Click
      end
      object edt1: TEdit
        Left = 100
        Top = 91
        Width = 121
        Height = 21
        TabOrder = 2
      end
      object edt2: TEdit
        Left = 100
        Top = 118
        Width = 121
        Height = 21
        TabOrder = 3
      end
      object edt3: TEdit
        Left = 8
        Top = 54
        Width = 213
        Height = 21
        Enabled = False
        TabOrder = 4
      end
    end
    object ts2: TTabSheet
      Caption = #27979#35797#25968#25454#35206#30422'tel'#27169#26495#25991#20214
      ImageIndex = 1
      object lbl3: TLabel
        Left = 7
        Top = 8
        Width = 102
        Height = 13
        Caption = #27979#35797#25991#20214'P'#28857#21015#22352#26631
      end
      object lbl4: TLabel
        Left = 256
        Top = 8
        Width = 102
        Height = 13
        Caption = #27979#35797#25991#20214'P'#28857#34892#22352#26631
      end
      object lbl5: TLabel
        Left = 7
        Top = 35
        Width = 95
        Height = 13
        Caption = 'TEL'#27169#26495'P'#28857#21015#22352#26631
      end
      object lbl6: TLabel
        Left = 256
        Top = 35
        Width = 95
        Height = 13
        Caption = 'TEL'#27169#26495'P'#28857#34892#22352#26631
      end
      object lbl7: TLabel
        Left = 7
        Top = 63
        Width = 62
        Height = 13
        Caption = 'Tel'#26368#22823#21015#25968
      end
      object lbl8: TLabel
        Left = 256
        Top = 63
        Width = 62
        Height = 13
        Caption = 'Tel'#26368#22823#34892#25968
      end
      object mmo1: TMemo
        Left = 3
        Top = 168
        Width = 499
        Height = 137
        Lines.Strings = (
          'mmo1')
        ScrollBars = ssVertical
        TabOrder = 8
      end
      object edt5: TEdit
        Left = 122
        Top = 5
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object edt6: TEdit
        Left = 381
        Top = 5
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object edt7: TEdit
        Left = 122
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 2
      end
      object edt8: TEdit
        Left = 381
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 3
      end
      object btn3: TButton
        Left = 3
        Top = 87
        Width = 499
        Height = 48
        Caption = #27979#35797#25968#25454#35206#30422'TEL'#27169#26495#25968#25454#65292#35831#35880#24910#20351#29992#65281'TEL'#34892#21015#25968#35831#21153#24517#27491#30830#12290
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = btn3Click
      end
      object edt4: TEdit
        Left = 122
        Top = 60
        Width = 121
        Height = 21
        TabOrder = 4
      end
      object edt9: TEdit
        Left = 381
        Top = 60
        Width = 121
        Height = 21
        TabOrder = 5
      end
      object edt10: TEdit
        Left = 3
        Top = 141
        Width = 499
        Height = 21
        Enabled = False
        TabOrder = 7
      end
    end
  end
end
