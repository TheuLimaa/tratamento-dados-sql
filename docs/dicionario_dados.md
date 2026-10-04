# Dicionário de dados — abastecimento

Tabela fonte: `abastecimento` (no banco simulado `fonte.db`)
Tabela bruta local: `abastecimento_bruto` (em `banco_dados/copia.db`, criada pela extração)

| Coluna | Tipo | Significado |
|---|---|---|
| `id` | inteiro | identificador único do registro de abastecimento |
| `placa` | texto | placa do caminhão |
| `dia` | texto (AAAA-MM-DD) | data do abastecimento |
| `horario` | texto (HH:MM) | horário do abastecimento |
| `quantidade_litros` | decimal | litros de combustível abastecidos |
| `km_rodado` | inteiro | km rodados desde o abastecimento anterior |
| `valor` | decimal | valor pago pelo abastecimento (R$) |

## Observações / pegadinhas conhecidas

- (ir preenchendo conforme for descobrindo, ex.: "quantidade_litros às vezes vem
  zerado pra abastecimentos de teste", "nem todo caminhão abastece todo ciclo")
