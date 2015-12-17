package com.teknoem.bestebes;



import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.teknoem.bestebe.R;
import com.teknoem.bestebes.Profil.DownloadImagesTask;






import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Intent;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.app.ActionBar.LayoutParams;
import android.content.Context;

import android.content.DialogInterface;
import android.content.Intent;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.view.Menu;
import android.provider.Settings.Secure;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.Toast;
import android.view.View.OnClickListener;
@SuppressLint("NewApi")
public class Kayit3 extends Activity  implements OnClickListener  {
	private static final String TAG_kayit = "uye";
	private static final String TAG_deger = "deger";
	private static final String TAG_uyeid = "uyeid";
	 private static final String TAG_takimlistesi = "takimlistesi";
		private static final String TAG_takimid = "takimid";
		private static final String TAG_takimadi = "takimadi";
		private static final String TAG_takimresmi = "takimresmi";
		 String[] items=  new String[18];
		 String[] dizitakimid=  new String[18];
		 String[] dizitakimresmi=  new String[18];
	 ConnectivityManager cn;
	 NetworkInfo nf;
	JSONArray androidd = null;
	JSONArray android2 = null;
	String deger,url,uyeid,donenad,donensoyad,donenkullaniciadi,donensifre,donenmail;
	 private String secilenDeger="";
	    Context context =this;
	    ImageView mChart;
	     String android_id,takimresmi,takimadi,takimid,url2;
	     SessionManager session;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_kayit3);
		
	

		
		 android_id = Secure.getString(this.getContentResolver(),
	            Secure.ANDROID_ID);
		
		 Bundle ad=getIntent().getExtras();
		  donenad=ad.getString("ad");
		 
		 Bundle soyad=getIntent().getExtras();
		donensoyad=soyad.getString("soyad");
		 
		 Bundle kullaniciadi=getIntent().getExtras();
		donenkullaniciadi=kullaniciadi.getString("kullaniciadi");
		 
		 Bundle sifre=getIntent().getExtras();
		  donensifre=sifre.getString("sifre");
		 
		 Bundle mail=getIntent().getExtras();
		 donenmail=mail.getString("mail");
			
			url2 = "http://teknoem.com/bestebes/takimlistesi.aspx?takimlistesi=true";
			
  			 new JSONParse2().execute();
		 
		Button devam4=(Button)findViewById(R.id.devam4);	
		 
		devam4.setOnClickListener(new View.OnClickListener() {
	        	public void onClick(View v) {
	        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
	        	     nf=cn.getActiveNetworkInfo();
	        	     if(nf != null && nf.isConnected()==true )
	       		    {
if(secilenDeger.equals(""))
{
	Toast.makeText(getApplicationContext(),"Takým Seçmediniz", Toast.LENGTH_SHORT).show();
	}
else
{
	 url = "http://teknoem.com/bestebes/uyekaydet.aspx?uyekaydet=true&eposta="+donenmail+"&takimi="+secilenDeger+"&ad="+donenad+"&soyad="+donensoyad+"&kullaniciadi="+donenkullaniciadi+"&sifre="+donensifre+"&androidid="+android_id+"";
		new JSONParse().execute();
		

}
	       		 }
	        		 else
	           		    {
	        			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
	        		    	startActivity(intent);         		    	
	           		    }
	        		
	        	}
			});
		
         
		mChart = (ImageView) findViewById(R.id.takimsecres);
        
        	
       
      
	}

	private class JSONParse extends AsyncTask<String, String, JSONObject> {
	   	 private ProgressDialog pDialog;
	   	@Override
	       protected void onPreExecute() {
	           super.onPreExecute();
	         
	           pDialog = new ProgressDialog(Kayit3.this);
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
	   				androidd = json.getJSONArray(TAG_kayit);
	   				
	   				JSONObject c = androidd.getJSONObject(0);
	   				
	   				// Storing  JSON item in a Variable
	   				 deger = c.getString(TAG_deger);
	   				uyeid=c.getString(TAG_uyeid);
	   				 if(deger.equals("true"))
	   				 {
	   					
	   					NotificationManager bildirimYoneticisi = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
	   			    	
	   			    	Notification bildirim =	new Notification.Builder(getApplicationContext()).
	   			    							setTicker("Bildirim var!").
	   			    							setContentTitle("5TE5 Kayýt").
	   			    							setContentText("Kayýt Olduðunuz Ýçin Teþekkürler").
	   			    							setContentIntent(PendingIntent.getActivity(getApplicationContext(), 0, new Intent(getApplicationContext(), MainActivity.class), 0)).
	   			    							setSmallIcon(R.drawable.logo).
	   			    							setAutoCancel(true).
	   			    							getNotification();
	   			    	
	   			    	bildirimYoneticisi.notify("bildirim_yeni", 0, bildirim);
	   					Intent intent = new Intent(getApplicationContext(), Anasayfa.class);
    					
    					startActivity(intent); 
    					
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
          
            pDialog = new ProgressDialog(Kayit3.this);
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
	    				android2 = json.getJSONArray(TAG_takimlistesi);
	    				for(int i = 0; i < android2.length(); i++){
	    				JSONObject c = android2.getJSONObject(i);
	    				
	    				// Storing  JSON item in a Variable
	    				 takimid = c.getString(TAG_takimid);
	    				 takimadi = c.getString(TAG_takimadi);
	    				 takimresmi = c.getString(TAG_takimresmi);
	    				
	    				 items[i]=takimadi; 
	    				 dizitakimid[i]=takimid;
	    				 dizitakimresmi[i]=takimresmi;
	    				}
	    				
	    				mChart.setOnClickListener(new View.OnClickListener() {
	    		        	public void onClick(View v) {
	    		        	
	    		        	

	    		                AlertDialog.Builder builder = new AlertDialog.Builder(context);
	    		                builder.setTitle("Bir Takým Seç");
	    		                builder.setSingleChoiceItems(items, -1, new DialogInterface.OnClickListener() {
	    		                    public void onClick(DialogInterface dialog, int item) {
	    		                    	secilenDeger= dizitakimid[item];
	    		                    	
	    		                    	mChart.setTag(dizitakimresmi[item]);
	    		        				new DownloadImagesTask().execute(dizitakimresmi[item]);
	    		                    			 
	    		                    		
	    		                    	}
	    		                    	
	    		                    	
	    		                    	
	    		                    
	    		                        
	    		                    
	    		                });
	    		                builder.setPositiveButton("Tamam", new DialogInterface.OnClickListener() {
	    		           		 public void onClick(DialogInterface dialog, int whichButton) {
	    		           			
	    		           				
	    		           			
	    		           			 
	    		           		   }
	    		           		  });
	    		           		 

	    		                builder.setNegativeButton(android.R.string.cancel,new DialogInterface.OnClickListener() {
	    		           		 public void onClick(DialogInterface dialog, int whichButton) {
	    		           		   
	    		           		     }
	    		           		    });
	    		              
	    		                
	    		                AlertDialog alert = builder.create();
	    		                
	    		               
	    		      		 alert.show();
	    		        		
	    		        	}
	    				});
	    				
	    				 

	    				
	    				
	    				
	    		} catch (JSONException e) {
	    			e.printStackTrace();
	    		}

	    		 
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
	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		
	}
	
}
