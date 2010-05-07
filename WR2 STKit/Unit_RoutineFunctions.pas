unit Unit_RoutineFunctions;
interface
uses Unit1,Math, KromUtils, SysUtils, Unit_Tracing, Defaults;

//function AddWarning(WarningText:string):boolean;
function CalculateSNIRoutes():boolean;
procedure GetPositionFromTRK(TRKNumber:integer; Loc:single; Node:pinteger; X,Y,Z,Fraction:psingle);
procedure GetPositionFromSNI(SNINumber:integer; Loc:single; X,Y,Z:psingle);
procedure GetPositionFromSNISpeed(SNINumber:integer; X,Y,Z,H,P,B:psingle);
function ReturnListOfChangedFiles(eol:string):string;
procedure PlaceCarOnTerrain(var CrX,CrY,CrZ,CrH,CrP,CrB:single; PickDirection:string; var CmX,CmY,CmZ,CmH,CmP:single);
procedure MoveCarSimple();
procedure MoveCarAlongTrack(TrackID:integer);

implementation

procedure MoveCarAlongTrack(TrackID:integer);
var p0,p1,p2,k:integer; dt,ay,by,t:single;
begin
PlayTrackPos:=PlayTrackPos+(FrameTime*PlayTrackSpeed/5); //*5
if PlayTrackPos<0 then PlayTrackPos:=PlayTrackPos+TRK[TrackID].Route[TRKQty[TrackID].Nodes].Delta;
if PlayTrackPos>=TRK[TrackID].Route[TRKQty[TrackID].Nodes].Delta then
PlayTrackPos:=PlayTrackPos-TRK[TrackID].Route[TRKQty[TrackID].Nodes].Delta;

GetPositionFromTRK(TrackID,PlayTrackPos,@p0,@t,@t,@t,@dt);
p1:=(p0+1) mod TRKQty[TrackID].Nodes; // 1 <= X < Qty , 0
p2:=(p0+2) mod TRKQty[TrackID].Nodes; // 1 <= X < Qty , 0
inc(p0); inc(p1); inc(p2);

with TRK[TrackID] do begin
CarX:=(Route[p0].X+Route[p0].Ideal*Route[p0].Matrix[1])*(1-dt)+
      (Route[p1].X+Route[p1].Ideal*Route[p1].Matrix[1])*dt;
CarY:=(Route[p0].Y+Route[p0].Ideal*Route[p0].Matrix[4])*(1-dt)+
      (Route[p1].Y+Route[p1].Ideal*Route[p1].Matrix[4])*dt;
CarZ:=(Route[p0].Z+Route[p0].Ideal*Route[p0].Matrix[7])*(1-dt)+
      (Route[p1].Z+Route[p1].Ideal*Route[p1].Matrix[7])*dt;

//Choose wherever car should follow Track or terrain
if Form1.CBTrace.Checked then
TraceHeight(CarX,CarY,CarZ,'Near',@CarY,@TracePt);

xPos:=CarX;
yPos:=CarY+15; //look above roof
zPos:=CarZ;

CarP:=arctan2(
(Route[p2].Y-Route[p1].Y)*dt+
(Route[p1].Y-Route[p0].Y)*(1-dt),
(GetLength(Route[p2].X-Route[p1].X,Route[p2].Z-Route[p1].Z))*dt+
(GetLength(Route[p1].X-Route[p0].X,Route[p1].Z-Route[p0].Z))*(1-dt)
)*180/pi;

CarH:=180+arctan2(
((Route[p2].X+Route[p2].Ideal*Route[p2].Matrix[1])-
 (Route[p1].X+Route[p1].Ideal*Route[p1].Matrix[1]))*dt+
((Route[p1].X+Route[p1].Ideal*Route[p1].Matrix[1])-
 (Route[p0].X+Route[p0].Ideal*Route[p0].Matrix[1]))*(1-dt),
((Route[p2].Z+Route[p2].Ideal*Route[p2].Matrix[7])-
 (Route[p1].Z+Route[p1].Ideal*Route[p1].Matrix[7]))*dt+
((Route[p1].Z+Route[p1].Ideal*Route[p1].Matrix[7])-
 (Route[p0].Z+Route[p0].Ideal*Route[p0].Matrix[7]))*(1-dt)
)*180/pi;

