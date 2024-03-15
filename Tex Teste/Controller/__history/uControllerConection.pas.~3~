unit uControllerConection;

interface

uses
  system.SysUtils,uDAOConection ;

type
  TControllerConection = class
    private
    FdaoConection: TDAOConection;
       constructor Create;
       destructor Destroy; override;
    public
    property daoConection: TDAOConection read FdaoConection write FdaoConection;
      class function getInstance : TControllerConection;

  end;

implementation


var
  Instance : TControllerConection;

{ TControllerConection }

constructor TControllerConection.Create;
begin
  inherited Create;

  FdaoConection := TDAOConection.Create;
end;

destructor TControllerConection.Destroy;
begin
  inherited;
  FreeAndNil(FdaoConection);
end;

class function TControllerConection.getInstance: TControllerConection;
begin
  if Instance = nil then
    Instance := TControllerConection.Create;

  result := Instance;

end;

initialization
  instance := nil;

finalization
  if instance <> nil then
    instance.Free;

end.
