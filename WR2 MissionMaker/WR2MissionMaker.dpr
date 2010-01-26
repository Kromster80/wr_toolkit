program WR2MissionMaker;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  SupprtUnit2 in 'SupprtUnit2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'WR2 Manager';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
