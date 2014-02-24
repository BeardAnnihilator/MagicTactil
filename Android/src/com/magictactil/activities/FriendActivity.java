package com.magictactil.activities;

import android.app.ProgressDialog;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.actionbarsherlock.app.SherlockActivity;
import com.actionbarsherlock.view.MenuItem;
import com.magictactil.app.R;
import com.magictactil.db.Friend;
import com.magictactil.network.FriendModule;

/**
 * Friend activity showing a particular friend and permit to remove him from the player's friend list
 * 
 * @author Benjamin
 *
 */
public class 				FriendActivity extends SherlockActivity 
{
	private Friend			friend;
	private TextView		tv_name;
	private Button			btn_delete;
	private ProgressDialog	progress_dialog;
	
	@Override
	protected void 			onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.friend);
		this.initSherlock();
		this.initWidgets();
		this.getExtras();
		this.initView();
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
	 * Getting extra (friend)
	 */
	private void			getExtras()
	{
		friend = (Friend) getIntent().getExtras().get("friend");
	}
	
	/**
	 * View initialization (content)
	 */
	private void			initView()
	{
		this.tv_name.setText(friend.getPseudo());
	}
	
	/**
	 * Sherlock initialization
	 */
	private void			initSherlock()
	{
		getSupportActionBar().setDisplayHomeAsUpEnabled(true);
		getSupportActionBar().setTitle(R.string.friend);
	}

	/**
	 * Widgets initialization
	 */
	private void			initWidgets()
	{
		this.tv_name = (TextView) findViewById(R.id.tvFriendName);
		this.btn_delete = (Button) findViewById(R.id.btnDeleteFriend);
	}
	
	/**
	 * Buttons initialization
	 */
	private void 			initButtons()
	{
		this.btn_delete.setOnClickListener(new OnClickListener() 
		{
			@Override
			public void onClick(View v) 
			{
				createDialogProgressBar(getString(R.string.friend_deleting));
				Thread t = new Thread(new Runnable() 
				{
					@Override
					public void 	run()
					{
						if (FriendModule.DeleteFriend(friend))
						{
							runOnUiThread(new Runnable() 
							{
								public void run() 
								{
									Toast.makeText(FriendActivity.this, getString(R.string.friend_deleted), Toast.LENGTH_LONG).show();
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
									Toast.makeText(FriendActivity.this, getString(R.string.friend_cant_delete), Toast.LENGTH_LONG).show();
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
