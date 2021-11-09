inherited TPedidos: TTPedidos
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnLateral: TPanel
    inherited pnPesquisa: TPanel
      inherited pnFiltro: TPanel
        inherited cbFiltroCampo: TComboBox
          Items.Strings = (
            'Filtro'
            'N'#250'mero do pedido'
            'C'#243'digo do cliente'
            'Nome do cliente')
        end
        inherited btnBuscar: TButton
          Height = 26
          OnClick = btnBuscarClick
          ExplicitHeight = 26
        end
        inherited btnTodos: TButton
          Width = 83
          OnClick = btnTodosClick
          ExplicitWidth = 83
        end
      end
    end
    inherited gbLateral: TGroupBox
      inherited grdLateral: TDBGrid
        DataSource = DMPedidos.dsLateral
        OnDblClick = grdLateralDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'NUMERO_PEDIDO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATA_EMISSAO'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CLIENTE'
            Width = 250
            Visible = True
          end>
      end
    end
  end
  inherited gbPrincipal: TGroupBox
    object pnNumeroPedido: TPanel
      Left = 147
      Top = 16
      Width = 135
      Height = 30
      BevelOuter = bvNone
      Color = clSilver
      ParentBackground = False
      TabOrder = 0
      object dbNumeroPedidoCabecalho: TDBText
        Left = 8
        Top = 8
        Width = 120
        Height = 15
        DataField = 'NUMERO_PEDIDO'
        DataSource = DMPedidos.dsPedidos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object pnEmissao: TPanel
      Left = 425
      Top = 16
      Width = 135
      Height = 30
      BevelOuter = bvNone
      Color = clSilver
      ParentBackground = False
      TabOrder = 1
      object dbDataEmissaoCabecalho: TDBText
        Left = 8
        Top = 8
        Width = 120
        Height = 15
        Alignment = taCenter
        DataField = 'DATA_EMISSAO'
        DataSource = DMPedidos.dsPedidos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object Panel1: TPanel
      Left = 8
      Top = 50
      Width = 135
      Height = 30
      BevelOuter = bvNone
      Color = clSilver
      ParentBackground = False
      TabOrder = 2
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 121
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Cliente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
    end
    object Panel2: TPanel
      Left = 147
      Top = 50
      Width = 413
      Height = 30
      BevelOuter = bvNone
      Color = clSilver
      ParentBackground = False
      TabOrder = 3
      object dbClienteNome: TDBText
        Left = 103
        Top = 9
        Width = 303
        Height = 17
        DataField = 'CLIENTE_NOME'
        DataSource = DMPedidos.dsPedidos
      end
      object dbClienteCodigo: TDBEdit
        Left = 8
        Top = 3
        Width = 89
        Height = 22
        DataField = 'CLIENTE'
        DataSource = DMPedidos.dsPedidos
        TabOrder = 0
      end
    end
    object pcPrincipal: TPageControl
      Left = 2
      Top = 86
      Width = 566
      Height = 297
      ActivePage = tsItens
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 4
      object tsItens: TTabSheet
        Caption = 'Itens do pedido'
        ImageIndex = 1
        DesignSize = (
          558
          268)
        object grdItens: TDBGrid
          Left = 35
          Top = 3
          Width = 518
          Height = 263
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = DMPedidos.dsPedidosItens
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Calibri'
          TitleFont.Style = []
          OnKeyUp = grdItensKeyUp
          Columns = <
            item
              Expanded = False
              FieldName = 'NUMERO_PEDIDO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRODUTO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRODUTO_DESCRICAO'
              Width = 250
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QTD'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR_UNITARIO'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR_TOTAL'
              Width = 90
              Visible = True
            end>
        end
        object navItens: TDBNavigator
          Left = 2
          Top = 2
          Width = 27
          Height = 192
          DataSource = DMPedidos.dsPedidosItens
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete]
          Kind = dbnVertical
          TabOrder = 1
          OnClick = navItensClick
        end
      end
    end
    object pnRodape: TPanel
      Left = 2
      Top = 383
      Width = 566
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 5
      object Panel4: TPanel
        Left = 7
        Top = 6
        Width = 445
        Height = 30
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          445
          30)
        object Label1: TLabel
          Left = 11
          Top = 8
          Width = 423
          Height = 15
          Alignment = taRightJustify
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = 'Valor total (R$):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 262
        end
      end
      object Panel5: TPanel
        Left = 457
        Top = 6
        Width = 100
        Height = 30
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 1
        DesignSize = (
          100
          30)
        object dbValorTotalPedido: TDBText
          Left = 7
          Top = 8
          Width = 82
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          DataField = 'VALOR_TOTAL'
          DataSource = DMPedidos.dsPedidos
          ExplicitWidth = 242
        end
      end
    end
    object Panel3: TPanel
      Left = 286
      Top = 16
      Width = 135
      Height = 30
      BevelOuter = bvNone
      Color = clSilver
      ParentBackground = False
      TabOrder = 6
      object lblDataEmissaoCabecalho: TLabel
        Left = 16
        Top = 8
        Width = 110
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Emiss'#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
    end
    object Panel6: TPanel
      Left = 8
      Top = 16
      Width = 135
      Height = 30
      BevelOuter = bvNone
      Color = clSilver
      ParentBackground = False
      TabOrder = 7
      object lblNumeroPedidoCabecalho: TLabel
        Left = 8
        Top = 8
        Width = 121
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'N'#250'mero do pedido:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
    end
  end
  inherited navPrincipal: TDBNavigator
    DataSource = DMPedidos.dsPedidos
    Hints.Strings = ()
  end
end
