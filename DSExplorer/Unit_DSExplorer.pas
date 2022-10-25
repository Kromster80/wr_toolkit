unit Unit_DSExplorer;
interface
uses
  Classes, Generics.Collections,
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


end.
