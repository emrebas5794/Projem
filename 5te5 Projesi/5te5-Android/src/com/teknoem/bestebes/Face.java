package com.teknoem.bestebes;

import com.teknoem.bestebe.R;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.webkit.WebView;

public class Face extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_face);
		WebView browser = (WebView) findViewById(R.id.webView1);
		browser.loadUrl("https://www.facebook.com/5te5bilgiyarismasi?ref=hl");
	}
}
