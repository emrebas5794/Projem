package com.teknoem.bestebes;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.teknoem.bestebe.R;






import android.R.color;
import android.accounts.Account;
import android.accounts.AccountManager;
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
import android.util.Patterns;
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
		 
		 Pattern emailPattern = Patterns.EMAIL_ADDRESS; // API level 8+
			Account[] accounts = AccountManager.get(this).getAccounts();
			for (Account account : accounts) {
			    if (emailPattern.matcher(account.name).matches()) {
			        String possibleEmail = account.name;
			        kayit_edit_email.setText(possibleEmail);
			    }
			}
			
		
		

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
	        			deger_kayit_edit_ad=kayit_edit_ad.getText().toString().trim();
	        			deger_kayit_soyad=kayit_soyad.getText().toString().trim();
	        			deger_kayit_edit_kullaniciadi=kayit_edit_kullaniciadi.getText().toString().trim();
	        			deger_kayit_edit_email=kayit_edit_email.getText().toString().trim();
	        			
	        			deger_kayit_edit_sifre=kayit_edit_sifre.getText().toString().trim();
	        			String[] kullaniciadikontrol=deger_kayit_edit_kullaniciadi.split(" ");
	        			String[] kullaniciepostakontrol=deger_kayit_edit_email.split(" ");
	        			String[] kullanicisifrekontrol=deger_kayit_edit_sifre.split(" ");
	        			String[] adkontrol=deger_kayit_edit_ad.split(" ");
	        			String[] soyadkontrol=deger_kayit_soyad.split(" ");
	        			if(isValidEmail(kullaniciepostakontrol[0])==false || cevir(kullaniciadikontrol[0])==true || cevir(kullaniciepostakontrol[0])==true)
	        			{
	        				
	        			
	        				if(cevir(kullaniciadikontrol[0])==true)
	        				{
	        				
	        					Toast.makeText(getApplicationContext(),"Kullanýcý Adýnýza Türkçe Karekter Olamaz.", Toast.LENGTH_LONG).show(); 
	        				}
	        				else if(cevir(kullaniciepostakontrol[0])==true)
	        				{
	        				
	        					Toast.makeText(getApplicationContext(),"E-Postanýz 'da  Türkçe Karekter Olamaz.", Toast.LENGTH_LONG).show(); 
	        				}
	        				else
	        				{
	        					Toast.makeText(getApplicationContext(),"E-Postanýzý Doðru Giriniz", Toast.LENGTH_LONG).show(); 
	        				}
	        				
	        			}
	        			else
	        			{
	        			if(deger_kayit_edit_kullaniciadi.length()<=11 && adkontrol.length==1 && soyadkontrol.length==1 && kullaniciadikontrol.length==1 && kullaniciepostakontrol.length==1 && kullanicisifrekontrol.length==1)
	        			{
	        			
	        				kayit_edit_email.setBackgroundColor(R.drawable.menu2);
	        				kayit_edit_sifre.setBackgroundColor(R.drawable.menu2);
	        				kayit_edit_kullaniciadi.setBackgroundColor(R.drawable.menu2);
	        				kayit_edit_ad.setBackgroundColor(R.drawable.menu2);
	        				kayit_soyad.setBackgroundColor(R.drawable.menu2);
	        				
	        			
		        		 url = "http://teknoem.com/bestebes/kontrol.aspx?kullaniciadi="+deger_kayit_edit_kullaniciadi+"&eposta="+deger_kayit_edit_email+"&androidid="+android_id+"";
			        		new JSONParse().execute();
	        			}
	        			else if(kullaniciepostakontrol.length>1)
	        			{
	        				Toast.makeText(getApplicationContext(),"E-Postanýz 'da Boþluk Olmamalý", Toast.LENGTH_LONG).show(); 
	        				kayit_edit_email.setBackgroundColor(Color.RED);
	        				
	        			}
	        			else if(adkontrol.length>1)
	        			{
	        				Toast.makeText(getApplicationContext(),"Adýnýz 'da Boþluk Olmamalý", Toast.LENGTH_LONG).show(); 
	        				kayit_edit_ad.setBackgroundColor(Color.RED);
	        				
	        			}
	        			else if(soyadkontrol.length>1)
	        			{
	        				Toast.makeText(getApplicationContext(),"Soyadýnýz 'da Boþluk Olmamalý", Toast.LENGTH_LONG).show(); 
	        				kayit_soyad.setBackgroundColor(Color.RED);
	        				
	        			}
	        			else if(kullanicisifrekontrol.length>1)
	        			{
	        				Toast.makeText(getApplicationContext(),"Þifreniz 'de Boþluk Olmamalý", Toast.LENGTH_LONG).show(); 
	        				kayit_edit_sifre.setBackgroundColor(Color.RED);
	        			}
	        			else if(kullaniciadikontrol.length>1)
	        			{
	        				Toast.makeText(getApplicationContext(),"Kullanýcý Adýnýz 'da Boþluk Olmamalý", Toast.LENGTH_LONG).show(); 
	        				kayit_edit_kullaniciadi.setBackgroundColor(Color.RED);
	        			}
	        			else
	        			{
	        				Toast.makeText(getApplicationContext(),"Kullanýcý Adýnýz 11 Karekterden Küçük Olmalý", Toast.LENGTH_LONG).show(); 
	        				kayit_edit_kullaniciadi.setBackgroundColor(Color.RED);
	        				
	        			}
	        			
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
	           cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
	    	     nf=cn.getActiveNetworkInfo();
	    		 if(nf != null && nf.isConnected()==true )
	  		    {  
	    			 pDialog = new ProgressDialog(Kayit2.this);
	            pDialog.setMessage("Bilgiler Test Ediliyor..");
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
	  public boolean cevir(String veriyolla)
	  {
		
		  int  sonuc = 0;
				     String[] link=veriyolla.split("");
				     
					  String[] dizi ={"Ü","ü","Ð","ð","Ý","ý","þ","Þ","Ç","ç","ö","Ö","?","#","(",")","{","}","[","]"};
		  for(int i=0;i<link.length;i++)
		  {
			  for(int j=0;j<dizi.length;j++)
			  {
				 if(link[i].equals(dizi[j]))
				 {
					 sonuc=1;
				 }
				  
			  }
			  
		  }
		 
		  if(sonuc==0)
		  {
			  return false;
		  }
		  else
		  {
			  return true;
		  }
			 
		  
					  
		
		  
	  }

}
