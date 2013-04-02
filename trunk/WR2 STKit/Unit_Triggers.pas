unit Unit_Triggers;
interface
uses Classes, SysUtils, FileCtrl, Windows, KromUtils ,Math, dglOpenGL,
  Unit_Defaults, Unit_Render, KromOGLUtils;

const
  RESTRICT_TRIGGERS = True;
  TRLnames: array [0..24] of string = (
  '', '/1/', '/2/',
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
    fType1, fType2: Word;
    fPosition: Vector3f;
    fScale: Vector3f;
    u1: array [1 .. 6] of ShortInt;
    fMatrix:array[1..9]of Single; //Rotation
    fTarget:Vector3f;
    u2:array[1..3]of SmallInt;
    Changed:Boolean;
    function  GetTriggerType: Word;
    procedure SetTriggerType(aValue:word);
    procedure SetPosition(aValue:Vector3f);
    procedure SetScale(aValue:Vector3f);
    function  GetRotation:Vector3i;
    procedure SetRotation(aValue:Vector3i);
    procedure SetTarget(aValue:Vector3f);
    function  GetFlags:string;
  public
    constructor Create;
    procedure LoadFromStream(Stream:TMemoryStream);
    procedure SaveToStream(Stream:TMemoryStream);
    property TriggerType: Word read GetTriggerType write SetTriggerType;
    property Position: Vector3f read fPosition write SetPosition;
    property Scale: Vector3f read fScale write SetScale;
    property Rotation: Vector3i read GetRotation write SetRotation;
    property Target: Vector3f read fTarget write SetTarget;
    property Flags: string read GetFlags;
    function Title: string;
  end;

  TSTriggersCollection = class
  private
    fChanged: Boolean;
    fTriggers: TList;
    procedure Clear;
    function GetChanged: Boolean;
    function GetTrigger(aIndex: Integer):TSTrigger;
    function GetCount: Integer; //Returns Trigger
  public
    constructor Create;
    destructor Destroy; override;
    property Changed: Boolean read GetChanged;
    property Count: Integer read GetCount;
    property Triggers[aIndex: Integer]: TSTrigger read GetTrigger; default;
    procedure ApplyRestrictions;

    function  AddTrigger(aPos: vector3f): Boolean;
    procedure Delete(aIndex: Integer);

    function  LoadFromFile(aFile:string): Boolean;
    procedure SaveToFile(aFile:string);
    procedure Render(A: Single; Id: Integer; aEditMode: TEditingMode);
  end;


implementation


constructor TSTrigger.Create;
var
  I: Integer;
begin
  inherited;

  fType1 := 1;
  fType2 := 1;
  Scale := Vectorize(10.0, 10.0, 10.0);

  FillChar(u1, SizeOf(u1), #255);
  FillChar(u2, SizeOf(u2), #255);
end;


procedure TSTrigger.LoadFromStream(Stream: TMemoryStream);
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


procedure TSTrigger.SaveToStream(Stream: TMemoryStream);
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


function TSTrigger.GetTriggerType: Word;
begin
  Result := fType1;
end;


procedure TSTrigger.SetTriggerType(aValue: Word);
begin
  fType1 := aValue;
  fType2 := aValue;
end;


procedure TSTrigger.SetPosition(aValue: Vector3f);
begin
  fPosition := aValue;
end;


procedure TSTrigger.SetScale(aValue: Vector3f);
begin
  if RESTRICT_TRIGGERS and (fType1 in [8, 15]) then
  begin
    fScale.X := EnsureRange(aValue.X,1,20);
    fScale.Y := EnsureRange(aValue.Y,2,20);
    fScale.Z := EnsureRange(aValue.Z,3,20);
  end else
    fScale := aValue;
end;


function TSTrigger.GetRotation: Vector3i;
var v: Vector3i;
begin
  Matrix2Angles(fMatrix, 9, @v.X, @v.Y, @v.Z);
  Result := V;
end;


procedure TSTrigger.SetRotation(aValue: Vector3i);
begin
  Angles2Matrix(aValue.X, aValue.Y, aValue.Z, @fMatrix, 9);
end;


procedure TSTrigger.SetTarget(aValue: Vector3f);
begin
  fTarget := aValue;
end;


function TSTrigger.GetFlags: string;
begin
  Result := Format('%d %d %d %d %d %d %d %d %d',
            [u1[1], u1[2], u1[3], u1[4], u1[5], u1[6], u2[1], u2[2], u2[3]]);
end;


function TSTrigger.Title: string;
begin
  Result := TRLNames[fType1];
end;


{ TSTriggersColleaction }
constructor TSTriggersCollection.Create;
begin
  inherited;

  fTriggers := TList.Create;
end;


destructor TSTriggersCollection.Destroy;
begin
  fTriggers.Free;

  inherited;
end;


procedure TSTriggersCollection.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Triggers[I].Free;

  fTriggers.Clear;
end;


function TSTriggersCollection.GetChanged: Boolean;
var
  I: Integer;
begin
  Result := fChanged;
  for I := 0 to Count - 1 do
    Result := Result and Triggers[I].Changed;
end;


function TSTriggersCollection.GetCount: Integer;
begin
  Result := fTriggers.Count;
end;


function TSTriggersCollection.GetTrigger(aIndex: Integer): TSTrigger;
begin
  Result := fTriggers[aIndex];
end;


function TSTriggersCollection.AddTrigger(aPos: vector3f): Boolean;
var
  T: TSTrigger;
begin
  if Count > 255 then
  begin
    MessageBox(0, 'Can''t add more than 256 objects to a scenery', 'Warning', MB_ICONEXCLAMATION or MB_OK);
    Result := False;
    Exit;
  end;

  T := TSTrigger.Create;
  T.Position := aPos;

  fTriggers.Add(T);

  fChanged := True;
  Result := True;
end;


procedure TSTriggersCollection.Delete(aIndex: Integer);
begin
  Triggers[aIndex].Free;
  fTriggers.Delete(aIndex);
  fChanged := True;
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

  for I := 0 to Count - 1 do
  case Triggers[I].TriggerType of
    7:  begin // Repair
          Inc(RepairCount);
          if RepairCount > MAX_TRIG then
            Triggers[I].TriggerType := 16;
        end;
    8:  begin // Nitro
          Inc(NitroCount);
          if NitroCount > MAX_TRIG then
            Triggers[I].TriggerType := 16;
        end;
    15: begin // Refuel
          Inc(FuelCount);
          if FuelCount > MAX_TRIG then
            Triggers[I].TriggerType := 16;
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


function TSTriggersCollection.LoadFromFile(aFile: string): boolean;
var
  I: Integer;
  S: TMemoryStream;
  T: TSTrigger;
begin
  Result := False;
  Clear;
  if not FileExists(aFile) then Exit;

  S := TMemoryStream.Create;
  try
    S.LoadFromFile(aFile);

    while (S.Position <> S.Size) do
    begin
      T := TSTrigger.Create;
      T.LoadFromStream(S);
      fTriggers.Add(T);
    end;

    fChanged := False;
    Result := True;
  finally
    S.Free;
  end;
end;


procedure TSTriggersCollection.SaveToFile(aFile: string);
var
  I: Integer;
  S: TMemoryStream;
begin
  S := TMemoryStream.Create;
  try
    for I := 0 to Count - 1 do
      Triggers[I].SaveToStream(S);

    S.SaveToFile(aFile);
    fChanged := False;
  finally
    S.Free;
  end;
end;


procedure TSTriggersCollection.Render(A: Single; Id: Integer; aEditMode: TEditingMode);
var
  I: Integer;
  h,p,b: Integer;
begin
  glLineWidth(2);

  for I := 0 to Count - 1 do
  begin
    //Render bounding boxes
    glPushMatrix;
    if A<>0 then glColor4f(0,0.5,1,A) else kSetColorCode(kObject,I);
    glBegin(GL_POINTS);
      glVertex3fv(@Triggers[I].fPosition);
    glEnd;
    Matrix2Angles(Triggers[I].fMatrix, 9, @h, @p, @b);
    glTranslatef(Triggers[I].fPosition.X, Triggers[I].fPosition.Y, Triggers[I].fPosition.Z);
    glRotatef(h,1,0,0); glRotatef(p,0,1,0); glRotatef(b,0,0,1);
    glTranslatef(Triggers[I].fScale.X*5, Triggers[I].fScale.Y*5, Triggers[I].fScale.Z*5); //corner point
    glScalef(Triggers[I].fScale.X*10, Triggers[I].fScale.Y*10, Triggers[I].fScale.Z*10);  //trigger size
    if A<>1 then glCallList(coBox);
    glCallList(coBoxW);

    glPushMatrix;
      glRotatef(90,0,0,1);
      if Triggers[I].TriggerType in [9,11,14] then glCallList(coArrow);
    glPopMatrix;

    if A <> 0 then
    begin
      glRasterPos3f(0,0,0);
      glPrint(inttostr(Triggers[I].TriggerType));
    end;
    glPopMatrix;

    //Render line for teleport and other thing
    if Triggers[I].TriggerType in [5,11] then
    begin
      if A <> 0 then glColor4f(1,1,1,A) else kSetColorCode(kPoint,I);
      glBegin(GL_LINES);
        glVertex3fv(@Triggers[I].fPosition);
        glVertex3fv(@Triggers[I].fTarget);
      glEnd;
      glBegin(GL_POINTS);
        glVertex3fv(@Triggers[I].fTarget);
      glEnd;
    end;

  end;

  glLineWidth(LineWidth);

  if (Id <> -1) and (A <> 0) then
  begin
    glColor4f(1,0,0,1); //highlight either trigger or destination with red
    glBegin(GL_POINTS);
    if aEditMode = emTriggerDest then
      glvertex3fv(@Triggers[Id].fTarget)
    else
      glvertex3fv(@Triggers[Id].fPosition);
    glEnd;
  end;
end;


end.
