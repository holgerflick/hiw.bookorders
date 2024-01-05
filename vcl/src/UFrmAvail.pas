unit UFrmAvail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.UITypes, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.CheckLst;

type
  TFrmAvail = class(TForm)
    Editions: TDBGrid;
    Stores: TCheckListBox;
    sourceEditions: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure StoresClickCheck(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FAllEditions: TDataSet;

    FAllStores: TDataSet;
    FUnavailStores: TDataSet;

    FOnOldAfterScroll: TDataSetNotifyEvent;

    { Private declarations }
    procedure OnAfterScroll(Sender: TDataSet);

    procedure SetupDataSources;
    procedure UpdateCheckboxes;
    procedure ToggleStoreAvail;

    procedure Reopen;
  public
    { Public declarations }

    class procedure Display;
  end;

var
  FrmAvail: TFrmAvail;

implementation

uses
  UDbManager
  ;

{$R *.dfm}

class procedure TFrmAvail.Display;
begin
  var LFrm := TFrmAvail.Create(nil);
  try
    LFrm.ShowModal;
  finally
    LFrm.Free;
  end;
end;

procedure TFrmAvail.FormCreate(Sender: TObject);
begin
  SetupDataSources;
end;

procedure TFrmAvail.FormDestroy(Sender: TObject);
begin
  FAllEditions.AfterScroll := FOnOldAfterScroll;
end;

procedure TFrmAvail.OnAfterScroll(Sender: TDataSet);
begin
  UpdateCheckboxes;
end;

procedure TFrmAvail.Reopen;
begin
  FUnavailStores.Close;
  FUnavailStores.Open;
end;

procedure TFrmAvail.SetupDataSources;
begin
  FAllEditions := TDbManager.Shared.qryAllEditions;

  sourceEditions.DataSet := FAllEditions;
  Editions.DataSource := sourceEditions;

  FAllStores := TDbManager.Shared.qryStores;
  FUnavailStores := TDbManager.Shared.qryUnavailableStores;

  FOnOldAfterScroll := FAllEditions.AfterScroll;
  FAllEditions.AfterScroll := OnAfterScroll;

  Reopen;

  UpdateCheckboxes;
end;

procedure TFrmAvail.StoresClickCheck(Sender: TObject);
begin
  ToggleStoreAvail;
end;

procedure TFrmAvail.ToggleStoreAvail;
begin
  // remove from table if it is not checked, add to table if it is

  // Stores.checked is already flipped when the event is triggered...
  var LChecked := not Stores.Checked[ Stores.ItemIndex ];

  var LStoreId: Integer := Integer( Stores.Items.Objects[ Stores.ItemIndex ] );

  var LEditionId: Integer := FAllEditions.FieldByName('id').AsInteger;

  if not LChecked then
  begin
    // remove from unavailable table
    TDbManager.Shared.RemoveFromUnavailable( LEditionId, LStoreId );
  end
  else
  begin
    TDbManager.Shared.AddToUnavailable( LEditionId, LStoreId );
  end;
  Reopen;
  UpdateCheckboxes;
end;

procedure TFrmAvail.UpdateCheckboxes;
var
  LBookmark: TBookmark;

begin
  FAllStores.DisableControls;
  LBookmark := nil;

  try
    LBookmark := FAllStores.GetBookmark;

    FAllStores.First;

    Stores.Items.BeginUpdate;
    Stores.Items.Clear;

    while not FAllStores.Eof do begin

      var LIndex := Stores.Items.AddObject(
        FAllStores.FieldByName('Name').AsString,
        TObject( FAllStores.FieldByName('Id').AsInteger )
         );

      var LIsUnavail :=
        FUnavailStores.Locate('id', FAllStores.FieldByName('id').AsInteger, [] );

      Stores.Checked[LIndex] := NOT LIsUnavail;

      FAllStores.Next;
    end;

    FAllStores.GotoBookmark(LBookmark);
  finally
    FAllStores.FreeBookmark(LBookmark);
    FAllStores.EnableControls;
    Stores.Items.EndUpdate;
  end;
end;

end.
