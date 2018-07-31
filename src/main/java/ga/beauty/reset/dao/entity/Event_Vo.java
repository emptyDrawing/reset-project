package ga.beauty.reset.dao.entity;

import java.sql.Date;

public class Event_Vo {
	private int eve_no;
	private String img;
	private String title;
	private String con;
	private String com_email;
	private Date nalja;
	private int pop;
	private int view;
	private int open;
	
	public Event_Vo() {
	}

	public int getEve_no() {
		return eve_no;
	}

	public void setEve_no(int eve_no) {
		this.eve_no = eve_no;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCon() {
		return con;
	}

	public void setCon(String con) {
		this.con = con;
	}

	public String getCom_email() {
		return com_email;
	}

	public void setCom_email(String com_email) {
		this.com_email = com_email;
	}

	public Date getNalja() {
		return nalja;
	}

	public void setNalja(Date nalja) {
		this.nalja = nalja;
	}

	public int getPop() {
		return pop;
	}

	public void setPop(int pop) {
		this.pop = pop;
	}

	public int getView() {
		return view;
	}

	public void setView(int view) {
		this.view = view;
	}

	public int getOpen() {
		return open;
	}

	public void setOpen(int open) {
		this.open = open;
	}

	@Override
	public String toString() {
		return "Event_Vo [eve_no=" + eve_no + ", img=" + img + ", title=" + title + ", con=" + con + ", com_email="
				+ com_email + ", nalja=" + nalja + ", pop=" + pop + ", view=" + view + ", open=" + open + "]";
	}

	public Event_Vo(int eve_no, String img, String title, String con, String com_email, Date nalja, int pop, int view,
			int open) {
		super();
		this.eve_no = eve_no;
		this.img = img;
		this.title = title;
		this.con = con;
		this.com_email = com_email;
		this.nalja = nalja;
		this.pop = pop;
		this.view = view;
		this.open = open;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((com_email == null) ? 0 : com_email.hashCode());
		result = prime * result + ((con == null) ? 0 : con.hashCode());
		result = prime * result + eve_no;
		result = prime * result + ((img == null) ? 0 : img.hashCode());
		result = prime * result + open;
		result = prime * result + pop;
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		result = prime * result + view;
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
		Event_Vo other = (Event_Vo) obj;
		if (com_email == null) {
			if (other.com_email != null)
				return false;
		} else if (!com_email.equals(other.com_email))
			return false;
		if (con == null) {
			if (other.con != null)
				return false;
		} else if (!con.equals(other.con))
			return false;
		if (eve_no != other.eve_no)
			return false;
		if (img == null) {
			if (other.img != null)
				return false;
		} else if (!img.equals(other.img))
			return false;
		if (open != other.open)
			return false;
		if (pop != other.pop)
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		if (view != other.view)
			return false;
		return true;
	}

}
