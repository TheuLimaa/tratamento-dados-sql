"""Script de extracao: manda uma consulta SQL pra API (POST) e salva o resultado,
sem nenhum tratamento, numa tabela "_bruto" no banco local.

ANTES DE RODAR: deixe o scripts/servidor_api.py rodando em outro terminal.

O QUE VOCE PRECISA MEXER: só a variável SQL_QUERY, logo abaixo. O resto (fazer a
chamada, salvar o resultado) já está pronto, é o mesmo tipo de código que você usa
no trabalho.
"""
import sqlite3
from pathlib import Path

import requests

RAIZ = Path(__file__).resolve().parent.parent
URL_API = "http://localhost:5000/query"
CAMINHO_COPIA = RAIZ / "banco_dados" / "copia.db"

# ---------------------------------------------------------------------------
# MUDE AQUI: a consulta que você quer mandar pra API, e o nome da tabela onde
# o resultado bruto vai ser salvo localmente.
# ---------------------------------------------------------------------------
SQL_QUERY = "SELECT * FROM abastecimento"
NOME_TABELA_BRUTA = "abastecimento_bruto"
# ---------------------------------------------------------------------------


def extrair(sql_query: str) -> dict:
    """Manda a consulta pra API e devolve {"colunas": [...], "linhas": [...]}."""
    resposta = requests.post(URL_API, json={"sql": sql_query})
    resposta.raise_for_status()
    return resposta.json()


def salvar_bruto(resultado: dict, nome_tabela: str) -> None:
    """Salva o resultado, sem tratar nada, como uma tabela no banco de cópia local."""
    colunas = resultado["colunas"]
    linhas = resultado["linhas"]

    CAMINHO_COPIA.parent.mkdir(parents=True, exist_ok=True)
    conexao = sqlite3.connect(CAMINHO_COPIA)

    colunas_sql = ", ".join(f'"{coluna}"' for coluna in colunas)
    placeholders = ", ".join("?" for _ in colunas)

    conexao.execute(f'DROP TABLE IF EXISTS "{nome_tabela}"')
    conexao.execute(f'CREATE TABLE "{nome_tabela}" ({colunas_sql})')
    conexao.executemany(
        f'INSERT INTO "{nome_tabela}" VALUES ({placeholders})',
        [[linha[coluna] for coluna in colunas] for linha in linhas],
    )
    conexao.commit()
    conexao.close()

    print(f"{len(linhas)} linhas salvas em {CAMINHO_COPIA} -> tabela '{nome_tabela}'")


if __name__ == "__main__":
    resultado = extrair(SQL_QUERY)
    salvar_bruto(resultado, NOME_TABELA_BRUTA)
