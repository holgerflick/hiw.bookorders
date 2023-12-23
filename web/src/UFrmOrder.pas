unit UFrmOrder;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, UServiceManager;

type
  TFrmOrder = class(TWebForm)
    procedure WebFormCreate(Sender: TObject);
  private
    { Private declarations }
    FManager: TServiceManager;

  public
    { Public declarations }
  end;

var
  FrmOrder: TFrmOrder;

implementation

{$R *.dfm}

procedure TFrmOrder.WebFormCreate(Sender: TObject);
begin
  FManager := TServiceManager.Create(Self);
  FManager.RequestBooks;
end;

end.