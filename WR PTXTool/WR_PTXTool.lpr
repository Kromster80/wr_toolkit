program WR_PTXTool;

{$MODE Delphi}

uses
  Forms, Interfaces,
  WR_PTX1 in 'WR_PTX1.pas' {Form1},
  WR_AboutBox in ' Common \WR_AboutBox.pas' {AboutForm},
  WR_PTX_TDXT_Alpha in 'WR_PTX_TDXT_Alpha.pas',
  WR_PTX_TDisplayImage in 'WR_PTX_TDisplayImage.pas', WR_PTX_TDXT_Color;

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MBWR/WR2 PTX Tool';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
