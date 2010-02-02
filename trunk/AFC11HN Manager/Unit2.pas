unit Unit2;
{$IFDEF FPC} {$MODE Delphi} {$ENDIF}
interface
uses
  {$IFDEF FPC} LResources, {$ENDIF}
  Graphics, Forms, Classes, StdCtrls, ExtCtrls, Controls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
  end;

var
  Form2: TForm2;

implementation

{$IFDEF VER140}
  {$R *.dfm}
{$ENDIF}

initialization
{$IFDEF FPC}
  {$I Unit2.lrs}
{$ENDIF}

end.
