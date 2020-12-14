grammar IsiLang;

@header{
	import isilanguage.datastructures.IsiSymbol;
	import isilanguage.datastructures.IsiVariable;
	import isilanguage.datastructures.IsiSymbolTable;
	import isilanguage.exceptions.IsiSemanticException;
	import isilanguage.ast.IsiProgram;
	import isilanguage.ast.AbstractCommand;
	import isilanguage.ast.CommandLeitura;
	import isilanguage.ast.CommandEscrita;
	import isilanguage.ast.CommandAtribuicao;
	import isilanguage.ast.CommandDecisao;
	import isilanguage.ast.CommandRepeticao;
	import java.util.ArrayList;
	import java.util.Stack;
}

@members{
	private int _tipo;
	private int _checkTipo;
	private String _varName;
	private String _varValue;
	private IsiSymbolTable symbolTable = new IsiSymbolTable();
	private IsiSymbol symbol;
	private IsiProgram program = new IsiProgram();
	private ArrayList<AbstractCommand> curThread;
	private Stack<ArrayList<AbstractCommand>> stack = new Stack<ArrayList<AbstractCommand>>();
	private String _readID;
	private String _writeID;
	private String _exprID;
	private String _exprContent;
	private String _exprDecision;
	private Stack<String> decisionStack = new Stack<String>();
	private Stack<Boolean> senaoStack = new Stack<Boolean>();
	private ArrayList<AbstractCommand> listaTrue;
	private ArrayList<AbstractCommand> listaFalse;
	private ArrayList<AbstractCommand> listaComandos;
	
	public void verificaID(String id){
		if (!symbolTable.exists(id)){
			throw new IsiSemanticException("Symbol "+id+" not declared");
		}
	}
	
	public void exibeComandos(){
		for (AbstractCommand c: program.getComandos()){
			System.out.println(c);
		}
	}
	
	public void generateCode(){
		program.generateTarget();
	}
}

prog	: 'programa' decl bloco  'fimprog;'
           {  program.setVarTable(symbolTable);
           	  program.setComandos(stack.pop());
           	  
           	  for(IsiSymbol symbol: symbolTable.getAll()){
           	  	if (!symbol.isUsed()){
	            	throw new IsiSemanticException("Symbol "+symbol.getName()+" declared but not used.");
           	  	}
           	  }
           	  
           	  
           	 
           } 
		;
		
decl    :  (declaravar)+
        ;
        
        
declaravar :  tipo ID  {
	                  _varName = _input.LT(-1).getText();
	                  _varValue = null;
	                  symbol = new IsiVariable(_varName, _tipo, _varValue);
	                  if (!symbolTable.exists(_varName)){
	                     symbolTable.add(symbol);	
	                  }
	                  else{
	                  	 throw new IsiSemanticException("Symbol "+_varName+" already declared");
	                  }
                    } 
              (  VIR 
              	 ID {
	                  _varName = _input.LT(-1).getText();
	                  _varValue = null;
	                  symbol = new IsiVariable(_varName, _tipo, _varValue);
	                  if (!symbolTable.exists(_varName)){
	                     symbolTable.add(symbol);	
	                  }
	                  else{
	                  	 throw new IsiSemanticException("Symbol "+_varName+" already declared");
	                  }
                    }
              )* 
               SC
           ;
           
tipo       : 'numero' { _tipo = IsiVariable.NUMBER;  }
           | 'texto'  { _tipo = IsiVariable.TEXT;  }
           ;
        
bloco	: { curThread = new ArrayList<AbstractCommand>(); 
	        stack.push(curThread);  
          }
          (cmd)+
		;
		

cmd		:  cmdleitura  
 		|  cmdescrita 
 		|  cmdattrib
 		|  cmdselecao
 		|  cmdrepeticao  
		;
		
cmdleitura	: 'leia' AP
                     ID { 
                     	verificaID(_input.LT(-1).getText());
                     	_readID = _input.LT(-1).getText();
						symbolTable.get(_readID).setUsed();	
					} 
                     FP 
                     SC 
                     
              {
              	IsiVariable var = (IsiVariable)symbolTable.get(_readID);
              	CommandLeitura cmd = new CommandLeitura(_readID, var);
              	stack.peek().add(cmd);
              }   
			;
			
cmdescrita	: 'escreva' 
                 AP 
                 (ID { verificaID(_input.LT(-1).getText());
	                  _writeID = _input.LT(-1).getText();
                     } 
                 |
                 NUMBER {_writeID = _input.LT(-1).getText();} 
                 |TEXT {_writeID = _input.LT(-1).getText();} 
                 )
                 FP 
                 SC
               {
               	  CommandEscrita cmd = new CommandEscrita(_writeID);
               	  stack.peek().add(cmd);
               }
			;
			
cmdattrib	:  ID { verificaID(_input.LT(-1).getText());
                    _exprID = _input.LT(-1).getText();
	                symbolTable.get(_exprID).setUsed();
	                _checkTipo = symbolTable.get(_exprID).getType();
                   } 
               ATTR { 
               		_exprContent = "";
               } 
               expr 
               SC
               {
               	 CommandAtribuicao cmd = new CommandAtribuicao(_exprID, _exprContent);
               	 stack.peek().add(cmd);
               }
			;
			
			
