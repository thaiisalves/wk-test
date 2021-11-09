unit funcoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Menus,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids,
  Vcl.ComCtrls, Vcl.StdCtrls, Data.FMTBcd, Data.DB, Data.SqlExpr, DBGrids,
  Data.DBXInterBase, TypInfo, IniFiles, Datasnap.DBClient;

type
  Tfuncoes =  class
  private
  public
    constructor Create(); virtual;
    destructor Destroy(); override;

    procedure ClienteValidate(Sender: TField);
    procedure ProdutoValidate(Sender: TField);

    procedure AbrirDSDependentes(DSDependentes: array of TDataSource);
    procedure FecharDSDependentes(DSDependentes: array of TDataSource);
    procedure AtualizarDSDependentes(DSDependentes: array of TDataSource);
    procedure SalvarDSDependentes(DSDependentes: array of TDataSource);
    procedure AplicarUpdatesDSDependentes(DSDependentes: array of TDataSource);
    procedure CancelarDSDependentes(DSDependentes: array of TDataSource);

    function GenID(Generator: String; Incrementar: Integer=1) : String;
  end;

var
  funcs : Tfuncoes;

implementation

{ Tfuncoes }

uses T_DMCon;

constructor Tfuncoes.Create;
begin
  inherited Create;
end;

destructor Tfuncoes.Destroy;
begin
  inherited;
end;

procedure Tfuncoes.ClienteValidate(Sender: TField);
var
  qrySelect : TSQLQuery;
begin
  if Sender.IsNull then
    begin
      if Sender.DataSet.FindField('CLIENTE_NOME') <> nil then
        Sender.DataSet.FieldByName('CLIENTE_NOME').Clear;
      Exit;
    end;

  qrySelect := TSQLQuery.Create(nil);
  try
    qrySelect.Name          := 'qrySelect' + FormatDateTime('HHMMSSZZ', Now);
    qrySelect.SQLConnection := DMCon.Conexao;
    qrySelect.SQL.Text      := 'SELECT NOME FROM CLIENTES WHERE CODIGO = ' + Sender.AsString;
    qrySelect.Open;

    if qrySelect.IsEmpty then
      begin
        Application.MessageBox(PChar(Format('"%s" não é um cliente válido', [Sender.AsString])), PChar('Atenção'), MB_OK + MB_ICONEXCLAMATION);
        Abort;
      end;

    if Sender.DataSet.FindField('CLIENTE_NOME') <> nil then
      Sender.DataSet.FieldByName('CLIENTE_NOME').AsString := qrySelect.FieldByName('NOME').AsString;
  finally
    FreeAndNil(qrySelect);
  end;
end;

procedure Tfuncoes.ProdutoValidate(Sender: TField);
var
  qrySelect : TSQLQuery;
begin
  if Sender.IsNull then
    begin
      if Sender.DataSet.FindField('PRODUTO_DESCRICAO') <> nil then
        Sender.DataSet.FieldByName('PRODUTO_DESCRICAO').Clear;
      Exit;
    end;

  qrySelect := TSQLQuery.Create(nil);
  try
    qrySelect.Name          := 'qrySelect' + FormatDateTime('HHMMSSZZ', Now);
    qrySelect.SQLConnection := DMCon.Conexao;
    qrySelect.SQL.Text      := 'SELECT DESCRICAO FROM PRODUTOS WHERE CODIGO = ' + Sender.AsString;
    qrySelect.Open;

    if qrySelect.IsEmpty then
      begin
        Application.MessageBox(PChar(Format('"%s" não é um produto válido', [Sender.AsString])), PChar('Atenção'), MB_OK + MB_ICONEXCLAMATION);
        Abort;
      end;

    if Sender.DataSet.FindField('PRODUTO_DESCRICAO') <> nil then
      Sender.DataSet.FieldByName('PRODUTO_DESCRICAO').AsString := qrySelect.FieldByName('DESCRICAO').AsString;
  finally
    FreeAndNil(qrySelect);
  end;
end;

procedure Tfuncoes.AbrirDSDependentes(DSDependentes: array of TDataSource);
var
  FCursor : TCursor;
  I       : Integer;
  Msg     : String;
