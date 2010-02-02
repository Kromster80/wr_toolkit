unit SupprtUnit2;

interface

uses sysutils, graphics;

function IDfromSTR(txt:string; Num:integer):integer;
function WRTexte(txt:string):string;

const
PresetColor: array[1..15]of TColor = (
$000000,$000080,$0000D0,$0060C0,$00B0D0,
$0080F0,$D0D0D0,$404040,$405000,$006000,
$600000,$A05050,$602060,$909090,$808080);

CTABLen: array[1..87,1..3] of integer =(
{1} (2500553,2500797,244), 	//vs_2_0  	CTABSize=244	CodeSize=468
{2} (2501265,2501462,197), 	//vs_2_0  	CTABSize=197	CodeSize=411
{3} (2501873,2502117,244), 	//vs_2_0  	CTABSize=244	CodeSize=468
{4} (2502585,2502665,80), 	//vs_2_0  	CTABSize=80	CodeSize=216
{5} (2502881,2503225,344), 	//vs_2_0  	CTABSize=344	CodeSize=464
{6} (2503689,2503950,261), 	//vs_2_0  	CTABSize=261	CodeSize=459
{7} (2504409,2504705,296), 	//vs_2_0  	CTABSize=296	CodeSize=568
{8} (2505273,2505401,128), 	//vs_2_0  	CTABSize=128	CodeSize=320
{9} (2505721,2506065,344), 	//vs_2_0  	CTABSize=344	CodeSize=488
{10} (2506553,2506941,388), 	//vs_2_0  	CTABSize=388	CodeSize=1596
{11} (2508537,2508749,212), 	//vs_2_0  	CTABSize=212	CodeSize=340
{12} (2509089,2509349,260), 	//vs_2_0  	CTABSize=260	CodeSize=892
{13} (2510241,2510502,261), 	//vs_2_0  	CTABSize=261	CodeSize=435
{14} (2510937,2511201,264), 	//vs_2_0  	CTABSize=264	CodeSize=680
{15} (2511881,2512173,292), 	//vs_2_0  	CTABSize=292	CodeSize=492
{16} (2512665,2512921,256), 	//vs_2_0  	CTABSize=256	CodeSize=968
{17} (2513889,2514097,208), 	//vs_2_0  	CTABSize=208	CodeSize=480
{18} (2514577,2514837,260), 	//vs_2_0  	CTABSize=260	CodeSize=700
{19} (2515537,2515781,244), 	//vs_2_0  	CTABSize=244	CodeSize=548
{20} (2516329,2516537,208), 	//vs_2_0  	CTABSize=208	CodeSize=1032
{21} (2517569,2517729,160), 	//vs_2_0  	CTABSize=160	CodeSize=544
{22} (2518273,2518485,212), 	//vs_2_0  	CTABSize=212	CodeSize=748
{23} (2519233,2519369,136), 	//vs_2_0  	CTABSize=136	CodeSize=416
{24} (2519785,2519945,160), 	//vs_2_0  	CTABSize=160	CodeSize=280
{25} (2520225,2520529,304), 	//vs_2_0  	CTABSize=304	CodeSize=448
{26} (2520977,2521161,184), 	//vs_2_0  	CTABSize=184	CodeSize=752
{27} (2521913,2522077,164), 	//vs_2_0  	CTABSize=164	CodeSize=364
{28} (2522441,2522569,128), 	//vs_2_0  	CTABSize=128	CodeSize=608
{29} (2523177,2523345,168), 	//vs_2_0  	CTABSize=168	CodeSize=1880
{30} (2525225,2525524,299), 	//ps_2_0  	CTABSize=299	CodeSize=829
{31} (2526353,2526558,205), 	//ps_2_0  	CTABSize=205	CodeSize=571
{32} (2527129,2527334,205), 	//ps_2_0  	CTABSize=205	CodeSize=571
{33} (2527905,2528110,205), 	//ps_2_0  	CTABSize=205	CodeSize=619
{34} (2528729,2528934,205), 	//ps_2_0  	CTABSize=205	CodeSize=619
{35} (2529553,2529790,237), 	//ps_2_0  	CTABSize=237	CodeSize=731
{36} (2530521,2530788,267), 	//ps_2_0  	CTABSize=267	CodeSize=717
{37} (2531505,2531804,299), 	//ps_2_0  	CTABSize=299	CodeSize=861
{38} (2532665,2532932,267), 	//ps_2_0  	CTABSize=267	CodeSize=821
{39} (2533753,2534020,267), 	//ps_2_0  	CTABSize=267	CodeSize=773
{40} (2534793,2535108,315), 	//ps_2_0  	CTABSize=315	CodeSize=813
{41} (2535921,2536158,237), 	//ps_2_0  	CTABSize=237	CodeSize=747
{42} (2536905,2537172,267), 	//ps_2_0  	CTABSize=267	CodeSize=773
{43} (2537945,2538182,237), 	//ps_2_0  	CTABSize=237	CodeSize=803
{44} (2538985,2539284,299), 	//ps_2_0  	CTABSize=299	CodeSize=877
{45} (2540161,2540460,299), 	//ps_2_0  	CTABSize=299	CodeSize=885
{46} (2541345,2541644,299), 	//ps_2_0  	CTABSize=299	CodeSize=901
{47} (2542545,2542844,299), 	//ps_2_0  	CTABSize=299	CodeSize=949
{48} (2543793,2544060,267), 	//ps_2_0  	CTABSize=267	CodeSize=693
{49} (2544753,2545020,267), 	//ps_2_0  	CTABSize=267	CodeSize=749
{50} (2545769,2546021,252), 	//ps_2_0  	CTABSize=252	CodeSize=1140
{51} (2547161,2547193,32), 	//ps_2_0  	CTABSize=32	CodeSize=112
{52} (2547305,2547385,80), 	//ps_2_0  	CTABSize=80	CodeSize=200
{53} (2547585,2547617,32), 	//ps_2_0  	CTABSize=32	CodeSize=112
{54} (2547729,2548023,294), 	//ps_2_0  	CTABSize=294	CodeSize=682
{55} (2548705,2548933,228), 	//ps_2_0  	CTABSize=228	CodeSize=420
{56} (2549353,2549902,549), 	//ps_2_0  	CTABSize=549	CodeSize=995
{57} (2550897,2550929,32), 	//ps_2_0  	CTABSize=32	CodeSize=96
{58} (2551025,2551105,80), 	//ps_2_0  	CTABSize=80	CodeSize=152
{59} (2551257,2551337,80), 	//ps_2_0  	CTABSize=80	CodeSize=200
{60} (2551537,2551741,204), 	//ps_2_0  	CTABSize=204	CodeSize=532
{61} (2552273,2552509,236), 	//ps_2_0  	CTABSize=236	CodeSize=348
{62} (2552857,2552983,126), 	//ps_2_0  	CTABSize=126	CodeSize=410
{63} (2553393,2553602,209), 	//ps_2_0  	CTABSize=209	CodeSize=367
{64} (2553969,2554045,76), 	//ps_2_0  	CTABSize=76	CodeSize=124
{65} (2554169,2554245,76), 	//ps_2_0  	CTABSize=76	CodeSize=164
{66} (2554409,2554485,76), 	//ps_2_0  	CTABSize=76	CodeSize=204
{67} (2554689,2554769,80), 	//ps_2_0  	CTABSize=80	CodeSize=304
{68} (2555073,2555249,176), 	//ps_2_0  	CTABSize=176	CodeSize=336
{69} (2555585,2555802,217), 	//ps_2_0  	CTABSize=217	CodeSize=575
{70} (2556377,2556457,80), 	//ps_2_0  	CTABSize=80	CodeSize=128
{71} (2556585,2556753,168), 	//ps_2_0  	CTABSize=168	CodeSize=480
{72} (2557233,2557353,120), 	//ps_2_0  	CTABSize=120	CodeSize=1424
{73} (2558777,2558897,120), 	//ps_2_0  	CTABSize=120	CodeSize=192
{74} (2559089,2559209,120), 	//ps_2_0  	CTABSize=120	CodeSize=192
{75} (2559401,2559585,184), 	//ps_2_0  	CTABSize=184	CodeSize=440
{76} (2560025,2560105,80), 	//ps_2_0  	CTABSize=80	CodeSize=128
{77} (2560233,2560501,268), 	//ps_2_0  	CTABSize=268	CodeSize=772
{78} (2561273,2561508,235), 	//ps_2_0  	CTABSize=235	CodeSize=741
{79} (2562249,2562722,473), 	//ps_2_0  	CTABSize=473	CodeSize=879
{80} (2563601,2564150,549), 	//ps_2_0  	CTABSize=549	CodeSize=979
{81} (2565129,2565678,549), 	//ps_2_0  	CTABSize=549	CodeSize=1027
{82} (2566705,2567283,578), 	//ps_2_0  	CTABSize=578	CodeSize=1054
{83} (2568337,2568915,578), 	//ps_2_0  	CTABSize=578	CodeSize=1054
{84} (2569969,2570518,549), 	//ps_2_0  	CTABSize=549	CodeSize=1019
{85} (2571537,2572055,518), 	//ps_2_0  	CTABSize=518	CodeSize=898
{86} (2572953,2573471,518), 	//ps_2_0  	CTABSize=518	CodeSize=906
{87} (2574377,2574585,208) 	//ps_2_0  	CTABSize=208
);

implementation

uses Unit1;

function IDfromSTR(txt:string; Num:integer):integer;
var ID,kk,ii:integer;
begin
kk:=length(txt);
if kk=0 then begin IDfromSTR:=0; exit; end;

for ii:=1 to Num do
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
