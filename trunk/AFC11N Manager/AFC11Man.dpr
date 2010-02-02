program AFC11Man;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  SupprtUnit2 in 'SupprtUnit2.pas',
  Unit2 in 'Unit2.pas' {Form2},
  WR_AboutBox in 'WR_AboutBox.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'AFC11 Manager';
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
