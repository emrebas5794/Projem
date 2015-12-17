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

public class Yanlis extends Activity {
	Button tekrardene,sorupaylas,yanlisresim;
	String donensoruid,donendogrucevap,donenjokersayisi,donensorusayisi;
	 AdView adView;
	 ConnectivityManager cn;
	 NetworkInfo nf;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_yanlis);
		
		 AdView adView = (AdView) this.findViewById(R.id.adView);
		    AdRequest adRequest = new AdRequest.Builder().build();
		    adView.loadAd(adRequest); //adView i yüklüyoruz
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
