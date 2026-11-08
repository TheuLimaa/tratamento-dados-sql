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


-- 2) Quais as 2 placas com MENOS abastecimentos registrados?


-- 3) Qual foi o UNICO abastecimento de maior valor (de todos, sem agrupar
--    por motorista nem placa -- so o maior abastecimento individual)?


-- 4) Quais os 2 caminhoes mais eficientes (maior km_rodado por litro
--    abastecido)? Dica: eficiencia e SUM(km_rodado) / SUM(quantidade_litros).


-- 5) Pra cada modelo de caminhao, qual o gasto medio por abastecimento?
--    Mostre do maior pro menor gasto medio.


-- 6) Desafio livre: quais motoristas dirigem mais de um caminhao, e quantos
--    caminhoes cada um dirige? (Dica: essa pergunta e sobre caminhoes_bruto
--    sozinha -- nao precisa de abastecimento_bruto aqui.)
