
unit server_data_types;

interface

uses Grijjy.Bson, Grijjy.Bson.Serialization;

type
     
    TProduct = record
    public 
        ProductID : Int64;
        PartyID : Int64;
        CreatedAt : TDateTime;
        Serial : Integer;
        Addr : Byte;
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
        Code : Word;
        Name : string;
        
    end;
 
    TChartsBucket = record
    public 
        Day : Integer;
        Hour : Integer;
        Minute : Integer;
        BucketID : Int64;
        Name : string;
        Last : Boolean;
        
    end;
 
    TChartsYearMonth = record
    public 
        Year : Integer;
        Month : Integer;
        
    end;
 
    TAddrVarValue = record
    public 
        Addr : Byte;
        VarCode : Word;
        Value : Double;
        
    end;
 
    TAddrError = record
    public 
        Addr : Byte;
        Message : string;
        
    end;
 
    TWorkResultInfo = record
    public 
        Work : string;
        Result : Integer;
        Message : string;
        
    end;
 
    TDelayInfo = record
    public 
        Run : Boolean;
        Seconds : Integer;
        What : string;
        
    end;


implementation 



end.