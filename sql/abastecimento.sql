-- ============================================================================
-- Exploração e decisões — tabela "abastecimento"
--
-- Aqui eu anoto o raciocínio/exploração ANTES de decidir o tratamento final
-- (que vai pra sql/tratamento_abastecimento.sql). Esse arquivo não "roda" como
-- parte do pipeline — é meu rascunho de investigação.
-- ============================================================================

-- Como são os dados crus, antes de qualquer tratamento?
SELECT * FROM abastecimento_bruto LIMIT 20;

-- Tem placa duplicada/com espaço, nome de produto inconsistente, etc.?
-- (anotar aqui o que for descobrindo)


-- Decisões tomadas (ir preenchendo conforme avança):
-- - ?
