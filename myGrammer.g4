grammar         myGrammer;
start:          importState* class+ ;
//------------------------------------------------------------------------------------------------------------------------------------------------------
//استفاده کردن از کتابخانه ها و اجزای آن ها
importState: Imp ':' ':' From '(' class_name ',' class_names ((class_names)*)? ')' '.' Semicolon? Semicolon?|
            Imp ':' ':' From '(' class_name ',' '*' ')' '.' Semicolon? Semicolon?;
 //------------------------------------------------------------------------------------------------------------------------------------------------------
 //تعریف کلاس
 class:          Accessibility? VAR_NAME Class ( Inherited From class_names)?
                 (Implements class_name (',' class_name)* )? Begin  class_Body End Semicolon?;
 class_Body:      vari| arr|  function|reference|assigning|procedur;
 //------------------------------------------------------------------------------------------------------------------------------------------------------
 //تعریف تابع
 function:       Accessibility? Static? Func VAR_NAME '(' cal ')' Returns Type('{' codes
                 (Return '('data_type ')' Semicolon?)? '}'Semicolon?)? Semicolon?;
  function_call: VAR_NAME '('VAR_NAME? string? char?')' ';'?;
 cal1:VAR_NAME Type;
 cal2:Var VAR_NAME':'Type;
 cal:(((cal1|cal2)';'?)*(cal1|cal2))?;
     string
         : '"'.*?'"' |'‘'.*?'’' ;
     char
         : '"'CHAR'"' | '‘'CHAR'’';
 //------------------------------------------------------------------------------------------------------------------------------------------------------
 arethmics:areth|areth('*='|'/='|'-='|'+='|'=='|'-'|'+'|'%'|'//'|'/'|'*')arethmics;
//------------------------------------------------------------------------------------------------------------------------------------------------------
//تعریف متغیر
vari:            (Accessibility)? Const? Var VAR_NAME(','VAR_NAME)* ':' (Type) ('='data_type)? (Semicolon)?|
 (Accessibility)? (Const)? Var VAR_NAME':' Type ( '=' data_type )? ';'? ;
 //------------------------------------------------------------------------------------------------------------------------------------------------------
 ternary:condtions'?'codes':'codes Semicolon?;
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //تعریف رویه
  procedur:      (Accessibility)? Static? Proc VAR_NAME '(' procedur_body ')' Semicolon?;
    procedur_body:codes;
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //کدهای داخل بلوک ها
  code:           (vari | arr|procedur | assigning | for | while | do | if | switch | try  | expression|
                  reference|ternary|arethmics|function|function_call|UNARY_TYPE';'?|UNARY_MINUS';'?) ;
  codes:code|code codes;
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //تعریف آرایه
  arr:            Accessibility? Const? Var '['( '0' ':'POS_DECIMAL )? ']' VAR_NAME ':' Type
                  ( '=' '{' '['(data_type)?(','data_type*) ']' '}' )?Semicolon?;
 //------------------------------------------------------------------------------------------------------------------------------------------------------
 //  تعریف ارجاعات
 reference:Accessibility? class_name VAR_NAME'->'((New class_name '(' cal')')|NULL);
//------------------------------------------------------------------------------------------------------------------------------------------------------
//حلقه فور
for:  for1 |for2;
cond:BOOL_TYPE|((VAR_NAME|data_type)(And|Or|And And|Or Or|'=='|'!='|'<='|'>='|'<'|'>')(VAR_NAME|data_type));
condtions:cond|cond(And|Or|And And|Or Or|'=='|'!='|'<='|'>='|'<'|'>')condtions;
areth:(VAR_NAME|data_type)('*='|'/='|'-='|'+='|'=='|'-'|'+'|'%'|'//'|'/'|'*')(VAR_NAME|data_type);
body:codes?';'?|'{'codes?'}'';'?|'{'codes'}'';'?;
for1:For '(' ((Accessibility)? Const? Var VAR_NAME ':' Type('=' data_type)?)?(Semicolon? condtions)?
    (Semicolon?UNARY_TYPE)? ')' body ?;
