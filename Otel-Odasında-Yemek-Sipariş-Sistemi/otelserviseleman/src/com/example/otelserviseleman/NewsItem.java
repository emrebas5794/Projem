package com.example.otelserviseleman;

public class NewsItem {

	
	private String odano;
	
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

	
	
	

	@Override
	public String toString() {
		return yemekid ;
	}
}