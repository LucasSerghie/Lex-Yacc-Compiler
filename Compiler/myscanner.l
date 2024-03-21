%{
#include "mylanguage.tab.h"
void yyerror(char *s);
%}

%option yylineno

DIGIT		[0-9]
LETTER		[A-Za-z]
UNDERLINE	"_"

%%

"var"       	{ return VAR; }

"if"        	{ return IF; }

"else"      	{ return ELSE; }

"while"     	{ return WHILE; }

"for"       	{ return FOR; }

"in"        	{ return IN; }

"break"     	{ return BREAK; }

"continue"  	{ return CONTINUE; }

"return"    	{ return RETURN; }

"print"     	{ return PRINT; }

"input"     	{ return INPUT; }

"int" 			{return TYPE_INTEGER; }

"float" 		{return TYPE_FLOAT; }

"string"		{return TYPE_STRING; }

"True"      	{ return TRUE; }

"False"     	{ return FALSE; }

"len"			{ return LEN; }

"range"			{ return RANGE; }

"append"		{ return APPEND; }

"=="			{return EQ; }

"!="			{return NE; }

">="			{return GE; }

"<="			{return LE; }

"||"			{return OR; }

"&&"			{return AND; }

"!"				{return NOT; }

">"				{return '>'; }

"<"				{return '<'; }

"="				{return '='; }

"+"				{return '+'; }

"-"				{return '-'; }

"*"				{return '*'; }

"/"				{return '/'; }

"%"				{return '%'; }

"[]"			{return EMPTY_VECTOR; }

"("				{return OPEN_PARAN; }

")"				{return CLOSE_PARAN; }

"["				{return OPEN_BRACK; }

"]"				{return CLOSED_BRACK; }

"{"				{return OPEN_CURLY; }

"}"				{return CLOSE_CURLY; }

","				{return COMA; }

":"				{return COLON; }

";"				{return SEMICOLON; }

"."				{return DOT; }

"^"				{return '^'; }	

"\""    		{return DOUBLEQUOTES; }	


{LETTER}({UNDERLINE}|{LETTER}|{DIGIT})* {
	return IDENTIFIER;}

".*?" 			{
	return STRING;}

{DIGIT}+"."{DIGIT}+ {
	return FLOAT;}	

{DIGIT}+ {
	return INTEGER;}		


"//".*		;
[ \t\n]*	;

.		{printf ("Unexpected character"); }

%%

int yywrap (void) 
{
	return 1;
}