/*
-- 
-- ATIVIDADE 2/2

-- Equipe 5: Camila Oliveira e Rosana Cardoso
--
-- Script: 6. ROTINA_EXECUCAO
--
-- Executar as rotinas
--

*/
-- 1. Executar a função FC_INS_TIPO_GASTO
DECLARE 
  RETORNO NUMBER;
BEGIN
  RETORNO := FC_INS_TIPO_GASTO;
END;

SELECT * FROM TIPO_GASTO;
SELECT * FROM LOG_CARGA;

-- 2. Executar a Procedure UP_EXECUTA_CARGA passando o parametro 2
BEGIN
  UP_EXECUTA_CARGA(2);
END;

-- 3. Verificar se todas as tabelas foram preenchidas
SELECT * FROM TIPO_GASTO;
SELECT * FROM PARLAMENTAR;
SELECT * FROM GASTO_PARLAMENTAR;

-- 4. Verificar Tabela LOG_CARGA
SELECT * FROM LOG_CARGA;

-- 5. Executar a Procedure UP_EXECUTA_CARGA passando o parametro 1
BEGIN
  UP_EXECUTA_CARGA(1);
END;

-- 6. Verificar se todas as tabelas foram preenchidas
SELECT * FROM TIPO_GASTO;
SELECT * FROM PARLAMENTAR;
SELECT * FROM GASTO_PARLAMENTAR;
SELECT * FROM LOG_CARGA;
