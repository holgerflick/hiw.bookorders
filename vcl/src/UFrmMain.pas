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
    btnMarkdown: TButton;
    btnJSON: TButton;
    DlgSaveJson: TFileSaveDialog;
    DlgFolder: TFileOpenDialog;
    procedure btnBooksClick(Sender: TObject);
    procedure btnStoresClick(Sender: TObject);
    procedure btnAvailClick(Sender: TObject);
    procedure btnMarkdownClick(Sender: TObject);
    procedure btnJSONClick(Sender: TObject);
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
    UDbManager
  , UFrmAvail
  , UFrmStores
  , UFrmBooks
  ;

{$R *.dfm}

procedure TFrmMain.btnAvailClick(Sender: TObject);
begin
  TFrmAvail.Display;
end;

procedure TFrmMain.btnBooksClick(Sender: TObject);
begin
  ShowBooks;
end;

procedure TFrmMain.btnJSONClick(Sender: TObject);
begin
  if DlgSaveJson.Execute then
  begin
    TDbManager.Shared.SaveToJson(DlgSaveJson.FileName);
  end;
end;

procedure TFrmMain.btnMarkdownClick(Sender: TObject);
begin
  if DlgFolder.Execute then
  begin
    TDbManager.Shared.SaveToMarkdown(DlgFolder.FileName);
  end;
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
