-- ============================================================================
-- Treino de JOIN a partir de PERGUNTA DE NEGOCIO (sem dica de sintaxe).
-- Base: abastecimento_bruto (fato) + caminhoes_bruto (dimensao).
--
-- O objetivo aqui nao e aprender sintaxe nova -- e treinar o caminho de
-- "pergunta em portugues" ate "consulta SQL", que e diferente de so ler e
-- validar um codigo pronto.
--
-- Pra toda pergunta tipo "top N" (os 3 melhores, os 2 piores, etc), pensa em:
-- ORDER BY (pra ranquear) + LIMIT (pra cortar só os N primeiros).
-- ============================================================================


-- 0) Exemplo resolvido, so pra lembrar o padrao:
-- "Quais os 2 motoristas que mais abasteceram (em quantidade de registros)?"
SELECT
    c.motorista,
    COUNT(*) AS qtd_abastecimentos
FROM abastecimento_bruto a
JOIN caminhoes_bruto c ON a.placa = c.placa
GROUP BY c.motorista
ORDER BY qtd_abastecimentos DESC
LIMIT 2;


-- ============================================================================
-- PERGUNTAS -- escreva a consulta do zero, sem olhar os outros arquivos
-- ============================================================================

-- 1) Quais os 3 motoristas que mais gastaram em combustivel (valor total)?
SELECT
    c.motorista,
    SUM(a.valor) AS valor
FROM abastecimento_bruto a
JOIN caminhoes_bruto c ON a.placa = c.placa
GROUP BY c.motorista
ORDER BY valor DESC
LIMIT 3;




-- 2) Quais as 2 placas com MENOS abastecimentos registrados?
SELECT
    placa,
    COUNT(*) AS qtd_abastecimentos
FROM abastecimento_bruto 
GROUP BY placa
ORDER BY qtd_abastecimentos ASC
LIMIT 2;

-- 3) Qual foi o UNICO abastecimento de maior valor (de todos, sem agrupar
--    por motorista nem placa -- so o maior abastecimento individual)?
SELECT
    valor
FROM abastecimento_bruto 
order by valor DESC
LIMIT 1;

-- 4) Quais os 2 caminhoes mais eficientes (maior km_rodado por litro
--    abastecido)? Dica: eficiencia e SUM(km_rodado) / SUM(quantidade_litros).
SELECT
    placa,
    ROUND(SUM(valor), 2) AS valor_total,
    Sum(km_rodado) * 1.0/ sum(quantidade_litros) as km_por_litro
FROM abastecimento_bruto
GROUP BY placa
ORDER BY km_por_litro DESC
LIMIT 2;


-- 5) Pra cada modelo de caminhao, qual o gasto medio por abastecimento?
--    Mostre do maior pro menor gasto medio.
SELECT
    b.modelo,
    count(id) as qntd_abastecimento,
    avg(valor) as media_total
from abastecimento_bruto a
join caminhoes_bruto b ON 
a.placa = b.placa

GROUP by b.modelo
order by media_total DESC;

-- 6) Desafio livre: quais motoristas dirigem mais de um caminhao, e quantos
--    caminhoes cada um dirige? (Dica: essa pergunta e sobre caminhoes_bruto
--    sozinha -- nao precisa de abastecimento_bruto aqui.)
SELECT
    motorista,
    count(placa) as qtnd_placas
FROM caminhoes_bruto 
GROUP by motorista
HAVING qtnd_placas >1 ;
