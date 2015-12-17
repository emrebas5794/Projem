package com.teknoem.bestebes;

import com.teknoem.bestebe.R;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.webkit.WebView;
import android.widget.Button;
import android.widget.ImageView;

public class Oduller extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_oduller);
		ImageView faceyeit = (ImageView) findViewById(R.id.faceyegit);
		faceyeit.setOnClickListener(new Button.OnClickListener(){

			@Override
			public void onClick(View arg0) {
				 Intent intent = new Intent(getApplicationContext(), Face.class);
					
					startActivity(intent); 
				
			}});
	}
	 public void onBackPressed() {
	       
   	  
   	  Intent intent = new Intent(getApplicationContext(), MainActivity.class);
			
			startActivity(intent); 
     

}
}
