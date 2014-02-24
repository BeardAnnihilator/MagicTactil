package com.magictactil.activities;

import java.io.File;
import java.io.IOException;
import java.lang.ref.WeakReference;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Stack;

import org.andengine.engine.camera.Camera;
import org.andengine.engine.handler.IUpdateHandler;
import org.andengine.engine.options.EngineOptions;
import org.andengine.engine.options.ScreenOrientation;
import org.andengine.engine.options.resolutionpolicy.RatioResolutionPolicy;
import org.andengine.entity.primitive.Line;
import org.andengine.entity.primitive.Rectangle;
import org.andengine.entity.scene.Scene;
import org.andengine.entity.scene.background.Background;
import org.andengine.entity.sprite.Sprite;
import org.andengine.entity.text.Text;
import org.andengine.entity.text.TextOptions;
import org.andengine.input.touch.TouchEvent;
import org.andengine.opengl.font.Font;
import org.andengine.opengl.font.FontFactory;
import org.andengine.opengl.texture.ITexture;
import org.andengine.opengl.texture.TextureOptions;
import org.andengine.opengl.texture.atlas.bitmap.BitmapTextureAtlas;
import org.andengine.opengl.texture.atlas.bitmap.BitmapTextureAtlasTextureRegionFactory;
import org.andengine.opengl.texture.region.ITextureRegion;
import org.andengine.opengl.texture.region.TextureRegion;
import org.andengine.opengl.texture.region.TextureRegionFactory;
import org.andengine.opengl.vbo.VertexBufferObjectManager;
import org.andengine.ui.activity.BaseGameActivity;
import org.andengine.util.HorizontalAlign;
import org.andengine.util.color.Color;

import android.content.Intent;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;

import com.magictactil.game.Action;
import com.magictactil.game.BitmapTextureSource;
import com.magictactil.game.Card;
import com.magictactil.game.Player;
import com.magictactil.model.Room;
import com.magictactil.network.Client_tcp;
import com.magictactil.network.GameModule;
import com.magictactil.network.Response;
import com.magictactil.session.SessionMT;
import com.magictactil.utils.Constants;
import com.magictactil.utils.Utils;

/**
 * Game activity managing the entire game process 
 * 
 * @author Benjamin
 *
 */
/**
 * @author Benjamin
 *
 */
public class 					GameActivity extends BaseGameActivity
{
	protected static final int	CAMERA_WIDTH = 1280;
	protected static final int 	CAMERA_HEIGHT = 800;
	protected static final int	CARD_WIDTH = 500;
	protected static final int 	CARD_HEIGHT = 500;
	protected static final int	INGAME_CARD_WIDTH = 100;
	protected static final int 	INGAME_CARD_HEIGHT = 135;
	protected static final int 	SECTION_WIDTH = 122;
	protected static final int 	SECTION_HEIGHT = 180;
	protected static final int 	PLAYER_HEIGHT = 350;
	protected static final int 	LINE_SIZE = 2;
	protected static final String TAPC = "TAPC";
	protected static final String UTAP = "UTAP";
	protected static final String MOVE = "MOVE";
	protected static final String UPGI = "UPGI";
	protected static final String RSET = "RSET";
	private Scene				scene;
	private Font				font;
	private Font				small_font;
	private Font				white_font;
	private BitmapTextureAtlas	player2_icon_ta;
	private ITextureRegion		player2_icon_tr;
	private BitmapTextureAtlas	player1_icon_ta;
	private ITextureRegion		player1_icon_tr;
	private BitmapTextureAtlas	library_ta;
	private ITextureRegion		library_tr;
	private BitmapTextureAtlas	grave_ta;
	private ITextureRegion		grave_tr;
	private BitmapTextureAtlas	exiled_ta;
	private ITextureRegion		exiled_tr;
	private BitmapTextureAtlas	hand_ta;
	private ITextureRegion		hand_tr;
	private BitmapTextureAtlas	grey_deck_ta;
	private ITextureRegion		grey_deck_tr;
	private Camera				camera;
	private Text 				library_text;
	private Text				p2_hand_text;
	private Text				life_text;
	private Text				p2_life_text;
	private Text				p1_exiled_text;
	private Player				player_1;
	private Player				player_2;
	private Text 				p2_library_text;
	private Text				p2_grave_text;
	private Text				p2_exiled_text;
	private Room				room;
	private Client_tcp			socket;
	private ArrayList<Action> 	send_queue;

