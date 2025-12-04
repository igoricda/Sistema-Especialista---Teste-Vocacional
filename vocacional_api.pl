% vocacional_api.pl
% Autores: Guilherme Altmeyer Soares, Igor Correa Domingues de Almeida, Kauan Carlos Campos e Maria Eduarda Quevedo
:- module(vocacional_api, [
    api_get_questions1/1,
    api_calc_stage1/2,
    api_get_questions2/2,
    api_calc_final/2
]).

:- use_module(library(random)).
:- use_module(library(lists)).

% Evita warnings de predicados espalhados
:- discontiguous pergunta_area/2.
:- discontiguous alternativa_area/3.
:- discontiguous pergunta_curso/3.
:- discontiguous opc_curso/4.

% --- BASE DE CONHECIMENTO ---

area(negocios).
area(tecnologia_exatas).
area(saude_bemestar).
area(biologicas_agrarias).
area(humanas_sociais).

curso(negocios, administracao).
curso(negocios, contabeis).
curso(negocios, economia).
curso(negocios, secretariado_executivo).
curso(negocios, turismo).
curso(negocios, hotelaria).
curso(tecnologia_exatas, computacao).
curso(tecnologia_exatas, engenharia_eletrica).
curso(tecnologia_exatas, engenharia_mecanica).
curso(tecnologia_exatas, engenharia_quimica).
curso(tecnologia_exatas, engenharia_civil).
curso(tecnologia_exatas, engenharia_agricola).
curso(tecnologia_exatas, matematica).
curso(saude_bemestar, medicina).
curso(saude_bemestar, enfermagem).
curso(saude_bemestar, fisioterapia).
curso(saude_bemestar, nutricao).
curso(saude_bemestar, farmacia).
curso(saude_bemestar, odontologia).
curso(saude_bemestar, psicologia).
curso(saude_bemestar, educacao_fisica).
curso(biologicas_agrarias, biologicas).
curso(biologicas_agrarias, agronomia).
curso(biologicas_agrarias, zootecnia).
curso(humanas_sociais, filosofia).
curso(humanas_sociais, historia).
curso(humanas_sociais, geografia).
curso(humanas_sociais, ciencias_sociais).
curso(humanas_sociais, psicologia_humanas).
curso(humanas_sociais, pedagogia).
curso(humanas_sociais, educacao_especial).
curso(humanas_sociais, servico_social).
curso(humanas_sociais, direito).
curso(humanas_sociais, letras).

% --- PERGUNTAS ETAPA 1 (MACRO-ÁREAS) ---

pergunta_area(1, '1) Qual atividade você se imagina fazendo com mais satisfação?').
alternativa_area(1, 'Liderando negócios ou organizando empresas', [negocios]).
alternativa_area(1, 'Criando tecnologias, programando ou trabalhando com engenharia', [tecnologia_exatas]).
alternativa_area(1, 'Cuidando da saúde das pessoas ou promovendo bem-estar físico', [saude_bemestar]).
alternativa_area(1, 'Estudando seres vivos, plantas ou animais', [biologicas_agrarias]).
alternativa_area(1, 'Entendendo comportamentos humanos, cultura, leis ou comunicação', [humanas_sociais]).

pergunta_area(2, '2) Qual matéria escolar você mais gosta?').
alternativa_area(2, 'Empreendedorismo ou administração', [negocios]).
alternativa_area(2, 'Matemática, física, informática, química ou lógica', [tecnologia_exatas]).
alternativa_area(2, 'Biologia humana ou saúde', [saude_bemestar]).
alternativa_area(2, 'Ecologia, biologia geral ou agropecuária', [biologicas_agrarias]).
alternativa_area(2, 'História, sociologia, filosofia, português, atualidades ou redação', [humanas_sociais]).

pergunta_area(3, '3) Qual ambiente de trabalho te atrai mais?').
alternativa_area(3, 'Escritório corporativo, hotel ou empresa', [negocios]).
alternativa_area(3, 'Empresa de tecnologia, laboratório, obras ou projetos de engenharia', [tecnologia_exatas]).
alternativa_area(3, 'Hospital, clínica, academia ou centros esportivos', [saude_bemestar]).
alternativa_area(3, 'Fazendas experimentais ou centros de pesquisa ambiental', [biologicas_agrarias]).
alternativa_area(3, 'Escola, ONGs, mídias, tribunais ou atividades ligadas ao comportamento humano', [humanas_sociais]).

