create database empresa

Use empresa

create table funcionario(
cod_func int not null identity,
nome_func varchar(20) not null,
sobrenome_func varchar (30) not null,
data_inicio datetime,
cargo varchar(30),
salario money,
comissao float,
cod_depto int,
gerente int
constraint pk_func Primary key (cod_func)
)

select * from funcionario

insert into funcionario values ('Jose','Dantas',1981-01-17,'presidente',18000,1000,10,NULL)
insert into funcionario values ('Lucas','Silva',1981-08-17,'gerente',8000,NULL,10,1)
insert into funcionario values ('Lucas','Silva',1981-08-17,'gerente',8000,NULL,10,1)
insert into funcionario values ('Marcos','Alcantara',1982-04-17,'gerente',8000,1500,40,1)
insert into funcionario values ('Junior','Souza',1983-01-01,'gerente',8000,NULL,30,1)

create table departamento(
cod_depto int not null,
nome_depto varchar(30) not null,
local_depto varchar(20) not null
constraint pk_depto primary key(cod_depto)
)

insert into departamento values(10,'Administração','SP')
insert into departamento values(30,'Vendas','São Paulo')
insert into departamento values(40,'TECNOLOGIA','Hortolandia')
insert into departamento values(50,'CONTABILIDADE','Campinas')
insert into departamento values(60,'PRODUÇÃO','Campinas')

select * from departamento

create table categoria_trabalho(
cod_cat int not null identity,
menor_salario decimal not null,
maior_salario decimal not null constraint pk_cat primary key(cod_cat)
)

insert into categoria_trabalho values (500,1499)
insert into categoria_trabalho values (1500,2499)
insert into categoria_trabalho values (2500,4499)
insert into categoria_trabalho values (4500,7999)
insert into categoria_trabalho values (8000,9999)
insert into categoria_trabalho values (10000,11199)
insert into categoria_trabalho values (12000,18000)


alter table funcionario
add constraint fk_depto foreign key (cod_depto) references departamento(cod_depto)

--se precisar alterar o gerente para testar a consulta utilize este código, não esqueça de verificar o id do Jose
update funcionario set gerente = 6 where cod_func = 8


/*1.Crie uma consulta para exibir o nome do funcionário, o nome do departamento e a 
localização de todos os funcionários que recebem uma comissão.*/
SELECT f.nome_func, d.nome_depto, d.local_depto
FROM funcionario f  INNER JOIN departamento d
ON (f.comissao IS NOT NULL) AND (f.cod_depto = d.cod_depto)

--OU 
SELECT f.nome_func, f.cod_depto, d.nome_depto, d.local_depto
FROM funcionario f, departamento d
WHERE d.cod_depto = f.cod_depto
AND f.comissao IS NOT NULL

/*2.Crie uma consulta para exibir o nome, o cargo, o número e o nome do departamento e 
local para todos os funcionários que trabalham em São Paulo.*/
SELECT f.nome_func, f.cargo, f.cod_depto, d.nome_depto, d.local_depto
FROM funcionario f INNER JOIN departamento d
ON d.local_depto = 'São Paulo' AND f.cod_depto = d.cod_depto

/*3.Exiba o nome e o número do funcionário junto com o nome e o número do gerente. Coloque um label nas colunas
 Employee, Emp#, Manager e Mgr#, respectivamente */
SELECT e.nome_func "Employee", e.cod_func "Emp#",
m.nome_func "Manager", m.cod_func "Mgr#"
FROM funcionario e, funcionario m
WHERE e.gerente= m.cod_func;
--ou
SELECT e.nome_func "Employee", e.cod_func "Emp#",
m.nome_func "Manager", m.cod_func "Mgr#"
FROM funcionario e JOIN funcionario m
ON e.gerente= m.cod_func;

/*4.Exibir todos os funcionários incluindo José (presidente), que não possuem
um gerente.*/
SELECT e.nome_func "Employee", e.cod_func "Emp#",
m.nome_func "Manager", m.cod_func "Mgr#"
FROM funcionario e LEFT OUTER JOIN funcionario m
ON e.gerente= m.cod_func;



/*Testes*/

select * from funcionario
select * from departamento
select * from categoria_trabalho


select nome_func 'inner', cod_cat, salario, menor_salario, maior_salario from funcionario inner join categoria_trabalho on funcionario.salario = categoria_trabalho.maior_salario
select nome_func 'left', cod_cat, salario, menor_salario, maior_salario from funcionario left join categoria_trabalho on funcionario.salario = categoria_trabalho.maior_salario
select nome_func 'right', cod_cat, salario, menor_salario, maior_salario from funcionario right join categoria_trabalho on funcionario.salario = categoria_trabalho.maior_salario
select nome_func 'left outer', cod_cat, salario, menor_salario, maior_salario from funcionario left outer join categoria_trabalho on funcionario.salario = categoria_trabalho.maior_salario
select nome_func 'right outer', cod_cat, salario, menor_salario, maior_salario from funcionario right outer join categoria_trabalho on funcionario.salario = categoria_trabalho.maior_salario
select nome_func 'join', cod_cat, salario, menor_salario, maior_salario from funcionario join categoria_trabalho on funcionario.salario = categoria_trabalho.maior_salario