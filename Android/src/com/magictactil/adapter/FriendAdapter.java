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
import com.magictactil.db.Friend;

/**
 * Friends adapter for friend listing
 * 
 * @author Drakkin
 *
 */
public class 							FriendAdapter extends BaseAdapter 
{
	private List<Friend> 				list_item;
	private LayoutInflater 				mInflater;

	/**
	 * @param context
	 * @param list, list of friend
	 * @param sort, sort type
	 */
	public 								FriendAdapter(Context context, List<Friend> list, String sort) 
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
	 * set list
	 * 
	 * @param list
	 */
	public void							setList(List<Friend> list)
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
