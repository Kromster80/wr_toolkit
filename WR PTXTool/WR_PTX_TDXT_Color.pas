unit WR_PTX_TDXT_Color;
interface
uses Math, KromUtils;

procedure DXT_RGB_Encode(R1,R2,R3,R4:Pointer; out OutDat:int64; out RMS:array of single);
procedure DXT_RGB_Decode(InDat:Pointer; out OutDat:array of byte);

implementation

function ColTo16(c1,c2,c3:byte):word;
begin
  if (c3 mod 8)>3 then Result := Math.min((c3 shr 3)+1,31) else Result:=(c3 shr 3);
  if (c2 mod 4)>1 then Result := Result+Math.min((c2 shr 2)+1,63)shl 5 else Result:=Result+(c2 shr 2)shl 5;
  if (c1 mod 8)>3 then Result := Result+Math.min((c1 shr 3)+1,31)shl 11 else Result:=Result+(c1 shr 3)shl 11;
end;


procedure ColFrom16(m:word; out c1,c2,c3:byte);
begin
  c1 := m div 2048 * 8;
  c2 := m div 32 mod 64 * 4;
  c3 := m mod 32 * 8;
end;

procedure DXT_RGB_Encode(R1,R2,R3,R4:Pointer; out OutDat:int64; out RMS:array of single);
var
  i,k,h:integer;
  InputColor:array[1..16,1..3]of byte; //Input colors
  c0:array[1..4,1..3]of byte;   //
  c2:array[1..4,1..3]of byte;
  Crms:array[1..48]of byte;
  im:array[1..16]of word;
  m1,m2:word;
  tRMS:array[1..4]of integer;
  Trial:array[1..6]of record
    Dat:int64;
    tRMS:integer;
  end;


  procedure MakeBlock(id,mm1,mm2:word);
    var i:integer;
    begin with Trial[id] do begin
      Dat:=mm1+(mm2 shl 16);
      for i:=1 to 16 do
        Dat:=Dat+int64( int64(im[i] AND $03) shl ( 32 + (i-1)*2 ));
    end; end;

