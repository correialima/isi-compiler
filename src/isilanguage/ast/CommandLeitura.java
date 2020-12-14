package isilanguage.ast;

import isilanguage.datastructures.IsiVariable;

public class CommandLeitura extends AbstractCommand {

	private String id;
	private IsiVariable var;
	
	public CommandLeitura (String id, IsiVariable var) {
		this.id = id;
		this.var = var;
	}
	@Override
	public String generatePythonCode(int indentLevel) {
		// TODO Auto-generated method stub
		return "\t".repeat(indentLevel)+ id + " = " + (var.getType()==IsiVariable.NUMBER? "float(input())": "input()");
		
	}
	@Override
	public String toString() {
		return "\n\tCommandLeitura [id=" + id + "]";
	}

}