TraceHeight((Route[p0].X+Route[p0].Margin1*Route[p0].Matrix[1]/10)*(1-dt)+
            (Route[p1].X+Route[p1].Margin1*Route[p1].Matrix[1]/10)*dt,
            CarY,
            (Route[p0].Z+Route[p0].Margin1*Route[p0].Matrix[7]/10)*(1-dt)+
            (Route[p1].Z+Route[p1].Margin1*Route[p1].Matrix[7]/10)*dt,
            'Near',@ay,@k);
TraceHeight((Route[p0].X+Route[p0].Margin2*Route[p0].Matrix[1]/10)*(1-dt)+
            (Route[p1].X+Route[p1].Margin2*Route[p1].Matrix[1]/10)*dt,
            CarY,
            (Route[p0].Z+Route[p0].Margin2*Route[p0].Matrix[7]/10)*(1-dt)+
            (Route[p1].Z+Route[p1].Margin2*Route[p1].Matrix[7]/10)*dt,
            'Near',@by,@k);

CarB:=90-arctan2(
(Route[p0].Margin2-Route[p0].Margin1)*(1-dt)+
(Route[p1].Margin2-Route[p1].Margin1)*dt,(ay-by)*10)*180/pi;
end; //with TRK[TrackID] do
xRot:=CarH-180;
yRot:=180+15-CarP/2;
Zoom:=1.6;
end;

procedure PlaceCarOnTerrain(var CrX,CrY,CrZ,CrH,CrP,CrB:single; PickDirection:string; var CmX,CmY,CmZ,CmH,CmP:single);
var T:integer; //temp
    RetY:single;
    sinH,cosH:single;
    deltaP,deltaB:single;
    i:integer;
    Tx,Tz:single;
begin
  sinH:=sin(CrH/180*pi);
  cosH:=cos(CrH/180*pi);
  for i:=1 to 4 do
    CarWheels[i].Diam:=3;    

  for i:=1 to 4 do begin
    Tx:=CrX+WheelsM[i,1]*sinH*CarLength+WheelsM[i,2]*cosH*CarTrackWidth;
    Tz:=CrZ+WheelsM[i,3]*cosH*CarLength+WheelsM[i,4]*sinH*CarTrackWidth;
    CarWheels[i].Angle.P:=CarWheels[i].Angle.P-Round(GetLength(CarWheels[i].Pos.X-Tx,CarWheels[i].Pos.Z-Tz)/(CarWheels[i].Diam*pi)*180);
    CarWheels[i].Pos.X:=Tx;
    CarWheels[i].Pos.Z:=Tz;
    TraceHeight(CarWheels[i].Pos.X,CrY,CarWheels[i].Pos.Z,PickDirection,@RetY,@T);
    CarWheels[i].Pos.Y:=RetY;
  end;

  TraceHeight(CrX-sinH*CarLength,CrY,CrZ-cosH*CarLength,PickDirection,@RetY,@T);
  deltaP:=RetY;
  TraceHeight(CrX+sinH*CarLength,CrY,CrZ+cosH*CarLength,PickDirection,@RetY,@T);
  deltaP:=deltaP-RetY;

  TraceHeight(CrX+cosH*CarTrackWidth,CrY,CrZ-sinH*CarTrackWidth,PickDirection,@RetY,@T);
  deltaB:=RetY;
  TraceHeight(CrX-cosH*CarTrackWidth,CrY,CrZ+sinH*CarTrackWidth,PickDirection,@RetY,@T);
  deltaB:=deltaB-RetY;

  TraceHeight(CrX,CrY,CrZ,PickDirection,@RetY,@T);
  CrY:=RetY;
  CrP:=arctan2(deltaP,CarLength*2)*180/pi;
  CrB:=arctan2(deltaB,CarTrackWidth*2)*180/pi;

  CmX:=CrX;
  CmY:=CrY+15; //look above roof
  CmZ:=CrZ;
  CmH:=CrH-180;
  CmP:=180+15-CrP/2;
end;

procedure MoveCarSimple();
const TopSpeed=40;
var SpeedIncrease,SpeedDecrease,TurnAngle:single;
begin

SpeedIncrease:=0;
SpeedDecrease:=0;

