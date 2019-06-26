 
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
         
    end; TConfigSvc = class 
    public
        class function Vars: TArray<string>;static;
         
    end;

implementation 

uses HttpRpcClient, SuperObjectHelp;

  
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

  
class function TConfigSvc.Vars: TArray<string>;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('ConfigSvc.Vars', req, Result); 
end;

 
end.