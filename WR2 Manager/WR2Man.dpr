program WR2Man;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit_WRTools in 'Unit_WRTools.pas',
  Unit2 in 'Unit2.pas' {Form2},
  Unit_RuntimeFXP in 'Unit_RuntimeFXP.pas',
  Unit_WR2DS in 'Unit_WR2DS.pas',
  Unit_INI in 'Unit_INI.pas',
  Unit_Search in 'Unit_Search.pas',
  WR_AboutBox in '..\ Common \WR_AboutBox.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'WR2 Manager';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TAboutForm, AboutForm);
  Form1.FormCreate(nil);

  Application.Run;

end.
