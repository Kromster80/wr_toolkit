unit WR_Manager_unit1;
interface
uses
  Windows, ShellApi, Forms, sysutils, filectrl, KromUtils,
  ExtCtrls, StdCtrls, Controls, Classes, Graphics, Buttons, ComCtrls,
  CheckLst;

type
  TForm1 = class(TForm)
    BAbout: TButton;
    CLBox2: TCheckListBox;
    Bmemo1: TButton;
    BChoose1: TButton;
    Label2: TLabel;
    BChoose2: TButton;
    Bmemo2: TButton;
    Bmemo3: TButton;
    Bmemo4: TButton;
    BChoose4: TButton;
    BChoose3: TButton;
    BAll: TButton;
    BNone: TButton;
    Bevel1: TBevel;
    Bmemo5: TButton;
    BChoose5: TButton;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    BRevert: TButton;
    SB_MBWR: TSpeedButton;
    SB_MBWRMP: TSpeedButton;
    SBSave: TSpeedButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    CLBox1: TCheckListBox;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    CBSort: TCheckBox;
    Bevel2: TBevel;
    Label6: TLabel;
    CLBox3: TCheckListBox;
    GroupBox2: TGroupBox;
    RGDisplay: TRadioGroup;
    RGDisplay2: TRadioGroup;
    CBSort2: TCheckBox;
    CBBup: TCheckBox;
    LBox1: TListBox;
    Label16: TLabel;
    Label17: TLabel;
    Label15: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label18: TLabel;
    Label19: TLabel;
    Button2: TButton;
    Button1: TButton;
    procedure Err(ErrorID:integer; parameter:string);
    procedure FormCreateAction_Scan(Sender: TObject);
    procedure Scan4Cars();
    procedure Scan4Tracks();
    procedure LoadInfos(Sender: TObject; IDX:integer);
    procedure ScanCAR(carfile:string);
    procedure Scan4Prof();
    procedure RefreshCarList();
    procedure RefreshCarQty();
    procedure RefreshScnQty();
    procedure BAboutClick(Sender: TObject);
    procedure AddFav1(Sender: TObject);
    procedure AddFav2(Sender: TObject);
    procedure SetFav(Sender: TObject);
    procedure CLBox1ClickCheck(Sender: TObject);
    procedure SBSaveClick(Sender: TObject);
    procedure CBSortClick(Sender: TObject);
    procedure AllorNone(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CLBox1DblClick(Sender: TObject);
    procedure Revert(Sender: TObject);
    procedure SB_MBWRClick(Sender: TObject);
    procedure SB_MBWRMPClick(Sender: TObject);
    procedure GetTrackInfo(Sender: TObject);
    procedure RGDisplay2Click(Sender: TObject);
    procedure SaveINIFile();
    procedure SaveWRdsFrontEnd();
    procedure CLBox3ClickCheck(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  end;

const
  MaxCars=2048; zz:string=#13+#10;
  strasse: array [1..13]of string=(
    'Tarmac','Tarmac/Gravel','Tarmac/Sand','Tarmac/Grass','Tarmac/Snow','Tarmac/Concrete',
    'Sand','Sand/Gravel','Sand/Grass','Gravel','Grass','Snow','Concrete');
  gelaende: array [1..7]of string=(
    'Off the Road','Flat','Rolling','Ondulating','Hilly','Mountainous','Terrain');


var
  Form1: TForm1;
  SearchRec: TSearchRec;
RootDir:string;
f,g:file;
ft,gt:textfile;
NR,SendID:integer; //NumRead
fw,fh:integer;
s:string;

nodeqty,scnqty:integer;
mauth,mconv,misc: array [1..256]of string;
trkscn,trkstage,trkrel,trkmark,trkdriv,trkchk,trksurf,trkshape,trkoffr: array [1..256,1..20]of integer;
trkname,trkimage: array [1..256,1..20]of string;
trklen: array [1..256,1..256]of real;
scndir,scnbg,scnol,scnfl,scnld,scningame,scnname: array [1..256]of string;
TrackQty,scnlast: array [1..256]of integer;

TBname,DSname: array [1..512]of string; //1..287 for password protected cars
DSqty,TBqty,COqty:integer;  //Number of parameters(176), temp


aqty,pqty,Checkedqty,Checkedqty_S,ReleasedCars,ReleasedTracks,fqty:integer;
ii,kk,ID,id2,h,i,j,k,l,m:integer;
installed,installed_S: array [1..MaxCars]of boolean;
incl:boolean;
rclass: array [1..MaxCars]of word;
addon,location: array [1..MaxCars]of string;
modelname,carname,origcarname: array [1..MaxCars]of string;
cmprof,profile,s2,s3: array [1..32]of string;
favqty: array [1..8]of integer;
fav: array [1..8,1..MaxCars]of string;
favname: array [1..8]of string;
c,d: array [1..4096]of char;

implementation
uses
  WR_AboutBox, WR_Manager_SetName, WR_Manager_Splash, WR_Manager_ReleaseNotesForm;

{$R *.dfm}

procedure TForm1.Err(ErrorID:integer; parameter:string);
var s:string;
begin
if ErrorID=1  then s:='Folder '+parameter+' contains no EditCar.car file. Folder skipped.';
if ErrorID=2  then s:='"WR-EditCars" folder already contains '+parameter+'.'+#10+#13+'Still car will be installed. You have to solve this case on your own, sorry.';
if ErrorID=3  then s:='"WR-EditCars\Bak" folder already contains '+parameter+'.'+#10+#13+'Still car will be installed. You have to solve this case on your own, sorry.';
if ErrorID=4  then s:='Two folders with identical names ('+parameter+') encountered.'+#10+#13+'CarManager will ignore this. You have to delete one of them.';
MessageBox(0,@s[1],'Error',MB_OK or MB_ICONWARNING or MB_TASKMODAL);
end;

procedure TForm1.FormCreateAction_Scan(Sender: TObject);
begin
Form3.Shape1.Width:=0;
Form3.Show;
Form3.Image1.Refresh;
BChoose1.Hint:='>';
BChoose2.Hint:='>';
BChoose3.Hint:='>';
BChoose4.Hint:='>';
BChoose5.Hint:='>';
if fileexists('carman.ini') then begin
AssignFile(ft,'carman.ini'); FileMode:=0; reset(ft); FileMode:=2;
i:=1; k:=1;
repeat
 repeat
 readln(ft,s);
 until((s='')or(s[1]+s[2]<>'//'));

 if s='[Options]' then
 repeat
 readln(ft,s);
 if s='' then break;
 if (s[1]='W') then //Width=***
   if length(s)<10 then Form1.Width:=strtoint(s[7]+s[8]+s[9]) //***
                   else Form1.Width:=strtoint(s[7]+s[8]+s[9]+s[10]); //****
 if (s[1]='H') then //Height=***
   if length(s)<11 then Form1.Height:=strtoint(s[8]+s[9]+s[10]) //***
                   else Form1.Height:=strtoint(s[8]+s[9]+s[10]+s[11]); //****
 if (length(s)=12) then begin //FullScreen=*
   if (s[12]='1') then Form1.WindowState:=wsMaximized else
   if (s[12]='0') then Form1.WindowState:=wsNormal; end else
 if (length(s)=15) then //DisplayFormat=*
   RGDisplay.ItemIndex:=strtoint(s[15]);
 if (length(s)=16) then //DisplayFormat2=*
   RGDisplay2.ItemIndex:=strtoint(s[16]);
 if (length(s)=13) then begin //MakeBackups=*
   if (s[13]='1') then CBBup.Checked:=true else
   if (s[13]='0') then CBBup.Checked:=false; end else
 if (length(s)=10) then begin  //SortList=*
   if (s[10]='1') then CBSort.Checked:=true else
   if (s[10]='0') then CBSort.Checked:=false; end;
 if (length(s)=11) then begin  //SortList2=*
   if (s[11]='1') then CBSort2.Checked:=true else
   if (s[11]='0') then CBSort2.Checked:=false; end;
 until(s='') else

 if s='[Profiles]' then
 repeat
 readln(ft,s);
 cmprof[i]:=s;
 inc(i);
 until(s='') else

 if (s='[Set'+inttostr(k)+']')and(k<=5) then begin
 readln(ft,s);
 favname[k]:=''; favqty[k]:=0;
 for j:=6 to length(s) do favname[k]:=favname[k]+s[j];
   case k of
   1: BChoose1.Caption:=favname[k];
   2: BChoose2.Caption:=favname[k];
   3: BChoose3.Caption:=favname[k];
   4: BChoose4.Caption:=favname[k];
   5: BChoose5.Caption:=favname[k];
   end;
 repeat
 readln(ft,s);
 if (k=1)and(s<>'') then BChoose1.Hint:=BChoose1.Hint+#10+#13+s;
 if (k=2)and(s<>'') then BChoose2.Hint:=BChoose2.Hint+#10+#13+s;
 if (k=3)and(s<>'') then BChoose3.Hint:=BChoose3.Hint+#10+#13+s;
 if (k=4)and(s<>'') then BChoose4.Hint:=BChoose4.Hint+#10+#13+s;
 if (k=5)and(s<>'') then BChoose5.Hint:=BChoose5.Hint+#10+#13+s;
 inc(favqty[k]);
 fav[k,favqty[k]]:=s;
 until(s='');
 dec(favqty[k]);
 fqty:=k;
 inc(k);
 end;

until(eof(ft));
closefile(ft);
end;

ScnQty:=0;

Scan4Cars();
Scan4Tracks();
Scan4Prof();
Form1.Show;
Form1.ShowHint:=true;
PageControl1Change(nil);
if Form3.Showing then Form3.Destroy;
end;

procedure TForm1.Scan4Cars();
begin
////////////////////////////////////////////////////////////////////////////////
//Scanning for add-on cars
////////////////////////////////////////////////////////////////////////////////
if not DirectoryExists('WR-EditCars') then begin
if Form3.Showing then Form3.Destroy;
MessageBox(0,
'Add-on cars folder "WR-EditCars" could not be found. Possible cause:'+#13+#10+
'  - Tool started not in MBWR folder'+#13+#10+
'  - No add-on cars installed'
,'MBWR Car Manager Error',mb_ok);
//SBSave.Enabled:=false;
exit;
end;
RootDir:=getcurrentdir;
ChDir('WR-EditCars');
FindFirst('*', faAnyFile or faDirectory, SearchRec);
id:=1;
repeat
if (SearchRec.Attr and faDirectory<>0)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..')
then  //Folder
if uppercase(SearchRec.Name)<>'BAK' then begin
Form3.Label1.Caption:=SearchRec.Name;
Form3.Label1.Repaint;
if not fileexists(SearchRec.Name+'\EditCar.car') then Err(1,SearchRec.Name) else begin //case insensitive
addon[id]:=SearchRec.Name;
location[id]:='std';
installed[id]:=true;
inc(id); end; end;
until (FindNext(SearchRec)<>0);
FindClose(SearchRec);
aqty:=id-1; //Folders found

ChDir(RootDir+'\WR-EditCars');
if not DirectoryExists('bak') then CreateDir('bak'); //Making if none
ChDir('bak');
FindFirst('*', faAnyFile or faDirectory, SearchRec);
repeat
if (SearchRec.Attr and faDirectory<>0)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then begin
Form3.Label1.Caption:=SearchRec.Name;
Form3.Label1.Repaint;
if not fileexists(SearchRec.Name+'\EditCar.car') then Err(1,SearchRec.Name) else begin //Folder
addon[id]:=SearchRec.Name;
location[id]:='bak';
installed[id]:=false;
incl:=false;
for i:=1 to id-1 do if addon[i]=addon[id] then incl:=true;
if not incl then inc(id) else Err(4,addon[id]);
end; end;
until (FindNext(SearchRec)<>0);
FindClose(SearchRec);
aqty:=id-1; //Folders found

for id:=1 to aqty do begin
//if id mod 2 =0 then begin
Form3.Shape1.Width:=round(321*(id/aqty));
Form3.Shape1.Repaint;
Form3.Label1.Caption:=addon[id];
Form3.Label1.Repaint;   
//end;
if installed[id] then s:=RootDir+'\WR-EditCars\'+addon[id]+'\EditCar.car'
             else s:=RootDir+'\WR-EditCars\bak\'+addon[id]+'\EditCar.car';
if fileexists(s) then ScanCAR(s);
end;
RefreshCarList();
end;

procedure TForm1.ScanCAR(carfile:string);
begin
AssignFile(f,carfile); FileMode:=0; reset(f,1); FileMode:=2; //read-only

blockread(f,c,33); s:='';
DSqty:=ord(c[9]);
for i:=1 to DSqty do begin
blockread(f,c,33);
TBqty:=ord(c[9])+ord(c[10])*256;
if c[10]=#1 then
s:=s;

j:=ord(c[30]);
if j<>0 then blockread(f,c,j+1);
DSname[i]:=StrPas(@c);

for k:=1 to TBqty do begin
if k=76 then
s:=s;
blockread(f,c,12);//28
COqty:=ord(c[9])+ord(c[10])*256;
if c[1]<>'N' then begin
j:=ord(c[5]);       //Cond
for m:=1 to j do begin
if m=1 then blockread(f,c,ord(c[9])+1);
if m>1 then begin blockread(f,c,4); blockread(f,c,ord(c[1])+1); end;
end;
blockread(f,c,12);//28
COqty:=ord(c[9])+ord(c[10])*256;
end;
blockread(f,c,16);
j:=ord(c[13]);
if j<>0 then begin blockread(f,c,j+1); TBname[k]:=StrPas(@c); end else TBname[k]:=''; //VAlb
blockread(f,c,13);
j:=ord(c[10]);
if j<>0 then blockread(f,c,j+1);                //VASM (file path)
blockread(f,c,8);
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1);               //DB name
blockread(f,c,8);
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1);               //SC...
blockread(f,c,8);
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1);               //IC...

