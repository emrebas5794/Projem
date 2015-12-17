package com.example.otelservisyemekhane;


import java.util.ArrayList;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.otelservisyemekhane.R;

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
			convertView = layoutInflater.inflate(R.layout.yemekler, null);
			holder = new ViewHolder();
			holder.yemekadet = (TextView) convertView.findViewById(R.id.adet);
			holder.yemekadi = (TextView) convertView.findViewById(R.id.yemek);
			holder.odano = (TextView) convertView.findViewById(R.id.odano);
			
			convertView.setTag(holder);
		} else {
			holder = (ViewHolder) convertView.getTag();
		}

		NewsItem newsItem = (NewsItem) listData.get(position);

		holder.yemekadet.setText(newsItem.getyemekadet());
		holder.yemekadi.setText(newsItem.getyemekadi());
		holder.odano.setText(newsItem.getodano());
		
		

		

		return convertView;
	}

	static class ViewHolder {
		TextView yemekadi;
		TextView yemekadet;
		TextView odano;
	
	}
}