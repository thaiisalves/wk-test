object TBaseCadastro: TTBaseCadastro
  Left = 0
  Top = 0
  Caption = 'Cadastro de pedidos'
  ClientHeight = 481
  ClientWidth = 775
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    775
    481)
  PixelsPerInch = 96
  TextHeight = 14
  object pnLateral: TPanel
    Left = 588
    Top = 0
    Width = 187
    Height = 481
    Align = alRight
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvLowered
    TabOrder = 0
    object pnPesquisa: TPanel
      Left = 1
      Top = 1
      Width = 185
      Height = 141
      Align = alTop
      BevelOuter = bvNone
      Color = clMedGray
      ParentBackground = False
      TabOrder = 0
      object btnPesquisa: TSpeedButton
        Left = 0
        Top = 0
        Width = 185
        Height = 25
        Align = alTop
        Caption = 'Pesquisa'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 20
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnPesquisaClick
        ExplicitLeft = -5
        ExplicitTop = 9
      end
      object pnFiltro: TPanel
        Left = 0
        Top = 25
        Width = 185
        Height = 116
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          185
          116)
        object lblFiltroCampo: TLabel
          Left = 8
          Top = 8
          Width = 32
          Height = 14
          Caption = 'Filtro:'
        end
        object cbFiltroCampo: TComboBox
          Left = 46
          Top = 3
          Width = 139
          Height = 22
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          ItemIndex = 0
          TabOrder = 0
          Text = 'Filtro'
          Items.Strings = (
            'Filtro')
        end
        object cbFiltroComparacao: TComboBox
          Left = 8
          Top = 30
          Width = 177
          Height = 22
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          ItemIndex = 0
          TabOrder = 1
          Text = 'Igual a'
          Items.Strings = (
            'Igual a'
            'Diferente de'
            'Maior que'
            'Menor que'
            'Maior ou igual que'
            'Menor ou igual que'
            'Contenha'
            'N'#227'o contenha')
        end
        object edtFiltroValor: TEdit
          Left = 8
          Top = 56
          Width = 175
          Height = 22
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          OnKeyUp = edtFiltroValorKeyUp
        end
        object btnBuscar: TButton
          Left = 8
          Top = 84
          Width = 88
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Buscar'
          TabOrder = 3
        end
        object btnTodos: TButton
          Left = 101
          Top = 84
          Width = 82
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Todos'
          TabOrder = 4
        end
      end
    end
    object gbLateral: TGroupBox
      Left = 1
      Top = 142
      Width = 185
      Height = 338
      Align = alClient
      Caption = '(Clique duas vezes para exibir)'
      TabOrder = 1
      object grdLateral: TDBGrid
        Left = 2
        Top = 16
        Width = 181
        Height = 320
        Align = alClient
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Calibri'
        TitleFont.Style = []
      end
    end
  end
  object gbPrincipal: TGroupBox
    Left = 8
    Top = 47
    Width = 570
    Height = 426
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 1
  end
  object navPrincipal: TDBNavigator
    Left = 8
    Top = 8
    Width = 570
    Height = 33
    VisibleButtons = [nbInsert, nbDelete, nbPost, nbCancel, nbRefresh]
    ConfirmDelete = False
    TabOrder = 2
    BeforeAction = navPrincipalBeforeAction
    OnClick = navPrincipalClick
  end
end
