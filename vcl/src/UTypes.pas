unit UTypes;

interface

uses
    System.Generics.Collections
  , System.Classes
  , System.SysUtils

  , Vcl.Graphics
  ;

type
  TIdList = TList<Integer>;

  TStoreDTO = class
  private
    FName: String;
    FDomain: String;
    FCountryIso: String;
    FId: Integer;
  published
    property Id: Integer read FId write FId;
    property Name: String read FName write FName;
    property Domain: String read FDomain write FDomain;
    property CountryIso: String read FCountryIso write FCountryIso;
  end;
  TStoresDTO = TObjectList<TStoreDTO>;

  TEditionDTO = class
  private
    FName: String;
    FASIN: String;
    FStores: TIdList;
    FId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Id: Integer read FId write FId;
    property Name: String read FName write FName;
    property AmazonId: String read FASIN write FASIN;
    property Stores: TIdList read FStores;
  end;
  TEditionsDTO = TObjectList<TEditionDTO>;


  TBookDTO = class
  private
    FTitle: String;
    FSubtitle: String;
    FPubDate: TDate;
    FId: Integer;
    FEditions: TEditionsDTO;
    FCover: TMemoryStream;
  public
    constructor Create;
    destructor Destroy; override;

  published

    property Id: Integer read FId write FId;
    property PubDate: TDate read FPubDate write FPubDate;
    property Title: String read FTitle write FTitle;
    property Subtitle: String read FSubtitle write FSubtitle;
    property Cover: TMemoryStream read FCover write FCover;

    property Editions: TEditionsDTO read FEditions write FEditions;

  end;
  TBooksDTO = TObjectList<TBookDTO>;

  TPayload = class
  private
    FStores: TStoresDTO;
    FBooks: TBooksDTO;

  public
    constructor Create;
    destructor Destroy; override;
  published
    property Stores: TStoresDTO read FStores;
    property Books: TBooksDTO read FBooks;
  end;

implementation

{ TPayload }

constructor TPayload.Create;
begin
  inherited;

  FBooks := TBooksDTO.Create;
  FStores := TStoresDTO.Create;
end;

destructor TPayload.Destroy;
begin
  FStores.Free;
  FBooks.Free;

  inherited;
end;

{ TEditionDTO }

constructor TEditionDTO.Create;
begin
  inherited;

  FStores := TIdList.Create;
end;

destructor TEditionDTO.Destroy;
begin
  FStores.Free;
  inherited;
end;

{ TBookDTO }

constructor TBookDTO.Create;
begin
  inherited;

  FCover := TMemoryStream.Create;
  FEditions := TEditionsDTO.Create;
end;

destructor TBookDTO.Destroy;
begin
  FEditions.Free;
  FCover.Free;

  inherited;
end;

end.
