unit UnitFormData;

interface

uses
    server_data_types,
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids;

type
    TMeregedRow = record
        Text: string;
        Row: integer;

    end;

    TFormData = class(TForm)
        Panel1: TPanel;
        Panel3: TPanel;
        ComboBox1: TComboBox;
        Splitter1: TSplitter;
        Panel2: TPanel;
        StringGrid2: TStringGrid;
        ListBox1: TListBox;
        StringGrid1: TStringGrid;
        Panel4: TPanel;
        Label1: TLabel;
        StringGrid3: TStringGrid;
        procedure FormCreate(Sender: TObject);
        procedure ComboBox1Change(Sender: TObject);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: integer;
          var CanSelect: Boolean);
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: integer;
          Rect: TRect; State: TGridDrawState);
        procedure Panel1Resize(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid2TopLeftChanged(Sender: TObject);
        procedure ListBox1Click(Sender: TObject);
        procedure StringGrid2DblClick(Sender: TObject);
    private
        { Private declarations }
        FYearMonth: TArray<TYearMonth>;
        FParties: TArray<TPartyCatalogue>;
        FMeregedRows: TArray<TMeregedRow>;
        FProducts: TArray<TProduct>;
        FRows: TArray<TRow>;
        procedure FetchParty(partyID: int64);
    public
        { Public declarations }
        procedure FetchYearsMonths;
    end;

var
    FormData: TFormData;

implementation

{$R *.dfm}

uses app, HttpClient, services, dateutils, stringgridutils, stringutils,
    UnitFormPopup;

function NewMeregedRow(ARow: integer; Atext: string): TMeregedRow;
begin
    Result.Text := Atext;
    Result.Row := ARow;
end;

procedure TFormData.FormCreate(Sender: TObject);
begin
    with StringGrid2 do
    begin
        ColCount := 10;
        RowCount := 100500;
        FixedCols := 1;
        FixedRows := 1;

        Cells[0, 0] := 'a';
        Cells[1, 1] := 'b';
        Cells[2, 2] := 'c';
    end;
    Panel4.Visible := false;
end;

procedure TFormData.FormShow(Sender: TObject);
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

procedure TFormData.ListBox1Click(Sender: TObject);
begin
    if StringGrid1.Row - 1 >= length(FParties) then
        exit;
    FetchParty(FParties[StringGrid1.Row - 1].partyID);
end;

procedure TFormData.Panel1Resize(Sender: TObject);
begin
    with StringGrid1 do
    begin
        ColWidths[0] := 70;
        ColWidths[1] := 70;
        ColWidths[2] := 70;
        ColWidths[3] := Panel1.Width - ColWidths[0] - ColWidths[1] -
          ColWidths[2] - 10;
        Repaint;
    end;

    with StringGrid3 do
    begin
        ColWidths[0] := 70;
        ColWidths[1] := 70;
        ColWidths[2] := Panel1.Width - ColWidths[0] - ColWidths[1] - 30;
        Repaint;
    end;
end;

procedure TFormData.StringGrid1DrawCell(Sender: TObject; ACol, ARow: integer;
  Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    ta: TAlignment;

begin
    grd := Sender as TStringGrid;
    cnv := grd.Canvas;
    cnv.Font.Assign(grd.Font);
    cnv.Brush.Color := clWhite;

    if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption;

    ta := taLeftJustify;
    case ACol of
        0:
            begin
                ta := taCenter;
                cnv.Font.Color := clGreen;
            end;
        1:
            begin
                ta := taLeftJustify;
                cnv.Font.Color := clBlack;
            end;
    end;
    DrawCellText(grd, ACol, ARow, Rect, ta, grd.Cells[ACol, ARow]);
end;

procedure TFormData.StringGrid1SelectCell(Sender: TObject; ACol, ARow: integer;
  var CanSelect: Boolean);
begin
    if ARow - 1 >= length(FParties) then
        exit;
    FetchParty(FParties[ARow - 1].partyID);
end;

procedure TFormData.StringGrid2DblClick(Sender: TObject);
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
        pt := StringGrid1.ClientToScreen(r.TopLeft);
        FormPopup.Left := pt.X + 5 + Panel2.Left;
        FormPopup.Top := pt.Y + 5;
        FormPopup.Show;
    end;
end;

procedure TFormData.StringGrid2DrawCell(Sender: TObject; ACol, ARow: integer;
  Rect: TRect; State: TGridDrawState);
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

procedure TFormData.StringGrid2TopLeftChanged(Sender: TObject);
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

procedure TFormData.ComboBox1Change(Sender: TObject);
var
    I: integer;
begin

    with StringGrid1 do
    begin
        ColCount := 4;

        OnSelectCell := nil;
        with FYearMonth[ComboBox1.ItemIndex] do
            FParties := TPartiesSvc.PartiesOfYearMonth(year, month);
        RowCount := length(FParties) + 1;
        if RowCount = 1 then
            exit;

        FixedRows := 1;
        Cells[0, 0] := 'День';
        Cells[1, 0] := 'Вермя';
        Cells[2, 0] := '№';
        Cells[3, 0] := 'Исполнение';

        for I := 0 to length(FParties) - 1 do
            with FParties[I] do
            begin
                Cells[0, I + 1] := IntToStr2(day);
                Cells[1, I + 1] :=
                  Format('%s:%s', [IntToStr2(hour), IntToStr2(minute)]);
                Cells[2, I + 1] := IntToStr(partyID);
                Cells[3, I + 1] := FParties[I].ProductType;
            end;

        Row := RowCount - 1;
        OnSelectCell := StringGrid1SelectCell;
        FetchParty(FParties[Row - 1].partyID);
    end;

end;

procedure TFormData.FetchYearsMonths;
var
    I: integer;
    ym: TYearMonth;
begin
    ComboBox1.Clear;
    FYearMonth := TPartiesSvc.YearsMonths;
    if length(FYearMonth) = 0 then
        with ym do
        begin
            year := YearOf(now);
            month := MonthOf(now);
            FYearMonth := [ym];
        end;

    for I := 0 to length(FYearMonth) - 1 do
        with FYearMonth[I] do
            ComboBox1.Items.Add(Format('%d %s',
              [year, FormatDateTime('MMMM', IncMonth(0, month))]));

    ComboBox1.ItemIndex := 0;
    ComboBox1Change(nil);
end;

procedure TFormData.FetchParty(partyID: int64);
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
        FProducts := TLastPartySvc.Products1;
    end
    else
    begin
        xs := TPartiesSvc.PartyProductsValues(partyID,
          app.AppVars[ListBox1.ItemIndex].Code);
        FProducts := TPartiesSvc.PartyProducts(partyID);
        FRows := xs.Rows;
    end;

    if (length(xs.Rows) = 0) or (length(xs.Rows[0].Cells) = 0) then
    begin
        Panel4.Hide;
        Panel2.Hide;
    end;

    Panel4.Show;
    Panel2.Show;
    Label1.Caption := Format('Приборы партии №%d', [partyID]);

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

    with StringGrid3 do
    begin
        RowCount := length(FProducts) + 1;
        if RowCount > 1 then
            FixedRows := 1;
        Cells[0, 0] := '№';
        Cells[1, 0] := 'Сер.№';
        Cells[2, 0] := 'Адрес';

        Panel4.Height := Label1.Height + RowCount * DefaultRowHeight + 30;
        for I := 0 to length(FProducts) - 1 do
        begin
            Cells[0, I + 1] := IntToStr(FProducts[I].ProductID);
            Cells[1, I + 1] := IntToStr(FProducts[I].Serial);
            Cells[2, I + 1] := '$' + IntToStr(FProducts[I].Addr);
        end;

    end;
    StringGrid_Unselect(StringGrid3);

end;

end.
