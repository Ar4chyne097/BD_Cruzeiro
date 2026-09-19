-- dotpad/db_af_2026
CREATE DATABASE db_xpto;
USE db_xpto;

CREATE TABLE tb_funcionarios(
  id_func_pk INT PRIMARY KEY AUTO_INCREMENT,
  nome       VARCHAR(30) NOT NULL,
  salario    FLOAT, 
  idade      INT,
  sexo       CHAR(1) CHECK(SEXO IN('F','M', 'f', 'm')),
  cargo      VARCHAR(30)
);

INSERT INTO 
tb_funcionarios(nome, salario, idade, sexo, cargo) 
VALUES('Anitta', 250.23, 71, 'f', 'Estoquista');

INSERT INTO 
tb_funcionarios(nome, salario, idade, sexo, cargo) 
VALUES('Belo', 8900.25, 71, 'f', 'Estoquista');

/*INSERT INTO 
tb_funcionarios( salario, idade, sexo, cargo) 
VALUES(8900.25, 71, 'f', 'Estoquista');*/

-- comenta uma linha
/*Comenta um bloco*/

SELECT * FROM tb_funcionarios;
SELECT nome, salario FROM tb_funcionarios;
SELECT * FROM tb_funcionarios WHERE nome = 'Anitta';
SELECT * FROM tb_funcionarios WHERE salario > 200;
SELECT * FROM tb_funcionarios WHERE salario < 5000;
SELECT * FROM tb_funcionarios WHERE salario >= 1500;
SELECT * FROM tb_funcionarios WHERE salario <= 1354;
SELECT * FROM tb_funcionarios WHERE salario <> 1250;
SELECT * FROM tb_funcionarios WHERE idade > 18 AND salario > 200;
SELECT * FROM tb_funcionarios WHERE idade > 18 OR salario > 200;
SELECT MAX(salario), MIN(salario), SUM(salario), AVG(salario)
FROM tb_funcionarios;
SELECT * FROM tb_funcionarios ORDER BY nome;
SELECT * FROM tb_funcionarios ORDER BY nome ASC;
SELECT * FROM tb_funcionarios ORDER BY nome DESC;
SELECT nome, UPPER(nome), LOWER(nome), SUBSTR(nome, 1,3) FROM tb_funcionarios;
SELECT nome, UPPER(SUBSTR(nome, 1,3)) FROM tb_funcionarios;
SELECT nome, UPPER(SUBSTR(nome, 1,3)) FROM tb_funcionarios ORDER BY nome;
SELECT nome, INSTR(nome, 't') FROM tb_funcionarios;
SELECT nome, REPLACE(nome, 'tt', 'vv') FROM tb_funcionarios;
SELECT nome, LENGTH(nome) FROM tb_funcionarios;
SELECT DISTINCT(nome) FROM tb_funcionarios;

SELECT * FROM tb_funcionarios WHERE idade > 10 AND idade < 30;
SELECT * FROM tb_funcionarios WHERE idade BETWEEN 10 AND 30;
SELECT * FROM tb_funcionarios WHERE id_func_pk = 1;
SELECT * FROM tb_funcionarios WHERE id_func_pk IN (1,3,5);

INSERT INTO tb_funcionarios(nome, salario) 
VALUES('Gugu', 200);

SELECT * FROM tb_funcionarios;
SELECT * FROM tb_funcionarios WHERE idade IS NULL;
SELECT * FROM tb_funcionarios WHERE idade IS NOT NULL;

SELECT * FROM tb_funcionario WHERE nome LIKE 'g%';
SELECT * FROM tb_funcionario WHERE nome LIKE '%ER';
SELECT * FROM tb_funcionario WHERE nome LIKE '%g%';

-- Aula 04_09_26
CREATE TABLE tb_departamento(
  id_dep_pk INT PRIMARY KEY AUTO_INCREMENT,
  nome      VARCHAR(30)
  );

INSERT INTO tb_departamento(nome) VALUES('T.I.');
INSERT INTO tb_departamento(nome) VALUES('Estoque');
INSERT INTO tb_departamento(nome) VALUES('ADM');
INSERT INTO tb_departamento(nome) VALUES('Contabilidade');

