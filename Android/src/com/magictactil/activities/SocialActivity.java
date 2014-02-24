package com.magictactil.activities;

import android.os.Bundle;

import com.actionbarsherlock.app.SherlockFragmentActivity;
import com.magictactil.app.R;

/**
 * Activity for friend chatting
 * 
 * @author Benjamin
 *
 */
public class SocialActivity extends SherlockFragmentActivity
{
	@Override
	protected void 		onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.social);
	}
}
