package com.magictactil.network;

import com.magictactil.model.Card;
import com.magictactil.model.Deck;
import com.magictactil.session.SessionMT;
import com.magictactil.utils.Constants;

/**
 * Class managing Server commnication for cards
 * 
 * @author Benjamin
 *
 */
public class CardModule 
{
	private static String		sep_cmd = "\r";
	private static String		sep_data = "\n";
	private static Client_tcp 	socket;

	/**
	 * Add a card to a deck
	 * 
	 * @param card, card to add
	 * @param deck, deck
	 * @return
	 */
	public static boolean		addCardToDeck(Card card, Deck deck)
	{
		String					cmd = "";
		String					func = "ACFD";
		String					res;

		cmd += "nameOwner" + sep_cmd + SessionMT.current_user.getPseudo() + sep_data;
		cmd += "deckName" + sep_cmd + deck.getName() + sep_data;
		cmd += "idCard" + sep_cmd + card.getId() + sep_data;
		cmd += "isSided" + sep_cmd + "false" + sep_data;
		cmd += "nbCard" + sep_cmd + "1" + sep_data;

		res = sendPacket(func, cmd);
		if (res.equals("OK"))
			return (true);
		return (false);
	}

	/**
	 * Send a packet to the server
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
