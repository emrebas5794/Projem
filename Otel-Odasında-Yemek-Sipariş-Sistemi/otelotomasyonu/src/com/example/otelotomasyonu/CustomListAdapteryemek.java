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

public class CustomListAdapteryemek extends BaseAdapter {

	private ArrayList<NewsItemyemek> listData;

	private LayoutInflater layoutInflater;

	public CustomListAdapteryemek(Context context, ArrayList<NewsItemyemek> listData) {
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
			convertView = layoutInflater.inflate(R.layout.yemekliste, null);
			holder = new ViewHolder();
			holder.headlineView = (TextView) convertView.findViewById(R.id.isim);
			holder.reporterNameViewv = (TextView) convertView.findViewById(R.id.yemeklistefiyat);
			
			holder.imageView1 = (ImageView) convertView.findViewById(R.id.resim);
			convertView.setTag(holder);
		} else {
			holder = (ViewHolder) convertView.getTag();
		}

		NewsItemyemek newsItemyemek = (NewsItemyemek) listData.get(position);

		holder.headlineView.setText(newsItemyemek.getyemekadi());
		holder.reporterNameViewv.setText(newsItemyemek.getyemekfiyat());
		
		

		if (holder.imageView1 != null) {
			new ImageDownloaderTaskyemek(holder.imageView1).execute(newsItemyemek.getUrl());
		}


		return convertView;
	}

	static class ViewHolder {
		TextView headlineView;
		TextView reporterNameViewv;
		TextView reportedDateView;
		ImageView imageView1;
	}
}
