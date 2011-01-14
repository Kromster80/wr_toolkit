unit Unit_Streets;
interface
uses Classes, sysutils, Windows, KromUtils, Math, dglOpenGL;


type
  TSStreetShape = packed record
    Offset:array[1..2]of single;
    Options:word; //unused (Options=0)
    NumLanes:word;
  end;

  TSStreetNode = packed record
    Position:vector3f;
    Tangent:vector3f;
  end;

  TSStreetSpline = packed record
    PtA,PtB:word;
    FirstShRef,NumShRefs:word;
    LenA,LenB,Length:single;
    Density,Options:word;
    OppSpline,PrevSpline:word;
    FirstWay,NumWays:word;
    FirstRoW,NumRoW:word;
  end;

  TSStreetShRef = packed record //Is same count as Num_Shapes
    Shape,Speed:word;         //extending each shape with speed limit
    StartU:single;            //unused (always 0)
  end;

  TSStreetRoW = packed record //is same count as NumSplines
    Spline:word;
    Tracks:cardinal;
  end;


type
  TSStreets = class
    private
      Header:array[1..4]of char;
      Version,Options:word;

      fShapeCount:integer;
      fNodeCount:integer;
      fSplineCount:integer;
      fShRefCount:integer;
      fRoWCount:integer;
      fShapes:array of TSStreetShape;
      fNodes:array of TSStreetNode;
      fSplines:array of TSStreetSpline;
      fShRefs:array of TSStreetShRef;
      fRoWs:array of TSStreetRoW;
    public
      //constructor Create;
      procedure Clear;
      //procedure AddShape;
      //procedure RemShape;

      function LoadFromFile(aFile:string):boolean;
      //procedure SaveToFile;
    end;


procedure AddShapeClick_();
procedure RemShapeClick_();
procedure ListStreetShapeClick_();
procedure StreetShapeChange_();
procedure STRPointIDChange_();
procedure STRPointXChange_();
procedure RemPointClick_();
procedure RemSplineClick_();

function ComputeSplineLength(In1:integer):single;
function FindOppSpline(In1:integer):integer;
function FindPrevSpline(In1:integer):integer;
function FindFirstWay(In1:integer):integer;
procedure DeleteSpline(In1:integer);
procedure MakeSpline(Node1,Node2:integer);

var
    STRShapeRefresh:boolean=false;
    STRPointRefresh:boolean=false;

implementation
uses Unit1, Unit_RoutineFunctions, Unit_Tracing, PTXTexture;


procedure TSStreets.Clear;
begin
  fShapeCount := 0;
  fNodeCount  := 0;
  fSplineCount:= 0;
  fShRefCount := 0;
  fRoWCount   := 0;
  setlength(fShapes, 0);
  setlength(fNodes, 0);
  setlength(fSplines, 0);
  setlength(fShRefs, 0);
  setlength(fRoWs, 0);
end;


function TSStreets.LoadFromFile(aFile:string):boolean;
var S:TMemoryStream;
begin
  Result := false;

  Clear;
  if not FileExists(aFile) then exit;

  S := TMemoryStream.Create;
  try
    S.LoadFromFile(aFile);
    S.Read(Header[1],4);
    if Header[1]+Header[2]+Header[3]+Header[4] <> 'NRTS' then exit;
    S.Read(Version,2);
    S.Read(Options,2);
    S.Read(fShapeCount,4);
    S.Read(fNodeCount,4);
    S.Read(fSplineCount,4);
    S.Read(fShRefCount,4);
    S.Read(fRoWCount,4);
    Assert(Version = 258, 'Only WR2 streets format is supported yet');

    setlength(fShapes,fShapeCount+2);  //+2 is necessay to handle 0 length case:
    setlength(fNodes,fNodeCount+2);  // blockread reads from [1] element which
    setlength(fSplines,fSplineCount+2);// needs to be existent 0..1 => 0+2
    setlength(fShRefs,fShRefCount+2);
    setlength(fRoWs,fRoWCount+2);

    S.Read(fShapes[1], fShapeCount*12);
    S.Read(fNodes[1], fNodeCount*24);
    S.Read(fSplines[1], fSplineCount*36);
    S.Read(fShRefs[1], fShRefCount*8);
    S.Read(fRoWs[1], fRoWCount*6);

  finally
    S.Free;
  end;
end;


