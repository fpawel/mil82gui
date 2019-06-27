unit UnitMainFormMil82;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls,
    Vcl.StdCtrls, Vcl.ToolWin, Vcl.Imaging.pngimage, System.ImageList,
    Vcl.ImgList;

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
    TabSheetChart: TTabSheet;
        procedure FormShow(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure PageControlMainDrawTab(Control: TCustomTabControl;
          TabIndex: Integer; const Rect: TRect; Active: Boolean);
        procedure PageControlMainChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure ToolButton4Click(Sender: TObject);
    private
        { Private declarations }
        procedure AppException(Sender: TObject; E: Exception);
    public
        { Public declarations }

    end;

var
    MainFormMil82: TMainFormMil82;

implementation

{$R *.dfm}

uses UnitFormLastParty, vclutils, JclDebug, ioutils, UnitFormChartSeries, app,
  services, UnitFormAppConfig;



procedure TMainFormMil82.FormCreate(Sender: TObject);
begin

    Application.OnException := AppException;
    LabelStatusTop.Caption := '';
    PanelMessageBox.Width := 700;
    PanelMessageBox.Height := 350;
end;



procedure TMainFormMil82.FormClose(Sender: TObject; var Action: TCloseAction);
var wp: WINDOWPLACEMENT;
    fs: TFileStream;
begin
    fs := TFileStream.Create(ChangeFileExt(paramstr(0), '.position'), fmOpenWrite or fmCreate);
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



    with FormChartSeries do
    begin
        Font.Assign(self.Font);
        Parent := TabSheetChart;
        BorderStyle := bsNone;
        Align := alClient;
        Show;
    end;

    with FormLastParty do
    begin
        Font.Assign(self.Font);
        Parent := TabSheetParty;
        BorderStyle := bsNone;
        Align := alClient;
        Show;
    end;



end;

procedure TMainFormMil82.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
    FormChartSeries.ChangeAxisOrder(GetVCLControlAtPos(self, MousePos),
      WheelDelta);
//    FormCharts.FFormChartSeries.ChangeAxisOrder(GetVCLControlAtPos(self,
//      MousePos), WheelDelta);
end;

procedure TMainFormMil82.PageControlMainChange(Sender: TObject);
var
    PageControl: TPageControl;
begin
    PageControl := Sender as TPageControl;
    PageControl.Repaint;
    PanelMessageBox.Hide;

end;

procedure TMainFormMil82.PageControlMainDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    PageControl_DrawVerticalTab(Control, TabIndex, Rect, Active);
end;

procedure TMainFormMil82.ToolButton4Click(Sender: TObject);
begin
    with ToolButton4 do
        with ClientToScreen(Point(0, Height)) do
        begin
            with FormAppconfig do
            begin
                Left := X - 5 - Width;
                Top := Y + 5;
                Show;
            end;
        end;
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
        Application.OnException := nil;
        Application.Terminate;
        exit;
    end;
end;

end.
