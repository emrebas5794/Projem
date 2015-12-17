package com.example.otelotomasyonu;

import java.util.ArrayList;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.PropertyInfo;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;

import android.os.Bundle;
import android.os.StrictMode;
import android.app.Activity;
import android.content.Intent;
import android.view.Menu;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import android.widget.AdapterView.OnItemClickListener;

public class MainYenekActivity extends Activity {

	public static final  String SOAP_ACTION = "http://tempuri.org/yemeklerigosterid";
	public  static final  String OPERATION_NAME = "yemeklerigosterid"; 
	public static final  String WSDL_TARGET_NAMESPACE = "http://tempuri.org/";
	public static final  String SOAP_ADDRESS = "http://kralled.com/Service1.asmx";
	
	public static final  String SOAP_ACTION2 = "http://tempuri.org/yemeklerigosterisim";
	public  static final  String OPERATION_NAME2 = "yemeklerigosterisim"; 
	public static final  String WSDL_TARGET_NAMESPACE2 = "http://tempuri.org/";
	public static final  String SOAP_ADDRESS2 = "http://kralled.com/Service1.asmx";
	
	public static final  String SOAP_ACTION3 = "http://tempuri.org/yemeklerigosterresim";
	public  static final  String OPERATION_NAME3 = "yemeklerigosterresim"; 
	public static final  String WSDL_TARGET_NAMESPACE3 = "http://tempuri.org/";
	public static final  String SOAP_ADDRESS3 = "http://kralled.com/Service1.asmx";
	
	public static final  String SOAP_ACTION4 = "http://tempuri.org/yemeklerigosterfiyat";
	public  static final  String OPERATION_NAME4 = "yemeklerigosterfiyat"; 
	public static final  String WSDL_TARGET_NAMESPACE4 = "http://tempuri.org/";
	public static final  String SOAP_ADDRESS4 = "http://kralled.com/Service1.asmx";
	
	
	public String Call1(String menuidsi)
	{
		SoapObject request = new SoapObject(WSDL_TARGET_NAMESPACE,OPERATION_NAME);
		PropertyInfo pit=new PropertyInfo();
	 	 pit.setName("menuidsi");
	 	 pit.setValue(menuidsi);
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
	
	public String Call2(String menuidsi)
	{
		SoapObject request = new SoapObject(WSDL_TARGET_NAMESPACE2,OPERATION_NAME2);
		PropertyInfo pit=new PropertyInfo();
	 	 pit.setName("menuidsi");
	 	 pit.setValue(menuidsi);
		pit.setType(String.class);
		request.addProperty(pit);
		
		SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(
		SoapEnvelope.VER11);
		envelope.dotNet = true;
	
		envelope.setOutputSoapObject(request);
	
		HttpTransportSE httpTransport = new HttpTransportSE(SOAP_ADDRESS2);
		Object response=null;
		try
		{
			httpTransport.call(SOAP_ACTION2, envelope);
			response = envelope.getResponse();
			
		}
		catch (Exception exception)
		{
			response=exception.toString();
		}
		return response.toString();
	}
	
	public String Call3(String menuidsi)
	{
		SoapObject request = new SoapObject(WSDL_TARGET_NAMESPACE3,OPERATION_NAME3);
		
		PropertyInfo pit=new PropertyInfo();
	 	 pit.setName("menuidsi");
	 	 pit.setValue(menuidsi);
		pit.setType(String.class);
		request.addProperty(pit);
		
		SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(
		SoapEnvelope.VER11);
		envelope.dotNet = true;
	
		envelope.setOutputSoapObject(request);
	
		HttpTransportSE httpTransport = new HttpTransportSE(SOAP_ADDRESS3);
		Object response=null;
		try
		{
			httpTransport.call(SOAP_ACTION3, envelope);
			response = envelope.getResponse();
			
		}
		catch (Exception exception)
		{
			response=exception.toString();
		}
		return response.toString();
	}
	
	public String Call4(String menuidsi)
	{
		SoapObject request = new SoapObject(WSDL_TARGET_NAMESPACE4,OPERATION_NAME4);
		PropertyInfo pit=new PropertyInfo();
	 	 pit.setName("menuidsi");
	 	 pit.setValue(menuidsi);
		pit.setType(String.class);
		request.addProperty(pit);
		
		SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(
		SoapEnvelope.VER11);
		envelope.dotNet = true;
	
		envelope.setOutputSoapObject(request);
	
		HttpTransportSE httpTransport = new HttpTransportSE(SOAP_ADDRESS4);
		Object response=null;
		try
		{
			httpTransport.call(SOAP_ACTION4, envelope);
			response = envelope.getResponse();
			
		}
		catch (Exception exception)
		{
			response=exception.toString();
		}
		return response.toString();
	}
	
	String menuid;
	 private vtislem vtislem;
	 
	@Override
	
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main_yenek);
		
