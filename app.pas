unit app;

interface
uses  inifiles, server_data_types;

var
    AppSets :  TInifile;
    AppVars: TArray<TVar>;
    Mil82HttpAddr: string;

function AppVarName(code:integer):string;
function AppVarCode(name:string):integer;

implementation

uses registry, winapi.windows, sysutils, stringutils;

function AppVarName(code:integer):string;
var
  I: Integer;
begin
    for I := 0 to Length(AppVars)-1 do
        if AppVars[i].Code = code then
            exit(AppVars[i].Name);
    exit(inttostr2(code));
end;

function AppVarCode(name:string):integer;
var
  I: Integer;
begin
    for I := 0 to Length(AppVars)-1 do
        if AppVars[i].Name = name then
            exit(AppVars[i].Code);
    exit(-1);
end;

function GetMil82HttpAddr: string;
var
    key: TRegistry;
begin
    key := TRegistry.Create(KEY_READ);
    try
        if not key.OpenKey('mil82\http', False) then
            raise Exception.Create('cant open mil82\http');
        result := key.ReadString('addr');
    finally
        key.CloseKey;
        key.Free;
    end;
end;


initialization

AppSets := TIniFile.Create(ChangeFileExt(paramstr(0), '.ini'));

Mil82HttpAddr :=  GetMil82HttpAddr;

end.

