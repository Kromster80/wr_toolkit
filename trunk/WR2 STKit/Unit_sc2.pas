unit Unit_sc2;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

 interface
uses Unit1,FileCtrl,sysutils,Windows,KromUtils,Math,dglOpenGL,PTXTexture, Defaults;

  procedure AutoFill_SC2(Sender: TObject);
  procedure EditSC2Click(Sender: TObject);
  procedure UpdateSC2TrackList();
  procedure SC2TrackListClick(Sender: TObject);
  procedure EditSC2TrackClick(Sender: TObject);
  function  SaveSC2(InFile:string):boolean;
  function  LoadSC2(InFile:string):boolean;
  procedure SendDataToSC2();
  procedure WriteCommonDataToSC2();

var
    AddonScenery:record
    EngineName,BGround,Name,SceneryFlag:string;
    FreeRideID,TrackQty:integer;
      Track:array[1..MAX_TRACKS+MAX_WP_TRACKS]of record
      TrackNo:byte;
      Name:string;
      CheckPoint:byte;
      mDistance:integer;
      Direction,WayPoint:byte;
      Maps:string;
      TypeID,NumSections,Order:byte;
      end;
    Author,Converter,Contact,Comment:string;
    end;

    SC2TRefresh:boolean=false;

implementation


procedure AutoFill_SC2(Sender: TObject);
var i:integer;
begin
Changes.SC2 := true;

WriteCommonDataToSC2();

with AddonScenery do begin
  EngineName := UpperCase(Scenery);
  Name       := Scenery;
  FreeRideID := 1;
  Author     := '';
  Converter  := '';
  Contact    := '';
  Comment    := '';
end;

for i:=1 to EnsureRange(TracksQty, 0, MAX_TRACKS) do
with AddonScenery.Track[i] do begin
  Name:=AddonScenery.Name+' '+inttostr(i);
  Direction:=1;
  TypeID:=1;
end;

for i:=1 to EnsureRange(TracksQtyWP, 0, MAX_WP_TRACKS) do
with AddonScenery.Track[i+TracksQty] do begin
  Name:=AddonScenery.Name+' WP'+inttostr(i);
  Direction:=1;
  TypeID:=1;
end;

  SendDataToSC2();
end;


procedure EditSC2Click(Sender: TObject);
begin
if SC2TRefresh then exit;
Changes.SC2:=true;
AddonScenery.EngineName:=Form1.SC2_EngName.Text;
AddonScenery.Name:=Form1.SC2_Name.Text;
AddonScenery.FreeRideID:=Form1.SC2_FreeRideTrack.Value;
AddonScenery.Author:=Form1.SC2_Author.Text;
AddonScenery.Converter:=Form1.SC2_Converter.Text;
AddonScenery.Contact:=Form1.SC2_Contact.Text;
AddonScenery.Comment:=Form1.SC2_Comments.Text;
UpdateSC2TrackList();
end;


procedure UpdateSC2TrackList();
var i:integer;
begin
  Form1.SC2_TrackList.Clear;
  for i:=1 to AddonScenery.TrackQty do
    Form1.SC2_TrackList.Items.Add(inttostr(i)+'. '+AddonScenery.Track[i].Name);
  Form1.SC2_TrackList.ItemIndex:=0;
  SC2TrackListClick(nil);
end;


procedure SC2TrackListClick(Sender: TObject);
var ID:integer;
begin
ID:=Form1.SC2_TrackList.ItemIndex+1;
if ID=0 then begin
Form1.SC2T_Title.Text:='';
Form1.SC2T_Direction.ItemIndex:=0;
Form1.SC2T_Type.ItemIndex:=0;
Form1.Label140.Caption:='Length, 0m';
Form1.Label118.Caption:='Waypoint, 0';
Form1.SC2T_Image.Text:='';
exit;
end;
SC2TRefresh:=true;
with AddonScenery.Track[ID] do begin
Form1.SC2T_Title.Text:=Name;
Form1.SC2T_Direction.ItemIndex:=Direction-1;
Form1.SC2T_Type.ItemIndex:=TypeID-1;
Form1.Label140.Caption:='Length, '+inttostr(mDistance)+'m';
Form1.Label118.Caption:='Waypoint, '+inttostr(integer(Waypoint));
Form1.SC2T_Image.Text:=Maps;
end;
SC2TRefresh:=false;
end;


procedure EditSC2TrackClick(Sender: TObject);
var ID:integer;
begin
  if SC2TRefresh then exit;
  ID := Form1.SC2_TrackList.ItemIndex+1;
  if ID=0 then exit;
  Changes.SC2 := true;

  with AddonScenery.Track[ID] do begin
    Name      := Form1.SC2T_Title.Text;
    Direction := Form1.SC2T_Direction.ItemIndex+1;
    TypeID    := Form1.SC2T_Type.ItemIndex+1;
    Form1.SC2_TrackList.Items[ID-1] := inttostr(ID)+'. '+Name; //renaming on-the-fly
  end;
  SC2TrackListClick(nil);
end;


function SaveSC2(InFile:string):boolean;
var
  f:file;
  k,h:integer;
