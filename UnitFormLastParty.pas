unit UnitFormLastParty;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
    Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
    Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin, server_data_types;

type

    TFormLastParty = class(TForm)
        StringGrid1: TStringGrid;
        ImageList1: TImageList;
        ToolBarParty: TToolBar;
        ToolButtonParty: TToolButton;
        ToolButtonStop: TToolButton;
        ToolButton1: TToolButton;
        ToolButton2: TToolButton;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
        procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
          const Value: string);
        procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        procedure FormShow(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure ToolButtonPartyClick(Sender: TObject);
        procedure ToolButtonStopClick(Sender: TObject);
        procedure ToolButton1Click(Sender: TObject);
    private
        { Private declarations }
        Last_Edited_Col, Last_Edited_Row: Integer;

        FhWndTip: THandle;

        FInterrogatePlace: Integer;

        procedure WMWindowPosChanged(var AMessage: TMessage);
          message WM_WINDOWPOSCHANGED;
        procedure WMEnterSizeMove(var Msg: TMessage); message WM_ENTERSIZEMOVE;

        procedure WMActivateApp(var AMessage: TMessage); message WM_ACTIVATEAPP;

    public
        { Public declarations }
        FProducts: TArray<TLastPartyProduct>;
        procedure reload_data;
        procedure setup_products;
    end;

var
    FormLastParty: TFormLastParty;

implementation

uses stringgridutils, stringutils, dateutils,
    vclutils, ComponentBaloonHintU, services, info;

{$R *.dfm}

procedure StringGrid_SetupColumnWidth(grd: TStringGrid);
var
    w, ARow, ACol: Integer;
begin
    with grd do
    begin
        for ACol := 0 to ColCount - 1 do
        begin
            ColWidths[ACol] := 30;
            for ARow := 0 to RowCount - 1 do
            begin
                w := Canvas.TextWidth(Cells[ACol, ARow]);
                if ColWidths[ACol] < w + 30 then
                    ColWidths[ACol] := w + 30;
            end;
        end;
    end;

end;

procedure TFormLastParty.FormCreate(Sender: TObject);
begin
    FInterrogatePlace := -1;
    reload_data;
end;

procedure TFormLastParty.FormShow(Sender: TObject);
begin
    //
end;

procedure TFormLastParty.WMEnterSizeMove(var Msg: TMessage);
begin
    CloseWindow(FhWndTip);
    inherited;
end;

procedure TFormLastParty.WMWindowPosChanged(var AMessage: TMessage);
begin
    CloseWindow(FhWndTip);
    inherited;
end;

procedure TFormLastParty.WMActivateApp(var AMessage: TMessage);
begin
    CloseWindow(FhWndTip);
    inherited;
end;

procedure TFormLastParty.StringGrid1SelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
var
    r: TRect;
    grd: TStringGrid;
begin
    grd := Sender as TStringGrid;

    // When selecting a cell
    if grd.EditorMode then
    begin // It was a cell being edited
        grd.EditorMode := false; // Deactivate the editor
        // Do an extra check if the LastEdited_ACol and LastEdited_ARow are not -1 already.
        // This is to be able to use also the arrow-keys up and down in the Grid.
        if (Last_Edited_Col <> -1) and (Last_Edited_Row <> -1) then
            StringGrid1SetEditText(grd, Last_Edited_Col, Last_Edited_Row,
              grd.Cells[Last_Edited_Col, Last_Edited_Row]);
        // Just make the call
    end;
    // Do whatever else wanted

    if (ARow > 0) AND (ACol in [1, 2]) then
        grd.Options := grd.Options + [goEditing]
    else
        grd.Options := grd.Options - [goEditing];
end;

procedure TFormLastParty.StringGrid1SetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: string);
begin
    if ARow = 0 then
        exit;
    With StringGrid1 do
        // Fired on every change
        if Not EditorMode // goEditing must be 'True' in Options
        then
        begin // Only after user ends editing the cell
            Last_Edited_Col := -1; // Indicate no cell is edited
            Last_Edited_Row := -1; // Indicate no cell is edited
            // Do whatever wanted after user has finish editing a cell
            StringGrid1.OnSetEditText := nil;
            try
                case ACol of
                    2:
                        begin
                            // UpdateSerial(ACol, ARow, Value);
                        end;
                    1:
                        begin
                            // UpdateAddr(ACol, ARow, Value);
                        end;
                end;
            finally
                StringGrid1.OnSetEditText := StringGrid1SetEditText;
            end;
        end
        else
        begin // The cell is being editted
            Last_Edited_Col := ACol; // Remember column of cell being edited
            Last_Edited_Row := ARow; // Remember row of cell being edited
        end;

