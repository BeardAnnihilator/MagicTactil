package com.magictactil.fragments;

import java.util.ArrayList;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.actionbarsherlock.app.SherlockListFragment;
import com.magictactil.activities.EventActivity;
import com.magictactil.adapter.EventAdapter;
import com.magictactil.app.R;
import com.magictactil.model.Event;
import com.magictactil.network.EventModule;
import com.magictactil.network.ResponseParser;

/**
 * Fragment listing the events
 * 
 * @author Benjamin
 *
 */
public class 					EventFragment extends SherlockListFragment
{
	private ArrayList<Event>	list;
	private EventAdapter		adapter;
	private View				view = null;
	
	@Override
	public View 			onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
	{
		view = inflater.inflate(R.layout.event_list, container, false);
		return (view);
	}

	@Override
	public void 			onResume() 
	{
		super.onResume();
	}

	@Override
	public void setMenuVisibility(boolean menuVisible) 
	{
		if (view != null && menuVisible)
			this.updateEvents();
		super.setMenuVisibility(menuVisible);
	}
	
	@Override
	public void 			onListItemClick(ListView lv, View view, int position, long id) 
	{
		super.onListItemClick(lv, view, position, id);
		Intent 				i = new Intent(getSherlockActivity(), EventActivity.class);

		i.putExtra("event_name", list.get(position).getName());
		startActivity(i);
	}
	
	/**
	 * Get events from the server
	 */
	private void			updateEvents()
	{
		Thread t = new Thread(new Runnable() 
		{
			@Override
			public void run() 
			{
				list = ResponseParser.parseEvents(EventModule.listEvents());
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
		this.adapter = new EventAdapter(getSherlockActivity(), list);
		this.adapter.setList(this.list);
		setListAdapter(adapter);
	}
}
