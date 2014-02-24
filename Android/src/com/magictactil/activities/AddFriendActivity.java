package com.magictactil.activities;

import android.app.ProgressDialog;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.actionbarsherlock.app.SherlockActivity;
import com.actionbarsherlock.view.MenuItem;
import com.magictactil.app.R;
import com.magictactil.network.FriendModule;

/**
 * Activity for friend adding
 * 
 * @author Benjamin
 *
 */
public class AddFriendActivity extends SherlockActivity 
{
	private Button				btn_add;
	private EditText			et_name;
	private ProgressDialog		progress_dialog;

	@Override
	public void 				onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.add_friend);
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
	 * Action Bar Sherlock initialization
	 */
	private void			initSherlock()
	{
		getSupportActionBar().setDisplayHomeAsUpEnabled(true);
		getSupportActionBar().setTitle(R.string.friend_add);
	}

	/**
	 * Widgets initialization
	 */
	private void				initWidgets()
	{
		this.btn_add = (Button) findViewById(R.id.btnAddFriend);
		this.et_name = (EditText) findViewById(R.id.etFriendName);
	}

	/**
	 * Buttons initialization
	 */
	private void				initButtons()
	{
		this.btn_add.setOnClickListener(new OnClickListener() 
		{
			@Override
			public void onClick(View v) 
			{
				createDialogProgressBar(getString(R.string.friend_adding));
				Thread t = new Thread(new Runnable() 
				{
					@Override
					public void run() 
					{
						String			name;

						name = et_name.getText().toString();
						if (FriendModule.AddFriend(name))
						{
							runOnUiThread(new Runnable() 
							{
								public void run() 
								{
									Toast.makeText(AddFriendActivity.this, getString(R.string.friend_added), Toast.LENGTH_LONG).show();
									progress_dialog.cancel();
								}
							});
							finish();
						}
						else
						{
							runOnUiThread(new Runnable() 
							{
								public void run() 
								{
									progress_dialog.cancel();
									Toast.makeText(AddFriendActivity.this, getString(R.string.friend_cant_add), Toast.LENGTH_LONG).show();
								}
							});
						}
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
}