pergunta_area(4, '4) Como você prefere ajudar a sociedade?').
alternativa_area(4, 'Melhorando empresas e o turismo', [negocios]).
alternativa_area(4, 'Criando tecnologias, estruturas, dispositivos ou produtos científicos', [tecnologia_exatas]).
alternativa_area(4, 'Cuidando da saúde física/mental e promovendo qualidade de vida', [saude_bemestar]).
alternativa_area(4, 'Preservando o meio ambiente e seres vivos', [biologicas_agrarias]).
alternativa_area(4, 'Difundindo cultura, defendendo direitos ou promovendo educação', [humanas_sociais]).

pergunta_area(5, '5) O que você valoriza mais em uma profissão?').
alternativa_area(5, 'Gestão, organização e resultados', [negocios]).
alternativa_area(5, 'Inovação, tecnologia, cálculos e precisão técnica', [tecnologia_exatas]).
alternativa_area(5, 'Contato humano e cuidado com o corpo/mente', [saude_bemestar]).
alternativa_area(5, 'Natureza, sustentabilidade e vida', [biologicas_agrarias]).
alternativa_area(5, 'Expressão, reflexão crítica, comunicação ou justiça', [humanas_sociais]).

pergunta_area(6, '6) Você se considera mais:').
alternativa_area(6, 'Empreendedor e comunicativo', [negocios]).
alternativa_area(6, 'Lógico e interessado por tecnologia, química ou exatas', [tecnologia_exatas]).
alternativa_area(6, 'Cuidadoso, empático ou ativo fisicamente', [saude_bemestar]).
alternativa_area(6, 'Observador da natureza e do meio ambiente', [biologicas_agrarias]).
alternativa_area(6, 'Expressivo, reflexivo, comunicativo ou defensor de direitos', [humanas_sociais]).

pergunta_area(7, '7) Qual desses profissionais você considera mais interessante?').
alternativa_area(7, 'Gestor ou empreendedor', [negocios]).
alternativa_area(7, 'Engenheiro, cientista, programador ou químico', [tecnologia_exatas]).
alternativa_area(7, 'Profissional da saúde ou educador físico', [saude_bemestar]).
alternativa_area(7, 'Biólogo, agrônomo ou zootecnista', [biologicas_agrarias]).
alternativa_area(7, 'Professor, psicólogo, assistente social, historiador, advogado ou comunicador', [humanas_sociais]).

pergunta_area(8, '8) Como você imagina seu impacto futuro?').
alternativa_area(8, 'Transformar empresas e turismo', [negocios]).
alternativa_area(8, 'Criar tecnologias e estruturas inovadoras', [tecnologia_exatas]).
alternativa_area(8, 'Salvar vidas, cuidar da saúde e promover bem-estar', [saude_bemestar]).
alternativa_area(8, 'Contribuir para a preservação e produtividade ambiental', [biologicas_agrarias]).
alternativa_area(8, 'Promover educação, cultura, direitos e compreensão humana', [humanas_sociais]).

% --- PERGUNTAS ETAPA 2 (CURSOS POR MACRO-ÁREA) ---

% Negócios
pergunta_curso(negocios, 1, '1) O que mais te interessa ao pensar em trabalhar com empresas?').
opc_curso(negocios,1,'Liderar equipes e tomar decisões estratégicas', administracao).
opc_curso(negocios,1,'Controlar finanças, impostos e relatórios', contabeis).
opc_curso(negocios,1,'Analisar dados, mercados e economia', economia).
opc_curso(negocios,1,'Organizar comunicação e processos executivos internacionais', secretariado_executivo).
opc_curso(negocios,1,'Criar experiências de lazer, viagens e cultura', turismo).
opc_curso(negocios,1,'Gerenciar hotéis, eventos e atendimento ao público', hotelaria).

pergunta_curso(negocios, 2, '2) Em qual ambiente você mais se imagina atuando?').
opc_curso(negocios,2,'Na liderança de uma empresa', administracao).
opc_curso(negocios,2,'Em escritório analisando números e legislações', contabeis).
opc_curso(negocios,2,'Em consultorias e instituições financeiras', economia).
opc_curso(negocios,2,'Em ambientes corporativos internacionais', secretariado_executivo).
opc_curso(negocios,2,'Em agências de viagem ou roteiros culturais', turismo).
opc_curso(negocios,2,'Em hotéis e empreendimentos de hospitalidade', hotelaria).

