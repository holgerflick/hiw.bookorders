object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Manage Book orders'
  ClientHeight = 185
  ClientWidth = 375
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
    Height = 49
    Caption = 'Books'
    TabOrder = 0
    OnClick = btnBooksClick
  end
  object btnStores: TButton
    Left = 135
    Top = 16
    Width = 105
    Height = 49
    Caption = 'Stores'
    TabOrder = 1
    OnClick = btnStoresClick
  end
  object btnAvail: TButton
    Left = 246
    Top = 16
    Width = 105
    Height = 49
    Caption = 'Availability'
    TabOrder = 2
    OnClick = btnAvailClick
  end
  object btnMarkdown: TButton
    Left = 24
    Top = 80
    Width = 216
    Height = 49
    Caption = 'Save as Markdown...'
    TabOrder = 3
    OnClick = btnMarkdownClick
  end
  object DlgSave: TFileSaveDialog
    DefaultExtension = 'md'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Markdown (*.md)'
        FileMask = '*.md'
      end>
    Options = [fdoOverWritePrompt, fdoPathMustExist]
    Title = 'Save as Markdown'
    Left = 264
    Top = 96
  end
end
