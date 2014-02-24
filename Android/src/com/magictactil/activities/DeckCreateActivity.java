package com.magictactil.activities;

import java.lang.ref.WeakReference;

import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Toast;

import com.actionbarsherlock.app.SherlockActivity;
import com.actionbarsherlock.view.MenuItem;
import com.magictactil.app.R;
import com.magictactil.model.Deck;
import com.magictactil.network.DeckModule;

/**
 * Activity for deck creation
 * 
 * @author Benjamin
 *
 */
public class 			DeckCreateActivity extends SherlockActivity 
{
	private Button				btn_add;
	private EditText			et_name;
	private CheckBox			cb_real;
	private ProgressDialog		progress_dialog;

	@Override
	public void 				onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.deck_create);
		this.initSherlock();
		this.initWidgets();
		this.initButtons();
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
	
	/**
	 * Sherlock initialization
	 */
	private void			initSherlock()
	{
		getSupportActionBar().setDisplayHomeAsUpEnabled(true);
		getSupportActionBar().setTitle(R.string.deck_create);
	}

	/**
	 * Widgets initialization
	 */
	private void				initWidgets()
	{
		this.btn_add = (Button) findViewById(R.id.btnDeckCreate);
		this.et_name = (EditText) findViewById(R.id.etDeckName);
		this.cb_real = (CheckBox) findViewById(R.id.cbDeckReal);
	}

	/**
	 * Buttons initilizations
	 */
	private void				initButtons()
	{
		this.btn_add.setOnClickListener(new OnClickListener() 
		{
			@Override
			public void onClick(View v) 
			{
				Deck			deck;
				CreateDeckTask	task;
				
				deck = new Deck();
				deck.setName(et_name.getText().toString());
				deck.setReal(cb_real.isChecked());
				task = new CreateDeckTask(DeckCreateActivity.this, deck);
				task.execute();
			}
		});
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
	 * Async task for deck creation on the server
	 * 
	 * @author Benjamin
	 *
	 */
	static class										CreateDeckTask extends AsyncTask<Void, Integer, Boolean>
	{
		private WeakReference<DeckCreateActivity> 		activity = null;
		private Deck									deck;
		private Boolean									res;

		/**
		 * @param act, Activity
		 * @param deck, Deck to create
		 */
		public 											CreateDeckTask(DeckCreateActivity act, Deck deck)
		{
			this.link(act);	
			this.deck = deck;
		}

		@Override
		protected void 									onPreExecute() 
		{
			if (this.activity.get() != null)
				this.activity.get().createDialogProgressBar(this.activity.get().getString(R.string.deck_creation));
		}

		@Override
		protected Boolean 								doInBackground(Void... params) 
		{
			res = DeckModule.createDeck(deck);
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
					Toast.makeText(this.activity.get(), this.activity.get().getString(R.string.deck_create_ok), Toast.LENGTH_LONG).show();
					this.activity.get().finish();
				}
				else
				{
					Toast.makeText(this.activity.get(), this.activity.get().getString(R.string.deck_create_ko), Toast.LENGTH_LONG).show();
				}
			}
		}
		
		/**
		 * Link activity with weak reference, activity could be destroyed during task 
		 * 
		 * @param act, activity
		 */
		public void 									link(DeckCreateActivity act) 
		{
			this.activity = new WeakReference<DeckCreateActivity>(act);
		}
	}
}
