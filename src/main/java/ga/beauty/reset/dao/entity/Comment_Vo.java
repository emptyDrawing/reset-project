package ga.beauty.reset.dao.entity;

import java.sql.Date;

public class Comment_Vo {
	private int co_no;
	private String writer;
	private String email;
	private Date nalja;
	private String content;
	private String co_type; //ENUM('�Ű���','����','�̺�Ʈ')
	private int p_no;
	public Comment_Vo() {
	}

	public Comment_Vo(int co_no, String writer, String email, Date nalja, String content, String co_type, int p_no) {
		super();
		this.co_no = co_no;
		this.writer = writer;
		this.email = email;
		this.nalja = nalja;
		this.content = content;
		this.co_type = co_type;
		this.p_no = p_no;
	}

	public int getCo_no() {
		return co_no;
	}

	public void setCo_no(int co_no) {
		this.co_no = co_no;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCo_type() {
		return co_type;
	}

	public void setCo_type(String co_type) {
		this.co_type = co_type;
	}

	public int getP_no() {
		return p_no;
	}

	public void setP_no(int p_no) {
		this.p_no = p_no;
	}

	@Override
	public String toString() {
		return "Comment_Vo [co_no=" + co_no + ", writer=" + writer + ", email=" + email + ", nalja=" + nalja
				+ ", content=" + content + ", co_type=" + co_type + ", p_no=" + p_no + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + co_no;
		result = prime * result + ((co_type == null) ? 0 : co_type.hashCode());
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + p_no;
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
		Comment_Vo other = (Comment_Vo) obj;
		if (co_no != other.co_no)
			return false;
		if (co_type == null) {
			if (other.co_type != null)
				return false;
		} else if (!co_type.equals(other.co_type))
			return false;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (p_no != other.p_no)
			return false;
		if (writer == null) {
			if (other.writer != null)
				return false;
		} else if (!writer.equals(other.writer))
			return false;
		return true;
	}
	
	
	
	
}
