unit UnitFormCharts;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
    server_data_types, UnitFormChartSeries;

type
    TValuePoint = record
        Addr: byte;
        var_id: integer;
        value: double;
        time: tdateTime;
    end;

    TFormCharts = class(TForm)
        Panel1: TPanel;
        StringGrid1: TStringGrid;
        Panel3: TPanel;
        ComboBox1: TComboBox;
        Splitter1: TSplitter;
    Timer1: TTimer;
        procedure FormCreate(Sender: TObject);
        procedure ComboBox1Change(Sender: TObject);
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: integer;
          var CanSelect: Boolean);
        procedure FormShow(Sender: TObject);
        procedure Panel1Resize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    private
        { Private declarations }
        FBuckets: TArray<TChartsBucket>;
        FYearMonth: TArray<TYearMonth>;
        FAddValues: TArray<TValuePoint>;

        procedure OnResponse(AResponse: TBytes);

    public
        { Public declarations }
        procedure FetchYearsMonths;
        procedure AddValue(Addr, var_id: integer; value: double;
          time: tdateTime);
    end;

var
    FormCharts: TFormCharts;

implementation

{$R *.dfm}

uses Grijjy.Http, httprpcclient, dateutils, stringgridutils, services,
    stringutils, app, HttpClient;

procedure TFormCharts.FormCreate(Sender: TObject);
begin
    //
end;

procedure TFormCharts.FormShow(Sender: TObject);
begin
    //
end;

procedure TFormCharts.Panel1Resize(Sender: TObject);
begin
    with StringGrid1 do
    begin
        ColWidths[0] := 60;
        ColWidths[1] := 50;
        ColWidths[2] := 70;
        ColWidths[3] := 70;
        ColWidths[4] := Panel1.Width - ColWidths[0] - ColWidths[1] -
          ColWidths[2] - ColWidths[3] - 10;
        Repaint;
    end;
end;

