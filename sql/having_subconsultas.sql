-- ============================================================================
-- Pratica de HAVING e subconsultas, usando a mesma base de abastecimento_bruto
-- + caminhoes_bruto que ja usamos em join_caminhoes.sql
--
-- HAVING: filtra GRUPOS depois do GROUP BY (diferente do WHERE, que filtra
-- LINHAS antes de agrupar).
--
-- Subconsulta: uma consulta dentro de outra (entre parenteses), usada pra
-- comparar com um valor calculado na hora, em vez de um numero fixo.
-- ============================================================================


-- 1) HAVING: motoristas que gastaram mais de R$100.000 no total
SELECT
    c.motorista,
    ROUND(SUM(a.valor), 2) AS valor_total
FROM abastecimento_bruto a
JOIN caminhoes_bruto c ON a.placa = c.placa
GROUP BY c.motorista
HAVING SUM(a.valor) > 100000
ORDER BY valor_total DESC;


-- 2) Subconsulta: caminhoes mais novos que a media de ano de fabricacao da frota
SELECT
    placa,
    modelo,
    ano_fabricacao
FROM caminhoes_bruto
WHERE ano_fabricacao > (
    SELECT AVG(ano_fabricacao) FROM caminhoes_bruto
);


-- ============================================================================
-- DESAFIOS -- escreva a consulta voce mesmo abaixo de cada comentario
-- ============================================================================

-- 3) HAVING: liste as placas que tiveram MAIS DE 60 abastecimentos.

SELECT
    placa,
    count(id) as qntd_abastecimento
from abastecimento_bruto
group by placa
HAVING qntd_abastecimento > 55


-- 4) Subconsulta: quais motoristas gastaram (SUM de valor) ACIMA da media
--    de gasto entre todos os motoristas?

SELECT
    c.motorista,
    SUM(a.valor) AS valor_total
FROM abastecimento_bruto a
JOIN caminhoes_bruto c ON a.placa = c.placa
GROUP BY c.motorista
HAVING SUM(a.valor) > (
    SELECT AVG(valor_total) FROM (
        SELECT SUM(a.valor) AS valor_total
        FROM abastecimento_bruto a
        JOIN caminhoes_bruto c ON a.placa = c.placa
        GROUP BY c.motorista
    )
)



-- 5) CASE WHEN (conceito novo): classifique cada abastecimento em
--    'alto', 'medio' ou 'baixo' conforme quantidade_litros:
--      > 300 litros        = 'alto'
--      entre 150 e 300     = 'medio'
--      < 150               = 'baixo'
     SELECT placa, quantidade_litros,
        CASE
         WHEN quantidade_litros > 300 THEN 'alto'
        WHEN quantidade_litros >= 150 THEN 'medio'
        ELSE 'baixo'
      END AS categoria
    FROM abastecimento_bruto;


-- 6) Desafio livre: junte tudo -- encontre o(s) motorista(s) que gastou
--    acima da media (igual o desafio 4) E que dirige mais de um caminhao

SELECT
    c.motorista,
    SUM(a.valor) AS valor_total,
    count(DISTINCT a.placa) as placas
FROM abastecimento_bruto a
JOIN caminhoes_bruto c ON a.placa = c.placa
GROUP BY c.motorista
HAVING SUM(a.valor) > (
    SELECT AVG(valor_total) FROM (
        SELECT SUM(a.valor) AS valor_total
        FROM abastecimento_bruto a
        JOIN caminhoes_bruto c ON a.placa = c.placa
        GROUP BY c.motorista
    )
)
AND COUNT(DISTINCT a.placa) > 1
