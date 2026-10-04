"""Orquestra a rotina semanal inteira, em sequência: extração -> tratamento SQL
-> gráfico -> e-mail. É este script que o Agendador de Tarefas do Windows chama
(via rodar_semanal.bat), toda segunda de manhã.

AINDA NAO CONSTRUI ISSO DE VERDADE — monto depois que cada etapa individual
(extração, views, gráfico, e-mail) já estiver funcionando sozinha.
"""
import subprocess
import sys
from datetime import datetime
from pathlib import Path

RAIZ = Path(__file__).resolve().parent
LOG = RAIZ / "logs" / "rodar_semanal.log"
ULTIMA_EXECUCAO = RAIZ / "logs" / "ultima_execucao.txt"


def registrar(mensagem: str) -> None:
    LOG.parent.mkdir(parents=True, exist_ok=True)
    with open(LOG, "a", encoding="utf-8") as arquivo:
        arquivo.write(f"{datetime.now().isoformat()} - {mensagem}\n")


def rodar_etapa(caminho_script: str) -> None:
    registrar(f"iniciando {caminho_script}")
    resultado = subprocess.run([sys.executable, caminho_script])
    if resultado.returncode != 0:
        registrar(f"ERRO em {caminho_script}")
        raise RuntimeError(f"Etapa falhou: {caminho_script}")
    registrar(f"concluido {caminho_script}")


if __name__ == "__main__":
    # TODO: aqui o simulador/servidor_api.py precisa estar rodando antes
    # (ou, no trabalho de verdade, isso nao se aplica -- la a API ja existe)
    rodar_etapa("extracao/buscar_dados.py")
    # TODO: rodar o sql/tratamento_abastecimento.sql contra o banco
    rodar_etapa("graficos/kpi_abastecimento.py")
    rodar_etapa("envio/email_kpi_abastecimento.py")

    ULTIMA_EXECUCAO.write_text(datetime.now().isoformat(), encoding="utf-8")
