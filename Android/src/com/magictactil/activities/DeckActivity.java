package com.magictactil.activities;

import java.lang.ref.WeakReference;
import java.util.ArrayList;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.widget.GridView;

import com.actionbarsherlock.app.SherlockActivity;
import com.actionbarsherlock.view.Menu;
import com.actionbarsherlock.view.MenuItem;
import com.magictactil.adapter.CardAdapter;
import com.magictactil.app.R;
import com.magictactil.model.Card;
import com.magictactil.model.Deck;
import com.magictactil.network.DeckModule;
import com.magictactil.session.SessionMT;

/**
 * Deck activity : list the deck's card and a link to cards adding
 * 
 * @author Benjamin
 *
 */
public class 					DeckActivity extends SherlockActivity 
{
	private GridView			gv_cards;
	private Deck				deck;
	private ProgressDialog		progress_dialog;

	@Override
	public void 				onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.deck);
		this.getExtra();
		this.initSherlock();
		this.initWidgets();
		GetCardsTask task = new GetCardsTask(this, deck);
		task.execute();
	}
	
	/**
	 * Widgets initialization
	 */
	private void 				initWidgets() 
	{
		this.gv_cards = (GridView) findViewById(R.id.gvDeckCards);
	}

	/**
	 * Get extra (deck)
	 */
	private void getExtra() 
	{
		deck = (Deck) getIntent().getExtras().get("deck");
	}

	@Override
	public boolean 					onOptionsItemSelected(MenuItem item) 
	{
		switch (item.getItemId()) 
		{
		case R.id.ID_ACTION_DECK_ADD_CARD:
			Intent i = new Intent(getApplicationContext(), CardAddActivity.class);
			i.putExtra("deck", deck);
			startActivity(i);
			return true;
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
		menu.add(0, R.id.ID_ACTION_DECK_ADD_CARD, 0, getString(R.string.deck_add_card)).setIcon(R.drawable.icon_new_event).setShowAsAction(MenuItem.SHOW_AS_ACTION_IF_ROOM | MenuItem.SHOW_AS_ACTION_WITH_TEXT);
		return (super.onCreateOptionsMenu(menu));
	}

	/**
	 * Create the progress bar dialog
	 * 
	 * @param mess, message to be displayed
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
	 * Sherlock initialization
	 */
	private void			initSherlock()
	{
		getSupportActionBar().setDisplayHomeAsUpEnabled(true);
		getSupportActionBar().setTitle(deck.getName());
	}
	
	/**
	 * Qsync task for getting the deck's cards from the server
	 * 
	 * @author Benjamin
	 *
	 */
	static class										GetCardsTask extends AsyncTask<Void, Integer, Boolean>
	{
		private WeakReference<DeckActivity> 			activity = null;
		private String									res;
		private Deck									deck;
		private ArrayList<Card> 						cards;

		/**
		 * @param act, Activity
		 * @param deck, Deck to list cards
		 */
		public 											GetCardsTask(DeckActivity act, Deck deck)
		{
			this.link(act);	
			this.deck = deck;
		}

		@Override
		protected void 									onPreExecute() 
		{
			if (this.activity.get() != null)
				this.activity.get().createDialogProgressBar(this.activity.get().getString(R.string.deck_getting_cards));
		}

		@Override
		protected Boolean 								doInBackground(Void... params) 
		{
			res = DeckModule.getCardsOfDeck(deck);
			cards = DeckModule.parseCards(res);
			return null;
		}

		@Override
		protected void 									onPostExecute(Boolean result) 
		{
			if (this.activity.get() != null)
			{
				this.activity.get().setList(cards);
				this.activity.get().progress_dialog.cancel();
			}
		}
		
		/**
		 * Link activity with weak reference, activity could be destroyed during task 
		 * 
		 * @param act, activity
		 */
		public void 									link(DeckActivity act) 
		{
			this.activity = new WeakReference<DeckActivity>(act);
		}
	}

	/**
	 * Set a new list of cards and display it
	 * 
	 * @param parseCards, new list of cards
	 */
	public void setList(ArrayList<Card> parseCards) 
	{
		this.deck.setCards(parseCards);
		gv_cards.setAdapter(new CardAdapter(this, this.deck.getCards()));
		SessionMT.current_deck = this.deck;
	}
}
