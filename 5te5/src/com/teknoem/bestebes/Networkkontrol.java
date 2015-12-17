package com.teknoem.bestebes;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.util.Log;
import android.widget.Toast;

public class Networkkontrol extends BroadcastReceiver  {
	 private static final String LOG_TAG = "Otomatik internet Kontrol�";
	 static boolean isConnected = false;

	  @Override
	  public void onReceive(final Context context, final Intent intent) {
	 
	   isNetworkAvailable(context); //receiver �al��t��� zaman �a��r�lan method
	 
	  }
	 
	 
	  private boolean isNetworkAvailable(Context context) {
	   ConnectivityManager connectivity = (ConnectivityManager) 
	     context.getSystemService(Context.CONNECTIVITY_SERVICE); //Sistem a��n� dinliyor internet var m� yok mu
	   
	   if (connectivity != null) {
	    NetworkInfo[] info = connectivity.getAllNetworkInfo();
	    if (info != null) {
	     for (int i = 0; i < info.length; i++) {
	      if (info[i].getState() == NetworkInfo.State.CONNECTED) {
	       
	    	if(!isConnected){ //internet varsa
		        isConnected = true;
		        Log.v(LOG_TAG, "�nternet Ba�land�n�z!");
		        
	       }
	       return true;
	      }
	     }
	    }
	   }
	   isConnected = false;
       Toast.makeText(context, "�nternet Ba�lant�n�zda Sorun Var", Toast.LENGTH_LONG).show();
	   Log.v(LOG_TAG, "�nternet Ba�lant�n�zda Sorun Var!");
	
	   return false;
	  }
	 }
