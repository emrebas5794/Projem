package com.example.otelotomasyonu;

public class NewsItem5 {

	
	private String yemekadi;
	private String yemekid;
	private String yemekfiyat;
	private String yemekadet;

	

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
	
	public String getyemekfiyatt() {
		return yemekfiyat;
	}

	public void setyemekfiyatt(String yemekfiyat) {
		this.yemekfiyat = yemekfiyat;
	}

	public String getyemekadet() {
		return yemekadet;
	}

	public void setyemekadet(String yemekadet) {
		this.yemekadet = yemekadet;
	}

	
	
	@Override
	public String toString() {
		return yemekid ;
	}
}
