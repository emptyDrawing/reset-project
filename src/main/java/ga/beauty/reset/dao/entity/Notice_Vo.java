package ga.beauty.reset.dao.entity;

import java.sql.Date;

public class Notice_Vo {
	
	//��������
	private int no_no; 		//�������� �۹�ȣ
	private String title;	//�������� �̸�
	private String content;	//����
	private Date nalja; 	//��¥
	
	public Notice_Vo() {
	}

	public Notice_Vo(int no_no, String title, String content, Date nalja) {
		super();
		this.no_no = no_no;
		this.title = title;
		this.content = content;
		this.nalja = nalja;
	}

	public int getNo_no() {
		return no_no;
	}

	public void setNo_no(int no_no) {
		this.no_no = no_no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getNalja() {
		return nalja;
	}

	public void setNalja(Date nalja) {
		this.nalja = nalja;
	}

	@Override
	public String toString() {
		return "NoticeVo [no_no=" + no_no + ", title=" + title + ", content=" + content + ", nalja=" + nalja + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + no_no;
		result = prime * result + ((title == null) ? 0 : title.hashCode());
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
		Notice_Vo other = (Notice_Vo) obj;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (no_no != other.no_no)
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		return true;
	}
	
	
}
