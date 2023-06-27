/*
 * JFlex example from the user Manual
 *
 * Copyright 2020, Gerwin Klein, Régis Décamps, Steve Rowe
 * SPDX-License-Identifier: GPL-2.0-only
 */

import java_cup.runtime.Symbol;

/** Modified as a Ruby lexical analyzer */

%%

%public
%class Lexer
%unicode
%cup
%line
%column
%debug
%throws UnknownCharacterException

%{
  StringBuffer string = new StringBuffer();

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

ALPHA=[A-Za-z]
DIGIT=[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
NEWLINE=\r|\n|\r\n
WHITE_SPACE_CHAR=[\n\r\ \t\b\012]

Identifier = {ALPHA}({ALPHA}|{DIGIT}|_)*
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]
DecIntegerLiteral = 0 | [1-9][0-9]*
/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "#" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*



%state STRING

%%


/* keywords */
<YYINITIAL> "begin"           { return symbol(sym.BEGIN); }
<YYINITIAL> "end"            { return symbol(sym.END); }
<YYINITIAL> "alias"              { return symbol(sym.ALIAS); }
<YYINITIAL> "and"              { return symbol(sym.AND); }
<YYINITIAL> "break"              { return symbol(sym.BREAK); }
<YYINITIAL> "case"              { return symbol(sym.CASE); }
<YYINITIAL> "class"              { return symbol(sym.CLASS); }
<YYINITIAL> "def"              { return symbol(sym.DEF); }
<YYINITIAL> "defined"              { return symbol(sym.DEFINED); }
<YYINITIAL> "do"              { return symbol(sym.DO); }
<YYINITIAL> "else"              { return symbol(sym.ELSE); }
<YYINITIAL> "elsif"              { return symbol(sym.ELSIF); }
<YYINITIAL> "ensure"              { return symbol(sym.ENSURE); }
<YYINITIAL> "false"              { return symbol(sym.FALSE); }
<YYINITIAL> "for"              { return symbol(sym.FOR); }
<YYINITIAL> "if"              { return symbol(sym.IF); }
<YYINITIAL> "in"              { return symbol(sym.IN); }
<YYINITIAL> "module"              { return symbol(sym.MODULE); }
<YYINITIAL> "next"              { return symbol(sym.NEXT); }
<YYINITIAL> "nil"              { return symbol(sym.NIL); }
<YYINITIAL> "not"              { return symbol(sym.NOT); }
<YYINITIAL> "or"              { return symbol(sym.OR); }
<YYINITIAL> "redo"              { return symbol(sym.REDO); }
<YYINITIAL> "rescue"              { return symbol(sym.RESCUE); }
<YYINITIAL> "retry"              { return symbol(sym.RETRY); }
<YYINITIAL> "return"              { return symbol(sym.RETURN); }
<YYINITIAL> "self"              { return symbol(sym.SELF); }
<YYINITIAL> "super"              { return symbol(sym.SUPER); }
<YYINITIAL> "then"              { return symbol(sym.THEN); }
<YYINITIAL> "true"              { return symbol(sym.TRUE); }
<YYINITIAL> "undef"              { return symbol(sym.UNDEF); }
<YYINITIAL> "unless"              { return symbol(sym.UNLESS); }
<YYINITIAL> "until"              { return symbol(sym.UNTIL); }
<YYINITIAL> "when"              { return symbol(sym.WHEN); }
<YYINITIAL> "while"              { return symbol(sym.WHILE); }
<YYINITIAL> "yield"              { return symbol(sym.YIELD); }


<YYINITIAL> {
  /* identifiers */
  {Identifier}                   { return symbol(sym.IDENTIFIER); }

  /* literals */
  {DecIntegerLiteral}            { return symbol(sym.INTEGER_LITERAL); }
  \"                             { string.setLength(0); yybegin(STRING); }

  /* operators and delimiters */
  "="                            { return symbol(sym.EQ); }
  "=="                           { return symbol(sym.EQEQ); }
  "+"                            { return symbol(sym.PLUS); }
  "{"                            { return symbol(sym.LEFT_BRACE); }
  "}"                            { return symbol(sym.RIGHT_BRACE); }
  "("                            { return symbol(sym.LEFT_PAREN); }
  ")"                            { return symbol(sym.RIGHT_PAREN); }
  "."                            { return symbol(sym.DOT); }
  ";"                            { return symbol(sym.SEMICOLON); }
  "["                            { return symbol(sym.LEFT_BRACKET); }
  "]"                            { return symbol(sym.RIGHT_BRACKET); }
  "%"                            { return symbol(sym.MOD); }
  "!="                           { return symbol(sym.NEQ); }
  ">"                            { return symbol(sym.GT); }
  "<"                            { return symbol(sym.LT); }
  ">="                           { return symbol(sym.GE); }
  "<="                           { return symbol(sym.LE); }
  "<=>"                          { return symbol(sym.C_COMPARISON); }
  "&&"                           { return symbol(sym.AND_OP); }
  "||"                           { return symbol(sym.OR_OP); }
  "!"                            { return symbol(sym.NOT_OP); }
  "-"                            { return symbol(sym.MINUS); }
  "*"                            { return symbol(sym.MULTIPLY); }
  "/"                            { return symbol(sym.DIVIDE); }
  "**"                           { return symbol(sym.EXP); }
  "+="                           { return symbol(sym.PLUS_AS); }
  "-="                           { return symbol(sym.MINUS_AS); }
  "*="                            { return symbol(sym.MULTIPLY_AS); }
  "/="                            { return symbol(sym.DIVIDE_AS); }
  "%="                            { return symbol(sym.MOD_AS); }
  "**="                           { return symbol(sym.EXP_AS); }
  "&"                           { return symbol(sym.AND_BIT); }
  "|"                            { return symbol(sym.OR_BIT); }
  "^"                            { return symbol(sym.XOR_BIT); }
  "~"                            { return symbol(sym.NOT_BIT); }
  "?"                            { return symbol(sym.QUESTION); }
  ","                            { return symbol(sym.COMMA); }
  ":"                            { return symbol(sym.COLON); }
  "$"                            { return symbol(sym.DOLLAR); }
  "@"                            { return symbol(sym.AT); }
  "@@"                            { return symbol(sym.ATAT); }
  
  
  /* comments */
  {Comment}                      { /* ignore */ }

  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }
  {NONNEWLINE_WHITE_SPACE_CHAR}+ { }
  {NEWLINE} { }
}


<STRING> {
  \"                             { yybegin(YYINITIAL);
                                   return symbol(sym.STRING_LITERAL,
                                   string.toString()); }
  [^\n\r\"\\]+                   { string.append( yytext() ); }
  \\t                            { string.append('\t'); }
  \\n                            { string.append('\n'); }

  \\r                            { string.append('\r'); }
  \\\"                           { string.append('\"'); }
  \\                             { string.append('\\'); }
}


/* error fallback */
[^]                              { throw new UnknownCharacterException(yytext()); }
