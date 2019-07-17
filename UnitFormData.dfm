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
    Left = 265
    Top = 0
    Width = 5
    Height = 592
    ExplicitHeight = 300
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 265
    Height = 592
    Align = alLeft
    BevelOuter = bvNone
    Constraints.MinWidth = 265
    TabOrder = 0
    OnResize = Panel1Resize
    ExplicitHeight = 300
    object StringGrid1: TStringGrid
      AlignWithMargins = True
      Left = 3
      Top = 34
      Width = 259
      Height = 555
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
      OnSelectCell = StringGrid1SelectCell
      ExplicitHeight = 263
      ColWidths = (
        64
        64
        64)
      RowHeights = (
        22)
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 265
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
      TabOrder = 1
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
  end
  object HtmlViewer1: THtmlViewer
    Left = 270
    Top = 0
    Width = 730
    Height = 592
    BorderStyle = htFocused
    DefBackground = clWhite
    DefFontName = 'Segoe UI'
    DefFontSize = 14
    HistoryMaxCount = 0
    NoSelect = False
    PrintMarginBottom = 2.000000000000000000
    PrintMarginLeft = 2.000000000000000000
    PrintMarginRight = 2.000000000000000000
    PrintMarginTop = 2.000000000000000000
    PrintScale = 1.000000000000000000
    Align = alClient
    TabOrder = 1
    Touch.InteractiveGestures = [igPan]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia]
    ExplicitLeft = 271
  end
end