	@Override
	protected void onCreate(Bundle pSavedInstanceState) 
	{
		room = (Room) getIntent().getExtras().get("room");
		socket = Client_tcp.getInstance();
		send_queue = new ArrayList<Action>();
		Log.d(Constants.TAG, "===== GAME BEGINS");
		super.onCreate(pSavedInstanceState);
	}

	@Override
	public EngineOptions 	onCreateEngineOptions() 
	{
		EngineOptions		options;

		camera = new Camera(0, 0, CAMERA_WIDTH, CAMERA_HEIGHT);
		options = new EngineOptions(true, ScreenOrientation.LANDSCAPE_FIXED, new RatioResolutionPolicy(CAMERA_WIDTH, CAMERA_HEIGHT), camera);
		return (options);
	}

	@Override
	public void 			onCreateResources(OnCreateResourcesCallback pOnCreateResourcesCallback) throws IOException 
	{
		BitmapTextureAtlasTextureRegionFactory.setAssetBasePath("cards/");

		// Create players
		this.player_1 = new Player();
		this.player_1.setName(SessionMT.current_user.getPseudo());
		this.player_2 = new Player();

		// TMP set players names
		this.player_2.setName("Player 2");

		// Create deck 
		SecureRandom random = new SecureRandom();

		ArrayList<com.magictactil.model.Card> cards = SessionMT.current_deck.getCards();
		Stack<Card> deck = new Stack<Card>();
		for (int i = 0; i < cards.size(); i++)
		{
			Card card = new Card();
			card.setId(new BigInteger(130, random).toString(10));
			card.setUrl(cards.get(i).getSet().get(0).getPicUrl());
			deck.add(card);
		}
		this.player_1.setDeck(deck);

		// load deck cards images
		this.loadDeckCardImages();

		this.loadGraphics();
		this.loadFonts();

		pOnCreateResourcesCallback.onCreateResourcesFinished();
	}

	/**
	 * Load graphics elements essentially images
	 */
	private void loadGraphics() 
	{
		BitmapTextureAtlasTextureRegionFactory.setAssetBasePath("cards/");

		this.library_ta = new BitmapTextureAtlas(getTextureManager(), 80, 114);
		this.library_tr = BitmapTextureAtlasTextureRegionFactory.createFromAsset(library_ta, this, "library.png", 0, 0);
		this.library_ta.load();

		// Load icon player
		this.player1_icon_ta = new BitmapTextureAtlas(getTextureManager(), 256, 256);
		this.player1_icon_tr = BitmapTextureAtlasTextureRegionFactory.createFromAsset(player1_icon_ta, this, "player1_icon.png", 0, 0);
		this.player1_icon_ta.load();
		this.player2_icon_ta = new BitmapTextureAtlas(getTextureManager(), 256, 256);
		this.player2_icon_tr = BitmapTextureAtlasTextureRegionFactory.createFromAsset(player2_icon_ta, this, "player2_icon.png", 0, 0);
		this.player2_icon_ta.load();

		// Load graveyard icon
		this.grave_ta = new BitmapTextureAtlas(getTextureManager(), 80, 80);
		this.grave_tr = BitmapTextureAtlasTextureRegionFactory.createFromAsset(grave_ta, this, "graveyard.png", 0, 0);
		this.grave_ta.load();

		// Load exiled icon
		this.exiled_ta = new BitmapTextureAtlas(getTextureManager(), 80, 80);
		this.exiled_tr = BitmapTextureAtlasTextureRegionFactory.createFromAsset(exiled_ta, this, "exiled.png", 0, 0);
		this.exiled_ta.load();

		// Load grey deck icon
		this.grey_deck_ta = new BitmapTextureAtlas(getTextureManager(), 80, 80);
		this.grey_deck_tr = BitmapTextureAtlasTextureRegionFactory.createFromAsset(grey_deck_ta, this, "grey_deck.png", 0, 0);
		this.grey_deck_ta.load();

		// Load hand icon
		this.hand_ta = new BitmapTextureAtlas(getTextureManager(), 80, 80);
		this.hand_tr = BitmapTextureAtlasTextureRegionFactory.createFromAsset(hand_ta, this, "hand.png", 0, 0);
		this.hand_ta.load();				
	}

