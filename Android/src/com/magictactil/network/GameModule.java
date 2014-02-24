package com.magictactil.network;

import android.util.Log;

import com.magictactil.game.Action;
import com.magictactil.game.Card;
import com.magictactil.model.Room;
import com.magictactil.session.SessionMT;
import com.magictactil.utils.Constants;

/**
 * Class managing server communication for game
 * 
 * @author Benjamin
 *
 */
public class GameModule 
{
	private static String		sep_cmd = "\r";
	private static String		sep_data = "\n";
	private static Client_tcp 	socket;
	
	/**
	 * Move a card
	 * 
	 * @param card
	 * @param room
	 * @param action
	 * @return
	 */
	public static String		move(Card card, Room room, Action action)
	{
		String					cmd = "";
		String					func = "MOVE";
		String					res = "";

		cmd += "idCard" + sep_cmd + card.getId() + sep_data;
		cmd += "nameRoom" + sep_cmd + room.getName() + sep_data;
		cmd += "client_name" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		cmd += "destination" + sep_cmd + action.getDest() + sep_data;
		cmd += "X" + sep_cmd + action.getX() + sep_data;
		cmd += "Y" + sep_cmd + action.getY() + sep_data;
		cmd += "url" + sep_cmd + action.getCard().getUrl() + sep_data;
		cmd += "source" + sep_cmd + action.getSource() + sep_data;
		Log.d(Constants.TAG, "SEND MOVE = " + cmd);
		res = sendPacket(func, cmd);
		return (res);
	}
	
	/**
	 * Engage a card
	 * 
	 * @param card
	 * @param room
	 * @return
	 */
	public static String		engageCard(Card card, Room room)
	{
		String					cmd = "";
		String					func = "TAPC";
		String					res = "";

		cmd += "idCard" + sep_cmd + card.getId() + sep_data;
		cmd += "nameRoom" + sep_cmd + room.getName() + sep_data;
		cmd += "client_name" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		Log.d(Constants.TAG, "SEND TAPC = " + cmd);
//		res = sendPacket(func, cmd);
		return (res);
	}

	/**
	 * Desengage a card
	 * 
	 * @param card
	 * @param room
	 * @return
	 */
	public static String		desengageCard(Card card, Room room)
	{
		String					cmd = "";
		String					func = "UTAP";
		String					res = "";

		cmd += "idCard" + sep_cmd + card.getId() + sep_data;
		cmd += "nameRoom" + sep_cmd + room.getName() + sep_data;
		cmd += "client_name" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		Log.d(Constants.TAG, "SEND UTAP = " + cmd);
//		res = sendPacket(func, cmd);
		return (res);
	}
	
	/**
	 * Update game info
	 * 
	 * @param room
	 * @param hp
	 * @return
	 */
	public static String		updateGameInfo(Room room, int hp)
	{
		String					cmd = "";
		String					func = "UPGI";
		String					res = "";

		cmd += "healthpoints" + sep_cmd + hp + sep_data;
		cmd += "nameRoom" + sep_cmd + room.getName() + sep_data;
		cmd += "client_name" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		res = sendPacket(func, cmd);
		return (res);
	}
	
	public static String		reset(Room room)
	{
		String					cmd = "";
		String					func = "RSET";
		String					res = "";

		cmd += "nameRoom" + sep_cmd + room.getName() + sep_data;
		cmd += "client_name" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		res = sendPacket(func, cmd);
		return (res);		
	}
	
	/**
	 * Parse server response for upadteInfo
	 * 
	 * @param data
	 * @return
	 */
	public static int			parseHP(String data)
	{
		int						res = 0;
		String[]				fields;
		
		fields = data.split(sep_data);
		for (int i = 0; i < fields.length; i++)
		{
			String[]			cmd;

			cmd = fields[i].split(sep_cmd);
			if (cmd.length > 1)
			{
				if (cmd[0].equals("healthpoints"))
					res = Integer.parseInt(cmd[1]);
			}
		}
		return (res);
	}
	
	/**
	 * parse server response for move
	 * 
	 * @param data
	 * @return
	 */
	public static Action		parseMove(String data)
	{
		Action					res;
		String[]					fields;
		Card c  = new Card();
		
		res = new Action();
		fields = data.split(sep_data);
		for (int i = 0; i < fields.length; i++)
		{
			String[]			cmd;

			cmd = fields[i].split(sep_cmd);
			if (cmd.length > 1)
			{
				if (cmd[0].equals("idCard"))
					c.setId(cmd[1]);
				if (cmd[0].equals("url"))
					c.setUrl(cmd[1]);
				if (cmd[0].equals("destination"))
					res.setDest(cmd[1]);
			}
		}
		res.setCard(c);
		return (res);
	}
	
	/**
	 * Send packet to the server
	 * 
	 * @param func
	 * @param cmd
	 * @return
	 */
	public static String		sendPacket(String func, String cmd)
	{
		String					res = "";
		Packet					packet = new Packet();

		socket = Client_tcp.getInstance();
		if (socket.getIsConnected() || socket.connect(Constants.SERVER_IP, Constants.SERVER_PORT))
		{
			packet.setDest(1);
			packet.setSrc(2);
			packet.setData(cmd);
			packet.setFunc(func);
			socket.send(packet.getHeader());
			socket.send(cmd);
			res = socket.receive();
		}
		return (res);
	}
}
