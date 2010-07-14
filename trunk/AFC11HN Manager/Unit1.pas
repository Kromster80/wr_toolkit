unit Unit1;
{$IFDEF FPC} {$MODE Delphi} {$ENDIF}
interface
uses
  {$IFDEF FPC} LResources, LCLIntf, {$ENDIF}
  Windows, SysUtils, Classes, Controls, ExtCtrls, Forms,
  StdCtrls, KromUtils, ComCtrls, CheckLst, Buttons, WR_DataSet, ShellApi, Dialogs;

type
  TForm1 = class(TForm)
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    CLBCars: TCheckListBox;
    Label3: TLabel;
    SaveChanges: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    SAll: TButton;
    SNone: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure OpenDS(Sender: TObject; filename:string);
    procedure SaveDS(Sender: TObject);
    procedure AddCarsToDS(aEditCar:string);
    procedure SearchAutos(Sender: TObject);
    procedure GetAutoInfo(s1:string;i1:integer);
    procedure AboutClick(Sender: TObject);
    procedure WriteINI(Sender: TObject);
    procedure ReadINI(Sender: TObject);
    procedure PopulateCarList();
    procedure SaveDSRun(Sender: TObject);
    procedure CLBCarsClick(Sender: TObject);
    procedure SAllClick(Sender: TObject);
  end;

const
 //These values define where addon cars will be appended. Measured from original DS file
 StockCars      = 54; //Car info
 Stock3DCars    = 57; //3D Model
 StockMotoren   = 33; //Engine
 StockGetriebe  = 14; //Gearbox
 StockReifen    = 72; //Tires

 MaxCars        = 2560;
 VersionInfo    = 'AFC11HN Manager       Version 0.1d (15 Jul 2010)';

var
  Form1: TForm1;
  WorkDir:string;
  zz:string='     '{;//}+'                                                                                        ';

  fHighwayDataSet:TDataSet;

  AddonCarQty:integer;
  AddonCar:array[1..MaxCars]of record
    Folder:string;
    Factory,Model,Name:string;
    Install:boolean;
  end;

implementation
uses Unit2, WR_AboutBox;


procedure TForm1.FormCreate(Sender: TObject);
var s1,s2:string;
begin
  DoClientAreaResize(Self);

  if Sender<>nil then exit; //Wait until all forms are init
  Form2.Show;
  Form2.Repaint;

  WorkDir := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));

  //WorkDir := 'E:\AFC11 - HighwayNights\';

  if not fileexists(WorkDir+'FrontEnd2\FrontEnd.ds') then begin
    Form2.FormStyle := fsNormal;
    MessageBox(Form1.Handle,'".\FrontEnd2\FrontEnd.ds" not found. Run HNMan from AFC11HN folder.','Error',MB_OK);
    Form1.Close;
    exit;
  end;

  s1 := WorkDir + 'FrontEnd2\FrontEnd.ds';
  s2 := WorkDir + 'FrontEnd2\FrontEnd.bak';
  if not FileExists(s2) then CopyFile(@(s1)[1],@(s2)[1],true);

  OpenDS(nil,WorkDir+'FrontEnd2\FrontEnd.ds');

  Form2.Label2.Caption := 'Scanning: Cars ...';     Form2.Label2.Refresh; SearchAutos(nil);         //Form2.Memo1.Lines.Add('Autos - '+ElapsedTime(@TimeCode));
  if Form2.Showing then Form2.Destroy;
  PopulateCarList();
  ReadINI(nil);
end;


procedure TForm1.PopulateCarList();
var i:integer;
begin
  for i:=1 to AddonCarQty do
    CLBCars.Items.Add(AddonCar[i].Folder+zz+int2fix(i,3));
  CLBCars.Refresh;
end;


procedure TForm1.OpenDS(Sender: TObject; filename:string);
begin
  fHighwayDataSet := TDataSet.Create;
  fHighwayDataSet.LoadDS(filename);
end;


