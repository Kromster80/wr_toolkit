unit MTkit2_CPO;
interface
uses
  KromUtils,
  MTkit2_Defaults;

var
  CPOHead: record
    Head: array [1..4] of AnsiChar;
    Qty, x1, x2, x3: Integer;
  end;

  CPO: array [1 .. MAX_CPO_SHAPES] of record
    Format: Integer; // 2 possible types 2-box 3-shape
    PosX, PosY, PosZ: Single;
    ScaleX, ScaleY, ScaleZ: Single;
    Matrix9: array [1 .. 9] of Single;
    VerticeCount, PolyCount, IndiceSize, Clear1: Integer;
    Vertices: array [1 .. 256] of Vector3f;
    Indices:  array [1 .. 512] of Word;
  end;

implementation

end.
