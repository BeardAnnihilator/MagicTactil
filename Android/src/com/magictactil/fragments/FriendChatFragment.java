package com.magictactil.fragments;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.actionbarsherlock.app.SherlockFragment;
import com.magictactil.app.R;

/**
 * Chat fragment
 * 
 * @author Benjamin
 *
 */
public class 			FriendChatFragment extends SherlockFragment
{
	View				view;
	
	@Override
	public View 			onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
	{
		view = inflater.inflate(R.layout.friend_chat, container, false);
		return view;
	}
}
