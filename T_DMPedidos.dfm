object DMPedidos: TDMPedidos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 308
  Width = 475
  object qryPedidos: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'NUMERO_PEDIDO'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT P.*'
      '     , C.NOME AS CLIENTE_NOME'
      'FROM PEDIDOS P'
      '    LEFT JOIN CLIENTES C ON C.CODIGO = P.CLIENTE'
      'WHERE P.NUMERO_PEDIDO = :NUMERO_PEDIDO')
    SQLConnection = DMCon.Conexao
    Left = 40
    Top = 24
    object qryPedidosNUMERO_PEDIDO: TIntegerField
      FieldName = 'NUMERO_PEDIDO'
      Required = True
    end
    object qryPedidosDATA_EMISSAO: TSQLTimeStampField
      FieldName = 'DATA_EMISSAO'
    end
    object qryPedidosCLIENTE: TIntegerField
      FieldName = 'CLIENTE'
    end
    object qryPedidosVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 18
      Size = 2
    end
    object qryPedidosCLIENTE_NOME: TStringField
      FieldName = 'CLIENTE_NOME'
      Size = 250
    end
  end
  object dspPedidos: TDataSetProvider
    DataSet = qryPedidos
    Left = 144
    Top = 24
  end
  object cdsPedidos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPedidos'
    AfterClose = cdsPedidosAfterClose
    AfterInsert = cdsPedidosAfterInsert
    AfterScroll = cdsPedidosAfterScroll
    Left = 248
    Top = 24
    object cdsPedidosNUMERO_PEDIDO: TIntegerField
      FieldName = 'NUMERO_PEDIDO'
      Required = True
    end
    object cdsPedidosDATA_EMISSAO: TSQLTimeStampField
      FieldName = 'DATA_EMISSAO'
    end
    object cdsPedidosCLIENTE: TIntegerField
      FieldName = 'CLIENTE'
    end
    object cdsPedidosVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 18
      Size = 2
    end
    object cdsPedidosCLIENTE_NOME: TStringField
      FieldName = 'CLIENTE_NOME'
      Size = 250
    end
  end
  object dsPedidos: TDataSource
    DataSet = cdsPedidos
    Left = 352
    Top = 24
  end
  object qryPedidosItens: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'numero_pedido'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select i.*'
      '     , p.descricao as produto_descricao'
      'from pedidos_itens i'
      '    left join produtos p on p.codigo = i.produto'
      'where i.numero_pedido = :numero_pedido')
    SQLConnection = DMCon.Conexao
    Left = 40
    Top = 80
    object qryPedidosItensID_PEDIDOS_ITENS: TIntegerField
      FieldName = 'ID_PEDIDOS_ITENS'
      Required = True
    end
    object qryPedidosItensNUMERO_PEDIDO: TIntegerField
      FieldName = 'NUMERO_PEDIDO'
    end
    object qryPedidosItensPRODUTO: TIntegerField
      FieldName = 'PRODUTO'
    end
    object qryPedidosItensQTD: TIntegerField
      FieldName = 'QTD'
    end
    object qryPedidosItensVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      Precision = 18
      Size = 2
    end
    object qryPedidosItensVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 18
      Size = 2
    end
    object qryPedidosItensPRODUTO_DESCRICAO: TStringField
      FieldName = 'PRODUTO_DESCRICAO'
      Size = 250
    end
  end
  object dspPedidosItens: TDataSetProvider
    DataSet = qryPedidosItens
    Left = 144
    Top = 80
  end
  object cdsPedidosItens: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPedidosItens'
    BeforeOpen = cdsPedidosItensBeforeOpen
    BeforeInsert = cdsPedidosItensBeforeInsert
    AfterInsert = cdsPedidosItensAfterInsert
    BeforeEdit = cdsPedidosItensBeforeEdit
    BeforePost = cdsPedidosItensBeforePost
    Left = 248
    Top = 80
    object cdsPedidosItensID_PEDIDOS_ITENS: TIntegerField
      FieldName = 'ID_PEDIDOS_ITENS'
      Required = True
    end
    object cdsPedidosItensNUMERO_PEDIDO: TIntegerField
      FieldName = 'NUMERO_PEDIDO'
    end
    object cdsPedidosItensPRODUTO: TIntegerField
      FieldName = 'PRODUTO'
    end
    object cdsPedidosItensQTD: TIntegerField
      FieldName = 'QTD'
    end
    object cdsPedidosItensVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      Precision = 18
      Size = 2
    end
    object cdsPedidosItensVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 18
      Size = 2
    end
    object cdsPedidosItensPRODUTO_DESCRICAO: TStringField
      FieldName = 'PRODUTO_DESCRICAO'
      Size = 250
    end
  end
  object dsPedidosItens: TDataSource
    DataSet = cdsPedidosItens
    Left = 352
    Top = 80
  end
  object qryLateral: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT P.NUMERO_PEDIDO'
      '     , P.DATA_EMISSAO'
      
        '     , CAST(C.CODIGO || '#39' - '#39' || C.NOME AS VARCHAR(300)) AS CLIE' +
        'NTE'
      'FROM PEDIDOS P'
      '    LEFT JOIN CLIENTES C ON C.CODIGO = P.CLIENTE'
      'ORDER BY P.NUMERO_PEDIDO')
    SQLConnection = DMCon.Conexao
    Left = 40
    Top = 136
    object qryLateralNUMERO_PEDIDO: TIntegerField
      FieldName = 'NUMERO_PEDIDO'
      Required = True
    end
    object qryLateralDATA_EMISSAO: TSQLTimeStampField
      FieldName = 'DATA_EMISSAO'
    end
    object qryLateralCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 300
    end
  end
  object dspLateral: TDataSetProvider
    DataSet = qryLateral
    Left = 144
    Top = 136
  end
  object cdsLateral: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLateral'
    AfterInsert = cdsPedidosAfterInsert
    AfterScroll = cdsPedidosAfterScroll
    Left = 248
    Top = 136
    object cdsLateralNUMERO_PEDIDO: TIntegerField
      FieldName = 'NUMERO_PEDIDO'
      Required = True
    end
    object cdsLateralDATA_EMISSAO: TSQLTimeStampField
      FieldName = 'DATA_EMISSAO'
    end
    object cdsLateralCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 300
    end
  end
  object dsLateral: TDataSource
    DataSet = cdsLateral
    Left = 352
    Top = 136
  end
end
