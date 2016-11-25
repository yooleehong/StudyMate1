package studyMate.util;

public class Page {
	int number;
	String label;
	String active;
	public Page(int number, String label, boolean active) {
		this.number = number;
		this.label = label;
		this.active = active ? "active" : "x";
	}

	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}

}
