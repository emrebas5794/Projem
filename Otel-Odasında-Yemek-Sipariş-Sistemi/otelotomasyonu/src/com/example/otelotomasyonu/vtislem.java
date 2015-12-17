package com.example.otelotomasyonu;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.PropertyInfo;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDatabase.CursorFactory;
import android.database.sqlite.SQLiteOpenHelper;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Toast;
 

public class vtislem extends SQLiteOpenHelper 
{
 
	public static final  String SOAP_ACTION = "http://tempuri.org/sipariskayit";
	public  static final  String OPERATION_NAME = "sipariskayit"; 
	public static final  String WSDL_TARGET_NAMESPACE = "http://tempuri.org/";
	public static final  String SOAP_ADDRESS = "http://kralled.com/Service1.asmx";
	
	
	
	
	public String Call1(String odano,String yemekadi,String yemekadet,String yemekfiyat)
	{
		SoapObject request = new SoapObject(WSDL_TARGET_NAMESPACE,OPERATION_NAME);
		PropertyInfo pit=new PropertyInfo();
	 	 pit.setName("odano");
	 	 pit.setValue(odano);
		pit.setType(String.class);
		request.addProperty(pit);
		pit=new PropertyInfo();
		 pit.setName("yemekadi");
	 	 pit.setValue(yemekadi);
		pit.setType(String.class);
		request.addProperty(pit);
		pit=new PropertyInfo();
		 pit.setName("yemekadet");
	 	 pit.setValue(yemekadet);
		pit.setType(String.class);
		request.addProperty(pit);
		pit=new PropertyInfo();
		 pit.setName("yemekfiyat");
	 	 pit.setValue(yemekfiyat);
		pit.setType(String.class);
		request.addProperty(pit);
		
		SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(
		SoapEnvelope.VER11);
		envelope.dotNet = true;
	
		envelope.setOutputSoapObject(request);
	
		HttpTransportSE httpTransport = new HttpTransportSE(SOAP_ADDRESS);
		Object response=null;
		try
		{
			httpTransport.call(SOAP_ACTION, envelope);
			response = envelope.getResponse();
			
		}
		catch (Exception exception)
		{
			response=exception.toString();
		}
		return response.toString();
	}
	
	
    public vtislem(Context context, String name, CursorFactory factory,
            int version) 
    {
        super(context, name, factory, version);
        
        // TODO Auto-generated constructor stub
    }
 
    @Override
    public void onCreate(SQLiteDatabase db) 
    {
        // TODO Auto-generated method stub
        db.execSQL("CREATE  TABLE  IF NOT EXISTS siparis (id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , siparisisim VARCHAR, siparisadet VARCHAR, siparisfiyat VARCHAR)");
    }
 
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) 
    {
        // TODO Auto-generated method stub
        db.execSQL("DROP TABLE IF EXIST siparis;");
    }
 
    public void kayitekle( String siparisisim,String siparisadet, String siparisfiyat)
    {
        SQLiteDatabase db=this.getWritableDatabase();
        db.execSQL("INSERT INTO siparis(siparisisim,siparisadet,siparisfiyat) VALUES('" + siparisisim + "','" + siparisadet + "','" + siparisfiyat + "')");
 
 
    }
    public void kayitsil(String id)
    {
        SQLiteDatabase db=this.getReadableDatabase();
        db.delete("siparis", "id="+id, null);
 
 
    }
    public void siparislerisil()
    {
        SQLiteDatabase db=this.getReadableDatabase();
        db.delete("siparis", "", null);
 
 
    }
 
 
  
    double toplam=0;
    String[] sutunlar = new String[] {"id","siparisisim", "siparisadet", "siparisfiyat"};
    SQLiteDatabase db = this.getReadableDatabase();
    Cursor c = db.query("siparis", sutunlar, null, null,null, null, null);
    String diziid[]=new String[c.getCount()];
    public ArrayAdapter<String> tumKayitlar(Context context) 
    {
       
 
        int idSiraNo = c.getColumnIndex("id");
        int isimSiraNo = c.getColumnIndex("siparisisim");
        int adetSiraNo = c.getColumnIndex("siparisadet");
        int fiyatSiraNo = c.getColumnIndex("siparisfiyat");
        String dizi[]=new String[c.getCount()];
     
        int sayac=0;
      
        for (c.moveToFirst(); !c.isAfterLast(); c.moveToNext()) {
            dizi[sayac]=c.getString(isimSiraNo) + "    "  + c.getString(adetSiraNo)+" Adet" + "  " + c.getString(fiyatSiraNo);
            toplam=toplam+c.getDouble(fiyatSiraNo);
            diziid[sayac]=c.getString(idSiraNo);
            
            sayac+=1;
            
        }
 
        ArrayAdapter AA= new ArrayAdapter<String>(context,android.R.layout.simple_list_item_1,dizi);  
        return AA;
    }
    
    public String sipariskayit(String oda)
    {
    	String[] sutunlar = new String[] {"siparisisim", "siparisadet", "siparisfiyat"};
	    SQLiteDatabase db = this.getReadableDatabase();
	    Cursor c = db.query("siparis", sutunlar, null, null,null, null, null);
	   
		
		
	  String odano;
	  String yemekadi;
	  String yemekadet;
	  String yemekfiyat;
	  
        int isimSiraNo = c.getColumnIndex("siparisisim");
        int adetSiraNo = c.getColumnIndex("siparisadet");
        int fiyatSiraNo = c.getColumnIndex("siparisfiyat");
        String dizi[]=new String[c.getCount()];
        String deger = null;
        int sayac=0;
      
        for (c.moveToFirst(); !c.isAfterLast(); c.moveToNext()) {
        	String kayit;
            odano=oda;
           
            yemekadi=c.getString(isimSiraNo);
            yemekadet=c.getString(adetSiraNo);
            yemekfiyat=c.getString(fiyatSiraNo);
            
        	kayit=Call1(odano,yemekadi,yemekadet,yemekfiyat);
        	if(kayit.equals("kayit"))
     		{
     			
     			deger="islemtamam";
     		}
            
            sayac+=1;
            
   
        }
        
        return deger;
 
    }


	
    
   
  
     
     
     
 
}
