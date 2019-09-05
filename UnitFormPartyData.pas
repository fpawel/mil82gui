unit UnitFormPartyData;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
    server_data_types;

type
    TMeregedRow = record
        Text: string;
        Row: integer;

    end;

    TFormPartyData = class(TForm)
        ListBox1: TListBox;
        StringGrid2: TStringGrid;
        procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid2DblClick(Sender: TObject);
        procedure StringGrid2TopLeftChanged(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
    private
        { Private declarations }
        FMeregedRows: TArray<TMeregedRow>;
        FRows: TArray<TRow>;
    public
        { Public declarations }
        procedure FetchParty(partyID: int64);
    end;

var
    FormPartyData: TFormPartyData;

implementation

{$R *.dfm}

uses stringgridutils, UnitFormPopup, app, services;

procedure TFormPartyData.FormCreate(Sender: TObject);
begin
    with StringGrid2 do
    begin
        ColCount := 10;
        RowCount := 2;
        FixedCols := 1;
        FixedRows := 1;

        Cells[0, 0] := 'a';
        Cells[1, 1] := 'b';
        Cells[2, 2] := 'c';
    end;
end;

procedure TFormPartyData.FormShow(Sender: TObject);
var
    AVar: TVar;
begin
    with ListBox1 do
    begin

        Items.Clear;
        for AVar in app.AppVars do
            Items.Add('   ' + AVar.Name);
        ItemIndex := 0;
    end;

    FetchParty(0);
end;

procedure TFormPartyData.StringGrid2DblClick(Sender: TObject);
var
    r: TRect;
    pt: TPoint;
    c: TCell;
begin
    with StringGrid2 do
    begin
        c := FRows[Row].Cells[Col];
        if length(c.Detail) = 0 then
            exit;

        FormPopup.RichEdit1.Text := c.Detail;
        case c.ValueType of
            0:
                FormPopup.RichEdit1.Font.Color := clBlack;
            1:
                FormPopup.RichEdit1.Font.Color := clBlue;
            2:
                FormPopup.RichEdit1.Font.Color := clRed;
        end;

        r := CellRect(Col, Row);
        pt := StringGrid2.ClientToScreen(r.TopLeft);
        FormPopup.Left := pt.X + ColWidths[Col] + 3;
        FormPopup.Top := pt.Y + RowHeights[Row] + 3;
        FormPopup.Show;
    end;
end;

procedure TFormPartyData.StringGrid2DrawCell(Sender: TObject;
  ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    ta: TAlignment;
    AMergeRect: TMeregedRow;
begin
    grd := StringGrid2;
    cnv := grd.Canvas;
    cnv.Font.Assign(grd.Font);

    cnv.Brush.Color := clWhite;
    if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption
    else if gdFixed in State then
        cnv.Brush.Color := cl3DLight;
    cnv.Font.Color := clBlack;
    cnv.Pen.Color := $00BCBCBC;
    cnv.Pen.Width := -1;

    if ACol > 0 then
        for AMergeRect in FMeregedRows do
            if ARow = AMergeRect.Row then
            begin
                cnv.Brush.Color := clInfoBk;
                cnv.Font.Color := clNavy;
                cnv.Font.Style := [fsBold];

                StringGrid_DrawMeregedCell(grd, AMergeRect.Text,
                  AMergeRect.Row, Rect);
                exit;
            end;

    ta := taCenter;
    if (ACol > 0) ANd (ARow > 0) then
    begin
        ta := taRightJustify;
        case FRows[ARow].Cells[ACol].ValueType of
            0:
                cnv.Font.Color := clBlack;
            1:
                cnv.Font.Color := clBlue;
            2:
                cnv.Font.Color := clRed;
        end;

    end;

    DrawCellText(StringGrid2, ACol, ARow, Rect, ta,
      StringGrid2.Cells[ACol, ARow]);

    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);

end;

procedure TFormPartyData.StringGrid2TopLeftChanged(Sender: TObject);
var
    ACol, ARow: integer;
begin
    with StringGrid2 do
    begin
        for ACol := LeftCol to LeftCol + VisibleColCount - 1 do
            for ARow := TopRow to TopRow + VisibleRowCount - 1 do
                Cells[ACol, ARow] := Cells[ACol, ARow];

        for ACol := 0 to LeftCol + VisibleColCount - 1 do
            Cells[ACol, 0] := Cells[ACol, 0];

        for ARow := TopRow to TopRow + VisibleRowCount - 1 do
            Cells[0, ARow] := Cells[0, ARow];
    end;
end;

procedure TFormPartyData.FetchParty(partyID: int64);
var
    AVar: TVar;
    xs: TTable;
    _row: TRow;
    ACol, ARow, I: integer;
begin

    FMeregedRows := [];
    if partyID = 0 then
    begin
        xs := TLastPartySvc.ProductsValues
          (app.AppVars[ListBox1.ItemIndex].Code);
        // FProducts := TLastPartySvc.Products1;
    end
    else
    begin
        xs := TPartiesSvc.PartyProductsValues(partyID,
          app.AppVars[ListBox1.ItemIndex].Code);
        // FProducts := TPartiesSvc.PartyProducts(partyID);
        FRows := xs.Rows;
    end;

    with StringGrid2 do
    begin

        ColCount := length(xs.Rows[0].Cells);
        RowCount := length(xs.Rows);

        for I := 0 to length(xs.Rows[0].Cells) - 1 do
            Cells[I, 0] := xs.Rows[0].Cells[I].Text;

        ARow := 0;

        for _row in xs.Rows do
        begin

            if length(_row.Cells) = 1 then
            begin
                SetLength(FMeregedRows, length(FMeregedRows) + 1);
                FMeregedRows[length(FMeregedRows) - 1].Row := ARow;
                FMeregedRows[length(FMeregedRows) - 1].Text :=
                  _row.Cells[0].Text;

            end
            else
            begin

                for ACol := 0 to ColCount - 1 do
                    Cells[ACol, ARow] := _row.Cells[ACol].Text;

            end;
            ARow := ARow + 1;
        end;

    end;
    StringGrid_SetupColumnsWidth(StringGrid2);

end;

end.
