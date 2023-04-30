import ply.lex as lex

#Lexer
reserved = {
    'input' : 'INPUT',
    'eval' : 'EVAL',
    'print' : 'PRINT'
}

tokens = ['newline', 'INT', 'LPAR', 'RPAR', 'PLUS', 'MINUS', 'EQUALS', 'VARNAME'] + list(reserved.values())
t_PLUS = r'\+'
t_MINUS = r'-'
t_LPAR = r'\('
t_RPAR = r'\)'
t_EQUALS = r'='

def t_INT(t):
    r'\d+'
    try:
        t.value = int(t.value)
    except ValueError:
        print("integer value too large", t.value)
        t.value = 0
    return t

def t_VARNAME(t):
    r'[a-zA-Z_][a-zA-Z_0-9]*'
    t.type = reserved.get(t.value, 'VARNAME')
    return t

t_ignore = ' \t'

def t_newline(t):
    r'\n+'
    t.lexer.lineno += t.value.count("\n")
    
def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)

lexer = lex.lex()