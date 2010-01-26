unit SupprtUnit2;
interface
uses SysUtils, KromUtils;

function IDfromSTR(txt:string; IDOrder:integer):integer;
function WRTexte(txt:string):string;

const
ResultType:array[1..3]of string = ('Gold/Silver/Bronze','Special Test','x Multi Speedbucks');

implementation
uses Unit1;

function IDfromSTR(txt:string; IDOrder:integer):integer;
var ID,kk,ii:integer;
begin
kk:=length(txt);
if kk=0 then begin IDfromSTR:=0; exit; end;

for ii:=1 to IDOrder do
repeat
dec(kk);
until((kk=0)or(txt[kk]=' '));
    
ID:=0;
repeat
inc(kk); //set to first digit
ID:=ID*10+strtoint(txt[kk]);
until((kk=length(txt))or(txt[kk+1]=' '));
IDfromSTR:=ID;
end;

function WRTexte(txt:string):string;
var h,m,j:integer; s:string;
begin
if length(txt)<2 then begin WRTexte:=s; exit; end;
h:=2; m:=0;
if txt[1]='[' then
repeat
m:=m*10+strtoint(txt[h]);
inc(h);
until((h=length(txt))or(txt[h]=']')or(txt[h]=':'));
if txt[h]=':' then begin WRTexte:=s; exit; end;
s:=Value[1,3,m+1].Str;
for j:=h+1 to length(txt) do
s:=s+txt[j];
WRTexte:=s;
end;

end.