if Car.Mode='Sim' then begin
  //All speed is stored as m/s
  //All acceleration is stored as m/s
  //All turning speed is stored as euler/s

  TurnAngle:=0;
  if Key3 then TurnAngle:=-60;
  if Key4 then TurnAngle:=60;

  TurnAngle:=TurnAngle*(1-abs(10-Car.Speed)/40); //The bigger speed the less steering control 10=1 50=0
  if Car.Speed<5 then
  TurnAngle:=TurnAngle*(Car.Speed/5); //The smaller speed the less steering control 10=1 0=0

  SpeedIncrease:=0;
  SpeedDecrease:=0.25+10*sqr(sqr(sqr(Car.Speed/TopSpeed)))+abs(TurnAngle/12); //That is air-brake
  if Key1 then SpeedIncrease:=10; //100
  if Key2 then SpeedDecrease:=20; //Fast braking with constant force

  Car.Speed:=EnsureRange(Car.Speed+(SpeedIncrease-SpeedDecrease)*FrameTime/1000,0,TopSpeed);
  //if (Car.Speed=0)and(Key2) then Car.Speed:=-10;

end else begin
  Car.Speed:=0;
  TurnAngle:=0;
  if Key1 then Car.Speed:=30;
  if Key2 then Car.Speed:=-30;
  if Key3 then TurnAngle:=-60;
  if Key4 then TurnAngle:=60;
end;

Car.Stopped:=(Car.Speed=0)and(TurnAngle=0)and(not Key1)and(not Key2)and(not Key3)and(not Key4);

Form1.Memo1.Lines[0]:='Speed '+inttostr(round(Car.Speed*3.6))+'km/h ('+
                      inttostr(round(SpeedIncrease-SpeedDecrease))+')';
Form1.Memo1.Lines[1]:='M -'+Car.Mode;

CarX:=CarX+(-0*cos(xRot/180*pi)+(Car.Speed*FrameTime*10/1000)*sin(xRot/180*pi));
CarZ:=CarZ+( 0*sin(xRot/180*pi)+(Car.Speed*FrameTime*10/1000)*cos(xRot/180*pi));
CarH:=CarH+TurnAngle*FrameTime/1000;

CarWheels[1].Angle.H:=round(TurnAngle);
CarWheels[2].Angle.H:=round(TurnAngle);

PlaceCarOnTerrain(CarX,CarY,CarZ,CarH,CarP,CarB,'Near',xPos,yPos,zPos,xRot,yRot);

Zoom:=1.6;
CarX:=EnsureRange(CarX,-Qty.BlocksX*512,Qty.BlocksX*512);
CarZ:=EnsureRange(CarZ,-Qty.BlocksZ*512,Qty.BlocksZ*512);
xPos:=CarX;
zPos:=CarZ;
end;


procedure GetPositionFromTRK(TRKNumber:integer; Loc:single; Node:pinteger; X,Y,Z,Fraction:psingle);
var k:integer; Fract:single;
begin
Fract:=0;

if Loc=0 then K:=1 else
if Loc=TRK[TRKNumber].Route[TRKQty[TRKNumber].Nodes].Delta then
K:=TRKQty[TRKNumber].Nodes else
if Loc>TRK[TRKNumber].Route[TRKQty[TRKNumber].Nodes].Delta then begin
Node^:=1; X^:=0; Y^:=0; Z^:=0; Fraction^:=0; exit;
end else

begin
K:=0; while (Loc>TRK[TRKNumber].Route[K].Delta) do inc(K);
dec(K);

Fract:=(Loc-TRK[TRKNumber].Route[K].Delta)/
(TRK[TRKNumber].Route[K+1].Delta-TRK[TRKNumber].Route[K].Delta);
end;

Node^:=K;
X^:=TRK[TRKNumber].Route[K].X*(1-Fract)+TRK[TRKNumber].Route[K+1].X*Fract;
Y^:=TRK[TRKNumber].Route[K].Y*(1-Fract)+TRK[TRKNumber].Route[K+1].Y*Fract;
Z^:=TRK[TRKNumber].Route[K].Z*(1-Fract)+TRK[TRKNumber].Route[K+1].Z*Fract;
Fraction^:=Fract;
end;

