unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView, FMX.TabControl,
  FMX.StdCtrls, FMX.Ani, System.Rtti, FMX.Grid.Style, FMX.Edit, FMX.Grid,
  FMX.ScrollBox, System.Math.Vectors, FMX.DateTimeCtrls, FMX.Controls3D,
  FMX.Layers3D,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Datasnap.DBClient, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,JSON,uEnumCrud;

type
  TfrmPrincipal = class(TForm)
    StyleBook1: TStyleBook;
    TabControl1: TTabControl;
    tbBuscarPessoa: TTabItem;
    MultiView1: TMultiView;
    tbAdicionarPessoa: TTabItem;
    tbExcluirPessoa: TTabItem;
    Rectangle1: TRectangle;
    btnAbriMenu: TSpeedButton;
    btBuscaPessoa: TSpeedButton;
    btAdicionarPessoa: TSpeedButton;
    btnFechar: TSpeedButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Text1: TText;
    Text4: TText;
    Text3: TText;
    Text2: TText;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Label2: TLabel;
    CAShowing: TColorAnimation;
    CAHiding: TColorAnimation;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    Label1: TLabel;
    stGridPessoas: TStringGrid;
    Código: TStringColumn;
    nome: TStringColumn;
    RG: TStringColumn;
    Layout1: TLayout;
    edtBuscar: TEdit;
    Image5: TImage;
    Label3: TLabel;
    lyDadosPrincipal: TLayout;
    lyFooter: TLayout;
    Layout3D1: TLayout3D;
    Label4: TLabel;
    Label5: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    Label6: TLabel;
    edtRG: TEdit;
    Label7: TLabel;
    Layout2: TLayout;
    dtNascimento: TDateEdit;
    Layout4: TLayout;
    edtLogradouro: TEdit;
    Label9: TLabel;
    edtCep: TEdit;
    Image6: TImage;
    Label8: TLabel;
    Layout5: TLayout;
    edtBairro: TEdit;
    Label10: TLabel;
    edtComplemento: TEdit;
    Label12: TLabel;
    edtUF: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    edtNumero: TEdit;
    edtCidade: TEdit;
    Label11: TLabel;
    rectButtonSalvar: TRectangle;
    Label15: TLabel;
    rectButtonCancelar: TRectangle;
    Label16: TLabel;
    rectButtonExcluir: TRectangle;
    Label17: TLabel;
    tbHome: TTabItem;
    Rectangle7: TRectangle;
    Label18: TLabel;
    btnHome: TSpeedButton;
    Image8: TImage;
    Text5: TText;
    procedure btnFecharClick(Sender: TObject);
    procedure btBuscaPessoaClick(Sender: TObject);
    procedure btAdicionarPessoaClick(Sender: TObject);
    procedure MultiView1StartShowing(Sender: TObject);
    procedure MultiView1StartHiding(Sender: TObject);
    procedure CAShowingFinish(Sender: TObject);
    procedure CAHidingFinish(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure stGridPessoasCellDblClick(const Column: TColumn;
      const Row: Integer);
    procedure Image6Click(Sender: TObject);
    procedure rectButtonSalvarClick(Sender: TObject);
    procedure rectButtonCancelarClick(Sender: TObject);
    procedure rectButtonExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnHomeClick(Sender: TObject);
  private
    procedure ListarPessoas;
    function ConsultaCEPViaApi(CEP: string): String;
    procedure LimparTelaCadastro;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses
  uControllerPessoa,UnitLogin;

procedure TfrmPrincipal.btAdicionarPessoaClick(Sender: TObject);
begin
  TabControl1.TabIndex := tbAdicionarPessoa.Index;
  MultiView1.HideMaster;
end;

procedure TfrmPrincipal.btBuscaPessoaClick(Sender: TObject);
begin
  TabControl1.TabIndex := tbBuscarPessoa.Index;
  MultiView1.HideMaster;
end;

procedure TfrmPrincipal.btnFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.btnHomeClick(Sender: TObject);
begin
  TabControl1.TabIndex := tbHome.Index;
  MultiView1.HideMaster;
end;

procedure TfrmPrincipal.CAHidingFinish(Sender: TObject);
begin
   CAShowing.Enabled := False;
end;

procedure TfrmPrincipal.CAShowingFinish(Sender: TObject);
begin
  CAHiding.Enabled := False;
end;

procedure TfrmPrincipal.Image5Click(Sender: TObject);
begin
  ListarPessoas;
end;

procedure TfrmPrincipal.Image6Click(Sender: TObject);
var
  Json  : TJSONObject;
  Response : string;
begin
  if edtCep.Text = '' then
    Abort;

  Response := ConsultaCEPViaApi(edtCep.Text);

  json := tjsonobject.ParseJsonValue(TEncoding.UTF8.GetBytes(Response),0) as TJSONObject;

  edtLogradouro.Text := json.GetValue<string>('logradouro','');
  edtComplemento.Text := json.GetValue<string>('complemento','');
  edtBairro.Text := json.GetValue<string>('bairro','');
  edtCidade.Text := json.GetValue<string>('localidade','');
  edtUF.Text := json.GetValue<string>('uf');

end;

procedure TfrmPrincipal.MultiView1StartHiding(Sender: TObject);
begin
  CAHiding.Enabled := True;
end;

procedure TfrmPrincipal.MultiView1StartShowing(Sender: TObject);
begin
  CAShowing.Enabled := True;
end;

procedure TfrmPrincipal.rectButtonCancelarClick(Sender: TObject);
begin
  LimparTelaCadastro;
end;

procedure TfrmPrincipal.rectButtonExcluirClick(Sender: TObject);
var
  ControllerPessoa : TControllerPessoa;
begin
  ControllerPessoa := TControllerPessoa.Create;

  ControllerPessoa.ModeloPessoa.Enumerador := EnumTipoCrud.Excluir;
  ControllerPessoa.ModeloPessoa.Codigo := StrToInt(edtCodigo.Text);
  try
    if MessageDlg('Confirma a exclusão desse registro?',TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbYes,TMsgDlgBtn.mbNo],0) = mrYes then
    begin
      if ControllerPessoa.ModeloPessoa.Persistir then
        Showmessage('Registro Excluido');

      LimparTelaCadastro;
      ListarPessoas;
      TabControl1.TabIndex := tbBuscarPessoa.Index;
    end;
  finally
    FreeAndNil(ControllerPessoa);
  end;

