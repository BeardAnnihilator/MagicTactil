package com.magictactil.network;

import com.magictactil.model.User;
import com.magictactil.utils.Constants;

/**
 * Class mananging server communication for profile
 * 
 * @author Benjamin
 *
 */
public class ProfilModule 
{
	private static String		sep_cmd = "\r";
	private static String		sep_data = "\n";
	private static Client_tcp 	socket;
	private static String		USERNAME = "username";

	/**
	 * Edit profile
	 * 
	 * @param user
	 * @return
	 */
	public static boolean		editProfil(User user)
	{
		String					cmd = "";
		String					func = "SETU";
		String					res;

		cmd += USERNAME + sep_cmd + user.getPseudo() + sep_data;
		cmd += "name" + sep_cmd + user.getLast_name() + sep_data;
		cmd += "telephone" + sep_cmd + user.getPhone() + sep_data;
		cmd += "email" + sep_cmd + user.getEmail() + sep_data;
		cmd += "location" + sep_cmd + user.getLocation() + sep_data;
		cmd += "gender" + sep_cmd;
		if (user.isMale())
			cmd += "M";
		else
			cmd += "F";
		cmd += sep_data;
		res = sendPacket(func, cmd);
		if (res.equals("OK"))
			return (true);
		return (false);
	}

	/**
	 * get profile
	 * 
	 * @param user
	 * @return
	 */
	public static String		getProfil(User user)
	{
		String					cmd = "";
		String					func = "GETU";
		String					res = "";

		cmd += USERNAME + sep_cmd + user.getPseudo() + sep_data;
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
