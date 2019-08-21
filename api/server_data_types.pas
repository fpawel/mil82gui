
unit server_data_types;

interface

uses Grijjy.Bson, Grijjy.Bson.Serialization;

type
    
    TLastPartyProduct = record
    public
        Serial : Integer;
        Addr : Byte;
        Place : Integer;
        Checked : Boolean;
        ProductID : Int64;
        
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
        C2 : Double;
        C3 : Double;
        C4 : Double;
        ProductType : string;
        C1 : Double;
        
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
        ComportGas : string;
        TemperaturePlus : Double;
        InterrogateProductVarIntervalMillis : Integer;
        ComportTemperature : string;
        TemperatureMinus : Double;
        BlowGasMinutes : Integer;
        
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
    
    TTimeDelphi = record
    public
        Minute : Integer;
        Second : Integer;
        Millisecond : Integer;
        Year : Integer;
        Month : Integer;
        Day : Integer;
        Hour : Integer;
        
    end;
    
    TYearMonth = record
    public
        Year : Integer;
        Month : Integer;
        
    end;
    
    TPartyCatalogue = record
    public
        Hour : Integer;
        Minute : Integer;
        PartyID : Int64;
        ProductType : string;
        Last : Boolean;
        Day : Integer;
        
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
        TotalSeconds : Integer;
        ElapsedSeconds : Integer;
        What : string;
        
    end;
    

implementation

end.