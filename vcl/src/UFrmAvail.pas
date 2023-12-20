unit UFrmAvail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFrmAvail = class(TForm)
    Editions: TDBGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetupDataSources;
  public
    { Public declarations }
  end;

var
  FrmAvail: TFrmAvail;

implementation

uses
  UDbManager
  ;

{$R *.dfm}

procedure TFrmAvail.FormCreate(Sender: TObject);
begin
  SetupDataSources;
end;

procedure TFrmAvail.SetupDataSources;
begin
  Editions.DataSource := TDbManager.Shared.sourceAllEditions;
end;

end.
