-- dotpad/db_af_2026
create database bd_banquinho;
use bd_banquinho;

create table tb_funcionarios(
id_func_pk int primary key auto_increment,
nome varchar(50),
salario float,
idade int,
sexo enum("M", "F", "I"),
cargo varchar(50)
);

insert into tb_funcionarios(nome, salario, idade, sexo, cargo) values
("Oswaldo Moles", 1299.98, 54, "M", "Radialista"),
("Orlando", 1000.02 ,48, "I", "Coronel"),
("Valmir", "8.09", 98, "M", "Enxadrista"),
("Frida", "500000000.02", 47, "F", "Desenhista"),
("Amélia", "7.987", 40, "F", "Pilota");

select * from tb_funcionarios;
select nome, salario from tb_funcionarios;

select * from tb_funcionarios where nome = "Valmir";
select * from tb_funcionarios where salario > 200;
select * from tb_funcionarios where salario < 5000;
select * from tb_funcionarios where salario >= 1500;
select * from tb_funcionarios where salario <= 1354;
select * from tb_funcionarios where salario <> 1250;
select * from tb_funcionarios where salario != 1250;

select * from tb_funcionarios where idade > 18 and salario > 200;
select * from tb_funcionarios where idade > 18 or salario > 200;

select max(salario), min(salario), sum(salario), avg(salario) FROM tb_funcionarios;

select * from tb_funcionarios order by nome;
select * from tb_funcionarios order by nome asc;
select * from tb_funcionarios order by nome desc;

select nome, upper(nome), lower(nome), substr(nome, 1,3) from tb_funcionarios;
select nome, upper(substr(nome, 1,3)) from tb_funcionarios;
select nome, upper(substr(nome, 1,3)) from tb_funcionarios order by nome;
select nome, instr(nome, 't') from tb_funcionarios;
select nome, replace(nome, 'tt', 'vv') from tb_funcionarios;
select nome, length(nome) from tb_funcionarios;
select distinct(nome) from tb_funcionarios;

select * from tb_funcionarios where idade > 10 and idade < 30;
select * from tb_funcionarios where idade BETWEEN 10 and 30;
select * from tb_funcionarios where id_func_pk = 1;
select * from tb_funcionarios where id_func_pk in (1,3,5);

insert into tb_funcionarios(nome, idade, cargo) values("Helena", 18, "Desenvolvedora de Jogos");

select * from tb_funcionarios;
select * from tb_funcionarios where sexo is null;
select * from tb_funcionarios where nome is not null;

select * from tb_funcionarios where nome like 'g%';
select * from tb_funcionarios where nome like '%ER';
select * from tb_funcionarios where nome like '%g%';

-- Aula 04_09_26
create table tb_departamento(
id_dep_pk int primary key auto_increment,
nome varchar(30)
);

insert into tb_departamento(nome) values
("T.I."),
("Jurídico"),
("R.H."),
("Finanças"),
("Administrativo"),
("Contabilidade");

drop table tb_funcionarios;
show tables;

create table tb_funcionarios(
id_func_pk int primary key auto_increment,
nome varchar(50) not null,
salario float,
idade tinyint(3),
sexo enum("M", "F", "I"),
cargo varchar(30),
dep int,
constraint fk_dep foreign key(dep) references tb_departamento(id_dep_pk)
);

select * from tb_departamento;

insert into tb_funcionarios(nome, salario, idade, sexo, cargo, dep) values
("Adelaide", 1924.56, 38, "I", "Advogada", 2),
("Brione", 1998.55, 39, "F", "Contadora", 6),
("Klara", 0.98, 40, "M", "CEO", 5),
("Doralice", 0.99, 41, "I", "Recrutador", 3),
("Héracles", 1.001, 42, "F", "Gestor de fundos", 4),
("José", 1.98, 37, "F", "Analista de Sistemas", 1);

select * from tb_funcionarios where dep = 1;
select nome, dep from tb_funcionarios;

select * from tb_funcionarios
inner join tb_departamento
on tb_funcionarios.dep = tb_departamento.id_dep_pk;

select * from tb_funcionarios where salario > (select avg(salario) from tb_funcionarios);
select * from tb_funcionarios where salario > (select avg(salario) from tb_funcionarios where dep = (select id_dep_pk from tb_departamento where nome = 'Jurídico'));

select * from tb_funcionarios;

-- set SQL_SAFE_UPDATES = 0;
/*insert into tb_departamento(nome) values ("Contabilidade");

insert into tb_funcionarios(nome, salario, idade, sexo, cargo, dep) values
("Brione", 1998.55, 39, "F", "Contadora", 7);*/