	/**
	 * Load fonts
	 */
	private void loadFonts()
	{
		FontFactory.setAssetBasePath("fonts/");
		final ITexture fontTexture = new BitmapTextureAtlas(getTextureManager(), 256, 256, TextureOptions.BILINEAR_PREMULTIPLYALPHA);
		final ITexture fontTexture2 = new BitmapTextureAtlas(getTextureManager(), 256, 256, TextureOptions.BILINEAR_PREMULTIPLYALPHA);
		final ITexture fontTexture3 = new BitmapTextureAtlas(getTextureManager(), 256, 256, TextureOptions.BILINEAR_PREMULTIPLYALPHA);

		this.font = FontFactory.createFromAsset(this.getFontManager(), fontTexture, getAssets(), "Roboto-Condensed.ttf", 30f, true, new Color(0, 0, 0).hashCode());
		this.font.load();
		this.small_font = FontFactory.createFromAsset(this.getFontManager(), fontTexture2, getAssets(), "Roboto-Condensed.ttf", 20f, true, new Color(0, 0, 0).hashCode());
		this.small_font.load();
		this.white_font = FontFactory.createFromAsset(this.getFontManager(), fontTexture3, getAssets(), "Roboto-Condensed.ttf", 20f, true, new Color(1, 1, 1).hashCode());
		this.white_font.load();
	}

	/**
	 * Download cards' images from the image url
	 */
	private void loadDeckCardImages() 
	{
		for (int i = 0; i < this.player_1.getDeck().size(); i++)
		{
			File file = new File(this.getFilesDir(), SessionMT.current_deck.getCards().get(i).getId() + ".jpg");
			Log.d(Constants.TAG, "===== LOAD " + file.getPath());
			BitmapTextureSource source = new BitmapTextureSource(BitmapFactory.decodeFile(file.getPath()));
			BitmapTextureAtlas texture = new BitmapTextureAtlas(this.getTextureManager(), CARD_WIDTH, CARD_HEIGHT);
			texture.addTextureAtlasSource(source, 0, 0);
			texture.load();
			TextureRegion textureRegion = (TextureRegion) TextureRegionFactory.createFromSource(texture, source, 0, 0);
			this.player_1.getDeck().get(i).setTexture_region(textureRegion);
		}
	}

