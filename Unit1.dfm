object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'PED TSK&TEL Map Edit'
  ClientHeight = 645
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Magimg1: TImage
    Left = 614
    Top = 37
    Width = 100
    Height = 100
  end
  object Label1: TLabel
    Left = 720
    Top = 41
    Width = 48
    Height = 13
    Caption = #22270#20687#22352#26631
  end
  object Label2: TLabel
    Left = 720
    Top = 68
    Width = 48
    Height = 13
    Caption = #25991#20214#22352#26631
  end
  object Memo1: TMemo
    Left = 614
    Top = 137
    Width = 275
    Height = 320
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
    OnChange = Memo1Change
  end
  object Edit1: TEdit
    Left = 772
    Top = 37
    Width = 62
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 1
  end
  object scrlbx1: TScrollBox
    Left = 8
    Top = 37
    Width = 600
    Height = 600
    HorzScrollBar.Smooth = True
    VertScrollBar.Smooth = True
    TabOrder = 2
    OnMouseWheel = scrlbx1MouseWheel
  end
  object SBtn: TButton
    Left = 32
    Top = 0
    Width = 25
    Height = 25
    Caption = 'S'
    Enabled = False
    TabOrder = 3
    OnClick = SBtnClick
  end
  object MBtn: TButton
    Left = 63
    Top = 0
    Width = 25
    Height = 25
    Caption = 'M'
    Enabled = False
    TabOrder = 4
    OnClick = MBtnClick
  end
  object LBtn: TButton
    Left = 94
    Top = 0
    Width = 25
    Height = 25
    Caption = 'L'
    Enabled = False
    TabOrder = 5
    OnClick = LBtnClick
  end
  object XLBtn: TButton
    Left = 125
    Top = 0
    Width = 25
    Height = 25
    Caption = 'XL'
    Enabled = False
    TabOrder = 6
    OnClick = XLBtnClick
  end
  object XXLBtn: TButton
    Left = 156
    Top = 0
    Width = 25
    Height = 25
    Caption = 'XXL'
    Enabled = False
    TabOrder = 7
    OnClick = XXLBtnClick
  end
  object NBBtn: TButton
    Left = 1
    Top = 0
    Width = 25
    Height = 25
    Caption = 'NB'
    Enabled = False
    TabOrder = 8
    OnClick = NBBtnClick
  end
  object Edit2: TEdit
    Left = 772
    Top = 64
    Width = 126
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 9
  end
  object ButtonGroup1: TButtonGroup
    Left = 187
    Top = -4
    Width = 78
    Height = 33
    Enabled = False
    Items = <
      item
        Caption = ' M'
        OnClick = ButtonGroup1Items0Click
      end
      item
        Caption = ' S'
        OnClick = ButtonGroup1Items1Click
      end
      item
        Caption = ' N'
        OnClick = ButtonGroup1Items2Click
      end>
    TabOrder = 10
  end
  object Edit3: TEdit
    Left = 271
    Top = 2
    Width = 13
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 11
  end
  object AllMBtn: TButton
    Left = 290
    Top = 0
    Width = 41
    Height = 25
    Caption = 'MarkAll'
    Enabled = False
    TabOrder = 12
    OnClick = AllMBtnClick
  end
  object AllNBtn: TButton
    Left = 337
    Top = 0
    Width = 50
    Height = 25
    Caption = 'NormalAll'
    Enabled = False
    TabOrder = 13
    OnClick = AllNBtnClick
  end
  object Button2: TButton
    Left = 614
    Top = 463
    Width = 57
    Height = 33
    Caption = #28165#38500#26085#24535
    Enabled = False
    TabOrder = 14
    OnClick = Button2Click
  end
  object BrushBtn: TButton
    Left = 445
    Top = 0
    Width = 65
    Height = 25
    Hint = #26694#36873#27169#24335#21644#31508#21047#27169#24335#20999#25442
    Caption = #30697#38453#27169#24335
    Enabled = False
    TabOrder = 15
    OnClick = BrushBtnClick
    OnMouseEnter = BrushBtnMouseEnter
  end
  object AllSBtn: TButton
    Left = 392
    Top = 0
    Width = 49
    Height = 25
    Caption = 'SkpiAll'
    Enabled = False
    TabOrder = 16
    OnClick = AllSBtnClick
  end
  object chkLockNormal: TCheckBox
    Left = 614
    Top = 501
    Width = 80
    Height = 17
    Caption = #38145#23450'Normal'
    TabOrder = 17
  end
  object chkLockSkip: TCheckBox
    Left = 614
    Top = 524
    Width = 80
    Height = 17
    Caption = #38145#23450'Skip'
    TabOrder = 18
  end
  object chkLockMark: TCheckBox
    Left = 614
    Top = 547
    Width = 80
    Height = 17
    Caption = #38145#23450'Mark'
    TabOrder = 19
  end
  object dlgOpen1: TOpenDialog
    Left = 80
    Top = 40
  end
  object mm1: TMainMenu
    Left = 112
    Top = 40
    object N1: TMenuItem
      Caption = #25171#24320'(&O)'
      object F1: TMenuItem
        Caption = #25991#20214'(&F)'
        OnClick = F1Click
      end
      object N5: TMenuItem
        Caption = #20445#23384#25991#20214'(&S)'
        Enabled = False
        OnClick = N5Click
      end
      object E1: TMenuItem
        Caption = #36864#20986'(&E)'
        OnClick = E1Click
      end
    end
    object N2: TMenuItem
      Caption = #25805#20316
      object N4: TMenuItem
        Caption = #22352#26631#26816#27979
        OnClick = N4Click
      end
      object EL1: TMenuItem
        Caption = #20351#29992'TEL'#27169#26495
        Enabled = False
        OnClick = EL1Click
      end
      object EL2: TMenuItem
        Caption = #20445#23384'TEL'#27979#35797#22352#26631
        Enabled = False
        OnClick = EL2Click
      end
      object Focus2Accodata1: TMenuItem
        Caption = 'Focus2Acco-data'
        OnClick = Focus2Accodata1Click
      end
      object Dat1: TMenuItem
        Caption = 'Dat'#25991#20214#32534#36753
        OnClick = Dat1Click
      end
      object WATWafer1: TMenuItem
        Caption = 'WATWafer'#25991#20214#29983#25104
        OnClick = WATWafer1Click
      end
      object CPSPEC1: TMenuItem
        Caption = 'CP-SPEC'#25209#37327#25991#20214#26356#25913
        OnClick = CPSPEC1Click
      end
      object XLS1: TMenuItem
        Caption = 'XLS'#25991#20214#25913#21517
        Enabled = False
        OnClick = XLS1Click
      end
    end
    object WAT1: TMenuItem
      Caption = 'WAT'
      object FTP1: TMenuItem
        Caption = 'FTP'#21151#33021
        OnClick = FTP1Click
      end
      object WatLimit1: TMenuItem
        Caption = 'WatLimit'#21019#24314
        OnClick = WatLimit1Click
      end
    end
    object N6: TMenuItem
      Caption = #21246#36873#21442#25968
      object mniTSKSample: TMenuItem
        Caption = 'TSKSimple'
        OnClick = mniTSKSampleClick
      end
    end
    object N3: TMenuItem
      Caption = #24110#21161
      object A1: TMenuItem
        Caption = #20851#20110'(&A)'
        OnClick = A1Click
      end
      object mniN7: TMenuItem
        Caption = #24110#21161#35828#26126
        OnClick = mniN7Click
      end
    end
  end
  object dlgSave1: TSaveDialog
    Left = 160
    Top = 45
  end
end
