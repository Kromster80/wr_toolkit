unit Unit_Triggers;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

 interface
uses Unit1,sysutils,Windows,KromUtils,Math,dglOpenGL,PTXTexture,Defaults;

procedure ListTrigClick_();
procedure ListTrigDblClick_();
procedure AddTriggerClick_();
procedure RemTriggerClick_();
procedure ComputeTriggerClick_(Sender: TObject);

implementation

procedure ListTrigClick_();
var A,B,C,ID:integer;
begin with Form1 do begin
TriggersRefresh:=true;
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
TriggersRefresh:=false;
end;
end;

procedure ListTrigDblClick_();
var ID:integer;
begin with Form1 do begin
ID:=ListTrig.ItemIndex+1;
xPos:=TRL[ID].x;
yPos:=TRL[ID].y;
zPos:=TRL[ID].z;
end;
end;

procedure AddTriggerClick_();
begin  //Duplicate selected item
TriggersRefresh:=true;
Form1.ListTrig.Items.Add('new');
Form1.ListTrig.ItemIndex:=TRLQty;
inc(TRLQty);
Form1.TRL_X.Value:=xPos;
Form1.TRL_Y.Value:=yPos;
Form1.TRL_Z.Value:=zPos;
TriggersRefresh:=false;
ComputeTriggerClick_(nil);
Changes.TRL:=true;
end;

procedure RemTriggerClick_();
var i,ID:integer;
begin
ID:=Form1.ListTrig.ItemIndex+1;
if ID<1 then exit;
TriggersRefresh:=true;
//todo: Form1.ListTrig.Items.DeleteSelected;
dec(TRLQty);
for i:=ID to TRLQty do TRL[i]:=TRL[i+1];
TriggersRefresh:=false;
Form1.ListTrig.ItemIndex:=EnsureRange(ID,1,TRLQty)-1;
Form1.ListTrigClick(nil);
Changes.TRL:=true;
end;

procedure ComputeTriggerClick_(Sender: TObject);
var A,B,C,ID,ii:integer; Nqty,Fqty,Rqty:integer;
begin
with Form1 do begin
if TriggersRefresh then exit;
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
for ii:=1 to TRLQty do if TRL[ii].id1=8 then inc(Nqty) else //Nitro
                       if TRL[ii].id1=15 then inc(Fqty) else//Refuel
                       if TRL[ii].id1=7   then inc(Rqty);   //Repair
  if Nqty>8 then begin
  ii:=TRLQty;
  while(TRL[ii].id1<>8) do dec(ii);
  TRL[ii].id1:=16;
  ListTrig.Items[ii-1]:=inttostr(ii)+'. '+TRLNames[TRL[ii].id1];
  MyMessageBox(Form1.Handle,'Nitro triggers limited to 8','Warning',MB_OK or MB_ICONWARNING or MB_TASKMODAL);
  end;
  if Fqty>8 then begin
  ii:=TRLQty;
  while(TRL[ii].id1<>15) do dec(ii);
  TRL[ii].id1:=16;
  ListTrig.Items[ii-1]:=inttostr(ii)+'. '+TRLNames[TRL[ii].id1];
  MyMessageBox(Form1.Handle,'Refuel triggers limited to 8','Warning',MB_OK or MB_ICONWARNING or MB_TASKMODAL);
  end;
  if Rqty>8 then begin
  ii:=TRLQty;
  while(TRL[ii].id1<>7) do dec(ii);
  TRL[ii].id1:=16;
  ListTrig.Items[ii-1]:=inttostr(ii)+'. '+TRLNames[TRL[ii].id1];
  MyMessageBox(Form1.Handle,'Repair triggers limited to 8','Warning',MB_OK or MB_ICONWARNING or MB_TASKMODAL);
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
Changes.TRL:=true;
end;
end;


end.
