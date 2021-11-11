DROP TABLE `dados`.`TAB_DADOS_INFRA`;
CREATE TABLE `dados`.`TAB_DADOS_INFRA` (
  `num_infracao` integer,
  `descricao` varchar(200),
  `enquadramento` varchar(100),
  `gravidade` varchar(20),
  `responsabilidade` varchar(20),
  `competencia` varchar(20),
  `valor` decimal(10,2) )