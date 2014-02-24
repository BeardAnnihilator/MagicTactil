package com.magictactil.db;

import java.io.Serializable;

/**
 * Friend model
 * 
 * @author Benjamin
 *
 */
public class 		Friend implements Serializable
{
	private static final long serialVersionUID = 1L;
	private String	pseudo = "";

	public String getPseudo() 
	{
		return pseudo;
	}

	public void setPseudo(String pseudo) 
	{
		this.pseudo = pseudo;
	}
}
