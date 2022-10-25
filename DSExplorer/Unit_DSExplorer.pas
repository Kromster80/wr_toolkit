unit Unit_DSExplorer;
interface
uses
  Classes, SysUtils, Generics.Collections;

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

  // Column?
  TCO = class
  public
    fVAId: Integer;
    fVALb: TDSString;
    fVAiU: Byte;
    fVASM: TDSString;
    fVAST: TDSString;
    fVAIC: TDSString;
    fVASC: TDSString;

    fValues: TList<TValue>;
    constructor Create;
    procedure LoadFromStream(aStream: TStream);
    procedure SaveToStream(aStream: TStream);
  end;

  // Table?
  TTB = class
  public
    fVAId: Integer;
    fVAiC: Byte;
    fVALb: TDSString;
    fConds: TList<TDSString>;
    fCOs: TObjectList<TCO>;
    constructor Create;
    procedure LoadFromStream(aStream: TStream);
    procedure SaveToStream(aStream: TStream);
  end;

  // DataS?
  TDSExplorer = class
  public
    Filename: string;
    fVAst: TChunkVAst;
    fVAau: Byte;
    fTBs: TObjectList<TTB>;
    constructor Create;
    procedure LoadFromFile(const aFilename: string);
    procedure SaveToFile(const aFilename: string);
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


{ TDSExplorer }
constructor TDSExplorer.Create;
begin
  inherited;

  fTBs := TObjectList<TTB>.Create;
end;


procedure TDSExplorer.LoadFromFile(const aFilename: string);
var
  ms: TMemoryStream;
  chunk: TChunkHead;
  vaen: Integer;
  tb: TTB;
  I: Integer;
begin
  Filename := aFilename;

  ms := TMemoryStream.Create;
  try
    try
      ms.LoadFromFile(aFilename);

      ms.Read(chunk, SizeOf(chunk));
      Assert(chunk.TagString = 'NDDS');
      ms.Read(chunk, SizeOf(chunk));
      Assert(chunk.TagString = 'VAEn');
      ms.Read(vaen, SizeOf(vaen));

      ms.Read(chunk, SizeOf(chunk));
      Assert(chunk.TagString = 'VAst');
      fVAst.LoadFromStream(ms);

      ms.Read(chunk, SizeOf(chunk));
      Assert(chunk.TagString = 'VAau');
      ms.Read(fVAau, SizeOf(fVAau));

      for I := 0 to vaen - 1 do
      begin
        ms.Read(chunk, SizeOf(chunk));

        if chunk.TagString = 'NDTB' then
        begin
          tb := TTB.Create;
          tb.LoadFromStream(ms);
          fTBs.Add(tb);
        end else
          Assert(False);
      end;

      Assert(ms.Position = ms.Size);
    except

    end;
  finally
    ms.Free;
  end;
end;


procedure TDSExplorer.SaveToFile(const aFilename: string);
var
  ms: TMemoryStream;
  chunk: TChunkHead;
  vaen: Integer;
  tb: TTB;
  I: Integer;
begin
  Filename := aFilename;

  ms := TMemoryStream.Create;

  chunk.SetTagString('NDDS');
  ms.Write(chunk, SizeOf(chunk));

  chunk.SetTagString('VAEn');
  ms.Write(chunk, SizeOf(chunk));

  vaen := fTBs.Count;
  ms.Write(vaen, SizeOf(vaen));

  chunk.SetTagString('VAst');
  ms.Write(chunk, SizeOf(chunk));
  fVAst.SaveToStream(ms);

  chunk.SetTagString('VAau');
  ms.Write(chunk, SizeOf(chunk));
  ms.Write(fVAau, SizeOf(fVAau));

  for I := 0 to vaen - 1 do
  begin
    chunk.SetTagString('NDTB');
    ms.Write(chunk, SizeOf(chunk));

    fTBs[I].SaveToStream(ms);
  end;

  ms.SaveToFile(aFilename);

  ms.Free;
end;


{ TCO }
constructor TCO.Create;
begin
  inherited;

  fValues := TList<TValue>.Create;
end;


procedure TCO.LoadFromStream(aStream: TStream);
var
  chunk: TChunkHead;
  vaen: Integer;
  I: Integer;
begin
  aStream.Read(chunk, SizeOf(chunk));
  aStream.Read(vaen, SizeOf(vaen));
  aStream.Read(chunk, SizeOf(chunk));
  aStream.Read(fVAId, SizeOf(fVAId));
  aStream.Read(chunk, SizeOf(chunk));
  fVALb.LoadFromStream(aStream);
  aStream.Read(chunk, SizeOf(chunk));
  aStream.Read(fVAiU, SizeOf(fVAiU));
  aStream.Read(chunk, SizeOf(chunk));
  fVASM.LoadFromStream(aStream);
  aStream.Read(chunk, SizeOf(chunk));
  fVAST.LoadFromStream(aStream);
  aStream.Read(chunk, SizeOf(chunk));
  fVAIC.LoadFromStream(aStream);
  aStream.Read(chunk, SizeOf(chunk));
  fVASC.LoadFromStream(aStream);

  for I := 0 to vaen - 1 do
    fValues.Add(TValue.NewFromStream(aStream));
