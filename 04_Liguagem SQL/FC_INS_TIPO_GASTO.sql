/*
-- 
-- ATIVIDADE 2/2

-- Equipe 5: Camila Oliveira e Rosana Cardoso
--
-- Script: 2. FC_INS_TIPO_GASTO
--
-- Criar uma Função chamada FC_INS_TIPO_GASTO
--

*/
CREATE OR REPLACE FUNCTION FC_INS_TIPO_GASTO
  RETURN NUMBER
AS
  ERRO VARCHAR2(500);
  REGISTRO NUMBER;

BEGIN 
    
    REGISTRO := LOGCARGA_SEQ.nextval;
    PKG_LOG_CARGA.UP_INS_LOGCARGA(REGISTRO, 'CARGA DADOS', CURRENT_DATE);
    
    INSERT INTO tipo_gasto
    SELECT 
      distinct
      TG.numSubCota,
      TG.txtdescricao,
      current_date
    FROM TRANSPARENCIA_GASTOS TG
    WHERE TG.sguf IN ('MG', 'PE')
    ORDER BY 1;
     
    PKG_LOG_CARGA.UP_UPD_LOGCARGA(REGISTRO, CURRENT_DATE, '');
    RETURN 0;
 
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    ERRO:=substr(SQLERRM,1,500);
    PKG_LOG_CARGA.UP_UPD_LOGCARGA(REGISTRO, CURRENT_DATE, ERRO);
    RETURN 1;

  WHEN OTHERS THEN
    ERRO:=substr(SQLERRM,1,500);
    PKG_LOG_CARGA.UP_UPD_LOGCARGA(REGISTRO, CURRENT_DATE, ERRO);
    RETURN 1;

END;