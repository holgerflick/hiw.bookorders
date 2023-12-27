object FrmOrder: TFrmOrder
  Width = 640
  Height = 412
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  OnCreate = WebFormCreate
  object imgCover: TWebImageControl
    Left = 24
    Top = 211
    Width = 161
    Height = 193
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    ChildOrder = 4
  end
  object cbTitles: TWebComboBox
    Left = 24
    Top = 32
    Width = 585
    Height = 23
    ElementClassName = 'form-select'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    Text = 'cbTitles'
    WidthPercent = 100.000000000000000000
    OnClick = cbTitlesClick
    ItemIndex = -1
  end
  object cbEditions: TWebComboBox
    Left = 24
    Top = 80
    Width = 585
    Height = 23
    ElementClassName = 'form-select'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    Text = 'cbTitles'
    WidthPercent = 100.000000000000000000
    OnClick = cbEditionsClick
    ItemIndex = -1
  end
  object cbStores: TWebComboBox
    Left = 24
    Top = 128
    Width = 585
    Height = 23
    ElementClassName = 'form-select'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    Text = 'cbTitles'
    WidthPercent = 100.000000000000000000
    OnClick = cbStoresClick
    ItemIndex = -1
  end
  object btnGo: TWebButton
    Left = 416
    Top = 176
    Width = 193
    Height = 33
    Caption = 'Go to Amazon'
    ChildOrder = 3
    ElementClassName = 'btn btn-success'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = btnGoClick
  end
end
