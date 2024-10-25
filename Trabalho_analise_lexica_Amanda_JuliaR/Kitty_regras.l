%{
    #include <stdio.h>
    #define IDENTIFICADOR 1
     #define INTEIRO 2
    #define REAL 3
    #define IGUAL 4
    #define ENDERECO 5
    #define OPERADOR 6
    #define LOGICO 7
    #define SEPARADOR 8
    #define PARENTESES_ABRE 9
    #define PARENTESES_FECHA 10
    #define CHAVE_ABRE 11
    #define CHAVE_FECHA 12
    #define COLCHETE_ABRE 13
    #define COLCHETE_FECHA 14
    #define ASPAS 15
     #define MAIN 16
    #define INT 17
    #define DOUBLE 18
    #define VIRGULA 20
    #define WHILE 21
    #define FOR 22
    #define IF 23
    #define ELSE 24
    #define PRINT 25

    int num_linhas = 1, num_erros = 0;
%}
%option yylineno
/*Definições*/

DIGITO [0-9]
LETRA [a-zA-Z]
ID {LETRA}({LETRA}|{DIGITO}|_)*
ESPACO [\t\r ]
ESPECIAL [_]


%%

{DIGITO}+{ID}|{DIGITO}+"_"{ID}|"_"{ID}|"_"{ID}{DIGITO}+ {
    printf("\033[1m\033[91mIdentificador inválido: %s - ", yytext);
    num_erros++;
    printf("Linha: %d\n", num_linhas);
}

"main" {
    return MAIN;
}
"int" {

    return INT;
}

"double" {
    return DOUBLE;
}

"," {
    return VIRGULA;
}

"while" {
    return WHILE;
}

"for" {
    return FOR;
}

"if" {
    return IF;
}

"else" {
    return ELSE;
}

"print" {
    return PRINT;
}

{DIGITO}+ {
    printf("\033[1m\033[92mInteiro: \033[0m%s\n", yytext);
    return INTEIRO;
}

{DIGITO}+"."{DIGITO}+ {
    printf("\033[1m\033[92mReal: \033[0m%s\n", yytext);
    return REAL;
}

{ID} {
    printf("\33[1m\033[93mIdentificador: \33[0m%s\n", yytext);
    return IDENTIFICADOR;
}

"=" {
    printf("\33[1m\033[38;5;208mComando de atribuição: \033[0m%s\n", yytext);
    return IGUAL;
}

"@" {
    return ENDERECO;
}

"+"|"-"|"*"|"/"|"%" {
    printf("\033[1m\033[94mOperador matemático: \033[0m%s\n", yytext);
    return OPERADOR;
}

">"|"<"|">="|"<="|"!="|"=="|"&"|"|" {
    printf("\033[1m\033[94mOperador lógico: \033[0m%s\n", yytext);
    return LOGICO;
}



";" {
    printf("\033[1m\033[35mSeparador de comando:\033[0m %s\n", yytext);
    return SEPARADOR;
}

"("|")" {
    return yytext[0] == '(' ? PARENTESES_ABRE : PARENTESES_FECHA;
    printf("\033[1m\033[35mPAR:\033[0m %s\n", yytext);
}

"{"|"}" {
    return yytext[0] == '{' ? CHAVE_ABRE : CHAVE_FECHA;
}

"["|"]" {
    return yytext[0] == '[' ? COLCHETE_ABRE : COLCHETE_FECHA;
}

"^^"[^\n]* {
    printf("\033[1m\033[35mComentário\n");
}

"'" {
    return ASPAS;
}


\n {
    num_linhas++;
}

{ESPACO}

. {
    printf("\033[1m\033[91mTOKEN INVÁLIDO: %s - ", yytext);
    num_erros++;
    printf("Linha: %d \n", num_linhas);
}



