package com.magictactil.model;

/**
 * model
 * 
 * @author Benjamin
 *
 */
public class Event 
{
	private String	name;
	private String	description;
	private String 	creator_email;
	private String	creator;
	private String	date;
	private String 	location;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCreator_email() {
		return creator_email;
	}
	public void setCreator_email(String creator_email) {
		this.creator_email = creator_email;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
}
