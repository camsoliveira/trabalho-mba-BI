/*
-- 
-- ATIVIDADE 2/2

-- Equipe 5: Camila Oliveira e Rosana Cardoso
--
-- Script: 2. FC_INS_TIPO_GASTO
--
-- Testar a Fun��o chamada FC_INS_TIPO_GASTO
--

*/
-- EXECUTAR FUN��O
SET SERVEROUTPUT ON

DECLARE
  RETORNO NUMBER;
BEGIN
  RETORNO:=FC_INS_TIPO_GASTO;
  DBMS_OUTPUT.PUT_LINE(RETORNO);
END;

-- CHECAR TABELAS
SELECT * FROM LOG_CARGA;
SELECT * FROM TIPO_GASTO;