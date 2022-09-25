unit KM_Vertexes;
interface
uses
  Math, SysUtils, KM_Colors;

{ Volumetric 3D structures }

const
  // Split terrain into 4-texture buckets
  // 4 is the best compromise between shader efficiency, vertex attributes size and buckets count / draw calls
  GFX_TERRAIN_TEXTURES_MAX_BLENDS = 4;

type
  TKMVertex2 = record
  public
    X, Y: Single;
    class operator Add(const A, B: TKMVertex2): TKMVertex2; inline;
    class operator Divide(const A, B: TKMVertex2): TKMVertex2; overload; inline;
    class operator Divide(const A: TKMVertex2; B: Single): TKMVertex2; overload; inline;
    class operator Equal(const A, B: TKMVertex2): Boolean;
    class operator NotEqual(const A, B: TKMVertex2): Boolean;
    class operator Multiply(A: Single; const B: TKMVertex2): TKMVertex2; overload; inline;
    class operator Multiply(const A: TKMVertex2; B: Single): TKMVertex2; overload; inline;
    class operator Multiply(const A, B: TKMVertex2): TKMVertex2; overload; inline;
    class operator Subtract(const A, B: TKMVertex2): TKMVertex2; inline;

    class function NaN: TKMVertex2; static;
    class function New(aX, aY: Single): TKMVertex2; static; inline;
    class function NewLerp(A, B: TKMVertex2; aFrac: Single): TKMVertex2; static; inline;

    // Only self-sufficient methods here
    function IsNaN: Boolean;
    function GetLength: Single;
    function GetLengthSqr: Single;
    function GetNormalize: TKMVertex2;
    function GetRotate(aAngle: Single): TKMVertex2;
    function GetRotate45: TKMVertex2;
    function GetRotate90: TKMVertex2;
    function GetRound: TKMVertex2;
    function ToString: string;
  end;
  PKMVertex2 = ^TKMVertex2;

  TKMVertex2R = record
    X, Y: Single;
    R: Integer;
  end;

  TKMVertex2UV = record
  public
    X, Y, U, V: Single;
    class function New(aX, aY, aU, aV: Single): TKMVertex2UV; static;
  end;

  TKMVertex3 = record
  public
    X, Y, Z: Single;
    class operator Add(const A, B: TKMVertex3): TKMVertex3; inline;
    class operator Divide(const A: TKMVertex3; B: Single): TKMVertex3; inline;
    class operator Equal(const A, B: TKMVertex3): Boolean;
    class operator Subtract(const A, B: TKMVertex3): TKMVertex3; inline;
    class operator Multiply(const A: TKMVertex3; B: Single): TKMVertex3; inline;
    class operator Multiply(const A: TKMVertex3; B: TKMVertex3): TKMVertex3; inline;
    class operator Negative(const A: TKMVertex3): TKMVertex3; inline;

    class function NaN: TKMVertex3; static;
    class function New(aX, aY, aZ: Single): TKMVertex3; overload; static;
    class function New(const aArray3: TArray<Single>): TKMVertex3; overload; static;
    class function New(A: TKMVertex2): TKMVertex3; overload; static;
    class function New(A: TKMVertex2; aZ: Single): TKMVertex3; overload; static;
    class function NewHP(aHeading, aPitch: Single): TKMVertex3; overload; static;
    class function NewLerp(A, B: TKMVertex3; aFrac: Single): TKMVertex3; static; inline;

    function GetOffset(aX, aY, aZ: Single): TKMVertex3; inline;
    function GetOffsetZ(aZ: Single): TKMVertex3; inline;

    // Only self-sufficient methods here
    function IsNaN: Boolean;
    function GetLength: Single; inline;
    function GetLengthSqr: Single; inline;
    function GetNormalize: TKMVertex3;
    function GetNormalizeXY: TKMVertex3;
    function GetNormalizeAngles: TKMVertex3;
    function GetRotateXY90(aAngle90: Byte): TKMVertex3;
    function GetXY: TKMVertex2;
    function GetXZ: TKMVertex2;
    function GetYZ: TKMVertex2;
    function ToArray3: TArray<Single>;
    function ToString: string;
  end;
  PKMVertex3 = ^TKMVertex3;

  TKMRotationOrder = (roXYZ, roYXZ, roZXY, roZYX, roYZX, roXZY);

  TKMVertex4 = record
  public
    X, Y, Z, W: Single; // [Position, Weight] or [Quaternion]
    class operator Add(const A, B: TKMVertex4): TKMVertex4; inline;
    class operator Multiply(const A: TKMVertex4; B: Single): TKMVertex4; inline;
    class operator Negative(const A: TKMVertex4): TKMVertex4; inline;
    class operator Subtract(const A, B: TKMVertex4): TKMVertex4; inline;

    class function New(const aXYZ: TKMVertex3; aW: Single): TKMVertex4; overload; static;
    class function New(const aArray4: TArray<Single>): TKMVertex4; overload; static;
    class function New(aX, aY, aZ, aW: Single): TKMVertex4; overload; static;
    class function NewLerp(const A, B: TKMVertex4; aFrac: Single): TKMVertex4; static;
    class function NewNLerp(const A, B: TKMVertex4; aFrac: Single): TKMVertex4; static;
    class function NewSLerp(const A, B: TKMVertex4; aFrac: Single): TKMVertex4; static;
    class function NewQuaternion(const aRotate: TKMVertex3; aOrder: TKMRotationOrder = roXYZ): TKMVertex4; static;

    class function GetDotProduct(const A, B: TKMVertex4): Single; static;

    function GetLengthSqr: Single;
    function GetNormalize: TKMVertex4;
    function IsZeroLength: Boolean;

    function ToArray4: TArray<Single>;
  end;

  // For when we need to render something in 3D without lighting (e.g. house type icons, overlay sprites)
  TKMVertex3M = record
  public
    X, Y, Z: Single; // Position
    U, V: Single;    // UV mapping
    class function New(aX, aY, aZ: Single): TKMVertex3M; overload; static;
    class function New(aX, aY, aZ, aU, aV: Single): TKMVertex3M; overload; static;
    class function New(const aXYZ: TKMVertex3; aU, aV: Single): TKMVertex3M; overload; static;
    function GetRotateXY90(aAngle90: Byte): TKMVertex3M;
    function GetRotateAround(aCenter: TKMVertex2; aAngle: Single): TKMVertex3M;
    function GetOffset(const aXYZ: TKMVertex3): TKMVertex3M;
  end;

  TKMVertex3M2 = record
  public
    X, Y, Z: Single; // Position
    OX, OY: Single;  // Origin
    OU, OV: Single;  // UV mapping
  end;

  TKMVertexPCW = record
  public
    X, Y, Z: Single;        // Position
    cR, cG, cB, cA: Single; // Color
    W: Single;              // Weight
  end;
  PKMVertexPCW = ^TKMVertexPCW;

  TKMVertexPNCM = record
  public
    X, Y, Z: Single;    // Position
    nX, nY, nZ: Single; // Normal
    cR, cG, cB: Single; // Color
    U, V: Single;       // UV mapping
  end;

  TKMVertexPNCMW = record
  public
    X, Y, Z: Single;    // Position
    nX, nY, nZ: Single; // Normal
    cR, cG, cB: Single; // Color
    U, V: Single;       // UV mapping
    W: Single;          // Weight
    function GetXYZ: TKMVertex3;
    procedure SetRGB(const aColor: TKMColor3f);
  end;
  PKMVertexPNCMW = ^TKMVertexPNCMW;

  // Used to render terrain where each vertice contains corresponding textures weights
  // UV mapping can be used only for one texture (decals, overlays, etc)
  TKMVertexPNMWs = record
  public
    X, Y, Z: Single;    // Position
    nX, nY, nZ: Single; // Normal
    U, V, W: Single;    // UV mapping and UV weight
    Weight: array [0..GFX_TERRAIN_TEXTURES_MAX_BLENDS-1] of Single; // Weights of terrain textures
  end;
  PKMVertexPNMWs = ^TKMVertexPNMWs;

  // Used to render skeletal animated models (each vertice references 2 bones and weights)
  TKMVertexPNCMW2 = record
  public
    X, Y, Z: Single;    // Position
    nX, nY, nZ: Single; // Normal
    cR, cG, cB: Single; // Color
    U, V: Single;       // UV mapping
    Weight1, Weight2: Single; // Integer part stores weightmap index, fractional part stores weight in 0 .. 0,9 range
    procedure SetRGB(const aColor: TKMColor3f);
  end;
  PKMVertexPNCMW2 = ^TKMVertexPNCMW2;

  // Two vertexes together, for Eye-Direction
  TKMVertex3Ray = record
  public
    Start, Endpoint: TKMVertex3;
  end;
  PKMVertex3Ray = ^TKMVertex3Ray;
  TKMRayArray = array of TKMVertex3Ray;

  // 3D box defined by top and bottom corners
  TKMVertexBox = record
  public
    CornerLow, CornerHigh: TKMVertex3;
    class function New(aLow, aHigh: TKMVertex3): TKMVertexBox; overload; static;
    class function New(aLowX, aLowY, aLowZ, aHighX, aHighY, aHighZ: Single): TKMVertexBox; overload; static;
    class function NewUnit: TKMVertexBox; static;
    class operator Add(const A: TKMVertexBox; B: TKMVertex3): TKMVertexBox;
    function GetCenterLow: TKMVertex3;
  end;
  PKMVertexBox = ^TKMVertexBox;

  // 3D sphere defined by center and radius
  TKMVertexSphere = record
  public
    Center: TKMVertex3;
    Radius: Single;
    class function New(aCenter: TKMVertex3; aRadius: Single): TKMVertexSphere; static;
  end;

  TMatrix3 = record
  private type
    TMatrix3Vert = array [0..2] of TKMVertex3; // Just for convenience of internal Matrix access
  public
    class function Identity: TMatrix3; static;
    class function NewHeadingLW(aHeading: Single): TMatrix3; static;
    class function NewPitchLW(aPitch: Single): TMatrix3; static;
    class function NewBankLW(aBank: Single): TMatrix3; static;
    class function NewTranslate(aX, aY: Single): TMatrix3; static;
    class function NewTranslateAndScale(aX, aY, aW, aH: Single): TMatrix3; static;
    class function NewScale(aScale: Single): TMatrix3; overload; static;
    class function NewScale(aScaleX, aScaleY: Single): TMatrix3; overload; static;

    function IsEqual(aM: TMatrix3; aEpsilon: Single): Boolean;
    function Scale2(const aScale: Single): TMatrix3; overload;
    function Scale2(const aX, aY: Single): TMatrix3; overload;
    function GetRemoveTranslate: TMatrix3;
    function ToString: string;

    class operator Multiply(const aMatA, aMatB: TMatrix3): TMatrix3; inline;

    case Integer of
      0: (M: TMatrix3Vert);
      1: (m11, m12, m13: Single;
          m21, m22, m23: Single;
          m31, m32, m33: Single);
  end;

  TMatrix4 = record
  private type
    TMatrix4Vert = array [0..3] of TKMVertex4; // Just for convenience of internal Matrix access
  private
    function DetInternal(const a1, a2, a3, b1, b2, b3, c1, c2, c3: Single): Single; inline;
    function Scale(const AFactor: Single): TMatrix4;
  public
    class function Identity: TMatrix4; static;
    class function NewHeadingLW(aHeading: Single): TMatrix4; static;
    class function NewPitchLW(aPitch: Single): TMatrix4; static;
    class function NewBankLW(aBank: Single): TMatrix4; static;
    class function NewQuaternion(Q: TKMVertex4): TMatrix4; static;
    class function NewTranslate(aX, aY: Single): TMatrix4; overload; static;
    class function NewTranslate(aX, aY, aZ: Single): TMatrix4; overload; static;
    class function NewTranslate(const aVert: TKMVertex3): TMatrix4; overload; static;
    class function NewTranslateAndScale(aX, aY, aW, aH: Single): TMatrix4; static;
    class function NewRotateLW(const aHPB: TKMVertex3): TMatrix4; overload; static;
    class function NewScale(aScale: Single): TMatrix4; overload; static;
    class function NewScale(aScaleX, aScaleY: Single): TMatrix4; overload; static;
    class function NewScale(aScale: TKMVertex3): TMatrix4; overload; static;
    class function NewBias05: TMatrix4; static;
    class function NewReflectionAboutPlane(aX, aY, aZ, aD: Single): TMatrix4; static;
    class function NewLookAtRH(const aEye, aTarget, aUp: TKMVertex3): TMatrix4; static;
    class function NewOrthoOffCenterRH(const aLeft, aRight, aTop, aBottom, aZNear, aZFar: Single): TMatrix4; static;
    class function NewPerspectiveFovRH(const aFOV, aAspect, aZNear, aZFar: Single; const aHorizontalFOV: Boolean = False): TMatrix4; static;

    function Determinant: Single;
    function Adjoint: TMatrix4;
    function Inverse: TMatrix4;
    function InvApply(aVert: TKMVertex3): TKMVertex3;
    function IsEqual(aM: TMatrix4; aEpsilon: Single): Boolean;
    function Scale3(const aScale: Single): TMatrix4; overload;
    function Scale3(const aX, aY, aZ: Single): TMatrix4; overload;
    function GetRemoveTranslate: TMatrix4;
    function GetTranslate: TKMVertex3;
    function ToString: string;

    class operator Multiply(const aA, aB: TMatrix4): TMatrix4; inline;
    class operator Multiply(const aVector: TKMVertex3; const aMatrix: TMatrix4): TKMVertex3; inline;
    class operator Multiply(const aVector: TKMVertex4; const aMatrix: TMatrix4): TKMVertex4; inline;

    case Integer of
      0: (M: TMatrix4Vert);
      1: (m11, m12, m13, m14: Single;
          m21, m22, m23, m24: Single;
          m31, m32, m33, m34: Single;
          m41, m42, m43, m44: Single);
  end;

  // Texture atlas handle and UV coordinates within that atlas
  TKMTexCoords = record
  public
    ID: Cardinal; // Atlas-Texture handle where the Tex is located
    u1,v1,u2,v2: Single; // Top-Left, Bottom-Right UV coordinates
    class function New(aId: Cardinal; aU1, aV1, aU2, aV2: Single): TKMTexCoords; static;
    function ToMatrix3: TMatrix3;
  end;

  TKMVertexFormat = (vfP, vfPM, vfPM2, vfPNCM, vfPNMWs, vfPNCMW, vfPNCMW2);

  TKMVertex2Array = array of TKMVertex2;
  TKMVertex2UVArray = array of TKMVertex2UV;
  TKMVertex3Array = array of TKMVertex3;
  TKMVertex3MArray = array of TKMVertex3M;
  TKMVertex3M2Array = array of TKMVertex3M2;
  TKMVertex4Array = array of TKMVertex4;
  TKMVertexPCWArray = array of TKMVertexPCW;
  TKMVertexPNCMArray = array of TKMVertexPNCM;
  TKMVertexPNCMWArray = array of TKMVertexPNCMW;
  TKMVertexPNMWsArray = array of TKMVertexPNMWs;
  TKMVertexPNCMW2Array = array of TKMVertexPNCMW2;
  TKMVertex2Array4 = array [0..3] of TKMVertex2;
  TKMVertex3Array4 = array [0..3] of TKMVertex3;
  TKMVertex3MArray4 = array [0..3] of TKMVertex3M;
  PKMVertex3Array = ^TKMVertex3Array;
  TKMMatrix4Array = array of TMatrix4;

  TKMVertexRect = record
  public
    Left, Top, Right, Bottom: Single;
    class operator Multiply(const aRect: TKMVertexRect; aScale: Single): TKMVertexRect;
    class function New(const aLeft, aTop, aRight, aBottom: Single): TKMVertexRect; static;
    //function ClipVector(const aVector: TKMVertex2): TKMVertex2;
    function GetMove(aX, aY: Single): TKMVertexRect; overload;
    function GetMove(aV: TKMVertex2): TKMVertexRect; overload;
    function GetCenter: TKMVertex2;
    function GetWidth: Single;
    function GetHeight: Single;
    function ToMatrix4: TMatrix4;
  end;

  TKMRenderRectTex = record
  public
    Color: TKMColor4f;
    Rect: TKMVertexRect;
    Tex: TKMTexCoords;
    RotateAroundCenter: Single; // in radians
    class function New(aX1, aY1, aU1, aV1, aX2, aY2, aU2, aV2: Single; aTexId: Cardinal; aColor: TKMColor4f): TKMRenderRectTex; overload; static;
    class function New(aX1, aY1, aX2, aY2: Single; aTex: TKMTexCoords; aColor: TKMColor4f): TKMRenderRectTex; overload; static;
  end;

  TKMCircle2 = record
    Position: TKMVertex2;
    Radius: Single;
    class function New(aX, aY, aRadius: Single): TKMCircle2; overload; static;
    class function New(aCenter: TKMVertex2; aRadius: Single): TKMCircle2; overload; static;
    function IsEqual(aCircle: TKMCircle2; aEpsilon: Single): Boolean;
    function IsCircleInside(aX, aY, aRadius: Single): Boolean;
    function IsCircleOutside(aX, aY, aRadius: Single): Boolean;
  end;

  TKMCircle2Array = array of TKMCircle2;

  TKMCircle2List = record
  public
    Circles: TKMCircle2Array;
    procedure Append(const aCircle: TKMCircle2); overload;
    procedure Clear;
    function Count: Integer;
    procedure Remove(const aCircle: TKMCircle2);
  end;

  TKMSegment2 = record
    A, B: TKMVertex2;
    class function New(const A, B: TKMVertex2): TKMSegment2; static;
    function OnLeft(const aPoint: TKMVertex2): Boolean;
    function Normal: TKMVertex2;
    function Direction: TKMVertex2;
    function IntersectionParameter(const aEdge: TKMSegment2): Single;
    function Morph(const tA, tB: Single): TKMSegment2;
    function RotateAround05(aRot: Byte): TKMSegment2;
  end;
  PKMSegment2 = ^TKMSegment2;

  TKMSegment2Array = array of TKMSegment2;

  TKMSegment2List = record
  public
    Segments: TKMSegment2Array;
    procedure Append(const aA, aB: TKMVertex2); overload;
    procedure Append(aX1, aY1, aX2, aY2: Single); overload;
    procedure Append(const aSeg: TKMSegment2); overload;
    procedure Append(const aSegs: TKMSegment2Array); overload;
    function Count: Integer;
  end;

  TKMPolygon2 = record
  public
    Points: TKMVertex2Array;
    class function New: TKMPolygon2; overload; static;
    class function New(aCount: Integer): TKMPolygon2; overload; static;
    class function New(aX1, aY1, aX2, aY2, aX3, aY3: Single): TKMPolygon2; overload; static;
    class function New(aX1, aY1, aX2, aY2, aX3, aY3, aX4, aY4: Single): TKMPolygon2; overload; static;
    class operator Multiply(const A: TKMPolygon2; B: Single): TKMPolygon2;
    function PointCount: Integer;
    function Edges: TKMSegment2Array;
    function IsConvex: Boolean;
    function CyrusBeckClip(aSubjects: TKMSegment2Array): TKMSegment2Array;
    function CheckDistance(const aPoint: TKMVertex2; aDistance: Single): Boolean;
    function GetDistanceSqr(const aPoint: TKMVertex2): Single;
    function GetCenter: TKMVertex2;
    function GetOffset(aX, aY: Single): TKMPolygon2;
  end;

  // Growing list of vertices
  TKMVertex3List = record
  public
    Vertices: TKMVertex3Array;
    Count: Integer;
    class function New(aCapacity: Integer): TKMVertex3List; static;
    procedure Push(const aVertex: TKMVertex3); overload;
    procedure Push(const aVertex1, aVertex2, aVertex3: TKMVertex3); overload;
    procedure Push(const aVertex1, aVertex2, aVertex3, aVertex4: TKMVertex3); overload;
    function GetBounds: TKMVertexBox;
  end;

  // Store N best vertices (sorted)
  TKMVertexComparer = reference to function(const A, B: TKMVertex3): Integer;
  TKMVertex3PriorityList = record
  public
    // Max Capacity limited by array length set in constructor
    Vertices: array of TKMVertex3;
    Count: Integer;
    Comparer: TKMVertexComparer;
    class function New(aCapacity: Integer; aComparer: TKMVertexComparer): TKMVertex3PriorityList; static;
    procedure Push(aVertex: TKMVertex3);
    procedure Delete(aIndex: Integer);
    procedure Clear;
  end;

  // A plane in Normal+Distance format (used in TKMFrustum)
  TKMPlane = record
  public
    Normal: TKMVertex3;
    Distance: Single;
    class function New(const A,B,C,Distance: Single): TKMPlane; overload; static;
    class function New(const aNormal: TKMVertex3; const aDistance: Single): TKMPlane; overload; static;
    procedure Normalize;
  end;
  PKMPlane = ^TKMPlane;

  //For the "TKMFrustum.SphereInFrustum" it is important that the front plane was the last in the enumeration
  TKMPlaneType = (pLeft, pTop, pRight, pBottom, pBack, pFront);

  TKMFrustum = record
  public
    Planes: array [TKMPlaneType] of TKMPlane;
    class function New(const aMatViewProj: TMatrix4): TKMFrustum; static;
    function GetCornerPoints: TKMVertex3Array;
    function GetSideRays: TKMRayArray;
    function PointInFrustum(const aPoint: TKMVertex3): Boolean;
    function SphereInFrustum(const aCenter: TKMVertex3; aRadius: Single): Boolean; overload;
    function SphereInFrustum(const aSphere: TKMVertexSphere): Boolean; overload;
    function ClipByPlane(const aClippingPlaneZ: Single): TKMVertex3Array;
  end;
  PKMFrustum = ^TKMFrustum;

  // Blob of PNCM vertices and indices ready to render
  // Has variables 'VertCount' and 'IndCount' just for convenience
  TKMGeometryBlob = record
  public
    VertCount: Word;
    Verts: TKMVertexPNCMArray;
    IndCount: Word;
    Indices: TArray<Word>;
    class function New(aVertCount, aIndCount: Word): TKMGeometryBlob; static;
    function IsEmpty: Boolean;
  end;
  PKMGeometryBlob = ^TKMGeometryBlob;

  // Lowpoly hit-test model
  TKMHitTestModelLowpoly = record
  public
    VertCount: Byte;
    Verts: TKMVertex3Array;
    PolyCount: Byte;
    Indices: TArray<Word>; // We dont need Words, but they are just easier to render for debug

    // For debug display we can show nicer wireframe if we use one more indice set
    DbgWireIndCount: Byte;
    DbgWireIndices: TArray<Word>; // We dont need Words, but they are just easier to render for debug
    function IsEmpty: Boolean;
    function HitTest(const aModelMat: TMatrix4; const aRay: TKMVertex3Ray; aDbgPoly: PInteger; out aEyeDist: Single): Boolean;
    function GetBoundingCube: TKMVertexBox;
  end;
  PKMHitTestModelLowpoly = ^TKMHitTestModelLowpoly;

  function MakeArray: TKMVertex2Array; overload;
  function MakeArray(aX1, aY1, aX2, aY2: Single): TKMVertex2Array; overload;
  function MakeArray(aX1, aY1, aX2, aY2, aX3, aY3: Single): TKMVertex2Array; overload;
  function MakeArray(aX1, aY1, aX2, aY2, aX3, aY3, aX4, aY4: Single): TKMVertex2Array; overload;
  function MakeArray3(aVertex: TKMVertex3): TKMVertex3Array; overload;
  function MakeArray3(aX1, aY1, aZ1, aX2, aY2, aZ2: Single): TKMVertex3Array; overload;
  function MakeArray3(aX1, aY1, aZ1, aX2, aY2, aZ2, aX3, aY3, aZ3: Single): TKMVertex3Array; overload;
  function MakeArray3(aX1, aY1, aZ1, aX2, aY2, aZ2, aX3, aY3, aZ3, aX4, aY4, aZ4: Single): TKMVertex3Array; overload;
  function MakeArray3(aVert1, aVert2: TKMVertex3): TKMVertex3Array; overload;
  function MakeArray3(aVert1, aVert2, aVert3: TKMVertex3): TKMVertex3Array; overload;
  function MakeArray3(aVert1, aVert2, aVert3, aVert4: TKMVertex3): TKMVertex3Array; overload;

  function VertexBoxDistanceSqr(const aPoint: TKMVertex3; const aBox: TKMVertexBox): Single;
  function QuaternionToEuler(aQuat: TKMVertex3): TKMVertex3; overload;
  function QuaternionToEuler(aQuat: TKMVertex4): TKMVertex3; overload;
  function RayTriangleIntersect(const aRay: TKMVertex3Ray; const V1, V2, V3: TKMVertex3; out aEyeDist: Single): Boolean; overload;
  function RayTriangleIntersect(const aRay: TKMVertex3Ray; const V1, V2, V3: TKMVertex3; out aPoint, aNormal: TKMVertex3): Boolean; overload;
  function RayBoxIntersect(const aRay: TKMVertex3Ray; const aBox: TKMVertexBox; out aEyeDist: Single): Boolean;

  procedure SplineRasterize(const aA, aAnchorA, aAnchorB, aB: TKMVertex2; aSpacing: Single; var aNodes: TKMVertex2Array);

  function AnglesLerp(const A, B: TKMVertex3; aFrac: Single): TKMVertex3;
  function SegmentsIntersection(const A, B, C, D: TKMVertex2): TKMVertex2;

  function VectorCrossProduct(const A, B: TKMVertex2): Single; overload; inline;
  function VectorDotProduct(const A, B: TKMVertex2): Single; overload; inline;
  function VectorToEuler(const A: TKMVertex2): Single; overload;
  function VectorToEuler(const A: TKMVertex3): TKMVertex2; overload;

  function VectorCrossProductXY(A, B: TKMVertex3): Single; inline;
  function VectorDistanceXY(A, B: TKMVertex3): Single; inline;
  function VectorDistancePointSegmentSqrXY(const aPoint, aSegA, aSegB: TKMVertex2; var T: Single): Single;
  function VectorDotProduct(const A, B: TKMVertex3): Single; overload; inline;
  function VectorDotXY(A, B: TKMVertex3): Single; inline;
  function VectorCrossProduct(const A, B: TKMVertex3): TKMVertex3; overload; inline;
  function VectorCrossProduct(const A, B, C: PKMVertex3): TKMVertex3; overload; inline;
  function VectorRotateXY(A: TKMVertex3; aAngle: Single): TKMVertex3; inline;
  function VectorRotateXYAround05(A: TKMVertex3; aAngle: Single): TKMVertex3; inline;
  function VectorTriAreaXY(A, B, C: TKMVertex3): Single; inline;


