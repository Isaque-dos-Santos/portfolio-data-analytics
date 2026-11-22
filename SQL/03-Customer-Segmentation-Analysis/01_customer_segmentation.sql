-- Customer Segmentation Analysis
-- Segments customers based on transaction frequency
-- using CTEs, aggregations, and CASE WHEN.
-- Calculates total transactions and points per customer.
-- Classifies customers as occasional, recurring, or frequent.

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

)

SELECT *

FROM tb_segmento
ORDER BY totalTransacoes DESC