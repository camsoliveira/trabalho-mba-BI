
CREATE TABLE TRAB_STG_CARGO(
	CargoID 	INTEGER NOT NULL,
	Desc_Cargo 	VARCHAR(50) NOT NULL,
 CONSTRAINT PK_Cargo_CargoID PRIMARY KEY (
	CargoID 
));

CREATE TABLE TRAB_STG_DEPARTAMENTO(
	DepartamentoID 		INTEGER NOT NULL,
	Desc_Departamento 	VARCHAR(50),
 CONSTRAINT PK_Departamento_DepartamentoID PRIMARY KEY  
(
	DepartamentoID 
));

CREATE TABLE TRAB_STG_DIVISAO(
	DivisaoID 		INTEGER NOT NULL,
	Desc_Divisao 	VARCHAR(50),
 CONSTRAINT PK_Divisao_DivisaoID PRIMARY KEY  
(
	DivisaoID 
));

CREATE TABLE TRAB_STG_FUNCIONARIO(
	FuncionarioID 			INTEGER NOT NULL,
	Nome_Funcionaro 		VARCHAR(50),
	Sobrenome_Funcionaro 	VARCHAR(50),
 CONSTRAINT PK_Funcionario_FuncionarioID PRIMARY KEY  
(
	FuncionarioID 
));

CREATE TABLE TRAB_STG_MEDIA(
	CBO			 		INTEGER NOT NULL,
	Cargo 			 	VARCHAR(50),
	Jornada				INTEGER,
	Piso 				FLOAT(126),
	Media 				FLOAT(126),
	Maior               FLOAT(126),
	Salario_Hora		FLOAT(126),
 CONSTRAINT PK_Media_CBO PRIMARY KEY  
(
	CBO,
	Cargo
));

CREATE TABLE TRAB_STG_FOLHA_PAGAMENTO(
	FuncionarioID		INTEGER NOT NULL,
	CargoID 			INTEGER NOT NULL,
	DepartamentoID		INTEGER NOT NULL,
	DivisaoID 			INTEGER NOT NULL,
	Data_PG				DATE,
	Salario 			FLOAT(126),
 CONSTRAINT PK_FolhaPag_ID PRIMARY KEY  
(
	FuncionarioID,
	CargoID,
	DepartamentoID,
	DivisaoID,
	Data_PG
));
  