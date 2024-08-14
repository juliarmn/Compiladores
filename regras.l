%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int num_linhas = 1;
%}


int num_linhas = 0;

DIGITO [0-9]
LETRA [a-zA-Z]
ID     {LETRA}({LETRA}|{DIGITO}|_)*

%%

{ID} {
    printf("ID válido: %s (Linha %d)\n", yytext, num_linhas);
}

{DIGITO}+"_" {
    printf("Erro de entrada: %s na linha %d (ID inválido começando com número)\n", yytext, num_linhas);
}

{DIGITO}+{LETRA}* {
    printf("Erro de entrada: %s na linha %d (ID inválido começando com número)\n", yytext, num_linhas);
}

{DIGITO}+ {
    printf("Inteiro: %s (%d)\n", yytext, atoi(yytext));
}

{DIGITO}+"."{DIGITO}* {
    printf("Número Real: %s (%f)\n", yytext, atof(yytext));
}

"+"|"-"|"*"|"/"|"%" {
    printf("Operador matemático: %s\n", yytext);
}

"<"|"<="|">"|">="|"="|"!="|"&&"|"||" {
    printf("Operador lógico: %s\n", yytext);
}

"^^" {
    printf("Comentário\n");
}

";" {
    printf("Separador de comando\n");
}

"{"|"}"|"("|")"|"["|"]" {
    printf("Separador: %s\n", yytext);
}

\n {
    num_linhas++;
}

[\t]+ {
    /* Ignora espaços em branco e tabulações */
}

. {
    printf("Erro de entrada: %s na linha %d\n", yytext, num_linhas);
}

%%

int main(void)
{
    char nome_arquivo[100];
    
    printf("Digite o nome do arquivo: ");
    scanf("%s", nome_arquivo);
    
    yyin = fopen(nome_arquivo, "r");
    if (!yyin) {
        perror("Erro ao abrir o arquivo");
        return 1;
    }

    yylex();
    fclose(yyin);
    return 0;
}