package com.magictactil.fragments;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.actionbarsherlock.app.SherlockFragment;
import com.magictactil.activities.MenuTab;
import com.magictactil.app.R;
import com.magictactil.network.NetworkModule;
import com.magictactil.session.SessionMT;

/**
 * Sign up fragment
 * 
 * @author Drakkin
 *
 */
public class 				SignUpFragment extends SherlockFragment
{
	private View			view;
	private Button			btn_signup;
	private EditText		et_email;
	private EditText		et_username;
	private EditText		et_pwd1;
	private EditText		et_pwd2;
	private ProgressDialog	progress_dialog;

	@Override
	public View 		onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
	{
		view = inflater.inflate(R.layout.signup, container, false);
		this.initWidgets();
		this.initButtons();
		return (view);
	}

	/**
	 * Widgets initialization
	 */
	private void		initWidgets()
	{
		this.btn_signup = (Button) view.findViewById(R.id.btnSignUp);
		this.et_email = (EditText) view.findViewById(R.id.etSignUpEmail);
		this.et_username = (EditText) view.findViewById(R.id.etSignUpUsername);
		this.et_pwd1 = (EditText) view.findViewById(R.id.etSignUpPassword);
		this.et_pwd2 = (EditText) view.findViewById(R.id.etSignUpCPassword);
	}

	/**
	 * Buttons initialization
	 */
	private void		initButtons()
	{
		this.btn_signup.setOnClickListener(new OnClickListener() 
		{
			@Override
			public void onClick(View v) 
			{
				String	email = et_email.getText().toString();
				String	username = et_username.getText().toString();
				String	pwd1 = et_pwd1.getText().toString();
				String	pwd2 = et_pwd2.getText().toString();

				if (!email.equals("") && !username.equals("") && !pwd1.equals("") && !pwd2.equals(""))
				{
					if (pwd1.equals(pwd2))
					{
						createDialogProgressBar(getString(R.string.sign_up_load));
						Thread t = new Thread(new Runnable() 
						{
							@Override
							public void run() 
							{
								boolean		res;
								final String		msg;

								res = NetworkModule.sendRegu(et_email.getText().toString(), et_pwd1.getText().toString(), et_username.getText().toString());
								progress_dialog.cancel();
								if (res)
									msg = getString(R.string.signup_ok);
								else
									msg = getString(R.string.signup_ko);
								getActivity().runOnUiThread(new Runnable() 
								{
									@Override
									public void run() 
									{
										Toast.makeText(getActivity(), msg, Toast.LENGTH_LONG).show();
									}
								});
								if (res)
								{
									SessionMT.current_user.setPseudo(et_username.getText().toString());
									Intent i = new Intent(getActivity(), MenuTab.class);

									startActivity(i);
									getActivity().finish();
								}
							}
						});
						t.start();
					}
					else
						Toast.makeText(getActivity(), getString(R.string.pwd_same), Toast.LENGTH_LONG).show();
				}
				else
					Toast.makeText(getActivity(), getString(R.string.plz_fillin), Toast.LENGTH_LONG).show();
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
		this.progress_dialog = new ProgressDialog(getActivity());
		this.progress_dialog.setMessage(mess);
		this.progress_dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
		this.progress_dialog.setIndeterminate(true);
		this.progress_dialog.setCancelable(false);
		this.progress_dialog.show();
	}
}
