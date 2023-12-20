unit UAppGlobals;

interface

type
  TAppGlobals = class
    class function DatabaseFilename: String;

  end;

implementation

uses
  System.IOUtils
  ;

{ TAppGlobals }

class function TAppGlobals.DatabaseFilename: String;
begin
  Result := TPath.Combine(
    TPath.GetLibraryPath,
    'books.db'
  );
end;

end.
