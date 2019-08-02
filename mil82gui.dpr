program mil82gui;

uses
  Vcl.Forms,
  superdate in 'utils\superobject\superdate.pas',
  superobject in 'utils\superobject\superobject.pas',
  supertimezone in 'utils\superobject\supertimezone.pas',
  supertypes in 'utils\superobject\supertypes.pas',
  superxmlparser in 'utils\superobject\superxmlparser.pas',
  Grijjy.BinaryCoding in 'grijjy\Grijjy.BinaryCoding.pas',
  Grijjy.Bson in 'grijjy\Grijjy.Bson.pas',
  Grijjy.Bson.Serialization in 'grijjy\Grijjy.Bson.Serialization.pas',
  Grijjy.Console in 'grijjy\Grijjy.Console.pas',
  Grijjy.DateUtils in 'grijjy\Grijjy.DateUtils.pas',
  Grijjy.Hash in 'grijjy\Grijjy.Hash.pas',
  Grijjy.Hooking in 'grijjy\Grijjy.Hooking.pas',
  Grijjy.Http in 'grijjy\Grijjy.Http.pas',
  Grijjy.JWT in 'grijjy\Grijjy.JWT.pas',
  Grijjy.MemoryPool in 'grijjy\Grijjy.MemoryPool.pas',
  Grijjy.PropertyBag in 'grijjy\Grijjy.PropertyBag.pas',
  Grijjy.SocketPool.Win in 'grijjy\Grijjy.SocketPool.Win.pas',
  Grijjy.System in 'grijjy\Grijjy.System.pas',
  Grijjy.SysUtils in 'grijjy\Grijjy.SysUtils.pas',
  Grijjy.Uri in 'grijjy\Grijjy.Uri.pas',
  Grijjy.Winsock2 in 'grijjy\Grijjy.Winsock2.pas',
  Grijjy.OpenSSL.API in 'grijjy\Grijjy.OpenSSL.API.pas',
  Grijjy.Bson.IO in 'grijjy\Grijjy.Bson.IO.pas',
  Grijjy.Collections in 'grijjy\Grijjy.Collections.pas',
  Grijjy.OpenSSL in 'grijjy\Grijjy.OpenSSL.pas',
  SuperObjectHelp in 'utils\SuperObjectHelp.pas',
  notify_services in 'api\notify_services.pas',
  server_data_types in 'api\server_data_types.pas',
  services in 'api\services.pas',
  stringutils in 'utils\stringutils.pas',
  stringgridutils in 'utils\stringgridutils.pas',
  ComponentBaloonHintU in 'utils\ComponentBaloonHintU.pas',
  ujsonrpc in 'utils\jsonrpc\ujsonrpc.pas',
  app in 'app.pas',
  UnitFormLastParty in 'UnitFormLastParty.pas' {FormLastParty},
  UnitMainFormMil82 in 'UnitMainFormMil82.pas' {MainFormMil82},
  UnitFormChartSeries in 'UnitFormChartSeries.pas' {FormChartSeries},
  vclutils in 'utils\vclutils.pas',
  UnitFormAppConfig in 'UnitFormAppConfig.pas' {FormAppConfig},
  comport in 'utils\comport.pas',
  hardware_errors in 'utils\hardware_errors.pas',
  UnitFormCharts in 'UnitFormCharts.pas' {FormCharts},
  HttpRpcClient in 'api\HttpRpcClient.pas',
  HttpClient in 'api\HttpClient.pas',
  HttpExceptions in 'api\HttpExceptions.pas',
  UnitFormData in 'UnitFormData.pas' {FormData},
  UnitFormModalMessage in 'UnitFormModalMessage.pas' {FormModalMessage};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainFormMil82, MainFormMil82);
  Application.CreateForm(TFormLastParty, FormLastParty);
  Application.CreateForm(TFormChartSeries, FormChartSeries);
  Application.CreateForm(TFormAppConfig, FormAppConfig);
  Application.CreateForm(TFormCharts, FormCharts);
  Application.CreateForm(TFormData, FormData);
  Application.CreateForm(TFormModalMessage, FormModalMessage);
  Application.Run;
end.
