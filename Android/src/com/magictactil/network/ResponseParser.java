package com.magictactil.network;

import java.util.ArrayList;

import com.magictactil.db.Friend;
import com.magictactil.model.Event;
import com.magictactil.model.User;

public class 					ResponseParser 
{
	private static String		sep_cmd = "\r";
	private static String		sep_data = "\n";

	public static User			parseUser(String resp)
	{
		User					res = new User();
		String[]				fields;

		fields = resp.split(sep_data);
		for (int i = 0; i < fields.length; i++)
		{
			String[]			cmd;

			cmd = fields[i].split(sep_cmd);
			if (cmd.length > 1)
			{
				if (cmd[0].equals("username"))
					res.setPseudo(cmd[1]);
				else if (cmd[0].equals("email"))
					res.setEmail(cmd[1]);
				else if (cmd[0].equals("name"))
					res.setLast_name(cmd[1]);
				else if (cmd[0].equals("gender"))
					res.setMale(cmd[1].equals("M"));
				else if (cmd[0].equals("location"))
					res.setLocation(cmd[1]);
				else if (cmd[0].equals("telephone"))
					res.setPhone(cmd[1]);
			}
		}
		return (res);
	}
	
	public static Event			parseEvent(String resp)
	{
		Event					res = new Event();
		String[]				fields;

		fields = resp.split(sep_data);
		for (int i = 0; i < fields.length; i++)
		{
			String[]			cmd;

			cmd = fields[i].split(sep_cmd);
			if (cmd.length > 1)
			{
				if (cmd[0].equals("creator"))
					res.setCreator(cmd[1]);
				else if (cmd[0].equals("name"))
					res.setName(cmd[1]);
				else if (cmd[0].equals("description"))
					res.setDescription(cmd[1]);
				else if (cmd[0].equals("date"))
					res.setDate(cmd[1]);
				else if (cmd[0].equals("location"))
					res.setLocation(cmd[1]);
			}
		}
		return (res);
	}

	public static ArrayList<Event>	parseEvents(String resp)
	{
		ArrayList<Event>				events = new ArrayList<Event>();
		String[]				list_names;

		list_names = resp.split(sep_data);
		for (int i = 0; i < list_names.length; i++)
		{
			Event				event = new Event();

			event.setName(list_names[i]);
			events.add(event);
		}
		return (events);
	}

	public static ArrayList<Friend>		parseFriends(String resp)
	{
		ArrayList<Friend>				friends = new ArrayList<Friend>();
		String[]						list_names;

		list_names = resp.split(sep_data);
		for (int i = 0; i < list_names.length; i++)
		{
			Friend				friend = new Friend();

			friend.setPseudo(list_names[i]);
			if (!friend.getPseudo().equals(""))
				friends.add(friend);
		}
		return (friends);
	}
}