const
  // Convert tile-space coordinates to vertice-space
  //
  //  V---------|
  //  |         |
  //  |    T    |
  //  |         |
  //  |_________|
  TILE_TO_VERT3: TKMVertex3 = (X: 0.5; Y: 0.5; Z: 0.0);


implementation
uses
  KromUtils;

const
  Epsilon: Single = 1E-40;


{ TKMTexCoords }
class function TKMTexCoords.New(aId: Cardinal; aU1, aV1, aU2, aV2: Single): TKMTexCoords;
begin
  Result.ID := aId;
  Result.u1 := aU1;
  Result.v1 := aV1;
  Result.u2 := aU2;
  Result.v2 := aV2;
end;


function TKMTexCoords.ToMatrix3: TMatrix3;
begin
  Result := TMatrix3.NewTranslateAndScale(u1, v1, u2 - u1, v2 - v1);
end;


{ TKMVertex2 }
class function TKMVertex2.NaN: TKMVertex2;
begin
  Result.X := MaxInt;
  Result.Y := MaxInt;
end;


class function TKMVertex2.New(aX, aY: Single): TKMVertex2;
begin
  Result.X := aX;
  Result.Y := aY;
end;


class function TKMVertex2.NewLerp(A, B: TKMVertex2; aFrac: Single): TKMVertex2;
begin
  Result := A + (B - A) * aFrac;
end;


class operator TKMVertex2.Add(const A, B: TKMVertex2): TKMVertex2;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
end;


class operator TKMVertex2.Divide(const A, B: TKMVertex2): TKMVertex2;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
end;


class operator TKMVertex2.Divide(const A: TKMVertex2; B: Single): TKMVertex2;
begin
  Result.X := A.X / B;
  Result.Y := A.Y / B;
end;


class operator TKMVertex2.Equal(const A, B: TKMVertex2): Boolean;
begin
  //Result := (A.X = B.X) and (A.Y = B.Y);
  Result := (Abs(A.X - B.X) < 0.0001) and (Abs(A.Y - B.Y) < 0.0001);
end;


class operator TKMVertex2.NotEqual(const A, B: TKMVertex2): Boolean;
begin
  Result := (Abs(A.X - B.X) >= 0.0001) or (Abs(A.Y - B.Y) >= 0.0001);
end;


class operator TKMVertex2.Multiply(A: Single; const B: TKMVertex2): TKMVertex2;
begin
  Result.X := A * B.X;
  Result.Y := A * B.Y;
end;


class operator TKMVertex2.Multiply(const A: TKMVertex2; B: Single): TKMVertex2;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
end;


class operator TKMVertex2.Multiply(const A, B: TKMVertex2): TKMVertex2;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
end;


class operator TKMVertex2.Subtract(const A, B: TKMVertex2): TKMVertex2;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
end;


function TKMVertex2.ToString: string;
begin
  Result := 'X:' + FloatToStrF(X, ffGeneral, 10, 8) + ' Y:' + FloatToStrF(Y, ffGeneral, 10, 8);
end;


function TKMVertex2.GetLength: Single;
begin
  Result := Sqrt(Sqr(X) + Sqr(Y));
end;


function TKMVertex2.GetLengthSqr: Single;
begin
  Result := Sqr(X) + Sqr(Y);
end;


function TKMVertex2.GetNormalize: TKMVertex2;
var
  d: Single;
begin
  d := Sqrt(Sqr(X) + Sqr(Y));

  if d = 0 then Exit(Self);

  d := 1 / d;
  Result.X := X * d;
  Result.Y := Y * d;
end;


// aAngle - angle in radians by which we want to rotate the vector
function TKMVertex2.GetRotate(aAngle: Single): TKMVertex2;
var
  c, s: Single;
begin
  c := Cos(aAngle);
  s := Sin(aAngle);
  Result.X := X * c - Y * s;
  Result.Y := X * s + Y * c;
end;


function TKMVertex2.GetRotate45: TKMVertex2;
const
  c = 0.707106781;
  s = 0.707106781;
begin
  Result.X := X * c - Y * s;
  Result.Y := X * s + Y * c;
end;


function TKMVertex2.GetRotate90: TKMVertex2;
begin
  Result.X := -Y;
  Result.Y := X;
end;


function TKMVertex2.GetRound: TKMVertex2;
begin
  Result.X := Round(Y);
  Result.Y := Round(X);
end;


function TKMVertex2.IsNaN: Boolean;
begin
  // Treat MaxInt as invalid number
  // Due to Single floating-point precision loss, MaxInt actually gets saved off by +1
  // So we use this hacky solution instead of straightforward compare
  Result := (X > MaxInt / 2) or (Y > MaxInt / 2);
end;


{ TKMVertex2UV }
class function TKMVertex2UV.New(aX, aY, aU, aV: Single): TKMVertex2UV;
begin
  Result.X := aX;
  Result.Y := aY;
  Result.U := aU;
  Result.V := aV;
end;


