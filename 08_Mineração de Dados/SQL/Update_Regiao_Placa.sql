USE dados;
SET SQL_SAFE_UPDATES = 0;
UPDATE INFRA_MD
SET	   regiao_placa = 'Centro-Oeste'
WHERE  uf_placa in ('DF','GO','MT','MS');
SET SQL_SAFE_UPDATES = 0;
UPDATE INFRA_MD
SET	   regiao_placa = 'Nordeste'
WHERE  uf_placa in ('AL','BA','CE','MA','PB','PE','PI','RN','SE');
SET SQL_SAFE_UPDATES = 0;
UPDATE INFRA_MD
SET	   regiao_placa = 'Norte'
WHERE  uf_placa in ('AC','AP','AM','PA','RO','RR','TO');
SET SQL_SAFE_UPDATES = 0;
UPDATE INFRA_MD
SET	   regiao_placa = 'Sudeste'
WHERE  uf_placa in ('ES','MG','RJ','SP');
SET SQL_SAFE_UPDATES = 0;
UPDATE INFRA_MD
SET	   regiao_placa = 'Sul'
WHERE  uf_placa in ('PR','RS','SC');