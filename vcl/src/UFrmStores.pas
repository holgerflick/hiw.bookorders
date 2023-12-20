unit UFrmStores;

interface

uses
    Data.DB

  , System.Classes
  , System.SysUtils
  , System.Variants

  , Vcl.Buttons
  , Vcl.Controls
  , Vcl.DBCtrls
  , Vcl.DBGrids
  , Vcl.Dialogs
  , Vcl.ExtCtrls
  , Vcl.Forms
  , Vcl.Graphics
  , Vcl.Grids

  , Winapi.Messages
  , Winapi.Windows

  ;


type
  TFrmStores = class(TForm)
    Stores: TDBGrid;
    Navigator: TDBNavigator;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetupDatasources;
  public
    { Public declarations }
    class procedure Display;
  end;


implementation

uses
  UDbManager
  ;

{$R *.dfm}

{ TFrmStores }

class procedure TFrmStores.Display;
begin
  var LFrm := TFrmStores.Create(nil);
  try
    LFrm.ShowModal;
  finally
    LFrm.Free;
  end;
end;

procedure TFrmStores.FormCreate(Sender: TObject);
begin
  SetupDatasources;
end;

procedure TFrmStores.SetupDatasources;
begin
  Navigator.DataSource := TDbManager.Shared.sourceStores;
  Stores.DataSource := TDbManager.Shared.sourceStores;
end;

end.