end;

procedure TfrmPrincipal.rectButtonSalvarClick(Sender: TObject);
var
  ControllerPessoa : TControllerPessoa;
begin

  if edtNome.Text = '' then
  begin
    MessageDlg('Nome não informado',TMsgDlgType.mtWarning,[TMsgDlgBtn.mbOK],0);
    edtNome.SetFocus;
    Abort
  end;

  if edtRG.Text = '' then
  begin
    MessageDlg('RG não informado',TMsgDlgType.mtWarning,[TMsgDlgBtn.mbOK],0);
    edtRG.SetFocus;
    Abort
  end;

  if edtCep.Text = '' then
  begin
    MessageDlg('Logradouro não informado',TMsgDlgType.mtWarning,[TMsgDlgBtn.mbOK],0);
    edtCep.SetFocus;
    Abort
  end;

  ControllerPessoa := TControllerPessoa.Create;
  try
    if edtCodigo.text = '' then
      ControllerPessoa.ModeloPessoa.Enumerador := Inserir
    else
    begin
      ControllerPessoa.ModeloPessoa.Enumerador := atualizar;
      ControllerPessoa.ModeloPessoa.Codigo := StrToInt(edtCodigo.Text);
    end;

    ControllerPessoa.ModeloPessoa.Nome           := edtNome.Text;
    ControllerPessoa.ModeloPessoa.DataNascimento := FormatDateTime('dd/mm/yyyy',dtNascimento.Date);
    ControllerPessoa.ModeloPessoa.RG             := edtRG.Text;
    ControllerPessoa.ModeloPessoa.Logradouro     := edtLogradouro.Text;
    ControllerPessoa.ModeloPessoa.Complemento    := edtComplemento.Text;
    ControllerPessoa.ModeloPessoa.Bairro         := edtBairro.Text;
    ControllerPessoa.ModeloPessoa.Cidade         := edtCidade.Text;
    ControllerPessoa.ModeloPessoa.UF             := edtUF.Text;
    ControllerPessoa.ModeloPessoa.Numero         := edtNumero.Text;
    ControllerPessoa.ModeloPessoa.CEP            := StrToInt(edtCep.Text);

    if ControllerPessoa.ModeloPessoa.persistir then
    begin
      if ControllerPessoa.ModeloPessoa.Enumerador = Inserir then
        ShowMessage('Registro Inserido')
      else
        ShowMessage('Registro Atualizado')
    end
    else
      ShowMessage('Erro ao inserir');


     LimparTelaCadastro;

     TabControl1.TabIndex := tbBuscarPessoa.Index;

  finally
    FreeAndNil(ControllerPessoa);
  end;