	@Override
	public void 			onCreateScene(OnCreateSceneCallback pOnCreateSceneCallback) throws IOException 
	{
		this.scene = new Scene();
		this.scene.registerUpdateHandler(new IUpdateHandler()
		{
			@Override
			public void onUpdate(float pSecondsElapsed) 
			{
				if (send_queue.size() == 0)
				{
					final Response resp = socket.nonBlockingReceive();

					if (resp != null)
					{
						if (resp.getFunc().equals(MOVE))
						{
							Action a = GameModule.parseMove(resp.getData());
							if (a.getDest().equals("Hand"))
							{
								DLTask task = new DLTask(GameActivity.this, a.getCard());

								task.execute();
								player_2.addToHand(a.getCard());
							}
							else if (a.getDest().equals("Battlefield"))
							{
								addCardToPlayer2(a.getCard());
							}
							p2_hand_text.setText("" + player_2.getHand().size());
						}
						else if (resp.getFunc().equals(TAPC))
						{
							ArrayList<Card> cards = player_2.getCards_bf();

							Action a = GameModule.parseMove(resp.getData());
							for (int i = 0; i < cards.size(); i++)
							{
								if (cards.get(i).getId().equals(a.getCard().getId()))
								{
									cards.get(i).getSprite().setRotationCenter(cards.get(i).getSprite().getWidth() / 2, cards.get(i).getSprite().getHeight() / 2);
									cards.get(i).getSprite().setRotation(90f);
								}
							}
						}
						else if (resp.getFunc().equals(UTAP))
						{
							ArrayList<Card> cards = player_2.getCards_bf();

							Action a = GameModule.parseMove(resp.getData());
							for (int i = 0; i < cards.size(); i++)
							{
								if (cards.get(i).getId().equals(a.getCard().getId()))
								{
									cards.get(i).getSprite().setRotationCenter(cards.get(i).getSprite().getWidth() / 2, cards.get(i).getSprite().getHeight() / 2);
									cards.get(i).getSprite().setRotation(0f);
								}
							}
						}
						else if (resp.getFunc().equals(UPGI))
						{
							int new_hp = GameModule.parseHP(resp.getData());
							
							player_2.setLife(new_hp);
							p2_life_text.setText("Life :" + player_2.getLife());
						}
						else if (resp.getFunc().equals(RSET))
						{
							finish();
						}
					}
				}
				else
				{
					Action a = send_queue.get(0);
					if (a.getType().equals(MOVE))
						GameModule.move(a.getCard(), room, a);
					else if (a.getType().equals(TAPC))
						GameModule.engageCard(a.getCard(), room);
					else if (a.getType().equals(UTAP))
						GameModule.desengageCard(a.getCard(), room);
					else if (a.getType().equals(UPGI))
						GameModule.updateGameInfo(room, player_1.getLife());
					send_queue.remove(0);
				}
			}

			@Override
			public void reset()
			{
			}
		});
		this.scene.setBackground(new Background(30f/255f, 18f/255f, 9f/255f));
		this.createPlayersUI();
		this.createPlayer1Deck();
		this.createPlayer1Grave();
		this.createPlayer1Exiled();
		this.createPlayer1Hand();
		this.createPlayer1UI();
		this.createPlayer2UI();
		scene.setTouchAreaBindingOnActionDownEnabled(true);
		pOnCreateSceneCallback.onCreateSceneFinished(this.scene);
	}

	/**
	 * Create user interface
	 */
	private void 		createPlayersUI() 
	{
		Rectangle		rect_players_ui;
		int				y_begin = PLAYER_HEIGHT;
		Line 			line;

		rect_players_ui = new Rectangle(0, 0, 275, CAMERA_HEIGHT, getVertexBufferObjectManager());
		rect_players_ui.setColor(227f/255f, 234f/255f, 242f/255f);
		line = new Line(0, y_begin, CAMERA_WIDTH,  y_begin, 15, getVertexBufferObjectManager());
		line.setColor(44f/255f, 132f/255f, 206f/255f);
		this.scene.attachChild(rect_players_ui);
		this.scene.attachChild(line);
	}