begin
WriteCommonDataToSC2();
assignfile(f,InFile); rewrite(f,1);
blockwrite(f,'WR2'+#1,4);
blockwrite(f,#0+#0,2);
with AddonScenery do begin
  h:=length(EngineName);  blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(EngineName,h+1)[1],h+1);
  h:=length(BGround);     blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(BGround,h+1)[1],h+1);
  h:=length(Name);        blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(Name,h+1)[1],h+1);
  h:=length(SceneryFlag); blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(SceneryFlag,h+1)[1],h+1);
  blockwrite(f,FreeRideID,2);
  blockwrite(f,TrackQty,2);
  for k:=1 to TrackQty do with AddonScenery.Track[k] do begin
    blockwrite(f,TrackNo,2);
    h:=length(Name);  blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(Name,h+1)[1],h+1);
    blockwrite(f,CheckPoint,2);
    blockwrite(f,mDistance,2);
    blockwrite(f,Direction,2);
    blockwrite(f,WayPoint,2);
    h:=length(Maps);  blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(Maps,h+1)[1],h+1);
    blockwrite(f,TypeID,2);
    blockwrite(f,NumSections,2);
    blockwrite(f,Order,2);
  end;
  h:=length(Author);  blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(Author,h+1)[1],h+1);
  h:=length(Converter);  blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(Converter,h+1)[1],h+1);
  h:=length(Contact);  blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(Contact,h+1)[1],h+1);
  h:=length(Comment);  blockwrite(f,h,2); if h<>0 then blockwrite(f,chr2(Comment,h+1)[1],h+1);
end;
closefile(f);
Changes.SC2:=false;
Result:=true;
end;


function LoadSC2(InFile:string):boolean;
var
  f:file;
  k,h:word;
begin Result:=false;
if not fileexists(InFile) then exit;
assignfile(f,InFile); FileMode:=0; reset(f,1); FileMode:=2; //read-only
blockread(f,c,4); if c[1]+c[2]+c[3]+c[4]<>'WR2'+#1 then exit;
blockread(f,c,2); //Chapters
with AddonScenery do begin
blockread(f,h,2);
if h<>0 then begin blockread(f,c,h+1);
EngineName:=StrPas(@c); end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); BGround:=StrPas(@c); end else BGround:='';
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Name:=StrPas(@c); end else Name:='';
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); SceneryFlag:=StrPas(@c); end else SceneryFlag:='';
blockread(f,FreeRideID,2);
blockread(f,TrackQty,2);
for k:=1 to TrackQty do with AddonScenery.Track[k] do begin
blockread(f,TrackNo,2);
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Name:=StrPas(@c); end else Name:='';
blockread(f,CheckPoint,2);
blockread(f,mDistance,2);
blockread(f,Direction,2);
blockread(f,WayPoint,2);
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Maps:=StrPas(@c); end else Maps:='';
blockread(f,TypeID,2);
blockread(f,NumSections,2);
blockread(f,Order,2);
end;
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Author:=StrPas(@c); end else Author:='';
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Converter:=StrPas(@c); end else Converter:='';
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Contact:=StrPas(@c); end else Contact:='';
blockread(f,h,2); if h<>0 then begin blockread(f,c,h+1); Comment:=StrPas(@c); end else Comment:='';
end;
closefile(f);
SendDataToSC2();
Result:=true;
end;


procedure SendDataToSC2();
begin
  SC2TRefresh:=true;
  with AddonScenery do begin
    Form1.SC2_EngName.Text        := EngineName;
    Form1.SC2_Name.Text           := Name; 
    Form1.SC2_BGImage.Text        :='BG_'+Form1.SC2_EngName.Text+'.tga';
    Form1.SC2_ScnFlag.Text        := 'Flag'+Form1.SC2_EngName.Text+'.tga';
    Form1.SC2_FreeRideTrack.Value := FreeRideID;
    Form1.SC2_ScnTracks.Value     := EnsureRange(TracksQty, 0, MAX_TRACKS) + EnsureRange(TracksQtyWP, 0, MAX_WP_TRACKS);//TrackQty;
    Form1.SC2_Author.Text         := Author;
    Form1.SC2_Converter.Text      := Converter;
    Form1.SC2_Contact.Text        := Contact;
    Form1.SC2_Comments.Text       := Comment;
  end;

  SC2TRefresh := false;
  Form1.SC2_TrackList.ItemIndex := 0;
  UpdateSC2TrackList();
end;


procedure WriteCommonDataToSC2();
var i:integer;
begin
with AddonScenery do begin
//EngineName:=
//Name:=
BGround:='BG_'+Form1.SC2_EngName.Text+'.tga';
SceneryFlag:='Flag'+Form1.SC2_EngName.Text+'.tga';
//FreeRideID:=
TrackQty:=EnsureRange(TracksQty,0,MAX_TRACKS)+EnsureRange(TracksQtyWP,0,MAX_WP_TRACKS);
//Author:=
//Converter:=
//Contact:=
//Comment:=
end;

for i:=1 to EnsureRange(TracksQty,0,32) do
with AddonScenery.Track[i] do begin
TrackNo:=i;
if Name='' then Name:=AddonScenery.Name+' '+inttostr(i);
if Direction=0 then Direction:=1;
if TypeID=0 then TypeID:=1;
CheckPoint:=0;
if TRKQty[i].Nodes<>0 then
mDistance:=round(TRK[i].Route[EnsureRange(TRKQty[i].Nodes,1,16384)].Delta/10)
else mDistance:=0;
WayPoint:=0;
Maps:='Track'+AddonScenery.EngineName+int2fix(i,2)+'.tga';
NumSections:=0;
Order:=i;
end;

for i:=1 to EnsureRange(TracksQtyWP,0,32) do
with AddonScenery.Track[i+TracksQty] do begin
TrackNo:=i;
if Name='' then Name:=AddonScenery.Name+' WP'+inttostr(i);
if Direction=0 then Direction:=1;
if TypeID=0 then TypeID:=1;
CheckPoint:=0;
mDistance:=WTRLength[i];
WayPoint:=1;
Maps:='Track'+AddonScenery.EngineName+'WP'+int2fix(i,2)+'.tga'; //Numeration goes on
NumSections:=WTR[i].NodeQty-1;
Order:=i+TracksQty;
end;

end;



end.
