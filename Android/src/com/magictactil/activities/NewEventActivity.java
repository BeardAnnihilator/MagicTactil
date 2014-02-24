package com.magictactil.activities;

import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.actionbarsherlock.app.SherlockActivity;
import com.actionbarsherlock.view.MenuItem;
import com.magictactil.app.R;
import com.magictactil.model.Event;
import com.magictactil.network.EventModule;
import com.magictactil.session.SessionMT;

/**
 * Activity for event creation
 * 
 * @author Benjamin
 *
 */
public class 					NewEventActivity extends SherlockActivity 
{
	private Button				btn_create;
	private EditText			et_name;
	private EditText			et_desc;

	@Override
	public void 				onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.new_event);
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
	 * Widgets initialization
	 */
	private void				initWidgets()
	{
		this.btn_create = (Button) findViewById(R.id.btnEventCreate);
		this.et_name	= (EditText) findViewById(R.id.etEventName);
		this.et_desc = (EditText) findViewById(R.id.etEventDesc);
	}

	/**
	 * Buttons initialization
	 */
	private void				initButtons()
	{
		this.btn_create.setOnClickListener(new OnClickListener() 
		{
			@Override
			public void onClick(View v) 
			{
				Thread t = new Thread(new Runnable() 
				{
					@Override
					public void run() 
					{
						Event			event = new Event();
						String			name;
						String			desc;

						name = et_name.getText().toString();
						desc = et_desc.getText().toString();
						event.setName(name);
						event.setCreator(SessionMT.current_user.getPseudo());
						event.setDate("14/02/2014");
						event.setDescription(desc);
						event.setLocation("Marseille");
						if (EventModule.createEvent(event))
						{
							runOnUiThread(new Runnable() 
							{
								@Override
								public void run() 
								{
									Toast.makeText(NewEventActivity.this, getString(R.string.event_created), Toast.LENGTH_LONG).show();
								}
							});
							finish();
						}
					}
				});
				t.start();
			}
		});
	}

	/**
	 * Sherlock initialization
	 */
	private void			initSherlock()
	{
		getSupportActionBar().setDisplayHomeAsUpEnabled(true);
		getSupportActionBar().setTitle(R.string.new_event);
	}
}
