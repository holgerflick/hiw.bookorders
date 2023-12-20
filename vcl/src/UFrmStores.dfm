object FrmStores: TFrmStores
  Left = 0
  Top = 0
  Caption = 'Stores'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  DesignSize = (
    624
    441)
  TextHeight = 20
  object Stores: TDBGrid
    Left = 8
    Top = 39
    Width = 608
    Height = 394
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DbManager.sourceStores
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'name'
        Width = 224
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'countryCode'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'domain'
        Width = 121
        Visible = True
      end>
  end
  object Navigator: TDBNavigator
    Left = 8
    Top = 8
    Width = 605
    Height = 25
    VisibleButtons = [nbFirst, nbLast, nbDelete, nbPost, nbCancel]
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
end
