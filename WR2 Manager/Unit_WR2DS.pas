unit Unit_WR2DS;

interface
uses Unit1, KromUtils, FileCtrl, SysUtils, Windows;

    procedure OpenDS(filename:string);
    procedure SaveDS(filename:string);
    procedure AddTracksToDS();
    procedure AddMissionsToDS();
    procedure SaveProfiles();

implementation

procedure OpenDS(filename:string);
var i,k,h,j,m:integer;
begin
assignfile(f,filename); FileMode:=0; reset(f,1); FileMode:=2;
blockread(f,Header,33);
DSqty:=ord(Header[9]);
setlength(TB,DSqty+1);
setlength(CO,DSqty+1);
setlength(Value,DSqty+1);
for i:=1 to DSqty do begin
blockread(f,c,33);
TB[i].Entries:=ord(c[9])+ord(c[10])*256;
TB[i].Index:=ord(c[17])+ord(c[18])*256;
TB[i].iC:=ord(c[25]);
j:=ord(c[30]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
TB[i].Lib:=s;
setlength(CO[i],TB[i].Entries+1);
setlength(Value[i],TB[i].Entries+1);

for k:=1 to TB[i].Entries do begin
blockread(f,c,4);
if c[1]+c[2]+c[3]+c[4]<>'NDCO' then begin
blockread(f,c,4);
TB[i].Cond:=int2(c[1],c[2]);
setlength(TB[i].CondText,TB[i].Cond+1);
  for j:=1 to TB[i].Cond do begin
  blockread(f,c,4);
  h:=int2(c[1],c[2]); //length of entry
  blockread(f,c,h+1);
  for m:=1 to h do TB[i].CondText[j]:=TB[i].CondText[j]+c[m];
  end;
blockread(f,c,4); //read upcoming NDCO
end;

blockread(f,c,24);                      //VAEn, VAId, VALb
CO[i,k].Entries:=ord(c[5])+ord(c[6])*256;
CO[i,k].Index:=ord(c[13])+ord(c[14])*256;
j:=ord(c[21]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
CO[i,k].Lib:=s;

blockread(f,c,13);                      //VASM
CO[i,k].iU:=ord(c[5]);
j:=ord(c[10]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
CO[i,k].SM:=s;

blockread(f,c,8);                       //VAST
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
CO[i,k].ST:=s;

blockread(f,c,8);                       //VAIC
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
CO[i,k].IC:=s;

blockread(f,c,8);                       //VASC
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
CO[i,k].SC:=s;

if (i=14)or(i=16)or(i=19)or(i=49) then
setlength(Value[i,k],CO[i,k].Entries+max(MaxScen,MaxCars,MaxMiss)) else
setlength(Value[i,k],CO[i,k].Entries+10);//stupid way to avoid common length
for j:=1 to CO[i,k].Entries do begin      //mismatches when adding new stuff
Value[i,k,j].Typ:=0;
Value[i,k,j].Int:=0;
Value[i,k,j].Rel:=0;
Value[i,k,j].Str:='';
blockread(f,c,1);
if c[1]=#1  then begin Value[i,k,j].Typ:=1; blockread(f,Value[i,k,j].Int,4); end;
if c[1]=#2  then begin Value[i,k,j].Typ:=2; blockread(f,Value[i,k,j].Rel,4); end;
if c[1]=#16 then begin Value[i,k,j].Typ:=3; Value[i,k,j].Str:=''; blockread(f,h,4);
                       if h<>0 then begin blockread(f,c,h+1);
                       Value[i,k,j].Str:=StrPas(@c); end; end;
if Value[i,k,j].Typ=0 then exit;

end;//CO.Entries
end;//TB.Entries
end; //1..DSqty
closefile(f);
end;

procedure SaveDS(filename:string);
var i,k,j:integer;
begin
assignfile(f,filename); rewrite(f,1);
c[1]:=#0;
blockwrite(f,Header,33); //assume DSQty didn't changed
for i:=1 to DSqty do begin
s:='NDTBVAEn'+chr2(TB[i].Entries,4)+'VAId'+chr2(TB[i].Index,4)+'VAiC'+chr(TB[i].iC)+
'VALb'+chr2(length(TB[i].Lib),4)+TB[i].Lib+#0;
if TB[i].Cond>0 then s:=s+'Cond'+chr2(TB[i].Cond,4);
for j:=1 to TB[i].Cond do s:=s+chr2(length(TB[i].CondText[j]),4)+TB[i].CondText[j]+#0;
blockwrite(f,s[1],length(s));

for k:=1 to TB[i].Entries do begin
s:='NDCOVAEn'+chr2(CO[i,k].Entries,4)+'VAId'+chr2(CO[i,k].Index,4)
+'VALb'+chr2(length(CO[i,k].Lib),4)+CO[i,k].Lib+#0
+'VAiU'+chr(CO[i,k].iU)
    +'VASM'+chr2(length(CO[i,k].SM),4);
if CO[i,k].SM<>'' then s:=s+CO[i,k].SM+#0;
s:=s+'VAST'+chr2(length(CO[i,k].ST),4);
if CO[i,k].ST<>'' then s:=s+CO[i,k].ST+#0;
s:=s+'VAIC'+chr2(length(CO[i,k].IC),4);
if CO[i,k].IC<>'' then s:=s+CO[i,k].IC+#0;
s:=s+'VASC'+chr2(length(CO[i,k].SC),4);
if CO[i,k].SC<>'' then s:=s+CO[i,k].SC+#0;
blockwrite(f,s[1],length(s));

for j:=1 to CO[i,k].Entries do begin
case Value[i,k,j].Typ of
1:      s:=#1+chr2(Value[i,k,j].Int,4);
2:      s:=#2+unreal2(Value[i,k,j].Rel);
3:begin s:=#16+chr2(length(Value[i,k,j].Str),4);
if Value[i,k,j].Str<>'' then s:=s+Value[i,k,j].Str+#0; end;
end;
blockwrite(f,s[1],length(s));

end;//CO.Entries
//Button1.Caption:=inttostr(i)+' '+inttostr(k);
end;//TB.Entries
end; //1..DSqty
closefile(f);
end;

procedure AddTracksToDS();
var ID,scnID,j,i,k:integer;
begin

for j:=1 to TB[14].Entries do if (j<>14)and(j<>15) then begin   //skip these
CO[14,j].Entries:=184;                                          //reset original Qty
for i:=1 to AddonSceneryQty do if AddonScenery[i].Install then
inc(CO[14,j].Entries,AddonScenery[i].TrackQty);
end;

ID:=184; scnID:=0;
for i:=1 to AddonSceneryQty do if AddonScenery[i].Install then begin
AddonScenery[i].FreeRideID_abs:=ID+AddonScenery[i].FreeRideID-1;
inc(scnID);
for k:=1 to AddonScenery[i].TrackQty do begin
inc(ID);  //185..+
for j:=1 to TB[14].Entries do if (j<>14)and(j<>15) then Value[14,j,ID].Typ:=Value[14,j,ID-1].Typ;
Value[14,1,ID].Int:=ID-1;                               //Index
Value[14,2,ID].Int:=6+scnID;                            //SceneryID (installed)
Value[14,3,ID].Int:=AddonScenery[i].Track[k].TrackNo;   //TrackNo
Value[14,4,ID].Str:=AddonScenery[i].Track[k].Name;      //
Value[14,5,ID].Int:=AddonScenery[i].Track[k].CheckPoint;//
Value[14,6,ID].Int:=0;                                  //ReleasedFlag
Value[14,7,ID].Str:='';                                 //ClearColumn
Value[14,8,ID].Int:=0;                                  //NumDrives
Value[14,9,ID].Int:=AddonScenery[i].Track[k].mDistance;   //
Value[14,10,ID].Int:=AddonScenery[i].Track[k].Direction;   //
Value[14,11,ID].Int:=0;                               //TRecordNitro
Value[14,12,ID].Int:=AddonScenery[i].Track[k].WayPoint;    //
//0
Value[14,13,ID].Str:='_krTrk'+int2fix(i,2)+int2fix(k,2);        //TrackMaps
Value[14,16,ID].Int:=AddonScenery[i].Track[k].TypeID;      //TrackType
Value[14,17,ID].Int:=0;                               //TRecordInt
Value[14,18,ID].Str:='<<< LEER >>>';                  //TRecordString
Value[14,19,ID].Str:='<<< LEER >>>';                  //TRecordDriver
Value[14,20,ID].Str:='<<< LEER >>>';                  //TRecordCar
Value[14,21,ID].Str:='<<< LEER >>>';                  //TRecordDay
Value[14,22,ID].Str:='<<< LEER >>>';                  //TRecordMonth
Value[14,23,ID].Str:='<<< LEER >>>';                  //TRecordYear
Value[14,24,ID].Int:=0;                               //TimeTotal
Value[14,25,ID].Int:=AddonScenery[i].Track[k].NumSections; //
Value[14,26,ID].Int:=ID-1;                             //Order
end;//1..AddonScenery[i].TrackQty
end;//1..SceneryQty

for j:=1 to TB[16].Entries do {if (j<>6)and(j<>9) then }begin//skip those
CO[16,j].Entries:=7;
for i:=1 to AddonSceneryQty do if AddonScenery[i].Install then
inc(CO[16,j].Entries);
end;

ID:=7;
for i:=1 to AddonSceneryQty do if AddonScenery[i].Install then begin
inc(ID);  //8+
for j:=1 to TB[16].Entries do if (j<>6)and(j<>9) then Value[16,j,ID].Typ:=Value[16,j,ID-1].Typ; //prev
Value[16,1,ID].Int:=ID-1;                               //Index
Value[16,2,ID].Str:=AddonScenery[i].EngineName;         //
Value[16,3,ID].Str:='_krScnBG'+int2fix(i,2);
Value[16,4,ID].Int:=0;                                  //LastSelectTrack
Value[16,5,ID].Str:=AddonScenery[i].Name;               //
Value[16,7,ID].Str:='_krScnFL'+int2fix(i,2);        //
Value[16,8,ID].Int:=AddonScenery[i].FreeRideID_abs;     //
end;
end;

procedure AddMissionsToDS();
var ID,ID2,j,i,k:integer;
begin
ChDir(RootDir);
for j:=1 to TB[19].Entries do begin //skip those
  CO[19,j].Entries:=74;//original Qty
  for i:=1 to AddonMissionQty do
    if AddonMission[i].Install then
      inc(CO[19,j].Entries);
end;

ID:=74;
for i:=1 to AddonMissionQty do if AddonMission[i].Install then begin
  inc(ID);  //75..+
  for j:=1 to TB[19].Entries do
    Value[19,j,ID].Typ:=Value[19,j,ID-1].Typ;
  Value[19,1,ID].Int:=ID-1;                               //Index
  Value[19,2,ID].Int:=AddonMission[i].EventCode;          //
  Value[19,3,ID].Int:=AddonMission[i].Score;              //
  Value[19,4,ID].Int:=0;                                  //FlagRelease
  Value[19,5,ID].Int:=0;                                  //NumDrives
  Value[19,6,ID].Int:=AddonMission[i].NumRaces;           //
  Value[19,7,ID].Str:=AddonMission[i].Name;               //
  Value[19,8,ID].Int:=AddonMission[i].ResultTyp;          //
  Value[19,9,ID].Int:=0;                                  //Result
  Value[19,10,ID].Str:=AddonMission[i].RefTextFail;       //
  Value[19,11,ID].Str:=AddonMission[i].RefText1;          //
  Value[19,12,ID].Str:=AddonMission[i].RefText2;          //
  Value[19,13,ID].Str:=AddonMission[i].RefText3;          //
  Value[19,14,ID].Int:=1;                                 //ReleaseMission - 'AbsoluteBeginners'
  Value[19,15,ID].Int:=AddonMission[i].MissionClass;      //
  Value[19,16,ID].Int:=0;                                 //ResultCash
  Value[19,17,ID].Int:=AddonMission[i].DefCash;           //
  Value[19,18,ID].Int:=AddonMission[i].InitCShip;         //?
end;//1..AddonMissionQty

for ID:=1 to CO[49,j].Entries do begin //special fix for RefFail/RefSuccess Texts
Value[49,42,ID].Typ:=Value[49,42,1].Typ;
Value[49,43,ID].Typ:=Value[49,43,1].Typ;
end;

for j:=1 to TB[49].Entries do begin
CO[49,j].Entries:=128;//original Qty
for i:=1 to AddonMissionQty do if AddonMission[i].Install then
inc(CO[49,j].Entries,AddonMission[i].NumRaces);
end;

ID:=128; ID2:=0;
for i:=1 to AddonMissionQty do if AddonMission[i].Install then begin
inc(ID2);
for k:=1 to AddonMission[i].NumRaces do begin
inc(ID);  //129..+
for j:=1 to TB[49].Entries do Value[49,j,ID].Typ:=Value[49,j,ID-1].Typ;
Value[49,1,ID].Int:=ID-1;                                       //Index
Value[49,2,ID].Str:=AddonMission[i].Race[k].HeadLineText;       //
Value[49,3,ID].Int:=AddonMission[i].Race[k].BonusID;            //
Value[49,4,ID].Int:=0;                                          //RaceBonus
Value[49,5,ID].Int:=0;                                          //NumDrives
Value[49,6,ID].Int:=0;                                          //FlagResult
Value[49,7,ID].Int:=AddonMission[i].Race[k].CarID;              //
Value[49,8,ID].Int:=AddonMission[i].Race[k].TrackID;            //
Value[49,9,ID].Int:=AddonMission[i].Race[k].Laps;               //
Value[49,10,ID].Int:=AddonMission[i].Race[k].Drivers;           //
Value[49,11,ID].Int:=AddonMission[i].Race[k].StartPosition;     //
Value[49,12,ID].Int:=AddonMission[i].Race[k].LeadTime;          //
Value[49,13,ID].Int:=AddonMission[i].Race[k].LeadMeter;         //
Value[49,14,ID].Int:=AddonMission[i].Race[k].LeadPositions;     //
Value[49,15,ID].Int:=AddonMission[i].Race[k].Nitro;             //
Value[49,16,ID].Int:=AddonMission[i].Race[k].Traffic;           //
Value[49,17,ID].Int:=AddonMission[i].Race[k].RaceMode;          //
Value[49,18,ID].Str:=AddonMission[i].Race[k].MissionText;       //
Value[49,19,ID].Int:=0;                                         //_WR1_UserMark
Value[49,20,ID].Int:=AddonMission[i].Race[k].MinPlace;
Value[49,21,ID].Int:=AddonMission[i].Race[k].AvSpeed;
Value[49,22,ID].Int:=AddonMission[i].Race[k].Drifts;
Value[49,23,ID].Int:=AddonMission[i].Race[k].FinishLeadTime;
Value[49,24,ID].Int:=AddonMission[i].Race[k].MaxDamage;
Value[49,25,ID].Int:=AddonMission[i].Race[k].RaceTime;
Value[49,26,ID].Int:=AddonMission[i].Race[k].MaxLapTime;
Value[49,27,ID].Int:=AddonMission[i].Race[k].TopSpeed;
Value[49,28,ID].Int:=AddonMission[i].Race[k].TopSpeedNum;
Value[49,29,ID].Int:=AddonMission[i].Race[k].OppStrength;
Value[49,30,ID].Int:=AddonMission[i].Race[k].DriveModel;
Value[49,31,ID].Int:=74+ID2-1;                                  //MissionID;
Value[49,32,ID].Int:=k;                                         //MissionRaceOrder;
Value[49,33,ID].Int:=AddonMission[i].Race[k].TrackFilter;
Value[49,34,ID].Int:=AddonMission[i].Race[k].CarFilter;
Value[49,35,ID].Int:=AddonMission[i].Race[k].EventCode;
Value[49,36,ID].Int:=AddonMission[i].Race[k].InitOppCars;
Value[49,37,ID].Int:=AddonMission[i].Race[k].OppCar1;
Value[49,38,ID].Int:=AddonMission[i].Race[k].OppCar2;
Value[49,39,ID].Int:=AddonMission[i].Race[k].OppCar3;
Value[49,40,ID].Int:=AddonMission[i].Race[k].OppCar4;
Value[49,41,ID].Int:=AddonMission[i].Race[k].OppCar5;
Value[49,42,ID].Str:=AddonMission[i].Race[k].TextSuccess;
Value[49,43,ID].Str:=AddonMission[i].Race[k].TextFail;
Value[49,44,ID].Int:=AddonMission[i].Race[k].InitCode;
end;//1..AddonMission[i].RaceQty
end;//1..MissionQty
end;

procedure SaveProfiles();
var s1,s2:string; ID,i,j,k,h:integer;
begin
for ID:=1 to ProfileQty do if Profile[ID].Install then begin

  for k:=1 to 10 do P_[ID].CO[8,k].Entries:=184; //184 is base number of WR2 tracks
  for i:=1 to AddonSceneryQty do if AddonScenery[i].Install then begin
    for h:=1 to AddonScenery[i].TrackQty do begin
      for k:=1 to 10 do begin
      inc(P_[ID].CO[8,k].Entries);
      setlength(P_[ID].Value[8,k],P_[ID].CO[8,k].Entries+1);
      end;
    k:=P_[ID].CO[8,1].Entries;
    P_[ID].Value[8,1,k].Typ:=1;  P_[ID].Value[8,1,k].Int:=1;            //ReleaseFlag
    P_[ID].Value[8,2,k].Typ:=1;  P_[ID].Value[8,2,k].Int:=0;            //NumDrives
    P_[ID].Value[8,3,k].Typ:=1;  P_[ID].Value[8,3,k].Int:=0;            //TRecordNitro
    P_[ID].Value[8,4,k].Typ:=1;  P_[ID].Value[8,4,k].Int:=0;            //TRecordInt
    P_[ID].Value[8,5,k].Typ:=3;  P_[ID].Value[8,5,k].Str:='--:--.--';   //TRecordString
    P_[ID].Value[8,6,k].Typ:=3;  P_[ID].Value[8,6,k].Str:='---';        //TRecordDriver
    P_[ID].Value[8,7,k].Typ:=3;  P_[ID].Value[8,7,k].Str:='---';        //TRecordCar
    P_[ID].Value[8,8,k].Typ:=3;  P_[ID].Value[8,8,k].Str:='--';         //TRecordDay
    P_[ID].Value[8,9,k].Typ:=3;  P_[ID].Value[8,9,k].Str:='--';         //TRecordMonth
    P_[ID].Value[8,10,k].Typ:=3; P_[ID].Value[8,10,k].Str:='----';      //TRecordYear
    end;
  end;

  k:=184; //the last possible LastSelectTrack
  P_[ID].CO[9,1].Entries:=6; //Base number of sceneries
  for i:=1 to AddonSceneryQty do
    if AddonScenery[i].Install then begin
    inc(P_[ID].CO[9,1].Entries);
    setlength(P_[ID].Value[9,1],P_[ID].CO[9,1].Entries+AddonSceneryQty+1);
    P_[ID].Value[9,1,P_[ID].CO[9,1].Entries].Typ:=1; //all integer
    P_[ID].Value[9,1,P_[ID].CO[9,1].Entries].Int:=k+1; //first track for current scenery
    inc(k,AddonScenery[i].TrackQty);
    end;


  for k:=1 to 4 do begin
  P_[ID].CO[10,k].Entries:=74; //Base number of missions
    for i:=1 to AddonMissionQty do
    if AddonMission[i].Install then begin
    inc(P_[ID].CO[10,k].Entries);
    setlength(P_[ID].Value[10,k],P_[ID].CO[10,k].Entries+AddonMissionQty+1);
    P_[ID].Value[10,k,P_[ID].CO[10,k].Entries].Typ:=1; //all integer
    P_[ID].Value[10,k,P_[ID].CO[10,k].Entries].Int:=0;

    P_[ID].Value[10,1,P_[ID].CO[10,k].Entries].Int:=1; //released flag
    end;
  end;

  for k:=1 to 3 do begin
  P_[ID].CO[17,k].Entries:=128;
    for i:=1 to AddonMissionQty do
    if AddonMission[i].Install then begin
    inc(P_[ID].CO[17,k].Entries,AddonMission[i].NumRaces);
    setlength(P_[ID].Value[17,k],P_[ID].CO[17,k].Entries+1);
      for j:=1 to AddonMission[i].NumRaces do begin
      P_[ID].Value[17,k,P_[ID].CO[17,k].Entries-j+1].Typ:=1; //all integer
      P_[ID].Value[17,k,P_[ID].CO[17,k].Entries-j+1].Int:=0;
      end;
    end;
  end;

if Form1.Cheat_AllCarsTracks.Checked then begin
for k:=1 to P_[ID].CO[8,1].Entries do P_[ID].Value[8,1,k].Int:=1;   //TrackReleaseFlag
for k:=1 to P_[ID].CO[13,1].Entries do P_[ID].Value[13,1,k].Int:=1; //CarReleaseFlag
end;

assignfile(f,RootDir+'\WR2-Saves\'+profile[ID].Folder+'\Career.new'); rewrite(f,1);
c[1]:=#0;
blockwrite(f,P_[ID].Header,33); //assume DSQty didn't changed
for i:=1 to P_[ID].DSqty do begin
s:='NDTBVAEn'+chr2(P_[ID].TB[i].Entries,4)+'VAId'+chr2(P_[ID].TB[i].Index,4)+'VAiC'+chr(P_[ID].TB[i].iC)+
'VALb'+chr2(length(P_[ID].TB[i].Lib),4)+P_[ID].TB[i].Lib+#0;
if P_[ID].TB[i].Cond>0 then s:=s+'Cond'+chr2(P_[ID].TB[i].Cond,4);
for j:=1 to P_[ID].TB[i].Cond do s:=s+chr2(length(P_[ID].TB[i].CondText[j]),4)+P_[ID].TB[i].CondText[j]+#0;
blockwrite(f,s[1],length(s));

for k:=1 to P_[ID].TB[i].Entries do begin
s:='NDCOVAEn'+chr2(P_[ID].CO[i,k].Entries,4)+'VAId'+chr2(P_[ID].CO[i,k].Index,4)
+'VALb'+chr2(length(P_[ID].CO[i,k].Lib),4)+P_[ID].CO[i,k].Lib+#0
+'VAiU'+chr(P_[ID].CO[i,k].iU)
+'VASM'+chr2(length(P_[ID].CO[i,k].SM),4);
if P_[ID].CO[i,k].SM<>'' then s:=s+P_[ID].CO[i,k].SM+#0;
s:=s+'VAST'+chr2(length(P_[ID].CO[i,k].ST),4);
if P_[ID].CO[i,k].ST<>'' then s:=s+P_[ID].CO[i,k].ST+#0;
s:=s+'VAIC'+chr2(length(P_[ID].CO[i,k].IC),4);
if P_[ID].CO[i,k].IC<>'' then s:=s+P_[ID].CO[i,k].IC+#0;
s:=s+'VASC'+chr2(length(P_[ID].CO[i,k].SC),4);
if P_[ID].CO[i,k].SC<>'' then s:=s+P_[ID].CO[i,k].SC+#0;
blockwrite(f,s[1],length(s));

for j:=1 to P_[ID].CO[i,k].Entries do begin
case P_[ID].Value[i,k,j].Typ of
1:      s:=#1+chr2(P_[ID].Value[i,k,j].Int,4);
2:      s:=#2+unreal2(P_[ID].Value[i,k,j].Rel);
3:begin s:=#16+chr2(length(P_[ID].Value[i,k,j].Str),4);
if P_[ID].Value[i,k,j].Str<>'' then s:=s+P_[ID].Value[i,k,j].Str+#0; end;
end;
blockwrite(f,s[1],length(s));

end;//CO.Entries
//Button1.Caption:=inttostr(i)+' '+inttostr(k);
end;//TB.Entries
end; //1..DSqty
closefile(f);

DateTimeToString(s,'yyyy-mm-dd hh-nn-ss',Now); //2007-12-23 15-24-33
s1:=RootDir+'\WR2-Saves\'+profile[ID].Folder+'\Career.wrc';
s2:=RootDir+'\WR2-Saves\'+profile[ID].Folder+'\Career '+s+'.bak';
RenameFile(s1,s2);
s1:=RootDir+'\WR2-Saves\'+profile[ID].Folder+'\Career.new';
s2:=RootDir+'\WR2-Saves\'+profile[ID].Folder+'\Career.wrc';
RenameFile(s1,s2);
end;
end;


end.
