package com.magictactil.tabs;

import java.util.ArrayList;
import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.view.ViewPager;
import com.actionbarsherlock.app.ActionBar;
import com.actionbarsherlock.app.ActionBar.Tab;
import com.actionbarsherlock.app.SherlockFragmentActivity;

public class 							TabsAdapter extends FragmentPagerAdapter implements ActionBar.TabListener, ViewPager.OnPageChangeListener
{
	private final Context 				context;
	private final ActionBar			 	action_bar;
	private final ViewPager 			view_pager;
	private final ArrayList<Class<?>> 	tabs = new ArrayList<Class<?>>();
	
	public 								TabsAdapter(SherlockFragmentActivity activity, ViewPager pager) 
	{
		super(activity.getSupportFragmentManager());
		this.context = activity;
		this.view_pager = pager;
		this.view_pager.setAdapter(this);
		this.view_pager.setOnPageChangeListener(this);
		this.action_bar = activity.getSupportActionBar();
	}

	public void 						addTab(ActionBar.Tab tab, Class<?> clss, Bundle args) 
	{
		Class<?> info = clss;
		tabs.add(info);
		tab.setTag(info);
		tab.setTabListener(this);
		this.action_bar.addTab(tab);
		notifyDataSetChanged();
	}
	
	@Override
	public Fragment 					getItem(int pos) 
	{
		Class<?>						tab = this.tabs.get(pos);
		
		return (Fragment.instantiate(context, tab.getName()));
	}

	@Override
	public int 							getCount() 
	{
		return (this.tabs.size());
	}

	@Override
	public void 						onTabSelected(Tab tab, FragmentTransaction ft) 
	{
		Object 							tag = tab.getTag();
	
		for (int i=0; i< tabs.size(); i++) 
		{
			if (tabs.get(i) == tag) 
			{
				view_pager.setCurrentItem(i);
			}
		}
	}

	@Override
	public void 						onTabUnselected(Tab tab, FragmentTransaction ft) 
	{
	}

	@Override
	public void 						onTabReselected(Tab tab, FragmentTransaction ft) 
	{
	}

	@Override
	public void 						onPageScrollStateChanged(int arg0) 
	{
	}

	@Override
	public void 						onPageScrolled(int arg0, float arg1, int arg2) 
	{
	}

	@Override
	public void 						onPageSelected(int position) 
	{
		this.action_bar.setSelectedNavigationItem(position);
	}
}
