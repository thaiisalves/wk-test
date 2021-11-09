unit T_BaseCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, funcoes, Datasnap.DBClient, Math, Vcl.Buttons;

type
  TTipoFiltroComparacao = (tfcIgual, tfcDiferente, tfcMaior, tfcMenor,
                           tfcMaiorIgual, tfcMenorIgual, tfcContenha,
                           tfcNaoContenha);

type
  TTBaseCadastro = class(TForm)
    pnLateral: TPanel;
    pnPesquisa: TPanel;
    gbLateral: TGroupBox;
    grdLateral: TDBGrid;
    gbPrincipal: TGroupBox;
    navPrincipal: TDBNavigator;
    btnPesquisa: TSpeedButton;
    pnFiltro: TPanel;
    cbFiltroCampo: TComboBox;
    lblFiltroCampo: TLabel;
    cbFiltroComparacao: TComboBox;
    edtFiltroValor: TEdit;
    btnBuscar: TButton;
    btnTodos: TButton;
    procedure FormCreate(Sender: TObject);
    procedure navPrincipalClick(Sender: TObject; Button: TNavigateBtn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtFiltroValorKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure navPrincipalBeforeAction(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
    function GetDSDependente(Indice: Integer) : TDataSource;
  public
    { Public declarations }
    FDSDependentes : array of TDataSource;
    property DSDependente[Indice: Integer] : TDataSource read GetDSDependente;
    function GetFiltroTipoComparacao : TTipoFiltroComparacao;
  end;

var
  TBaseCadastro: TTBaseCadastro;

implementation

{$R *.dfm}

function TTBaseCadastro.GetDSDependente(Indice: Integer) : TDataSource;
begin
  Result := FDSDependentes[Indice];
end;

procedure TTBaseCadastro.FormCreate(Sender: TObject);
begin
  try
    SetLength(FDSDependentes, 1);
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTBaseCadastro.FormCreate %s%s', [#13, E.Message]));
  end;
end;

procedure TTBaseCadastro.FormShow(Sender: TObject);
begin
  try
    btnPesquisa.Click;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTBaseCadastro.FormShow %s%s', [#13, E.Message]));
  end;
end;

procedure TTBaseCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    if Action = caNone then
      Exit;

    funcs.FecharDSDependentes(FDSDependentes);
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTBaseCadastro.FormClose %s%s', [#13, E.Message]));
  end;
end;

procedure TTBaseCadastro.navPrincipalClick(Sender: TObject;
  Button: TNavigateBtn);
begin
  try
    case Button of
      nbPost :
        begin
          funcs.SalvarDSDependentes(FDSDependentes);
          (navPrincipal.DataSource.DataSet as TClientDataSet).ApplyUpdates(0);
          funcs.AplicarUpdatesDSDependentes(FDSDependentes);
          funcs.AtualizarDSDependentes(FDSDependentes);
        end;
      nbRefresh :
        begin
          funcs.AtualizarDSDependentes(FDSDependentes);
        end;
      nbDelete :
        begin
          (navPrincipal.DataSource.DataSet as TClientDataSet).ApplyUpdates(0);
          funcs.AplicarUpdatesDSDependentes(FDSDependentes);
        end;
    end;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTBaseCadastro.navPrincipalClick %s%s', [#13, E.Message]));
  end;
end;

function TTBaseCadastro.GetFiltroTipoComparacao : TTipoFiltroComparacao;
begin
  try
    case cbFiltroComparacao.ItemIndex of
      0 : Result := tfcIgual;
      1 : Result := tfcDiferente;
      2 : Result := tfcMaior;
      3 : Result := tfcMenor;
      4 : Result := tfcMaiorIgual;
      5 : Result := tfcMenorIgual;
      6 : Result := tfcContenha;
      7 : Result := tfcNaoContenha;
    end;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTBaseCadastro.GetFiltroTipoComparacao %s%s', [#13, E.Message]));
  end;
end;

procedure TTBaseCadastro.btnPesquisaClick(Sender: TObject);
begin
  try
    if pnFiltro.Visible then
      begin
        pnFiltro.Visible := False;
        pnPesquisa.Height := btnPesquisa.Height + 2;
      end
    else
      begin
        pnFiltro.Visible := True;
        pnPesquisa.Height := btnPesquisa.Height + pnFiltro.Height;
      end;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTBaseCadastro.btnPesquisaClick %s%s', [#13, E.Message]));
  end;
end;

procedure TTBaseCadastro.edtFiltroValorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  try
    if Key = VK_RETURN then
      btnBuscar.Click;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TTBaseCadastro.edtFiltroValorKeyUp %s%s', [#13, E.Message]));
  end;
end;

procedure TTBaseCadastro.navPrincipalBeforeAction(Sender: TObject;
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
      raise Exception.Create(Format('TTBaseCadastro.navPrincipalBeforeAction %s%s', [#13, E.Message]));
  end;
end;

end.
