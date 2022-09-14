unit ColorPicker2;
interface
uses
  SysUtils, Classes, Vcl.Graphics, Vcl.Forms, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Controls, Math, KromUtils;

type
  TForm_ColorPicker2 = class(TForm)
    Shape2: TShape;
    HSImage: TImage;
    BriImage: TImage;
    Ticker: TShape;
    Shape1: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnReset: TButton;
    SpinR: TSpinEdit;
    SpinG: TSpinEdit;
    SpinB: TSpinEdit;
    SpinS: TSpinEdit;
    SpinH: TSpinEdit;
    SpinBr: TSpinEdit;
    btnOk: TButton;
    procedure HSImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure HSImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure HSImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure BriImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BriImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BriImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SpinRGBChange(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure SpinHSBChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fOnPreview: TProc<Cardinal>;
    fOnOk: TProc;
    fOnCancel: TProc;
    fColorOriginal: Cardinal;
    fBmpHueSat, fBmpBrightness: TBitmap;
    SpyMouseH: Boolean;
    SpyMouseB: Boolean;
    Hue, Sat, Bri: Integer; // 0..359, 0..255, 0..255
    RGBRefresh: Boolean;
    HSBRefresh: Boolean;
    procedure Init;
    procedure ApplyHue2RGB(aHue: Integer; var R, G, B: Integer);
    procedure ApplySat2RGB(InSat: Integer; var R, G, B: Integer);
    procedure ApplyBri2RGB(inR, inG, inB, InBri: Integer; var R, G, B: Integer);
    procedure DrawHueSatQuad;
    procedure DrawBriRow;
    procedure DisplayResultColor(Sender: string);
    procedure ConvertRGB2HSB(Rin, Gin, Bin: Integer; var Hout, Sout, Bout: Integer);
    procedure ConvertHSB2RGB(H_in, S_in, B_in: Integer; var R, G, B: Integer);
    procedure PositionHSBCursors;
  public
    class function Execute(aColor: Cardinal; aPreview: TProc<Cardinal>; aOk, aCancel: TProc): Boolean;
  end;


implementation
{$R *.dfm}

var
  fm: TForm_ColorPicker2;

class function TForm_ColorPicker2.Execute(aColor: Cardinal; aPreview: TProc<Cardinal>; aOk, aCancel: TProc): Boolean;
begin
  if fm = nil then
    fm := TForm_ColorPicker2.Create(Application);

  fm.fColorOriginal := aColor;
  fm.fOnPreview := aPreview;
  fm.fOnOk := aOk;
  fm.fOnCancel := aCancel;
  fm.Init;

  fm.ShowModal;
end;

procedure TForm_ColorPicker2.Init;
begin
  ConvertRGB2HSB(fColorOriginal and $FF, fColorOriginal shr 8 and $FF, fColorOriginal shr 16 and $FF, Hue, Sat, Bri);
  PositionHSBCursors;
  DrawHueSatQuad;
  DrawBriRow;
  DisplayResultColor('Both');
end;

procedure TForm_ColorPicker2.DrawHueSatQuad;
var
  P: PByteArray;
  R, G, B: Integer;
  ii, kk: Integer;
begin
  // Fill area with Hue and Saturation data respecting Brightness
  for ii := 0 to 255 do
  begin
    P := fBmpHueSat.ScanLine[ii];
    for kk := 0 to 359 do
    begin
      ApplyHue2RGB(kk, R, G, B);
      ApplySat2RGB(ii, R, G, B);
      ApplyBri2RGB(R, G, B, Bri, R, G, B);
      P[kk * 3 + 0] := B;
      P[kk * 3 + 1] := G;
      P[kk * 3 + 2] := R;
    end;
  end;
  HSImage.Canvas.Draw(0, 0, fBmpHueSat);
end;

procedure TForm_ColorPicker2.DrawBriRow;
var
  R, G, B, Rt, Gt, Bt: Integer;
  i: Integer;
begin
  Hue := Shape1.Left - HSImage.Left + Shape1.Width div 2; // restore after cycle
  Sat := Shape1.Top - HSImage.Top + Shape1.Height div 2;
  ApplyHue2RGB(Hue, R, G, B);
  ApplySat2RGB(Sat, R, G, B);
  for i := 0 to 255 do
  begin
    ApplyBri2RGB(R, G, B, i, Rt, Gt, Bt);
    fBmpBrightness.Canvas.Pixels[0, i] := Rt + Gt * 256 + Bt * 65536;
  end;
  Bri := Ticker.Top - BriImage.Top + (Ticker.Height div 2);
  BriImage.Canvas.StretchDraw(BriImage.Canvas.ClipRect, fBmpBrightness);
end;

procedure TForm_ColorPicker2.ApplyHue2RGB(aHue: Integer; var R, G, B: Integer);
const
  V = 255 / (360 div 6);
begin
  aHue := EnsureRange(aHue, 0, 359);
  case aHue of
    0 .. 59:    begin
                  R := 255;
                  G := round(aHue * V);
                  B := 0;
                end;
    60 .. 119:  begin
                  R := round((120 - aHue) * V);
                  G := 255;
                  B := 0;
                end;
    120 .. 179: begin
                  R := 0;
                  G := 255;
                  B := round((aHue - 120) * V);
                end;
    180 .. 239: begin
                  R := 0;
                  G := round((240 - aHue) * V);
                  B := 255;
                end;
    240 .. 299: begin
                  R := round((aHue - 240) * V);
                  G := 0;
                  B := 255;
                end;
    300 .. 359: begin
                  R := 255;
                  G := 0;
                  B := round((360 - aHue) * V);
                end;
  end;
end;

procedure TForm_ColorPicker2.ApplySat2RGB(InSat: Integer; var R, G, B: Integer);
begin
  R := round((R * (255 - InSat) + 127 * (InSat)) / 255);
  G := round((G * (255 - InSat) + 127 * (InSat)) / 255);
  B := round((B * (255 - InSat) + 127 * (InSat)) / 255);
end;

procedure TForm_ColorPicker2.ApplyBri2RGB(inR, inG, inB, InBri: Integer; var R, G, B: Integer);
begin
  if InBri = 127 then
    Exit
  else
  if InBri < 127 then
  begin
    R := round((inR * InBri + 255 * (127 - InBri)) / 127);
    G := round((inG * InBri + 255 * (127 - InBri)) / 127);
    B := round((inB * InBri + 255 * (127 - InBri)) / 127);
  end
  else if InBri > 127 then
  begin
    R := round((inR * (255 - InBri) + 0 * (InBri - 127)) / 127);
    G := round((inG * (255 - InBri) + 0 * (InBri - 127)) / 127);
    B := round((inB * (255 - InBri) + 0 * (InBri - 127)) / 127);
  end;
end;

procedure TForm_ColorPicker2.ConvertRGB2HSB(Rin, Gin, Bin: Integer; var Hout, Sout, Bout: Integer);
var
  Rdel, Gdel, Bdel, Vmin, Vmax, Vdel, xp: Integer;
begin
  Vmin := min(Rin, Gin, Bin);
  Vmax := max(Rin, Gin, Bin);
  Vdel := Vmax - Vmin;
  Bout := 255 - round((Vmax + Vmin) / 2);
  if Vdel = 0 then
  begin
    Hout := 180;
    Sout := 255;
  end
  else
  begin // Middle of HSImage
    if Bout >= 127 then
      Sout := 255 - round(Vdel / (Vmax + Vmin) * 255) // including 127
    else
      Sout := 255 - round(Vdel / (511 - Vmax - Vmin) * 255);

    Rdel := round((Rin - Vmin) * 255 / Vdel);
    Gdel := round((Gin - Vmin) * 255 / Vdel);
    Bdel := round((Bin - Vmin) * 255 / Vdel);
    if Rin = Vmax then
      xp := round((Gdel - Bdel) / 255 * 60)
    else if Gin = Vmax then
      xp := round(120 - (Rdel - Bdel) / 255 * 60)
    else if Bin = Vmax then
      xp := round(240 - (Gdel - Rdel) / 255 * 60)
    else
      xp := 0;
    if xp < 0 then
      Inc(xp, 360);
    if xp > 360 then
      Dec(xp, 360);
    Hout := xp;
  end;
end;

procedure TForm_ColorPicker2.ConvertHSB2RGB(H_in, S_in, B_in: Integer; var R, G, B: Integer);
begin
  ApplyHue2RGB(H_in, R, G, B);
  ApplySat2RGB(S_in, R, G, B);
  ApplyBri2RGB(R, G, B, B_in, R, G, B);
end;

procedure TForm_ColorPicker2.DisplayResultColor(Sender: string);
var
  R, G, B, Ht, St, Bt: Integer;
begin
  RGBRefresh := true;
  HSBRefresh := true;
  if Sender = 'RGB' then
  begin
    R := EnsureRange(round(SpinR.Value), 0, 255);
    G := EnsureRange(round(SpinG.Value), 0, 255);
    B := EnsureRange(round(SpinB.Value), 0, 255);
    ConvertRGB2HSB(R, G, B, Ht, St, Bt);
    SpinH.Value := Hue;
    SpinS.Value := 255 - Sat;
    SpinBr.Value := 255 - Bri;
  end;
  if Sender = 'HSB' then
  begin
    ConvertHSB2RGB(Hue, Sat, Bri, R, G, B);
    SpinR.Value := R;
    SpinG.Value := G;
    SpinB.Value := B;
  end;
  if Sender = 'Both' then
  begin
    ConvertHSB2RGB(Hue, Sat, Bri, R, G, B);
    SpinR.Value := R;
    SpinG.Value := G;
    SpinB.Value := B;
    SpinH.Value := Hue;
    SpinS.Value := 255 - Sat;
    SpinBr.Value := 255 - Bri;
  end;
  Shape2.Brush.Color := round(R) + round(G) * 256 + round(B) * 65536;

  if Assigned(fOnPreview) then
    fOnPreview(round(R) + round(G) * 256 + round(B) * 65536);

  RGBRefresh := false;
  HSBRefresh := false;
end;

procedure TForm_ColorPicker2.HSImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SpyMouseH := true;
  HSImageMouseMove(nil, Shift, X, Y);
end;

procedure TForm_ColorPicker2.HSImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if not SpyMouseH then
    Exit;
  Hue := EnsureRange(X, 0, 359);
  Sat := EnsureRange(Y, 0, 255);
  Shape1.Left := HSImage.Left + Hue - Shape1.Width div 2; // - Shape1.Width mod 2;
  Shape1.Top := HSImage.Top + Sat - Shape1.Height div 2; // - Shape1.Width mod 2;
  DrawBriRow;
  DisplayResultColor('Both');
end;

procedure TForm_ColorPicker2.HSImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SpyMouseH := false;
end;

procedure TForm_ColorPicker2.BriImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SpyMouseB := true;
  BriImageMouseMove(nil, Shift, X, Y);
end;

procedure TForm_ColorPicker2.BriImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if not SpyMouseB then
    Exit;
  Bri := EnsureRange(Y, 0, BriImage.Height - 1);
  Ticker.Top := BriImage.Top + Bri - (Ticker.Height div 2);
  DisplayResultColor('Both');
end;

procedure TForm_ColorPicker2.BriImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SpyMouseB := false;
  DrawHueSatQuad;
end;

procedure TForm_ColorPicker2.SpinRGBChange(Sender: TObject);
var
  R, G, B: Integer;
begin
  if RGBRefresh then
    Exit;
  RGBRefresh := true;
  R := EnsureRange(round(SpinR.Value), 0, 255);
  G := EnsureRange(round(SpinG.Value), 0, 255);
  B := EnsureRange(round(SpinB.Value), 0, 255);
  RGBRefresh := false;
  ConvertRGB2HSB(R, G, B, Hue, Sat, Bri);
  PositionHSBCursors;
  DrawHueSatQuad;
  DrawBriRow;
  DisplayResultColor('RGB');
end;

procedure TForm_ColorPicker2.btnResetClick(Sender: TObject);
begin
  Init;
end;

procedure TForm_ColorPicker2.PositionHSBCursors;
begin
  Shape1.Left := HSImage.Left + Hue - Shape1.Width div 2; // - Shape1.Width mod 2;
  Shape1.Top := HSImage.Top + Sat - Shape1.Height div 2; // - Shape1.Width mod 2;
  Ticker.Top := BriImage.Top + Bri - (Ticker.Height div 2);
end;

procedure TForm_ColorPicker2.SpinHSBChange(Sender: TObject);
var
  R, G, B: Integer;
begin
  if HSBRefresh then
    Exit;

  HSBRefresh := true;
  Hue := EnsureRange(round(SpinH.Value), 0, 359);
  Sat := EnsureRange(255 - round(SpinS.Value), 0, 255);
  Bri := EnsureRange(255 - round(SpinBr.Value), 0, 255);
  HSBRefresh := false;
  ConvertHSB2RGB(Hue, Sat, Bri, R, G, B);
  PositionHSBCursors;
  DrawHueSatQuad;
  DrawBriRow;
  DisplayResultColor('HSB');
end;

procedure TForm_ColorPicker2.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;

  if Assigned(fOnOk) then
    fOnOk;
end;

procedure TForm_ColorPicker2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOk then
    if Assigned(fOnCancel) then
      fOnCancel;
end;

procedure TForm_ColorPicker2.FormCreate(Sender: TObject);
begin
  fBmpHueSat := TBitmap.Create;
  fBmpHueSat.PixelFormat := pf24bit;
  fBmpHueSat.Width := HSImage.Width;;
  fBmpHueSat.Height := HSImage.Height;
  fBmpBrightness := TBitmap.Create;
  fBmpBrightness.PixelFormat := pf24bit;
  fBmpBrightness.Width := 1;
  fBmpBrightness.Height := BriImage.Height;
end;

procedure TForm_ColorPicker2.FormDestroy(Sender: TObject);
begin
  fBmpHueSat.Free;
  fBmpBrightness.Free;
end;

initialization

end.
