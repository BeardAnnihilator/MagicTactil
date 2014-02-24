package com.magictactil.model;

import java.io.Serializable;

/**
 * room model
 * 
 * @author Benjamin
 *
 */
public class 			Room implements Serializable 
{
	private static final long serialVersionUID = 1L;
	private String		name;
	private String 		format;
	private int			id;
	private boolean		visible;
	private String		owner;
	
	public String 		getOwner() 
	{
		return (owner);
	}

	public void 		setOwner(String owner)
	{
		this.owner = owner;
	}

	public int 			getId() 
	{
		return (id);
	}

	public void 		setId(int id) 
	{
		this.id = id;
	}

	public boolean 		isVisible() 
	{
		return (visible);
	}

	public void setVisible(boolean visible) 
	{
		this.visible = visible;
	}

	public String 		getFormat() 
	{
		return (format);
	}

	public void setFormat(String format) 
	{
		this.format = format;
	}

	public String 		getName() 
	{
		return (name);
	}

	public void setName(String name) 
	{
		this.name = name;
	}
}
