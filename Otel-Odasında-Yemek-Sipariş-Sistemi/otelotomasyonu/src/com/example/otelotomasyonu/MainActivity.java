package com.example.otelotomasyonu;

import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.os.StrictMode;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.PropertyInfo;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;

public class MainActivity extends Activity {
	public final String SOAP_ACTION = "http://tempuri.org/login";
	public final String OPERATION_NAME = "login"; 
	public final String WSDL_TARGET_NAMESPACE = "http://tempuri.org/";
	public final String SOAP_ADDRESS = "http://kralled.com/Service1.asmx";
	
	TextView tvstatus;
	public String Call(String odano)
	{
		SoapObject request = new SoapObject(WSDL_TARGET_NAMESPACE,OPERATION_NAME);
		PropertyInfo pit=new PropertyInfo();
	 	 pit.setName("odano");
	 	 pit.setValue(odano);
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
	

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		  StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
          StrictMode.setThreadPolicy(policy);      
        
        
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		    ConnectivityManager cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
		    NetworkInfo nf=cn.getActiveNetworkInfo();
		    if(nf != null && nf.isConnected()==true )
		    {
		        Toast.makeText(this, "Baðlantý var.", Toast.LENGTH_LONG).show();
		       
		        final EditText editoda=(EditText)findViewById(R.id.editoda);
		       
		       
		        Button girisbut=(Button)findViewById(R.id.butgiris);
		        girisbut.setOnClickListener(new View.OnClickListener() {
		        	public void onClick(View v) {
		        		
						final String odano2=String.valueOf(editoda.getText()) ; 
						final String durum=String.valueOf("1");
						final String sayi;
						final String s;
						
						sayi=Call(odano2);
						
						
						
						if (sayi.equals(durum))
						{		
							final Bundle bundle=new Bundle();
							
							
						
							Intent intent = new Intent(MainActivity.this, MainGirisActivity.class);
							bundle.putString("oda",odano2);
							intent.putExtras(bundle);
							startActivity(intent); 
						}
						
							
						
		        	}
				});
		    }
		    
		    else
		    {
		        Toast.makeText(this, "Baðlantý mevcut deðil kontrol ediniz.", Toast.LENGTH_LONG).show();
		        
		      }
		        
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

}
