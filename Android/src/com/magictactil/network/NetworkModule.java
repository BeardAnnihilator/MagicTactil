package com.magictactil.network;

import com.magictactil.utils.Constants;

/**
 * Class managing server communication for sign
 * 
 * @author Benjamin
 *
 */
public class 					NetworkModule 
{
	private static String		sep_cmd = "\r";
	private static String		sep_data = "\n";
	private static Client_tcp 	socket;

	/**
	 * Create a new user on the server
	 * 
	 * @param email
	 * @param password
	 * @param username
	 * @return
	 */
	public static boolean		sendRegu(String email, String password, String username)
	{
		String					cmd = "";
		String					func = "REGU";
		String					res = "";

		cmd += "email" + sep_cmd + email + sep_data;
		cmd += "password" + sep_cmd + password + sep_data;
		cmd += "username" + sep_cmd + username;
		res = sendPacket(func, cmd);
		if (res.equals("OK"))
			return (true);
		else
			return (false);
	}

	/**
	 * Sign in a user
	 * 
	 * @param password
	 * @param username
	 * @return
	 */
	public static boolean		sendSgni(String password, String username)
	{
		String					cmd = "";
		String					func = "SGNI";
		String					res = "";

		cmd += "password" + sep_cmd + password + sep_data;
		cmd += "username" + sep_cmd + username + sep_data;
		res = sendPacket(func, cmd);
		if (res.equals("OK"))
			return (true);
		else
			return(false);
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
