
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
        ProductType : string;
        C1 : Double;
        C2 : Double;
        C3 : Double;
        C4 : Double;
        PartyID : Int64;
        CreatedAt : TDateTime;
        
    end;
 
    TPartySettings = record
    public 
        ProductType : string;
        C1 : Double;
        C2 : Double;
        C3 : Double;
        C4 : Double;
        
    end;
 
    TTempPlusMinus = record
    public 
        TempPlus : Double;
        TempMinus : Double;
        
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
 
    TAddrVarValue = record
    public 
        Addr : Byte;
        Var : Word;
        Value : Double;
        
    end;


implementation 



end.