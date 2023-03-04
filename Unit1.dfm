object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 567
  ClientWidth = 903
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Button1: TButton
    Left = 792
    Top = 509
    Width = 92
    Height = 50
    Caption = 'Escutar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 903
    Height = 378
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    TabOrder = 1
    OnChange = RichEdit1Change
    ExplicitWidth = 628
  end
  object btnSalvar: TButton
    Left = 680
    Top = 509
    Width = 89
    Height = 50
    Caption = 'Salvar'
    TabOrder = 2
    OnClick = btnSalvarClick
  end
  object btnCopiar: TButton
    Left = 568
    Top = 509
    Width = 89
    Height = 50
    Caption = 'Copiar'
    TabOrder = 3
    OnClick = btnCopiarClick
  end
end