procedure GetPositionFromSNI(SNINumber:integer; Loc:single; X,Y,Z:psingle);
var k:integer; Fract:single;
begin
if Loc>SNILen[SNINumber] then begin X^:=0; Y^:=0; Z^:=0; exit; end;
if Loc=0 then begin
X^:=SNINode[SNIObj[SNINumber].firstNode+1].X;
Y^:=SNINode[SNIObj[SNINumber].firstNode+1].Y;
Z^:=SNINode[SNIObj[SNINumber].firstNode+1].Z;
exit; end;
if Loc=SNILen[SNINumber] then begin
X^:=SNINode[SNIObj[SNINumber].firstNode+SNIObj[SNINumber].NumNodes].X;
Y^:=SNINode[SNIObj[SNINumber].firstNode+SNIObj[SNINumber].NumNodes].Y;
Z^:=SNINode[SNIObj[SNINumber].firstNode+SNIObj[SNINumber].NumNodes].Z;
exit; end;

K:=0; while (Loc>SNISubDist[SNINumber,K]) do inc(K);
dec(K);

Fract:=(Loc-SNISubDist[SNINumber,K])/
(SNISubDist[SNINumber,K+1]-SNISubDist[SNINumber,K]);

X^:=SNISubNode[SNINumber,K].X*(1-Fract)+SNISubNode[SNINumber,K+1].X*Fract;
Y^:=SNISubNode[SNINumber,K].Y*(1-Fract)+SNISubNode[SNINumber,K+1].Y*Fract;
Z^:=SNISubNode[SNINumber,K].Z*(1-Fract)+SNISubNode[SNINumber,K+1].Z*Fract;
end;

procedure GetPositionFromSNISpeed(SNINumber:integer; X,Y,Z,H,P,B:psingle);
var n1,n2:integer; SpeedMS,Delta,tx,tz:single; SubN,sn0,sn1,sn2:integer;
begin

  SNILoc[SNINumber]:=frac(SNILoc[SNINumber]/SNILen[SNINumber])*SNILen[SNINumber];

  sn1:=0;
  repeat
  inc(sn1);
  until(SNILoc[SNINumber]<=SNISubDist[SNINumber,sn1+1]); //sn1..<..Loc..<..sn2

  sn2:=sn1+1; if sn2>SNIObj[SNINumber].NumNodes*SNI_LOD then sn2:=1;
  sn0:=sn1-1; if sn0<1 then sn0:=SNIObj[SNINumber].NumNodes*SNI_LOD; //could be used for nice rotation interpolation

  //% between prev and current nodes
  Delta:=(SNILoc[SNINumber]-SNISubDist[SNINumber,sn1])/(SNISubDist[SNINumber,sn2]-SNISubDist[SNINumber,sn1]);

  SubN:=(sn1-1) mod SNI_LOD; //Sub-Node 1..SNI_LOD
  n1:=(sn1-1) div SNI_LOD+1;//Node
  n2:=n1+1; if n2>SNIObj[SNINumber].NumNodes then n2:=1; //Next node
  inc(n1,SNIObj[SNINumber].firstNode);
  inc(n2,SNIObj[SNINumber].firstNode);

  SpeedMS:=(SNINode[n1].Speed*(SNI_LOD-SubN)+SNINode[n2].Speed*(SubN))/SNI_LOD; //speed at current position
  SNILoc[SNINumber]:=SNILoc[SNINumber]+(FrameTime/1000)*SpeedMS*2.777;// *m/s

X^:=SNISubNode[SNINumber,sn1].X*(1-Delta)+SNISubNode[SNINumber,sn2].X*Delta; //10% = 90first+10next
Y^:=SNISubNode[SNINumber,sn1].Y*(1-Delta)+SNISubNode[SNINumber,sn2].Y*Delta;
Z^:=SNISubNode[SNINumber,sn1].Z*(1-Delta)+SNISubNode[SNINumber,sn2].Z*Delta;

