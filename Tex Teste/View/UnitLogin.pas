unit UnitLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, FMX.Objects,
  FMX.Ani, System.Skia, FMX.Skia,Loading;

type
  TfrmLogin = class(TForm)
    lyPrincipal: TLayout;
    Label1: TLabel;
    edtLogin: TEdit;
    Label2: TLabel;
    edtSenha: TEdit;
    lyLogin: TLayout;
    imgLogo: TImage;
    rectButtonLogar: TRectangle;
    Label3: TLabel;
    FloatAnimation1: TFloatAnimation;
    Image1: TImage;
    procedure Label3MouseLeave(Sender: TObject);
    procedure rectButtonLogarClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    procedure ValidaLogin(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
      Validado : Boolean;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

uses uControllerLogin;

procedure TfrmLogin.Image1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.Label3MouseLeave(Sender: TObject);
begin
  rectButtonLogar.Opacity := 0.2;
end;

procedure TfrmLogin.rectButtonLogarClick(Sender: TObject);
var
  ControllerLogin : TControllerLogin;

  
begin
  FloatAnimation1.Start;

  ControllerLogin := TControllerLogin.Create;

  if (edtlogin.Text = '') or (edtSenha.Text = '') then
    Abort;


  var LTread := TThread.CreateAnonymousThread(
  procedure
  begin
   TLoading.Show('Autenticando usuário.',Self);
   sleep(2000);
   Validado := False;
   TThread.Synchronize(nil,
    procedure
    begin
      ControllerLogin.ModeloLogin.Login := Trim(edtLogin.Text);
      ControllerLogin.ModeloLogin.Senha := Trim(edtSenha.Text);

      if ControllerLogin.ModeloLogin.AutenticarLogin then
         Validado := True
    end);
  end);
  LTread.OnTerminate := ValidaLogin;
  LTread.Start;

end;

procedure TfrmLogin.ValidaLogin(Sender: TObject);
begin
  TLoading.Hide;

  if Validado then
    Close
  else ShowMessage('Erro ao logar');

  if Sender is TThread then
  begin
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage(Exception(TThread(sender).FatalException).Message);
      exit;
    end;
  end;
end;



end.