cmdselecao  :  'se' AP
                    ID    { 
                    	_exprDecision = _input.LT(-1).getText();
                    	verificaID(_input.LT(-1).getText());
	                	_checkTipo = symbolTable.get(_exprDecision).getType();
                    }
                    OPREL { _exprDecision += _input.LT(-1).getText(); }
                    
                    (ID {
                    	_exprDecision += _input.LT(-1).getText(); 
                    	decisionStack.push(_exprDecision);
                    	verificaID(_input.LT(-1).getText());
                    	if (_checkTipo != symbolTable.get(_input.LT(-1).getText()).getType()) {
							throw new IsiSemanticException("Invalid type operation");
						}
                    	
                    }| NUMBER{
                    	_exprDecision += _input.LT(-1).getText(); 
                    	decisionStack.push(_exprDecision);
                    	if (_checkTipo != 0) {
							throw new IsiSemanticException("Invalid type operation");
						}
                    	
                    } | TEXT{
                    	_exprDecision += _input.LT(-1).getText(); 
                    	decisionStack.push(_exprDecision);
                    	if (_checkTipo != 1) {
							throw new IsiSemanticException("Invalid type operation");
						}
                    }) 
                    FP 
                    ACH 
                    { 
						senaoStack.push(false);
						curThread = new ArrayList<AbstractCommand>(); 
                      stack.push(curThread);
                    }
                    (cmd)+ 
                    
                    FCH 
                    {
                       listaTrue = stack.pop();	
                    } 
                   ('senao' 
                   	 ACH
                   	 {
                   	 	senaoStack.pop();
                   	 	senaoStack.push(true);
                   	 	curThread = new ArrayList<AbstractCommand>();
                   	 	stack.push(curThread);
                   	 } 
                   	(cmd+) 
                   	{
                   		listaFalse = stack.pop();
                   	}
                   	FCH
                   )?
                   	{
                   		if (senaoStack.pop()){
                   			
	                   		CommandDecisao cmd = new CommandDecisao(decisionStack.pop(), listaTrue, listaFalse);
                   			stack.peek().add(cmd);
	                   		
                   		}else{
                   			CommandDecisao cmd = new CommandDecisao(decisionStack.pop(), listaTrue);
                   			stack.peek().add(cmd);
                   		
                   		}
                   	}
            ;

cmdrepeticao :
				'enquanto'
					AP
                    ID    { 
                    	_exprDecision = _input.LT(-1).getText();
                    	verificaID(_input.LT(-1).getText());
	                	_checkTipo = symbolTable.get(_exprDecision).getType();
                    }
                    OPREL { _exprDecision += _input.LT(-1).getText(); }
                    
                    (ID {
                    	_exprDecision += _input.LT(-1).getText(); 
                    	decisionStack.push(_exprDecision);
                    	verificaID(_input.LT(-1).getText());
                    	if (_checkTipo != symbolTable.get(_input.LT(-1).getText()).getType()) {
							throw new IsiSemanticException("Invalid type operation");
						}
                    	
                    }| NUMBER{
                    	_exprDecision += _input.LT(-1).getText(); 
                    	decisionStack.push(_exprDecision);
                    	if (_checkTipo != 0) {
							throw new IsiSemanticException("Invalid type operation");
						}
                    	
                    } | TEXT{
                    	_exprDecision += _input.LT(-1).getText(); 
                    	decisionStack.push(_exprDecision);
                    	if (_checkTipo != 1) {
							throw new IsiSemanticException("Invalid type operation");
						}
                    }) 
                    FP 
                    ACH 
                    { curThread = new ArrayList<AbstractCommand>(); 
                      stack.push(curThread);
                    }
                    (cmd)+ 
                    
                    FCH 
                    {
                       listaComandos = stack.pop();	
                   		CommandRepeticao cmd = new CommandRepeticao(decisionStack.pop(), listaComandos);
                   		stack.peek().add(cmd);
                   	}
            ;
				
			
expr		:  termo ( 
	             OP  { _exprContent += _input.LT(-1).getText();}
	            termo
	            )*
	        |
	        	TEXT { 
	        		_exprContent += _input.LT(-1).getText();
					if (_checkTipo != 1) {
						throw new IsiSemanticException("Invalid type operation");
					}	        	
	        	}
	        	
			;	
			
termo		: ID { verificaID(_input.LT(-1).getText());
	               _exprContent += _input.LT(-1).getText();
	               if (_checkTipo != symbolTable.get(_exprContent).getType()) {
						throw new IsiSemanticException("Invalid type operation");
					}
	               
                 } 
            | 
              NUMBER
              {
              	_exprContent += _input.LT(-1).getText();
              	if (_checkTipo != 0) {
						throw new IsiSemanticException("Invalid type operation");
					}
              }
			;
			
	
AP	: '('
	;
	
FP	: ')'
	;
	
SC	: ';'
	;
	
OP	: '+' | '-' | '*' | '/'
	;
	
ATTR : '='
	 ;
	 
VIR  : ','
     ;
     
ACH  : '{'
     ;
     
FCH  : '}'
     ;
	 
	 
OPREL : '>' | '<' | '>=' | '<=' | '==' | '!='
      ;
      
ID	: [a-z] ([a-z] | [A-Z] | [0-9])*
	;
	
NUMBER	: [0-9]+ ('.' [0-9]+)?
		;
		
TEXT	: '"' (~["\\] | '\\' .)* '"'
;
		
WS	: (' ' | '\t' | '\n' | '\r') -> skip;


