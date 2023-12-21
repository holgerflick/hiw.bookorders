unit UFrmBooks;

interface

uses
    Data.DB

  , System.Classes
  , System.SysUtils
  , System.Variants

  , Vcl.Buttons
  , Vcl.Controls
  , Vcl.DBCtrls
  , Vcl.DBGrids
  , Vcl.Dialogs
  , Vcl.ExtCtrls
  , Vcl.Forms
  , Vcl.Graphics
  , Vcl.Grids

  , Winapi.Messages
  , Winapi.Windows

  , hyiedefs
  , hyieutils
  , iexBitmaps
  , iesettings
  , iexLayers
  , iexRulers
  , iexToolbars
  , iexUserInteractions
  , imageenio
  , imageenproc
  , iexProcEffects
  , ieview
  , imageenview
  , ieopensavedlg
  , iexDBBitmaps

  ;

type
  TFrmBooks = class(TForm)
    Books: TDBGrid;
    Navigator: TDBNavigator;
    DlgOpenImage: TOpenImageEnDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Cover: TImageEnView;
    Splitter1: TSplitter;
    Editions: TDBGrid;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure CoverDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FCoverImage: TIEDBBitmap;

    procedure SetupDatasources;
    procedure LoadImage;

  public
    { Public declarations }
    class procedure Display;
  end;

implementation

uses
  UDbManager
  ;

{$R *.dfm}

procedure TFrmBooks.CoverDblClick(Sender: TObject);
begin
  LoadImage;
end;

class procedure TFrmBooks.Display;
begin
  var LFrm := TFrmBooks.Create(nil);
  try
    LFrm.ShowModal;
  finally
    LFrm.Free;
  end;
end;

procedure TFrmBooks.FormCreate(Sender: TObject);
begin
  SetupDatasources;
end;

procedure TFrmBooks.FormDestroy(Sender: TObject);
begin
  FCoverImage.Free;
end;

procedure TFrmBooks.LoadImage;
var
  LDs: TDataSet;

begin
  if DlgOpenImage.Execute then
  begin
    LDs := Books.DataSource.DataSet;
    if not (LDs.State in dsEditModes) then
    begin
      LDs.Edit;
    end;

    TBlobField( Lds.FieldByName('Cover') ).LoadFromFile(DlgOpenImage.FileName);
    LDs.Post;
  end;
end;

procedure TFrmBooks.SetupDatasources;
begin
  var LManager := TDbManager.Shared;

  Navigator.DataSource := LManager.sourceBooks;
  Books.DataSource := LManager.sourceBooks;

  // set up image field
  FCoverImage := TIEDBBitmap.Create(
    LManager.sourceBooks,
    'Cover',
    '' );
  Cover.SetExternalBitmap(FCoverImage);

  Editions.DataSource := LManager.sourceEditions;
end;

end.
