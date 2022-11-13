unit MTkit2_Defaults;
interface
uses
  dglOpenGL;

type
  TActivePage = (apMTL, apParts, apLights, apCOB, apCPO, apExtra, apBrowse);
  TRenderMode = (rmOpenGL, rmShaders);
  TUIDataSection = (uiMOX, uiMTL, uiVinyl, uiBlinkers, uiParts, uiCOB, uiCPO);
  TLoadMode = (
    lmJustLoad, // When loading from Browse
    lmLoadAndShow // When importing from menu or converting
    );
  TRenderObjectSet = set of (roMOX, roMOX_COB, roCOB, roCPO, roTREE);
  TEditingActions = (cuMOX, cuMTL, cuCOB, cuCPO, cuTREE, cuALL);
  TCameraAction = (caNone, caRotate, caMove, caZoom);

  TKnownFileType = (
    kftLwo,
    kftMox,
    kftTree
  );

  TKnownFileTypeInfo = record
    Filter: string;
    Ext: string;
  end;

const
  APP_TITLE = 'Mesh ToolKit';
  VER_INFO = '2.4.3+';
  FPS_INTERVAL: Cardinal = 1000;               // Calculate FPS every ---- ms
  MAX_MATERIALS = 255;
  MAX_COLORS = 15;
  MAX_CPO_SHAPES = 12;
  MAX_READ_BUFFER = 262144;

  // Fill in and use other known types
  FILE_TYPE_INFO: array [TKnownFileType] of TKnownFileTypeInfo = (
    (Filter: 'Lightwave 3D files (*.lwo)|*.lwo'; Ext: '.lwo'),
    (Filter: 'World Racing 2 object files (*.mox)|*.mox'; Ext: '.mox'),
    (Filter: 'World Racing 2 tree files (*.tree)|*.tree'; Ext: '.tree')
  );

  BBoxV: array [1..8,1..3] of Single =(
  (-0.5,-0.5,-0.5),( 0.5,-0.5,-0.5),( 0.5, 0.5,-0.5),(-0.5, 0.5,-0.5),
  (-0.5,-0.5, 0.5),( 0.5,-0.5, 0.5),( 0.5, 0.5, 0.5),(-0.5, 0.5, 0.5));

  BBoxI: array [1..6,1..4] of Byte =((4,3,2,1),(5,6,7,8),(1,2,6,5),(2,3,7,6),(3,4,8,7),(4,1,5,8));

  OSprite: array [1..4,1..2] of Single =((1,1),(-1,1),(-1,-1),(1,-1));
  OSpriteUV: array [1..4,1..2] of Single =((1,1),(0,1),(0,0),(1,0));

  ORadius: array [1..32,1..2] of Single =(
    (0,1),(0.195,0.98),(0.383,0.924),(0.556,0.831),
    (0.707,0.707),
    (0.831,0.556),(0.924,0.383),(0.98,0.195),(1,0),
    (0.98,-0.195),(0.924,-0.383),(0.831,-0.556),
    (0.707,-0.707),
    (0.556,-0.831),(0.383,-0.924),(0.195,-0.98),(0,-1),
    (-0.195,-0.98),(-0.383,-0.924),(-0.556,-0.831),
    (-0.707,-0.707),
    (-0.831,-0.556),(-0.924,-0.383),(-0.98,-0.195),(-1,0),
    (-0.98,0.195),(-0.924,0.383),(-0.831,0.556),
    (-0.707,0.707),
    (-0.556,0.831),(-0.383,0.924),(-0.195,0.98));

  OFlame: array [1..112,1..3] of Single =(
    (0.081,-0.079,-0.09),
    (0.12,-0.117,0.215),
    (-0.083,-0.079,-0.09),
    (-0.122,-0.117,0.215),
    (0.026,-0.027,0.657),
    (-0.028,-0.027,0.657),
    (-0.083,0.077,-0.09),
    (-0.122,0.115,0.215),
    (0.081,0.077,-0.09),
    (0.12,0.115,0.215),
    (-0.028,0.025,0.657),
    (0.026,0.025,0.657),
    (0.081,0.077,-0.09),
    (0.12,0.115,0.215),
    (0.081,-0.079,-0.09),
    (0.12,-0.117,0.215),
    (0.026,0.025,0.657),
    (0.026,-0.027,0.657),
    (-0.542,0.535,0.006),
    (-0.542,-0.535,0.006),
    (0.542,0.535,0.006),
    (0.542,-0.535,0.006),
    (0.112,0.002,-0.09),
    (0.167,0.003,0.215),
    (-0.004,-0.114,-0.09),
    (-0.005,-0.168,0.215),
    (0.036,0,0.836),
    (-0.002,-0.038,0.836),
    (-0.114,-0.003,-0.09),
    (-0.169,-0.005,0.215),
    (0.002,0.112,-0.09),
    (0.003,0.167,0.215),
    (-0.038,-0.002,0.836),
    (0,0.037,0.836),
    (0.002,0.112,-0.09),
    (0.003,0.167,0.215),
    (0.112,0.002,-0.09),
    (0.167,0.003,0.215),
    (0,0.037,0.836),
    (0.036,0,0.836),
    (-0.083,-0.079,-0.09),
    (-0.122,-0.117,0.215),
    (-0.083,0.077,-0.09),
    (-0.122,0.115,0.215),
    (-0.028,-0.027,0.657),
    (-0.028,0.025,0.657),
    (-0.004,-0.114,-0.09),
    (-0.005,-0.168,0.215),
    (-0.114,-0.003,-0.09),
    (-0.169,-0.005,0.215),
    (-0.002,-0.038,0.836),
    (-0.038,-0.002,0.836),
    (-0.001,-0.119,-0.09),
    (-0.001,-0.167,0.195),
    (-0.094,-0.09,-0.09),
    (0.092,-0.09,-0.09),
    (0.13,-0.126,0.195),
    (0.122,-0.118,0.438),
    (-0.001,-0.157,0.438),
    (-0.001,-0.108,0.829),
    (0.083,-0.081,0.829),
    (0.03,-0.03,1.157),
    (-0.001,-0.04,1.157),
    (-0.032,-0.03,1.157),
    (-0.085,-0.081,0.829),
    (-0.124,-0.118,0.438),
    (-0.132,-0.126,0.195),
    (-0.094,0.088,-0.09),
    (-0.001,0.166,0.195),
    (-0.001,0.117,-0.09),
    (-0.132,0.124,0.195),
    (-0.124,0.116,0.438),
    (-0.001,0.155,0.438),
    (-0.001,0.106,0.829),
    (-0.085,0.08,0.829),
    (-0.032,0.028,1.157),
    (-0.001,0.038,1.157),
    (0.03,0.028,1.157),
    (0.083,0.08,0.829),
    (0.122,0.116,0.438),
    (0.13,0.124,0.195),
    (0.092,0.088,-0.09),
    (0.092,0.088,-0.09),
    (0.173,-0.001,0.195),
    (0.123,-0.001,-0.09),
    (0.13,0.124,0.195),
    (0.122,0.116,0.438),
    (0.162,-0.001,0.438),
    (0.111,-0.001,0.829),
    (0.083,0.08,0.829),
    (0.03,0.028,1.157),
    (0.04,-0.001,1.157),
    (0.03,-0.03,1.157),
    (0.083,-0.081,0.829),
    (0.122,-0.118,0.438),
    (0.13,-0.126,0.195),
    (0.092,-0.09,-0.09),
    (-0.125,-0.001,-0.09),
    (-0.175,-0.001,0.195),
    (-0.094,0.088,-0.09),
    (-0.094,-0.09,-0.09),
    (-0.132,-0.126,0.195),
    (-0.124,-0.118,0.438),
    (-0.164,-0.001,0.438),
    (-0.113,-0.001,0.829),
    (-0.085,-0.081,0.829),
    (-0.032,-0.03,1.157),
    (-0.042,-0.001,1.157),
    (-0.032,0.028,1.157),
    (-0.085,0.08,0.829),
    (-0.124,0.116,0.438),
    (-0.132,0.124,0.195));

  OFlameN: array [1..112,1..3] of Single =(
    (0,-0.992,-0.123),
    (0,-1,0.028),
    (0,-0.992,-0.123),
    (0,-0.996,0.085),
    (0,-0.98,0.199),
    (0,-0.98,0.199),
    (0,0.992,-0.123),
    (0,1,0.028),
    (0,0.992,-0.123),
    (0,0.996,0.085),
    (0,0.98,0.199),
    (0,0.98,0.199),
    (0.992,0,-0.129),
    (1,0,0.029),
    (0.992,0,-0.129),
    (0.996,0,0.089),
    (0.978,0,0.208),
    (0.978,0,0.208),
    (0,0,1),
    (0,0,1),
    (0,0,1),
    (0,0,1),
    (0.702,-0.702,-0.123),
    (0.707,-0.707,0.024),
    (0.702,-0.702,-0.123),
    (0.705,-0.705,0.068),
    (0.7,-0.7,0.143),
    (0.7,-0.7,0.143),
    (-0.702,0.702,-0.123),
    (-0.707,0.707,0.024),
    (-0.702,0.702,-0.123),
    (-0.705,0.705,0.068),
    (-0.7,0.7,0.143),
    (-0.7,0.7,0.143),
    (0.701,0.701,-0.129),
    (0.707,0.707,0.025),
    (0.701,0.701,-0.129),
    (0.705,0.705,0.071),
    (0.699,0.699,0.15),
    (0.699,0.699,0.15),
    (-0.992,0,-0.129),
    (-1,0,0.029),
    (-0.992,0,-0.129),
    (-0.996,0,0.089),
    (-0.978,0,0.208),
    (-0.978,0,0.208),
    (-0.701,-0.701,-0.129),
    (-0.707,-0.707,0.025),
    (-0.701,-0.701,-0.129),
    (-0.705,-0.705,0.071),
    (-0.699,-0.699,0.15),
    (-0.699,-0.699,0.15),
    (0,-0.986,-0.167),
    (0,-0.998,-0.065),
    (-0.3,-0.941,-0.159),
    (0.3,-0.941,-0.159),
    (0.303,-0.951,-0.068),
    (0.302,-0.949,0.084),
    (0,-0.996,0.093),
    (0,-0.989,0.15),
    (0.3,-0.942,0.153),
    (0.298,-0.935,0.195),
    (0,-0.979,0.204),
    (-0.298,-0.935,0.195),
    (-0.3,-0.942,0.153),
    (-0.302,-0.949,0.084),
    (-0.303,-0.951,-0.068),
    (-0.3,0.941,-0.159),
    (0,0.998,-0.065),
    (0,0.986,-0.167),
    (-0.303,0.951,-0.068),
    (-0.302,0.949,0.084),
    (0,0.996,0.093),
    (0,0.989,0.15),
    (-0.3,0.942,0.153),
    (-0.298,0.935,0.195),
    (0,0.979,0.204),
    (0.298,0.935,0.195),
    (0.3,0.942,0.153),
    (0.302,0.949,0.084),
    (0.303,0.951,-0.068),
    (0.3,0.941,-0.159),
    (0.931,0.325,-0.165),
    (0.998,0,-0.068),
    (0.985,0,-0.174),
    (0.942,0.329,-0.071),
    (0.941,0.328,0.088),
    (0.995,0,0.097),
    (0.988,0,0.156),
    (0.932,0.325,0.159),
    (0.925,0.323,0.202),
    (0.977,0,0.213),
    (0.925,-0.323,0.202),
    (0.932,-0.325,0.159),
    (0.941,-0.328,0.088),
    (0.942,-0.329,-0.071),
    (0.931,-0.325,-0.165),
    (-0.985,0,-0.174),
    (-0.998,0,-0.068),
    (-0.931,0.325,-0.165),
    (-0.931,-0.325,-0.165),
    (-0.942,-0.329,-0.071),
    (-0.941,-0.328,0.088),
    (-0.995,0,0.097),
    (-0.988,0,0.156),
    (-0.932,-0.325,0.159),
    (-0.925,-0.323,0.202),
    (-0.977,0,0.213),
    (-0.925,0.323,0.202),
    (-0.932,0.325,0.159),
    (-0.941,0.328,0.088),
    (-0.942,0.329,-0.071));

  OFlameUV: array [1..112,1..2] of Single =(
    (0.392,0.008),
    (0.392,0.325),
    (0.29,0.008),
    (0.29,0.324),
    (0.392,0.993),
    (0.29,0.993),
    (0.389,0.008),
    (0.389,0.324),
    (0.289,0.008),
    (0.289,0.324),
    (0.389,0.993),
    (0.289,0.993),
    (0.388,0.008),
    (0.388,0.324),
    (0.289,0.008),
    (0.289,0.324),
    (0.387,0.993),
    (0.289,0.993),
    (0.579,0.927),
    (0.579,0.534),
    (0.965,0.927),
    (0.965,0.534),
    (0.384,0.008),
    (0.384,0.325),
    (0.292,0.008),
    (0.292,0.324),
    (0.384,0.995),
    (0.292,0.995),
    (0.382,0.008),
    (0.382,0.324),
    (0.291,0.008),
    (0.291,0.324),
    (0.382,0.995),
    (0.291,0.995),
    (0.38,0.008),
    (0.38,0.324),
    (0.291,0.008),
    (0.291,0.324),
    (0.38,0.995),
    (0.291,0.995),
    (0.389,0.008),
    (0.389,0.324),
    (0.289,0.008),
    (0.289,0.324),
    (0.389,0.993),
    (0.289,0.993),
    (0.382,0.008),
    (0.382,0.324),
    (0.291,0.008),
    (0.291,0.324),
    (0.382,0.995),
    (0.291,0.995),
    (0.108,0.006),
    (0.108,0.165),
    (0.024,0.006),
    (0.025,0.006),
    (0.025,0.165),
    (0.025,0.325),
    (0.108,0.368),
    (0.108,0.656),
    (0.025,0.656),
    (0.025,0.988),
    (0.108,0.988),
    (0.024,0.988),
    (0.024,0.656),
    (0.024,0.324),
    (0.024,0.165),
    (0.022,0.006),
    (0.106,0.165),
    (0.106,0.006),
    (0.022,0.165),
    (0.022,0.324),
    (0.106,0.368),
    (0.106,0.656),
    (0.022,0.656),
    (0.022,0.988),
    (0.106,0.988),
    (0.024,0.988),
    (0.024,0.656),
    (0.024,0.324),
    (0.024,0.165),
    (0.024,0.006),
    (0.021,0.006),
    (0.106,0.165),
    (0.106,0.006),
    (0.021,0.165),
    (0.021,0.324),
    (0.106,0.367),
    (0.106,0.656),
    (0.021,0.656),
    (0.021,0.988),
    (0.105,0.988),
    (0.024,0.988),
    (0.024,0.656),
    (0.023,0.324),
    (0.023,0.165),
    (0.023,0.006),
    (0.106,0.006),
    (0.106,0.165),
    (0.024,0.006),
    (0.022,0.006),
    (0.022,0.165),
    (0.022,0.324),
    (0.106,0.368),
    (0.106,0.656),
    (0.022,0.656),
    (0.022,0.988),
    (0.106,0.988),
    (0.024,0.988),
    (0.024,0.656),
    (0.024,0.324),
    (0.024,0.165));

  OFlameP: array [1..98,1..3] of Byte = (
    (1,2,3),
    (2,4,3),
    (2,5,4),
    (5,6,4),
    (7,8,9),
    (8,10,9),
    (8,11,10),
    (11,12,10),
    (13,14,15),
    (14,16,15),
    (14,17,16),
    (17,18,16),
    (19,20,21),
    (20,22,21),
    (23,24,25),
    (24,26,25),
    (24,27,26),
    (27,28,26),
    (29,30,31),
    (30,32,31),
    (30,33,32),
    (33,34,32),
    (35,36,37),
    (36,38,37),
    (36,39,38),
    (39,40,38),
    (41,42,43),
    (42,44,43),
    (42,45,44),
    (45,46,44),
    (47,48,49),
    (48,50,49),
    (48,51,50),
    (51,52,50),
    (53,54,55),
    (53,56,54),
    (56,57,54),
    (57,58,54),
    (58,59,54),
    (58,60,59),
    (58,61,60),
    (61,62,60),
    (62,63,60),
    (63,64,60),
    (64,65,60),
    (65,66,60),
    (66,59,60),
    (66,54,59),
    (66,67,54),
    (67,55,54),
    (68,69,70),
    (68,71,69),
    (71,72,69),
    (72,73,69),
    (72,74,73),
    (72,75,74),
    (75,76,74),
    (76,77,74),
    (77,78,74),
    (78,79,74),
    (79,80,74),
    (80,73,74),
    (80,69,73),
    (80,81,69),
    (81,82,69),
    (82,70,69),
    (83,84,85),
    (83,86,84),
    (86,87,84),
    (87,88,84),
    (87,89,88),
    (87,90,89),
    (90,91,89),
    (91,92,89),
    (92,93,89),
    (93,94,89),
    (94,95,89),
    (95,88,89),
    (95,84,88),
    (95,96,84),
    (96,97,84),
    (97,85,84),
    (98,99,100),
    (98,101,99),
    (101,102,99),
    (102,103,99),
    (103,104,99),
    (103,105,104),
    (103,106,105),
    (106,107,105),
    (107,108,105),
    (108,109,105),
    (109,110,105),
    (110,111,105),
    (111,104,105),
    (111,99,104),
    (111,112,99),
    (112,100,99));

  DEFAULT_COLORS: array [1..15,1..3] of Byte = (
    (0,0,0),(39,0,2),(130,10,5),(20,4,0),(140,98,0),(159,71,0),(150,150,160),(10,10,10),
    (0,5,10),(2,10,4),(0,2,8),(17,17,30),(5,2,8),(50,50,50),(40,40,40));

  DEFAULT_REFLECT: array [1..15,1..3] of Byte = (
    (12,12,12),(12,12,12),(12,12,12),(12,12,12),(12,12,12),(12,12,12),(12,12,12),
    (12,12,12),(12,12,12),(12,12,12),(12,12,12),(12,12,12),(12,12,12),(12,12,12),(0,0,0));

  DEFAULT_SPEC: array [1..3] of Byte = (145,145,145);

  DEFAULT_SPEC2: array [1..15,1..3] of Byte = (
    (12,12,12),(85,0,5),(0,0,0),(130,32,15),(0,0,0),(0,0,0),(0,0,0),(50,50,50),
    (0,40,28),(10,40,18),(0,13,40),(74,75,130),(53,34,60),(100,100,100),(120,120,120));

  LightPos: array [0..3] of GLfloat = (40,24,17,0);
  LightSpec: array [0..3] of GLfloat = (0.7,0.7,0.7,0);
  LightDiff: array [0..3] of GLfloat = (1,1,1,0);

  LightPos2: array [0..3] of GLfloat = (-40,40,20,0);
  LightSpec2: array [0..3] of GLfloat = (0.3,0.3,0.3,0);
  LightDiff2: array [0..3] of GLfloat = (0.3,0.3,0.3,0);

var
  Dif: array [0..3] of GLfloat;

implementation

end.
