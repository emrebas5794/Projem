package com.teknoem.bestebes;

import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.teknoem.bestebe.R;



import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
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

public class KullaniciSoru extends Activity {
	private static final String TAG_kullanicisorusu = "kullanicisorusu";
	private static final String TAG_deger = "deger";
	JSONArray androidd = null;
	String deger,url,donenid,soru;
	EditText editsoru;
	SessionManager session;
	 ConnectivityManager cn;
	 NetworkInfo nf;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_kullanici_soru);
		session = new SessionManager(getApplicationContext());
		
		Bundle id=getIntent().getExtras();
		donenid=id.getString("kulllaniciid");
		
		Button	 sorugonder=(Button)findViewById(R.id.soruyugonder);
		 editsoru=(EditText)findViewById(R.id.editsoru);
		sorugonder.setOnClickListener(new Button.OnClickListener(){

				@Override
				public void onClick(View arg0) {
					 
					soru=editsoru.getText().toString().replace(" ", "-");
					 session.checkLogin();
			         
					 HashMap<String, String> user = session.getUserDetails();
					 
					 url = "http://teknoem.com/bestebes/sorruyolla.aspx?kullanicisorukaydet=true&kullanicisorusu="+soru+"&kullaniciid="+donenid+"&tokenid="+user.get(SessionManager.KEY_tokenid)+"";
		        		new JSONParse().execute();
					
				}});
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
   			 pDialog = new ProgressDialog(KullaniciSoru.this);
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
    				androidd = json.getJSONArray(TAG_kullanicisorusu);
    				
    				JSONObject c = androidd.getJSONObject(0);
    				
    				// Storing  JSON item in a Variable
    				 deger = c.getString(TAG_deger);
    				 if(deger.equals("true"))
    				 {
    					 Toast.makeText(getApplicationContext(),"Sorunuz Gönderildi. Onaylandýðýnda Size Mail Gelecektir.", Toast.LENGTH_SHORT).show(); 
    					 Intent intent = new Intent(getApplicationContext(), MainActivity.class);	
	        		    	startActivity(intent);    
    				 }
    				 
    				else
    				{
    					
    					Toast.makeText(getApplicationContext(),"Sorunuz Gönderilemedi. Daha Sonra Tekrar Deneyeniz.", Toast.LENGTH_SHORT).show(); 
    				}
    				 
    				
    				
    		} catch (JSONException e) {
    			e.printStackTrace();
    		}

    		 
    	 }
    	 
    	 
    	 
    	 
    	 
}
}
