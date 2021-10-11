unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan, ComCtrls, IdUDPClient,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer, IdSocketHandle;

type
  TMainForm = class(TForm)
    OpenBtn: TButton;
    FileEdit: TLabeledEdit;
    SendBtn: TButton;
    GroupBox1: TGroupBox;
    SizeCap: TLabel;
    BufCount: TLabel;
    ProgressBar: TProgressBar;
    StatusLabel: TLabel;
    SizeLabel: TLabel;
    BufLabel: TLabel;
    UDPServer: TIdUDPServer;
    OpenDialog: TOpenDialog;
    UDPClient: TIdUDPServer;
    SaveDialog: TSaveDialog;
    procedure OpenBtnClick(Sender: TObject);
    procedure SendBtnClick(Sender: TObject);
    procedure UDPServerUDPRead(Sender: TObject; AData: TStream;
      ABinding: TIdSocketHandle);
    procedure UDPClientUDPRead(Sender: TObject; AData: TStream;
      ABinding: TIdSocketHandle);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  // глобальные переменные клиента
  get_accept: boolean = false;

  // глобальные переменные сервера
  ServerStream : TFileStream;
  first_       : boolean=true;
  get_buffers  : integer;
  get_buf_num  : integer;
implementation

{$R *.dfm}

procedure SendProcedure(FStream: TFileStream; UDPClient: TIdUDPServer;
           StatusLabel :Tlabel; ProgressBar :TProgressBar);
var
  i,j,count: integer;
  buf : array[1..40000] of Char;
begin
  i:=round(FStream.Size/40000);
  if (i*40000<FStream.Size) then i:=i+1;
  ProgressBar.Max:=i;
  UDPClient.Send('localhost',1151,'count_buf:'+IntToStr(i)+'#');
  Application.ProcessMessages;
  for j:=1 to  i do
  begin
    if i=j then
    count:=FStream.Read(buf,FStream.Size-((i-1)*40000))
    else count:=FStream.Read(buf,length(buf));
    UDPClient.SendBuffer('localhost',1151,buf,count);
    StatusLabel.Caption:='передача пакета № '+IntToStr(j);
    ProgressBar.Position:=j;
    while get_accept=false do Application.ProcessMessages;
    get_accept:=false;
  end;
end;

// открытие файла
procedure TMainForm.OpenBtnClick(Sender: TObject);
var
  FStream : TFileStream;
begin
  if OpenDialog.Execute
  then
   begin
    FileEdit.Text:=OpenDialog.FileName;
    FStream:=TFileStream.Create(OPenDialog.FileName,fmOpenRead);
    SizeLabel.Caption:=IntToStr(Round(FStream.Size/1024))+' килобайт.';
    BufLabel.Caption:=FloatToStr(FStream.Size/40000)+' пакетов.';
    FStream.free;
   end; 
end;

// отправка файла
procedure TMainForm.SendBtnClick(Sender: TObject);
var
  FStream : TFileStream;
begin
  if not FileExists(FileEdit.Text) then Exit;
  FStream:=TFileStream.Create(FileEdit.Text,fmOpenRead);
  SendProcedure(FStream, UDPClient, StatusLabel, ProgressBar);
  FStream.Free;
end;

// процедура приема файла на сервере
procedure TMainForm.UDPServerUDPRead(Sender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);
var
  str_buf : array[1..20] of Char;
begin
  // если первый раз, то считываем данные об колличестве пакетов, которые нужно будет принять
  // создаем поток для файла
  if first_=true then
  begin
    AData.Read(str_buf,length(str_buf));
    if copy(str_buf,1,10)='count_buf:' then
    get_buffers:=StrToInt(copy(str_buf,11,pos('#',str_buf)-11));
    if SaveDialog.Execute then
    begin
      first_:=false;
      ServerStream:=TFileStream.Create(SaveDialog.FileName,fmCreate);
    end;
  end else
  begin
    get_buf_num:=get_buf_num+1;
    ServerStream.Position:=ServerStream.Size;
    ServerStream.CopyFrom(AData,AData.Size);
    UDPServer.Send('localhost',1152,'accept');
    if get_buffers=get_buf_num then
    begin
      ShowMessage('Все, принято!');
      ServerStream.Free;
    end;
  end;
end;

procedure TMainForm.UDPClientUDPRead(Sender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);
begin
  get_accept:=true;
end;

end.
