unit MTkit2_MOX;
interface
uses
  MTkit2_Vertex;

type
  TMOXVertice = packed record
    X, Y, Z: Single;
    nX, nY, nZ: Single;
    U, V: Single;
    x1, x2: Single;
  end;

  TMOXPart = packed record
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

  TMOXBlinker = packed record
    BlinkerType: Integer;     // 4b Type of object
    sMin, sMax, Freq: Single; // Min, Max
    B,G,R,A: Byte;            // 20
    Unused, Parent: SmallInt; // 24
    Matrix: TMatrix;          // 88
  end;

const
  MAX_MOX_VTX = 131072;
  MAX_MOX_IDX = 131072;

  MAX_BLINKERS = 128;
  MAX_PARTS = 255;
  MAX_MATERIALS = 1024;

var
  MOX: record
    Qty: record VerticeCount, PolyCount, ChunkCount, MatCount, PartCount, Blink: Integer; end;
    Vertice: array [1..MAX_MOX_VTX] of TMOXVertice;
    Face: array [1..MAX_MOX_IDX,1..3] of Word;  // Polygon links
    Chunk: array [1..2048, 1..4] of Word;  // Surface ranges (points/polys) 40 parts * 40 materials
    Sid: array [1..2048, 1..2] of Word;
    MoxMat: array [1..MAX_MATERIALS] of record
      ID: Integer;
      xxx: array [1..332] of AnsiChar;
    end;
    Parts: array [1..MAX_PARTS] of TMOXPart;
    Blinkers: array [1..MAX_BLINKERS] of TMOXBlinker;
  end;

implementation

end.