{ TKMVertex3 }
class operator TKMVertex3.Add(const A, B: TKMVertex3): TKMVertex3;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
  Result.Z := A.Z + B.Z;
end;


class operator TKMVertex3.Divide(const A: TKMVertex3; B: Single): TKMVertex3;
begin
  Result.X := A.X / B;
  Result.Y := A.Y / B;
  Result.Z := A.Z / B;
end;


class operator TKMVertex3.Equal(const A, B: TKMVertex3): Boolean;
begin
  //Result := (A.X = B.X) and (A.Y = B.Y) and (A.Z = B.Z);
  Result := (Abs(A.X - B.X) < 0.0001) and (Abs(A.Y - B.Y) < 0.0001) and (Abs(A.Z - B.Z) < 0.0001);
end;


class operator TKMVertex3.Multiply(const A: TKMVertex3; B: TKMVertex3): TKMVertex3;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
  Result.Z := A.Z * B.Z;
end;


class operator TKMVertex3.Negative(const A: TKMVertex3): TKMVertex3;
begin
  Result.X := -A.X;
  Result.Y := -A.Y;
  Result.Z := -A.Z;
end;


class operator TKMVertex3.Subtract(const A, B: TKMVertex3): TKMVertex3;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
  Result.Z := A.Z - B.Z;
end;


class operator TKMVertex3.Multiply(const A: TKMVertex3; B: Single): TKMVertex3;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
  Result.Z := A.Z * B;
end;


class function TKMVertex3.New(aX, aY, aZ: Single): TKMVertex3;
begin
  Result.X := aX;
  Result.Y := aY;
  Result.Z := aZ;
end;


class function TKMVertex3.New(A: TKMVertex2): TKMVertex3;
begin
  Result.X := A.X;
  Result.Y := A.Y;
  Result.Z := 0;
end;


class function TKMVertex3.New(A: TKMVertex2; aZ: Single): TKMVertex3;
begin
  Result.X := A.X;
  Result.Y := A.Y;
  Result.Z := aZ;
end;


class function TKMVertex3.New(const aArray3: TArray<Single>): TKMVertex3;
begin
  Assert(Length(aArray3) = 3);
  Result.X := aArray3[0];
  Result.Y := aArray3[1];
  Result.Z := aArray3[2];
end;


// Angles must be already in Radians!
class function TKMVertex3.NewHP(aHeading, aPitch: Single): TKMVertex3;
begin
  Result.X := Sin(aHeading) * Cos(aPitch);
  Result.Y := -Cos(aHeading) * Cos(aPitch);
  Result.Z := Sin(aPitch);
end;


class function TKMVertex3.NewLerp(A, B: TKMVertex3; aFrac: Single): TKMVertex3;
begin
  Result := A + (B - A) * aFrac;
end;


class function TKMVertex3.NaN: TKMVertex3;
begin
  Result.X := MaxInt;
  Result.Y := MaxInt;
  Result.Z := MaxInt;
end;


function VectorDistanceXY(A, B: TKMVertex3): Single;
var
  dx,dy: Single;
begin
  dx := A.X - B.X;
  dy := A.Y - B.Y;
  Result := Sqrt(dx*dx + dy*dy);
end;


// T is the fraction between aSegA and aSegB where the closest point to the aPoint is located
// T is limited to 0..1 range
// if aPoint is beyond segment, Result is still accurate to the segment endpoint
//
//                     aPoint
//                       |
//   SegA----------------T-----SegB
//
function VectorDistancePointSegmentSqrXY(const aPoint, aSegA, aSegB: TKMVertex2; var T: Single): Single;
var
  pqx, pqy, dx, dy, d: Single;
begin
  pqx := aSegB.X - aSegA.X;
  pqy := aSegB.Y - aSegA.Y;

  dx := aPoint.X - aSegA.X;
  dy := aPoint.Y - aSegA.Y;

  D := pqx * pqx + pqy * pqy;
  T := pqx * dx + pqy * dy;

  if (D > 0) then
    T := T / D;

  T := EnsureRange(T, 0, 1);

  dx := aSegA.X + T * pqx - aPoint.X;
  dy := aSegA.Y + T * pqy - aPoint.Y;
  Result := dx * dx + dy * dy;
end;


function VectorDotXY(A, B: TKMVertex3): Single;
begin
  Result := A.X * B.X + A.Y * B.Y;
end;


function TKMVertex3.GetLength: Single;
begin
  Result := Sqrt(GetLengthSqr);
end;


function TKMVertex3.GetLengthSqr: Single;
begin
  // FastMath uses this approach instead of Sqr(x).
  // Maybe we can prefer it too
  Result := X*X + Y*Y + Z*Z;
end;


function TKMVertex3.GetNormalize: TKMVertex3;
var
  d: Single;
begin
  d := GetLength;

  if d = 0 then Exit(Self);

  d := 1 / d;
  Result.X := X * d;
  Result.Y := Y * d;
  Result.Z := Z * d;
end;


// Normalize vector components as angles into 0 .. 2Pi range
function TKMVertex3.GetNormalizeAngles: TKMVertex3;
const
  Pi2 = Pi * 2;
begin
  Result := Self / Pi2;

  if Result.X >= 1.0 then
    Result.X := Frac(Result.X)
  else
  if Result.X < 0.0 then
    Result.X := Result.X - Ceil(Result.X);

  if Result.Y >= 1.0 then
    Result.Y := Frac(Result.Y)
  else
  if Result.Y < 0.0 then
    Result.Y := Result.Y - Ceil(Result.Y);

  if Result.Z >= 1.0 then
    Result.Z := Frac(Result.Z)
  else
  if Result.Z < 0.0 then
    Result.Z := Result.Z - Ceil(Result.Z);

  Result := Result * Pi2;
end;


function TKMVertex3.GetNormalizeXY: TKMVertex3;
var
  d: Single;
begin
  d := Sqrt(Sqr(X) + Sqr(Y));

  if d = 0 then Exit(Self);

  d := 1 / d;
  Result.X := X * d;
  Result.Y := Y * d;
  Result.Z := Z;
end;


function TKMVertex3.GetOffset(aX, aY, aZ: Single): TKMVertex3;
begin
  Result.X := X + aX;
  Result.Y := Y + aY;
  Result.Z := Z + aZ;
end;


function TKMVertex3.GetOffsetZ(aZ: Single): TKMVertex3;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z + aZ;
end;


function TKMVertex3.GetRotateXY90(aAngle90: Byte): TKMVertex3;
begin
  Result := Self;

  // Say we had 0:2
  case aAngle90 mod 4 of
    0: begin Result.X :=  X; Result.Y :=  Y; end; //  0: 2
    1: begin Result.X := -Y; Result.Y :=  X; end; // -2: 0
    2: begin Result.X := -X; Result.Y := -Y; end; //  0:-2
    3: begin Result.X :=  Y; Result.Y := -X; end; //  2: 0
  end;
end;


function TKMVertex3.IsNaN: Boolean;
begin
  // Treat MaxInt as invalid number
  // Due to Single floating-point precision loss, MaxInt actually gets saved off by +1
  // So we use this hacky solution instead of straightforward compare
  Result := (X > MaxInt / 2) or (Y > MaxInt / 2) or (Z > MaxInt / 2);
end;


function VectorCrossProductXY(A, B: TKMVertex3): Single;
begin
  Result := A.Y*B.X - A.X*B.Y;
end;


function VectorRotateXY(A: TKMVertex3; aAngle: Single): TKMVertex3;
var
  c, s: Single;
begin
  c := Cos(aAngle);
  s := Sin(aAngle);
  Result.X := A.X * c - A.Y * s;
  Result.Y := A.X * s + A.Y * c;
  Result.Z := A.Z;
end;


// Rotate around TILE_TO_VERT3
function VectorRotateXYAround05(A: TKMVertex3; aAngle: Single): TKMVertex3;
var
  c, s: Single;
begin
  c := Cos(aAngle);
  s := Sin(aAngle);
  Result.X := (A.X - 0.5) * c - (A.Y - 0.5) * s + 0.5;
  Result.Y := (A.X - 0.5) * s + (A.Y - 0.5) * c + 0.5;
  Result.Z := A.Z;
end;


function TKMVertex3.ToArray3: TArray<Single>;
begin
  SetLength(Result, 3);
  Result[0] := X;
  Result[1] := Y;
  Result[2] := Z;
end;


function TKMVertex3.ToString: string;
begin
  Result := 'X:' + FloatToStrF(X, ffGeneral, 10, 8) + ' Y:' + FloatToStrF(Y, ffGeneral, 10, 8) + ' Z:' + FloatToStrF(Z, ffGeneral, 10, 8);
end;


function TKMVertex3.GetXY: TKMVertex2;
begin
  Result.X := X;
  Result.Y := Y;
end;


function TKMVertex3.GetXZ: TKMVertex2;
begin
  Result.X := X;
  Result.Y := Z;
end;


function TKMVertex3.GetYZ: TKMVertex2;
begin
  Result.X := Y;
  Result.Y := Z;
end;


// Derives the signed xy-plane area of the triangle ABC, or the relationship of line AB to point C.
// Returns the signed xy-plane area of the triangle
function VectorTriAreaXY(A, B, C: TKMVertex3): Single;
var
  abx, aby, acx, acy: Single;
begin
  abx := B.X - A.X;
  aby := B.Y - A.Y;
  acx := C.X - A.X;
  acy := C.Y - A.Y;
  Result := acx * aby - abx * acy;
end;


{ TKMVertex3M }
class function TKMVertex3M.New(aX, aY, aZ: Single): TKMVertex3M;
begin
  Result.X := aX;
  Result.Y := aY;
  Result.Z := aZ;
  Result.U := 0.0;
  Result.V := 0.0;
end;


class function TKMVertex3M.New(aX, aY, aZ, aU, aV: Single): TKMVertex3M;
begin
  Result.X := aX;
  Result.Y := aY;
  Result.Z := aZ;
  Result.U := aU;
  Result.V := aV;
end;


class function TKMVertex3M.New(const aXYZ: TKMVertex3; aU, aV: Single): TKMVertex3M;
begin
  Result.X := aXYZ.X;
  Result.Y := aXYZ.Y;
  Result.Z := aXYZ.Z;
  Result.U := aU;
  Result.V := aV;
end;


function TKMVertex3M.GetRotateXY90(aAngle90: Byte): TKMVertex3M;
begin
  Result := Self;

  // Say we had 0:2
  case aAngle90 mod 4 of
    0: begin Result.X :=  X; Result.Y :=  Y; end; //  0: 2
    1: begin Result.X := -Y; Result.Y :=  X; end; // -2: 0
    2: begin Result.X := -X; Result.Y := -Y; end; //  0:-2
    3: begin Result.X :=  Y; Result.Y := -X; end; //  2: 0
  end;
end;


function TKMVertex3M.GetRotateAround(aCenter: TKMVertex2; aAngle: Single): TKMVertex3M;
var
  c, s: Single;
begin
  Result := Self;

  c := Cos(aAngle);
  s := Sin(aAngle);

  Result.X := (X - aCenter.X) * c - (Y - aCenter.Y) * s + aCenter.X;
  Result.Y := (X - aCenter.X) * s + (Y - aCenter.Y) * c + aCenter.Y;
end;


function TKMVertex3M.GetOffset(const aXYZ: TKMVertex3): TKMVertex3M;
begin
  Result := Self;
  Result.X := X + aXYZ.X;
  Result.Y := Y + aXYZ.Y;
  Result.Z := Z + aXYZ.Z;
end;


{ TKMVertex4 }
class operator TKMVertex4.Add(const A, B: TKMVertex4): TKMVertex4;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
  Result.Z := A.Z + B.Z;
  Result.W := A.W + B.W;
end;


class operator TKMVertex4.Multiply(const A: TKMVertex4; B: Single): TKMVertex4;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
  Result.Z := A.Z * B;
  Result.W := A.W * B;
end;


class operator TKMVertex4.Negative(const A: TKMVertex4): TKMVertex4;
begin
  Result.X := -A.X;
  Result.Y := -A.Y;
  Result.Z := -A.Z;
  Result.W := -A.W;
end;


class function TKMVertex4.New(const aXYZ: TKMVertex3; aW: Single): TKMVertex4;
begin
  Result.X := aXYZ.X;
  Result.Y := aXYZ.Y;
  Result.Z := aXYZ.Z;
  Result.W := aW;
end;


class function TKMVertex4.New(const aArray4: TArray<Single>): TKMVertex4;
begin
  Assert(Length(aArray4) = 4);
  Result.X := aArray4[0];
  Result.Y := aArray4[1];
  Result.Z := aArray4[2];
  Result.W := aArray4[3];
end;


class function TKMVertex4.New(aX, aY, aZ, aW: Single): TKMVertex4;
begin
  Result.X := aX;
  Result.Y := aY;
  Result.Z := aZ;
  Result.W := aW;
end;


class function TKMVertex4.GetDotProduct(const A, B: TKMVertex4): Single;
begin
  Result := A.X * B.X + A.Y * B.Y + A.Z * B.Z + A.W * B.W;
end;


class function TKMVertex4.NewLerp(const A, B: TKMVertex4; aFrac: Single): TKMVertex4;
begin
  Result.X := Lerp(A.X, B.X, aFrac);
  Result.Y := Lerp(A.Y, B.Y, aFrac);
  Result.Z := Lerp(A.Z, B.Z, aFrac);
  Result.W := Lerp(A.W, B.W, aFrac);
end;


class function TKMVertex4.NewNLerp(const A, B: TKMVertex4; aFrac: Single): TKMVertex4;
begin
  // Surprisingly, A and -A represent same orientation, but interpolating between them will cause a roundtrip.
  // Thus we need to check for that and if DOT is negative, negate one quaternion to get short Lerp path
  if TKMVertex4.GetDotProduct(A, B) < 0 then
    Result := TKMVertex4.NewLerp(-A, B, aFrac)
  else
    Result := TKMVertex4.NewLerp(A, B, aFrac);

  Result := Result.GetNormalize;
end;


// Looks raw .. find a better one?
class function TKMVertex4.NewSLerp(const A, B: TKMVertex4; aFrac: Single): TKMVertex4;
var
  cosHalfTheta, sinHalfTheta, halfTheta: Single;
  ratioA, ratioB: Single;
begin
  // Calculate angle between them
  cosHalfTheta := GetDotProduct(A, B);

  // if A=B or A=-B then theta = 0 and we can return A
  if Abs(cosHalfTheta) >= 1.0 then
    Exit(A);

  sinHalfTheta := Sqrt(1.0 - cosHalfTheta * cosHalfTheta);

  // If theta = 180 degrees then result is not fully defined
  // we could rotate around any axis normal to A or B
  if Abs(sinHalfTheta) < 0.001 then
    Exit(A * 0.5 + B * 0.5);

  halfTheta := ArcCos(cosHalfTheta);
  ratioA := Sin((1 - aFrac) * halfTheta) / sinHalfTheta;
  ratioB := Sin(aFrac * halfTheta) / sinHalfTheta;

  // Calculate Quaternion
  Result := A * ratioA + B * ratioB;
end;


class function TKMVertex4.NewQuaternion(const aRotate: TKMVertex3; aOrder: TKMRotationOrder = roXYZ): TKMVertex4;
const
  // Taken from https://github.com/mrdoob/three.js/src/math/Quaternion.js
  // Note, its XYZW there, but we use WXYZ here, hence swapped columns
  Q_SIGNS: array [TKMRotationOrder, 0..3] of Single = (
    (-1, +1, -1, +1),
    (+1, +1, -1, -1),
    (-1, -1, +1, +1),
    (+1, -1, +1, -1),
    (-1, +1, +1, -1),
    (+1, -1, -1, +1));
var
  hSin, hCos, pSin, pCos, bSin, bCos: Single;
