unit info;

interface

var Vars : TArray<string>;

implementation

uses services;

initialization

   Vars := TConfigSvc.Vars;

end.