procedure AddShapeClick_();
var ID:integer;
begin
inc(STRHead.NumShapes);
inc(STRHead.NumShRefs);
ID:=STRHead.NumShapes;
setlength(STR_Shape,ID+1);
setlength(STR_ShRef,ID+1);
STR_Shape[ID].Offset[1]:=26;
STR_Shape[ID].Offset[2]:=26;
STR_Shape[ID].NumLanes:=1;
STR_Shape[ID].Options:=0;
STR_ShRef[ID].Shape:=ID-1;
STR_ShRef[ID].Speed:=round(60/0.0036);
STR_ShRef[ID].StartU:=0;
Form1.ListStreetShape.Items.Add(inttostr(STR_Shape[ID].Options)
+' '+inttostr(STR_Shape[ID].NumLanes)
+' '+inttostr(round(STR_Shape[ID].Offset[1]))
+' '+inttostr(round(STR_Shape[ID].Offset[2])));
if STRHead.NumShapes>1 then Form1.RemShape.Enabled:=true;
Form1.STRSplineShape1.MaxValue:=STRHead.NumShapes;
Form1.STRSplineShape2.MaxValue:=STRHead.NumShapes;
Changes.STR:=true;
end;

procedure RemShapeClick_();
var i,ID:integer;
begin
ID:=Form1.ListStreetShape.ItemIndex+1;
if ID<1 then exit;
if STRHead.NumShapes=1 then exit;

for i:=ID+1 to STRHead.NumShapes do
STR_Shape[i-1]:=STR_Shape[i];

for i:=1 to STRHead.NumShRefs do
if STR_ShRef[i].Shape+1>ID then
dec(STR_ShRef[i].Shape) else
if STR_ShRef[i].Shape+1=ID then
STR_ShRef[i].Shape:=EnsureRange(ID-1,1,STRHead.NumShapes)-1;

dec(STRHead.NumShapes);
if STRHead.NumShapes=1 then Form1.RemShape.Enabled:=false;
Form1.STRSplineShape1.MaxValue:=STRHead.NumShapes;
Form1.STRSplineShape2.MaxValue:=STRHead.NumShapes;
Form1.SendQADtoUI('Streets');
Form1.ListStreetShape.ItemIndex:=ID-1;
Changes.STR:=true;
end;

procedure ListStreetShapeClick_();
var ID:integer;
begin
ID:=Form1.ListStreetShape.ItemIndex+1;
if ID<1 then exit;
STRShapeRefresh:=true;
Form1.STROff1.Value:=STR_Shape[ID].Offset[1];
Form1.STROff2.Value:=STR_Shape[ID].Offset[2];
Form1.STRLanes.Value:=STR_Shape[ID].NumLanes;
//Form1.STRShapeOpt1.Checked:=(STR_Shape[ID].Options and 4096 = 4096);
//Form1.STRShapeOpt2.Checked:=(STR_Shape[ID].Options and 8192 = 8192);
Form1.STRShSpeed.Value:=round(STR_ShRef[ID].Speed*0.0036);
STRShapeRefresh:=false;
Changes.STR:=true;
end;

procedure StreetShapeChange_();
var ID:integer; s:string;
begin
if STRShapeRefresh then exit;
ID:=Form1.ListStreetShape.ItemIndex+1;
if ID=0 then exit;
STR_Shape[ID].Offset[1]:=Form1.STROff1.Value;
STR_Shape[ID].Offset[2]:=Form1.STROff2.Value;
STR_Shape[ID].NumLanes:=Form1.STRLanes.Value;
STR_Shape[ID].Options:=0;
STR_ShRef[ID].Speed:=EnsureRange(round(Form1.STRShSpeed.Value/0.0036),0,65535); //
//Disable those, seems to have no effect after all
//if Form1.STRShapeOpt1.Checked then inc(STR_Shape[ID].Options,4096);
//if Form1.STRShapeOpt2.Checked then inc(STR_Shape[ID].Options,8192);

s:=inttostr(round(STR_ShRef[ID].Speed*0.0036))+'kmh ';
s:=s+inttostr(round(STR_Shape[ID].Offset[1]))+'m ';
if STR_Shape[ID].NumLanes=2 then s:=s+inttostr(round(STR_Shape[ID].Offset[2]))+'m ';
if (STR_Shape[ID].Options and 4096 = 4096) then s:=s+'1' else s:=s+'0';
if (STR_Shape[ID].Options and 8192 = 8192) then s:=s+'1' else s:=s+'0';
Form1.ListStreetShape.Items[ID-1]:=s;

