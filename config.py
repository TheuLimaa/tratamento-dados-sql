"""Configurações gerais do projeto (não-sensíveis — segredos ficam em segredos/.env).
"""
from pathlib import Path

RAIZ = Path(__file__).resolve().parent
CAMINHO_FONTE = RAIZ / "banco_dados" / "fonte.db"
CAMINHO_COPIA = RAIZ / "banco_dados" / "copia.db"
URL_SIMULADOR = "http://localhost:5000/query"
