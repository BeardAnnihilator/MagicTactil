package com.magictactil.fragments;

import java.util.ArrayList;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.actionbarsherlock.app.SherlockListFragment;
import com.magictactil.activities.RoomActivity;
import com.magictactil.adapter.RoomAdapter;
import com.magictactil.app.R;
import com.magictactil.model.Room;
import com.magictactil.network.RoomModule;

/**
 * Fragment listing the room
 * 
 * @author Benjamin
 *
 */
public class	 		GameFragment extends SherlockListFragment 
{
	private View				view = null;
	private RoomAdapter			adapter;
	private ArrayList<Room> 	list;
	
	@Override
	public View 			onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
	{
		view = inflater.inflate(R.layout.game, container, false);
		return (view);
	}
	
	@Override
	public void onResume() 
	{
		super.onResume();
	}

	@Override
	public void setMenuVisibility(boolean menuVisible) 
	{
		if (view != null && menuVisible)
			this.updateRooms();
		super.setMenuVisibility(menuVisible);
	}
	
	@Override
	public void 			onListItemClick(ListView lv, View view, int position, long id) 
	{
		super.onListItemClick(lv, view, position, id);
		Intent 				i = new Intent(getSherlockActivity(), RoomActivity.class);

		i.putExtra("room", list.get(position));
		startActivity(i);
	}
	
	/**
	 * Get rooms from the server
	 */
	private void updateRooms() 
	{
		Thread t = new Thread(new Runnable() 
		{
			@Override
			public void run() 
			{
				String	res = RoomModule.getAllRooms();
				list = RoomModule.parseRooms(res);
				getSherlockActivity().runOnUiThread(new Runnable() 
				{
					@Override
					public void run() 
					{
						initListView();
					}
				});
			}
		});
		t.start();
	}
	
	/**
	 * ListView initialization
	 */
	private void			initListView()
	{
		this.adapter = new RoomAdapter(getSherlockActivity(), list);
		this.adapter.setList(this.list);
		setListAdapter(adapter);
	}
}
