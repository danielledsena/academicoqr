unit Unit_relatorios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, RpCon, RpConDS, RpDefine, RpRave, DB, ADODB;

type
  TForm_relatorios = class(TForm)
    btn_rel_cursos: TBitBtn;
    btn_rel_turmas: TBitBtn;
    btn_rel_alunos: TBitBtn;
    btn_rel_faltas: TBitBtn;
    btn_rel_aulas: TBitBtn;
    btn_fechar: TBitBtn;
    ADOQuery_rel_cursos: TADOQuery;
    procedure btn_rel_cursosClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure btn_rel_turmasClick(Sender: TObject);
    procedure btn_rel_alunosClick(Sender: TObject);
    procedure btn_rel_faltasClick(Sender: TObject);
    procedure btn_rel_aulasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_relatorios: TForm_relatorios;

implementation

uses Unit_logon, Unit_rel_turmas, Unit_rel_alunos, Unit_rel_faltas,
  Unit_rel_aulas, Unit_rel_cursos;

{$R *.dfm}

procedure TForm_relatorios.btn_rel_cursosClick(Sender: TObject);
begin
  ADOQuery_rel_cursos.Open();
  Form_rel_cursos.QuickRep1.Preview;
  ADOQuery_rel_cursos.Close();
end;

procedure TForm_relatorios.btn_fecharClick(Sender: TObject);
begin
  Close;
end;

procedure TForm_relatorios.btn_rel_turmasClick(Sender: TObject);
begin
  Form_rel_turmas.showmodal;
end;

procedure TForm_relatorios.btn_rel_alunosClick(Sender: TObject);
begin
  Form_rel_alunos.showmodal;
end;

procedure TForm_relatorios.btn_rel_faltasClick(Sender: TObject);
begin
  Form_rel_faltas.Showmodal;
end;

procedure TForm_relatorios.btn_rel_aulasClick(Sender: TObject);
begin
  Form_rel_aulas.showmodal;
end;

end.
