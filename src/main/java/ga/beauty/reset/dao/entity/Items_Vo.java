package ga.beauty.reset.dao.entity;

public class Items_Vo {
	private int item;
	private String name;
	private String img;
	private String brand;
	private String vol;
	private int price;
	private double tot;
	private int oil;
	private int dry;
	private int sen;
	private int comp;
	private int cate;
	private String tags;
	private int open;
	
	public Items_Vo() {
	}

	public Items_Vo(int item, String name, String img, String brand, String vol, int price, double tot, int oil,
			int dry, int sen, int comp, int cate, String tags, int open) {
		super();
		this.item = item;
		this.name = name;
		this.img = img;
		this.brand = brand;
		this.vol = vol;
		this.price = price;
		this.tot = tot;
		this.oil = oil;
		this.dry = dry;
		this.sen = sen;
		this.comp = comp;
		this.cate = cate;
		this.tags = tags;
		this.open = open;
	}

	@Override
	public String toString() {
		return "Items_Vo [item=" + item + ", name=" + name + ", img=" + img + ", brand=" + brand + ", vol=" + vol
				+ ", price=" + price + ", tot=" + tot + ", oil=" + oil + ", dry=" + dry + ", sen=" + sen + ", comp="
				+ comp + ", cate=" + cate + ", tags=" + tags + ", open=" + open + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((brand == null) ? 0 : brand.hashCode());
		result = prime * result + cate;
		result = prime * result + comp;
		result = prime * result + dry;
		result = prime * result + ((img == null) ? 0 : img.hashCode());
		result = prime * result + item;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + oil;
		result = prime * result + open;
		result = prime * result + price;
		result = prime * result + sen;
		result = prime * result + ((tags == null) ? 0 : tags.hashCode());
		long temp;
		temp = Double.doubleToLongBits(tot);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((vol == null) ? 0 : vol.hashCode());
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
		Items_Vo other = (Items_Vo) obj;
		if (brand == null) {
			if (other.brand != null)
				return false;
		} else if (!brand.equals(other.brand))
			return false;
		if (cate != other.cate)
			return false;
		if (comp != other.comp)
			return false;
		if (dry != other.dry)
			return false;
		if (img == null) {
			if (other.img != null)
				return false;
		} else if (!img.equals(other.img))
			return false;
		if (item != other.item)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (oil != other.oil)
			return false;
		if (open != other.open)
			return false;
		if (price != other.price)
			return false;
		if (sen != other.sen)
			return false;
		if (tags == null) {
			if (other.tags != null)
				return false;
		} else if (!tags.equals(other.tags))
			return false;
		if (Double.doubleToLongBits(tot) != Double.doubleToLongBits(other.tot))
			return false;
		if (vol == null) {
			if (other.vol != null)
				return false;
		} else if (!vol.equals(other.vol))
			return false;
		return true;
	}

	public int getItem() {
		return item;
	}

	public void setItem(int item) {
		this.item = item;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getVol() {
		return vol;
	}

	public void setVol(String vol) {
		this.vol = vol;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public double getTot() {
		return tot;
	}

	public void setTot(double tot) {
		this.tot = tot;
	}

	public int getOil() {
		return oil;
	}

	public void setOil(int oil) {
		this.oil = oil;
	}

	public int getDry() {
		return dry;
	}

	public void setDry(int dry) {
		this.dry = dry;
	}

	public int getSen() {
		return sen;
	}

	public void setSen(int sen) {
		this.sen = sen;
	}

	public int getComp() {
		return comp;
	}

	public void setComp(int comp) {
		this.comp = comp;
	}

	public int getCate() {
		return cate;
	}

	public void setCate(int cate) {
		this.cate = cate;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public int getOpen() {
		return open;
	}

	public void setOpen(int open) {
		this.open = open;
	}

	
}
