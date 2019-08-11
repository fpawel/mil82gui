
unit server_data_types;

interface

uses Grijjy.Bson, Grijjy.Bson.Serialization;

type
    
    TLastPartyProduct = record
    public
        Addr : Byte;
        Place : Integer;
        Checked : Boolean;
        ProductID : Int64;
        Serial : Integer;
        
    end;
    
    TParty = record
    public
        C2 : Double;
        C3 : Double;
        C4 : Double;
        PartyID : Int64;
        CreatedAt : TDateTime;
        ProductType : string;
        C1 : Double;
        
    end;
    
    TProduct = record
    public
        ProductID : Int64;
        Serial : Integer;
        Addr : Byte;
        
    end;
    
    TCell = record
    public
        ValueType : Integer;
        Text : string;
        Detail : string;
        
    end;
    
    TRow = record
    public
        Cells : TArray<TCell>;
        
    end;
    
    TTable = record
    public
        Rows : TArray<TRow>;
        
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
        BlowAirMinutes : Integer;
        HoldTemperatureMinutes : Integer;
        ComportProducts : string;
        BlowGasMinutes : Integer;
        TemperatureMinus : Double;
        TemperaturePlus : Double;
        InterrogateProductVarIntervalMillis : Integer;
        ComportTemperature : string;
        ComportGas : string;
        
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
    
    TYearMonth = record
    public
        Month : Integer;
        Year : Integer;
        
    end;
    
    TPartyCatalogue = record
    public
        PartyID : Int64;
        ProductType : string;
        Last : Boolean;
        Day : Integer;
        Hour : Integer;
        Minute : Integer;
        
    end;
    
    TAddrVarValue = record
    public
        VarCode : Word;
        Value : Double;
        Addr : Byte;
        
    end;
    
    TAddrError = record
    public
        Message : string;
        Addr : Byte;
        
    end;
    
    TWorkResultInfo = record
    public
        Work : string;
        Result : Integer;
        Message : string;
        
    end;
    
    TDelayInfo = record
    public
        ElapsedSeconds : Integer;
        What : string;
        TotalSeconds : Integer;
        
    end;
    

implementation

end.