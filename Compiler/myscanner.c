#include <stdio.h>
#include "mylanguage.tab.h"

extern FILE *yyin;   // Input file for the lexer
extern int yylex();  // Lexer function
extern char *yytext;  // Token text

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening input file");
        return 1;
    }

    yyin = file;

    int token;
    while ((token = yylex())) {
        printf("Token: %d, Text: %s\n", token, yytext);
    }

    fclose(file);
    return 0;
}