begin
  // We use different that traditional axis setup. Our ground plane is XY and Z goes up

  hSin := Sin(aRotate.X / 2);
  hCos := Cos(aRotate.X / 2);

  pSin := Sin(-aRotate.Z / 2);
  pCos := Cos(-aRotate.Z / 2);

  bSin := Sin(aRotate.Y / 2);
  bCos := Cos(aRotate.Y / 2);

  Result.W := hCos * bCos * pCos + hSin * bSin * pSin * Q_SIGNS[aOrder, 0];
  Result.X := hCos * bSin * pCos + hSin * bCos * pSin * Q_SIGNS[aOrder, 1];
  Result.Y := hCos * bCos * pSin + hSin * bSin * pCos * Q_SIGNS[aOrder, 2];
  Result.Z := hSin * bCos * pCos + hCos * bSin * pSin * Q_SIGNS[aOrder, 3];
  Result := Result.GetNormalize;
end;


class operator TKMVertex4.Subtract(const A, B: TKMVertex4): TKMVertex4;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
  Result.Z := A.Z - B.Z;
  Result.W := A.W - B.W;
end;


function TKMVertex4.GetLengthSqr: Single;
begin
  Result := Sqr(X) + Sqr(Y) + Sqr(Z) + Sqr(W);
end;


function TKMVertex4.GetNormalize: TKMVertex4;
var
  d: Single;
begin
  d := Sqrt(Sqr(X) + Sqr(Y) + Sqr(Z) + Sqr(W));

  if d = 0 then Exit(Self);

  Result := Self * (1 / d);
end;


function TKMVertex4.IsZeroLength: Boolean;
begin
  // So far we have only one use-case where we can check for perfect zero (vertex initialized, but never used)
  Result := (X + Y + Z + W) = 0.0;
end;


function TKMVertex4.ToArray4: TArray<Single>;
begin
  SetLength(Result, 4);
  Result[0] := X;
  Result[1] := Y;
  Result[2] := Z;
  Result[3] := W;
end;


{ TKMVertexPNCMW }
function TKMVertexPNCMW.GetXYZ: TKMVertex3;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
end;


procedure TKMVertexPNCMW.SetRGB(const aColor: TKMColor3f);
begin
  cR := aColor.R;
  cG := aColor.G;
  cB := aColor.B;
end;


{ TKMVertexPNCMW2 }
procedure TKMVertexPNCMW2.SetRGB(const aColor: TKMColor3f);
begin
  cR := aColor.R;
  cG := aColor.G;
  cB := aColor.B;
end;


{ TKMCircle2 }
class function TKMCircle2.New(aX, aY, aRadius: Single): TKMCircle2;
begin
  Result.Position.X := aX;
  Result.Position.Y := aY;
  Result.Radius := aRadius;
end;


class function TKMCircle2.New(aCenter: TKMVertex2; aRadius: Single): TKMCircle2;
begin
  Result.Position := aCenter;
  Result.Radius := aRadius;
end;


// See if circle is fully inside
function TKMCircle2.IsCircleInside(aX, aY, aRadius: Single): Boolean;
begin
  Result := Sqr(Position.X - aX) + Sqr(Position.Y - aY) <= Sqr(Radius - aRadius);
end;


// See if circle is fully outside
function TKMCircle2.IsCircleOutside(aX, aY, aRadius: Single): Boolean;
begin
  Result := Sqr(Position.X - aX) + Sqr(Position.Y - aY) >= Sqr(Radius + aRadius);
end;


function TKMCircle2.IsEqual(aCircle: TKMCircle2; aEpsilon: Single): Boolean;
begin
  Result := (Abs(Position.X - aCircle.Position.X) <= aEpsilon)
        and (Abs(Position.Y - aCircle.Position.Y) <= aEpsilon)
        and (Abs(Radius - aCircle.Radius) <= aEpsilon);
end;


{ TKMCircle2List }
procedure TKMCircle2List.Append(const aCircle: TKMCircle2);
begin
  SetLength(Circles, Length(Circles) + 1);
  Circles[High(Circles)] := aCircle;
end;


procedure TKMCircle2List.Clear;
begin
  SetLength(Circles, 0);
end;


function TKMCircle2List.Count: Integer;
begin
  Result := Length(Circles);
end;


procedure TKMCircle2List.Remove(const aCircle: TKMCircle2);
var
  I: Integer;
begin
  for I := 0 to High(Circles) do
  if Circles[I].IsEqual(aCircle, 0.0001) then
  begin
    Circles[I] := Circles[High(Circles)];
    SetLength(Circles, Length(Circles) - 1);
  end;
end;


{ TKMSegment2 }
class function TKMSegment2.New(const A, B: TKMVertex2): TKMSegment2;
begin
  Result.A := A;
  Result.B := B;
end;


function TKMSegment2.OnLeft(const aPoint: TKMVertex2): Boolean;
var
  ab, ap: TKMVertex2;
begin
  ab := B - A;
  ap := aPoint - A;
  Result := VectorCrossProduct(ab, ap) >= 0;
end;


// Rotate Segment around 0.5,0.5 in 90 degrees steps
function TKMSegment2.RotateAround05(aRot: Byte): TKMSegment2;
begin
  case aRot mod 4 of
    0:  Result := Self;
    1:  begin
          Result.A.X := 1 - A.Y;
          Result.A.Y := A.X;
          Result.B.X := 1 - B.Y;
          Result.B.Y := B.X;
        end;
    2:  begin
          Result.A.X := 1 - A.X;
          Result.A.Y := 1 - A.Y;
          Result.B.X := 1 - B.X;
          Result.B.Y := 1 - B.Y;
        end;
    3:  begin
          Result.A.X := A.Y;
          Result.A.Y := 1 - A.X;
          Result.B.X := B.Y;
          Result.B.Y := 1 - B.X;
        end;
  end;
end;


function TKMSegment2.Normal: TKMVertex2;
begin
  Result := TKMVertex2.New(B.Y - A.Y, A.X - B.X);
end;


function TKMSegment2.Direction: TKMVertex2;
begin
  Result := B - A;
end;


function TKMSegment2.IntersectionParameter(const aEdge: TKMSegment2): Single;
var
  segmentToEdge, segmentDir, edgeDir: TKMVertex2;
begin
  segmentToEdge := aEdge.A - A;
  segmentDir := Direction;
  edgeDir := aEdge.Direction;

  Result := VectorCrossProduct(edgeDir, segmentToEdge) / VectorCrossProduct(edgeDir, segmentDir);

  if IsNan(Result) then
    Result := 0;
end;


function TKMSegment2.Morph(const tA, tB: Single): TKMSegment2;
var
  d: TKMVertex2;
begin
  d := B - A;
  Result.A := A + d * tA;
  Result.B := A + d * tB;
end;


{ TKMPolygon2 }
class function TKMPolygon2.New: TKMPolygon2;
begin
  SetLength(Result.Points, 0);
end;


class function TKMPolygon2.New(aCount: Integer): TKMPolygon2;
begin
  SetLength(Result.Points, aCount);
end;


class function TKMPolygon2.New(aX1, aY1, aX2, aY2, aX3, aY3: Single): TKMPolygon2;
begin
  SetLength(Result.Points, 3);
  Result.Points[0].X := aX1;
  Result.Points[0].Y := aY1;
  Result.Points[1].X := aX2;
  Result.Points[1].Y := aY2;
  Result.Points[2].X := aX3;
  Result.Points[2].Y := aY3;
end;


class function TKMPolygon2.New(aX1, aY1, aX2, aY2, aX3, aY3, aX4, aY4: Single): TKMPolygon2;
begin
  SetLength(Result.Points, 4);
  Result.Points[0].X := aX1;
  Result.Points[0].Y := aY1;
  Result.Points[1].X := aX2;
  Result.Points[1].Y := aY2;
  Result.Points[2].X := aX3;
  Result.Points[2].Y := aY3;
  Result.Points[3].X := aX4;
  Result.Points[3].Y := aY4;
end;


function TKMPolygon2.PointCount: Integer;
begin
  Result := Length(Points);
end;


function TKMPolygon2.IsConvex: Boolean;
var
  a, b, c, l: Integer;
begin
  Result := True;

  l := Length(Points);
  if l >= 3 then
  begin
    a := l - 2;
    b := l - 1;
    c := 0;

    while c < Length(Points) do
    begin
      Result := TKMSegment2.New(Points[a], Points[b]).OnLeft(Points[c]);
      a := b;
      b := c;
      Inc(c);
    end;
  end;
end;


class operator TKMPolygon2.Multiply(const A: TKMPolygon2; B: Single): TKMPolygon2;
var
  I: Integer;
begin
  // Copy all fields
  Result := A;
  // Resizing array will copy it's contents (without that we'd copy only Pointer to array!)
  SetLength(Result.Points, Length(Result.Points));

  for I := 0 to High(Result.Points) do
    Result.Points[I] := Result.Points[I] * B;
end;


function TKMPolygon2.Edges: TKMSegment2Array;
var
  a, b, len, count: Integer;
begin
  SetLength(Result, 0);

  len := Length(Points);
  if len >= 2 then
  begin
    count := 0;
    SetLength(Result, len);
    a := len - 1;
    b := 0;
    while b < len do
    begin
      Result[count] := TKMSegment2.New(Points[a], Points[b]);
      a := b;
      Inc(b);
      Inc(count);
    end;
    SetLength(Result, count);
  end;
end;


function TKMPolygon2.GetCenter: TKMVertex2;
var
  I: Integer;
begin
  Result := Points[0];
  for I := 1 to High(Points) do
    Result := Result + Points[I];

  Result := Result / Length(Points);
end;


function TKMPolygon2.GetDistanceSqr(const aPoint: TKMVertex2): Single;
var
  I: Integer;
  T, dstSqr, bestT, bestDstSqr: Single;
  bestSeg: TKMSegment2;
begin
  bestT := 0;
  bestDstSqr := MaxSingle;
  for I := 0 to High(Points) do
  begin
    // Find closest segment and closest point
    dstSqr := VectorDistancePointSegmentSqrXY(aPoint, Points[I], Points[(I+1) mod Length(Points)], T);

    if dstSqr < bestDstSqr then
    begin
      bestT := T;
      bestSeg.A := Points[I];
      bestSeg.B := Points[(I+1) mod Length(Points)];
      bestDstSqr := dstSqr;
    end;
  end;

  // If point lays within polygon, then distance is 0
  if (bestT > 0.0) and (bestT < 1.0) then
    if VectorCrossProduct(bestSeg.B - bestSeg.A, aPoint - bestSeg.A) > 0 then
      bestDstSqr := 0;

  Result := bestDstSqr;
end;


function TKMPolygon2.CheckDistance(const aPoint: TKMVertex2; aDistance: Single): Boolean;
begin
  Result := GetDistanceSqr(aPoint) < Sqr(aDistance);
end;


function TKMPolygon2.CyrusBeckClip(aSubjects: TKMSegment2Array): TKMSegment2Array;
  function Clip(var aSubject: TKMSegment2): Boolean;
  var
    subjDir: TKMVertex2;
    tA, tB, t, product: Single;
    edge: TKMSegment2;
  begin
    subjDir := aSubject.Direction;
    tA := 0.0;
    tB := 1.0;

    for edge in Edges do
    begin
      product := VectorDotProduct(edge.Normal, subjDir);

      if product < 0 then
      begin
        t := aSubject.IntersectionParameter(edge);
        if t > tA then
          tA := t;
      end;

      if product > 0 then
      begin
        t := aSubject.IntersectionParameter(edge);
        if t < tB then
          tB := t;
      end;

      if (product = 0) and not edge.OnLeft(aSubject.A) then
      begin
        Result := False;
        Exit;
      end;
    end;
    if tA > tB then
    begin
      Result := False;
      Exit;
    end;
    aSubject := aSubject.Morph(tA, tB);
    Result := True;
  end;
var
  count: Integer;
  subject, clippedSubject: TKMSegment2;
begin
  if not IsConvex then Exit;

  SetLength(Result, Length(aSubjects));
  count := 0;
  for subject in aSubjects do
  begin
    clippedSubject := subject;
    if Clip(clippedSubject) then
    begin
      Result[count] := clippedSubject;
      Inc(count);
    end;
  end;
  SetLength(Result, count);
end;


function TKMPolygon2.GetOffset(aX, aY: Single): TKMPolygon2;
var
  I: Integer;
begin
  // Copy all fields
  Result := Self;
  // Resizing array will copy it's contents (without that we'd copy only Pointer to array!)
  SetLength(Result.Points, Length(Points));

  // Do the offset
  for I := 0 to High(Points) do
  begin
    Result.Points[I].X := Points[I].X + aX;
    Result.Points[I].Y := Points[I].Y + aY;
  end;
end;


{ TKMVertex3List }
class function TKMVertex3List.New(aCapacity: Integer): TKMVertex3List;
begin
  SetLength(Result.Vertices, Max(aCapacity, 16));
  Result.Count := 0;
end;


procedure TKMVertex3List.Push(const aVertex: TKMVertex3);
begin
  if Length(Vertices) = Count then
    SetLength(Vertices, Length(Vertices) * 2);

  Vertices[Count] := aVertex;
  Inc(Count);
end;


procedure TKMVertex3List.Push(const aVertex1, aVertex2, aVertex3: TKMVertex3);
begin
  if Length(Vertices) <= Count+3 then
    SetLength(Vertices, Length(Vertices) * 2);

  Vertices[Count] := aVertex1;
  Vertices[Count+1] := aVertex2;
  Vertices[Count+2] := aVertex3;
  Inc(Count, 3);
end;


procedure TKMVertex3List.Push(const aVertex1, aVertex2, aVertex3, aVertex4: TKMVertex3);
begin
  if Length(Vertices) <= Count+4 then
    SetLength(Vertices, Length(Vertices) * 2);

  Vertices[Count] := aVertex1;
  Vertices[Count+1] := aVertex2;
  Vertices[Count+2] := aVertex3;
  Vertices[Count+3] := aVertex4;
  Inc(Count, 4);
end;


function TKMVertex3List.GetBounds: TKMVertexBox;
var
  I: Integer;
begin
  if Count = 0 then
    Exit;

  Result.CornerLow := Vertices[0];
  Result.CornerHigh := Vertices[0];

  for I := 1 to Count - 1 do
  begin
    Result.CornerLow.X := Min(Result.CornerLow.X, Vertices[I].X);
    Result.CornerLow.Y := Min(Result.CornerLow.Y, Vertices[I].Y);
    Result.CornerLow.Z := Min(Result.CornerLow.Z, Vertices[I].Z);
    Result.CornerHigh.X := Max(Result.CornerHigh.X, Vertices[I].X);
    Result.CornerHigh.Y := Max(Result.CornerHigh.Y, Vertices[I].Y);
    Result.CornerHigh.Z := Max(Result.CornerHigh.Z, Vertices[I].Z);
  end;
end;


{ TKMVertex3PriorityList }
class function TKMVertex3PriorityList.New(aCapacity: Integer; aComparer: TKMVertexComparer): TKMVertex3PriorityList;
begin
  SetLength(Result.Vertices, aCapacity);
  Result.Count := 0;
  Result.Comparer := aComparer;
end;


// Use Comparer to keep only "best" values in
procedure TKMVertex3PriorityList.Push(aVertex: TKMVertex3);
var
  v: PKMVertex3;
  I, rightItems, tgt: Integer;
begin
  // Find place for new vertex
  if (Count = 0) then
  begin
    // First, trivial accept
    v := @Vertices[0];
  end
  else if Comparer(aVertex, Vertices[Count-1]) >= 0 then
  begin
    // Further than the last segment, skip
    if (Count >= Length(Vertices)) then
      Exit;
    // Last, trivial accept
    v := @Vertices[Count];
  end else
  begin
    // Insert inbetween
    tgt := -1; // Should never happen
    for I := 0 to Count - 1 do
      if Comparer(aVertex, Vertices[I]) <= 0 then
      begin
        tgt := I+1;
        Break;
      end;

    rightItems := Min(Count-I, Length(Vertices) - tgt);
    Assert((tgt <> -1) and (tgt + rightItems <= Length(Vertices)));
    if rightItems > 0 then
      Move(Vertices[I], Vertices[tgt], SizeOf(TKMVertex3) * rightItems);

    v := @Vertices[I];
  end;

  v^ := aVertex;

  if (Count < Length(Vertices)) then
    Inc(Count);
