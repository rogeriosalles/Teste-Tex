unit uControllerLogin;

interface

uses ulogin,System.SysUtils;

type
  TControllerLogin = class
    private
    FModeloLogin: TLogin;

    public
      property ModeloLogin: TLogin read FModeloLogin write FModeloLogin;
      function AutenticarLogin: Boolean;
      constructor Create;
      destructor destroy; override;
  end;

implementation

{ TControllerVenda }


function TControllerLogin.AutenticarLogin: Boolean;
begin
  result := ModeloLogin.AutenticarLogin;
end;

constructor TControllerLogin.Create;
begin
  FModeloLogin := TLogin.Create;
  inherited Create;
end;

destructor TControllerLogin.destroy;
begin
  FreeAndNil(FModeloLogin);
  inherited;
end;



end.