DROP TABLE tb_funcionarios;
show tables;

CREATE TABLE tb_funcionarios(
  id_func_pk INT PRIMARY KEY AUTO_INCREMENT,
  nome       VARCHAR(30) NOT NULL,
  salario    FLOAT, 
  idade      INT,
  sexo       CHAR(1) CHECK(SEXO IN('F','M', 'f', 'm')),
  cargo      VARCHAR(30), 
  dep        INT,
  CONSTRAINT fk_dep FOREIGN KEY (dep) REFERENCES 
  tb_departamento(id_dep_pk)
);

SELECT * FROM tb_departamento;

INSERT INTO 
tb_funcionarios(nome, salario, idade, sexo, cargo, dep) 
VALUES('Anitta', 250.23, 71, 'f', 'Estoquista', 2);

INSERT INTO 
tb_funcionarios(nome, salario, idade, sexo, cargo, dep) 
VALUES('Belo', 8900.25, 71, 'f', 'Estoquista', 2);

INSERT INTO 
tb_funcionarios(nome, salario, idade, sexo, cargo) 
VALUES('Gugu', 8900.25, 71, 'f', 'Estoquista');

SELECT * FROM tb_funcionarios WHERE dep = 1;
SELECT * FROM tb_funcionarios WHERE dep = (SELECT id_dep_pk FROM tb_departamento WHERE nome = 'T.I.');

SELECT id_dep_pk FROM tb_departamento WHERE nome = 'T.I.';

SELECT * FROM tb_funcionarios WHERE salario > (SELECT AVG(salario) FROM tb_funcionarios);

SELECT * FROM tb_funcionarios WHERE salario > (SELECT AVG(salario) FROM tb_funcionarios WHERE dep = (SELECT id_dep_pk FROM tb_departamento WHERE nome = 'Estoque'));
select * from tb_funcionarios;
UPDATE tb_funcionarios SET sexo = 'M' WHERE nome = 'Gugu';
DELETE FROM tb_departamento WHERE id_dep_pk = 2;
DELETE FROM tb_funcionarios WHERE dep = 2;

-- ================================================================================
SELECT dep, AVG(salario) FROM tb_funcionarios GROUP BY dep;

SELECT dep, AVG(salario) FROM tb_funcionarios 
GROUP BY dep HAVING AVG(salario)  < 850;

SELECT COUNT(dep) FROM tb_funcionarios;
SELECT COUNT(*) FROM tb_funcionarios;
SELECT COUNT(dep) FROM tb_funcionarios GROUP BY dep;

SELECT dep, COUNT(*) FROM tb_funcionarios 
WHERE dep <> 1 GROUP BY dep;

SELECT * FROM tb_funcionarios WHERE id_func_pk IN(3,4);


-- ==============================================================================
SELECT * FROM tb_funcionarios WHERE id_func_pk NOT IN(3,4);
SELECT dep, count(*) FROM tb_funcionarios
 WHERE id_func_pk IN(3,4) GROUP BY dep; 

SELECT dep FROM tb_funcionarios
 WHERE id_func_pk IN(3,4) GROUP BY dep;
 
 SELECT dep FROM tb_funcionarios
 WHERE id_func_pk NOT IN(3,4) GROUP BY dep;

 SELECT dep FROM tb_funcionarios
 WHERE id_func_pk NOT IN(3,4) GROUP BY dep ORDER BY dep;
 
 SELECT dep, cargo FROM tb_funcionarios 
 WHERE id_func_pk NOT IN(1,2) GROUP BY dep, cargo;
 
SELECT * FROM tb_funcionarios;

ALTER TABLE tb_funcionarios ADD(rg VARCHAR(30));
ALTER TABLE tb_funcionarios MODIFY COLUMN rg INT;
ALTER TABLE tb_funcionarios DROP COLUMN rg;

SELECT * FROM tb_funcionarios;

ALTER TABLE tb_departamento ADD(qtd_func INT);
SELECT * FROM tb_departamento;

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