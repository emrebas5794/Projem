package com.teknoem.bestebes;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.teknoem.bestebe.R;



import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
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
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_kullanici_soru);
		
		Bundle id=getIntent().getExtras();
		donenid=id.getString("kulllaniciid");
		
		Button	 sorugonder=(Button)findViewById(R.id.soruyugonder);
		 editsoru=(EditText)findViewById(R.id.editsoru);
		sorugonder.setOnClickListener(new Button.OnClickListener(){

				@Override
				public void onClick(View arg0) {
					 
					soru=editsoru.getText().toString().replace(" ", "-");
					
					 
					 url = "http://teknoem.com/bestebes/sorruyolla.aspx?kullanicisorukaydet=true&kullanicisorusu="+soru+"&kullaniciid="+donenid+"";
		        		new JSONParse().execute();
					
				}});
	}
	
	 private class JSONParse extends AsyncTask<String, String, JSONObject> {
    	 private ProgressDialog pDialog;
    	@Override
        protected void onPreExecute() {
            super.onPreExecute();
          
            pDialog = new ProgressDialog(KullaniciSoru.this);
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
    				androidd = json.getJSONArray(TAG_kullanicisorusu);
    				
    				JSONObject c = androidd.getJSONObject(0);
    				
    				// Storing  JSON item in a Variable
    				 deger = c.getString(TAG_deger);
    				 if(deger.equals("true"))
    				 {
    					 Toast.makeText(getApplicationContext(),"Sorunuz Gönderildi. Onaylandýðýnda Size Mail Gelecektir.", Toast.LENGTH_SHORT).show(); 
    					 
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
