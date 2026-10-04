# Tabelas e views — banco_dados/copia.db

Visão geral de tudo que existe no banco local (atualizar conforme for criando).

| Nome | Tipo | Criada por | Descrição |
|---|---|---|---|
| `abastecimento_bruto` | tabela | `extracao/buscar_dados.py` | cópia fiel do que vem da API, sem tratamento |
| `abastecimento` | tabela/view (a definir) | `sql/tratamento_abastecimento.sql` | dado tratado, pronto pros KPIs |
| `vw_eficiencia_caminhao` | view (a criar) | `sql/tratamento_abastecimento.sql` | km/litro por caminhão |

Pra ver isso ao vivo: abrir `banco_dados/copia.db` com a extensão SQLite Viewer do
VS Code, ou rodar `SELECT name, type FROM sqlite_master;`.
