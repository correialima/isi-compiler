package isilanguage.datastructures;

public class IsiVariable extends IsiSymbol {

	public static final int NUMBER = 0;
	public static final int TEXT = 1;

	private int type;
	private String value;
	private boolean used;

	public IsiVariable(String name, int type, String value) {
		super(name);
		this.type = type;
		this.value = value;
		this.used = false;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Override
	public String toString() {
		return "IsiVariable [name=" + name + ", type=" + type + ", value=" + value + "]";
	}

	public String generatePythonCode() {
		String str;
		if (type == NUMBER) {
			str = "float";
		} else {
			str = "str";
		}
		return super.name + ": " +str;
	}

	@Override
	public boolean isUsed() {
		return used;
	}
	
	public void setUsed() {
		this.used = true;
	}

}