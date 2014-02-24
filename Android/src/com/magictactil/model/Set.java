package com.magictactil.model;

import java.io.Serializable;

import com.google.gson.annotations.SerializedName;

public class 			Set implements Serializable
{
	@SerializedName("-picURL")
	private String		picUrl;
	private String		text;
	public String getPicUrl() {
		return (picUrl);
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public String getText() {
		return (text);
	}
	public void setText(String text) {
		this.text = text;
	}
}
