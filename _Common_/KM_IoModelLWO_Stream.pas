unit KM_IoModelLWO_Stream;
interface
uses
  Classes;


type
  // LWO model class, the way it is
  TLWOPostProcess = (ppCalcNormals, ppFixUVs, ppSeparateSurfaces, ppTriangulate);
  TLWOPostProcessSet = set of TLWOPostProcess;

  // Added bonus method to read and swap Bytes (BigEndian -> LittleEndian conversion)
  TSwappedStream = class(TMemoryStream)
  public
    function ReadSwap(var Buffer; Count: LongInt): LongInt;

    // Wrappers for various writes. For simplicity
    procedure Write(const aString: AnsiString); overload;
    procedure Write(const aInt: Integer); overload;
    procedure WriteChunk2(const aTitle: AnsiString; aBody: TSwappedStream);
    procedure WriteChunk4(const aTitle: AnsiString; aBody: TSwappedStream);
    procedure WriteStringLen(const aString: AnsiString);
    procedure WriteStringPad(const aString: AnsiString); // Write string, padded to next even length
    procedure WriteStringPadLen(const aString: AnsiString); // Write string, padded to next even length, and length
    procedure WriteSwap(const aBuffer; Count: LongInt);
  end;


implementation


{ TSwappedStream }
function TSwappedStream.ReadSwap(var Buffer; Count: Integer): LongInt;
var
  P1: PByte;
  P2: PByte;
  C: Byte;
begin
  Result := Read(Buffer, Count);

  // Swap bytes around the middle
  P1 := PByte(@Buffer);
  P2 := PByte(@Buffer) + Count - 1;
  while P1 < P2 do
  begin
    C := P1^;
    P1^ := P2^;
    P2^ := C;
    Inc(P1);
    Dec(P2);
  end;
end;


procedure TSwappedStream.Write(const aString: AnsiString);
begin
  Write(aString[1], Length(aString));
end;


procedure TSwappedStream.Write(const aInt: Integer);
begin
  WriteSwap(aInt, SizeOf(Integer));
end;


procedure TSwappedStream.WriteChunk2(const aTitle: AnsiString; aBody: TSwappedStream);
var
  sz: Word;
begin
  aBody.Position := 0;
  sz := aBody.Size;
  Write(aTitle);
  WriteSwap(sz, 2);
  CopyFrom(aBody, aBody.Size);
end;


procedure TSwappedStream.WriteChunk4(const aTitle: AnsiString; aBody: TSwappedStream);
var
  sz: Integer;
begin
  aBody.Position := 0;
  sz := aBody.Size;
  Write(aTitle);
  WriteSwap(sz, 4);
  CopyFrom(aBody, aBody.Size);
end;


procedure TSwappedStream.WriteStringLen(const aString: AnsiString);
var
  sz: Word;
begin
  sz := Length(aString);
  WriteSwap(sz, 2);
  Write(aString);
end;


procedure TSwappedStream.WriteStringPad(const aString: AnsiString);
begin
  if Length(aString) mod 2 = 0 then
    Write(aString + #0#0)
  else
    Write(aString + #0);
end;


procedure TSwappedStream.WriteStringPadLen(const aString: AnsiString);
var
  sz: Word;
begin
  sz := (Length(aString) div 2 + 1) * 2;
  WriteSwap(sz, 2);

  if Length(aString) mod 2 = 0 then
    Write(aString + #0#0)
  else
    Write(aString + #0);
end;


procedure TSwappedStream.WriteSwap(const aBuffer; Count: Integer);
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Write((PByte(@aBuffer) + I)^, 1);
end;


end.
