unit T_Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.Actions, Vcl.ActnList;

type
  TTPrincipal = class(TForm)
    mnuPrincipal: TMainMenu;
    Arquivo1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    actPrincipal: TActionList;
    acPedidos: TAction;
    acPedidos1: TMenuItem;
    procedure acPedidosExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TPrincipal: TTPrincipal;

implementation

{$R *.dfm}

uses T_Pedidos;

procedure TTPrincipal.acPedidosExecute(Sender: TObject);
begin
  try
    if not Assigned(TPedidos) then
      TPedidos := TTPedidos.Create(Self);

    TPedidos.WindowState  := wsNormal;
    TPedidos.FormStyle    := fsMDIChild;
    TPedidos.Show;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTPrincipal.acPedidosExecute %s%s', [#13, E.Message]));
  end;
end;

end.