Changes.STR:=true;
end;

procedure STRPointIDChange_();
var ID:integer;
begin
if Form1.STRPointID.Value=0 then exit;
Form1.STRPointID.Value:=EnsureRange(Form1.STRPointID.Value,1,STRHead.NumPoints);
ID:=Form1.STRPointID.Value;
STRPointRefresh:=true;
Form1.STRPointX.Value:=STR_Point[ID].x;
Form1.STRPointY.Value:=STR_Point[ID].y;
Form1.STRPointZ.Value:=STR_Point[ID].z;

if STR_Point[ID].tz<>0 then
Form1.STRPointT.Value:=round(arctan2(STR_Point[ID].tx,STR_Point[ID].tz)*180/pi)
else Form1.STRPointT.Value:=0;
Form1.STRPointT2.Value:=round(sin(STR_Point[ID].ty)*180/pi);
STRPointRefresh:=false;
//xPos:=STR_Point[ID].x;
//yPos:=STR_Point[ID].y;
//zPos:=STR_Point[ID].z;
end;

procedure STRPointXChange_();
var ID:integer; y1,y2:single; ti:integer;
begin
if Form1.STRPointID.Value=0 then exit;
if STRPointRefresh then exit;
ID:=Form1.STRPointID.Value;
STR_Point[ID].x:=Form1.STRPointX.Value;
STR_Point[ID].y:=Form1.STRPointY.Value;
STR_Point[ID].z:=Form1.STRPointZ.Value;
STR_Point[ID].tx:=sin(Form1.STRPointT.Value*pi/180);
//STR_Point[ID].ty:=arcsin(Form1.STRPointT2.Value*pi/180);
STR_Point[ID].tz:=cos(Form1.STRPointT.Value*pi/180);

TraceHeight(STR_Point[ID].x+STR_Point[ID].tx*100,
            STR_Point[ID].y+STR_Point[ID].ty*100,
            STR_Point[ID].z+STR_Point[ID].tz*100,
            pd_Near, @y1, @ti);
TraceHeight(STR_Point[ID].x-STR_Point[ID].tx*100,
            STR_Point[ID].y-STR_Point[ID].ty*100,
            STR_Point[ID].z-STR_Point[ID].tz*100,
            pd_Near, @y2, @ti);

Normalize(STR_Point[ID].tx,
          (y1-y2)/150,
          STR_Point[ID].tz,
          @STR_Point[ID].tx,@STR_Point[ID].ty,@STR_Point[ID].tz);
//xPos:=STR_Point[ID].x;
//yPos:=STR_Point[ID].y;
//zPos:=STR_Point[ID].z;
Changes.STR:=true;
end;

procedure RemPointClick_();
var i,k,ID:integer; toDel:array[1..256]of integer;
begin
ID:=Form1.STRPointID.Value;
if ID=0 then exit;

k:=1;
for i:=1 to STRHead.NumSplines do //Remove splines using this point
if (STR_Spline[i].PtA+1=ID)or(STR_Spline[i].PtB+1=ID) then begin
toDel[k]:=i; //delete later to not interfere with current loop
inc(k);
end;

for i:=k-1 downto 1 do DeleteSpline(toDel[i]);

for i:=1 to STRHead.NumSplines do begin //shift up points in splines
if STR_Spline[i].PtA+1>ID then dec(STR_Spline[i].PtA);
if STR_Spline[i].PtB+1>ID then dec(STR_Spline[i].PtB);
end;

for i:=ID+1 to STRHead.NumPoints do //shift up points
STR_Point[i-1]:=STR_Point[i];

dec(STRHead.NumPoints);
Form1.STRPointID.Value:=EnsureRange(ID,1,STRHead.NumPoints)-1;
Changes.STR:=true;
end;

procedure RemSplineClick_();
var ID:integer;
begin
ID:=Form1.STRSplineID1.Value;
if ID=0 then exit;
DeleteSpline(ID);
Form1.STRSplineID1.Value:=EnsureRange(ID,1,STRHead.NumSplines)-1;
end;

function ComputeSplineLength(In1:integer):single;
var kk,PA,PB:integer; LA,LB,T,Len:single;// A,B,C:integer;
var ax,bx,cx,x0,x1,x2,x3,xt:single;
    ay,by,cy,y0,y1,y2,y3,yt:single;
    az,bz,cz,z0,z1,z2,z3,zt:single;
    Spline:array[0..32]of record x,y,z:single; end;
