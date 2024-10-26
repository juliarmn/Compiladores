%{
    #include <stdio.h>
    #include "Kitty_sintaxe.tab.h"
    int num_linhas = 1, num_erros = 0;
%}
%option yylineno
/*Definições*/

DIGITO [0-9]
LETRA [a-zA-Z]
ID {LETRA}({LETRA}|{DIGITO}|_)*
ESPACO [\t\r ]
ESPECIAL [_]
EOL            \r?\n
IDENTIFICADOR {LETRA}({LETRA}|{DIGITO})*
INTEIRO {DIGITO}+
REAL {DIGITO}+"."{DIGITO}+ 
IGUAL "="
ENDERECO "@"
OPERADOR "+"|"-"|"*"|"/"|"%"
LOGICO ">"|"<"|">="|"<="|"!="|"=="|"&"|"|" 
SEPARADOR ";"
PARENTESES_ABRE "("
PARENTESES_FECHA ")"
CHAVE_ABRE "{"
CHAVE_FECHA "}"
COLCHETE_ABRE "["
COLCHETE_FECHA "]"
ASPAS "'"
MAIN main
INT int
DOUBLE double
VIRGULA ,
WHILE while
FOR for
IF if
ELSE else
PRINT print


%%

{DIGITO}+{ID}|{DIGITO}+"_"{ID}|"_"{ID}|"_"{ID}{DIGITO}+ {
    printf("\033[1m\033[91mIdentificador inválido: %s - ", yytext);
    num_erros++;
    printf("Linha: %d\n", num_linhas);
}

{MAIN} {return (MAIN);}

{EOL} {
    num_linhas++;
}

{INT} {return (INT);}

{DOUBLE} {return (DOUBLE);}

{VIRGULA} {return (VIRGULA);}

{WHILE} {return (WHILE);}

{FOR} {return (FOR);}

{IF} {return (IF);}

{ELSE} {return (ELSE);}

{PRINT} {return (PRINT);}

{INTEIRO} {return (INTEIRO);}

{REAL} {return (REAL);}

{IDENTIFICADOR} {return (IDENTIFICADOR);}

{IGUAL} {return (IGUAL);}

{ENDERECO} {return (ENDERECO);}

{OPERADOR} {return (OPERADOR);}

{LOGICO} {return (LOGICO);}

{SEPARADOR} {return (SEPARADOR);}

{PARENTESES_ABRE} {return (PARENTESES_ABRE);}

{PARENTESES_FECHA} {return (PARENTESES_FECHA);}

{CHAVE_ABRE} {return (CHAVE_ABRE);}

{CHAVE_FECHA} {return (CHAVE_FECHA);}

{COLCHETE_ABRE} {return (COLCHETE_ABRE);}

{COLCHETE_FECHA} {return (COLCHETE_FECHA);}

{ASPAS} {return (ASPAS);}

"^^"[^\n]* {
    printf("\033[1m\033[35mComentário\n");
}


{ESPACO}

. {
    printf("\033[1m\033[91mTOKEN INVÁLIDO: %s - ", yytext);
    num_erros++;
    printf("Linha: %d \n", num_linhas);
}



