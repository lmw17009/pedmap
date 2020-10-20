object WatLimitMain: TWatLimitMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'WatLimFileCreate V'
  ClientHeight = 484
  ClientWidth = 873
  Color = clBtnFace
  DragMode = dmAutomatic
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
    Left = 208
    Top = 85
    Width = 333
    Height = 13
    Caption = #24405#20837#26631#39064'=>'#29983#25104#21015#34920'=>'#21491#20987#20462#25913#21015#34920'=>'#36755#20837#25991#20214#21517'=>'#21019#24314'LIM'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object mmo1: TMemo
    Left = 8
    Top = 0
    Width = 738
    Height = 73
    Lines.Strings = (
      'mmo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btn1: TButton
    Left = 752
    Top = 1
    Width = 113
    Height = 106
    Caption = #21019#24314'LIM'
    TabOrder = 1
    OnClick = btn1Click
  end
  object edt1: TEdit
    Left = 584
    Top = 82
    Width = 168
    Height = 21
    TabOrder = 2
    Text = #35831#36755#20837#25991#20214#21517
    OnClick = edt1Click
  end
  object lv1: TListView
    Left = 8
    Top = 112
    Width = 858
    Height = 366
    Checkboxes = True
    Columns = <
      item
        Caption = 'Par_no Parameter'
        Width = 150
      end
      item
        Alignment = taCenter
        Caption = 'Unit'
        Width = 70
      end
      item
        Alignment = taCenter
        Caption = 'VL'
        Width = 70
      end
      item
        Alignment = taCenter
        Caption = 'V H'
        Width = 70
      end
      item
        Alignment = taCenter
        Caption = 'S L'
        Width = 70
      end
      item
        Alignment = taCenter
        Caption = 'S H'
        Width = 70
      end
      item
        Alignment = taCenter
        Caption = 'CL'
        Width = 70
      end
      item
        Alignment = taCenter
        Caption = 'CH'
        Width = 70
      end
      item
        Alignment = taCenter
        Caption = 'CENTER'
        Width = 70
      end
      item
        Alignment = taCenter
        Caption = 'FLAG'
        Width = 70
      end
      item
        Alignment = taCenter
        Caption = 'Version'
        Width = 70
      end>
    DragMode = dmAutomatic
    GridLines = True
    MultiSelect = True
    RowSelect = True
    PopupMenu = pm1
    TabOrder = 3
    ViewStyle = vsReport
    OnColumnRightClick = lv1ColumnRightClick
    OnDragDrop = lv1DragDrop
    OnDragOver = lv1DragOver
    OnMouseEnter = lv1MouseEnter
    OnMouseLeave = lv1MouseLeave
    OnMouseMove = lv1MouseMove
  end
  object btn2: TButton
    Left = 8
    Top = 79
    Width = 122
    Height = 27
    Caption = #29983#25104#21015#34920
    TabOrder = 4
    OnClick = btn2Click
  end
  object pm1: TPopupMenu
    Left = 576
    Top = 392
    object N1: TMenuItem
      Caption = #20462#25913
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #28165#38500
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #21024#38500
      OnClick = N3Click
    end
  end
end