end;


procedure TKMVertex3PriorityList.Clear;
begin
  Count := 0;
end;


procedure TKMVertex3PriorityList.Delete(aIndex: Integer);
begin
  if aIndex < Count - 1 then
    Move(Vertices[aIndex + 1], Vertices[aIndex], SizeOf(TKMVertex3) * (Count - 1 - aIndex));
  Dec(Count);
end;


function MakeArray: TKMVertex2Array;
begin
  SetLength(Result, 0);
end;


function MakeArray(aX1, aY1, aX2, aY2: Single): TKMVertex2Array;
begin
  SetLength(Result, 2);
  Result[0].X := aX1;
  Result[0].Y := aY1;
  Result[1].X := aX2;
  Result[1].Y := aY2;
end;


function MakeArray(aX1, aY1, aX2, aY2, aX3, aY3: Single): TKMVertex2Array;
begin
  SetLength(Result, 3);
  Result[0].X := aX1;
  Result[0].Y := aY1;
  Result[1].X := aX2;
  Result[1].Y := aY2;
  Result[2].X := aX3;
  Result[2].Y := aY3;
end;


function MakeArray(aX1, aY1, aX2, aY2, aX3, aY3, aX4, aY4: Single): TKMVertex2Array;
begin
  SetLength(Result, 4);
  Result[0].X := aX1;
  Result[0].Y := aY1;
  Result[1].X := aX2;
  Result[1].Y := aY2;
  Result[2].X := aX3;
  Result[2].Y := aY3;
  Result[3].X := aX4;
  Result[3].Y := aY4;
end;


function MakeArray3(aVertex: TKMVertex3): TKMVertex3Array;
begin
  SetLength(Result, 1);
  Result[0] := aVertex;
end;


function MakeArray3(aX1, aY1, aZ1, aX2, aY2, aZ2: Single): TKMVertex3Array;
begin
  SetLength(Result, 2);
  Result[0].X := aX1;
  Result[0].Y := aY1;
  Result[0].Z := aZ1;
  Result[1].X := aX2;
  Result[1].Y := aY2;
  Result[1].Z := aZ2;
end;


function MakeArray3(aX1, aY1, aZ1, aX2, aY2, aZ2, aX3, aY3, aZ3: Single): TKMVertex3Array;
begin
  SetLength(Result, 3);
  Result[0].X := aX1;
  Result[0].Y := aY1;
  Result[0].Z := aZ1;
  Result[1].X := aX2;
  Result[1].Y := aY2;
  Result[1].Z := aZ2;
  Result[2].X := aX3;
  Result[2].Y := aY3;
  Result[2].Z := aZ3;
end;


function MakeArray3(aX1, aY1, aZ1, aX2, aY2, aZ2, aX3, aY3, aZ3, aX4, aY4, aZ4: Single): TKMVertex3Array;
begin
  SetLength(Result, 4);
  Result[0].X := aX1;
  Result[0].Y := aY1;
  Result[0].Z := aZ1;
  Result[1].X := aX2;
  Result[1].Y := aY2;
  Result[1].Z := aZ2;
  Result[2].X := aX3;
  Result[2].Y := aY3;
  Result[2].Z := aZ3;
  Result[3].X := aX4;
  Result[3].Y := aY4;
  Result[3].Z := aZ4;
end;


function MakeArray3(aVert1, aVert2: TKMVertex3): TKMVertex3Array;
begin
  SetLength(Result, 2);
  Result[0] := aVert1;
  Result[1] := aVert2;
end;


function MakeArray3(aVert1, aVert2, aVert3: TKMVertex3): TKMVertex3Array;
begin
  SetLength(Result, 3);
  Result[0] := aVert1;
  Result[1] := aVert2;
  Result[2] := aVert3;
end;


function MakeArray3(aVert1, aVert2, aVert3, aVert4: TKMVertex3): TKMVertex3Array;
begin
  SetLength(Result, 4);
  Result[0] := aVert1;
  Result[1] := aVert2;
  Result[2] := aVert3;
  Result[3] := aVert4;
end;


{ TKMVertexRect }
class operator TKMVertexRect.Multiply(const aRect: TKMVertexRect; aScale: Single): TKMVertexRect;
begin
  Result.Left := aRect.Left * aScale;
  Result.Top := aRect.Top * aScale;
  Result.Right := aRect.Right * aScale;
  Result.Bottom := aRect.Bottom * aScale;
end;


class function TKMVertexRect.New(const aLeft, aTop, aRight, aBottom: Single): TKMVertexRect;
begin
  Result.Left := aLeft;
  Result.Top := aTop;
  Result.Right := aRight;
  Result.Bottom := aBottom;
end;


function TKMVertexRect.ToMatrix4: TMatrix4;
begin
  Result := TMatrix4.NewTranslateAndScale(Left, Top, Right - Left, Bottom - Top);
end;


// Given Rect, we need to clip Vector to its bounds
// Assume both start at zero
{function TKMVertexRect.ClipVector(const aVector: TKMVertex2): TKMVertex2;
var
  coefX, coefY: Single;
begin
  Assert((Left = 0) and (Top = 0), 'Cant clip against non 0-based Rect');

  if (aVector.X = 0) and (aVector.Y = 0) then
    Result := aVector
  else
  if aVector.X = 0 then
    Result := TKMVertex2.New(0, Min(aVector.Y, Bottom))
  else
  if aVector.Y = 0 then
    Result := TKMVertex2.New(Min(aVector.X, Right), 0)
  else
  begin
    coefX := Min(Right / aVector.X, 1.0);
    coefY := Min(Bottom / aVector.Y, 1.0);
    Result := aVector * Min(coefX, coefY);
  end;
end;}


function TKMVertexRect.GetMove(aX, aY: Single): TKMVertexRect;
begin
  Result.Left := Left + aX;
  Result.Top := Top + aY;
  Result.Right := Right + aX;
  Result.Bottom := Bottom + aY;
end;


function TKMVertexRect.GetHeight: Single;
begin
  Result := Bottom - Top;
end;

function TKMVertexRect.GetMove(aV: TKMVertex2): TKMVertexRect;
begin
  Result.Left := Left + aV.X;
  Result.Top := Top + aV.Y;
  Result.Right := Right + aV.X;
  Result.Bottom := Bottom + aV.Y;
end;


function TKMVertexRect.GetWidth: Single;
begin
  Result := Right - Left;
end;


function TKMVertexRect.GetCenter: TKMVertex2;
begin
  Result.X := (Left + Right) / 2;
  Result.Y := (Top + Bottom) / 2;
end;


{ TKMRenderRectTex }
class function TKMRenderRectTex.New(aX1, aY1, aU1, aV1, aX2, aY2, aU2, aV2: Single; aTexId: Cardinal; aColor: TKMColor4f): TKMRenderRectTex;
begin
  Result := default(TKMRenderRectTex);

  Result.Rect.Left := aX1;
  Result.Rect.Top := aY1;
  Result.Rect.Right := aX2;
  Result.Rect.Bottom := aY2;
  Result.Tex.u1 := aU1;
  Result.Tex.v1 := aV1;
  Result.Tex.u2 := aU2;
  Result.Tex.v2 := aV2;
  Result.Tex.ID := aTexId;
  Result.Color := aColor;
end;


class function TKMRenderRectTex.New(aX1, aY1, aX2, aY2: Single; aTex: TKMTexCoords; aColor: TKMColor4f): TKMRenderRectTex;
begin
  Result := default(TKMRenderRectTex);

  Result.Rect.Left := aX1;
  Result.Rect.Top := aY1;
  Result.Rect.Right := aX2;
  Result.Rect.Bottom := aY2;
  Result.Tex := aTex;
  Result.Color := aColor;
end;


// Lerp angles with regard to loop over 0..2Pi range
//todo -cOptimization: This solution is inefficient, but we'll need to refactor animations into quaternions anyway
function AnglesLerp(const A, B: TKMVertex3; aFrac: Single): TKMVertex3;
const
  Pi2 = Pi * 2;
  SANE_RANGE = Pi2*10;
var
  a2, b2: TKMVertex3;
begin
  Assert(Abs(A.X) <= SANE_RANGE, 'AnglesLerp');

  a2 := A.GetNormalizeAngles;
  b2 := B.GetNormalizeAngles;

  if Abs(a2.X - b2.X) <= Pi then
    Result.X := Lerp(a2.X, b2.X, aFrac)
  else
  begin
    if a2.X > b2.X then
      Result.X := Lerp(a2.X - Pi2, b2.X, aFrac)
    else
      Result.X := Lerp(a2.X, b2.X - Pi2, aFrac);

    if Result.X < 0 then
      Result.X := Result.X + Pi2;
  end;

  if Abs(a2.Y - b2.Y) <= Pi then
    Result.Y := Lerp(a2.Y, b2.Y, aFrac)
  else
  begin
    if a2.Y > b2.Y then
      Result.Y := Lerp(a2.Y - Pi2, b2.Y, aFrac)
    else
      Result.Y := Lerp(a2.Y, b2.Y - Pi2, aFrac);

    if Result.Y < 0 then
      Result.Y := Result.Y + Pi2;
  end;

  if Abs(a2.Z - b2.Z) <= Pi then
    Result.Z := Lerp(a2.Z, b2.Z, aFrac)
  else
  begin
    if a2.Z > b2.Z then
      Result.Z := Lerp(a2.Z - Pi2, b2.Z, aFrac)
    else
      Result.Z := Lerp(a2.Z, b2.Z - Pi2, aFrac);

    if Result.Z < 0 then
      Result.Z := Result.Z + Pi2;
  end;
end;


function VectorDotProduct(const A, B: TKMVertex3): Single;
begin
  Result := A.X * B.X + A.Y * B.Y + A.Z * B.Z;
end;


function VectorCrossProduct(const A, B: TKMVertex3): TKMVertex3;
begin
  Result.X := A.Y * B.Z - A.Z * B.Y;
  Result.Y := A.Z * B.X - A.X * B.Z;
  Result.Z := A.X * B.Y - A.Y * B.X;
end;


function VectorCrossProduct(const A, B, C: PKMVertex3): TKMVertex3;
begin
  Result := VectorCrossProduct(B^ - A^, C^ - A^);
end;


// Returns Heading angle for given vector direction
// - Heading starts at North and goes clockwise from 0 to 360
function VectorToEuler(const A: TKMVertex2): Single;
//var
//  dist: Single;
begin
  //dist := Sqrt(Sqr(A.X) + Sqr(A.Y));
  // Convert XY to angle value
  Result := ArcTan2(-A.X, A.Y) / Pi * 180 + 180;
end;


// Returns Heading and Pitch angles for given vector direction
// - Heading starts at North and goes clockwise from 0 to 360
// - Pitch starts at XY plane and goes up from 0 up to 90
function VectorToEuler(const A: TKMVertex3): TKMVertex2;
var
  distXYZ: Single;
begin
  // Convert XY to angle value
  Result.X := ArcTan2(-A.X, A.Y) / Pi * 180 + 180;

  if Abs(A.Z) < Epsilon then
    // Flat vector in XY plane
    Result.Y := 0
  else
  begin
    distXYZ := Sqrt(Sqr(A.X) + Sqr(A.Y) + Sqr(A.Z));
    Result.Y := 90 - ArcCos(A.Z / distXYZ) / Pi * 180;
  end;
end;


// Distance between vertex and a box ^2
function VertexBoxDistanceSqr(const aPoint: TKMVertex3; const aBox: TKMVertexBox): Single;
var
  top: TKMVertex3;
begin
  top := TKMVertex3.New((aBox.CornerLow.X + aBox.CornerHigh.X) / 2,
                        (aBox.CornerLow.Y + aBox.CornerHigh.Y) / 2,
                         aBox.CornerHigh.Z);
  top := top - aPoint;
  Result := top.GetLengthSqr;
end;


function QuaternionToEuler(aQuat: TKMVertex3): TKMVertex3;
var
  t, w, xx, yy, zz: Single;
begin
  xx := Sqr(aQuat.X);
  yy := Sqr(aQuat.Y);
  zz := Sqr(aQuat.Z);

  t := 1 - xx - yy - zz;
  if t < 0 then
    w := 0
  else
    w := -Sqrt(t);

  t := aQuat.X * aQuat.Y + aQuat.Z * W;
  if (t > 0.499) then // singularity at north pole
  begin
    Result.X := 2 * ArcTan2(aQuat.X, w);
    Result.Y := Pi/2;
    Result.Z := 0;
  end
  else
  if (t < -0.499) then // singularity at south pole
  begin
    Result.X := -2 * ArcTan2(aQuat.X, w);
    Result.Y := - Pi/2;
    Result.Z := 0;
  end
  else
  begin
    Result.X := ArcTan2(2*aQuat.Y*w - 2*aQuat.X*aQuat.Z, 1 - 2*yy - 2*zz);
    Result.Y := ArcSin(2*t);
    Result.Z := ArcTan2(2*aQuat.X*w - 2*aQuat.Y*aQuat.Z, 1 - 2*xx - 2*zz);
  end;
end;


function QuaternionToEuler(aQuat: TKMVertex4): TKMVertex3;
var
  t, xx, yy, zz: Single;
begin
  xx := Sqr(aQuat.X);
  yy := Sqr(aQuat.Y);
  zz := Sqr(aQuat.Z);

  t := aQuat.X * aQuat.Y + aQuat.Z * aQuat.W;
  if (t > 0.499) then // singularity at north pole
  begin
    Result.X := 2 * ArcTan2(aQuat.X, aQuat.W);
    Result.Y := Pi/2;
    Result.Z := 0;
  end
  else
  if (t < -0.499) then // singularity at south pole
  begin
    Result.X := -2 * ArcTan2(aQuat.X, aQuat.W);
    Result.Y := - Pi/2;
    Result.Z := 0;
  end
  else
  begin
    Result.X := ArcTan2(2*aQuat.Y*aQuat.W - 2*aQuat.X*aQuat.Z, 1 - 2*yy - 2*zz);
    Result.Y := ArcSin(2*t);
    Result.Z := ArcTan2(2*aQuat.X*aQuat.W - 2*aQuat.Y*aQuat.Z, 1 - 2*xx - 2*zz);
  end;
end;


function RayTriangleIntersect(const aRay: TKMVertex3Ray; const V1, V2, V3: TKMVertex3; out aEyeDist: Single): Boolean;
var
  rayDir, E1, E2, PV, QV, TV: TKMVertex3;
  T, U, V, Det, InvDet: Single;
begin
  Result := False;

  rayDir := aRay.Endpoint - aRay.Start;

  E1 := V2 - V1;
  E2 := V3 - V1;
  PV := VectorCrossProduct(rayDir, E2);
  Det := VectorDotProduct(E1, PV);

  //Skip if Ray is parallel to triangle
  if Abs(Det) < 0.00001 then
    Exit;

  InvDet := 1 / Det;
  TV := aRay.Start - V1;
  U := VectorDotProduct(TV, PV) * InvDet;

  if (U >= 0) and (U <= 1) then
  begin
    QV := VectorCrossProduct(TV, E1);
    V := VectorDotProduct(rayDir, QV) * InvDet;
    if (V >= 0) and (U + V <= 1) then
    begin
      T := VectorDotProduct(E2, QV) * InvDet;
      aEyeDist := (aRay.Endpoint - aRay.Start).GetLength * T;
      if T > 0.00001 then
        Result := True;
    end;
  end;
end;


