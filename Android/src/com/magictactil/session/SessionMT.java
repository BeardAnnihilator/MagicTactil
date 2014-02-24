package com.magictactil.session;

import java.util.ArrayList;

import com.magictactil.model.Card;
import com.magictactil.model.Deck;
import com.magictactil.model.User;

/**
 * User session variables
 * 
 * @author Drakkin
 *
 */
public class 					SessionMT 
{
	public static boolean		logged = false;
	public static User			current_user = new User();
	public static ArrayList<Card> 	cards;
	public static Deck			current_deck = null;
}
