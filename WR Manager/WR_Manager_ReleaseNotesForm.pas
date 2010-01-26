unit WR_Manager_ReleaseNotesForm;

interface

uses
  Forms, StdCtrls, Classes, Controls;

type
  TForm4 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
Form4.Hide;
end;

end.
