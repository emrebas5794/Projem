package com.example.otelotomasyonu;

public class NewsItem {

	
	private String yemekadi;
	private String url;
	private String yemekid;
	
	
	
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
	
	
	

	@Override
	public String toString() {
		return yemekid ;
	}
}