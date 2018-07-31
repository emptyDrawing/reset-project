package ga.beauty.reset.dao.entity;

public class Ranks_Vo {
	private int item;
	private int one;
	private int two;
	private int three;
	private int four;
	private int five;
	
	public Ranks_Vo() {
	}

	public Ranks_Vo(int item, int one, int two, int three, int four, int five) {
		super();
		this.item = item;
		this.one = one;
		this.two = two;
		this.three = three;
		this.four = four;
		this.five = five;
	}

	@Override
	public String toString() {
		return "Rank_Vo [item=" + item + ", one=" + one + ", two=" + two + ", three=" + three + ", four=" + four
				+ ", five=" + five + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + five;
		result = prime * result + four;
		result = prime * result + item;
		result = prime * result + one;
		result = prime * result + three;
		result = prime * result + two;
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
		Ranks_Vo other = (Ranks_Vo) obj;
		if (five != other.five)
			return false;
		if (four != other.four)
			return false;
		if (item != other.item)
			return false;
		if (one != other.one)
			return false;
		if (three != other.three)
			return false;
		if (two != other.two)
			return false;
		return true;
	}

	public int getItem() {
		return item;
	}

	public void setItem(int item) {
		this.item = item;
	}

	public int getOne() {
		return one;
	}

	public void setOne(int one) {
		this.one = one;
	}

	public int getTwo() {
		return two;
	}

	public void setTwo(int two) {
		this.two = two;
	}

	public int getThree() {
		return three;
	}

	public void setThree(int three) {
		this.three = three;
	}

	public int getFour() {
		return four;
	}

	public void setFour(int four) {
		this.four = four;
	}

	public int getFive() {
		return five;
	}

	public void setFive(int five) {
		this.five = five;
	}
	
	
}
