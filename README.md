# Tratamento de Dados SQL

Projeto que estou construindo pra praticar o fluxo que uso no meu trabalho: extrair
dados de uma API que recebe consultas SQL via POST, guardar uma cópia local, tratar
tudo com SQL (views que recalculam sozinhas), gerar gráfico e mandar por e-mail —
tudo automatizado. A organização das pastas espelha a que uso no dia a dia, pra eu
treinar me localizando nela.

Dados 100% fictícios (uma tabela de abastecimento de caminhões) — nada do sistema
real da empresa.

## Como funciona

```
simulador/        → simula a API REST (só existe aqui no estudo; no trabalho a
                     API já existe de verdade)
consultas_api/     → cópia de referência das consultas mandadas pra API
extracao/          → script que busca o dado e salva bruto, sem tratar nada
sql/               → exploração (abastecimento.sql) e tratamento final + views
                     (tratamento_abastecimento.sql)
docs/              → dicionário de dados, tabelas/views existentes
graficos/          → gera os gráficos dos KPIs a partir das views
envio/             → monta e manda o e-mail com o relatório
segredos/          → credenciais (.env, nunca commitado — só o .env.example)
logs/              → log de execução da rotina semanal
saidas/            → gráficos/arquivos gerados
banco_dados/       → fonte.db (simula o banco remoto) e copia.db (minha cópia
                     de trabalho) — fora do Git, são regeráveis
config.py          → configurações gerais (não-sensíveis)
rodar_semanal.py   → orquestra tudo em sequência (extração → tratamento →
                     gráfico → e-mail)
rodar_semanal.bat  → dispara o rodar_semanal.py (pro Agendador de Tarefas chamar)
LEIA-ME.txt        → guia rápido de como rodar tudo
```

## Como rodar (hoje)

Num terminal, deixo o simulador rodando:
```powershell
pip install -r requirements.txt
python simulador/servidor_api.py
```

Em outro terminal, rodo a extração:
```powershell
python extracao/buscar_dados.py
```

Isso popula `banco_dados/copia.db` com a tabela `abastecimento_bruto`. A partir
daí, trabalho em cima dela com as consultas em `sql/tratamento_abastecimento.sql`.

## Status

Em desenvolvimento. Focando agora nos exercícios de SQL (views e tratamento);
gráfico, e-mail e automação completa ainda são esqueletos (ver `LEIA-ME.txt`).
