package com.magictactil.game;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Ingame player class
 * 
 * @author Benjamin
 *
 */
public class 				Player 
{
	private int				life = 20;
	private String			name;
	private ArrayList<Card>	hand = new ArrayList<Card>();
	private ArrayList<Card> grave = new ArrayList<Card>();
	private ArrayList<Card> exiled = new ArrayList<Card>();
	private ArrayList<Card> cards_bf = new ArrayList<Card>();
	private Stack<Card> 	deck = new Stack<Card>();

	public ArrayList<Card> getCards_bf() 
	{
		return (cards_bf);
	}

	public void setCards_bf(ArrayList<Card> cards_bf) 
	{
		this.cards_bf = cards_bf;
	}

	public ArrayList<Card> getGrave() 
	{
		return grave;
	}

	public void setGrave(ArrayList<Card> grave) 
	{
		this.grave = grave;
	}

	public ArrayList<Card> getExiled() 
	{
		return exiled;
	}

	public void setExiled(ArrayList<Card> exiled) 
	{
		this.exiled = exiled;
	}

	public void setHand(ArrayList<Card> hand) 
	{
		this.hand = hand;
	}

	public int 				getLife() 
	{
		return (life);
	}

	public void 			setLife(int life) 
	{
		this.life = life;
	}
	
	public void				increaseLife()
	{
		this.life++;
	}
	
	public void				decreaseLife()
	{
		this.life--;
	}

	public String 			getName() 
	{
		return (name);
	}

	public void 			setName(String name) 
	{
		this.name = name;
	}

	public ArrayList<Card> 	getHand() 
	{
		return (hand);
	}

	public void 			addToHand(Card card) 
	{
		this.hand.add(card);
	}

	public Stack<Card>		getDeck() 
	{
		return (deck);
	}

	public void 			setDeck(Stack<Card> deck)
	{
		this.deck = deck;
	}

	public Card 			pickDeck() 
	{
		Card				top_card;

		top_card = this.deck.pop();
		this.hand.add(top_card);
		return (top_card);
	}

	public void HandToBF() 
	{
		if (this.hand.size() != 0)
			this.hand.remove(0);
		this.cards_bf.add(new Card());
	}

	/**
	 * move a card from the player hand to the battlefield
	 * 
	 * @param card, the card to move
	 */
	public void HandToBattlefield(Card card) 
	{
		for (int i = 0; i < hand.size(); i++)
		{
			if (hand.get(i).getId().equals(card.getId()))
			{
				if (card.getSprite() != null)
					hand.get(i).setSprite(card.getSprite());
				this.cards_bf.add(hand.get(i));
				hand.remove(i);
				break;
			}
		}
	}
}
