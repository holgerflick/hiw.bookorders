object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Manage Book orders'
  ClientHeight = 418
  ClientWidth = 703
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 20
  object btnBooks: TButton
    Left = 24
    Top = 16
    Width = 105
    Height = 89
    Caption = 'Books'
    TabOrder = 0
    OnClick = btnBooksClick
  end
  object btnStores: TButton
    Left = 135
    Top = 16
    Width = 105
    Height = 89
    Caption = 'Stores'
    TabOrder = 1
    OnClick = btnStoresClick
  end
  object btnAvail: TButton
    Left = 246
    Top = 16
    Width = 105
    Height = 89
    Caption = 'Availability'
    TabOrder = 2
  end
end
