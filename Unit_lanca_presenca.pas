unit Unit_lanca_presenca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, DB, ADODB;

type
  TForm_lanca_presenca = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edt_turma: TEdit;
    cb_aulas: TComboBox;
    btn_listar_alunos: TBitBtn;
    btn_confirmar: TBitBtn;
    btn_fechar: TBitBtn;
    btn_turma: TBitBtn;
    ck_lista_alunos: TCheckListBox;
    ADOQuery_aux: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure btn_turmaClick(Sender: TObject);
    procedure cb_aulasEnter(Sender: TObject);
    procedure btn_listar_alunosClick(Sender: TObject);
    procedure btn_confirmarClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_lanca_presenca: TForm_lanca_presenca;

implementation

uses Unit_logon, Unit_pesquisa_turmas;

{$R *.dfm}

procedure TForm_lanca_presenca.FormShow(Sender: TObject);
begin
  edt_turma.Clear;
  cb_aulas.Clear;
  ck_lista_alunos.Clear;
end;

procedure TForm_lanca_presenca.btn_turmaClick(Sender: TObject);
begin
  edt_turma.Clear;
  Form_pesquisa_turmas.ShowModal;
 
  if Form_pesquisa_turmas.chave <> '' then
     edt_turma.Text := Form_pesquisa_turmas.chave
end;

procedure TForm_lanca_presenca.cb_aulasEnter(Sender: TObject);
var data :TDateTime;
begin
  cb_aulas.Clear;
  if edt_turma.Text = '' then
     ShowMessage('Selecione uma turma!')
  else
     begin
       //Busca as aulas que ainda n�o tiveram a frequ�ncia lan�ada
       ADOQuery_aux.SQL.Text := ' SELECT DATA FROM AULAS '+
                                ' WHERE COD_TURMA=' + QuotedStr(edt_turma.Text)+
                                ' AND DATA NOT IN ' +
                                ' (SELECT DATA FROM FREQUENCIAS '+
                                ' WHERE COD_TURMA='+QuotedStr(edt_turma.Text)+')'+
                                ' ORDER BY DATA DESC';
       ADOQuery_aux.Open;
       if ADOQuery_aux.IsEmpty then
          ShowMessage('N�o existem aulas dessa turma para lan�amento de frequ�ncia!')
       else
          begin
             While not ADOQuery_aux.Eof do
             begin
                data := ADOQuery_aux.fieldbyname('DATA').AsDateTime;
                cb_aulas.Items.Add(FormatDateTime('dd/mm/yyyy',data));
                ADOQuery_aux.Next;
             end;
          end;
          ADOQuery_aux.Close;
     end;
end; 

procedure TForm_lanca_presenca.btn_listar_alunosClick(Sender: TObject);
var aluno : string;
begin
   if (edt_turma.Text='') or (cb_aulas.Text='') then
      ShowMessage('Informa��es inv�lidas!')
   else
     begin
      ADOQuery_aux.SQL.Text := 'SELECT MATRICULAS.COD_ALUNO, ALUNOS.NOME '+
                               'FROM MATRICULAS INNER JOIN ALUNOS '+
                               'ON MATRICULAS.COD_ALUNO = ALUNOS.COD_ALUNO '+
                               'WHERE COD_TURMA =' + QuotedStr(edt_turma.Text)+
                               'ORDER BY ALUNOS.NOME';
      ADOQuery_aux.Open;
      if ADOQuery_aux.IsEmpty then
         ShowMessage('N�o existem alunos matriculados nesta turma!')
      else
      begin
         While not ADOQuery_aux.Eof do
         begin
            aluno := ADOQuery_aux.fieldbyname('COD_ALUNO').AsString;
            aluno := stringofchar('0',3-length(aluno)) + aluno;
            aluno := aluno +' - '+ ADOQuery_aux.fieldbyname('NOME').AsString;
            ck_lista_alunos.Items.Add(aluno);
            ADOQuery_aux.Next;
         end;
      end;
      ADOQuery_aux.Close;
     end;
end;

procedure TForm_lanca_presenca.btn_confirmarClick(Sender: TObject);
var i : integer;
    cod_aluno, presente, data : string;
    deuerro : boolean;
begin
    Form_logon.ConexaoBD.BeginTrans;
    try
      deuerro := false;
      data := FormatDateTime('mm/dd/yyyy',StrToDate(cb_aulas.Text));
      for i := 0 to ck_lista_alunos.Items.Count -1 do
      begin
         ck_lista_alunos.Selected[i] := true;
         cod_aluno := copy(ck_lista_alunos.Items.Strings[i],1,3);

         if ck_lista_alunos.Checked[i] then
            presente := 'S'
         else 
            presente := 'N';
 
         ADOQuery_aux.SQL.Text := 'INSERT INTO FREQUENCIAS VALUES '+
                                  '('+ QuotedStr(edt_turma.Text) +
                                  ','+ cod_aluno +
                                  ','+ QuotedStr(data) +
                                  ','+ QuotedStr(presente) + ')';
         ADOQuery_aux.ExecSQL;
      end;
    except
      on E : Exception do
      begin
         deuerro := true;
         ShowMessage('Ocorreu o seguinte erro: ' + E.Message);
      end;
    end;

    if deuerro = true then
       Form_logon.ConexaoBD.RollbackTrans
    else
       begin
          Form_logon.ConexaoBD.CommitTrans;
          ShowMessage('Lan�amento efetuado com sucesso!');
          edt_turma.Clear;
          cb_aulas.Clear;
          ck_lista_alunos.Clear;
       end;
end;

procedure TForm_lanca_presenca.btn_fecharClick(Sender: TObject);
begin
  Close;
end;

end.
