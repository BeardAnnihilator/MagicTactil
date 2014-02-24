package com.magictactil.network;

import java.util.ArrayList;

import com.magictactil.model.Card;
import com.magictactil.model.Deck;
import com.magictactil.session.SessionMT;
import com.magictactil.utils.Constants;

/**
 * Class managing communication to ther server for decks
 * 
 * @author Benjamin
 *
 */
public class 				DeckModule 
{
	private static String		sep_cmd = "\r";
	private static String		sep_data = "\n";
	private static Client_tcp 	socket;

	/**
	 * Create the deck on the server
	 * 
	 * @param deck
	 * @return
	 */
	public static boolean		createDeck(Deck deck)
	{
		String					cmd = "";
		String					func = "CRDK";
		String					res;

		cmd += "deckName" + sep_cmd + deck.getName() + sep_data;
		cmd += "isReal" + sep_cmd + deck.isReal() + sep_data;
		cmd += "nameOwner" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		res = sendPacket(func, cmd);
		if (res.equals("OK"))
			return (true);
		return (false);
	}

	/**
	 * List the deck's cards
	 * 
	 * @param deck
	 * @return
	 */
	public static String		getCardsOfDeck(Deck deck)
	{
		String					cmd = "";
		String					func = "SDTU";
		String					res = "";

		cmd += "nameOwner" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		cmd += "idDeck" + sep_cmd + deck.getId() + sep_data;
		res = sendPacket(func, cmd);
		return (res);
	}

	/**
	 * get the player's deck
	 * 
	 * @return
	 */
	public static String		getMyDecks()
	{
		String					cmd = "";
		String					func = "GLID";
		String					res = "";

		cmd += "nameOwner" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		res = sendPacket(func, cmd);
		return (res);
	}

	/**
	 * Parse the server response to get decks
	 * 
	 * @param res
	 * @return
	 */
	public static ArrayList<Deck> 	parseDecks(String res)
	{
		ArrayList<Deck>				decks = new ArrayList<Deck>();
		Deck						deck = new Deck();
		String[]					fields;

		fields = res.split(sep_data);
		for (int i = 0; i < fields.length; i++)
		{

			String[]			cmd;

			cmd = fields[i].split(sep_cmd);
			if (cmd.length > 1)
			{
				if (cmd[0].equals("deckName"))
					deck.setName(cmd[1]);
				else if (cmd[0].equals("idDeck"))
					deck.setId(Integer.parseInt(cmd[1]));
				else if (cmd[0].equals("isReal"))
				{
					deck.setReal(Boolean.parseBoolean(cmd[1]));
					decks.add(deck);
					deck = new Deck();
				}
			}
		}
		return (decks);
	}

	/**
	 * parse server response to get deck's cards
	 * 
	 * @param res
	 * @return
	 */
	public static ArrayList<Card> 	parseCards(String res)
	{
		ArrayList<Card>				cards = new ArrayList<Card>();
		Card						card = new Card();
		String[]					fields;

		fields = res.split(sep_data);
		for (int i = 0; i < fields.length; i++)
		{
			String[]			cmd;

			cmd = fields[i].split(sep_cmd);
			if (cmd.length > 1)
			{
				if (cmd[0].equals("idCard"))
				{
					card = SessionMT.cards.get(Integer.parseInt(cmd[1]) - 1);

					cards.add(card);
				}
			}
		}
		return (cards);
	}

	/**
	 * send packet to the server
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
