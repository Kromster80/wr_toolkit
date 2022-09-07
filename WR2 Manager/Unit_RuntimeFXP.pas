unit Unit_RuntimeFXP;
interface
uses
  Unit1, KromUtils, FileCtrl, SysUtils, Windows;

  procedure ReadRuntimeFXP(Sender: TObject);
  procedure SaveRuntimeFXP(Sender: TObject);
  procedure MakeRuntimeFXPEntries(Sender: TObject);

implementation

procedure ReadRuntimeFXP(Sender: TObject);
const BaseLength = 20542; //20542- is default for WR2
var i:integer; ft:textfile;
begin
  chdir(RootDir);
  assignfile(ft,'FrontEnd\Runtime.fxp'); reset(ft);
  setlength(Runtime, BaseLength); 
  i:=0;
  repeat
    inc(i);
    if i >= length(Runtime) then
      setlength(Runtime, length(Runtime) + 200);
    readln(ft,Runtime[i]);
  until(eof(ft));
  closefile(ft);
  RuntimeQty:=i;
end;


procedure SaveRuntimeFXP(Sender: TObject);
var
  ir,iw,k,h:integer;
  s:string;
  ft:textfile;
  Entry:record
    Line:integer;
    AddID:integer;
  end;
begin
  chdir(RootDir);
  assignfile(ft,'FrontEnd\Runtime.fxp'); rewrite(ft);
  ir:=0;
  iw:=0;
  repeat
    inc(ir);
    inc(iw);

    s:=Runtime[ir];
    if (length(s)>3)and(s[1]+s[2]+s[3]='//~') then begin
      repeat
        inc(ir);
        s:=Runtime[ir];
      until((length(s)>3)and(s[1]+s[2]+s[3]='//~'));
      inc(ir);
    end;

    for k:=1 to AddQty do
    if Runtime[ir]=AddRuntime[k].LandMark then begin
      Entry.Line:=iw+AddRuntime[k].Offset;
      Entry.AddID:=k;
    end;

    if iw=Entry.Line then begin
      writeln(ft,'//~'+AddRuntime[Entry.AddID].Title);
      for h:=1 to AddRuntime[Entry.AddID].Length do
        writeln(ft,AddRuntime[Entry.AddID].Lines[h]);
      writeln(ft,'//~'+AddRuntime[Entry.AddID].Title);
    end;

    writeln(ft,Runtime[ir]);
  until(ir=RuntimeQty);
  
  closefile(ft);
end;


