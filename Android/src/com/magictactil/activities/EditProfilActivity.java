package com.magictactil.activities;

import android.app.ProgressDialog;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;

import com.actionbarsherlock.app.SherlockActivity;
import com.actionbarsherlock.view.MenuItem;
import com.magictactil.app.R;
import com.magictactil.model.User;
import com.magictactil.network.ProfilModule;
import com.magictactil.session.SessionMT;
import com.magictactil.utils.Utils;

/**
 * Activity for edit profile and change password
 * 
 * @author Benjamin
 *
 */
public class 					EditProfilActivity extends SherlockActivity 
{
	private Button				btn_update;
	private EditText			et_name;
	private EditText			et_pseudo;
	private EditText			et_email;
	private EditText			et_location;
	private EditText			et_phone;
	private RadioButton			rb_male;
	private ProgressDialog		progress_dialog;

	@Override
	public void 				onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.edit_profil);
		this.initSherlock();
		this.initWidgets();
		this.initButtons();
		this.initEditTexts();
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
	 * Widgets initialization
	 */
	private void				initWidgets()
	{
		this.btn_update = (Button) findViewById(R.id.btnEditUpdate);
		this.et_name = (EditText) findViewById(R.id.etLastName);
		this.et_pseudo = (EditText) findViewById(R.id.etPseudo);
		this.rb_male = (RadioButton) findViewById(R.id.rbMale);
		this.et_email = (EditText) findViewById(R.id.etEmail);
		this.et_location = (EditText) findViewById(R.id.etLocation);
		this.et_phone = (EditText) findViewById(R.id.etPhone);
	}

	/**
	 * Buttons initialization
	 */
	private void				initButtons()
	{
		this.btn_update.setOnClickListener(new OnClickListener() 
		{
			@Override
			public void onClick(View v) 
			{
				progress_dialog = Utils.createDialogProgressBar(getApplicationContext().getString(R.string.update), EditProfilActivity.this);
				Thread t = new Thread(new Runnable() 
				{
					@Override
					public void run() 
					{

						User		update_user = new User();

						update_user.setPseudo(et_pseudo.getText().toString());
						update_user.setLast_name(et_name.getText().toString());
						update_user.setMale(rb_male.isChecked());
						update_user.setEmail(et_email.getText().toString());
						update_user.setLocation(et_location.getText().toString());
						update_user.setPhone(et_phone.getText().toString());
						if (ProfilModule.editProfil(update_user))
						{
							SessionMT.current_user = update_user;
						}
						progress_dialog.cancel();
					}
				});
				t.start();
			}
		});
	}

	/**
	 * EditText initialization
	 */
	private void			initEditTexts()
	{
		this.et_pseudo.setText(SessionMT.current_user.getPseudo());
	}

	/**
	 * Sherlock initialization
	 */
	private void			initSherlock()
	{
		getSupportActionBar().setDisplayHomeAsUpEnabled(true);
		getSupportActionBar().setTitle(R.string.edit_profil);
	}
}
