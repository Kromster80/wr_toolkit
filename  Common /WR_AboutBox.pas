unit WR_AboutBox;
interface
uses Forms, ShellApi, Classes, Controls, StdCtrls, Windows, ExtCtrls, Graphics, KromUtils, Math;

type
  TAboutForm = class(TForm)
    About_Link: TLabel;
    Label_VersionInfo: TLabel;
    Label3: TLabel;
    Image1: TImage;
    Label_Text: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    procedure URLClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MailToClick(Sender: TObject);
  private
    ToolVersion:string;
  public
    procedure Show(aVersionInfo,aText,aToolVersion4URL:string); overload;
  end;

var
  AboutForm: TAboutForm;

implementation
{$R *.dfm}

procedure TAboutForm.Show(aVersionInfo,aText,aToolVersion4URL:string);
begin
  Label_VersionInfo.Caption:=aVersionInfo;
  Label_Text.Caption:=aText;
  ToolVersion:=aToolVersion4URL;
  Width:=max(256,Label_VersionInfo.Width+64); //Fit version info
  Show;
end;

procedure TAboutForm.MailToClick(Sender: TObject);
begin
  MailTo('kromster80@gmail.com','','');
end;

procedure TAboutForm.URLClick(Sender: TObject);
begin
  OpenMySite(ToolVersion);
end;

procedure TAboutForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key=27 then AboutForm.Close;   //ESC
end;

end.
