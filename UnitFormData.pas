unit UnitFormData;

interface

uses
    server_data_types,
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  HTMLUn2, HtmlView;

type
    TFormData = class(TForm)
        Panel1: TPanel;
        StringGrid1: TStringGrid;
        Panel3: TPanel;
        ComboBox1: TComboBox;
        Splitter1: TSplitter;
    HtmlViewer1: THtmlViewer;
        procedure FormCreate(Sender: TObject);
        procedure ComboBox1Change(Sender: TObject);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure Panel1Resize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    private
        { Private declarations }
        FYearMonth: TArray<TYearMonth>;
        FParties: TArray<TPartyCatalogue>;
        procedure OnResponse(AResponse: TBytes);
    public
        { Public declarations }
        procedure FetchYearsMonths;
    end;

var
    FormData: TFormData;

implementation

{$R *.dfm}

uses app, HttpClient, services, dateutils, stringgridutils, stringutils;

procedure TFormData.FormCreate(Sender: TObject);
begin
    //
end;

procedure TFormData.FormShow(Sender: TObject);
begin
    //Mil82HttpGetResponseAsync(Mil82HttpAddr + '/report?party_id=last', OnResponse);
end;

procedure TFormData.Panel1Resize(Sender: TObject);
begin
    with StringGrid1 do
    begin
        ColWidths[0] := 70;
        ColWidths[1] := 70;
        ColWidths[2] := Panel1.Width - ColWidths[0] - ColWidths[1] - 10;
        Repaint;
    end;
end;

procedure TFormData.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    ta: TAlignment;

begin
    grd := StringGrid1;
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
    DrawCellText(StringGrid1, ACol, ARow, Rect, ta,
      StringGrid1.Cells[ACol, ARow]);
end;

procedure TFormData.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
    if ARow - 1 >= length(FParties) then
        exit;
    //FormChartSeries.Hide;
    Mil82HttpGetResponseAsync(Format(Mil82HttpAddr + '/report?party_id=%d',
      [FParties[ARow - 1].PartyID]), OnResponse);
end;

procedure TFormData.ComboBox1Change(Sender: TObject);
var
    I: Integer;
begin

    with StringGrid1 do
    begin
        ColCount := 3;

        OnSelectCell := nil;
        with FYearMonth[ComboBox1.ItemIndex] do
            FParties := TPartiesSvc.PartiesOfYearMonth(year, month);
        RowCount := length(FParties) + 1;
        if RowCount = 1 then
            exit;

        FixedRows := 1;
        Cells[0, 0] := 'День';
        Cells[1, 0] := 'Вермя';
        Cells[2, 0] := 'Исполнение';

        for I := 0 to length(FParties) - 1 do
            with FParties[I] do
            begin
                Cells[0, I + 1] := IntToStr2(day);
                Cells[1, I + 1] :=
                  Format('%s:%s', [IntToStr2(hour), IntToStr2(minute)]);
                Cells[2, I + 1] := FParties[I].ProductType;
            end;

        OnSelectCell := StringGrid1SelectCell;
        Row := RowCount - 1;
        Mil82HttpGetResponseAsync(Format(Mil82HttpAddr + '/report?party_id=%d',
            [FParties[Row - 1].PartyID]), OnResponse);
    end;

end;

procedure TFormData.FetchYearsMonths;
var
    I: Integer;
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


procedure TFormData.OnResponse(AResponse: TBytes);
begin
    HtmlViewer1.LoadFromString(TEncoding.UTF8.GetString( AResponse ));
end;

end.
