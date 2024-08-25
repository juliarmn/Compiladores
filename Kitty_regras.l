%{
    int num_linhas = 1, num_erros = 0;
%}

/*Definições*/

DIGITO [0-9]
LETRA [a-zA-Z]
ID {LETRA}({LETRA}|{DIGITO}|_)*
ESPACO [\t\r ]

%%

{ID}"="{DIGITO}+"."{DIGITO}+ {
    printf("\33[1m\033[38;5;208mComando de atribuição: \033[0m%s\n", yytext);
}

{ID}"="{DIGITO}+ {
    printf("\33[1m\033[38;5;208mComando de atribuição: \033[0m%s\n", yytext);
}

{ID}"="{ID} {
    printf("\33[1m\033[38;5;208mComando de atribuição: \033[0m%s\n", yytext);
}

{DIGITO}+{ID}|{DIGITO}+"_"{ID}|"_"{ID}|"_"{ID}{DIGITO}+ {
    printf("\033[1m\033[91mIdentificador inválido: %s - ", yytext);
    num_erros++;
    printf("Linha: %d\n", num_linhas);
}

{DIGITO}+ {
    printf("\033[1m\033[92mInteiro: \033[0m%s\n", yytext);
}

{DIGITO}+"."{DIGITO}+ {
    printf("\033[1m\033[92mReal: \033[0m%s\n", yytext);
}

"-"|"+"{DIGITO}+ {
    printf("\033[1m\033[92mInteiro com sinal: \033[0m%s\n", yytext);
}

"-"|"+"{DIGITO}+"."{DIGITO}+ {
    printf("\033[1m\033[92mReal com sinal: \033[0m%s\n", yytext);
}

{ID} {
    printf("\33[1m\033[93mIdentificador: \33[0m%s\n", yytext);
}

"+"|"-"|"*"|"/"|"%" {
    printf("\033[1m\033[94mOperador matemático: \033[0m%s\n", yytext);
}

">"|"<"|">="|"<="|"!="|"=="|"&"|"|"|"@" {
    printf("\033[1m\033[94mOperador lógico: \033[0m%s\n", yytext);
}



";" {
    printf("\033[1m\033[35mSeparador de comando:\033[0m %s\n", yytext);
}

"("|")"|"{"|"}"|"["|"]" {
    printf("\033[1m\033[35mSeparador: \033[0m%s\n", yytext);
}

"^^"[^\n]* {
    printf("\033[1m\033[35mComentário\n");
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

%%

int yywrap();

int main(void) {  /* Aqui foi adicionado o tipo de retorno explicitamente */
    yylex();
    printf("\033[1m\033[91mTotal de erros: %d\n", num_erros);

    if (num_erros == 0) {
        printf("\t\033[1m\033[95m /\\_/\\  \n");
        printf("\t( o.o ) \n");
        printf("\t > ^ <  \n");
        printf("\033[1m\033[95mCódigo compilado com sucesso\n");
    }
    return 0;
}

int yywrap () {
    return 1;
}
