unit WR_AboutBox;
interface
uses
  Forms, Classes, Controls, StdCtrls, ExtCtrls, Graphics, KromUtils,
  Math;

type
  TAboutForm = class(TForm)
    Image1: TImage;
    lbName: TLabel;
    lbVersion: TLabel;
    lbText: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    Label2: TLabel;
    lbContactEmail: TLabel;
    Label4: TLabel;
    lbWebsiteLink: TLabel;
    procedure URLClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MailToClick(Sender: TObject);
  private
    fURLReference: string;
  public
    procedure Show(const aName, aVersion, aText, aURLReference: string); overload;
  end;

var
  AboutForm: TAboutForm;

implementation
{$R *.dfm}

procedure TAboutForm.Show(const aName, aVersion, aText, aURLReference: string);
begin
  lbName.Caption := aName;
  lbVersion.Caption := aVersion;
  lbText.Caption := aText;

  fURLReference := aURLReference;

  ClientWidth := Max(1, Max(lbVersion.Width, lbText.Width) + 32);

  Height := lbText.Top + lbText.Height + 24 + (Height - Bevel1.Top);

  Show;
end;


procedure TAboutForm.MailToClick(Sender: TObject);
begin
  MailTo('kromster80@gmail.com', '', '');
end;


procedure TAboutForm.URLClick(Sender: TObject);
begin
  OpenMySite(fURLReference);
end;


procedure TAboutForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // ESC
  if Key = 27 then
    Close;
end;

initialization

end.
