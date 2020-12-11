unit Logger;

interface

type
  TLogKind = (lkError, lkInfo, lkWarning);

  TLogger = class
  private
    class procedure CheckEventLogHandle;
    class procedure Write(AEntryType: Word; AEventId: Cardinal; AMessage: string); static;
    class procedure WriteError(AMessage: string); static;
    class procedure WriteInfo(AMessage: string); static;
    class procedure WriteWarning(AMessage: string); static;
  public
    class var Source: string;
    class destructor Destroy;

    class procedure Log(AMessage: string;ALogKind:TLogKind);

   // class procedure AddEventSourceToRegistry; static;

    class procedure AddEventSourceToRegistry(ASource, AFilename: string);static;
  end;

threadvar EventLogHandle: THandle;

implementation

uses Windows, Registry, SysUtils;

class destructor TLogger.Destroy;
begin
  if EventLogHandle > 0 then
  begin
    DeregisterEventSource(EventLogHandle);
  end;
end;

class procedure TLogger.Log(AMessage: string; ALogKind: TLogKind);
begin
case ALogKind of
  lkError:   Write(EVENTLOG_ERROR_TYPE, 2, AMessage);
  lkInfo:  Write(EVENTLOG_INFORMATION_TYPE, 2, AMessage);
  lkWarning:  Write(EVENTLOG_WARNING_TYPE, 2, AMessage);
end;
end;

class procedure TLogger.WriteInfo(AMessage: string);
begin
  Write(EVENTLOG_INFORMATION_TYPE, 2, AMessage);
end;

class procedure TLogger.WriteWarning(AMessage: string);
begin
  Write(EVENTLOG_WARNING_TYPE, 3, AMessage);
end;

class procedure TLogger.WriteError(AMessage: string);
begin
  Write(EVENTLOG_ERROR_TYPE, 4, AMessage);
end;

class procedure TLogger.CheckEventLogHandle;
begin
  if EventLogHandle = 0 then
  begin
   EventLogHandle := RegisterEventSource(nil, PChar(Source));
  end;
  if EventLogHandle <= 0 then
  begin
    raise Exception.Create('Could not obtain Event Log handle.');
  end;
end;

class procedure TLogger.Write(AEntryType: Word; AEventId: Cardinal; AMessage: string);
begin
  CheckEventLogHandle;
  ReportEvent(EventLogHandle, AEntryType, 0, AEventId, nil, 1, 0, @AMessage, nil);
end;

class procedure TLogger.AddEventSourceToRegistry(ASource, AFilename: string);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.OpenKey('\SYSTEM\CurrentControlSet\Services\Eventlog\Application\' + ASource, True) then
    begin
      reg.WriteString('EventMessageFile', AFilename);
      reg.WriteInteger('TypesSupported', 7);
      reg.CloseKey;
    end
    else
    begin
      raise Exception.Create('Error updating the registry. This action requires administrative rights.');
    end;
  finally
    reg.Free;
  end;
end;

initialization

TLogger.Source := 'MyApplicationName';  // Application Name

end.
