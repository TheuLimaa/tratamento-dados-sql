"""Exploracao: grafico 3D (scatter) relacionando litros abastecidos, km rodado
e valor pago, um ponto por abastecimento.

Isso e so um experimento pra aprender matplotlib 3D -- nao faz parte do
pipeline oficial de KPI (esse fica em kpi_abastecimento.py).
"""
import sqlite3
from pathlib import Path

import matplotlib.pyplot as plt
import pandas as pd

RAIZ = Path(__file__).resolve().parent.parent
CAMINHO_BANCO = RAIZ / "banco_dados" / "copia.db"


def gerar_grafico_3d() -> None:
    conexao = sqlite3.connect(CAMINHO_BANCO)
    df = pd.read_sql("SELECT * FROM abastecimento_bruto", conexao)
    conexao.close()

    fig = plt.figure()
    ax = fig.add_subplot(projection="3d")

    ax.scatter(df["quantidade_litros"], df["km_rodado"], df["valor"])
    ax.set_xlabel("Litros abastecidos")
    ax.set_ylabel("Km rodado")
    ax.set_zlabel("Valor pago (R$)")


    plt.show()


def gerar_grafico_barras_3d() -> None:
    conexao = sqlite3.connect(CAMINHO_BANCO)
    df = pd.read_sql("SELECT * FROM vw_eficiencia_caminhao", conexao)
    conexao.close()

    fig = plt.figure()
    ax = fig.add_subplot(projection="3d")

    posicoes_x = range(len(df))  # uma posicao por caminhao: 0, 1, 2, 3...
    posicoes_y = [0] * len(df)   # todas as barras na mesma linha
    posicoes_z = [0] * len(df)   # todas comecam do chao

    altura = df["km_por_litro"]
    ax.bar3d(posicoes_x, posicoes_y, posicoes_z, 0.5, 0.5, altura, color="steelblue")
    

    ax.set_xticks(posicoes_x)
    ax.set_xticklabels(df["placa"], rotation=45)



    


    
    ax.set_zlabel("Km por litro")
    ax.set_title("Eficiência por caminhão (km por litro)")

    plt.savefig(RAIZ / "saidas" / "grafico_3d_barras.png")
    plt.show()

    plt.show()


if __name__ == "__main__":
    gerar_grafico_barras_3d()
