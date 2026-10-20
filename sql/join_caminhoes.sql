-- ============================================================================
-- Prática de JOIN — unindo abastecimento_bruto (fato) com caminhoes_bruto
-- (dimensão/cadastro), usando "placa" como chave em comum.
--
-- Colunas de caminhoes_bruto: placa, modelo, ano_fabricacao, motorista
-- Colunas de abastecimento_bruto: id, placa, dia, horario, quantidade_litros,
-- km_rodado, valor
--
-- Atenção: existe um caminhão (RST8X90) cadastrado mas que NUNCA abasteceu
-- ainda — isso é de propósito, pra você ver na prática a diferença entre
-- INNER JOIN e LEFT JOIN.
--
-- Exemplos 1-2: já resolvidos, estude a sintaxe. Desafios 3+: você escreve.
-- ============================================================================


-- 1) JOIN básico: trazer o modelo e o motorista ao lado de cada abastecimento
SELECT
    a.placa,
    c.modelo,
    c.motorista,
    a.dia,
    a.valor
FROM abastecimento_bruto a
JOIN caminhoes_bruto c ON a.placa = c.placa
LIMIT 10;


-- 2) JOIN + GROUP BY: valor total abastecido, por motorista
SELECT
    c.motorista,
    ROUND(SUM(a.valor), 2) AS valor_total
FROM abastecimento_bruto a
JOIN caminhoes_bruto c ON a.placa = c.placa
GROUP BY c.motorista
ORDER BY valor_total DESC;


-- ============================================================================
-- DESAFIOS — escreva a consulta você mesmo abaixo de cada comentário
-- ============================================================================

-- 3) Gasto médio por abastecimento (AVG), agrupado por MODELO de caminhão
--    (não por placa nem motorista — por modelo).
--    Dica: é o mesmo padrão do exemplo 2, só trocando SUM por AVG e
--    c.motorista por c.modelo.
SELECT
    c.modelo,
    avg(a.valor) as valor_total
from abastecimento_bruto a 
join caminhoes_bruto c on a.placa = c.placa
group by c.modelo
order by valor_total Desc;

-- 4) LEFT JOIN: liste TODOS os caminhões cadastrados (mesmo os que nunca
--    abasteceram) com a quantidade de abastecimentos de cada um.
--    Dica: comece o FROM pela tabela de caminhoes (não pela de abastecimento),
--    e troque JOIN por LEFT JOIN. Use COUNT(a.id) -- não COUNT(*) -- pra
--    contar certo quando não houver nenhum abastecimento.
--    FROM caminhoes_bruto c
--    LEFT JOIN abastecimento_bruto a ON a.placa = c.placa
--    GROUP BY c.placa
SELECT
    t1.placa,
    count(t2.id)
from caminhoes_bruto t1
left join abastecimento_bruto t2 ON
t1.placa = t2.placa

group by t1.placa

order by quantidade_litros Desc;



-- 5) Depois de rodar o desafio 4, repita a MESMA pergunta mas com JOIN comum
--    (sem o LEFT). Compare os resultados: quantas placas aparecem em cada um?
--    O que aconteceu com o caminhão RST8X90?
SELECT
    t1.placa,
    t2.quantidade_litros
from caminhoes_bruto t1
join abastecimento_bruto t2 ON
t1.placa = t2.placa

group by t1.placa

order by quantidade_litros Desc;

-- 6) Desafio livre: quem é o motorista mais "eficiente" -- aquele cujos
--    caminhões têm a maior média de km_rodado por litro abastecido?
--    Dica: junte o raciocínio do JOIN (pra saber o motorista de cada placa)
--    com o raciocínio de SUM(km_rodado)/SUM(quantidade_litros) que você já
--    usou antes (em sql/meus_exercicios_privados.sql).
SELECT
    c.motorista,
    ROUND(SUM(t1.valor), 2) AS valor_total,
    Sum(t1.km_rodado) * 1.0/ sum(t1.quantidade_litros)
FROM abastecimento_bruto t1
JOIN caminhoes_bruto c ON t1.placa = c.placa
GROUP BY c.motorista
ORDER BY valor_total DESC;