	/**
	 * Create player 1 interface
	 */
	private void 		createPlayer1UI()
	{
		int				y_begin = PLAYER_HEIGHT;
		Sprite			icon = new Sprite(20, y_begin + 20, player1_icon_tr, this.getVertexBufferObjectManager());
		Text			player1_name_text;
		Text			plus_text;
		Text			minus_text;
		Text			leave_text;

		leave_text = new Text(200, y_begin + 140, this.font, "Leave", new TextOptions(HorizontalAlign.CENTER), getVertexBufferObjectManager())
		{
			@Override
			public boolean onAreaTouched(final TouchEvent pSceneTouchEvent, final float pTouchAreaLocalX, final float pTouchAreaLocalY) 
			{
				switch (pSceneTouchEvent.getAction()) 
				{
				case TouchEvent.ACTION_DOWN:
					this.setScale(1.3f);
					break;
				case TouchEvent.ACTION_UP:
					GameModule.reset(room);
					finish();
					break;
				}
				return true;
			}
		};
		minus_text = new Text(190, y_begin + 120, this.font, "-", new TextOptions(HorizontalAlign.CENTER), getVertexBufferObjectManager())
		{
			@Override
			public boolean onAreaTouched(final TouchEvent pSceneTouchEvent, final float pTouchAreaLocalX, final float pTouchAreaLocalY) 
			{
				switch (pSceneTouchEvent.getAction()) 
				{
				case TouchEvent.ACTION_DOWN:
					this.setScale(1.3f);
					break;
				case TouchEvent.ACTION_UP:
					if (player_1.getLife() > 0)
					{
						player_1.decreaseLife();
						life_text.setText("Life : " + player_1.getLife());
						sendNewLife();
					}
					this.setScale(1f);
					break;
				}
				return true;
			}
		};
		plus_text = new Text(190, y_begin + 50, this.font, "+", new TextOptions(HorizontalAlign.CENTER), getVertexBufferObjectManager())
		{
			@Override
			public boolean onAreaTouched(final TouchEvent pSceneTouchEvent, final float pTouchAreaLocalX, final float pTouchAreaLocalY) 
			{
				switch (pSceneTouchEvent.getAction()) 
				{
				case TouchEvent.ACTION_DOWN:
					this.setScale(1.3f);
					break;
				case TouchEvent.ACTION_UP:
					player_1.increaseLife();
					life_text.setText("Life : " + player_1.getLife());
					this.setScale(1f);
					sendNewLife();
					break;
				}
				return true;
			}
		};
		this.life_text = new Text(150, y_begin + 80, this.font, "Life : " + this.player_1.getLife(), new TextOptions(HorizontalAlign.CENTER), getVertexBufferObjectManager());
		player1_name_text = new Text(150, y_begin + 30, this.font, this.player_1.getName(), new TextOptions(HorizontalAlign.CENTER), getVertexBufferObjectManager());
		this.scene.attachChild(icon);
		this.scene.attachChild(player1_name_text);
		this.scene.attachChild(life_text);
		this.scene.attachChild(plus_text);
		this.scene.registerTouchArea(plus_text);
		this.scene.attachChild(leave_text);
		this.scene.registerTouchArea(leave_text);
		this.scene.attachChild(minus_text);
		this.scene.registerTouchArea(minus_text);
	}

	/**
	 * Create player 1 hand interface
	 */
	private void		createPlayer1Hand()
	{
		Rectangle		background;

		background = new Rectangle(275, CAMERA_HEIGHT - 150, CAMERA_WIDTH - 275, 150, getVertexBufferObjectManager());
		background.setColor(44f/255f, 132f/255f, 206f/255f);
		this.scene.attachChild(background);
		this.createBlackRect("Hand", 275, CAMERA_HEIGHT - 170, CAMERA_WIDTH - 275);
	}

	/**
	 * Create player 1 deck
	 */
	private void		createPlayer1Deck()
	{
		Sprite			deck = new Sprite(80, PLAYER_HEIGHT + 150, library_tr, this.getVertexBufferObjectManager())
		{
			@Override
			public boolean onAreaTouched(final TouchEvent pSceneTouchEvent, final float pTouchAreaLocalX, final float pTouchAreaLocalY) 
			{
				switch (pSceneTouchEvent.getAction()) 
				{
				case TouchEvent.ACTION_DOWN:
					this.setScale(1.2f);
					break;
				case TouchEvent.ACTION_UP:
					if (player_1.getDeck().size() > 0)
					{
						addCardToHand();
						library_text.setText("" + player_1.getDeck().size());
					}
					this.setScale(1f);
					break;
				}
				return true;
			}
		};
		deck.setWidth(INGAME_CARD_WIDTH);
		deck.setHeight(INGAME_CARD_HEIGHT);
		this.library_text = new Text(80 + INGAME_CARD_WIDTH / 2, PLAYER_HEIGHT + INGAME_CARD_HEIGHT + 160, this.small_font, "" + player_1.getDeck().size(), new TextOptions(HorizontalAlign.CENTER), getVertexBufferObjectManager());
		createBlackRect("Deck", 80, PLAYER_HEIGHT + 130, INGAME_CARD_WIDTH);
		Log.d(Constants.TAG, "deck text x = " + library_text.getX() + " and y = " + library_text.getY());
		this.scene.attachChild(this.library_text);
		this.scene.attachChild(deck);
		this.scene.registerTouchArea(deck);
	}

