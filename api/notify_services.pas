
unit notify_services;

interface
uses server_data_types, superobject, Winapi.Windows, Winapi.Messages;
type
    TAddrErrorHandler = reference to procedure (x:TAddrError);
    TWorkResultInfoHandler = reference to procedure (x:TWorkResultInfo);
    TDelayInfoHandler = reference to procedure (x:TDelayInfo);
    TStringHandler = reference to procedure (x:string);
    TAddrVarValueHandler = reference to procedure (x:TAddrVarValue);
    

procedure HandleCopydata(var Message: TMessage);

procedure SetOnPanic( AHandler : TStringHandler);
procedure SetOnReadVar( AHandler : TAddrVarValueHandler);
procedure SetOnAddrError( AHandler : TAddrErrorHandler);
procedure SetOnWorkStarted( AHandler : TStringHandler);
procedure SetOnWorkComplete( AHandler : TWorkResultInfoHandler);
procedure SetOnWarning( AHandler : TStringHandler);
procedure SetOnDelay( AHandler : TDelayInfoHandler);

procedure NotifyServices_SetEnabled(enabled:boolean);

implementation 
uses Grijjy.Bson.Serialization, stringutils, sysutils;

type
    TServerAppCmd = (CmdPanic, CmdReadVar, CmdAddrError, CmdWorkStarted, CmdWorkComplete, CmdWarning, 
    CmdDelay);

    type _deserializer = record
        class function deserialize<T>(str:string):T;static;
    end;

var
    _OnPanic : TStringHandler;
    _OnReadVar : TAddrVarValueHandler;
    _OnAddrError : TAddrErrorHandler;
    _OnWorkStarted : TStringHandler;
    _OnWorkComplete : TWorkResultInfoHandler;
    _OnWarning : TStringHandler;
    _OnDelay : TDelayInfoHandler;
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
        CmdAddrError:
        begin
            if not Assigned(_OnAddrError) then
                raise Exception.Create('_OnAddrError must be set');
            _OnAddrError(_deserializer.deserialize<TAddrError>(str));
        end;
        CmdWorkStarted:
        begin
            if not Assigned(_OnWorkStarted) then
                raise Exception.Create('_OnWorkStarted must be set');
            _OnWorkStarted(str);
        end;
        CmdWorkComplete:
        begin
            if not Assigned(_OnWorkComplete) then
                raise Exception.Create('_OnWorkComplete must be set');
            _OnWorkComplete(_deserializer.deserialize<TWorkResultInfo>(str));
        end;
        CmdWarning:
        begin
            if not Assigned(_OnWarning) then
                raise Exception.Create('_OnWarning must be set');
            _OnWarning(str);
        end;
        CmdDelay:
        begin
            if not Assigned(_OnDelay) then
                raise Exception.Create('_OnDelay must be set');
            _OnDelay(_deserializer.deserialize<TDelayInfo>(str));
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
procedure SetOnAddrError( AHandler : TAddrErrorHandler);
begin
    if Assigned(_OnAddrError) then
        raise Exception.Create('_OnAddrError already set');
    _OnAddrError := AHandler;
end;
procedure SetOnWorkStarted( AHandler : TStringHandler);
begin
    if Assigned(_OnWorkStarted) then
        raise Exception.Create('_OnWorkStarted already set');
    _OnWorkStarted := AHandler;
end;
procedure SetOnWorkComplete( AHandler : TWorkResultInfoHandler);
begin
    if Assigned(_OnWorkComplete) then
        raise Exception.Create('_OnWorkComplete already set');
    _OnWorkComplete := AHandler;
end;
procedure SetOnWarning( AHandler : TStringHandler);
begin
    if Assigned(_OnWarning) then
        raise Exception.Create('_OnWarning already set');
    _OnWarning := AHandler;
end;
procedure SetOnDelay( AHandler : TDelayInfoHandler);
begin
    if Assigned(_OnDelay) then
        raise Exception.Create('_OnDelay already set');
    _OnDelay := AHandler;
end;


initialization
    _enabled := false;

end.