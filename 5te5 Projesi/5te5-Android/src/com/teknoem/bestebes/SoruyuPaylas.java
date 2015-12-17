package com.teknoem.bestebes;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.teknoem.bestebe.R;



import android.annotation.TargetApi;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.Bitmap.CompressFormat;
import android.graphics.Canvas;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.text.Html;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;

public class SoruyuPaylas extends Activity {
	Bitmap mBitmap;
	 File imagePath;
	 Button paylas;
	 Button btsoru,btncevapa,btncevapb,btncevapc,btncevapd;
	String  donensoruid,donenjokersayisi,donensorusayisi,donendogrucevap;
	 private static String url;
	private static final String TAG_sorular = "sorular";
	private static final String TAG_id = "soruid";
	private static final String TAG_soru = "soru";
	private static final String TAG_cevapa = "cevapa";
	private static final String TAG_cevapb = "cevapb";
	private static final String TAG_cevapc = "cevapc";
	private static final String TAG_cevapd = "cevapd";
	private static final String TAG_dogrucevap = "dogrucevap";
	JSONArray androidd = null;
	 
	
	 ConnectivityManager cn;
	 NetworkInfo nf;

	String soruid,soru,cevapa,cevapb,cevapc,cevapd,dogrucevap,donensayfatipi;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_soruyu_paylas);
		
		  btsoru=(Button)findViewById(R.id.pbtsoru);
	   		
		  Bundle jokersayisi=getIntent().getExtras();
			donenjokersayisi=jokersayisi.getString("gidenjokersayisi");
			
			 Bundle sayfatipi=getIntent().getExtras();
			 donensayfatipi=sayfatipi.getString("sayfatipi");
		 
			Bundle sorusayisi=getIntent().getExtras();
			 donensorusayisi=sorusayisi.getString("sorusayisi");
			 
			 Bundle dogrucevap=getIntent().getExtras();
			donendogrucevap=sorusayisi.getString("dogrucevap");
			 
			 btncevapa=(Button)findViewById(R.id.pcevapa);	
	   		 btncevapb=(Button)findViewById(R.id.pcevapb);	
	   		 btncevapc=(Button)findViewById(R.id.pcevapc);	
	   		 btncevapd=(Button)findViewById(R.id.pcevapd);	
	   		 
		 new AlertDialog.Builder(this).setIcon(android.R.drawable.ic_dialog_alert).setTitle("Exit")
         .setMessage("Soruyu Paylaşmak Mı İstiyorsun")
         .setPositiveButton("Evet", new DialogInterface.OnClickListener() {
             @Override
             public void onClick(DialogInterface dialog, int which) {
            	 Bundle soruid=getIntent().getExtras();
            	 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
        	     nf=cn.getActiveNetworkInfo();
        		 if(nf != null && nf.isConnected()==true )
     		    {

        		 donensoruid=soruid.getString("soruid");
        		url = "http://teknoem.com/bestebes/facebook.aspx?soru=true&soruid="+donensoruid+"";
        		  new JSONParse().execute();
     		   }
        		 else
           		    {
        			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
        		    	startActivity(intent);         		    	
           		    }
   
                  
             }
         }).setNegativeButton("Hayır", null).show();
		
	      
			
	       
     
	}
	public Bitmap takeScreenshot() {
		   View rootView = findViewById(android.R.id.content).getRootView();
		   rootView.setDrawingCacheEnabled(true);
		   return rootView.getDrawingCache();
		}

	public void saveBitmap(Bitmap bitmap) {
	    File imagePath = new File(Environment.getExternalStorageDirectory() + "/bestebessoru.png");
	    FileOutputStream fos;
	    try {
	        fos = new FileOutputStream(imagePath);
	        bitmap.compress(CompressFormat.JPEG, 100, fos);
	        fos.flush();
	        fos.close();
	    } catch (FileNotFoundException e) {
	        Log.e("GREC", e.getMessage(), e);
	    } catch (IOException e) {
	        Log.e("GREC", e.getMessage(), e);
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
   		   pDialog = new ProgressDialog(SoruyuPaylas.this);
           pDialog.setMessage("Yükleniyorr ...");
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
   				androidd = json.getJSONArray(TAG_sorular);
   				
   				JSONObject c = androidd.getJSONObject(0);
   				
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
   				
   				Bitmap bitmap = takeScreenshot();
	     	       saveBitmap(bitmap);
	     	      Intent share = new Intent(Intent.ACTION_SEND);
	        		 
      		    share.setType("image/*");
      		 
      		    String imagePath = Environment.getExternalStorageDirectory()
      		            + "/bestebessoru.png";
      		 
      		    File imageFileToShare = new File(imagePath);
      		 
      		    Uri uri = Uri.fromFile(imageFileToShare);
      		    share.putExtra(Intent.EXTRA_STREAM, uri);
      		 
      		    startActivity(Intent.createChooser(share, "5te5 Paylaş"));
   				
   				
   				
   		} catch (JSONException e) {
   			e.printStackTrace();
   		}

   		 
   	 }
}
	
	
	public void onBackPressed() {
		final Bundle bundle=new Bundle();
		
		if(donensayfatipi.equals("dogru"))
		{
			Intent intent = new Intent(getApplicationContext(), Dogru.class);
			bundle.putString("gidenjokersayisi",donenjokersayisi);
			bundle.putString("sorusayisi",donensorusayisi);
			bundle.putString("soruid",donensoruid);
			intent.putExtras(bundle);
			startActivity(intent); 
			
		}
		if(donensayfatipi.equals("yanlis"))
		{
			Intent intent = new Intent(getApplicationContext(), Yanlis.class);
			bundle.putString("gidenjokersayisi",donenjokersayisi);
			bundle.putString("sorusayisi",donensorusayisi);
			bundle.putString("soruid",donensoruid);
			bundle.putString("dogrucevap",donendogrucevap);
			intent.putExtras(bundle);
			startActivity(intent); 
			
		}
		if(donensayfatipi.equals("suredoldu"))
		{
			Intent intent = new Intent(getApplicationContext(), Surenizdoldu.class);
			bundle.putString("gidenjokersayisi",donenjokersayisi);
			bundle.putString("sorusayisi",donensorusayisi);
			bundle.putString("soruid",donensoruid);
			intent.putExtras(bundle);
			startActivity(intent); 
			
		}
		
		
    }
	
}
