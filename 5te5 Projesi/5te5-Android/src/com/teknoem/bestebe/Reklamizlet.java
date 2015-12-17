package com.teknoem.bestebe;

import android.R.integer;
import android.app.*;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.os.*; 
import android.util.Log;
import android.view.*;  
import android.webkit.ValueCallback;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.*;

import com.jirbo.adcolony.*;
import com.teknoem.bestebes.Dogru;


public class Reklamizlet extends Activity implements AdColonyAdListener, AdColonyAdAvailabilityListener {

	 final static String APP_ID  = "app4799b182e4df4ed5b9";
	  final static String ZONE_ID = "vzfeea95b9138240318b";
	  String  donensoruid,donenjokersayisi,donenjokerlimit,donensorusayisi,donendogrucevap,donensayfatipi;
	  Handler button_text_handler;
	  Runnable button_text_runnable;
	  Button video_button;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
	
		 AdColony.configure( this, "version:1.0,store:google", APP_ID, ZONE_ID );
		    // version - arbitrary application version
		    // store   - google or amazon
		    
		    // Add ad availability listener
		    AdColony.addAdAvailabilityListener(this);

		    // Disable rotation if not on a tablet-sized device (note: not
		    // necessary to use AdColony).
		    if ( !AdColony.isTablet() )
		    {
		      setRequestedOrientation( ActivityInfo.SCREEN_ORIENTATION_PORTRAIT );
		    }
		setContentView(R.layout.activity_reklamizlet);
		 Bundle jokersayisi=getIntent().getExtras();
			donenjokersayisi=jokersayisi.getString("gidenjokersayisi");
			
			 Bundle sayfatipi=getIntent().getExtras();
			 donensayfatipi=sayfatipi.getString("sayfatipi");
		 
			Bundle sorusayisi=getIntent().getExtras();
			 donensorusayisi=sorusayisi.getString("sorusayisi");
			 
			 Bundle dogrucevap=getIntent().getExtras();
			donendogrucevap=sorusayisi.getString("dogrucevap");
			
			
		
		 video_button = (Button) findViewById(R.id.video_button);
		    
		    // Handler and Runnable for updating button text based on ad availability listener
		    button_text_handler = new Handler();
		    button_text_runnable = new Runnable()
		    {
		      public void run()
		      {
		    		video_button.setText("Video'yu Ýzlemek Ýçin Týkla");
		    	video_button.setOnClickListener(
		    	new View.OnClickListener()
		    	{
		          public void onClick( View v )
		    	  {
		    		AdColonyVideoAd ad = new AdColonyVideoAd( ZONE_ID ).withListener( Reklamizlet.this );
		    		ad.show();
		    	  }
		    	});
		      }
		    };
		  }

		  public void onPause()
		  {
		    super.onPause();
		    AdColony.pause();
		  }

		  public void onResume()
		  {
		    super.onResume();
		   
		    AdColony.resume( this );
		   
		  }

		  //Ad Started Callback - called only when an ad successfully starts playing
		  public void onAdColonyAdStarted( AdColonyAd ad )
		  {
			Log.d("AdColony", "onAdColonyAdStarted");
		  }

		  //Ad Attempt Finished Callback - called at the end of any ad attempt - successful or not.
		  public void onAdColonyAdAttemptFinished( AdColonyAd ad )
		  {
			// You can ping the AdColonyAd object here for more information:
			// ad.shown() - returns true if the ad was successfully shown.
			// ad.notShown() - returns true if the ad was not shown at all (i.e. if onAdColonyAdStarted was never triggered)
			// ad.skipped() - returns true if the ad was skipped due to an interval play setting
			// ad.canceled() - returns true if the ad was cancelled (either programmatically or by the user)
			// ad.noFill() - returns true if the ad was not shown due to no ad fill.
			 int jokerislem;
			 jokerislem=Integer.valueOf(donenjokersayisi)+1;
			 
			  final Bundle bundle=new Bundle();
			    Intent intent = new Intent(getApplicationContext(), Dogru.class);
				bundle.putString("gidenjokersayisi",String.valueOf(jokerislem));
				bundle.putString("sorusayisi",donensorusayisi);
				bundle.putString("soruid",donensoruid);
				bundle.putString("jokerlimit","1");
				intent.putExtras(bundle);
				startActivity(intent); 
		    Log.d("AdColony", "onAdColonyAdAttemptFinished");
		  }
		  
		  //Ad Availability Change Callback - update button text
		  public void onAdColonyAdAvailabilityChange(boolean available, String zone_id) 
		  {
			if (available) button_text_handler.post(button_text_runnable);
		  }
		  public void onBackPressed() {
			  final Bundle bundle=new Bundle();
			    Intent intent = new Intent(getApplicationContext(), Dogru.class);
				bundle.putString("gidenjokersayisi",donenjokersayisi);
				bundle.putString("sorusayisi",donensorusayisi);
				bundle.putString("jokerlimit","0");
				bundle.putString("soruid",donensoruid);
			
				intent.putExtras(bundle);
				startActivity(intent); 
		  }
}
