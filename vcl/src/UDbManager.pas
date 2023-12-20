unit UDbManager;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDbManager = class(TDataModule)
    SQLite: TFDPhysSQLiteDriverLink;
    Connection: TFDConnection;
    qryBooks: TFDQuery;
    qryEditions: TFDQuery;
    sourceBooks: TDataSource;
    sourceEditions: TDataSource;
    qryBooksid: TFDAutoIncField;
    qryBookstitle: TWideStringField;
    qryBookssubtitle: TWideStringField;
    qryBookscover: TBlobField;
    qryEditionsid: TFDAutoIncField;
    qryEditionsname: TWideStringField;
    qryEditionsbooksId: TIntegerField;
    qryEditionsasin: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  strict private
    class var FInstance: TDbManager;
  private
    { Private declarations }
  public
    { Public declarations }
    class destructor Destroy;
    class function Shared: TDbManager;
  end;

implementation

uses
  UAppGlobals
  ;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDbManager }

procedure TDbManager.DataModuleCreate(Sender: TObject);
begin
  Connection.Params.Database := TAppGlobals.DatabaseFilename;

  qryBooks.Open;
  qryEditions.Open;
end;

procedure TDbManager.DataModuleDestroy(Sender: TObject);
begin
  qryEditions.Close;
  qryBooks.Close;
end;

class destructor TDbManager.Destroy;
begin
  FInstance.Free;
end;

class function TDbManager.Shared: TDbManager;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TDbManager.Create(nil);
  end;

  Result := FInstance;
end;

end.
