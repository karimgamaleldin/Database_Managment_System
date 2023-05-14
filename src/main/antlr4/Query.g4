grammar Query;

@parser::header {
package sqlAntlrParser;
}

@lexer::header {
package sqlAntlrParser;
}
/* Parser Rules */
sql_query :  update_table | insert_into | delete_from | select_from | create_index;

//create_table : CREATE TABLE IDENTIFIER LPAREN column_def (COMMA column_def)* RPAREN SEMICOLON;

//column_def : IDENTIFIER datatype (PRIMARY KEY)?;

//datatype : 'INT' | 'DECIMAL' | 'VARCHAR';

update_table : UPDATE tableName SET updateColumnToSet (otherUpdateColumnToSet)* WHERE updateDeleteCondition ;

insert_into : INSERT INTO IDENTIFIER LPAREN column_name (COMMA column_name)* RPAREN VALUES LPAREN value (COMMA value)* RPAREN;

column_name : IDENTIFIER;

value : INTEGER | DECIMAL | STRING;

delete_from : DELETE FROM tableName (WHERE updateDeleteCondition (otherDeleteCondition)*)?;

select_from : SELECT '*' FROM tableName (WHERE condition (otherSelectCondition)*)?;

condition : columnName operator value;

create_index : CREATE INDEX ON tableName '('indexColumnName COMMA indexColumnName COMMA indexColumnName')';

tableName : IDENTIFIER;

columnName: IDENTIFIER;

indexColumnName: IDENTIFIER;

operator: GREATERTHAN | GREATERTHANOREQUAL | LESSTHAN | LESSTHANOREQUAL | NOTEQUAL | EQUAL;

otherSelectCondition: columnOperators columnName operator value;

columnOperators: AND | XOR | OR ;

updateDeleteColumnName: IDENTIFIER;

updateDeleteValue: INTEGER | DECIMAL | STRING;

updateDeleteCondition : updateDeleteColumnName '=' updateDeleteValue;

otherDeleteCondition: ',' updateDeleteColumnName '=' updateDeleteValue;

updateColumnName: IDENTIFIER;

updateValue: INTEGER | DECIMAL | STRING;

updateColumnToSet : updateColumnName '=' updateValue;

otherUpdateColumnToSet : ',' updateColumnName '=' updateValue;




/* Lexer Rules */
fragment LETTER : [a-zA-Z];
fragment DIGIT : [0-9];
TABLE : 'TABLE';
CREATE : 'CREATE';
UPDATE : 'UPDATE';
INSERT : 'INSERT';
DELETE : 'DELETE';
SET : 'SET';
SELECT : 'SELECT';
FROM : 'FROM';
WHERE : 'WHERE';
AND : 'AND';
OR : 'OR';
XOR: 'XOR';
INDEX : 'INDEX';
ON : 'ON';
INTO : 'INTO';
VALUES : 'VALUES';
IDENTIFIER : LETTER (LETTER | DIGIT | '_')*;
INTEGER: DIGIT+;
DECIMAL : DIGIT+ '.' DIGIT*;
STRING : '\'' ~('\''|'\r'|'\n')* '\'';
GREATERTHAN: '>';
GREATERTHANOREQUAL: '>=';
LESSTHAN: '<';
LESSTHANOREQUAL: '<=';
NOTEQUAL: '!=';
EQUAL: '=';
LPAREN : '(';
RPAREN : ')';
COMMA : ',';
WS : [ \t\n\r] + -> skip;
/* End Of Lexer Rules */