update tb_funcionarios set sexo = 'M' where nome = 'José';
delete from tb_funcionarios where dep = 1;
delete from tb_departamento where id_dep_pk = 6;

-- ================================================================================
select dep, avg(salario) from tb_funcionarios group by dep;
select dep, avg(salario) FROM tb_funcionarios group by dep HAVING AVG(salario)  < 850;

select count(dep) from tb_funcionarios;
select count(*) from tb_funcionarios;
select count(dep) from tb_funcionarios group by dep;
select dep, count(*) from tb_funcionarios where dep != 1 group by dep;

select * from tb_funcionarios where id_func_pk in(3,4);

-- ==============================================================================
select * from tb_funcionarios where id_func_pk not in(3,4);
select dep, count(*) from tb_funcionarios where id_func_pk in(3,4) group by dep;

select dep from tb_funcionarios where id_func_pk in(3,4) group by dep;
 
select dep from tb_funcionarios where id_func_pk NOT IN(3,4) group by dep;

select dep from tb_funcionarios where id_func_pk NOT IN(3,4) group by dep order by dep;
 
select dep, cargo from tb_funcionarios  where id_func_pk NOT IN(1,2) group by dep, cargo;
 
select * from tb_funcionarios;

alter table tb_funcionarios add(rg varchar(30));
alter table tb_funcionarios modify column rg INT;
alter table tb_funcionarios drop column rg;

select * from tb_funcionarios;

alter table tb_departamento add(qtd_func int);
select * from tb_departamento;

-- ============================================================================
show tables;
select * from tb_departamento;
select * from tb_funcionarios;

alter table tb_departamento change nome nome_dep varchar(50);
-- ============================================================================
-- a4 - 14/09/2026
create table tb_disciplinas(
id_disc_pk int primary key auto_increment,
nome_disc varchar(50)
);

insert into tb_disciplinas(nome_disc) values 
("Cálculo I"),
("Cálculo II"),
("Álgebra Linear"),
("Física Quântica "),
("Termodinâmica"),
("Mecânica"),
("Eletrostática");

select * from tb_disciplinas;

create table tb_cursos(
id_crs_pk int primary key auto_increment,
nome_curso varchar(50)
);

insert into tb_cursos(nome_curso) values
("Matemática"),
("Física");

select * from tb_cursos;

create table tb_alunos(
id_aln_pk int primary key auto_increment,
nome varchar(50),
id_curso int,
constraint foreign key(id_curso) references tb_cursos(id_crs_pk)
);

insert into tb_alunos(nome, id_curso) values 
("Guilherme", 1),
("Adelaide", 2),
("Nelson", 1),
("Rosa", 2),
("João", 1),
("Gilberto", 1),
("Ana", 2),
("Maria", 2);

select * from tb_alunos;

create table tb_professor(
id_prof_pk int primary key auto_increment,
nome varchar(50),
disciplina int,
constraint foreign key(disciplina) references tb_disciplinas(id_disc_pk)
);

insert into tb_professor(nome, disciplina) values 
("Feyman", 7),
("Daria", 5),
("Carlos", 3),
("Brenda", 1),
("Ariel", 2),
("Jasmine", 4),
("Frida", 6);

select * from tb_professor;

create table chaves(
id_chv_pk int primary key auto_increment,
id_aluno int,
id_prof int,
id_curso int,
id_disc int,
constraint foreign key(id_aluno) references tb_alunos(id_aln_pk),
constraint foreign key(id_prof) references tb_professor(id_prof_pk),
constraint foreign key(id_curso) references tb_cursos(id_crs_pk),
constraint foreign key(id_disc) references tb_disciplinas(id_disc_pk)
);

alter table chaves
rename to tb_chaves;

alter table tb_alunos
change id_curso curso int;

select * from tb_alunos;
select * from tb_professor;
select * from tb_cursos;
select * from tb_disciplinas;
select * from tb_chaves;

select id_aluno, id_prof, id_curso, id_disc from tb_chaves
inner join tb_alunos on tb_chaves.id_aluno = tb_alunos.id_aln_pk
inner join tb_professor on tb_chaves.id_prof = tb_professor.id_prof_pk
inner join tb_cursos on tb_chaves.id_curso = tb_cursos.id_crs_pk
inner join tb_disciplinas on tb_chaves.id_disc = tb_disciplinas.id_disc_pk;

insert into tb_chaves(id_aluno, id_prof, id_curso, id_disc) values
(1, 4, 1, 1),
(2, 5, 2, 2),
(3, 3, 1,  3),
(4, 6, 2, 4),
(5, 2, 1, 5),
(6, 7, 1, 6),
(7, 1, 2, 7),
(8, 4, 2, 1);