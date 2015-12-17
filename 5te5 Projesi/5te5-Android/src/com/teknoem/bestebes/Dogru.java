package com.teknoem.bestebes;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SignatureException;
import java.util.Formatter;
import java.util.HashMap;
import com.rekmob.ads.RekmobInterstitial;
import com.rekmob.ads.RekmobInterstitial.RekmobInterstitialAdListener;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


import com.google.android.gms.ads.*;


import com.teknoem.bestebe.R;
import com.teknoem.bestebe.Reklamizlet;
import com.teknoem.bestebes.Soru5.CountDownExample;




import android.R.integer;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.graphics.Color;
import android.media.MediaPlayer;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.renderscript.Sampler.Value;

import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

public  class Dogru extends Activity implements RekmobInterstitialAdListener {
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
	String url,url2,donenjokerlimit,url3,deger,deger2,deger3,donensorusayisi,donensoruid,donenjokersayisi;
	SessionManager session;
	
	 ConnectivityManager cn;
	 NetworkInfo nf;
	 Button jokerkazan;
	
	 RekmobInterstitial rekmobInterstitial;
		static final String INTERSTITIAL_AD_UNIT_ID = "f166417eb71d4da1af999ee9da93ad1b";

		static final String TAG = "InterstitialActivity";
		
	@Override
	
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView( R.layout.activity_dogru );
		donenjokerlimit="0";
		rekmobInterstitial = new RekmobInterstitial(this,
				INTERSTITIAL_AD_UNIT_ID);

		
		rekmobInterstitial.setInterstitialAdListener(this);

		
		
		
		
		session = new SessionManager(getApplicationContext());
		
		Bundle soruid=getIntent().getExtras();
		
		 donensoruid=soruid.getString("soruid");
			Bundle sorusayisi=getIntent().getExtras();
			 donensorusayisi=sorusayisi.getString("sorusayisi");
		 Bundle jokersayisi=getIntent().getExtras();
			donenjokersayisi=jokersayisi.getString("gidenjokersayisi");
			
			
		ticketsayisi=(Button)findViewById(R.id.ticketsayisi);
		sorupaylas=(Button)findViewById(R.id.facepaylas);
		jokerkazan=(Button)findViewById(R.id.jokerkazan);
		jokerkazan.setVisibility(View.INVISIBLE);
		
		jokerkazan.setOnClickListener(new View.OnClickListener() {
        	public void onClick(View v) {
		
        		final Bundle bundle=new Bundle();
        			Intent intent = new Intent(getApplicationContext(), Reklamizlet.class);	
        			bundle.putString("soruid",donensoruid);
        			bundle.putString("gidenjokersayisi",donenjokersayisi);
        			bundle.putString("sorusayisi",donensorusayisi);
        			bundle.putString("sayfatipi","dogru");
        			
        			intent.putExtras(bundle);
        			startActivity(intent); 
     		    	
        		
        	}
		});
		
		
		
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
		
		
		
		 
		 
		    		 
		    		/*  session.checkLogin();
				         
						 HashMap<String, String> user = session.getUserDetails();
		    		  url3 = "http://teknoem.com/bestebes/sayiekle.aspx?jokerekle=true&kullaniciid="+ user.get(SessionManager.KEY_uyeid)+"&tokenid="+user.get(SessionManager.KEY_tokenid)+"";
		        		new JSONParse3().execute();
		        		int sayi=Integer.valueOf(donenjokersayisi)+1;
		        		donenjokersayisi=String.valueOf(sayi);
		        		 jokerkazan.setText("Tebrikler 1 Joker Kazandýnýz.." );*/
		    		  
		    	
		    	 
