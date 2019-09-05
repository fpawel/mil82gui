
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
        Addr : Byte;
        ProductID : Int64;
        Serial : Integer;
        
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
        C1 : Double;
        C2 : Double;
        C3 : Double;
        C4 : Double;
        ProductType : string;
        
    end;
    
    TTempPlusMinus = record
    public
        TempPlus : Double;
        TempMinus : Double;
        
    end;
    
    TUserAppSettings = record
    public
        BlowGasMinutes : Integer;
        HoldTemperatureMinutes : Integer;
        ComportTemperature : string;
        TemperatureMinus : Double;
        TemperaturePlus : Double;
        BlowAirMinutes : Integer;
        InterrogateProductVarIntervalMillis : Integer;
        ComportProducts : string;
        ComportGas : string;
        
    end;
    
    TVar = record
    public
        Code : Word;
        Name : string;
        
    end;
    
    TTimeDelphi = record
    public
        Year : Integer;
        Month : Integer;
        Day : Integer;
        Hour : Integer;
        Minute : Integer;
        Second : Integer;
        Millisecond : Integer;
        
    end;
    
    TChartsBucket = record
    public
        IsLast : Boolean;
        CreatedAt : TTimeDelphi;
        UpdatedAt : TTimeDelphi;
        BucketID : Int64;
        Name : string;
        
    end;
    
    TYearMonth = record
    public
        Year : Integer;
        Month : Integer;
        
    end;
    
    TPartyCatalogue = record
    public
        Last : Boolean;
        Day : Integer;
        Hour : Integer;
        Minute : Integer;
        PartyID : Int64;
        ProductType : string;
        
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