package com.teknoem.bestebe;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class Google extends Activity {
	private WebView webview;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_google);
		
	    
		 webview = (WebView) findViewById(R.id.webView1);
		
		webview.setWebViewClient(new MyBrowser());
		webview.getSettings().setLoadsImagesAutomatically(true);
		webview.getSettings().setJavaScriptEnabled(true);
		webview.setScrollBarStyle(View.SCROLLBARS_INSIDE_OVERLAY);
		webview.loadUrl("https://play.google.com/store/apps/details?id=com.teknoem.bestebe");

	      	}
	  private class MyBrowser extends WebViewClient {
	      @Override
	      public boolean shouldOverrideUrlLoading(WebView view, String url) {
	         view.loadUrl(url);
	         return true;
	      }
	   }
}
