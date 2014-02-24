package com.magictactil.game;

import org.andengine.entity.sprite.Sprite;
import org.andengine.opengl.texture.region.ITextureRegion;

/**
 * Ingame card
 * 
 * @author Benjamin
 *
 */
public class 			Card 
{
	private String		name;
	private String		img_name;
	private ITextureRegion	texture_region;
	private String		id;
	private String		url;
	private Sprite		sprite;
	
	public Sprite getSprite() {
		return (sprite);
	}
	public void setSprite(Sprite sprite) {
		this.sprite = sprite;
	}
	public String getUrl() {
		return (url);
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getId() {
		return (id);
	}
	public void setId(String id) {
		this.id = id;
	}
	public ITextureRegion getTexture_region() {
		return texture_region;
	}
	public void setTexture_region(ITextureRegion texture_region) {
		this.texture_region = texture_region;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImg_name() {
		return img_name;
	}
	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}
}
