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
	public String generatePythonCode() {
		// TODO Auto-generated method stub
		return id +" = input()";
	}
	@Override
	public String toString() {
		return "CommandLeitura [id=" + id + "]";
	}

}