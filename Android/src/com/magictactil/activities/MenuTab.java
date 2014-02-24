package com.magictactil.activities;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;

import com.actionbarsherlock.app.ActionBar;
import com.actionbarsherlock.app.SherlockFragmentActivity;
import com.actionbarsherlock.view.Menu;
import com.actionbarsherlock.view.MenuItem;
import com.magictactil.app.R;
import com.magictactil.fragments.DeckFragment;
import com.magictactil.fragments.EventFragment;
import com.magictactil.fragments.FriendListFragment;
import com.magictactil.fragments.GameFragment;
import com.magictactil.fragments.ProfilFragment;
import com.magictactil.tabs.TabsAdapter;

/**
 * Main connected activity containing 5 fragments: 
 * Profile
 * Friends
 * Events
 * Decks
 * Rooms
 * 
 * @author Benjamin
 *
 */
public class MenuTab extends SherlockFragmentActivity
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
		mTabsAdapter.addTab(getSupportActionBar().newTab().setText(getString(R.string.profile)), ProfilFragment.class, null);
		mTabsAdapter.addTab(getSupportActionBar().newTab().setText(getString(R.string.friends)), FriendListFragment.class, null);
		mTabsAdapter.addTab(getSupportActionBar().newTab().setText(getString(R.string.events)), EventFragment.class, null);
		mTabsAdapter.addTab(getSupportActionBar().newTab().setText(getString(R.string.deck)), DeckFragment.class, null);
		mTabsAdapter.addTab(getSupportActionBar().newTab().setText(getString(R.string.room)), GameFragment.class, null);
		mViewPager.setOnPageChangeListener(new OnPageChangeListener() 
		{
			@Override
			public void onPageSelected(int arg0) 
			{
				getSupportActionBar().setSelectedNavigationItem(arg0);
				supportInvalidateOptionsMenu();
			}
			
			@Override
			public void onPageScrolled(int arg0, float arg1, int arg2) 
			{
			}
			
			@Override
			public void onPageScrollStateChanged(int arg0) 
			{
			}
		});
	}

	@Override
	public boolean 					onOptionsItemSelected(MenuItem item) 
	{
		Intent 						i;
		
		switch (item.getItemId()) 
		{
		case R.id.ID_ACTION_NEW_EVENT:
			i = new Intent(getApplicationContext(), NewEventActivity.class);
			startActivity(i);
			break;
		case R.id.ID_ACTION_ADD_FRIEND:
			i = new Intent(getApplicationContext(), AddFriendActivity.class);
			startActivity(i);
			break;
		case R.id.ID_ACTION_EDIT_PROFIL:
			i = new Intent(getApplicationContext(), EditProfilActivity.class);
			startActivity(i);
			break;
		case R.id.ID_ACTION_CREATE_DECK:
			i = new Intent(getApplicationContext(), DeckCreateActivity.class);
			startActivity(i);
			break;
		case R.id.ID_ACTION_ROOM_CREATE:
			i = new Intent(getApplicationContext(), RoomCreateActivity.class);
			startActivity(i);
			break;
		default:
			return super.onOptionsItemSelected(item);
		}
		return super.onOptionsItemSelected(item);
	}

	@Override
	public boolean 					onCreateOptionsMenu(Menu menu) 
	{
		if (mViewPager.getCurrentItem() == 2)
			menu.add(0, R.id.ID_ACTION_NEW_EVENT, 0, getString(R.string.new_event)).setIcon(R.drawable.icon_new_event).setShowAsAction(MenuItem.SHOW_AS_ACTION_IF_ROOM | MenuItem.SHOW_AS_ACTION_WITH_TEXT);
		else if (mViewPager.getCurrentItem() == 1)
			menu.add(0, R.id.ID_ACTION_ADD_FRIEND, 0, getString(R.string.friend_add)).setIcon(R.drawable.icon_add_friend).setShowAsAction(MenuItem.SHOW_AS_ACTION_IF_ROOM | MenuItem.SHOW_AS_ACTION_WITH_TEXT);
		else if (mViewPager.getCurrentItem() == 0)
			menu.add(0, R.id.ID_ACTION_EDIT_PROFIL, 0, getString(R.string.edit_profil)).setIcon(R.drawable.icon_profil_edit).setShowAsAction(MenuItem.SHOW_AS_ACTION_IF_ROOM | MenuItem.SHOW_AS_ACTION_WITH_TEXT);
		else if (mViewPager.getCurrentItem() == 3)
			menu.add(0, R.id.ID_ACTION_CREATE_DECK, 0, getString(R.string.deck_create)).setIcon(R.drawable.icon_new_event).setShowAsAction(MenuItem.SHOW_AS_ACTION_IF_ROOM | MenuItem.SHOW_AS_ACTION_WITH_TEXT);
		else if (mViewPager.getCurrentItem() == 4)
			menu.add(0, R.id.ID_ACTION_ROOM_CREATE, 0, getString(R.string.room_create)).setIcon(R.drawable.icon_new_event).setShowAsAction(MenuItem.SHOW_AS_ACTION_IF_ROOM | MenuItem.SHOW_AS_ACTION_WITH_TEXT);
		return (super.onCreateOptionsMenu(menu));
	}
}