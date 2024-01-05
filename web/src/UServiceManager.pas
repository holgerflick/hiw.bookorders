unit UServiceManager;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Modules, WEBLib.REST, UTypes;

type
  TServiceManager = class(TWebDataModule)
    Request: TWebHttpRequest;
    procedure WebDataModuleCreate(Sender: TObject);
    procedure WebDataModuleDestroy(Sender: TObject);
  private
    FPayload: TPayload;

    FOnBooksReady: TNotifyEvent;
    { Private declarations }

    procedure ProcessResponse(AContent: JSValue);
  public
    { Public declarations }

    procedure RequestBooks;
    function GetStoreById( AId: Integer ): TStoreDTO;

    property OnBooksReady: TNotifyEvent read FOnBooksReady write FOnBooksReady;
    property Payload: TPayload read FPayload;
  end;



implementation

uses
  Bcl.Utils
  ;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServiceManager }

function TServiceManager.GetStoreById(AId: Integer): TStoreDTO;
var
  i: Integer;
begin
  Result := nil;
  i := 0;
  while i< Payload.Stores.Count  do
  begin
    if Payload.Stores[i].Id = AId then
    begin
      Result := Payload.Stores[i];
      Exit;
    end;

    Inc(i);
  end;
end;

procedure TServiceManager.ProcessResponse(AContent: JSValue);
var
  LEncoded: String;
  LBytes: TBytesStream;

  LStoresArr: TJSArray;
  LStoreObj: TJSObject;

  LBooksArr: TJSArray;
  LBookObj: TJSObject;

  LStoreIds: TJSArray;

  LEditionsArr: TJSArray;
  LEditionObj: TJSObject;

  LRoot: TJSObject;
  LStore: TStoreDTO;
  LBook: TBookDTO;
  LEdition: TEditionDTO;
  k,
  j,
  i: Integer;
begin
  FPayload.Free;

  FPayload := TPayload.Create;

  // look at stores

  LRoot := TJSObject( AContent );
  LStoresArr := TJSArray( LRoot['stores'] );

  for i := 0 to LStoresArr.Length -1 do
  begin
    LStoreObj := TJSObject( LStoresArr[i] );
    LStore := TStoreDTO.Create;
    LStore.Id := JS.toInteger( LStoreObj['id'] );
    LStore.Domain := JS.toString( LStoreObj['domain'] );
    LStore.CountryIso := JS.toString( LStoreObj['countryIso'] );
    LStore.Name := JS.toString( LStoreObj['name'] );

    FPayload.Stores.Add(LStore);
  end;

  LBooksArr := TJSArray( LRoot['books'] );

  for i := 0 to LBooksArr.Length -1 do
  begin
    LBookObj := TJSObject( LBooksArr[i] );
    LBook := TBookDTO.Create;
    LBook.Id := JS.toInteger( LBookObj['id'] );
    LBook.PubDate := TBclUtils.ISOToDate( JS.toString( LBookObj['pubDate'] ) );
    LBook.Title := JS.toString( LBookObj['title'] );
    LBook.Subtitle := JS.toString( LBookObj['subtitle'] );
    LBook.Description := JS.toString( LBookObj['description'] );

    LEncoded := JS.toString( LBookObj['cover'] );
    if LEncoded <> '' then
    begin
       LEncoded := 'data:image/jpeg;base64,' + LEncoded;
       LBook.CoverDataUrl := LEncoded;
    end;

    // editions
    LEditionsArr := TJSArray( LBookObj['editions'] );
    for j := 0 to LEditionsArr.Length - 1 do
    begin
      LEdition := TEditionDTO.Create;
      LEditionObj := TJSObject( LEditionsArr[j] );
      LEdition.Id := JS.toInteger( LEditionObj['id'] );
      LEdition.Name := JS.toString( LEditionObj['name'] );
      LEdition.AmazonId := JS.toString( LEditionObj['amazonId'] );

      LStoreIds := TJSArray( LEditionObj['stores'] );
      for k := 0 to LStoreIds.Length -1 do
      begin
        LEdition.Stores.Add( JS.toInteger( LStoreIds[k] ) );
      end;

      LBook.Editions.Add(LEdition);
    end;


    FPayload.Books.Add(LBook);
  end;

  // console.log(FPayload);
end;

procedure TServiceManager.RequestBooks;
begin
  Request.Execute(
    procedure(AResponse: string; ARequest: TJSXMLHttpRequest)
    begin
      ProcessResponse(ARequest.response);

      if Assigned( FOnBooksReady ) then
      begin
        FOnBooksReady(Self);
      end;
    end,
    procedure(ARequest: TJSXMLHttpRequest)
    begin
      // error!
    end
    );
end;



procedure TServiceManager.WebDataModuleCreate(Sender: TObject);
begin
  FPayload := nil;
end;

procedure TServiceManager.WebDataModuleDestroy(Sender: TObject);
begin
  FPayload.Free;
end;

end.