procedure MakeRuntimeFXPEntries(Sender: TObject);
var i,k,h,m:integer; t: array [1..10]of integer;
begin
  AddQty:=0;

  //Append driven KM info into Players page
  if Form1.R_WriteKM.Checked then begin
    inc(AddQty);
    AddRuntime[AddQty].Title:='DrivenKM';
    AddRuntime[AddQty].Mode:='Add';
    AddRuntime[AddQty].LandMark:='  Text _iu';
    AddRuntime[AddQty].Offset:=14;
    AddRuntime[AddQty].Length:=28;
    AddRuntime[AddQty].Lines[ 1]:='Text _krDrvTx';
    AddRuntime[AddQty].Lines[ 2]:='{';
    AddRuntime[AddQty].Lines[ 3]:='Position( 190, 392, 0 );';
    AddRuntime[AddQty].Lines[ 4]:='Farbe( 128, 128, 128 );';
    AddRuntime[AddQty].Lines[ 5]:='Schatten( true );';
    AddRuntime[AddQty].Lines[ 6]:='SchattenOffset( 2, 3, 0 );';
    AddRuntime[AddQty].Lines[ 7]:='SchattenAlpha( 160 );';
    AddRuntime[AddQty].Lines[ 8]:='Groesse( 90, 24, 0 );';
    AddRuntime[AddQty].Lines[ 9]:='UID( 0:1:161 );';
    AddRuntime[AddQty].Lines[10]:='String( "Driven" );';
    AddRuntime[AddQty].Lines[11]:='Font( _AQ );';
    AddRuntime[AddQty].Lines[12]:='HAlign( 2 );';
    AddRuntime[AddQty].Lines[13]:='VAlign( 1 );';
    AddRuntime[AddQty].Lines[14]:='}';
    AddRuntime[AddQty].Lines[15]:='';
    AddRuntime[AddQty].Lines[16]:='Text _krDrvKM';
    AddRuntime[AddQty].Lines[17]:='{';
    AddRuntime[AddQty].Lines[18]:='Position( 310, 392, 0 );';
    AddRuntime[AddQty].Lines[19]:='Farbe( 128, 128, 128 );';
    AddRuntime[AddQty].Lines[20]:='Schatten( true );';
    AddRuntime[AddQty].Lines[21]:='SchattenOffset( 2, 3, 0 );';
    AddRuntime[AddQty].Lines[22]:='SchattenAlpha( 160 );';
    AddRuntime[AddQty].Lines[23]:='Groesse( 140, 24, 0 );';
    AddRuntime[AddQty].Lines[24]:='UID( 11:3:1 );';
    AddRuntime[AddQty].Lines[25]:='String( "Driven Km" );';
    AddRuntime[AddQty].Lines[26]:='Font( _AQ );';
    AddRuntime[AddQty].Lines[27]:='VAlign( 1 );';
    AddRuntime[AddQty].Lines[28]:='}';
    inc(AddQty);
    AddRuntime[AddQty].Title:='DrivenKM';
    AddRuntime[AddQty].Mode:='Add';
    AddRuntime[AddQty].LandMark:='    :_iu';
    AddRuntime[AddQty].Offset:=1;
    AddRuntime[AddQty].Length:=2;
    AddRuntime[AddQty].Lines[ 1]:=':_krDrvTx';
    AddRuntime[AddQty].Lines[ 2]:=':_krDrvKM';
  end;

  //Append advanced stats for Player
  if Form1.R_Stats.Checked then begin
    inc(AddQty);
    AddRuntime[AddQty].Title:='AdvancedStats1';
    AddRuntime[AddQty].Mode:='Add';
    AddRuntime[AddQty].LandMark:='  Text _oS';
    AddRuntime[AddQty].Offset:=25;
    AddRuntime[AddQty].Length:=31*10;

    t[1]:=172;
    t[2]:=172;
    t[3]:=110; //3 - Ranking
    t[4]:=172;
    t[5]:=112; //5 - Performance
    t[6]:=176; //6 - Best Lap
    t[7]:=126; //7 - Drift points
    t[8]:=531; //8 - Overtaking
    t[9]:=172;
    t[10]:=172;

    for k:=1 to 10 do begin
      m:=(k-1)*31;
      AddRuntime[AddQty].Lines[m+ 1]:='Text _krStat'+inttostr(k)+'t';
      AddRuntime[AddQty].Lines[m+ 2]:='{';
      AddRuntime[AddQty].Lines[m+ 3]:='Position( 350, '+inttostr(160+k*24)+', 0 );';
      AddRuntime[AddQty].Lines[m+ 4]:='Farbe( 128, 128, 128 );';
      AddRuntime[AddQty].Lines[m+ 5]:='Schatten( true );';
      AddRuntime[AddQty].Lines[m+ 6]:='SchattenOffset( 2, 3, 0 );';
      AddRuntime[AddQty].Lines[m+ 7]:='SchattenAlpha( 160 );';
      AddRuntime[AddQty].Lines[m+ 8]:='Groesse( 90, 24, 0 );';
      AddRuntime[AddQty].Lines[m+ 9]:='UID( 0:1:'+inttostr(t[k])+' );';
      AddRuntime[AddQty].Lines[m+10]:='String( "Stat'+inttostr(k)+'" );';
      AddRuntime[AddQty].Lines[m+11]:='Font( _AQ );';
      AddRuntime[AddQty].Lines[m+12]:='VAlign( 1 );';
      AddRuntime[AddQty].Lines[m+13]:='BuchstabenSkalierung( 80, 80, 100 );';
      AddRuntime[AddQty].Lines[m+14]:='}';
      AddRuntime[AddQty].Lines[m+15]:='';
      AddRuntime[AddQty].Lines[m+16]:='Text _krStat'+inttostr(k)+'n';
      AddRuntime[AddQty].Lines[m+17]:='{';
      AddRuntime[AddQty].Lines[m+18]:='Position( 200, '+inttostr(160+k*24)+', 0 );';
      AddRuntime[AddQty].Lines[m+19]:='Farbe( 128, 128, 128 );';
      AddRuntime[AddQty].Lines[m+20]:='Schatten( true );';
      AddRuntime[AddQty].Lines[m+21]:='SchattenOffset( 2, 3, 0 );';
      AddRuntime[AddQty].Lines[m+22]:='SchattenAlpha( 160 );';
      AddRuntime[AddQty].Lines[m+23]:='Groesse( 140, 24, 0 );';
      AddRuntime[AddQty].Lines[m+24]:='UID( 12:1:'+inttostr(k)+' );';
      AddRuntime[AddQty].Lines[m+25]:='String( "Stat'+inttostr(k)+'" );';
      AddRuntime[AddQty].Lines[m+26]:='Font( _AQ );';
      AddRuntime[AddQty].Lines[m+27]:='HAlign( 2 );';
      AddRuntime[AddQty].Lines[m+28]:='VAlign( 1 );';
      AddRuntime[AddQty].Lines[m+29]:='BuchstabenSkalierung( 90, 90, 100 );';
      AddRuntime[AddQty].Lines[m+30]:='}';
      AddRuntime[AddQty].Lines[m+31]:='';
    end;
    inc(AddQty);
    AddRuntime[AddQty].Title:='AdvancedStats1';
    AddRuntime[AddQty].Mode:='Add';
    AddRuntime[AddQty].LandMark:='    :_oS';
    AddRuntime[AddQty].Offset:=1;
    AddRuntime[AddQty].Length:=2*10;
    for k:=1 to 10 do begin
      m:=(k-1)*2;
      AddRuntime[AddQty].Lines[m+ 1]:=':_krStat'+inttostr(k)+'t';
      AddRuntime[AddQty].Lines[m+ 2]:=':_krStat'+inttostr(k)+'n';
    end;
  end;

  if Form1.R_SceneryBG.Checked then begin
  inc(AddQty);
  AddRuntime[AddQty].Title:='AddonSceneryBG';
  AddRuntime[AddQty].Mode:='Add';
  AddRuntime[AddQty].LandMark:='  Bitmap _yL'; //BG_Testcenter, in scn folder
  AddRuntime[AddQty].Offset:=4;
  h:=0;
  for i:=1 to AddonSceneryQty do
  if AddonScenery[i].Install then begin
  inc(h);
  AddRuntime[AddQty].Lines[h]:='Bitmap _krScnBG'+int2fix(i,2)+' { Pfad( ".\\Sceneries\\BG_'+AddonScenery[i].Folder+'.tga" ); }';
  end;
  AddRuntime[AddQty].Length:=h;

  inc(AddQty);
  AddRuntime[AddQty].Title:='AddonSceneryBG';
  AddRuntime[AddQty].Mode:='Add';
  AddRuntime[AddQty].LandMark:='    :_yL';
  AddRuntime[AddQty].Offset:=1;
  h:=0;
  for i:=1 to AddonSceneryQty do if AddonScenery[i].Install then begin
    inc(h);
    AddRuntime[AddQty].Lines[h]:=':_krScnBG'+int2fix(i,2);
  end;
  AddRuntime[AddQty].Length:=h;

  inc(AddQty);
  AddRuntime[AddQty].Title:='AddonSceneryFL';
  AddRuntime[AddQty].Mode:='Add';
  AddRuntime[AddQty].LandMark:='  Bitmap _hj'; //flagusa, in scn folder
  AddRuntime[AddQty].Offset:=4;
  h:=0;
  for i:=1 to AddonSceneryQty do
  if AddonScenery[i].Install then begin inc(h);
  AddRuntime[AddQty].Lines[h]:='Bitmap _krScnFL'+int2fix(i,2)+' { Pfad( ".\\Sceneries\\flag'+AddonScenery[i].Folder+'.tga" ); }';
  end; AddRuntime[AddQty].Length:=h;

  inc(AddQty);
  AddRuntime[AddQty].Title:='AddonSceneryFL';
  AddRuntime[AddQty].Mode:='Add';
  AddRuntime[AddQty].LandMark:='    :_hj';
  AddRuntime[AddQty].Offset:=1;
  h:=0;
  for i:=1 to AddonSceneryQty do if AddonScenery[i].Install then begin
  inc(h); AddRuntime[AddQty].Lines[h]:=':_krScnFL'+int2fix(i,2);
  end; AddRuntime[AddQty].Length:=h;

  inc(AddQty);
  AddRuntime[AddQty].Title:='AddonTrackMaps';
  AddRuntime[AddQty].Mode:='Add';
  AddRuntime[AddQty].LandMark:='  Bitmap _5H'; //MiamiWP05.tga, in trk folder
  AddRuntime[AddQty].Offset:=4;
  h:=0;
  for i:=1 to AddonSceneryQty do if AddonScenery[i].Install then begin
    m:=0;
    for k:=1 to AddonScenery[i].TrackQty do
    if AddonScenery[i].Track[k].WayPoint=0 then begin inc(h); inc(m);
    AddRuntime[AddQty].Lines[h]:='Bitmap _krTrk'+int2fix(i,2)+int2fix(k,2)+
    ' { Pfad( ".\\TrackMaps\\Track'+AddonScenery[i].Folder+int2fix(m,2)+'.tga" ); }'; end;
    m:=0;
    for k:=1 to AddonScenery[i].TrackQty do
    if AddonScenery[i].Track[k].WayPoint=1 then begin inc(h); inc(m);
    AddRuntime[AddQty].Lines[h]:='Bitmap _krTrk'+int2fix(i,2)+int2fix(k,2)+
    ' { Pfad( ".\\TrackMaps\\Track'+AddonScenery[i].Folder+'WP'+int2fix(m,2)+'.tga" ); }'; end;
  end;

  AddRuntime[AddQty].Length:=h;

  inc(AddQty);
  AddRuntime[AddQty].Title:='AddonTrackMaps';
  AddRuntime[AddQty].Mode:='Add';
  AddRuntime[AddQty].LandMark:='    :_5H';
  AddRuntime[AddQty].Offset:=1;
  h:=0;
  for i:=1 to AddonSceneryQty do
  if AddonScenery[i].Install then
  for k:=1 to AddonScenery[i].TrackQty do begin
    inc(h);
    AddRuntime[AddQty].Lines[h]:=':_krTrk'+int2fix(i,2)+int2fix(k,2);
  end;
  AddRuntime[AddQty].Length:=h;

  end;
end;


end.
 