package com.teknoem.bestebes;

import java.util.HashMap;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;

import com.teknoem.bestebes.MainActivity;

public class SessionManager {
	// Shared Preferences
		SharedPreferences pref;
		
		// Editor for Shared preferences
		Editor editor;
		
		// Context
		Context _context;
		
		// Shared pref mode
		int PRIVATE_MODE = 0;
		
		// Sharedpref file name
		private static final String PREF_NAME = "AndroidHivePref";
		
		// All Shared Preferences Keys
		private static final String IS_LOGIN = "IsLoggedIn";
		
		// User name (make variable public to access from outside)
		
		public static final String KEY_uyeid = "suyeid";
		public static final String KEY_EMAIL = "semail";
		public static final String KEY_takimi = "stakimi";
		public static final String KEY_NAME = "sname";
		public static final String KEY_soyad = "ssoyad";
		public static final String KEY_kullaniciadi = "skullaniciadi";
		public static final String KEY_sifre = "ssifre";
		public static final String KEY_tokenid = "stokenid";
		
		
		// Email address (make variable public to access from outside)
		
		
		// Constructor
		public SessionManager(Context context){
			this._context = context;
			pref = _context.getSharedPreferences(PREF_NAME, PRIVATE_MODE);
			editor = pref.edit();
		}
		
		/**
		 * Create login session
		 * */
		public void createLoginSession(String suyeid,String semail,String stakimi,String sname,String ssoyad,String skullaniciadi,String ssifre,String stokenid){
			
			editor.putBoolean(IS_LOGIN, true);

			editor.putString(KEY_uyeid, suyeid);
			editor.putString(KEY_EMAIL, semail);
			editor.putString(KEY_takimi, stakimi);
			editor.putString(KEY_NAME, sname);
			editor.putString(KEY_soyad, ssoyad);
			editor.putString(KEY_kullaniciadi, skullaniciadi);
			editor.putString(KEY_sifre, ssifre);
			editor.putString(KEY_tokenid, stokenid);
			
			editor.commit();
		}	
		
		/**
		 * Check login method wil check user login status
		 * If false it will redirect user to login page
		 * Else won't do anything
		 * */
		 public void checkLogin(){
			// Check login status
			if(!this.isLoggedIn()){
				// user is not logged in redirect him to Login Activity
				Intent i = new Intent(_context, Anasayfa.class);
				// Closing all the Activities
				i.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
				
				// Add new Flag to start new Activity
				i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
				
				// Staring Login Activity
				_context.startActivity(i);
				
            }
          
			
		}

		public HashMap<String, String> getUserDetails(){
			HashMap<String, String> user = new HashMap<String, String>();
			// user name
			user.put(KEY_uyeid, pref.getString(KEY_uyeid, null));
			user.put(KEY_EMAIL, pref.getString(KEY_EMAIL, null));
			user.put(KEY_takimi, pref.getString(KEY_takimi, null));
			user.put(KEY_NAME, pref.getString(KEY_NAME, null));
			user.put(KEY_soyad, pref.getString(KEY_soyad, null));
			user.put(KEY_kullaniciadi, pref.getString(KEY_kullaniciadi, null));
			user.put(KEY_sifre, pref.getString(KEY_sifre, null));
			user.put(KEY_tokenid, pref.getString(KEY_tokenid, null));
		
	
			return user;
		}

		public void logoutUser(){
			// Clearing all data from Shared Preferences
			editor.clear();
			editor.commit();
			
			// After logout redirect user to Loing Activity
			Intent i = new Intent(_context, Anasayfa.class);
			// Closing all the Activities
			i.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
			
			// Add new Flag to start new Activity
			i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
			
			// Staring Login Activity
			_context.startActivity(i);
		}
		
		/**
		 * Quick check for login
		 * **/
		// Get Login State
		public boolean isLoggedIn(){
			return pref.getBoolean(IS_LOGIN, false);
		}
}
