unit Unit_Triggers;
interface
uses Classes, SysUtils, FileCtrl, Windows, KromUtils ,Math, dglOpenGL, Unit_Defaults, Unit_Render, KromOGLUtils;

const
  RESTRICT_TRIGGERS = True;
  TRLnames: array [1..24] of string = (
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
  TSTrigger = class
  private
    fType1,fType2:word;
    fPosition:Vector3f;
    fScale:Vector3f;
    u1:array[1..6]of shortint;
    fMatrix:array[1..9]of single; //Rotation
    fTarget:Vector3f;
    u2:array[1..3]of smallint;
    Changed:boolean;
    function  GetTriggerType():word;
    procedure SetTriggerType(aValue:word);
    procedure SetPosition(aValue:Vector3f);
    procedure SetScale(aValue:Vector3f);
    function  GetRotation():Vector3i;
    procedure SetRotation(aValue:Vector3i);
    procedure SetTarget(aValue:Vector3f);
    function  GetFlags():string;
  public
    constructor Create;
    procedure LoadFromStream(Stream:TMemoryStream);
    procedure SaveToStream(Stream:TMemoryStream);
    property TriggerType:word read GetTriggerType write SetTriggerType;
    property Position:Vector3f read fPosition write SetPosition;
    property Scale:Vector3f read fScale write SetScale;
    property Rotation:Vector3i read GetRotation write SetRotation;
    property Target:Vector3f read fTarget write SetTarget;
    property Flags:string read GetFlags;
    function GetName:string;
  end;

  TSTriggersCollection = class
  private
    fChanged:boolean;
    fCount:integer;
    fTriggers:array of TSTrigger;
    procedure Clear;
    function GetChanged:boolean;
    function GetTrigger(aIndex:integer):TSTrigger; //Returns Trigger
  public
    property Changed:boolean read GetChanged;
    property Count:integer read fCount;
    property Trigger[aIndex:integer]:TSTrigger read GetTrigger; default;
    function TriggerName(aIndex:integer):string; //Includes ID
    procedure ApplyRestrictions;

    function  AddTrigger(aPos:vector3f):boolean;
    procedure RemTrigger(aIndex:integer);

    function  LoadFromFile(aFile:string):boolean;
    procedure SaveToFile(aFile:string);
    procedure Render(A:single; ID:integer; aEditMode:TEditingMode);
  end;


implementation


constructor TSTrigger.Create;
var i:integer;
begin
  Inherited;
  fType1 := 1;
  fType2 := 1;
  Scale := Vectorize(10.0,10.0,10.0);
  Rotation := Vectorize(0,0,0);
  for i:=1 to 6 do u1[i] := -1;
  for i:=1 to 3 do u2[i] := -1;
end;


procedure TSTrigger.LoadFromStream(Stream:TMemoryStream);
begin
  Stream.Read(fType1, 2);
  Stream.Read(fType2, 2);
  Stream.Read(fPosition, 12);
  Stream.Read(fScale, 12);
  Stream.Read(u1, 6);
  case fType1 of
    3,6,7,9,10,14..17,19,20,22,23: Stream.Read(fMatrix, 36);
    4,8,18,21:                     begin
                                     Stream.Read(fMatrix, 36);
                                     Stream.Read(fTarget, 4);
                                   end;
    5,11:                          begin
                                     Stream.Read(fMatrix, 36);
                                     Stream.Read(fTarget, 12);
                                     Stream.Read(u2, 6);
                                   end;
  end;
end;


procedure TSTrigger.SaveToStream(Stream:TMemoryStream);
begin
  Stream.Write(fType1, 2);
  Stream.Write(fType2, 2);
  Stream.Write(fPosition, 12);
  Stream.Write(fScale, 12);
  Stream.Write(u1, 6);
  case fType1 of
    3,6,7,9,10,14..17,19,20,22,23: Stream.Write(fMatrix, 36);
    4,8,18,21:                     begin
                                     Stream.Write(fMatrix, 36);
                                     Stream.Write(fTarget, 4);
                                   end;
    5,11:                          begin
                                     Stream.Write(fMatrix, 36);
                                     Stream.Write(fTarget, 12);
                                     Stream.Write(u2, 6);
                                   end;
  end;
  Changed := false;
end;


function TSTrigger.GetTriggerType:word;
begin
  Result := fType1;
end;


procedure TSTrigger.SetTriggerType(aValue:word);
begin
  fType1 := aValue;
  fType2 := aValue;
end;


procedure TSTrigger.SetPosition(aValue:Vector3f);
begin
  fPosition := aValue;
end;


procedure TSTrigger.SetScale(aValue:Vector3f);
begin
  if RESTRICT_TRIGGERS and (fType1 in [8, 15]) then begin
    fScale.X := EnsureRange(aValue.X,1,20);
    fScale.Y := EnsureRange(aValue.Y,2,20);
    fScale.Z := EnsureRange(aValue.Z,3,20);
  end else
    fScale := aValue;
end;


function TSTrigger.GetRotation():Vector3i;
var v:Vector3i;
begin
  Matrix2Angles(fMatrix,9,@V.X,@V.Y,@V.Z);
  Result := V;
end;


procedure TSTrigger.SetRotation(aValue:Vector3i);
begin
  Angles2Matrix(aValue.X,aValue.Y,aValue.Z,@fMatrix,9);
end;


procedure TSTrigger.SetTarget(aValue:Vector3f);
begin
  fTarget := aValue;
end;


function TSTrigger.GetFlags():string;
begin
  Result := Format('%d %d %d %d %d %d %d %d %d',
            [u1[1], u1[2], u1[3], u1[4], u1[5], u1[6], u2[1], u2[2], u2[3]]);
end;


function TSTrigger.GetName():string;
begin
  Result := TRLNames[fType1];
end;


{ TSTriggersColleaction }
procedure TSTriggersCollection.Clear;
var i:integer;
begin
  for i:=1 to fCount do
    fTriggers[i].Free;
  fCount := 0;
end;


function TSTriggersCollection.GetChanged:boolean;
var i:integer;
begin
  Result := fChanged;
  for i:=1 to fCount do
    Result := Result and fTriggers[i].Changed;
end;


function TSTriggersCollection.GetTrigger(aIndex:integer):TSTrigger;
begin
  Result := fTriggers[aIndex];
end;


function TSTriggersCollection.TriggerName(aIndex:integer):string;
begin
  Result := inttostr(aIndex) + '. ' + fTriggers[aIndex].GetName;
end;


function TSTriggersCollection.AddTrigger(aPos:vector3f):boolean;
begin
  if fCount>255 then begin
    MessageBox(0, 'Can''t add more than 256 objects to a scenery', 'Warning', MB_ICONEXCLAMATION or MB_OK);
    Result := false;
    exit;
  end;

  inc(fCount);
  setlength(fTriggers, fCount+1);
  fTriggers[fCount] := TSTrigger.Create;
  fTriggers[fCount].Position := aPos;

  fChanged := true;
  Result := true;
end;


procedure TSTriggersCollection.RemTrigger(aIndex:integer);
var i:integer;
begin
  dec(fCount);
  for i:=aIndex to fCount do
    fTriggers[i] := fTriggers[i+1]; //Shift everything up
  fTriggers[fCount+1].Free; //Delete last one
  fChanged := true;
end;


procedure TSTriggersCollection.ApplyRestrictions;
const
  MAX_TRIG = 8;
var
  I: Integer;
  RepairCount, NitroCount, FuelCount: Integer;
begin
  RepairCount := 0;
  NitroCount := 0;
  FuelCount := 0;

  for I := 1 to fCount do
  case fTriggers[I].TriggerType of
    7:  begin // Repair
          Inc(RepairCount);
          if RepairCount > MAX_TRIG then
            fTriggers[I].TriggerType := 16;
        end;
    8:  begin // Nitro
          Inc(NitroCount);
          if NitroCount > MAX_TRIG then
            fTriggers[I].TriggerType := 16;
        end;
    15: begin // Refuel
          Inc(FuelCount);
          if FuelCount > MAX_TRIG then
            fTriggers[I].TriggerType := 16;
        end;
    end;

  if RepairCount > MAX_TRIG then
    MessageBox(HWND(nil), 'Repair triggers count is limited to 8 max', 'Warning',
      MB_OK or MB_ICONWARNING or MB_TASKMODAL);
  if NitroCount > MAX_TRIG then
    MessageBox(HWND(nil), 'Nitro triggers count is limited to 8 max', 'Warning',
      MB_OK or MB_ICONWARNING or MB_TASKMODAL);
  if FuelCount > MAX_TRIG then
    MessageBox(HWND(nil), 'Refuel triggers count is limited to 8 max', 'Warning',
      MB_OK or MB_ICONWARNING or MB_TASKMODAL);

  if (NitroCount > MAX_TRIG) or (FuelCount > MAX_TRIG) or (RepairCount > MAX_TRIG) then
    fChanged := True;
end;


function TSTriggersCollection.LoadFromFile(aFile:string):boolean;
var i:integer; S:TMemoryStream;
begin
  Result := false;
  Clear;
  if not FileExists(aFile) then exit;

  S := TMemoryStream.Create;
  try
    S.LoadFromFile(aFile);

    fCount := 255;
    setlength(fTriggers, fCount+1);

    for i:=1 to fCount do
    begin
      if S.Position = S.Size then
      begin
        fCount := i-1;
        setlength(fTriggers, fCount+1);
        break;
      end;
      fTriggers[i] := TSTrigger.Create;
      fTriggers[i].LoadFromStream(S);
    end;
    fChanged := false;
    Result := true;
  finally
    S.Free;
  end;
end;


procedure TSTriggersCollection.SaveToFile(aFile:string);
var i:integer; S:TMemoryStream;
begin
  S := TMemoryStream.Create;
  try
    for i:=1 to fCount do
      fTriggers[i].SaveToStream(S);

    S.SaveToFile(aFile);
    fChanged := false;
  finally
    S.Free;
  end;
end;


procedure TSTriggersCollection.Render(A:single; ID:integer; aEditMode:TEditingMode);
var ii:integer; h,p,b:integer;
begin
  glLineWidth(2);

  for ii:=1 to Count do begin
    //Render bounding boxes
    glPushMatrix;
    if A<>0 then glColor4f(0,0.5,1,A) else kSetColorCode(kObject,ii);
    glBegin(GL_POINTS);
      glVertex3fv(@fTriggers[ii].fPosition);
    glEnd;
    Matrix2Angles(fTriggers[ii].fMatrix,9,@h,@p,@b);
    glTranslatef(fTriggers[ii].fPosition.X,fTriggers[ii].fPosition.Y,fTriggers[ii].fPosition.Z);
    glRotatef(h,1,0,0); glRotatef(p,0,1,0); glRotatef(b,0,0,1);
    glTranslatef(fTriggers[ii].fScale.X*5,fTriggers[ii].fScale.Y*5,fTriggers[ii].fScale.Z*5); //corner point
    glScalef(fTriggers[ii].fScale.X*10,fTriggers[ii].fScale.Y*10,fTriggers[ii].fScale.Z*10);  //trigger size
    if A<>1 then glCallList(coBox);
    glCallList(coBoxW);

    glPushMatrix;
      glRotatef(90,0,0,1);
      if fTriggers[ii].TriggerType in [9,11,14] then glCallList(coArrow);
    glPopMatrix;

    if A<>0 then begin
      glRasterPos3f(0,0,0);
      glPrint(inttostr(fTriggers[ii].TriggerType));
    end;
    glPopMatrix;

    //Render line for teleport and other thing
    if fTriggers[ii].TriggerType in [5,11] then begin
      if A<>0 then glColor4f(1,1,1,A) else kSetColorCode(kPoint,ii);
      glBegin(GL_LINES);
        glVertex3fv(@fTriggers[ii].fPosition);
        glVertex3fv(@fTriggers[ii].fTarget);
      glEnd;
      glBegin(GL_POINTS);
        glVertex3fv(@fTriggers[ii].fTarget);
      glEnd;
    end;

  end;

  glLineWidth(LineWidth);

  if ID=0 then exit;

  if A<>0 then begin
    glColor4f(1,0,0,1); //highlight either trigger or destination with red
    glBegin(GL_POINTS);
    if aEditMode=emTriggerDest then
      glvertex3fv(@fTriggers[ID].fTarget)
    else
      glvertex3fv(@fTriggers[ID].fPosition);
    glEnd;
  end;
end;


end.
