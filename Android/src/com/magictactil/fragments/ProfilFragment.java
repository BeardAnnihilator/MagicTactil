package com.magictactil.fragments;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.actionbarsherlock.app.SherlockFragment;
import com.magictactil.app.R;
import com.magictactil.session.SessionMT;

/**
 * Fragemnt showing player informations
 * 
 * @author Benjamin
 *
 */
public class 			ProfilFragment extends SherlockFragment
{
	private View		view;
	private TextView	tv_email;
	private TextView	tv_pseudo;
	private TextView	tv_last_name;
	private TextView	tv_phone;
	private TextView	tv_location;
	private ImageView	ivAvatar;
	
	@Override
	public View 			onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
	{
		view = inflater.inflate(R.layout.profil, container, false);
		this.initWidgets();
		return (view);
	}
	
	@Override
	public void onResume() 
	{
		initProfil();
		super.onResume();
	}

	/**
	 * Widgets initilization
	 */
	private void			initWidgets()
	{
		this.tv_email = (TextView) view.findViewById(R.id.tvEmail);
		this.tv_pseudo = (TextView) view.findViewById(R.id.tvPseudo);
		this.tv_last_name = (TextView) view.findViewById(R.id.tvlastName);
		this.tv_phone = (TextView) view.findViewById(R.id.tvPhone);
		this.ivAvatar = (ImageView) view.findViewById(R.id.ivProfil);
		this.tv_location = (TextView) view.findViewById(R.id.tvLocation);
	}

	/**
	 * View initialization
	 */
	private void			initProfil()
	{
		if (!SessionMT.current_user.isMale())
			this.ivAvatar.setImageResource(R.drawable.default_female);
		this.tv_email.setText(SessionMT.current_user.getEmail());
		this.tv_pseudo.setText(SessionMT.current_user.getPseudo());		
		this.tv_last_name.setText(SessionMT.current_user.getLast_name());
		this.tv_phone.setText(SessionMT.current_user.getPhone());
		this.tv_location.setText(SessionMT.current_user.getLocation());
	}
}
