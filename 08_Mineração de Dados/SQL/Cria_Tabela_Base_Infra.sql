
DROP TABLE TAB_INFRACAO_BASE;
CREATE TABLE `dados`.`TAB_INFRACAO_BASE` (
  `dat_infracao` date,
  `tip_abordagem` varchar(2),
  `ind_assinou_auto` varchar(2),
  `ind_veiculo_estrangeiro` Boolean,
  `ind_sentido_trafego` varchar(2),
  `uf_placa` varchar(2),
  `regiao_placa` varchar (20),
  `uf_infracao` varchar(2),
  `regiao_infracao` varchar (20),
  `num_br_infracao` integer,
  `num_km_infracao` integer,
  `nom_municipio` varchar(200),
  `cod_infracao` integer,
  `descricao_abreviada` varchar(200),
  `enquadramento` varchar(200),
  `data_inicio_vigencia` date,
  `data_fim_vigencia` boolean,
  `med_realizada` integer,
  `med_considerada` integer,
  `exc_verificado` integer,
  `especie` varchar(100),
  `nome_veiculo_marca` varchar(100),
  `nom_modelo_veiculo` varchar(100),
  `hora` varchar(20) ) 