package com.magictactil.adapter;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.magictactil.app.R;
import com.magictactil.model.Room;

/**
 * Adapter for room listing
 * 
 * @author Benjamin
 *
 */
public class 							RoomAdapter extends BaseAdapter
{
	private List<Room> 					list_item;
	private LayoutInflater 				mInflater;

	/**
	 * @param context
	 * @param list, list of room
	 */
	public 								RoomAdapter(Context context, List<Room> list) 
	{
		this.list_item = list;
		this.mInflater = LayoutInflater.from(context);
	}

	@Override
	public int 							getCount() 
	{
		return this.list_item.size();
	}

	@Override
	public Object 						getItem(int position) 
	{
		return this.list_item.get(position);
	}

	@Override
	public long 						getItemId(int position) 
	{
		return position;
	}

	/**
	 * Set list
	 * 
	 * @param list
	 */
	public void							setList(List<Room> list)
	{
		this.list_item = list;
	}

	@Override
	public View 						getView(int position, View convertView, ViewGroup parent) 
	{
		LinearLayout 					layoutItem;
		
		if (convertView == null) 
		{
			layoutItem = (LinearLayout) mInflater.inflate(R.layout.room_list_item, parent, false);
		} 
		else 
		{
			layoutItem = (LinearLayout) convertView;
		}
		TextView tv_name = (TextView)layoutItem.findViewById(R.id.tvRoomListName);
		tv_name.setText(this.list_item.get(position).getName());
		return (layoutItem);
	}
}
