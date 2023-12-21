object DbManager: TDbManager
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 503
  Width = 524
  object SQLite: TFDPhysSQLiteDriverLink
    EngineLinkage = slStatic
    Left = 40
    Top = 104
  end
  object Connection: TFDConnection
    Params.Strings = (
      'Database=D:\bookorders\bin\books.db'
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'Synchronous=Full'
      'JournalMode=Off'
      'StringFormat=Unicode'
      'DriverID=SQLite')
    ConnectedStoredUsage = []
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 40
  end
  object qryBooks: TFDQuery
    ActiveStoredUsage = []
    Connection = Connection
    SQL.Strings = (
      'SELECT * FROM books'
      '  ORDER BY published DESC')
    Left = 168
    Top = 40
    object qryBooksid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryBookstitle: TWideStringField
      DisplayLabel = 'Title'
      DisplayWidth = 150
      FieldName = 'title'
      Origin = 'title'
      FixedChar = True
      Size = 500
    end
    object qryBookssubtitle: TWideStringField
      DisplayLabel = 'Subtitle'
      DisplayWidth = 150
      FieldName = 'subtitle'
      Origin = 'subtitle'
      FixedChar = True
      Size = 500
    end
    object qryBookscover: TBlobField
      DisplayLabel = 'Cover Image'
      FieldName = 'cover'
      Origin = 'cover'
    end
    object qryBookspublished: TDateField
      DisplayLabel = 'PubDate'
      FieldName = 'published'
      Origin = 'published'
      EditMask = '!99/99/00;1;_'
    end
  end
  object qryEditions: TFDQuery
    ActiveStoredUsage = []
    MasterSource = sourceBooks
    MasterFields = 'id'
    DetailFields = 'booksId'
    Connection = Connection
    SQL.Strings = (
      'SELECT * FROM editions '
      '  WHERE booksId = :id')
    Left = 168
    Top = 112
    ParamData = <
      item
        Name = 'ID'
        DataType = ftAutoInc
        ParamType = ptInput
        Value = Null
      end>
    object qryEditionsid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryEditionsname: TWideStringField
      DisplayLabel = 'Name'
      FieldName = 'name'
      Origin = 'name'
      FixedChar = True
      Size = 100
    end
    object qryEditionsbooksId: TIntegerField
      FieldName = 'booksId'
      Origin = 'booksId'
    end
    object qryEditionsasin: TWideStringField
      FieldName = 'asin'
      Origin = 'asin'
    end
  end
  object sourceBooks: TDataSource
    DataSet = qryBooks
    Left = 248
    Top = 40
  end
  object sourceEditions: TDataSource
    DataSet = qryEditions
    Left = 248
    Top = 112
  end
  object qryStores: TFDQuery
    ActiveStoredUsage = []
    Connection = Connection
    SQL.Strings = (
      'SELECT * FROM stores')
    Left = 168
    Top = 184
    object qryStoresid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryStoresname: TWideStringField
      DisplayLabel = 'Name'
      FieldName = 'name'
      Origin = 'name'
      FixedChar = True
      Size = 50
    end
    object qryStorescountryCode: TWideStringField
      DisplayLabel = 'Country ISO Code'
      FieldName = 'countryCode'
      Origin = 'countryCode'
      FixedChar = True
      Size = 2
    end
    object qryStoresdomain: TWideStringField
      DisplayLabel = 'Domain suffix'
      FieldName = 'domain'
      Origin = 'domain'
      Size = 10
    end
  end
  object sourceStores: TDataSource
    DataSet = qryStores
    Left = 248
    Top = 184
  end
  object qryAllEditions: TFDQuery
    ActiveStoredUsage = []
    Connection = Connection
    SQL.Strings = (
      
        'SELECT e.id id, e.name, title,subtitle, (title || '#39' '#39' || subtitl' +
        'e) as gridTitle FROM editions e'
      '  LEFT JOIN books b ON e.booksId = b.id'
      '  ORDER BY title, subtitle')
    Left = 168
    Top = 256
    object qryAllEditionsid: TFDAutoIncField
      DisplayWidth = 10
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryAllEditionsname: TWideStringField
      DisplayLabel = 'Edition'
      DisplayWidth = 25
      FieldName = 'name'
      Origin = 'name'
      FixedChar = True
      Size = 100
    end
    object qryAllEditionstitle: TWideStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Title'
      DisplayWidth = 38
      FieldName = 'title'
      Origin = 'title'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 500
    end
    object qryAllEditionssubtitle: TWideStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Subtitle'
      DisplayWidth = 500
      FieldName = 'subtitle'
      Origin = 'subtitle'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 500
    end
    object qryAllEditionsgridTitle: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'gridTitle'
      Origin = 'gridTitle'
      ProviderFlags = []
      ReadOnly = True
      Size = 32767
    end
  end
  object qryUnavailableStores: TFDQuery
    ActiveStoredUsage = []
    MasterSource = sourceAllEditions
    MasterFields = 'id'
    DetailFields = 'id'
    Connection = Connection
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'SELECT s.id FROM stores s'
      '  JOIN unavailable u ON u.storeid = s.id AND u.editionid = :id '
      ''
      ' ')
    Left = 168
    Top = 320
    ParamData = <
      item
        Name = 'ID'
        DataType = ftAutoInc
        ParamType = ptInput
        Value = 8
      end>
    object qryUnavailableStoresid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
  end
  object sourceAllEditions: TDataSource
    DataSet = qryAllEditions
    Left = 264
    Top = 256
  end
  object comRemoveUnavail: TFDCommand
    Connection = Connection
    CommandText.Strings = (
      'DELETE FROM unavailable '
      '  WHERE (storeId = :storeId) AND (editionId = :editionId)')
    ActiveStoredUsage = []
    ParamData = <
      item
        Name = 'STOREID'
        ParamType = ptInput
      end
      item
        Name = 'EDITIONID'
        ParamType = ptInput
      end>
    Left = 408
    Top = 192
  end
  object comAddUnavail: TFDCommand
    Connection = Connection
    CommandText.Strings = (
      
        'INSERT INTO unavailable (storeId, editionId) VALUES (:storeId, :' +
        'editionId)')
    ActiveStoredUsage = []
    ParamData = <
      item
        Name = 'STOREID'
        ParamType = ptInput
      end
      item
        Name = 'EDITIONID'
        ParamType = ptInput
      end>
    Left = 408
    Top = 264
  end
end
