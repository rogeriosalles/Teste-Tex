unit uDAOLogin;

interface

uses
  uLogin,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDAOLogin = class
    private
      ModeloLogin : Tlogin;
    public

     function AutenticarLogin(ModeloLogin : TLogin): Boolean;
  end;

implementation

{ TDAOLogin }

uses  uControllerConection;

function TDAOLogin.AutenticarLogin(ModeloLogin : TLogin): Boolean;
var
  Query : TFDQuery;
begin
  Query := TControllerConection.getInstance().daoConection.CriarQuery;
  Query.Close;
  Query.SQL.Add('select * from usuario');
  Query.SQL.Add('where cLogin = :login and cPassword = :senha' );

  Query.Params.ParamByName('Login').Value := ModeloLogin.Login;
  Query.Params.ParamByName('senha').Value := ModeloLogin.Senha;


  Query.Open;
  Result := Query.RecordCount > 0;

end;


end.
