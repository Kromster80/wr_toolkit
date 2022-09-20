unit MTkit2_COB;
interface
uses
  KromUtils;

var
  COB: record
    Head: record
      PointQty, PolyQty: Integer;
      X, Y, Z, Xmin, Xmax, Ymin, Ymax, Zmin, ZMax: Single;
    end;
    Vertices: array [1..256] of Vector3f;
    NormalsP: array [1..256] of Vector3f;
    Faces: array [1..256,1..3] of Word;   // Polygon links
  end;

implementation

end.
