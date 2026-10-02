-- ============================================================================
-- Tratamento em SQL sobre a tabela "abastecimento_bruto", dentro de
-- banco_dados/copia.db
--
-- Lembre-se: NUNCA mexo na tabela "_bruto" diretamente (UPDATE/DELETE nela) — ela é
-- a cópia fiel do que vem da API. Todo tratamento é feito em cima dela via SELECT
-- (ou criando views/tabelas novas), nunca alterando-a.
--
-- Colunas de abastecimento_bruto: id, placa, dia, horario, quantidade_litros,
-- km_rodado, valor
-- ============================================================================


-- Estrutura e amostra dos dados
SELECT * FROM abastecimento_bruto LIMIT 10;


-- Total gasto e total de litros por caminhão (placa)
SELECT
    placa,
    COUNT(*) AS qtd_abastecimentos,
    ROUND(SUM(valor), 2) AS valor_total,
    ROUND(SUM(quantidade_litros), 2) AS litros_total
FROM abastecimento_bruto
GROUP BY placa
ORDER BY valor_total DESC;
