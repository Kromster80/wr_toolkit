program WR_Manager;

uses
  Forms,
  WR_Manager_unit1 in 'WR_Manager_unit1.pas' {Form1},
  WR_AboutBox in 'WR_AboutBox.pas' {AboutForm},
  WR_Manager_SetName in 'WR_Manager_SetName.pas' {Form2},
  WR_Manager_Splash in 'WR_Manager_Splash.pas' {Form3},
  WR_Manager_ReleaseNotesForm in 'WR_Manager_ReleaseNotesForm.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MBWR Manager';
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