	/**
	 * Graphic function to create a black rectangle with white text
	 * 
	 * @param s, text 
	 * @param x, x position
	 * @param y, y position
	 * @param width, width of the rectangle
	 */
	private void		createBlackRect(String s, int x, int y, int width)
	{
		Rectangle		rect;
		Text			text;

		rect = new Rectangle(x, y, width, 20, getVertexBufferObjectManager());
		rect.setColor(0, 0, 0);
		text = new Text(x, y - 1, white_font, s, new TextOptions(HorizontalAlign.CENTER), getVertexBufferObjectManager());
		this.scene.attachChild(rect);
		this.scene.attachChild(text);
	}

	/**
	 * Create a grey rectangle with an image inside
	 * 
	 * @param x, x position
	 * @param y, y position
	 * @param width, width
	 * @param height, height
	 * @param tr, ITextureRegion image to insert
	 */
	private void		createGreyBack(int x, int y, int width, int height, ITextureRegion tr)
	{
		Rectangle		rect;

		rect = new Rectangle(x, y, width, height, getVertexBufferObjectManager());
		rect.setColor(154f/255f, 154f/255f, 154f/255f);
		Sprite			sprite = new Sprite(x + 20, y + 20, tr, this.getVertexBufferObjectManager());
		this.scene.attachChild(rect);
		this.scene.attachChild(sprite);
	}

	/**
	 * Create player 1 graveyard
	 */
	private void		createPlayer1Grave()
	{
		this.createBlackRect("Graveyard", 20, CAMERA_HEIGHT - 150, INGAME_CARD_WIDTH);
		this.createGreyBack(20, CAMERA_HEIGHT - 130, INGAME_CARD_WIDTH, INGAME_CARD_HEIGHT, grave_tr);
	}

	/**
	 * Create player 1 exiled
	 */
	private void		createPlayer1Exiled()
	{
		int				x_begin;
		int				y_begin;

		this.createBlackRect("Exiled", 150, CAMERA_HEIGHT - 150, INGAME_CARD_WIDTH);
		this.createGreyBack(150, CAMERA_HEIGHT - 130, INGAME_CARD_WIDTH, INGAME_CARD_HEIGHT, exiled_tr);
		x_begin = CAMERA_WIDTH - SECTION_WIDTH;
		y_begin = CAMERA_HEIGHT - SECTION_HEIGHT;
		this.p1_exiled_text = new Text(x_begin + 10, y_begin + 5, this.font, "" + this.player_1.getExiled().size(), new TextOptions(HorizontalAlign.CENTER), getVertexBufferObjectManager());
		this.scene.attachChild(this.p1_exiled_text);
	}

	/**
	 * Create player 2 interface
	 */
	private void		createPlayer2UI()
	{
		Text			player2_name_text;
		Sprite			icon = new Sprite(20, PLAYER_HEIGHT - 120, player2_icon_tr, this.getVertexBufferObjectManager());

		this.p2_life_text = new Text(150, PLAYER_HEIGHT - 60, this.font, "Life : " + this.player_2.getLife(), new TextOptions(HorizontalAlign.CENTER), getVertexBufferObjectManager());
		player2_name_text = new Text(150, PLAYER_HEIGHT - 110, this.font, this.player_2.getName(), new TextOptions(HorizontalAlign.CENTER), getVertexBufferObjectManager());
		this.scene.attachChild(player2_name_text);
		this.scene.attachChild(p2_life_text);
		this.scene.attachChild(icon);
		this.createPlayer2Hand();
		this.createPlayer2Deck();

		// Graveyard
		Sprite			grave = new Sprite(20, 10, grave_tr, this.getVertexBufferObjectManager());

		this.p2_grave_text = new Text(60, 90, this.small_font, "0", new TextOptions(HorizontalAlign.CENTER), getVertexBufferObjectManager());
		this.scene.attachChild(grave);
		this.scene.attachChild(p2_grave_text);

		// Exiled
		Sprite			exiled = new Sprite(120, 10, exiled_tr, this.getVertexBufferObjectManager());

		this.p2_exiled_text = new Text(160, 90, this.small_font, "0", new TextOptions(HorizontalAlign.CENTER), getVertexBufferObjectManager());
		this.scene.attachChild(p2_exiled_text);
		this.scene.attachChild(exiled);
	}

