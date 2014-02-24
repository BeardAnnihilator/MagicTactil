package com.magictactil.fragments;

import java.util.ArrayList;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.actionbarsherlock.app.SherlockListFragment;
import com.magictactil.activities.FriendActivity;
import com.magictactil.adapter.FriendAdapter;
import com.magictactil.app.R;
import com.magictactil.db.Friend;
import com.magictactil.network.FriendModule;
import com.magictactil.network.ResponseParser;

/**
 * Fragment listing the player's friends
 * 
 * @author Benjamin
 *
 */
public class 			FriendListFragment extends SherlockListFragment 
{
	View 				view = null;
	private FriendAdapter adapter;
	private ArrayList<Friend> list;

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) 
	{
		view = inflater.inflate(R.layout.friend_list, container, false);
		return view;
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
			this.updateFriends();
		super.setMenuVisibility(menuVisible);
	}

	@Override
	public void onListItemClick(ListView lv, View view, int position, long id) {
		super.onListItemClick(lv, view, position, id);
		Intent i = new Intent(getSherlockActivity(), FriendActivity.class);

		i.putExtra("friend", list.get(position));
		startActivity(i);
	}

	/**
	 * Get player friend list from the server
	 * 
	 */
	private void updateFriends() {
		Thread t = new Thread(new Runnable() {
			@Override
			public void run() {
				list = ResponseParser.parseFriends(FriendModule.getFriends());
				getSherlockActivity().runOnUiThread(new Runnable() {
					@Override
					public void run() {
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
	private void initListView() 
	{
		this.adapter = new FriendAdapter(getSherlockActivity(), list, null);
		this.adapter.setList(this.list);
		setListAdapter(adapter);
	}
}