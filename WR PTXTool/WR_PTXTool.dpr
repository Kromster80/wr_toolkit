program WR_PTXTool;
uses
  Forms,
  WR_PTX1 in 'WR_PTX1.pas' {fmPTXTool},
  WR_AboutBox in '..\_Common_\WR_AboutBox.pas' {AboutForm},
  WR_PTX_TDisplayImage in 'WR_PTX_TDisplayImage.pas',
  WR_DXTCompressorAlpha in 'WR_DXTCompressorAlpha.pas',
  WR_DXTCompressorColor in 'WR_DXTCompressorColor.pas';

{$R *.RES}

var
  fmPTXTool: TfmPTXTool;

begin
  Application.Initialize;
  Application.Title := 'MBWR/WR2 PTX Tool';
  Application.CreateForm(TfmPTXTool, fmPTXTool);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
