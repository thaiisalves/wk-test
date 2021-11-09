unit T_Pedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, T_BaseCadastro, Data.DB, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls,
  Vcl.Buttons;

type
  TTPedidos = class(TTBaseCadastro)
    pnNumeroPedido: TPanel;
    dbNumeroPedidoCabecalho: TDBText;
    pnEmissao: TPanel;
    dbDataEmissaoCabecalho: TDBText;
    Panel1: TPanel;
    Label2: TLabel;
    Panel2: TPanel;
    pcPrincipal: TPageControl;
    tsItens: TTabSheet;
    grdItens: TDBGrid;
    navItens: TDBNavigator;
    pnRodape: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Panel5: TPanel;
    dbValorTotalPedido: TDBText;
    Panel3: TPanel;
    lblDataEmissaoCabecalho: TLabel;
    Panel6: TPanel;
    lblNumeroPedidoCabecalho: TLabel;
    dbClienteCodigo: TDBEdit;
    dbClienteNome: TDBText;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBuscarClick(Sender: TObject);
    procedure grdLateralDblClick(Sender: TObject);
    procedure btnTodosClick(Sender: TObject);
    procedure grdItensKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure navAlteraItensBeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure navPrincipalClick(Sender: TObject; Button: TNavigateBtn);
    procedure navItensClick(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
    function GetFiltroCampoSQL : String;
    procedure AbrirTelaPedidoItem;
  public
    { Public declarations }
  end;

var
  TPedidos: TTPedidos;

implementation

{$R *.dfm}

uses T_DMPedidos, T_PedidoItem, funcoes, T_DMCon;

procedure TTPedidos.FormCreate(Sender: TObject);
begin
  try
    DMPedidos := TDMPedidos.Create(Self);

    inherited;

    Self.FDSDependentes[0] := DMPedidos.dsPedidosItens;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TDMPedidos.cdsPedidosItensBeforeOpen %s%s', [#13, E.Message]));
  end;
end;

procedure TTPedidos.FormShow(Sender: TObject);
begin
  try
    inherited;

    DMPedidos.cdsLateral.Close;
    DMPedidos.cdsLateral.Open;
    grdLateralDblClick(nil);
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TDMPedidos.cdsPedidosItensBeforeOpen %s%s', [#13, E.Message]));
  end;
end;

procedure TTPedidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    if (DMPedidos.cdsPedidos.State in [dsInsert, dsEdit]) then
      begin
        Application.MessageBox(PChar('Salve ou cancele para continuar'), PChar('Atenção'), MB_OK + MB_ICONEXCLAMATION);
        Action := caNone;
        Abort;
      end;

    FreeAndNil(DMPedidos);
    Action    := caFree;
    TPedidos  := nil;

    inherited;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTPedidos.FormClose %s%s', [#13, E.Message]));
  end;
end;

function TTPedidos.GetFiltroCampoSQL : String;
begin
  try
    case cbFiltroCampo.ItemIndex of
      1 : Result := 'P.NUMERO_PEDIDO';
      2 : Result := 'P.CLIENTE';
      3 : Result := 'C.NOME';
    end;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTPedidos.GetFiltroCampoSQL %s%s', [#13, E.Message]));
  end;
end;

procedure TTPedidos.btnBuscarClick(Sender: TObject);
var
  SQL : TStringList;
begin
  try
    inherited;

    if (Sender = btnBuscar) and (cbFiltroCampo.ItemIndex <= 0) then
      begin
        Application.MessageBox(PChar('Selecione um campo para pesquisar'), PChar('Atenção'), MB_OK + MB_ICONQUESTION);
        Abort;
      end;

    SQL := TStringList.Create;
    try
      SQL.Clear;
      SQL.Add('SELECT P.NUMERO_PEDIDO');
      SQL.Add('     , P.DATA_EMISSAO');
      SQL.Add('     , CAST(C.CODIGO || '' - '' || C.NOME AS VARCHAR(300)) AS CLIENTE');
      SQL.Add('FROM PEDIDOS P');
      SQL.Add('    LEFT JOIN CLIENTES C ON C.CODIGO = P.CLIENTE');

      if  (Sender <> btnTodos) and (edtFiltroValor.Text <> EmptyStr) then
        begin
          case GetFiltroTipoComparacao of
            tfcIgual        : SQL.Add(Format('WHERE %s = ''%s'''                , [GetFiltroCampoSQL, edtFiltroValor.Text]));
            tfcDiferente    : SQL.Add(Format('WHERE %s IS DISTINCT FROM ''%s''' , [GetFiltroCampoSQL, edtFiltroValor.Text]));
            tfcMaior        : SQL.Add(Format('WHERE %s > ''%s'''                , [GetFiltroCampoSQL, edtFiltroValor.Text]));
            tfcMenor        : SQL.Add(Format('WHERE %s < ''%s'''                , [GetFiltroCampoSQL, edtFiltroValor.Text]));
            tfcMaiorIgual   : SQL.Add(Format('WHERE %s >= ''%s'''               , [GetFiltroCampoSQL, edtFiltroValor.Text]));
            tfcMenorIgual   : SQL.Add(Format('WHERE %s <= ''%s'''               , [GetFiltroCampoSQL, edtFiltroValor.Text]));
            tfcContenha     : SQL.Add(Format('WHERE %s LIKE ''%s%s%s'''         , [GetFiltroCampoSQL, '%', edtFiltroValor.Text, '%']));
            tfcNaoContenha  : SQL.Add(Format('WHERE %s NOT LIKE ''%s%s%s'''     , [GetFiltroCampoSQL, '%', edtFiltroValor.Text, '%']));
          end;
        end;

      SQL.Add('ORDER BY P.NUMERO_PEDIDO');

      DMPedidos.cdsLateral.Close;
      DMPedidos.qryLateral.SQL := SQL;
      DMPedidos.cdsLateral.Open;
    finally
      FreeAndNil(SQL);
    end;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTPedidos.btnBuscarClick %s%s', [#13, E.Message]));
  end;
end;

procedure TTPedidos.btnTodosClick(Sender: TObject);
begin
  try
    inherited;
    btnBuscarClick(btnTodos);
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTPedidos.btnTodosClick %s%s', [#13, E.Message]));
  end;
end;

procedure TTPedidos.grdLateralDblClick(Sender: TObject);
var
  Codigo : String;
begin
  try
    inherited;

    if DMPedidos.cdsPedidos.State in [dsInsert, dsEdit] then
      begin
        Application.MessageBox(PChar('Salve ou cancele para continuar'), PChar('Atenção'), MB_OK + MB_ICONEXCLAMATION);
        Abort;
      end;

    if not DMPedidos.cdsLateral.Active then
      Exit;

    Codigo := DMPedidos.cdsLateralNUMERO_PEDIDO.AsString;

    DMPedidos.cdsPedidos.Close;
    DMPedidos.cdsPedidos.FetchParams;
    DMPedidos.cdsPedidos.ParamByName('NUMERO_PEDIDO').AsString := Codigo;
    DMPedidos.cdsPedidos.Open;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTPedidos.grdLateralDblClick %s%s', [#13, E.Message]));
  end;
end;

procedure TTPedidos.grdItensKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  try
    if Key = VK_DELETE then
      begin
        navItens.BtnClick(nbDelete);
        Exit;
      end
    else
    if Key = VK_RETURN then
      begin
        AbrirTelaPedidoItem;
        DMPedidos.cdsPedidosItens.ApplyUpdates(0);
        navPrincipal.BtnClick(nbRefresh);
        Exit;
      end;

    inherited;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTPedidos.grdItensKeyUp %s%s', [#13, E.Message]));
  end;
end;

procedure TTPedidos.navAlteraItensBeforeAction(Sender: TObject;
  Button: TNavigateBtn);
begin
  try
    if Button = nbDelete then
      begin
        if Application.MessageBox(PChar('Deseja realmente deletar o registro?'), PChar('Atenção'), MB_YESNO + MB_ICONQUESTION) = ID_NO then
          Abort;
      end;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTPedidos.navAlteraItensBeforeAction %s%s', [#13, E.Message]));
  end;

end;

procedure TTPedidos.navPrincipalClick(Sender: TObject; Button: TNavigateBtn);
begin
  try
    DMCon.IniciarTransacao;

    inherited;

    DMCon.CommitarTransacao(True);

    DMPedidos.cdsLateral.Refresh;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      begin
        DMCon.FazerRollBack(True);
        raise Exception.Create(Format('TTPedidos.navPrincipalClick %s%s', [#13, E.Message]));
      end;
  end;
end;

procedure TTPedidos.AbrirTelaPedidoItem;
begin
  try
    if not Assigned(TPedidoItem) then
      TPedidoItem := TTPedidoItem.Create(Self);

    TPedidoItem.FormStyle   := fsMDIForm;
    TPedidoItem.WindowState := wsNormal;
    TPedidoItem.ShowModal;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTPedidos.AbrirTelaPedidoItem %s%s', [#13, E.Message]));
  end;
end;

procedure TTPedidos.navItensClick(Sender: TObject; Button: TNavigateBtn);
begin
  try
    inherited;

    if DMPedidos.cdsPedidos.IsEmpty then
      Abort;

    case Button of
      nbInsert :
        begin
          AbrirTelaPedidoItem;
          DMPedidos.cdsPedidosItens.ApplyUpdates(0);
          navPrincipal.BtnClick(nbRefresh);
        end;
    end;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTPedidos.navItensClick %s%s', [#13, E.Message]));
  end;
end;

end.
