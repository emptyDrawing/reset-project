package ga.beauty.reset.dao.entity.stat;

public class Log_File {

	private String nalja;
	private String logCate;
	private String cate;
	private String msg;
	
	public Log_File() {
		// TODO Auto-generated constructor stub
	}

	public Log_File(String nalja, String logCate, String cate, String msg) {
		super();
		this.nalja = nalja;
		this.logCate = logCate;
		this.cate = cate;
		this.msg = msg;
	}

	public String getNalja() {
		return nalja;
	}

	public void setNalja(String nalja) {
		this.nalja = nalja;
	}

	public String getLogCate() {
		return logCate;
	}

	public void setLogCate(String logCate) {
		this.logCate = logCate;
	}

	public String getCate() {
		return cate;
	}

	public void setCate(String cate) {
		this.cate = cate;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	@Override
	public String toString() {
		return "Log_File [nalja=" + nalja + ", logCate=" + logCate + ", cate=" + cate + ", msg=" + msg + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((cate == null) ? 0 : cate.hashCode());
		result = prime * result + ((logCate == null) ? 0 : logCate.hashCode());
		result = prime * result + ((msg == null) ? 0 : msg.hashCode());
		result = prime * result + ((nalja == null) ? 0 : nalja.hashCode());
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
		Log_File other = (Log_File) obj;
		if (cate == null) {
			if (other.cate != null)
				return false;
		} else if (!cate.equals(other.cate))
			return false;
		if (logCate == null) {
			if (other.logCate != null)
				return false;
		} else if (!logCate.equals(other.logCate))
			return false;
		if (msg == null) {
			if (other.msg != null)
				return false;
		} else if (!msg.equals(other.msg))
			return false;
		if (nalja == null) {
			if (other.nalja != null)
				return false;
		} else if (!nalja.equals(other.nalja))
			return false;
		return true;
	}
}