end;

procedure TFormLastParty.ToolButton1Click(Sender: TObject);
begin

    with StringGrid1 do
    begin
        if MessageBox(Handle,
          PCHar(format
          ('Подтвердите необходимость удаления данных БО %s, место %d, адрес %s',
          [Cells[2, Row], Row, Cells[1, Row]])), 'Запрос подтверждения',
          mb_IconQuestion or mb_YesNo) <> mrYes then
            exit;
        FProducts := TLastPartySvc.DeleteProduct(FProducts[Row-1].ProductID);
        setup_products;
    end;

end;

procedure TFormLastParty.ToolButtonPartyClick(Sender: TObject);
var
    r: Integer;
begin
    r := MessageBox(Handle, 'Подтвердите необходимость создания новой партии.',
      'Запрос подтверждения', mb_IconQuestion or mb_YesNo);

    if r <> mrYes then
        exit;

    //
    reload_data;

end;

procedure TFormLastParty.ToolButtonStopClick(Sender: TObject);
begin
    FProducts := TLastPartySvc.AddNewProduct;
    setup_products;
end;

procedure TFormLastParty.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    ACol, ARow: Integer;
    p: TLastPartyProduct;
begin
    if (GetAsyncKeyState(VK_LBUTTON) >= 0) then
        exit;
    StringGrid1.MouseToCell(X, Y, ACol, ARow);
    if (ACol > 0) or (ARow = 0) then
        exit;

    FProducts[ARow - 1].Checked := not FProducts[ARow - 1].Checked;

    StringGrid_RedrawRow(StringGrid1, ARow);

end;

procedure TFormLastParty.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    p: TLastPartyProduct;

begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Font.Assign(grd.Font);
    cnv.Brush.Color := clWhite;

    if (ARow = 0) or (ACol = 0) then
        cnv.Brush.Color := cl3DLight;

    if ARow = 0 then
    begin
        DrawCellText(StringGrid1, ACol, ARow, Rect, taCenter,
          StringGrid1.Cells[ACol, ARow]);
        StringGrid_DrawCellBounds(StringGrid1.Canvas, ACol, 0, Rect);
        exit;
    end;

    p := FProducts[ARow - 1];

    if (ACol > 0) and (p.Error <> '') then
    begin
        cnv.Font.Color := clRed;
        cnv.Brush.Color := $F6F7F7;
    end;

    if ARow = FInterrogatePlace + 1 then
        cnv.Brush.Color := clSkyBlue;

    if ACol = 0 then
    begin

        grd.Canvas.FillRect(Rect);
        DrawCheckbox(grd, grd.Canvas, Rect, p.Checked, grd.Cells[ACol, ARow]);
        StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
        exit;
    end;

    if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption;

    DrawCellText(StringGrid1, ACol, ARow, Rect, taLeftJustify,
      StringGrid1.Cells[ACol, ARow]);

    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormLastParty.setup_products;
var
    ARow,ACol: Integer;
begin

    StringGrid_Clear(StringGrid1);
    with StringGrid1 do
    begin
        self.Height := DefaultRowHeight * (Length(FProducts) + 1) + 50;

        ColCount := 3 + Length(Vars);
        RowCount := Length(FProducts) + 1;
        if Length(FProducts) = 0 then
            exit;

        FixedRows := 1;
        FixedCols := 1;
        ColWidths[0] := 80;

        Cells[0, 0] := 'Место';
        Cells[1, 0] := 'Адр.';
        Cells[2, 0] := '№';

        for ACol := 3 to ColCount - 1 do
            Cells[ACol, 0] := Vars[ACol-3];

        for ARow := 1 to RowCount - 1 do
        begin
            Cells[0, ARow] := IntToStr(ARow);
            Cells[1, ARow] := IntToStr(FProducts[ARow - 1].Addr);
            Cells[2, ARow] := IntToStr(FProducts[ARow - 1].Serial);
        end;

    end;
    StringGrid_SetupColumnWidth(StringGrid1);
end;

procedure TFormLastParty.reload_data;
begin
    with Application.MainForm do
        with TLastPartySvc.Party do
            Caption := format('Партия БО КГСДУМ № %d, создана %s',
              [PartyID, FormatDateTime('dd MMMM yyyy hh:nn',
              IncHour(CreatedAt, 3))]);
    FProducts := TLastPartySvc.products;
    setup_products;

end;

end.
