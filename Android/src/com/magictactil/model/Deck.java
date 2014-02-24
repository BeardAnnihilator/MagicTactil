package com.magictactil.model;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Deck model
 * 
 * @author Benjamin
 *
 */
public class 				Deck implements Serializable
{
	private static final long serialVersionUID = 1L;
	private String			name;
	private boolean			real;
	private int				id;
	private ArrayList<Card> cards;

	public ArrayList<Card> 	getCards() 
	{
		return (cards);
	}

	public void 			setCards(ArrayList<Card> cards)
	{
		this.cards = cards;
	}

	public int 			getId() 
	{
		return (id);
	}

	public void 		setId(int id) 
	{
		this.id = id;
	}

	public String 		getName() 
	{
		return (name);
	}

	public void 		setName(String name) 
	{
		this.name = name;
	}

	public boolean 		isReal() 
	{
		return (real);
	}

	public void 		setReal(boolean real) 
	{
		this.real = real;
	}
}
