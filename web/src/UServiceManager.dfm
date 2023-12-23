object ServiceManager: TServiceManager
  OnCreate = WebDataModuleCreate
  Height = 231
  Width = 362
  object Request: TWebHttpRequest
    ResponseType = rtJSON
    URL = 'https://www.holgerscode.com/json/books.json'
    Left = 64
    Top = 48
  end
end