end;


procedure TCO.SaveToStream(aStream: TStream);
var
  chunk: TChunkHead;
  vaen: Integer;
  I: Integer;
begin
  chunk.SetTagString('VAEn');
  aStream.Write(chunk, SizeOf(chunk));

  vaen := fValues.Count;
  aStream.Write(vaen, SizeOf(vaen));

  chunk.SetTagString('VAId');
  aStream.Write(chunk, SizeOf(chunk));
  aStream.Write(fVAId, SizeOf(fVAId));

  chunk.SetTagString('VALb');
  aStream.Write(chunk, SizeOf(chunk));
  fVALb.SaveToStream(aStream);

  chunk.SetTagString('VAiU');
  aStream.Write(chunk, SizeOf(chunk));
  aStream.Write(fVAiU, SizeOf(fVAiU));

  chunk.SetTagString('VASM');
  aStream.Write(chunk, SizeOf(chunk));
  fVASM.SaveToStream(aStream);

  chunk.SetTagString('VAST');
  aStream.Write(chunk, SizeOf(chunk));
  fVAST.SaveToStream(aStream);

  chunk.SetTagString('VAIC');
  aStream.Write(chunk, SizeOf(chunk));
  fVAIC.SaveToStream(aStream);

  chunk.SetTagString('VASC');
  aStream.Write(chunk, SizeOf(chunk));
  fVASC.SaveToStream(aStream);

  for I := 0 to vaen - 1 do
    fValues[I].SaveToStream(aStream);
end;


{ TTB }
constructor TTB.Create;
begin
  inherited;

  fCOs := TObjectList<TCO>.Create;
  fConds := TList<TDSString>.Create;
end;


procedure TTB.LoadFromStream(aStream: TStream);
var
  chunk: TChunkHead;
  vaen: Integer;
  I, K: Integer;
  co: TCO;
  condCount: Integer;
  ss: TDSString;
begin
  aStream.Read(chunk, SizeOf(chunk));
  Assert(chunk.TagString = 'VAEn');
  aStream.Read(vaen, SizeOf(vaen));
  aStream.Read(chunk, SizeOf(chunk));
  aStream.Read(fVAId, SizeOf(fVAId));
  aStream.Read(chunk, SizeOf(chunk));
  aStream.Read(fVAiC, 1);
  aStream.Read(chunk, SizeOf(chunk));
  fVALb.LoadFromStream(aStream);

  // No entries and we are at the end - don't bother checking for "Cond"
  if (vaen = 0) and (aStream.Position = aStream.Size) then
    Exit;

  // VAiC is not a good marker it seems
  // So we read it and see if it is "Cond"

  aStream.Read(chunk, SizeOf(chunk));
  if chunk.TagString = 'Cond' then
  begin
    aStream.Read(condCount, 4);
    for K := 0 to condCount - 1 do
    begin
      ss.LoadFromStream(aStream);
      fConds.Add(ss);
    end;
  end else
    // if not a "Cond" - rollback
    aStream.Seek(-4, soFromCurrent);

  for I := 0 to vaen - 1 do
  begin
    aStream.Read(chunk, SizeOf(chunk));
    if chunk.TagString = 'NDCO' then
    begin
      co := TCO.Create;
      co.LoadFromStream(aStream);
      fCOs.Add(co);
    end else
      Assert(False, chunk.TagString);
  end;
end;


procedure TTB.SaveToStream(aStream: TStream);
var
  chunk: TChunkHead;
  vaen: Integer;
  I, K: Integer;
  co: TCO;
  condCount: Integer;
  ss: TDSString;
begin
  chunk.SetTagString('VAEn');
  aStream.Write(chunk, SizeOf(chunk));

  vaen := fCOs.Count;
  aStream.Write(vaen, SizeOf(vaen));

  chunk.SetTagString('VAId');
  aStream.Write(chunk, SizeOf(chunk));
  aStream.Write(fVAId, SizeOf(fVAId));

  chunk.SetTagString('VAiC');
  aStream.Write(chunk, SizeOf(chunk));
  aStream.Write(fVAiC, SizeOf(fVAiC));

  chunk.SetTagString('VALb');
  aStream.Write(chunk, SizeOf(chunk));
  fVALb.SaveToStream(aStream);

  if fConds.Count > 0 then
  begin
    chunk.SetTagString('Cond');
    aStream.Write(chunk, SizeOf(chunk));
    aStream.Write(fConds.Count, 4);
    for K := 0 to fConds.Count - 1 do
      fConds[K].SaveToStream(aStream);
  end;

  for I := 0 to vaen - 1 do
  begin
    chunk.SetTagString('NDCO');
    aStream.Write(chunk, SizeOf(chunk));
    fCOs[I].SaveToStream(aStream);
  end;
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
  sa: AnsiString;
  sb: TBytes;
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
