package com.magictactil.activities;

import java.lang.ref.WeakReference;

import android.app.ProgressDialog;
import android.app.SearchManager;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.GridView;
import android.widget.Toast;

import com.actionbarsherlock.app.SherlockActivity;
import com.actionbarsherlock.view.Menu;
import com.actionbarsherlock.view.MenuInflater;
import com.actionbarsherlock.view.MenuItem;
import com.actionbarsherlock.widget.SearchView;
import com.magictactil.adapter.CardAdapter;
import com.magictactil.app.R;
import com.magictactil.model.Card;
import com.magictactil.model.Deck;
import com.magictactil.network.CardModule;
import com.magictactil.session.SessionMT;
import com.magictactil.utils.Constants;

/**
 * Activity for adding cards in deck
 * 
 * @author Benjamin
 *
 */
public class 					CardAddActivity extends SherlockActivity 
{
	private GridView			gv_cards;
	private ProgressDialog 		progress_dialog;
	private Deck				deck;
	private CardAdapter			adapter;
	
	@Override
	public void 				onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.card_add);
		this.getExtra();
		this.initSherlock();
		this.initWidgets();
		this.initGridView();	
		this.checkIntent(getIntent());
	}

	/**
	 * Get extra (deck)
	 */
	private void getExtra()
	{
		deck = (Deck) getIntent().getSerializableExtra("deck");
	}

	/**
	 * Initialize grid view
	 */
	private void 				initGridView() 
	{
		adapter = new CardAdapter(this, SessionMT.cards);
		gv_cards.setAdapter(adapter);
		gv_cards.setOnItemClickListener(new OnItemClickListener() 
		{
			public void onItemClick(AdapterView<?> parent, View v, int position, long id) 
			{
				AddCardTask	task;
				Card		card;
				
				card = SessionMT.cards.get(position);
				task = new AddCardTask(CardAddActivity.this, deck, card);
				task.execute();
			}
		});
	}

	/**
	 * Widgets initialization
	 */
	private void 				initWidgets() 
	{
		this.gv_cards = (GridView) findViewById(R.id.gvCards);
	}

	@Override
	public boolean 					onOptionsItemSelected(MenuItem item) 
	{
		switch (item.getItemId()) 
		{
		case android.R.id.home:
			finish();
			return true;
		default:
			return super.onOptionsItemSelected(item);
		}
	}
	
	@Override
	public boolean 					onCreateOptionsMenu(Menu menu) 
	{
		MenuInflater 				inflater = getSupportMenuInflater();
		SearchManager 				searchManager;
		SearchView 					searchView;
	    
		inflater.inflate(R.menu.search, menu);
	    searchManager = (SearchManager) getSystemService(Context.SEARCH_SERVICE);
	    searchView = (SearchView) menu.findItem(R.id.search).getActionView();
	    searchView.setSearchableInfo(searchManager.getSearchableInfo(getComponentName()));
		return (super.onCreateOptionsMenu(menu));
	}

	@Override
	protected void onNewIntent(Intent intent) 
	{
		checkIntent(intent);
		super.onNewIntent(intent);
	}

	/**
	 * Check search intent and filter the cards
	 * 
	 * @param intent, search intent
	 */
	private void checkIntent(Intent intent) 
	{
		if (Intent.ACTION_SEARCH.equals(intent.getAction()))
		{
            String query = intent.getStringExtra(SearchManager.QUERY);
            Log.e(Constants.TAG, "Search" + query);
            adapter.getFilter().filter(query);
            //use the query to search your data somehow
        }		
	}

	/**
	 * Action Bar Sherlock initialization
	 */
	private void			initSherlock()
	{
		getSupportActionBar().setDisplayHomeAsUpEnabled(true);
		getSupportActionBar().setTitle(getString(R.string.deck_add_card));
	}

	/**
	 * Create the progress bar dialog
	 * 
	 * @param mess
	 */
	private void 					createDialogProgressBar(String mess)
	{
		this.progress_dialog = new ProgressDialog(this);
		this.progress_dialog.setMessage(mess);
		this.progress_dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
		this.progress_dialog.setIndeterminate(true);
		this.progress_dialog.setCancelable(false);
		this.progress_dialog.show();
	}
	
	/**
	 * AsyncTask for adding card in the deck on the server
	 * 
	 * @author Benjamin
	 *
	 */
	static class										AddCardTask extends AsyncTask<Void, Integer, Boolean>
	{
		private WeakReference<CardAddActivity> 			activity = null;
		private Deck									deck;
		private Card									card;
		private Boolean									res;

		/**
		 * @param act, activity
		 * @param deck, deck 
		 * @param card, card to add to the deck
		 */
		public 											AddCardTask(CardAddActivity act, Deck deck, Card card)
		{
			this.link(act);	
			this.deck = deck;
			this.card = card;
		}

		@Override
		protected void 									onPreExecute() 
		{
			if (this.activity.get() != null)
				this.activity.get().createDialogProgressBar(this.activity.get().getString(R.string.deck_adding_card));
		}

		@Override
		protected Boolean 								doInBackground(Void... params) 
		{
			res = CardModule.addCardToDeck(card, deck);
			return null;
		}

		@Override
		protected void 									onPostExecute(Boolean result) 
		{
			if (this.activity.get() != null)
			{
				this.activity.get().progress_dialog.cancel();
				if (res)
				{
					Toast.makeText(this.activity.get(), this.activity.get().getString(R.string.deck_adding_card_ok), Toast.LENGTH_LONG).show();
				}
				else
				{
					Toast.makeText(this.activity.get(), this.activity.get().getString(R.string.deck_adding_card_ko), Toast.LENGTH_LONG).show();
				}
			}
		}
		
		/**
		 * Link activity with weak reference, activity could be destroyed during task 
		 * 
		 * @param act, activity
		 */
		public void 									link(CardAddActivity act) 
		{
			this.activity = new WeakReference<CardAddActivity>(act);
		}
	}
}
