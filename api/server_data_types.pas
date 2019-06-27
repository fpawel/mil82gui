
unit server_data_types;

interface

uses Grijjy.Bson, Grijjy.Bson.Serialization;

type
     
    TLastPartyProduct = record
    public 
        ProductID : Int64;
        PartyID : Int64;
        CreatedAt : TDateTime;
        Serial : Integer;
        Addr : Integer;
        Place : Integer;
        Checked : Boolean;
        
    end;
 
    TParty = record
    public 
        PartyID : Int64;
        CreatedAt : TDateTime;
        ProductType : string;
        C1 : Single;
        C2 : Single;
        C3 : Single;
        C4 : Single;
        
    end;
 
    TUserAppSettings = record
    public 
        ComportProducts : string;
        ComportTemperature : string;
        ComportGas : string;
        TemperatureMinus : Double;
        TemperaturePlus : Double;
        BlowGasMinutes : Integer;
        BlowAirMinutes : Integer;
        HoldTemperatureMinutes : Integer;
        
    end;
 
    TVar = record
    public 
        Code : Integer;
        Name : string;
        
    end;


implementation 



end.