object FormAppConfig: TFormAppConfig
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 387
  ClientWidth = 654
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 21
  object Panel21: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 310
    Height = 381
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox2: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 300
      Height = 140
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Caption = #1057#1054#1052' '#1087#1086#1088#1090#1099
      TabOrder = 0
      object Panel1: TPanel
        Left = 2
        Top = 23
        Width = 296
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        TabOrder = 0
        object Shape1: TShape
          Left = 1
          Top = 36
          Width = 294
          Height = 1
          Align = alBottom
          Pen.Color = cl3DLight
          ExplicitLeft = 168
          ExplicitTop = 152
          ExplicitWidth = 65
        end
        object Panel2: TPanel
          Left = 1
          Top = 1
          Width = 160
          Height = 35
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #1041#1083#1086#1082#1080' '#1086#1087#1090#1080#1095#1077#1089#1082#1080#1077
          TabOrder = 1
        end
        object ComboBoxComportProducts: TComboBox
          Left = 180
          Top = 4
          Width = 98
          Height = 26
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 20
          ItemIndex = 0
          ParentFont = False
          TabOrder = 0
          Text = 'COM1'
          OnChange = ComboBoxComportProductsChange
          Items.Strings = (
            'COM1')
        end
      end
      object Panel17: TPanel
        Left = 2
        Top = 61
        Width = 296
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        TabOrder = 1
        object Shape9: TShape
          Left = 1
          Top = 36
          Width = 294
          Height = 1
          Align = alBottom
          Pen.Color = cl3DLight
          ExplicitLeft = 168
          ExplicitTop = 152
          ExplicitWidth = 65
        end
        object Panel18: TPanel
          Left = 1
          Top = 1
          Width = 160
          Height = 35
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #1043#1072#1079#1086#1074#1099#1081' '#1073#1083#1086#1082
          TabOrder = 0
        end
        object ComboBoxComportGas: TComboBox
          Left = 180
          Top = 4
          Width = 98
          Height = 26
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 20
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = 'COM1'
          Items.Strings = (
            'COM1')
        end
      end
      object Panel5: TPanel
        Left = 2
        Top = 99
        Width = 296
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        TabOrder = 2
        object Panel6: TPanel
          Left = 1
          Top = 1
          Width = 160
          Height = 36
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #1058#1077#1088#1084#1086#1082#1072#1084#1077#1088#1072
          TabOrder = 0
        end
        object ComboBoxComportTemp: TComboBox
          Left = 180
          Top = 4
          Width = 98
          Height = 26
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 20
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = 'COM1'
          OnChange = ComboBoxComportProductsChange
          Items.Strings = (
            'COM1')
        end
      end
    end
    object GroupBox3: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 155
      Width = 300
      Height = 217
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Caption = #1055#1072#1088#1090#1080#1103
      TabOrder = 1
      object Panel13: TPanel
        Left = 2
        Top = 23
        Width = 296
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        TabOrder = 0
        object Shape3: TShape
          Left = 1
          Top = 36
          Width = 294
          Height = 1
          Align = alBottom
          Pen.Color = cl3DLight
          ExplicitLeft = 168
          ExplicitTop = 152
          ExplicitWidth = 65
        end
        object Panel14: TPanel
          Left = 1
          Top = 1
          Width = 160
          Height = 35
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #1048#1089#1087#1086#1083#1085#1077#1085#1080#1077
          TabOrder = 0
        end
        object ComboBoxProductTypeName: TComboBox
          Left = 180
          Top = 4
          Width = 98
          Height = 26
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 20
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = 'COM1'
          OnChange = ComboBoxProductTypeNameChange
          Items.Strings = (
            'COM1')
        end
      end
      object Panel15: TPanel
        Left = 2
        Top = 61
        Width = 296
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        TabOrder = 1
        object Shape4: TShape
          Left = 1
          Top = 36
          Width = 294
          Height = 1
          Align = alBottom
          Pen.Color = cl3DLight
          ExplicitLeft = 168
          ExplicitTop = 152
          ExplicitWidth = 65
        end
        object Panel16: TPanel
          Left = 1
          Top = 1
          Width = 160
          Height = 35
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #1055#1043#1057'-'#1043#1057#1054' 1'
          TabOrder = 0
        end
        object EditC1: TEdit
          Left = 180
          Top = 5
          Width = 98
          Height = 26
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'EditPgs1'
          OnChange = ComboBoxProductTypeNameChange
        end
      end
      object Panel22: TPanel
        Left = 2
        Top = 99
        Width = 296
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        TabOrder = 2
        object Shape7: TShape
          Left = 1
          Top = 36
          Width = 294
          Height = 1
          Align = alBottom
          Pen.Color = cl3DLight
          ExplicitLeft = 168
          ExplicitTop = 152
          ExplicitWidth = 65
        end
        object Panel23: TPanel
          Left = 1
          Top = 1
          Width = 160
          Height = 35
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #1055#1043#1057'-'#1043#1057#1054' 2'
          TabOrder = 0
        end
        object EditC2: TEdit
          Left = 180
          Top = 6
          Width = 98
          Height = 26
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'Edit1'
          OnChange = ComboBoxProductTypeNameChange
        end
      end
      object Panel24: TPanel
        Left = 2
        Top = 137
        Width = 296
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        TabOrder = 3
        object Shape8: TShape
          Left = 1
          Top = 36
          Width = 294
          Height = 1
          Align = alBottom
          Pen.Color = cl3DLight
          ExplicitLeft = 168
          ExplicitTop = 152
          ExplicitWidth = 65
        end
        object Panel25: TPanel
          Left = 1
          Top = 1
          Width = 160
          Height = 35
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #1055#1043#1057'-'#1043#1057#1054' 3'
          TabOrder = 0
        end
        object EditC3: TEdit
          Left = 180
          Top = 4
          Width = 98
          Height = 26
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'Edit1'
          OnChange = ComboBoxProductTypeNameChange
        end
      end
      object Panel26: TPanel
        Left = 2
        Top = 175
        Width = 296
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        TabOrder = 4
        object Panel27: TPanel
          Left = 1
          Top = 1
          Width = 160
          Height = 36
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #1055#1043#1057'-'#1043#1057#1054' 4'
          TabOrder = 0
        end
        object EditC4: TEdit
          Left = 180
          Top = 5
          Width = 98
          Height = 26
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'Edit1'
          OnChange = ComboBoxProductTypeNameChange
        end
      end
    end
  end
  object Panel3: TPanel
    AlignWithMargins = True
    Left = 319
    Top = 3
    Width = 334
    Height = 381
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object GroupBox4: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 324
      Height = 140
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100', '#1084#1080#1085'.'
      TabOrder = 0
      object Panel4: TPanel
        Left = 2
        Top = 23
        Width = 320
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        TabOrder = 0
        object Shape2: TShape
          Left = 1
          Top = 36
          Width = 318
          Height = 1
          Align = alBottom
          Pen.Color = cl3DLight
          ExplicitLeft = 168
          ExplicitTop = 152
          ExplicitWidth = 65
        end
        object Panel19: TPanel
          Left = 1
          Top = 1
          Width = 200
          Height = 35
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #1055#1088#1086#1076#1091#1074#1082#1072' '#1075#1072#1079#1072
          TabOrder = 0
        end
        object EditDurMinutesBlowGas: TEdit
          Left = 210
          Top = 5
          Width = 98
          Height = 26
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'EditDurMinutesBlowGas'
          OnChange = ComboBoxComportProductsChange
        end
      end
      object Panel20: TPanel
        Left = 2
        Top = 61
        Width = 320
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        TabOrder = 1
        object Shape10: TShape
          Left = 1
          Top = 36
          Width = 318
          Height = 1
          Align = alBottom
          Pen.Color = cl3DLight
          ExplicitLeft = 168
          ExplicitTop = 152
          ExplicitWidth = 65
        end
        object Panel28: TPanel
          Left = 1
          Top = 1
          Width = 200
          Height = 35
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #1055#1088#1086#1076#1091#1074#1082#1072' '#1074#1086#1079#1076#1091#1093#1072
          TabOrder = 0
        end
        object EditDurMinutesBlowAir: TEdit
          Left = 210
          Top = 5
          Width = 98
          Height = 26
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'Edit1'
          OnChange = ComboBoxComportProductsChange
        end
      end
      object Panel29: TPanel
        Left = 2
        Top = 99
        Width = 320
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        TabOrder = 2
        object Panel30: TPanel
          Left = 1
          Top = 1
          Width = 200
          Height = 36
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #1042#1099#1076#1077#1088#1078#1082#1072' T"C'
          TabOrder = 0
        end
        object EditDurMinutesHoldT: TEdit
          Left = 210
          Top = 5
          Width = 98
          Height = 26
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'Edit1'
          OnChange = ComboBoxComportProductsChange
        end
      end
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 155
      Width = 324
      Height = 99
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Caption = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072' '#1091#1089#1090#1072#1074#1082#1080
      TabOrder = 1
      object Panel9: TPanel
        Left = 2
        Top = 23
        Width = 320
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        TabOrder = 0
        object Shape6: TShape
          Left = 1
          Top = 36
          Width = 318
          Height = 1
          Align = alBottom
          Pen.Color = cl3DLight
          ExplicitLeft = 168
          ExplicitTop = 152
          ExplicitWidth = 65
        end
        object Panel10: TPanel
          Left = 1
          Top = 1
          Width = 200
          Height = 35
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #1053#1080#1079#1082#1072#1103' ("'#1084#1080#1085#1091#1089'")'
          TabOrder = 0
        end
        object EditTempMinus: TEdit
          Left = 210
          Top = 5
          Width = 98
          Height = 26
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'Edit1'
        end
      end
      object Panel11: TPanel
        Left = 2
        Top = 61
        Width = 320
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        TabOrder = 1
        object Panel12: TPanel
          Left = 1
          Top = 1
          Width = 200
          Height = 36
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #1042#1099#1089#1086#1082#1072#1103' ("'#1087#1083#1102#1089'")'
          TabOrder = 0
        end
        object EditTempPlus: TEdit
          Left = 210
          Top = 5
          Width = 98
          Height = 26
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'Edit1'
          OnChange = ComboBoxComportProductsChange
        end
      end
    end
  end
end
