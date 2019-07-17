unit UnitMainFormMil82;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls,
    Vcl.StdCtrls, Vcl.ToolWin, Vcl.Imaging.pngimage, System.ImageList,
    server_data_types, Vcl.ImgList;

type
    EHostApplicationPanic = class(Exception);

    TMainFormMil82 = class(TForm)
        ImageList4: TImageList;
        PageControlMain: TPageControl;
        TabSheetParty: TTabSheet;
        TabSheetJournal: TTabSheet;
        TabSheetCharts: TTabSheet;
        PanelMessageBox: TPanel;
        ImageError: TImage;
        ImageInfo: TImage;
        PanelMessageBoxTitle: TPanel;
        ToolBar2: TToolBar;
        ToolButton3: TToolButton;
        RichEditlMessageBoxText: TRichEdit;
        PanelTop: TPanel;
        LabelStatusTop: TLabel;
        ToolBar1: TToolBar;
        ToolButtonRun: TToolButton;
        ToolBar3: TToolBar;
        ToolButton1: TToolButton;
        ToolButton4: TToolButton;
        PanelDelay: TPanel;
        LabelDelayElepsedTime: TLabel;
        LabelProgress: TLabel;
        LabelWhatDelay: TLabel;
        LabelDelayTotalTime: TLabel;
        ToolBar6: TToolBar;
        ToolButtonStop: TToolButton;
        Panel2: TPanel;
        ProgressBar1: TProgressBar;
        ToolBarStop: TToolBar;
        ToolButton2: TToolButton;
        PopupMenu1: TPopupMenu;
        N1: TMenuItem;
        TimerDelay: TTimer;
        TimerPerforming: TTimer;
        LabelStatusBottom1: TLabel;
    N821: TMenuItem;
    TabSheetData: TTabSheet;
        procedure FormShow(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure PageControlMainDrawTab(Control: TCustomTabControl;
          TabIndex: Integer; const Rect: TRect; Active: Boolean);
        procedure PageControlMainChange(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
          WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
        procedure ToolButton4Click(Sender: TObject);
        procedure N1Click(Sender: TObject);
        procedure ToolButtonRunClick(Sender: TObject);
        procedure TimerPerformingTimer(Sender: TObject);
        procedure FormResize(Sender: TObject);
        procedure ToolButton2Click(Sender: TObject);
        procedure ToolButton3Click(Sender: TObject);
    procedure N821Click(Sender: TObject);
    procedure TimerDelayTimer(Sender: TObject);
    procedure ToolButtonStopClick(Sender: TObject);
    private
        { Private declarations }
        procedure AppException(Sender: TObject; E: Exception);
        procedure HandleCopydata(var Message: TMessage); message WM_COPYDATA;
        procedure SetupDelay(i: TDelayInfo);
    public
        { Public declarations }

    end;

var
    MainFormMil82: TMainFormMil82;

implementation

{$R *.dfm}

uses UnitFormLastParty, vclutils, JclDebug, ioutils, UnitFormChartSeries, app,
    services, UnitFormAppConfig, notify_services, HttpRpcClient, superobject,
    UnitFormCharts, dateutils, math, HttpExceptions, UnitFormData;

function color_work_result(r: Integer): Tcolor;
begin
    if r = 0 then
        exit(clNavy)
    else if r = 1 then
        exit(clMaroon)
    else
        exit(clRed);
end;

procedure TMainFormMil82.FormCreate(Sender: TObject);
begin

    HttpRpcClient.HttpHostAddr := app.Mil82HttpAddr;

    Application.OnException := AppException;
    LabelStatusTop.Caption := '';
    PanelMessageBox.Width := 700;
    PanelMessageBox.Height := 350;
    LabelStatusBottom1.Caption := '';
end;

procedure TMainFormMil82.FormClose(Sender: TObject; var Action: TCloseAction);
var
    wp: WINDOWPLACEMENT;
    fs: TFileStream;
begin
    NotifyServices_SetEnabled(false);
    HttpRpcClient.TIMEOUT_CONNECT := 10;
    try
        TPeerSvc.Close;
    except
        on ERpcNoResponseException do
            exit;
    end;

    fs := TFileStream.Create(ChangeFileExt(paramstr(0), '.position'),
      fmOpenWrite or fmCreate);
    if not GetWindowPlacement(Handle, wp) then
        raise Exception.Create('GetWindowPlacement: false');
    fs.Write(wp, SizeOf(wp));
    fs.Free;

end;

procedure TMainFormMil82.FormShow(Sender: TObject);
var
    FileName: String;
    wp: WINDOWPLACEMENT;
    fs: TFileStream;
begin

    AppVars := TConfigSvc.vars;

    FileName := ChangeFileExt(paramstr(0), '.position');
    if FileExists(FileName) then
    begin
        fs := TFileStream.Create(FileName, fmOpenRead);
        fs.Read(wp, SizeOf(wp));
        fs.Free;
        SetWindowPlacement(Handle, wp);
    end;

    with FormLastParty do
    begin
        Font.Assign(self.Font);
        Parent := TabSheetParty;
        BorderStyle := bsNone;
        Align := alClient;
        Show;
    end;

    with FormChartSeries do
        begin
            Font.Assign(self.Font);
            Parent := FormCharts;
            BorderStyle := bsNone;
            Align := alClient;
            Show;
        end;

    with FormCharts do
    begin
        Font.Assign(self.Font);
        Parent := TabSheetCharts;
        BorderStyle := bsNone;
        Align := alClient;
        Show;
        FetchYearsMonths;
    end;

    with FormData do
    begin
        Font.Assign(self.Font);
        Parent := TabSheetData;
        BorderStyle := bsNone;
        Align := alClient;
        Show;
        FetchYearsMonths;
    end;



    SetOnWorkStarted(
        procedure(s: string)
        begin
            PanelMessageBox.Hide;
            ToolBarStop.Show;
            LabelStatusTop.Caption := TimeToStr(now) + ' ' + s;
            TimerPerforming.Enabled := true;
            LabelStatusBottom1.Caption := '';
        end);

    SetOnWorkComplete(
        procedure(x: TWorkResultInfo)
        begin

            ImageInfo.Visible := x.Result <> 2;
            ImageError.Visible := x.Result = 2;

            if PanelMessageBox.Visible then
                RichEditlMessageBoxText.Text := RichEditlMessageBoxText.Text +
                  #10#13#10#13
            else
                RichEditlMessageBoxText.Text := '';

            PanelMessageBoxTitle.Caption := x.Work;
            RichEditlMessageBoxText.Text := RichEditlMessageBoxText.Text +
              x.Message;
            RichEditlMessageBoxText.Font.Color := color_work_result(x.Result);
            LabelStatusTop.Font.Color := color_work_result(x.Result);

            PanelMessageBox.Show;
            PanelMessageBox.BringToFront;
            FormResize(self);

            ToolBarStop.Visible := false;
            LabelStatusTop.Caption := TimeToStr(now) + ' ' + x.Work + ': ' +
              x.Message;
            TimerPerforming.Enabled := false;
            LabelStatusBottom1.Caption := '';
            FormLastParty.OnWorkComplete;
        end);

    SetOnAddrError(
        procedure(x: TAddrError)
        begin
            FormLastParty.OnAddrError(x);
            LabelStatusBottom1.Font.Color := clRed;
            LabelStatusBottom1.Caption := Format('$%X: %s',
              [x.Addr, x.Message]);
        end);

    SetOnReadVar(
        procedure(x: TAddrVarValue)
        begin
            LabelStatusBottom1.Font.Color := clNavy;
            LabelStatusBottom1.Caption := Format('$%X: %s[%d]=%s',
              [x.Addr, AppVarName(x.VarCode), x.VarCode, floatToStr(x.Value)]);

            FormLastParty.OnReadAddrVarValue(x);
        end

      );

    SetOnDelay(SetupDelay);

    SetOnWarning(
        procedure(content: string)
        var
            s: string;
        begin
            s := content + #10#13#10#13;
            s := s + '������� OK ����� ������������ ������ � ���������� ������.'#10#13#10#13;
            s := s + '������� ������ ����� ��������.';
            if MessageDlg(s, mtWarning, mbOKCancel, 0) <> IDOK then
                TRunnerSvc.Cancel;
        end);

    NotifyServices_SetEnabled(true);
    TPeerSvc.Init;
end;

procedure TMainFormMil82.FormMouseWheel(Sender: TObject; Shift: TShiftState;
WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
    FormChartSeries.ChangeAxisOrder(GetVCLControlAtPos(self, MousePos),
      WheelDelta);
    // FormCharts.FFormChartSeries.ChangeAxisOrder(GetVCLControlAtPos(self,
    // MousePos), WheelDelta);
end;

procedure TMainFormMil82.FormResize(Sender: TObject);
begin
    if PanelMessageBox.Visible then
    begin
        PanelMessageBox.Left := ClientWidth div 2 - PanelMessageBox.Width div 2;
        PanelMessageBox.Top := ClientHeight div 2 -
          PanelMessageBox.Height div 2;
    end;
end;

procedure TMainFormMil82.PageControlMainChange(Sender: TObject);
var
    PageControl: TPageControl;
begin
    PageControl := Sender as TPageControl;
    PageControl.Repaint;
    PanelMessageBox.Hide;

    if PageControl.ActivePage = TabSheetCharts then
        FormCharts.FetchYearsMonths else
    if PageControl.ActivePage = TabSheetData then
        FormData.FetchYearsMonths else
    if PageControl.ActivePage = TabSheetParty then
        FormLastParty.setup_products;

end;

procedure TMainFormMil82.PageControlMainDrawTab(Control: TCustomTabControl;
TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    PageControl_DrawVerticalTab(Control, TabIndex, Rect, Active);
end;

procedure TMainFormMil82.TimerDelayTimer(Sender: TObject);
var
    s: string;
    v: TDateTime;
begin
    s := LabelDelayElepsedTime.Caption;
    if TryStrToTime(s, v) then
        LabelDelayElepsedTime.Caption := FormatDateTime('HH:mm:ss',
          IncSecond(v));
    ProgressBar1.Position := ProgressBar1.Position +
      Integer(TimerDelay.Interval);

    LabelProgress.Caption :=
      inttostr(ceil(ProgressBar1.Position * 100 / ProgressBar1.Max)) + '%';

end;

procedure TMainFormMil82.TimerPerformingTimer(Sender: TObject);
var
    v: Integer;
begin
    with LabelStatusTop.Font do
        if Color = clRed then
            Color := clblue
        else
            Color := clRed;
end;

procedure TMainFormMil82.ToolButton2Click(Sender: TObject);
begin
    TRunnerSvc.Cancel;
end;

procedure TMainFormMil82.ToolButton3Click(Sender: TObject);
begin
    PanelMessageBox.Hide;
end;

procedure TMainFormMil82.ToolButton4Click(Sender: TObject);
begin
    with ToolButton4 do
        with ClientToScreen(Point(0, Height)) do
        begin
            with FormAppconfig do
            begin
                Left := x - 5 - Width;
                Top := Y + 5;
                Show;
            end;
        end;
end;

procedure TMainFormMil82.ToolButtonRunClick(Sender: TObject);
begin
    with ToolButtonRun do
        with ClientToScreen(Point(0, Height)) do
            PopupMenu1.Popup(x, Y);
end;

procedure TMainFormMil82.ToolButtonStopClick(Sender: TObject);
begin
    TRunnerSvc.SkipDelay;
end;

procedure TMainFormMil82.HandleCopydata(var Message: TMessage);
begin
    notify_services.HandleCopydata(Message);
end;

procedure TMainFormMil82.N1Click(Sender: TObject);
begin
    TRunnerSvc.RunReadVars;
    FormCharts.FetchYearsMonths;
end;

procedure TMainFormMil82.N821Click(Sender: TObject);
begin
    TRunnerSvc.RunMainWork;
    FormCharts.FetchYearsMonths;
end;

procedure TMainFormMil82.AppException(Sender: TObject; E: Exception);
var
    stackList: TJclStackInfoList; // JclDebug.pas
    sl: TStringList;
    stacktrace: string;

    FErrorLog: TextFile;
    ErrorLogFileName: string;
begin

    stackList := JclCreateStackList(false, 0, Caller(0, false));
    sl := TStringList.Create;
    stackList.AddToStrings(sl, true, false, true, false);
    stacktrace := sl.Text;
    sl.Free;
    stackList.Free;
    OutputDebugStringW(PWideChar(E.Message + #10#13 + stacktrace));

    ErrorLogFileName := ChangeFileExt(paramstr(0), '.log');
    AssignFile(FErrorLog, ErrorLogFileName, CP_UTF8);
    if FileExists(ErrorLogFileName) then
        Append(FErrorLog)
    else
        Rewrite(FErrorLog);

    Writeln(FErrorLog, FormatDateTime('dd/MM/yy hh:nn:ss', now), ' ',
      'delphi_exception', ' ', E.ClassName, ' ', stringreplace(Trim(E.Message),
      #13, ' ', [rfReplaceAll, rfIgnoreCase]));

    Writeln(FErrorLog, StringOfChar('-', 120));

    Writeln(FErrorLog, stringreplace(Trim(stacktrace), #13, ' ',
      [rfReplaceAll, rfIgnoreCase]));

    Writeln(FErrorLog, StringOfChar('-', 120));

    CloseFile(FErrorLog);

    if E is EHostApplicationPanic then
    begin
        Application.ShowException(E);
        Application.Terminate;
        exit;
    end;

    if MessageDlg(E.Message, mtError, [mbAbort, mbIgnore], 0) = mrAbort then
    begin
        NotifyServices_SetEnabled(false);
        HttpRpcClient.TIMEOUT_CONNECT := 10;
        try
            TPeerSvc.Close;
        except
            on ERpcNoResponseException do
                exit;
        end;

        Application.OnException := nil;
        Application.Terminate;
        exit;
    end;
end;

procedure TMainFormMil82.SetupDelay(i: TDelayInfo);
begin
    LabelDelayElepsedTime.Caption := '00:00:00';
    LabelDelayTotalTime.Caption := FormatDateTime('HH:mm:ss', IncSecond(i.Seconds));
    LabelWhatDelay.Caption := i.What;
    LabelProgress.Caption := '';
    ProgressBar1.Position := 0;
    ProgressBar1.Max := i.Seconds * 1000;
    PanelDelay.Visible := i.Run;
    TimerDelay.Enabled := i.Run;
end;

end.
