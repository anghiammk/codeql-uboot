import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class Network extends Expr
{
    Network()
    {
        exists(MacroInvocation m | 
        m.getMacroName().regexpMatch("ntoh(s|l|ll)") and this = m.getExpr()
        )
    }


}

class Config extends TaintTracking::Configuration
{
    Config()
    {
        this = "NetworkToMemFuncLength"
    }

    override predicate isSource(DataFlow::Node source)
    {
        source.asExpr() instanceof Network
    }

    
    override predicate isSink(DataFlow::Node sink)
    {
        exists(FunctionCall c | c.getTarget().getName() = "memcpy" and sink.asExpr() = c.getArgument(2))
    }   
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink



