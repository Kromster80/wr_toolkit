unit Unit_Triggers;
interface
uses sysutils,filectrl,Windows,KromUtils,Math,dglOpenGL,Defaults, KromOGLUtils;

const
  TRLnames:array[1..24]of string = (
  ' (1)', ' (2)',
  'Jump Tunnel (3)',              //3
  'Zero gravity',                 //4
  'Jump "Origin-Aim" (5)',        //5
  'Jump Checkpoint (6)',          //6
  'Car repair',                   //7
  'Nitro bottle',                 //8
  '"Jump Ahead" symbol',          //9
  'Car suspension lift',          //10
  'Teleporter',                   //11
  ' (12)', ' (13)',
  'Carwash',                      //14
  'Refuel nitro',                 //15
  'Parking lot',                  //16
  ' (17)', ' (18)', ' (19)', ' (20)', ' (21)', ' (22)', ' (23)', ' (24)');

type
  TSTriggers = class
  private
  public
    Count:integer;
    TRL:array[1..256]of record
      id1,id2:word;
      X,Y,Z,xSize,ySize,zSize:single;
      u1:array[1..6]of shortint;
      Matrix:array[1..9]of single; //Rotation
      x2,y2,z2:single;
      u2:array[1..3]of smallint;
    end;

    function LoadFromFile(aFile:string):boolean;
    procedure SaveToFile(aFile:string);

    function GetName(aItem:integer):string;

    procedure ListTrigClick_();
    procedure ListTrigDblClick_();
    procedure AddTriggerClick_();
    procedure RemTriggerClick_();
    procedure ComputeTriggerClick_(Sender: TObject);

    procedure Render(A:single; ID:integer);
  end;



implementation
uses Unit1;

function TSTriggers.LoadFromFile(aFile:string):boolean;
var
  f:file;
  NumRead:integer;
begin
  Result := false;
  Count := 0;
  if not FileExists(aFile) then exit;

  assignfile(f,aFile);
  reset(f,1);

  repeat
    inc(Count);
    blockread(f,TRL[Count],34,NumRead); //common part
    if NumRead<>0 then
      case TRL[Count].id1 of
        3,6,7,9,10,14..17,19,20,22,23: blockread(f,TRL[Count].Matrix,36);
        4,8,18,21:                     blockread(f,TRL[Count].Matrix,40);
        5,11:                          blockread(f,TRL[Count].Matrix,54);
      end;
  until(NumRead=0);
  dec(Count);
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
  Changes.TRL:=false;
end;


function TSTriggers.GetName(aItem:integer):string;
begin
  Result := inttostr(aItem)+'. '+TRLNames[fTriggers.TRL[aItem].id1];
end;


procedure TSTriggers.Render(A:single; ID:integer);
var ii:integer; h,p,b:integer;
begin
glLineWidth(2);

for ii:=1 to Count do begin
  //Render bounding box
  glPushMatrix;
  if A<>0 then glColor4f(0,0.5,1,A) else kSetColorCode(kObject,ii);
  glbegin(gl_points);
    glvertex3fv(@TRL[ii].x);
  glEnd;
  Matrix2Angles(TRL[ii].Matrix,9,@h,@p,@b);
  glTranslatef(TRL[ii].x,TRL[ii].y,TRL[ii].z);
  glRotatef(h,1,0,0); glRotatef(p,0,1,0); glRotatef(b,0,0,1);
  glTranslatef(TRL[ii].xSize*5,TRL[ii].ySize*5,TRL[ii].zSize*5); //corner point
  glScalef(TRL[ii].xSize*10,TRL[ii].ySize*10,TRL[ii].zSize*10);  //trigger size
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
    glbegin(gl_lines);
    glvertex3fv(@TRL[ii].x);
    glvertex3fv(@TRL[ii].x2);
    glEnd;
    glbegin(gl_points);
    glvertex3fv(@TRL[ii].x2);
    glEnd;
  end;

end;

glLineWidth(LineWidth);

if ID=0 then exit;

if A<>0 then begin
glColor4f(1,0,0,1); //highlight either trigger or destination with red
glbegin(gl_points);
if EditMode='Pointer' then
glvertex3fv(@TRL[ID].x2) else
glvertex3fv(@TRL[ID].x);
glEnd;
end;

end;


procedure TSTriggers.ListTrigClick_();
var A,B,C,ID:integer;
begin
  TriggersRefresh := true;

  with Form1 do begin
    ID:=ListTrig.ItemIndex+1;
    CBTriggerType.ItemIndex:=TRL[ID].id1-1;
    TRL_X.Value:=TRL[ID].x;
    TRL_Y.Value:=TRL[ID].y;
    TRL_Z.Value:=TRL[ID].z;
    TRL_S1.Value:=TRL[ID].xSize;
    TRL_S2.Value:=TRL[ID].ySize;
    TRL_S3.Value:=TRL[ID].zSize;
    Matrix2Angles(TRL[ID].Matrix,9,@a,@b,@c);
    TRL_R1.Value:=a; TRL_R2.Value:=b; TRL_R3.Value:=c;

    if TRL[ID].id1 in [4,8] then Label17.Caption:='Value' else Label17.Caption:='Target X';
    Label17.Enabled:=TRL[ID].id1 in [4,5,8,11];
    Label16.Enabled:=TRL[ID].id1 in [5,11];
    Label15.Enabled:=TRL[ID].id1 in [5,11];
    TRL_P1.Enabled:=TRL[ID].id1 in [4,5,8,11];
    TRL_P2.Enabled:=TRL[ID].id1 in [5,11];
    TRL_P3.Enabled:=TRL[ID].id1 in [5,11];

    TRL_P1.Value:=TRL[ID].x2;
    TRL_P2.Value:=TRL[ID].y2;
    TRL_P3.Value:=TRL[ID].z2;
    TRL_Flags.Text:=inttostr(TRL[ID].u1[1])+' '+inttostr(TRL[ID].u1[2])+' '+inttostr(TRL[ID].u1[3])+' '+
                    inttostr(TRL[ID].u1[4])+' '+inttostr(TRL[ID].u1[5])+' '+inttostr(TRL[ID].u1[6])+'. '+
                    inttostr(TRL[ID].u2[1])+' '+inttostr(TRL[ID].u2[2])+' '+inttostr(TRL[ID].u2[3])+' ';
    xPos:=TRL[ID].x;
    yPos:=TRL[ID].y;
    zPos:=TRL[ID].z;
  end;

  TriggersRefresh := false;
end;


procedure TSTriggers.ListTrigDblClick_();
var ID:integer;
begin
  ID   := Form1.ListTrig.ItemIndex+1;
  xPos := TRL[ID].x;
  yPos := TRL[ID].y;
  zPos := TRL[ID].z;
end;


procedure TSTriggers.AddTriggerClick_();
begin //Duplicate selected item
  TriggersRefresh := true;
  Form1.ListTrig.Items.Add('new');
  Form1.ListTrig.ItemIndex := Count;
  inc(Count);
  Form1.TRL_X.Value := xPos;
  Form1.TRL_Y.Value := yPos;
  Form1.TRL_Z.Value := zPos;
  TriggersRefresh := false;
  ComputeTriggerClick_(nil);

  Changes.TRL := true;
end;


procedure TSTriggers.RemTriggerClick_();
var i,ID:integer;
begin
  ID := Form1.ListTrig.ItemIndex+1;
  if ID<1 then exit;

  TriggersRefresh := true;
  Form1.ListTrig.Items.Delete(Form1.ListTrig.ItemIndex);
  dec(Count);
  for i:=ID to Count do TRL[i]:=TRL[i+1];

  TriggersRefresh := false;
  Form1.ListTrig.ItemIndex := EnsureRange(ID,1,Count)-1;
  Form1.ListTrigClick(nil);

  Changes.TRL := true;
end;


procedure TSTriggers.ComputeTriggerClick_(Sender: TObject);
var A,B,C,ID,ii:integer; Nqty,Fqty,Rqty:integer;
begin
  if TriggersRefresh then exit;

  with Form1 do begin
    if ListTrig.ItemIndex<0 then exit;
    ID:=ListTrig.ItemIndex+1;
    TRL[ID].id1:=EnsureRange(CBTriggerType.ItemIndex+1,1,length(TRLnames));
    TRL[ID].id2:=EnsureRange(CBTriggerType.ItemIndex+1,1,length(TRLnames));

    if TRL[ID].id1 in [4,8] then Label17.Caption:='Value' else Label17.Caption:='Target X';
    Label17.Enabled:=TRL[ID].id1 in [4,5,8,11];
    Label16.Enabled:=TRL[ID].id1 in [5,11];
    Label15.Enabled:=TRL[ID].id1 in [5,11];
    TRL_P1.Enabled:=TRL[ID].id1 in [4,5,8,11];
    TRL_P2.Enabled:=TRL[ID].id1 in [5,11];
    TRL_P3.Enabled:=TRL[ID].id1 in [5,11];

    TRL[ID].x:=TRL_X.Value;
    TRL[ID].y:=TRL_Y.Value;
    TRL[ID].z:=TRL_Z.Value;
    Nqty:=0; Fqty:=0; Rqty:=0;

    for ii:=1 to Count do if TRL[ii].id1=8 then inc(Nqty) else //Nitro
                           if TRL[ii].id1=15 then inc(Fqty) else//Refuel
                           if TRL[ii].id1=7   then inc(Rqty);   //Repair

    if Nqty>8 then begin
      ii:=Count;
      while(TRL[ii].id1<>8) do dec(ii);
      TRL[ii].id1:=16;
      ListTrig.Items[ii-1]:=inttostr(ii)+'. '+TRLNames[TRL[ii].id1];
      MessageBox(Form1.Handle,'Nitro triggers limited to 8','Warning',MB_OK or MB_ICONWARNING or MB_TASKMODAL);
    end;

    if Fqty>8 then begin
      ii:=Count;
      while(TRL[ii].id1<>15) do dec(ii);
      TRL[ii].id1:=16;
      ListTrig.Items[ii-1]:=inttostr(ii)+'. '+TRLNames[TRL[ii].id1];
      MessageBox(Form1.Handle,'Refuel triggers limited to 8','Warning',MB_OK or MB_ICONWARNING or MB_TASKMODAL);
    end;

    if Rqty>8 then begin
      ii:=Count;
      while(TRL[ii].id1<>7) do dec(ii);
      TRL[ii].id1:=16;
      ListTrig.Items[ii-1]:=inttostr(ii)+'. '+TRLNames[TRL[ii].id1];
      MessageBox(Form1.Handle,'Repair triggers limited to 8','Warning',MB_OK or MB_ICONWARNING or MB_TASKMODAL);
    end;

    if (TRL[ID].id1=15)or(TRL[ID].id1=8) then begin
      TRL[ID].xSize:=EnsureRange(TRL_S1.Value,1,20);
      TRL[ID].ySize:=EnsureRange(TRL_S2.Value,2,20);
      TRL[ID].zSize:=EnsureRange(TRL_S3.Value,3,20);
    end else begin
      TRL[ID].xSize:=TRL_S1.Value;
      TRL[ID].ySize:=TRL_S2.Value;
      TRL[ID].zSize:=TRL_S3.Value;
    end;

    a:=TRL_R1.Value; b:=TRL_R2.Value; c:=TRL_R3.Value;
    Angles2Matrix(a,b,c,@TRL[ID].Matrix,9);
    TRL[ID].x2:=TRL_P1.Value;
    TRL[ID].y2:=TRL_P2.Value;
    TRL[ID].z2:=TRL_P3.Value;

    for ii:=1 to 6 do TRL[ID].u1[ii]:=-1;
    for ii:=1 to 3 do TRL[ID].u2[ii]:=-1;

     ListTrig.Items[ID-1]:=inttostr(ID)+'. '+TRLNames[TRL[ID].id1];

    if (Sender=TRL_X)or(Sender=TRL_Y)or(Sender=TRL_Z) then begin
      xPos:=TRL[ID].x;
      yPos:=TRL[ID].y;
      zPos:=TRL[ID].z;
    end;
  end; //with Form1 do begin

  Changes.TRL := true;
end;


end.
