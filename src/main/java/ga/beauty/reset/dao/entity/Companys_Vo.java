package ga.beauty.reset.dao.entity;

public class Companys_Vo {

	private String 	email;
	private String 	company;
	private int 	bisnum;
	private String 	manager;
	private int 	postcode;
	private String	address;
	private String	phone;
	
	public Companys_Vo() {
	}

	public Companys_Vo(String email, String company, int bisnum, String manager, int postcode, String address,
			String phone) {
		super();
		this.email = email;
		this.company = company;
		this.bisnum = bisnum;
		this.manager = manager;
		this.postcode = postcode;
		this.address = address;
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public int getBisnum() {
		return bisnum;
	}

	public void setBisnum(int bisnum) {
		this.bisnum = bisnum;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public int getPostcode() {
		return postcode;
	}

	public void setPostcode(int postcode) {
		this.postcode = postcode;
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

	@Override
	public String toString() {
		return "Companys_Vo [email=" + email + ", company=" + company + ", bisnum=" + bisnum + ", manager=" + manager
				+ ", postcode=" + postcode + ", address=" + address + ", phone=" + phone + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((address == null) ? 0 : address.hashCode());
		result = prime * result + bisnum;
		result = prime * result + ((company == null) ? 0 : company.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + ((manager == null) ? 0 : manager.hashCode());
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
		Companys_Vo other = (Companys_Vo) obj;
		if (address == null) {
			if (other.address != null)
				return false;
		} else if (!address.equals(other.address))
			return false;
		if (bisnum != other.bisnum)
			return false;
		if (company == null) {
			if (other.company != null)
				return false;
		} else if (!company.equals(other.company))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (manager == null) {
			if (other.manager != null)
				return false;
		} else if (!manager.equals(other.manager))
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
