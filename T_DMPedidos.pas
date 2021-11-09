unit T_DMPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Data.FMTBcd,
  Data.DB, Datasnap.DBClient, Datasnap.Provider, Data.SqlExpr, Vcl.Forms;

type
  TDMPedidos = class(TDataModule)
    qryPedidos: TSQLQuery;
    dspPedidos: TDataSetProvider;
    cdsPedidos: TClientDataSet;
    dsPedidos: TDataSource;
    qryPedidosItens: TSQLQuery;
    dspPedidosItens: TDataSetProvider;
    cdsPedidosItens: TClientDataSet;
    dsPedidosItens: TDataSource;
    qryPedidosNUMERO_PEDIDO: TIntegerField;
    qryPedidosDATA_EMISSAO: TSQLTimeStampField;
    qryPedidosCLIENTE: TIntegerField;
    qryPedidosVALOR_TOTAL: TFMTBCDField;
    qryPedidosCLIENTE_NOME: TStringField;
    cdsPedidosNUMERO_PEDIDO: TIntegerField;
    cdsPedidosDATA_EMISSAO: TSQLTimeStampField;
    cdsPedidosCLIENTE: TIntegerField;
    cdsPedidosVALOR_TOTAL: TFMTBCDField;
    cdsPedidosCLIENTE_NOME: TStringField;
    qryPedidosItensID_PEDIDOS_ITENS: TIntegerField;
    qryPedidosItensNUMERO_PEDIDO: TIntegerField;
    qryPedidosItensPRODUTO: TIntegerField;
    qryPedidosItensQTD: TIntegerField;
    qryPedidosItensVALOR_UNITARIO: TFMTBCDField;
    qryPedidosItensVALOR_TOTAL: TFMTBCDField;
    qryPedidosItensPRODUTO_DESCRICAO: TStringField;
    cdsPedidosItensID_PEDIDOS_ITENS: TIntegerField;
    cdsPedidosItensNUMERO_PEDIDO: TIntegerField;
    cdsPedidosItensPRODUTO: TIntegerField;
    cdsPedidosItensQTD: TIntegerField;
    cdsPedidosItensVALOR_UNITARIO: TFMTBCDField;
    cdsPedidosItensVALOR_TOTAL: TFMTBCDField;
    cdsPedidosItensPRODUTO_DESCRICAO: TStringField;
    qryLateral: TSQLQuery;
    dspLateral: TDataSetProvider;
    cdsLateral: TClientDataSet;
    dsLateral: TDataSource;
    qryLateralNUMERO_PEDIDO: TIntegerField;
    qryLateralDATA_EMISSAO: TSQLTimeStampField;
    qryLateralCLIENTE: TStringField;
    cdsLateralNUMERO_PEDIDO: TIntegerField;
    cdsLateralDATA_EMISSAO: TSQLTimeStampField;
    cdsLateralCLIENTE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsPedidosItensBeforeOpen(DataSet: TDataSet);
    procedure cdsPedidosItensBeforePost(DataSet: TDataSet);
    procedure cdsPedidosAfterScroll(DataSet: TDataSet);
    procedure cdsPedidosItensBeforeEdit(DataSet: TDataSet);
    procedure cdsPedidosItensBeforeInsert(DataSet: TDataSet);
    procedure cdsPedidosItensAfterInsert(DataSet: TDataSet);
    procedure cdsPedidosAfterInsert(DataSet: TDataSet);
    procedure cdsPedidosAfterClose(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMPedidos: TDMPedidos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses funcoes, T_Pedidos;

{$R *.dfm}

procedure TDMPedidos.DataModuleCreate(Sender: TObject);
begin
  try
    qryPedidosCLIENTE_NOME.ProviderFlags            := [];
    qryPedidosItensPRODUTO_DESCRICAO.ProviderFlags  := [];

    cdsPedidosNUMERO_PEDIDO.DisplayLabel            := 'Número do pedido';
    cdsPedidosDATA_EMISSAO.DisplayLabel             := 'Data de emissão';
    cdsPedidosCLIENTE.DisplayLabel                  := 'Código do cliente';
    cdsPedidosVALOR_TOTAL.DisplayLabel              := 'Valor total';
    cdsPedidosCLIENTE_NOME.DisplayLabel             := 'Nome do cliente';

    cdsPedidosItensID_PEDIDOS_ITENS.Visible         := False;
    cdsPedidosItensNUMERO_PEDIDO.DisplayLabel       := 'Número do pedido';
    cdsPedidosItensPRODUTO.DisplayLabel             := 'Código do produto';
    cdsPedidosItensQTD.DisplayLabel                 := 'Quantidade';
    cdsPedidosItensVALOR_UNITARIO.DisplayLabel      := 'Valor unitário';
    cdsPedidosItensVALOR_TOTAL.DisplayLabel         := 'Valor total';
    cdsPedidosItensPRODUTO_DESCRICAO.DisplayLabel   := 'Descrição do produto';

    cdsLateralNUMERO_PEDIDO.DisplayLabel            := 'Número do pedido';
    cdsLateralDATA_EMISSAO.DisplayLabel             := 'Data de emissão';
    cdsLateralCLIENTE.DisplayLabel                  := 'Cliente';

    cdsLateralDATA_EMISSAO.DisplayFormat            := 'DD/MM/YYYY HH:MM:01';
    cdsPedidosDATA_EMISSAO.DisplayFormat            := 'DD/MM/YYYY HH:MM:01';
    cdsPedidosVALOR_TOTAL.DisplayFormat             := '0.00';
    cdsPedidosItensVALOR_UNITARIO.DisplayFormat     := '0.00';
    cdsPedidosItensVALOR_TOTAL.DisplayFormat        := '0.00';

    cdsPedidosCLIENTE.OnValidate                    := funcs.ClienteValidate;
    cdsPedidosItensPRODUTO.OnValidate               := funcs.ProdutoValidate;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TDMPedidos.DataModuleCreate %s%s', [#13, E.Message]));
  end;
end;

procedure TDMPedidos.cdsPedidosItensBeforeOpen(DataSet: TDataSet);
begin
  try
    cdsPedidosItens.FetchParams;
    cdsPedidosItens.ParamByName('numero_pedido').AsInteger := cdsPedidosNUMERO_PEDIDO.AsInteger;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TDMPedidos.cdsPedidosItensBeforeOpen %s%s', [#13, E.Message]));
  end;
end;

procedure TDMPedidos.cdsPedidosItensBeforePost(DataSet: TDataSet);
begin
  try
    if cdsPedidosItensNUMERO_PEDIDO.IsNull then
      begin
        Application.MessageBox(PChar('Informe o número do pedido'), PChar('Atenção'), MB_OK + MB_ICONEXCLAMATION);
        Abort;
      end;

    if cdsPedidosItensPRODUTO.IsNull then
      begin
        Application.MessageBox(PChar('Informe o código do produto'), PChar('Atenção'), MB_OK + MB_ICONEXCLAMATION);
        Abort;
      end;

    if cdsPedidosItensQTD.IsNull then
      begin
        Application.MessageBox(PChar('Informe uma quantidade'), PChar('Atenção'), MB_OK + MB_ICONEXCLAMATION);
        Abort;
      end;

    if cdsPedidosItensVALOR_UNITARIO.IsNull then
      begin
        Application.MessageBox(PChar('Informe o valor unitário'), PChar('Atenção'), MB_OK + MB_ICONEXCLAMATION);
        Abort;
      end;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TDMPedidos.cdsPedidosItensBeforePost %s%s', [#13, E.Message]));
  end;
end;

procedure TDMPedidos.cdsPedidosAfterScroll(DataSet: TDataSet);
begin
  try
    funcs.FecharDSDependentes(TTPedidos(Self.Owner).FDSDependentes);
    funcs.AbrirDSDependentes(TTPedidos(Self.Owner).FDSDependentes);
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TDMPedidos.cdsPedidosAfterScroll %s%s', [#13, E.Message]));
  end;
end;

procedure TDMPedidos.cdsPedidosItensBeforeEdit(DataSet: TDataSet);
begin
  try
    if not (cdsPedidos.State in [dsInsert, dsEdit]) then
      cdsPedidos.Edit;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TDMPedidos.cdsPedidosItensBeforeEdit %s%s', [#13, E.Message]));
  end;
end;

procedure TDMPedidos.cdsPedidosItensBeforeInsert(DataSet: TDataSet);
begin
  try
    if not (cdsPedidos.State in [dsInsert, dsEdit]) then
      cdsPedidos.Edit;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TDMPedidos.cdsPedidosItensBeforeInsert %s%s', [#13, E.Message]));
  end;
end;

procedure TDMPedidos.cdsPedidosItensAfterInsert(DataSet: TDataSet);
begin
  try
    cdsPedidosItensID_PEDIDOS_ITENS.AsString  := funcs.GenID('GEN_PEDIDOS_ITENS_ID');
    cdsPedidosItensNUMERO_PEDIDO.AsInteger    := cdsPedidosNUMERO_PEDIDO.AsInteger;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TDMPedidos.cdsPedidosItensAfterInsert %s%s', [#13, E.Message]));
  end;
end;

procedure TDMPedidos.cdsPedidosAfterInsert(DataSet: TDataSet);
begin
  try
    cdsPedidosNUMERO_PEDIDO.AsString  := funcs.GenID('GEN_PEDIDOS_ID');
    cdsPedidosDATA_EMISSAO.AsDateTime := Now;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TDMPedidos.cdsPedidosAfterInsert %s%s', [#13, E.Message]));
  end;
end;

procedure TDMPedidos.cdsPedidosAfterClose(DataSet: TDataSet);
begin
  try
    funcs.FecharDSDependentes(TTPedidos(Self.Owner).FDSDependentes);
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TDMPedidos.cdsPedidosAfterClose %s%s', [#13, E.Message]));
  end;
end;

end.
