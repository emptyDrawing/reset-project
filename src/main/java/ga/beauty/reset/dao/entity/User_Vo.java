package ga.beauty.reset.dao.entity;

public class User_Vo {

	private String email;
	private String password;
	private String user_type;
	private String join_route;
	
	public User_Vo() {
	}

	public User_Vo(String email, String password, String user_type, String join_route) {
		super();
		this.email = email;
		this.password = password;
		this.user_type = user_type;
		this.join_route = join_route;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getJoin_route() {
		return join_route;
	}

	public void setJoin_route(String join_route) {
		this.join_route = join_route;
	}

	@Override
	public String toString() {
		return "User_Vo [email=" + email + ", password=" + password + ", user_type=" + user_type + ", join_route="
				+ join_route + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + ((join_route == null) ? 0 : join_route.hashCode());
		result = prime * result + ((password == null) ? 0 : password.hashCode());
		result = prime * result + ((user_type == null) ? 0 : user_type.hashCode());
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
		User_Vo other = (User_Vo) obj;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (join_route == null) {
			if (other.join_route != null)
				return false;
		} else if (!join_route.equals(other.join_route))
			return false;
		if (password == null) {
			if (other.password != null)
				return false;
		} else if (!password.equals(other.password))
			return false;
		if (user_type == null) {
			if (other.user_type != null)
				return false;
		} else if (!user_type.equals(other.user_type))
			return false;
		return true;
	}
	
	
	
}
