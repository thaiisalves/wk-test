object TPedidoItem: TTPedidoItem
  Left = 0
  Top = 0
  Caption = 'Item do pedido'
  ClientHeight = 176
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object gbItem: TGroupBox
    Left = 8
    Top = 47
    Width = 529
    Height = 116
    TabOrder = 0
    object lblProduto: TLabel
      Left = 11
      Top = 18
      Width = 110
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Produto:'
    end
    object lblQuantidade: TLabel
      Left = 11
      Top = 60
      Width = 110
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Quantidade:'
    end
    object lblValorUnitario: TLabel
      Left = 11
      Top = 88
      Width = 110
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Valor unit'#225'rio:'
    end
    object dbProdutoDescricao: TDBText
      Left = 127
      Top = 38
      Width = 395
      Height = 17
      DataField = 'PRODUTO_DESCRICAO'
      DataSource = DMPedidos.dsPedidosItens
    end
    object dbProduto: TDBEdit
      Left = 127
      Top = 15
      Width = 121
      Height = 21
      DataField = 'PRODUTO'
      DataSource = DMPedidos.dsPedidosItens
      TabOrder = 0
    end
    object dbQtd: TDBEdit
      Left = 127
      Top = 57
      Width = 121
      Height = 21
      DataField = 'QTD'
      DataSource = DMPedidos.dsPedidosItens
      TabOrder = 1
    end
    object dbValorUnitario: TDBEdit
      Left = 127
      Top = 84
      Width = 121
      Height = 21
      DataField = 'VALOR_UNITARIO'
      DataSource = DMPedidos.dsPedidosItens
      TabOrder = 2
    end
  end
  object navPrincipal: TDBNavigator
    Left = 8
    Top = 8
    Width = 528
    Height = 33
    DataSource = DMPedidos.dsPedidos
    VisibleButtons = [nbPost, nbCancel]
    ConfirmDelete = False
    TabOrder = 1
    OnClick = navPrincipalClick
  end
end
