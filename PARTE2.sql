create database bbtransportes;
use bbtransportes;

create table departamento(id_departamento int not null constraint id_departamento_pk primary key identity,
nome_departamento nvarchar(20) not null,
departamento_local nvarchar(20) not null);

delete departamento where id_departamento = 1;


insert into departamento(nome_departamento,departamento_local)
values                 ('RH','Primeiro Andar');
insert into departamento(nome_departamento,departamento_local)
values                 ('TeleComunicacao','Primeiro Andar');
insert into departamento(nome_departamento,departamento_local)
values                 ('Vendas','Segundo Andar');
insert into departamento(nome_departamento,departamento_local)
values                 ('Gerencia','Terceiro Andar');
insert into departamento(nome_departamento,departamento_local)
values                 ('TI','Segundo Andar');


create table funcionario (id_funcionario int not null constraint id_funcionario_pk primary key identity,
nome_funcionario nvarchar(20) not null,
sobrenome_funcionario nvarchar(20) not null,
data_de_nascimento date not null,
cpf nchar(12) not null constraint uq_cpf unique,
endereco nvarchar(20) not null,
cep nchar(8) not null,
cidade nchar(10) not null,
telefone nvarchar(20) not null,
id_departamento_fk int not null constraint id_departamento_fk foreign key references departamento(id_departamento) on delete cascade on update cascade,
funcao nvarchar(20) not null,
salario money);

select * from funcionario;

insert into funcionario(nome_funcionario,sobrenome_funcionario,data_de_nascimento,cpf,endereco,cep,cidade,telefone,id_departamento_fk,funcao,salario)
values                 ('Ryan','Bleu Bleu','24-04-1964','24246662424','Rua dos Cotolengos','2424666','Caucaia','9242466624',2,'Conversar','300000');
insert into funcionario(nome_funcionario,sobrenome_funcionario,data_de_nascimento,cpf,endereco,cep,cidade,telefone,id_departamento_fk,funcao,salario)
values                 ('pedro','Pires','26-06-1999','123456789875','Rua Pires','06421545','Caucaia','9242466624',5,'Programar','1000');
insert into funcionario(nome_funcionario,sobrenome_funcionario,data_de_nascimento,cpf,endereco,cep,cidade,telefone,id_departamento_fk,funcao,salario)
values                 ('jhony','Pires','26-06-1999','123456789845','Rua Pires','06421545','Caucaia','9242466624',1,'Diretor de RH','1000');
insert into funcionario(nome_funcionario,sobrenome_funcionario,data_de_nascimento,cpf,endereco,cep,cidade,telefone,id_departamento_fk,funcao,salario)
values                 ('william','Pires','26-06-1999','123459989845','Rua dos sabia','06421545','Campinas','9242466624',3,'Vender','500');

insert into funcionario(nome_funcionario,sobrenome_funcionario,data_de_nascimento,cpf,endereco,cep,cidade,telefone,id_departamento_fk,funcao,salario)
values                 ('Karina','Henrique','26-06-1999','321459989845','Rua dos henriques','06421125','Cotia','9242466624',4,'Vender','2000');
insert into funcionario(nome_funcionario,sobrenome_funcionario,data_de_nascimento,cpf,endereco,cep,cidade,telefone,id_departamento_fk,funcao,salario)
values                 ('william','Pires','26-06-1999','124559989845','Rua dos sabia','06421545','Campinas','9242466624',3,'Professor','500');

delete from funcionario where id_funcionario = 8;

update funcionario set salario = '1500' where salario = '1000';
select funcionario.nome_funcionario,funcionario.sobrenome_funcionario from funcionario order by sobrenome_funcionario desc ;

select funcionario.data_de_nascimento,funcionario.nome_funcionario from funcionario order by YEAR(funcionario.data_de_nascimento) desc;

select funcionario.nome_funcionario,funcionario.funcao,departamento.nome_departamento from funcionario
inner join departamento on funcionario.id_departamento_fk = departamento.id_departamento;

select funcionario.salario, AVG(funcionario.salario) ' Média de Salario' from funcionario
group by (funcionario.salario);

select count(funcionario.nome_funcionario)'Quantidade de Funcionario' from funcionario;

select funcionario.nome_funcionario, MIN(funcionario.salario)'MENOR SALARIO' from funcionario
group by funcionario.nome_funcionario,funcionario.salario;

select funcionario.nome_funcionario,departamento.nome_departamento from funcionario
inner join departamento on funcionario.id_departamento_fk = departamento.id_departamento
order by funcionario.nome_funcionario;

select funcionario.nome_funcionario from funcionario where cidade like 'Campinas' and funcionario.funcao like 'Professor';

select funcionario.nome_funcionario,departamento.nome_departamento from funcionario
inner join departamento on funcionario.id_departamento_fk = departamento.id_departamento
where departamento.nome_departamento like 'V%';

select funcionario.nome_funcionario,departamento.nome_departamento from funcionario
inner join departamento on funcionario.id_departamento_fk = departamento.id_departamento
where departamento.nome_departamento like 'Compras';
