
package com.teknoem.bestebes;



import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;



import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.Intent;
import android.graphics.Color;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.StrictMode;
import android.text.InputType;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;



import com.teknoem.bestebe.R;
import com.teknoem.bestebes.*;

public class Anasayfa extends Activity {

	
	private static final String TAG_login = "login";
	private static final String TAG_email = "email";
	private static final String TAG_deger2 = "deger";
	private static final String TAG_deger = "deger";
	private static final String TAG_id = "uyeid";
	private static final String TAG_eposta = "eposta";
	private static final String TAG_takimi = "takimi";
	private static final String TAG_ad = "ad";
	private static final String TAG_soyad = "soyad";
	private static final String TAG_kullaniciadi = "kullaniciadi";
	private static final String TAG_sifre = "sifre";
	private static final String TAG_tokenid = "tokenid";
	
	Context context =this;
	JSONArray androidd = null;
	JSONArray androiddd = null;
	String tokenid,id,eposta,takimi,ad,soyad,kullaniciadi,sifre,deger,deger2,jokersayisi;
	 String url,url2;
	 EditText edit_kullaniciadi,edit_sifre;
	 ConnectivityManager cn;
	 NetworkInfo nf;
		SessionManager session;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy); 
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_anasayfa);
		
		
	   
		 edit_kullaniciadi=(EditText)findViewById(R.id.kullaniciadi_edit);	
		 edit_sifre=(EditText)findViewById(R.id.sifre_edit);
		
		Button uyekayit=(Button)findViewById(R.id.kayitolbtn);	
		 
		uyekayit.setOnClickListener(new View.OnClickListener() {
	        	public void onClick(View v) {

	        		
					Intent intent = new Intent(getApplicationContext(), Kayit2.class);
				
					startActivity(intent); 
	        		
	        	}
			});
		
		
TextView sifremiunuttum=(TextView)findViewById(R.id.sifremiunuttumbtn);	
		
