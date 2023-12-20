object FrmBooks: TFrmBooks
  Left = 0
  Top = 0
  Caption = 'Manage books  and editions'
  ClientHeight = 420
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  DesignSize = (
    764
    420)
  TextHeight = 20
  object Books: TDBGrid
    Left = 8
    Top = 40
    Width = 748
    Height = 217
    Anchors = [akLeft, akTop, akRight, akBottom]
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
      end>
  end
  object Cover: TDBImage
    Left = 8
    Top = 272
    Width = 161
    Height = 140
    Anchors = [akLeft, akBottom]
    DataField = 'cover'
    DataSource = DbManager.sourceBooks
    TabOrder = 1
    ExplicitTop = 240
  end
  object Editions: TDBGrid
    Left = 175
    Top = 272
    Width = 581
    Height = 140
    Anchors = [akLeft, akRight, akBottom]
    DataSource = DbManager.sourceEditions
    TabOrder = 2
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
  object Navigator: TDBNavigator
    Left = 8
    Top = 8
    Width = 745
    Height = 25
    VisibleButtons = [nbFirst, nbLast, nbDelete, nbPost, nbCancel]
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    ExplicitWidth = 740
  end
end
