unit app;

interface
uses  inifiles, server_data_types;

var
    AppSets :  TInifile;
    AppVars: TArray<TVar>;

function AppVarName(code:integer):string;
function AppVarCode(name:string):integer;

implementation

uses sysutils, stringutils;

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


initialization

AppSets := TIniFile.Create(ChangeFileExt(paramstr(0), '.ini'));

end.

