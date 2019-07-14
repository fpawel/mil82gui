unit UnitFormAppConfig;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, System.Generics.collections,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
    ComponentBaloonHintU;

type
    EWrongInputExcpetion = class(Exception);

    TFormAppConfig = class(TForm)
        Panel21: TPanel;
        GroupBox2: TGroupBox;
        Panel1: TPanel;
        Shape1: TShape;
        Panel2: TPanel;
        ComboBoxComportProducts: TComboBox;
        Panel17: TPanel;
        Shape9: TShape;
        Panel18: TPanel;
        ComboBoxComportGas: TComboBox;
        Panel5: TPanel;
        Panel6: TPanel;
        ComboBoxComportTemp: TComboBox;
        GroupBox3: TGroupBox;
        Panel13: TPanel;
        Shape3: TShape;
        Panel14: TPanel;
        ComboBoxProductTypeName: TComboBox;
        Panel15: TPanel;
        Shape4: TShape;
        Panel16: TPanel;
        EditC1: TEdit;
        Panel22: TPanel;
        Shape7: TShape;
        Panel23: TPanel;
        EditC2: TEdit;
        Panel24: TPanel;
        Shape8: TShape;
        Panel25: TPanel;
    EditC3: TEdit;
        Panel26: TPanel;
        Panel27: TPanel;
        EditC4: TEdit;
        Panel3: TPanel;
        GroupBox4: TGroupBox;
        Panel4: TPanel;
        Shape2: TShape;
        Panel19: TPanel;
        EditDurMinutesBlowGas: TEdit;
        Panel20: TPanel;
        Shape10: TShape;
        Panel28: TPanel;
        EditDurMinutesBlowAir: TEdit;
        Panel29: TPanel;
        Panel30: TPanel;
        EditDurMinutesHoldT: TEdit;
        GroupBox1: TGroupBox;
        Panel9: TPanel;
        Shape6: TShape;
        Panel10: TPanel;
        EditTempMinus: TEdit;
        Panel11: TPanel;
        Panel12: TPanel;
        EditTempPlus: TEdit;
        procedure FormCreate(Sender: TObject);
        procedure FormDeactivate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure ComboBoxComportProductsChange(Sender: TObject);
        procedure ComboBoxProductTypeNameChange(Sender: TObject);
    private
        { Private declarations }
        FhWndTip: THandle;
        FEnableOnEdit: boolean;
        procedure WMWindowPosChanged(var AMessage: TMessage);
          message WM_WINDOWPOSCHANGED;
        procedure WMEnterSizeMove(var Msg: TMessage); message WM_ENTERSIZEMOVE;

        procedure WMActivateApp(var AMessage: TMessage); message WM_ACTIVATEAPP;
        procedure ShowBalloonTip(c: TWinControl; Icon: TIconKind;
          Title, Text: string);

        function TryEditToInt(ed: TEdit): Integer;
        function TryEditToFloat(ed: TEdit): double;

    public
        { Public declarations }
    end;

var
    FormAppConfig: TFormAppConfig;

implementation

{$R *.dfm}

uses stringutils, services, server_data_types, comport;

procedure setupCB(cb: TComboBox; s: string);
begin
    cb.ItemIndex := cb.Items.IndexOf(s);
end;

procedure TFormAppConfig.FormCreate(Sender: TObject);
begin
    FEnableOnEdit := false;
end;

procedure TFormAppConfig.FormShow(Sender: TObject);
var
    s: string;
    v: TUserAppSettings;

    p: TParty;

begin
    FEnableOnEdit := false;
    ComboBoxProductTypeName.Items.Clear;
    for s in TConfigSvc.ProductTypesNames do
        ComboBoxProductTypeName.Items.Add(s);
    EnumComports(ComboBoxComportProducts.Items);
    EnumComports(ComboBoxComportTemp.Items);
    EnumComports(ComboBoxComportGas.Items);
    v := TConfigSvc.UserAppSetts;

    setupCB(ComboBoxComportProducts, v.ComportProducts);
    setupCB(ComboBoxComportTemp, v.ComportTemperature);
    setupCB(ComboBoxComportGas, v.ComportGas);

    EditDurMinutesBlowGas.Text := IntToStr(v.BlowGasMinutes);
    EditDurMinutesBlowAir.Text := IntToStr(v.BlowAirMinutes);
    EditDurMinutesHoldT.Text := IntToStr(v.HoldTemperatureMinutes);
    EditTempMinus.Text := FloatToStr(v.TemperatureMinus);
    EditTempPlus.Text := FloatToStr(v.TemperaturePlus);

    p := TLastPartySvc.Party;
    setupCB(ComboBoxProductTypeName, p.ProductType);
    EditC1.Text := FloatToStr(p.C1);
    EditC2.Text := FloatToStr(p.C2);
    EditC3.Text := FloatToStr(p.C3);
    EditC4.Text := FloatToStr(p.C4);

    FEnableOnEdit := true;
