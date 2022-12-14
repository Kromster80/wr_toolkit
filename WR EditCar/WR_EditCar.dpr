program WR_EditCar;
uses
  Forms,
  WR_EditCar1 in 'WR_EditCar1.pas' {Form1},
  WR_EditCar_Lang in 'WR_EditCar_Lang.pas',
  WR_AboutBox in '..\_Common_\WR_AboutBox.pas' {AboutForm},
  WR_DataSet in '..\_Common_\WR_DataSet.pas';

{$R *.res}

var
  Form1: TForm1;

begin
  Application.Initialize;
  Application.Title := 'MBWR\WR2 EditCar';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