pergunta_curso(negocios, 3, '3) Que habilidade você gostaria de fortalecer?').
opc_curso(negocios,3,'Coordenação e tomada de decisão', administracao).
opc_curso(negocios,3,'Precisão numérica e análise fiscal', contabeis).
opc_curso(negocios,3,'Interpretação de dados e projeções', economia).
opc_curso(negocios,3,'Comunicação multilíngue e organização executiva', secretariado_executivo).
opc_curso(negocios,3,'Planejamento de experiências e serviços turísticos', turismo).
opc_curso(negocios,3,'Gestão operacional e atendimento ao cliente', hotelaria).

% Tecnologia e Exatas
pergunta_curso(tecnologia_exatas,1,'1) Que tipo de criação técnica te atrai mais?').
opc_curso(tecnologia_exatas,1,'Desenvolver softwares e sistemas inteligentes', computacao).
opc_curso(tecnologia_exatas,1,'Projetar circuitos e sistemas de energia', engenharia_eletrica).
opc_curso(tecnologia_exatas,1,'Criar máquinas e dispositivos mecânicos', engenharia_mecanica).
opc_curso(tecnologia_exatas,1,'Desenvolver processos industriais e produtos químicos', engenharia_quimica).
opc_curso(tecnologia_exatas,1,'Construir estruturas urbanas e infraestrutura', engenharia_civil).
opc_curso(tecnologia_exatas,1,'Criar soluções técnicas para o campo', engenharia_agricola).
opc_curso(tecnologia_exatas,1,'Resolver problemas lógicos e ensinar matemática', matematica).

pergunta_curso(tecnologia_exatas,2,'2) Com qual desafio você se empolgaria mais?').
opc_curso(tecnologia_exatas,2,'Programar inteligência artificial', computacao).
opc_curso(tecnologia_exatas,2,'Criar sistemas de energia sustentável', engenharia_eletrica).
opc_curso(tecnologia_exatas,2,'Projetar uma máquina mais eficiente', engenharia_mecanica).
opc_curso(tecnologia_exatas,2,'Criar um novo material ou substância', engenharia_quimica).
opc_curso(tecnologia_exatas,2,'Planejar uma ponte ou grande estrutura', engenharia_civil).
opc_curso(tecnologia_exatas,2,'Otimizar irrigação e produção agrícola', engenharia_agricola).
opc_curso(tecnologia_exatas,2,'Resolver teoremas ou problemas abstratos', matematica).

pergunta_curso(tecnologia_exatas,3,'3) Qual desses temas mais te atrai?').
opc_curso(tecnologia_exatas,3,'Algoritmos e lógica computacional', computacao).
opc_curso(tecnologia_exatas,3,'Eletricidade, circuitos e controle', engenharia_eletrica).
opc_curso(tecnologia_exatas,3,'Dinâmica, mecânica e máquinas', engenharia_mecanica).
opc_curso(tecnologia_exatas,3,'Transformações e processos industriais', engenharia_quimica).
opc_curso(tecnologia_exatas,3,'Estruturas e materiais', engenharia_civil).
opc_curso(tecnologia_exatas,3,'Sistemas agrícolas e produtividade', engenharia_agricola).
opc_curso(tecnologia_exatas,3,'Abstrações lógicas e raciocínio', matematica).

% Saúde e Bem-estar
pergunta_curso(saude_bemestar,1,'1) Qual forma de cuidar das pessoas mais combina com você?').
opc_curso(saude_bemestar,1,'Diagnosticar doenças e tomar decisões críticas', medicina).
opc_curso(saude_bemestar,1,'Acompanhar pacientes continuamente', enfermagem).
opc_curso(saude_bemestar,1,'Recuperar movimento e autonomia', fisioterapia).
opc_curso(saude_bemestar,1,'Orientar alimentação para saúde', nutricao).
opc_curso(saude_bemestar,1,'Desenvolver medicamentos e análises laboratoriais', farmacia).
opc_curso(saude_bemestar,1,'Cuidar da saúde bucal', odontologia).
opc_curso(saude_bemestar,1,'Apoiar emocionalmente e compreender comportamentos', psicologia).
opc_curso(saude_bemestar,1,'Promover desempenho físico e exercícios', educacao_fisica).

