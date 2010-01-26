unit WR_Manager_SetName;

interface

uses Forms, StdCtrls, Controls, Classes;


type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure GetSender(send:integer);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  SetID:integer;

implementation

uses WR_Manager_unit1;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
if Edit1.Text='' then exit;
case SendID of
1: Form1.BChoose1.Caption:=Edit1.Text;
2: Form1.BChoose2.Caption:=Edit1.Text;
3: Form1.BChoose3.Caption:=Edit1.Text;
4: Form1.BChoose4.Caption:=Edit1.Text;
5: Form1.BChoose5.Caption:=Edit1.Text;
end;
Form1.AddFav2(nil);
Form2.Close;
end;

procedure TForm2.GetSender(send:integer);
begin
SetID:=send;
case SendID of
1: Edit1.Text:=Form1.BChoose1.Caption;
2: Edit1.Text:=Form1.BChoose2.Caption;
3: Edit1.Text:=Form1.BChoose3.Caption;
4: Edit1.Text:=Form1.BChoose4.Caption;
5: Edit1.Text:=Form1.BChoose5.Caption;
end;
Form2.Button1.SetFocus;
Form2.Edit1.SetFocus;   //Make text selected
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
Close;
end;

end.
