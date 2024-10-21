echo "Iniciando o BISON"
bison -d Kitty_sintaxe.y
echo "Renomeando arquivos"
mv Kitty_sintaxe.tab.h analisador.h
mv Kitty_sintaxe.tab.c Kitty_sintaxe.c
echo "Iniciando FLEX"
flex Kitty_regras.l
echo "Renomeando arquivos"
mv lex.yy.c Kitty_regras.c
echo "Compilando arquivos"
gcc -c Kitty_regras.c -o Kitty_regras.o
gcc -c Kitty_sintaxe.c -o Kitty_sintaxe.o
gcc -o comp Kitty_regras.o Kitty_sintaxe.o -lfl -lm
echo "Para executar o compilador digite: ./comp programa.txt"
