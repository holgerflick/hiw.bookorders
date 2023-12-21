object FrmBooks: TFrmBooks
  Left = 0
  Top = 0
  Caption = 'Manage books  and editions'
  ClientHeight = 610
  ClientWidth = 952
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 20
  object Splitter2: TSplitter
    Left = 0
    Top = 248
    Width = 952
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 64
  end
  object Books: TDBGrid
    Left = 0
    Top = 31
    Width = 952
    Height = 217
    Align = alTop
    DataSource = DbManager.sourceBooks
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'title'
        Width = 297
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'subtitle'
        Width = 353
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'published'
        Visible = True
      end>
  end
  object Navigator: TDBNavigator
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 946
    Height = 25
    VisibleButtons = [nbFirst, nbLast, nbDelete, nbPost, nbCancel]
    Align = alTop
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 251
    Width = 952
    Height = 359
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 225
      Top = 0
      Height = 359
      ExplicitLeft = 408
      ExplicitTop = 24
      ExplicitHeight = 100
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 225
      Height = 359
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Cover: TImageEnView
        Left = 0
        Top = 0
        Width = 225
        Height = 359
        Align = alClient
        TabOrder = 0
        OnDblClick = CoverDblClick
        AutoShrink = True
      end
    end
    object Editions: TDBGrid
      Left = 228
      Top = 0
      Width = 261
      Height = 359
      Align = alLeft
      DataSource = DbManager.sourceEditions
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'name'
          Width = 352
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'asin'
          Title.Caption = 'ASIN'
          Visible = True
        end>
    end
  end
  object DlgOpenImage: TOpenImageEnDialog
    ZoomFilter = rfLanczos3
    Left = 432
    Top = 160
  end
end
