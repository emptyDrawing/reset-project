package ga.beauty.reset.dao.entity;

import java.sql.Timestamp;

public class Members_Vo {

	private String 	email;
	private String 	nick;
	private String 	gender;
	private int 	age;
	private String 	skin;
	private String 	phone;
	private String	cart;
	private int 	exp;
	private Timestamp nalja;
	
	public Members_Vo() {
	}

	public Members_Vo(String email, String nick, String gender, int age, String skin, String phone, String cart,
			int exp, Timestamp nalja) {
		super();
		this.email = email;
		this.nick = nick;
		this.gender = gender;
		this.age = age;
		this.skin = skin;
		this.phone = phone;
		this.cart = cart;
		this.exp = exp;
		this.nalja = nalja;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCart() {
		return cart;
	}

	public void setCart(String cart) {
		this.cart = cart;
	}

	public int getExp() {
		return exp;
	}

	public void setExp(int exp) {
		this.exp = exp;
	}

	public Timestamp getNalja() {
		return nalja;
	}

	public void setNalja(Timestamp nalja) {
		this.nalja = nalja;
	}

	@Override
	public String toString() {
		return "Members_Vo [email=" + email + ", nick=" + nick + ", gender=" + gender + ", age=" + age + ", skin="
				+ skin + ", phone=" + phone + ", cart=" + cart + ", exp=" + exp + ", nalja=" + nalja + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + age;
		result = prime * result + ((cart == null) ? 0 : cart.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + exp;
		result = prime * result + ((gender == null) ? 0 : gender.hashCode());
		result = prime * result + ((nalja == null) ? 0 : nalja.hashCode());
		result = prime * result + ((nick == null) ? 0 : nick.hashCode());
		result = prime * result + ((phone == null) ? 0 : phone.hashCode());
		result = prime * result + ((skin == null) ? 0 : skin.hashCode());
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
		Members_Vo other = (Members_Vo) obj;
		if (age != other.age)
			return false;
		if (cart == null) {
			if (other.cart != null)
				return false;
		} else if (!cart.equals(other.cart))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (exp != other.exp)
			return false;
		if (gender == null) {
			if (other.gender != null)
				return false;
		} else if (!gender.equals(other.gender))
			return false;
		if (nalja == null) {
			if (other.nalja != null)
				return false;
		} else if (!nalja.equals(other.nalja))
			return false;
		if (nick == null) {
			if (other.nick != null)
				return false;
		} else if (!nick.equals(other.nick))
			return false;
		if (phone == null) {
			if (other.phone != null)
				return false;
		} else if (!phone.equals(other.phone))
			return false;
		if (skin == null) {
			if (other.skin != null)
				return false;
		} else if (!skin.equals(other.skin))
			return false;
		return true;
	}
	
	
	
}
