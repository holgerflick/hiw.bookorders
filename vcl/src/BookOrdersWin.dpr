program BookOrdersWin;

uses
  Vcl.Forms,
  UFrmBooks in 'UFrmBooks.pas' {FrmBooks},
  UAppGlobals in 'UAppGlobals.pas',
  UDbManager in 'UDbManager.pas' {DbManager: TDataModule},
  UFrmMain in 'UFrmMain.pas' {FrmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