procedure TForm1.SaveDS(Sender: TObject);
var i:integer;
begin

  //Restore stock count
  fHighwayDataSet.SetCOLengths(6, StockCars);
  fHighwayDataSet.SetCOLengths(7, Stock3DCars);
  fHighwayDataSet.SetCOLengths(8, StockMotoren);
  fHighwayDataSet.SetCOLengths(9, StockGetriebe);
  fHighwayDataSet.SetCOLengths(10,StockReifen);

  for i:=1 to AddonCarQty do
  if AddonCar[i].Install then
    AddCarsToDS(WorkDir+'\Autos\'+AddonCar[i].Folder+'\EditCar.car');
                             
  fHighwayDataSet.SaveDS(WorkDir+'FrontEnd2\FrontEnd.ds');
  WriteINI(nil);
end;


procedure TForm1.AddCarsToDS(aEditCar:string);
var
  fCarDataSet:TDataSet;
  i:integer;
  ID:integer;
begin

  fCarDataSet := TDataSet.Create;
  fCarDataSet.LoadDS(aEditCar);

  fHighwayDataSet.SetCOLengths(6,  fHighwayDataSet.COCount(6, 2)+1);
  fHighwayDataSet.SetCOLengths(7,  fHighwayDataSet.COCount(7, 2)+1);
  fHighwayDataSet.SetCOLengths(8,  fHighwayDataSet.COCount(8, 2)+1);
  fHighwayDataSet.SetCOLengths(9,  fHighwayDataSet.COCount(9, 2)+1);
  fHighwayDataSet.SetCOLengths(10, fHighwayDataSet.COCount(10,2)+2); //Front&Rear tires

  with fHighwayDataSet do begin
    ID := COCount(6,2); //CarsDB
    SetValue(6, 1,ID,'AddonCar');                         //Kommentar
    SetValue(6, 2,ID, ID-1);                              //Index
    SetValue(6, 3,ID, COCount( 7,2)-1);                   //3D CarID
    SetValue(6, 4,ID, fCarDataSet.GetValue(2, 4,2));      //CarTextID
    SetValue(6, 5,ID, fCarDataSet.GetValue(2, 5,2));      //Score
    SetValue(6, 6,ID, 1);                                 //FlagRelease
    SetValue(6, 7,ID, 0);                                 //ReleaseByCaseID
    for i:=8 to 11 do
    SetValue(6, i,ID, fCarDataSet.GetValue(2, i,2));      //8-11
    SetValue(6,12,ID, COCount( 8,2)-1);                   //MotorID
    SetValue(6,13,ID, COCount( 9,2)-1);                   //GetriebeID
    SetValue(6,14,ID, COCount(10,2)-2);                   //FrontReifenID
    SetValue(6,15,ID, COCount(10,2)-1);                   //RearReifenID
                                                          //16 empty
    for i:=17 to 30 do
    SetValue(6, i,ID, fCarDataSet.GetValue(2, i,2));      //17-30
    SetValue(6,31,ID, fCarDataSet.GetValue(2,33,2));      //Weight_KG
    SetValue(6,32,ID, fCarDataSet.GetValue(2,37,2));      //Antrieb
    SetValue(6,33,ID, fCarDataSet.GetValue(2,38,2));      //Gesamt
    SetValue(6,34,ID, fCarDataSet.GetValue(2,39,2));      //Luftwider
    SetValue(6,35,ID, fCarDataSet.GetValue(2,40,2));      //
    SetValue(6,36,ID, fCarDataSet.GetValue(2,41,2));      //
    SetValue(6,37,ID, fCarDataSet.GetValue(2,42,2));      //SperrDiff
    SetValue(6,38,ID, fCarDataSet.GetValue(2,43,2));      //RaceClass
    SetValue(6,39,ID, fCarDataSet.GetValue(2,44,2));      //ReifenYPos
    SetValue(6,40,ID, fCarDataSet.GetValue(2,45,2));      //0-100
    SetValue(6,41,ID, fCarDataSet.GetValue(2,46,2));      //MphTopSpeed
                                                          //42 empty
    SetValue(6,43,ID, fCarDataSet.GetValue(2, 48,2));     //
    SetValue(6,44,ID, fCarDataSet.GetValue(2, 49,2));     //
    SetValue(6,45,ID, fCarDataSet.GetValue(2,105,2));     //HerstellerName
    SetValue(6,46,ID, fCarDataSet.GetValue(2,106,2));     //HerstellerLogo
    if (not fCarDataSet.IndexInRange(2,107,2)) or (fCarDataSet.GetValue(2,107,2).Str='') then
      SetValue(6,47,ID, 'kein')
    else
      SetValue(6,47,ID, fCarDataSet.GetValue(2,107,2));   //Caravan
    SetValue(6,48,ID, fCarDataSet.GetValue(2,105,2));     //ClassName
    //The rest gets repeaten from last car

    ID := COCount(7,2); //3DCarsDB
                                                          //1 empty
    SetValue(7, 2,ID, ID-1);                              //Index
    SetValue(7, 3,ID, fCarDataSet.GetValue(1, 3,2));      //EngineName
    SetValue(7, 4,ID, fCarDataSet.GetValue(1, 6,2));      //
    SetValue(7, 5,ID, fCarDataSet.GetValue(1, 7,2));      //
    SetValue(7, 6,ID, fCarDataSet.GetValue(1, 8,2));      //
    SetValue(7, 7,ID, fCarDataSet.GetValue(1, 9,2));      //
    SetValue(7, 8,ID, fCarDataSet.GetValue(1,10,2));      //
    SetValue(7, 9,ID, fCarDataSet.GetValue(1,11,2));      //
    SetValue(7,10,ID, fCarDataSet.GetValue(1,12,2));      //
    SetValue(7,11,ID, fCarDataSet.GetValue(1,16,2));      //
    SetValue(7,12,ID, fCarDataSet.GetValue(1,17,2));      //
    SetValue(7,13,ID, fCarDataSet.GetValue(1,18,2));      //
    SetValue(7,14,ID, fCarDataSet.GetValue(1,19,2));      //
    SetValue(7,15,ID, fCarDataSet.GetValue(1,20,2));      //
    SetValue(7,16,ID, fCarDataSet.GetValue(1,21,2));      //
    SetValue(7,17,ID, fCarDataSet.GetValue(1,26,2));      //
    SetValue(7,18,ID, fCarDataSet.GetValue(1,27,2));      //
    SetValue(7,19,ID, fCarDataSet.GetValue(1,28,2));      //
    for i:=20 to 31 do
    SetValue(7, i,ID, 0);                                 //20-31
    SetValue(7,32,ID, fCarDataSet.GetValue(1,44,2));      //KopfXPos
    SetValue(7,33,ID, fCarDataSet.GetValue(1,45,2));      //
    SetValue(7,34,ID, fCarDataSet.GetValue(1,46,2));      //
    SetValue(7,35,ID, fCarDataSet.GetValue(1,47,2));      //
    SetValue(7,36,ID, fCarDataSet.GetValue(1,48,2));      //
    SetValue(7,37,ID, fCarDataSet.GetValue(1,49,2));      //
    SetValue(7,38,ID, fCarDataSet.GetValue(1,50,2));      //
    SetValue(7,39,ID, fCarDataSet.GetValue(1,54,2));      //Tacho1Modus
    SetValue(7,40,ID, fCarDataSet.GetValue(1,55,2));      //
    SetValue(7,41,ID, fCarDataSet.GetValue(1,56,2));      //
    SetValue(7,42,ID, fCarDataSet.GetValue(1,57,2));      //
    SetValue(7,43,ID, fCarDataSet.GetValue(1,58,2));      //
    SetValue(7,44,ID, fCarDataSet.GetValue(1,59,2));      //
    SetValue(7,45,ID, fCarDataSet.GetValue(1,60,2));      //
    SetValue(7,46,ID, fCarDataSet.GetValue(1,61,2));      //
    SetValue(7,47,ID, fCarDataSet.GetValue(1,62,2));      //
    SetValue(7,48,ID, fCarDataSet.GetValue(1,63,2));      //
    SetValue(7,49,ID, fCarDataSet.GetValue(1,64,2));      //Tacho2Modus
    SetValue(7,50,ID, fCarDataSet.GetValue(1,65,2));      //
    SetValue(7,51,ID, fCarDataSet.GetValue(1,66,2));      //
    SetValue(7,52,ID, fCarDataSet.GetValue(1,67,2));      //
    SetValue(7,53,ID, fCarDataSet.GetValue(1,68,2));      //
    SetValue(7,54,ID, fCarDataSet.GetValue(1,69,2));      //
    SetValue(7,55,ID, fCarDataSet.GetValue(1,70,2));      //
    SetValue(7,56,ID, fCarDataSet.GetValue(1,71,2));      //
    SetValue(7,57,ID, fCarDataSet.GetValue(1,72,2));      //
    SetValue(7,58,ID, fCarDataSet.GetValue(1,73,2));      //
    SetValue(7,59,ID, fCarDataSet.GetValue(1,75,2));      //MhaubenKameraHoehe
    SetValue(7,60,ID, fCarDataSet.GetValue(1,76,2));      //

    SetValue(7,62,ID, '');                                //UserVinyl
    SetValue(7,62,ID, 0);                                 //NumVinyls
    SetValue(7,63,ID, '');                                //UserRim
    SetValue(7,64,ID, '');                                //Marker
    SetValue(7,65,ID, fCarDataSet.GetValue(1,81,2));      //ColorIndex
    SetValue(7,66,ID, 0);                                 //DienstWagenFlag
    SetValue(7,67,ID, 1);                                 //FlagColorSelection

    ID := COCount(8,2); //MotorenDB
                                                          //1 empty
    SetValue(8, 2,ID, ID-1);                              //Index
    SetValue(8, 3,ID, fCarDataSet.GetValue(2,50,2));      //
    SetValue(8, 4,ID, fCarDataSet.GetValue(2,51,2));      //
    SetValue(8, 5,ID, fCarDataSet.GetValue(2,52,2));      //
    SetValue(8, 6,ID, fCarDataSet.GetValue(2,53,2));      //
    SetValue(8, 7,ID, fCarDataSet.GetValue(2,54,2));      //
    SetValue(8, 8,ID, fCarDataSet.GetValue(2,55,2));      //
    SetValue(8, 9,ID, fCarDataSet.GetValue(2,56,2));      //
    SetValue(8,10,ID, fCarDataSet.GetValue(2,57,2));      //
    SetValue(8,11,ID, fCarDataSet.GetValue(2,58,2));      //
    SetValue(8,12,ID, fCarDataSet.GetValue(2,59,2));      //
    SetValue(8,13,ID, fCarDataSet.GetValue(2,60,2));      //
    SetValue(8,14,ID, fCarDataSet.GetValue(2,61,2));      //
    SetValue(8,15,ID, fCarDataSet.GetValue(2,62,2));      //
    SetValue(8,16,ID, fCarDataSet.GetValue(2,63,2));      //
    SetValue(8,17,ID, fCarDataSet.GetValue(2,64,2));      //
    SetValue(8,18,ID, fCarDataSet.GetValue(2,65,2));      //
    SetValue(8,19,ID, fCarDataSet.GetValue(2,66,2));      //
    SetValue(8,20,ID, fCarDataSet.GetValue(2,67,2));      //
    SetValue(8,21,ID, fCarDataSet.GetValue(2,68,2));      //
    SetValue(8,22,ID, fCarDataSet.GetValue(2,69,2));      //
    SetValue(8,23,ID, fCarDataSet.GetValue(2,70,2));      //
    SetValue(8,24,ID, fCarDataSet.GetValue(2,71,2));      //
    SetValue(8,25,ID, fCarDataSet.GetValue(2,72,2));      //NMStep
    SetValue(8,26,ID, 0.0);      //10500rpm
    SetValue(8,27,ID, 0.0);      //11000rpm
    SetValue(8,28,ID, fCarDataSet.GetValue(2,75,2));      //SampleRate
                                                          //29 empty
    SetValue(8,30,ID, fCarDataSet.GetValue(2,77,2));      //
    SetValue(8,31,ID, fCarDataSet.GetValue(2,78,2));      //
    SetValue(8,32,ID, fCarDataSet.GetValue(2,79,2));      //
    SetValue(8,33,ID, fCarDataSet.GetValue(2,80,2));      //
    SetValue(8,34,ID, fCarDataSet.GetValue(2,81,2));      //
    SetValue(8,35,ID, fCarDataSet.GetValue(2,82,2));      //NMStep
    SetValue(8,36,ID, fCarDataSet.GetValue(2,84,2));      //Lautstaerke
    SetValue(8,37,ID, fCarDataSet.GetValue(2,101,2));      //
    SetValue(8,38,ID, fCarDataSet.GetValue(2,102,2));      //
    SetValue(8,39,ID, fCarDataSet.GetValue(2,103,2));      //
    SetValue(8,40,ID, fCarDataSet.GetValue(2,104,2));      //
    SetValue(8,41,ID, fCarDataSet.GetValue(2,100,2));      //Drehzahlmesser
    SetValue(8,42,ID, 0.0);      //11500rpm
    SetValue(8,43,ID, 0.0);      //12000rpm
    SetValue(8,44,ID, 0.0);      //12500rpm
    SetValue(8,45,ID, 0.0);      //13000rpm
    SetValue(8,46,ID, 0.0);      //13500rpm
    SetValue(8,47,ID, 0.0);      //14000rpm
    SetValue(8,48,ID, 0.0);      //14500rpm
    SetValue(8,49,ID, 0.0);      //15000rpm
    SetValue(8,50,ID, '');      //ommit SampleMOT
    SetValue(8,51,ID, '');      //ommit SampleAP

    ID := COCount(9,2); //GearboxDB
                                                          //1 empty
    SetValue(9, 2,ID, ID-1);                              //Index
    SetValue(9, 3,ID, fCarDataSet.GetValue(2,85,2));      //
    SetValue(9, 4,ID, fCarDataSet.GetValue(2,86,2));      //1
    SetValue(9, 5,ID, fCarDataSet.GetValue(2,87,2));      //2
    SetValue(9, 6,ID, fCarDataSet.GetValue(2,88,2));      //3
    SetValue(9, 7,ID, fCarDataSet.GetValue(2,89,2));      //4
    SetValue(9, 8,ID, fCarDataSet.GetValue(2,90,2));      //5
    SetValue(9, 9,ID, fCarDataSet.GetValue(2,91,2));      //6
    SetValue(9,10,ID, fCarDataSet.GetValue(2,92,2));      //7
    SetValue(9,11,ID, fCarDataSet.GetValue(2,93,2));      //R

    ID := COCount(10,2)-1; //Front Tires
                                                          //1 empty
    SetValue(10, 2,ID, ID-1);                             //Index
    SetValue(10, 3,ID, fCarDataSet.GetValue(2,94,2));
    SetValue(10, 4,ID, fCarDataSet.GetValue(2,95,2));
    SetValue(10, 5,ID, fCarDataSet.GetValue(2,96,2));

    ID := COCount(10,2); //Rear Tires
                                                          //1 empty
    SetValue(10, 2,ID, ID-1);                             //Index
    SetValue(10, 3,ID, fCarDataSet.GetValue(2,97,2));
    SetValue(10, 4,ID, fCarDataSet.GetValue(2,98,2));
    SetValue(10, 5,ID, fCarDataSet.GetValue(2,99,2));
  end;

  fCarDataSet.Free;
end;


procedure TForm1.SearchAutos(Sender: TObject);
var SearchRec:TSearchRec; i:integer;
begin
  AddonCarQty := 0;
  if not DirectoryExists(WorkDir+'Autos') then begin
    Form2.FormStyle := fsNormal;
    MessageBox(Form1.Handle, '".\Autos\" not found', 'Warning', MB_OK);
    Form2.FormStyle := fsStayOnTop;
    exit;
  end else begin
    FindFirst(WorkDir+'Autos\*', faAnyFile or faDirectory, SearchRec);
    repeat
      if (SearchRec.Attr and faDirectory<>0)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then
      if fileexists(WorkDir+'\Autos\'+SearchRec.Name+'\EditCar.car') then begin
        inc(AddonCarQty);
        AddonCar[AddonCarQty].Folder := SearchRec.Name;
      end;
    until (FindNext(SearchRec)<>0);
    FindClose(SearchRec);
  end;

  Form2.Label3.Visible := true;
  for i:=1 to AddonCarQty do
  begin
    Form2.Label3.Caption := inttostr(i) + '/' + inttostr(AddonCarQty) + ' (' + AddonCar[i].Folder + ')';
    Form2.Label3.Repaint;
    GetAutoInfo(AddonCar[i].Folder, i);
  end;

  Form2.Label3.Visible := false;
end;


procedure TForm1.GetAutoInfo(s1:string; i1:integer);
var fDataSet:TDataSet;
begin
  fDataSet := TDataSet.Create;
  fDataSet.LoadDS(WorkDir+'\Autos\'+s1+'\EditCar.car');
  AddonCar[i1].Factory := fDataSet.GetValueAsString(2,105,2);
  AddonCar[i1].Model   := fDataSet.GetValueAsString(2,4,2);
  fDataSet.Free;
end;


procedure TForm1.AboutClick(Sender: TObject);
begin
  AboutForm.Show(VersionInfo, 'Manages AFC11HN addon cars.', 'AFC11HNMan');
end;


procedure TForm1.WriteINI(Sender: TObject);
var ft:textfile; i:integer;
begin
  assignfile(ft,WorkDir+'HNMan.ini'); rewrite(ft);
  writeln(ft,'AFC11HN Manager INI file');

  writeln(ft);
  writeln(ft,'Cars:');
  for i:=1 to AddOnCarQty do
    if AddonCar[i].Install then begin
    writeln(ft,AddonCar[i].Folder);
  end;
  closefile(ft);
end;


procedure TForm1.ReadINI(Sender: TObject);
var i:integer; s,st:string; ft:textfile;
begin
  if not fileexists(WorkDir+'HNMan.ini') then exit;
  assignfile(ft, WorkDir+'HNMan.ini'); reset(ft);
  readln(ft); readln(ft);

  repeat
    readln(ft,s);
    if s = 'Cars:' then
      repeat
        readln(ft, s);
        //We compare string with AddonCar Folder incase player has some other display format, e.g. RaceClass.Name.Folder
        for i := 0 to CLBCars.Count-1 do
        begin
          st := Copy(CLBCars.Items[i], length(CLBCars.Items[i])-2, 3); //Read last 3 chars
          if AddonCar[strtoint(st)].Folder = s then
            CLBCars.Checked[i] := true;
        end;
      until(s='');
  until(eof(ft));
  closefile(ft);
  CLBCarsClick(nil);
end;


procedure TForm1.SaveDSRun(Sender: TObject);
var aPath:string;
begin
  SaveChanges.Click();
  Form1.Close;
  aPath := WorkDir+'HighwayNights.exe';
  ShellExecute(handle, 'open', @(aPath)[1], nil, nil, SW_SHOWNORMAL);
end;


procedure TForm1.CLBCarsClick(Sender: TObject);
var i:integer;
begin
  for i:=1 to CLBCars.Count do
    AddonCar[i].Install := CLBCars.Checked[i-1];

  if CLBCars.ItemIndex = -1 then exit;
  i := strtoint(Copy(CLBCars.Items[CLBCars.ItemIndex], length(CLBCars.Items[CLBCars.ItemIndex])-2, 3)); //Read last 3 chars
  Label1.Caption := AddonCar[i].Folder;
  Label2.Caption := AddonCar[i].Factory;
  Label4.Caption := AddonCar[i].Model;
end;


procedure TForm1.SAllClick(Sender: TObject);
var i:integer;
begin
  for i:=1 to CLBCars.Count do
  begin
    CLBCars.Checked[i-1] := (Sender=SAll) and (Sender<>SNone);
    AddonCar[i].Install  := (Sender=SAll) and (Sender<>SNone);
  end;
end;


{$IFDEF VER140} {$R *.dfm} {$ENDIF}
{$IFDEF VER150} {$R *.dfm} {$ENDIF}

initialization
{$IFDEF FPC}
  {$I Unit1.lrs}
{$ENDIF}

end.