begin
    PA:=STR_Spline[In1].PtA+1;       //point A index
    PB:=STR_Spline[In1].PtB+1;       //point B index
    LA:=STR_Spline[In1].LenA/3;      //anchor A length
    LB:=-STR_Spline[In1].LenB/3;     //anchor B length

    for kk:=0 to 32 do begin //Compute basic spline
    T:=kk/32; //0..1 range
    x0:=STR_Point[PA].x; x1:=x0+STR_Point[PA].tx*LA;
    x3:=STR_Point[PB].x; x2:=x3+STR_Point[PB].tx*LB;
    y0:=STR_Point[PA].y; y1:=y0+STR_Point[PA].ty*LA;
    y3:=STR_Point[PB].y; y2:=y3+STR_Point[PB].ty*LB;
    z0:=STR_Point[PA].z; z1:=z0+STR_Point[PA].tz*LA;
    z3:=STR_Point[PB].z; z2:=z3+STR_Point[PB].tz*LB;
    cx:=3*(x1-x0); bx:=3*(x2-x1)-cx; ax:=x3-x0-cx-bx; Spline[kk].x:=ax*t*t*t+bx*t*t+cx*t+x0;
    cy:=3*(y1-y0); by:=3*(y2-y1)-cy; ay:=y3-y0-cy-by; Spline[kk].y:=ay*t*t*t+by*t*t+cy*t+y0;
    cz:=3*(z1-z0); bz:=3*(z2-z1)-cz; az:=z3-z0-cz-bz; Spline[kk].z:=az*t*t*t+bz*t*t+cz*t+z0;
    end;

    Len:=0;
    for kk:=1 to 32 do
    Len:=Len+sqrt(sqr(Spline[kk].x-Spline[kk-1].x)+
                  sqr(Spline[kk].y-Spline[kk-1].y)+
                  sqr(Spline[kk].z-Spline[kk-1].z));
    Result:=Len;
end;

function FindOppSpline(In1:integer):integer;
var k:integer;
begin
Result:=65535;
for k:=1 to STRHead.NumSplines do
if (STR_Spline[In1].PtA=STR_Spline[k].PtB)and(STR_Spline[In1].PtB=STR_Spline[k].PtA) then
Result:=k-1;
end;

function FindPrevSpline(In1:integer):integer;
var k,Prev,NumPrev:integer;
begin
Prev:=0; NumPrev:=0;
for k:=1 to STRHead.NumSplines do
if (STR_Spline[In1].PtA=STR_Spline[k].PtB)and(STR_Spline[In1].PtB<>STR_Spline[k].PtA)
and(sign(STR_Spline[In1].LenA)=sign(STR_Spline[k].LenB))
then begin
Prev:=k;
inc(NumPrev);
end;
if (Prev=0)or(NumPrev>1) then Result:=65535 else Result:=Prev-1;
end;

function FindFirstWay(In1:integer):integer;
var i,k,NumWays:integer; Ways:array[1..4]of integer;
begin
NumWays:=0;
for k:=1 to STRHead.NumSplines do
if (STR_Spline[In1].PtB=STR_Spline[k].PtA)and(STR_Spline[In1].PtA<>STR_Spline[k].PtB)
and(sign(STR_Spline[In1].LenB)=sign(STR_Spline[k].LenA))
then begin
if NumWays<5 then inc(NumWays);
Ways[NumWays]:=k;
end;

setlength(STR_Spline,STRHead.NumSplines+5);
//Ways[1..16] are holding all possible upcoming routes
//now we need to sort them in CCW order
//ExchangeSplines now
if NumWays>1 then
for k:=1 to NumWays do begin
STR_Spline[0]:=STR_Spline[In1+k];
STR_Spline[In1+k]:=STR_Spline[Ways[k]];
STR_Spline[Ways[k]]:=STR_Spline[0];
end;

i:=0;                                    //shift up if there are empty entries
for k:=1 to STRHead.NumSplines do begin
repeat inc(i);
until(STR_Spline[i].Length<>0);
STR_Spline[k]:=STR_Spline[i];
end;

setlength(STR_Spline,STRHead.NumSplines+1);

STR_Spline[In1].NumWays:=NumWays;
case NumWays of
0: Result:=65535;       //None
1: Result:=Ways[1]-1;   //Found
else Result:=(In1+1)-1; //Next
end;
end;