pergunta_curso(saude_bemestar,2,'2) Onde você se imagina atuando?').
opc_curso(saude_bemestar,2,'Emergências e centros hospitalares', medicina).
opc_curso(saude_bemestar,2,'Enfermarias e atendimento direto', enfermagem).
opc_curso(saude_bemestar,2,'Clínicas de reabilitação', fisioterapia).
opc_curso(saude_bemestar,2,'Consultórios e programas alimentares', nutricao).
opc_curso(saude_bemestar,2,'Laboratórios e indústrias farmacêuticas', farmacia).
opc_curso(saude_bemestar,2,'Clínicas odontológicas', odontologia).
opc_curso(saude_bemestar,2,'Escolas, consultórios ou empresas', psicologia).
opc_curso(saude_bemestar,2,'Academias ou equipes esportivas', educacao_fisica).

pergunta_curso(saude_bemestar,3,'3) O que mais te motiva nesse campo?').
opc_curso(saude_bemestar,3,'Cuidar de vidas sob pressão', medicina).
opc_curso(saude_bemestar,3,'Estar próximo do paciente', enfermagem).
opc_curso(saude_bemestar,3,'Restaurar capacidades físicas', fisioterapia).
opc_curso(saude_bemestar,3,'Melhorar a saúde pelo alimento', nutricao).
opc_curso(saude_bemestar,3,'Criar soluções científicas para tratamentos', farmacia).
opc_curso(saude_bemestar,3,'Cuidar da estética e função bucal', odontologia).
opc_curso(saude_bemestar,3,'Ajudar no bem-estar emocional', psicologia).
opc_curso(saude_bemestar,3,'Incentivar qualidade de vida', educacao_fisica).

% Biológicas e Agrárias
pergunta_curso(biologicas_agrarias,1,'1) Quais atividades te despertam mais interesse?').
opc_curso(biologicas_agrarias,1,'Estudar plantas, animais e ecossistemas', biologicas).
opc_curso(biologicas_agrarias,1,'Trabalhar com plantio, solo e produtividade', agronomia).
opc_curso(biologicas_agrarias,1,'Cuidar de animais de produção e manejo', zootecnia).

pergunta_curso(biologicas_agrarias,2,'2) Onde você se imagina atuando?').
opc_curso(biologicas_agrarias,2,'Laboratórios e pesquisas ambientais', biologicas).
opc_curso(biologicas_agrarias,2,'Fazendas e empresas agrícolas', agronomia).
opc_curso(biologicas_agrarias,2,'Centros de criação animal', zootecnia).

pergunta_curso(biologicas_agrarias,3,'3) Qual tema mais te empolga estudar?').
opc_curso(biologicas_agrarias,3,'Genética, ecologia e meio ambiente', biologicas).
opc_curso(biologicas_agrarias,3,'Solo, fertilização e técnicas agrícolas', agronomia).
opc_curso(biologicas_agrarias,3,'Alimentação e produção animal', zootecnia).

pergunta_curso(biologicas_agrarias,4,'4) O que mais combina com seu perfil?').
opc_curso(biologicas_agrarias,4,'Curioso e investigativo sobre a natureza', biologicas).
opc_curso(biologicas_agrarias,4,'Prático e orientado a resultados produtivos', agronomia).
opc_curso(biologicas_agrarias,4,'Paciente e cuidadoso com animais', zootecnia).

% Humanas e Sociais
pergunta_curso(humanas_sociais,1,'1) O que mais te motiva a estudar ou trabalhar?').
opc_curso(humanas_sociais,1,'Refletir sobre ideias humanas', filosofia).
opc_curso(humanas_sociais,1,'Entender o passado e suas influências', historia).
opc_curso(humanas_sociais,1,'Estudar relações entre pessoas e espaço', geografia).
opc_curso(humanas_sociais,1,'Investigar comportamentos coletivos', ciencias_sociais).
opc_curso(humanas_sociais,1,'Compreender emoções e comportamento', psicologia_humanas).
opc_curso(humanas_sociais,1,'Ensinar e desenvolver pessoas', pedagogia).
opc_curso(humanas_sociais,1,'Promover inclusão e acessibilidade educacional', educacao_especial).
opc_curso(humanas_sociais,1,'Apoiar comunidades vulneráveis', servico_social).
opc_curso(humanas_sociais,1,'Defender direitos e atuar com leis', direito).
opc_curso(humanas_sociais,1,'Trabalhar com idiomas, leitura e comunicação', letras).

