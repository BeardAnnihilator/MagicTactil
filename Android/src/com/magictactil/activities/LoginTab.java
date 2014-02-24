package com.magictactil.activities;

import android.os.Bundle;
import android.support.v4.view.ViewPager;

import com.actionbarsherlock.app.ActionBar;
import com.actionbarsherlock.app.SherlockFragmentActivity;
import com.actionbarsherlock.view.MenuItem;
import com.magictactil.app.R;
import com.magictactil.fragments.SignInFragment;
import com.magictactil.fragments.SignUpFragment;
import com.magictactil.tabs.TabsAdapter;

/**
 * Login activity containing a sign in fragment and a sign up fragment
 * 
 * @author Benjamin
 *
 */
public class 			LoginTab extends SherlockFragmentActivity
{
	private ViewPager 	mViewPager;
	private TabsAdapter mTabsAdapter;
	
	@Override
	protected void 		onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		mViewPager = new ViewPager(this);
		mViewPager.setId(R.id.pager);
		setContentView(mViewPager);
		getSupportActionBar().setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);
		 
		mTabsAdapter = new TabsAdapter(this, mViewPager);
		mTabsAdapter.addTab(getSupportActionBar().newTab().setText(getString(R.string.sign_in)), SignInFragment.class, null);
		mTabsAdapter.addTab(getSupportActionBar().newTab().setText(getString(R.string.sign_up)), SignUpFragment.class, null);
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
}
