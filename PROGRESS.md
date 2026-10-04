# Progresso do projeto

Última atualização: 2026-10-04

## O que já fiz

- [x] Montei um servidor local (`simulador/servidor_api.py`) que simula a API do
      meu trabalho: recebe POST com uma consulta SQL, roda contra um banco
      fictício (`fonte.db`, tabela `abastecimento` de caminhões), devolve JSON
- [x] Escrevi o script de extração (`extracao/buscar_dados.py`): manda a consulta
      SQL, salva o resultado bruto em `banco_dados/copia.db`, tabela
      `abastecimento_bruto`
- [x] Testei o fluxo ponta a ponta (servidor rodando + extração funcionando)
- [x] Entendi o conceito de **VIEW** (consulta salva que recalcula sozinha sempre
      que o dado bruto muda) e por que isso resolve boa parte do problema de
      "deixar algo atualizando automaticamente"
- [x] Desenhei o pipeline completo que quero construir: extração → views de KPI →
      script de relatório (pandas + matplotlib) → e-mail → agendamento
- [x] Criei o repositório separado `tratamento-dados-sql` no GitHub (separei do
      `cotacoes-financeiras`, que é sobre outra coisa — API pública + pandas)
- [x] Reorganizei a estrutura de pastas pra espelhar o padrão que uso no
      trabalho (`simulador/`, `consultas_api/`, `extracao/`, `sql/`, `docs/`,
      `graficos/`, `envio/`, `segredos/`, `logs/`, `saidas/`, `config.py`,
      `rodar_semanal.py`/`.bat`, `LEIA-ME.txt`) — só a organização, sem nada do
      sistema real da empresa
- [x] Deixei esqueletados (ainda não funcionam de verdade) os próximos passos:
      `graficos/kpi_abastecimento.py`, `envio/outlook.py` +
      `envio/email_kpi_abastecimento.py`, `rodar_semanal.py`/`.bat`
- [x] Mantenho um arquivo local `sql/meus_exercicios_privados.sql` (não vai pro
      Git, está no `.gitignore`) com os desafios que ainda preciso resolver

## Próximo passo

Os desafios que estou praticando (ver `sql/meus_exercicios_privados.sql`):

1. Valor total de abastecimento num trimestre específico
2. Eficiência (km/litro) por caminhão
3. Diferença percentual de eficiência entre dois caminhões
4. Criar uma VIEW com a eficiência por caminhão (`vw_eficiencia_caminhao`)

Depois de resolver o 4, dá pra destravar `graficos/kpi_abastecimento.py` (ele já
espera essa view pelo nome).

## Como retomar

```powershell
# terminal 1
python simulador/servidor_api.py

# terminal 2
python extracao/buscar_dados.py
```

## Como estou trabalhando nesse projeto

- Escrevo e rodo o código eu mesmo; peço ajuda só pra entender conceitos e
  destravar erros.
- Nunca vai pro Git: bancos `.db` (regeneráveis), meu arquivo de exercícios
  privados, e `segredos/.env` de verdade (só o `.env.example` fica).
- Dados 100% fictícios — nunca uso dado ou estrutura real da empresa aqui, mesmo
  quando copio o *padrão de organização* do que uso no trabalho.
