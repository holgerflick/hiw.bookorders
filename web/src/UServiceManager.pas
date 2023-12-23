unit UServiceManager;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Modules, WEBLib.REST, UTypes;

type
  TServiceManager = class(TWebDataModule)
    Request: TWebHttpRequest;
    procedure WebDataModuleCreate(Sender: TObject);
  private
    FPayload: TPayload;

    FOnBooksReady: TNotifyEvent;
    { Private declarations }

    procedure ProcessResponse(AContent: JSValue);
  public
    { Public declarations }

    procedure RequestBooks;

    property OnBooksReady: TNotifyEvent read FOnBooksReady write FOnBooksReady;
  end;



implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServiceManager }

procedure TServiceManager.ProcessResponse(AContent: JSValue);
var
  LStoresArr: TJSArray;
  LStoreObj: TJSObject;

  LRoot: TJSObject;
  LStore: TStoreDTO;

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



  console.log(FPayload);
end;

procedure TServiceManager.RequestBooks;
begin
  Request.Execute(
    procedure(AResponse: string; ARequest: TJSXMLHttpRequest)
    begin
      ProcessResponse(ARequest.response);
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

end.
