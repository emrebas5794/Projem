package com.teknoem.bestebes;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
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
import android.content.DialogInterface.OnClickListener;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.Bitmap.CompressFormat;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.os.Environment;
import android.provider.Settings.Secure;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity {
	 private static final String TAG_takimresmi = "takimresmi";
		private static final String TAG_takimresim = "takimresim";
		private static final String TAG_jokersayisi = "jokersayisi";
		private static final String TAG_rjokersayisi = "rjokersayisi";
		JSONArray androidd = null;
		JSONArray androiddd = null;
	SessionManager session;
	ImageView anasayfatakimlogo;
	Button oyunabasla,profil,puandurum,cikis,btnurunler;
	String uyeid,DEFAULT_APP_ID,DEFAULT_SENDER_ID,DEFAULT_SECRET_KEY;
	 CountDownTimer countDownExample;
	 int sayac=0;
	  String android_id,resim,url,jokersayisi,url2;
	  private static final String LOG_TAG = "Otomatik internet Kontrolü";
	  private Networkkontrol receiver;//Network dinleyen receiver objemizin referansý
	  IntentFilter filter;
	 String donenjokersayisi;
	  ImageView mChart;
	  ConnectivityManager cn;
		 NetworkInfo nf;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		try {
			
			 filter = new IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION);
  			  receiver = new Networkkontrol();
  			  registerReceiver(receiver, filter);
			  
  			
  			
  			mChart =(ImageView)findViewById(R.id.anasayfatakimlogo);	
		  session = new SessionManager(getApplicationContext());
		  
		  oyunabasla=(Button)findViewById(R.id.oyunabasla);	
		  profil=(Button)findViewById(R.id.btnprofil);	
		  puandurum=(Button)findViewById(R.id.btnpuandurum);	
		  cikis=(Button)findViewById(R.id.btncikis);
		  btnurunler=(Button)findViewById(R.id.btnurunler);
	
		  

		    
		session.checkLogin();
		 
			 
		if(session.isLoggedIn()==true)
		{
			
			 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
    	     nf=cn.getActiveNetworkInfo();
    		 if(nf != null && nf.isConnected()==true )
 		    {
   			  
    			 HashMap<String, String> user = session.getUserDetails();
    		       
    		        uyeid=user.get(SessionManager.KEY_uyeid);
    		        
    		        url = "http://teknoem.com/bestebes/takimlistesi.aspx?takimresim=true&kullaniciid="+uyeid+"";
    				
    				 new JSONParse().execute();
    				
 		    }
    		 else
       		    {
    			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
    		    	startActivity(intent);         		    	
       		    } 
	        // get user data from session
	       
				
			
		}
		else
		    {
		 	Intent intent = new Intent(getApplicationContext(), Anasayfa.class);	
	    	startActivity(intent);         		    	
		    }
			 
			
				
		
		
		
		oyunabasla.setOnClickListener(new View.OnClickListener() {
        	public void onClick(View v) {
        		oyunabasla.setBackgroundColor(Color.RED);
        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
        	     nf=cn.getActiveNetworkInfo();
        		 if(nf != null && nf.isConnected()==true )
     		    {
        			 url2 = "http://teknoem.com/bestebes/ticketkaydet.aspx?jokersayisi=true&kullaniciid="+uyeid+"";
     				
    				 new JSONParse2().execute();
    				
    				
     		    }
        		 else
           		    {
        			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
        		    	startActivity(intent);         		    	
           		    }
   
				
				
        	}
		});
		

		

		

puandurum.setOnClickListener(new View.OnClickListener() {
        	public void onClick(View v) {
        		puandurum.setBackgroundColor(Color.RED);
        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
        	     nf=cn.getActiveNetworkInfo();
        		 if(nf != null && nf.isConnected()==true )
      		    {
        			  
         				Intent intent = new Intent(getApplicationContext(), PuanSiralamasi.class);
         					startActivity(intent); 
      		    }
         		 else
            		    {
         			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
         		    	startActivity(intent);         		    	
            		    }
				
        	}
		});
		
		cikis.setOnClickListener(new View.OnClickListener() {
        	public void onClick(View v) {
        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
        	     nf=cn.getActiveNetworkInfo();
        		 if(nf != null && nf.isConnected()==true )
      		    {
        			  
        			 cikis.setBackgroundColor(Color.RED);
             		session.logoutUser();
      		    }
         		 else
            		    {
         			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
         		    	startActivity(intent);         		    	
            		    }
        		
        		
        	}
		});
		
		btnurunler.setOnClickListener(new View.OnClickListener() {
        	public void onClick(View v) {
        		btnurunler.setBackgroundColor(Color.RED);
        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
        	     nf=cn.getActiveNetworkInfo();
        		 if(nf != null && nf.isConnected()==true )
      		    {
        			  
         				Intent intent = new Intent(getApplicationContext(), Oduller.class);
         					startActivity(intent); 
      		    }
         		 else
            		    {
         			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
         		    	startActivity(intent);         		    	
            		    }
				
        	}
		});
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	private class JSONParse extends AsyncTask<String, String, JSONObject> {
   	 private ProgressDialog pDialog;
   	@Override
       protected void onPreExecute() {
           super.onPreExecute();
         
           pDialog = new ProgressDialog(MainActivity.this);
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
   				androidd = json.getJSONArray(TAG_takimresmi);
   				
   				JSONObject c = androidd.getJSONObject(0);
   				
   				// Storing  JSON item in a Variable
   				 resim = c.getString(TAG_takimresim);
   				
   				mChart.setTag(resim);
				new DownloadImagesTask().execute(resim);
		
				
				profil.setOnClickListener(new View.OnClickListener() {
		        	public void onClick(View v) {
		        		profil.setBackgroundColor(Color.RED);
		        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
		        	     nf=cn.getActiveNetworkInfo();
		        		 if(nf != null && nf.isConnected()==true )
		      		    {
		        			 final Bundle bundle=new Bundle();
		         				Intent intent = new Intent(getApplicationContext(), Profil.class);
		         				bundle.putString("resimyol",resim);
			        			
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
          
            pDialog = new ProgressDialog(MainActivity.this);
            pDialog.setMessage("Joker Sayýnýz Getiriliyor.");
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
    				androiddd = json.getJSONArray(TAG_rjokersayisi);
    				
    				JSONObject c = androiddd.getJSONObject(0);
    				
    				// Storing  JSON item in a Variable
    				 jokersayisi = c.getString(TAG_jokersayisi);
    				
    				 final Bundle bundle=new Bundle();
     				Intent intent = new Intent(getApplicationContext(), Soru1.class);
     				bundle.putString("gidenjokersayisi",jokersayisi);
 					intent.putExtras(bundle);
     				startActivity(intent); 
    				
    				
    		} catch (JSONException e) {
    			e.printStackTrace();
    		}

    		 
    	 }
    	 
    	 
    	 
    	 
    	 
}
	
	
	 protected void onDestroy() { //Activity Kapatýldýðý zaman receiver durduralacak.Uygulama arka plana alýndýðý zamanda receiver çalýþmaya devam eder
		  Log.v(LOG_TAG, "onDestory");
		  super.onDestroy();
		   
		  unregisterReceiver(receiver);//receiver durduruluyor
		 
		 }
	
	 public void onBackPressed() {
	        new AlertDialog.Builder(this).setIcon(android.R.drawable.ic_dialog_alert).setTitle("Exit")
	                .setMessage("Uygulamayý Kapatmak Mý Ýstiyorsun?")
	                .setPositiveButton("Evet", new DialogInterface.OnClickListener() {
	                    @Override
	                    public void onClick(DialogInterface dialog, int which) {
	                    	  moveTaskToBack(true);
	                    	  finish();
	                    	  Intent intent = new Intent(getApplicationContext(), MainActivity.class);
	              			
	              			startActivity(intent); 
                             
	                    }
	                }).setNegativeButton("Hayýr", null).show();
	    }
	  
}

