package com.example.otelserviseleman;


import java.util.ArrayList;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.otelserviseleman.R;

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
			convertView = layoutInflater.inflate(R.layout.servis, null);
			holder = new ViewHolder();
			
			holder.odano = (TextView) convertView.findViewById(R.id.yemek);
			
			convertView.setTag(holder);
		} else {
			holder = (ViewHolder) convertView.getTag();
		}

		NewsItem newsItem = (NewsItem) listData.get(position);

		
		holder.odano.setText(newsItem.getodano());
		
		

		

		return convertView;
	}

	static class ViewHolder {
		TextView yemekadi;
		TextView yemekadet;
		TextView odano;
	
	}
}