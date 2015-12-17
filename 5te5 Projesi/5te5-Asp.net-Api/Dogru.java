package com.teknoem.bestebes;

import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.android.gms.ads.*;
import com.google.android.gms.internal.ko;
import com.teknoem.bestebe.R;
import com.teknoem.bestebes.Soru5.CountDownExample;









import android.R.integer;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.media.MediaPlayer;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.renderscript.Sampler.Value;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

public class Dogru extends Activity {
	Button ticketsayisi,btnsonraki,sorupaylas;
	private static final String TAG_ticket = "ticket";
	private static final String TAG_deger = "deger";
	private static final String TAG_jokersil = "jokersil";
	private static final String TAG_deger2 = "deger2";
	private static final String TAG_jokerekle = "jokerekle";
	private static final String TAG_deger3 = "deger3";
	JSONArray androidd = null;
	JSONArray androiddd = null;
	JSONArray androidddd = null;
	String url,url2,url3,deger,deger2,deger3,donensorusayisi,donensoruid,donenjokersayisi;
	SessionManager session;
	 AdView adView;
	 ConnectivityManager cn;
	 NetworkInfo nf;
	 Button jokerkazan;
	 private InterstitialAd gecisReklam;
		 AdRequest adRequest;
	@Override
	
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_dogru);
		session = new SessionManager(getApplicationContext());
		 AdView adView = (AdView) this.findViewById(R.id.adView);
		    AdRequest adRequest = new AdRequest.Builder().build();
		    adView.loadAd(adRequest); //adView i yüklüyoruz
		Bundle soruid=getIntent().getExtras();
		 adView.resume(); 
		 donensoruid=soruid.getString("soruid");
			Bundle sorusayisi=getIntent().getExtras();
			 donensorusayisi=sorusayisi.getString("sorusayisi");
		 Bundle jokersayisi=getIntent().getExtras();
			donenjokersayisi=jokersayisi.getString("gidenjokersayisi");
		 
		ticketsayisi=(Button)findViewById(R.id.ticketsayisi);
		sorupaylas=(Button)findViewById(R.id.facepaylas);
		
		sorupaylas.setOnClickListener(new View.OnClickListener() {
        	public void onClick(View v) {
        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
        	     nf=cn.getActiveNetworkInfo();
        		 if(nf != null && nf.isConnected()==true )
        		    {
        			 
        		final Bundle bundle=new Bundle();
        		sorupaylas.setBackgroundColor(Color.RED);
    			Intent intent = new Intent(getApplicationContext(), SoruyuPaylas.class);
    			bundle.putString("soruid",donensoruid);
    			bundle.putString("gidenjokersayisi",donenjokersayisi);
    			bundle.putString("sorusayisi",donensorusayisi);
    			bundle.putString("sayfatipi","dogru");
				intent.putExtras(bundle);
				startActivity(intent); 
        		    }
         		 else
            		    {
         			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
         		    	startActivity(intent);         		    	
            		    }
        	}
		});
		
		 jokerkazan=(Button)findViewById(R.id.jokerkazan);
		 jokerkazan.setVisibility(View.INVISIBLE);
		 jokerkazan.setOnClickListener(new View.OnClickListener() {
	        	public void onClick(View v) {
	        		if(jokerkazan.getText().equals("1x Joker Kazan"))
	        		{
	        			
	        			showGecisReklam();
	        		}
	        		else
	        		{
	        			
	        			Toast.makeText(getApplicationContext(), "Joker Kazanmak Ýçin Tekrar Oynayýn.", Toast.LENGTH_LONG).show();
	        		}
	        		
	        	
	        		
	        	}
			});
		 
		
		  
		  
		  AdRequest adRdequest = new AdRequest.Builder()
	        .addTestDevice(AdRequest.DEVICE_ID_EMULATOR)    // remove if in real time use
	        .addTestDevice("9HD6IZVGT8SC9LBI")       // remove if in real time use
	        .build();
		  gecisReklam = new InterstitialAd(this);
	        
	        gecisReklam.setAdUnitId("ca-app-pub-8355959580831785/1731784154");//Reklam Ýd miz.Admob da oluþturduðumuz geçiþ reklam id si
	        gecisReklam.loadAd(adRdequest);
	        gecisReklam.setAdListener(new AdListener() { //Geçiþ reklama listener ekliyoruz
	        	
	        	@Override
	             public void onAdLoaded() { //Geçiþ reklam Yüklendiðinde çalýþýr
	      		  	
	        		if(donensorusayisi.equals("5"))
					{
						
	        			 jokerkazan.setVisibility(View.VISIBLE);
					}
	        		
	        	
	        		 
	        	 }
	        	 
	        	 
		    	
		         public void onAdFailedToLoad(int errorCode) { //Geçiþ Reklam Yüklenemediðinde  Çalýþýr
		   		  

		         }
		    	 
		    	  public void onAdClosed(){ //Geçiþ Reklam Kapatýldýðýnda çalýþýr
		    		
		    		 
		    	  }
		    	  public void   onAdOpened(){ //Geçiþ Reklam Kapatýldýðýnda çalýþýr
		    		
		    		  Toast.makeText(getApplicationContext(), "Joker Kazanmak Ýçin Týkla",3000).show();
		    		  
		    	
		    	  }
		    	  public void   onAdLeftApplication(){ //Geçiþ Reklam Kapatýldýðýnda çalýþýr
			    		
		    		 
		    		  session.checkLogin();
				         
						 HashMap<String, String> user = session.getUserDetails();
		    		  url3 = "http://teknoem.com/bestebes/sayiekle.aspx?jokerekle=true&kullaniciid="+ user.get(SessionManager.KEY_uyeid)+"";
		        		new JSONParse3().execute();
		        		int sayi=Integer.valueOf(donenjokersayisi)+1;
		        		donenjokersayisi=String.valueOf(sayi);
		        		 jokerkazan.setText("Tebrikler 1 Joker Kazandýnýz.." );
		    		  
		    	
		    	  }
		    	 
		    	 
			});
		btnsonraki=(Button)findViewById(R.id.btnsonraki1);
	
		
		btnsonraki.setOnClickListener(new View.OnClickListener() {
        	public void onClick(View v) {
        		 session.checkLogin();
		         
				 HashMap<String, String> user = session.getUserDetails();
        		btnsonraki.setBackgroundColor(Color.RED);
        		url2 = "http://teknoem.com/bestebes/sayiekle.aspx?jokersil=true&kullaniciid="+ user.get(SessionManager.KEY_uyeid)+"&jokersayisi="+donenjokersayisi+"";
        		new JSONParse2().execute();
        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
        	     nf=cn.getActiveNetworkInfo();
        		 if(nf != null && nf.isConnected()==true )
       		    {
				if(donensorusayisi.equals("1"))
				{		final Bundle bundle=new Bundle();
					
					Intent intent = new Intent(getApplicationContext(), Soru2.class);
					bundle.putString("gidenjokersayisi",donenjokersayisi);
					intent.putExtras(bundle);
					startActivity(intent); 
					
				}
				if(donensorusayisi.equals("2"))
				{
					
final Bundle bundle=new Bundle();
					
					Intent intent = new Intent(getApplicationContext(), Soru3.class);
					bundle.putString("gidenjokersayisi",donenjokersayisi);
					intent.putExtras(bundle);
					
					
					startActivity(intent); 
				}
				if(donensorusayisi.equals("3"))
				{
final Bundle bundle=new Bundle();
					
					Intent intent = new Intent(getApplicationContext(), Soru4.class);
					bundle.putString("gidenjokersayisi",donenjokersayisi);
					intent.putExtras(bundle);
					startActivity(intent); 
					
				}
				if(donensorusayisi.equals("4"))
				{
					
final Bundle bundle=new Bundle();
					
					Intent intent = new Intent(getApplicationContext(), Soru5.class);
					bundle.putString("gidenjokersayisi",donenjokersayisi);
					intent.putExtras(bundle);
					startActivity(intent); 
				}
				if(donensorusayisi.equals("5"))
				{
					
					 
					 
					
						 url = "http://teknoem.com/bestebes/sayiekle.aspx?ticketekle=true&kullaniciid="+ user.get(SessionManager.KEY_uyeid)+"";
			        		new JSONParse().execute();
			        		
			        		Intent intent = new Intent(getApplicationContext(), Soru1.class);
			        		final Bundle bundle=new Bundle();
							
							
							bundle.putString("gidenjokersayisi",donenjokersayisi);
							intent.putExtras(bundle);
							startActivity(intent); 
							
				}
       		 }
         		 else
            		    {
         			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
         		    	startActivity(intent);         		    	
            		    }
        	}
		});
		
		
		
		if(donensorusayisi.equals("1"))
		{
			
			ticketsayisi.setText("        5te5 için son 4 soru!" );
			
		}
		if(donensorusayisi.equals("2"))
		{
			
			ticketsayisi.setText("        5te5 için son 3 soru!" );
		}
		if(donensorusayisi.equals("3"))
		{
			
			ticketsayisi.setText("        5te5 için son 2 soru!" );
		}
		if(donensorusayisi.equals("4"))
		{
			
			ticketsayisi.setText("        5te5 için son 1 soru!" );
		}
		if(donensorusayisi.equals("5"))
		{
			//MediaPlayer sesVerisi=MediaPlayer.create(Dogru.this,R.raw.sesefek);
			 //sesVerisi.start();
			
			ticketsayisi.setText("        Tebrikler 5te5  Yaptýnýz." );
			btnsonraki.setText("Tekrar Oyna");
			
		}
		
		
	}
	
	
	
	 private class JSONParse extends AsyncTask<String, String, JSONObject> {
    	 private ProgressDialog pDialog;
    	@Override
        protected void onPreExecute() {
            super.onPreExecute();
          
            pDialog = new ProgressDialog(Dogru.this);
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
          
            pDialog = new ProgressDialog(Dogru.this);
            pDialog.setMessage("Yükleniyorr ...");
            pDialog.setIndeterminate(false);
            pDialog.setCancelable(false);
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
    				androiddd = json.getJSONArray(TAG_jokersil);
    				
    				JSONObject c = androiddd.getJSONObject(0);
    				
    				// Storing  JSON item in a Variable
    				 deger2 = c.getString(TAG_deger2);
    				
    				
    				
    				
    		} catch (JSONException e) {
    			e.printStackTrace();
    		}

    		 
    	 }
    	 
    	 
}
	 private class JSONParse3 extends AsyncTask<String, String, JSONObject> {
    	 private ProgressDialog pDialog;
    	@Override
        protected void onPreExecute() {
            super.onPreExecute();
          
            pDialog = new ProgressDialog(Dogru.this);
            pDialog.setMessage("Yükleniyorr ...");
            pDialog.setIndeterminate(false);
            pDialog.setCancelable(false);
            pDialog.show();
            
             
            
    	}
    	
    	@Override
        protected JSONObject doInBackground(String... args) {
    		
    		JSONParser jParser = new JSONParser();

    		// Getting JSON from URL
    		JSONObject json = jParser.getJSONFromUrl(url3);
    		return json;
    	}
    	 @Override
         protected void onPostExecute(JSONObject json) {
    		 pDialog.dismiss();
    		 try {
    				// Getting JSON Array from URL
    				androidddd = json.getJSONArray(TAG_jokerekle);
    				
    				JSONObject c = androidddd.getJSONObject(0);
    				
    				// Storing  JSON item in a Variable
    				 deger3 = c.getString(TAG_deger3);
    				if(deger3.equals("true"))
    				{
    					
    					
    				}
    				 
    				
    				 
    		} catch (JSONException e) {
    			e.printStackTrace();
    		}

    		 
    	 }
    	 
    	 
}


	 public void onBackPressed() {
	        new AlertDialog.Builder(this).setIcon(android.R.drawable.ic_dialog_alert).setTitle("Exit")
	                .setMessage("Anasayfa'ya Gitmek Mi Ýstiyorsun ?")
	                .setPositiveButton("Evet", new DialogInterface.OnClickListener() {
	                    @Override
	                    public void onClick(DialogInterface dialog, int which) {
	                    	if(donensorusayisi.equals("5"))
	        				{
	        					
	        					 session.checkLogin();
	        			         
	        					 HashMap<String, String> user = session.getUserDetails();
	        					 
	        					
	        						 url = "http://teknoem.com/bestebes/ticketkaydet.aspx?ticketekle=true&kullaniciid="+ user.get(SessionManager.KEY_uyeid)+"";
	        			        		new JSONParse().execute();
	        			        		
	        			        		Intent intent = new Intent(getApplicationContext(), MainActivity.class);
	        	    					
	        	    					startActivity(intent); 
	        				}
	                    	else
	                    	{
	                    		Intent intent = new Intent(getApplicationContext(), MainActivity.class);
    	    					
    	    					startActivity(intent); 
	                    		
	                    	}
	                    	session.checkLogin();
       			         
       					 HashMap<String, String> user = session.getUserDetails();
	                    	 url2 = "http://teknoem.com/bestebes/ticketkaydet.aspx?jokersil=true&kullaniciid="+ user.get(SessionManager.KEY_uyeid)+"&jokersayisi="+donenjokersayisi+"";
				        		new JSONParse2().execute();
	                    }
	                }).setNegativeButton("Hayýr", null).show();
	    }
	
	 public void showGecisReklam() {
	     

	      if (gecisReklam.isLoaded()) {//Eðer reklam yüklenmiþse kontrol ediliyor
	    	  gecisReklam.show(); //Reklam yüklenmiþsse gösterilecek
	      } else {//reklam yüklenmemiþse
			  Toast.makeText(getApplicationContext(), "Reklam Gösterim Ýçin Hazýr Deðil.", Toast.LENGTH_LONG).show();
	      }
	 }
}
