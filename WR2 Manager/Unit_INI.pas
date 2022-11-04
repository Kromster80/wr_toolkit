unit Unit_INI;
interface
uses Unit1, KromUtils, FileCtrl, SysUtils;

procedure ReadINI;
procedure WriteINI;

implementation

procedure ReadINI();
var
  i:integer;
  s:string;
  ft:textfile;
begin
  chdir(RootDir);
  if not fileexists('WR2Man.ini') then exit;
  AssignFile(ft,'WR2Man.ini'); reset(ft);
  readln(ft); //writeln(ft,'WR2 Manager INI file');
  readln(ft); //writeln(ft);

  repeat
    readln(ft,s);

    if s='Profiles:' then
    repeat
      readln(ft,s);
      for i:=1 to ProfileQty do
      if not Profile[i].Install then
      Profile[i].Install:=s=Profile[i].Folder;
    until(s='');

    if s='Sceneries:' then
    repeat
      readln(ft,s);
      for i:=1 to AddOnSceneryQty do
      if not AddonScenery[i].Install then
      AddonScenery[i].Install:=s=AddonScenery[i].Folder;
    until(s='');

    if s='Missions:' then
    repeat
      readln(ft,s);
      for i:=1 to AddOnMissionQty do
      if not AddonMission[i].Install then
      AddonMission[i].Install:=s=AddonMission[i].FileName;
    until(s='');

    if s='Runtime:' then begin
      Form1.R_SceneryBG.Checked:=false;
      Form1.R_WriteKM.Checked:=false;
      Form1.R_Stats.Checked:=false;
      repeat
        readln(ft,s);
        if s='SceneryBG' then Form1.R_SceneryBG.Checked:=true;
        if s='WriteKM' then Form1.R_WriteKM.Checked:=true;
        if s='AdvancedStats' then Form1.R_Stats.Checked:=true;
      until(s='');
    end;

  until(eof(ft));
  closefile(ft);

  for i:=1 to ProfileQty do Form1.CLBProfiles.Checked[i-1]:=Profile[i].Install;
  for i:=1 to AddonSceneryQty do Form1.CLBSceneries.Checked[i+6-1]:=AddonScenery[i].Install;
  for i:=1 to AddOnMissionQty do Form1.CLBMissions.Checked[i-1]:=AddonMission[i].Install;
end;

procedure WriteINI();
var
  i:integer;
  ft:textfile;
begin
  chdir(RootDir);
  AssignFile(ft,'WR2Man.ini'); rewrite(ft);
  writeln(ft,'WR2 Manager INI file');

  writeln(ft);
  writeln(ft,'Profiles:');
  for i:=1 to ProfileQty do
    if Profile[i].Install then
      writeln(ft,Profile[i].Folder);

  writeln(ft);
  writeln(ft,'Sceneries:');
  for i:=1 to AddOnSceneryQty do
    if AddonScenery[i].Install then
      writeln(ft,AddonScenery[i].Folder);

  writeln(ft);
  writeln(ft,'Missions:');
  for i:=1 to AddOnMissionQty do
    if AddonMission[i].Install then
      writeln(ft,AddonMission[i].FileName);

  writeln(ft);
  writeln(ft,'Runtime:');
  if Form1.R_SceneryBG.Checked then writeln(ft,'SceneryBG');
  if Form1.R_WriteKM.Checked then writeln(ft,'WriteKM');
  if Form1.R_Stats.Checked then writeln(ft,'AdvancedStats');

  closefile(ft);
end;


end.
