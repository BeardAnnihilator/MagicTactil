package com.magictactil.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.magictactil.activities.LoginTab;
import com.magictactil.json.CardParser;
import com.magictactil.session.SessionMT;

/**
 * Activity loading the magic card database
 * 
 * @author Benjamin
 *
 */
public class 		MainActivity extends Activity 
{
	@Override
	public void 	onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.loading);
		SessionMT.cards = CardParser.parseCards(this);
		Intent i = new Intent(this, LoginTab.class);
		startActivity(i);
		this.finish();
	}
}
