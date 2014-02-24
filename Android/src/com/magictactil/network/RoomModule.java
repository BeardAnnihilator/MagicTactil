package com.magictactil.network;

import java.util.ArrayList;

import com.magictactil.model.Room;
import com.magictactil.model.User;
import com.magictactil.session.SessionMT;
import com.magictactil.utils.Constants;

/**
 * Class managing server communication for rooms
 * 
 * @author Benjamin
 *
 */
public class 			RoomModule 
{
	private static String		sep_cmd = "\r";
	private static String		sep_data = "\n";
	private static Client_tcp 	socket;

	/**
	 * Create a room on the server
	 * 
	 * @param room
	 * @return
	 */
	public static String		createRoom(Room room)
	{
		String					cmd = "";
		String					func = "CNRO";
		String					res = "";

		cmd += "nameOwner" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		cmd += "nameRoom" + sep_cmd + room.getName() + sep_data;
		cmd += "format" + sep_cmd + room.getFormat() + sep_data;
		cmd += "state" + sep_cmd + "1" + sep_data;
		res = sendPacket(func, cmd);
		return (res);
	}

	/**
	 * Get all rooms on the server
	 * 
	 * @return
	 */
	public static String		getAllRooms()
	{
		String					cmd = "";
		String					func = "GEAR";
		String					res = "";

		res = sendPacket(func, cmd);
		return (res);
	}

	/**
	 * Delete a room on the server
	 * 
	 * @param room
	 * @return
	 */
	public static String		deleteRoom(Room room)
	{
		String					cmd = "";
		String					func = "DERO";
		String					res = "";

		cmd += "nameOwner" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		cmd += "nameRoom" + sep_cmd + room.getName() + sep_data;
		res = sendPacket(func, cmd);
		return (res);
	}

	/**
	 * Join a room on the server
	 * 
	 * @param room
	 * @return
	 */
	public static String		joinRoom(Room room)
	{
		String					cmd = "";
		String					func = "JORO";
		String					res = "";

		cmd += "username" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		cmd += "nameRoom" + sep_cmd + room.getName() + sep_data;
		res = sendPacket(func, cmd);
		return (res);
	}

	/**
	 * Leave a room
	 * 
	 * @param room
	 * @return
	 */
	public static String		leaveRoom(Room room)
	{
		String					cmd = "";
		String					func = "LEAR";
		String					res = "";

		cmd += "username" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		cmd += "nameRoom" + sep_cmd + room.getName() + sep_data;
		res = sendPacket(func, cmd);
		return (res);
	}

	/**
	 * Get players in a room
	 * 
	 * @param room
	 * @return
	 */
	public static String		getPlayersInRoom(Room room)
	{
		String					cmd = "";
		String					func = "GPFR";
		String					res = "";

		cmd += "idRoom" + sep_cmd + room.getId() + sep_data;
		res = sendPacket(func, cmd);
		return (res);
	}

	/**
	 * Parse server response for players
	 * 
	 * @param res
	 * @return
	 */
	public static ArrayList<User> 	parseUsers(String res)
	{
		ArrayList<User>				users = new ArrayList<User>();
		User						user = new User();
		String[]					fields;

		fields = res.split(sep_data);
		for (int i = 0; i < fields.length; i++)
		{
			String[]			cmd;

			cmd = fields[i].split(sep_cmd);
			if (!cmd[0].equals("idRoom"))
			{
				user = new User();

				user.setPseudo(fields[i]);
				users.add(user);
			}
		}
		return (users);
	}

	/**
	 * parse server response for room
	 * 
	 * @param res
	 * @return
	 */
	public static ArrayList<Room> 	parseRooms(String res)
	{
		ArrayList<Room>				rooms = new ArrayList<Room>();
		Room						room = new Room();
		String[]					fields;

		fields = res.split(sep_data);
		for (int i = 0; i < fields.length; i++)
		{
			String[]			cmd;

			cmd = fields[i].split(sep_cmd);
			if (cmd.length > 1)
			{
				if (cmd[0].equals("nameOwner"))
					room.setOwner(cmd[1]);
				else if (cmd[0].equals("id"))
					room.setId(Integer.parseInt(cmd[1].trim()));
				else if (cmd[0].equals("format"))
					room.setFormat(cmd[1]);
				else if (cmd[0].equals("nameRoom"))
					room.setName(cmd[1]);
				else if (cmd[0].equals("state"))
				{
					// mettre state quand ce sera bon
					rooms.add(room);
					room = new Room();
				}
			}
		}
		return (rooms);
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
