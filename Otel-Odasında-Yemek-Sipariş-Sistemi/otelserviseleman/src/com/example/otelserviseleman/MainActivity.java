package com.example.otelserviseleman;

import java.util.ArrayList;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.PropertyInfo;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;

import com.example.otelserviseleman.CustomListAdapter;
import com.example.otelserviseleman.MainActivity;
import com.example.otelserviseleman.NewsItem;
import com.example.otelserviseleman.R;

import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.view.Menu;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;

public class MainActivity extends Activity {
	public static final  String SOAP_ACTION = "http://tempuri.org/serviselamanid";
	public  static final  String OPERATION_NAME = "serviselamanid"; 
	public static final  String WSDL_TARGET_NAMESPACE = "http://tempuri.org/";
	public static final  String SOAP_ADDRESS = "http://kralled.com/Service1.asmx";
	
	public static final  String SOAP_ACTION2 = "http://tempuri.org/serviselamanoda";
	public  static final  String OPERATION_NAME2 = "serviselamanoda"; 
	public static final  String WSDL_TARGET_NAMESPACE2 = "http://tempuri.org/";
	public static final  String SOAP_ADDRESS2 = "http://kralled.com/Service1.asmx";
	
	public static final  String SOAP_ACTION3 = "http://tempuri.org/servissil";
	public  static final  String OPERATION_NAME3 = "servissil"; 
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
	public String Call3(String id)
	{
		SoapObject request = new SoapObject(WSDL_TARGET_NAMESPACE3,OPERATION_NAME3);
		PropertyInfo pit=new PropertyInfo();
	 	 pit.setName("id");
	 	 pit.setValue(id);
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
	Context context =this;
	String servisid;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		
		
		 ConnectivityManager cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
		    NetworkInfo nf=cn.getActiveNetworkInfo();
		    if(nf != null && nf.isConnected()==true )
		    {
		        Toast.makeText(this, "Baðlantý var.", Toast.LENGTH_LONG).show();
	        
	        Button yenile=(Button)findViewById(R.id.yenile);		
			 yenile.setOnClickListener(new View.OnClickListener() {
		        	public void onClick(View v) {
		        		
		        		
		        		Intent intent = new Intent(MainActivity.this, MainActivity.class);
		        		
		        		startActivity(intent); 
						
		        	}
				});
			 
			 ArrayList<NewsItem> image_details = getListData();
				final ListView lv1 = (ListView) findViewById(R.id.yemeklistee);
				lv1.setAdapter(new CustomListAdapter(this, image_details));
				
				lv1.setOnItemClickListener(new OnItemClickListener() {

					
					public void onItemClick(AdapterView<?> a, View v, int position, long id) {
						Object o = lv1.getItemAtPosition(position);
						NewsItem newsData = (NewsItem) o;
						
						servisid=newsData.getyemekid().toString();
						AlertDialog.Builder hazir =new AlertDialog.Builder(context);
			        	hazir.setTitle("Otel Servis");
			        	hazir.setMessage("Sipariþ Silinsin Mi?");
			        	hazir.setCancelable(false);
			        	
			        	hazir.setPositiveButton("EVET", new DialogInterface.OnClickListener() {
			        		@Override
			        		public void onClick(DialogInterface diyalog,int which)
			        		{
			        		
			        			if(Call3(servisid).equals("silindi"))
				        		{
				        			
				        			Toast.makeText(getApplicationContext(),"Sipariþ Silinmiþtir", Toast.LENGTH_SHORT).show();
				        			Intent intent = new Intent(MainActivity.this, MainActivity.class);
					        		
					    			startActivity(intent); 

				        		}
				        			
			        			
			        		}
			        	
			        	})
			        	.setNegativeButton("HAYIR", new DialogInterface.OnClickListener()
			        	{	
							public void onClick(DialogInterface dialog, int which) {
								// TODO Auto-generated method stub
								
							}
			        	
			        	
			        	
			        	
			        });
			        	AlertDialog alertDialog=hazir.create();
			        	alertDialog.show();
						
						
						
					}

				});
		    }
		    
		    else
		    {
		        Toast.makeText(this, "Baðlantý mevcut deðil kontrol ediniz.", Toast.LENGTH_LONG).show();
		        
		      }
		
		
	}
	
	 
	    
	    String odano = new String(Call2());
	    String[] diziodano = odano.split(",");
		
	    String id = new String(Call1());
	    String[] diziyemekid = id.split(",");
	    

		
	        
		private ArrayList<NewsItem> getListData() {
			
			 
			    
			ArrayList<NewsItem> results = new ArrayList<NewsItem>();
			NewsItem newsData = new NewsItem();
			for(int i=0;i<diziyemekid.length;i++)
			{
			newsData = new NewsItem();
			newsData.setyemekid(diziyemekid[i]);
			newsData.setodano("Oda "+diziodano[i]+" Sipariþleri Hazýr.");
			results.add(newsData);
			
			
			
			}
			

			return results;
		}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

}
