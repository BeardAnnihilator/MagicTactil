package com.magictactil.network;

import android.content.Context;

import com.magictactil.model.Event;
import com.magictactil.session.SessionMT;
import com.magictactil.utils.Constants;

/**
 * class managing server communication for events
 * 
 * @author Benjamin
 *
 */
public class 					EventModule 
{
	private static String		sep_cmd = "\r";
	private static String		sep_data = "\n";
	private static Client_tcp 	socket;

	/**
	 * Create an event on the server
	 * 
	 * @param event
	 * @return
	 */
	public static boolean		createEvent(Event event)
	{
		String					cmd = "";
		String					func = "CREV";
		String					res;

		cmd += "name" + sep_cmd + event.getName() + sep_data;
		cmd += "description" + sep_cmd + event.getDescription() + sep_data;
		cmd += "creator" + sep_cmd + event.getCreator() + sep_data;
		cmd += "creatorEmail" + sep_cmd + event.getCreator_email() + sep_data;
		cmd += "date" + sep_cmd + event.getDate() + sep_data;
		cmd += "location" + sep_cmd + event.getLocation() + sep_data;
		res = sendPacket(func, cmd);
		if (res.equals("OK"))
			return (true);
		return (false);
	}

	/**
	 * list events on the server
	 * 
	 * @return
	 */
	public static String		listEvents()
	{
		String					cmd = "/";
		String					func = "GTAL";
		String					res = "";

		res = sendPacket(func, cmd);
		return (res);
	}

	/**
	 * check ig the player is signed up to the event
	 * 
	 * @param event
	 * @return
	 */
	public static boolean		IsSignedUp(Event event)
	{
		String					cmd = "";
		String					func = "ISUE";
		String					res;

		cmd += "name" + sep_cmd + event.getName() + sep_data;
		cmd += "username" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		res = sendPacket(func, cmd);
		if (res.equals("OK"))
			return (true);
		return (false);
	}

	/**
	 * Unsubscribe the player
	 * 
	 * @param event
	 * @return
	 */
	public static boolean		Unsubscribe(Event event)
	{
		String					cmd = "";
		String					func = "SGOE";
		String					res;

		cmd += "name" + sep_cmd + event.getName() + sep_data;
		cmd += "username" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		res = sendPacket(func, cmd);
		if (res.equals("OK"))
			return (true);
		return (false);
	}

	/**
	 * Sign up the player to the event
	 * 
	 * @param event
	 * @return
	 */
	public static boolean		SignUp(Event event)
	{
		String					cmd = "";
		String					func = "SGUE";
		String					res;

		cmd += "name" + sep_cmd + event.getName() + sep_data;
		cmd += "username" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		res = sendPacket(func, cmd);
		if (res.equals("OK"))
			return (true);
		return (false);
	}

	/**
	 * Get a particular event
	 * 
	 * @param event
	 * @param ctx
	 * @return
	 */
	public static String		getEvent(Event event, Context ctx)
	{
		String					cmd = "";
		String					func = "GETE";
		String					res = "";

		cmd += "name" + sep_cmd + event.getName() + sep_data;
		res = sendPacket(func, cmd);
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
