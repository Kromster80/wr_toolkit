program MultiEx;
uses
  Forms,
  MultiEx_unit1 in 'MultiEx_unit1.pas' {Form1},
  WR_AboutBox in 'WR_AboutBox.pas' {AboutForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Synetic Extractor';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
