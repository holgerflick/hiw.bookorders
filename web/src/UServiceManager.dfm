object ServiceManager: TServiceManager
  OnCreate = WebDataModuleCreate
  OnDestroy = WebDataModuleDestroy
  Height = 231
  Width = 362
  object Request: TWebHttpRequest
    ResponseType = rtJSON
    URL = 'https://www.holgerscode.com/json/books.json'
    Left = 88
    Top = 48
  end
end
