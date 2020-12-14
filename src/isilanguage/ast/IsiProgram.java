package isilanguage.ast;

import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Iterator;

import isilanguage.datastructures.IsiSymbol;
import isilanguage.datastructures.IsiSymbolTable;

public class IsiProgram {
	private IsiSymbolTable varTable;
	private ArrayList<AbstractCommand> comandos;
	private String programName;

	public void generateTarget() {
		StringBuilder str = new StringBuilder();
		str.append("def main():\n\n");

		
		//declaração de variáveis
		str.append("\t");
		str.append("### Declaração de variáveis\n");
		for (IsiSymbol symbol: varTable.getAll()) {
			str.append("\t");
			str.append("//"+symbol.generatePythonCode()+"\n");
		}
		str.append("\n");
		
		
		for (AbstractCommand command: comandos) {
			str.append(command.generatePythonCode(1)+"\n");
		}
		str.append("\n");

		//str.append("if __name__ == '__main__':\n");
		//str.append("\tmain()");
		try {
			FileWriter fr = new FileWriter(new File("output.py"));
			fr.write(str.toString());
			fr.close();
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}

	}

	public IsiSymbolTable getVarTable() {
		return varTable;
	}

	public void setVarTable(IsiSymbolTable varTable) {
		this.varTable = varTable;
	}

	public ArrayList<AbstractCommand> getComandos() {
		return comandos;
	}

	public void setComandos(ArrayList<AbstractCommand> comandos) {
		this.comandos = comandos;
	}

	public String getProgramName() {
		return programName;
	}

	public void setProgramName(String programName) {
		this.programName = programName;
	}
	
}
