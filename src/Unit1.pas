unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SvcMgr, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    rbLogger: TRadioButton;
    rbEventLogger: TRadioButton;
    procedure LogWithSvcMgr;
    procedure LogWithHelper;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Logger;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if rbEventLogger.Checked then
    LogWithSvcMgr
  else
    LogWithHelper;
end;

procedure TForm1.LogWithHelper;
begin
  TLogger.Source := 'MyApplicationName';
  TLogger.Log('This is an information.', lkInfo);
  TLogger.Log('This is an error.', lkError);
  TLogger.Log('This is an warning.', lkWarning);
end;

procedure TForm1.LogWithSvcMgr;
begin

  with TEventLogger.Create('MyApplicationName') do
  begin
    LogMessage('This is an error.', EVENTLOG_SUCCESS, 12345);
    LogMessage('This is another error.', EVENTLOG_ERROR_TYPE, 12345);
    LogMessage('This is information.', EVENTLOG_INFORMATION_TYPE, 12345);
    LogMessage('This is a warning.', EVENTLOG_WARNING_TYPE, 12345);
  end;

end;

end.
