unit Unit1;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  System.Win.ComObj,
  Winapi.ActiveX,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  SpeechLib_TLB,
  Clipbrd;


type
  TForm1 = class(TForm)
    Button1: TButton;
    RichEdit1: TRichEdit;
    btnSalvar: TButton;
    btnCopiar: TButton;
    procedure Button1Click(Sender: TObject);
    procedure RichEdit1Change(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCopiarClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    comandos: array of string;
    procedure ExecutarComandos(richedit: TRichEdit; const comandos: array of string);
    procedure SalvarArquivo;
    procedure ApagarUltimaPalavra(RichEdit: TRichEdit);

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ApagarUltimaPalavra(RichEdit: TRichEdit);
var
  Texto: string;
  UltimaPalavra, PosicaoAnterior: Integer;
begin
  // Obt�m o �ndice do caractere da �ltima palavra no texto.
  Texto := RichEdit.Text;
  UltimaPalavra := LastDelimiter(' ', Texto);

  if UltimaPalavra > 0 then
  begin
    // Obt�m o �ndice do caractere que inicia a palavra anterior.
    PosicaoAnterior := LastDelimiter(' ', Copy(Texto, 1, UltimaPalavra-1)) + 1;

    // Define a sele��o para incluir a �ltima palavra e a exclui.
    RichEdit.SelStart := PosicaoAnterior - 1;
    RichEdit.SelLength := UltimaPalavra - PosicaoAnterior + 1;
    RichEdit.ClearSelection;
  end;

end;

procedure TForm1.btnCopiarClick(Sender: TObject);
begin
  RichEdit1.SelectAll;
  RichEdit1.CopyToClipboard;
end;

procedure TForm1.btnSalvarClick(Sender: TObject);
begin
  SalvarArquivo;
  Showmessage('Salvei no Banco de dados');
  ApagarUltimaPalavra(RichEdit1);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
{https://support.microsoft.com/pt-br/windows/usar-a-digita%C3%A7%C3%A3o-de-voz-para-falar-em-vez-de-digitar-no-computador-fec94565-c4bd-329d-e59a-af033fa5689f}

  RichEdit1.SetFocus;
 // Pressiona a tecla "Windows"
  keybd_event(VK_LWIN, 0, 0, 0);

  // Pressiona a tecla "H"
  keybd_event(Ord('H'), MapVirtualKey(Ord('H'), 0), 0, 0);

  // Libera a tecla "H"
  keybd_event(Ord('H'), MapVirtualKey(Ord('H'), 0), KEYEVENTF_KEYUP, 0);

  // Libera a tecla "Windows"
  keybd_event(VK_LWIN, 0, KEYEVENTF_KEYUP, 0);
end;

procedure TForm1.ExecutarComandos(richedit: TRichEdit;
  const comandos: array of string);
var
  i: Integer;
  palavra: string;
  texto: string;
begin
  texto := richedit.Text;
  for i := 0 to High(comandos) do // percorre cada comando na matriz
  begin
    palavra := comandos[i];
    if Pos(palavra, texto) > 0 then // verifica se a palavra existe no texto
    begin
      // fa�a algo aqui, como executar um comando espec�fico
      ShowMessage('Comando "' + palavra + '" encontrado!');

      if palavra='Fechar' then
        close;

      if palavra='Salvar' then
        btnSalvar.Click;


      if palavra='Copiar' then
        btnCopiar.Click;

    end;
  end;

end;

procedure TForm1.RichEdit1Change(Sender: TObject);
begin
  // preenche a matriz de comandos com algumas palavras
  SetLength(comandos, 4);
  comandos[0] := 'Abrir';
  comandos[1] := 'Salvar';
  comandos[2] := 'Fechar';
  comandos[3] := 'Copiar';

  ExecutarComandos(richedit1, comandos);
end;

procedure TForm1.SalvarARquivo;
var
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(nil);
  try
    // Define o t�tulo da janela do di�logo de salvar.
    SaveDialog.Title := 'Salvar arquivo';

    // Define as extens�es permitidas e o tipo de arquivo padr�o.
    SaveDialog.Filter := 'Arquivos RTF (*.rtf)|*.rtf|Todos os arquivos (*.*)|*.*';
    SaveDialog.DefaultExt := 'rtf';

    // Exibe o di�logo de salvar e verifica se o usu�rio pressionou o bot�o OK.
    if SaveDialog.Execute then
    begin
      // Salva o conte�do do TRichEdit no arquivo selecionado.
      RichEdit1.Lines.SaveToFile(SaveDialog.FileName);
    end;
  finally
    SaveDialog.Free;
  end;

end;

end.
