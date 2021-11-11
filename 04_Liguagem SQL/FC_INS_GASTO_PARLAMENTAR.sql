/*
-- 
-- ATIVIDADE 2/2

-- Equipe 5: Camila Oliveira e Rosana Cardoso
--
-- Script: 4. FC_INS_GASTO_PARLAMENTAR
--
-- Criar uma Função chamada FC_INS_GASTO_PARLAMENTAR
--

*/
CREATE OR REPLACE FUNCTION FC_INS_GASTO_PARLAMENTAR
  RETURN NUMBER
AS
  ERRO VARCHAR2(500);
  REGISTRO NUMBER;

BEGIN 
    
    REGISTRO := LOGCARGA_SEQ.nextval;
    PKG_LOG_CARGA.UP_INS_LOGCARGA(REGISTRO, 'CARGA DADOS', CURRENT_DATE);
    
    DECLARE
        CURSOR CUR_GASTO_PARLAMENTAR IS SELECT CASE WHEN NUDEPUTADOID IS NULL THEN -1 ELSE NUDEPUTADOID END, 
                                               NUMSUBCOTA, 
                                               CASE WHEN DATEMISSAO IS NULL THEN TO_CHAR(CURRENT_DATE,'YYYY') ELSE TO_CHAR(DATEMISSAO,'YYYY') END, 
                                               CASE WHEN DATEMISSAO IS NULL THEN TO_CHAR(CURRENT_DATE,'MM') ELSE TO_CHAR(DATEMISSAO,'MM') END, 
                                               SUM(CASE WHEN VLRDOCUMENTO >= 0 THEN VLRDOCUMENTO ELSE 0 END),
                                               SUM(CASE WHEN VLRDOCUMENTO < 0 THEN VLRDOCUMENTO ELSE 0 END)
                                          FROM TRANSPARENCIA_GASTOS 
                                         WHERE SGUF IN ('MG')
                                        GROUP BY CASE WHEN NUDEPUTADOID IS NULL THEN -1 ELSE NUDEPUTADOID END, 
                                                 NUMSUBCOTA, 
                                                 CASE WHEN DATEMISSAO IS NULL THEN TO_CHAR(CURRENT_DATE,'YYYY') ELSE TO_CHAR(DATEMISSAO,'YYYY') END,
                                                 CASE WHEN DATEMISSAO IS NULL THEN TO_CHAR(CURRENT_DATE,'MM') ELSE TO_CHAR(DATEMISSAO,'MM') END
                                        ORDER BY CASE WHEN NUDEPUTADOID IS NULL THEN -1 ELSE NUDEPUTADOID END, 
                                                 NUMSUBCOTA, 
                                                 CASE WHEN DATEMISSAO IS NULL THEN TO_CHAR(CURRENT_DATE,'YYYY') ELSE TO_CHAR(DATEMISSAO,'YYYY') END,
                                                 CASE WHEN DATEMISSAO IS NULL THEN TO_CHAR(CURRENT_DATE,'MM') ELSE TO_CHAR(DATEMISSAO,'MM') END; 
        CR_NUDEPUTADOID NUMBER(10,0);
        CR_NUMSUBCOTA NUMBER(10,0);
        CR_ANO VARCHAR2(4);
        CR_MES VARCHAR2(2);
        CR_VLRGASTO NUMBER(10,2);
        CR_VLRESTORNO NUMBER(10,2);

    BEGIN 
        OPEN CUR_GASTO_PARLAMENTAR;
    
        LOOP
    
            FETCH CUR_GASTO_PARLAMENTAR INTO CR_NUDEPUTADOID, CR_NUMSUBCOTA, CR_ANO, CR_MES, CR_VLRGASTO, CR_VLRESTORNO;
            EXIT WHEN CUR_GASTO_PARLAMENTAR%NOTFOUND;
            INSERT INTO GASTO_PARLAMENTAR (COD_TIPO_GASTO, IDE_PARLAMENTAR, NUM_ANO, NUM_MES, VAL_GASTO_MES, VAL_ESTORNO_MES, DTC_CADASTRO) 
                 VALUES (CR_NUMSUBCOTA,
                         CR_NUDEPUTADOID,
	                       TO_NUMBER(CR_ANO), 
	                       TO_NUMBER(CR_MES),
	                       CR_VLRGASTO,
	                       CR_VLRESTORNO,
                         CURRENT_DATE);     
            
        END LOOP;
    
    CLOSE CUR_GASTO_PARLAMENTAR;
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
