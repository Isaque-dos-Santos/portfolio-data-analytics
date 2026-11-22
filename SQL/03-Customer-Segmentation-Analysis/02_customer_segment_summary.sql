-- Customer Segment Summary
-- Summarizes customer counts, total transactions,
-- and accumulated points for each customer segment.
-- Uses CTEs and window functions to calculate
-- cumulative metrics and extract segment totals.

WITH tb_tabelaSeparada AS (

SELECT t1.IdCliente,
       sum(t1.qtdePontos) AS somaPontos,
       count(DISTINCT t1.IdTransacao) AS totalTransacoes
   
FROM transacoes AS t1

INNER JOIN clientes AS t2
ON t1.idCliente = t2.idCliente

GROUP BY t1.idCliente

),

tb_segmento AS (

SELECT *,
       CASE
          WHEN totalTransacoes = 1 THEN 'Esporádico'
          WHEN totalTransacoes <= 5 THEN 'Recorrente'
          ELSE 'Frequente'
       END AS segmento

FROM tb_tabelaSeparada

),

tb_clientesClassificados AS (

SELECT *,
        sum(somaPontos) OVER (PARTITION BY segmento ORDER BY IdCliente) AS totalPontos,
        sum(totalTransacoes) OVER (PARTITION BY segmento ORDER BY IdCliente) AS somaTransações,
        count(IdCliente) OVER (PARTITION BY segmento ORDER BY IdCliente) AS clientesSegmento

FROM tb_segmento

),

tb_rn AS (

SELECT *,
         ROW_NUMBER() OVER (PARTITION BY segmento ORDER BY IdCliente DESC) AS rnSegmento

FROM tb_clientesClassificados

)

SELECT segmento,
       clientesSegmento,
       somaTransações,
       totalPontos
       

FROM tb_rn
WHERE rnSegmento = 1