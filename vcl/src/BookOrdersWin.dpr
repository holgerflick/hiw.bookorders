program BookOrdersWin;

uses
  Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage,
  Vcl.Forms,
  UFrmBooks in 'UFrmBooks.pas' {FrmBooks},
  UAppGlobals in 'UAppGlobals.pas',
  UDbManager in 'UDbManager.pas' {DbManager: TDataModule},
  UFrmMain in 'UFrmMain.pas' {FrmMain},
  UFrmStores in 'UFrmStores.pas' {FrmStores},
  UFrmAvail in 'UFrmAvail.pas' {FrmAvail},
  UTypes in 'UTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
