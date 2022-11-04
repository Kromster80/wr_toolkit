unit Unit_Search;
interface
uses Unit1, Unit2, Forms, Unit_WRTools, Windows, CheckLst, KromUtils, FileCtrl, SysUtils,
  Messages, Classes, Controls, ShellAPI, StdCtrls, Buttons, ExtCtrls, ComCtrls;

procedure SearchSceneries();
procedure GetSceneryInfo(s1:string; i1:integer);
procedure SearchProfiles();
procedure GetProfileInfo(s1:string;i1:integer);
procedure SearchAutos();
procedure GetAutoInfo(s1:string;i1:integer);
procedure SearchMissions();
procedure GetMissionInfo(s1:string; i1:integer);

implementation

procedure SearchSceneries();
var SearchRec:TSearchRec; ii,h,i,k:integer;
begin
  ChDir(RootDir);
  ////////////////////////////////////////////////////////////////////////////////
  //Scanning for add-on scenario folders
  ////////////////////////////////////////////////////////////////////////////////
  if not DirectoryExists('AddOns\Sceneries') then begin
    MessageBox(0, '"AddOns\Sceneries\" not found', 'Warning', MB_ICONWARNING or MB_OK or MB_TOPMOST or MB_APPLMODAL);
    AddonSceneryQty:=0;
    //exit;
  end else begin
    ChDir('AddOns\Sceneries');
    FindFirst('*', faAnyFile or faDirectory, SearchRec);
    h:=1;
    repeat
      if (SearchRec.Attr and faDirectory<>0)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then begin
      if fileexists(RootDir+'\AddOns\Sceneries\'+SearchRec.Name+'\EditScenery.sc2') then begin
      AddonScenery[h].Folder:=SearchRec.Name;
      inc(h); end; end;
    until (FindNext(SearchRec)<>0);
    FindClose(SearchRec);
    AddonSceneryQty:=h-1;

    //resorting add-on sceneries for Multi-Players
    for i:=1 to h-1 do //all
    for k:=i+1 to h-1 do  //all following after
    if uppercase(AddonScenery[i].Folder)>uppercase(AddonScenery[k].Folder) then
      SwapStr(AddonScenery[i].Folder, AddonScenery[k].Folder);
  end;

  Form2.Label3.Visible:=true;
  for ii:=1 to AddonSceneryQty do begin
    Form2.Label3.Caption:=inttostr(ii)+'/'+inttostr(AddonSceneryQty)+' ('+AddonScenery[ii].Folder+')'; Form2.Label3.Repaint;
    GetSceneryInfo(AddonScenery[ii].Folder,ii);
  end;
  Form2.Label3.Visible:=false;

  for i:=2 to 7 do begin  //CO[16,2].Entries
    Form1.CLBSceneries.AddItem(#160+WRTexte(Value[16,5,i].Str), TObject(i-1));
    Form1.CLBSceneries.State[i-2]:=cbGrayed;
    Form1.CLBSceneries.ItemEnabled[i-2]:=false;
  end;

  for ii:=1 to AddonSceneryQty do begin
    Form1.CLBSceneries.AddItem(' '+AddonScenery[ii].Name, TObject(ii));
    Form1.CLBSceneries.Checked[ii+6-1]:=AddonScenery[ii].Install;
  end;

  Form1.Label127.Caption:='Available sceneries: '+inttostr(6+AddonSceneryQty)+' / '+inttostr(MaxScen);
end;

procedure GetSceneryInfo(s1:string; i1:integer);
var
  w: Word;
  k:integer;
  f:file;
begin
  AssignFile(f,s1+'\EditScenery.sc2'); FileMode:=0; reset(f,1); FileMode:=2; //read-only
  blockread(f,c,4); if c[1]+c[2]+c[3]+c[4]<>'WR2'+#1 then exit;
  blockread(f,c,2); //Chapters
  with AddonScenery[i1] do
  begin
    blockread(f,w,2);
    if w<>0 then begin blockread(f,c,w+1); EngineName:=PAnsiChar(@c); end;
    blockread(f,w,2);
    if w<>0 then begin blockread(f,c,w+1); BGround:=PAnsiChar(@c); end;
    blockread(f,w,2);
    if w<>0 then begin blockread(f,c,w+1); Name:=PAnsiChar(@c); end;
    blockread(f,w,2);
    if w<>0 then begin blockread(f,c,w+1); SceneryFlag:=PAnsiChar(@c); end;
blockread(f,FreeRideID,2);
blockread(f,TrackQty,2);
  for k:=1 to TrackQty do with AddonScenery[i1].Track[k] do begin
  blockread(f,TrackNo,2);
  blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); Name:=PAnsiChar(@c); end;
  blockread(f,CheckPoint,2);
  blockread(f,mDistance,2);
  blockread(f,Direction,2);
  blockread(f,WayPoint,2);
  blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); Maps:=PAnsiChar(@c); end;
  blockread(f,TypeID,2);
  blockread(f,NumSections,2);
  blockread(f,Order,2);
  end;
blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); Author:=PAnsiChar(@c); end;
blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); Converter:=PAnsiChar(@c); end;
blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); Contact:=PAnsiChar(@c); end;
blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); Comment:=PAnsiChar(@c); end;
end;
closefile(f);
end;

procedure SearchProfiles();
var SearchRec:TSearchRec; ii,h:integer;
begin
  ChDir(RootDir);
  if not DirectoryExists('WR2-Saves') then begin
    MessageBox(0, '"WR2-Saves\" not found', 'Warning', MB_ICONWARNING or MB_OK or MB_TOPMOST or MB_APPLMODAL);
    exit;
  end;
  ChDir('WR2-Saves');
  FindFirst('*', faAnyFile or faDirectory, SearchRec);
  h:=1;
  repeat
    if (SearchRec.Attr and faDirectory<>0)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then
    if fileexists(RootDir+'\WR2-Saves\'+SearchRec.Name+'\career.wrc') then begin
    Profile[h].Folder:=SearchRec.Name;
    inc(h); end;
  until(FindNext(SearchRec)<>0);
  FindClose(SearchRec);
  ProfileQty:=h-1;
  Form2.Label3.Visible:=true;
  for ii:=1 to ProfileQty do begin
    Form2.Label3.Caption:=inttostr(ii)+'/'+inttostr(ProfileQty)+' ('+Profile[ii].Folder+')'; Form2.Label3.Repaint;
    GetProfileInfo(Profile[ii].Folder,ii);
    Form1.CLBProfiles.AddItem(Profile[ii].Folder,nil);
  end;
  Form2.Label3.Visible:=false;
  Form1.Label3.Caption:='Player profiles: '+inttostr(ProfileQty)+' / '+inttostr(MaxProf);
end;

procedure GetProfileInfo(s1:string;i1:integer);
var i,j,m,k,h:integer; s:string; f:file;
begin
AssignFile(f,RootDir+'\WR2-Saves\'+s1+'\career.wrc'); FileMode:=0; reset(f,1); FileMode:=2;
blockread(f,P_[i1].Header,33);
P_[i1].DSqty:=ord(P_[i1].Header[9]);
for i:=1 to P_[i1].DSqty do begin
blockread(f,c,33);
P_[i1].TB[i].Entries:=ord(c[9])+ord(c[10])*256;
P_[i1].TB[i].Index:=ord(c[17])+ord(c[18])*256;
P_[i1].TB[i].iC:=ord(c[25]);
j:=ord(c[30]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
P_[i1].TB[i].Lib:=s;

for k:=1 to P_[i1].TB[i].Entries do begin
blockread(f,c,4);
if c[1]+c[2]+c[3]+c[4]<>'NDCO' then begin
blockread(f,c,4);
P_[i1].TB[i].Cond:=int2(c[1],c[2]);
setlength(P_[i1].TB[i].CondText,P_[i1].TB[i].Cond+1);
  for j:=1 to P_[i1].TB[i].Cond do begin
  blockread(f,c,4);
  h:=int2(c[1],c[2]); //length of entry
  blockread(f,c,h+1);
  for m:=1 to h do P_[i1].TB[i].CondText[j]:=P_[i1].TB[i].CondText[j]+c[m];
  end;
blockread(f,c,4); //read upcoming NDCO
end;

blockread(f,c,24);                      //VAEn, VAId, VALb
P_[i1].CO[i,k].Entries:=ord(c[5])+ord(c[6])*256;
P_[i1].CO[i,k].Index:=ord(c[13])+ord(c[14])*256;
j:=ord(c[21]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
P_[i1].CO[i,k].Lib:=s;

blockread(f,c,13);                      //VASM
P_[i1].CO[i,k].iU:=ord(c[5]);
j:=ord(c[10]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
P_[i1].CO[i,k].SM:=s;

blockread(f,c,8);                       //VAST
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
P_[i1].CO[i,k].ST:=s;

blockread(f,c,8);                       //VAIC
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
P_[i1].CO[i,k].IC:=s;

blockread(f,c,8);                       //VASC
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1); s:='';
for m:=1 to j do s:=s+c[m];
P_[i1].CO[i,k].SC:=s;

setlength(P_[i1].Value[i,k],P_[i1].CO[i,k].Entries+1);//stupid way to avoid common length
for j:=1 to P_[i1].CO[i,k].Entries do begin      //mismatches when adding new stuff
P_[i1].Value[i,k,j].Typ:=0;
P_[i1].Value[i,k,j].Int:=0;
P_[i1].Value[i,k,j].Rel:=0;
P_[i1].Value[i,k,j].Str:='';
blockread(f,c,1);
if c[1]=#1  then begin P_[i1].Value[i,k,j].Typ:=1; blockread(f,P_[i1].Value[i,k,j].Int,4); end;
if c[1]=#2  then begin P_[i1].Value[i,k,j].Typ:=2; blockread(f,P_[i1].Value[i,k,j].Rel,4); end;
if c[1]=#16 then begin P_[i1].Value[i,k,j].Typ:=3; blockread(f,h,4); if h<>0 then begin blockread(f,c,h+1);
                       P_[i1].Value[i,k,j].Str:=PAnsiChar(@c); end; end;
if P_[i1].Value[i,k,j].Typ=0 then exit;

end;//CO.Entries
end;//TB.Entries
end; //1..DSqty
closefile(f);
end;


procedure SearchAutos();
var SearchRec:TSearchRec; ii,kk,jj,t,h,i,k:integer;
begin
  ChDir(RootDir);
  AddonCarQty:=0;

  if not DirectoryExists('AddOns\autos') then begin
    MessageBox(0, '"AddOns\autos\" not found', 'Warning', MB_ICONWARNING or MB_OK or MB_TOPMOST or MB_APPLMODAL);
    exit;
  end else begin
    ChDir('AddOns\autos');
    FindFirst('*', faAnyFile or faDirectory, SearchRec);
    h:=1;
    repeat
      if (SearchRec.Attr and faDirectory<>0)
      and(SearchRec.Name<>'.')
      and(SearchRec.Name<>'..')
      and fileexists(RootDir+'\AddOns\autos\'+SearchRec.Name+'\EditCar.car') then begin
        AddonCar[h].Folder:=SearchRec.Name;
        inc(h);
      end;
    until (FindNext(SearchRec)<>0);
    FindClose(SearchRec);
    AddonCarQty:=h-1;
  end;

  Form2.Label3.Visible := true;
  //ChkListCars.Clear;
  for ii:=1 to AddonCarQty do begin //don't use (i) here
    Form2.Label3.Caption:=inttostr(ii)+'/'+inttostr(AddonCarQty)+' ('+AddonCar[ii].Folder+')';
    Form2.Label3.Repaint;
    GetAutoInfo(AddonCar[ii].Folder,ii);
    if AddonCar[ii].Factory<>'' then
      AddonCar[ii].Name:=' '+AddonCar[ii].Factory+' '+AddonCar[ii].Model
    else
      AddonCar[ii].Name:=' '+AddonCar[ii].Model;
    Form1.CBCars.AddItem(AddOnCarPrefix+AddonCar[ii].Name, TObject(ii));
    //ChkListCars.AddItem(AddonCar[ii].Name+zz+inttostr(ii),nil);
  end;

  for i:=2 to CO[24,3].Entries do
  Form1.CBCars.AddItem(#160+Value[24,44,i].Str+' '+Value[24,3,i].Str+zz+inttostr(i-1),nil);

  Form1.CBCars.ItemIndex:=0;

  Form1.ListCars2.AddItem('',nil);
  for k:=1 to MaxCars do begin
    for i:=2 to CO[24,3].Entries do
      if Value[24,7,i].Int=k then begin
        Form1.ListCars2.AddItem(#160+Value[24,44,i].Str+' '+Value[24,3,i].Str+zz+inttostr(i-1)+' '+inttostr(Value[24,4,i].Int),nil);
        inc(CarsInClass[k]);
      end;
    for ii:=1 to AddonCarQty do
      if AddonCar[ii].MenuClass=k then begin
        Form1.ListCars2.AddItem(AddOnCarPrefix+AddonCar[ii].Name+zz+inttostr(ii)+' '+inttostr(AddonCar[ii].Score),nil);
        inc(CarsInClass[k]);
      end;
    if Form1.ListCars2.Items.Strings[Form1.ListCars2.Count-1]<>'' then begin
      Form1.ListCars2.AddItem('',nil);
    end;
  end;

  t:=0;
  for ii:=1 to MaxCars do begin
    if CarsInClass[ii]<>0 then inc(t);
    for kk:=1 to CarsInClass[ii] do begin
      for jj:=1 to kk-1 do
      if IDfromSTR(Form1.ListCars2.Items[kk-1+t],1)<IDfromSTR(Form1.ListCars2.Items[jj-1+t],1) then begin //previous is empty row
        Form1.ListCars2.Items.Insert(jj-1+t,Form1.ListCars2.Items[kk-1+t]);
        Form1.ListCars2.Items.Delete(kk-1+t+1);          //Delete moved text
      end;
    //inc(t);
    end;
    inc(t,CarsInClass[ii]);
  end;

  for i:=2 to Form1.ListCars2.Count-1 do
    for k:=2 to i-1 do begin
      if (Form1.ListCars2.Items[i-2]='')and //compare by groups
         (Form1.ListCars2.Items[k-2]='')and
      ((IDfromSTR(Form1.ListCars2.Items[k-1],1))
      >(IDfromSTR(Form1.ListCars2.Items[i-1],1)))
      then begin //compare Scores
        t:=0;
        repeat
          Form1.ListCars2.Items.Insert(k-1+t,Form1.ListCars2.Items[i-1+t]);
          inc(t);
          Form1.ListCars2.Items.Delete(i-1+t);          //Delete moved text
        until(Form1.ListCars2.Items[i-1+t]='');       //until empty moved
        Form1.ListCars2.Items.Insert(k-1+t,'');       //add spacer
        Form1.ListCars2.Items.Delete(i-1+t+1);        //delete old spacer
        break;
      end;
    end;

  Form1.ListCars2.Items.Delete(Form1.ListCars2.Count-1); //Delete last empty

  Form1.Label141.Caption:='Available cars: '+inttostr(CO[24,3].Entries-1)+'+'+inttostr(AddonCarQty)+' / '+inttostr(MaxCars);

  Form2.Label3.Visible:=false;
end;


procedure GetAutoInfo(s1:string;i1:integer);
var NumRead,Pos,i,k,j,h,m:integer; f:file;
begin
  Pos:=0; //reset to 0
  AssignFile(f,RootDir+'\AddOns\autos\'+s1+'\EditCar.car'); FileMode:=0; reset(f,128); FileMode:=2;
  blockread(f,c,1000,NumRead); closefile(f); //reading 128kbytes should be enough (usually ~30kb)

  EC_DSqty:=ord(c[Pos+9]);
  inc(Pos,33);
  
  for i:=1 to EC_DSqty do begin
    EC_TB[i].Entries:=ord(c[Pos+9])+ord(c[Pos+10])*256;
    if ord(c[Pos+30])<>0 then inc(Pos,ord(c[Pos+30])+1);//blockread(f,c,ord(c[30])+1);
    inc(Pos,33);

    for k:=1 to EC_TB[i].Entries do begin
      if (c[Pos+1]+c[Pos+2]+c[Pos+3]+c[Pos+4])<>'NDCO' then begin
      inc(Pos,4);
      EC_TB[i].Cond:=int2(c[Pos+1],c[Pos+2]);
      inc(Pos,4);
      setlength(EC_TB[i].CondText,EC_TB[i].Cond+1);
        for j:=1 to EC_TB[i].Cond do begin
          m:=int2(c[Pos+1],c[Pos+2]);
          inc(Pos,4);
          for h:=1 to m do EC_TB[i].CondText[j]:=EC_TB[i].CondText[j]+c[Pos+h];
          inc(Pos,m+1);  //reading upside-down
        end;
      //read upcoming NDCO
      //inc(Pos,4);
      end;
      inc(Pos,4);
      //VAEn, VAId, VALb
      EC_CO[i,k].Entries:=ord(c[Pos+5])+ord(c[Pos+6])*256;
      j:=ord(c[Pos+21]); inc(Pos,24); if j<>0 then inc(Pos,j+1);//VAEn, VAId, VALb
      j:=ord(c[Pos+10]); inc(Pos,13); if j<>0 then inc(Pos,j+1);//VASM
      j:=ord(c[Pos+5]);  inc(Pos, 8); if j<>0 then inc(Pos,j+1);//VAST
      j:=ord(c[Pos+5]);  inc(Pos, 8); if j<>0 then inc(Pos,j+1);//VAIC
      j:=ord(c[Pos+5]);  inc(Pos, 8); if j<>0 then inc(Pos,j+1);//VASC

      setlength(EC_Value[i,k],EC_CO[i,k].Entries+1);
      for j:=1 to EC_CO[i,k].Entries do begin
        EC_Value[i,k,j].Typ:=0; EC_Value[i,k,j].Int:=0; EC_Value[i,k,j].Rel:=0; EC_Value[i,k,j].Str:='';
        if c[Pos+1]=#1  then begin
                    EC_Value[i,k,j].Typ:=1; EC_Value[i,k,j].Int:=int2(c[Pos+2],c[Pos+3],c[Pos+4],c[Pos+5]); inc(Pos,5); end;
        if c[Pos+1]=#2  then begin
                    EC_Value[i,k,j].Typ:=2; EC_Value[i,k,j].Rel:=real2(c[Pos+2],c[Pos+3],c[Pos+4],c[Pos+5]); inc(Pos,5); end;
        if c[Pos+1]=#16 then begin
                    EC_Value[i,k,j].Typ:=3; h:=int2(c[Pos+2],c[Pos+3],c[Pos+4],c[Pos+5]); inc(Pos,5);
                    for m:=1 to h do EC_Value[i,k,j].Str:=EC_Value[i,k,j].Str+c[Pos+m];
                    if h<>0 then inc(Pos,h+1); end;
        if EC_Value[i,k,j].Typ=0 then Form1.Close;
      end;//CO.Entries
    end;//TB.Entries
  end; //1..DSqty

  if length(EC_Value[2,105])>=2 then //fix for old editcars with few fields
  AddonCar[i1].Factory:=EC_Value[2,105,2].Str
  else AddonCar[i1].Factory:='';
  AddonCar[i1].Model:=EC_Value[2,4,2].Str;
  AddonCar[i1].Score:=EC_Value[2,5,2].Int;
  AddonCar[i1].MenuClass:=EC_Value[2,8,2].Int;
  AddonCar[i1].RaceClass:=EC_Value[2,43,2].Int;
end;


procedure SearchMissions();
var SearchRec:TSearchRec; ii,h,i,k:integer; NodeAdded:boolean;
begin
ChDir(RootDir);
////////////////////////////////////////////////////////////////////////////////
//Scanning for add-on missions folders
////////////////////////////////////////////////////////////////////////////////
if not DirectoryExists('AddOns\Missions') then begin
  MessageBox(0, '"AddOns\Missions\" not found', 'Warning', MB_ICONWARNING or MB_OK or MB_TOPMOST or MB_APPLMODAL);
  AddonMissionQty:=0;
end else begin
ChDir('AddOns\Missions');
FindFirst('*', faAnyFile or faDirectory, SearchRec);
h:=1;
repeat
if (SearchRec.Attr and faDirectory=0)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then
if GetFileExt(SearchRec.Name)='MIS' then begin
AddonMission[h].FileName:=SearchRec.Name;
inc(h); end;
until (FindNext(SearchRec)<>0);
FindClose(SearchRec);
AddonMissionQty:=h-1;
end;

Form2.Label3.Visible:=true;
for ii:=1 to AddonMissionQty do begin
Form2.Label3.Caption:=inttostr(ii)+'/'+inttostr(AddonMissionQty)+' ('+AddonMission[ii].FileName+')'; Form2.Label3.Repaint;
GetMissionInfo(AddonMission[ii].FileName,ii);
//sleep(400);
end;
Form2.Label3.Visible:=false;

for ii:=1 to AddonMissionQty do begin
Form1.CLBMissions.AddItem(AddonMission[ii].FileName+' '+AddonMission[ii].Name,nil);
Form1.CLBMissions.Checked[ii-1]:=AddonMission[ii].Install;
end;

for i:=2 to 74 do begin
NodeAdded:=false;
for k:=2 to i-1 do
if Value[19,15,i].Int=Value[19,15,k].Int then begin
if not NodeAdded then
MNode[i]:=Form1.TWMissions.Items.AddChild(MNode[k],WRTexte(Value[19,7,i].Str));
NodeAdded:=true;
end;
if not NodeAdded then
MNode[i]:=Form1.TWMissions.Items.Add(MNode[i],WRTexte(Value[19,7,i].Str));

end;

  Form1.Label129.Caption:='Available missions: '+inttostr(AddonMissionQty)+' / '+inttostr(MaxMiss);

end;

procedure GetMissionInfo(s1:string; i1:integer);
var
  f:file;
  Version:byte;
  w: Word;
  k:integer;
begin
AssignFile(f,s1); FileMode:=0; reset(f,1); FileMode:=2; //read-only
blockread(f,c,4);
if (c[1]+c[2]+c[3]<>'WR2') then exit;
Version:=ord(c[4]);
blockread(f,c,2); //=1 means number of missions inside the file
with AddonMission[i1] do begin //mission maker ID
blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); Name:=PAnsiChar(@c); end;
blockread(f,EventCode,2);
blockread(f,ResultTyp,2);
blockread(f,NumRaces,2);
blockread(f,MissionClass,2);
blockread(f,Score,2);
blockread(f,DefCash,2);
blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); RefText1:=PAnsiChar(@c); end;
blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); RefText2:=PAnsiChar(@c); end;
blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); RefText3:=PAnsiChar(@c); end;
blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); RefTextFail:=PAnsiChar(@c); end;
blockread(f,InitCShip,2);
for k:=1 to NumRaces do begin
blockread(f,c,2); //=ID
blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); Race[k].HeadLineText:=PAnsiChar(@c); end;
blockread(f,Race[k].BonusID,24);
{blockread(f,Race[k].CarID,2);
blockread(f,Race[k].TrackID,2);
blockread(f,Race[k].Laps,2);
blockread(f,Race[k].Drivers,2);
blockread(f,Race[k].StartPosition,2);
blockread(f,Race[k].LeadTime,2);
blockread(f,Race[k].LeadMeter,2);
blockread(f,Race[k].LeadPositions,2);
blockread(f,Race[k].Nitro,2);
blockread(f,Race[k].Traffic,2);
blockread(f,Race[k].RaceMode,2);}
blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); Race[k].MissionText:=PAnsiChar(@c); end;
blockread(f,Race[k].MinPlace,22);
{blockread(f,Race[k].AvSpeed,2);
blockread(f,Race[k].Drifts,2);
blockread(f,Race[k].FinishLeadTime,2);
blockread(f,Race[k].MaxDamage,2);
blockread(f,Race[k].RaceTime,2);
blockread(f,Race[k].MaxLapTime,2);
blockread(f,Race[k].TopSpeed,2);
blockread(f,Race[k].TopSpeedNum,2);
blockread(f,Race[k].OppStrength,2);
blockread(f,Race[k].DriveModel,2);}
blockread(f,c,2); //MissionID
blockread(f,c,2); //MissionRaceOrder
blockread(f,Race[k].TrackFilter,2);
blockread(f,Race[k].CarFilter,2);
blockread(f,Race[k].EventCode,2);
blockread(f,Race[k].InitOppCars,2);
blockread(f,Race[k].OppCar1,2);
blockread(f,Race[k].OppCar2,2);
blockread(f,Race[k].OppCar3,2);
blockread(f,Race[k].OppCar4,2);
blockread(f,Race[k].OppCar5,2);
blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); Race[k].TextSuccess:=PAnsiChar(@c); end;
blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); Race[k].TextFail:=PAnsiChar(@c); end;
blockread(f,Race[k].InitCode,2);
end; //..NumRaces

if Version>=2 then begin
  blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); Author:=PAnsiChar(@c); end;
  blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); Contact:=PAnsiChar(@c); end;
end;
if Version>=3 then begin //Include comment, addon cars and tracks
  blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); Comment:=PAnsiChar(@c); end;
  blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); CarName:=PAnsiChar(@c); end;
  blockread(f,w,2); if w<>0 then begin blockread(f,c,w+1); TrackName:=PAnsiChar(@c); end;
end;

end; //..with
closefile(f);
end;

end.
 