end;

procedure TFormAppConfig.FormDeactivate(Sender: TObject);
begin
    Hide;
end;

procedure TFormAppConfig.ComboBoxProductTypeNameChange(Sender: TObject);
var
    v: TPartySettings;
    x:TTempPlusMinus;
begin
    if not FEnableOnEdit then
        exit;
    CloseWindow(FhWndTip);
    try
        v.ProductType := ComboBoxProductTypeName.Text;
        v.C1 := TryEditToFloat(EditC1);
        v.C2 := TryEditToFloat(EditC2);
        v.C3 := TryEditToFloat(EditC3);
        v.C4 := TryEditToFloat(EditC4);

        CloseWindow(FhWndTip);
        TLastPartySvc.SetPartySettings(v);
        if Sender = ComboboxProductTypeName then
        with TConfigSvc.ProductTypeTemperatures(ComboboxProductTypeName.Text) do
        begin
            FEnableOnEdit := false;
            EditTempMinus.Text := floattostr(TempMinus);
            EditTempPlus.Text := floattostr(TempPlus);
            FEnableOnEdit := true;
            ComboBoxComportProductsChange(EditTempMinus);
        end;

        TLastPartySvc.SetPartySettings(v);

        (Sender as TWinControl).SetFocus;
    except
        on EWrongInputExcpetion do
            exit;
    end;

end;

procedure TFormAppConfig.ComboBoxComportProductsChange(Sender: TObject);
var
    v: TUserAppSettings;
begin
    if not FEnableOnEdit then
        exit;
    CloseWindow(FhWndTip);

    try
        v.ComportProducts := ComboBoxComportProducts.Text;
        v.ComportTemperature := ComboBoxComportTemp.Text;
        v.ComportGas := ComboBoxComportGas.Text;
        v.BlowGasMinutes := TryEditToInt(EditDurMinutesBlowGas);
        v.BlowAirMinutes := TryEditToInt(EditDurMinutesBlowAir);
        v.HoldTemperatureMinutes := TryEditToInt(EditDurMinutesHoldT);
        v.TemperatureMinus := TryEditToFloat(EditTempMinus);
        v.TemperaturePlus := TryEditToFloat(EditTempPlus);
        TConfigSvc.SetUserAppSetts(v);

        (Sender as TWinControl).SetFocus;
    except
        on EWrongInputExcpetion do
            exit;
    end;
end;

procedure TFormAppConfig.WMEnterSizeMove(var Msg: TMessage);
begin
    CloseWindow(FhWndTip);
    inherited;
end;

procedure TFormAppConfig.WMWindowPosChanged(var AMessage: TMessage);
begin
    CloseWindow(FhWndTip);
    inherited;
end;

procedure TFormAppConfig.WMActivateApp(var AMessage: TMessage);
begin
    CloseWindow(FhWndTip);
    inherited;
end;

procedure TFormAppConfig.ShowBalloonTip(c: TWinControl; Icon: TIconKind;
  Title, Text: string);
begin
    CloseWindow(FhWndTip);
    FhWndTip := ComponentBaloonHintU.ShowBalloonTip(c, Icon, Title, Text);
end;

function TFormAppConfig.TryEditToInt(ed: TEdit): Integer;
begin
    if TryStrToInt(ed.Text, result) then
        exit(result);
    ShowBalloonTip(ed, TIconKind.Error, 'не допустимое значение',
      'ожидалось целое число');
    ed.SetFocus;
    raise EWrongInputExcpetion.Create('');


end;

function TFormAppConfig.TryEditToFloat(ed: TEdit): double;
begin
    if try_str_to_float(ed.Text, result) then
        exit(result);
    ShowBalloonTip(ed, TIconKind.Error, 'не допустимое значение',
      'ожидалось число c плавающей точкой');
    ed.SetFocus;
    raise EWrongInputExcpetion.Create('');

end;

end.
