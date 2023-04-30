from flat import *
# from lexer import *

#Parser
precedence = (
    ('nonassoc', 'PRINT'),
    ('left', 'PLUS')
    )

#program ::= module
def p_program(t):
    'program : module'
    print("parsed a program", t[1])
    t[0] = t[1]

    
#module ::= module newline statement
def p_module(t):
    'module : statements'
    print("Module: ", t[1])
    t[0] = Module(body=t[1] if not t[0] else t[0] + t[1], type_ignores=[])
    

#module ::= (empty file)
def p_empty(t):
    'module : '
    t[0] = Module(body=[], type_ignores=[])


#module ::= statement
def p_statements_multiple(t):
    'statements : statements statement'
    t[0] = t[1] + [t[2]]


#module ::= statements statement
def p_statements_single(t):
    'statements : statement'
    t[0] = [t[1]]

    
#statement ::= expression    
def p_statement_expression(t):
    'statement : expression'
    t[0] = t[1]

    
#statement ::= "print" "(" expression ")"
def p_statement_print(t):
    'statement : PRINT LPAR expression RPAR'
    t[0] = Expr(value=Call(func=Name(id="print", ctx=Load()), args=[t[3]], keywords=[]))
    
    
#statement ::= VARNAME "=" expression
def p_statement_assignment(t):
    'statement : VARNAME EQUALS expression'
    t[0] = Assign(targets=[Name(id=t[1], ctx=Store())], value=t[3])
    
    
#expression ::= "eval" "(" "input" "(" ")" ")"
def p_statement_evalinputs(t):
    'expression : EVAL LPAR INPUT LPAR RPAR RPAR'
    t[0] = Call(func=Name(id="eval", ctx=Load()), args=[Call(func=Name(id="input", ctx=Load()), args=[], keywords=[])], keywords=[])
    
    
#expression ::= expression "+" expression
def p_expression_addition(t):
    'expression : expression PLUS expression'
    t[0] = BinOp(left=t[1], op=Add(), right=t[3])
    
    
#expression ::= VARNAME
def p_expression_varname(t):
    'expression : VARNAME'
    t[0] = Name(id=t[1], ctx=Load())
    
    
#expression ::= "-" expression
def p_expression_minus(t):
    'expression : MINUS expression'
    t[0] = UnaryOp(op=USub(), operand=t[2])

    
#expression ::= INT
def p_expression_int(t):
    'expression : INT'
    t[0] = Constant(value=t[1])
    
    
# expression ::= "(" expression ")"
def p_expression_parenth(t):
    'expression : LPAR expression RPAR'
    t[0] = t[2]
    
    
#character not recognized
def p_error(t):
    print("Syntax error at '%s'" % t.value)

  
#---------------------------------------------------------------------------------------------------------------        

#unparsing function used for testing
def unparse(n):
    if isinstance(n, Module):
        prog = ''
        for child in n.body:
            prog = prog + unparse(child)
            prog = prog + '\n'
        return prog
    
    elif isinstance(n, Assign):
        return unparse(n.targets[0]) + ' = ' + unparse(n.value)
    
    elif isinstance(n, Expr):
        return unparse(n.value)
    
    elif isinstance(n, Constant):
        return str(n.value)
    
    elif isinstance(n, Name):
        return n.id
    
    elif isinstance(n, BinOp):
        return unparse(n.left) + unparse(n.op) + unparse(n.right)
    
    elif isinstance(n, UnaryOp):
        return unparse(n.op) + unparse(n.operand)
    
    elif isinstance(n, Call):
        if (len(n.args) != 0):
            return unparse(n.func) + '(' + unparse(n.args[0]) + ')'
        else:
            return unparse(n.func) + '()'
    
    elif isinstance(n, Add):
        return ' + '
    
    elif isinstance(n, USub):
        return '-'
    
    else:
        raise Exception("Error in name_nodes: unrecognized AST node")  