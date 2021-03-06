program Academico;

uses
  Forms,
  Unit_logon in 'Unit_logon.pas' {Form_logon},
  Unit_menu in 'Unit_menu.pas' {Form_menu},
  Unit_splash in 'Unit_splash.pas' {Form_splash},
  Unit_usuarios in 'Unit_usuarios.pas' {Form_usuarios},
  Unit_pesquisa in 'Unit_pesquisa.pas' {Form_pesquisa},
  Unit_permissoes in 'Unit_permissoes.pas' {Form_permissoes},
  Unit_cursos in 'Unit_cursos.pas' {Form_cursos},
  Unit_instrutores in 'Unit_instrutores.pas' {Form_instrutores},
  Unit_turmas in 'Unit_turmas.pas' {Form_turmas},
  Unit_pesquisa_turmas in 'Unit_pesquisa_turmas.pas' {Form_pesquisa_turmas},
  Unit_alunos in 'Unit_alunos.pas' {Form_alunos},
  Unit_matriculas in 'Unit_matriculas.pas' {Form_matriculas},
  Unit_lanca_aulas in 'Unit_lanca_aulas.pas' {Form_lanca_aulas},
  Unit_lanca_presenca in 'Unit_lanca_presenca.pas' {Form_lanca_presenca},
  Unit_pag_instrutores in 'Unit_pag_instrutores.pas' {Form_pag_instrutores},
  Unit_relatorios in 'Unit_relatorios.pas' {Form_relatorios},
  Unit_rel_turmas in 'Unit_rel_turmas.pas' {Form_rel_turmas},
  Unit_rel_alunos in 'Unit_rel_alunos.pas' {Form_rel_alunos},
  Unit_rel_faltas in 'Unit_rel_faltas.pas' {Form_rel_faltas},
  Unit_rel_aulas in 'Unit_rel_aulas.pas' {Form_rel_aulas},
  Unit_rel_cursos in 'Unit_rel_cursos.pas' {Form_rel_cursos},
  untRel_turmas in 'untRel_turmas.pas' {Rel_turmas},
  untRel_alunos in 'untRel_alunos.pas' {Rel_alunos},
  untRel_faltas in 'untRel_faltas.pas' {Rel_faltas},
  untRel_aulas in 'untRel_aulas.pas' {Rel_aulas};

{$R *.res}

begin
  Application.Initialize;

  Form_splash:=TForm_splash.Create(application);
  Form_splash.Show;
  Form_splash.Update;

  Application.CreateForm(TForm_logon, Form_logon);
  Application.CreateForm(TForm_menu, Form_menu);
  Application.CreateForm(TForm_usuarios, Form_usuarios);
  Application.CreateForm(TForm_pesquisa, Form_pesquisa);
  Application.CreateForm(TForm_permissoes, Form_permissoes);
  Application.CreateForm(TForm_cursos, Form_cursos);
  Application.CreateForm(TForm_instrutores, Form_instrutores);
  Application.CreateForm(TForm_turmas, Form_turmas);
  Application.CreateForm(TForm_pesquisa_turmas, Form_pesquisa_turmas);
  Application.CreateForm(TForm_alunos, Form_alunos);
  Application.CreateForm(TForm_matriculas, Form_matriculas);
  Application.CreateForm(TForm_lanca_aulas, Form_lanca_aulas);
  Application.CreateForm(TForm_lanca_presenca, Form_lanca_presenca);
  Application.CreateForm(TForm_pag_instrutores, Form_pag_instrutores);
  Application.CreateForm(TForm_relatorios, Form_relatorios);
  Application.CreateForm(TForm_rel_turmas, Form_rel_turmas);
  Application.CreateForm(TForm_rel_alunos, Form_rel_alunos);
  Application.CreateForm(TForm_rel_faltas, Form_rel_faltas);
  Application.CreateForm(TForm_rel_aulas, Form_rel_aulas);
  Application.CreateForm(TForm_rel_cursos, Form_rel_cursos);
  Application.CreateForm(TRel_turmas, Rel_turmas);
  Application.CreateForm(TRel_alunos, Rel_alunos);
  Application.CreateForm(TRel_faltas, Rel_faltas);
  Application.CreateForm(TRel_aulas, Rel_aulas);
  // Application.CreateForm(TForm_splash, Form_splash);

  if form_logon.autenticacao = false then
   Application.Terminate;

  Form_splash.Hide;
  Form_splash.Destroy;
  
  Application.Run;
end.
