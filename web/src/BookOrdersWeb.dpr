program BookOrdersWeb;

uses
  Vcl.Forms,
  WEBLib.Forms,
  UFrmOrder in 'UFrmOrder.pas' {FrmOrder: TWebForm} {*.html},
  UServiceManager in 'UServiceManager.pas' {ServiceManager: TWebDataModule},
  UTypes in '..\..\vcl\src\UTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmOrder, FrmOrder);
  Application.Run;
end.
