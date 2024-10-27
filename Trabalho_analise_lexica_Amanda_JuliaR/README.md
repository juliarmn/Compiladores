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

# Segunda parte - analisador sintático

Seguindo para a próxima etapa da linguagem Kitty, deve-se tger na máquina o Bison.

## Instalação

### FEDORA

    sudo dnf install bison

### ARCH

    sudo pacman -Syu bison

### UBUNTU / DEBIAN

    sudo apt-get install bison
    
## Compilar e rodar

Para compilar seu código bison(Yacc), você tem que ter o arquivo com extensão *.y*, que é o analisador sintático, e um *.l*, que é o léxico que passa os tokens para o sintático, assim, logo após:

    bison -d Kitty_sintaxe.y

    flex Kitty_regras.l

    gcc -o programa Kitty_sintaxe.tab.c lex.yy.c -lfl

Por fim, para rodar:

    ./prog programa_sucesso.txt

## Testes

Para testar tem dois programas, um que está correto para o análisador sintático (programa_sucesso.txt), e outro com erro (programa_falha.txt).