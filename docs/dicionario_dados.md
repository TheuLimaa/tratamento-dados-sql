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

---

# Dicionário de dados — caminhoes

Tabela fonte: `caminhoes` (no banco simulado `fonte.db`)
Tabela bruta local: `caminhoes_bruto` (em `banco_dados/copia.db`)

| Coluna | Tipo | Significado |
|---|---|---|
| `placa` | texto | placa do caminhão (chave única — liga com `abastecimento_bruto.placa`) |
| `modelo` | texto | modelo do veículo |
| `ano_fabricacao` | inteiro | ano de fabricação |
| `motorista` | texto | motorista responsável pelo caminhão |

## Observações / pegadinhas conhecidas

- O caminhão `RST8X90` está cadastrado, mas **nunca abasteceu** ainda — é de
  propósito, pra praticar a diferença entre `INNER JOIN` (ele some do
  resultado) e `LEFT JOIN` (ele aparece, com valores nulos/zerados do lado do
  abastecimento).
- Um motorista pode dirigir mais de um caminhão (ex.: Carlos Souza aparece em
  duas placas) — então `JOIN` por `placa` traz o motorista certo de cada
  abastecimento, mas agrupar por motorista "junta" vários caminhões dele.
