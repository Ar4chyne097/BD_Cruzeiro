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
-- a4 - 14/09/2026
create table tb_disciplinas(
id_disc_pk int primary key auto_increment,
nome varchar(60),
cursos varchar(60)
);

insert into tb_disciplinas(nome, cursos) values 
("BD", "ADS"),
("Front End", "ADS"),
("JAVA", "CCP"),
("Cálculo I", "Matemática"),
("Cálculo II", "Matemática"),
("Álgebra Linear", "Matemática"),
("Redes","Engenharia de Software");

-- select * from tb_disciplinas;

create table tb_alunos(
id_aln_pk int primary key auto_increment,
nome varchar(50) not null,
curso varchar(50)
);

/*update tb_disciplinas
set cursos = "Física"
where id_disc_pk = 5;

update tb_disciplinas
set cursos = "Engenharia Civil"
where id_disc_pk = 6;*/

insert into tb_alunos(nome, curso) values 
("João", "ADS"),
("Maria", "CCP"),
("Fernanda", "Matemática"),
("Clarice", "Física"),
("Ronaldo", "Engenharia Civil"),
("Vitor", "Engenharia de Software");

-- select * from tb_alunos;

create table tb_alnDisc(
id_aluno int,
id_disciplinas int,
primary key(id_aluno, id_disciplinas),
foreign key(id_aluno) references tb_alunos(id_aln_pk),
foreign key(id_disciplinas) references tb_disciplinas(id_disc_pk)
);

insert into tb_alnDisc(id_aluno, id_disciplinas) 
values
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(6, 7);

select id_aluno, id_disciplinas from tb_alnDisc
inner join tb_alunos
on tb_alnDisc.id_aluno = tb_alunos.id_aln_pk
inner join tb_disciplinas
on tb_alnDisc.id_disciplinas = tb_disciplinas.id_disc_pk;

create table tb_professor(
id_aln_pf int primary key auto_increment,
nome varchar(50) not null,
curso varchar(50),
disciplina varchar(50)
);

alter table tb_professor
rename column id_aln_pf to id_prf_pk;

insert into tb_professor(nome, curso, disciplina) values 
("Vladmir", "ADS", "BD"),
("Alexandra", "ADS", "Front End"),
("Ivan", "CCP", "JAVA"),
("Nicolau", "Matemática", "Cálculo I"),
("Alexandre", "Física", "Cálculo II"),
("Catarina", "Engenharia Civil", "Álgebra Linear"),
("Anna", "Engenharia de Software", "Redes");

select * from tb_professor;

alter table tb_alnDisc
rename to tb_chaves;

select * from tb_chaves;

alter table tb_chaves
add id_prof int;



alter table tb_chaves
add primary key(id_prof),
add foreign key(id_prof) references tb_professor(id_prf_pk);

insert into tb_chaves(id_prof, id_disciplinas)
values
(1, 1),
(2, 1),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7);

select * from tb_chaves;