begin
  try
    FCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    for I := 0 to High(DSDependentes) do
      begin
        if (DSDependentes[I] <> nil) and
           (DSDependentes[I].DataSet <> nil) and
           (not DSDependentes[I].DataSet.Active) then
          DSDependentes[I].DataSet.Open;
      end;
      Screen.Cursor := FCursor;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      begin
        Msg := EmptyStr;

        if (High(DSDependentes) > I) and (DSDependentes[I] <> nil) and (DSDependentes[I].DataSet <> nil) then
          Msg := Format('DataSet: %s - ', [DSDependentes[I].DataSet.Name]);

        raise Exception.Create(Format('TDSDependentes.AbrirDSDependentes %s%s%s', [#13, Msg, E.Message]));
      end;
  end;
end;

procedure Tfuncoes.FecharDSDependentes(DSDependentes: array of TDataSource);
var
  FCursor : TCursor;
  I       : Integer;
  Msg     : String;
begin
  try
    FCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    for I := 0 to High(DSDependentes) do
      begin
        if (DSDependentes[I] <> nil) and
           (DSDependentes[I].DataSet <> nil) and
           (DSDependentes[I].DataSet.Active) then
          begin
            DSDependentes[I].DataSet.Close;
          end;
      end;
    Screen.Cursor := FCursor;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      begin
        Msg := EmptyStr;

        if (High(DSDependentes) > I) and (DSDependentes[I] <> nil) and (DSDependentes[I].DataSet <> nil) then
          Msg := Format('DataSet: %s - ', [DSDependentes[I].DataSet.Name]);

        raise Exception.Create(Format('TDSDependentes.FecharDSDependentes %s%s%s', [#13, Msg, E.Message]));
      end;
  end;
end;

procedure Tfuncoes.AtualizarDSDependentes(DSDependentes: array of TDataSource);
var
  FCursor : TCursor;
  I       : Integer;
  Msg     : String;
begin
  try
    FCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    for I := 0 to High(DSDependentes) do
      begin
        if (DSDependentes[I] <> nil) and
           (DSDependentes[I].DataSet <> nil) and
           (DSDependentes[I].DataSet.Active) then
          begin
            DSDependentes[I].DataSet.Refresh;
          end;
      end;
    Screen.Cursor := FCursor;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      begin
        Msg := EmptyStr;

        if (High(DSDependentes) > I) and (DSDependentes[I] <> nil) and (DSDependentes[I].DataSet <> nil) then
          Msg := Format('DataSet: %s - ', [DSDependentes[I].DataSet.Name]);

        raise Exception.Create(Format('TDSDependentes.AtualizarDSDependentes %s%s%s', [#13, Msg, E.Message]));
      end;
  end;
end;

procedure Tfuncoes.SalvarDSDependentes(DSDependentes: array of TDataSource);
var
  FCursor : TCursor;
  I       : Integer;
  Msg     : String;
begin
  try
    FCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    for I := 0 to High(DSDependentes) do
      begin
        if (DSDependentes[I] <> nil) and
           (DSDependentes[I].DataSet <> nil) and
           (DSDependentes[I].DataSet.Active) then
          begin
            if DSDependentes[I].DataSet.State in [dsInsert, dsEdit] then
              DSDependentes[I].DataSet.Post;
          end;
      end;
    Screen.Cursor := FCursor;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      begin
        Msg := EmptyStr;

        if (High(DSDependentes) > I) and (DSDependentes[I] <> nil) and (DSDependentes[I].DataSet <> nil) then
          Msg := Format('DataSet: %s - ', [DSDependentes[I].DataSet.Name]);

        raise Exception.Create(Format('TDSDependentes.SalvarDSDependentes %s%s%s', [#13, Msg, E.Message]));
      end;
  end;
end;

procedure Tfuncoes.AplicarUpdatesDSDependentes(DSDependentes: array of TDataSource);
var
  FCursor : TCursor;
  I       : Integer;
  Msg     : String;
begin
  try
    FCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    for I := 0 to High(DSDependentes) do
      begin
        if (DSDependentes[I] <> nil) and
           (DSDependentes[I].DataSet <> nil) and
           (DSDependentes[I].DataSet.Active) then
          begin
            if DSDependentes[I].DataSet is TClientDataSet then
              (DSDependentes[I].DataSet as TClientDataSet).ApplyUpdates(0);
          end;
      end;
    Screen.Cursor := FCursor;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      begin
        Msg := EmptyStr;

        if (High(DSDependentes) > I) and (DSDependentes[I] <> nil) and (DSDependentes[I].DataSet <> nil) then
          Msg := Format('DataSet: %s - ', [DSDependentes[I].DataSet.Name]);

        raise Exception.Create(Format('Tfuncoes.AplicarUpdatesDSDependentes %s%s%s', [#13, Msg, E.Message]));
      end;
  end;
end;

procedure Tfuncoes.CancelarDSDependentes(DSDependentes: array of TDataSource);
var
  FCursor : TCursor;
  I       : Integer;
  Msg     : String;
begin
  try
    FCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    for I := 0 to High(DSDependentes) do
      begin
        if (DSDependentes[I] <> nil) and
           (DSDependentes[I].DataSet <> nil) and
           (DSDependentes[I].DataSet.Active) then
          begin
            if DSDependentes[I].DataSet.State in [dsInsert, dsEdit] then
              DSDependentes[I].DataSet.Cancel;

            if DSDependentes[I].DataSet is TClientDataSet then
              (DSDependentes[I].DataSet as TClientDataSet).CancelUpdates;
          end;
      end;
    Screen.Cursor := FCursor;
  except
    on E : EAbort do
      Abort;
    on E : Exception do
      begin
        Msg := EmptyStr;

        if (High(DSDependentes) > I) and (DSDependentes[I] <> nil) and (DSDependentes[I].DataSet <> nil) then
          Msg := Format('DataSet: %s - ', [DSDependentes[I].DataSet.Name]);

        raise Exception.Create(Format('Tfuncoes.CancelarDSDependentes %s%s%s', [#13, Msg, E.Message]));
      end;
  end;
end;

function Tfuncoes.GenID(Generator: String; Incrementar: Integer=1) : String;
var
  qryGen : TSQLQuery;
begin
  try
    Result := EmptyStr;

    qryGen := TSQLQuery.Create(nil);
    try
      qryGen.Name           := 'qryGen' + FormatDateTime('HHMMSSZZ', Now);
      qryGen.SQLConnection  := DMCon.Conexao;
      qryGen.SQL.Text       := Format('SELECT FIRST 1 GEN_ID(%s, %d) AS ID FROM RDB$DATABASE', [Generator, Incrementar]);
      qryGen.Open;

      Result := qryGen.FieldByName('ID').AsString;
    finally
      FreeAndNil(qryGen);
    end;
  except
    on E : EAbort do
      Abort;
    on E: Exception do
      raise Exception.Create(Format('Tfuncoes.GenID %s%s', [#13, E.Message]));
  end;
end;

end.
