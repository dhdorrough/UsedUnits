UNIT BitMaps;

INTERFACE

CONST
  SETS_PER_BITMAP = 9;
  MAX_BITS_PER_SET = SETS_PER_BITMAP * 256;

TYPE

  TBitMap = ARRAY[0..SETS_PER_BITMAP] OF
    SET OF 0..255; { LEDGERS IN USE }

procedure BitMap_Diff(var C: TBitMap; A, B: TBitMap);
procedure BitMap_ZERO(var C: TBitMap);
procedure BitMap_ADDONE(var C: TBitMap; N: INTEGER);
procedure BitMap_SubOne(var C: TBitMap; N: INTEGER);
procedure BitMap_ADDALL(var C: TBitMap; A, B: TBitMap);
procedure BitMap_SUBALL(var C: TBitMap; A, B: TBitMap);
procedure BitMap_Intersection(var C: TBitMap; A, B: TBitMap);
function BitMap_HasElement(C: TBitMap; N: INTEGER): boolean;
function BitMap_EQUAL(A, B: TBitMap): boolean;
procedure BitMap_DUMP(NAME: string; MAP: TBitMap);
function BitMap_Contains(A, B: TBitMap): boolean;
function BitMap_IsEmpty(A: TBitMap): boolean;

IMPLEMENTATION

procedure BitMap_ZERO(var C: TBitMap);
  var I: INTEGER;
begin { BitMap_ZERO }
  for I := 0 to SETS_PER_BITMAP do
    C[I] := [];
end;  { BitMap_ZERO }

procedure BitMap_Diff(var C: TBitMap; A, B: TBitMap);
  var I: INTEGER;
begin { BitMap_Diff }
  for I := 0 to SETS_PER_BITMAP do
    C[I] := A[I] - B[I];
end;  { BitMap_Diff }

procedure BitMap_ADDONE(var C: TBitMap; N: INTEGER);
  var SETNUMBER, BIT: INTEGER;
begin { BitMap_ADDONE }
  SETNUMBER := N DIV 256;
  BIT := N MOD 256;
  if setnumber <= sets_per_bitmap then
    C[SETNUMBER] := C[SETNUMBER] + [BIT];
end;  { BitMap_SETEXPT }

procedure BitMap_SubOne(var C: TBitMap; N: INTEGER);
  var SETNUMBER, BIT: INTEGER;
begin { BitMap_SubOne }
  SETNUMBER := N DIV 256;
  BIT := N MOD 256;
  if setnumber <= sets_per_bitmap then
    C[SETNUMBER] := C[SETNUMBER] - [BIT];
end;  { BitMap_SubOne }

procedure BitMap_SUBALL(var C: TBitMap; A, B: TBitMap);
  var I: INTEGER;
begin { BitMap_SUBALL }
  for I := 0 to SETS_PER_BITMAP do
    C[I] := A[I] - B[I];
end;  { BitMap_SUBALL }

procedure BitMap_ADDALL(var C: TBitMap; A, B: TBitMap);
  var I: INTEGER;
begin { BitMap_ADDALL }
  for I := 0 to SETS_PER_BITMAP do
    C[I] := A[I] + B[I];
end;  { BitMap_ADDALL }

procedure BitMap_Intersection(var C: TBitMap; A, B: TBitMap);
  var I: INTEGER;
begin { BitMap_Intersection }
  for I := 0 to SETS_PER_BITMAP do
    C[I] := A[I] * B[I];
end;  { BitMap_Intersection }

function BitMap_HasElement(C: TBitMap; N: INTEGER): boolean;
  var SETNUMBER, BIT: INTEGER;
begin { BitMap_HasElement }
  Result:= False;
  SETNUMBER := N DIV 256;
  BIT := N MOD 256;
  if setnumber <= sets_per_bitmap then
    BitMap_HasElement := BIT IN C[SETNUMBER];
end;  { BitMap_HasElement }

function BitMap_EQUAL(A, B: TBitMap): boolean;
  var
    I: INTEGER;
    MODE: (COMPARING, EQUAL, NOT_EQUAL);
begin { BitMap_EQUAL }
  I := 0;
  MODE := COMPARING;
  repeat
    if I > SETS_PER_BITMAP then
      MODE := EQUAL
    else
      if A[I] <> B[I] then
        MODE := NOT_EQUAL
      else
        I := I + 1;
  until MODE <> COMPARING;
  BitMap_EQUAL := MODE = EQUAL;
end;  { BitMap_EQUAL }

procedure BitMap_DUMP(NAME: string; MAP: TBitMap);
  var I: INTEGER;
begin { BitMap_DUMP }
  WRITELN('TBitMap: ', NAME);
  for I := 0 to 2300 do
    begin
      if (I MOD 50) = 0 then
        begin
          WRITELN;
          WRITE(I:4, ': ');
        end;
      if BitMap_HasElement(MAP, I) then
        WRITE('1')
      else
        WRITE('0');
    end;
  WRITELN;
  READLN;
end;  { BitMap_DUMP }

function BitMap_Contains(A, B: TBitMap): boolean;
  var
    I: INTEGER;
    MODE: (COMPARING, GEQ, NOT_GEQ);
begin { BitMap_Contains }
  I := 0;
  MODE := COMPARING;
  repeat
    if I > SETS_PER_BITMAP then
      MODE := GEQ
    else
      if NOT (A[I] >= B[I]) then
        MODE := NOT_GEQ
      else
        I := I + 1;
  until MODE <> COMPARING;
  BitMap_Contains := MODE = GEQ;
end;  { BitMap_Contains }

function BitMap_IsEmpty(A: TBitMap): boolean;
  var
    B: TBitMap;
begin
  BitMap_Zero(B);
  result := BitMap_EQUAL(A,  B);
end;

end.
