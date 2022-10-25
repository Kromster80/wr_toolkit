unit UnitMainForm;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IOUtils, Types, Math, Generics.Collections,

  Unit_DSExplorer, Vcl.ComCtrls, Vcl.Clipbrd;

type
  TForm7 = class(TForm)
    btnFindAndDisplayDSs: TButton;
    lvTBs: TListView;
    lvDSs: TListView;
    lvCOs: TListView;
    btnDisplayAll: TButton;
    lvValues: TListView;
    btnCopyAll: TButton;
    btnPasteAll: TButton;
    procedure btnFindAndDisplayDSsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvTBsColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvTBsCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure lvDSsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvTBsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btnDisplayAllClick(Sender: TObject);
    procedure lvCOsColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvCOsCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure lvCOsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btnCopyAllClick(Sender: TObject);
    procedure btnPasteAllClick(Sender: TObject);
  private
    fSortDirTB: Integer;
    fSortColTB: Integer;
    fSortDirCO: Integer;
    fSortColCO: Integer;

    fDSs: TObjectList<TDSExplorer>;

    procedure LoadDS;
    procedure DisplayDS;
    procedure DisplayTB(aDS: TDSExplorer; aClear: Boolean);
    procedure DisplayCO(aTB: TTB; aClear: Boolean);
    procedure DisplayValues(aCO: TCO; aClear: Boolean);
    procedure ValuesCopy(aTB: TTB);
    procedure ValuesPaste(aTB: TTB);
  end;

var
  Form7: TForm7;

implementation
uses
  StrUtils;

{$R *.dfm}

procedure TForm7.DisplayDS;
var
  I: Integer;
  li: TListItem;
begin
  lvDSs.Items.Clear;

  lvDSs.Items.BeginUpdate;
  for I := 0 to fDSs.Count - 1 do
  begin
    li := lvDSs.Items.Add;

    li.Caption := fDSs[I].Filename;
    li.SubItems.Append(fDSs[I].fVAst.ToString);
    li.SubItems.Append(IntToStr(fDSs[I].fVAau));
    li.SubItems.Append(IntToStr(fDSs[I].fTBs.Count));
    li.Data := fDSs[I];
  end;
  lvDSs.Items.EndUpdate;
end;


procedure TForm7.DisplayTB(aDS: TDSExplorer; aClear: Boolean);
var
  I: Integer;
  li: TListItem;
begin
  if aClear then
    lvTBs.Items.Clear;

  if aDS = nil then Exit;

  lvTBs.Items.BeginUpdate;
  for I := 0 to aDS.fTBs.Count - 1 do
  begin
    li := lvTBs.Items.Add;

    li.Caption := aDS.fTBs[I].fVALb.Lb;
    li.SubItems.Append(IntToStr(aDS.fTBs[I].fVAId));
    li.SubItems.Append(IntToStr(aDS.fTBs[I].fVAiC));
    li.SubItems.Append(IntToStr(aDS.fTBs[I].fConds.Count));
    li.SubItems.Append(IntToStr(aDS.fTBs[I].fCOs.Count));
    li.Data := aDS.fTBs[I];
  end;
  lvTBs.Items.EndUpdate;
end;


procedure TForm7.btnDisplayAllClick(Sender: TObject);
var
  I: Integer;
  K: Integer;
begin
  lvTBs.OnChange := nil;
  lvTBs.Items.BeginUpdate;
  lvCOs.Items.BeginUpdate;
  try
    for I := 0 to fDSs.Count - 1 do
    begin
      DisplayTB(fDSs[I], False);

      for K := 0 to fDSs[I].fTBs.Count - 1 do
        DisplayCO(fDSs[I].fTBs[K], False);
    end;
  finally
    lvCOs.Items.EndUpdate;
    lvTBs.Items.EndUpdate;
    lvTBs.OnChange := lvTBsChange;
  end;
end;


procedure TForm7.DisplayCO(aTB: TTB; aClear: Boolean);
var
  I: Integer;
  li: TListItem;
