program FindUsedUnits;

uses
  Forms,
  uUsedUnits in 'uUsedUnits.pas' {Form_UsedUnits},
  MyUtils in '..\MyUtils\MyUtils.pas',
  StStrL in '..\TP\SysTools\source\StStrL.pas',
  SoftReg in '..\MyUtils\SoftReg.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title:= 'Used Units';
  Application.CreateForm(TForm_UsedUnits, Form_UsedUnits);
  Application.Run;
end.
