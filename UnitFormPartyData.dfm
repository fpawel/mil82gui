object FormPartyData: TFormPartyData
  Left = 0
  Top = 0
  Caption = 'FormPartyData'
  ClientHeight = 419
  ClientWidth = 749
  Color = clHighlightText
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 18
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 749
    Height = 28
    Align = alTop
    Columns = 8
    ItemHeight = 18
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
    TabOrder = 0
  end
  object StringGrid2: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 31
    Width = 743
    Height = 385
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
    TabOrder = 1
    OnDblClick = StringGrid2DblClick
    OnDrawCell = StringGrid2DrawCell
    OnTopLeftChanged = StringGrid2TopLeftChanged
    ColWidths = (
      64
      64
      64)
    RowHeights = (
      22)
  end
end
