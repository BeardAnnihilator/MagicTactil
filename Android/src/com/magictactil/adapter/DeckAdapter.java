package com.magictactil.adapter;

import java.util.ArrayList;

import com.magictactil.app.R;
import com.magictactil.model.Deck;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

/**
 * Adapter for deck listing 
 * 
 * @author Benjamin
 *
 */
public class 				DeckAdapter extends BaseAdapter
{
	private Context	 		context;
	private ArrayList<Deck> list;
	
	/**
	 * @param context
	 * @param l, list of the decks
	 */
	public 					DeckAdapter(Context context, ArrayList<Deck> l) 
	{
		this.context = context;
		this.list = l;
	}
 
	@Override
	public View 			getView(int position, View convertView, ViewGroup parent) 
	{
		LayoutInflater 		inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		View 				gridView;
 
		if (convertView == null) 
		{
			gridView = new View(context);
			gridView = inflater.inflate(R.layout.deck_item, null);
 
			TextView textView = (TextView) gridView.findViewById(R.id.grid_item_label);
			textView.setText(this.list.get(position).getName());
 
			ImageView imageView = (ImageView) gridView.findViewById(R.id.grid_item_image);
			imageView.setImageResource(R.drawable.card_back);
		} 
		else 
		{
			gridView = (View) convertView;
		}
 
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
}
