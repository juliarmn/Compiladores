%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char *s);
extern int yylineno;
extern int num_linhas;
extern int num_erros;
%}
%define parse.error detailed


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

Programa_principal: MAIN PARENTESES_ABRE PARENTESES_FECHA CHAVE_ABRE Comandos CHAVE_FECHA;

Comandos: Comando Comandos 
          | Comando 
          | %empty;

Comando: Declaracao 
         | Atribuicao 
         | Print 
         | Loop 
         | Condicao 
         | Aritmetica;

Declaracao: Tipo Decl SEPARADOR;

Tipo: INT 
      | DOUBLE;
;
Decl: LISTA_VAR ;

LISTA_VAR: IDENTIFICADOR Atribui_valor VIRGULA LISTA_VAR 
           | IDENTIFICADOR Atribui_valor;

Atribui_valor: IGUAL Num 
               | %empty;

Num: INTEIRO 
     | REAL ;

Atribuicao: IDENTIFICADOR IGUAL Exp SEPARADOR ;

Exp: INT x 
     | Num x 
     | IDENTIFICADOR x; 

x: OPERADOR Exp 
   | %empty;

teste: IDENTIFICADOR LOGICO Num;

inicializador: Tipo IDENTIFICADOR IGUAL Num SEPARADOR teste SEPARADOR Aritmetica;

Aritmetica: IDENTIFICADOR IGUAL OPERADOR Termo Aritmetica 
            | %empty;

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
   | %empty;

%%

extern FILE *yyin;
void yyerror(char *s) {
/// if(strcmp(str,"syntax error")==0){
num_erros++;
printf("Erro sintático\n");
printf("O erro aparece próximo a linha: %d : %s", yylineno, s);
///}
///return num_erros;
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

yyparse();

if(num_erros==0)
puts("Análise concluída com sucesso");

return 0;
}