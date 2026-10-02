# Tratamento de Dados SQL

Projeto que estou construindo pra praticar o fluxo que uso no meu trabalho: extrair
dados de uma API que recebe consultas SQL via POST, guardar uma cópia local, e tratar
tudo com SQL — views que recalculam sozinhas sempre que o dado bruto é atualizado.

## Como funciona

Simulo localmente o mesmo padrão do meu trabalho, com dados 100% fictícios (uma
tabela de abastecimento de caminhões), sem nenhum dado real da empresa:

```
scripts/servidor_api.py  → simula a API REST (recebe POST com SQL, devolve JSON)
scripts/extracao.py      → meu script de extração: manda a consulta, salva o
                            resultado bruto localmente, sem tratar nada
banco_dados/copia.db     → minha cópia local (fonte.db simula o banco remoto,
                            copia.db é onde eu trabalho)
sql/tratamento.sql       → minhas consultas e views de tratamento
saidas/                  → gráficos e relatórios gerados
```

## Como rodar

Num terminal, deixo o servidor rodando:
```powershell
pip install -r requirements.txt
python scripts/servidor_api.py
```

Em outro terminal, rodo a extração:
```powershell
python scripts/extracao.py
```

Isso popula `banco_dados/copia.db` com a tabela `abastecimento_bruto`. A partir
daí, trabalho em cima dela com as consultas em `sql/tratamento.sql`.

## Próximos passos

- Views de KPI (eficiência por caminhão, totais por período)
- Script de relatório (lê as views, gera gráfico com matplotlib)
- Automação via Agendador de Tarefas do Windows

## Status

Em desenvolvimento.
