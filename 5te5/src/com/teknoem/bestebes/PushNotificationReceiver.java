package com.teknoem.bestebes;



import com.teknoem.bestebe.R;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.util.Log;

public class PushNotificationReceiver extends BroadcastReceiver {

    private NotificationManager mNotificationManager;
    public static final int NOTIFICATION_ID = 1;

    String message;

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
	@SuppressLint("NewApi")
	public void onReceive(Context context, Intent intent) {

        /** All push message containts this values */
        message = intent.getStringExtra("collapse_key");
        Log.d("PushNotificationReceiver", "message:" + message);
        Log.d("PushNotificationReceiver", "from:" + intent.getStringExtra("from"));

        /** Sample Key Values (First, these must be added from Turkcell push server) */
        Log.d("PushNotificationReceiver", "key:" + "video, " + "value:" + intent.getStringExtra("video"));
        Log.d("PushNotificationReceiver", "key:" + "image, " + "value:" + intent.getStringExtra("image"));
        Log.d("PushNotificationReceiver", "key:" + "www, " + "value:" + intent.getStringExtra("www"));

        /** Show Sample Notification*/

        mNotificationManager = (NotificationManager)context.getSystemService(Context.NOTIFICATION_SERVICE);

        PendingIntent contentIntent = PendingIntent.getActivity(context, 0,
                new Intent(context, MainActivity.class), 0);

        Notification.Builder mBuilder = new Notification.Builder(
                context).setSmallIcon(R.drawable.ic_launcher)
                .setContentTitle("GCM Notification")
                .setStyle(new Notification.BigTextStyle().bigText(message))
                .setContentText(message);

        mBuilder.setContentIntent(contentIntent);
        mNotificationManager.notify(NOTIFICATION_ID, mBuilder.build());
    }

}

