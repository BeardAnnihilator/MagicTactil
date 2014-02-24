package com.magictactil.json;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

import android.content.Context;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.magictactil.model.Card;
import com.magictactil.model.Set;

/**
 * Parsing class for card database
 * 
 * @author Benjamin
 *
 */
public class 						CardParser 
{
	private final static String		file_name = "cards.json";
	private final static String		file_path = "cards";

	/**
	 * Parse the cards
	 * 
	 * @param context
	 * @return the list of cards
	 */
	public static ArrayList<Card> 	parseCards(Context context)
	{
		ArrayList<Card> 			cards = null;
		JsonCards					jc;

		try 
		{
			Type setListType = new TypeToken<List<Set>>() {}.getType();
			
			Gson gson = new GsonBuilder().registerTypeAdapter(setListType, new SetTypeAdapter()).create();
			InputStream descriptor = context.getAssets().open(file_path + "/" + file_name);
			jc = gson.fromJson(new InputStreamReader(descriptor), JsonCards.class);
			cards = jc.getCockatrice_carddatabase().getCards().getCard();
			for (int i = 0; i < cards.size(); i++)
			{
				cards.get(i).setId(i + 1);
			}
		}
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		return (cards);
	}
}
