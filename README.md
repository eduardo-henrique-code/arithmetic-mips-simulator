# Calculadora em Assembly MIPS

Calculadora de linha de comando escrita em **Assembly MIPS32**, desenvolvida na disciplina de **Laboratório de Arquitetura de Computadores**. O programa exibe um menu interativo no console, lê dois números inteiros e realiza as quatro operações básicas.

## Funcionalidades

- Menu principal interativo (calcular ou sair)
- Operações com números inteiros (positivos e negativos):
  - Soma
  - Subtração
  - Multiplicação
  - Divisão
- Divisão inteira com exibição do **quociente e do resto**
- Detecção de **estouro de valor** (overflow) em soma, subtração e multiplicação
- Tratamento de **divisão por zero**
- Tratamento de **opção inválida** nos dois menus
- Opções aceitas em letras **maiúsculas ou minúsculas**
- "Limpeza" de tela simulada por meio de quebras de linha
- Retorno automático ao menu após cada cálculo

## Como executar

O código usa as chamadas de sistema (`syscall`) do simulador **MARS**, então a forma mais simples de rodar é:

1. Instale o [MARS](https://dpetersanderson.github.io/) (requer Java).
2. Abra o arquivo `calculadora.asm` em **File → Open**.
3. Monte o programa com **Run → Assemble** (tecla `F3`).
4. Execute com **Run → Go** (tecla `F5`).
5. Interaja pela janela **Run I/O** na parte inferior.

> O programa também deve funcionar no SPIM/QtSpim, pois utiliza apenas syscalls padrão.

## Como usar

1. No menu principal, digite `C` para fazer um cálculo ou `X` para sair.
2. Informe o 1º e o 2º número (um por vez, confirmando com `Enter`).
3. Escolha a operação digitando uma das teclas da tabela abaixo.
4. O resultado é exibido e o programa volta ao menu principal.

Operações disponíveis:

| Tecla | Operação      |
|-------|---------------|
| `A`   | Soma          |
| `S`   | Subtração     |
| `M`   | Multiplicação |
| `D`   | Divisão       |

### Exemplo de execução

```
==============================
|     CALCULADORA ASSEMBLY   |
==============================
|  C - Calculo               |
|  X - Sair                  |
==============================
>> Digite a opcao: C
==============================
Digite o 1o numero: 20
Digite o 2o numero: 4
...
|  A - Soma                  |
|  S - Subtracao             |
|  M - Multiplicacao         |
|  D - Divisao               |
==============================
>> Digite a opcao: M

==============================
  Resultado: 80
```

## Como o código funciona

### Estrutura

| Rótulo               | Função                                                        |
|----------------------|---------------------------------------------------------------|
| `main`               | Exibe o menu principal e lê a opção (`C` ou `X`)              |
| `loop`               | Lê os dois números e a operação desejada                      |
| `chamar_soma`        | Executa `addu` e verifica overflow                            |
| `chamar_subtracao`   | Executa `subu` e verifica overflow                            |
| `chamar_multiplicacao` | Executa `mult`, lê `LO` e `HI` e verifica overflow          |
| `chamar_divisao`     | Verifica divisor zero; executa `div` e lê `LO` (quociente) e `HI` (resto) |
| `exibe`              | Limpa a tela e imprime o resultado                            |
| `exibe_divisao`      | Limpa a tela e imprime o quociente e o resto                  |
| `error`              | Mensagem de opção inválida                                    |
| `divisor_zero`       | Mensagem de divisão por zero                                  |
| `overflow`           | Mensagem de estouro de valor                                  |
| `fim`                | Encerramento do programa (syscall 10)                         |

### Registradores utilizados

| Registrador | Uso                              |
|-------------|----------------------------------|
| `$t0`       | 1º número                        |
| `$t1`       | 2º número                        |
| `$t2`       | Operação escolhida               |
| `$t3`       | Resultado (quociente na divisão) |
| `$t4`       | Opção do menu principal          |
| `$t5`       | Resto da divisão / auxiliar na checagem de overflow |
| `$t6`       | Auxiliar na checagem de overflow |

### Syscalls utilizadas

| `$v0` | Serviço             |
|-------|---------------------|
| 1     | Imprimir inteiro    |
| 4     | Imprimir string     |
| 5     | Ler inteiro         |
| 10    | Encerrar programa   |
| 12    | Ler caractere       |

## Próximos passos

- [ ] Adicionar operações extras (resto isolado, potência, raiz quadrada)
- [ ] Suporte a números de ponto flutuante (divisão com casas decimais)
- [ ] Permitir encadear cálculos usando o resultado anterior

## Contexto acadêmico

Projeto desenvolvido para a disciplina **Laboratório de Arquitetura de Computadores**, com o objetivo de praticar:

- Manipulação de registradores e instruções aritméticas
- Desvios condicionais e incondicionais (`beq`, `j`)
- Entrada e saída por syscalls
- Organização de um programa em Assembly (segmentos `.data` e `.text`)
