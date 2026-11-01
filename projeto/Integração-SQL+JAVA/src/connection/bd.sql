create database db_regioes;
use db_regioes;

create table iniciais(
id_pk int primary key,
nome varchar(30) not null,
tipo1 varchar(30) not null,
tipo2 varchar(30) null
);

select count(nome) from iniciais;
select * from iniciais;