	/**
	 * Create player 2 hand
	 */
	private void		createPlayer2Hand()
	{
		Sprite			icon = new Sprite(120, 120, hand_tr, this.getVertexBufferObjectManager());

		this.p2_hand_text = new Text(160, 200, this.small_font, "" + this.player_2.getHand().size(), new TextOptions(HorizontalAlign.CENTER), getVertexBufferObjectManager());
		this.scene.attachChild(this.p2_hand_text);
		this.scene.attachChild(icon);
	}

	/**
	 * Create player 2 deck
	 */
	private void		createPlayer2Deck()
	{
		Sprite			icon = new Sprite(30, 120, grey_deck_tr, this.getVertexBufferObjectManager());

		p2_library_text = new Text(60, 200, this.small_font, "" + this.player_2.getDeck().size(), new TextOptions(HorizontalAlign.CENTER), getVertexBufferObjectManager());
		this.scene.attachChild(p2_library_text);
		this.scene.attachChild(icon);
	}

	@Override
	public void 			onPopulateScene(Scene pScene, OnPopulateSceneCallback pOnPopulateSceneCallback) throws IOException
	{
		pOnPopulateSceneCallback.onPopulateSceneFinished();
	}

	/**
	 * Class managing a graphic card
	 * 
	 * @author Benjamin
	 *
	 */
	private class CardSprite extends Sprite
	{
		/**
		 * @param pX
		 * @param pY
		 * @param pTextureRegion
		 * @param pVertexBufferObjectManager
		 * @param c, the card
		 */
		public CardSprite(float pX, float pY, ITextureRegion pTextureRegion, VertexBufferObjectManager pVertexBufferObjectManager, Card c) 
		{
			super(pX, pY, pTextureRegion, pVertexBufferObjectManager);
			card = c;
		}

		boolean engaged = false;
		boolean mGrabbed = false;
		long lastTap = 0;
		long MAX_DURATION = 300;
		private Card 	card;

		@Override
		public boolean onAreaTouched(final TouchEvent pSceneTouchEvent, final float pTouchAreaLocalX, final float pTouchAreaLocalY) 
		{
			switch (pSceneTouchEvent.getAction()) 
			{
			case TouchEvent.ACTION_DOWN:
				lastTap = System.currentTimeMillis();
				this.mGrabbed = true;
				break;
			case TouchEvent.ACTION_MOVE:
				if(this.mGrabbed)
				{
					this.setScale(1.1f);
					this.setPosition(pSceneTouchEvent.getX() - this.getWidth() / 2, pSceneTouchEvent.getY() - this.getHeight() / 2);
				}
				break;
			case TouchEvent.ACTION_UP:
				long timePassed = System.currentTimeMillis() - lastTap;
				lastTap = System.currentTimeMillis();
				if (timePassed <= MAX_DURATION)
				{
//					this.setRotationCenter(this.getWidth() / 2, this.getHeight() / 2);
//					if (!engaged)
//					{
//						sendEngage(card);
//						this.setRotation(90f);
//					}
//					else
//					{
//						sendDesengage(card);
//						this.setRotation(0f);
//					}
//					engaged = !engaged;
				}
				else if(this.mGrabbed) 
				{
					this.mGrabbed = false;
					this.setScale(1f);
					sendMove("Battlefield", "Hand", card, 1 + (player_1.getCards_bf().size() % 9 * 10), 1 + (player_1.getCards_bf().size() / 9 * 50));
					this.setY(PLAYER_HEIGHT + 20 + (player_1.getCards_bf().size() / 9 * INGAME_CARD_HEIGHT));
					this.setX(285 + ((player_1.getCards_bf().size() % 9) * (INGAME_CARD_WIDTH + 10)));
					player_1.HandToBF();
				}
				break;
			}		
			return true;
		}
	}

