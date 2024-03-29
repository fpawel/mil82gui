
unit notify_services;

interface

uses superobject, Winapi.Windows, Winapi.Messages, server_data_types;

type
    TAddrVarValueHandler = reference to procedure (x:TAddrVarValue);
    TAddrErrorHandler = reference to procedure (x:TAddrError);
    TWorkResultInfoHandler = reference to procedure (x:TWorkResultInfo);
    TDelayInfoHandler = reference to procedure (x:TDelayInfo);
    TProcedure = reference to procedure;
    TStringHandler = reference to procedure (x:string);
    

procedure HandleCopydata(var Message: TMessage);
procedure CloseServerWindow;

procedure SetOnPanic( AHandler : TStringHandler);
procedure SetOnReadVar( AHandler : TAddrVarValueHandler);
procedure SetOnAddrError( AHandler : TAddrErrorHandler);
procedure SetOnWorkStarted( AHandler : TStringHandler);
procedure SetOnWorkComplete( AHandler : TWorkResultInfoHandler);
procedure SetOnWarning( AHandler : TStringHandler);
procedure SetOnDelay( AHandler : TDelayInfoHandler);
procedure SetOnEndDelay( AHandler : TStringHandler);
procedure SetOnStatus( AHandler : TStringHandler);
procedure SetOnNewChart( AHandler : TProcedure);

procedure NotifyServices_SetEnabled(enabled:boolean);

implementation 

uses Grijjy.Bson.Serialization, stringutils, sysutils;

type
    TServerAppCmd = (CmdPanic, CmdReadVar, CmdAddrError, CmdWorkStarted, CmdWorkComplete, CmdWarning, CmdDelay, CmdEndDelay, CmdStatus, 
    CmdNewChart);

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
    _OnEndDelay : TStringHandler;
    _OnStatus : TStringHandler;
    _OnNewChart : TProcedure;
    _enabled:boolean;

procedure CloseServerWindow;
begin
    SendMessage(FindWindow('Mil82ServerWindow', nil), WM_CLOSE, 0, 0)
end;

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
        CmdEndDelay:
        begin
            if not Assigned(_OnEndDelay) then
                raise Exception.Create('_OnEndDelay must be set');
            _OnEndDelay(str);
        end;
        CmdStatus:
        begin
            if not Assigned(_OnStatus) then
                raise Exception.Create('_OnStatus must be set');
            _OnStatus(str);
        end;
        CmdNewChart:
        begin
            if not Assigned(_OnNewChart) then
                raise Exception.Create('_OnNewChart must be set');
            _OnNewChart();
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
procedure SetOnEndDelay( AHandler : TStringHandler);
begin
    if Assigned(_OnEndDelay) then
        raise Exception.Create('_OnEndDelay already set');
    _OnEndDelay := AHandler;
end;
procedure SetOnStatus( AHandler : TStringHandler);
begin
    if Assigned(_OnStatus) then
        raise Exception.Create('_OnStatus already set');
    _OnStatus := AHandler;
end;
procedure SetOnNewChart( AHandler : TProcedure);
begin
    if Assigned(_OnNewChart) then
        raise Exception.Create('_OnNewChart already set');
    _OnNewChart := AHandler;
end;


initialization
    _enabled := false;

end.