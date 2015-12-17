package com.example.otelotomasyonu;



import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.PropertyInfo;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;


import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.os.StrictMode;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;


import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;




public class MainGirisActivity extends Activity {
	
	
	public static final  String SOAP_ACTION = "http://tempuri.org/yemekgosterid";
	public  static final  String OPERATION_NAME = "yemekgosterid"; 
	public static final  String WSDL_TARGET_NAMESPACE = "http://tempuri.org/";
	public static final  String SOAP_ADDRESS = "http://kralled.com/Service1.asmx";
	
	public static final  String SOAP_ACTION2 = "http://tempuri.org/yemekgosterisim";
	public  static final  String OPERATION_NAME2 = "yemekgosterisim"; 
	public static final  String WSDL_TARGET_NAMESPACE2 = "http://tempuri.org/";
	public static final  String SOAP_ADDRESS2 = "http://kralled.com/Service1.asmx";
	
	public static final  String SOAP_ACTION3 = "http://tempuri.org/yemekgosterresim";
	public  static final  String OPERATION_NAME3 = "yemekgosterresim"; 
	public static final  String WSDL_TARGET_NAMESPACE3 = "http://tempuri.org/";
	public static final  String SOAP_ADDRESS3 = "http://kralled.com/Service1.asmx";
	
	
	
	
	
	public String Call1()
	{
		SoapObject request = new SoapObject(WSDL_TARGET_NAMESPACE,OPERATION_NAME);
		
		
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
	
	public String Call2()
	{
		SoapObject request = new SoapObject(WSDL_TARGET_NAMESPACE2,OPERATION_NAME2);
		
		
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
	
	public String Call3()
	{
		SoapObject request = new SoapObject(WSDL_TARGET_NAMESPACE3,OPERATION_NAME3);
		
		
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
	
	@Override
	
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main_giris);
		 Bundle oda=getIntent().getExtras();
			final String donenoda=oda.getString("oda");
		
			
			
			 Button siparisler=(Button)findViewById(R.id.siparisler11);		
			 siparisler.setOnClickListener(new View.OnClickListener() {
		        	public void onClick(View v) {
		        		
		        		final Bundle bundle=new Bundle();
		        		Intent intent = new Intent(MainGirisActivity.this, MainSiparisActivity.class);
		        		bundle.putString("oda",donenoda);
						intent.putExtras(bundle);
		        		startActivity(intent); 
						
		        	}
				});
		ArrayList<NewsItem> image_details = getListData();
		final ListView lv1 = (ListView) findViewById(R.id.list);
		lv1.setAdapter(new CustomListAdapter(this, image_details));
		
		lv1.setOnItemClickListener(new OnItemClickListener() {

			
			public void onItemClick(AdapterView<?> a, View v, int position, long id) {
				Object o = lv1.getItemAtPosition(position);
				NewsItem newsData = (NewsItem) o;
				final Bundle bundle=new Bundle();
				Intent intent = new Intent(MainGirisActivity.this, MainYenekActivity.class);
				
				bundle.putString("secilen",newsData.getyemekid());
				bundle.putString("oda",donenoda);
				intent.putExtras(bundle);
				startActivity(intent);
				
				
			}

		});

				
		
			}

	
				
	String id = new String(Call1());
    String[] diziid = id.split(",");
    
    String isim = new String(Call2());
    String[] diziisim = isim.split(",");
    
    String resimyol = new String(Call3());
    String[] diziresimyol = resimyol.split(",");
	

	
        
	private ArrayList<NewsItem> getListData() {
		
		 
		    
		ArrayList<NewsItem> results = new ArrayList<NewsItem>();
		NewsItem newsData = new NewsItem();
		for(int i=0;i<diziid.length;i++)
		{
		newsData = new NewsItem();
		newsData.setyemekid(diziid[i]);
		newsData.setyemekadi(diziisim[i]);
		newsData.setUrl("http://kralled.com/"+diziresimyol[i]);
		results.add(newsData);
		
		
		
		}
		

		return results;
	}
			
		

	

	
	



	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main_giris, menu);

		

        
        
		return true;
	}




	
}
