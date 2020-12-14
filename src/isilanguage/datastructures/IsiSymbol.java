package isilanguage.datastructures;

public abstract class IsiSymbol {
	
	protected String name;
	
	public abstract String generatePythonCode();
	public abstract boolean isUsed();
	public abstract void setUsed();
	public abstract int getType();
	public abstract String getValue();
	public IsiSymbol(String name) {
		this.name = name;
		
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	@Override
	public String toString() {
		return "IsiSymbol [name=" + name + "]";
	}
	
	
	

}