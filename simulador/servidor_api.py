"""Servidor local que SIMULA a API REST do ERP (a que aceita uma consulta SQL no corpo
do POST e devolve os dados do banco de dados remoto).

Isso existe só pra você praticar localmente o mesmo mecanismo que usa no trabalho,
sem precisar de rede nem de dado real da empresa. A tabela "abastecimento" aqui é
100% fictícia.

Como usar:
    python scripts/servidor_api.py

Isso deixa um servidor rodando em http://localhost:5000 . Deixe esse terminal aberto
e rodando; use OUTRO terminal pra rodar o scripts/extracao.py.
"""
import random
import sqlite3
from datetime import date, timedelta
from pathlib import Path

from flask import Flask, jsonify, request

RAIZ = Path(__file__).resolve().parent.parent
CAMINHO_FONTE = RAIZ / "banco_dados" / "fonte.db"

app = Flask(__name__)


def criar_dados_ficticios():
    """Cria o banco 'fonte.db' (simulando o banco remoto do ERP) com dados inventados,
    caso ele ainda não exista."""
    if CAMINHO_FONTE.exists():
        return

    CAMINHO_FONTE.parent.mkdir(parents=True, exist_ok=True)
    conexao = sqlite3.connect(CAMINHO_FONTE)
    conexao.execute(
        """
        CREATE TABLE abastecimento (
            id INTEGER PRIMARY KEY,
            placa TEXT,
            dia TEXT,
            horario TEXT,
            quantidade_litros REAL,
            km_rodado INTEGER,
            valor REAL
        )
        """
    )

    placas = ["ABC1D23", "XYZ9E88", "QWE4R56", "LMN7P12"]
    preco_litro_base = 5.80
    data_inicial = date(2026, 1, 1)

    linhas = []
    for dia_offset in range(0, 270, 3):  # um abastecimento a cada ~3 dias, ao longo do ano
        dia = data_inicial + timedelta(days=dia_offset)
        for placa in placas:
            if random.random() < 0.6:  # nem todo caminhao abastece em todo ciclo
                litros = round(random.uniform(150, 400), 1)
                preco_litro = round(preco_litro_base + random.uniform(-0.3, 0.3), 2)
                linhas.append(
                    (
                        placa,
                        dia.isoformat(),
                        f"{random.randint(5, 20):02d}:{random.randint(0, 59):02d}",
                        litros,
                        random.randint(50, 600),
                        round(litros * preco_litro, 2),
                    )
                )

    conexao.executemany(
        """
        INSERT INTO abastecimento (placa, dia, horario, quantidade_litros, km_rodado, valor)
        VALUES (?, ?, ?, ?, ?, ?)
        """,
        linhas,
    )
    conexao.commit()
    conexao.close()
    print(f"Banco ficticio criado em {CAMINHO_FONTE} com {len(linhas)} linhas.")


@app.route("/query", methods=["POST"])
def executar_consulta():
    """Recebe {"sql": "SELECT ..."} e devolve o resultado dessa consulta.

    Igual no seu trabalho: o cliente (seu script de extracao) manda o SQL, o servidor
    roda contra o banco dele, e devolve os dados.
    """
    corpo = request.get_json(force=True)
    sql = corpo.get("sql", "")

    if not sql.strip().lower().startswith("select"):
        return jsonify({"erro": "Por seguranca, esse servidor so aceita consultas SELECT."}), 400

    conexao = sqlite3.connect(CAMINHO_FONTE)
    conexao.row_factory = sqlite3.Row
    try:
        cursor = conexao.execute(sql)
        colunas = [descricao[0] for descricao in cursor.description]
        linhas = [dict(linha) for linha in cursor.fetchall()]
    except sqlite3.Error as erro:
        return jsonify({"erro": str(erro)}), 400
    finally:
        conexao.close()

    return jsonify({"colunas": colunas, "linhas": linhas})


if __name__ == "__main__":
    criar_dados_ficticios()
    print("Servidor rodando em http://localhost:5000  (POST /query)")
    app.run(port=5000)