procedure DeleteSpline(In1:integer);
var i:integer;
begin
for i:=In1+1 to STRHead.NumSplines do begin
//dec(STR_Spline[i].FirstShRef);
//dec(STR_Spline[i].FirstRoW); 65535 now
STR_Spline[i-1]:=STR_Spline[i];
end;
dec(STRHead.NumSplines);

//for i:=In1+1 to STRHead.NumShRefs do  STR_ShRef[i-1]:=STR_ShRef[i];   dec(STRHead.NumShRefs);
for i:=In1+1 to STRHead.NumRoWs do    STR_RoW[i-1]:=STR_RoW[i];       dec(STRHead.NumRoWs);

Form1.STR_PrepareToSaveClick(nil);
end;

procedure MakeSpline(Node1,Node2:integer);
var ID:integer;
begin
for ID:=1 to STRHead.NumSplines do
if (STR_Spline[ID].PtA+1=Node1)and(STR_Spline[ID].PtB+1=Node2) then exit;

inc(STRHead.NumSplines);
ID:=STRHead.NumSplines;
setlength(STR_Spline,ID+2);
//STRHead.NumShRefs:=ID; //easiest solution - 1Spline=1ShRef
//setlength(STR_ShRef,STRHead.NumShRefs+2);
STRHead.NumRoWs:=ID; //easiest solution - 1Spline=1RoW
setlength(STR_RoW,STRHead.NumRoWs+2);
STR_Spline[ID].PtA:=Node1-1;
STR_Spline[ID].PtB:=Node2-1;
STR_Spline[ID].FirstShRef:=STR_Spline[ID-1].FirstShRef;//ID-1; //0..x
//STR_ShRef[ID].Shape:=0;
//STR_ShRef[ID].Speed:=round(60/0.0036); //60kmh
//STR_ShRef[ID].StartU:=0;
STR_Spline[ID].NumShRefs:=1;
STR_Spline[ID].LenA:=
GetLength(STR_Point[Node1].x-STR_Point[Node2].x,
          STR_Point[Node1].y-STR_Point[Node2].y,
          STR_Point[Node1].z-STR_Point[Node2].z);
STR_Spline[ID].LenB:=STR_Spline[ID].LenA;
//Reverse anchors to face each other
if GetLength((STR_Point[Node1].x+STR_Point[Node1].tx*STR_Spline[ID].LenA/3)-STR_Point[Node2].x,
             (STR_Point[Node1].z+STR_Point[Node1].tz*STR_Spline[ID].LenA/3)-STR_Point[Node2].z)
>  GetLength((STR_Point[Node1].x+STR_Point[Node1].tx*-STR_Spline[ID].LenA/3)-STR_Point[Node2].x,
             (STR_Point[Node1].z+STR_Point[Node1].tz*-STR_Spline[ID].LenA/3)-STR_Point[Node2].z)
then STR_Spline[ID].LenA:=-STR_Spline[ID].LenA;
//LenB is applied with "-" sign !
if GetLength((STR_Point[Node2].x+STR_Point[Node2].tx*-STR_Spline[ID].LenB/3)-STR_Point[Node1].x,
             (STR_Point[Node2].z+STR_Point[Node2].tz*-STR_Spline[ID].LenB/3)-STR_Point[Node1].z)
>  GetLength((STR_Point[Node2].x+STR_Point[Node2].tx*STR_Spline[ID].LenB/3)-STR_Point[Node1].x,
             (STR_Point[Node2].z+STR_Point[Node2].tz*STR_Spline[ID].LenB/3)-STR_Point[Node1].z)
then STR_Spline[ID].LenB:=-STR_Spline[ID].LenB;

STR_Spline[ID].Options:=0;
STR_Spline[ID].OppSpline:=FindOppSpline(ID);
STR_Spline[ID].FirstRoW:=65535; //0..x
STR_Spline[ID].NumRoW:=0;
Form1.STRSplineID1.Value:=ID; //perform after new values are assigned to avoid crash

if STR_Spline[ID].OppSpline<>65535 then begin
STR_Spline[ID].LenA:=-STR_Spline[STR_Spline[ID].OppSpline+1].LenB;
STR_Spline[ID].LenB:=-STR_Spline[STR_Spline[ID].OppSpline+1].LenA;
end;
//if Form1.CBSplineSymmetry.Checked then Form1.STRSplineID1Change(nil);

Form1.STR_PrepareToSaveClick(nil);
end;



end.
