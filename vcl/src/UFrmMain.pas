unit UFrmMain;

interface

uses
    System.Classes
  , System.SysUtils
  , System.Variants

  , Vcl.Controls
  , Vcl.Dialogs
  , Vcl.Forms
  , Vcl.Graphics
  , Vcl.StdCtrls

  , Winapi.Messages
  , Winapi.Windows

  ;


type
  TFrmMain = class(TForm)
    btnBooks: TButton;
    btnStores: TButton;
    btnAvail: TButton;
    procedure btnBooksClick(Sender: TObject);
    procedure btnStoresClick(Sender: TObject);
  private
    { Private declarations }
    procedure ShowBooks;
    procedure ShowStores;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
    UFrmStores
  , UFrmBooks
  ;

{$R *.dfm}

procedure TFrmMain.btnBooksClick(Sender: TObject);
begin
  ShowBooks;
end;

procedure TFrmMain.btnStoresClick(Sender: TObject);
begin
  ShowStores;
end;

procedure TFrmMain.ShowBooks;
begin
  TFrmBooks.Display;
end;

procedure TFrmMain.ShowStores;
begin
  TFrmStores.Display;
end;

end.
