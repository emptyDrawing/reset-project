package ga.beauty.reset.dao.entity;

import java.sql.Date;

public class Qna_Vo {
	//���Ǽ���
	private int qa_no;		//�۹�ȣ
	private Date nalja;		//��¥	
	private String con;		//����
	private int qa_type;	//��������
	private String email;	//�亯 ���� �̸���
	private String answer;	//�亯
	
	
	

	public Qna_Vo() {
	}

	
	public Qna_Vo(int qa_no, Date nalja, String con, int qa_type, String email, String answer) {
		super();
		this.qa_no = qa_no;
		this.nalja = nalja;
		this.con = con;
		this.qa_type = qa_type;
		this.email = email;
		this.answer = answer;
	}

	public int getQa_no() {
		return qa_no;
	}

	public void setQa_no(int qa_no) {
		this.qa_no = qa_no;
	}

	public Date getNalja() {
		return nalja;
	}

	public void setNalja(Date nalja) {
		this.nalja = nalja;
	}

	public String getCon() {
		return con;
	}

	public void setCon(String con) {
		this.con = con;
	}

	public int getQa_type() {
		return qa_type;
	}

	public void setQa_type(int qa_type) {
		this.qa_type = qa_type;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	
	
	@Override
	public String toString() {
		return "GuestVo [qa_no=" + qa_no + ", nalja=" + nalja + ", con=" + con + ", qa_type=" + qa_type + ", email="
				+ email + ", answer=" + answer + "]";
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((answer == null) ? 0 : answer.hashCode());
		result = prime * result + ((con == null) ? 0 : con.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + qa_no;
		result = prime * result + qa_type;
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
		Qna_Vo other = (Qna_Vo) obj;
		if (answer == null) {
			if (other.answer != null)
				return false;
		} else if (!answer.equals(other.answer))
			return false;
		if (con == null) {
			if (other.con != null)
				return false;
		} else if (!con.equals(other.con))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (qa_no != other.qa_no)
			return false;
		if (qa_type != other.qa_type)
			return false;
		return true;
	}

	
	
	

	
	
	
}
