# Progresso do projeto

Última atualização: 2026-10-01

## O que já fiz

- [x] Criei a estrutura do projeto (`scripts/`, `sql/`, `banco_dados/`, `saidas/`)
- [x] Montei um servidor local (`scripts/servidor_api.py`) que simula a API do meu
      trabalho: recebe POST com uma consulta SQL, roda contra um banco fictício
      (`fonte.db`, tabela `abastecimento` de caminhões), devolve JSON
- [x] Escrevi o script de extração (`scripts/extracao.py`): manda a consulta SQL,
      salva o resultado bruto em `banco_dados/copia.db`, tabela `abastecimento_bruto`
- [x] Testei o fluxo ponta a ponta (servidor rodando + extração funcionando)
- [x] Entendi o conceito de **VIEW** (consulta salva que recalcula sozinha sempre
      que o dado bruto muda) e por que isso resolve boa parte do problema de
      "deixar algo atualizando automaticamente"
- [x] Desenhei o pipeline completo que quero construir: extração → views de KPI →
      script de relatório (pandas + matplotlib) → agendamento (Agendador de
      Tarefas do Windows)
- [x] Criei o repositório separado `tratamento-dados-sql` no GitHub (separei do
      `cotacoes-financeiras`, que é sobre outra coisa — API pública + pandas)
- [x] Mantenho um arquivo local `sql/meus_exercicios_privados.sql` (não vai pro
      Git, está no `.gitignore`) com os desafios que ainda preciso resolver

## Próximo passo — focar em exercícios de SQL

Amanhã quero focar mais em **exercícios de SQL** — tanto terminar os desafios que já
tinha (consulta por trimestre, eficiência km/litro por caminhão, diferença percentual
entre caminhões, criar uma VIEW) quanto praticar mais consultas novas.

Os desafios pendentes estão salvos em `sql/meus_exercicios_privados.sql` (local, não
commitado):
1. Valor total de abastecimento num trimestre específico
2. Eficiência (km/litro) por caminhão
3. Diferença percentual de eficiência entre dois caminhões
4. Criar uma VIEW com a eficiência por caminhão

## Como retomar

```powershell
# terminal 1
python scripts/servidor_api.py

# terminal 2
python scripts/extracao.py
```

Depois, abro `sql/meus_exercicios_privados.sql` (ou peço pra gerarem mais exercícios
novos) e pratico.

## Como estou trabalhando nesse projeto

- Escrevo e rodo o código eu mesmo; peço ajuda só pra entender conceitos e
  destravar erros.
- Nunca vai pro Git: bancos `.db` (regeneráveis) e meu arquivo de exercícios
  privados.
- Dados 100% fictícios — nunca uso dado real da empresa aqui.
