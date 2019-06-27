unit UnitFormAppConfig;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, System.Generics.collections,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
    ComponentBaloonHintU;

type
    TFormAppConfig = class(TForm)
        Panel19: TPanel;
        Panel20: TPanel;
        Panel1: TPanel;
        Shape1: TShape;
        Panel2: TPanel;
        ComboBoxComportProducts: TComboBox;
        Panel3: TPanel;
        Shape2: TShape;
        Panel4: TPanel;
        EditPgs1: TEdit;
        Panel5: TPanel;
        Shape3: TShape;
        Panel6: TPanel;
        ComboBoxComportTemp: TComboBox;
        Panel7: TPanel;
        Shape4: TShape;
        Panel8: TPanel;
        EditPgs4: TEdit;
        Panel9: TPanel;
        Shape5: TShape;
        Panel10: TPanel;
        EditPgs3: TEdit;
        Panel11: TPanel;
        Shape6: TShape;
        Panel12: TPanel;
        EditPgs2: TEdit;
        Panel13: TPanel;
        Shape7: TShape;
        Panel14: TPanel;
        EdTempTime: TEdit;
        Panel15: TPanel;
        Shape8: TShape;
        Panel16: TPanel;
        EdGasTime: TEdit;
        procedure FormCreate(Sender: TObject);
        procedure FormDeactivate(Sender: TObject);
        procedure FormShow(Sender: TObject);
    private
        { Private declarations }

    public
        { Public declarations }
    end;

var
    FormAppConfig: TFormAppConfig;

implementation

{$R *.dfm}

uses stringutils, services;

procedure TFormAppConfig.FormCreate(Sender: TObject);
begin
    //
end;

procedure TFormAppConfig.FormShow(Sender: TObject);
begin
    //
end;


procedure TFormAppConfig.FormDeactivate(Sender: TObject);
begin
    Hide;
end;



end.