function RayTriangleIntersect(const aRay: TKMVertex3Ray; const V1, V2, V3: TKMVertex3; out aPoint, aNormal: TKMVertex3): Boolean;
var
  rayDir, E1, E2, PV, QV, TV: TKMVertex3;
  T, U, V, Det, InvDet: Single;
begin
  Result := False;

  rayDir := aRay.Endpoint - aRay.Start;

  E1 := V2 - V1;
  E2 := V3 - V1;
  PV := VectorCrossProduct(rayDir, E2);
  Det := VectorDotProduct(E1, PV);

  //Skip if Ray is parallel to triangle
  if Abs(Det) < 0.00001 then
    Exit;

  InvDet := 1 / Det;
  TV := aRay.Start - V1;
  U := VectorDotProduct(TV, PV) * InvDet;

  if (U >= 0) and (U <= 1) then
  begin
    QV := VectorCrossProduct(TV, E1);
    V := VectorDotProduct(rayDir, QV) * InvDet;
    if (V >= 0) and (U + V <= 1) then
    begin
      T := VectorDotProduct(E2, QV) * InvDet;
      if T > 0.00001 then
      begin
        aPoint := TKMVertex3.NewLerp(aRay.Start, aRay.Endpoint, T);
        aNormal := VectorCrossProduct(E1, E2).GetNormalize;
        Result := True;
      end;
    end;
  end;
end;


function RayBoxIntersect(const aRay: TKMVertex3Ray; const aBox: TKMVertexBox; out aEyeDist: Single): Boolean;
var
  rdir, lb, rt, dirfrac: TKMVertex3;
  t1, t2, t3, t4, t5, t6, tmin, tmax: Single;
begin
  rdir := (aRay.Endpoint - aRay.Start).GetNormalize;

  lb := aBox.CornerLow;
  rt := aBox.CornerHigh;

  // r.dir is unit direction vector of ray
  dirfrac.x := 1 / rdir.x;
  dirfrac.y := 1 / rdir.y;
  dirfrac.z := 1 / rdir.z;
  // lb is the corner of AABB with minimal coordinates - left bottom, rt is maximal corner
  // r.org is origin of ray
  t1 := (lb.X - aRay.Start.X) * dirfrac.X;
  t2 := (rt.X - aRay.Start.X) * dirfrac.X;
  t3 := (lb.Y - aRay.Start.Y) * dirfrac.Y;
  t4 := (rt.Y - aRay.Start.Y) * dirfrac.Y;
  t5 := (lb.Z - aRay.Start.Z) * dirfrac.Z;
  t6 := (rt.Z - aRay.Start.Z) * dirfrac.Z;

  tmin := max(max(min(t1, t2), min(t3, t4)), min(t5, t6));
  tmax := min(min(max(t1, t2), max(t3, t4)), max(t5, t6));

  // if tmax < 0, ray (line) is intersecting AABB, but whole AABB is behing us
  if (tmax < 0) then
  begin
    aEyeDist := tmax;
    Result := False;
  end else
  // if tmin > tmax, ray doesn't intersect AABB
  if (tmin > tmax) then
  begin
    aEyeDist := tmax;
    Result := False;
  end else
  begin
    aEyeDist := tmin;
    Result := True;
  end;
end;


function VectorCrossProduct(const A, B: TKMVertex2): Single;
begin
  Result := A.X * B.Y - A.Y * B.X;
end;


function VectorDotProduct(const A, B: TKMVertex2): Single;
begin
  Result := A.X * B.X + A.Y * B.Y;
end;


{ TKMVertexBox }
class function TKMVertexBox.New(aLow, aHigh: TKMVertex3): TKMVertexBox;
begin
  Result.CornerLow := aLow;
  Result.CornerHigh := aHigh;
end;


class function TKMVertexBox.New(aLowX, aLowY, aLowZ, aHighX, aHighY, aHighZ: Single): TKMVertexBox;
begin
  Result.CornerLow := TKMVertex3.New(aLowX, aLowY, aLowZ);
  Result.CornerHigh := TKMVertex3.New(aHighX, aHighY, aHighZ);
end;


class function TKMVertexBox.NewUnit: TKMVertexBox;
begin
  Result.CornerLow := TKMVertex3.New(-1, -1, -1);
  Result.CornerHigh := TKMVertex3.New(1, 1, 1);
end;


class operator TKMVertexBox.Add(const A: TKMVertexBox; B: TKMVertex3): TKMVertexBox;
begin
  Result.CornerLow := A.CornerLow + B;
  Result.CornerHigh := A.CornerHigh + B;
end;


function TKMVertexBox.GetCenterLow: TKMVertex3;
begin
  Result.X := (CornerLow.X + CornerHigh.X) / 2;
  Result.Y := (CornerLow.Y + CornerHigh.Y) / 2;
  Result.Z := CornerLow.Z;
end;


class function TKMVertexSphere.New(aCenter: TKMVertex3; aRadius: Single): TKMVertexSphere;
begin
  Result.Center := aCenter;
  Result.Radius := aRadius;
end;


{ TMatrix3 }
// This rotation matrix uses invert angle to mimic LW behavior (where NG.XYZ = LW.X-ZY)
// Angle in Radians
class function TMatrix3.NewHeadingLW(aHeading: Single): TMatrix3;
begin
  Result := Identity;
  Result.m11 := Cos(-aHeading);  Result.m21 := Sin(-aHeading);
  Result.m12 := -Sin(-aHeading); Result.m22 := Cos(-aHeading);
end;


// This rotation matrix uses invert angle to mimic LW behavior (where NG.XYZ = LW.X-ZY)
// Angle in Radians
class function TMatrix3.NewPitchLW(aPitch: Single): TMatrix3;
begin
  Result := Identity;
  Result.m22 := Cos(-aPitch);  Result.m32 := Sin(-aPitch);
  Result.m23 := -Sin(-aPitch); Result.m33 := Cos(-aPitch);
end;


// Angle in Radians
class function TMatrix3.NewBankLW(aBank: Single): TMatrix3;
begin
  Result := Identity;
  Result.m11 := Cos(aBank);  Result.m13 := Sin(aBank);
  Result.m31 := -Sin(aBank); Result.m33 := Cos(aBank);
end;


class function TMatrix3.NewTranslate(aX, aY: Single): TMatrix3;
begin
  Result := Identity;
  Result.m31 := aX;
  Result.m32 := aY;
end;


class function TMatrix3.NewTranslateAndScale(aX, aY, aW, aH: Single): TMatrix3;
begin
  Result := Identity;
  Result.m11 := aW;
  Result.m22 := aH;
  Result.m31 := aX;
  Result.m32 := aY;
end;


class function TMatrix3.NewScale(aScale: Single): TMatrix3;
begin
  Result := Identity;
  Result.m11 := aScale;
  Result.m22 := aScale;
end;


class function TMatrix3.NewScale(aScaleX, aScaleY: Single): TMatrix3;
begin
  Result := Identity;
  Result.m11 := aScaleX;
  Result.m22 := aScaleY;
end;


function TMatrix3.GetRemoveTranslate: TMatrix3;
begin
  Result := Self;

  Result.m13 := 0;
  Result.m23 := 0;
  Result.m31 := 0;
  Result.m32 := 0;
end;


function TMatrix3.Scale2(const aScale: Single): TMatrix3;
var
  I: Integer;
begin
  Result := Self;

  for I := 0 to 1 do
  begin
    Result.M[I].X := M[I].X * aScale;
    Result.M[I].Y := M[I].Y * aScale;
  end;
end;


function TMatrix3.Scale2(const aX, aY: Single): TMatrix3;
var
  I: Integer;
begin
  Result := Self;

  for I := 0 to 1 do
  begin
    Result.M[I].X := M[I].X * aX;
    Result.M[I].Y := M[I].Y * aY;
  end;
end;


function TMatrix3.ToString: string;
begin
  Result := Format(
    '%.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f',
    [m11, m21, m31, m12, m22, m32, m13, m23, m33]);
end;


function TMatrix3.IsEqual(aM: TMatrix3; aEpsilon: Single): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to 3 do
  if (M[I] - aM.M[I]).GetLengthSqr > Sqr(aEpsilon) then
    Exit(False);
end;


// For some unknown reasons TMatrix3 uses Left-to-Right matrix multiplication,
// which is different from GLSL standard Right-to-Left multiplication
// Typical GLSL transform is written like: Result := Proj * View * Model * Vertex
// Same transform written in TMatrix3 is: Result := Vertex * Model * View * Proj
// Both produce exactly the same result, because GLSL evaluates Right-to-Left and TMatrix3 evaluates Left-to-Right
class operator TMatrix3.Multiply(const aMatA, aMatB: TMatrix3): TMatrix3;
begin
  Result.M[0].X := aMatA.M[0].X * aMatB.M[0].X + aMatA.M[0].Y * aMatB.M[1].X + aMatA.M[0].Z * aMatB.M[2].X;
  Result.M[0].Y := aMatA.M[0].X * aMatB.M[0].Y + aMatA.M[0].Y * aMatB.M[1].Y + aMatA.M[0].Z * aMatB.M[2].Y;
  Result.M[0].Z := aMatA.M[0].X * aMatB.M[0].Z + aMatA.M[0].Y * aMatB.M[1].Z + aMatA.M[0].Z * aMatB.M[2].Z;
  Result.M[1].X := aMatA.M[1].X * aMatB.M[0].X + aMatA.M[1].Y * aMatB.M[1].X + aMatA.M[1].Z * aMatB.M[2].X;
  Result.M[1].Y := aMatA.M[1].X * aMatB.M[0].Y + aMatA.M[1].Y * aMatB.M[1].Y + aMatA.M[1].Z * aMatB.M[2].Y;
  Result.M[1].Z := aMatA.M[1].X * aMatB.M[0].Z + aMatA.M[1].Y * aMatB.M[1].Z + aMatA.M[1].Z * aMatB.M[2].Z;
  Result.M[2].X := aMatA.M[2].X * aMatB.M[0].X + aMatA.M[2].Y * aMatB.M[1].X + aMatA.M[2].Z * aMatB.M[2].X;
  Result.M[2].Y := aMatA.M[2].X * aMatB.M[0].Y + aMatA.M[2].Y * aMatB.M[1].Y + aMatA.M[2].Z * aMatB.M[2].Y;
  Result.M[2].Z := aMatA.M[2].X * aMatB.M[0].Z + aMatA.M[2].Y * aMatB.M[1].Z + aMatA.M[2].Z * aMatB.M[2].Z;
end;


class function TMatrix3.Identity;
const
  id: TMatrix3 = (
    m11: 1; m12: 0; m13: 0;
    m21: 0; m22: 1; m23: 0;
    m31: 0; m32: 0; m33: 1
  );
begin
  Result := id;
end;


{ TMatrix4 }
// This rotation matrix uses invert angle to mimic LW behavior (where NG.XYZ = LW.X-ZY)
// Angle in Radians
class function TMatrix4.NewHeadingLW(aHeading: Single): TMatrix4;
begin
  Result := Identity;
  Result.m11 := Cos(-aHeading);  Result.m21 := Sin(-aHeading);
  Result.m12 := -Sin(-aHeading); Result.m22 := Cos(-aHeading);
end;


// This rotation matrix uses invert angle to mimic LW behavior (where NG.XYZ = LW.X-ZY)
// Angle in Radians
class function TMatrix4.NewPitchLW(aPitch: Single): TMatrix4;
begin
  Result := Identity;
  Result.m22 := Cos(-aPitch);  Result.m32 := Sin(-aPitch);
  Result.m23 := -Sin(-aPitch); Result.m33 := Cos(-aPitch);
end;


// Angle in Radians
class function TMatrix4.NewBankLW(aBank: Single): TMatrix4;
begin
  Result := Identity;
  Result.m11 := Cos(aBank);  Result.m13 := Sin(aBank);
  Result.m31 := -Sin(aBank); Result.m33 := Cos(aBank);
end;


class function TMatrix4.NewQuaternion(Q: TKMVertex4): TMatrix4;
begin
  Result := Identity;

  // By https://www.euclideanspace.com/maths/geometry/rotations/conversions/quaternionToMatrix/index.htm
  // 1 - 2*qy2 - 2*qz2  2*qx*qy - 2*qz*qw  2*qx*qz + 2*qy*qw
  // 2*qx*qy + 2*qz*qw  1 - 2*qx2 - 2*qz2  2*qy*qz - 2*qx*qw
  // 2*qx*qz - 2*qy*qw  2*qy*qz + 2*qx*qw  1 - 2*qx2 - 2*qy2
  Result.m11 := 1 - 2 * (Q.Y * Q.Y + Q.Z * Q.Z); Result.m21 := 2 * (Q.X * Q.Y - Q.Z * Q.W);     Result.m31 := 2 * (Q.X * Q.Z + Q.Y * Q.W);
  Result.m12 := 2 * (Q.X * Q.Y + Q.Z * Q.W);     Result.m22 := 1 - 2 * (Q.X * Q.X + Q.Z * Q.Z); Result.m32 := 2 * (Q.Y * Q.Z - Q.X * Q.W);
  Result.m13 := 2 * (Q.X * Q.Z - Q.Y * Q.W);     Result.m23 := 2 * (Q.Y * Q.Z + Q.X * Q.W);     Result.m33 := 1 - 2 * (Q.X * Q.X + Q.Y * Q.Y);
end;


// Convert from -1..1 to 0..1
// Divide by 2 and move +0.5
class function TMatrix4.NewBias05: TMatrix4;
begin
  Result.m11 := 0.5; Result.m21 := 0.0; Result.m31 := 0.0; Result.m41 := 0.5;
  Result.m12 := 0.0; Result.m22 := 0.5; Result.m32 := 0.0; Result.m42 := 0.5;
  Result.m13 := 0.0; Result.m23 := 0.0; Result.m33 := 0.5; Result.m43 := 0.5;
  Result.m14 := 0.0; Result.m24 := 0.0; Result.m34 := 0.0; Result.m44 := 1.0;

  //Result := TMatrix4.NewScale(0.5) * TMatrix4.NewTranslate(1, 1, 1);
end;


class function TMatrix4.NewTranslate(aX, aY: Single): TMatrix4;
begin
  Result := Identity;
  Result.m41 := aX;
  Result.m42 := aY;
end;


class function TMatrix4.NewTranslate(aX, aY, aZ: Single): TMatrix4;
begin
  Result := Identity;
  Result.m41 := aX;
  Result.m42 := aY;
  Result.m43 := aZ;
end;


class function TMatrix4.NewTranslate(const aVert: TKMVertex3): TMatrix4;
begin
  Result := Identity;
  Result.m41 := aVert.X;
  Result.m42 := aVert.Y;
  Result.m43 := aVert.Z;
end;


class function TMatrix4.NewTranslateAndScale(aX, aY, aW, aH: Single): TMatrix4;
begin
  Result := Identity;
  Result.m11 := aW;
  Result.m22 := aH;
  Result.m41 := aX;
  Result.m42 := aY;
end;


// Angles in degrees
class function TMatrix4.NewRotateLW(const aHPB: TKMVertex3): TMatrix4;
begin
  Result := TMatrix4.NewBankLW(aHPB.Z / 180 * Pi) *
            TMatrix4.NewPitchLW(aHPB.Y / 180 * Pi) *
            TMatrix4.NewHeadingLW(aHPB.X / 180 * Pi);
end;


class function TMatrix4.NewReflectionAboutPlane(aX, aY, aZ, aD: Single): TMatrix4;
begin
  Result.m11 := 1 - 2 * aX * aX; Result.m21 :=    -2 * aX * aY; Result.m31 :=    -2 * aX * aZ; Result.m41 := -2 * aX * aD;
  Result.m12 :=    -2 * aX * aY; Result.m22 := 1 - 2 * aY * aY; Result.m32 :=    -2 * aY * aZ; Result.m42 := -2 * aY * aD;
  Result.m13 :=    -2 * aX * aZ; Result.m23 :=    -2 * aY * aZ; Result.m33 := 1 - 2 * aZ * aZ; Result.m43 := -2 * aZ * aD;
  Result.m14 := 0;               Result.m24 := 0;               Result.m34 := 0;               Result.m44 := 1;
