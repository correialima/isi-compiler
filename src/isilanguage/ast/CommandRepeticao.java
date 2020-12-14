package isilanguage.ast;

import java.util.ArrayList;

public class CommandRepeticao extends AbstractCommand{

	private String condition;
	private ArrayList<AbstractCommand> listaComandos;
	
	public CommandRepeticao(String condition, ArrayList<AbstractCommand> lc) {
		this.condition = condition;
		this.listaComandos = lc;
	}
	
	
	@Override
	public String generatePythonCode(int indentLevel) {

		int nextIndentLevel = indentLevel + 1;
		
		StringBuilder str = new StringBuilder();
		str.append("\n"+"\t".repeat(indentLevel)+"while ("+condition+"):\n");
		for (AbstractCommand cmd: listaComandos) {
			str.append(cmd.generatePythonCode(nextIndentLevel)+"\n");
		}
		
		return str.toString();
	}
	@Override
	public String toString() {
		return "CommandRepeticao [condition=" + condition + ", listaComandos=" + listaComandos + "]";
	}

}
