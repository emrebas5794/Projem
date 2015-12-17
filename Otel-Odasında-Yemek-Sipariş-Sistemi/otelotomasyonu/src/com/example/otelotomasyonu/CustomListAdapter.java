package com.example.otelotomasyonu;

import java.util.ArrayList;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.otelotomasyonu.R;

public class CustomListAdapter extends BaseAdapter {

	private ArrayList<NewsItem> listData;

	private LayoutInflater layoutInflater;

	public CustomListAdapter(Context context, ArrayList<NewsItem> listData) {
		this.listData = listData;
		layoutInflater = LayoutInflater.from(context);
	}

	@Override
	public int getCount() {
		return listData.size();
	}

	@Override
	public Object getItem(int position) {
		return listData.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	public View getView(int position, View convertView, ViewGroup parent) {
		ViewHolder holder;
		if (convertView == null) {
			convertView = layoutInflater.inflate(R.layout.satir, null);
			holder = new ViewHolder();
			holder.headlineView = (TextView) convertView.findViewById(R.id.actionTitle);
			
			holder.imageView = (ImageView) convertView.findViewById(R.id.thumbNail);
			convertView.setTag(holder);
		} else {
			holder = (ViewHolder) convertView.getTag();
		}

		NewsItem newsItem = (NewsItem) listData.get(position);

		holder.headlineView.setText(newsItem.getyemekadi());
		
		

		if (holder.imageView != null) {
			new ImageDownloaderTask(holder.imageView).execute(newsItem.getUrl());
		}


		return convertView;
	}

	static class ViewHolder {
		TextView headlineView;
		TextView reporterNameView;
		TextView reportedDateView;
		ImageView imageView;
	}
}