
unit notify_services;

interface
uses server_data_types, superobject, Winapi.Windows, Winapi.Messages;
type
    TStringHandler = reference to procedure (x:string);
    TAddrVarValueHandler = reference to procedure (x:TAddrVarValue);
    

procedure HandleCopydata(var Message: TMessage);

procedure SetOnPanic( AHandler : TStringHandler);
procedure SetOnReadVar( AHandler : TAddrVarValueHandler);
procedure SetOnError( AHandler : TStringHandler);

procedure NotifyServices_SetEnabled(enabled:boolean);

implementation 
uses Grijjy.Bson.Serialization, stringutils, sysutils;

type
    TServerAppCmd = (CmdPanic, CmdReadVar, 
    CmdError);

    type _deserializer = record
        class function deserialize<T>(str:string):T;static;
    end;

var
    _OnPanic : TStringHandler;
    _OnReadVar : TAddrVarValueHandler;
    _OnError : TStringHandler;
    _enabled:boolean;

class function _deserializer.deserialize<T>(str:string):T;
begin
    TgoBsonSerializer.Deserialize(str, Result);
end;

procedure NotifyServices_SetEnabled(enabled:boolean);
begin
   _enabled := enabled;
end;

procedure HandleCopydata(var Message: TMessage);
var
    cd: PCOPYDATASTRUCT;
    cmd: TServerAppCmd;
    str:string;
begin
    if not _enabled then
        exit;
    cd := PCOPYDATASTRUCT(Message.LParam);
    cmd := TServerAppCmd(Message.WParam);
    Message.result := 1;
    SetString(str, PWideChar(cd.lpData), cd.cbData div 2);
    case cmd of
        CmdPanic:
        begin
            if not Assigned(_OnPanic) then
                raise Exception.Create('_OnPanic must be set');
            _OnPanic(str);
        end;
        CmdReadVar:
        begin
            if not Assigned(_OnReadVar) then
                raise Exception.Create('_OnReadVar must be set');
            _OnReadVar(_deserializer.deserialize<TAddrVarValue>(str));
        end;
        CmdError:
        begin
            if not Assigned(_OnError) then
                raise Exception.Create('_OnError must be set');
            _OnError(str);
        end;
        
    else
        raise Exception.Create('wrong message: ' + IntToStr(Message.WParam));
    end;
end;

procedure SetOnPanic( AHandler : TStringHandler);
begin
    if Assigned(_OnPanic) then
        raise Exception.Create('_OnPanic already set');
    _OnPanic := AHandler;
end;
procedure SetOnReadVar( AHandler : TAddrVarValueHandler);
begin
    if Assigned(_OnReadVar) then
        raise Exception.Create('_OnReadVar already set');
    _OnReadVar := AHandler;
end;
procedure SetOnError( AHandler : TStringHandler);
begin
    if Assigned(_OnError) then
        raise Exception.Create('_OnError already set');
    _OnError := AHandler;
end;


initialization
    _enabled := false;

end.