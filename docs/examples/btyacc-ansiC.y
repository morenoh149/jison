%token	AUTO REGISTER STATIC EXTERN TYPEDEF VOID CHAR SHORT INT LONG FLOAT
	DOUBLE SIGNED UNSIGNED CONST VOLATILE STRUCT UNION ENUM CASE DEFAULT
	IF SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN ELSE
	MULEQ DIVEQ MODEQ ADDEQ SUBEQ LSHEQ RSHEQ ANDEQ XOREQ OREQ
	AND OR EQU NEQ LEQ GEQ LSH RSH INC DEC ARROW IDENTIFIER STRING
	INTCONST CHARCONST FLOATCONST ELIPSIS SIZEOF

%%

translation_unit
	: external_declaration
	| translation_unit external_declaration
	;

external_declaration
	: function_definition
	| declaration
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement
	| declarator declaration_list compound_statement
	| declaration_specifiers declarator compound_statement
	| declarator compound_statement
	;

declaration
	: declaration_specifiers init_declarator_list ';'
	| declaration_specifiers ';'
	;

declaration_list
	: declaration
	| declaration_list declaration
	;

declaration_specifiers
	: storage_class_specifier declaration_specifiers
	| storage_class_specifier
	| type_specifier declaration_specifiers
	| type_specifier
	| type_qualifier declaration_specifiers
	| type_qualifier
	;

storage_class_specifier
	: AUTO
	| REGISTER
	| STATIC
	| EXTERN
	| TYPEDEF
	;

type_specifier
	: VOID
	| CHAR
	| SHORT
	| INT
	| LONG
	| FLOAT
	| DOUBLE
	| SIGNED
	| UNSIGNED
	| struct_or_union_specifier
	| enum_specifier
	| typedef_name
	;

type_qualifier
	: CONST
	| VOLATILE
	;

struct_or_union_specifier
	: struct_or_union IDENTIFIER '{' struct_declaration_list '}'
	| struct_or_union  '{' struct_declaration_list '}'
	| struct_or_union IDENTIFIER
	;

struct_or_union
	: STRUCT
	| UNION
	;

struct_declaration_list
	: struct_declaration
	| struct_declaration_list struct_declaration
	;

init_declarator_list
	: init_declarator
	| init_declarator_list ',' init_declarator
	;

init_declarator
	: declarator
	| declarator '=' initializer
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list ';'
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list
	| type_specifier
	| type_qualifier specifier_qualifier_list
	| type_qualifier
	;

struct_declarator_list
	: struct_declarator
	| struct_declarator_list ',' struct_declarator
	;

struct_declarator
	: declarator
	| declarator ':' constant_expression
	| ':' constant_expression
	;

enum_specifier
	: ENUM IDENTIFIER '{' enumerator_list '}'
	| ENUM '{' enumerator_list '}'
	| ENUM IDENTIFIER
	;

enumerator_list
	: enumerator
	| enumerator_list ',' enumerator
	;

enumerator
	: IDENTIFIER
	| IDENTIFIER '=' constant_expression
	;

declarator
	: pointer direct_declarator
	| direct_declarator
	;

direct_declarator
	: IDENTIFIER
	| '(' declarator ')'
	| direct_declarator '[' constant_expression ']'
	| direct_declarator '[' ']'
	| direct_declarator '(' parameter_type_list ')'
	| direct_declarator '(' identifier_list ')'
	| direct_declarator '(' ')'
	;

pointer : '*' type_qualifier_list
	| '*'
	| '*' type_qualifier_list pointer
	| '*' pointer
	;

type_qualifier_list
	: type_qualifier
	| type_qualifier_list type_qualifier
	;

parameter_type_list
	: parameter_list
	| parameter_list ',' ELIPSIS
	;

parameter_list
	: parameter_declaration
	| parameter_list ',' parameter_declaration
	;

parameter_declaration
	: declaration_specifiers declarator
	| declaration_specifiers abstract_declarator
	| declaration_specifiers
	;

identifier_list
	: IDENTIFIER
	| identifier_list ',' IDENTIFIER
	;

initializer
	: assignment_expression
	| '{' initializer_list  '}'
	| '{' initializer_list ',' '}'
	;


initializer_list
	: initializer
	| initializer_list ',' initializer
	;

type_name
	: specifier_qualifier_list abstract_declarator
	| specifier_qualifier_list
	;

abstract_declarator
	: pointer
	| pointer direct_abstract_declarator
	| direct_abstract_declarator
	;