begin
  if aClear then
    lvCOs.Items.Clear;

  if aTB = nil then Exit;

  lvCOs.Items.BeginUpdate;
  for I := 0 to aTB.fCOs.Count - 1 do
  begin
    li := lvCOs.Items.Add;

    li.Caption := aTB.fCOs[I].fVALb.Lb;
    li.SubItems.Append(IntToStr(aTB.fCOs[I].fVAId));
    li.SubItems.Append(IntToStr(aTB.fCOs[I].fVAiU));
    li.SubItems.Append(aTB.fCOs[I].fVASM.Lb);
    li.SubItems.Append(aTB.fCOs[I].fVAST.Lb);
    li.SubItems.Append(aTB.fCOs[I].fVAIC.Lb);
    li.SubItems.Append(aTB.fCOs[I].fVASC.Lb);
    li.SubItems.Append(IntToStr(aTB.fCOs[I].fValues.Count));
    li.Data := aTB.fCOs[I];
  end;
  lvCOs.Items.EndUpdate;
end;


procedure TForm7.DisplayValues(aCO: TCO; aClear: Boolean);
var
  I: Integer;
  li: TListItem;
begin
  if aClear then
    lvValues.Items.Clear;

  if aCO = nil then Exit;

  lvValues.Items.BeginUpdate;
  for I := 0 to aCO.fValues.Count - 1 do
  begin
    li := lvValues.Items.Add;

    li.Caption := IntToStr(aCO.fValues[I].Typ);
    li.SubItems.Append(aCO.fValues[I].ToString);
  end;
  lvValues.Items.EndUpdate;
end;


procedure TForm7.FormCreate(Sender: TObject);
begin
  fDSs := TObjectList<TDSExplorer>.Create;
  btnFindAndDisplayDSs.Click;
end;


procedure TForm7.LoadDS;
var
  allFiles: TStringDynArray;
  I: Integer;
  ds: TDSExplorer;
