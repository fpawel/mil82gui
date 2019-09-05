
unit services;

interface

uses superobject, server_data_types;

type 
    TLastPartySvc = class
    public
        class function AddNewProduct:TArray<TLastPartyProduct>;static;
        class function DeleteProduct(param1:Int64):TArray<TLastPartyProduct>;static;
        class function Party:TParty;static;
        class function Products:TArray<TLastPartyProduct>;static;
        class function Products1:TArray<TProduct>;static;
        class function ProductsValues(param1:Int64):TTable;static;
        class procedure SetPartySettings(A:TPartySettings);static;
        class procedure SetProductAddr(ProductID:Int64; AddrStr:string);static;
        class procedure SetProductSerial(ProductID:Int64; SerialStr:string);static;
         
    end;

    TConfigSvc = class
    public
        class function ProductTypeTemperatures(param1:string):TTempPlusMinus;static;
        class function ProductTypesNames:TArray<string>;static;
        class procedure SetPlaceChecked(Place:Integer; Checked:Boolean);static;
        class procedure SetUserAppSetts(A:TUserAppSettings);static;
        class function UserAppSetts:TUserAppSettings;static;
        class function Vars:TArray<TVar>;static;
         
    end;

    TRunnerSvc = class
    public
        class procedure Cancel;static;
        class procedure RunMainWork;static;
        class procedure RunReadVars;static;
        class procedure SkipDelay;static;
         
    end;

    TChartsSvc = class
    public
        class function BucketsOfYearMonth(Year:Integer; Month:Integer):TArray<TChartsBucket>;static;
        class function DeletePoints(BucketID:Int64; Addresses:TArray<Byte>; Vars:TArray<Word>; ValueMinimum:Double; ValueMaximum:Double; TimeMinimum:TTimeDelphi; TimeMaximum:TTimeDelphi):Int64;static;
        class function YearsMonths:TArray<TYearMonth>;static;
         
    end;

    TPartiesSvc = class
    public
        class procedure NewParty;static;
        class function PartiesOfYearMonth(Year:Integer; Month:Integer):TArray<TPartyCatalogue>;static;
        class function PartyProducts(param1:Int64):TArray<TProduct>;static;
        class function PartyProductsValues(param1:Int64; param2:Int64):TTable;static;
        class function YearsMonths:TArray<TYearMonth>;static;
         
    end;

    

function GetHttpServerAddr: string;

implementation 

uses System.SysUtils, registry, winapi.windows, HttpRpcClient, SuperObjectHelp, Grijjy.Bson.Serialization;

function GetHttpServerAddr: string;
var
    key: TRegistry;
begin
    key := TRegistry.Create(KEY_READ);
    try
        if not key.OpenKey( 'mil82\http', False) then
            raise Exception.Create('cant open mil82\http');
        result := key.ReadString('addr');
    finally
        key.CloseKey;
        key.Free;
    end;
end;

 
class function TLastPartySvc.AddNewProduct:TArray<TLastPartyProduct>;
var
    req : ISuperobject;
begin
    req := SO;
    
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'LastPartySvc.AddNewProduct', req, Result); 
end;


class function TLastPartySvc.DeleteProduct(param1:Int64):TArray<TLastPartyProduct>;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1); 
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'LastPartySvc.DeleteProduct', req, Result); 
end;


class function TLastPartySvc.Party:TParty;
var
    req : ISuperobject;
begin
    req := SO;
    
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'LastPartySvc.Party', req, Result); 
end;


class function TLastPartySvc.Products:TArray<TLastPartyProduct>;
var
    req : ISuperobject;
begin
    req := SO;
    
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'LastPartySvc.Products', req, Result); 
end;


class function TLastPartySvc.Products1:TArray<TProduct>;
var
    req : ISuperobject;
begin
    req := SO;
    
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'LastPartySvc.Products1', req, Result); 
end;


class function TLastPartySvc.ProductsValues(param1:Int64):TTable;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1); 
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'LastPartySvc.ProductsValues', req, Result); 
end;


class procedure TLastPartySvc.SetPartySettings(A:TPartySettings);
var
    req : ISuperobject;s:string;
begin
    req := SO;
    TgoBsonSerializer.serialize(A, s); req['A'] := SO(s); 
    ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'LastPartySvc.SetPartySettings', req); 
end;


class procedure TLastPartySvc.SetProductAddr(ProductID:Int64; AddrStr:string);
var
    req : ISuperobject;s:string;
begin
    req := SO;
    SuperObject_SetField(req, 'ProductID', ProductID); SuperObject_SetField(req, 'AddrStr', AddrStr); 
    ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'LastPartySvc.SetProductAddr', req); 
end;


class procedure TLastPartySvc.SetProductSerial(ProductID:Int64; SerialStr:string);
var
    req : ISuperobject;s:string;
begin
    req := SO;
    SuperObject_SetField(req, 'ProductID', ProductID); SuperObject_SetField(req, 'SerialStr', SerialStr); 
    ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'LastPartySvc.SetProductSerial', req); 