end;

procedure TfrmPrincipal.stGridPessoasCellDblClick(const Column: TColumn; const Row: Integer);
var
  ControllerVenda : TControllerPessoa;
  Query : TFDQuery;
  I     : integer;
begin
  ControllerVenda := TControllerPessoa.Create;
  Query := ControllerVenda.ModeloPessoa.BuscarPessoa(stGridPessoas.Cells[0,row]);

  if Query.RecordCount > 0 then
  begin
    edtCodigo.Text := Query.FieldByName('nCdPessoa').AsString;
    edtLogradouro.Text := Query.FieldByName('cLogradouro').Value;
    edtComplemento.Text := Query.FieldByName('cComplemento').Value;
    edtBairro.Text := Query.FieldByName('cBairro').Value;
    edtCidade.Text := Query.FieldByName('cCidade').Value;
    edtUF.Text := Query.FieldByName('cUF').Value;

    if Query.FieldByName('cNumero').Value = null then
      edtNumero.Text := ''
    else
    edtNumero.Text := Query.FieldByName('cNumero').Value;

    edtCep.Text := Query.FieldByName('nCEP').AsString;
    edtNome.Text := Query.FieldByName('cNome').Value;
    edtRG.Text := Query.FieldByName('cRG').Value;
    dtNascimento.Date :=  StrToDate(Query.FieldByName('dDataNascimento').Value);

    TabControl1.TabIndex := tbAdicionarPessoa.Index;
  end;

end;

procedure TfrmPrincipal.ListarPessoas;
var
  ControllerVenda : TControllerPessoa;
  Query : TFDQuery;
  I     : integer;
begin
  ControllerVenda := TControllerPessoa.Create;
  Query := ControllerVenda.ModeloPessoa.Listar(edtBuscar.Text);
  try
    if Query.RecordCount > 0 then
    begin

      stGridPessoas.RowCount := Query.RecordCount;

      for I := 0 to Query.RecordCount -1 do
      begin

        stGridPessoas.Cells[0,I] := Query.FieldByName('nCdPessoa').AsString;
        stGridPessoas.Cells[1,I] := Query.FieldByName('cNome').Value;
        stGridPessoas.Cells[2,I] := Query.FieldByName('cRG').Value;

        Query.Next;
      end;

    end;
  finally
    FreeAndNil(ControllerVenda);
  end;
end;

function TfrmPrincipal.ConsultaCEPViaApi(CEP: string): String;
var
  RESTClient : TRESTClient;
  RESTRequest : TRESTRequest;
  RESTResponse : TRESTResponse;
begin

  RESTClient := TRESTClient.Create(nil);
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);

  try
    RESTClient.BaseURL := 'https://viacep.com.br/ws/';
    RESTClient.Accept := 'application/json';

    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTRequest.Resource :=  CEP + '/json/';

    RESTRequest.Execute;

    if RESTResponse.StatusCode = 200 then
      Result := RESTResponse.Content
    else
      ShowMessage('CEP: ' + edtCep.Text + ' não encontrado.');

  finally
    FreeAndNil(RESTClient);
    FreeAndNil(RESTRequest);
    FreeAndNil(RESTResponse);
  end;

end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  TabControl1.TabIndex := tbHome.Index;

  if Not Assigned(frmLogin) then
    Application.CreateForm(TfrmLogin,frmLogin);

  frmLogin.ShowModal;
  FreeAndNil(frmLogin);
end;

procedure TfrmPrincipal.LimparTelaCadastro;
begin
  edtCodigo.Text := '';
  edtNome.Text := '';
  edtRG.Text := '';
  edtCep.Text := '';
  edtLogradouro.Text := '';
  edtCidade.Text := '';
  edtBairro.Text := '';
  edtNumero.Text := '';
  edtComplemento.Text := '';
  edtUF.Text := '';
  edtBuscar.Text;
end;



end.
