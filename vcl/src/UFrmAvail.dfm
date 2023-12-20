object FrmAvail: TFrmAvail
  Left = 0
  Top = 0
  Caption = 'Availability in stores'
  ClientHeight = 493
  ClientWidth = 743
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  DesignSize = (
    743
    493)
  TextHeight = 20
  object Editions: TDBGrid
    Left = 8
    Top = 8
    Width = 727
    Height = 301
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DbManager.sourceAllEditions
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
end
