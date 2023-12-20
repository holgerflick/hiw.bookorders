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
    qryAllEditions: TFDQuery;
    qryUnavailableStores: TFDQuery;
    sourceAllEditions: TDataSource;
    qryAllEditionsid: TFDAutoIncField;
    qryAllEditionsname: TWideStringField;
    qryAllEditionstitle: TWideStringField;
    qryAllEditionssubtitle: TWideStringField;
    qryUnavailableStoresid: TFDAutoIncField;
    comRemoveUnavail: TFDCommand;
    comAddUnavail: TFDCommand;
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

    procedure AddToUnavailable( AEditionId, AStoreId: Integer );
    procedure RemoveFromUnavailable( AEditionId, AStoreId: Integer );

    procedure SaveToMarkdown(AFilename: String);
  end;

implementation

uses
  UAppGlobals
  ;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDbManager }

procedure TDbManager.AddToUnavailable(AEditionId, AStoreId: Integer);
begin
  comAddUnavail.ParamByName('editionId').AsInteger := AEditionId;
  comAddUnavail.ParamByName('storeId').AsInteger := AStoreId;
  comAddUnavail.Execute;
end;

procedure TDbManager.DataModuleCreate(Sender: TObject);
begin
  Connection.Params.Database := TAppGlobals.DatabaseFilename;

  qryBooks.Open;
  qryEditions.Open;
  qryStores.Open;
  qryAllEditions.Open;
  qryUnavailableStores.Open;
end;

procedure TDbManager.DataModuleDestroy(Sender: TObject);
begin
  qryUnavailableStores.Close;
  qryEditions.Close;
  qryBooks.Close;
  qryStores.Close;
  qryAllEditions.Close;
end;

class destructor TDbManager.Destroy;
begin
  FInstance.Free;
end;

procedure TDbManager.RemoveFromUnavailable(AEditionId, AStoreId: Integer);
begin
  comRemoveUnavail.ParamByName('editionId').AsInteger := AEditionId;
  comRemoveUnavail.ParamByName('storeId').AsInteger := AStoreId;
  comRemoveUnavail.Execute;
end;

procedure TDbManager.SaveToMarkdown(AFilename: String);
const
  MD_SEP_CENTER = ' :---: |';
  MD_SEP_LEFT = ' :--- |';

var
  LLines: TStringList;
  LBookmark: TBookmark;

begin
  LLines := TStringList.Create;

  try
    // TODO: add enable/disable controls
    // TODO: add bookmarks

    qryBooks.First;

    while not qryBooks.Eof do
    begin
      LLines.Add( '# ' + qryBookstitle.AsString );
      if not qryBookssubtitle.AsString.IsEmpty then
      begin
        LLines.Add( '*' + qryBookssubtitle.AsString + '*' );
      end;

      var LBuffer := '| Store | ';
      var LSep := '|' + MD_SEP_LEFT;

      qryEditions.First;
      while not qryEditions.Eof do
      begin
        LBuffer := LBuffer + qryEditionsname.AsString + ' | ';
        LSep := LSep + MD_SEP_CENTER;
        qryEditions.Next;
      end;

      LLines.Add('');
      LLines.Add(LBuffer);
      LLines.Add(LSep);

      qryStores.First;
      while not qryStores.Eof do
      begin
        LBuffer := '| ' + qryStoresname.AsString + ' | ';

        qryEditions.First;
        while not qryEditions.Eof do
        begin
          var LIsUnavailable := qryUnavailableStores.Locate( 'id',
            qryStoresid.AsInteger, [] );

          if not LIsUnavailable then
          begin
            LBuffer := LBuffer +
              Format( '[:flag_%s:](https://www.amazon%s/dp/%s)',
                [ qryStorescountryCode.AsString,
                  qryStoresdomain.AsString,
                  qryEditionsasin.AsString]
                );
          end;

          LBuffer := LBuffer + ' | ';

          qryEditions.Next;
        end;

        LLines.Add(LBuffer);

        qryStores.Next;
      end;

      LLines.Add('');
      qryBooks.Next;
    end;

    LLines.SaveToFile(AFilename);
  finally
    LLines.Free;
  end;
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
