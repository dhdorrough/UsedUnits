unit uUsedUnits;

interface

uses
  Windows, Dialogs, Graphics, Menus, StdCtrls, ExtCtrls, Controls,
  ComCtrls, Classes, Messages, SysUtils, Forms,
  BitMaps;

const
  Version  = '1.07';

{ 1.06 03/28/2003 Made the behaviour wrt. a project file entered manually the same as the behaviour wrt. a project file entered using a command line parameter  }
{ 1.06 03/28/2003 Corrected so that the .dof file is read if a project file is entered using a command line parameter }
{ 1.06 03/28/2003 Added Browsing Path to the paths }
{ 1.06 03/28/2003 Removed menu items that are not functional by making them invisible }
{ 1.06 03/28/2003 Moved the Setup page to the last page }
{ 1.06 03/28/2003 Added an hour glass cursor }
{ 1.05 03/28/2003 Load SearchPath from .dof file }
{ 1.04 09/05/2002 Get rid of ShBrowse }
{ 1.03 07/13/2000 Allow search for Interface only relations }
  
  MAXUNITS = 1600;
type
  SetOfChar = set of char;

  TUnitInfo = class;

  TListOfAllUnits = class(TComponent)
    private
      fRootName: string;
      fUnitList: TStringList;
    public
      constructor Create(AOwner: TComponent); override;
      property UnitList: TStringList
               read fUnitList
               write fUnitList;
{*}   procedure GetChildren(proc: TGetChildProc; Root: TComponent); override;
      procedure DeleteUnitInfo(aUnitInfo: TUnitInfo);
      procedure AddUnitInfo(aUnitInfo: TUnitInfo);
      procedure Clear;
    published
      property RootUnit: string
               read fRootName
               write fRootName;
  end;

  TUnitInfo = class(TComponent)
    private
      fFound: boolean;
      fFilePath: string;
      fUnitsReferenced: TStringList;
      fUnitsReferencedSet: TBitMap;
      fListOfAllUnits: TListOfAllUnits;
      fUnitName: string;
      procedure SetListOfAllUnits(aListOfAllUnits: TListOfAllUnits);
      procedure SetUnitsReferenced(aUnitsReferenced: TStringList);
    public
      Processed: boolean;
      Constructor Create(aUnitName: string; aListOfAllUnits: TListOfAllUnits); reintroduce;
      Destructor Destroy; override;
{*}   function GetChildOwner : TComponent; override;
{*}   function GetParentComponent: TComponent; override;
{*}   procedure SetParentComponent(AParent: TComponent); override;
{*}   function HasParent: boolean; override;
{*}   procedure ReadState(Reader: TReader); override;
      property ListOfAllUnits: TListOfAllUnits
               read fListOfAllUnits
               write SetListOfAllUnits;
    published
      property UnitName: string
               read fUnitName
               write fUnitName;
      property FilePath: string
               read fFilePath
               write fFilePath;
      property Found: boolean
               read fFound
               write fFound;
      property UnitsReferenced: TStringList
               read fUnitsReferenced
               write SetUnitsReferenced;
  end;

  TForm_UsedUnits = class(TForm)
    PageControl1: TPageControl;
    TabSheet_Setup: TTabSheet;
    TabSheet_UsedUnits: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Button_Add: TButton;
    Button_Delete: TButton;
    OpenDialog1: TOpenDialog;
    Panel3: TPanel;
    Label2: TLabel;
    Edit_MainProgram: TEdit;
    Button_MainProgram: TButton;
    Panel4: TPanel;
    TabSheet_Relation: TTabSheet;
    lbUnits: TListBox;
    Panel5: TPanel;
    lbUsedUnits: TListBox;
    Panel_MemoPath: TPanel;
    lbPaths: TListBox;
    rbUsedBy: TRadioButton;
    rbUses: TRadioButton;
    Label_NowProcessing: TLabel;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    PrintSetup1: TMenuItem;
    Print1: TMenuItem;
    N2: TMenuItem;
    SaveAs1: TMenuItem;
    Open1: TMenuItem;
    New1: TMenuItem;
    SaveDialog1: TSaveDialog;
    Panel6: TPanel;
    Panel8: TPanel;
    Panel7: TPanel;
    cbStartUnit: TComboBox;
    cbTargetUnit: TComboBox;
    Panel9: TPanel;
    btnFind: TButton;
    Image1: TImage;
    Button_Begin: TButton;
    PrintDialog1: TPrintDialog;
    Reports1: TMenuItem;
    ListUnitstoTextFile1: TMenuItem;
    lbRelation: TListBox;
    Label3: TLabel;
    btnNext: TButton;
    Help1: TMenuItem;
    About1: TMenuItem;
    HowtoUseHelp1: TMenuItem;
    SearchforHelpOn1: TMenuItem;
    Contents1: TMenuItem;
    cbInterfacesOnly: TCheckBox;
    procedure Button_AddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button_MainProgramClick(Sender: TObject);
    procedure Button_BeginClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button_DeleteClick(Sender: TObject);
    procedure lbPathsClick(Sender: TObject);
    procedure Edit_MainProgramChange(Sender: TObject);
    procedure lbUnitsClick(Sender: TObject);
    procedure rbUsesClick(Sender: TObject);
    procedure rbUsedByClick(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure File1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    function ReadQuotedString: string;
    procedure SkipDelimiters;
    procedure SkipBlanks;
    procedure SkipComment;
    function NextToken: string;
    function ReadString(cset: SetOfChar): string;
    procedure NextCh;
    function OpenProjectFile(FileName: string): Boolean; {PB}
    procedure PageControl1Change(Sender: TObject);
    procedure cbStartUnitChange(Sender: TObject);
    procedure cbTargetUnitChange(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure lbUsedUnitsClick(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure ListUnitstoTextFile1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Reports1Click(Sender: TObject);
  private
    { Private declarations }
    fListOfAllUnits: TListOfAllUnits;
    fRelation:      array[0..MAX_BITS_PER_SET] of SmallInt;
    fMaxLevel:      0..MAX_BITS_PER_SET;
    fProcessing:    boolean;
    Infile:         TextFile;
    Inlfn:          string;
    EofFlag:        boolean;
    Line:           string;
    ch:             char;
    Token:          string;
    idx:            integer;
    fUnitsProcessed: TBitMap;
    procedure SetProcessing(value: boolean);
    procedure AddPaths(Path: string);
  protected
    procedure WMUser(var Message: TMessage); message WM_USER;
  public
    { Public declarations }
    Alpha   : SetOfChar;
    DelphiDir: string;
    Numeric : SetOfChar;
    fNrFound, fNrScanned: integer;
    fOriginalDirectory: string;
    fCurrentDirectory: string;
    AlphaNumeric: SetOfChar;
    procedure AddUnit( CurrentUnitInfo: TUnitInfo;
                       UnitName: string;
                       Flags: integer);
    procedure ClearsPaths;
    procedure ClearUnitList(List: TStringList);
    procedure Enable_Stuff;
    function  FindHeirarchy(StartUnit, TargetUnit: string): boolean;
    procedure FindNextRelation(FindNext: boolean);
    function  GetUnitNr(aUnitName: string): integer;
    procedure Initialize_Referenced_Sets;
    procedure ListUnitsToTextFile(lfn: string);
    procedure LoadFile(FileName: string);
    procedure LoadRegistryPaths;
    property  Processing: boolean
              read fProcessing
              write SetProcessing;
    procedure ScanFile(lbIndex: integer);
    procedure ShowUnits;
    procedure ShowUsedUnits;
    procedure ShowUsedByUnits;
    procedure SaveFileAs(FileName: string);
  end;

var
  Form_UsedUnits: TForm_UsedUnits;

implementation

{$R *.DFM}

uses StStrL, uAbout, MyUtils, SoftReg;
//uses StStrL, uAbout;

function Empty(s: string): boolean;
begin
  result := trim(s) = '';
end;

procedure Alert(msg: string);
begin
  Application.MessageBox(pchar(Msg), 'Warning', MB_OK);
end;


procedure TForm_UsedUnits.Button_AddClick(Sender: TObject);
  var
    Folder: string;
begin
  if BrowseForFolder('Select folder', Folder) then
    with lbPaths.Items do
      Add(AddBackSlashL(Folder));
(*
  if SHBrowse.Execute then
  begin
    with lbPaths.Items do
    begin
      Add(AddBackSlashL(SHBrowse.Folder));
    end;
  end;
  lbPaths.SetFocus;
*)
end;

{*****************************************************************************
{   Function Name     : uuStrPos
{   Function Purpose  : Like POS but not case specific
{*******************************************************************************}
    
function uuStrPos( StartIdx: integer;
                   Target  : string;
                   Buffer  : string): integer;
  var
    mode   : (SEARCHING, SEARCH_FOUND, NOT_FOUND);
    i      : integer;
    LenTar : Integer;
    BufLen : integer;
begin { uuStrPos }
  LenTar := Length(Target);
  BufLen := Length(Buffer);
  if LenTar > 0 then
    begin
      { look for the first character of the target }
      mode := SEARCHING;
      i    := StartIdx;
      repeat
        if i + LenTar - 1 > BufLen then
          mode := NOT_FOUND else
        if UpperCase(Buffer[i]) = UpperCase(Target[1]) then  { match on 1st char }
          if CompareText(Target, Copy(Buffer, i, LenTar)) = 0 then
            mode := SEARCH_FOUND
          else
            inc(i)
        else
          inc(i);
      until mode <> SEARCHING;
      if mode = SEARCH_FOUND then
        result := i
      else
        result := 0;
    end
  else
    result := 0;   { searching for null-string is bad luck }
end;  { uuStrPos }

procedure TForm_UsedUnits.ClearsPaths;
begin
  lbPaths.Clear;
end;

procedure TForm_UsedUnits.AddPaths(Path: string);
  var
    aPos: integer;
    p: integer;
begin
  p := 1;
  repeat
    p := uuStrPos(p, '$(delphi)', Path);
    if p > 0 then
      begin
        Path := Copy(Path, 1, p-1) + DelphiDir + Copy(Path, p+9, length(path)-p-8);
        p    := p + length(DelphiDir) + 1;
      end;
  until p = 0;

  repeat
    APos := Pos(';', Path);
    if APos=0 then APos := Pos(',', Path);
    if APos=0 then
      begin
        if Path<>'' then
          lbPaths.Items.Add(AddBackSlashL(Path));
        Path := '';
      end
    else
      begin
        if APos>1 then
          lbPaths.Items.Add(AddBackSlashL(Copy(Path, 1, Pred(APos))));
        Path := Copy(Path, Succ(APos), Length(Path));
      end;
  until Path='';
end;

procedure TForm_UsedUnits.LoadRegistryPaths;
  var
    Key: HKEY;
    Path: string;
    SoftReg: TSoftReg;
begin { LoadRegistryPaths }
  SoftReg := TSoftReg.Create;
  try
    SoftReg.CompanyName:= 'Borland';
    SoftReg.ProductName:= 'Delphi';
    SoftReg.Version:= '7.0';
    with SoftReg do
      begin
        OpenRootKey(rkLocal);
        Key       := OpenKey(0, '', False);
        try
          DelphiDir := ReadString(Key, 'RootDir', '');
          if DelphiDir[Length(DelphiDir)] = '\' then
            Delete(DelphiDir, Length(DelphiDir), 1);
        finally
    //        CloseKey(Key);
        end;

        OpenRootKey(rkUser);
        try
          { Get path to Delphi Root Directory }
          Key := OpenKey(0, 'Library', False);
          try
            Path := ReadString(Key, 'Search Path', '');
            AddPaths(Path);
            Path := ReadString(Key, 'Browsing Path', ''); {PB}
            AddPaths(Path); {PB}
          finally
            CloseKey(Key);
          end;
        finally
          CloseRootKey;
        end;
      end;
  finally
    SoftReg.Free;
  end;
end;  { LoadRegistryPaths }

procedure TForm_UsedUnits.FormCreate(Sender: TObject);
begin { FormCreate }
  GetDir(0, fOriginalDirectory);
  Alpha           := ['A'..'Z', 'a'..'z', '_'];
  Numeric         := ['0'..'9'];
  AlphaNumeric    := Alpha + Numeric;;
  fListOfAllUnits := TListOfAllUnits.Create(self);
  LoadRegistryPaths;
  Label_NowProcessing.Caption := '';
  PageControl1.ActivePage := TabSheet_UsedUnits;
  Enable_Stuff;
end;  { FormCreate }


procedure TForm_UsedUnits.Enable_Stuff;
  var
    b: boolean;
    UnitInfo: TUnitInfo;
begin { TForm_UsedUnits.Enable_Stuff }
  b := Empty(Edit_MainProgram.Text);
  Button_Begin.Enabled := (not b) and (not fProcessing);
  with lbPaths do
    Button_Delete.Enabled := ItemIndex >= 0;
  with lbUnits do
    begin
      if ItemIndex >= 0 then
        begin
          UnitInfo := TUnitInfo(Items.Objects[ItemIndex]);
          rbUsedBy.Enabled     := not fProcessing;
          rbUses.Enabled       := (UnitInfo.Found) and (not fProcessing);
          cbStartUnit.Enabled  := not fProcessing;
          cbTargetUnit.Enabled := not fProcessing;
        end
      else
        begin
          rbUsedBy.Enabled := false;
          rbUses.Enabled   := false;
        end;
    end;

  btnFind.Enabled  := (cbStartUnit.ItemIndex >= 0) and
                      (cbTargetUnit.ItemIndex >= 0) and
                      (not fProcessing);
  btnNext.Enabled  := (not BitMap_IsEmpty(fUnitsProcessed)) and
                      (not fProcessing);
//  Reports1.Enabled := (lbUnits.Items.Count > 0) and (not fProcessing);
end;  { TForm_UsedUnits.Enable_Stuff }

procedure TForm_UsedUnits.Button_MainProgramClick(Sender: TObject);
begin
  with OpenDialog1 do
    begin
      Filter := 'Pascal Project (*.dpr)|*.dpr|'+
                'Pascal Source (*.pas)|*.pas|' +
                'Delphi Package Source (*.dpk)|*dpk';
      DefaultExt := 'dpr';
      if Execute then
        begin
          OpenProjectFile(FileName); {PB}
          Enable_Stuff;
        end;
    end;
end;

procedure TForm_UsedUnits.Initialize_Referenced_Sets;
  var
    i        : integer;
    j        : integer;
    UnitInfo : TUnitInfo;
    UnitNr   : integer;
    bUnitName: string;
begin { Initialize_Referenced_Sets }
  Processing := true;
  with lbUnits do
    begin
      for i := 0 to Items.Count-1 do
        begin
          UnitInfo := TUnitInfo(Items.Objects[i]);
          with UnitInfo do
            begin
              if (i mod 10) = 0 then
                begin
                  Label_NowProcessing.Caption := Format('Processing %d/%d [%s]',
                                                   [i, Items.Count, UnitInfo.UnitName]);
                  Application.ProcessMessages;
                end;
              BitMap_Zero(fUnitsReferencedSet);
              for j := 0 to fUnitsReferenced.Count-1 do
                begin
                  bUnitName := fUnitsReferenced[j];
                  UnitNr    := GetUnitNr(bUnitName);
                  if UnitNr >= 0 then
                    BitMap_ADDONE(fUnitsReferencedSet, UnitNr);
                end;
            end;
        end;
    end;
  Label_NowProcessing.Caption := '';
  Processing := false;
end;  { Initialize_Referenced_Sets }

procedure TForm_UsedUnits.Button_BeginClick(Sender: TObject);
  var
    UnitNr: integer;
    UnitInfo: TUnitInfo;
begin
  UnitNr         := 0;
  fNrFound       := 0;
  fNrScanned     := 0;
  lbUnits.Sorted := false;
  lbUsedUnits.Clear;
  Processing     := true;
  try
    Screen.Cursor:= crHourGlass; {PB}
    try
      fCurrentDirectory := ExtractFilePath(Edit_MainProgram.Text);
      ChDir(fCurrentDirectory);
      lbUnits.Clear;
      AddUnit(nil, ExtractFileName(Edit_MainProgram.Text), 0);

      repeat
        ScanFile(UnitNr);
        inc(UnitNr);
      until UnitNr >= lbUnits.Items.Count;
      lbUnits.Sorted := true;
      for UnitNr := 0 to lbUnits.Items.Count - 1 do
        begin
          UnitInfo := TUnitInfo(lbUnits.Items.Objects[UnitNr]);
          if not UnitInfo.Found then
            lbUnits.Items[UnitNr] := Format('(%s)', [lbUnits.Items[UnitNr]]);
        end;
      Initialize_Referenced_Sets;
      Label_NowProcessing.Caption := Format('FINISHED. Found=%d, Scanned=%d',
                                            [lbUnits.Items.Count, fNrScanned]);
    finally
      Screen.Cursor:= crDefault; {PB}
    end;
  finally {PB}
    Processing     := false;
  end;
end;

procedure TForm_UsedUnits.AddUnit( CurrentUnitInfo: TUnitInfo;
                                   UnitName: string;
                                   Flags: integer);  // for now, flags = 0: Interface;
                                                     //          flags = 1: Implementation
  var
    aUnitInfo: TUnitInfo;
    idx: integer;
begin { TForm_UsedUnits.AddUnit }
  { add it to the overall list of units }
  with lbUnits do
    begin
      idx := Items.IndexOf(UnitName);
      if idx < 0 then
        begin
          aUnitInfo := TUnitInfo.Create(UnitName, fListOfAllUnits);
          Items.AddObject(UnitName, aUnitInfo);
          inc(fNrFound);
          Application.ProcessMessages;
        end;
    end;

  { add it to the list of units referenced by the current unit }
  if Assigned(CurrentUnitInfo) then
    with CurrentUnitInfo.UnitsReferenced do
      begin
        idx := IndexOf(UnitName);
        if idx < 0 then
          AddObject(UnitName, TObject(flags));
      end;
end;  { TForm_UsedUnits.AddUnit }

procedure TForm_UsedUnits.NextCh;
begin
  if idx > length(Line) then
    begin
      if not eof(InFile) then
        readln(InFile, Line)
      else
        begin
          if not EofFlag then
            EofFlag := true
          else
            raise Exception.CreateFmt('Unexpected EOF on file %s', [InLfn]);
        end;
      idx := 1;
      ch  := ' '
    end
  else
    begin
      ch := Line[idx];
      inc(idx);
    end;
end;

function TForm_UsedUnits.OpenProjectFile(FileName: string): Boolean; {PB}
var
  Ext: string;

  function InList(Ext: string; const Exts: array of string): boolean;
    var
      i: integer;
  begin { InList }
    result := false;
    for i := 0 to High(Exts) do
      if CompareText(Ext, Exts[i]) = 0 then
        begin
          result := true;
          break;
        end;
  end;  { InList }

  procedure LoadDofFile(const FileName: string);
    const
      SEARCHPATH = 'SearchPath';
    var
      DofFileName: string;
      InFile: TextFile;
      line: string;
      Len: integer;

    function FindLine(const s: string): boolean;
      var
        mode: (SEARCHING, SEARCH_FOUND, NOT_FOUND);
    begin { FindLine }
      mode := SEARCHING;
      while mode = SEARCHING do
        begin
          if Eof(InFile) then
            mode := NOT_FOUND
          else
            begin
              readln(InFile, Line);
              if CompareText(s, Copy(Line, 1, Length(s))) = 0 then
                mode := SEARCH_FOUND
            end;
        end;
      result := mode = SEARCH_FOUND;
    end;  { FindLine }

  begin { LoadDofFile }
    DofFileName := ChangeFileExt(FileName, '.dof');
    if FileExists(DofFileName) then
      begin
        AssignFile(Infile, DofFileName);
        Reset(InFile);
        try
          if FindLine('[Directories]') then
            if FindLine(SEARCHPATH)then
              begin
                ClearsPaths;
                LoadRegistryPaths;
                Len  := Length(SEARCHPATH);
                Line := Copy(Line, Len+2, Length(Line)-Len-1);
                AddPaths(Line);
              end;
        finally
          CloseFile(InFile);
        end;
      end;
  end;  { LoadDofFile }

begin
  Result:= FileExists(FileName);
  if Result then
  begin
    Ext:= ExtractFileExt(FileName);
    if SameText(Ext, '.exe') or SameText(Ext, '.dll') then
    begin
      Ext:= '.dpr';
      ChangeFileExt(FileName, Ext);
    end;
    Edit_MainProgram.Text:= FileName;
    if InList(Ext, ['.dpr', '.pas', '.dpk']) then
      LoadDofFile(FileName);
  end;
end;

function TForm_UsedUnits.ReadString(cset: SetOfChar): string;
begin
  result := '';
  while ch in cset do
    begin
      SetLength(result, succ(Length(result)));
      result[Length(result)] := ch;
      NextCh;
    end;
end;

function TForm_UsedUnits.NextToken: string;
begin
  SkipBlanks;
  SkipComment;
  result := ReadString(AlphaNumeric);
end;

procedure TForm_UsedUnits.SkipComment;
  var
    done: boolean;
begin { SkipComment }
  if ch = '{' then
    begin
      NextCh;
      while ch <> '}' do
        NextCh;
      NextCh;
    end else
  if ch = '/' then
    begin
      if Idx <= Length(Line) then
        if Line[idx] = '/' then // current and next = '//'
          begin
            if not eof(InFile) then
              begin
                Readln(InFile, Line);
                idx := 1;
                ch := Line[Idx];
              end;
          end;
    end else
  if ch = '(' then
    begin
      if ch = '*' then
        begin
          NextCh;
          done := false;
          while not done do
            begin
              NextCh;
              if ch = ')' then
                done := true;
            end;
          NextCh;
        end;
    end;
end;  { SkipComment }

procedure TForm_UsedUnits.SkipBlanks;
begin
  while ch in [' ', '{', '('] do
    if ch = ' ' then
      NextCh
    else
      SkipComment;
end;

procedure TForm_UsedUnits.SkipDelimiters;
begin { TForm_UsedUnits.SkipDelimiters }
  while not (ch in (AlphaNumeric+[';'])) do
    if ch = '{' then
      SkipComment
    else
      NextCh;
end;  { TForm_UsedUnits.SkipDelimiters }

function TForm_UsedUnits.ReadQuotedString: string;
  var
    ch0: char;
begin { TForm_UsedUnits.ReadQuotedString }
  ch0 := ch;
  result := '';
  NextCh;
  while ch <> ch0 do
    begin
      result := result + ch;
      nextch;
    end;
  NextCh;
end;  { TForm_UsedUnits.ReadQuotedString }

// Copied from MWStrings, because this project should not depend on Mail Manager 2010 - PB

(*
function Padr(Field: string; Width: integer; PadChar: char): string; overload;
  var
   blanks : string[255];
   temp   : string;
   LenFld : Integer;
begin { Padr }
  blanks[0] := CHR(255);
  FillChar(blanks[1], 255, PadChar);
  LenFld    := Length(Field);
  if LenFld < Width then
    temp := field + copy(blanks, 1, Width-LenFld)
  else { LenFld >= Width }
    begin
      if Width > 0 then
        temp := copy(field, 1, Width)
      else
        temp := '';
    end;

  padr := temp;
end;  { Padr }

function Padr(Field: string; Width: integer): string; overload;
begin
  result := Padr(Field, Width, ' ');
end;
*)

procedure TForm_UsedUnits.ScanFile(lbIndex: integer);
  var
    UsesIdx         : integer;
    UseClauseCount  : integer;
    CurrentUnitInfo : TUnitInfo;
    FullName        : string;
    BaseName        : string;
    FileNameFound   : boolean;

  procedure ProcessUsesClause(i: integer);

    procedure ProcessInClause;
      var
        FilePath: string;
    begin { ProcessInClause }
      SkipBlanks;
      Token    := ReadQuotedString;
      FilePath := ExtractFilePath(Token);
      if empty(FilePath) then
        FilePath := fCurrentDirectory;
      CurrentUnitInfo.FilePath := FilePath;
      SkipBlanks;
      SkipComment;
    end;  { ProcessInClause }

    procedure AddUsedUnit(UnitName: string);
      var
        uuCurrentUnitInfo: TUnitInfo;
    begin { AddUsedUnit }
      with lbUnits do
        begin
          if pos('.', UnitName) = 0 then
            UnitName := UnitName + '.pas';
          uuCurrentUnitInfo := TUnitInfo(lbUnits.Items.Objects[lbIndex]);
          AddUnit(uuCurrentUnitInfo, UnitName, UseClauseCount);
        end;
    end;  { AddUsedUnit }

  begin { ProcessUsesClause }
    if not Empty(Copy(Line, 1, i-1)) then
      Exit;  { if there is anything in front of this 'uses' then assume
               that we are in the middle of a comment and ignore it }
    idx  := i;    // init char pointer
    NextCh;
    Token := NextToken;
    if (CompareText(Token, 'USES') <> 0) and
       (CompareText(Token, 'CONTAINS') <> 0) then  // this 'uses' must be part of something else
      Exit;
    repeat
      SkipDelimiters;
      Token := NextToken;
      SkipBlanks;
      if not Empty(Token) then
        if CompareText(Token, 'in') = 0 then
          ProcessInClause
        else
          if ch in [',', ';', 'i', 'I'] then
            AddUsedUnit(Token)
          else
            exit;  // if the token isn't followed by a comma or a semicolon
                    // or an 'i' (from 'in')
                    // the the syntax dosen't make sense and we are probably
                    // in the middle of a comment
    until ch = ';';
    inc(UseClauseCount);
  end;  { ProcessUsesClause }

  function FileFound(lfn: string; var FullName: string): boolean;
    var
      i: integer;
      path: string;
  begin
    result := false;
    // look through each of the search paths for the file
    path     := AddBackSlashL(fCurrentDirectory);
    FullName := path+lfn;
    if FileExists(FullName) then
      result   := true
    else
      for i := 0 to lbPaths.Items.Count-1 do
        begin
          FullName := lbPaths.Items[i]+lfn;
          if FileExists(FullName) then
            begin
              result   := true;
              exit;
            end;
        end;
  end;

  function CheckFileName: boolean;

    function CheckUnitName(Which: string): boolean;
      var
        i: integer;
    begin { CheckUnitName }
      result := false;
      i := uuStrPos(1, which, line);
      if i > 0 then
        begin
          if not Empty(Copy(Line, 1, i-1)) then
            Exit;  { if there is anything in front of "UNIT" then assume
                     that we are in the middle of a comment and ignore it }
          idx  := i;    // init char pointer
          NextCh;
          Token := NextToken;    // read "UNIT" (or "PROGRAM")
          if CompareText(Token, Which) <> 0 then
            Exit;   // something completely different
          Token := NextToken;
          if CompareText(Token, BaseName) <> 0 then
            AlertFmt('File/Unit name mismatch: %s/%s',
               [Token, BaseName]);
          result := true;
        end;
    end;  { CheckUnitName }

  begin { CheckFileName }
    result := CheckUnitName('UNIT');
    if not result then
      result := CheckUnitName('PROGRAM');
    if not result then
      result := CheckUnitName('PACKAGE');
    if not result then
      result := CheckUnitName('LIBRARY');
  end;  { CheckFileName }

begin { TForm_UsedUnits.ScanFile }
  CurrentUnitInfo := TUnitInfo(lbUnits.Items.Objects[lbIndex]);
  Inlfn           := lbUnits.Items[lbIndex];
  UseClauseCount  := 0;
  if FileFound(InLfn, FullName) then
    begin
      BaseName                    := ChangeFileExt(ExtractFileName(FullName), '');
      CurrentUnitInfo.FilePath    := ExtractFilePath(FullName);
      Label_NowProcessing.Caption := Format('%d: %s', [lbUnits.Items.Count+1, InLfn]);
      AssignFile(Infile, FullName);
      EofFlag := false;
      reset(InFile);

      // Insure that the UnitName is same as the FileName
      FileNameFound := false;
      while not (FileNameFound or Eof(InFile)) do
        begin
          readln(InFile, Line);
          FileNameFound := CheckFileName;
        end;
        
      if Eof(InFile) then
        raise Exception.CreateFmt('PROGRAM/UNIT name not found in file %s',
                                  [FullName]);

      while (UseClauseCount < 2) and (not eof(InFile)) do
        begin
          readln(InFile, line);
          UsesIdx :=  uuStrPos(1, 'USES', Line);
          if UsesIdx <= 0 then
            UsesIdx := uuStrPos(1, 'CONTAINS', line);
          if UsesIdx > 0 then  // found a uses clause
            ProcessUsesClause(UsesIdx);
        end;
      CloseFile(InFile);
      Inc(fNrScanned);
      with CurrentUnitInfo do
        begin
          Processed := true;
          Found     := true;
        end;
    end
  else
    CurrentUnitInfo.Found := false;
end;  { TForm_UsedUnits.ScanFile }


procedure TForm_UsedUnits.FormDestroy(Sender: TObject);
begin
  fListOfAllUnits.Free;
  ChDir(fOriginalDirectory);
end;

procedure TForm_UsedUnits.Button_DeleteClick(Sender: TObject);
  var
    idx: integer;
begin
  with lbPaths do
    begin
      if ItemIndex >= 0 then
        begin
          Idx := ItemIndex;
          Items.Delete(ItemIndex);
          if idx < Items.Count then
            ItemIndex := idx;
          Enable_Stuff;
        end;
    end;
end;

procedure TForm_UsedUnits.lbPathsClick(Sender: TObject);
begin
  Enable_Stuff;
end;

Destructor TUnitInfo.Destroy;
begin
  UnitsReferenced.Free;
  inherited;
end;

constructor TUnitInfo.Create(aUnitName: string; aListOfAllUnits: TListOfAllUnits);
begin
  inherited Create(aListOfAllUnits);
  fUnitName        := aUnitName;
  fListOfAllUnits  := aListOfAllUnits;
  fUnitsReferenced := TStringList.Create;
end;

procedure TForm_UsedUnits.Edit_MainProgramChange(Sender: TObject);
begin
  Enable_Stuff;
end;

procedure TForm_UsedUnits.lbUnitsClick(Sender: TObject);
  var
    CurrentUnitInfo: TUnitInfo;
begin
  Enable_Stuff;
  ShowUnits;
  with lbUnits do
    begin
      CurrentUnitInfo := TUnitInfo(Items.Objects[ItemIndex]);
      Label_NowProcessing.Caption := CurrentUnitInfo.FilePath + Items[ItemIndex];
    end;
end;

procedure TForm_UsedUnits.ShowUnits;
begin { TForm_UsedUnits. }
  if rbUses.Checked then
    ShowUsedUnits else
  if rbUsedBy.Checked then
    ShowUsedByUnits;
end;  { TForm_UsedUnits. }

procedure TForm_UsedUnits.ShowUsedUnits;
  var
    UnitName: string;
    UnitInfo: TUnitInfo;
begin { TForm_UsedUnits.ShowUsedUnits }
  with lbUnits do
    begin
      UnitName := Items[ItemIndex];
      UnitInfo := TUnitInfo(Items.Objects[ItemIndex]);
      lbUsedUnits.Items := UnitInfo.UnitsReferenced;
    end;
end;  { TForm_UsedUnits.ShowUsedUnits }

procedure TForm_UsedUnits.ShowUsedByUnits;
  var
    i, idx: integer;
    TargetUnitName: string;
    UnitInfo: TUnitInfo;
begin { TForm_UsedUnits.ShowUsedByUnits }
  lbUsedUnits.Clear;
  with lbUnits do
    begin
      TargetUnitName := TUnitInfo(Items.Objects[ItemIndex]).UnitName;
      for i := 0 to Items.Count-1 do
        begin
          UnitInfo := TUnitInfo(Items.Objects[i]);
          with UnitInfo do
            begin
              idx := UnitsReferenced.IndexOf(TargetUnitName);
              if idx >= 0 then
                lbUsedUnits.Items.Add(Items[i]);
            end;
        end;
    end;
end;  { TForm_UsedUnits.ShowUsedByUnits }



procedure TForm_UsedUnits.rbUsesClick(Sender: TObject);
begin
  ShowUnits;
end;

procedure TForm_UsedUnits.rbUsedByClick(Sender: TObject);
begin
  ShowUnits;
end;

procedure TForm_UsedUnits.SaveAs1Click(Sender: TObject);
begin
  with SaveDialog1 do
    begin
      InitialDir := ExtractFilePath(Edit_MainProgram.Text);
      FileName   := JustNameL(Edit_MainProgram.Text) + '.txt';
      DefaultExt := 'txt';
      if Execute then
        SaveFileAs(FileName);
    end;
end;

procedure TForm_UsedUnits.SaveFileAs(FileName: string);
  var
    FileStream: TFileStream;
    FileName_puu: string;

  procedure GenTextVersion(InLfn, OutLfn: string);
    var
      SrcStream: TStream;
      DestStream: TFileStream;
  begin { GenTextVersion }
    SrcStream := TFileStream.Create( InLfn, fmOpenRead);
    try
      destStream := TFileStream.Create(OutLfn, fmCreate);
      try
        { now convert binary version to text version and output on
          destination stream }
        ObjectBinaryToText(SrcStream, destStream);
      finally
        destStream.Free;
      end;
    finally
      SrcStream.Free;    { destroy the input stream }
    end;
  end;  { GenTextVersion }

begin { TForm_UsedUnits.SaveFileAs }
  fListOfAllUnits.fUnitList.Assign(lbUnits.Items);
  fListOfAllUnits.fRootName := Edit_MainProgram.Text;
  FileName_puu := ForceExtensionL(FileName, 'puu');
  try
    FileStream := TFileStream.Create(FileName_puu, fmCreate OR fmShareExclusive);
    try
      FileStream.WriteComponent(fListOfAllUnits);
    finally
      FileStream.Free;
    end;
    GenTextVersion(FileName_puu, FileName);
  except
    Alert(Format('Error Code: %d', [GetLastError]));
  end;
end;  { TForm_UsedUnits.SaveFileAs }


procedure TForm_UsedUnits.File1Click(Sender: TObject);
  var
    b: boolean;
begin
  b := (not Empty(Edit_MainProgram.Text)) and
       (lbUnits.Items.Count > 0) and
       (not Processing);
  SaveAs1.Enabled := b;
  Print1.Enabled  := b;
end;

procedure TListOfAllUnits.GetChildren(proc: TGetChildProc; Root: TComponent);
  var
    i : integer;
begin
  for i := 0 to fUnitList.Count-1 do
    Proc(TUnitInfo(fUnitList.Objects[i]));
end;

function TUnitInfo.GetChildOwner : TComponent;
begin
  result := self;
end;

function TUnitInfo.GetParentComponent: TComponent;
begin
  result := fListOfAllUnits;
end;

procedure TUnitInfo.SetParentComponent(AParent: TComponent);
begin
  if not (csLoading in ComponentState) then
    fListOfAllUnits := AParent as TListOfAllUnits;
end;

function TUnitInfo.HasParent: boolean;
begin
  result := true;
end;

procedure TUnitInfo.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TListOfAllUnits then
    ListOfAllUnits := TListOfAllUnits(Reader.Parent);
end;

procedure TUnitInfo.SetUnitsReferenced(aUnitsReferenced: TStringList);
begin
  fUnitsReferenced := aUnitsReferenced;
(*
  if aUnitsReferenced <> fUnitsReferenced then
    begin
      if fUnitsReferenced <> nil then
        fUnitsReferenced.DeleteUnitsReferenced(Self);
      if aUnitsReferenced <> nil then
        aUnitsReferenced.AddUnitsReferenced(Self);
    end;
*)
end;

procedure TUnitInfo.SetListOfAllUnits(aListOfAllUnits: TListOfAllUnits);
begin
  if aListOfAllUnits <> fListOfAllUnits then
    begin
      if fListOfAllUnits <> nil then
        fListOfAllUnits.DeleteUnitInfo(Self);
      if aListOfAllUnits <> nil then
        aListOfAllUnits.AddUnitInfo(Self);
    end;
end;

procedure TListOfAllUnits.DeleteUnitInfo(aUnitInfo: TUnitInfo);
  var
    idx: integer;
begin
  idx := fUnitList.IndexOfObject(aUnitInfo);
  if idx >= 0 then
    begin
      aUnitInfo.Free;
      fUnitList.Delete(idx);
    end;
end;

procedure TListOfAllUnits.AddUnitInfo(aUnitInfo: TUnitInfo);
begin
  aUnitInfo.fListOfAllUnits := self;
  fUnitList.AddObject(aUnitInfo.fUnitName, aUnitInfo);
end;

constructor TListOfAllUnits.Create(AOwner: TComponent);
begin
  inherited;
  fUnitList := TStringList.Create;
end;


procedure TForm_UsedUnits.LoadFile(FileName: string);

  Procedure Validate(RequiredToken: string);
  begin { Validate }
    if CompareText(Token, RequiredToken) <> 0 then
      raise Exception.CreateFmt('Token <%s> not found', [RequiredToken]);
  end;  { Validate }

  procedure SkipEqualSign;
  begin { SkipEqualSign }
    SkipBlanks;
    Token := ch;
    Validate('=');
    NextCh;
    SkipBlanks;
  end;  { SkipEqualSign }

  procedure LoadUnitInfo;
    var
      aUnitInfo: TUnitInfo;
  begin { LoadUnitInfo }
    aUnitInfo := TUnitInfo.Create('', fListOfAllUnits);
    Token := NextToken;
    Validate('TUnitInfo');
    Token := NextToken;
    repeat
      if CompareText(token, 'UnitName') = 0 then
        begin
          SkipEqualSign;
          Token := ReadQuotedString;
          aUnitInfo.UnitName := Token;
          Token := NextToken;
        end else
      if CompareText(token, 'FilePath') = 0 then
        begin
          SkipEqualSign;
          Token := ReadQuotedString;
          aUnitInfo.FilePath := Token;
          Token := NextToken;
        end else
      if CompareText(token, 'Found') = 0 then
        begin
          SkipEqualSign;
          Token := NextToken;
          aUnitInfo.Found := CompareText(Token, 'True') = 0;
          Token := NextToken;
        end else
      if CompareText(token, 'UnitsReferenced') = 0 then
        begin
          if ch <> '.' then
            Raise Exception.CreateFmt('"." expected in line [%s]', [line]);
          NextCh;
          Token := NextToken;
          Validate('Strings');
          SkipEqualSign;
          Token := ch;
          Validate('(');
          NextCh;
          repeat
            SkipBlanks;
            Token := ReadQuotedString;
            aUnitInfo.UnitsReferenced.Add(Token);
          until ch = ')';
          NextCh;
          Token := NextToken;
        end else
      if compareText(Token, 'end') <> 0 then
        Exception.CreateFmt('Unexpected property of TUnitInfo: %s', [Token]);
    until CompareText(token, 'end') = 0;
    aUnitInfo.Processed := true;
    fListOfAllUnits.fUnitList.AddObject(aUnitInfo.UnitName, aUnitInfo);
    Token := NextToken;
  end;  { LoadUnitInfo }


begin { TForm_UsedUnits.LoadFile }
  // This was intended to use ReadComponent but I get an error when loading
  // UnitsReferenced.Strings. Was faster and easier to simulate just what I need.

  InLfn := FileName;
  AssignFile(InFile, InLfn);
  Reset(Infile);
  EofFlag := false;
  Line := '';
  idx  := 1;
  NextCh;
  Token := NextToken;
  Validate('object');
  Token := NextToken;
  Validate('TListOfAllUnits');
  Token := NextToken;
  if Token = 'RootUnit' then
    begin
      SkipEqualSign;
      fListOfAllUnits.RootUnit := ReadQuotedString;
      Token := NextToken;
    end;
  while Token = 'object' do
    LoadUnitInfo;

  CloseFile(InFile);

(*
  try
    FileStream := TFileStream.Create(FileName, fmOpenRead OR fmShareExclusive);
    try
      FileStream.ReadComponent(fListOfAllUnits);
    finally
      FileStream.Free;
    end;
  except
    on e:exception do
      Alert(Format('Error loading saved unit information [%s]', [e.message]));
  end;
*)
end;  { TForm_UsedUnits.LoadFile }


procedure TForm_UsedUnits.Open1Click(Sender: TObject);
  var
    i: integer;
    UnitName: string;
    UnitInfo: TUnitInfo;
begin
  with OpenDialog1 do
    begin
      Filter := 'Pascal Used Units (*.txt)|*.txt';
      DefaultExt := 'txt';
      if Execute then
        begin
          fListOfAllUnits.Clear;
          LoadFile(FileName);
          with fListOfAllUnits do
            begin
              Edit_MainProgram.Text := fRootName;
              for i := 0 to fUnitList.Count-1 do
                begin
                  UnitName := fUnitList[i];
                  UnitInfo := TUnitInfo(fUnitList.Objects[i]);
                  if not UnitInfo.Found then
                    UnitName := Format('(%s)', [UnitName]);
                  lbUnits.Items.AddObject(UnitName, UnitInfo);
                end;
            end;
          Initialize_Referenced_Sets;
          Enable_Stuff;
        end;
    end;
end;

procedure TListOfAllUnits.Clear;
begin { TListOfAllUnits.Clear }
  (Owner as TForm_UsedUnits).ClearUnitList(fUnitList);
end;  { TListOfAllUnits.Clear }

procedure TForm_UsedUnits.ClearUnitList(List: TStringList);
  var
    i: integer;
begin { TForm_UsedUnits.ClearUnitList }
  with List do
    for i := Count - 1 downto 0 do
      begin
        TUnitInfo(Objects[i]).Free;
        Delete(i);
      end;
end;  { TForm_UsedUnits.ClearUnitList }

procedure TForm_UsedUnits.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = TabSheet_Relation then
    if (cbStartUnit.Items.Count  <> lbUnits.Items.Count) or
       (cbTargetUnit.Items.Count <> lbUnits.Items.Count) then
    begin
      cbStartUnit.Items  := lbUnits.Items;
      cbTargetUnit.Items := lbUnits.Items;
      Enable_Stuff;
    end;
end;

procedure TForm_UsedUnits.cbStartUnitChange(Sender: TObject);
begin
  lbRelation.Clear;
  Enable_Stuff;
end;

procedure TForm_UsedUnits.cbTargetUnitChange(Sender: TObject);
begin
  lbRelation.Clear;
  Enable_Stuff;
end;

procedure TForm_UsedUnits.FindNextRelation(FindNext: boolean);
  var
    UnitInfo: TUnitInfo;
    StartUnitName: string;
    TargetUnitName: string;
    Level: integer;
    UnitNr: integer;
    temp, msg: string;

begin { TForm_UsedUnits.FindNextRelation }
  with cbStartUnit do
    begin
      UnitInfo       := TUnitInfo(Items.Objects[ItemIndex]);
      StartUnitName  := UnitInfo.UnitName;
    end;
  with cbTargetUnit do
    begin
      UnitInfo       := TUnitInfo(Items.Objects[ItemIndex]);
      TargetUnitName := UnitInfo.UnitName;
    end;
  fMaxLevel := 0;
  lbRelation.Clear;
  lbUsedUnits.Clear;
  if not FindNext then  { find first }
    BitMap_Zero(fUnitsProcessed);
  if FindHeirarchy(StartUnitName, TargetUnitName) then
    begin
      { update lbRelation }
      for Level := 1 to fMaxLevel do
        begin
          UnitNr   := fRelation[Level];
//          UnitInfo := TUnitInfo(lbUnits.Items.Objects[UnitNr]); { dosen't work here? }
          temp     := lbUnits.Items[UnitNr];
          lbRelation.Items.Add(temp);
        end;
      Label_NowProcessing.Caption := 'Relation Found';
      Enable_Stuff;
    end
  else
    begin
      Label_NowProcessing.Caption := '';
      if not FindNext then  { find first }
        begin
          msg := Format('No USES relation could be found between %s and %s',
                       [StartUnitName, TargetUnitName]);
          if cbInterfacesOnly.Checked then
            msg := msg + ' (Interfaces only)';
          Alert(Msg);
        end
      else { find next }
        begin
          Alert(Format('No more USES relations could be found between %s and %s',
                     [StartUnitName, TargetUnitName]));
          btnNext.Enabled := false;
        end;
    end;
end;  { TForm_UsedUnits.FindNextRelation }

procedure TForm_UsedUnits.btnFindClick(Sender: TObject);
begin
  FindNextRelation(false);
end; 

function TForm_UsedUnits.GetUnitNr(aUnitName: string): integer;
  var
    l, h, m: integer;
    c: integer; // comparison: <, =, >
    UnitInfo: TUnitInfo;
begin { GetUnitNr }
  with lbUnits.Items do
    begin
      l := 0;
      h := Count-1;
      while l <= h do
        begin
          m := (l + h) div 2;
          UnitInfo := TUnitInfo(Objects[m]);
          c := AnsiCompareText(aUnitName, UnitInfo.UnitName);
          if c < 0 then
            h := m - 1 else
          if c > 0 then
            l := m + 1
          else { c = 0: found it }
            begin
              result := m;
              exit;
            end;
        end;
    end;
  result := -1;
end;  { GetUnitNr }

function TForm_UsedUnits.FindHeirarchy(StartUnit, TargetUnit: string): boolean;
  var
    StartUnitNr: integer;
    TargetUnitNr: integer;
    UnitsInProcess: TBitMap;

  function FindRelation(CurrentUnitNr, TargetUnitNr: integer;
                        Level: integer): boolean;
    var
      UnitInfo: TUnitInfo;
      UnitsToTry: TBitMap;
      i: integer;

    {*****************************************************************************
    {   Function Name     : OkToCheckReference
    {   Function Purpose  : If only references within the Interface section are
    {                       wanted, then make sure that this unit was referenced
                            in the interface.
    {   Return Value      : True if the indicated unit was referenced in the
    {                       Interface section
    {*******************************************************************************}

    function OkToCheckReference(CurrentUnitNr, TargetUnitNr: integer): boolean;
      var
        aName: string;
        idx, flags: integer;
        UnitInfo: TUnitInfo;
    begin { OkToCheckReference }
      if cbInterfacesOnly.Checked then
        begin
          result := false;

          // 1. Get the name of the referenced unit
          aName := lbUnits.Items[TargetUnitNr];

          // 2. Find it in the list of units used by current unit
          UnitInfo := TUnitInfo(lbUnits.Items.Objects[CurrentUnitNr]);
          idx      := UnitInfo.fUnitsReferenced.IndexOf(aName);

          // 3. Look at the corresponding "object" to see if it was referenced in the interface
          if idx >= 0 then  // this should always be true
            begin
              Flags  := integer(UnitInfo.fUnitsReferenced.Objects[idx]);
              result := Flags = 0;
            end;
        end
      else
        result := true;
    end;  { OkToCheckReference }

  begin { FindRelation }
    BitMap_AddOne(UnitsInProcess, CurrentUnitNr);
    UnitInfo := TUnitInfo(lbUnits.Items.Objects[CurrentUnitNr]);

    result := false;
    if UnitInfo.Found then { source code was found }
      { see if any of the units referenced by this unit is the target }
      if BitMap_HasElement(UnitInfo.fUnitsReferencedSet, TargetUnitNr) and
                 OkToCheckReference(CurrentUnitNr, TargetUnitNr)then
        result := true
      else
        begin { see if any of the referenced units completes the relation }
          BitMap_Diff(UnitsToTry, UnitInfo.fUnitsReferencedSet, UnitsInProcess);
          BitMap_Diff(UnitsToTry, UnitsToTry, fUnitsProcessed);
          for i := 0 to MAX_BITS_PER_SET-1 do  // need lowest/highest bit function
            begin
              if BitMap_HasElement(UnitsToTry, i) and
                 OkToCheckReference(CurrentUnitNr, i) then
                begin
                  result := FindRelation(i, TargetUnitNr, Level+1);
                  if result then
                    break;

                  BitMap_Diff(UnitsToTry, UnitsToTry, fUnitsProcessed);
                end;
            end;
        end;

    { if we found a relation, then add this unit to the relation }
    if result then
      begin
        fRelation[Level] := CurrentUnitNr;
        if Level > fMaxLevel then
          fMaxLevel := Level;
      end;

    BitMap_SubOne(UnitsInProcess, CurrentUnitNr);
    BitMap_AddOne(fUnitsProcessed, CurrentUnitNr);
  end;  { FindRelation }

begin { TForm_UsedUnits.FindHeirarchy }
  with lbUnits do
    begin
      StartUnitNr  := GetUnitNr(StartUnit);
      TargetUnitNr := GetUnitNr(TargetUnit);
      BitMap_Zero(UnitsInProcess);
      result := FindRelation(StartUnitNr, TargetUnitNr, 0);
    end;
end;  { TForm_UsedUnits.FindHeirarchy }


procedure TForm_UsedUnits.lbUsedUnitsClick(Sender: TObject);
  var
    UnitName: string;
    UnitNr:   integer;
begin
  with lbUsedUnits do
    begin
      UnitName := Items[ItemIndex];
      UnitNr   := GetUnitNr(UnitName);
      with lbUnits do
        ItemIndex := UnitNr;
      ShowUnits;
    end;
end;

procedure TForm_UsedUnits.Print1Click(Sender: TObject);
begin
//  with PrintDialog1 do
    begin
    end;
end;

procedure TForm_UsedUnits.ListUnitstoTextFile1Click(Sender: TObject);
begin
  with SaveDialog1 do
    begin
      InitialDir := ExtractFilePath(Edit_MainProgram.Text);
      FileName   := JustNameL(Edit_MainProgram.Text) + '.lst';
      DefaultExt := 'lst';
      if Execute then
        ListUnitsToTextFile(FileName);
    end;
end;

procedure TForm_UsedUnits.ListUnitsToTextFile(lfn: string);
  const
    FIELDWIDTH = 25;
    MAXLINELENGTH = 132;
  var
    i, j: integer;
    Len: integer;
    UnitInfo: TUnitInfo;
    OutFile: TextFile;

  procedure WriteRef(j: integer; AddComma: boolean);
    var
      ExtraSpace : integer;
  begin { WriteRef }
    if AddComma then
      ExtraSpace := 2
    else
      ExtraSpace := 0;

    with UnitInfo do
      begin
        if (Len + Length(UnitsReferenced[j]) + ExtraSpace) > MAXLINELENGTH then
          begin
            Writeln(OutFile);
            Write(OutFile, Padr('', FIELDWIDTH+4));
            len := FieldWidth + 4;
          end;
        write(OutFile, Unitsreferenced[j]);
        if AddComma then
          write(outFile, ', ');
        inc(Len, length(Unitsreferenced[j])+ExtraSpace);
      end;
  end;  { WriteRef }

begin { TForm_UsedUnits.ListUnitsToTextFile }
  AssignFile(OutFile, lfn);
  Rewrite(OutFile);
  try
    Len := 0;
    for i := 0 to lbUnits.Items.Count-1 do
      begin
        UnitInfo := TUnitInfo(lbUnits.items.objects[i]);
        if Assigned(UnitInfo) then
          with UnitInfo do
            begin
              Write(OutFile, i:3,
                               ' ',
                               Padr(UnitInfo.UnitName, FIELDWIDTH));
              inc(Len, 4+FieldWidth);
              if Assigned(UnitsReferenced) then
                begin
                  if (UnitsReferenced.count > 0) then
                    begin
                      for j := 0 to UnitsReferenced.count-2 do
                        WriteRef(j, true);
                      WriteRef(UnitsReferenced.count-1, false);
                    end;
                end
              else
                Write(outfile, 'UnitsReferenced not assigned for Unit ', UnitInfo.UnitName);
              Writeln(Outfile);
              Len := 0;
            end
        else
          Writeln(OutFile, 'UnitInfo not assigned for unit ', lbUnits.Items[i]);
      end;
  finally
    CloseFile(OutFile);
  end;
end;  { TForm_UsedUnits.ListUnitsToTextFile }


procedure TForm_UsedUnits.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm_UsedUnits.btnNextClick(Sender: TObject);
begin
  FindNextRelation(true);
end;

procedure TForm_UsedUnits.SetProcessing(value: boolean);
begin
  if value <> fProcessing then
    begin
      fProcessing := value;
      Enable_Stuff;
    end;
end;

procedure TForm_UsedUnits.FormShow(Sender: TObject);
begin
  PostMessage(Handle, WM_USER, 0, 0);
end;

procedure TForm_UsedUnits.WMUser(var Message: TMessage);
begin
  if ParamCount<>0 then
    OpenProjectFile(ParamStr(1)); {PB}
end;

procedure TForm_UsedUnits.About1Click(Sender: TObject);
begin
  AboutBox.Version := Version;
  AboutBox.ShowModal;
end;

procedure TForm_UsedUnits.Reports1Click(Sender: TObject);
begin
  ListUnitstoTextFile1.Enabled:= (lbUnits.Items.Count<> 0) and (not fProcessing);
end;

initialization
  RegisterClasses([TListOfAllUnits, TUnitInfo]);
  
end.
