package ga.beauty.reset.dao.entity.stat;

public class Log_Chart {

	private String label;
	private String valueX;
	private int valueY ;
	
	public Log_Chart() {
		// TODO Auto-generated constructor stub
	}
	
	public Log_Chart(String label, String valueX, int valueY) {
		super();
		this.label = label;
		this.valueX = valueX;
		this.valueY = valueY;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getValueX() {
		return valueX;
	}



	public void setValueX(String valueX) {
		this.valueX = valueX;
	}



	public int getValueY() {
		return valueY;
	}



	public void setValueY(int valueY) {
		this.valueY = valueY;
	}

	@Override
	public String toString() {
		return "Log_Chart [x:"+valueX+",y:"+valueY+"]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((label == null) ? 0 : label.hashCode());
		result = prime * result + ((valueX == null) ? 0 : valueX.hashCode());
		result = prime * result + valueY;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Log_Chart other = (Log_Chart) obj;
		if (label == null) {
			if (other.label != null)
				return false;
		} else if (!label.equals(other.label))
			return false;
		if (valueX == null) {
			if (other.valueX != null)
				return false;
		} else if (!valueX.equals(other.valueX))
			return false;
		if (valueY != other.valueY)
			return false;
		return true;
	}

	
	
}
