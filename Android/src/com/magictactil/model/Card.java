package com.magictactil.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Card model
 * 
 * @author Benjamin
 *
 */
public class 			Card implements Serializable
{
	private static final long serialVersionUID = 1L;
	private String		name;
	private List<Set>			set;
	private ArrayList<String>		colors;
	private String		manacost;
	private String		type;
	private String		pt;
	private String		text;
	private int			id;
	
	public int 			getId() 
	{
		return (id);
	}

	public void setId(int id) 
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
	
	public ArrayList<String> getColors() {
		return (colors);
	}

	public void setColors(ArrayList<String> colors) {
		this.colors = colors;
	}

	public String 		getManacost() 
	{
		return (manacost);
	}
	
	public void 		setManacost(String manacost) 
	{
		this.manacost = manacost;
	}
	
	public String 		getType() 
	{
		return (type);
	}
	
	public void 		setType(String type) 
	{
		this.type = type;
	}
	
	public String 		getPt() 
	{
		return (pt);
	}
	
	public void 		setPt(String pt) 
	{
		this.pt = pt;
	}
	
	public String 		getText() 
	{
		return (text);
	}
	
	
	public List<Set> getSet() {
		return (set);
	}

	public void setSet(List<Set> set) {
		this.set = set;
	}

	public void 		setText(String text) 
	{
		this.text = text;
	}
}
