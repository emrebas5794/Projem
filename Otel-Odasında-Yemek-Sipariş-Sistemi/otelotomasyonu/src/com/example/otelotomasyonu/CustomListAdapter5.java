package com.example.otelotomasyonu;

import java.util.ArrayList;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.otelotomasyonu.R;

public class CustomListAdapter5 extends BaseAdapter {

	private ArrayList<NewsItem5> listData;

	private LayoutInflater layoutInflater;

	public CustomListAdapter5(Context context, ArrayList<NewsItem5> listData) {
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
	String adet;
	public View getView(int position, View convertView, ViewGroup parent) {
		ViewHolder holder;
		
		if (convertView == null) {
			convertView = layoutInflater.inflate(R.layout.siparisliste, null);
			holder = new ViewHolder();
			holder.headlineView = (TextView) convertView.findViewById(R.id.yemekismi);
			
			holder.reportedDateView = (TextView) convertView.findViewById(R.id.adet);
			holder.reporterNameView = (TextView) convertView.findViewById(R.id.siparisyemekfiyati);
			holder.siparisarti = (ImageButton) convertView.findViewById(R.id.arti);
			holder.sipariseksi = (ImageButton) convertView.findViewById(R.id.eksi);
			
			convertView.setTag(holder);
		} else {
			holder = (ViewHolder) convertView.getTag();
		}

		NewsItem5 newsItemsiparis = (NewsItem5) listData.get(position);

		holder.headlineView.setText(newsItemsiparis.getyemekadi());
		
		holder.reportedDateView.setText(newsItemsiparis.getyemekadet());
		holder.reporterNameView.setText(newsItemsiparis.getyemekfiyatt());
	


		return convertView;
	}

	static class ViewHolder {
		TextView headlineView;
		TextView reporterNameView;
		TextView reportedDateView;
		ImageButton siparisarti;
		ImageButton sipariseksi;
		
	}
}
