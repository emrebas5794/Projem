package com.teknoem.bestebes;

import com.parse.Parse;
import com.parse.ParseACL;
import com.parse.ParseInstallation;
import com.parse.ParseUser;
import com.parse.PushService;

public class Application extends android.app.Application {

  public Application() {
  }

  @Override
  public void onCreate() {
    super.onCreate();

	Parse.initialize(this, "d6Br1ORuxT1UjbFON5UQYZwOBBsu7N6EIQ84RhEw", "5bSvMBVzsaYxwOVFQwFXxW2lxp2gHqO6nFxtD6v6");
	 
	ParseUser.enableAutomaticUser();
	ParseACL defaultACL = new ParseACL();

	// If you would like all objects to be private by default, remove this line.
	defaultACL.setPublicReadAccess(true);

	ParseACL.setDefaultACL(defaultACL, true);
  }
}