P^:=arctan2(SNISubNode[SNINumber,sn2].X-SNISubNode[SNINumber,sn1].X,SNISubNode[SNINumber,sn2].Z-SNISubNode[SNINumber,sn1].Z)*180/pi;
H^:=-arctan2(SNISubNode[SNINumber,sn2].Y-SNISubNode[SNINumber,sn1].Y,SNISubDist[SNINumber,sn2]-SNISubDist[SNINumber,sn1])*180/pi;
  tx:=GetLength(SNISubNode[SNINumber,sn1].X-(SNISubNode[SNINumber,sn0].X+SNISubNode[SNINumber,sn2].X)/2,
                SNISubNode[SNINumber,sn1].Z-(SNISubNode[SNINumber,sn0].Z+SNISubNode[SNINumber,sn2].Z)/2);
  tz:=GetLength((SNISubNode[SNINumber,sn0].X-SNISubNode[SNINumber,sn2].X),
                (SNISubNode[SNINumber,sn0].Z-SNISubNode[SNINumber,sn2].Z));
  Normalize(tx,tz);
B^:=-tx*500;
end;


function CalculateSNIRoutes():boolean;
var ii,kk,h,n0,n1,n2,n,ci:integer; t:single;
    TangA,TangB:array of array[1..3] of single;
    ax,bx,cx,x0,x1,x2,x3:single;
    ay,by,cy,y0,y1,y2,y3:single;
    az,bz,cz,z0,z1,z2,z3:single;