begin
FillChar(im,SizeOf(im),#0);
FillChar(Trial,SizeOf(Trial),#0);
FillChar(tRMS,SizeOf(tRMS),#0);
  for i:=0 to 3 do for h:=1 to 3 do InputColor[i+1,h]    := byte(Char(Pointer((Integer(R1)+i*4+h-1))^));
  for i:=0 to 3 do for h:=1 to 3 do InputColor[i+1+4,h]  := byte(Char(Pointer((Integer(R2)+i*4+h-1))^));
  for i:=0 to 3 do for h:=1 to 3 do InputColor[i+1+8,h]  := byte(Char(Pointer((Integer(R3)+i*4+h-1))^));
  for i:=0 to 3 do for h:=1 to 3 do InputColor[i+1+12,h] := byte(Char(Pointer((Integer(R4)+i*4+h-1))^));
  for i:=1 to 16 do begin
    RMS[1] := 0;
    RMS[2] := 0;
    RMS[3] := 0;
  end;

  //Find minmax pair from existing colors;
  tRMS[1] := 65535;
  tRMS[2] := 0;

  for i:=1 to 16 do for h:=i+1 to 16 do begin
    if tRMS[2] <= GetLengthSQR(InputColor[i,1]-InputColor[h,1], InputColor[i,2]-InputColor[h,2], InputColor[i,3]-InputColor[h,3]) then
    begin
      tRMS[2] := GetLengthSQR(InputColor[i,1]-InputColor[h,1], InputColor[i,2]-InputColor[h,2], InputColor[i,3]-InputColor[h,3]);
      if ColTo16(InputColor[i,1], InputColor[i,2], InputColor[i,3]) <= ColTo16(InputColor[h,1], InputColor[h,2], InputColor[h,3]) then
      begin
        im[1] := i;
        im[2] := h;
      end
      else
      begin
        im[1] := h;
        im[2] := i;
      end;
    end;
  end;

  m1 := ColTo16(InputColor[im[2],1], InputColor[im[2],2], InputColor[im[2],3]);
  m2 := ColTo16(InputColor[im[1],1], InputColor[im[1],2], InputColor[im[1],3]);

  //Find another minmax pair from existing colors;
 { tRMS[1]:=65535; tRMS[2]:=0;
  for i:=1 to 16 do for h:=i+1 to 16 do
    if (im[1]<>i)and(im[2]<>h)and(im[2]<>i)and(im[1]<>h) then begin
    if tRMS[2]<=round(GetLength(InputColor[i,1]-InputColor[h,1],InputColor[i,2]-InputColor[h,2],InputColor[i,3]-InputColor[h,3])) then begin
      tRMS[2]:=round(GetLength(InputColor[i,1]-InputColor[h,1],InputColor[i,2]-InputColor[h,2],InputColor[i,3]-InputColor[h,3]));
      if ColTo16(InputColor[i,1],InputColor[i,2],InputColor[i,3])<=ColTo16(InputColor[h,1],InputColor[h,2],InputColor[h,3]) then begin
        im[3]:=i; im[4]:=h;
      end else begin
        im[3]:=h; im[4]:=i;
      end;
    end;
  end;
  m1:=ColTo16((InputColor[im[2],1]+InputColor[im[4],1])div 2,(InputColor[im[2],2]+InputColor[im[4],2])div 2,(InputColor[im[2],3]+InputColor[im[4],3])div 2);
  m2:=ColTo16((InputColor[im[1],1]+InputColor[im[3],1])div 2,(InputColor[im[1],2]+InputColor[im[3],2])div 2,(InputColor[im[1],3]+InputColor[im[3],3])div 2);
//}

  {//Get minmax pair by luminance, produces rather poor results
  tRMS[1]:=65535; tRMS[2]:=0;
  for i:=1 to 16 do begin
    if tRMS[1]>=(InputColor[i,1]*3+InputColor[i,2]*6+InputColor[i,3]*1) then begin
      tRMS[1]:=(InputColor[i,1]*3+InputColor[i,2]*6+InputColor[i,3]*1);
      im[2]:=i;
      end;
    if tRMS[2]<=(InputColor[i,1]*3+InputColor[i,2]*6+InputColor[i,3]*1) then begin
      tRMS[2]:=(InputColor[i,1]*3+InputColor[i,2]*6+InputColor[i,3]*1);
      im[1]:=i;
      end;
  end; //}

  {//Find a middlepoint and build endpoints from it - incomplete idea
  FillChar(c1[1],SizeOf(c1[1]),#0);
  FillChar(c1[4],SizeOf(c1[4]),#255);
  for i:=1 to 16 do begin
    c1[1,1]:=max(c1[1,1],InputColor[i,1]);
    c1[1,2]:=max(c1[1,2],InputColor[i,2]);
    c1[1,3]:=max(c1[1,3],InputColor[i,3]);
    c1[4,1]:=min(c1[4,1],InputColor[i,1]);
    c1[4,2]:=min(c1[4,2],InputColor[i,2]);
    c1[4,3]:=min(c1[4,3],InputColor[i,3]);
  end;
    c1[2,1]:=(c1[1,1]+c1[4,1])div 2;
    c1[2,2]:=(c1[1,2]+c1[4,2])div 2;
    c1[2,3]:=(c1[1,3]+c1[4,3])div 2; }
  //for i:=1 to 16 do begin
//    if InputColor[i,1]
  //}

  //These are input colors, 1=max and 4=min
  c0[1,1] := InputColor[im[2],1];
  c0[1,2] := InputColor[im[2],2];
  c0[1,3] := InputColor[im[2],3];

  c0[4,1] := InputColor[im[1],1];
  c0[4,2] := InputColor[im[1],2];
  c0[4,3] := InputColor[im[1],3];

//Case1 Straight case, use 2 interpolated colors 1/3 and 2/3
  ColFrom16(m1,c2[1,1],c2[1,2],c2[1,3]);
  ColFrom16(m2,c2[4,1],c2[4,2],c2[4,3]);
  c2[2,1]:=mix(c2[4,1],c2[1,1],1/3);
  c2[2,2]:=mix(c2[4,2],c2[1,2],1/3);
  c2[2,3]:=mix(c2[4,3],c2[1,3],1/3);
  c2[3,1]:=mix(c2[4,1],c2[1,1],2/3);
  c2[3,2]:=mix(c2[4,2],c2[1,2],2/3);
  c2[3,3]:=mix(c2[4,3],c2[1,3],2/3);

  for i:=1 to 16 do begin
    for h:=1 to 4 do
      tRMS[h]:=GetLengthSQR(InputColor[i,1]-c2[h,1],InputColor[i,2]-c2[h,2],InputColor[i,3]-c2[h,3]);
    if tRMS[1]<tRMS[2] then h:=1 else h:=2;
    if tRMS[h]>tRMS[3] then h:=3;
    if tRMS[h]>tRMS[4] then h:=4;
    if h=1 then im[i]:=0;
    if h=2 then im[i]:=2;
    if h=3 then im[i]:=3;
    if h=4 then im[i]:=1;
    inc(Trial[1].tRMS,tRMS[h]);
  end;

  MakeBlock(1,m1,m2);

//Case2 Straight case, use 1 interpolated color 1/2, other color should be avoided (it's black?)
  c2[2,1]:=(c2[1,1]+c2[4,1])div 2;
  c2[2,2]:=(c2[1,2]+c2[4,2])div 2;
  c2[2,3]:=(c2[1,3]+c2[4,3])div 2;

  for i:=1 to 16 do begin
    for h:=1 to 4 do
      tRMS[h]:=GetLengthSQR(InputColor[i,1]-c2[h,1],InputColor[i,2]-c2[h,2],InputColor[i,3]-c2[h,3]);
    if tRMS[1]<tRMS[2] then h:=1 else h:=2;
    if tRMS[h]>tRMS[4]{=tRMS[3]} then h:=4;
    if h=1 then im[i]:=1;
    if h=2 then im[i]:=2;
    if h=3 then im[i]:=3;
    if h=4 then im[i]:=0;
    inc(Trial[2].tRMS,tRMS[h]);
  end;

  MakeBlock(2,m2,m1);

//Case3 Enlarge range one direction to get better match for 1/3 or 2/3 interpolation

  for k:=0 to 1 do begin
    if k=0 then begin
      c2[1,1]:=EnsureRange(c0[1,1]+(c0[1,1]-c0[4,1])div 2,0,255);
      c2[1,2]:=EnsureRange(c0[1,2]+(c0[1,2]-c0[4,2])div 2,0,255);
      c2[1,3]:=EnsureRange(c0[1,3]+(c0[1,3]-c0[4,3])div 2,0,255);
      m1:=ColTo16(c2[1,1],c2[1,2],c2[1,3]);
      m2:=ColTo16(c0[4,1],c0[4,2],c0[4,3]);
      if m1<m2 then SwapInt(m1,m2);
      ColFrom16(m1,c2[1,1],c2[1,2],c2[1,3]);
      ColFrom16(m2,c2[4,1],c2[4,2],c2[4,3]);
    end;
    if k=1 then begin
      c2[4,1]:=EnsureRange(c0[4,1]-(c0[1,1]-c0[4,1])div 2,0,255);
      c2[4,2]:=EnsureRange(c0[4,2]-(c0[1,2]-c0[4,2])div 2,0,255);
      c2[4,3]:=EnsureRange(c0[4,3]-(c0[1,3]-c0[4,3])div 2,0,255);
      m1:=ColTo16(c0[1,1],c0[1,2],c0[1,3]);
      m2:=ColTo16(c2[4,1],c2[4,2],c2[4,3]);
      if m1<m2 then SwapInt(m1,m2);
      ColFrom16(m1,c2[1,1],c2[1,2],c2[1,3]);
      ColFrom16(m2,c2[4,1],c2[4,2],c2[4,3]);
    end;

    c2[2,1]:=mix(c2[4,1],c2[1,1],1/3);
    c2[2,2]:=mix(c2[4,2],c2[1,2],1/3);
    c2[2,3]:=mix(c2[4,3],c2[1,3],1/3);
    c2[3,1]:=mix(c2[4,1],c2[1,1],2/3);
    c2[3,2]:=mix(c2[4,2],c2[1,2],2/3);
    c2[3,3]:=mix(c2[4,3],c2[1,3],2/3);

    for i:=1 to 16 do begin
      for h:=1 to 4 do
        tRMS[h]:=GetLengthSQR(InputColor[i,1]-c2[h,1],InputColor[i,2]-c2[h,2],InputColor[i,3]-c2[h,3]);
      if tRMS[1]<tRMS[2] then h:=1 else h:=2;
      if tRMS[h]>tRMS[3] then h:=3;
      if tRMS[h]>tRMS[4] then h:=4;
      if h=1 then im[i]:=0;
      if h=2 then im[i]:=2;
      if h=3 then im[i]:=3;
      if h=4 then im[i]:=1;
      inc(Trial[3+k].tRMS,tRMS[h]);
    end;

    MakeBlock(3+k,m1,m2);
  end;

//Case4 Compute average block color and try to match it either by 1 or 2 interpolations, best for plaincolor matching
// possibly can be split into R-G-B matching, but that involves triple the code..
  tRMS[1]:=0; tRMS[2]:=0; tRMS[3]:=0;
  for i:=1 to 16 do begin
    inc(tRMS[1],InputColor[i,1]);
    inc(tRMS[2],InputColor[i,2]);
    inc(tRMS[3],InputColor[i,3]);
  end;

  m1:=ColTo16( //rounded one step up
  EnsureRange((round(tRMS[1]/16)shr 3+1) * 8,0,255),
  EnsureRange((round(tRMS[2]/16)shr 2+1) * 4,0,255),
  EnsureRange((round(tRMS[3]/16)shr 3+1) * 8,0,255));
  ColFrom16(m1,c2[1,1],c2[1,2],c2[1,3]);
  m2:=ColTo16( //rounded one step down
  EnsureRange((round(tRMS[1]/16)shr 3) * 8,0,255),
  EnsureRange((round(tRMS[2]/16)shr 2) * 4,0,255),
  EnsureRange((round(tRMS[3]/16)shr 3) * 8,0,255));
  ColFrom16(m2,c2[4,1],c2[4,2],c2[4,3]);

  c2[2,1]:=(c2[4,1]+c2[1,1])div 2; c2[2,2]:=(c2[4,2]+c2[1,2])div 2; c2[2,3]:=(c2[4,3]+c2[1,3])div 2;

  for i:=1 to 16 do begin
    for h:=1 to 4 do
      tRMS[h]:=GetLengthSQR(InputColor[i,1]-c2[h,1],InputColor[i,2]-c2[h,2],InputColor[i,3]-c2[h,3]);
    if tRMS[1]<tRMS[2] then h:=1 else h:=2;
    if tRMS[h]>tRMS[4]{=tRMS[3]} then h:=4;
    if h=1 then im[i]:=1;
    if h=2 then im[i]:=2;
    if h=3 then im[i]:=3;
    if h=4 then im[i]:=0;
    inc(Trial[5].tRMS,tRMS[h]);
  end;

  MakeBlock(5, m2, m1);

  c2[2,1] := mix(c2[4,1],c2[1,1],1/3);
  c2[2,2] := mix(c2[4,2],c2[1,2],1/3);
  c2[2,3] := mix(c2[4,3],c2[1,3],1/3);
  c2[3,1] := mix(c2[4,1],c2[1,1],2/3);
  c2[3,2] := mix(c2[4,2],c2[1,2],2/3);
  c2[3,3] := mix(c2[4,3],c2[1,3],2/3);

  for i:=1 to 16 do begin
    for h:=1 to 4 do
      tRMS[h]:=GetLengthSQR(InputColor[i,1]-c2[h,1],InputColor[i,2]-c2[h,2],InputColor[i,3]-c2[h,3]);
    if tRMS[1]<tRMS[2] then h := 1 else h := 2;
    if tRMS[h]>tRMS[3] then h := 3;
    if tRMS[h]>tRMS[4] then h := 4;
    if h=1 then im[i] := 0;
    if h=2 then im[i] := 2;
    if h=3 then im[i] := 3;
    if h=4 then im[i] := 1;
    inc(Trial[6].tRMS,tRMS[h]);
  end;

  MakeBlock(6, m1, m2);


//  Trial[1].tRMS:=9999999;
//  Trial[2].tRMS:=9999999;
//  Trial[3].tRMS:=9999999;
//  Trial[4].tRMS:=9999999;
//  Trial[5].tRMS:=9999999;
//  Trial[6].tRMS:=9999999;
{  Trial[1].Dat:=ColTo16(255,0,0);   //Red
  Trial[2].Dat:=ColTo16(255,255,0); //Yellow
  Trial[3].Dat:=ColTo16(0,255,0);   //Green
  Trial[4].Dat:=ColTo16(0,255,255); //Cyan
  Trial[5].Dat:=ColTo16(0,0,255);   //Blue
  Trial[6].Dat:=ColTo16(255,0,255); //Magenta}

//Choose the result with least RMS error
  k := 99999;
  for i:=1 to 6 do
    if k>Trial[i].tRMS then begin
      k := Trial[i].tRMS;
      h := i;
    end;
  OutDat := Trial[h].Dat;
//  if Trial[h].tRMS>100 then
//    OutDat:=1023;

DXT_RGB_Decode(@OutDat,Crms); //Carry out RMS error value
    for i:=1 to 16 do RMS[0] := RMS[0] + sqr(InputColor[i,1] - Crms[i*3-2]);
    for i:=1 to 16 do RMS[1] := RMS[1] + sqr(InputColor[i,2] - Crms[i*3-1]);
    for i:=1 to 16 do RMS[2] := RMS[2] + sqr(InputColor[i,3] - Crms[i*3]);
end;


procedure DXT_RGB_Decode(InDat:Pointer; out OutDat:array of byte);
var i,h,x:integer; c:array[1..8]of byte;
Colors:array[1..4,1..3]of word; //4colors in R,G,B
begin
  for i := 1 to 8 do //cast into array of byte
    c[i] := byte(Char(Pointer((cardinal(InDat)+i-1))^));

  //Acquire min/max colors
  Colors[1,1] := (c[2]div 8)*8;                //R1
  Colors[1,2] := (c[2]mod 8)*32+(c[1]div 32)*4;//G1
  Colors[1,3] := (c[1]mod 32)*8;               //B1
  Colors[2,1] := (c[4]div 8)*8;                //R2
  Colors[2,2] := (c[4]mod 8)*32+(c[3]div 32)*4;//G2
  Colors[2,3] := (c[3]mod 32)*8;               //B2

  //Acquire average colors
  if (c[1]+c[2]*256) > (c[3]+c[4]*256) then begin
    Colors[3,1] := round((Colors[2,1] + Colors[1,1]*2)/3);
    Colors[3,2] := round((Colors[2,2] + Colors[1,2]*2)/3);
    Colors[3,3] := round((Colors[2,3] + Colors[1,3]*2)/3);
    Colors[4,1] := round((Colors[2,1]*2 + Colors[1,1])/3);
    Colors[4,2] := round((Colors[2,2]*2 + Colors[1,2])/3);
    Colors[4,3] := round((Colors[2,3]*2 + Colors[1,3])/3);
  end else begin
    Colors[3,1] := round((Colors[2,1] + Colors[1,1])/2); Colors[4,1] := 255; //This is in fact 1bit transparent
    Colors[3,2] := round((Colors[2,2] + Colors[1,2])/2); Colors[4,2] := 0;   //but let's show it as purple
    Colors[3,3] := round((Colors[2,3] + Colors[1,3])/2); Colors[4,3] := 255;
  end;

  for h:=1 to 16 do begin
    x:=0;
    if h mod 4=1 then x :=  ord(c[1+(h-1)div 4+4])mod 4;        //1,5, 9,13
    if h mod 4=2 then x := (ord(c[1+(h-1)div 4+4])mod 16)div 4; //2,6,10,14
    if h mod 4=3 then x := (ord(c[1+(h-1)div 4+4])mod 64)div 16;//3,7,11,15
    if h mod 4=0 then x :=  ord(c[1+(h-1)div 4+4])div 64;       //4,8,12,16

    OutDat[(h-1)*3+0] := Colors[x+1,1]; //R
    OutDat[(h-1)*3+1] := Colors[x+1,2]; //G
    OutDat[(h-1)*3+2] := Colors[x+1,3]; //B
  end;
end;

end.

