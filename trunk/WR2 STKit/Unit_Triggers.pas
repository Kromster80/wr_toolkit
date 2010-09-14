unit Unit_Triggers;
interface
uses SysUtils, FileCtrl, Windows, KromUtils ,Math, dglOpenGL, Defaults, Unit_Render, KromOGLUtils;

const
  RESTRICT_TRIGGERS = true;
  TRLnames:array[1..24]of string = (
  '/1/', '/2/',
  'Jump Tunnel /3/',              //3
  'Zero gravity',                 //4
  'Jump "Origin-Aim" /5/',        //5
  'Jump Checkpoint /6/',          //6
  'Car repair',                   //7
  'Nitro bottle',                 //8
  '"Jump Ahead" symbol',          //9
  'Car suspension lift',          //10
  'Teleporter',                   //11
  '/12/', '/13/',
  'Carwash',                      //14
  'Refuel nitro',                 //15
  'Parking lot',                  //16
  '/17/', '/18/', '/19/', '/20/', '/21/', '/22/', '/23/', '/24/');


type
  TSTriggers = class
  private
    fCount:integer;
    TRL:array[1..256]of packed record
      id1,id2:word;
      Pos,Scale:Vector3f;
      u1:array[1..6]of shortint;
      Matrix:array[1..9]of single; //Rotation
      Target:Vector3f;
      u2:array[1..3]of smallint;
    end;
    procedure ApplyRestrictions;
    function  GetTriggerType(aIndex:integer):word;
    procedure SetTriggerType(aIndex:integer; aValue:word);
    function  GetPosition(aIndex:integer):Vector3f;
    procedure SetPosition(aIndex:integer; aValue:Vector3f);
    function  GetScale(aIndex:integer):Vector3f;
    procedure SetScale(aIndex:integer; aValue:Vector3f);
    function  GetRotation(aIndex:integer):Vector3i;
    procedure SetRotation(aIndex:integer; aValue:Vector3i);
    function  GetTarget(aIndex:integer):Vector3f;
    procedure SetTarget(aIndex:integer; aValue:Vector3f);
  public
    Changed:boolean;
    property Count:integer read fCount;
    function GetName(aIndex:integer):string;
    property TriggerType[Index:integer]:word read GetTriggerType write SetTriggerType;
    property Position[Index:integer]:Vector3f read GetPosition write SetPosition;
    property Scale[Index:integer]:Vector3f read GetScale write SetScale;
    property Rotation[Index:integer]:Vector3i read GetRotation write SetRotation;
    property Target[Index:integer]:Vector3f read GetTarget write SetTarget;
    function GetFlags(aIndex:integer):string;

    function CanAddTrigger():boolean;
    procedure AddTrigger();
    procedure RemTrigger(aIndex:integer);

    function  LoadFromFile(aFile:string):boolean;
    procedure SaveToFile(aFile:string);
    procedure Render(A:single; ID:integer; aEditMode:string);
  end;



implementation


function  TSTriggers.GetTriggerType(aIndex:integer):word;
begin
  Result := TRL[aIndex].id1;
end;


procedure TSTriggers.SetTriggerType(aIndex:integer; aValue:word);
begin
  TRL[aIndex].id1 := EnsureRange(aValue, 1, length(TRLnames));
  TRL[aIndex].id2 := TRL[aIndex].id1;
  ApplyRestrictions();
end;


function TSTriggers.GetPosition(aIndex:integer):Vector3f;
begin
  Result := TRL[aIndex].Pos;
end;


procedure TSTriggers.SetPosition(aIndex:integer; aValue:Vector3f);
begin
  TRL[aIndex].Pos := aValue;
end;


function TSTriggers.GetScale(aIndex:integer):Vector3f;
begin
  Result := TRL[aIndex].Scale;
end;


