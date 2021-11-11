USE dados;
SET SQL_SAFE_UPDATES = 0;
UPDATE INFRA_MD
SET	   regiao_infracao = 'Centro-Oeste'
WHERE  uf_infracao in ('DF','GO','MT','MS');
SET SQL_SAFE_UPDATES = 0;
UPDATE INFRA_MD
SET	   regiao_infracao = 'Nordeste'
WHERE  uf_infracao in ('AL','BA','CE','MA','PB','PE','PI','RN','SE');
SET SQL_SAFE_UPDATES = 0;
UPDATE INFRA_MD
SET	   regiao_infracao = 'Norte'
WHERE  uf_infracao in ('AC','AP','AM','PA','RO','RR','TO');
SET SQL_SAFE_UPDATES = 0;
UPDATE INFRA_MD
SET	   regiao_infracao = 'Sudeste'
WHERE  uf_infracao in ('ES','MG','RJ','SP');
SET SQL_SAFE_UPDATES = 0;
UPDATE INFRA_MD
SET	   regiao_infracao = 'Sul'
WHERE  uf_infracao in ('PR','RS','SC');