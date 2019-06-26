unit UnitMainFormMil82;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ToolWin, Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList;

type
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
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PageControlMainDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure PageControlMainChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainFormMil82: TMainFormMil82;

implementation

{$R *.dfm}

uses UnitFormLastParty, vclutils;

procedure TMainFormMil82.FormCreate(Sender: TObject);
begin
    LabelStatusTop.Caption := '';
    PanelMessageBox.Width := 700;
    PanelMessageBox.Height := 350;
end;

procedure TMainFormMil82.FormShow(Sender: TObject);
begin
    with FormLastParty do
    begin
        Font.Assign(self.Font);
        Parent := TabSheetParty;
        BorderStyle := bsNone;
        Align := alTop;
        Show;
    end;

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

end.
