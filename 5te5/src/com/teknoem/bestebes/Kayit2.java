package com.teknoem.bestebes;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.teknoem.bestebe.R;






import android.R.color;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.provider.Settings.Secure;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnFocusChangeListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

public class Kayit2 extends Activity {
	private static final String TAG_kayit = "kontrol";
	private static final String TAG_deger = "deger";
	
	JSONArray androidd = null;
	String deger,url;
	 ConnectivityManager cn;
	 NetworkInfo nf;
	EditText kayit_soyad, kayit_edit_ad, kayit_edit_kullaniciadi, kayit_edit_sifre, kayit_edit_email;
	String deger_kayit_soyad,deger_kayit_edit_ad,deger_kayit_edit_kullaniciadi,deger_kayit_edit_sifre,deger_kayit_edit_email;
	String yazi,yazi2,yazi3,yazi4,yazi5;
	String android_id ;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_kayit2);
		
		kayit_edit_ad=(EditText)findViewById(R.id.keditText11);	
		kayit_soyad=(EditText)findViewById(R.id.keditText22);	
		kayit_edit_kullaniciadi=(EditText)findViewById(R.id.keditText33);	
		kayit_edit_sifre=(EditText)findViewById(R.id.keditText44);	
		kayit_edit_email=(EditText)findViewById(R.id.keditText55);	
		
		 android_id = Secure.getString(this.getContentResolver(),
	            Secure.ANDROID_ID);
		kayit_edit_email.addTextChangedListener(new TextWatcher() {
			 
			   public void afterTextChanged(Editable s) {
				  
				
		  }

			@Override
			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {
				
				
			}

			@Override
			public void onTextChanged(CharSequence s, int start, int before,
					int count) {
				if( isValidEmail(kayit_edit_email.getText().toString())==true)
				{
					  
					   kayit_edit_email.setBackgroundColor(Color.GREEN);
					   yazi5=kayit_edit_email.getText().toString();
					 
					}
				   else
				   {
					   kayit_edit_email.setBackgroundColor(Color.RED);
					   
				   }
				
			}
			 
			  
			  });
		

		Button kayit=(Button)findViewById(R.id.kuyekaydet);	
		 
		kayit.setOnClickListener(new View.OnClickListener() {
	        	public void onClick(View v) {
	        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
	        	     nf=cn.getActiveNetworkInfo();
	        		 if(nf != null && nf.isConnected()==true )
	     		    {
	        		if(kayit_edit_ad.getText().toString().equals("") || kayit_soyad.getText().toString().equals("") || kayit_edit_kullaniciadi.getText().toString().equals("") || kayit_edit_sifre.getText().toString().equals("") || kayit_edit_email.getText().toString().equals(""))
	        		{
	        			Toast.makeText(getApplicationContext(),"Lütfen Boþ Alan Býrakmayýnýz.", Toast.LENGTH_SHORT).show(); 
	        			
	        		}
	        		else
	        		{
	        			deger_kayit_edit_kullaniciadi=kayit_edit_kullaniciadi.getText().toString();
	        			if(deger_kayit_edit_kullaniciadi.length()<=11)
	        			{
	        			deger_kayit_edit_ad=kayit_edit_ad.getText().toString();
	        			deger_kayit_soyad=kayit_soyad.getText().toString();
	        			
	        			
	        			deger_kayit_edit_sifre=kayit_edit_sifre.getText().toString();
	        			deger_kayit_edit_email=kayit_edit_email.getText().toString();
	        			
	        			kayit_edit_email.setBackgroundColor(R.drawable.kayitol);
	        			kayit_edit_kullaniciadi.setBackgroundColor(R.drawable.kayitol);
	        			
		        		 url = "http://teknoem.com/bestebes/kontrol.aspx?kullaniciadi="+deger_kayit_edit_kullaniciadi+"&eposta="+deger_kayit_edit_email+"&androidid="+android_id+"";
			        		new JSONParse().execute();
	        			}
	        			else
	        			{
	        				Toast.makeText(getApplicationContext(),"Kullanýcý Adýnýz 11 Karekterden Küçük Olmalý", Toast.LENGTH_LONG).show(); 
	        				kayit_edit_kullaniciadi.setBackgroundColor(Color.RED);
	        				
	        			}
	        			
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
	         
	           pDialog = new ProgressDialog(Kayit2.this);
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
	   				if(deger.equals("true"))
	   				{
	   					final Bundle bundle=new Bundle();
	        			Intent intent = new Intent(getApplicationContext(), Kayit3.class);
	        			bundle.putString("ad",deger_kayit_edit_ad);
	        			bundle.putString("soyad",deger_kayit_soyad);
	        			bundle.putString("kullaniciadi",deger_kayit_edit_kullaniciadi);
	        			bundle.putString("sifre",deger_kayit_edit_sifre);
	        			bundle.putString("mail",deger_kayit_edit_email);
	    				intent.putExtras(bundle);
						startActivity(intent); 
	   				}
	
	   				if(deger.equals("eposta"))
	   				{
	   					
	   					Toast.makeText(getApplicationContext(),"Bu Eposta Baþkasý Tarafýndan Kullanýyor.", Toast.LENGTH_SHORT).show(); 
	   					kayit_edit_email.setBackgroundColor(Color.RED);
	   				
	   				}
	   				if(deger.equals("kullaniciadi"))
	   				{
	   					Toast.makeText(getApplicationContext(),"Bu Kullanici Adý Baþkasý Tarafýndan Kullanýyor.", Toast.LENGTH_SHORT).show(); 
	   					kayit_edit_kullaniciadi.setBackgroundColor(Color.RED);
	   				}
	   				if(deger.equals("androidid"))
	   				{
	   					Toast.makeText(getApplicationContext(),"Bu Telefon Ýle Daha Önce Kayýt Yapýldý.", Toast.LENGTH_SHORT).show(); 
	   					
	   				}
	   				if(deger.equals("epostaandroidid"))
	   				{
	   					Toast.makeText(getApplicationContext(),"Bu Eposta ve Telefon Ýle Daha Önce Kayýt Yapýldý.", Toast.LENGTH_SHORT).show(); 
	   					kayit_edit_email.setBackgroundColor(Color.RED);
	   				}
	   				if(deger.equals("kullaniciadiandroidid"))
	   				{
	   					Toast.makeText(getApplicationContext(),"Bu Kullanýcý Adý  ve Telefon Ýle Daha Önce Kayýt Yapýldý.", Toast.LENGTH_SHORT).show(); 
	   					kayit_edit_kullaniciadi.setBackgroundColor(Color.RED);
	   				}
	   					
	   				if(deger.equals("epostakullaniciadi"))
	   				{
	   					Toast.makeText(getApplicationContext(),"Bu Kullanýcý Adý ve Eposta Baþkasý Tarafýndan Kullanýyor.", Toast.LENGTH_SHORT).show(); 
	   					kayit_edit_email.setBackgroundColor(Color.RED);
	   					kayit_edit_kullaniciadi.setBackgroundColor(Color.RED);
	   				}
	   				if(deger.equals("kullaniciadiepostaandroidid"))
	   				{
	   					Toast.makeText(getApplicationContext(),"Bu Kullanýcý Adý , Eposta ve Telefon Ýle Daha Önce Kayýt Yapýldý. ", Toast.LENGTH_SHORT).show(); 
	   					kayit_edit_email.setBackgroundColor(Color.RED);
	   					kayit_edit_kullaniciadi.setBackgroundColor(Color.RED);
	   				}
	   				
	   				if(deger.equals("kotu"))
	   				{
	   					Toast.makeText(getApplicationContext(),"Telefon Mac Adresiniz Alýndý Hakkýnýzda Ýþlem Baþlatýlacaktýr.", Toast.LENGTH_SHORT).show(); 
	   					
	   				}
	   				 
	   				 
	   		} catch (JSONException e) {
	   			e.printStackTrace();
	   		}

	   		 
	   	 }
	
}
	
	  public boolean isValidEmail(String email)
	  {
	      boolean isValidEmail = false;

	      String emailExpression = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{2,4}$";
	      CharSequence inputStr = email;

	      Pattern pattern = Pattern.compile(emailExpression, Pattern.CASE_INSENSITIVE);
	      Matcher matcher = pattern.matcher(inputStr);
	      if (matcher.matches())
	      {
	          isValidEmail = true;
	      }
	      return isValidEmail;
	  }
	  public String cevir(String veriyolla)
	  {
		  String link="";
		  link = veriyolla.replace("ü", "U");
				     link = link.replace("Ü", "u");
				     link = link.replace("ð", "g");
				     link = link.replace("Ð", "G");
				     link = link.replace("Ý", "I");
				     link = link.replace("ý", "i");
				     link = link.replace("þ", "s");
				     link = link.replace("Þ", "S");
				     link = link.replace("ç", "c");
				     link = link.replace("Ç", "C");
				     link = link.replace("ö", "o");
				     link = link.replace("Ö", "O");
				     link = link.replace("?", "");
				     link = link.replace("#", "");
				     link = link.replace("(", "");
				     link = link.replace(")", "");
				     link = link.replace("{", "");
				     link = link.replace("}", "i");
				     link = link.replace("[", "i");
				     link = link.replace("]", "i");
				    
		  
		  return link;
		  
	  }

}