		 StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
         StrictMode.setThreadPolicy(policy);      
         Bundle oda=getIntent().getExtras();
			final String donenoda=oda.getString("oda");
         Button menuler=(Button)findViewById(R.id.menulerr);		
			 menuler.setOnClickListener(new View.OnClickListener() {
		        	public void onClick(View v) {
		        		
		        		final Bundle bundle=new Bundle();
		        		Intent intent = new Intent(MainYenekActivity.this, MainGirisActivity.class);
		        		bundle.putString("oda",donenoda);
						intent.putExtras(bundle);
		        		startActivity(intent); 
						
		        	}
				});
			 Button siparisler=(Button)findViewById(R.id.siparisler11);		
			 siparisler.setOnClickListener(new View.OnClickListener() {
		        	public void onClick(View v) {
		        		
		        		final Bundle bundle=new Bundle();
		        		Intent intent = new Intent(MainYenekActivity.this, MainSiparisActivity.class);
		        		bundle.putString("oda",donenoda);
						intent.putExtras(bundle);
		    			startActivity(intent); 
						
		        	}
				});
			
		vtislem=new vtislem(this, "siparis", null, 1);
	   
	    
		ArrayList<NewsItemyemek> image_details = getListData();
		
		
		final ListView lv1 = (ListView) findViewById(R.id.yemeklistee);
		lv1.setAdapter(new CustomListAdapteryemek(this, image_details));
		
		lv1.setOnItemClickListener(new OnItemClickListener() {

			
			public void onItemClick(AdapterView<?> a, View v, int position, long id) {
				Object o = lv1.getItemAtPosition(position);
				NewsItemyemek newsData = (NewsItemyemek) o;
				
				
				vtislem.kayitekle( newsData.getyemekadi().toString(),"1",  newsData.getyemekfiyat().toString());
				Toast.makeText(getApplicationContext(),"Sipariþ Eklendi..", Toast.LENGTH_SHORT).show(); 
			
				
			}

		});

		
		
		
		
	    
	}
	
	

	private ArrayList<NewsItemyemek> getListData() {
		
		

		Bundle datalar=getIntent().getExtras();
		final String donenler=datalar.getString("secilen");
		
		menuid=donenler;
		String id = new String(Call1(menuid));
	    String[] diziid = id.split(",");
	    
	    String isim = new String(Call2(menuid));
	    String[] diziisim = isim.split(",");
	    
	    String resimyol = new String(Call3(menuid));
	    String[] diziresimyol = resimyol.split(",");
				
	    String yemekfiyati = new String(Call4(menuid));
	    String[] diziyemekfiyat = yemekfiyati.split(",");
	    
		ArrayList<NewsItemyemek> results = new ArrayList<NewsItemyemek>();
		NewsItemyemek newsData = new NewsItemyemek();
		
		for(int i=0;i<diziid.length;i++)
		{
		newsData = new NewsItemyemek();
		newsData.setyemekid(diziid[i]);
		newsData.setyemekadi(diziisim[i]);
		newsData.setyemekfiyat(diziyemekfiyat[i]+"  TL");
		newsData.setUrl("http://kralled.com/"+diziresimyol[i]);
		results.add(newsData);
		
		
		
		}
		
		
		

		return results;
	}
			
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main_yenek, menu);
		return true;
	}

}
