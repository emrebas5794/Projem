package com.teknoem.bestebes;

import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.rekmob.ads.RekmobInterstitial;
import com.rekmob.ads.RekmobView;

import com.rekmob.ads.RekmobView;
import com.rekmob.ads.RekmobInterstitial.RekmobInterstitialAdListener;
import com.teknoem.bestebe.R;
import com.teknoem.bestebes.Dogru.JSONParse2;

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
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;

public class Yanlis extends Activity  {
	Button tekrardene,sorupaylas,yanlisresim;
	String donensoruid,donendogrucevap,donenjokersayisi,donensorusayisi,deger2,url2;
	 
	
		JSONArray androiddd = null;
		private static final String TAG_jokersil = "jokersil";
		private static final String TAG_deger2 = "deger2";
		static final String REKMOB_AD_UNIT_ID = "43a33bce617e467cad32c6c3d909c254";
		 RekmobInterstitial rekmobInterstitial;
			static final String INTERSTITIAL_AD_UNIT_ID = "f166417eb71d4da1af999ee9da93ad1b";

			static final String TAG = "InterstitialActivity";
		RekmobView rekmobView;
		SessionManager session;
	 ConnectivityManager cn;
	 NetworkInfo nf;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_yanlis);
		
		
		
		
	rekmobView = (RekmobView) findViewById(R.id.rekmobAdView);
	
		rekmobView.setAdUnitId(REKMOB_AD_UNIT_ID);
		
		rekmobView.loadAd();
		
		session = new SessionManager(getApplicationContext());
		
		Bundle soruid=getIntent().getExtras();
		 donensoruid=soruid.getString("soruid");
		 Bundle jokersayisi=getIntent().getExtras();
			donenjokersayisi=jokersayisi.getString("gidenjokersayisi");
			Bundle sorusayisi=getIntent().getExtras();
			 donensorusayisi=sorusayisi.getString("sorusayisi");
			
		 Bundle dogrucevap=getIntent().getExtras();
		 donendogrucevap=dogrucevap.getString("dogrucevap");
		 
		 yanlisresim=(Button)findViewById(R.id.yanlisresim);
		 
		 yanlisresim.setText("Dogru Cevap:"+donendogrucevap);
		 
		tekrardene=(Button)findViewById(R.id.tekrardene);
		tekrardene.setOnClickListener(new View.OnClickListener() {
        	public void onClick(View v) {
        		tekrardene.setBackgroundColor(Color.RED);
        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
        	     nf=cn.getActiveNetworkInfo();
        		if(nf != null && nf.isConnected()==true )
    		    {
        			final Bundle bundle=new Bundle();
					
					Intent intent = new Intent(getApplicationContext(), Soru1.class);
					bundle.putString("gidenjokersayisi",donenjokersayisi);
					bundle.putString("sorusayisi",donensorusayisi);
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
				bundle.putString("sorusayisi",donensorusayisi);
				bundle.putString("gidenjokersayisi",donenjokersayisi);
				bundle.putString("sayfatipi","yanlis");
				bundle.putString("dogrucevap",donendogrucevap);
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
     			 pDialog = new ProgressDialog(Yanlis.this);
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
                    	
                    	session.checkLogin();
      			         
      					 HashMap<String, String> user = session.getUserDetails();
	                    	 url2 = "http://teknoem.com/bestebes/sayiekle.aspx?jokersil=true&kullaniciid="+ user.get(SessionManager.KEY_uyeid)+"&jokersayisi="+donenjokersayisi+"&tokenid="+user.get(SessionManager.KEY_tokenid)+"";
				        		new JSONParse2().execute();
                    	Intent intent = new Intent(getApplicationContext(), MainActivity.class);
    					
    					startActivity(intent); 
                    }
                }).setNegativeButton("Hayýr", null).show();
    }
	

	
	protected void onDestroy() {
		
		if (rekmobView != null) {
			rekmobView.destroy();
		}
		super.onDestroy();
	}



	
}
	
