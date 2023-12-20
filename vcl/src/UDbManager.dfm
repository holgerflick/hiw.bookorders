object DbManager: TDbManager
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 201
  Width = 412
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
end
