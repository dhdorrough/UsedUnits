(* changed on 9/19/2023 - testing it *)
unit uAbout;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    lblVersion: TLabel;
    OKButton: TButton;
  private
    procedure SetVersion(const Value: string);
    { Private declarations }
  public
    property Version: string
             write SetVersion;
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.DFM}

{ TAboutBox }

procedure TAboutBox.SetVersion(const Value: string);
begin
  lblVersion.Caption := Format('Version %s', [Value]);
end;

end.
 
