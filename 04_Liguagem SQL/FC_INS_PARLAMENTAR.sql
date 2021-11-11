/*
-- 
-- ATIVIDADE 2/2

-- Equipe 5: Camila Oliveira e Rosana Cardoso
--
-- Script: 3. FC_INS_PARLAMENTAR
--
-- Criar uma Função chamada FC_INS_PARLAMENTAR
--

*/
CREATE OR REPLACE FUNCTION FC_INS_PARLAMENTAR
  RETURN NUMBER
AS
  ERRO VARCHAR2(500);
  REGISTRO NUMBER;

BEGIN 
    
    REGISTRO := LOGCARGA_SEQ.nextval;
    PKG_LOG_CARGA.UP_INS_LOGCARGA(REGISTRO, 'CARGA DADOS', CURRENT_DATE);
    
    DECLARE
        CURSOR CUR_PARLAMENTAR IS SELECT DISTINCT NUDEPUTADOID, TXNOMEPARLAMENTAR, SGPARTIDO, SGUF FROM TRANSPARENCIA_GASTOS 
                                   WHERE SGUF IN ('MG', 'PE')
                                  ORDER BY 1;
        CR_NUDEPUTADOID NUMBER(10,0);
        CR_TXNOMEPARLAMENTAR VARCHAR2(300);
        CR_SGPARTIDO VARCHAR2(10);
        CR_SGUF VARCHAR2(10);

    BEGIN 
        OPEN CUR_PARLAMENTAR;
    
        LOOP
    
            FETCH CUR_PARLAMENTAR INTO CR_NUDEPUTADOID, CR_TXNOMEPARLAMENTAR, CR_SGPARTIDO, CR_SGUF;
            EXIT WHEN CUR_PARLAMENTAR%NOTFOUND;
            INSERT INTO PARLAMENTAR (IDE_PARLAMENTAR, DES_PARLAMENTAR, TIP_PARLAMENTAR, SGL_PARTIDO, SGL_ESTADO, DTC_CADASTRO) 
                 VALUES (CASE WHEN CR_NUDEPUTADOID IS NULL 
                                   THEN -1 
                              ELSE CR_NUDEPUTADOID END,
	                       CASE WHEN CR_NUDEPUTADOID IS NULL OR CR_TXNOMEPARLAMENTAR IS NULL OR CR_TXNOMEPARLAMENTAR = '' 
                                   THEN 'INFORMACAO INEXISTENTE' 
                              ELSE CR_TXNOMEPARLAMENTAR END,
	                       CASE WHEN CR_NUDEPUTADOID IS NULL 
                                   THEN 'OUTROS' 
                              ELSE 'DEPUTADO' END,
	                       CASE WHEN CR_NUDEPUTADOID IS NULL OR CR_SGPARTIDO IS NULL 
                                   THEN 'XX' 
                              ELSE CR_SGPARTIDO END,
	                       CASE WHEN CR_NUDEPUTADOID IS NULL OR CR_SGUF IS NULL 
                                   THEN 'XX' 
                              ELSE CR_SGUF END,
                         CURRENT_DATE);     
            
        END LOOP;
    
    CLOSE CUR_PARLAMENTAR;
    END;

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