for2:For Every (Accessibility)? Var VAR_NAME In (VAR_NAME|'['data_type ']') Do codes Until End;
//------------------------------------------------------------------------------------------------------------------------------------------------------
//حلقه وایل
while:          While '(' condtions ')' Begin (codes )? End;
do:        Do (codes )? As condtions Semicolon? ;
//------------------------------------------------------------------------------------------------------------------------------------------------------
//ایف الس
if:             If '{' condtions '}' Then (codes )?Semicolon?(Elif '(' condtions ')' Do (codes)?End)?(elseDo )? ;
elseDo: ElseDo (codes)? Stop?;
//------------------------------------------------------------------------------------------------------------------------------------------------------
//سوییچ کیس
switch:         Switch (expression ) Match Begin? cases default? End;
case:           Case VAR_NAME ':' code? (Break Semicolon?)? Semicolon?;
cases:          case cases|case;
default:        Default data_type ':' code? (Break ';'?)? End;
//------------------------------------------------------------------------------------------------------------------------------------------------------
//تعریف خطا
error:class_name VAR_NAME;
errors:error|error','errors;
try:            Try '{' '{' codes? '}' '}' catchBlock;
catchBlock:    Catch '('errors ')'Begin codes? End ;
//------------------------------------------------------------------------------------------------------------------------------------------------------
//مقدار دهی کردن
assigning:VAR_NAME'<-'(code|data_type)Semicolon?;
//------------------------------------------------------------------------------------------------------------------------------------------------------
//عبارات
expression:     '(' expression ')' |
                expression '^' expression |
                '++' expression |expression'++'|'--'expression|expression'--'|'-'expression |
                expression ('<<' | '>>') expression |
                expression ('*'|'/' | '/''/'  | '%') expression |
                ('+' |'-') expression | expression ('+'|'-') |
                ('+''+' | '-''-') expression | expression ('+''+' |'-''-' ) |
                 expression ( '&&') expression |
                 expression (And | '&') expression |
                 expression ( '||' ) expression |
                 expression (Or | '|' ) expression |
                 expression ('=' '=' | '!''=' ) expression |
                 expression ( '<' '='| '>''=') expression |
                 expression ('<' | '>' ) expression |
                 expression ('-' '=' | '+' '=') expression |
                 expression ('/' '=' | '*' '=' ) expression |
                data;
data:           ('+' | '-')? (Name | INTEGER_TYPE | FLOAT_TYPE | CHAR_TYPE | STRING_TYPE |BOOL_TYPE |VAR_NAME);
 class_names:class_name|class_name','class_names;
 class_name:VAR_NAME;
//------------------------------------------------------------------------------------------------------------------------------------------------------
//تعریف مت
//------------------------------------------------------------------------------------------------------------------------------------------------------
//نامگذاری متغیرها.
//------------------------------------------------------------------------------------------------------------------------------------------------------
//اسامی خاص
//------------------------------------------------------------------------------------------------------------------------------------------------------
//مقدار دهی به متغیرها
 Type:           INTEGER| FLOAT  | CHAR | BOOL| STRING| VOID;
 DECIMAL : '0' | POS_DECIMAL | NEG_DECIMAL;
