package ga.beauty.reset.dao.entity;

public class Eve_addr_Vo {
	private int add_no;
	private int eve_no;
	private String email;
	private String name;
	private String address;
	private String phone;
	private int postcode;

	public Eve_addr_Vo() {
	}

	public Eve_addr_Vo(int add_no, int eve_no, String email, String name, String address, String phone, int postcode) {
		super();
		this.add_no = add_no;
		this.eve_no = eve_no;
		this.email = email;
		this.name = name;
		this.address = address;
		this.phone = phone;
		this.postcode = postcode;
	}

	@Override
	public String toString() {
		return "Eve_addr_Vo [add_no=" + add_no + ", eve_no=" + eve_no + ", email=" + email + ", name=" + name
				+ ", address=" + address + ", phone=" + phone + ", postcode=" + postcode + "]";
	}

	public int getAdd_no() {
		return add_no;
	}

	public void setAdd_no(int add_no) {
		this.add_no = add_no;
	}

	public int getEve_no() {
		return eve_no;
	}

	public void setEve_no(int eve_no) {
		this.eve_no = eve_no;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getPostcode() {
		return postcode;
	}

	public void setPostcode(int postcode) {
		this.postcode = postcode;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + add_no;
		result = prime * result + ((address == null) ? 0 : address.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + eve_no;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((phone == null) ? 0 : phone.hashCode());
		result = prime * result + postcode;
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
		Eve_addr_Vo other = (Eve_addr_Vo) obj;
		if (add_no != other.add_no)
			return false;
		if (address == null) {
			if (other.address != null)
				return false;
		} else if (!address.equals(other.address))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (eve_no != other.eve_no)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (phone == null) {
			if (other.phone != null)
				return false;
		} else if (!phone.equals(other.phone))
			return false;
		if (postcode != other.postcode)
			return false;
		return true;
	}
	
}
