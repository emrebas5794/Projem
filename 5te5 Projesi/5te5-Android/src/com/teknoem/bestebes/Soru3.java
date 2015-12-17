package com.teknoem.bestebes;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.os.StrictMode;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.InterstitialAd;
import com.teknoem.bestebe.*;
import com.teknoem.bestebes.Soru2.CountDownExample;
public class Soru3 extends Activity {
	 private InterstitialAd gecisReklam;
		Button btnsorureklam;
		 AdRequest adRequest;
	ListView sorulist1;
	Button btsoru,btncevapa,btncevapb,btncevapc,btncevapd;
	TextView sure;
	 int jokersayi=-1;
	 ConnectivityManager cn;
	 NetworkInfo nf;
	ArrayList<HashMap<String, String>> oslist = new ArrayList<HashMap<String, String>>();
	
	private static String url;
	private static final String TAG_sorular = "sorular";
	private static final String TAG_id = "soruid";
	private static final String TAG_soru = "soru";
	private static final String TAG_cevapa = "cevapa";
	private static final String TAG_cevapb = "cevapb";
	private static final String TAG_cevapc = "cevapc";
	private static final String TAG_cevapd = "cevapd";
	private static final String TAG_dogrucevap = "dogrucevap";
	JSONArray android = null;
	 int suree=15;
	 
	 Button btnjokersayisi;
	String soru,cevapa,cevapb,cevapc,cevapd,dogrucevap,soruid,donenjokersayisi;
	
	 CountDownTimer countDownExample;
	 SessionManager session;
	 ImageView sureresim;
	
	protected void onCreate(Bundle savedInstanceState) {
		StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy); 
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_soru3);
       
