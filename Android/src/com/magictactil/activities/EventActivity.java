package com.magictactil.activities;

import android.app.ProgressDialog;
import android.graphics.Typeface;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.actionbarsherlock.app.SherlockActivity;
import com.actionbarsherlock.view.MenuItem;
import com.magictactil.app.R;
import com.magictactil.model.Event;
import com.magictactil.network.EventModule;
import com.magictactil.network.ResponseParser;

/**
 * Single event activity which describe the event and permit to subscribe to it 
 * 
 * @author Benjamin
 *
 */
public class 				EventActivity extends SherlockActivity 
{
	private Event			event;
	private boolean			signed = false;
	private TextView		tv_name;
	private TextView		tv_desc;
	private TextView		tv_date;
	private TextView		tv_location;
	private Button			btn_signup;
	private ProgressDialog	progress_dialog;

	@Override
	protected void 			onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.event);
		this.initSherlock();
		this.initWidgets();
		this.getExtras();
		this.initFont();
		this.checkSigned();
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
	 * Getting extra (Event)
	 */
	private void			getExtras()
	{
		event = new Event();

		event.setName(getIntent().getExtras().getString("event_name"));
	}

	/**
	 * Check if the pplayer is already signed to this event
	 */
	private void			checkSigned()
	{
		createDialogProgressBar(getString(R.string.get_event));
		Thread t = new Thread(new Runnable() 
		{
			@Override
			public void run() 
			{
				String res;

				signed = EventModule.IsSignedUp(event);
				res = EventModule.getEvent(event, EventActivity.this);
				event = ResponseParser.parseEvent(res);
				runOnUiThread(new Runnable() 
				{
					@Override
					public void run() 
					{
						initView();
						initButtons();
						progress_dialog.cancel();

					}
				});
			}
		});
		t.start();
	}

	/**
	 * View initialization (content)
	 */
	private void			initView()
	{
		this.tv_name.setText(event.getName());
		this.tv_desc.setText(event.getDescription());
		this.tv_date.setText(event.getDate());
		this.tv_location.setText(event.getLocation());
		if (signed)
			this.btn_signup.setText(getString(R.string.unsubscribe));
		else
			this.btn_signup.setText(getString(R.string.sing_up_ev));
	}

	/**
	 * Sherlock initialization
	 */
	private void			initSherlock()
	{
		getSupportActionBar().setDisplayHomeAsUpEnabled(true);
		getSupportActionBar().setTitle(R.string.event);
	}

	/**
	 * Widgets initialization
	 */
	private void			initWidgets()
	{
		this.tv_name = (TextView) findViewById(R.id.tvEventName);
		this.tv_desc = (TextView) findViewById(R.id.tvEventDesc);
		this.tv_date = (TextView) findViewById(R.id.tvEventDate);
		this.tv_location = (TextView) findViewById(R.id.tvEventLocation);
		this.btn_signup = (Button) findViewById(R.id.btnEventSignUp);
	}

	/**
	 * Buttons initialization
	 */
	private void			initButtons()
	{
		if (!signed)
		{
			this.btn_signup.setOnClickListener(new OnClickListener() 
			{
				@Override
				public void onClick(View v) 
				{
					createDialogProgressBar(getString(R.string.subsribing));
					Thread t = new Thread(new Runnable() 
					{
						@Override
						public void run() 
						{
							if (EventModule.SignUp(event))
								signed = true;
							runOnUiThread(new Runnable() 
							{
								@Override
								public void run() 
								{
									if (signed)
										Toast.makeText(EventActivity.this, getString(R.string.subscribe_success), Toast.LENGTH_LONG).show();

									initView();
									initButtons();
									progress_dialog.cancel();
								}
							});
						}
					});
					t.start();
				}
			});
		}
		else
			this.btn_signup.setOnClickListener(new OnClickListener() 
			{
				@Override
				public void onClick(View v) 
				{
					createDialogProgressBar(getString(R.string.unsubscribing));
					Thread t = new Thread(new Runnable() 
					{
						@Override
						public void run() 
						{
							if (EventModule.Unsubscribe(event))
								signed = false;
							runOnUiThread(new Runnable() 
							{
								@Override
								public void run() 
								{
									if (!signed)
										Toast.makeText(EventActivity.this, getString(R.string.unsubscribe_success), Toast.LENGTH_LONG).show();
									initView();
									initButtons();
									progress_dialog.cancel();
								}
							});
						}
					});
					t.start();
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
	 * Font initialization
	 */
	private void			initFont()
	{
		Typeface 			font;

		font = Typeface.createFromAsset(getAssets(), "Roboto-Condensed.ttf");

		this.tv_name.setTypeface(font);
		this.tv_desc.setTypeface(font);
		this.tv_location.setTypeface(font);
		this.tv_date.setTypeface(font);
	}
}
