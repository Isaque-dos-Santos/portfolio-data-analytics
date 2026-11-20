-- Os três produtos mais vendidos dentro de cada categoria

WITH tb_produtos AS (

SELECT *

FROM transacoes AS t1

INNER JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

INNER JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

),

tb_Valores AS (

SELECT DescNomeProduto,
       DescCategoriaProduto,
       sum(QtdeProduto) AS qtdeVendas,
       sum(QtdeProduto * VlProduto) AS valorTotalMovimentado



FROM tb_produtos

WHERE vlProduto >= 0

GROUP BY IdProduto, DescNomeProduto, DescCategoriaProduto

),

tb_rn AS (

SELECT *,
            ROW_NUMBER() OVER (PARTITION BY DescCategoriaProduto ORDER BY qtdeVendas DESC) AS rn

FROM tb_Valores

)

SELECT *

FROM tb_rn 
WHERE rn <= 3

ORDER BY DescCategoriaProduto, rn