direct_abstract_declarator
	: '(' abstract_declarator ')'
	| direct_abstract_declarator '[' constant_expression ']'
	| '[' constant_expression ']'
	| direct_abstract_declarator '[' ']'
	| '[' ']'
	| direct_abstract_declarator '(' parameter_type_list ')'
	| '(' parameter_type_list ')'
	| direct_abstract_declarator '(' ')'
	| '(' ')'
	;

typedef_name
	: IDENTIFIER
	;

statement
	: labeled_statement
	| expression_statement
	| compound_statement
	| selection_statement
	| iteration_statement
	| jump_statement
	;

labeled_statement
	: IDENTIFIER ':' statement
	| CASE constant_expression ':' statement
	| DEFAULT ':' statement
	;

expression_statement
	: expression ';'
	| ';'
	;

compound_statement
	: '{' declaration_list statement_list '}'
	| '{' declaration_list '}'
	| '{' statement_list '}'
	| '{' '}'
	;

statement_list
	: statement
	| statement_list statement
	;

selection_statement
	: IF '(' expression ')' statement
	| IF '(' expression ')' statement ELSE statement
	| SWITCH '(' expression ')' statement
	;

iteration_statement
	: WHILE '(' expression ')' statement
	| DO statement WHILE '(' expression ')' ';'
	| FOR '(' expression ';' expression ';' expression ')' statement
	| FOR '(' expression ';' expression ';' ')' statement
	| FOR '(' expression ';' ';' expression ')' statement
	| FOR '(' expression ';' ';' ')' statement
	| FOR '(' ';' expression ';' expression ')' statement
	| FOR '(' ';' expression ';' ')' statement
	| FOR '(' ';' ';' expression ')' statement
	| FOR '(' ';' ';' ')' statement
	;

jump_statement
	: GOTO IDENTIFIER ';'
	| CONTINUE ';'
	| BREAK ';'
	| RETURN expression ';'
	| RETURN  ';'
	;

constant_expression
	: assignment_expression
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression
	;

assignment_operator
	:  '='  | MULEQ | DIVEQ | MODEQ | ADDEQ | SUBEQ
	| LSHEQ | RSHEQ | ANDEQ | XOREQ | OREQ
	;

conditional_expression
	: logical_OR_expression
	| logical_OR_expression '?' expression ':' conditional_expression
	;

logical_OR_expression
	: logical_AND_expression
	| logical_OR_expression OR logical_AND_expression
	;

logical_AND_expression
	: inclusive_OR_expression
	| logical_AND_expression AND inclusive_OR_expression
	;

inclusive_OR_expression
	: exclusive_OR_expression
	| inclusive_OR_expression '|' exclusive_OR_expression
	;

exclusive_OR_expression
	: AND_expression
	| exclusive_OR_expression '^' AND_expression
	;

AND_expression
	: equality_expression
	| AND_expression '&' equality_expression
	;

equality_expression
	: relational_expression
	| equality_expression EQU relational_expression
	| equality_expression NEQ relational_expression
	;

relational_expression
	: shift_expression
	| relational_expression '<' shift_expression
	| relational_expression '>' shift_expression
	| relational_expression LEQ shift_expression
	| relational_expression GEQ shift_expression
	;

shift_expression
	: additive_expression
	| shift_expression LSH additive_expression
	| shift_expression RSH additive_expression
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression
	| additive_expression '-' multiplicative_expression
	;

multiplicative_expression
	: cast_expression
	| multiplicative_expression '*' cast_expression
	| multiplicative_expression '/' cast_expression
	| multiplicative_expression '%' cast_expression
	;

cast_expression
	: unary_expression
	| '(' type_name ')' cast_expression
	;

unary_expression
	: postfix_expression
	| INC unary_expression
	| DEC unary_expression
	| unary_operator cast_expression
	| SIZEOF unary_expression
	| SIZEOF '(' type_name ')'
	;

unary_operator
	: '&' | '*' | '+' | '-' | '~' | '!'
	;

postfix_expression
	: primary_expression
	| postfix_expression '[' expression ']'
	| postfix_expression '(' argument_expression_list ')'
	| postfix_expression '(' ')'
	| postfix_expression '.' IDENTIFIER
	| postfix_expression ARROW IDENTIFIER
	| postfix_expression INC
	| postfix_expression DEC
	;

primary_expression
	: IDENTIFIER
	| constant
	| STRING
	| '(' expression ')'
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;

constant
	: INTCONST
	| CHARCONST
	| FLOATCONST
	;

