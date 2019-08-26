
unit server_data_types;

interface

uses Grijjy.Bson, Grijjy.Bson.Serialization;

type
    
    TLastPartyProduct = record
    public
        ProductID : Int64;
        Serial : Integer;
        Addr : Byte;
        Place : Integer;
        Checked : Boolean;
        
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
        InterrogateProductVarIntervalMillis : Integer;
        ComportTemperature : string;
        TemperaturePlus : Double;
        BlowAirMinutes : Integer;
        BlowGasMinutes : Integer;
        HoldTemperatureMinutes : Integer;
        ComportProducts : string;
        ComportGas : string;
        TemperatureMinus : Double;
        
    end;
    
    TVar = record
    public
        Code : Word;
        Name : string;
        
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
        PartyID : Int64;
        ProductType : string;
        Last : Boolean;
        Day : Integer;
        Hour : Integer;
        Minute : Integer;
        
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