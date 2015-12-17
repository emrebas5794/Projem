package com.teknoem.bestebes;

import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.teknoem.bestebe.R;






import android.R.integer;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.Button;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.Toast;

public class PuanSiralamasi extends Activity {
	
	private static final String TAG_toplam = "toplam";
	private static final String TAG_sirasi = "sirasi";
	private static final String TAG_takimi = "takimi";
	private static final String TAG_kullaniciadi = "kullaniciadi";
	private static final String TAG_sayi = "sayi";
	JSONArray android = null;
	ListView list;
	 String url;
	 Button takimlogo;
	 View convertView;
	String ad,soyad,sayi,takimi;
	
	SessionManager session;
	Button btnpuanyenile,ayliksira;
	 HashMap<String, String> user;
	  ConnectivityManager cn;
		 NetworkInfo nf;
	ArrayList<HashMap<String, String>> oslist = new ArrayList<HashMap<String, String>>();
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_puan_siralamasi);
		final Animation animAlpha = AnimationUtils.loadAnimation(this, R.anim.anim_scale4);
		session = new SessionManager(getApplicationContext());
		session.checkLogin();
		user = session.getUserDetails();
		list=(ListView)findViewById(R.id.siralamalistesi);
		  url = "http://teknoem.com/bestebes/toplamticket.aspx?toplamticket=true&&kullaniciadi="+user.get(SessionManager.KEY_kullaniciadi)+"";
		  oslist = new ArrayList<HashMap<String, String>>();
		 new JSONParse().execute();
		 
		 
		 btnpuanyenile=(Button)findViewById(R.id.btnpuanyenile);	
		 btnpuanyenile.setOnClickListener(new View.OnClickListener() {
	        	public void onClick(View v) {
	        		v.startAnimation(animAlpha);
	        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
	        	     nf=cn.getActiveNetworkInfo();
	        		 if(nf != null && nf.isConnected()==true )
	     		    {
	       			  
	        			  url = "http://teknoem.com/bestebes/toplamticket.aspx?toplamticket=true&&kullaniciadi="+user.get(SessionManager.KEY_kullaniciadi)+"";
	        			  oslist = new ArrayList<HashMap<String, String>>();
	        			 new JSONParse().execute();
	     		    }
	        		 else
	           		    {
	        			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
	        		    	startActivity(intent);         		    	
	           		    }
	   
					
					
	        	}
			});
			
		 ayliksira=(Button)findViewById(R.id.ayliksiralama);	
		 ayliksira.setOnClickListener(new View.OnClickListener() {
	        	public void onClick(View v) {
	        		
	        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
	        	     nf=cn.getActiveNetworkInfo();
	        		 if(nf != null && nf.isConnected()==true )
	     		    {
	        			 if(ayliksira.getText().toString().equals("Aylýk Sýralamaya Geç"))
	 	        		{
	        			  url = "http://teknoem.com/bestebes/toplamticket.aspx?ayliktoplamticket=true&&kullaniciadi="+user.get(SessionManager.KEY_kullaniciadi)+"";
	        			  oslist = new ArrayList<HashMap<String, String>>();
	        			 new JSONParse().execute();
	        			 ayliksira.setText("Haftalýk Sýralamaya Geç");
	 	        		}
	        				else
	    	        		{
	        					url = "http://teknoem.com/bestebes/toplamticket.aspx?toplamticket=true&&kullaniciadi="+user.get(SessionManager.KEY_kullaniciadi)+"";
	  	        			  oslist = new ArrayList<HashMap<String, String>>();
	  	        			 new JSONParse().execute();
	        					 ayliksira.setText("Aylýk Sýralamaya Geç");
	    	        			
	    	        		}
	     		    }
	        		 else
	           		    {
	        			 	Intent intent = new Intent(getApplicationContext(), Hata.class);	
	        		    	startActivity(intent);         		    	
	           		    }
	   
					
	        		
	        	
	        	}
			});
		
		
		 
        		
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
    			 pDialog = new ProgressDialog(PuanSiralamasi.this);
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
    				android = json.getJSONArray(TAG_toplam);
    				for(int i = 0; i < android.length(); i++){
    				JSONObject c = android.getJSONObject(i);
    				
    				// Storing  JSON item in a Variable
    				 ad = c.getString(TAG_sirasi);
    				 soyad = c.getString(TAG_kullaniciadi);
    				 sayi = c.getString(TAG_sayi);
    				 takimi = c.getString(TAG_takimi);
    				 
    				 HashMap<String, String> map = new HashMap<String, String>();

     				
     				if(Integer.valueOf(ad)<=9)
     				{
     					map.put(TAG_sirasi, "0"+ad);
     					
     				}
     				else
     				{
     					map.put(TAG_sirasi, ad);
     					
     				}
     				
     			
     				
     				
     				
     					map.put(TAG_takimi,takimi);
     					
     			
     				
     				map.put(TAG_kullaniciadi, soyad);
     				if(Integer.valueOf(sayi)<=9)
     				{
     					map.put(TAG_sayi, "0"+sayi);
     					
     				}
     				else
     				{
     					map.put(TAG_sayi, sayi);
     					
     				}
     				
     				
     				oslist.add(map);
     			
     				
     		
     				
     				
     		        
     				
     				ListAdapter adapter = new SimpleAdapter(PuanSiralamasi.this, oslist,
     						R.layout.siralamalist,
     						new String[] { TAG_sirasi, TAG_takimi, TAG_kullaniciadi, TAG_sayi }, new int[] {
     								R.id.siralamaad,R.id.siralamatakim, R.id.siralamasoyad, R.id.siralamasayi});

     				list.setAdapter(adapter);
     				
     				list.setOnItemClickListener(new AdapterView.OnItemClickListener() {

    		            @Override
    		            public void onItemClick(AdapterView<?> parent, View view,
    		                                    int position, long id) {
    		                Toast.makeText(PuanSiralamasi.this, "You Clicked at "+oslist.get(+position).get("siralamasayi"), Toast.LENGTH_SHORT).show();

    		            }
    		        });
    				
    				
    	    		
    		
    	
    				
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
