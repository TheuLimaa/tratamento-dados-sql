"""Funcao generica de envio de e-mail (via SMTP). Separado num arquivo proprio
pra qualquer script de "envio/" poder reusar, sem repetir a logica de conexao.

AINDA NAO CONSTRUI ISSO DE VERDADE — fica pra quando chegarmos na etapa de
automacao/envio. As credenciais (quando existirem) vao morar em segredos/.env,
nunca direto aqui.
"""
import smtplib
from email.message import EmailMessage


def enviar_email(destinatario: str, assunto: str, corpo: str, anexo: str | None = None) -> None:
    """Monta e envia um e-mail simples, com anexo opcional (ex.: um grafico .png)."""
    # TODO: ler usuario/senha de segredos/.env (nunca hardcoded aqui)
    # TODO: montar EmailMessage() com assunto, corpo, destinatario
    # TODO: anexar o arquivo, se "anexo" for passado
    # TODO: conectar no servidor SMTP (smtplib.SMTP_SSL(...)) e enviar
    raise NotImplementedError("ainda nao implementado")
