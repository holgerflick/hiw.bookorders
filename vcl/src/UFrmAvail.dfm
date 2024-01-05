object FrmAvail: TFrmAvail
  Left = 0
  Top = 0
  Caption = 'Availability in stores'
  ClientHeight = 530
  ClientWidth = 861
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    861
    530)
  TextHeight = 20
  object Editions: TDBGrid
    Left = 8
    Top = 8
    Width = 845
    Height = 322
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DbManager.sourceAllEditions
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'gridTitle'
        Title.Caption = 'Title'
        Width = 484
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'name'
        Width = 302
        Visible = True
      end>
  end
  object Stores: TCheckListBox
    Left = 8
    Top = 336
    Width = 845
    Height = 186
    Anchors = [akLeft, akRight, akBottom]
    Columns = 3
    ItemHeight = 20
    TabOrder = 1
    OnClickCheck = StoresClickCheck
  end
  object sourceEditions: TDataSource
    Left = 88
    Top = 128
  end
end
