program mil82gui;

uses
  Vcl.Forms,
  superdate in 'utils\superobject\superdate.pas',
  superobject in 'utils\superobject\superobject.pas',
  supertimezone in 'utils\superobject\supertimezone.pas',
  supertypes in 'utils\superobject\supertypes.pas',
  superxmlparser in 'utils\superobject\superxmlparser.pas',
  Grijjy.BinaryCoding in '..\..\grijjy\GrijjyFoundation\Grijjy.BinaryCoding.pas',
  Grijjy.Bson.IO in '..\..\grijjy\GrijjyFoundation\Grijjy.Bson.IO.pas',
  Grijjy.Bson in '..\..\grijjy\GrijjyFoundation\Grijjy.Bson.pas',
  Grijjy.Bson.Path in '..\..\grijjy\GrijjyFoundation\Grijjy.Bson.Path.pas',
  Grijjy.Bson.Serialization in '..\..\grijjy\GrijjyFoundation\Grijjy.Bson.Serialization.pas',
  Grijjy.Collections in '..\..\grijjy\GrijjyFoundation\Grijjy.Collections.pas',
  Grijjy.Console in '..\..\grijjy\GrijjyFoundation\Grijjy.Console.pas',
  Grijjy.DateUtils in '..\..\grijjy\GrijjyFoundation\Grijjy.DateUtils.pas',
  Grijjy.Hash in '..\..\grijjy\GrijjyFoundation\Grijjy.Hash.pas',
  Grijjy.Hooking in '..\..\grijjy\GrijjyFoundation\Grijjy.Hooking.pas',
  Grijjy.Http in '..\..\grijjy\GrijjyFoundation\Grijjy.Http.pas',
  Grijjy.JWT in '..\..\grijjy\GrijjyFoundation\Grijjy.JWT.pas',
  Grijjy.MemoryPool in '..\..\grijjy\GrijjyFoundation\Grijjy.MemoryPool.pas',
  Grijjy.PropertyBag in '..\..\grijjy\GrijjyFoundation\Grijjy.PropertyBag.pas',
  Grijjy.SocketPool.Win in '..\..\grijjy\GrijjyFoundation\Grijjy.SocketPool.Win.pas',
  Grijjy.System in '..\..\grijjy\GrijjyFoundation\Grijjy.System.pas',
  Grijjy.SysUtils in '..\..\grijjy\GrijjyFoundation\Grijjy.SysUtils.pas',
  Grijjy.Uri in '..\..\grijjy\GrijjyFoundation\Grijjy.Uri.pas',
  Grijjy.Winsock2 in '..\..\grijjy\GrijjyFoundation\Grijjy.Winsock2.pas',
  Grijjy.OpenSSL in '..\..\grijjy\GrijjyFoundation\Grijjy.OpenSSL.pas',
  Grijjy.OpenSSL.API in '..\..\grijjy\GrijjyFoundation\Grijjy.OpenSSL.API.pas',
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
  HttpExceptions in 'api\HttpExceptions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainFormMil82, MainFormMil82);
  Application.CreateForm(TFormLastParty, FormLastParty);
  Application.CreateForm(TFormChartSeries, FormChartSeries);
  Application.CreateForm(TFormAppConfig, FormAppConfig);
  Application.CreateForm(TFormCharts, FormCharts);
  Application.Run;
end.
