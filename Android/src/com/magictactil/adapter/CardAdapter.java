package com.magictactil.adapter;

import java.util.ArrayList;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ImageView;
import android.widget.TextView;

import com.magictactil.app.R;
import com.magictactil.model.Card;
import com.nostra13.universalimageloader.core.ImageLoader;

/**
 * Cards adapater for card listing
 * 
 * @author Benjamin
 *
 */
public class 				CardAdapter extends BaseAdapter implements Filterable
{
	private Context	 		context;
	private ArrayList<Card> list;
	
	/**
	 * @param context
	 * @param l, list of cards
	 */
	public 					CardAdapter(Context context, ArrayList<Card> l) 
	{
		this.context = context;
		this.list = l;
	}
 
	@Override
	public View 			getView(int position, View convertView, ViewGroup parent) 
	{
		final ImageView 	imageView;
		LayoutInflater 		inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		View 				gridView;
 
		if (convertView == null) 
		{
			gridView = new View(context);
			gridView = inflater.inflate(R.layout.deck_item, null);
		} 
		else 
		{
			gridView = (View) convertView;
		}
		imageView = (ImageView) gridView.findViewById(R.id.grid_item_image);
		TextView textView = (TextView) gridView.findViewById(R.id.grid_item_label);
		textView.setText(this.list.get(position).getName());
		imageView.setImageResource(R.drawable.card_back);
		ImageLoader.getInstance().displayImage(this.list.get(position).getSet().get(0).getPicUrl(), imageView);
		return gridView;
	}
 
	@Override
	public int getCount() 
	{
		return list.size();
	}
 
	@Override
	public Object getItem(int position) 
	{
		return null;
	}
 
	@Override
	public long getItemId(int position) 
	{
		return 0;
	}

	@Override
	public Filter getFilter()
	{
		return new Filter() 
		{
            @Override
            protected void publishResults(CharSequence constraint, FilterResults results) 
            {
                list = (ArrayList<Card>) results.values;
                CardAdapter.this.notifyDataSetChanged();
            }

            @Override
            protected FilterResults performFiltering(CharSequence constraint) 
            {
                ArrayList<Card> filteredResults = new ArrayList<Card>();

                for (int i = 0; i < list.size(); i++)
                {
                	if (list.get(i).getName().toLowerCase().contains(constraint.toString().toLowerCase()))
                		filteredResults.add(list.get(i));
                }
                FilterResults results = new FilterResults();
                results.values = filteredResults;

                return results;
            }
        };
	}
}