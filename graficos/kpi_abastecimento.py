"""Gera o grafico do KPI de eficiencia (km/litro) por caminhao, a partir da view
criada em sql/tratamento_abastecimento.sql.

AINDA NAO CONSTRUI ISSO DE VERDADE — e a proxima etapa depois de terminar os
desafios de SQL (view de eficiencia). Os passos ja estao esqueletados abaixo.
"""
import sqlite3
from pathlib import Path

import matplotlib.pyplot as plt
import pandas as pd

RAIZ = Path(__file__).resolve().parent.parent
CAMINHO_BANCO = RAIZ / "banco_dados" / "copia.db"
CAMINHO_SAIDA = RAIZ / "saidas" / "kpi_eficiencia.png"


def gerar_grafico() -> None:
    conexao = sqlite3.connect(CAMINHO_BANCO)
    # TODO: trocar pelo nome real da view depois de criar ela no desafio 4
    df = pd.read_sql("SELECT * FROM vw_eficiencia_caminhao", conexao)
    conexao.close()

    # TODO: montar o grafico (ex.: plt.bar(df["placa"], df["km_por_litro"]))

    CAMINHO_SAIDA.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(CAMINHO_SAIDA)
    print(f"Grafico salvo em {CAMINHO_SAIDA}")


if __name__ == "__main__":
    gerar_grafico()
