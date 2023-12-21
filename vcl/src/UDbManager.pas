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
    qryAllEditionsgridTitle: TWideStringField;
    qryBookspublished: TDateField;
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
    procedure SaveToJson(AFilename: String);
  end;

implementation

uses
    UTypes
  , UAppGlobals

  , System.IOUtils
  , System.TypInfo

  , Neon.Core.Persistence.JSON
  , Neon.Core.Persistence
  , Neon.Core.Types
  , Neon.Core.Utils

  , hyiedefs
  , hyieutils
  , iexBitmaps
  , iexDBBitmaps
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

procedure TDbManager.SaveToJson(AFilename: String);
var
 LPayload: TPayload;

begin
  LPayload := TPayload.Create;
  try
    qryStores.First;
    while not qryStores.eof do
    begin
      var LStore := TStoreDTO.Create;
      LStore.Id := qryStoresId.AsInteger;
      LStore.Name := qryStoresname.AsString;
      LStore.Domain := qryStoresdomain.AsString;
      LStore.CountryIso := qryStorescountryCode.AsString;

      LPayload.Stores.Add( LStore );

      qryStores.Next;
    end;


    qryBooks.First;
    while not qryBooks.Eof do
    begin
      var LBook := TBookDTO.Create;
      LBook.Id := qryBooksId.AsInteger;
      LBook.Title := qryBookstitle.AsString;
      LBook.Subtitle := qryBookssubtitle.AsString;

      if not qryBooksCover.IsNull then
      begin
        var LCover := TIEDBBitmap.Create;
        try
          LCover.Read( qryBooksCover );
          LCover.Resample( 500, -1, rfLanczos3  );

          LBook.Cover.Clear;
          LCover.Write(LBook.Cover, ioPNG );
        finally
          LCover.Free;
        end;
      end;

      qryEditions.First;
      while not qryEditions.Eof do
      begin
        var LEdition := TEditionDTO.Create;
        LEdition.Id := qryEditionsId.AsInteger;
        LEdition.Name := qryEditionsname.AsString;
        LEdition.AmazonId := qryEditionsasin.AsString;

        qryAllEditions.Locate('id', qryEditionsid.AsInteger, [] );

        for var LStore in LPayload.Stores do
        begin
          var LIsUnavailable := qryUnavailableStores.Locate('id', LStore.Id, [] );

          if not LIsUnavailable then
          begin
            LEdition.Stores.Add(LStore.Id);
          end;
        end;

        LBook.Editions.Add(LEdition);

        qryEditions.Next;
      end;

      LPayload.Books.Add(LBook);

      qryBooks.Next;
    end;
    var LConfig := TNeonConfiguration.Default
      .SetMemberCase(TNeonCase.CamelCase)
      .SetMembers([TNeonMembers.Properties])
      .SetVisibility([mvPublished])
      ;

    var LJSON := TNeon.ObjectToJSONString(LPayload, LConfig);
    TFile.WriteAllText(AFilename, LJSON);
  finally
    LPayload.Free;
  end;
end;

procedure TDbManager.SaveToMarkdown(AFilename: String);
const
  MD_SEP_CENTER = ' :---: |';
  MD_SEP_LEFT = ' :--- |';

var
  LLines: TStringList;

begin
  LLines := TStringList.Create;

  try
    // TODO: add enable/disable controls
    // TODO: add bookmarks

    qryBooks.First;

    var LHeader :=
    '''
    ---
    title: List of all books
    tags:
       - Delphi
    ---
    ''';

    LLines.Add(LHeader);
    LLines.Add('# List of all books');

    while not qryBooks.Eof do
    begin
      LLines.Add( '## ' + qryBookstitle.AsString );
      if not qryBookssubtitle.AsString.IsEmpty then
      begin
        LLines.Add( '### ' + qryBookssubtitle.AsString  );
      end;

      if not qryBookscover.IsNull then
      begin
        // cover
        var LDataURL := 'data:png/image;base64,';

        var LCover := TIEDBBitmap.Create;
        try
          LCover.Read(qryBookscover);

          LCover.Resample(250, -1, rfLanczos3);

          var LOutput := TMemoryStream.Create;
          try
            LCover.Write(LOutput, ioPNG);

            LOutput.Position := 0;
            LDataUrl := LDataUrl + TBase64.Encode(LOutput);
          finally
            LOutput.Free;
          end;
        finally
          LCover.Free;
        end;

        LLines.Add('![Cover image](' + LDataUrl + ')');
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
          // navigate in qryAllEditions as that is linked to qryUnavailableStores
          qryAllEditions.Locate('id', qryEditionsId.AsInteger, [] );

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
