package com.magictactil.app.test;

import android.test.ActivityInstrumentationTestCase2;
import android.view.View;

import com.magictactil.activities.DeckCreateActivity;
import com.magictactil.activities.MenuTab;
import com.magictactil.app.MainActivity;
import com.magictactil.app.R;
import com.robotium.solo.Solo;

public class RobotiumTest extends ActivityInstrumentationTestCase2<MainActivity> 
{
	private Solo solo;

	public RobotiumTest() 
	{
		super(MainActivity.class);
	}

	public void setUp() throws Exception 
	{
		solo = new Solo(getInstrumentation(), getActivity());
	}

	public void testRobotium() throws Exception
	{
		solo.enterText(0, "test_account");
		solo.enterText(1, "aaaaaa");
		solo.clickOnButton(0);
		solo.assertCurrentActivity("", MenuTab.class);
		solo.scrollToSide(Solo.RIGHT);
		solo.scrollToSide(Solo.RIGHT);
		solo.scrollToSide(Solo.RIGHT);
		
		View actionbarItem1 = solo.getView(R.id.ID_ACTION_CREATE_DECK);
		solo.clickOnView(actionbarItem1);
		solo.assertCurrentActivity("Excepted Create deck", DeckCreateActivity.class);
		solo.enterText(0, "deck_test");
		solo.clickOnButton(0);
		assertTrue(solo.searchText(getActivity().getString(R.string.deck_create_ok)));
	}

	@Override
	public void tearDown() throws Exception 
	{
		solo.finishOpenedActivities();
	}
}