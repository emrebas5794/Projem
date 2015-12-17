package com.example.otelservisyemekhane;

public class NewsItem {

	
	private String odano;
	private String yemekadi;
	private String yemekadet;
	private String yemekid;
	
	
	public String getyemekid() {
		return yemekid;
	}

	public void setyemekid(String yemekid) {
		this.yemekid = yemekid;
	}
	
	public String getodano() {
		return odano;
	}

	public void setodano(String odano) {
		this.odano = odano;
	}

	public String getyemekadi() {
		return yemekadi;
	}

	public void setyemekadi(String yemekadi) {
		this.yemekadi = yemekadi;
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