unit KromStringUtils;
interface

  function StringLow(const aString: string): Integer; inline;
  function StringHigh(const aString: string): Integer; inline;
  function StringStart: Integer; inline;
  function StringPad(const aString: string; aLength: Integer): string;

  function FixDecimalSeparator(const aString: string): string;

  function IntFromString(const aString: string; aDelimiter: Char; aPlace: Byte): Integer;
  function FloatFromString(const aString: string; aDelimiter: Char; aPlace: Byte): Single;
  function StringFromString(const aString: string; aDelimiter: Char; aPlace: Byte): string;

  function FloatFromStringDef(const aString: string; aDelimiter: Char; aPlace: Byte; aDefault: Single): Single;
  function StringFromStringDef(const aString: string; aDelimiter: Char; aPlace: Byte; aDefault: string): string;
  function TryFloatFromString(const aString: string; aDelimiter: Char; aPlace: Byte; out aResult: Single): Boolean;
  function TryStringFromString(const aString: string; aDelimiter: Char; aPlace: Byte; out aResult: string): Boolean;

  function UpperCaseByWord(const aString: string): string;

  function EscapeTextForGoogleSheets(const aString: string): string;

implementation
uses
  SysUtils, StrUtils;


function StringLow(const aString: string): Integer;
begin
  {$IFDEF FPC}
    Result := Low(aString);
  {$ELSE}
    {$IF CompilerVersion >= 24}
    Result := Low(aString); // Delphi XE3 and up can use Low(s)
    {$ELSE}
    Result := 1;            // Delphi XE2 and below can't use Low(s), but don't have ZEROBASEDSTRINGS either
    {$IFEND}
  {$ENDIF}
end;


function StringHigh(const aString: string): Integer;
begin
  {$IFDEF FPC}
    Result := Length(aString);
  {$ELSE}
    {$IF CompilerVersion >= 24}
    Result := High(aString);    // Delphi XE3 and up can use High(s)
    {$ELSE}
    Result := Length(aString);  // Delphi XE2 and below can't use High(s), but don't have ZEROBASEDSTRINGS either
    {$IFEND}
  {$ENDIF}
end;


function StringStart: Integer; inline;
begin
  {$IFDEF FPC}
    Result := Low(String(' '));
  {$ELSE}
    {$IF CompilerVersion >= 24}
    Result := Low(String(' ')); // Delphi XE3 and up can use Low(s)
    {$ELSE}
    Result := 1;        // Delphi XE2 and below can't use Low(s), but don't have ZEROBASEDSTRINGS either
    {$IFEND}
  {$ENDIF}
end;


function StringPad(const aString: string; aLength: Integer): string;
begin
  Result := Copy(aString, StringStart, aLength) + DupeString(' ', aLength - Length(aString));
end;


function FixDecimalSeparator(const aString: string): string;
var
  I: Integer;
begin
  Result := aString;

  for I := StringLow(Result) to StringHigh(Result) do
  if (Result[I] = '.') or (Result[I] = ',') then
    Result[I] := FormatSettings.DecimalSeparator;
end;


function IntFromString(const aString: string; aDelimiter: Char; aPlace: Byte): Integer;
begin
  Result := StrToInt(StringFromString(aString, aDelimiter, aPlace));
end;


function FloatFromString(const aString: string; aDelimiter: Char; aPlace: Byte): Single;
var
  s: string;
begin
  s := StringFromString(aString, aDelimiter, aPlace);
  s := FixDecimalSeparator(s);

  Result := StrToFloat(s);
end;


function StringFromString(const aString: string; aDelimiter: Char; aPlace: Byte): string;
begin
  if not TryStringFromString(aString, aDelimiter, aPlace, Result) then
    raise Exception.Create('No value at place');
end;


function FloatFromStringDef(const aString: string; aDelimiter: Char; aPlace: Byte; aDefault: Single): Single;
var
  s: string;
begin
  s := StringFromStringDef(aString, aDelimiter, aPlace, '');
  s := FixDecimalSeparator(s);

  Result := StrToFloatDef(s, aDefault);
end;


function StringFromStringDef(const aString: string; aDelimiter: Char; aPlace: Byte; aDefault: string): string;
var
  s: string;
begin
  if not TryStringFromString(aString, aDelimiter, aPlace, s) then
    Result := aDefault
  else
    Result := s;
end;


// Extract a number at given position from a string (0 .. N-1)
// / delimited
function TryFloatFromString(const aString: string; aDelimiter: Char; aPlace: Byte; out aResult: Single): Boolean;
var
  s: string;
begin
  Result := TryStringFromString(aString, aDelimiter, aPlace, s) and TryStrToFloat(s, aResult);
end;


// Extract a string at given position from a string (0 .. N-1)
function TryStringFromString(const aString: string; aDelimiter: Char; aPlace: Byte; out aResult: string): Boolean;
var
  I, Pos1, Pos2: Integer;
begin
  // Find the first char of requested number
  Pos1 := 0;
  for I := 1 to aPlace do
  repeat
    Inc(Pos1);
  until (Pos1 + 1 > Length(aString)) or (aString[Pos1] = aDelimiter);

  // Find the last char of requested number (could be the same)
  Pos2 := Pos1;
  repeat
    Inc(Pos2);
  until (Pos2 > Length(aString)) or (aString[Pos2] = aDelimiter);

  aResult := Copy(aString, Pos1 + 1, Pos2 - 1 - Pos1);
  Result := True;
end;


// Keep in mind, that Delphi UpCase&UpperCase handle only Latin
function UpperCaseByWord(const aString: string): string;
var
  I: Integer;
begin
  Result := aString;

  for I := StringLow(Result) to StringHigh(Result) do
    if (I = StringLow(Result)) or (Result[I-1] = #32) then
      Result[I] := UpCase(Result[I]);
end;


// Intended for the new GoogleSheet with all cells set to "Automatic" type
function EscapeTextForGoogleSheets(const aString: string): string;
var
  s: string;
begin
  s := aString;

  // When the first character is a ' or '=' - escape it with another '
  if (s <> '') then
  begin
    if (s[1] = #39) or (s[1] = '=') then
      s := #39 + s;

    // When there are " or spaces - wrap and escape everything with "
    if (Pos('"', s) > 0) or (s[1] = ' ') or (s[High(s)] = ' ') then
    begin
      s := StringReplace(s, '"', '""', [rfReplaceAll]);
      s := '"' + s + '"';
    end;
  end;

  Result := s;
end;


end.
