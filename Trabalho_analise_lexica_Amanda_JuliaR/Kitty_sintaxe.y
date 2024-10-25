%{
#include "cabecalho.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex(void);  // Declaração de yylex
extern int num_linhas;
extern int num_erros;
%}

%token IDENTIFICADOR INTEIRO REAL OPERADOR ENDERECO
%token IGUAL SEPARADOR
%token LOGICO
%token ASPAS
%token PARENTESES_ABRE PARENTESES_FECHA
%token CHAVE_ABRE CHAVE_FECHA
%token COLCHETE_ABRE COLCHETE_FECHA
%token INT DOUBLE VIRGULA MAIN
%token PRINTF WHILE IF ELSE FOR
%start Programa_principal

%%

Programa_principal: MAIN PARENTESES_ABRE PARENTESES_FECHA CHAVE_ABRE Comandos CHAVE_FECHA 
                    | error {yyerror("", num_linhas); };

Comandos: Comando Comandos 
          | Comando 
          | ;

Comando: Declaracao 
         | Atribuicao 
         | Print 
         | Loop 
         | Condicao 
         | Aritmetica 
         | error {yyerror("", num_linhas); };

Declaracao: Tipo Decl SEPARADOR;

Tipo: INT 
      | DOUBLE;

Decl: LISTA_VAR ;
LISTA_VAR: IDENTIFICADOR Atribui_valor VIRGULA LISTA_VAR 
           | IDENTIFICADOR Atribui_valor;

Atribui_valor: IGUAL Num 
               | ;

Num: INTEIRO 
     | REAL ;

Atribuicao: IDENTIFICADOR IGUAL Exp SEPARADOR ;

Exp: INT x 
     | Num x 
     | IDENTIFICADOR x; 

x: OPERADOR Exp 
   | ;

teste: IDENTIFICADOR LOGICO Num;

inicializador: Tipo IDENTIFICADOR IGUAL Num SEPARADOR teste SEPARADOR Aritmetica;

Aritmetica: IDENTIFICADOR IGUAL OPERADOR Termo Aritmetica 
            | ;

Termo: Num 
       | IDENTIFICADOR 
       | PARENTESES_ABRE Exp PARENTESES_FECHA;

Loop: WHILE PARENTESES_ABRE teste PARENTESES_FECHA CHAVE_ABRE Comandos CHAVE_FECHA 
      | FOR PARENTESES_ABRE inicializador PARENTESES_FECHA CHAVE_ABRE Comandos CHAVE_FECHA;

Condicao: IF PARENTESES_ABRE teste PARENTESES_FECHA CHAVE_ABRE Comandos CHAVE_FECHA 
          | IF PARENTESES_ABRE teste PARENTESES_FECHA CHAVE_ABRE Comandos CHAVE_FECHA ELSE CHAVE_ABRE Comandos CHAVE_FECHA;

Print: PRINTF PARENTESES_ABRE ASPAS Qualquer_palavra ASPAS PARENTESES_FECHA SEPARADOR;

Qualquer_palavra: IDENTIFICADOR y;

y: IDENTIFICADOR y 
   | ;

%%

extern FILE *yyin;
int yyerror(char *str, int num_linha) {
if(strcmp(str,"syntax error")==0){
num_erros++;
printf("Erro sintático\n");//Exibe mensagem de erro
}
else
{
printf("O erro aparece próximo à linha %d\n", num_linha);//Exibe a linha do erro
}
return num_erros;
}

int main (int argc, char **argv )
{
++argv, --argc;
if ( argc > 0 )
yyin = fopen( argv[0], "r" );
else
{
puts("Falha ao abrir arquivo, nome incorreto ou não especificado. Digite o comando novamente.");
exit(0);
}
do {
yyparse();
} while (!feof(yyin));
if(num_erros==0)
puts("Análise concluída com sucesso");

return 0;
}