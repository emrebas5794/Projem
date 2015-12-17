package com.teknoem.bestebes;


import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDatabase.CursorFactory;
import android.database.sqlite.SQLiteOpenHelper;
import android.os.Bundle;
import android.util.Log;
import android.widget.ArrayAdapter;
import android.widget.Toast;
 

public class vtislem extends SQLiteOpenHelper 
{

    public vtislem(Context context, String name, CursorFactory factory,
            int version) 
    {
        super(context, name, factory, version);
        
        // TODO Auto-generated constructor stub
    }
 
    @Override
    public void onCreate(SQLiteDatabase db) 
    {
        // TODO Auto-generated method stub
        db.execSQL("CREATE  TABLE  IF NOT EXISTS KalanSoru (id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , SoruSayisi VARCHAR)");
       
       
    }
 
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) 
    {
        // TODO Auto-generated method stub
        db.execSQL("DROP TABLE IF EXIST KalanSoru;");
    }
 
    public void kayitekle(String SoruSayisi)
    {
        SQLiteDatabase db=this.getWritableDatabase();
        db.execSQL("INSERT INTO KalanSoru(SoruSayisi) VALUES('" + SoruSayisi + "')");
 
 
    }
    
    public void kayitguncelle(String SoruSayisi)
    {
        SQLiteDatabase db=this.getWritableDatabase();
        db.execSQL("Update KalanSoru Set SoruSayisi='"+SoruSayisi+"'");
 
 
    }
    public int kayitlistele()
    {
    	 
    	String countQuery = "SELECT  * FROM KalanSoru";
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.rawQuery(countQuery, null);
        cursor.close();
 
        // return count
        return cursor.getCount();
       
 
    }
   

   


	
    
   
  
     
     
     
 
}
