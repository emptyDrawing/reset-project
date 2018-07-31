package ga.beauty.reset.dao.entity;

import java.sql.Date;

public class Reviews_Vo {
	private int rev_no;
	private int item;
	private String img;
	private String writer;
	private int age;
	private String skin;
	private String gender;
	private String good;
	private String bad;
	private String tip;
	private int pop;
	private int star;
	private Date nalja;
	private int open;
	
	public Reviews_Vo() {
	}

	public Reviews_Vo(int rev_no, int item, String img, String writer, int age, String skin, String gender, String good,
			String bad, String tip, int pop, int star, Date nalja, int open) {
		super();
		this.rev_no = rev_no;
		this.item = item;
		this.img = img;
		this.writer = writer;
		this.age = age;
		this.skin = skin;
		this.gender = gender;
		this.good = good;
		this.bad = bad;
		this.tip = tip;
		this.pop = pop;
		this.star = star;
		this.nalja = nalja;
		this.open = open;
	}

	@Override
	public String toString() {
		return "Reviews_Vo [rev_no=" + rev_no + ", item=" + item + ", img=" + img + ", writer=" + writer + ", age="
				+ age + ", skin=" + skin + ", gender=" + gender + ", good=" + good + ", bad=" + bad + ", tip=" + tip
				+ ", pop=" + pop + ", star=" + star + ", nalja=" + nalja + ", open=" + open + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + age;
		result = prime * result + ((bad == null) ? 0 : bad.hashCode());
		result = prime * result + ((gender == null) ? 0 : gender.hashCode());
		result = prime * result + ((good == null) ? 0 : good.hashCode());
		result = prime * result + ((img == null) ? 0 : img.hashCode());
		result = prime * result + item;
		result = prime * result + open;
		result = prime * result + pop;
		result = prime * result + rev_no;
		result = prime * result + ((skin == null) ? 0 : skin.hashCode());
		result = prime * result + star;
		result = prime * result + ((tip == null) ? 0 : tip.hashCode());
		result = prime * result + ((writer == null) ? 0 : writer.hashCode());
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
		Reviews_Vo other = (Reviews_Vo) obj;
		if (age != other.age)
			return false;
		if (bad == null) {
			if (other.bad != null)
				return false;
		} else if (!bad.equals(other.bad))
			return false;
		if (gender == null) {
			if (other.gender != null)
				return false;
		} else if (!gender.equals(other.gender))
			return false;
		if (good == null) {
			if (other.good != null)
				return false;
		} else if (!good.equals(other.good))
			return false;
		if (img == null) {
			if (other.img != null)
				return false;
		} else if (!img.equals(other.img))
			return false;
		if (item != other.item)
			return false;
		if (open != other.open)
			return false;
		if (pop != other.pop)
			return false;
		if (rev_no != other.rev_no)
			return false;
		if (skin == null) {
			if (other.skin != null)
				return false;
		} else if (!skin.equals(other.skin))
			return false;
		if (star != other.star)
			return false;
		if (tip == null) {
			if (other.tip != null)
				return false;
		} else if (!tip.equals(other.tip))
			return false;
		if (writer == null) {
			if (other.writer != null)
				return false;
		} else if (!writer.equals(other.writer))
			return false;
		return true;
	}

	public int getRev_no() {
		return rev_no;
	}

	public void setRev_no(int rev_no) {
		this.rev_no = rev_no;
	}

	public int getItem() {
		return item;
	}

	public void setItem(int item) {
		this.item = item;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getSkin() {
		return skin;
	}

	public void setSkin(String skin) {
		this.skin = skin;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getGood() {
		return good;
	}

	public void setGood(String good) {
		this.good = good;
	}

	public String getBad() {
		return bad;
	}

	public void setBad(String bad) {
		this.bad = bad;
	}

	public String getTip() {
		return tip;
	}

	public void setTip(String tip) {
		this.tip = tip;
	}

	public int getPop() {
		return pop;
	}

	public void setPop(int pop) {
		this.pop = pop;
	}

	public int getStar() {
		return star;
	}

	public void setStar(int star) {
		this.star = star;
	}

	public Date getNalja() {
		return nalja;
	}

	public void setNalja(Date nalja) {
		this.nalja = nalja;
	}

	public int getOpen() {
		return open;
	}

	public void setOpen(int open) {
		this.open = open;
	}

	
}