	/**
	 * Add a card to the player 1 hand
	 */
	private void 			addCardToHand()
	{
		Card 				top_card = this.player_1.pickDeck();

		sendMove("Hand", "Deck", top_card, 0, 0);
		final Sprite sprite = new CardSprite(280 + INGAME_CARD_WIDTH * (this.player_1.getHand().size() - 1), CAMERA_HEIGHT - INGAME_CARD_HEIGHT - 10, top_card.getTexture_region(), this.getVertexBufferObjectManager(), top_card); 
		sprite.setWidth(INGAME_CARD_WIDTH);
		sprite.setHeight(INGAME_CARD_HEIGHT);
		this.scene.attachChild(sprite);
		this.scene.registerTouchArea(sprite);
	}

	/**
	 * Send a card movement to the server
	 * 
	 * @param dest, destination
	 * @param src, source
	 * @param card, card moved
	 * @param x, new x
	 * @param y, new y
	 */
	private void sendMove(String dest, String src, Card card, int x, int y)
	{
		Action a = new Action();
		a.setCard(card);
		a.setDest(dest);
		a.setSource(src);
		a.setX(x);
		a.setY(y);
		a.setType(MOVE);
		send_queue.add(a);
	}

	/**
	 * Send a card engagment to the server
	 * 
	 * @param card, card engaged
	 */
	private void sendEngage(Card card) 
	{
		Action a = new Action();
		a.setCard(card);
		a.setType(TAPC);
		send_queue.add(a);
	}	

	/**
	 * Send a card desengagment to the server
	 * 
	 * @param card
	 */
	private void sendDesengage(Card card) 
	{
		Action a = new Action();
		a.setCard(card);
		a.setType(UTAP);
		send_queue.add(a);
	}
	
	/**
	 * Send actual player 1 life the the server
	 */
	private void sendNewLife() 
	{
		Action a = new Action();
		a.setType(UPGI);
		send_queue.add(a);
	}

	/**
	 * Add a card to the player 2
	 * 
	 * @param card, card to add
	 */
	private void 			addCardToPlayer2(Card card)
	{
		File file = new File(this.getFilesDir(), card.getId() + ".jpg");
		BitmapTextureSource source = new BitmapTextureSource(BitmapFactory.decodeFile(file.getPath()));
		BitmapTextureAtlas texture = new BitmapTextureAtlas(this.getTextureManager(), CARD_WIDTH, CARD_HEIGHT);
		texture.addTextureAtlasSource(source, 0, 0);
		texture.load();
		TextureRegion textureRegion = (TextureRegion) TextureRegionFactory.createFromSource(texture, source, 0, 0);
		card.setTexture_region(textureRegion);
		Sprite sprite = new Sprite(285 + ((this.player_2.getCards_bf().size() % 9) * (INGAME_CARD_WIDTH + 10)), (10 + (this.player_2.getCards_bf().size() / 9 * (INGAME_CARD_HEIGHT + 10))), card.getTexture_region(), this.getVertexBufferObjectManager());
		card.setSprite(sprite);
		this.player_2.HandToBattlefield(card);
		sprite.setWidth(INGAME_CARD_WIDTH);
		sprite.setHeight(INGAME_CARD_HEIGHT);
		this.scene.attachChild(sprite);
	}

	/**
	 * Async task for downloading images
	 * 
	 * @author Benjamin
	 *
	 */
	static class										DLTask extends AsyncTask<Void, Integer, Boolean>
	{	
		private WeakReference<GameActivity> 			activity = null;
		private Card									card;

		/**
		 * @param act, activity
		 * @param c, card
		 */
		public 											DLTask(GameActivity act, Card c)
		{
			this.link(act);	
			card = c;
		}

		@Override
		protected void 									onPreExecute() 
		{
		}

		@Override
		protected Boolean 								doInBackground(Void... params) 
		{
			File file = new File(this.activity.get().getFilesDir(), card.getId() + ".jpg");
			Utils.downloadImgFromUrl(card.getUrl(), file);
			return (null);
		}

		@Override
		protected void 									onPostExecute(Boolean result) 
		{
			if (this.activity.get() != null)
			{
			}
		}

		/**
		 * Link activity with weak reference, activity could be destroyed during task 
		 * 
		 * @param act, activity
		 */
		public void 									link(GameActivity act) 
		{
			this.activity = new WeakReference<GameActivity>(act);
		}
	}
}
