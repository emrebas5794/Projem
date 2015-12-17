package com.example.otelotomasyonu;

public class NewsItemyemek {

	
	private String yemekadi;
	private String url;
	private String yemekid;
	private String yemekfiyati;

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getyemekid() {
		return yemekid;
	}

	public void setyemekid(String yemekid) {
		this.yemekid = yemekid;
	}

	public String getyemekadi() {
		return yemekadi;
	}

	public void setyemekadi(String yemekadi) {
		this.yemekadi = yemekadi;
	}
	
	public String getyemekfiyat() {
		return yemekfiyati;
	}

	public void setyemekfiyat(String yemekfiyat) {
		this.yemekfiyati = yemekfiyat;
	}

	@Override
	public String toString() {
		return yemekid ;
	}
}
