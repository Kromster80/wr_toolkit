program DSExplorer;

uses
  Vcl.Forms,
  Unit_DSExplorer in 'Unit_DSExplorer.pas',
  UnitMainForm in 'UnitMainForm.pas' {Form7};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