end;


class function TMatrix4.NewScale(aScale: Single): TMatrix4;
begin
  Result := Identity;
  Result.m11 := aScale;
  Result.m22 := aScale;
  Result.m33 := aScale;
end;


class function TMatrix4.NewScale(aScaleX, aScaleY: Single): TMatrix4;
begin
  Result := Identity;
  Result.m11 := aScaleX;
  Result.m22 := aScaleY;
end;


class function TMatrix4.NewScale(aScale: TKMVertex3): TMatrix4;
begin
  Result := Identity;
  Result.m11 := aScale.X;
  Result.m22 := aScale.Y;
  Result.m33 := aScale.Z;
end;


class function TMatrix4.NewLookAtRH(const aEye, aTarget, aUp: TKMVertex3): TMatrix4;
var
  ZAxis, XAxis, YAxis: TKMVertex3;
begin
  ZAxis := (aEye - aTarget).GetNormalize;
  XAxis := (VectorCrossProduct(aUp, ZAxis)).GetNormalize;
  YAxis := VectorCrossProduct(ZAxis, XAxis);

  Result := Identity;
  Result.m11 := XAxis.X;
  Result.m12 := YAxis.X;
  Result.m13 := ZAxis.X;
  Result.m21 := XAxis.Y;
  Result.m22 := YAxis.Y;
  Result.m23 := ZAxis.Y;
  Result.m31 := XAxis.Z;
  Result.m32 := YAxis.Z;
  Result.m33 := ZAxis.Z;
  Result.m41 := - VectorDotProduct(XAxis, aEye);
  Result.m42 := - VectorDotProduct(YAxis, aEye);
  Result.m43 := - VectorDotProduct(ZAxis, aEye);
end;


class function TMatrix4.NewOrthoOffCenterRH(const aLeft, aRight, aTop, aBottom, aZNear, aZFar: Single): TMatrix4;
begin
  // Embarcadero implementation is wrong (depth is twice as it should be). Using correct formula below
  Result := Identity;
  Result.m11 := 2 / (aRight - aLeft);
  Result.m22 := 2 / (aTop - aBottom);
  Result.m33 := -2 / (aZFar - aZNear);
  Result.m41 := - (aRight + aLeft) / (aRight - aLeft);
  Result.m42 := - (aTop + aBottom) / (aTop - aBottom);
  Result.m43 := - (aZFar + aZNear) / (aZFar - aZNear);
end;


class function TMatrix4.NewPerspectiveFovRH(const aFOV, aAspect, aZNear, aZFar: Single; const aHorizontalFOV: Boolean = False): TMatrix4;
var
  XScale, YScale: Single;
begin
  if aHorizontalFOV then
  begin
    XScale := 1 / Tangent(aFOV / 2);
    YScale := XScale / aAspect;
  end else
  begin
    YScale := 1 / Tangent(aFOV / 2);
    XScale := YScale / aAspect;
  end;

  Result := TMatrix4.Identity;
  Result.m11 := XScale;
  Result.m22 := YScale;
  Result.m33 := aZFar / (aZNear - aZFar);
  Result.m34 := -1;
  Result.m43 := aZNear * aZFar / (aZNear - aZFar);
  Result.m44 := 0;
end;


function TMatrix4.DetInternal(const a1, a2, a3, b1, b2, b3, c1, c2, c3: Single): Single;
begin
  Result := a1 * (b2 * c3 - b3 * c2) - b1 * (a2 * c3 - a3 * c2) + c1 * (a2 * b3 - a3 * b2);
end;


function TMatrix4.GetRemoveTranslate: TMatrix4;
begin
  Result := Self;

  Result.m14 := 0;
  Result.m24 := 0;
  Result.m34 := 0;
  Result.m41 := 0;
  Result.m42 := 0;
  Result.m43 := 0;
end;


function TMatrix4.GetTranslate: TKMVertex3;
begin
  Result.X := m41;
  Result.Y := m42;
  Result.Z := m43;
end;


function TMatrix4.Scale(const AFactor: Single): TMatrix4;
var
  I: Integer;
begin
  for I := 0 to 3 do
  begin
    Result.M[I].X := M[I].X * AFactor;
    Result.M[I].Y := M[I].Y * AFactor;
    Result.M[I].Z := M[I].Z * AFactor;
    Result.M[I].W := M[I].W * AFactor;
  end;
end;


function TMatrix4.Scale3(const aScale: Single): TMatrix4;
var
  I: Integer;
begin
  Result := Self;

  for I := 0 to 2 do
  begin
    Result.M[I].X := M[I].X * aScale;
    Result.M[I].Y := M[I].Y * aScale;
    Result.M[I].Z := M[I].Z * aScale;
  end;
end;


function TMatrix4.Scale3(const aX, aY, aZ: Single): TMatrix4;
var
  I: Integer;
begin
  Result := Self;

  for I := 0 to 2 do
  begin
    Result.M[I].X := M[I].X * aX;
    Result.M[I].Y := M[I].Y * aY;
    Result.M[I].Z := M[I].Z * aZ;
  end;
end;


function TMatrix4.ToString: string;
begin
  Result := Format(
    '%.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f',
    [m11, m21, m31, m41, m12, m22, m32, m42, m13, m23, m33, m43, m14, m24, m34, m44]);
end;


function TMatrix4.Determinant: Single;
begin
  Result :=
    M[0].X * DetInternal(M[1].Y, M[2].Y, M[3].Y, M[1].Z, M[2].Z, M[3].Z, M[1].W, M[2].W, M[3].W) -
    M[0].Y * DetInternal(M[1].X, M[2].X, M[3].X, M[1].Z, M[2].Z, M[3].Z, M[1].W, M[2].W, M[3].W) +
    M[0].Z * DetInternal(M[1].X, M[2].X, M[3].X, M[1].Y, M[2].Y, M[3].Y, M[1].W, M[2].W, M[3].W) -
    M[0].W * DetInternal(M[1].X, M[2].X, M[3].X, M[1].Y, M[2].Y, M[3].Y, M[1].Z, M[2].Z, M[3].Z);
end;


function TMatrix4.Adjoint: TMatrix4;
var
  a1, a2, a3, a4, b1, b2, b3, b4, c1, c2, c3, c4, d1, d2, d3, d4: Single;
begin
  a1 := M[0].X;
  b1 := M[0].Y;
  c1 := M[0].Z;
  d1 := M[0].W;
  a2 := M[1].X;
  b2 := M[1].Y;
  c2 := M[1].Z;
  d2 := M[1].W;
  a3 := M[2].X;
  b3 := M[2].Y;
  c3 := M[2].Z;
  d3 := M[2].W;
  a4 := M[3].X;
  b4 := M[3].Y;
  c4 := M[3].Z;
  d4 := M[3].W;

  Result.M[0].X := DetInternal(b2, b3, b4, c2, c3, c4, d2, d3, d4);
  Result.M[1].X := -DetInternal(a2, a3, a4, c2, c3, c4, d2, d3, d4);
  Result.M[2].X := DetInternal(a2, a3, a4, b2, b3, b4, d2, d3, d4);
  Result.M[3].X := -DetInternal(a2, a3, a4, b2, b3, b4, c2, c3, c4);

  Result.M[0].Y := -DetInternal(b1, b3, b4, c1, c3, c4, d1, d3, d4);
  Result.M[1].Y := DetInternal(a1, a3, a4, c1, c3, c4, d1, d3, d4);
  Result.M[2].Y := -DetInternal(a1, a3, a4, b1, b3, b4, d1, d3, d4);
  Result.M[3].Y := DetInternal(a1, a3, a4, b1, b3, b4, c1, c3, c4);

  Result.M[0].Z := DetInternal(b1, b2, b4, c1, c2, c4, d1, d2, d4);
  Result.M[1].Z := -DetInternal(a1, a2, a4, c1, c2, c4, d1, d2, d4);
  Result.M[2].Z := DetInternal(a1, a2, a4, b1, b2, b4, d1, d2, d4);
  Result.M[3].Z := -DetInternal(a1, a2, a4, b1, b2, b4, c1, c2, c4);

  Result.M[0].W := -DetInternal(b1, b2, b3, c1, c2, c3, d1, d2, d3);
  Result.M[1].W := DetInternal(a1, a2, a3, c1, c2, c3, d1, d2, d3);
  Result.M[2].W := -DetInternal(a1, a2, a3, b1, b2, b3, d1, d2, d3);
  Result.M[3].W := DetInternal(a1, a2, a3, b1, b2, b3, c1, c2, c3);
end;


function TMatrix4.Inverse: TMatrix4;
const
  DefaultValue: TMatrix4 = (
    m11: 1.0; m12: 0.0; m13: 0.0; m14: 0.0;
    m21: 0.0; m22: 1.0; m23: 0.0; m24: 0.0;
    m31: 0.0; m32: 0.0; m33: 1.0; m34: 0.0;
    m41: 0.0; m42: 0.0; m43: 0.0; m44: 1.0;
  );
var
  Det: Single;
begin
  Det := Self.Determinant;
  if Abs(Det) < Epsilon then
    Result := DefaultValue
  else
    Result := Self.Adjoint.Scale(1 / Det);
end;


function TMatrix4.IsEqual(aM: TMatrix4; aEpsilon: Single): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to 3 do
  if (M[I] - aM.M[I]).GetLengthSqr > Sqr(aEpsilon) then
    Exit(False);
end;


function TMatrix4.InvApply(aVert: TKMVertex3): TKMVertex3;
begin
  aVert.X := aVert.X - m41;
  aVert.Y := aVert.Y - m42;
  aVert.Z := aVert.Z - m43;
  Result.X := aVert.X * m11 + aVert.Y * m12 + aVert.Z * m13;
  Result.Y := aVert.X * m21 + aVert.Y * m22 + aVert.Z * m23;
  Result.Z := aVert.X * m31 + aVert.Y * m32 + aVert.Z * m33;
end;


// For some unknown reasons TMatrix4 uses Left-to-Right matrix multiplication,
// which is different from GLSL standard Right-to-Left multiplication
// Typical GLSL transform is written like: Result := Proj * View * Model * Vertex
// Same transform written in TMatrix4 is: Result := Vertex * Model * View * Proj
// Both produce exactly the same result, because GLSL evaluates Right-to-Left and TMatrix4 evaluates Left-to-Right
class operator TMatrix4.Multiply(const aA, aB: TMatrix4): TMatrix4;
begin
  Result.M[0].X := aA.M[0].X * aB.M[0].X + aA.M[0].Y * aB.M[1].X + aA.M[0].Z * aB.M[2].X + aA.M[0].W * aB.M[3].X;
  Result.M[0].Y := aA.M[0].X * aB.M[0].Y + aA.M[0].Y * aB.M[1].Y + aA.M[0].Z * aB.M[2].Y + aA.M[0].W * aB.M[3].Y;
  Result.M[0].Z := aA.M[0].X * aB.M[0].Z + aA.M[0].Y * aB.M[1].Z + aA.M[0].Z * aB.M[2].Z + aA.M[0].W * aB.M[3].Z;
  Result.M[0].W := aA.M[0].X * aB.M[0].W + aA.M[0].Y * aB.M[1].W + aA.M[0].Z * aB.M[2].W + aA.M[0].W * aB.M[3].W;
  Result.M[1].X := aA.M[1].X * aB.M[0].X + aA.M[1].Y * aB.M[1].X + aA.M[1].Z * aB.M[2].X + aA.M[1].W * aB.M[3].X;
  Result.M[1].Y := aA.M[1].X * aB.M[0].Y + aA.M[1].Y * aB.M[1].Y + aA.M[1].Z * aB.M[2].Y + aA.M[1].W * aB.M[3].Y;
  Result.M[1].Z := aA.M[1].X * aB.M[0].Z + aA.M[1].Y * aB.M[1].Z + aA.M[1].Z * aB.M[2].Z + aA.M[1].W * aB.M[3].Z;
  Result.M[1].W := aA.M[1].X * aB.M[0].W + aA.M[1].Y * aB.M[1].W + aA.M[1].Z * aB.M[2].W + aA.M[1].W * aB.M[3].W;
  Result.M[2].X := aA.M[2].X * aB.M[0].X + aA.M[2].Y * aB.M[1].X + aA.M[2].Z * aB.M[2].X + aA.M[2].W * aB.M[3].X;
  Result.M[2].Y := aA.M[2].X * aB.M[0].Y + aA.M[2].Y * aB.M[1].Y + aA.M[2].Z * aB.M[2].Y + aA.M[2].W * aB.M[3].Y;
  Result.M[2].Z := aA.M[2].X * aB.M[0].Z + aA.M[2].Y * aB.M[1].Z + aA.M[2].Z * aB.M[2].Z + aA.M[2].W * aB.M[3].Z;
  Result.M[2].W := aA.M[2].X * aB.M[0].W + aA.M[2].Y * aB.M[1].W + aA.M[2].Z * aB.M[2].W + aA.M[2].W * aB.M[3].W;
  Result.M[3].X := aA.M[3].X * aB.M[0].X + aA.M[3].Y * aB.M[1].X + aA.M[3].Z * aB.M[2].X + aA.M[3].W * aB.M[3].X;
  Result.M[3].Y := aA.M[3].X * aB.M[0].Y + aA.M[3].Y * aB.M[1].Y + aA.M[3].Z * aB.M[2].Y + aA.M[3].W * aB.M[3].Y;
  Result.M[3].Z := aA.M[3].X * aB.M[0].Z + aA.M[3].Y * aB.M[1].Z + aA.M[3].Z * aB.M[2].Z + aA.M[3].W * aB.M[3].Z;
  Result.M[3].W := aA.M[3].X * aB.M[0].W + aA.M[3].Y * aB.M[1].W + aA.M[3].Z * aB.M[2].W + aA.M[3].W * aB.M[3].W;
end;


// Assume W = 1
class operator TMatrix4.Multiply(const aVector: TKMVertex3; const aMatrix: TMatrix4): TKMVertex3;
begin
  Result.X := (aVector.X * aMatrix.m11) + (aVector.Y * aMatrix.m21) + (aVector.Z * aMatrix.m31) + aMatrix.m41;
  Result.Y := (aVector.X * aMatrix.m12) + (aVector.Y * aMatrix.m22) + (aVector.Z * aMatrix.m32) + aMatrix.m42;
  Result.Z := (aVector.X * aMatrix.m13) + (aVector.Y * aMatrix.m23) + (aVector.Z * aMatrix.m33) + aMatrix.m43;
end;


class operator TMatrix4.Multiply(const aVector: TKMVertex4; const aMatrix: TMatrix4): TKMVertex4;
begin
  Result.X := (aVector.X * aMatrix.m11) + (aVector.Y * aMatrix.m21) + (aVector.Z * aMatrix.m31) + (aVector.W * aMatrix.m41);
  Result.Y := (aVector.X * aMatrix.m12) + (aVector.Y * aMatrix.m22) + (aVector.Z * aMatrix.m32) + (aVector.W * aMatrix.m42);
  Result.Z := (aVector.X * aMatrix.m13) + (aVector.Y * aMatrix.m23) + (aVector.Z * aMatrix.m33) + (aVector.W * aMatrix.m43);
  Result.W := (aVector.X * aMatrix.m14) + (aVector.Y * aMatrix.m24) + (aVector.Z * aMatrix.m34) + (aVector.W * aMatrix.m44);
end;


class function TMatrix4.Identity;
const
  id: TMatrix4 = (
    m11: 1; m12: 0; m13: 0; m14: 0;
    m21: 0; m22: 1; m23: 0; m24: 0;
    m31: 0; m32: 0; m33: 1; m34: 0;
    m41: 0; m42: 0; m43: 0; m44: 1;
  );
