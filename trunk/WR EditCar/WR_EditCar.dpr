program WR_EditCar;

uses
  Forms,
  WR_EditCar1 in 'WR_EditCar1.pas' {Form1},
  WR_EditCar_Lang in 'WR_EditCar_Lang.pas',
  WR_AboutBox in '..\ Common \WR_AboutBox.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MBWR\WR2 EditCar';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;

  end.
