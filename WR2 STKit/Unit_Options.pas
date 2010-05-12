unit Unit_Options;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface
uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, Spin, unit1, CheckLst, Math, KromUtils,
  StdCtrls, FileCtrl, ExtCtrls, Defaults;

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

{$IFDEF VER140}
  {$R *.dfm}
{$ENDIF}
{$IFDEF FPC}
  {$R *.lfm}
{$ENDIF}

procedure TFormOptions.FormShow(Sender: TObject);
begin
  FPSLimit.Value  := 1000 div fOptions.FPSLag;
  ViewDist.Value  := round(fOptions.ViewDistance/10);
  SplineDet.Value := fOptions.SplineDetail;

  case fOptions.TopDownRenderH of
    1024: CB_ResH.ItemIndex:=0;
    2048: CB_ResH.ItemIndex:=1;
    4096: CB_ResH.ItemIndex:=2;
    8192: CB_ResH.ItemIndex:=3;
    else  CB_ResH.ItemIndex:=1;
  end;
  case fOptions.TopDownRenderV of
    1024: CB_ResV.ItemIndex:=0;
    2048: CB_ResV.ItemIndex:=1;
    4096: CB_ResV.ItemIndex:=2;
    8192: CB_ResV.ItemIndex:=3;
    else  CB_ResV.ItemIndex:=1;
  end;

  WorkFolder.Text := fOptions.WorkDir;
  if Form1.RG2.ItemIndex <> -1 then
    ActiveScenery   := Form1.RG2.Items[Form1.RG2.ItemIndex];
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

Form1.RG2.Clear;
if DirectoryExists(fOptions.WorkDir+'Scenarios\') then begin
ChDir(fOptions.WorkDir+'Scenarios\');
FindFirst('*', faDirectory, SearchRec);
    repeat
    if (SearchRec.Attr and faDirectory=faDirectory)
    and(SearchRec.Name<>'.')and(SearchRec.Name<>'..')
    and(directoryexists(fOptions.WorkDir+'Scenarios\'+SearchRec.Name)) then
    Form1.RG2.Items.Add(SearchRec.Name);
    until (FindNext(SearchRec)<>0);
FindClose(SearchRec);
end;

Form1.RG2.ItemIndex:=0;
for i:=1 to Form1.RG2.Items.Count do
if Form1.RG2.Items[i-1]=ActiveScenery then Form1.RG2.ItemIndex:=i-1;

//Form1.SceneryReload(nil);
FormOptions.Hide;
end;


procedure TFormOptions.CancelButtonClick(Sender: TObject); begin
  FormOptions.Hide;
end;


procedure TFormOptions.Button1Click(Sender: TObject);
var fpath:string;
begin
  fpath:=WorkFolder.Text;
  SelectDirectory('Folder','',fpath);
  if fpath[length(fpath)]<>'\' then fpath:=fpath+'\';
  WorkFolder.Text:=fpath;
end;


end.
