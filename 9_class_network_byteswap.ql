import cpp

class Network extends Expr
{
    Network()
    {
        exists(MacroInvocation m | 
        m.getMacroName().regexpMatch("ntoh(s|l|ll)") and this = m.getExpr()
        )
    }

}

from Network n
select n