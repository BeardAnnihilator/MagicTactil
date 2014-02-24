package com.magictactil.fragments;

import java.util.ArrayList;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.GridView;
import android.widget.ProgressBar;

import com.actionbarsherlock.app.SherlockFragment;
import com.magictactil.activities.DeckActivity;
import com.magictactil.adapter.DeckAdapter;
import com.magictactil.app.R;
import com.magictactil.model.Deck;
import com.magictactil.network.DeckModule;

/**
 * Deck fragment for deck listing
 * 
 * @author Benjamin
 *
 */
public class 				DeckFragment extends SherlockFragment 
{
	private View				view = null;
	private ArrayList<Deck> 	list;
	private ProgressBar			pb;
	private GridView			gv_decks;

	@Override
	public View 			onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
	{
		view = inflater.inflate(R.layout.decks, container, false);
		this.initWidgets();
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
			this.updateDecks();
		super.setMenuVisibility(menuVisible);
	}

	/**
	 * Widgets initilization
	 */
	private void			initWidgets()
	{
		this.gv_decks = (GridView) view.findViewById(R.id.gvDecks);
		this.pb = (ProgressBar) view.findViewById(R.id.pbDeck);
	}

	/**
	 * Refresh the grid view
	 */
	private void			refreshGridView()
	{
		gv_decks.setAdapter(new DeckAdapter(getSherlockActivity(), list));

		gv_decks.setOnItemClickListener(new OnItemClickListener() 
		{
			public void onItemClick(AdapterView<?> parent, View v, int position, long id) 
			{
				Intent i = new Intent(getSherlockActivity(), DeckActivity.class);
				Deck		selected_deck;

				selected_deck = list.get(position);
				i.putExtra("deck", selected_deck);
				startActivity(i);
			}
		});
	}

	/**
	 * Getting deck list in the server
	 */
	private void			updateDecks()
	{
		Thread t = new Thread(new Runnable() 
		{
			@Override
			public void run() 
			{
				getSherlockActivity().runOnUiThread(new Runnable() 
				{
					@Override
					public void run() 
					{
						pb.setVisibility(View.VISIBLE);
					}
				});

				String	res = DeckModule.getMyDecks();
				list = DeckModule.parseDecks(res);

				getSherlockActivity().runOnUiThread(new Runnable() 
				{
					@Override
					public void run() 
					{
						pb.setVisibility(View.GONE);
						refreshGridView();
					}
				});
			}
		});
		t.start();
	}
}
