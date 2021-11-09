program WK_ERP;

uses
  Vcl.Forms,
  funcoes in 'funcoes.pas',
  T_DMCon in 'T_DMCon.pas' {DMCon: TDataModule},
  T_BaseCadastro in 'T_BaseCadastro.pas' {TBaseCadastro},
  T_Principal in 'T_Principal.pas' {TPrincipal},
  T_DMPedidos in 'T_DMPedidos.pas' {DMPedidos: TDataModule},
  T_Pedidos in 'T_Pedidos.pas' {TPedidos},
  T_PedidoItem in 'T_PedidoItem.pas' {TPedidoItem};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMCon, DMCon);
  Application.CreateForm(TTPrincipal, TPrincipal);
  Application.CreateForm(TTPedidoItem, TPedidoItem);
  Application.Run;
end.
