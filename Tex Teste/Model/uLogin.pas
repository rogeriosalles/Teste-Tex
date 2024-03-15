unit uLogin;

interface

type
  TLogin = class
    private
    FLogin: string;
    FSenha: string;

    public
      property Login: string read FLogin write FLogin;
      property Senha: string read FSenha write FSenha;
      function AutenticarLogin: Boolean;
  end;

implementation

{ TLogin }

uses uDAOLogin;

function TLogin.AutenticarLogin: Boolean;
var
  daoLogin : TDAOLogin;
begin
  daoLogin := TDAOLogin.create;

  result :=  daoLogin.AutenticarLogin(Self);
end;

end.