INTEGER_TYPE:  DECIMAL|HEX_DECIMAL|BINARY;
data_type:INTEGER_TYPE|FLOAT_TYPE|CHAR_TYPE|STRING_TYPE|BOOL_TYPE|NULL;
UNARY_TYPE:VAR_NAME('++'|'--')|('++'|'--')VAR_NAME;
UNARY_MINUS:'-'VAR_NAME;
//------------------------------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------------------------------------------------------------------------------------------------
//فرگمنت ها
fragment Letter:[a-zA-Z];
fragment Digit: [0-9];
fragment Esc:   '\\' [btnr"\\];
Semicolon:       ';';
SHIFT:           '<<'|'>>';
BracketO:         '{';
BracketC:          '}';
Pwr:               '^';
Ques:              '?';
Star :             '*';
Div  :             '/';
Plus :             '+';
ParantOPen:        '(';
ParantClose:       ')';
As:           ('A' | 'a')('S' | 's') '_'('L' | 'l')('O' | 'o')('N' | 'n')('G' | 'g')'_' ('A' | 'a')('S' | 's') ;
ElseDo: ('E' | 'e')('L' | 'l')('S' | 's')('E' | 'e')  ('D' | 'd')('O' | 'o') ('A' | 'a')('S' | 's') Follow;
Not:       ('N' | 'n')('O' | 'o') ('T' | 't');
Begin: ('B' | 'b')('E' | 'e')('G' | 'g')('I' | 'i')('N' | 'n') ;
Case: ('C' | 'c')('A' | 'a')('S' | 's')('E' | 'e') ;
Follow: ('F' | 'f')('O' | 'o')('L' | 'l')('L' | 'l')('O' | 'o')('W' | 'w') ;
Long : ('L' | 'l')('O' | 'o')('N' | 'n')('G' | 'g') ;
From: ('F' | 'f')('R' | 'r')('O' | 'o')('M' | 'm') ;
End: ('E' | 'e')('N' | 'n')('D' | 'd') ;
Return: ('R' | 'r')('E' | 'e')('T' | 't')('U' | 'u')('R' | 'r')('N' | 'n') ;
Var:  ('V' | 'v')('A' | 'a')('R' | 'r') ;
Func : ('F' | 'f')('U' | 'u')('N' | 'n')('C' | 'c') ;
For:        ('F' | 'f')('O' | 'o')('R' | 'r') ;
Every:  ('E' | 'e')('V' | 'v')('E' | 'e')('R' | 'r')('Y' | 'y') ;
Until: ('U' | 'u')('N' | 'n')('T' | 't')('I' | 'i')('L' | 'l') ;
Match: ('M' | 'm')('A' | 'a')('T' | 't')('C' | 'c')('H' | 'h') ;
Stop : ('S' | 's')('T' | 't')('O' | 'o')('P' | 'p') ;
Class: ('C' | 'c')('L' | 'l')('A' | 'a')('S' | 's')('S' | 's') ;
Inherited:  ('I' | 'i')('N' | 'n')('H' | 'h')('E' | 'e')('R' | 'r')('I' | 'i')('T' | 't')('E' | 'e')('D' | 'd');
Implements: ('I' | 'i')('M' | 'm')('P' | 'p')('L' | 'l')('E' | 'e')('M' | 'm')('E' | 'e')('N' | 'n')('T' | 't')('S' | 's') ;
Static: ('S' | 's')('T' | 't')('A' | 'a')('T' | 't')('I' | 'i')('C' | 'c') ;
Returns: ('R' | 'r')('E' | 'e')('T' | 't')('U' | 'u')('R' | 'r')('N' | 'n')('S' | 's') ;
Proc:  ('P' | 'p')('R' | 'r')('O' | 'o')('C' | 'c') ;
Const: ('C' | 'c')('O' | 'o')('N' | 'n')('S' | 's')('T' | 't')('A' | 'a')('N' | 'n')('T' | 't') ;
New: ('N' | 'n')('E' | 'e')('W' | 'w') ;
Switch: ('S' | 's')('W' | 'w')('I' | 'i')('T' | 't')('C' | 'c')('H' | 'h') ;
Break: ('B' | 'b')('R' | 'r')('E' | 'e')('A' | 'a')('K' | 'k') ;
Default:  ('D' | 'd')('E' | 'e')('F' | 'f')('A' | 'a')('U' | 'u')('L' | 'l')('T' | 't') ;
Try: ('T' | 't')('R' | 'r')('Y' | 'y') ;
Catch: ('C' | 'c')('A' | 'a')('T' | 't')('C' | 'c')('H' | 'h') ;
Then:  ('T' | 't')('H' | 'h')('E' | 'e')('N' | 'n') ;
Imp : ('I' | 'i')('M' | 'm')('P' | 'p')('O' | 'o')('R' | 'r')('T' | 't') ;
NULL :       ('N' | 'n')('U' | 'u')('L' | 'l')('L' | 'l') ;
True :         ('T' | 't')('R' | 'r')('U' | 'u')('E' | 'e') ;
False:        ('F' | 'f')('A' | 'a')('L' | 'l')('S' | 's')('E' | 'e') ;
While: ('W' | 'w')('H' | 'h')('I' | 'i')('L' | 'l')('E' | 'e') ;
And: ('A' | 'a')('N' | 'n')('D' | 'd') ;
Void:  ('V' | 'v')('O' | 'o')('I' | 'i')('D' | 'd') ;
If: ('I' | 'i')('F' | 'f') ;
AS : ('A' | 'a')('S' | 's') ;
Do: ('D' | 'd')('O' | 'o') ;
In:  ('I' | 'i')('N' | 'n') ;
Or: ('O' | 'o')('R' | 'r') ;
Elif : ('E' | 'e')('L' | 'l')('I' | 'i')('F' | 'f') ;
Else: ('E' | 'e')('L' | 'l')('S' | 's')('E' | 'e') ;
//Digit : ('D' | 'd') ('I' | 'i') ('G'|'g') ('I' | 'i') ('T' | 't');
INTEGER : ('I' | 'i')('N' | 'n')('T' | 't')('E' | 'e')('G' | 'g')('E' | 'e')('R' | 'r') ;
FLOAT : ('F' | 'f')('L' | 'l')('O' | 'o')('A' | 'a')('T' | 't') ;
CHAR : ('C' | 'c')('H' | 'h')('A' | 'a')('R' | 'r') ;
BOOL: ('B' | 'b')('O' | 'o')('O' | 'o')('L' | 'l')('E' | 'e')('A' | 'a')('N' | 'n') ;
STRING : ('S' | 's')('T' | 't')('R' | 'r')('I' | 'i')('N' | 'n')('G' | 'g') ;
VOID:('V'|'v')('O' | 'o')('I' | 'i')('D' | 'd');
PRE_INCREMENT : '++'VAR_NAME;
POST_INCREMENT : VAR_NAME'++';
PRE_DECREMENT : '--'VAR_NAME;
POST_DECREMENT : VAR_NAME'--';
NEGATIVE : '-'VAR_NAME;
Accessibility:  DIRECTACCESS | INDIRECTACCESS | RESTRICTED ;
DIRECTACCESS : ('D' | 'd')('I' | 'i')('R' | 'r')('E' | 'e')('C' | 'c')('T' | 't')('A' | 'a')('C' | 'c')('C' | 'c')
('E' | 'e')('S' | 's')('S' | 's') ;
INDIRECTACCESS : ('I' | 'i')('N' | 'n')('D' | 'd')('I' | 'i')('R' | 'r')('E' | 'e')('C' | 'c')('T' | 't')('A' | 'a')
('C' | 'c')('C' | 'c')('E' | 'e')('S' | 's')('S' | 's') ;
RESTRICTED : ('R' | 'r')('E' | 'e')('S' | 's')('T' | 't')('R' | 'r')('I' | 'i')('C' | 'c')('T' | 't')('E' | 'e')
('D' | 'd') ;
POS_DECIMAL : [1-9]+ Digit* ;
NEG_DECIMAL : '-'POS_DECIMAL ;
HEX_DECIMAL : '0'('X' | 'x')('0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' |'A' | 'a' | 'B' | 'b' |
 'C' | 'c' | 'D' | 'd' | 'E' | 'e' | 'F' | 'f')+;
BINARY : ('0' | '1')+('B' | 'b');
FLOAT_TYPE:'-'? Digit+ ('.' Digit+)? |'-'? Digit '.' Digit+('e'|'E')?('-'|'+')?Digit* INTEGER_TYPE;
STRING_TYPE: '"' (.)*? '"'|'"'Letter+ '"' |'‘'Letter+ '’';
BOOL_TYPE:         True|False ;
/*CAPITAL_THEN_SMALL:ALPHCA VAR_NAME ALPHSM;
ALPHCA:[A-Z];
ALPHSM:[a-z];*/
VAR_NAME :[a-zA-Z]+[a-zA-Z0-9]*| ([a-z])([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?
([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?
([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?
([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?
([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?([a-zA-Z0-9_])?;
CHAR_TYPE: '/''.''/'| [a-zA-Z_$];
CLASS_NAME : [A-Z]+([a-zA-Z0-9_$])*;
Name:           [a-zA-Z0-9_$]+;
Character:      Letter+ | Digit+ | '_' ;
WS:[ \t\n\r]+ -> skip;
CommentSL:      '--' (.*? |[r\n]*) -> skip ;
CommentML:      '!#' .*? '!#' -> skip ;
