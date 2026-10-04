"""Monta o e-mail semanal com o KPI de eficiencia dos caminhoes e manda pro
gestor, usando a funcao generica de envio/outlook.py.

AINDA NAO CONSTRUI ISSO DE VERDADE — proximo passo depois do grafico
(graficos/kpi_abastecimento.py) estar pronto.
"""
from pathlib import Path

from outlook import enviar_email

RAIZ = Path(__file__).resolve().parent.parent
GRAFICO = RAIZ / "saidas" / "kpi_eficiencia.png"


def montar_e_enviar() -> None:
    # TODO: calcular os numeros do resumo (ex.: media geral de km/litro) via
    # pandas/sqlite, pra colocar no corpo do e-mail, nao so no anexo
    corpo = "Segue o relatorio semanal de eficiencia dos caminhoes."
    enviar_email(
        destinatario="gestor@exemplo.com",  # TODO: colocar o destinatario real
        assunto="Relatorio semanal — eficiencia de combustivel",
        corpo=corpo,
        anexo=str(GRAFICO),
    )


if __name__ == "__main__":
    montar_e_enviar()
