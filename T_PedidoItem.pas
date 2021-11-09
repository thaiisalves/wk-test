unit T_PedidoItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.Mask;

type
  TTPedidoItem = class(TForm)
    gbItem: TGroupBox;
    lblProduto: TLabel;
    lblQuantidade: TLabel;
    lblValorUnitario: TLabel;
    dbProdutoDescricao: TDBText;
    dbProduto: TDBEdit;
    dbQtd: TDBEdit;
    dbValorUnitario: TDBEdit;
    navPrincipal: TDBNavigator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure navPrincipalClick(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TPedidoItem: TTPedidoItem;

implementation

{$R *.dfm}

uses T_DMPedidos;

procedure TTPedidoItem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    Action := caFree;
    TPedidoItem := nil;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTPedidoItem.FormClose %s%s', [#13, E.Message]));
  end;
end;

procedure TTPedidoItem.navPrincipalClick(Sender: TObject; Button: TNavigateBtn);
begin
  try
    if Button = nbCancel then
      DMPedidos.cdsPedidosItens.CancelUpdates;

    Close;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTPedidoItem.navPrincipalClick %s%s', [#13, E.Message]));
  end;
end;

end.
