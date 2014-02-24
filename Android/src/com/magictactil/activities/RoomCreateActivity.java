package com.magictactil.activities;

import java.lang.ref.WeakReference;

import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import com.actionbarsherlock.app.SherlockActivity;
import com.magictactil.app.R;
import com.magictactil.model.Room;
import com.magictactil.network.RoomModule;

/**
 * Activity for room creation
 * 
 * @author Benjamin
 *
 */
public class 					RoomCreateActivity extends SherlockActivity 
{
	private Button				btn_add;
	private EditText			et_name;
	private Spinner				sp_format;
	private CheckBox			cb_visible;
	private ProgressDialog		progress_dialog;

	@Override
	public void 				onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.room_create);
		this.initSherlock();
		this.initWidgets();
		this.initSpinner();
		this.initButtons();
	}

	/**
	 * Spinner initialization
	 */
	private void initSpinner() 
	{
		ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this, R.array.room_format, android.R.layout.simple_spinner_item);
		adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		sp_format.setAdapter(adapter);
	}

	/**
	 * Sherlock initialization
	 */
	private void			initSherlock()
	{
		getSupportActionBar().setDisplayHomeAsUpEnabled(true);
		getSupportActionBar().setTitle(R.string.room_create);
	}

	/**
	 * Widgets initialization
	 */
	private void				initWidgets()
	{
		this.btn_add = (Button) findViewById(R.id.btnRoomCreate);
		this.et_name = (EditText) findViewById(R.id.etRoomName);
		this.sp_format = (Spinner) findViewById(R.id.spFormat);
		this.cb_visible = (CheckBox) findViewById(R.id.cbRoomState);
	}

	/**
	 * Buttons initialization
	 */
	private void				initButtons()
	{
		this.btn_add.setOnClickListener(new OnClickListener() 
		{
			@Override
			public void onClick(View v) 
			{
				Room			room;
				RoomCreateTask	task;

				room = new Room();
				room.setName(et_name.getText().toString());
				room.setFormat((String) sp_format.getSelectedItem());
				room.setVisible(cb_visible.isChecked());
				task = new RoomCreateTask(RoomCreateActivity.this, room);
				task.execute();
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
		this.progress_dialog = new ProgressDialog(this);
		this.progress_dialog.setMessage(mess);
		this.progress_dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
		this.progress_dialog.setIndeterminate(true);
		this.progress_dialog.setCancelable(false);
		this.progress_dialog.show();
	}

	/**
	 * Async task for room creation
	 * 
	 * @author Benjamin
	 *
	 */
	static class										RoomCreateTask extends AsyncTask<Void, Integer, Boolean>
	{
		private WeakReference<RoomCreateActivity> 		activity = null;
		private Room									room;

		/**
		 * @param act, activity
		 * @param room, room to create
		 */
		public 											RoomCreateTask(RoomCreateActivity act, Room room)
		{
			this.link(act);	
			this.room = room;
		}

		@Override
		protected void 									onPreExecute() 
		{
			if (this.activity.get() != null)
				this.activity.get().createDialogProgressBar(this.activity.get().getString(R.string.room_creating));
		}

		@Override
		protected Boolean 								doInBackground(Void... params) 
		{
			RoomModule.createRoom(this.room);
			return null;
		}

		@Override
		protected void 									onPostExecute(Boolean result) 
		{
			if (this.activity.get() != null)
			{
				this.activity.get().progress_dialog.cancel();
				Toast.makeText(this.activity.get(), this.activity.get().getString(R.string.room_created), Toast.LENGTH_LONG).show();
				this.activity.get().finish();
			}
		}

		/**
		 * Link activity with weak reference, activity could be destroyed during task 
		 * 
		 * @param act, activity
		 */
		public void 									link(RoomCreateActivity act) 
		{
			this.activity = new WeakReference<RoomCreateActivity>(act);
		}
	}
}
