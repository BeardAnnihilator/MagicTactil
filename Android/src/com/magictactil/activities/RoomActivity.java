package com.magictactil.activities;

import java.io.File;
import java.lang.ref.WeakReference;
import java.util.ArrayList;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Toast;

import com.actionbarsherlock.app.SherlockActivity;
import com.actionbarsherlock.view.Menu;
import com.actionbarsherlock.view.MenuItem;
import com.magictactil.adapter.RoomPlayerAdapter;
import com.magictactil.app.R;
import com.magictactil.model.Room;
import com.magictactil.model.User;
import com.magictactil.network.RoomModule;
import com.magictactil.session.SessionMT;
import com.magictactil.utils.Utils;

/**
 * Room main activity which list he players in the rooms, permit to join this room and to launch the game
 * 
 * @author Benjamin
 *
 */
public class 					RoomActivity extends SherlockActivity
{
	private Room				room;
	private Button				btn_delete;
	private Button				btn_join;
	private Button				btn_play;
	private ProgressDialog		progress_dialog;
	private RoomPlayerAdapter	adapter;
	private ArrayList<User> 	list;
	private ListView			lv_players;

	@Override
	public void 				onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.room);
		this.getExtra();
		this.initSherlock();
		this.initWidgets();
		this.initView();
		this.initButtons();
		RoomGetPlayersTask task = new RoomGetPlayersTask(this, room);
		task.execute();
	}

	/**
	 * Buttons initialization
	 */
	private void 				initButtons() 
	{
		this.btn_delete.setOnClickListener(new OnClickListener() 
		{
			@Override
			public void onClick(View v) 
			{
				RoomDeleteTask	task = new RoomDeleteTask(RoomActivity.this, room);

				task.execute();
			}
		});
		this.btn_join.setOnClickListener(new OnClickListener() 
		{
			@Override
			public void onClick(View v) 
			{
				RoomJoinTask	task = new RoomJoinTask(RoomActivity.this, room);

				task.execute();
			}
		});
		this.btn_play.setOnClickListener(new OnClickListener() 
		{
			@Override
			public void 	onClick(View v) 
			{
				if (SessionMT.current_deck != null)
				{
					PrepareGameTask task = new PrepareGameTask(RoomActivity.this, room);
					
					task.execute();
				}
				else
					Toast.makeText(RoomActivity.this, getString(R.string.deck_needed), Toast.LENGTH_LONG).show();
			}
		});
	}

	/**
	 * Widgets initialization
	 */
	private void 				initWidgets()
	{
		this.btn_delete = (Button) findViewById(R.id.btnRoomDelete);
		this.btn_join = (Button) findViewById(R.id.btnRoomJoin);
		this.btn_play = (Button) findViewById(R.id.btnPlay);
		this.lv_players = (ListView) findViewById(R.id.lvRoomPlayers);
	}

	/**
	 * View initialization
	 */
	private void initView()
	{
		if (!room.getOwner().equals(SessionMT.current_user.getPseudo()))
			this.btn_delete.setVisibility(View.GONE);
	}

	/**
	 * ListView initialization
	 */
	private void initListView(ArrayList<User> u) 
	{
		this.list = u;
		this.adapter = new RoomPlayerAdapter(this, list, null);
		this.lv_players.setAdapter(adapter);
	}

	/**
	 * Getting extea (room)
	 */
	private void getExtra() 
	{
		room = (Room) getIntent().getExtras().get("room");
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

	@Override
	public boolean 					onCreateOptionsMenu(Menu menu) 
	{
		return (super.onCreateOptionsMenu(menu));
	}

	/**
	 * Sherlock initialization
	 */
	private void			initSherlock()
	{
		getSupportActionBar().setDisplayHomeAsUpEnabled(true);
		getSupportActionBar().setTitle(getString(R.string.room) + " " + room.getName());
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
	 * Async task for getting the players in the room
	 * 
	 * @author Benjamin
	 *
	 */
	static class										RoomGetPlayersTask extends AsyncTask<Void, Integer, Boolean>
	{
		private WeakReference<RoomActivity> 			activity = null;
		private Room									room;
		private String									res;
		private ArrayList<User> 						users;

		/**
		 * @param act, activity
		 * @param room, room
		 */
		public 											RoomGetPlayersTask(RoomActivity act, Room room)
		{
			this.link(act);	
			this.room = room;
		}

		@Override
		protected void 									onPreExecute() 
		{
			if (this.activity.get() != null)
				this.activity.get().createDialogProgressBar(this.activity.get().getString(R.string.room_get_players));
		}

		@Override
		protected Boolean 								doInBackground(Void... params) 
		{
			res = RoomModule.getPlayersInRoom(room);
			users = RoomModule.parseUsers(res);
			return null;
		}

		@Override
		protected void 									onPostExecute(Boolean result) 
		{
			if (this.activity.get() != null)
			{
				this.activity.get().initListView(users);
				this.activity.get().progress_dialog.cancel();
			}
		}

		/**
		 * Link activity with weak reference, activity could be destroyed during task 
		 * 
		 * @param act, activity
		 */
		public void 									link(RoomActivity act) 
		{
			this.activity = new WeakReference<RoomActivity>(act);
		}
	}

	/**
	 * Async task for deleting a room
	 * 
	 * @author Benjamin
	 *
	 */
	static class										RoomDeleteTask extends AsyncTask<Void, Integer, Boolean>
	{
		private WeakReference<RoomActivity> 			activity = null;
		private Room									room;
		private String									res;

		/**
		 * @param act, Activity
		 * @param room, the room to delete
		 */
		public 											RoomDeleteTask(RoomActivity act, Room room)
		{
			this.link(act);	
			this.room = room;
		}

		@Override
		protected void 									onPreExecute() 
		{
			if (this.activity.get() != null)
				this.activity.get().createDialogProgressBar(this.activity.get().getString(R.string.room_deleting));
		}

		@Override
		protected Boolean 								doInBackground(Void... params) 
		{
			res = RoomModule.deleteRoom(room);
			return null;
		}

		@Override
		protected void 									onPostExecute(Boolean result) 
		{
			if (this.activity.get() != null)
			{
				this.activity.get().progress_dialog.cancel();
				if (res.equals("OK"))
				{
					Toast.makeText(this.activity.get(), this.activity.get().getString(R.string.room_deleted), Toast.LENGTH_LONG).show();
					this.activity.get().finish();
				}
			}
		}

		/**
		 * Link activity with weak reference, activity could be destroyed during task 
		 * 
		 * @param act, activity
		 */
		public void 									link(RoomActivity act) 
		{
			this.activity = new WeakReference<RoomActivity>(act);
		}
	}

	/**
	 * Async task for joining a room
	 * 
	 * @author Benjamin
	 *
	 */
	static class										RoomJoinTask extends AsyncTask<Void, Integer, Boolean>
	{
		private WeakReference<RoomActivity> 			activity = null;
		private Room									room;
		private String									res;

		/**
		 * @param act, activity
		 * @param room, room to join
		 */
		public 											RoomJoinTask(RoomActivity act, Room room)
		{
			this.link(act);	
			this.room = room;
		}

		@Override
		protected void 									onPreExecute() 
		{
			if (this.activity.get() != null)
				this.activity.get().createDialogProgressBar(this.activity.get().getString(R.string.room_joining));
		}

		@Override
		protected Boolean 								doInBackground(Void... params) 
		{
			res = RoomModule.joinRoom(room);
			return null;
		}

		@Override
		protected void 									onPostExecute(Boolean result) 
		{
			if (this.activity.get() != null)
			{
				this.activity.get().progress_dialog.cancel();
				if (res.equals("OK"))
				{
					Toast.makeText(this.activity.get(), this.activity.get().getString(R.string.room_join_ok), Toast.LENGTH_LONG).show();
				}
			}
		}

		/**
		 * Link activity with weak reference, activity could be destroyed during task 
		 * 
		 * @param act, activity
		 */
		public void 									link(RoomActivity act) 
		{
			this.activity = new WeakReference<RoomActivity>(act);
		}
	}
	
	/**
	 * Async task for downloading the cards images before the game
	 * 
	 * @author Benjamin
	 *
	 */
	static class										PrepareGameTask extends AsyncTask<Void, Integer, Boolean>
	{	
		private WeakReference<RoomActivity> 			activity = null;
		private Room									room;

		/**
		 * @param act, activty
		 * @param room, room
		 */
		public 											PrepareGameTask(RoomActivity act, Room room)
		{
			this.link(act);	
			this.room = room;
		}

		@Override
		protected void 									onPreExecute() 
		{
			if (this.activity.get() != null)
				this.activity.get().createDialogProgressBar(this.activity.get().getString(R.string.game_loading));
		}

		@Override
		protected Boolean 								doInBackground(Void... params) 
		{
			for (int i = 0; i < SessionMT.current_deck.getCards().size(); i++)
			{
				File file = new File(this.activity.get().getFilesDir(), SessionMT.current_deck.getCards().get(i).getId() + ".jpg");
				Utils.downloadImgFromUrl(SessionMT.current_deck.getCards().get(i).getSet().get(0).getPicUrl(), file);
			}
			return null;
		}

		@Override
		protected void 									onPostExecute(Boolean result) 
		{
			if (this.activity.get() != null)
			{
				this.activity.get().progress_dialog.cancel();
				Intent i = new Intent(this.activity.get(), GameActivity.class);

				i.putExtra("room", room);
				
				this.activity.get().startActivity(i);
			}
		}
		
		/**
		 * Link activity with weak reference, activity could be destroyed during task 
		 * 
		 * @param act, activity
		 */
		public void 									link(RoomActivity act) 
		{
			this.activity = new WeakReference<RoomActivity>(act);
		}
	}
}