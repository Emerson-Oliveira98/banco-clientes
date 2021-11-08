create database loccar;
use loccar;

--CRIANDO A TABELA FABRICANTE --

create table fabricante (id_fabricante int not null constraint id_fabricante_pk primary key identity,
nome_fabricante nvarchar(20),dt_cadastro datetime default getdate());

select * from fabricante;

insert into fabricante(nome_fabricante)
values ('FORD');





--CRIANDO A TABELA TIPO_VEICULO--
create table tipo_veiculo(id_tipo_veiculo int not null constraint id_tipo_veiculo_pk primary key identity,
nome_tipo nvarchar(20),
dt_cadastro datetime default getdate());

select * from tipo_veiculo;



insert into tipo_veiculo(nome_tipo)
values                  ('SEDAN');

		
		
	
	
		
--CRIANDO A TABELA VEICULO--
create table veiculo(id_veiculo int not null constraint id_veiculo_pk primary key identity,
modelo nvarchar(20) not null,
descricao nvarchar(30) not null,
placa char(7) not null constraint uq_placa unique,
chassis	char(17) not null constraint uq_chassis unique,
id_fabricante_fk int not null constraint id_fabricante_fk foreign key references fabricante(id_fabricante) on delete cascade on update cascade,
id_tipo_veiculo int not null constraint id_tipo_veiculo_fk foreign key references tipo_veiculo(id_tipo_veiculo) on delete cascade on update cascade,
kms decimal (6,0));
					
					
select * from veiculo;
		


insert into veiculo(modelo,descricao,placa,chassis,id_fabricante_fk,id_tipo_veiculo,kms)
values            ('FUSION','PRETO, CARRO CONFORTAVEL','ETM5621','12345678998745632',1,1,0);
insert into veiculo(modelo,descricao,placa,chassis,id_fabricante_fk,id_tipo_veiculo,kms)
values            ('FUSION','PRETO, CARRO CONFORTAVEL','EYL9566','12345678998745633',1,1,0);

update veiculo set kms='56450' where placa ='EYL9566';


							
	
	
	
	
							
--CRIANDO A TABELA CLIENTES--
create table cliente (id_cliente int not null constraint id_cliente_pk primary key identity,
nome_cliente nvarchar(20) not null,
sobrenome_cliente nvarchar(40) not null,
sexo char(1) not null constraint ck_cli_sexo check(sexo in ('m','f')),
idade tinyint null constraint ck_cli_idade check(idade>=18),
data_nascimento date not null,
cpf decimal(11,0) not null constraint uq_cpf unique,
dt_cadastro datetime null default getdate());

select * from cliente;

insert into cliente(nome_cliente,sobrenome_cliente,sexo,idade,data_nascimento,cpf)
values          ('pedro','henrique','m','19','26-06-1997','99945678912');








--CRIANDO A TABELA TELEFONE--
create table telefone(id_telefone int not null constraint id_telefone_pk primary key identity,
num_tel numeric(9,0) not null constraint uq_num_tel unique,
dt_registro_tel datetime default getdate());

select * from telefone;

insert into telefone(num_tel)
values      ('942422518');




--CRIANDO A TABELA CONTATO TELEFONE--
Create TABLE contato_telefone (id_contato_telefone int constraint id_contato_telefone_pk primary key identity,
id_cliente_fk int not null constraint id_cliente_fk foreign key references cliente(id_cliente) on delete cascade on update cascade);

alter table contato_telefone add id_telefone_fk int not null constraint id_telefone_fk foreign key references telefone (id_telefone)on delete cascade on update cascade;

 
select * from contato_telefone;

insert into contato_telefone(id_cliente_fk,id_telefone_fk)
values                      (1,1);



--CRIANDO A TABELA LOCACAO--
create table locacao (id_locacao int not null constraint id_locacao_pk primary key identity,
dt_retirada date not null,
dt_entrega date not null,
id_veiculo_fk int not null constraint id_veiculo_fk foreign key references veiculo(id_veiculo) on delete cascade on update cascade,
id_cliente_fk int not null constraint id_cliente_fk2 foreign key references cliente(id_cliente) on delete cascade on update cascade,
dt_cadastro datetime null default getdate());

alter table locacao add contato_telefone_fk int  null constraint contato_telefone_fk foreign key references contato_telefone(id_contato_telefone);


select * from locacao;

insert into locacao (dt_retirada,dt_entrega,id_veiculo_fk,id_cliente_fk,contato_telefone_fk)
values             ('23-04-2015','30-04-2015',1,1,1);




--SELECIONANDO O NOME DO CLIENTE,TELEFONE DO CLIENTE,TIPO DO CARRO,DATA DA RETIRADA DA LOCACAO--
select cliente.nome_cliente,telefone.num_tel,veiculo.modelo,locacao.dt_retirada from locacao
inner join cliente on locacao.id_cliente_fk = cliente.id_cliente
inner join contato_telefone on locacao.contato_telefone_fk=contato_telefone.id_contato_telefone
inner join telefone on contato_telefone.id_telefone_fk =telefone.id_telefone
inner join veiculo on locacao.id_veiculo_fk = veiculo.id_veiculo
where YEAR(locacao.dt_retirada) = 2015;


																																		







