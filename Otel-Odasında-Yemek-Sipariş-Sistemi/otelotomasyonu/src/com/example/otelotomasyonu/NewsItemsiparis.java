package com.example.otelotomasyonu;

public class NewsItemsiparis {

	
	private String yemekadi;
	private String yemekid;
	private String yemekfiyat;

	private String yemekadet;

	private String siparisarti;
	private String sipariseksi;
	

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
	public String getsiparisarti() {
		return siparisarti;
	}

	public void setsiparisarti(String siparisarti) {
		this.siparisarti = sipariseksi;
	}
	public String getsipariseksi() {
		return sipariseksi;
	}

	public void setsipariseksi(String sipariseksi) {
		this.sipariseksi = sipariseksi;
	}
	
	
	@Override
	public String toString() {
		return yemekid ;
	}
}
