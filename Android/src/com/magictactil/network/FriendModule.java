package com.magictactil.network;

import com.magictactil.db.Friend;
import com.magictactil.session.SessionMT;
import com.magictactil.utils.Constants;

/**
 * Class managing server communication for friends
 * 
 * @author Benjamin
 *
 */
public class FriendModule 
{
	private static String		sep_cmd = "\r";
	private static String		sep_data = "\n";
	private static Client_tcp 	socket;
	private static String		USERNAME = "username";

	/**
	 * Add a friend
	 * 
	 * @param name
	 * @return
	 */
	public static boolean		AddFriend(String name)
	{
		String					cmd = "";
		String					func = "ADFR";
		String					res;

		cmd += USERNAME + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		cmd += "belongsto" + sep_cmd + name + sep_data;
		res = sendPacket(func, cmd);
		if (res.equals("OK"))
			return (true);
		return (false);
	}

	/**
	 * delete a friend
	 * 
	 * @param friend
	 * @return
	 */
	public static boolean		DeleteFriend(Friend friend)
	{
		String					cmd = "";
		String					func = "DELF";
		String					res;

		cmd += USERNAME + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		cmd += "belongsto" + sep_cmd + friend.getPseudo() + sep_data;
		res = sendPacket(func, cmd);
		if (res.equals("OK"))
			return (true);
		return (false);
	}

	/**
	 * get player's friends
	 * 
	 * @return
	 */
	public static String		getFriends()
	{
		String					cmd = "";
		String					func = "GFRL";
		String					res = "";

		cmd += USERNAME + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
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
