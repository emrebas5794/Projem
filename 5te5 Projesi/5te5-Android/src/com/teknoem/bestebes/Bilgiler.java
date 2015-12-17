package com.teknoem.bestebes;

import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.teknoem.bestebe.R;



import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class Bilgiler extends Activity {
	private static final String TAG_ticket = "uyeguncele";
	private static final String TAG_deger = "deger";
	SessionManager session;
	JSONArray androidd = null;
	String deger,url;
	 ConnectivityManager cn;
	 NetworkInfo nf;
	 Button uyeguncelle;
	EditText bilgi_soyad,bilgi_edit_ad,bilgi_edit_kullaniciadi,bilgi_edit_sifre,bilgi_edit_email;
String deger_bilgi_tokenid,donenresimyol,deger_bilgi_soyad,deger_bilgi_edit_ad,deger_bilgi_edit_kullaniciadi,deger_bilgi_edit_sifre,deger_bilgi_edit_email,deger_bilgi_edit_uyeid,deger_bilgi_edit_takimi;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_bilgiler);
		bilgi_edit_ad=(EditText)findViewById(R.id.beditText1);	
		bilgi_soyad=(EditText)findViewById(R.id.beditText2);	
		bilgi_edit_kullaniciadi=(EditText)findViewById(R.id.beditText3);	
		bilgi_edit_sifre=(EditText)findViewById(R.id.beditText4);	
		bilgi_edit_email=(EditText)findViewById(R.id.beditText5);	
		  session = new SessionManager(getApplicationContext());
			Bundle resimyol=getIntent().getExtras();
			 donenresimyol=resimyol.getString("resimyol");
			session.checkLogin();
			 HashMap<String, String> user = session.getUserDetails();
			 deger_bilgi_edit_ad=user.get(SessionManager.KEY_NAME);
			 deger_bilgi_soyad=user.get(SessionManager.KEY_soyad);
			 deger_bilgi_tokenid=user.get(SessionManager.KEY_tokenid);
			 
			 deger_bilgi_edit_kullaniciadi=user.get(SessionManager.KEY_kullaniciadi);
			 deger_bilgi_edit_sifre=user.get(SessionManager.KEY_sifre);
			 deger_bilgi_edit_email=user.get(SessionManager.KEY_EMAIL);
			 deger_bilgi_edit_uyeid=user.get(SessionManager.KEY_uyeid);
			 deger_bilgi_edit_takimi=user.get(SessionManager.KEY_takimi);
			 
			 bilgi_edit_ad.setText(deger_bilgi_edit_ad);
			 bilgi_soyad.setText(deger_bilgi_soyad);
			 bilgi_edit_kullaniciadi.setText(deger_bilgi_edit_kullaniciadi);
			 bilgi_edit_sifre.setText(deger_bilgi_edit_sifre);
			 bilgi_edit_email.setText(deger_bilgi_edit_email);
			 
			  uyeguncelle=(Button)findViewById(R.id.uyeguncelle);	
				
			 uyeguncelle.setOnClickListener(new View.OnClickListener() {
		        	public void onClick(View v) {
		        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
		        	     nf=cn.getActiveNetworkInfo();
		        	     if(nf != null && nf.isConnected()==true )
		       		    {

			   			 bilgi_edit_kullaniciadi.getText().toString();
			   			 bilgi_edit_sifre.getText().toString();
			   			 bilgi_edit_email.getText().toString();
		        		if( bilgi_edit_ad.getText().toString().equals("") ||  bilgi_soyad.getText().toString().equals("") || bilgi_edit_kullaniciadi.getText().toString().equals("") || bilgi_edit_sifre.getText().toString().equals("") ||  bilgi_edit_email.getText().toString().equals("") )
		        		{
		        			Toast.makeText(getApplicationContext(),"Lütfen Boþ Alan Býrakmayýnýz.", Toast.LENGTH_SHORT).show(); 
		        			
		        		}
		        		else
		        		{
		        		
		        		 url = "http://teknoem.com/bestebes/uyeguncelle.aspx?uyeguncelle=true&eposta="+bilgi_edit_email.getText().toString()+"&ad="+bilgi_edit_ad.getText().toString()+"&soyad="+bilgi_soyad.getText().toString()+"&kullaniciadi="+bilgi_edit_kullaniciadi.getText().toString()+"&sifre="+bilgi_edit_sifre.getText().toString()+"&uyeid="+deger_bilgi_edit_uyeid+"&tokenid="+deger_bilgi_tokenid+"";
			        		new JSONParse().execute();
			        		session.createLoginSession(deger_bilgi_edit_uyeid,bilgi_edit_email.getText().toString(),deger_bilgi_edit_takimi,bilgi_edit_ad.getText().toString(),bilgi_soyad.getText().toString(),bilgi_edit_kullaniciadi.getText().toString(),bilgi_edit_sifre.getText().toString(),deger_bilgi_tokenid);
		        		}	
			        		
		    		
		      		    }
		         		 else
		            		    {
		         			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
		         		    	startActivity(intent);         		    	
		            		    }
		        		
		        	}
				});
			 
	}
	
	private class JSONParse extends AsyncTask<String, String, JSONObject> {
   	 private ProgressDialog pDialog;
   	@Override
       protected void onPreExecute() {
           super.onPreExecute();
         
           pDialog = new ProgressDialog(Bilgiler.this);
           pDialog.setMessage("Yükleniyorr ...");
           pDialog.setIndeterminate(false);
           pDialog.setCancelable(false);
           pDialog.show();
           
            
           
   	}
   	
   	@Override
       protected JSONObject doInBackground(String... args) {
   		
   		JSONParser jParser = new JSONParser();

   		// Getting JSON from URL
   		JSONObject json = jParser.getJSONFromUrl(url);
   		return json;
   	}
   	 @Override
        protected void onPostExecute(JSONObject json) {
   		 pDialog.dismiss();
   		 try {
   				// Getting JSON Array from URL
   				androidd = json.getJSONArray(TAG_ticket);
   				
   				JSONObject c = androidd.getJSONObject(0);
   				
   				// Storing  JSON item in a Variable
   				 deger = c.getString(TAG_deger);
   				
   				
   				if(deger.equals("true"))
   				{
   			
   					session.checkLogin();
		   			 HashMap<String, String> user = session.getUserDetails();
		   			 deger_bilgi_edit_ad=user.get(SessionManager.KEY_NAME);
		   			 deger_bilgi_soyad=user.get(SessionManager.KEY_soyad);
		   			 deger_bilgi_edit_kullaniciadi=user.get(SessionManager.KEY_kullaniciadi);
		   			 deger_bilgi_edit_sifre=user.get(SessionManager.KEY_sifre);
		   			 deger_bilgi_edit_email=user.get(SessionManager.KEY_EMAIL);
		   			 deger_bilgi_edit_uyeid=user.get(SessionManager.KEY_uyeid);
		   			 deger_bilgi_edit_takimi=user.get(SessionManager.KEY_takimi);
		   			 
		   			 bilgi_edit_ad.setText(deger_bilgi_edit_ad);
		   			 bilgi_soyad.setText(deger_bilgi_soyad);
		   			 bilgi_edit_kullaniciadi.setText(deger_bilgi_edit_kullaniciadi);
		   			 bilgi_edit_sifre.setText(deger_bilgi_edit_sifre);
		   			 bilgi_edit_email.setText(deger_bilgi_edit_email);
   					Toast.makeText(getApplicationContext(),"Günceleme Yapýldý.", Toast.LENGTH_SHORT).show(); 
   				
   					final Bundle bundle=new Bundle();
   				Intent intent = new Intent(getApplicationContext(), Profil.class);
   				bundle.putString("resimyol",donenresimyol);
   				
   				intent.putExtras(bundle);
   					startActivity(intent); 
				
					uyeguncelle.setBackgroundResource(R.drawable.sorucevapback);
   				}
   				if(deger.equals("eposta"))
   				{
   					
   					Toast.makeText(getApplicationContext(),"Bu Eposta Baþkasý Tarafýndan Kullanýyor.", Toast.LENGTH_SHORT).show(); 
   					bilgi_edit_email.setBackgroundColor(Color.RED);
   				
   				}
   				if(deger.equals("kullaniciadi"))
   				{
   					Toast.makeText(getApplicationContext(),"Bu Kullanici Adý Baþkasý Tarafýndan Kullanýyor.", Toast.LENGTH_SHORT).show(); 
   					bilgi_edit_kullaniciadi.setBackgroundColor(Color.RED);
   				}
   				if(deger.equals("epostakullaniciadi"))
   				{
   					Toast.makeText(getApplicationContext(),"Bu Kullanici Adý ve Eposta Baþkasý Tarafýndan Kullanýyor.", Toast.LENGTH_SHORT).show(); 
   					bilgi_edit_email.setBackgroundColor(Color.RED);
   					bilgi_edit_kullaniciadi.setBackgroundColor(Color.RED);
   				}
   				if(deger.equals("kotu"))
   				{
   					Toast.makeText(getApplicationContext(),"Telefon Mac Adresiniz Alýndý Hakkýnýzda Ýþlem Baþlatýlacaktýr.", Toast.LENGTH_SHORT).show(); 
   					
   				}
   				
   		} catch (JSONException e) {
   			e.printStackTrace();
   		}

   		 
   	 }
}
	
	 public void onBackPressed() {
		 final Bundle bundle=new Bundle();
			Intent intent = new Intent(getApplicationContext(), Profil.class);
			bundle.putString("resimyol",donenresimyol);
			
			intent.putExtras(bundle);
				startActivity(intent); 
		
	    }

}