procedure TSTriggers.SetScale(aIndex:integer; aValue:Vector3f);
begin
  if RESTRICT_TRIGGERS and (TRL[aIndex].id1 in [8, 15]) then begin
    TRL[aIndex].Scale.X := EnsureRange(aValue.X,1,20);
    TRL[aIndex].Scale.Y := EnsureRange(aValue.Y,2,20);
    TRL[aIndex].Scale.Z := EnsureRange(aValue.Z,3,20);
  end else
    TRL[aIndex].Scale := aValue;
end;


function  TSTriggers.GetRotation(aIndex:integer):Vector3i;
var v:Vector3i;
begin
  Matrix2Angles(TRL[aIndex].Matrix,9,@V.X,@V.Y,@V.Z);
  Result := V;
end;


procedure TSTriggers.SetRotation(aIndex:integer; aValue:Vector3i);
begin
  Angles2Matrix(aValue.X,aValue.Y,aValue.Z,@TRL[aIndex].Matrix,9);
end;


function TSTriggers.GetTarget(aIndex:integer):Vector3f;
begin
  Result := TRL[aIndex].Target;
end;


procedure TSTriggers.SetTarget(aIndex:integer; aValue:Vector3f);
begin
  TRL[aIndex].Target := aValue;
end;


function TSTriggers.GetName(aIndex:integer):string;
begin
  Result := inttostr(aIndex)+'. '+TRLNames[TRL[aIndex].id1];
end;


function TSTriggers.GetFlags(aIndex:integer):string;
begin
  Result := Format('%d %d %d %d %d %d %d %d %d',
            [TRL[aIndex].u1[1], TRL[aIndex].u1[2], TRL[aIndex].u1[3],
             TRL[aIndex].u1[4], TRL[aIndex].u1[5], TRL[aIndex].u1[6],
             TRL[aIndex].u2[1], TRL[aIndex].u2[2], TRL[aIndex].u2[3]]);
end;


function TSTriggers.CanAddTrigger():boolean;
begin
  Result := fCount<=255;
end;