begin
  for ii:=1 to SNIHead.Obj do begin

  setlength(TangA,SNIObj[ii].NumNodes+1);
  setlength(TangB,SNIObj[ii].NumNodes+1);
  setlength(SNISubNode[ii],SNIObj[ii].NumNodes*SNI_LOD+1);
  setlength(SNISubDist[ii],SNIObj[ii].NumNodes*SNI_LOD+1);

     for kk:=1 to SNIObj[ii].NumNodes do begin
     n0:=kk-1; n1:=kk; n2:=kk+1; //n0-prev, n1-this, n2-next
     if n0=0 then n0:=SNIObj[ii].NumNodes;
     if n2>SNIObj[ii].NumNodes then n2:=1;
     inc(n0,SNIObj[ii].firstNode);
     inc(n1,SNIObj[ii].firstNode);
     inc(n2,SNIObj[ii].firstNode);

     ax:=Getlength((SNINode[n1].X-SNINode[n0].X),(SNINode[n1].Y-SNINode[n0].Y),(SNINode[n1].Z-SNINode[n0].Z));
     bx:=Getlength((SNINode[n2].X-SNINode[n1].X),(SNINode[n2].Y-SNINode[n1].Y),(SNINode[n2].Z-SNINode[n1].Z));

     TangA[kk,1]:=(SNINode[n2].X-SNINode[n0].X); //Vector X0-X2
     TangA[kk,2]:=(SNINode[n2].Y-SNINode[n0].Y); //Vector X0-X2
     TangA[kk,3]:=(SNINode[n2].Z-SNINode[n0].Z); //Vector X0-X2
     Normalize(TangA[kk,1],TangA[kk,2],TangA[kk,3]);
     TangB[kk,1]:=TangA[kk,1]*ax/3;
     TangB[kk,2]:=TangA[kk,2]*ax/3;
     TangB[kk,3]:=TangA[kk,3]*ax/3;
     TangA[kk,1]:=TangA[kk,1]*bx/3;
     TangA[kk,2]:=TangA[kk,2]*bx/3;
     TangA[kk,3]:=TangA[kk,3]*bx/3;
     SNITang[n1,1,1]:=SNINode[n1].X+TangA[kk,1];
     SNITang[n1,1,2]:=SNINode[n1].Y+TangA[kk,2];
     SNITang[n1,1,3]:=SNINode[n1].Z+TangA[kk,3];
     SNITang[n1,2,1]:=SNINode[n1].X-TangB[kk,1];
     SNITang[n1,2,2]:=SNINode[n1].Y-TangB[kk,2];
     SNITang[n1,2,3]:=SNINode[n1].Z-TangB[kk,3];
     end;

  ci:=0;

     for kk:=1 to SNIObj[ii].NumNodes do begin
     n1:=kk;
     n2:=kk+1; //n1-this, n2-next
     if n2>SNIObj[ii].NumNodes then n2:=1;
     n:=n2; //Tangent+1
     inc(n1,SNIObj[ii].firstNode);
     inc(n2,SNIObj[ii].firstNode);

        for h:=0 to SNI_LOD-1 do begin
        t:=h/SNI_LOD; //0..0.9
        inc(ci);
        x0:=SNINode[n1].X; x1:=x0+TangA[kk,1];  //this
        x3:=SNINode[n2].X; x2:=x3-TangB[n,1];   //next
        cx:=3*(x1-x0); bx:=3*(x2-x1)-cx; ax:=x3-x0-cx-bx;
        SNISubNode[ii,ci].X:=ax*t*t*t+bx*t*t+cx*t+x0;
        if SNIObj[ii].Mode=5 then SNISubNode[ii,ci].X:=x0*(1-t)+x3*t;

        y0:=SNINode[n1].Y; y1:=y0+TangA[kk,2];
        y3:=SNINode[n2].Y; y2:=y3-TangB[n,2];
        cy:=3*(y1-y0); by:=3*(y2-y1)-cy; ay:=y3-y0-cy-by;
        SNISubNode[ii,ci].Y:=ay*t*t*t+by*t*t+cy*t+y0;
        if SNIObj[ii].Mode=5 then SNISubNode[ii,ci].Y:=y0*(1-t)+y3*t;

        z0:=SNINode[n1].Z; z1:=z0+TangA[kk,3];
        z3:=SNINode[n2].Z; z2:=z3-TangB[n,3];
        cz:=3*(z1-z0); bz:=3*(z2-z1)-cz; az:=z3-z0-cz-bz;
        SNISubNode[ii,ci].Z:=az*t*t*t+bz*t*t+cz*t+z0;
        if SNIObj[ii].Mode=5 then SNISubNode[ii,ci].Z:=z0*(1-t)+z3*t;

        SNISubDist[ii,ci]:=sqrt(
        sqr(SNISubNode[ii,ci].X-SNISubNode[ii,ci-1].X)+
        sqr(SNISubNode[ii,ci].Y-SNISubNode[ii,ci-1].Y)+
        sqr(SNISubNode[ii,ci].Z-SNISubNode[ii,ci-1].Z));
        end;
     end;
     SNISubDist[ii,1]:=0;
     SNISubDist[ii,ci]:=sqrt(
        sqr(SNISubNode[ii,1].X-SNISubNode[ii,ci].X)+
        sqr(SNISubNode[ii,1].Y-SNISubNode[ii,ci].Y)+
        sqr(SNISubNode[ii,1].Z-SNISubNode[ii,ci].Z));
     for kk:=1 to SNIObj[ii].NumNodes*SNI_LOD do
     SNISubDist[ii,kk]:=SNISubDist[ii,kk-1]+SNISubDist[ii,kk];
     SNILen[ii]:=SNISubDist[ii,SNIObj[ii].NumNodes*SNI_LOD];
     if SNIObj[ii].Mode=5 then SNILen[ii]:=SNISubDist[ii,(SNIObj[ii].NumNodes-1)*SNI_LOD];
     SNILoc[ii]:=0;
  end;
Result:=true;
end;

function ReturnListOfChangedFiles(eol:string):string;
var i:integer; s:string;
begin
if Changes.QAD then s:=s+'QAD'+eol;
if Changes.IDX then s:=s+'IDX'+eol;
if Changes.VTX then s:=s+'VTX'+eol;
if Changes.SMP then s:=s+'SMP'+eol;
if Changes.WRK then s:=s+'WRK'+eol;
for i:=1 to 32 do begin
if Changes.TOB[i] then s:=s+'TOB'+int2fix(i,2)+eol;
if Changes.TRK[i] then s:=s+'TRK'+int2fix(i,2)+eol;
if Changes.WTR[i] then s:=s+'WTR'+int2fix(i,2)+eol;
end;
if Changes.SNI then s:=s+'SNI'+eol;
if Changes.LVL then s:=s+'LVL'+eol;
if Changes.SKY then s:=s+'SKY'+eol;
for i:=1 to 4 do
if Changes.RO[i] then s:=s+'RO'+int2fix(i,2)+eol;
if Changes.STR then s:=s+'STR'+eol;
if Changes.TRL then s:=s+'TRL'+eol;
if Changes.SC2 then s:=s+'SC2'+eol;
Result:=s;
end;


end.
