unit UFrmBooks;

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
  TFrmBooks = class(TForm)
    Books: TDBGrid;
    Cover: TDBImage;
    Editions: TDBGrid;
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

class procedure TFrmBooks.Display;
begin
  var LFrm := TFrmBooks.Create(nil);
  try
    LFrm.ShowModal;
  finally
    LFrm.Free;
  end;
end;

procedure TFrmBooks.FormCreate(Sender: TObject);
begin
  SetupDatasources;
end;

procedure TFrmBooks.SetupDatasources;
begin
  var LManager := TDbManager.Shared;

  Navigator.DataSource := LManager.sourceBooks;
  Books.DataSource := LManager.sourceBooks;
  Cover.DataSource := LManager.sourceBooks;

  Editions.DataSource := LManager.sourceEditions;
end;

end.
