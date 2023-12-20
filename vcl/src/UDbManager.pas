unit UDbManager;

interface

uses
    Data.DB

  , FireDAC.Comp.Client
  , FireDAC.Comp.DataSet
  , FireDAC.DApt
  , FireDAC.DApt.Intf
  , FireDAC.DatS
  , FireDAC.Phys
  , FireDAC.Phys.Intf
  , FireDAC.Phys.SQLite
  , FireDAC.Phys.SQLiteDef
  , FireDAC.Phys.SQLiteWrapper.Stat
  , FireDAC.Stan.Async
  , FireDAC.Stan.Def
  , FireDAC.Stan.Error
  , FireDAC.Stan.ExprFuncs
  , FireDAC.Stan.Intf
  , FireDAC.Stan.Option
  , FireDAC.Stan.Param
  , FireDAC.Stan.Pool
  , FireDAC.UI.Intf
  , FireDAC.VCLUI.Wait

  , System.Classes
  , System.SysUtils

  ;


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
    qryStores: TFDQuery;
    qryStoresid: TFDAutoIncField;
    qryStoresname: TWideStringField;
    qryStorescountryCode: TWideStringField;
    qryStoresdomain: TWideStringField;
    sourceStores: TDataSource;
    qryUnavailable: TFDQuery;
    qryAllEditions: TFDQuery;
    qryAvailableStores: TFDQuery;
    sourceAllEditions: TDataSource;
    sourceAvailableStores: TDataSource;
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
  qryStores.Open;
  qryUnavailable.Open;
end;

procedure TDbManager.DataModuleDestroy(Sender: TObject);
begin
  qryUnavailable.Close;
  qryEditions.Close;
  qryBooks.Close;
  qryStores.Close;
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
