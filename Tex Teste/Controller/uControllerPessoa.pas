unit uControllerPessoa;

interface

uses uPessoa,System.SysUtils,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait,
  FireDAC.Comp.Client;

type
  TControllerPessoa = class
    private
    FModeloPessoa: TPessoa;

    public
      property ModeloPessoa: TPessoa  read FModeloPessoa write FModeloPessoa;
      function Persistir: Boolean;
      function Listar(Busca: string): TFDQuery;
      function BuscarPessoa(nCdPessoa: string): TFDQuery;
      constructor Create;
      destructor destroy; override;
  end;

implementation

{ TControllerVenda }

function TControllerPessoa.BuscarPessoa(nCdPessoa: string): TFDQuery;
begin
  result := FModeloPessoa.BuscarPessoa(nCdPessoa);
end;

constructor TControllerPessoa.Create;
begin
  FModeloPessoa := TPessoa.Create;
  inherited Create;
end;

destructor TControllerPessoa.destroy;
begin
  FreeAndNil(FModeloPessoa);
  inherited;
end;

function TControllerPessoa.Listar(Busca: string): TFDQuery;
begin
  result := FModeloPessoa.Listar(busca);
end;

function TControllerPessoa.Persistir: Boolean;
begin
  result := FModeloPessoa.Persistir;
end;

end.
