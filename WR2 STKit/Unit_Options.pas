unit Unit_Options;
interface
uses
  SysUtils, Classes, Controls, Forms, Dialogs, Spin, unit1, KromUtils, StdCtrls, ExtCtrls, FileCtrl;

type
  TFormOptions = class(TForm)
    ApplyButton: TButton;
    FPSLimit: TSpinEdit;
    Label1: TLabel;
    Label4: TLabel;
    CancelButton: TButton;
    Button1: TButton;
    WorkFolder: TEdit;
    ViewDist: TSpinEdit;
    Label2: TLabel;
    SplineDet: TSpinEdit;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    CB_ResH: TComboBox;
    CB_ResV: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    procedure ApplyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  end;

var
  FormOptions: TFormOptions;
  ActiveScenery:string;

implementation
{$R *.dfm}

procedure TFormOptions.FormShow(Sender: TObject);
begin
  WorkFolder.Text := fOptions.WorkDir;

  FPSLimit.Value  := 1000 div fOptions.FPSLag;
  ViewDist.Value  := round(fOptions.ViewDistance/10);
  SplineDet.Value := fOptions.SplineDetail;

  case fOptions.TopDownRenderH of
    1024: CB_ResH.ItemIndex := 0;
    2048: CB_ResH.ItemIndex := 1;
    4096: CB_ResH.ItemIndex := 2;
    8192: CB_ResH.ItemIndex := 3;
    else  CB_ResH.ItemIndex := 1;
  end;
  case fOptions.TopDownRenderV of
    1024: CB_ResV.ItemIndex := 0;
    2048: CB_ResV.ItemIndex := 1;
    4096: CB_ResV.ItemIndex := 2;
    8192: CB_ResV.ItemIndex := 3;
    else  CB_ResV.ItemIndex := 1;
  end;

  if Form1.cbScenery.ItemIndex <> -1 then //
    ActiveScenery   := Form1.cbScenery.Items[Form1.cbScenery.ItemIndex];
end;


procedure TFormOptions.ApplyClick(Sender: TObject);
var i:integer; SearchRec:TSearchRec;
begin
  fOptions.WorkDir:=WorkFolder.Text;
  if FPSLimit.Value=100 then
    fOptions.FPSLag:=1 //unlimited
  else
    fOptions.FPSLag:=round(1000 / FPSLimit.Value);
  fOptions.ViewDistance := ViewDist.Value*10;
  fOptions.SplineDetail := SplineDet.Value;
  case CB_ResH.ItemIndex of
    0:   fOptions.TopDownRenderH := 1024;
    1:   fOptions.TopDownRenderH := 2048;
    2:   fOptions.TopDownRenderH := 4096;
    3:   fOptions.TopDownRenderH := 8192;
    else fOptions.TopDownRenderH := 1024;
  end;
  case CB_ResV.ItemIndex of
    0:   fOptions.TopDownRenderV := 1024;
    1:   fOptions.TopDownRenderV := 2048;
    2:   fOptions.TopDownRenderV := 4096;
    3:   fOptions.TopDownRenderV := 8192;
    else fOptions.TopDownRenderV := 1024;
  end;

  Form1.cbScenery.Clear;
  if DirectoryExists(fOptions.WorkDir+'Scenarios\') then
  begin
  ChDir(fOptions.WorkDir+'Scenarios\');
  FindFirst('*', faDirectory, SearchRec);
      repeat
      if (SearchRec.Attr and faDirectory=faDirectory)
      and(SearchRec.Name<>'.')and(SearchRec.Name<>'..')
      and(directoryexists(fOptions.WorkDir+'Scenarios\'+SearchRec.Name)) then
      Form1.cbScenery.Items.Add(SearchRec.Name);
      until (FindNext(SearchRec)<>0);
  FindClose(SearchRec);
  end;

  Form1.cbScenery.ItemIndex := 0;
  for i:=0 to Form1.cbScenery.Items.Count - 1 do
    if Form1.cbScenery.Items[I] = ActiveScenery then
      Form1.cbScenery.ItemIndex := I;

  //Form1.SceneryReload(nil);
  FormOptions.Hide;
end;


procedure TFormOptions.CancelButtonClick(Sender: TObject); begin
  FormOptions.Hide;
end;


procedure TFormOptions.Button1Click(Sender: TObject);
var aPath:string;
begin
  aPath := WorkFolder.Text;
  if not SelectDirectory('Browse for World Racing 2 folder', '', aPath) then exit; //Do no changes if user clicked Cancel
  WorkFolder.Text := IncludeTrailingPathDelimiter(aPath);
end;


end.
