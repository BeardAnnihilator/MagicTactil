package com.magictactil.adapter;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.magictactil.app.R;
import com.magictactil.model.User;

/**
 * Adapter for players in room listing
 * 
 * @author Benjamin
 *
 */
public class 							RoomPlayerAdapter extends BaseAdapter 
{
	private List<User> 					list_item;
	private LayoutInflater 				mInflater;

	public 								RoomPlayerAdapter(Context context, List<User> list, String sort) 
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

	public void							setList(List<User> list)
	{
		this.list_item = list;
	}

	@Override
	public View 						getView(int position, View convertView, ViewGroup parent) 
	{
		LinearLayout 					layoutItem;
		
		if (convertView == null) 
		{
			layoutItem = (LinearLayout) mInflater.inflate(R.layout.friend_list_item, parent, false);
		} 
		else 
		{
			layoutItem = (LinearLayout) convertView;
		}
		TextView tv_name = (TextView)layoutItem.findViewById(R.id.tvFriendListName);
		ImageView iv = (ImageView)layoutItem.findViewById(R.id.imgFriendListItem);

		iv.setImageResource(R.drawable.dafault_profil);
		tv_name.setText(this.list_item.get(position).getPseudo());
		return (layoutItem);
	}
}
