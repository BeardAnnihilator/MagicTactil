package com.magictactil.game;

/**
 * Game action like move or engage
 * 
 * @author Benjamin
 *
 */
public class Action
{
	private Card	card;
	private String						type;
	private String						dest;
	private String						source;
	private int			x;
	private int			y;
	
	public int getX() {
		return (x);
	}
	public void setX(int x) {
		this.x = x;
	}
	public int getY() {
		return (y);
	}
	public void setY(int y) {
		this.y = y;
	}
	public String getSource() {
		return (source);
	}
	public void setSource(String source) {
		this.source = source;
	}
	public Card getCard() {
		return (card);
	}
	public void setCard(Card card) {
		this.card = card;
	}
	public String getType() {
		return (type);
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDest() {
		return (dest);
	}
	public void setDest(String dest) {
		this.dest = dest;
	}
}
