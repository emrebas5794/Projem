package com.teknoem.bestebes;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;
import com.teknoem.bestebe.R;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;

public class Surenizdoldu extends Activity {
	Button tekrardene,sorupaylas;
	String donensoruid,donenjokersayisi,donensorusayisi;
	 AdView adView;
	 ConnectivityManager cn;
	 NetworkInfo nf;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_surenizdoldu);
		Bundle soruid=getIntent().getExtras();
		 donensoruid=soruid.getString("soruid");
		 AdView adView = (AdView) this.findViewById(R.id.adView);
		    AdRequest adRequest = new AdRequest.Builder().build();
		    adView.loadAd(adRequest); //adView i yüklüyoruz
		    
		    Bundle jokersayisi=getIntent().getExtras();
			donenjokersayisi=jokersayisi.getString("gidenjokersayisi");
			
		tekrardene=(Button)findViewById(R.id.suretekrardene);
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
				bundle.putString("sayfatipi","suredoldu");
				bundle.putString("gidenjokersayisi",donenjokersayisi);
				
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

	public void onBackPressed() {
       new AlertDialog.Builder(this).setIcon(android.R.drawable.ic_dialog_alert).setTitle("Exit")
               .setMessage("Anasayfa'ya Gitmek Mi Ýstiyorsun ?")
               .setPositiveButton("Evet", new DialogInterface.OnClickListener() {
                   @Override
                   public void onClick(DialogInterface dialog, int which) {
                   	Intent intent = new Intent(getApplicationContext(), MainActivity.class);
   					
   					startActivity(intent); 
                   }
               }).setNegativeButton("Hayýr", null).show();
   }
}