end;

 
class function TConfigSvc.ProductTypeTemperatures(param1:string):TTempPlusMinus;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1); 
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ConfigSvc.ProductTypeTemperatures', req, Result); 
end;


class function TConfigSvc.ProductTypesNames:TArray<string>;
var
    req : ISuperobject;
begin
    req := SO;
    
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ConfigSvc.ProductTypesNames', req, Result); 
end;


class procedure TConfigSvc.SetPlaceChecked(Place:Integer; Checked:Boolean);
var
    req : ISuperobject;s:string;
begin
    req := SO;
    SuperObject_SetField(req, 'Place', Place); SuperObject_SetField(req, 'Checked', Checked); 
    ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'ConfigSvc.SetPlaceChecked', req); 
end;


class procedure TConfigSvc.SetUserAppSetts(A:TUserAppSettings);
var
    req : ISuperobject;s:string;
begin
    req := SO;
    TgoBsonSerializer.serialize(A, s); req['A'] := SO(s); 
    ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'ConfigSvc.SetUserAppSetts', req); 
end;


class function TConfigSvc.UserAppSetts:TUserAppSettings;
var
    req : ISuperobject;
begin
    req := SO;
    
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ConfigSvc.UserAppSetts', req, Result); 
end;


class function TConfigSvc.Vars:TArray<TVar>;
var
    req : ISuperobject;
begin
    req := SO;
    
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ConfigSvc.Vars', req, Result); 
end;

 
class procedure TRunnerSvc.Cancel;
var
    req : ISuperobject;
begin
    req := SO;
    
    ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'RunnerSvc.Cancel', req); 
end;


class procedure TRunnerSvc.RunMainWork;
var
    req : ISuperobject;
begin
    req := SO;
    
    ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'RunnerSvc.RunMainWork', req); 
end;


class procedure TRunnerSvc.RunReadVars;
var
    req : ISuperobject;
begin
    req := SO;
    
    ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'RunnerSvc.RunReadVars', req); 
end;


class procedure TRunnerSvc.SkipDelay;
var
    req : ISuperobject;
begin
    req := SO;
    
    ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'RunnerSvc.SkipDelay', req); 
end;

 
class function TChartsSvc.BucketsOfYearMonth(Year:Integer; Month:Integer):TArray<TChartsBucket>;
var
    req : ISuperobject;s:string;
begin
    req := SO;
    SuperObject_SetField(req, 'Year', Year); SuperObject_SetField(req, 'Month', Month); 
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ChartsSvc.BucketsOfYearMonth', req, Result); 
end;


class function TChartsSvc.DeletePoints(BucketID:Int64; Addresses:TArray<Byte>; Vars:TArray<Word>; ValueMinimum:Double; ValueMaximum:Double; TimeMinimum:TTimeDelphi; TimeMaximum:TTimeDelphi):Int64;
var
    req : ISuperobject;s:string;
begin
    req := SO;
    SuperObject_SetField(req, 'BucketID', BucketID); SuperObject_SetField(req, 'Addresses', Addresses); SuperObject_SetField(req, 'Vars', Vars); SuperObject_SetField(req, 'ValueMinimum', ValueMinimum); SuperObject_SetField(req, 'ValueMaximum', ValueMaximum); TgoBsonSerializer.serialize(TimeMinimum, s); req['TimeMinimum'] := SO(s); TgoBsonSerializer.serialize(TimeMaximum, s); req['TimeMaximum'] := SO(s); 
    SuperObject_Get(ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'ChartsSvc.DeletePoints', req), Result); 
end;


class function TChartsSvc.YearsMonths:TArray<TYearMonth>;
var
    req : ISuperobject;
begin
    req := SO;
    
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ChartsSvc.YearsMonths', req, Result); 
end;

 
class procedure TPartiesSvc.NewParty;
var
    req : ISuperobject;
begin
    req := SO;
    
    ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'PartiesSvc.NewParty', req); 
end;


class function TPartiesSvc.PartiesOfYearMonth(Year:Integer; Month:Integer):TArray<TPartyCatalogue>;
var
    req : ISuperobject;s:string;
begin
    req := SO;
    SuperObject_SetField(req, 'Year', Year); SuperObject_SetField(req, 'Month', Month); 
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'PartiesSvc.PartiesOfYearMonth', req, Result); 
end;


class function TPartiesSvc.PartyProducts(param1:Int64):TArray<TProduct>;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1); 
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'PartiesSvc.PartyProducts', req, Result); 
end;


class function TPartiesSvc.PartyProductsValues(param1:Int64; param2:Int64):TTable;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1); req.AsArray.Add(param2); 
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'PartiesSvc.PartyProductsValues', req, Result); 
end;


class function TPartiesSvc.YearsMonths:TArray<TYearMonth>;
var
    req : ISuperobject;
begin
    req := SO;
    
    ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'PartiesSvc.YearsMonths', req, Result); 
end;

 
end.