sifremiunuttum.setOnClickListener(new View.OnClickListener() {
        	public void onClick(View v) {
        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
        	     nf=cn.getActiveNetworkInfo();
        		 if(nf != null && nf.isConnected()==true )
        		    {
        			 AlertDialog.Builder epostagonder =new AlertDialog.Builder(context);
        			 epostagonder.setTitle("5te5 Þifre Bilgilendirme");
        				final EditText input = new EditText(context);
        			
        				// Specify the type of input expected; this, for example, sets the input as a password, and will mask the text
        				input.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS);
        				epostagonder.setView(input);
        				
        				
        				 
        				epostagonder.setMessage("Sisteme Kayýtlý E-Postanýzý Giriniz");
        				epostagonder.setCancelable(false);
        		    	
        				epostagonder.setPositiveButton("Gönder", new DialogInterface.OnClickListener() {
        		    		@Override
        		    		public void onClick(DialogInterface diyalog,int which)
        		    		{
        		    			
        		    			
        		    			 url2 = "http://teknoem.com/bestebes/mailat.aspx?email="+input.getText().toString()+"";
        		         		new JSONParse2().execute();
        		         			
        		         			
        		         		
        		    			
        		    		}
        		    	
        		    	})
        		    	.setNegativeButton("Vazgeç", new DialogInterface.OnClickListener()
        		    	{	
        					public void onClick(DialogInterface dialog, int which) {
        						// TODO Auto-generated method stub
        						
        					}
        		    	
        		    	
        		    	
        		    	
        		    });
        		    	AlertDialog alertDialog=epostagonder.create();
        		    	alertDialog.show();
        		
        		    }
        		   else
        		    {
        		    	Intent intent = new Intent(getApplicationContext(), Hata.class);
        				
        				startActivity(intent); 
        		    	
        		    }
        		
        	}
		});
		
		Button grsbtn=(Button)findViewById(R.id.girisbtn);	
		
		grsbtn.setOnClickListener(new View.OnClickListener() {
        	public void onClick(View v) {
        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
        	     nf=cn.getActiveNetworkInfo();
        		 if(nf != null && nf.isConnected()==true )
        		    {
        		 session = new SessionManager(getApplicationContext());       
        		 url = "http://teknoem.com/bestebes/login.aspx?login=true&kullaniciadi="+edit_kullaniciadi.getText().toString()+"&sifre="+edit_sifre.getText().toString()+"";
        		new JSONParse().execute();
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
          
            pDialog = new ProgressDialog(Anasayfa.this);
            pDialog.setMessage("Yükleniyorr ...");
            pDialog.setIndeterminate(false);
            pDialog.setCancelable(true);
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
    				androidd = json.getJSONArray(TAG_login);
    				
    				JSONObject c = androidd.getJSONObject(0);
    				
    				// Storing  JSON item in a Variable
    				 deger = c.getString(TAG_deger);
    				 if(deger.equals("true"))
    				 {
    					 id = c.getString(TAG_id);
        				 eposta = c.getString(TAG_eposta);
        				 takimi = c.getString(TAG_takimi);
        				 ad = c.getString(TAG_ad);
        				 soyad = c.getString(TAG_soyad);
        				 kullaniciadi = c.getString(TAG_kullaniciadi);
        				 sifre = c.getString(TAG_sifre);
        				 sifre = c.getString(TAG_sifre);
        				 tokenid = c.getString(TAG_tokenid);
        				
        				
        				if(kullaniciadi.equals(edit_kullaniciadi.getText().toString()) && sifre.equals(edit_sifre.getText().toString()))
        				{
        				
        					session.createLoginSession(id,eposta,takimi,ad,soyad,kullaniciadi,sifre,tokenid);
        					Intent intent = new Intent(getApplicationContext(), MainActivity.class);
        					
		        			
						
        					startActivity(intent); 
        					
        				}
    					 
    				 }
    				 
    				else
    				{
    					
    					Toast.makeText(getApplicationContext(),"Kullanýcý Adý Veya Þifre Yanlýþ", Toast.LENGTH_SHORT).show(); 
    				}
    				 
    				
    				
    		} catch (JSONException e) {
    			e.printStackTrace();
    		}

    		 
    	 }
    	 
    	 
    	 
    	 
    	 
}
	 
	 
	 
	 private class JSONParse2 extends AsyncTask<String, String, JSONObject> {
    	 private ProgressDialog pDialog;
    	@Override
        protected void onPreExecute() {
            super.onPreExecute();
          
            pDialog = new ProgressDialog(Anasayfa.this);
            pDialog.setMessage("E-Posta Gönderiliyor");
            pDialog.setIndeterminate(false);
            pDialog.setCancelable(true);
            pDialog.show();
            
             
            
    	}
    	
    	@Override
        protected JSONObject doInBackground(String... args) {
    		
    		JSONParser jParser = new JSONParser();

    		// Getting JSON from URL
    		JSONObject json = jParser.getJSONFromUrl(url2);
    		return json;
    	}
    	 @Override
         protected void onPostExecute(JSONObject json) {
    		 pDialog.dismiss();
    		 try {
    				// Getting JSON Array from URL
    				androiddd = json.getJSONArray(TAG_email);
    				
    				JSONObject c = androiddd.getJSONObject(0);
    				
    				// Storing  JSON item in a Variable
    				 deger2 = c.getString(TAG_deger2);
    				 if(deger2.equals("true"))
    				 {
    					 Toast.makeText(getApplicationContext(),"Þifereniz Epostanýza Gonderildi Lütfen Epostanýzý Kontrol Ediniz", 5000).show();
    					 
    				 }
    				 
    				 if(deger2.equals("false"))
    				{
    					
    					Toast.makeText(getApplicationContext(),"Sisteme Kayýtlý E-posta Adresi Deðil", 5000).show();
    				}
    				 
    				
    				
    		} catch (JSONException e) {
    			e.printStackTrace();
    		}

    		 
    	 }
    	 
    	 
    	 
    	 
    	 
}
	
	 public void onBackPressed() {
	        new AlertDialog.Builder(this).setIcon(android.R.drawable.ic_dialog_alert).setTitle("Exit")
	                .setMessage("Uygulamayý Kapatmak Mý Ýstiyorsun?")
	                .setPositiveButton("Evet", new DialogInterface.OnClickListener() {
	                    @Override
	                    public void onClick(DialogInterface dialog, int which) {
	                    	  moveTaskToBack(true);
	                    	  finish();
	                    	  Intent intent = new Intent(getApplicationContext(), Anasayfa.class);
	              			
	              			startActivity(intent); 
                          
	                    }
	                }).setNegativeButton("Hayýr", null).show();
	    }
}
