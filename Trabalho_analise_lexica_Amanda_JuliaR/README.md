# Analizador Léxico com flex

## Instalação

Para usar o LEX, programa para gerar analisadores léxicos, é necessário fazer a instalação, de acordo com cada distribuição:

### FEDORA

    sudo dnf install flex

### ARCH

    sudo pacman -Syu install bison flex

### UBUNTU / DEBIAN

    sudo apt-get install flex libfl-dev

## Compilar e rodar

Para compilar seu código flex, você tem que ter o arquivo com extensão *.l*, assim, logo após:

    flex regras.l

Depois para compilar:

    gcc lex.yy.c -o prog

Por fim, para rodar:

    ./prog < nomes.txt

## Sobre a linguagem Kitty

No analisador léxico, verificamos os sinais de atribuição, os sinais do alfabeto aceitos pela linguagem, os tipos de variáveis (declarações de variável), operadores e sinais matemáticos e lógicos. Tudo isso por meio de gramáticas regulares.