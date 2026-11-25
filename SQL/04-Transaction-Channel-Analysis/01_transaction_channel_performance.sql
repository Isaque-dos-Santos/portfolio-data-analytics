-- Transaction Channel Performance Analysis
-- Analyzes monthly transaction performance across different channels.
-- Calculates total transactions, unique customers, and total points.
-- Uses CTEs and the LAG() window function to compare monthly results.
-- Measures percentage growth or decline in transaction volume.


WITH tb_canal AS (

SELECT substr(DtCriacao,1,7) AS dtDia,
       DescSistemaOrigem,
       COUNT(DISTINCT IdTransacao) AS totalTransacoes,
       COUNT(DISTINCT IdCliente) clientesÚnicos,
       SUM(qtdePontos) AS totalPontos


FROM transacoes

GROUP BY DescSistemaOrigem, dtDia

),

tb_lag AS (

SELECT *,
         LAG(totalTransacoes) OVER (PARTITION BY DescSistemaOrigem ORDER BY dtDia) AS lagTransacoes

FROM tb_canal

),

tb_percentual AS (

SELECT *,
     ROUND((totalTransacoes - lagTransacoes) * 100.0
     / NULLIF(lagTransacoes, 0),2) AS crescimentoPercentual

FROM tb_lag

)

SELECT DescSistemaOrigem,
       dtDia,
       totalTransacoes,
       clientesÚnicos,
       crescimentoPercentual,
       totalPontos
FROM tb_percentual

ORDER BY DescSistemaOrigem, dtDia