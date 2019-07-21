object FormData: TFormData
  Left = 0
  Top = 0
  Caption = 'FormData'
  ClientHeight = 592
  ClientWidth = 1000
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 270
    Top = 0
    Width = 5
    Height = 592
    ExplicitLeft = 265
    ExplicitHeight = 300
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 270
    Height = 592
    Align = alLeft
    BevelOuter = bvNone
    Constraints.MinWidth = 265
    TabOrder = 0
    OnResize = Panel1Resize
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 270
      Height = 31
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '   '#1044#1072#1090#1072
      Color = clGradientInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object ComboBox1: TComboBox
        Left = 77
        Top = 2
        Width = 132
        Height = 26
        Style = csOwnerDrawFixed
        Color = clHighlightText
        ItemHeight = 20
        ItemIndex = 0
        TabOrder = 0
        Text = '11.11.2018'
        OnChange = ComboBox1Change
        Items.Strings = (
          '11.11.2018')
      end
    end
    object StringGrid1: TStringGrid
      AlignWithMargins = True
      Left = 3
      Top = 34
      Width = 264
      Height = 363
      Align = alClient
      BorderStyle = bsNone
      ColCount = 4
      DefaultRowHeight = 22
      DefaultDrawing = False
      FixedColor = clBackground
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      GradientEndColor = clBlack
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentFont = False
      TabOrder = 1
      OnDrawCell = StringGrid1DrawCell
      OnSelectCell = StringGrid1SelectCell
      ColWidths = (
        64
        64
        64
        64)
      RowHeights = (
        22)
    end
    object Panel4: TPanel
      Left = 0
      Top = 400
      Width = 270
      Height = 192
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 270
        Height = 13
        Align = alTop
        Caption = #1055#1088#1080#1073#1086#1088#1099' '#1087#1072#1088#1090#1080#1080
        ExplicitWidth = 84
      end
      object StringGrid3: TStringGrid
        AlignWithMargins = True
        Left = 3
        Top = 16
        Width = 264
        Height = 173
        Align = alClient
        BorderStyle = bsNone
        ColCount = 3
        DefaultRowHeight = 22
        DefaultDrawing = False
        FixedColor = clBackground
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        GradientEndColor = clBlack
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentFont = False
        TabOrder = 0
        OnDrawCell = StringGrid1DrawCell
        ColWidths = (
          64
          64
          64)
        RowHeights = (
          22)
      end
    end
  end
  object Panel2: TPanel
    Left = 275
    Top = 0
    Width = 725
    Height = 592
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object StringGrid2: TStringGrid
      AlignWithMargins = True
      Left = 3
      Top = 31
      Width = 719
      Height = 558
      Align = alClient
      BiDiMode = bdLeftToRight
      BorderStyle = bsNone
      ColCount = 3
      DefaultRowHeight = 22
      DefaultDrawing = False
      FixedColor = clBackground
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      GradientEndColor = clBlack
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 0
      OnDrawCell = StringGrid2DrawCell
      OnTopLeftChanged = StringGrid2TopLeftChanged
      ColWidths = (
        64
        64
        64)
      RowHeights = (
        22)
    end
    object ListBox1: TListBox
      Left = 0
      Top = 0
      Width = 725
      Height = 28
      Align = alTop
      Columns = 8
      ItemHeight = 13
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '4'
        '56'
        '6'
        '7'
        '7'
        '7'
        '8'
        '8'
        '8'
        '8'
        '8'
        '8'
        '8')
      TabOrder = 1
      OnClick = ListBox1Click
    end
  end
end
