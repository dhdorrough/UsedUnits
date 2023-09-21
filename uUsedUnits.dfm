object Form_UsedUnits: TForm_UsedUnits
  Left = 540
  Top = 138
  Width = 494
  Height = 783
  Caption = 'Used Units'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 478
    Height = 689
    ActivePage = TabSheet_Setup
    Align = alClient
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet_UsedUnits: TTabSheet
      Caption = 'Used Units'
      DesignSize = (
        470
        661)
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 470
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          470
          56)
        object Label2: TLabel
          Left = 8
          Top = 12
          Width = 92
          Height = 13
          Caption = 'Main Program (.dpr)'
        end
        object Label3: TLabel
          Left = 3
          Top = 39
          Width = 38
          Height = 13
          Caption = 'All Units'
        end
        object Edit_MainProgram: TEdit
          Left = 112
          Top = 8
          Width = 327
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnChange = Edit_MainProgramChange
        end
        object Button_MainProgram: TButton
          Left = 444
          Top = 8
          Width = 25
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = Button_MainProgramClick
        end
        object rbUsedBy: TRadioButton
          Left = 204
          Top = 37
          Width = 69
          Height = 17
          Caption = 'Used By'
          TabOrder = 2
          OnClick = rbUsedByClick
        end
        object rbUses: TRadioButton
          Left = 273
          Top = 37
          Width = 50
          Height = 17
          Caption = 'Uses'
          TabOrder = 3
          OnClick = rbUsesClick
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 56
        Width = 193
        Height = 605
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object lbUnits: TListBox
          Left = 0
          Top = 0
          Width = 193
          Height = 605
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          OnClick = lbUnitsClick
        end
      end
      object Panel5: TPanel
        Left = 193
        Top = 56
        Width = 11
        Height = 605
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 2
      end
      object lbUsedUnits: TListBox
        Left = 204
        Top = 56
        Width = 193
        Height = 605
        Align = alLeft
        ItemHeight = 13
        Sorted = True
        TabOrder = 3
        OnClick = lbUsedUnitsClick
      end
      object Button_Begin: TButton
        Left = 400
        Top = 56
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = '&Scan'
        TabOrder = 4
        OnClick = Button_BeginClick
      end
    end
    object TabSheet_Relation: TTabSheet
      Caption = 'Find Relation'
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 201
        Height = 661
        Align = alLeft
        TabOrder = 0
        object Panel8: TPanel
          Left = 1
          Top = 630
          Width = 199
          Height = 30
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object cbTargetUnit: TComboBox
            Left = 5
            Top = 4
            Width = 189
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            OnChange = cbTargetUnitChange
          end
        end
        object Panel7: TPanel
          Left = 1
          Top = 1
          Width = 199
          Height = 30
          Align = alTop
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          object cbStartUnit: TComboBox
            Left = 5
            Top = 4
            Width = 189
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            OnChange = cbStartUnitChange
          end
        end
        object lbRelation: TListBox
          Left = 1
          Top = 31
          Width = 199
          Height = 599
          Align = alClient
          ItemHeight = 13
          TabOrder = 2
        end
      end
      object Panel9: TPanel
        Left = 201
        Top = 0
        Width = 80
        Height = 661
        Align = alLeft
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Image1: TImage
          Left = 12
          Top = 96
          Width = 55
          Height = 64
          Picture.Data = {
            07544269746D617076080000424D760800000000000076000000280000004000
            0000400000000100040000000000000800000000000000000000100000000000
            000000000000800000000080000080800000000080008000800000808000C0C0
            C00080808000FF00000000FF0000FFFF00000000FF00FF00FF0000FFFF00FFFF
            FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000FFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFF000000000000000000000FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFF00000000000000F000000000FFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFF00000000FF0000FF00000000FFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFF0000000FFF0000FFF0000000FFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFF000000FFFF0000FFFFF00000FFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFF0000FFFFFF0000FFFFFF0000FFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000FFFFF00000FFFFF000FFFFF00000FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFF00000000FFF0000000FFF00000FFF0000000FFFFFFFFFFFFFFF
            FFFFFFFFFFFF000FFFF000FF00FFF00FF000FF00FF00FFF00FFFFFFFFFFFFFFF
            FFFFFFFFFFFF00FFFFFF00FFFFF0000FF00FFFFFFFFFF0000FFFFFFFFFFFFFFF
            FFFFFFFFFFFF00FFFFFF00FFF00000FFF0000000FFF00000FFFFFFFFFFFFFFFF
            FFFFFFFFFFFF00FFFFFF00FF0000FFFFF0000000FF0000FFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF00FFFFFF00FF00FFF00FF00FFF00FF00FFF00FFFFFFFFFFFFFFF
            FFFFFFFFFFFF00FFFFFF00FF0000000FFF00000FFF0000000FFFFFFFFFFFFFFF
            FFFFFFFFFFFF00FFFFFF00FFF00000FFFFF000FFFFF00000FFFFFFFFFFFFFFFF
            FFFFFFFFFFFF00FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF00FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF00FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF}
          Transparent = True
        end
        object btnFind: TButton
          Left = 7
          Top = 5
          Width = 66
          Height = 25
          Caption = 'Find'
          TabOrder = 0
          OnClick = btnFindClick
        end
        object btnNext: TButton
          Left = 7
          Top = 35
          Width = 66
          Height = 25
          Caption = 'Next'
          TabOrder = 1
          OnClick = btnNextClick
        end
      end
      object cbInterfacesOnly: TCheckBox
        Left = 296
        Top = 8
        Width = 97
        Height = 17
        Caption = 'Interfaces Only'
        TabOrder = 2
      end
    end
    object TabSheet_Setup: TTabSheet
      Caption = 'Setup'
      object Label1: TLabel
        Left = 288
        Top = 8
        Width = 120
        Height = 13
        Caption = 'Source File Search Paths'
      end
      object Button_Add: TButton
        Left = 288
        Top = 32
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 0
        OnClick = Button_AddClick
      end
      object Button_Delete: TButton
        Left = 288
        Top = 64
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 1
        OnClick = Button_DeleteClick
      end
      object Panel_MemoPath: TPanel
        Left = 0
        Top = 0
        Width = 273
        Height = 661
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 2
        object lbPaths: TListBox
          Left = 0
          Top = 0
          Width = 273
          Height = 661
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          OnClick = lbPathsClick
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 689
    Width = 478
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label_NowProcessing: TLabel
      Left = 8
      Top = 10
      Width = 106
      Height = 13
      Caption = 'Label_NowProcessing'
    end
    object Panel2: TPanel
      Left = 308
      Top = 0
      Width = 170
      Height = 36
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 444
  end
  object MainMenu1: TMainMenu
    Left = 456
    object File1: TMenuItem
      Caption = '&File'
      OnClick = File1Click
      object New1: TMenuItem
        Caption = '&New'
      end
      object Open1: TMenuItem
        Caption = '&Open...'
        OnClick = Open1Click
      end
      object SaveAs1: TMenuItem
        Caption = 'Save &As...'
        OnClick = SaveAs1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Print1: TMenuItem
        Caption = '&Print...'
        Visible = False
        OnClick = Print1Click
      end
      object PrintSetup1: TMenuItem
        Caption = 'P&rint Setup...'
        Visible = False
      end
      object N1: TMenuItem
        Caption = '-'
        Visible = False
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        OnClick = Exit1Click
      end
    end
    object Reports1: TMenuItem
      Caption = 'Reports'
      OnClick = Reports1Click
      object ListUnitstoTextFile1: TMenuItem
        Caption = 'List Units to Text File...'
        OnClick = ListUnitstoTextFile1Click
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object Contents1: TMenuItem
        Caption = '&Contents'
        Enabled = False
        Visible = False
      end
      object SearchforHelpOn1: TMenuItem
        Caption = '&Search for Help On...'
        Enabled = False
        Visible = False
      end
      object HowtoUseHelp1: TMenuItem
        Caption = '&How to Use Help'
        Enabled = False
        Visible = False
      end
      object About1: TMenuItem
        Caption = '&About...'
        OnClick = About1Click
      end
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text (*.txt)|txt'
    Title = 'Save Used Units List'
    Left = 428
  end
  object PrintDialog1: TPrintDialog
    Options = [poDisablePrintToFile]
    Left = 384
  end
end
