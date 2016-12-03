program prjTTT;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uGame
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TfrmGame, frmGame);
  Application.Run;
end.

