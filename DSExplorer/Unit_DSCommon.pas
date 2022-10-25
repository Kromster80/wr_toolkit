unit Unit_DSCommon;
interface
uses
  Classes, SysUtils;

type
  TChunkHead = record
  private
    fTag: array [0..3] of AnsiChar;
  public
    function TagString: AnsiString;
    procedure SetTagString(aValue: AnsiString);
  end;

  TChunkVAst = record
  private
    fBytes: array [0..11] of Byte;
  public
    procedure LoadFromStream(aStream: TStream);
    procedure SaveToStream(aStream: TStream);
    function ToString: AnsiString;
  end;

  TDSString = record
    Lb: AnsiString;
    procedure LoadFromStream(aStream: TStream);
    procedure SaveToStream(aStream: TStream);
  end;

  TValue = record
  public
    Typ: Byte;
    I: Integer;
    F: Single;
    S: TDSString;
    class function NewFromStream(aStream: TStream): TValue; static;
    procedure SaveToStream(aStream: TStream);
    function ToString: AnsiString;
    function ToUnicodeString(aAnsiCodepage: Integer): string;
    procedure FromString(aValue: AnsiString);
    procedure FromUnicodeString(const aString: string; aAnsiCodepage: Integer);
  end;


implementation


{ TChunkHead }
function TChunkHead.TagString: AnsiString;
begin
  Result := fTag[0] + fTag[1] + fTag[2] + fTag[3];
end;


procedure TChunkHead.SetTagString(aValue: AnsiString);
begin
  fTag[0] := aValue[1];
  fTag[1] := aValue[2];
  fTag[2] := aValue[3];
  fTag[3] := aValue[4];
end;


{ TDSString }
procedure TDSString.LoadFromStream(aStream: TStream);
var
  size: Integer;
begin
  aStream.Read(size, 4);
  SetLength(Lb, size);
  if size > 0 then
  begin
    aStream.Read(Lb[1], size);
    aStream.Seek(1, soFromCurrent);
  end;
end;


procedure TDSString.SaveToStream(aStream: TStream);
var
  size: Integer;
begin
  size := Length(Lb);
  aStream.Write(size, 4);
  if size > 0 then
  begin
    aStream.Write(Lb[1], size);

    size := 0;
    aStream.Write(size, 1);
  end;
end;


{ TChunkVAst }
procedure TChunkVAst.LoadFromStream(aStream: TStream);
begin
  aStream.Read(fBytes[0], 12);
end;


procedure TChunkVAst.SaveToStream(aStream: TStream);
begin
  aStream.Write(fBytes[0], 12);
end;


function TChunkVAst.ToString: AnsiString;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to High(fBytes) do
    Result := Result + IntToHex(fBytes[I], 1);
end;


{ TValue }
class function TValue.NewFromStream(aStream: TStream): TValue;
begin
  Result := default(TValue);

  aStream.Read(Result.Typ, 1);
  case Result.Typ of
    0: Exit; // Rarely nothing
    1: aStream.Read(Result.I, 4);
    2: aStream.Read(Result.F, 4);
    16: Result.S.LoadFromStream(aStream);
  else
    Assert(False);
  end;
end;


procedure TValue.SaveToStream(aStream: TStream);
begin
  aStream.Write(Typ, 1);
  case Typ of
    0: Exit; // Rarely nothing
    1: aStream.Write(I, 4);
    2: aStream.Write(F, 4);
    16: S.SaveToStream(aStream);
  else
    Assert(False);
  end;
end;


function TValue.ToString: AnsiString;
begin
  case Typ of
    0: Result := ''; // Rarely nothing
    1: Result := IntToStr(I);
    2: Result := FloatToStr(F);
    16: Result := S.Lb;
  else
    Assert(False);
  end;
end;


function TValue.ToUnicodeString(aAnsiCodepage: Integer): string;
var
  sa: AnsiString;
  sb: TBytes;
begin
  sa := ToString;

  SetLength(sb, Length(sa));
  if Length(sa) > 0 then
    Move(sa[1], sb[0], Length(sa));

  Result := TEncoding.GetEncoding(aAnsiCodepage).GetString(sb);
end;


procedure TValue.FromString(aValue: AnsiString);
begin
  case Typ of
    0: ; // Rarely typ can be 0 and we should just skip it
    1: I := StrToInt(aValue);
    2: F := StrToFloat(aValue);
    16: S.Lb := aValue;
  else
    Assert(False);
  end;
end;


procedure TValue.FromUnicodeString(const aString: string; aAnsiCodepage: Integer);
var
  strLen: Integer;
  su: RawByteString;
begin
  Assert(Typ = 16);

  strLen := LocaleCharsFromUnicode(aAnsiCodepage, 0, PWideChar(aString), Length(aString), nil, 0, nil, nil);
  if strLen > 0 then
  begin
    SetLength(su, strLen);
    LocaleCharsFromUnicode(aAnsiCodepage, 0, PWideChar(aString), Length(aString), PAnsiChar(su), strLen, nil, nil);
    SetCodePage(su, aAnsiCodepage, False);
  end;

  S.Lb := su;
end;


end.
