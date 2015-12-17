package com.teknoem.bestebes;

import com.teknoem.bestebe.R;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

public class Hata extends Activity {
	 ConnectivityManager cn;
	 NetworkInfo nf;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_networkkontrol);
		Button  kontrol=(Button)findViewById(R.id.networkkontrol);	
		kontrol.setOnClickListener(new View.OnClickListener() {
	        	public void onClick(View v) {
	        		 cn=(ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
	        	     nf=cn.getActiveNetworkInfo();
	        	     if(nf != null && nf.isConnected()==true )
	       		    { 
	        	    	 Intent intent = new Intent(getApplicationContext(), MainActivity.class);	
	       		    	startActivity(intent);  
	       		    
	       		    }
	         		 else
         		    {
	         			Toast.makeText(getApplicationContext(),"Ýnternet Baðlantýnýzý Kontrol Ediniz", Toast.LENGTH_SHORT).show();     	
         		    }
     		
		}
	});	 
	       		    

	}
	 public void onBackPressed() {
		
		
	    }
}
