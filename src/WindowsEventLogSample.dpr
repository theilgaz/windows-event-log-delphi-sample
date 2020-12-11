program WindowsEventLogSample;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Logger in 'Logger.pas';

{$R *.res}
{$R MessageFile.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  TLogger.AddEventSourceToRegistry('MyApplicationName', ParamStr(0));
  Application.Run;
end.

