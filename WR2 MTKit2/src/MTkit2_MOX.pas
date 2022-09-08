unit MTkit2_MOX;
interface
uses
  MTkit2_Vertex;

const
  MAX_BLINKERS = 128;
  MAX_PARTS = 255;

var
  MOX: record
    Qty: record Vertice, Poly, Chunks, Mat, Parts, Blink: Integer; end;
    Vertice: array [1..65280] of record X,Y,Z,nX,nY,nZ,U,V,x1,x2: Single; end;
    Face: array [1..65280,1..3] of Word;   //Polygon links
    Chunk: array [1..2048,1..4] of Word; //Surface ranges (points/polys) 40parts*40materials
    Sid: array [1..2048,1..2] of Word;
    MoxMat: array [1..1024] of record
      ID: Integer;
      xxx: array [1..332] of AnsiChar;
    end;
    Parts: array [1..MAX_PARTS] of record
      Dname: string[64];
      Matrix: TMatrix;
      Parent, Child, PrevInLevel, NextInLevel: SmallInt;
      FirstMat, NumMat: Word;
      xMid, yMid, zMid, fRadius: Single;
      w1, w2, w3: SmallInt;
      TypeID: SmallInt;
      x1, x2, y1, y2, z1, z2: Single;
      w4, w5: Integer;
    end;

    Blinkers: array [1..MAX_BLINKERS] of record
      BlinkerType: Integer;                      //4b Type of object
      sMin, sMax, Freq: Single;               //Min,Max
      B,G,R,A: Byte;                //20
      z1, Parent: SmallInt;                      //24
      Matrix: TMatrix;  //88
    end;
  end;

implementation

end.