		btnsonraki=(Button)findViewById(R.id.btnsonraki1);
	
		
		btnsonraki.setOnClickListener(new View.OnClickListener() {
        	public void onClick(View v) {
        		 session.checkLogin();
		         
				 HashMap<String, String> user = session.getUserDetails();
        		btnsonraki.setBackgroundColor(Color.RED);
        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
        	     nf=cn.getActiveNetworkInfo();
        		 if(nf != null && nf.isConnected()==true )
       		    {
        		url2 = "http://teknoem.com/bestebes/sayiekle.aspx?jokersil=true&kullaniciid="+ user.get(SessionManager.KEY_uyeid)+"&jokersayisi="+donenjokersayisi+"&tokenid="+user.get(SessionManager.KEY_tokenid)+"";
        		new JSONParse2().execute();
        		
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
					
					
						
					
					 
						 
						 url = "http://teknoem.com/bestebes/sayiekle.aspx?ticketekle=true&kullaniciid="+ user.get(SessionManager.KEY_uyeid)+"&tokenid="+user.get(SessionManager.KEY_tokenid)+"";
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
			btnsonraki.setEnabled(false);
			btnsonraki.setText("Bekleyin");
			rekmobInterstitial.load();
		}
		if(donensorusayisi.equals("4"))
		{
			
			ticketsayisi.setText("        5te5 için son 1 soru!" );
		}
		if(donensorusayisi.equals("5"))
		{
			 Bundle jokerlimit=getIntent().getExtras();
				donenjokerlimit=jokersayisi.getString("jokerlimit");
		 
			//MediaPlayer sesVerisi=MediaPlayer.create(Dogru.this,R.raw.sesefek);
			 //sesVerisi.start();
			if(donenjokerlimit.equals("0"))
			{
			
				jokerkazan.setVisibility(View.VISIBLE);
			}
			if(donenjokerlimit.equals("1"))
			{
			
				jokerkazan.setVisibility(View.INVISIBLE);
			}
			
			ticketsayisi.setText("        Tebrikler 5te5  Yaptýnýz." );
			btnsonraki.setText("Tekrar Oyna");
			
		}
		
		
	}
	
	
	
	 private class JSONParse extends AsyncTask<String, String, JSONObject> {
    	 private ProgressDialog pDialog;
    	@Override
        protected void onPreExecute() {
            super.onPreExecute();
          
          
            
            cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
    	     nf=cn.getActiveNetworkInfo();
    		 if(nf != null && nf.isConnected()==true )
  		    {  
    			 pDialog = new ProgressDialog(Dogru.this);
            pDialog.setMessage("Yükleniyor...");
            pDialog.setIndeterminate(false);
            pDialog.setCancelable(false);
            pDialog.show();
            
             
  		    }
  		 else
     		    {
  			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
  		    	startActivity(intent);         		    	
     		    }
            
            
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
	 public class JSONParse2 extends AsyncTask<String, String, JSONObject> {
    	 private ProgressDialog pDialog;
    	@Override
        protected void onPreExecute() {
            super.onPreExecute();
          
          
            cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
   	     nf=cn.getActiveNetworkInfo();
   		 if(nf != null && nf.isConnected()==true )
 		    {  
   		  pDialog = new ProgressDialog(Dogru.this);
          pDialog.setMessage("Yükleniyor...");
          pDialog.setIndeterminate(false);
          pDialog.setCancelable(false);
          pDialog.show();
           
            
 		    }
 		 else
    		    {
 			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
 		    	startActivity(intent);         		    	
    		    }
             
            
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
	


	 public void onBackPressed() {
	        new AlertDialog.Builder(this).setIcon(android.R.drawable.ic_dialog_alert).setTitle("Exit")
	                .setMessage("Anasayfa'ya Gitmek Mi Ýstiyorsunuz ?")
	                .setPositiveButton("Evet", new DialogInterface.OnClickListener() {
	                    @Override
	                    public void onClick(DialogInterface dialog, int which) {
	                    	if(donensorusayisi.equals("5"))
	        				{
	        					
	        					 session.checkLogin();
	        			         
	        					 HashMap<String, String> user = session.getUserDetails();
	        					 
	        					
	        						 url = "http://teknoem.com/bestebes/sayiekle.aspx?ticketekle=true&kullaniciid="+ user.get(SessionManager.KEY_uyeid)+"&tokenid="+user.get(SessionManager.KEY_tokenid)+"";
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
	                    	 url2 = "http://teknoem.com/bestebes/sayiekle.aspx?jokersil=true&kullaniciid="+ user.get(SessionManager.KEY_uyeid)+"&jokersayisi="+donenjokersayisi+"&tokenid="+user.get(SessionManager.KEY_tokenid)+"";
				        		new JSONParse2().execute();
	                    }
	                }).setNegativeButton("Hayýr", null).show();
	    }
	
		protected void onDestroy() {
			/*
			 * when activity is destroyed, we destroys RekmobInterstitial instance to deactivate of its internal broadcast receivers.
			 * Thus we cancel new ad requests.  
			 */
			if (rekmobInterstitial != null) {
				rekmobInterstitial.destroy();
			}
			super.onDestroy();
		}

		/*
		 * when ad is clicked, onInterstitialClicked method of an
		 * RekmobInterstitialAdListener instance is fired by Rekmob-SDK
		 */
		@Override
		public void onInterstitialClicked(RekmobInterstitial arg0) {
			btnsonraki.setEnabled(true);
			btnsonraki.setText("Sonraki Soru");
		}

		/*
		 * when ad is dismissed, onInterstitialDismissed method of an
		 * RekmobInterstitialAdListener instance is fired by Rekmob-SDK
		 */
		@Override
		public void onInterstitialDismissed(RekmobInterstitial arg0) {
			btnsonraki.setEnabled(true);
			btnsonraki.setText("Sonraki Soru");
		}

		/*
		 * In case of fail on loading or showing of ad, onInterstitialFailed method
		 * of an RekmobInterstitialAdListener instance is fired by Rekmob-SDK and a
		 * message about failing is passed to method.
		 */
		@Override
		public void onInterstitialFailed(RekmobInterstitial arg0, String error) {
			Log.e(TAG, error);
			btnsonraki.setEnabled(true);
			btnsonraki.setText("Sonraki Soru");
		}

		/*
		 * When ad loaded , onInterstitialLoaded method is fired. If ad is ready to
		 * show, it can be invoked "show" method of RekmobInterstitial instance.
		 */
		@Override
		public void onInterstitialLoaded(RekmobInterstitial arg0) {
			if (rekmobInterstitial.isReady()) {
				rekmobInterstitial.show();
			} else {

			}
		}

		@Override
		public void onInterstitialShown(RekmobInterstitial arg0) {

		}


}
