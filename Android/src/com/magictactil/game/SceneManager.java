package com.magictactil.game;

import org.andengine.engine.Engine;
import org.andengine.engine.camera.Camera;
import org.andengine.entity.scene.Scene;
import org.andengine.entity.scene.background.Background;
import org.andengine.entity.sprite.Sprite;
import org.andengine.opengl.texture.atlas.bitmap.BitmapTextureAtlas;
import org.andengine.opengl.texture.atlas.bitmap.BitmapTextureAtlasTextureRegionFactory;
import org.andengine.opengl.texture.region.ITextureRegion;
import org.andengine.ui.activity.BaseGameActivity;

public class 					SceneManager
{
	private AllScenes			current_scene;
	private BaseGameActivity	game_activity;
	private Engine				engine;
	private Camera				camera;
	private BitmapTextureAtlas	ta_splash;
	private ITextureRegion		tr_splash;
	private Scene				game_scene;
	private Scene				menu_scene;
	private Scene				splash_scene;
	
	public enum 				AllScenes
	{
		SPLASH,
		MENU,
		GAME
	}

	public 						SceneManager(BaseGameActivity act, Engine eng, Camera cam) 
	{
		this.game_activity = act;
		this.engine = eng;
		this.camera = cam;
	}
	
	public void					loadSplashResources()
	{
		BitmapTextureAtlasTextureRegionFactory.setAssetBasePath("cards/");
		ta_splash = new BitmapTextureAtlas(game_activity.getTextureManager(), 128, 128);
		tr_splash = BitmapTextureAtlasTextureRegionFactory.createFromAsset(ta_splash, this.game_activity, "ic_launcher.png", 0, 0);
		ta_splash.load();
	}
	
	public void					loadGameResources()
	{
		
	}
	
	
	public Scene				createSplashScene()
	{
		this.splash_scene = new Scene();
		this.splash_scene.setBackground(new Background(125, 0, 0));
		
		Sprite icon = new Sprite(0, 0, tr_splash, engine.getVertexBufferObjectManager());
		icon.setPosition((camera.getWidth() - icon.getWidth()) / 2, (camera.getHeight() - icon.getHeight()));
		this.splash_scene.attachChild(icon);
		return (splash_scene);
	}

	public Scene				createGameScene()
	{
		this.game_scene = new Scene();
		this.game_scene.setBackground(new Background(0, 125, 0));
		return (game_scene);
	}
	
	public Scene				createMenuScene()
	{
		return (null);
	}
	
	public AllScenes		 	getCurrent_scene() 
	{
		return current_scene;
	}

	public void 				setCurrent_scene(AllScenes current_scene) 
	{
		this.current_scene = current_scene;
		switch (current_scene) {
		case SPLASH:
			break;
		case MENU:
			engine.setScene(menu_scene);
			break;
		case GAME:
			engine.setScene(game_scene);
			break;
		default:
			break;
		}
	}
	
	
}