pergunta_curso(humanas_sociais,2,'2) Em qual destes ambientes você se imagina atuando no futuro?').
opc_curso(humanas_sociais,2,'Universidades ou centros de pesquisa acadêmica', filosofia).
opc_curso(humanas_sociais,2,'Museus, arquivos históricos ou instituições culturais', historia).
opc_curso(humanas_sociais,2,'Escolas, órgãos ambientais ou projetos de geoprocessamento', geografia).
opc_curso(humanas_sociais,2,'Institutos de pesquisa social, ONGs ou estudos de comportamento coletivo', ciencias_sociais).
opc_curso(humanas_sociais,2,'Clínicas, escolas ou empresas com foco em desenvolvimento humano', psicologia_humanas).
opc_curso(humanas_sociais,2,'Escolas de ensino infantil e fundamental, planejamento e desenvolvimento de currículo', pedagogia).
opc_curso(humanas_sociais,2,'Centros de Educação Inclusiva ou escolas para alunos com necessidades especiais', educacao_especial).
opc_curso(humanas_sociais,2,'Órgãos públicos, projetos sociais ou organizações comunitárias', servico_social).
opc_curso(humanas_sociais,2,'Tribunais, escritórios de advocacia ou órgãos de justiça', direito).
opc_curso(humanas_sociais,2,'Editoras, escolas de idiomas, comunicação digital ou produção textual', letras).

pergunta_curso(humanas_sociais,3,'3) Que tipo de atividade intelectual você mais aprecia?').
opc_curso(humanas_sociais,3,'Debater ideias filosóficas', filosofia).
opc_curso(humanas_sociais,3,'Analisar fatos históricos', historia).
opc_curso(humanas_sociais,3,'Estudar fenômenos geográficos', geografia).
opc_curso(humanas_sociais,3,'Observar e interpretar comportamento coletivo', ciencias_sociais).
opc_curso(humanas_sociais,3,'Analisar a mente humana', psicologia_humanas).
opc_curso(humanas_sociais,3,'Planejar e aplicar métodos de ensino', pedagogia).
opc_curso(humanas_sociais,3,'Desenvolver estratégias de inclusão', educacao_especial).
opc_curso(humanas_sociais,3,'Criar políticas públicas e projetos sociais', servico_social).
opc_curso(humanas_sociais,3,'Analisar leis e argumentação jurídica', direito).
opc_curso(humanas_sociais,3,'Trabalhar com textos, línguas e comunicação', letras).

% ---------------- API PREDICATES ----------------

% Dinamicos para calculo de estado
:- dynamic pontos/2.
:- dynamic contador/2.

% --- API 1: Retorna lista de listas: [[ID, Texto, [Opcoes]], ...] ---
api_get_questions1(Questions) :-
    findall([ID, Texto, Alts],
            (pergunta_area(ID, Texto),
             get_alternatives_text_only(ID, Alts)),
            Questions).

get_alternatives_text_only(ID, AltsList) :-
    findall(Text, alternativa_area(ID, Text, _), L0),
    shuffle_list(L0, AltsList).

shuffle_list(List, Shuffled) :- random_permutation(List, Shuffled).

% --- API CALC 1 ---
api_calc_stage1(SelectedTexts, TopAreas) :-
    reset_pontos,
    process_selected_texts(SelectedTexts),
    get_top_areas(3, TopAreas).

reset_pontos :-
    retractall(pontos(_,_)),
    forall(area(A), assertz(pontos(A, 0))).

process_selected_texts([]).
process_selected_texts([Text|Rest]) :-
    (alternativa_area(_, Text, Areas) ->
        add_points_list(Areas)
    ; true),
    process_selected_texts(Rest).

add_points_list([]).
add_points_list([A|T]) :-
    (pontos(A, P) ->
        P1 is P + 1,
        retract(pontos(A, P)),
        assertz(pontos(A, P1))
    ; true),
    add_points_list(T).

get_top_areas(N, TopAreas) :-
    findall(P-A, pontos(A,P), Pairs),
    sort(0, @>=, Pairs, Sorted),
    take_top_n(Sorted, N, TopAreas).

