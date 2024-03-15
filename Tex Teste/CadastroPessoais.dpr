program CadastroPessoais;

uses
  System.StartUpCopy,
  FMX.Forms,
  uEnumCrud in 'Model\uEnumCrud.pas',
  uPessoa in 'Model\uPessoa.pas',
  uDAOPessoa in 'DAO\uDAOPessoa.pas',
  uControllerConection in 'Controller\uControllerConection.pas',
  uDAOConection in 'DAO\uDAOConection.pas',
  uControllerPessoa in 'Controller\uControllerPessoa.pas',
  UnitLogin in 'View\UnitLogin.pas' {frmLogin},
  UnitPrincipal in 'View\UnitPrincipal.pas' {frmPrincipal},
  uLogin in 'Model\uLogin.pas',
  uDAOLogin in 'DAO\uDAOLogin.pas',
  uControllerLogin in 'Controller\uControllerLogin.pas',
  Loading in 'Loading.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
