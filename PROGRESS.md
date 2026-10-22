# Progresso do projeto

Última atualização: 2026-10-21

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
- [x] Como estava com dificuldade de JOIN no trabalho (onde tem muitas tabelas
      de verdade), adicionei uma segunda tabela fictícia, `caminhoes`
      (cadastro: placa, modelo, ano, motorista), e um arquivo novo de prática,
      `sql/join_caminhoes.sql`, com JOIN de verdade entre duas tabelas (até
      agora eu só tinha praticado self-join). Tem um caminhão (`RST8X90`) sem
      nenhum abastecimento, de propósito, pra ver a diferença entre
      `INNER JOIN` e `LEFT JOIN` na prática.
- [x] Resolvi os desafios 3 a 6 de `sql/join_caminhoes.sql` (JOIN com AVG,
      LEFT JOIN vs JOIN comum, e cálculo de eficiência por motorista), senti mais
      facilidade depois de algumas semanas com o trabalho e hoje consigo fazer
      junções com mais facilidade.
- [x] Rodei o `graficos/kpi_abastecimento.py` e gerei o primeiro gráfico de
      verdade do projeto
- [x] Experimentei gráfico 3D no matplotlib (`graficos/exploracao_3d.py`):
      um scatter 3D e um bar3d. Aprendi que 3D é difícil de ler e por isso é
      pouco usado na prática — mas valeu pra treinar `projection="3d"`,
      `ax.bar3d`, `set_xticks`/`set_xticklabels`
- [x] Criei `sql/having_subconsultas.sql` para consolidar minha base (filtra    
      grupo
      depois do GROUP BY, diferente do WHERE), subconsulta (consulta dentro
      de outra, pra comparar com um valor calculado) e CASE WHEN (o
      if/elif/else do SQL). Resolvi os desafios 1, 2, 3, 4 e 5; o 6 (combinar
      HAVING com AND e COUNT DISTINCT) 

## Próximo passo

Terminar o desafio 6 de `sql/having_subconsultas.sql` (HAVING com duas
condições + COUNT DISTINCT).Continuar consolidando minha base em SQL.
Depois, destravar `envio/outlook.py` e `envio/email_kpi_abastecimento.py`.



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