session = new SessionManager(getApplicationContext());
		
		session.checkLogin();
        
		 HashMap<String, String> user = session.getUserDetails();	
	url = "http://teknoem.com/bestebes/soru3.aspx?GuncelSorular=true&kullaniciid="+user.get(SessionManager.KEY_uyeid)+"";
	
		
		
		sure=(TextView)findViewById(R.id.sure3);
		Bundle jokersayisi=getIntent().getExtras();
		donenjokersayisi=jokersayisi.getString("gidenjokersayisi");
		
		
		sureresim=(ImageView)findViewById(R.id.sureresim3);
		 oslist = new ArrayList<HashMap<String, String>>();
		  btsoru=(Button)findViewById(R.id.btsoru3);
	   		
		 new JSONParse().execute();
		
		 btncevapa=(Button)findViewById(R.id.cevapa3);	
   		 btncevapb=(Button)findViewById(R.id.cevapb3);	
   		 btncevapc=(Button)findViewById(R.id.cevapc3);	
   		 btncevapd=(Button)findViewById(R.id.cevapd3);	
   		 btnjokersayisi=(Button)findViewById(R.id.jokersayisi);
		  btnjokersayisi.setText("Joker Sayýsý "+donenjokersayisi);
   		 btnsorureklam=(Button)findViewById(R.id.btnsorureklam);
		
		  btnsorureklam.setOnClickListener(new View.OnClickListener() {
	        	public void onClick(View v) {
	        		
	        		if(jokersayi==0 || donenjokersayisi.equals("0"))
	        		{
	        			
	        			Toast.makeText(getApplicationContext(), "Yeterli Joker Hakkýnýz Yok.",3000).show();
	        		}
	        		else
	        		{
	        		if(cevapa.equals(dogrucevap))
	        		{
	        			btncevapa.setBackgroundColor(Color.RED);
	        		}
	        		if(cevapb.equals(dogrucevap))
	        		{
	        			btncevapb.setBackgroundColor(Color.RED);
	        		}
	        		if(cevapc.equals(dogrucevap))
	        		{
	        			btncevapc.setBackgroundColor(Color.RED);
	        		}
	        		if(cevapd.equals(dogrucevap))
	        		{
	        			btncevapd.setBackgroundColor(Color.RED);
	        		}
	        		
	        		
	        			 jokersayi= Integer.valueOf(donenjokersayisi)-1;
		        		  btnjokersayisi.setText("Joker Sayýsý "+jokersayi);
	        		}
	        		
	        		
	        		
	        	}
			});
		 
		 
	        
	       
  		
		
		
	}
	public class CountDownExample extends CountDownTimer{

		public CountDownExample(long millisInFuture, long countDownInterval) {
		super(millisInFuture, countDownInterval);
		}

		@Override
		public void onTick(long millisUntilFinished) {

			if(millisUntilFinished/1000<10)
			{
				sure.setText("0" + millisUntilFinished/1000);
			}
			else
			{
				sure.setText("" + millisUntilFinished/1000);
			}

	
		
			if(millisUntilFinished/1000==15)
			{
				suree=15;
				sureresim.setImageResource(R.drawable.s16);
				
			}
			if(millisUntilFinished/1000==14)
			{
				suree=15;
				sureresim.setImageResource(R.drawable.s15);
			}
			if(millisUntilFinished/1000==13)
			{
				suree=14;
				sureresim.setImageResource(R.drawable.s14);
			}
			if(millisUntilFinished/1000==12)
			{
				suree=13;
				sureresim.setImageResource(R.drawable.s13);
				
			}
			if(millisUntilFinished/1000==11)
			{
				suree=12;
				sureresim.setImageResource(R.drawable.s12);
			}
			if(millisUntilFinished/1000==10)
			{
				suree=11;
			
				sureresim.setImageResource(R.drawable.s11);
			}
			if(millisUntilFinished/1000==9)
			{
				suree=10;
				sureresim.setImageResource(R.drawable.s10);
			}
			if(millisUntilFinished/1000==8)
			{
				suree=9;
				sureresim.setImageResource(R.drawable.s9);
			}
			if(millisUntilFinished/1000==7)
			{
				suree=8;
				sureresim.setImageResource(R.drawable.s8);
			}
			if(millisUntilFinished/1000==6)
			{
				suree=7;
				sureresim.setImageResource(R.drawable.s7);
			}
			if(millisUntilFinished/1000==5)
			{
				suree=6;
				sureresim.setImageResource(R.drawable.s6);
			}
			if(millisUntilFinished/1000==4)
			{
				suree=5;
				
				sureresim.setImageResource(R.drawable.s5);
			}
			if(millisUntilFinished/1000==3)
			{
				sureresim.setImageResource(R.drawable.s4);
			}
			if(millisUntilFinished/1000==2)
			{
				sureresim.setImageResource(R.drawable.s3);
			}
		if(millisUntilFinished/1000==1)
		{
			
			final Bundle bundle=new Bundle();
			countDownExample.cancel();
			Intent intent = new Intent(getApplicationContext(), Surenizdoldu.class);
		
			bundle.putString("soruid",soruid);
			bundle.putString("sorusayisi","3");
			if(jokersayi==-1)
			{
			bundle.putString("gidenjokersayisi",donenjokersayisi);
			}
			else
			{
				
				bundle.putString("gidenjokersayisi",String.valueOf(jokersayi));
			}
			intent.putExtras(bundle);
			startActivity(intent); 
		}
		}

		@Override
		public void onFinish() {
			
		
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
             pDialog = new ProgressDialog(Soru3.this);
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
    				android = json.getJSONArray(TAG_sorular);
    				
    				JSONObject c = android.getJSONObject(0);
    				
    				// Storing  JSON item in a Variable
    				soruid=c.getString(TAG_id);
    				 soru = c.getString(TAG_soru);
    				 cevapa = c.getString(TAG_cevapa);
    				 cevapb = c.getString(TAG_cevapb);
    				 cevapc = c.getString(TAG_cevapc);
    				 cevapd = c.getString(TAG_cevapd);
    				 dogrucevap = c.getString(TAG_dogrucevap);

    				
    				
    				btsoru.setText(soru);
    				btncevapa.setText(cevapa);
    				btncevapb.setText(cevapb);
    				btncevapc.setText(cevapc);
    				btncevapd.setText(cevapd);
    				countDownExample = new CountDownExample(suree*1000 , 1000);
    	    		countDownExample.start();
    	    		
    				btncevapa.setOnClickListener(new View.OnClickListener() {
    		        	public void onClick(View v) {
    		        		btncevapa.setBackgroundColor(Color.RED);
    		        		if(cevapa.equals(dogrucevap))
    		        		{
    		        			final Bundle bundle=new Bundle();
    		        			countDownExample.cancel();
    		        			Intent intent = new Intent(getApplicationContext(), Dogru.class);
    		        			bundle.putString("sorusayisi","3");
    		        			bundle.putString("soruid",soruid);
    		        			if(jokersayi==-1)
    		        			{
    		        			bundle.putString("gidenjokersayisi",donenjokersayisi);
    		        			}
    		        			else
    		        			{
    		        				
    		        				bundle.putString("gidenjokersayisi",String.valueOf(jokersayi));
    		        			}
    							intent.putExtras(bundle);
        						startActivity(intent); 
    		        			
    		        		}
    		        		else
    		        		{
    		        			final Bundle bundle=new Bundle();
    		        			countDownExample.cancel();
    		        			Intent intent = new Intent(getApplicationContext(), Yanlis.class);
    		        			bundle.putString("dogrucevap",dogrucevap);
    		        			bundle.putString("soruid",soruid);
    		        			bundle.putString("sorusayisi","3");
    		        			if(jokersayi==-1)
    		        			{
    		        			bundle.putString("gidenjokersayisi",donenjokersayisi);
    		        			}
    		        			else
    		        			{
    		        				
    		        				bundle.putString("gidenjokersayisi",String.valueOf(jokersayi));
    		        			}
    							intent.putExtras(bundle);
        						startActivity(intent); 
    		        			
    		        		}
    		        		
    		        		
    						
    		        		
    		        	}
    				});
    				btncevapb.setOnClickListener(new View.OnClickListener() {
    		        	public void onClick(View v) {

    		        		btncevapb.setBackgroundColor(Color.RED);
    		        		if(cevapb.equals(dogrucevap))
    		        		{
    		        			final Bundle bundle=new Bundle();
    		        			countDownExample.cancel();
    		        			Intent intent = new Intent(getApplicationContext(), Dogru.class);
    		        			bundle.putString("sorusayisi","3");
    		        			bundle.putString("soruid",soruid);
    		        			if(jokersayi==-1)
    		        			{
    		        			bundle.putString("gidenjokersayisi",donenjokersayisi);
    		        			}
    		        			else
    		        			{
    		        				
    		        				bundle.putString("gidenjokersayisi",String.valueOf(jokersayi));
    		        			}
    							intent.putExtras(bundle);
        						startActivity(intent); 
    		        			
    		        			
    		        		}
    		        		else
    		        		{
    		        			final Bundle bundle=new Bundle();
    		        			countDownExample.cancel();
    		        			Intent intent = new Intent(getApplicationContext(), Yanlis.class);
    		        			bundle.putString("dogrucevap",dogrucevap);
    		        			bundle.putString("soruid",soruid);
    		        			bundle.putString("sorusayisi","3");
    		        			if(jokersayi==-1)
    		        			{
    		        			bundle.putString("gidenjokersayisi",donenjokersayisi);
    		        			}
    		        			else
    		        			{
    		        				
    		        				bundle.putString("gidenjokersayisi",String.valueOf(jokersayi));
    		        			}
    							intent.putExtras(bundle);
        						startActivity(intent); 
    		        			
    		        		}
    		        		
    		        	}
    				});
    				btncevapc.setOnClickListener(new View.OnClickListener() {
    		        	public void onClick(View v) {

    		        		btncevapc.setBackgroundColor(Color.RED);
    		        		if(cevapc.equals(dogrucevap))
    		        		{
    		        			final Bundle bundle=new Bundle();
    		        			countDownExample.cancel();
    		        			Intent intent = new Intent(getApplicationContext(), Dogru.class);
    		        			bundle.putString("sorusayisi","3");
    		        			bundle.putString("soruid",soruid);
    		        			if(jokersayi==-1)
    		        			{
    		        			bundle.putString("gidenjokersayisi",donenjokersayisi);
    		        			}
    		        			else
    		        			{
    		        				
    		        				bundle.putString("gidenjokersayisi",String.valueOf(jokersayi));
    		        			}
    							intent.putExtras(bundle);
        						startActivity(intent); 
    		        			
    		        			
    		        		}
    		        		else
    		        		{
    		        			final Bundle bundle=new Bundle();
    		        			countDownExample.cancel();
    		        			Intent intent = new Intent(getApplicationContext(), Yanlis.class);
    		        			bundle.putString("dogrucevap",dogrucevap);
    		        			bundle.putString("soruid",soruid);
    		        			bundle.putString("sorusayisi","3");
    		        			if(jokersayi==-1)
    		        			{
    		        			bundle.putString("gidenjokersayisi",donenjokersayisi);
    		        			}
    		        			else
    		        			{
    		        				
    		        				bundle.putString("gidenjokersayisi",String.valueOf(jokersayi));
    		        			}
    							intent.putExtras(bundle);
        						startActivity(intent); 
    		        		}
    		        	}
    				});
    				btncevapd.setOnClickListener(new View.OnClickListener() {
    		        	public void onClick(View v) {

    		        		btncevapd.setBackgroundColor(Color.RED);
    		        		if(cevapd.equals(dogrucevap))
    		        		{
    		        			final Bundle bundle=new Bundle();
    		        			countDownExample.cancel();
    		        			Intent intent = new Intent(getApplicationContext(), Dogru.class);
    		        			bundle.putString("sorusayisi","3");
    		        			bundle.putString("soruid",soruid);
    		        			if(jokersayi==-1)
    		        			{
    		        			bundle.putString("gidenjokersayisi",donenjokersayisi);
    		        			}
    		        			else
    		        			{
    		        				
    		        				bundle.putString("gidenjokersayisi",String.valueOf(jokersayi));
    		        			}
    							intent.putExtras(bundle);
        						startActivity(intent); 
    		        			
    		        			
    		        		}
    		        		else
    		        		{
    		        			final Bundle bundle=new Bundle();
    		        			countDownExample.cancel();
    		        			Intent intent = new Intent(getApplicationContext(), Yanlis.class);
    		        			bundle.putString("dogrucevap",dogrucevap);
    		        			bundle.putString("soruid",soruid);
    		        			bundle.putString("sorusayisi","3");
    		        			if(jokersayi==-1)
    		        			{
    		        			bundle.putString("gidenjokersayisi",donenjokersayisi);
    		        			}
    		        			else
    		        			{
    		        				
    		        				bundle.putString("gidenjokersayisi",String.valueOf(jokersayi));
    		        			}
    							intent.putExtras(bundle);
        						startActivity(intent); 
    		        			
    		        		}
    		        		
    		        	}
    				});
    				
    				
    		} catch (JSONException e) {
    			e.printStackTrace();
    		}

    		 
    	 }
}
	
	 public void onBackPressed() {
	        
	    }
}