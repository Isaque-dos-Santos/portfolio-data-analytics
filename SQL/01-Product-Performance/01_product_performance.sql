-- Product Performance Analysis
-- Analyzes product sales performance by calculating
-- total units sold and total transaction value.
-- Ranks products by sales volume in descending order.

WITH tb_produtosMaisVendidos AS (

SELECT t1.IdProduto,
       t1.DescCategoriaProduto,
       t1.DescNomeProduto,
       count(DISTINCT t2.IdTransacao) qtdeTransacoesDistintas,
       sum(t2.QtdeProduto) AS QtdeProdutosVendidos,
       sum(t2.vlProduto * t2.QtdeProduto) AS valorTotalMovimentado
FROM produtos AS t1


INNER JOIN transacao_produto AS t2
ON t1.IdProduto = t2.IdProduto

GROUP BY t1.IdProduto

)

SELECT DescNomeProduto,
       DescCategoriaProduto,
       QtdeProdutosVendidos,
       valorTotalMovimentado


FROM tb_produtosMaisVendidos
ORDER BY QtdeProdutosVendidos DESC