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
import android.widget.ImageView;
import android.widget.Toast;

import com.actionbarsherlock.app.SherlockFragment;
import com.facebook.Request;
import com.facebook.Response;
import com.facebook.Session;
import com.facebook.SessionState;
import com.facebook.model.GraphUser;
import com.magictactil.activities.MenuTab;
import com.magictactil.app.R;
import com.magictactil.network.NetworkModule;
import com.magictactil.network.ProfilModule;
import com.magictactil.network.ResponseParser;
import com.magictactil.session.SessionMT;

/**
 * Sign in Fragment
 * 
 * @author Drakkin
 *
 */
public class 				SignInFragment extends SherlockFragment
{
	private View 			view;
	private ImageView		iv_facebook;
	private Button			btn_signin;
	private EditText		et_username;
	private EditText		et_pwd;
	private ProgressDialog	progress_dialog;

	@Override
	public View 			onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
	{
		view = inflater.inflate(R.layout.login, container, false);
		this.initWidgets();
		this.initButtons();
		return (view);
	}

	/**
	 * Widgets initialization
	 */
	private void			initWidgets()
	{
		this.iv_facebook = (ImageView) this.view.findViewById(R.id.ivFacebookConnect);
		this.btn_signin = (Button) this.view.findViewById(R.id.btnSignIn);
		this.et_username = (EditText) this.view.findViewById(R.id.etSignInEmail);
		this.et_pwd = (EditText) this.view.findViewById(R.id.etSignInPwd);
	}

	/**
	 * Buttons initialization
	 */
	private void			initButtons()
	{
		this.iv_facebook.setOnClickListener(new OnClickListener() 
		{
			@Override
			public void onClick(View v) 
			{
				facebookConnect();
			}
		});
		this.btn_signin.setOnClickListener(new OnClickListener() 
		{
			@Override
			public void onClick(View v) 
			{
				String		pseudo = et_username.getText().toString();
				String		password = et_pwd.getText().toString();

				if (!pseudo.equals("") && !password.equals(""))
				{
					createDialogProgressBar(getString(R.string.signin_load));
					Thread t = new Thread(new Runnable() 
					{
						@Override
						public void run() 
						{
							boolean				res;
							String				response;
							final String		msg;

							res = NetworkModule.sendSgni(et_pwd.getText().toString(), et_username.getText().toString());
							if (res)
								msg = getString(R.string.signin_ok);
							else
								msg = getString(R.string.signin_ko);
							if (res)
							{
								SessionMT.current_user.setPseudo(et_username.getText().toString());
								response = ProfilModule.getProfil(SessionMT.current_user);
								SessionMT.current_user = ResponseParser.parseUser(response);
								Intent i = new Intent(getActivity(), MenuTab.class);

								startActivity(i);
								getActivity().finish();
							}
							progress_dialog.cancel();
							getActivity().runOnUiThread(new Runnable() 
							{
								@Override
								public void run() 
								{
									Toast.makeText(getActivity(), msg, Toast.LENGTH_LONG).show();
								}
							});
						}
					});
					t.start();
				}
				else
					Toast.makeText(getActivity(), getString(R.string.plz_fillin), Toast.LENGTH_LONG).show();
			}
		});
	}

	/**
	 * Facebook connection
	 */
	private void			facebookConnect()
	{
		Session.openActiveSession(getActivity(), true, new Session.StatusCallback() 
		{
			// callback when session changes state
			@Override
			public void call(Session session, SessionState state, Exception exception) 
			{
				if (session.isOpened()) 
				{
					// make request to the /me API
					Request.executeMeRequestAsync(session, new Request.GraphUserCallback()
					{
						// callback after Graph API response with user object
						@Override
						public void onCompleted(GraphUser user, Response response) 
						{
							if (user != null) 
							{
								//TextView welcome = (TextView) findViewById(R.id.welcome);
								//welcome.setText("Hello " + user.getName() + "!");
							}
						}
					});
				}
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
