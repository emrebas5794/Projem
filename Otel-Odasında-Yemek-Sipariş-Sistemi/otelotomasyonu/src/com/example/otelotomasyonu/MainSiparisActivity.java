package com.example.otelotomasyonu;

import java.lang.reflect.Array;
import java.util.ArrayList;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.PropertyInfo;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;

import android.R.array;
import android.os.Bundle;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.graphics.Color;
import android.view.Menu;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDatabase.CursorFactory;
import android.database.sqlite.SQLiteOpenHelper;

public class MainSiparisActivity extends Activity {
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
	
ArrayAdapter adaptor;
Context context =this;
private vtislem vtislem;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		vtislem=new vtislem(this, "siparis", null, 1);
		
	setContentView(R.layout.activity_main_siparis);
	
	final ListView lv1 = (ListView) findViewById(R.id.siparislistesi);
	 final TextView toplam=(TextView)findViewById(R.id.geneltoplam);
	 Bundle oda=getIntent().getExtras();
		final String donenoda=oda.getString("oda");
	adaptor= vtislem.tumKayitlar(getApplicationContext());
    lv1.setAdapter(adaptor);
  toplam.setText(String.valueOf(vtislem.toplam)+" TL");
		
 
  Button menuler=(Button)findViewById(R.id.menulerr);		
	 menuler.setOnClickListener(new View.OnClickListener() {
     	public void onClick(View v) {
     		
     		final Bundle bundle=new Bundle();
     		Intent intent = new Intent(MainSiparisActivity.this, MainGirisActivity.class);
     		bundle.putString("oda",donenoda);
				intent.putExtras(bundle);
     		startActivity(intent); 
				
     	}
		});
	 
	
		
	lv1.setOnItemClickListener(new OnItemClickListener() {
      
		   public void onItemClick(AdapterView<?> parent, View view,
                   final int position, long id) {
        	
        	AlertDialog.Builder sil =new AlertDialog.Builder(context);
        	sil.setTitle("Otel Servis");
        	sil.setMessage("Yemeði Silmek Ýstiyormusunuz.");
        	sil.setCancelable(false);
        	
        	sil.setPositiveButton("EVET", new DialogInterface.OnClickListener() {
        		@Override
        		public void onClick(DialogInterface diyalog,int which)
        		{
        			for(int i=0;i<=vtislem.diziid.length;i++)
        			{
        				
        				if(position==i)
        			
        				{
        					final Bundle bundle=new Bundle();
        					
        					vtislem.kayitsil(String.valueOf(vtislem.diziid[i]));
        					Toast.makeText(getApplicationContext(),"Yemek Silindi..", Toast.LENGTH_SHORT).show(); 
        					Intent intent = new Intent(MainSiparisActivity.this, MainSiparisActivity.class);
        					bundle.putString("oda",donenoda);
        					intent.putExtras(bundle);
    		    			startActivity(intent); 
        					
        				}
        					
        			}
        			
        			
        		}
        	
        	})
        	.setNegativeButton("HAYIR", new DialogInterface.OnClickListener()
        	{	
				public void onClick(DialogInterface dialog, int which) {
					// TODO Auto-generated method stub
					
				}
        	
        	
        	
        	
        });
        	AlertDialog alertDialog=sil.create();
        	alertDialog.show();
        			
        }
        });
	
	 Button kaydet=(Button)findViewById(R.id.kaydet);
     kaydet.setOnClickListener(new View.OnClickListener() {
     	public void onClick(View v) {
     		
     		if(vtislem.sipariskayit(donenoda).equals("islemtamam"))
     		{
     			final Bundle bundle=new Bundle();
     			
     			Toast.makeText(getApplicationContext(),"Sipariþiniz Verildi.", Toast.LENGTH_SHORT).show();
     			vtislem.siparislerisil();
     			Intent intent = new Intent(MainSiparisActivity.this, MainGirisActivity.class);
     			
        		
        		bundle.putString("oda",donenoda);
				intent.putExtras(bundle);
    			startActivity(intent); 
     		}
     		
     		
     		
                		
     	}

		
		});
	
        }
	
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main_siparis, menu);
		return true;
	}

}
