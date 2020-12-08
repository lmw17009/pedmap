object XlsFileRename: TXlsFileRename
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Xls'#22788#29702
  ClientHeight = 419
  ClientWidth = 776
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbl2: TLabel
    Left = -86
    Top = 333
    Width = 48
    Height = 13
    Caption = #20462#25913#21442#25968
  end
  object lv1: TListView
    Left = 0
    Top = 0
    Width = 775
    Height = 193
    Columns = <
      item
        Caption = 'Name'
        Width = 200
      end
      item
        Alignment = taCenter
        Caption = 'PPID'
        Width = 200
      end
      item
        Alignment = taCenter
        Caption = 'Lot'
        Width = 150
      end
      item
        Alignment = taCenter
        Caption = 'ID'
        Width = 80
      end
      item
        Alignment = taCenter
        Caption = 'Commit'
        Width = 80
      end
      item
        Alignment = taCenter
        Caption = 'Warn'
        Width = 60
      end>
    GridLines = True
    MultiSelect = True
    PopupMenu = pm1
    TabOrder = 0
    ViewStyle = vsReport
  end
  object grp1: TGroupBox
    Left = 0
    Top = 199
    Width = 369
    Height = 177
    Caption = 'ACCO'
    TabOrder = 1
    object cbb1: TComboBox
      Left = 0
      Top = 14
      Width = 248
      Height = 21
      TabOrder = 0
      Text = #35831#36873#25321'ACCOPPID'
      OnSelect = cbb1Select
    end
    object cbb2: TComboBox
      Left = 0
      Top = 41
      Width = 248
      Height = 21
      TabOrder = 1
      Text = #35831#36873#25321'ACCOLotID'
      OnSelect = cbb2Select
    end
    object edtACCOLotID: TEdit
      Left = 0
      Top = 103
      Width = 248
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = edtACCOLotIDChange
    end
    object edtAccoPPID: TEdit
      Left = 0
      Top = 68
      Width = 248
      Height = 29
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnChange = edtAccoPPIDChange
    end
    object edtAdjPPID: TEdit
      Left = 0
      Top = 138
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 4
    end
    object edtAdjLotID: TEdit
      Left = 127
      Top = 138
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 5
    end
  end
  object grp2: TGroupBox
    Left = 254
    Top = 199
    Width = 259
    Height = 177
    Caption = 'Focus'
    TabOrder = 2
    object cbb3: TComboBox
      Left = 0
      Top = 14
      Width = 248
      Height = 21
      TabOrder = 0
      Text = #35831#36873#25321'FocusPPID'
      OnSelect = cbb3Select
    end
    object cbb4: TComboBox
      Left = 0
      Top = 41
      Width = 248
      Height = 21
      TabOrder = 1
      Text = #35831#36873#25321'FocusLotID'
      OnSelect = cbb4Select
    end
    object edtFocusLotID: TEdit
      Left = 0
      Top = 103
      Width = 248
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edtFocusPPID: TEdit
      Left = 0
      Top = 68
      Width = 248
      Height = 29
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnChange = edtFocusPPIDChange
    end
    object edtFocusAdjustPPID: TEdit
      Left = 0
      Top = 138
      Width = 121
      Height = 21
      TabOrder = 4
    end
  end
  object btnYes: TButton
    Left = 254
    Top = 370
    Width = 115
    Height = 41
    Caption = #19968#38190#26356#25913
    TabOrder = 3
    OnClick = btnYesClick
  end
  object grp3: TGroupBox
    Left = 519
    Top = 199
    Width = 256
    Height = 177
    Caption = 'JUNO'
    TabOrder = 4
    object edtJUNOLotID: TEdit
      Left = 8
      Top = 103
      Width = 248
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edtJUNOPPID: TEdit
      Left = 8
      Top = 68
      Width = 248
      Height = 29
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object cbb6: TComboBox
      Left = 8
      Top = 41
      Width = 248
      Height = 21
      TabOrder = 2
      Text = #35831#36873#25321'JUNOLotID'
      OnSelect = cbb6Select
    end
    object cbb5: TComboBox
      Left = 8
      Top = 14
      Width = 248
      Height = 21
      TabOrder = 3
      Text = #35831#36873#25321'JUNOPPID'
      OnSelect = cbb5Select
    end
  end
  object btnMoveFileOW: TButton
    Left = 375
    Top = 370
    Width = 115
    Height = 41
    Caption = #19968#38190'OW'#36335#24452#25644#36816
    TabOrder = 5
    OnClick = btnMoveFileOWClick
  end
  object chkAutoOpenOW: TCheckBox
    Left = 496
    Top = 382
    Width = 170
    Height = 17
    Caption = #33258#21160#25171#24320#37325#20002#25991#20214#22841
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object btnFileNameChane: TButton
    Left = 173
    Top = 370
    Width = 75
    Height = 41
    Caption = #25991#20214#21517#20462#27491
    TabOrder = 7
    OnClick = btnFileNameChaneClick
  end
  object Conn1: TFDConnection
    Params.Strings = (
      'Database=d:\11.xls'
      'DataSource=Excel Files'
      'DriverID=ODBC')
    LoginPrompt = False
    Left = 424
    Top = 64
  end
  object Qry1: TFDQuery
    Connection = Conn1
    SQL.Strings = (
      'select * from [summary information$]')
    Left = 560
    Top = 72
  end
  object fdgxwtcrsr1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 496
    Top = 72
  end
  object fdphysdbcdrvrlnk1: TFDPhysODBCDriverLink
    Left = 296
    Top = 64
  end
  object mm1: TMainMenu
    Left = 616
    Top = 72
    object N1: TMenuItem
      Caption = #21152#36733#25991#20214
      OnClick = N1Click
    end
  end
  object dlgOpen1: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 160
    Top = 72
  end
  object pm1: TPopupMenu
    Left = 336
    Top = 144
    object N2: TMenuItem
      Caption = #28165#38500#25152#26377
      OnClick = N2Click
    end
  end
end
