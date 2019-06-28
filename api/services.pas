 
unit services;

interface

uses server_data_types, superobject;

type 
     TLastPartySvc = class 
    public
        class function AddNewProduct: TArray<TLastPartyProduct>;static;
        class function DeleteProduct( param1: Int64) : TArray<TLastPartyProduct>;static;
        class function Party: TParty;static;
        class function Products: TArray<TLastPartyProduct>;static;
        class procedure SetPartySettings( A: TPartySettings) ;static;
        class procedure SetProductAddr( ProductID: Int64; AddrStr: string) ;static;
        class procedure SetProductSerial( ProductID: Int64; SerialStr: string) ;static;
         
    end; TConfigSvc = class 
    public
        class function ProductTypeTemperatures( param1: string) : TTempPlusMinus;static;
        class function ProductTypesNames: TArray<string>;static;
        class procedure SetPlaceChecked( Place: Integer; Checked: Boolean) ;static;
        class procedure SetUserAppSetts( A: TUserAppSettings) ;static;
        class function UserAppSetts: TUserAppSettings;static;
        class function Vars: TArray<TVar>;static;
         
    end;

implementation 

uses HttpRpcClient, SuperObjectHelp, Grijjy.Bson.Serialization;

  
class function TLastPartySvc.AddNewProduct: TArray<TLastPartyProduct>;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('LastPartySvc.AddNewProduct', req, Result); 
end;

 
class function TLastPartySvc.DeleteProduct( param1: Int64) : TArray<TLastPartyProduct>;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.Call('LastPartySvc.DeleteProduct', req, Result); 
end;

 
class function TLastPartySvc.Party: TParty;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('LastPartySvc.Party', req, Result); 
end;

 
class function TLastPartySvc.Products: TArray<TLastPartyProduct>;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('LastPartySvc.Products', req, Result); 
end;

 
class procedure TLastPartySvc.SetPartySettings( A: TPartySettings) ;
var
    req : ISuperobject;
    s:string;
begin
    req := SO;
    TgoBsonSerializer.serialize(A, s); req['A'] := SO(s);
    ThttpRpcClient.GetResponse('LastPartySvc.SetPartySettings', req); 
end;

 
class procedure TLastPartySvc.SetProductAddr( ProductID: Int64; AddrStr: string) ;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'ProductID', ProductID);
    SuperObject_SetField(req, 'AddrStr', AddrStr);
    ThttpRpcClient.GetResponse('LastPartySvc.SetProductAddr', req); 
end;

 
class procedure TLastPartySvc.SetProductSerial( ProductID: Int64; SerialStr: string) ;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'ProductID', ProductID);
    SuperObject_SetField(req, 'SerialStr', SerialStr);
    ThttpRpcClient.GetResponse('LastPartySvc.SetProductSerial', req); 
end;

  
class function TConfigSvc.ProductTypeTemperatures( param1: string) : TTempPlusMinus;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.Call('ConfigSvc.ProductTypeTemperatures', req, Result); 
end;

 
class function TConfigSvc.ProductTypesNames: TArray<string>;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('ConfigSvc.ProductTypesNames', req, Result); 
end;

 
class procedure TConfigSvc.SetPlaceChecked( Place: Integer; Checked: Boolean) ;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'Checked', Checked);
    ThttpRpcClient.GetResponse('ConfigSvc.SetPlaceChecked', req); 
end;

 
class procedure TConfigSvc.SetUserAppSetts( A: TUserAppSettings) ;
var
    req : ISuperobject;
    s:string;
begin
    req := SO;
    TgoBsonSerializer.serialize(A, s); req['A'] := SO(s);
    ThttpRpcClient.GetResponse('ConfigSvc.SetUserAppSetts', req); 
end;

 
class function TConfigSvc.UserAppSetts: TUserAppSettings;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('ConfigSvc.UserAppSetts', req, Result); 
end;

 
class function TConfigSvc.Vars: TArray<TVar>;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('ConfigSvc.Vars', req, Result); 
end;

 
end.