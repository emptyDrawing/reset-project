package ga.beauty.reset.dao.entity;

import java.sql.Date;

public class Likes_Vo {
	private int like_no;
	private String email;
	private Date nalja;
	private String type;
	private int p_no;
	
	
	public Likes_Vo() {
	}
	
	public Likes_Vo(int like_no, String email, Date nalja, String type, int p_no) {
		super();
		this.like_no = like_no;
		this.email = email;
		this.nalja = nalja;
		this.type = type;
		this.p_no = p_no;
	}
	@Override
	public String toString() {
		return "Likes_Vo [like_no=" + like_no + ", email=" + email + ", nalja=" + nalja + ", type=" + type + ", p_no="
				+ p_no + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + like_no;
		result = prime * result + p_no;
		result = prime * result + ((type == null) ? 0 : type.hashCode());
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
		Likes_Vo other = (Likes_Vo) obj;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (like_no != other.like_no)
			return false;
		if (p_no != other.p_no)
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}
	public int getLike_no() {
		return like_no;
	}
	public void setLike_no(int like_no) {
		this.like_no = like_no;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getNalja() {
		return nalja;
	}
	public void setNalja(Date nalja) {
		this.nalja = nalja;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getP_no() {
		return p_no;
	}
	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	
	
}