procedure TFormCharts.StringGrid1DrawCell(Sender: TObject; ACol, ARow: integer;
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

    if (ARow - 1 > -1) AND (ARow - 1 < Length(FBuckets)) AND
      (FBuckets[ARow - 1].IsLast = true) then
    begin
        cnv.Font.Color := clBlue;
        cnv.Font.Style := [fsBold];
    end
    else
    begin
        cnv.Font.Style := [];
    end;

    DrawCellText(StringGrid1, ACol, ARow, Rect, ta,
      StringGrid1.Cells[ACol, ARow]);
end;

procedure TFormCharts.StringGrid1SelectCell(Sender: TObject;
  ACol, ARow: integer; var CanSelect: Boolean);
begin
    SetLength(FAddValues,0);
    if ARow - 1 >= Length(FBuckets) then
        exit;
    FormChartSeries.Hide;
    Mil82HttpGetResponseAsync(Format(Mil82HttpAddr + '/chart?bucket=%d',
      [FBuckets[ARow - 1].BucketID]), OnResponse);
end;

procedure TFormCharts.Timer1Timer(Sender: TObject);
var p : TValuePoint;
begin
    Timer1.Enabled := false;
    for p in FAddValues do
        FormChartSeries.AddValue(p.Addr, p.var_id, p.value, p.time);
    SetLength(FAddValues,0);
end;

procedure TFormCharts.ComboBox1Change(Sender: TObject);
var
    I: integer;
begin
    SetLength(FAddValues,0);
    with StringGrid1 do
    begin
        OnSelectCell := nil;
        with FYearMonth[ComboBox1.ItemIndex] do
            FBuckets := TChartsSvc.BucketsOfYearMonth(year, month);
        RowCount := Length(FBuckets) + 1;
        if RowCount = 1 then
            exit;

        FixedRows := 1;
        Cells[0, 0] := 'День';
        Cells[1, 0] := '№';
        Cells[2, 0] := 'Создан';
        Cells[3, 0] := 'Изменён';
        Cells[4, 0] := 'График';
        
        

        for I := 0 to Length(FBuckets) - 1 do
            with FBuckets[I] do
            begin
                Cells[0, I + 1] := IntToStr2(CreatedAt.Day);
                Cells[1, I + 1] := IntToStr(BucketID);                    
                Cells[2, I + 1] :=
                  Format('%s:%s', [IntToStr2(CreatedAt.hour),
                  IntToStr2(CreatedAt.minute)]);
                Cells[3, I + 1] :=
                  Format('%s:%s', [IntToStr2(UpdatedAt.hour),
                  IntToStr2(UpdatedAt.minute)]);
                Cells[4, I + 1] := Name;                
            end;

        OnSelectCell := StringGrid1SelectCell;
        Row := RowCount - 1;
    end;

end;

procedure TFormCharts.AddValue(Addr, var_id: integer; value: double;
  time: tdateTime);
var
    I: integer;
begin
    for I := 0 to Length(FBuckets) do
        with FBuckets[I], StringGrid1 do
            if (Row = I + 1) AND IsLast then
            begin
                UpdatedAt.year := YearOf(now);
                UpdatedAt.month := MonthOf(now);
                UpdatedAt.Day := DayOf(now);
                UpdatedAt.hour := HourOf(now);
                UpdatedAt.minute := MinuteOf(now);
                Cells[3, Row] :=
                  Format('%s:%s', [IntToStr2(UpdatedAt.hour),
                  IntToStr2(UpdatedAt.minute)]);
                
                SetLength(FAddValues, Length(FAddValues) + 1);
                FAddValues[Length(FAddValues) - 1].Addr := Addr;
                FAddValues[Length(FAddValues) - 1].var_id := var_id;
                FAddValues[Length(FAddValues) - 1].value := value;
                FAddValues[Length(FAddValues) - 1].time := now;
                Timer1.Enabled := true;

            end;
end;

procedure TFormCharts.FetchYearsMonths;
var
    I: integer;
    ym: TYearMonth;
begin
    ComboBox1.Clear;
    FYearMonth := TChartsSvc.YearsMonths;
    if Length(FYearMonth) = 0 then
        with ym do
        begin
            year := YearOf(now);
            month := MonthOf(now);
            FYearMonth := [ym];
        end;

    for I := 0 to Length(FYearMonth) - 1 do
        with FYearMonth[I] do
            ComboBox1.Items.Add(Format('%d %s',
              [year, FormatDateTime('MMMM', IncMonth(0, month))]));

    ComboBox1.ItemIndex := 0;
    ComboBox1Change(nil);
end;

procedure TFormCharts.OnResponse(AResponse: TBytes);
var
    stored_at: tdateTime;
    address, month, Day, hour, minute, second: byte;

    variable, year, millisecond: word;
    value: double;
    ms: TMemoryStream;
    BR: TBinaryReader;

    I: integer;
    n: LongInt;
begin
    ms := TMemoryStream.Create;
    BR := TBinaryReader.Create(ms);

    FormChartSeries.NewChart;

    ms.Write(AResponse, 0, Length(AResponse));
    ms.Seek(0, TSeekOrigin.soBeginning);
    n := BR.ReadInt64;
    for I := 0 to n - 1 do
    begin
        address := BR.ReadByte;
        variable := BR.ReadWord;
        year := BR.ReadWord;
        month := BR.ReadByte;
        Day := BR.ReadByte;
        hour := BR.ReadByte;
        minute := BR.ReadByte;
        second := BR.ReadByte;
        millisecond := BR.ReadWord;

        stored_at := EncodeDateTime(year, month, Day, hour, minute, second,
          millisecond);

        value := BR.ReadDouble;

        FormChartSeries.AddValue(address, variable, value, stored_at);

    end;
    FormChartSeries.show;

    ms.Free;
    BR.Free;
end;

end.
