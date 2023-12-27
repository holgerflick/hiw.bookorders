unit UFrmOrder;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, UServiceManager, Vcl.StdCtrls, WEBLib.StdCtrls,
  Vcl.Controls, WEBLib.ExtCtrls;

type
  TFrmOrder = class(TWebForm)
    cbTitles: TWebComboBox;
    cbEditions: TWebComboBox;
    cbStores: TWebComboBox;
    btnGo: TWebButton;
    imgCover: TWebImageControl;
    procedure WebFormCreate(Sender: TObject);
    procedure cbTitlesClick(Sender: TObject);
    procedure cbEditionsClick(Sender: TObject);
    procedure cbStoresClick(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
  private
    { Private declarations }
    FManager: TServiceManager;

    procedure HideAll;
    procedure UpdateInterface;
    procedure UpdateEditions;
    procedure UpdateStores;
    procedure UpdateButton;
    procedure UpdateCover;

    procedure OnBooksReady(Sender: TObject);

  public
    { Public declarations }

  end;

var
  FrmOrder: TFrmOrder;

implementation

uses
  UTypes
  ;

{$R *.dfm}

procedure TFrmOrder.btnGoClick(Sender: TObject);
var
  LStore: TStoreDTO;
  LEdition: TEditionDTO;

  LUrl: String;

begin
   if (cbStores.ItemIndex > -1) AND (cbEditions.ItemIndex > -1) then
    begin
      LStore := cbStores.Items.Objects[cbStores.ItemIndex] as TStoreDTO;
      LEdition := cbEditions.Items.Objects[cbEditions.ItemIndex] as TEditionDTO;

      LUrl := 'https://www.amazon' + LStore.Domain + '/dp/' + LEdition.AmazonId;
      Application.Navigate( LUrl, ntBlank );
    end;
end;

procedure TFrmOrder.cbEditionsClick(Sender: TObject);
begin
  UpdateStores;
end;

procedure TFrmOrder.cbStoresClick(Sender: TObject);
begin
  UpdateButton;
end;

procedure TFrmOrder.cbTitlesClick(Sender: TObject);
begin
  UpdateEditions;
end;

procedure TFrmOrder.HideAll;
var
  i: Integer;
  c: TControl;
begin
  for i := 0 to self.ComponentCount -1 do
  begin
    if self.Components[i] is TControl then
    begin
      c := TControl( self.Components[i] );
      c.Visible := False;
    end;
  end;
end;

procedure TFrmOrder.OnBooksReady(Sender: TObject);
begin
  UpdateInterface;
end;

procedure TFrmOrder.UpdateButton;
begin
  btnGo.Visible := true;

  UpdateCover;
end;

procedure TFrmOrder.UpdateCover;
var
  LBook: TBookDTO;

begin
  if cbTitles.ItemIndex > -1 then
  begin
    LBook := cbTitles.Items.Objects[cbTitles.ItemIndex] as TBookDTO;

    if LBook.CoverDataUrl.IsEmpty = False then
    begin
      imgCover.URL := LBook.CoverDataUrl;
      imgCover.Visible := true;
    end;

  end;
end;

procedure TFrmOrder.UpdateEditions;
var
  LBook: TBookDTO;
  LEdition: TEditionDTO;
  i: Integer;

begin
  if cbTitles.ItemIndex <> -1 then
  begin
    UpdateCover;

    cbStores.Visible := False;
    btnGo.Visible := False;

    LBook := cbTitles.Items.Objects[ cbTitles.ItemIndex ] as TBookDTO;

    cbEditions.Items.Clear;
    for i := 0 to LBook.Editions.Count - 1 do
    begin
      LEdition := LBook.Editions[i];
      cbEditions.Items.AddObject(LEdition.Name, LEdition);
    end;

    cbEditions.Visible := cbEditions.Items.Count > 0;
    if cbEditions.Visible then
    begin
      cbEditions.ItemIndex := 0;
    end;
  end;

end;

procedure TFrmOrder.UpdateInterface;
var
  i: Integer;
  LBook: TBookDTO;
begin
  // init form with titles
  cbTitles.Items.Clear;
  for i := 0 to FManager.Payload.Books.Count - 1 do
  begin
    LBook := FManager.Payload.Books[i];

    cbTitles.Items.AddObject( LBook.Title, LBook );
  end;

  cbTitles.Visible := cbTitles.Items.Count > 0;
  if cbTitles.Visible then
  begin
    cbTitles.ItemIndex := 0;
    UpdateEditions;
  end;
end;

procedure TFrmOrder.UpdateStores;
var
  LEdition: TEditionDTO;
  i: Integer;
  LId: Integer;
  LStore: TStoreDTO;
begin
  if cbEditions.ItemIndex > -1 then
  begin
    LEdition := cbEditions.Items.Objects[ cbEditions.ItemIndex ] as TEditionDTO;

    cbStores.Items.Clear;
    for i := 0 to LEdition.Stores.Count -1 do
    begin
      LId := LEdition.Stores[i];

      // lookup store
      LStore := FManager.GetStoreById(LId);
      if Assigned( LStore ) then
      begin
        cbStores.Items.AddObject( LStore.Name, LStore );
      end;
    end;

    cbStores.Visible := cbStores.Items.Count > 0;
    if cbStores.Visible then
    begin
      cbStores.ItemIndex := 0;
    end;
  end;
end;

procedure TFrmOrder.WebFormCreate(Sender: TObject);
begin
  HideAll;

  FManager := TServiceManager.Create(Self);
  FManager.OnBooksReady := OnBooksReady;
  FManager.RequestBooks;
end;

end.