take_top_n([], _, []).
take_top_n(_, 0, []).
take_top_n([_-Area|T], N, [Area|Rest]) :-
    N > 0,
    N1 is N - 1,
    take_top_n(T, N1, Rest).

% --- API 2: Retorna lista de listas: [[Area, ID, Texto, [Opcoes]], ...] ---
api_get_questions2(Areas, Questions) :-
    findall([Area, ID, Texto, Alts],
            (member(Area, Areas),
             pergunta_curso(Area, ID, Texto),
             get_course_alternatives(Area, ID, Alts)),
            Questions).

get_course_alternatives(Area, ID, Alts) :-
    findall(Text, opc_curso(Area, ID, Text, _), L0),
    shuffle_list(L0, Alts).

% --- API FINAL: Retorna lista de listas: [[Score, Curso], ...] ---
api_calc_final(SelectedTexts, Ranking) :-
    % 1. Inicializa contadores com pontos da etapa 1
    inicializar_contadores_com_pontos_area, 
    % 2. Soma pontos da etapa 2
    process_course_answers(SelectedTexts),
    % 3. Calcula MÉDIA e gera ranking
    get_course_ranking_media(Ranking).

% Define unificações (Aliases)
resolver_nome_curso(psicologia_humanas, psicologia) :- !.
resolver_nome_curso(X, X).

% Inicializa
inicializar_contadores_com_pontos_area :-
    retractall(contador(_,_)),
    forall(curso(Area, CursoRaw),
           (
               resolver_nome_curso(CursoRaw, CursoReal),
               (pontos(Area, P) -> PontosArea = P ; PontosArea = 0),
               adicionar_ao_contador(CursoReal, PontosArea)
           )).

% Auxiliar para somar pontos
adicionar_ao_contador(Curso, Pontos) :-
    (contador(Curso, ValorAtual) ->
        NovoValor is ValorAtual + Pontos,
        retract(contador(Curso, ValorAtual)),
        assertz(contador(Curso, NovoValor))
    ; assertz(contador(Curso, Pontos))).

% Processa respostas etapa 2
process_course_answers([]).
process_course_answers([Text|Rest]) :-
    (opc_curso(_, _, Text, CursoRaw) ->
        resolver_nome_curso(CursoRaw, CursoReal),
        adicionar_ao_contador(CursoReal, 1)
    ; true),
    process_course_answers(Rest).

% --- CÁLCULO DA MÉDIA ---

% Conta quantas perguntas existem na Etapa 1 + Etapa 2 para uma dada Area
contar_perguntas_da_area(Area, Total) :-
    % Etapa 1: conta todas as perguntas de área (pois todas as áreas competem nelas)
    findall(ID1, pergunta_area(ID1, _), L1),
    length(L1, Qtd1),
    % Etapa 2: conta apenas perguntas desta área específica
    findall(ID2, pergunta_curso(Area, ID2, _), L2),
    length(L2, Qtd2),
    Total is Qtd1 + Qtd2.

% Soma o total de perguntas de uma lista de áreas
somar_perguntas_areas([], 0).
somar_perguntas_areas([Area|Resto], Total) :-
    contar_perguntas_da_area(Area, Qtd),
    somar_perguntas_areas(Resto, SubTotal),
    Total is Qtd + SubTotal.

% Calcula a média individual de um curso
calcular_media_curso(CursoReal, ScoreTotal, Media) :-
    % 1. Descobre quais áreas alimentam este curso (Ex: Psicologia -> [saude, humanas])
    findall(Area, 
            (curso(Area, RawName), resolver_nome_curso(RawName, CursoReal)), 
            Areas),
    sort(Areas, UniqueAreas), % Remove duplicatas se houver
    
    % 2. Soma o total de perguntas possíveis nessas áreas
    somar_perguntas_areas(UniqueAreas, Denominador),
    
    % 3. Faz a divisão (evitando divisão por zero)
    (Denominador > 0 -> 
        MediaRaw is ScoreTotal / Denominador,
        % Multiplica por 10 para ficar uma nota tipo "7.5" em vez de "0.75"
        Media is MediaRaw * 10
    ; Media = 0).

get_course_ranking_media(Ranking) :-
    findall([Media, C], 
            (contador(C, V), V > 0, calcular_media_curso(C, V, Media)), 
            Pairs),
    sort(1, @>=, Pairs, Ranking).