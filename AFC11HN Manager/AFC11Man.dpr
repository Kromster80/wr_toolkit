program AFC11Man;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  WR_AboutBox in '..\_Common_\WR_AboutBox.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'AFC11HN Manager';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TAboutForm, AboutForm);
  Form1.FormCreate(nil);
  Application.Run;
end.
