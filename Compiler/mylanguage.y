%{

#include "mylanguage.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(char *s);
extern int yylex(void);
extern FILE *yyin;

%}

%token VAR
%token IF
%token ELSE
%token WHILE
%token FOR
%token IN
%token BREAK
%token CONTINUE
%token RETURN
%token PRINT
%token INPUT
%token LEN
%token RANGE
%token APPEND

%token IDENTIFIER
%token INTEGER
%token FLOAT
%token STRING
%token TRUE
%token FALSE
%token EMPTY_VECTOR

%token TYPE_INTEGER
%token TYPE_FLOAT
%token TYPE_STRING

%token DOT
%token COMA
%token COLON
%token SEMICOLON
%token DOUBLEQUOTES
%token OPEN_PARAN
%token CLOSE_PARAN
%token OPEN_BRACK
%token CLOSED_BRACK
%token OPEN_CURLY
%token CLOSE_CURLY

%token EQ
%token NE
%token GE
%token LE
%token '+'
%token '-'
%token '*'
%token '/'
%token '='
%token '<'
%token '>'
%token '%'
%token '^'

%left '+' '-'
%left '*' '/' '%'
%left OR
%left AND
%left NOT
%left GE
%left LE
%left EQ
%left NE

%nonassoc '=' '<' '>'

%%

program         :stmtlist
                ;
stmtlist        :stmt
                | stmt stmtlist
                ;
stmt            :simplestmt
                | ifstmt
                | elsestmt
                | whilestmt
                | forstmt
                | returnstmt
                | readstmt
                | printstmt
                ;
simplestmt      :assignment
                | expression
                | continuestmt
                | breakstmt
                ;
assignment      :VAR IDENTIFIER '=' expression
                |IDENTIFIER '=' expression
                |VAR IDENTIFIER
                ;
expression      :arithexpr
                | boolexpr
                | function
                ;
arithexpr       :term
                | term '+' arithexpr
                | term '-' arithexpr
                ;
term            :factor
                | factor '*' term
                | factor '/' term
                | factor '%' term
                | factor '^' term
                ;
factor          :OPEN_PARAN expression CLOSE_PARAN
                | element
                ;
element         : IDENTIFIER
                | INTEGER
                | FLOAT
                | STRING
                | EMPTY_VECTOR
                ;
type            :TYPE_INTEGER
                | TYPE_FLOAT
                | TYPE_STRING
                ;
boolexpr        :TRUE
                | FALSE
                | expression EQ expression
                | expression NE expression
                | expression LE expression
                | expression GE expression
                | expression AND expression
                | expression OR expression
                | expression '<' expression
                | expression '>' expression
                | NOT expression
                ;
function        : lenfunc
                | rangefunc
                | appendfunc
                ;
ifstmt          :IF expression COLON
                ;
elsestmt        :ELSE expression COLON
                ;
whilestmt       :WHILE expression COLON
                ;
forstmt         :FOR simplestmt IN expression COLON
                ;
returnstmt      :RETURN expression
                ;
printstmt       :PRINT OPEN_PARAN DOUBLEQUOTES comment DOUBLEQUOTES CLOSE_PARAN
                ;
continuestmt    :CONTINUE
                ;
breakstmt       :BREAK
                ;
readstmt        :VAR IDENTIFIER '=' type OPEN_PARAN INPUT OPEN_PARAN CLOSE_PARAN CLOSE_PARAN
                ;
lenfunc         :LEN OPEN_PARAN IDENTIFIER CLOSE_PARAN
                ;
rangefunc       :RANGE OPEN_PARAN term COMA comment CLOSE_PARAN
                ;
appendfunc      :DOT APPEND OPEN_PARAN arithexpr CLOSE_PARAN
                ;
comment         :arithexpr comment
                |arithexpr
                ;


%%

yyerror(char *s)
{
  printf("%s\n", s);
}

int yydebug = 0;

extern FILE *yyin;

main(int argc, char **argv)
{  
  int yydebug = 0;
  if(argc>1) yyin = fopen(argv[1], "r");
  if((argc>2)&&(!strcmp(argv[2],"-d"))) yydebug = 1;
  if(!yyparse()) fprintf(stderr,"\tO.K.\n");
  return 0;
}