begin
  fDSs.Clear;

  allFiles := TDirectory.GetFiles('samples\');

  for I := 0 to High(allFiles) do
  begin
    ds := TDSExplorer.Create;
    ds.LoadFromFile(allFiles[I]);
    fDSs.Add(ds);
  end;
end;


procedure TForm7.lvDSsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  DisplayTB(TDSExplorer(Item.Data), True);
end;


procedure TForm7.lvTBsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  DisplayCO(Item.Data, True);
end;


procedure TForm7.lvTBsColumnClick(Sender: TObject; Column: TListColumn);
begin
  if fSortDirTB = 0 then
    fSortDirTB := -1;

  if Column.Index = fSortColTB then
    fSortDirTB := -fSortDirTB
  else
    fSortDirTB := 1;

  fSortColTB := Column.Index;

  lvTBs.Items.BeginUpdate;
  lvTBs.AlphaSort;
  lvTBs.Items.EndUpdate;
end;


procedure TForm7.lvCOsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  DisplayValues(Item.Data, True);
end;


procedure TForm7.lvCOsColumnClick(Sender: TObject; Column: TListColumn);
begin
  if fSortDirCO = 0 then
    fSortDirCO := -1;

  if Column.Index = fSortColCO then
    fSortDirCO := -fSortDirCO
  else
    fSortDirCO := 1;

  fSortColCO := Column.Index;

  lvCOs.Items.BeginUpdate;
  lvCOs.AlphaSort;
  lvCOs.Items.EndUpdate;
end;


procedure TForm7.lvTBsCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  case fSortColTB of
    0: Compare := CompareStr(Item1.Caption, Item2.Caption);
    1: Compare := CompareValue(StrToIntDef(Item1.SubItems[0], -1), StrToIntDef(Item2.SubItems[0], -1));
    2: Compare := CompareValue(StrToIntDef(Item1.SubItems[1], -1), StrToIntDef(Item2.SubItems[1], -1));
    3: Compare := CompareValue(StrToIntDef(Item1.SubItems[2], -1), StrToIntDef(Item2.SubItems[2], -1));
    4: Compare := CompareValue(StrToIntDef(Item1.SubItems[3], -1), StrToIntDef(Item2.SubItems[3], -1));
  end;
  Compare := Compare * fSortDirTB;
end;


procedure TForm7.lvCOsCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  case fSortColCO of
    0: Compare := CompareStr(Item1.Caption, Item2.Caption);
    1: Compare := CompareValue(StrToIntDef(Item1.SubItems[0], -1), StrToIntDef(Item2.SubItems[0], -1));
    2: Compare := CompareValue(StrToIntDef(Item1.SubItems[1], -1), StrToIntDef(Item2.SubItems[1], -1));
    3: Compare := CompareStr(Item1.SubItems[2], Item2.SubItems[2]);
    4: Compare := CompareStr(Item1.SubItems[3], Item2.SubItems[3]);
    5: Compare := CompareStr(Item1.SubItems[4], Item2.SubItems[4]);
    6: Compare := CompareStr(Item1.SubItems[5], Item2.SubItems[5]);
  end;
  Compare := Compare * fSortDirCO;
end;


procedure TForm7.btnCopyAllClick(Sender: TObject);
var
  tb: TTB;
begin
  tb := lvTBs.ItemFocused.Data;

  ValuesCopy(tb);
end;


procedure TForm7.btnPasteAllClick(Sender: TObject);
var
  tb: TTB;
begin
  tb := lvTBs.ItemFocused.Data;

  ValuesPaste(tb);
end;


procedure TForm7.btnFindAndDisplayDSsClick(Sender: TObject);
begin
  LoadDS;
  DisplayDS;
end;


procedure TForm7.ValuesCopy(aTB: TTB);
var
  I, K: Integer;
  sl: TStringList;
  info: string;
  sa: AnsiString;
  su, s: string;
  sb: TBytes;
  s1250: string;
begin
  if aTB = nil then
  begin
    MessageBox(Handle, 'TB not selected', 'Error', MB_OK + MB_ICONERROR);
    Exit;
  end;

  sl := TStringList.Create;
  try
    // Header
    s := '';
    for I := 0 to aTB.fCOs.Count - 1 do
      s := s + IfThen(I > 0, #9) + aTB.fCOs[I].fVALb.Lb;
    sl.Append(s);

    // Values
    for K := 0 to aTB.fCOs[0].fValues.Count - 1 do
    begin
      s := '';

      for I := 0 to aTB.fCOs.Count - 1 do
      begin
        // Get the Unicode string
        if aTB.fCOs[I].fValues.Count >= aTB.fCOs[0].fValues.Count then
        begin
          // By default strings come in English (no codepage needed)
          su := aTB.fCOs[I].fValues[K].ToString;

          // Special treatment for localizations texts (DS uses ANSI, but stores no codepages)
          if aTB.fVALb.Lb = 'Texte' then
            if aTB.fCOs[I].fVALb.Lb = 'Deutsch' then
              su := aTB.fCOs[I].fValues[K].ToUnicodeString(1250)
            else
            if aTB.fCOs[I].fVALb.Lb = 'French' then
              su := aTB.fCOs[I].fValues[K].ToUnicodeString(1252)
            else
            if aTB.fCOs[I].fVALb.Lb = 'Spanish' then
              su := aTB.fCOs[I].fValues[K].ToUnicodeString(1252)
            else
            if aTB.fCOs[I].fVALb.Lb = 'Italian' then
              su := aTB.fCOs[I].fValues[K].ToUnicodeString(1252)
            else
            if aTB.fCOs[I].fVALb.Lb = 'Russian' then
              su := aTB.fCOs[I].fValues[K].ToUnicodeString(1251)
            else
              su := aTB.fCOs[I].fValues[K].ToUnicodeString(1252);
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

    info := Format('Copied %d lines', [sl.Count]);
    MessageBox(Handle, PWideChar(info), 'Info', MB_OK + MB_ICONINFORMATION);
  finally
    sl.Free;
  end;
end;


procedure TForm7.ValuesPaste(aTB: TTB);
var
  I, K: Integer;
  sl: TStringList;
  info: string;
  sa: TStringDynArray;
  su: string;
begin
  if aTB = nil then
  begin
    MessageBox(Handle, 'TB not selected', 'Error', MB_OK + MB_ICONERROR);
    Exit;
  end;

  sl := TStringList.Create;
  try
    sl.Text := Clipboard.AsText;

    // Verify line count
    if sl.Count <> aTB.fCOs[0].fValues.Count + 1 then
    begin
      info := Format('Line count in clipboard %d does not match TB %d+1',
        [sl.Count, aTB.fCOs[0].fValues.Count]);
      MessageBox(Handle, PWideChar(info), 'Error', MB_OK + MB_ICONERROR);
      Exit;
    end;

    // First line is header
    sa := SplitString(sl[0], #9);

    // Verify column count
    if Length(sa) <> aTB.fCOs.Count then
    begin
      info := Format('Column count in clipboard %d does not match TB %d',
        [Length(sa), aTB.fCOs.Count]);
      MessageBox(Handle, PWideChar(info), 'Error', MB_OK + MB_ICONERROR);
      Exit;
    end;

    // Verify column names
    for I := 0 to aTB.fCOs.Count - 1 do
    if aTB.fCOs[I].fVALb.Lb <> sa[I] then
    begin
      info := Format('Column name in clipboard "%s" does not match TB "%s"',
        [sa[I], aTB.fCOs[I].fVALb.Lb]);
      MessageBox(Handle, PWideChar(info), 'Error', MB_OK + MB_ICONERROR);
      Exit;
    end;

    for I := 0 to aTB.fCOs[0].fValues.Count - 1 do
    begin
      sa := SplitString(sl[I + 1], #9);

      for K := 0 to aTB.fCOs.Count - 1 do
      if I < aTB.fCOs[K].fValues.Count then
      begin
        if High(sa) >= K then
          su := sa[K]
        else
          su := '';

        // Restore line breaks
        su := StringReplace(su, '\n', #10, [rfReplaceAll]);
        su := StringReplace(su, '\r', #13, [rfReplaceAll]);

        aTB.fCOs[K].fValues[I].FromString(su);

        // Special treatment for localizations texts (DS uses ANSI, but stores no codepages)
        if aTB.fVALb.Lb = 'Texte' then
          if aTB.fCOs[K].fVALb.Lb = 'Deutsch' then
            aTB.fCOs[K].fValues[I].FromUnicodeString(su, 1250)
          else
          if aTB.fCOs[K].fVALb.Lb = 'French' then
            aTB.fCOs[K].fValues[I].FromUnicodeString(su, 1252)
          else
          if aTB.fCOs[K].fVALb.Lb = 'Spanish' then
            aTB.fCOs[K].fValues[I].FromUnicodeString(su, 1252)
          else
          if aTB.fCOs[K].fVALb.Lb = 'Italian' then
            aTB.fCOs[K].fValues[I].FromUnicodeString(su, 1252)
          else
          if aTB.fCOs[K].fVALb.Lb = 'Russian' then
            aTB.fCOs[K].fValues[I].FromUnicodeString(su, 1251)
          else
            aTB.fCOs[K].fValues[I].FromUnicodeString(su, 1252);
      end;
    end;
    {
    if sl.Count <> aCO.fValues.Count then
    begin
      info := Format('Can not paste.' + sLineBreak +
                     'Clipboard line count %d mismatches CO Values count %d',
                     [sl.Count, aCO.fValues.Count]);
      MessageBox(Handle, PWideChar(info), 'Error', MB_OK + MB_ICONERROR);
      Exit;
    end;

    for I := 0 to sl.Count - 1 do
      aCO.fValues[I].FromString(sl[I]);
     }
    info := Format('Replaced %d lines', [sl.Count]);
    MessageBox(Handle, PWideChar(info), 'Info', MB_OK + MB_ICONINFORMATION);
  finally
    sl.Free;
  end;
end;


end.
