unit Unit_DS;
interface
uses
  Classes, Vcl.Clipbrd, Windows, Generics.Collections,
  Unit_DSCommon;

type
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

    fValues: TObjectList<TValue>;
    constructor Create;
    procedure LoadFromStream(aStream: TStream);
    procedure SaveToStream(aStream: TStream);
  end;

  // Table?
  TTB = class
  private
    function GetMaxValuesCount: Integer;
  public
    fVAId: Integer;
    fVAiC: Byte;
    fVALb: TDSString;
    fConds: TList<TDSString>;
    fCOs: TObjectList<TCO>;
    constructor Create;
    procedure LoadFromStream(aStream: TStream);
    procedure SaveToStream(aStream: TStream);
    procedure ValuesCopyToClipboard(aHandle: THandle);
    procedure ValuesPasteFromClipboard(aHandle: THandle);
  end;

  // DataS?
  TDS = class
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
uses
  Math, Types, StrUtils, SysUtils;


{ TDS }
constructor TDS.Create;
begin
  inherited;

  fTBs := TObjectList<TTB>.Create;
end;


procedure TDS.LoadFromFile(const aFilename: string);
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
      Assert(chunk.GetTagString = 'NDDS');
      ms.Read(chunk, SizeOf(chunk));
      Assert(chunk.GetTagString = 'VAEn');
      ms.Read(vaen, SizeOf(vaen));

      ms.Read(chunk, SizeOf(chunk));
      Assert(chunk.GetTagString = 'VAst');
      fVAst.LoadFromStream(ms);

      ms.Read(chunk, SizeOf(chunk));
      Assert(chunk.GetTagString = 'VAau');
      ms.Read(fVAau, SizeOf(fVAau));

      for I := 0 to vaen - 1 do
      begin
        ms.Read(chunk, SizeOf(chunk));

        if chunk.GetTagString = 'NDTB' then
        begin
          tb := TTB.Create;
          tb.LoadFromStream(ms);
          fTBs.Add(tb);
        end else
          Assert(False, 'Unexpected chunk ' + chunk.GetTagString);
      end;

      Assert(ms.Position = ms.Size);
    except

    end;
  finally
    ms.Free;
  end;
end;


procedure TDS.SaveToFile(const aFilename: string);
var
  ms: TMemoryStream;
  chunk: TChunkHead;
  vaen: Integer;
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

  fValues := TObjectList<TValue>.Create;
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
    fValues.Add(TValue.CreateFromStream(aStream));
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


function TTB.GetMaxValuesCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to fCOs.Count - 1 do
    Result := Max(Result, fCOs[I].fValues.Count);
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
  Assert(chunk.GetTagString = 'VAEn');
  aStream.Read(vaen, SizeOf(vaen));

  aStream.Read(chunk, SizeOf(chunk));
  Assert(chunk.GetTagString = 'VAId');
  aStream.Read(fVAId, SizeOf(fVAId));

  aStream.Read(chunk, SizeOf(chunk));
  Assert(chunk.GetTagString = 'VAiC');
  aStream.Read(fVAiC, 1);

  aStream.Read(chunk, SizeOf(chunk));
  Assert(chunk.GetTagString = 'VALb');
  fVALb.LoadFromStream(aStream);

  // No entries and we are at the end - don't bother checking for "Cond"
  if (vaen = 0) and (aStream.Position = aStream.Size) then
    Exit;

  // VAiC is not a good marker it seems
  // So we read it and see if it is "Cond"

  aStream.Read(chunk, SizeOf(chunk));
  if chunk.GetTagString = 'Cond' then
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
    if chunk.GetTagString = 'NDCO' then
    begin
      co := TCO.Create;
      co.LoadFromStream(aStream);
      fCOs.Add(co);
    end else
      Assert(False, 'Unexpected chunk ' + chunk.GetTagString);
  end;
end;


procedure TTB.SaveToStream(aStream: TStream);
var
  chunk: TChunkHead;
  vaen: Integer;
  I, K: Integer;
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


procedure TTB.ValuesCopyToClipboard(aHandle: THandle);
var
  I, K: Integer;
  sl: TStringList;
  info: string;
  sa: AnsiString;
  su, s: string;
  sb: TBytes;
  s1250: string;
  valuesCount: Integer;
