package isilanguage.ast;

public class CommandEscrita extends AbstractCommand {

	private String id;
	
	public CommandEscrita(String id) {
		this.id = id;
	}
	@Override
	public String generatePythonCode(int indentLevel) {
		// TODO Auto-generated method stub
		return "\t".repeat(indentLevel)+"print("+id+")";
	}
	@Override
	public String toString() {
		return "CommandEscrita [id=" + id + "]";
	}
	

}