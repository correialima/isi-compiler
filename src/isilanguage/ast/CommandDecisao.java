package isilanguage.ast;

import java.util.ArrayList;

public class CommandDecisao extends AbstractCommand {
 
	private String condition;
	private ArrayList<AbstractCommand> listaTrue;
	private ArrayList<AbstractCommand> listaFalse;
	
	public CommandDecisao(String condition, ArrayList<AbstractCommand> lt, ArrayList<AbstractCommand> lf) {
		this.condition = condition;
		this.listaTrue = lt;
		this.listaFalse = lf;
	}
	@Override
	public String generatePythonCode(int indentLevel) {
		// TODO Auto-generated method stub
		int nextIndentLevel = indentLevel + 1;
		StringBuilder str = new StringBuilder();
		str.append("\n"+"\t".repeat(indentLevel)+"if ("+condition+"):\n");
		for (AbstractCommand cmd: listaTrue) {
			str.append(cmd.generatePythonCode(nextIndentLevel)+"\n");
		}
		if (listaFalse.size() > 0) {
			str.append("\t".repeat(indentLevel)+"else:\n");
			for (AbstractCommand cmd: listaFalse) {
				str.append(cmd.generatePythonCode(nextIndentLevel)+"\n");
			}
		}
		return str.toString();
	}
	@Override
	public String toString() {
		return "CommandDecisao [condition=" + condition + ", listaTrue=" + listaTrue + ", listaFalse=" + listaFalse
				+ "]";
	}
	
	

}