package ga.beauty.reset.dao.entity.stat;

public class Log_EM_Vo {

	private int no;
	private int like;
	private int view;
	private int num;

	public Log_EM_Vo() {
	}

	public Log_EM_Vo(int no, int like, int view, int num) {
		super();
		this.no = no;
		this.like = like;
		this.view = view;
		this.num = num;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	public int getView() {
		return view;
	}

	public void setView(int view) {
		this.view = view;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	@Override
	public String toString() {
		return "{\"no\":"+no+",\"like\":"+like+",\"view\":"+view+",\"num\":"+num+"}";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + no;
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
		Log_EM_Vo other = (Log_EM_Vo) obj;
		if (no != other.no)
			return false;
		return true;
	}
	
}
