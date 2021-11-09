unit T_DMCon;

interface

uses
  System.SysUtils, System.Classes, Data.DBXMySQL, Data.DB, Data.SqlExpr,
  Data.DBXFirebird;

type
  TDMCon = class(TDataModule)
    Conexao: TSQLConnection;
  private
    { Private declarations }
  public
    { Public declarations }
    IDTrans   : Integer;
    TransDesc : TTransactionDesc;
    procedure IniciarTransacao;
    function CommitarTransacao(Start: Boolean) : Boolean;
    function FazerRollBack(Start: Boolean) : Boolean;
  end;

var
  DMCon: TDMCon;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMCon.IniciarTransacao;
begin
  try
    if IDTrans = 0 then
      begin
        IDTrans                   := StrToInt(FormatDateTime('HHMMSSZZ', Now));
        TransDesc.TransactionID   := IDTrans;
        TransDesc.IsolationLevel  := xilREADCOMMITTED;
        Conexao.StartTransaction(TransDesc);
      end;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TDMCon.IniciarTransacao %s%s', [#13, E.Message]));
  end;
end;

function TDMCon.CommitarTransacao(Start: Boolean) : Boolean;
begin
  try
    Result := False;

    if TransDesc.TransactionID > 0 then
      Conexao.Commit(TransDesc);

    // Zera a transaction
    TransDesc.TransactionID := 0;

    if Start then
      IniciarTransacao;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TDMCon.CommitarTransacao %s%s', [#13, E.Message]));
  end;
end;

function TDMCon.FazerRollBack(Start: Boolean) : Boolean;
begin
  try
    Result := False;

    if Assigned(Conexao) and (TransDesc.TransactionID > 0) then
      Conexao.Rollback(TransDesc);

    // Zera a transaction
    TransDesc.TransactionID := 0;

    if Start then
      IniciarTransacao;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      raise Exception.Create(Format('TDMCon.FazerRollBack %s%s', [#13, E.Message]));
  end;
end;

end.
