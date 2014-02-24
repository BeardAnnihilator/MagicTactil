package com.magictactil.activities;

import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;

import com.actionbarsherlock.app.SherlockActivity;
import com.magictactil.app.R;

/**
 * Activity for the end of the game, tell the player he lost or won.
 * 
 * @author Benjamin
 *
 */
public class EndGameActivity extends SherlockActivity 
{
	private TextView			tv;
	private Button				btn;

	@Override
	public void 				onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.end_game);
		this.initSherlock();
		this.initWidgets();
		this.getExtra();
		this.initButtons();
	}

	/**
	 * Buttons initialization
	 */
	private void initButtons() 
	{
		this.btn.setOnClickListener(new OnClickListener() 
		{
			
			@Override
			public void onClick(View v) 
			{
				finish();
			}
		});
	}

	/**
	 * Getting extra (won or lost)
	 */
	private void getExtra()
	{
		if (getIntent().getExtras().getBoolean("won"))
			tv.setText(getString(R.string.game_won));
		else
			tv.setText(getString(R.string.game_lost));
	}

	/**
	 * Widgets initialization
	 */
	private void 				initWidgets() 
	{
		this.tv = (TextView) findViewById(R.id.tvEndGame);
		this.btn = (Button) findViewById(R.id.btnEndGame);
	}

	/**
	 * Sherlock initialization
	 */
	private void			initSherlock()
	{
		getSupportActionBar().setTitle(getString(R.string.end_game));
	}

}