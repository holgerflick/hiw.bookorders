unit UFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

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
  UFrmBooks
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

end;

end.
