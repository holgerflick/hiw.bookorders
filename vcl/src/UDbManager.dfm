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
      'SELECT * FROM books')
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
  object qryUnavailable: TFDQuery
    ActiveStoredUsage = []
    MasterSource = sourceEditions
    MasterFields = 'id'
    Connection = Connection
    SQL.Strings = (
      'SELECT * FROM unavailable WHERE editionId = :id ')
    Left = 168
    Top = 256
    ParamData = <
      item
        Name = 'ID'
        DataType = ftAutoInc
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryAllEditions: TFDQuery
    ActiveStoredUsage = []
    Active = True
    Connection = Connection
    SQL.Strings = (
      'SELECT e.id id, e.name, title,subtitle FROM editions e'
      '  LEFT JOIN books b ON e.booksId = b.id')
    Left = 152
    Top = 376
  end
  object qryAvailableStores: TFDQuery
    ActiveStoredUsage = []
    MasterSource = sourceAllEditions
    MasterFields = 'id'
    Connection = Connection
    SQL.Strings = (
      'SELECT s.id, s.name, s.countryCode, s.domain FROM stores s'
      
        '  LEFT JOIN unavailable u ON u.storeid = s.id AND u.editionid = ' +
        ':id '
      '  WHERE storeId IS NULL'
      ' ')
    Left = 152
    Top = 440
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 8
      end>
  end
  object sourceAllEditions: TDataSource
    DataSet = qryAllEditions
    Left = 248
    Top = 376
  end
  object sourceAvailableStores: TDataSource
    DataSet = qryAvailableStores
    Left = 248
    Top = 440
  end
end