procedure TSTriggers.AddTrigger();
var ii:integer;
begin
  inc(fCount);
  FillChar(TRL[fCount].id1, SizeOf(TRL[fCount]), #0);
  for ii:=1 to 6 do TRL[fCount].u1[ii]:=-1;
  for ii:=1 to 3 do TRL[fCount].u2[ii]:=-1;
  Changed := true;
end;


procedure TSTriggers.RemTrigger(aIndex:integer);
var i:integer;
begin
  dec(fCount);
  for i := aIndex to Count do
    TRL[i] := TRL[i+1]; //Shift everything up
  Changed := true;
end;


procedure TSTriggers.ApplyRestrictions();
const MAX_TRIG=8;
var ii,Nqty,Fqty,Rqty:integer;
begin
  Nqty:=0; Fqty:=0; Rqty:=0;
  for ii:=1 to fCount do
  case TRL[ii].id1 of
    8:  begin inc(Nqty); if NQty>MAX_TRIG then SetTriggerType(ii,16); end; //Nitro
    15: begin inc(Fqty); if FQty>MAX_TRIG then SetTriggerType(ii,16); end; //Refuel
    7:  begin inc(Rqty); if RQty>MAX_TRIG then SetTriggerType(ii,16); end; //Repair
  end;

  if NQty>8 then MessageBox(HWND(nil),'Nitro triggers count is limited to 8 max','Warning',MB_OK or MB_ICONWARNING or MB_TASKMODAL);
  if FQty>8 then MessageBox(HWND(nil),'Refuel triggers count is limited to 8 max','Warning',MB_OK or MB_ICONWARNING or MB_TASKMODAL);
  if Rqty>8 then MessageBox(HWND(nil),'Repair triggers count is limited to 8 max','Warning',MB_OK or MB_ICONWARNING or MB_TASKMODAL);

  if (NQty>8)or(FQty>8)or(RQty>8) then
    Changed := true;
end;


function TSTriggers.LoadFromFile(aFile:string):boolean;
var
  f:file;
  NumRead:integer;
begin
  Result := false;
  fCount := 0;
  if not FileExists(aFile) then exit;

  assignfile(f,aFile);
  reset(f,1);

  repeat
    inc(fCount);
    blockread(f,TRL[fCount],34,NumRead); //common part
    if NumRead<>0 then
      case TRL[fCount].id1 of
        3,6,7,9,10,14..17,19,20,22,23: blockread(f,TRL[fCount].Matrix,36);
        4,8,18,21:                     blockread(f,TRL[fCount].Matrix,40);
        5,11:                          blockread(f,TRL[fCount].Matrix,54);
      end;
  until(NumRead=0);
  dec(fCount);
  closefile(f);
  Result := true;
end;


procedure TSTriggers.SaveToFile(aFile:string);
var
  f:file;
  i:integer;
begin
  assignfile(f,aFile);
  rewrite(f,1);
  for i:=1 to Count do
  if TRL[i].id1<>0 then begin
    blockwrite(f,TRL[i],34);
    case TRL[i].id1 of
      3,6,7,9,10,14,15,16:blockwrite(f,TRL[i].Matrix,36);
      4,8:                blockwrite(f,TRL[i].Matrix,40);
      5,11:               blockwrite(f,TRL[i].Matrix,54);
    end;
  end;
  closefile(f);
  //Form1.Memo1.Lines.Add('Triggers saved in'+ElapsedTime(@OldTime));
  Changed := false;
end;


procedure TSTriggers.Render(A:single; ID:integer; aEditMode:string);
var ii:integer; h,p,b:integer;
begin
  glLineWidth(2);

  for ii:=1 to Count do begin
    //Render bounding boxes
    glPushMatrix;
    if A<>0 then glColor4f(0,0.5,1,A) else kSetColorCode(kObject,ii);
    glBegin(GL_POINTS);
      glVertex3fv(@TRL[ii].Pos);
    glEnd;
    Matrix2Angles(TRL[ii].Matrix,9,@h,@p,@b);
    glTranslatef(TRL[ii].Pos.X,TRL[ii].Pos.Y,TRL[ii].Pos.Z);
    glRotatef(h,1,0,0); glRotatef(p,0,1,0); glRotatef(b,0,0,1);
    glTranslatef(TRL[ii].Scale.X*5,TRL[ii].Scale.Y*5,TRL[ii].Scale.Z*5); //corner point
    glScalef(TRL[ii].Scale.X*10,TRL[ii].Scale.Y*10,TRL[ii].Scale.Z*10);  //trigger size
    if A<>1 then glCallList(coBox);
    glCallList(coBoxW);

    glPushMatrix;
      glRotatef(90,0,0,1);
      if TRL[ii].id1 in [9,11,14] then glCallList(coArrow);
    glPopMatrix;

    if A<>0 then begin
      glRasterPos3f(0,0,0);
      glPrint(inttostr(TRL[ii].id1));
    end;
    glPopMatrix;

    //Render line for teleport and other thing
    if TRL[ii].id1 in [5,11] then begin
      if A<>0 then glColor4f(1,1,1,A) else kSetColorCode(kPoint,ii);
      glBegin(GL_LINES);
        glVertex3fv(@TRL[ii].Pos);
        glVertex3fv(@TRL[ii].Target);
      glEnd;
      glBegin(GL_POINTS);
        glVertex3fv(@TRL[ii].Target);
      glEnd;
    end;

  end;

  glLineWidth(LineWidth);

  if ID=0 then exit;

  if A<>0 then begin
    glColor4f(1,0,0,1); //highlight either trigger or destination with red
    glBegin(GL_POINTS);
    if aEditMode='Pointer' then
      glvertex3fv(@TRL[ID].Target)
    else
      glvertex3fv(@TRL[ID].Pos);
    glEnd;
  end;  
end;



end.
