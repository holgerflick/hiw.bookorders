unit UFrmBooks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls;

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

var
  FrmBooks: TFrmBooks;

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
