# Progresso do projeto

Última atualização: 2026-10-18

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

- [x] Resolvi os 4 desafios de SQL numa tabela só (trimestre, eficiência por
      caminhão, diferença percentual entre dois caminhões, criar a
      `vw_eficiencia_caminhao`) — tudo em `sql/meus_exercicios_privados.sql`
- [x] Como estou com dificuldade de JOIN no trabalho (onde tem muitas tabelas
      de verdade), adicionei uma segunda tabela fictícia, `caminhoes`
      (cadastro: placa, modelo, ano, motorista), e um arquivo novo de prática,
      `sql/join_caminhoes.sql`, com JOIN de verdade entre duas tabelas (até
      agora eu só tinha praticado self-join). Tem um caminhão (`RST8X90`) sem
      nenhum abastecimento, de propósito, pra ver a diferença entre
      `INNER JOIN` e `LEFT JOIN` na prática.

## Próximo passo

Resolver os desafios 3 a 6 de `sql/join_caminhoes.sql`:

3. Gasto médio por abastecimento, agrupado por modelo de caminhão
4. `LEFT JOIN` — listar todos os caminhões (mesmo sem abastecimento) com a contagem
5. Comparar o resultado do 4 com um JOIN comum, e entender o que sumiu
6. Desafio livre: motorista com a maior eficiência média (km/litro)

Depois de terminar isso, volta a fazer sentido destravar
`graficos/kpi_abastecimento.py` (ele já espera a `vw_eficiencia_caminhao`).

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
