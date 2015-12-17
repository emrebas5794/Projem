package com.teknoem.bestebes;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.teknoem.bestebe.R;
import com.teknoem.bestebes.MainActivity.DownloadImagesTask;
import com.teknoem.bestebes.Soru1.CountDownExample;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;
import android.widget.Toast;

public class Profil extends Activity {
	SessionManager session;
	 ImageView takimlogodegistir;
	 CountDownTimer countDownExample;
	 private static final String TAG_toplam = "toplam";
		private static final String TAG_sirasi = "sirasi";
		private static final String TAG_kullaniciadi = "kullaniciadi";
		private static final String TAG_sayi = "sayi";
		 private static final String TAG_toplam2 = "toplam";
		 private static final String TAG_toplamsayi = "toplamticket";
		JSONArray androidd = null;
		JSONArray android2 = null;
		ListView list;
		 String url,url2;
		 ConnectivityManager cn;
		 NetworkInfo nf;
		 String ad,soyad,sayi,kullaniciadi,toplamsayi,email,donenresimyol;
		 Button btnadsoyad,btnemail,btnkullaniciadi,kullanicisoru;
		 HashMap<String, String> user;
		 TextView btnbuhafta,btntoplam;
		 int syc=0;
		 ImageView mChart;
		
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_profil);
		
		
		
		Bundle resimyol=getIntent().getExtras();
		 donenresimyol=resimyol.getString("resimyol");
		  
			
		 
		
		 
			
		
		session = new SessionManager(getApplicationContext());
		  user = session.getUserDetails();
	
		 session.checkLogin();
		 takimlogodegistir=(ImageView)findViewById(R.id.profilimageView11);
		
		 mChart =(ImageView)findViewById(R.id.profilimageView11);	
			 btnadsoyad=(Button)findViewById(R.id.pprofilbutton3);
			 btntoplam=(TextView)findViewById(R.id.toplamtextView5);
			 btnbuhafta=(TextView)findViewById(R.id.haftatextView2);
			 
			 
			 kullanicisoru=(Button)findViewById(R.id.profilbutton1);
			 kullanicisoru.setOnClickListener(new Button.OnClickListener(){

					@Override
					public void onClick(View arg0) {
						 final Bundle bundle=new Bundle();
						Intent intent = new Intent(getApplicationContext(), KullaniciSoru.class);
         				bundle.putString("kulllaniciid",user.get(SessionManager.KEY_uyeid));
	        			
						intent.putExtras(bundle);
         					startActivity(intent); 
						
						
					}});
				
			 btnadsoyad.setOnClickListener(new Button.OnClickListener(){

					@Override
					public void onClick(View arg0) {
						 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
		        	     nf=cn.getActiveNetworkInfo();
		        	     if(nf != null && nf.isConnected()==true )
		       		    {
		        	    	 final Bundle bundle=new Bundle();
		         				Intent intent = new Intent(getApplicationContext(), Bilgiler.class);
		         				bundle.putString("resimyol",donenresimyol);
			        			
								intent.putExtras(bundle);
		         					startActivity(intent); 
						
		       		 }
		        		 else
		           		    {
		        			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
		        		    	startActivity(intent);         		    	
		           		    }
					
					}});
			
			
			String adsoyad,takim;
			takim=user.get(SessionManager.KEY_takimi);
			adsoyad=user.get(SessionManager.KEY_NAME)+" "+user.get(SessionManager.KEY_soyad);
			kullaniciadi=user.get(SessionManager.KEY_kullaniciadi);
			email=user.get(SessionManager.KEY_EMAIL);
			
			btnadsoyad.setText(adsoyad.toUpperCase()+"      |       Düzenle");
			 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
    	     nf=cn.getActiveNetworkInfo();
    	     if(nf != null && nf.isConnected()==true )
   		    {
    	    	
    	    	 mChart.setTag(donenresimyol);
 				new DownloadImagesTask().execute(donenresimyol);
 		
 		 
 			  url = "http://teknoem.com/bestebes/toplamticket.aspx?toplamticket=true&kullaniciadi="+user.get(SessionManager.KEY_kullaniciadi)+"";
 			
 			 new JSONParse().execute();
 			 
 			 url2 = "http://teknoem.com/bestebes/toplamticket.aspx?toplamticketsayisi=true&kullaniciid="+user.get(SessionManager.KEY_uyeid)+"";
 				
 			 new JSONParse2().execute();
			
   		 }
    		 else
       		    {
    			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
    		    	startActivity(intent);         		    	
       		    }
			
				
			
		}
	public class DownloadImagesTask extends AsyncTask<String, Void, Bitmap> {

		@Override
		protected Bitmap doInBackground(String... urls) {
		    return download_Image(urls[0]);
		}

		@Override
		protected void onPostExecute(Bitmap result) {
		    mChart.setImageBitmap(result);              // how do I pass a reference to mChart here ?
		}
		

		private Bitmap download_Image(String url) {
		    //---------------------------------------------------
		    Bitmap bm = null;
		    try {
		        URL aURL = new URL(url);
		        URLConnection conn = aURL.openConnection();
		        conn.connect();
		        InputStream is = conn.getInputStream();
		        BufferedInputStream bis = new BufferedInputStream(is);
		        bm = BitmapFactory.decodeStream(bis);
		        bis.close();
		        is.close();
		    } catch (IOException e) {
		        Log.e("Hub","Error getting the image from server : " + e.getMessage().toString());
		    } 
		    return bm;
		    //---------------------------------------------------
		}


		}
	public class CountDownExample extends CountDownTimer{

		public CountDownExample(long millisInFuture, long countDownInterval) {
		super(millisInFuture, countDownInterval);
		}

		@Override
		public void onTick(long millisUntilFinished) {

	
		}

		@Override
		public void onFinish() {
			Intent intent = new Intent(getApplicationContext(), MainActivity.class);
			
			startActivity(intent); 
		
		}
		}
		
		 private class JSONParse extends AsyncTask<String, String, JSONObject> {
	    	 private ProgressDialog pDialog;
	    	@Override
	        protected void onPreExecute() {
	            super.onPreExecute();
	          
	            pDialog = new ProgressDialog(Profil.this);
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
	    				androidd = json.getJSONArray(TAG_toplam);
	    				for(int i = 0; i < androidd.length(); i++){
	    				JSONObject c = androidd.getJSONObject(i);
	    				
	    				// Storing  JSON item in a Variable
	    				 ad = c.getString(TAG_sirasi);
	    				 soyad = c.getString(TAG_kullaniciadi);
	    				 sayi = c.getString(TAG_sayi);
	    				 
	    				if(kullaniciadi.equals(soyad))
	    				{
	    					
	    					btnbuhafta.setText(sayi);
	    				 break;
	    				}
	    				else
	    				{
	    					
	    					
	    				}

	    				
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
	          
	            pDialog = new ProgressDialog(Profil.this);
	            pDialog.setMessage("Yükleniyorr ...");
	            pDialog.setIndeterminate(false);
	            pDialog.setCancelable(true);
	            pDialog.show();
	            
	             
	            
	    	}
	    	
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
		    				android2 = json.getJSONArray(TAG_toplam2);
		    				for(int i = 0; i < android2.length(); i++){
		    				JSONObject c = android2.getJSONObject(i);
		    				
		    				// Storing  JSON item in a Variable
		    				 toplamsayi = c.getString(TAG_toplamsayi);
		
		    				
		    				 btntoplam.setText(toplamsayi);

		    				
		    				}	
		    				
		    		} catch (JSONException e) {
		    			e.printStackTrace();
		    		}

		    		 
		    	 }
		}
		 public void onBackPressed() {
		       
		                    	  
		                    	  Intent intent = new Intent(getApplicationContext(), MainActivity.class);
		              			
		              			startActivity(intent); 
	                          
		                 
		    }
	}
		
		
		

