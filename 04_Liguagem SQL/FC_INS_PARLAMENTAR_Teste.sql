/*
-- 
-- ATIVIDADE 2/2

-- Equipe 5: Camila Oliveira e Rosana Cardoso
--
-- Script: 3. FC_INS_PARLAMENTAR
--
-- Testar a Fun��o chamada FC_INS_PARLAMENTAR
--

*/
-- EXECUTAR FUN��O
SET SERVEROUTPUT ON

DECLARE
  RETORNO NUMBER;
BEGIN
  RETORNO:=FC_INS_PARLAMENTAR;
  DBMS_OUTPUT.PUT_LINE(RETORNO);
END;

-- CHECAR TABELAS
SELECT * FROM LOG_CARGA;
SELECT * FROM PARLAMENTAR;