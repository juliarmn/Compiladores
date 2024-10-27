%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylineno;
extern int num_erros;

extern FILE *yyin;
void yyerror(const char *s) {
num_erros++;
printf("O erro aparece próximo a linha: %d : %s", yylineno, s);
}

%}
%define parse.error detailed


%token IDENTIFICADOR 
%token INTEIRO 
%token REAL 
%token OPERADOR 
%token ENDERECO
%token IGUAL 
%token SEPARADOR
%token CONECTOR
%token LOGICO
%token ASPAS
%token PARENTESES_ABRE 
%token PARENTESES_FECHA
%token CHAVE_ABRE 
%token CHAVE_FECHA
%token COLCHETE_ABRE 
%token COLCHETE_FECHA
%token INT 
%token DOUBLE 
%token VIRGULA 
%token MAIN
%token PRINT 
%token WHILE 
%token IF 
%token ELSE 
%token FOR
%start Programa

%%

Programa: MAIN PARENTESES_ABRE PARENTESES_FECHA CHAVE_ABRE Comandos CHAVE_FECHA;

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

Decl: LISTA_VAR;

LISTA_VAR: IDENTIFICADOR Atribui_valor VIRGULA LISTA_VAR 
           | IDENTIFICADOR Atribui_valor;

Atribui_valor: IGUAL Num 
               | %empty;

Num: INTEIRO 
     | REAL ;

Atribuicao: IDENTIFICADOR IGUAL Exp SEPARADOR ;

Exp:  Num x 
     | IDENTIFICADOR x
     | PARENTESES_ABRE Exp PARENTESES_FECHA x; 

x: OPERADOR Exp 
   | %empty;

teste: IDENTIFICADOR LOGICO Exp 
       | teste CONECTOR teste;

inicializador: IDENTIFICADOR IGUAL Exp SEPARADOR teste SEPARADOR Aritmetica
               | Tipo IDENTIFICADOR IGUAL Exp SEPARADOR teste SEPARADOR Aritmetica;

Aritmetica: IDENTIFICADOR IGUAL Termo OPERADOR Termo;

Termo: Num 
       | IDENTIFICADOR 
       | PARENTESES_ABRE Exp PARENTESES_FECHA;

Loop: WHILE PARENTESES_ABRE teste PARENTESES_FECHA CHAVE_ABRE Comandos CHAVE_FECHA 
      | FOR PARENTESES_ABRE inicializador PARENTESES_FECHA CHAVE_ABRE Comandos CHAVE_FECHA;

Condicao: IF PARENTESES_ABRE teste PARENTESES_FECHA CHAVE_ABRE Comandos CHAVE_FECHA 
          | IF PARENTESES_ABRE teste PARENTESES_FECHA CHAVE_ABRE Comandos CHAVE_FECHA ELSE CHAVE_ABRE Comandos CHAVE_FECHA;

Print: PRINT PARENTESES_ABRE ASPAS Qualquer_palavra ASPAS PARENTESES_FECHA SEPARADOR;

Qualquer_palavra: IDENTIFICADOR y;

y: IDENTIFICADOR y 
   | %empty;

%%



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
do{
      yyparse();
}while(!feof(yyin));
if(num_erros==0)
puts("Análise concluída com sucesso");

return 0;
}