begin
  sl := TStringList.Create;
  try
    // Header
    s := '';
    for I := 0 to fCOs.Count - 1 do
      s := s + IfThen(I > 0, #9) + fCOs[I].fVALb.Lb;
    sl.Append(s);

    valuesCount := GetMaxValuesCount;

    // Values
    for K := 0 to valuesCount - 1 do
    begin
      s := '';

      for I := 0 to fCOs.Count - 1 do
      begin
        // Get the Unicode string
        if K < fCOs[I].fValues.Count then
        begin
          // By default strings come in English (no codepage needed)
          su := fCOs[I].fValues[K].ToString;

          // Special treatment for localizations texts (DS uses ANSI, but stores no codepages)
          if fVALb.Lb = 'Texte' then
            if fCOs[I].fVALb.Lb = 'Deutsch' then
              su := fCOs[I].fValues[K].ToUnicodeString(1250)
            else
            if fCOs[I].fVALb.Lb = 'French' then
              su := fCOs[I].fValues[K].ToUnicodeString(1252)
            else
            if fCOs[I].fVALb.Lb = 'Spanish' then
              su := fCOs[I].fValues[K].ToUnicodeString(1252)
            else
            if fCOs[I].fVALb.Lb = 'Italian' then
              su := fCOs[I].fValues[K].ToUnicodeString(1252)
            else
            if fCOs[I].fVALb.Lb = 'Polish' then
              su := fCOs[I].fValues[K].ToUnicodeString(1250)
            else
            if fCOs[I].fVALb.Lb = 'Hungarian' then
              su := fCOs[I].fValues[K].ToUnicodeString(1250)
            else
            if fCOs[I].fVALb.Lb = 'Czech' then
              su := fCOs[I].fValues[K].ToUnicodeString(1250)
            else
            if fCOs[I].fVALb.Lb = 'Russian' then
              su := fCOs[I].fValues[K].ToUnicodeString(1251)
            else
              su := fCOs[I].fValues[K].ToUnicodeString(1252);
        end else
          su := '';

        s := s + IfThen(I > 0, #9) + su;
      end;

      // Make sure there are no such things in text already
      Assert(Pos('\n', s) = 0); // LF - #10
      Assert(Pos('\r', s) = 0); // CR - #13

      // We have to replace both separately, since DS uses LF and CRLF at will
      s := StringReplace(s, #10, '\n', [rfReplaceAll]);
      s := StringReplace(s, #13, '\r', [rfReplaceAll]);

      sl.Append(s);
    end;

    Clipboard.AsText := sl.Text;

    info := Format('Copied %d+1 lines', [sl.Count]);
    MessageBox(aHandle, PWideChar(info), 'Info', MB_OK + MB_ICONINFORMATION);
  finally
    sl.Free;
  end;
end;


procedure TTB.ValuesPasteFromClipboard(aHandle: THandle);
var
  I, K: Integer;
  sl: TStringList;
  info: string;
  sa: TStringDynArray;
  su: string;
  valuesCount: Integer;
begin
  sl := TStringList.Create;
  try
    sl.Text := Clipboard.AsText;

    valuesCount := GetMaxValuesCount;

    // Verify line count
    if sl.Count <> valuesCount + 1 then
    begin
      info := Format('Line count in clipboard %d does not match TB %d+1',
        [sl.Count, valuesCount]);
      MessageBox(aHandle, PWideChar(info), 'Error', MB_OK + MB_ICONERROR);
      Exit;
    end;

    // First line is header
    sa := SplitString(sl[0], #9);

    // Verify column count
    if Length(sa) <> fCOs.Count then
    begin
      info := Format('Column count in clipboard %d does not match TB %d',
        [Length(sa), fCOs.Count]);
      MessageBox(aHandle, PWideChar(info), 'Error', MB_OK + MB_ICONERROR);
      Exit;
    end;

    // Verify column names
    for I := 0 to fCOs.Count - 1 do
    if fCOs[I].fVALb.Lb <> sa[I] then
    begin
      info := Format('Column name in clipboard "%s" does not match TB "%s"',
        [sa[I], fCOs[I].fVALb.Lb]);
      MessageBox(aHandle, PWideChar(info), 'Error', MB_OK + MB_ICONERROR);
      Exit;
    end;

    for I := 0 to valuesCount - 1 do
    begin
      sa := SplitString(sl[I + 1], #9);

      for K := 0 to fCOs.Count - 1 do
      if I < fCOs[K].fValues.Count then
      begin
        if High(sa) >= K then
          su := sa[K]
        else
          su := '';

        // Restore line breaks
        su := StringReplace(su, '\n', #10, [rfReplaceAll]);
        su := StringReplace(su, '\r', #13, [rfReplaceAll]);

        fCOs[K].fValues[I].FromString(su);

        // Special treatment for localizations texts (DS uses ANSI, but stores no codepages)
        if fVALb.Lb = 'Texte' then
          if fCOs[K].fVALb.Lb = 'Deutsch' then
            fCOs[K].fValues[I].FromUnicodeString(su, 1250)
          else
          if fCOs[K].fVALb.Lb = 'French' then
            fCOs[K].fValues[I].FromUnicodeString(su, 1252)
          else
          if fCOs[K].fVALb.Lb = 'Spanish' then
            fCOs[K].fValues[I].FromUnicodeString(su, 1252)
          else
          if fCOs[K].fVALb.Lb = 'Italian' then
            fCOs[K].fValues[I].FromUnicodeString(su, 1252)
          else
          if fCOs[K].fVALb.Lb = 'Russian' then
            fCOs[K].fValues[I].FromUnicodeString(su, 1251)
          else
          if fCOs[K].fVALb.Lb = 'Polish' then
            fCOs[K].fValues[I].FromUnicodeString(su, 1250)
          else
          if fCOs[K].fVALb.Lb = 'Hungarian' then
            fCOs[K].fValues[I].FromUnicodeString(su, 1250)
          else
          if fCOs[K].fVALb.Lb = 'Czech' then
            fCOs[K].fValues[I].FromUnicodeString(su, 1250)
          else
            fCOs[K].fValues[I].FromUnicodeString(su, 1252);
      end;
    end;

    info := Format('Replaced %d-1 lines', [sl.Count]);
    MessageBox(aHandle, PWideChar(info), 'Info', MB_OK + MB_ICONINFORMATION);
  finally
    sl.Free;
  end;
end;


end.