begin
  Result := id;
end;


{ TKMPlane }
class function TKMPlane.New(const A, B, C, Distance: Single): TKMPlane;
begin
  Result.Normal.X := A;
  Result.Normal.Y := B;
  Result.Normal.Z := C;
  Result.Distance := Distance;
end;


class function TKMPlane.New(const aNormal: TKMVertex3; const aDistance: Single): TKMPlane;
begin
  Result.Normal := aNormal;
  Result.Distance := aDistance;
end;


procedure TKMPlane.Normalize;
var
  t: Single;
begin
  t := Normal.GetLength;
  Normal.X := Normal.X / t;
  Normal.Y := Normal.Y / t;
  Normal.Z := Normal.Z / t;
  Distance := Distance / t;
end;


{ TKMFrustrum }
function TKMFrustum.ClipByPlane(const aClippingPlaneZ: Single): TKMVertex3Array;
  function LinesIntersectionPoint(const p1, d1, p2, d2: TKMVertex3): TKMVertex3;
  var
    factor: Single;
  begin
    factor := (p1.X - p2.X) / (d2.X - d1.X);
    Result := p1 + d1 * factor;
  end;
var
  rays: TKMRayArray;
  I, IStart, IEnd: Integer;
  factor: array [0..3] of Single;
  dir, viewOrig, temp: TKMVertex3;
begin
  rays := GetSideRays;

  SetLength(Result, 4);

  // Clip against terrain plane
  for I := Low(rays) to High(rays) do
  begin
    factor[I] := (aClippingPlaneZ - rays[I].Endpoint.Z) / (rays[I].Start.Z - rays[I].Endpoint.Z);

    Result[I].X := Lerp(rays[I].Endpoint.X, rays[I].Start.X, factor[I]);
    Result[I].Y := Lerp(rays[I].Endpoint.Y, rays[I].Start.Y, factor[I]);
    Result[I].Z := aClippingPlaneZ;
  end;

  //Compute "eye" point
  viewOrig := LinesIntersectionPoint(rays[0].Start, rays[0].Start - rays[0].Endpoint,
                                     rays[1].Start, rays[1].Start - rays[1].Endpoint);

  //If "eye" under the clipping plane we need to change iteration limits to get a proper result
  if viewOrig.Z - aClippingPlaneZ > 0 then
  begin
    IStart := 0;
    IEnd := 1;
  end else
  begin
    IStart := 2;
    IEnd := 3;
  end;

  //Fixing points clockwise and correcting wrong intersection points caused by negative direction
  for I := IStart to IEnd do
  begin
    // Factor > 1 if frustum rays intersect clipping plane in negative direction
    // In this case on staight line it will be "new endpoint" "start point" "old endpoint"
    // (0 <= Factor <= 1) --> "start point" "new endpoint" "old endpoint"
    if factor[I] > 1.0 then
    begin
      dir := Result[I] - Result[3 - I];
      Result[I] := Result[3 - I];
      //Move point to "infinity" in proper direction
      Result[3 - I] := Result[3 - I] - dir * 1000.0;

      //If any factor > 1 then that means that result are ordered counterclockwise -> reorder it clockwise
      temp := Result[I];
      Result[I] := Result[3 - I];
      Result[3 - I] := temp;
    end;
  end
end;


// Get the corner points that describe the side edges from back to front clockwise
function TKMFrustum.GetCornerPoints: TKMVertex3Array;
  function Determinant(const AX, AY, AZ, BX, BY, BZ, CX, CY, CZ: Single): Single;
  begin
    Result := AX * (BY * CZ - BZ * CY) - BX * (AY * CZ - AZ * CY) + CX * (AY * BZ - AZ * BY);
  end;
  function PlanesIntersectionPoint(const aFirst, aSecond, aThird: PKMPlane): TKMVertex3;
  var
    det, shiftDet: Single;
  begin
    det := Determinant(aFirst.Normal.X,  aFirst.Normal.Y,  aFirst.Normal.Z,
                       aSecond.Normal.X, aSecond.Normal.Y, aSecond.Normal.Z,
                       aThird.Normal.X,  aThird.Normal.Y,  aThird.Normal.Z);

    if Abs(det) < Epsilon then
      Assert(False, 'Determinant must be non zero, otherwise planes are not intersecting in one point');

    shiftDet := Determinant(-aFirst.Distance,  aFirst.Normal.Y,  aFirst.Normal.Z,
                            -aSecond.Distance, aSecond.Normal.Y, aSecond.Normal.Z,
                            -aThird.Distance,  aThird.Normal.Y,  aThird.Normal.Z);

    Result.X := shiftDet / det;

    shiftDet := Determinant(aFirst.Normal.X,  -aFirst.Distance,  aFirst.Normal.Z,
                            aSecond.Normal.X, -aSecond.Distance, aSecond.Normal.Z,
                            aThird.Normal.X,  -aThird.Distance,  aThird.Normal.Z);

    Result.Y := shiftDet / det;

    shiftDet := Determinant(aFirst.Normal.X,  aFirst.Normal.Y,  -aFirst.Distance,
                            aSecond.Normal.X, aSecond.Normal.Y, -aSecond.Distance,
                            aThird.Normal.X,  aThird.Normal.Y,  -aThird.Distance);

    Result.Z := shiftDet / det;
  end;
begin
  SetLength(Result, 8);

  // Points go in this order TL TR BR BL
  Result[0] := PlanesIntersectionPoint(@Planes[pTop], @Planes[pLeft], @Planes[pBack]);
  Result[1] := PlanesIntersectionPoint(@Planes[pTop], @Planes[pLeft], @Planes[pFront]);
  Result[2] := PlanesIntersectionPoint(@Planes[pTop], @Planes[pRight], @Planes[pBack]);
  Result[3] := PlanesIntersectionPoint(@Planes[pTop], @Planes[pRight], @Planes[pFront]);

  Result[4] := PlanesIntersectionPoint(@Planes[pBottom], @Planes[pRight], @Planes[pBack]);
  Result[5] := PlanesIntersectionPoint(@Planes[pBottom], @Planes[pRight], @Planes[pFront]);
  Result[6] := PlanesIntersectionPoint(@Planes[pBottom], @Planes[pLeft], @Planes[pBack]);
  Result[7] := PlanesIntersectionPoint(@Planes[pBottom], @Planes[pLeft], @Planes[pFront]);
end;


function TKMFrustum.GetSideRays: TKMRayArray;
var
  CornerPoints: TKMVertex3Array;
  I: Integer;
begin
  CornerPoints := GetCornerPoints;

  SetLength(Result, 4);

  for I := Low(Result) to High(Result) do
  begin
    Result[I].Start := CornerPoints[I*2 + 1];
    Result[I].Endpoint := CornerPoints[I*2];
  end;
end;


class function TKMFrustum.New(const aMatViewProj: TMatrix4): TKMFrustum;
var
  m: TMatrix4;
  I: TKMPlaneType;
begin
  m := aMatViewProj; // Local shortcut

  Result.Planes[pRight] := TKMPlane.New(m.m14 - m.m11, m.m24 - m.m21, m.m34 - m.m31, m.m44 - m.m41);
  Result.Planes[pLeft]  := TKMPlane.New(m.m14 + m.m11, m.m24 + m.m21, m.m34 + m.m31, m.m44 + m.m41);
  Result.Planes[pBottom]:= TKMPlane.New(m.m14 + m.m12, m.m24 + m.m22, m.m34 + m.m32, m.m44 + m.m42);
  Result.Planes[pTop]   := TKMPlane.New(m.m14 - m.m12, m.m24 - m.m22, m.m34 - m.m32, m.m44 - m.m42);
  Result.Planes[pBack]  := TKMPlane.New(m.m14 - m.m13, m.m24 - m.m23, m.m34 - m.m33, m.m44 - m.m43);
  Result.Planes[pFront] := TKMPlane.New(m.m14 + m.m13, m.m24 + m.m23, m.m34 + m.m33, m.m44 + m.m43);

  for I := Low(TKMPlaneType) to High(TKMPlaneType) do
    Result.Planes[I].Normalize;
end;


function TKMFrustum.PointInFrustum(const aPoint: TKMVertex3): Boolean;
var
  I: TKMPlaneType;
  d: Single;
begin
  Result := True;

  for I := Low(TKMPlaneType) to High(TKMPlaneType) do
  begin
    d :=  Planes[I].Normal.X * aPoint.X +
          Planes[I].Normal.Y * aPoint.Y +
          Planes[I].Normal.Z * aPoint.Z +
          Planes[I].Distance;

    if d <= 0 then
      Exit(False);
  end;
end;


function TKMFrustum.SphereInFrustum(const aCenter: TKMVertex3; aRadius: Single): Boolean;
var
  I: TKMPlaneType;
  d: Single;
begin
  Result := True;

  for I := Low(TKMPlaneType) to High(TKMPlaneType) do
  begin
    d :=  Planes[I].Normal.X * aCenter.X +
          Planes[I].Normal.Y * aCenter.Y +
          Planes[I].Normal.Z * aCenter.Z +
          Planes[I].Distance;

    if d <= -aRadius then
      Exit(False);
  end;
end;


// Just a shortcut for cases where we already have sphere we want to test
function TKMFrustum.SphereInFrustum(const aSphere: TKMVertexSphere): Boolean;
begin
  Result := SphereInFrustum(aSphere.Center, aSphere.Radius);
end;


{ TKMGeometryBlob }
class function TKMGeometryBlob.New(aVertCount, aIndCount: Word): TKMGeometryBlob;
begin
  Result.VertCount := aVertCount;
  SetLength(Result.Verts, Result.VertCount);
  Result.IndCount := aIndCount;
  SetLength(Result.Indices, Result.IndCount);
end;


function TKMGeometryBlob.IsEmpty: Boolean;
begin
  Result := VertCount * IndCount = 0;
end;


{ TKMSegment2List }
procedure TKMSegment2List.Append(const aA, aB: TKMVertex2);
begin
  SetLength(Segments, Length(Segments) + 1);
  Segments[High(Segments)].A := aA;
  Segments[High(Segments)].B := aB;
end;


procedure TKMSegment2List.Append(aX1, aY1, aX2, aY2: Single);
var
  p: PKMSegment2;
begin
  SetLength(Segments, Length(Segments) + 1);
  p := @Segments[High(Segments)];
  p.A.X := aX1;
  p.A.Y := aY1;
  p.B.X := aX2;
  p.B.Y := aY2;
end;


procedure TKMSegment2List.Append(const aSeg: TKMSegment2);
begin
  SetLength(Segments, Length(Segments) + 1);
  Segments[High(Segments)] := aSeg;
end;


procedure TKMSegment2List.Append(const aSegs: TKMSegment2Array);
begin
  if Length(aSegs) = 0 then Exit;
  SetLength(Segments, Length(Segments) + Length(aSegs));
  Move(aSegs[0].A.X, Segments[Length(Segments) - Length(aSegs)].A.X, Length(aSegs) * SizeOf(TKMSegment2));
end;


function TKMSegment2List.Count: Integer;
begin
  Result := Length(Segments);
end;


procedure SplineRasterize(const aA, aAnchorA, aAnchorB, aB: TKMVertex2; aSpacing: Single; var aNodes: TKMVertex2Array);
const
  SPLINE_DETAIL = 100;
var
  I,K: Integer;
  arr: TKMVertex2Array;
  len: array of Single;
  s, t: Single;
  lenFull: Single;
  resCount: Integer;
  resSpacing: Extended;
  v1, v2: TKMVertex2;
begin
  SetLength(arr, SPLINE_DETAIL);
  SetLength(len, SPLINE_DETAIL);

  for I := 0 to SPLINE_DETAIL-1 do
  begin
    t := I / (SPLINE_DETAIL-1);
    s := 1 - t;

    arr[I] :=
      s * s * s * aA +
      3 * s * s * t * aAnchorA +
      3 * s * t * t * aAnchorB +
      t * t * t * aB;

    if I > 0 then
      len[I] := len[I-1] + (arr[I] - arr[I-1]).GetLength;
  end;

  lenFull := len[SPLINE_DETAIL-1];
  resCount := Round(lenFull / aSpacing);
  if resCount <> 0 then
    resSpacing := lenFull / resCount
  else
    resSpacing := 0;

  // Include first and last points (Count+1)
  SetLength(aNodes, resCount + 1);
  for I := 0 to resCount do
  begin
    t := I * resSpacing;

    for K := 0 to SPLINE_DETAIL-2 do
    if (len[K] <= t) and ((t <= len[K+1]) or (K+1 = SPLINE_DETAIL-1)) then
    begin
      v1 := arr[K];
      v2 := arr[K+1];

      aNodes[I] := TKMVertex2.NewLerp(v1, v2, (t - len[K]) / (len[K+1] - len[K]));
    end;
  end;
end;


function SegmentsIntersection(const A, B, C, D: TKMVertex2): TKMVertex2;
var
  AB, CD: TKMVertex2;
  D2, S, T: Single;
  res: Boolean;
begin
  AB := B - A;
  CD := D - C;

  D2 := -CD.X * AB.Y + AB.X * CD.Y;

  if D2 = 0 then Exit(TKMVertex2.NaN);

  S := (-AB.Y * (A.X - C.X) + AB.X * (A.Y - C.Y)) / D2;
  T := ( CD.X * (A.Y - C.Y) - CD.Y * (A.X - C.X)) / D2;

  res := (S > 0) and (S < 1) and (T > 0) and (T < 1);

  if res then
    Result := A + (t * AB)
  else
    Result := TKMVertex2.NaN;
end;


{ TKMHitTestModelLowpoly }
function TKMHitTestModelLowpoly.IsEmpty: Boolean;
begin
  Result := (VertCount = 0) or (PolyCount = 0);
end;


function TKMHitTestModelLowpoly.HitTest(const aModelMat: TMatrix4; const aRay: TKMVertex3Ray; aDbgPoly: PInteger; out aEyeDist: Single): Boolean;
var
  I: Integer;
  mInv: TMatrix4;
  rayInv: TKMVertex3Ray;
  dst, dstBest: Single;
begin
  Result := False;

  mInv := aModelMat.Inverse;
  rayInv.Start := aRay.Start * mInv;
  rayInv.Endpoint := aRay.Endpoint * mInv;

  // Return poly id, so we can highlight it in debug render
  if aDbgPoly <> nil then
    aDbgPoly^ := 0;

  dstBest := MaxSingle;

  for I := 0 to PolyCount - 1 do
  if RayTriangleIntersect(rayInv, Verts[Indices[I*3+0]], Verts[Indices[I*3+1]], Verts[Indices[I*3+2]], dst) then
    if dst < dstBest then
    begin
      dstBest := dst;

      if aDbgPoly <> nil then
        aDbgPoly^ := I;

      Result := True;
    end;
end;


function TKMHitTestModelLowpoly.GetBoundingCube: TKMVertexBox;
var
  I: Integer;
begin
  if VertCount = 0 then
    Exit(TKMVertexBox.New(0, 0, 0, 0, 0, 0));

  Result.CornerLow.X := Verts[0].X;
  Result.CornerLow.Y := Verts[0].Y;
  Result.CornerLow.Z := Verts[0].Z;
  Result.CornerHigh := Result.CornerLow;

  for I := 0 to High(Verts) do
  begin
    Result.CornerLow.X := Min(Result.CornerLow.X, Verts[I].X);
    Result.CornerLow.Y := Min(Result.CornerLow.Y, Verts[I].Y);
    Result.CornerLow.Z := Min(Result.CornerLow.Z, Verts[I].Z);
    Result.CornerHigh.X := Max(Result.CornerHigh.X, Verts[I].X);
    Result.CornerHigh.Y := Max(Result.CornerHigh.Y, Verts[I].Y);
    Result.CornerHigh.Z := Max(Result.CornerHigh.Z, Verts[I].Z);
  end;
end;


end.