for j:=1 to COqty do begin
blockread(f,c,5);
h:=ord(c[2])+ord(c[3])*256; s:='';
  if (c[1]=#16)and(h<>0) then begin
  blockread(f,c,h+1);
  for ii:=1 to h do s:=s+c[ii];
  end;
    if (DSname[i]='Edit_3DCarsDB')and(j=2)and(TBname[k]='ClassName') then
    modelname[id]:=s;
    if (DSname[i]='Edit_CarsDB')and(j=2)and(TBname[k]='CarName') then begin
    origcarname[id]:=s;
    carname[id]:=s;
    for ii:=1 to 32 do begin s2[ii]:=''; s3[ii]:=''; end;
s:=modelname[id];
if s<>'' then begin
   kk:=1; ii:=1;
   repeat
     repeat //Splitting to words
     s2[kk]:=s2[kk]+s[ii]; inc(ii);
     until((ii>length(s))or(s[ii]=#32));
   inc(kk); inc(ii);
   until(ii>length(s));
end;
s:=carname[id];
if s<>'' then begin
   kk:=1; ii:=1;
     repeat
       repeat //Splitting to words
       s3[kk]:=s3[kk]+s[ii]; inc(ii);
       until((ii>length(s))or(s[ii]=#32));
     inc(kk); inc(ii);
     until(ii>length(s));
end;
   kk:=1; s:=''; //Writing non-unique words as carname
   repeat ii:=1; incl:=true;
     repeat
     if s3[kk]=s2[ii] then incl:=false;
     inc(ii);
     until(s2[ii]='');
   if incl then s:=s+s3[kk]+' ';
   inc(kk);
   until(s3[kk]='');
   if s<>'' then if s[length(s)]=' ' then setlength(s,length(s)-1); //remove last #32
   carname[id]:=s;
   end;

   if (DSname[i]='Edit_CarsDB')and(j=2)and(TBname[k]='RaceClass') then begin
   rclass[id]:=h;
   closefile(f); exit; //SpeedUp
   end;
end;

end;
end; //1..DSqty
closefile(f);
end;

procedure TForm1.Scan4Prof();
begin
////////////////////////////////////////////////////////////////////////////////
//Scanning for profiles
////////////////////////////////////////////////////////////////////////////////
if RootDir<>'' then
ChDir(RootDir);
if not DirectoryExists('WR-SavesSinglePM') then begin
if Form3.Showing then Form3.Destroy;
MessageBox(0,
'Player profiles folder "WR-SavesSinglePM" could not be found. Possible cause:'+#13+#10+
'  - Tool started not in MBWR folder'+#13+#10+
'  - No profiles created'
,'MBWR Profile Manager Error',mb_ok);
//SBSave.Enabled:=false;
exit;
end;
ChDir('WR-SavesSinglePM');
FindFirst('*', faAnyFile or faDirectory, SearchRec);
id2:=1;
repeat
if (SearchRec.Attr and faDirectory<>0)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then  //Folder
if fileexists(RootDir+'\WR-SavesSinglePM\'+SearchRec.Name+'\Career.wrc') then begin
profile[id2]:=SearchRec.Name;
inc(id2); end;
until (FindNext(SearchRec)<>0);
FindClose(SearchRec);
pqty:=id2-1; //Folders found
for id2:=1 to pqty do CLBox2.Items.Add(profile[id2]);

for id:=1 to pqty do begin
id2:=1;
repeat
if uppercase(profile[id])=uppercase(cmprof[id2]) then CLBox2.Checked[id-1]:=true;
inc(id2);
until(cmprof[id2]='');
end;
end;

procedure TForm1.Scan4Tracks();
var ii:integer;
begin
if RootDir<>'' then
ChDir(RootDir);
////////////////////////////////////////////////////////////////////////////////
//Scanning for add-on scenario folders
////////////////////////////////////////////////////////////////////////////////
if not DirectoryExists('WR-EditTracks') then begin
if Form3.Showing then Form3.Destroy;
CLBox3.AddItem('No add-on tracks folder found. ("WR-EditTracks")',nil);
PageControl1.Pages[1].Enabled:=false;
exit;
end;
ChDir('WR-EditTracks');
FindFirst('*', faAnyFile or faDirectory, SearchRec);
h:=1;
repeat
if (SearchRec.Attr and faDirectory<>0)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then begin
if fileexists(RootDir+'\WR-EditTracks\'+SearchRec.Name+'\EditTrack.sci') then begin
scndir[h]:=SearchRec.Name;
inc(h); end; end;
until (FindNext(SearchRec)<>0);
FindClose(SearchRec);
//resort sceneries !
for i:=1 to h-1 do //all
for k:=i+1 to h-1 do  //all following after
if scndir[i]>scndir[k] then begin
s:=scndir[i]; scndir[i]:=scndir[k]; scndir[k]:=s;
end;

ScnQty:=0;
for ii:=1 to h-1 do
if fileexists(scndir[ii]+'\EditTrack.sci') then begin LoadInfos(nil,ii); inc(ScnQty); end;

if not DirectoryExists(RootDir+'\FrontEnd') then begin
if Form3.Showing then Form3.Destroy;
MessageBox(0,
'MBWR Data-base folder "FrontEnd" could not be found. Possible cause:'+#10+#13+
'  - Track Manager started not from MBWR folder'
,'MBWR Track Manager Error',mb_ok);
PageControl1.Pages[1].Enabled:=false;
exit;
end;
ChDir(RootDir+'\FrontEnd');

AssignFile(f,'WR.ds'); FileMode:=0; reset(f,1); FileMode:=2; //read-only
blockread(f,c,33); s:='';
DSqty:=ord(c[9]);
for i:=1 to DSqty do begin
blockread(f,c,33);
TBqty:=ord(c[9]);
j:=ord(c[30]);
if j<>0 then blockread(f,c,j+1); DSname[i]:='';
for m:=1 to j do DSname[i]:=DSname[i]+c[m];

for k:=1 to TBqty do begin
blockread(f,c,12);//28
COqty:=ord(c[9])+ord(c[10])*256;
if c[1]<>'N' then begin
j:=ord(c[5]);       //Cond
for m:=1 to j do begin
if m=1 then blockread(f,c,ord(c[9])+1);
if m>1 then begin blockread(f,c,4); blockread(f,c,ord(c[1])+1); end;
end;
blockread(f,c,12);//28
COqty:=ord(c[9])+ord(c[10])*256;
end;
blockread(f,c,16);
j:=ord(c[13]);
if j<>0 then blockread(f,c,j+1); TBname[k]:=''; //VAlb
for m:=1 to j do TBname[k]:=TBname[k]+c[m];
blockread(f,c,13);
j:=ord(c[10]);
if j<>0 then blockread(f,c,j+1);                //VASM (file path)
blockread(f,c,8);
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1);               //DB name
blockread(f,c,8);
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1);               //SC...
blockread(f,c,8);
j:=ord(c[5]);
if j<>0 then blockread(f,c,j+1);               //IC...

for j:=1 to COqty do begin
blockread(f,c,5);
h:=ord(c[2])+ord(c[3])*256; s:='';
  if (c[1]=#16)and(h<>0) then begin
  blockread(f,c,h+1);
  for ii:=1 to h do s:=s+c[ii];
  end;
    if (DSname[i]='SceneryDB')and(j>9)and(TBname[k]='EngineName') then
    //Check if installed and nothing more
    for ii:=1 to ScnQty do if uppercase(scnname[ii])=uppercase(s) then installed_S[ii]:=true;
//    closefile(f);
//    exit;
end;

end;
end; //1..DSqty
closefile(f);
RGDisplay2Click(nil);
end;

procedure TForm1.LoadInfos(Sender: TObject; IDX:integer);
var nodeqty,siz:integer;
begin
AssignFile(f,scndir[idx]+'\EditTrack.sci'); FileMode:=0; reset(f,1); FileMode:=2; //read-only
blockread(f,c,8); s:=c[1]+c[2]+c[3]+c[4]+c[5]+c[6]+c[7];
if s<>'WRTRKV1' then begin closefile(f); exit; end; //Not compatible format
blockread(f,c,4); nodeqty:=ord(c[4])+ord(c[3])*256;
for k:=1 to nodeqty do begin
blockread(f,c,12); siz:=ord(c[12])+ord(c[11])*256;  //Length of data
blockread(f,c,siz); // Data
case k of
1: ; //Index
2: begin scnname[IDX]:=''; for i:=1 to siz do scnname[IDX]:=scnname[IDX]+c[i]; end;
3: begin scnbg[IDX]:=''; for i:=1 to siz do scnbg[IDX]:=scnbg[IDX]+c[i]; end;
4: scnlast[IDX]:=int2(c[1],c[2]);
5: begin scningame[IDX]:=''; for i:=1 to siz do scningame[IDX]:=scningame[IDX]+c[i]; end;
6: begin scnol[IDX]:=''; for i:=1 to siz do scnol[IDX]:=scnol[IDX]+c[i]; end;
7: begin scnfl[IDX]:=''; for i:=1 to siz do scnfl[IDX]:=scnfl[IDX]+c[i]; end;
8: TrackQty[IDX]:=int2(c[1],c[2]);
9: begin scnld[IDX]:=''; for i:=1 to siz do scnld[IDX]:=scnld[IDX]+c[i]; end;
end;
end;
blockread(f,c,4); nodeqty:=ord(c[4])+ord(c[3])*256;
for k:=1 to nodeqty do begin
blockread(f,c,12);
siz:=ord(c[12])+ord(c[11])*256;
blockread(f,c,siz); m:=1;
case k of
1: ;
2: ;
3: ;
4: for i:=1 to TrackQty[IDX] do begin
        trkname[IDX,i]:='';
        repeat if m<=siz then trkname[IDX,i]:=trkname[IDX,i]+c[m];
        inc(m);
        until((c[m]=#0)or(m>siz)); inc(m); if trkname[IDX,i]='' then trkname[IDX,i]:=' '; end;
5: for i:=1 to TrackQty[IDX] do trkstage[IDX,i]:=ord(c[i]);
6: for i:=1 to TrackQty[IDX] do trkrel[IDX,i]:=ord(c[i]);
7: for i:=1 to TrackQty[IDX] do trkmark[IDX,i]:=ord(c[i]);
8: for i:=1 to TrackQty[IDX] do trkdriv[IDX,i]:=ord(c[i*2-1])+ord(c[i*2])*256;
9: ;
10:for i:=1 to TrackQty[IDX] do trklen[IDX,i]:=real2(c[i*4-3],c[i*4-2],c[i*4-1],c[i*4-0]);
11:;
12:for i:=1 to TrackQty[IDX] do trkchk[IDX,i]:=ord(c[i]);
13:for i:=1 to TrackQty[IDX] do begin
        trkimage[IDX,i]:='';
        repeat if m<=siz then trkimage[IDX,i]:=trkimage[IDX,i]+c[m];
        inc(m);
        until((c[m]=#0)or(m>siz)); inc(m); if trkimage[IDX,i]='' then trkimage[IDX,i]:=' '; end;
14:for i:=1 to TrackQty[IDX] do trksurf[IDX,i]:=ord(c[i]);
15:for i:=1 to TrackQty[IDX] do trkshape[IDX,i]:=ord(c[i]);
16:for i:=1 to TrackQty[IDX] do trkoffr[IDX,i]:=ord(c[i]);
17:;
18:;
19:;
20:;
21:;
22:;
23:;
end;
end;
blockread(f,c,4); nodeqty:=ord(c[4])+ord(c[3])*256;
for k:=1 to nodeqty do begin
blockread(f,c,12);
siz:=ord(c[12])+ord(c[11])*256;
blockread(f,c,siz); m:=1;
case k of
1: begin mauth[IDX]:=''; for i:=1 to siz do mauth[IDX]:=mauth[IDX]+c[i]; end;
2: begin mconv[IDX]:=''; for i:=1 to siz do mconv[IDX]:=mconv[IDX]+c[i]; end;
3: begin misc[IDX]:=''; for i:=1 to siz do misc[IDX]:=misc[IDX]+c[i]; end;
4: ;
end;
end;
closefile(f);
end;

procedure TForm1.RefreshCarList();
begin
CLBox1.Visible:=false; //Save time on redraw
CLBox1.Clear;
CLBox1.Sorted:=false; //Sort after
for id:=1 to aqty do begin
s:=inttostr(rclass[id]); for i:=2 downto length(s) do s:='0'+s;
case RGDisplay.ItemIndex of
0: s:=modelname[id]+' '+carname[id];
1: s:=s+'. '+modelname[id]+' '+carname[id];
2: s:=modelname[id]+' '+carname[id]+' ('+addon[id]+')';
3: s:=s+'. '+modelname[id]+' '+carname[id]+' ('+addon[id]+')';
4: s:=addon[id]+' ('+modelname[id]+' '+carname[id]+')';
5: s:=addon[id];
end;
CLBox1.Items.Add(s);
CLBox1.Checked[id-1]:=installed[id];
end;
CLBox1.Sorted:=CBSort.Checked; //Sort after
CLBox1.Visible:=true;
RefreshCarQty();
end;

procedure TForm1.RefreshCarQty();
begin
Checkedqty:=0;
for i:=1 to aqty do if installed[i] then inc(Checkedqty);
Label1.Caption:='Add-on Cars ('+inttostr(Checkedqty)+'/'+inttostr(aqty)+' Selected)';
if CheckedQty>30 then Label1.Font.Color:=160 else Label1.Font.Color:=0;
end;

procedure TForm1.RefreshScnQty();
begin
Checkedqty_S:=0;
for i:=1 to ScnQty do if installed_S[i] then inc(Checkedqty_S);
Label6.Caption:='Add-on Sceneries ('+inttostr(Checkedqty_S)+'/'+inttostr(ScnQty)+' Selected)';
//if CheckedQty>30 then Label1.Font.Color:=160 else Label1.Font.Color:=0;
end;


procedure TForm1.BAboutClick(Sender: TObject);
begin
AboutForm.Show('Version 0.5', 'Install and manage MBWR add-on cars and tracks.', 'MBWRMan');
{AboutForm.LTitle.Caption:='MBWR Manager by Krom';
AboutForm.LVersi.Caption:=;
AboutForm.LDescr.Caption:=;}
end;

procedure TForm1.AddFav1(Sender: TObject);
begin
CLBox1ClickCheck(nil); //apply cos list "slow"
with sender as TButton do
SendID:=strtoint(Name[6]);    //Bmemo*
Form2.Show;
Form2.GetSender(SendID);
end;

procedure TForm1.AddFav2(Sender: TObject);
begin
favqty[SendID]:=0;
for i:=1 to aqty do
  if installed[i] then begin
  inc(favqty[SendID]);
  fav[SendID,favqty[SendID]]:=addon[i];
  end;
end;

procedure TForm1.SetFav(Sender: TObject);
begin
with sender as TButton do SendID:=strtoint(name[8]);   //BChoose*
for i:=1 to aqty do installed[i]:=false;

for i:=1 to aqty do
for k:=1 to favqty[SendID] do
if uppercase(fav[SendID,k])=uppercase(addon[i]) then installed[i]:=true;

RefreshCarList(); //a bit slower but simplier
end;

procedure TForm1.CLBox1ClickCheck(Sender: TObject);
begin
for id:=1 to aqty do begin
s:=inttostr(rclass[id]); for i:=2 downto length(s) do s:='0'+s;
case RGDisplay.ItemIndex of
0: s:=modelname[id]+' '+carname[id];
1: s:=s+'. '+modelname[id]+' '+carname[id];
2: s:=modelname[id]+' '+carname[id]+' ('+addon[id]+')';
3: s:=s+'. '+modelname[id]+' '+carname[id]+' ('+addon[id]+')';
4: s:=addon[id]+' ('+modelname[id]+' '+carname[id]+')';
5: s:=addon[id];
end;
   k:=0;
   repeat inc(k);
   until((s=CLBox1.Items[k-1])or(k=aqty));
   if s=CLBox1.Items[k-1] then installed[id]:=CLBox1.Checked[k-1];

   if (CLBox1.ItemIndex>=0)and(CLBox1.Items[CLBox1.ItemIndex]=s) then begin
   Label3.Caption:=modelname[id];
   Label4.Caption:=origcarname[id];
   Label5.Caption:=addon[id];
   Label11.Caption:=inttostr(rclass[id]);
   end;
end;
RefreshCarQty();
end;

procedure TForm1.SBSaveClick(Sender: TObject);
var s1,s2:string;
begin
//Apply checkings again <- lists are "slow"
CLBox1ClickCheck(nil);
CLBox3ClickCheck(nil);

//Managing cars
for i:=1 to aqty do
if (installed[i])and(location[i]='bak') then begin
s1:=RootDir+'\WR-EditCars\bak\'+addon[i];
s2:=RootDir+'\WR-EditCars\'+addon[i];
if not RenameFile(s1,s2) then Err(2,addon[i]) else location[i]:='std';
end else
if (not installed[i])and(location[i]='std') then begin
s1:=RootDir+'\WR-EditCars\'+addon[i];
s2:=RootDir+'\WR-EditCars\bak\'+addon[i];
if not RenameFile(s1,s2) then Err(3,addon[i]) else location[i]:='bak';
end;

//Managing WR.ds/FrontEnd entries
SaveWRdsFrontEnd();

//Managing player profiles
Checkedqty:=0;
Checkedqty_S:=0;
for i:=1 to aqty do if installed[i] then inc(Checkedqty);
ReleasedCars:=checkedqty; //All checked are installed
for i:=1 to ScnQty do if installed_S[i] then begin
inc(ReleasedTracks,TrackQty[i]);
inc(Checkedqty_S,TrackQty[i]); //use different only here
end;

for id:=1 to pqty do if CLBox2.Checked[id-1] then begin
AssignFile(f,RootDir+'\WR-SavesSinglePM\'+profile[id]+'\Career.wrc');
FileMode:=0; reset(f,1); FileMode:=2;
AssignFile(g,RootDir+'\WR-SavesSinglePM\'+profile[id]+'\Career.new'); rewrite(g,1);

blockread(f,c,33);
blockwrite(g,c,33);
DSqty:=ord(c[9]);
for i:=1 to DSqty do begin
blockread(f,c,33);
blockwrite(g,c,33);
TBqty:=ord(c[9]);
j:=ord(c[30]);
if j<>0 then begin
blockread(f,c,j+1,NR);
blockwrite(g,c,NR); end;
DSname[i]:=''; for m:=1 to j do DSname[i]:=DSname[i]+c[m];

for k:=1 to TBqty do begin
blockread(f,c,12);//28
COqty:=ord(c[9])+ord(c[10])*256;
if DSName[i]='CarsDB' then begin c[9]:=chr(128+checkedqty); c[10]:=chr((128+checkedqty)div 256); end; //New  Qty
if DSName[i]='TracksDB' then begin c[9]:=chr(120+checkedqty_S); c[10]:=chr((120+checkedqty_S)div 256); end; //New  Qty
blockwrite(g,c,12);//28
if c[1]<>'N' then begin
  j:=ord(c[5]);       //Cond
  for m:=1 to j do begin
    if m=1 then begin blockread(f,c,ord(c[9])+1,NR); blockwrite(g,c,NR); end;
    if m>1 then begin blockread(f,c,4); blockwrite(g,c,4); blockread(f,c,ord(c[1])+1,NR); blockwrite(g,c,NR); end;
  end;
  blockread(f,c,12);//28
  blockwrite(g,c,12);//28
  COqty:=ord(c[9])+ord(c[10])*256;
end;
blockread(f,c,16);
blockwrite(g,c,16);
j:=ord(c[13]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //VAlb
blockread(f,c,13);
blockwrite(g,c,13);
j:=ord(c[10]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //VASM (file path)
blockread(f,c,8);
blockwrite(g,c,8);
j:=ord(c[5]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //DB name
blockread(f,c,8);
blockwrite(g,c,8);
j:=ord(c[5]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //SC...
blockread(f,c,8);
blockwrite(g,c,8);
j:=ord(c[5]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //IC...


for j:=1 to COqty do begin //Copy all original first //may vary !
 blockread(f,c,5);
 if (DSname[i]='CarsDB')and(k=1)and(c[2]=#1)and(j<=128) then inc(ReleasedCars);
 if (DSname[i]='TracksDB')and(k=1)and(c[2]=#1)and(j<=120) then inc(ReleasedTracks);
   h:=ord(c[2])+ord(c[3])*256; s:='';
   if (c[1]=#16)and(h<>0) then begin
   blockread(f,d,h+1);
   blockwrite(g,c,5);
   blockwrite(g,d,h+1);
   end else if ((DSname[i]='CarsDB')and(j>128))or((DSname[i]='TracksDB')and(j>120)) then else blockwrite(g,c,5);
end;

if DSname[i]='CarsDB' then
for j:=1 to checkedqty do
case k of
1: begin c[1]:=#1; c[2]:=#1; c[3]:=#0; c[4]:=#0; c[5]:=#0; blockwrite(g,c,5); end;//Released =1
2: begin c[1]:=#1; c[2]:=#0; c[3]:=#0; c[4]:=#0; c[5]:=#0; blockwrite(g,c,5); end;//Marked   =0
3: begin c[1]:=#1; c[2]:=#0; c[3]:=#0; c[4]:=#0; c[5]:=#0; blockwrite(g,c,5); end;//NoDrives =0
4: begin c[1]:=#2; c[2]:=#0; c[3]:=#0; c[4]:=#0; c[5]:=#0; blockwrite(g,c,5); end;//Distance =0
end;
if DSname[i]='TracksDB' then
for j:=1 to checkedqty_S do
case k of
1: begin c[1]:=#1; c[2]:=#1; c[3]:=#0; c[4]:=#0; c[5]:=#0; blockwrite(g,c,5); end;//Released =1
2: begin c[1]:=#1; c[2]:=#0; c[3]:=#0; c[4]:=#0; c[5]:=#0; blockwrite(g,c,5); end;//Marked   =0
3: begin c[1]:=#1; c[2]:=#0; c[3]:=#0; c[4]:=#0; c[5]:=#0; blockwrite(g,c,5); end;//NoDrives =0
end;

end;
end; //1..DSqty

closefile(f);
closefile(g);

s:=datetostr(date)+'_'+timetostr(time);
for i:=1 to length(s) do
if s[i]=':' then s[i]:='-';

s1:=RootDir+'\WR-SavesSinglePM\'+profile[id]+'\Career.wrc';
s2:=RootDir+'\WR-SavesSinglePM\'+profile[id]+'\Career'+s+'.bak';
if CBBup.Checked then RenameFile(s1,s2) else //else nothing happens :)
DeleteFile(s1);
s1:=RootDir+'\WR-SavesSinglePM\'+profile[id]+'\Career.new';
s2:=RootDir+'\WR-SavesSinglePM\'+profile[id]+'\Career.wrc';
RenameFile(s1,s2);
end;//1..CLBox2


for id:=1 to pqty do if CLBox2.Checked[id-1] then begin
AssignFile(f,RootDir+'\WR-SavesSinglePM\'+profile[id]+'\Profile.wrp');
FileMode:=0; reset(f,1); FileMode:=2;
AssignFile(g,RootDir+'\WR-SavesSinglePM\'+profile[id]+'\Profile.new'); rewrite(g,1);

blockread(f,c,33);
blockwrite(g,c,33);
DSqty:=ord(c[9]);
for i:=1 to DSqty do begin
blockread(f,c,33);
blockwrite(g,c,33);
TBqty:=ord(c[9]);
j:=ord(c[30]);
if j<>0 then begin
blockread(f,c,j+1,NR);
blockwrite(g,c,NR); end;
DSname[i]:=''; for m:=1 to j do DSname[i]:=DSname[i]+c[m];

for k:=1 to TBqty do begin
blockread(f,c,12);//28
COqty:=ord(c[9])+ord(c[10])*256;
blockwrite(g,c,12);//28
if c[1]<>'N' then begin
  j:=ord(c[5]);       //Cond
  for m:=1 to j do begin
    if m=1 then begin blockread(f,c,ord(c[9])+1,NR); blockwrite(g,c,NR); end;
    if m>1 then begin blockread(f,c,4); blockwrite(g,c,4); blockread(f,c,ord(c[1])+1,NR); blockwrite(g,c,NR); end;
  end;
  blockread(f,c,12);//28
  blockwrite(g,c,12);//28
  COqty:=ord(c[9])+ord(c[10])*256;
end;
blockread(f,c,16);
blockwrite(g,c,16);
j:=ord(c[13]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //VAlb
blockread(f,c,13);
blockwrite(g,c,13);
j:=ord(c[10]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //VASM (file path)
blockread(f,c,8);
blockwrite(g,c,8);
j:=ord(c[5]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //DB name
blockread(f,c,8);
blockwrite(g,c,8);
j:=ord(c[5]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //SC...
blockread(f,c,8);
blockwrite(g,c,8);
j:=ord(c[5]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //IC...

for j:=1 to COqty do begin //Copy all original first //may vary !
 blockread(f,c,5);
 if (DSName[i]='PlayerProfile')and(k=4) then
 case j of
 1: begin c[1]:=#1; c[2]:=#0; c[3]:=#0; c[4]:=#0; c[5]:=#0; end;
 2: begin c[1]:=#1; c[2]:=chr(ReleasedCars); c[3]:=chr(ReleasedCars div 256); c[4]:=#0; c[5]:=#0; end;
 3: begin c[1]:=#1; c[2]:=chr(ReleasedTracks); c[3]:=chr(ReleasedTracks div 256); c[4]:=#0; c[5]:=#0; end;
 end;

   h:=ord(c[2])+ord(c[3])*256; s:='';
   if (c[1]=#16)and(h<>0) then begin
   blockread(f,d,h+1);
   blockwrite(g,c,5);
   blockwrite(g,d,h+1);
   end else blockwrite(g,c,5);
end;

end;
end; //1..DSqty

closefile(f);
closefile(g);

s:=datetostr(date)+'_'+timetostr(time);
for i:=1 to length(s) do
if s[i]=':' then s[i]:='-';

s1:=RootDir+'\WR-SavesSinglePM\'+profile[id]+'\Profile.wrp';
s2:=RootDir+'\WR-SavesSinglePM\'+profile[id]+'\Profile'+s+'.bak';
if CBBup.Checked then RenameFile(s1,s2) else //else nothing happens :)
DeleteFile(s1);
s1:=RootDir+'\WR-SavesSinglePM\'+profile[id]+'\Profile.new';
s2:=RootDir+'\WR-SavesSinglePM\'+profile[id]+'\Profile.wrp';
RenameFile(s1,s2);
end;//1..CLBox2

SaveINIFile();
end;


procedure TForm1.SaveWRdsFrontEnd();
var ii:integer;
begin
ChDir(RootDir+'\FrontEnd'); //Make backups if none
if not FileExists('WR.orig') then CopyFile('WR.ds','WR.orig',true);
if not FileExists('runtime.orig') then CopyFile('runtime.fxp','runtime.orig',true);

CheckedQty_S:=0;
for ii:=1 to ScnQty do if installed_S[ii] then inc(CheckedQty_S);
AssignFile(ft,'runtime.orig'); FileMode:=0; reset(ft); FileMode:=2; //read-only
AssignFile(gt,RootDir+'\FrontEnd\runtime.fxp.fxp');
rewrite(gt);
repeat
readln(ft,s);
writeln(gt,s);
if eof(ft) then exit;
until((s='  Bitmap _p3')or(s='  Bitmap _p7')); //INT or DEF
for i:=1 to 4 do begin
readln(ft,s);
writeln(gt,s);
end;

for id:=1 to ScnQty do if installed_S[id] then begin
writeln(gt,'  Folder _00'+inttostr(id-1),zz,'  {',zz,'  }',zz);
s:=''; for ii:=1 to length(scnbg[id]) do if scnbg[id][ii]='\' then s:=s+'\\' else s:=s+scnbg[id][ii];
writeln(gt,'  Bitmap _00'+inttostr(id-1)+'bg',zz,'  {',zz,
           '    Pfad( ".\\',s,'" );',zz,'  }',zz);
s:=''; for ii:=1 to length(scnol[id]) do if scnol[id][ii]='\' then s:=s+'\\' else s:=s+scnol[id][ii];
writeln(gt,'  Bitmap _00'+inttostr(id-1)+'ol',zz,'  {',zz,
           '    Pfad( ".\\',s,'" );',zz,'  }',zz);
s:=''; for ii:=1 to length(scnfl[id]) do if scnfl[id][ii]='\' then s:=s+'\\' else s:=s+scnfl[id][ii];
writeln(gt,'  Bitmap _00'+inttostr(id-1)+'fl',zz,'  {',zz,
           '    Pfad( ".\\',s,'" );',zz,'  }',zz);
s:=''; for ii:=1 to length(scnld[id]) do if scnld[id][ii]='\' then s:=s+'\\' else s:=s+scnld[id][ii];
writeln(gt,'  Bitmap _00'+inttostr(id-1)+'ld',zz,'  {',zz,
           '    Pfad( ".\\',s,'" );',zz,'  }',zz);
  for id2:=1 to TrackQty[id] do begin
  s:=''; for ii:=1 to length(trkimage[id,id2]) do
  if trkimage[id,id2][ii]='\' then s:=s+'\\' else s:=s+trkimage[id,id2][ii];
  writeln(gt,'  Bitmap _00'+inttostr(id-1)+'tk'+inttostr(id2),zz,
  '  {',zz,'    Pfad( ".\\',s,'" );',zz,'  }',zz);
end;
end;

repeat
readln(ft,s); //skipping old entries
if eof(ft) then exit;
until((s='  Folder _Cg')or(s='  Folder _Cc')or(s='  Folder _zF')); //INT or DEF
writeln(gt,s);

repeat
readln(ft,s);
writeln(gt,s);
until(eof(ft));

closefile(ft);
closefile(gt);

AssignFile(f,'WR.orig'); FileMode:=0; reset(f,1); FileMode:=2; //read-only
AssignFile(g,'WR.ds.ds'); rewrite(g,1);
blockread(f,c,33);
blockwrite(g,c,33);
DSqty:=ord(c[9]);
for i:=1 to DSqty do begin
blockread(f,c,33);
blockwrite(g,c,33);
TBqty:=ord(c[9]);
j:=ord(c[30]);
if j<>0 then begin
blockread(f,c,j+1,NR);
blockwrite(g,c,NR); end;
DSname[i]:=''; for m:=1 to j do DSname[i]:=DSname[i]+c[m];

for k:=1 to TBqty do begin
blockread(f,c,12);//28
COqty:=ord(c[9])+ord(c[10])*256;
if DSName[i]='SceneryDB' then c[9]:=chr(9+CheckedQty_S); //New Scenery Qty
if DSName[i]='TracksDB' then begin c[9]:=#120; //Original Qty
for id:=1 to ScnQty do if installed_S[id] then begin
c[9]:=chr(ord(c[9])+TrackQty[id]);                           //Summirizing new Qty
end; end;
blockwrite(g,c,12);//28
if c[1]<>'N' then begin
  j:=ord(c[5]);       //Cond
  for m:=1 to j do begin
    if m=1 then begin blockread(f,c,ord(c[9])+1,NR); blockwrite(g,c,NR); end;
    if m>1 then begin blockread(f,c,4); blockwrite(g,c,4); blockread(f,c,ord(c[1])+1,NR); blockwrite(g,c,NR); end;
  end;
  blockread(f,c,12);//28
  blockwrite(g,c,12);//28
  COqty:=ord(c[9])+ord(c[10])*256;
end;
blockread(f,c,16);
blockwrite(g,c,16);
j:=ord(c[13]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //VAlb
//for m:=1 to j do s:=s+c[m];
//writeln(fo,'Title - '+s); TBname[k]:=s;    s:='';
blockread(f,c,13);
blockwrite(g,c,13);
j:=ord(c[10]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //VASM (file path)
//for m:=1 to j do s:=s+c[m];
//writeln(fo,'DB path - '+s); s:='';
blockread(f,c,8);
blockwrite(g,c,8);
j:=ord(c[5]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //DB name
//for m:=1 to j do s:=s+c[m];
//writeln(fo,'DB name - '+s); s:='';
blockread(f,c,8);
blockwrite(g,c,8);
j:=ord(c[5]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //SC...
//for m:=1 to j do s:=s+c[m];
//writeln(fo,'... - '+s); s:='';
blockread(f,c,8);
blockwrite(g,c,8);
j:=ord(c[5]);
if j<>0 then begin blockread(f,c,j+1); blockwrite(g,c,j+1); end;      //IC...
//for m:=1 to j do s:=s+c[m];
//writeln(fo,'... - '+s); s:='';

if DSName[i]='SceneryDB' then ii:=9 else
if DSName[i]='TracksDB' then ii:=120 else
ii:=COqty;

for j:=1 to ii do begin //Copy all original first
 blockread(f,c,5);
 h:=ord(c[2])+ord(c[3])*256; s:='';
   if (c[1]=#16)and(h<>0) then begin
   blockread(f,d,h+1);
     if (DSName[i]='Texte')and(j=1008)and(k>1)and(CheckedQty_S<>0) then begin
     s:=#13+#10+inttostr(CheckedQty_S)+' additionally installed sceneries found.';
     for l:=h+1 to h+length(s) do
     d[l]:=s[l-h];
     d[l]:=#0;
     inc(h,length(s));
     c[2]:=chr(h);
     c[3]:=chr(h div 256);
     end;
   blockwrite(g,c,5);
   blockwrite(g,d,h+1);
   end else
 blockwrite(g,c,5);
end;

for j:=ii+1 to COqty do begin //Copy all original first
blockread(f,c,5); h:=ord(c[2])+ord(c[3])*256;
if (c[1]=#16)and(h<>0) then blockread(f,c,h+1);
end;

if DSname[i]='SceneryDB' then begin
m:=120-1; l:=0;
for id:=1 to ScnQty do if installed_S[id] then begin //Finding Scenario ID
m:=m+TrackQty[id]; inc(l);
case k of
1: begin c[1]:=#1; c[2]:=chr(l+9-1); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
2: begin c[1]:=#16; c[2]:=chr(length(scnname[id])); c[3]:=#0; c[4]:=#0; c[5]:=#0;
         for ii:=1 to length(scnname[id]) do c[5+ii]:=scnname[id][ii]; c[5+ii]:=#0;
         blockwrite(g,c,5+length(scnname[id])+1); end;
3: begin s:='_00'+inttostr(id-1)+'bg';
         c[1]:=#16; c[2]:=chr(length(s)); c[3]:=#0; c[4]:=#0; c[5]:=#0;
         for ii:=1 to length(s) do c[5+ii]:=s[ii]; c[5+ii]:=#0;
         blockwrite(g,c,5+length(s)+1); end;
4: begin c[1]:=#1; c[2]:=chr(scnlast[id]); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
5: begin c[1]:=#16; c[2]:=chr(length(scningame[id])); c[3]:=#0; c[4]:=#0; c[5]:=#0;
         for ii:=1 to length(scningame[id]) do c[5+ii]:=scningame[id][ii]; c[5+ii]:=#0;
         blockwrite(g,c,5+length(scningame[id])+1); end;
6: begin s:='_00'+inttostr(id-1)+'ol';
         c[1]:=#16; c[2]:=chr(length(s)); c[3]:=#0; c[4]:=#0; c[5]:=#0;
         for ii:=1 to length(s) do c[5+ii]:=s[ii]; c[5+ii]:=#0;
         blockwrite(g,c,5+length(s)+1); end;
7: begin s:='_00'+inttostr(id-1)+'fl';
         c[1]:=#16; c[2]:=chr(length(s)); c[3]:=#0; c[4]:=#0; c[5]:=#0;
         for ii:=1 to length(s) do c[5+ii]:=s[ii]; c[5+ii]:=#0;
         blockwrite(g,c,5+length(s)+1); end;
8: begin c[1]:=#1; c[2]:=chr(m); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
9: begin s:='_00'+inttostr(id-1)+'ld';
         c[1]:=#16; c[2]:=chr(length(s)); c[3]:=#0; c[4]:=#0; c[5]:=#0;
         for ii:=1 to length(s) do c[5+ii]:=s[ii]; c[5+ii]:=#0;
         blockwrite(g,c,5+length(s)+1);
         end;
end;
end; //if SceneryDB
end; //1..ListBox2.Items.Count

l:=0;
if DSname[i]='TracksDB' then
for id:=1 to ScnQty do if installed_S[id] then begin //Finding Scenario ID
nodeqty:=1; for ii:=1 to id-1{not +1!} do if installed_S[ii] then nodeqty:=nodeqty+TrackQty[ii];
inc(l);
for id2:=1 to TrackQty[id] do
case k of
1: begin c[1]:=#1; c[2]:=chr(nodeqty+id2+120-2); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
2: begin c[1]:=#1; c[2]:=chr(l+9-1); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
3: begin c[1]:=#1; c[2]:=chr(id2-1); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
4: begin c[1]:=#16; c[2]:=chr(length(trkname[id,id2])); c[3]:=#0; c[4]:=#0; c[5]:=#0;
         for ii:=1 to length(trkname[id,id2]) do c[5+ii]:=trkname[id,id2][ii]; c[5+ii]:=#0;
         blockwrite(g,c,5+length(trkname[id,id2])+1); end;
5: begin c[1]:=#1; c[2]:=chr(trkstage[id,id2]); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
6: begin c[1]:=#1; c[2]:=chr(trkrel[id,id2]); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
7: begin c[1]:=#1; c[2]:=chr(trkmark[id,id2]); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
8: begin c[1]:=#1; c[2]:=chr(trkdriv[id,id2]); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
9: begin c[1]:=#1; c[2]:=chr(nodeqty+id2+119-2); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
10:begin c[1]:=#2; c[2]:=unreal2(trklen[id,id2])[1]; c[3]:=unreal2(trklen[id,id2])[2];
                   c[4]:=unreal2(trklen[id,id2])[3]; c[5]:=unreal2(trklen[id,id2])[4];  blockwrite(g,c,5); end;
11:begin c[1]:=#1; c[2]:=chr(round(trklen[id,id2])); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
12:begin c[1]:=#1; c[2]:=chr(trkchk[id,id2]); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
13:begin s:='_00'+inttostr(id-1)+'tk'+inttostr(id2);
         c[1]:=#16; c[2]:=chr(length(s)); c[3]:=#0; c[4]:=#0; c[5]:=#0;
         for ii:=1 to length(s) do c[5+ii]:=s[ii]; c[5+ii]:=#0;
         blockwrite(g,c,5+length(s)+1); end;
14:begin c[1]:=#1; c[2]:=chr(trksurf[id,id2]); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
15:begin c[1]:=#1; c[2]:=chr(trkshape[id,id2]); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
16:begin c[1]:=#1; c[2]:=chr(trkoffr[id,id2]); c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
17:begin c[1]:=#1; c[2]:=#0; c[3]:=#0; c[4]:=#0; c[5]:=#0;  blockwrite(g,c,5); end;
18:begin s:='--:--.--'; c[1]:=#16; c[2]:=#8; c[3]:=#0; c[4]:=#0; c[5]:=#0;
         for ii:=1 to 8 do c[5+ii]:=s[ii]; c[5+ii]:=#0; blockwrite(g,c,14); end;
19:begin s:='---'; c[1]:=#16; c[2]:=#3; c[3]:=#0; c[4]:=#0; c[5]:=#0;
         for ii:=1 to 3 do c[5+ii]:=s[ii]; c[5+ii]:=#0; blockwrite(g,c,9); end;
20:begin s:='---'; c[1]:=#16; c[2]:=#3; c[3]:=#0; c[4]:=#0; c[5]:=#0;
         for ii:=1 to 3 do c[5+ii]:=s[ii]; c[5+ii]:=#0; blockwrite(g,c,9); end;
21:begin s:='--'; c[1]:=#16; c[2]:=#2; c[3]:=#0; c[4]:=#0; c[5]:=#0;
         for ii:=1 to 2 do c[5+ii]:=s[ii]; c[5+ii]:=#0; blockwrite(g,c,8); end;
22:begin s:='--'; c[1]:=#16; c[2]:=#2; c[3]:=#0; c[4]:=#0; c[5]:=#0;
         for ii:=1 to 2 do c[5+ii]:=s[ii]; c[5+ii]:=#0; blockwrite(g,c,8); end;
23:begin s:='----'; c[1]:=#16; c[2]:=#4; c[3]:=#0; c[4]:=#0; c[5]:=#0;
         for ii:=1 to 4 do c[5+ii]:=s[ii]; c[5+ii]:=#0; blockwrite(g,c,10); end;
end; //1..ListBox2.Items.Count
end;
end;
end; //1..DSqty
closefile(f);
closefile(g);

Deletefile('runtime.fxp');
Deletefile('WR.ds');
Renamefile('runtime.fxp.fxp','runtime.fxp');
Renamefile('WR.ds.ds','WR.ds');

end;



procedure TForm1.SaveINIFile();
begin
ChDir(RootDir);
AssignFile(ft,'carman.ini'); rewrite(ft);
writeln(ft,'//CarManOptions');
writeln(ft,'[Options]');
if Form1.WindowState<>wsMaximized then writeln(ft,'Width=',inttostr(fw))
else writeln(ft,'Width=',inttostr(620)); //if non-full, set to default
if Form1.WindowState<>wsMaximized then writeln(ft,'Height=',inttostr(fh))
else writeln(ft,'Height=',inttostr(450));
write(ft,'FullScreen=');
if Form1.WindowState=wsMaximized then writeln(ft,'1') else writeln(ft,'0');
write(ft,'DisplayFormat=');
writeln(ft,inttostr(RGDisplay.ItemIndex));
write(ft,'DisplayFormat2=');
writeln(ft,inttostr(RGDisplay2.ItemIndex));
write(ft,'SortList=');
if CBSort.Checked then writeln(ft,'1') else writeln(ft,'0');
write(ft,'SortList2=');
if CBSort2.Checked then writeln(ft,'1') else writeln(ft,'0');
write(ft,'MakeBackups=');
if CBBup.Checked then writeln(ft,'1') else writeln(ft,'0');
writeln(ft,'');
writeln(ft,'//Profiles to alert by CarMan');
writeln(ft,'[Profiles]');
for i:=1 to pqty do if CLBox2.Checked[i-1] then writeln(ft,CLBox2.Items[i-1]);
writeln(ft,'');
writeln(ft,'//Favourite Sets 1-4');
for i:=1 to 5 do begin
writeln(ft,'[Set'+inttostr(i)+']');
case i of
1: writeln(ft,'Name='+BChoose1.Caption);
2: writeln(ft,'Name='+BChoose2.Caption);
3: writeln(ft,'Name='+BChoose3.Caption);
4: writeln(ft,'Name='+BChoose4.Caption);
5: writeln(ft,'Name='+BChoose5.Caption);
end;
  for k:=1 to favqty[i] do writeln(ft,fav[i,k]);
writeln(ft,'');
end;
closefile(ft);
end;

procedure TForm1.CBSortClick(Sender: TObject);
begin
RefreshCarList();
end;

procedure TForm1.AllorNone(Sender: TObject);
begin
if sender=BAll then if PageControl1.TabIndex=0 then
for i:=1 to aqty do begin
installed[i]:=true; CLBox1.Checked[i-1]:=true;
end else //PageControl1.TabIndex=1
for i:=1 to ScnQty do begin
installed_S[i]:=true; CLBox3.Checked[i-1]:=true;
end;
if sender=BNone then if PageControl1.TabIndex=0 then
for i:=1 to aqty do begin
installed[i]:=false; CLBox1.Checked[i-1]:=false;
end else //PageControl1.TabIndex=1
for i:=1 to ScnQty do begin
installed_S[i]:=false; CLBox3.Checked[i-1]:=false;
end;
RefreshCarQty();
RefreshScnQty();
end;

procedure TForm1.FormResize(Sender: TObject);
begin
if Form1.Width<=620 then Form1.Width:=620;  //MinSize
if Form1.Height<=450 then Form1.Height:=450;//MinSize
PageControl1.Width:=Form1.Width-(620-476);
PageControl1.Height:=Form1.Height-(450-423);
CLBox1.Width:=PageControl1.Width-(476-313); //alert size
CLBox1.Height:=PageControl1.Height-(423-377);
CLBox3.Width:=PageControl1.Width-(476-313); //alert size
CLBox3.Height:=PageControl1.Height-(423-377);
if CLBox1.Width<=500 then CLBox1.Columns:=0 else //not maximized
CLBox1.Columns:=CLBox1.Width div 250;
if CLBox3.Width<=400 then CLBox3.Columns:=0 else //not maximized
CLBox3.Columns:=CLBox3.Width div 200;
fw:=Form1.Width;
fh:=Form1.Height;
end;

procedure TForm1.CLBox1DblClick(Sender: TObject);
Var St: array [0..512] of char;
begin
//Made to allow editing .car by double click, nothing more !
id:=0;
repeat //finding right car
inc(id);
  s:=inttostr(rclass[id]); for i:=2 downto length(s) do s:='0'+s;
  case RGDisplay.ItemIndex of
  0: s:=modelname[id]+' '+carname[id];
  1: s:=s+'. '+modelname[id]+' '+carname[id];
  2: s:=modelname[id]+' '+carname[id]+' ('+addon[id]+')';
  3: s:=s+'. '+modelname[id]+' '+carname[id]+' ('+addon[id]+')';
  4: s:=addon[id]+' ('+modelname[id]+' '+carname[id]+')';
  5: s:=addon[id];
  end;
until((s=CLBox1.Items[CLBox1.ItemIndex])or(id=aqty));
if s=CLBox1.Items[CLBox1.ItemIndex] then
if location[id]='std' then s:='\WR-EditCars\'+addon[id]+'\EditCar.car' else
if location[id]='bak' then s:='\WR-EditCars\bak\'+addon[id]+'\EditCar.car';
k:=ShellExecute(handle, 'open', StrPCopy(St,'"'+RootDir+s+'"'), nil, nil, SW_SHOW);
end;

procedure TForm1.Revert(Sender: TObject);
begin
for id:=1 to aqty do begin
s:=inttostr(rclass[id]); for i:=2 downto length(s) do s:='0'+s;
case RGDisplay.ItemIndex of
0: s:=modelname[id]+' '+carname[id];
1: s:=s+'. '+modelname[id]+' '+carname[id];
2: s:=modelname[id]+' '+carname[id]+' ('+addon[id]+')';
3: s:=s+'. '+modelname[id]+' '+carname[id]+' ('+addon[id]+')';
4: s:=addon[id]+' ('+modelname[id]+' '+carname[id]+')';
5: s:=addon[id];
end;
   k:=0;
   repeat inc(k);
   until((s=CLBox1.Items[k-1])or(k=aqty));
   if s=CLBox1.Items[k-1] then
     if location[id]='bak' then begin installed[k]:=false; CLBox1.Checked[k-1]:=false;
     end else if location[id]='std' then begin
     installed[k]:=true; CLBox1.Checked[k-1]:=true; end;

end;
RefreshCarQty();
end;

procedure TForm1.SB_MBWRClick(Sender: TObject);
begin
SBSave.Click();
Form1.Close;
ChDir(RootDir);
ShellExecute(handle, 'open', 'WR_Starter.exe', NiL, Nil, SW_SHOWNORMAL);
end;

procedure TForm1.SB_MBWRMPClick(Sender: TObject);
begin
SBSave.Click();
Form1.Close;
ChDir(RootDir);
ShellExecute(handle, 'open', 'WR_Multiplayer_Lounge.exe', NiL, Nil, SW_SHOWNORMAL);
end;

procedure TForm1.GetTrackInfo(Sender: TObject);
begin
if (CLBox3.ItemIndex=-1)or(LBox1.ItemIndex=-1) then exit;

for i:=1 to ScnQty do begin
  case RGDisplay2.ItemIndex of
  0: s:=scningame[i];
  1: s:=scningame[i]+' ('+scnname[i]+')';
  end;
if s=CLBox3.Items[CLBox3.ItemIndex] then id:=i;
end;

id2:=LBox1.ItemIndex+1;
Label15.Caption:='Length: '+floattostr(round(trklen[id,id2]*10)/10)+' km';
if trkstage[id,id2]=1 then CheckBox2.Checked:=true else CheckBox2.Checked:=false;
if trkchk[id,id2]=1 then CheckBox3.Checked:=true else CheckBox3.Checked:=false;
if trkoffr[id,id2]=1 then CheckBox4.Checked:=true else CheckBox4.Checked:=false;
Label18.Caption:='Pavement: '+Strasse[trksurf[id,id2]];
Label19.Caption:='Terrain: '+Gelaende[trkshape[id,id2]];
end;

procedure TForm1.RGDisplay2Click(Sender: TObject);
begin
CLBox3.Visible:=false; //Save time on redraw
CLBox3.Clear;
CLBox3.Sorted:=false; //Sort after
for id:=1 to ScnQty do begin
case RGDisplay2.ItemIndex of
0: CLBox3.AddItem(scningame[id],nil);
1: CLBox3.AddItem(scningame[id]+' ('+scnname[id]+')',nil);
end;
CLBox3.Checked[id-1]:=installed_S[id];
end;
CLBox3.Sorted:=CBSort2.Checked; //Sort after
CLBox3.Visible:=true;
CLBox3ClickCheck(nil);
end;

procedure TForm1.CLBox3ClickCheck(Sender: TObject);
begin
for id:=1 to ScnQty do begin
case RGDisplay2.ItemIndex of
0: s:=scningame[id];
1: s:=scningame[id]+' ('+scnname[id]+')';
end;
   k:=0;
   repeat inc(k);
   until((s=CLBox3.Items[k-1])or(k=ScnQty));
   if s=CLBox3.Items[k-1] then installed_S[id]:=CLBox3.Checked[k-1];

  if (CLBox3.ItemIndex>=0)and(CLBox3.Items[CLBox3.ItemIndex]=s) then begin
  Label16.Caption:='Author: '+mauth[id];
  Label17.Caption:='Converter: '+mconv[id];
  LBox1.Clear;
  for i:=1 to TrackQty[id] do LBox1.Items.Add(trkname[id,i]);
  LBox1.ItemIndex:=0;
  end;
end;

Checkedqty_S:=0;
for i:=1 to ScnQty do if installed_S[i] then inc(Checkedqty_S);
Label6.Caption:='Add-on Sceneries ('+inttostr(Checkedqty_S)+'/'+inttostr(ScnQty)+' Selected)';
GetTrackInfo(nil);
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
if PageControl1.TabIndex=0 then begin
BRevert.Enabled:=true;
BChoose1.Enabled:=true;
BChoose2.Enabled:=true;
BChoose3.Enabled:=true;
BChoose4.Enabled:=true;
BChoose5.Enabled:=true;
Bmemo1.Enabled:=true;
Bmemo2.Enabled:=true;
Bmemo3.Enabled:=true;
Bmemo4.Enabled:=true;
Bmemo5.Enabled:=true;
end else begin
BRevert.Enabled:=false;
BChoose1.Enabled:=false;
BChoose2.Enabled:=false;
BChoose3.Enabled:=false;
BChoose4.Enabled:=false;
BChoose5.Enabled:=false;
Bmemo1.Enabled:=false;
Bmemo2.Enabled:=false;
Bmemo3.Enabled:=false;
Bmemo4.Enabled:=false;
Bmemo5.Enabled:=false;
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if CLBox3.ItemIndex=-1 then exit;
Form4.Show;
Form4.Memo1.Clear;
for id:=1 to ScnQty do begin
  case RGDisplay2.ItemIndex of
  0: s:=scningame[id];
  1: s:=scningame[id]+' ('+scnname[id]+')';
  end;
if s=CLBox3.Items[CLBox3.ItemIndex] then begin
Form4.Memo1.Lines.Add(misc[id]); exit; end;
end;
end;                                      

procedure TForm1.Button1Click(Sender: TObject);
begin
ChDir(RootDir);
ShellExecute(handle, 'open', 'WR_Setup.exe', NiL, Nil, SW_SHOWNORMAL);
end;

end.
