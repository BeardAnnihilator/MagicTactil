using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MagicTactilForWindows.Model;
using System.Collections.ObjectModel;
using System.Windows.Media.Imaging;
using System.Windows.Input;
using MagicTactilForWindows.Utilities;
using System.Text.RegularExpressions;
using System.Windows;
using Microsoft.Surface.Presentation.Controls;

namespace MagicTactilForWindows.ViewModel
{
    public enum Location { Deck, Hand, Battlefield, Graveyard, Exile };

    public class SimpleCard
    {
        protected readonly string fileName;
        public string path
        {
            get { return fileName; }
        }

        public string gameId { get; set; }

        public Location location { get; set; }
        public Point center { get; set; }

        protected BitmapSource bitmap = null;
        public BitmapSource Bitmap
        {
            get
            {
                if (bitmap == null)
                {
                    bitmap = new BitmapImage(new Uri(fileName, UriKind.Absolute));
                }

                return bitmap;
            }
        }

        public SimpleCard(string fileName, string _gameId = "", int x = 0, int y = 0)
        {
            center = new Point(x, y);
            gameId = _gameId;
            this.fileName = fileName;
        }

        public SimpleCard(string fileName, Location _location, string _gameId = "", int x = 0, int y = 0)
        {
            location = _location;
            center = new Point(x, y);
            gameId = _gameId;
            this.fileName = fileName;
        }

        public SimpleCard(Card target)
        {
            gameId = "";
            if (target != null)
            {
                bitmap = target.bitmap;
                fileName = target.fileName;
            }
        }
    }

    /// <summary>
    /// View model for game board
    /// </summary>
    class VMGame : APage
    {
        

        private Network _Server;
        private VMRoom _Room;

        private String deckcount = "Deck";
        public String DeckCount
        {
            get { return deckcount; }
            set
            {
                deckcount = value;
                OnPropertyChanged("DeckCount");
            }
        }

        private int mypv = 20;
        public int MYPV
        {
            get { return mypv; }
            set
            {
                mypv = value;
                OnPropertyChanged("MYPV");
            }
        }

        private int hispv = 20;
        public int HISPV
        {
            get { return hispv; }
            set
            {
                hispv = value;
                OnPropertyChanged("HISPV");
            }
        }

        private String name;

        private ObservableCollection<SimpleCard> deck = new ObservableCollection<SimpleCard>();
        public ObservableCollection<SimpleCard> Deck
        {
            get { return deck; }
            set
            {
                deck = value;
                
                OnPropertyChanged("Deck");
            }
        }

        private ObservableCollection<SimpleCard> hand = new ObservableCollection<SimpleCard>();
        public ObservableCollection<SimpleCard> Hand
        {
            get { return hand; }
            set
            {
                hand = value;
                OnPropertyChanged("Hand");
            }
        }

        private ICommand __draw;
        public ICommand draw
        {
            get
            {
                if (__draw == null)
                    __draw = new RelayCommand<object>(drawCard, null);
                return __draw;
            }
        }

        private ICommand __surrend;
        public ICommand surrend
        {
            get
            {
                if (__surrend == null)  
                    __surrend = new RelayCommand<object>(surrender, null);
                return __surrend;
            }
        }

        private ICommand __lesspv;
        public ICommand lesspv
        {
            get
            {
                if (__lesspv == null)
                    __lesspv = new RelayCommand<object>(reducepv, null);
                return __lesspv;
            }
        }

        private ICommand __morepv;
        public ICommand morepv
        {
            get
            {
                if (__morepv == null)
                    __morepv = new RelayCommand<object>(addpv, null);
                return __morepv;
            }
        }

        private ObservableCollection<SimpleCard> myboard = new ObservableCollection<SimpleCard>();
        public ObservableCollection<SimpleCard> MyBoard
        {
            get { return myboard; }
            set
            {
                myboard = value;
                OnPropertyChanged("MyBoard");
            }
        }

        private ObservableCollection<SimpleCard> oppboard = new ObservableCollection<SimpleCard>();
        public ObservableCollection<SimpleCard> OppBoard
        {
            get { return oppboard; }
            set
            {
                oppboard = value;
                OnPropertyChanged("OppBoard");
            }
        }

        private ObservableCollection<SimpleCard> grave = new ObservableCollection<SimpleCard>();
        public ObservableCollection<SimpleCard> Grave
        {
            get { return grave; }
            set
            {
                grave = value;
                OnPropertyChanged("Grave");
            }
        }

        private ObservableCollection<SimpleCard> exile = new ObservableCollection<SimpleCard>();
        public ObservableCollection<SimpleCard> Exile
        {
            get { return exile; }
            set
            {
                exile = value;
                OnPropertyChanged("Exile");
            }
        }

        public Conversation roomChat { get { return _Room.roomChat; } set { _Room.roomChat = value; OnPropertyChanged("roomChat"); } }

        public VMGame(Network server, VMRoom room)
        {
            _Server = server;
            _Server.GETUReturn += new EventHandler<serverReturnEventArgs>(r_GETU);
            _Server.RSETReturn += new EventHandler<serverReturnEventArgs>(r_RSET);
            _Server.UPGIReturn += new EventHandler<serverReturnEventArgs>(r_UPGI);
            _Room = room;
            MyBoard.CollectionChanged += MyBoard_CollectionChanged;
        }

        void r_MOVE(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("destination"))
            {
                if (VMProfile.getval(e.data, "destination").Equals("Battlefield"))
                {
                    string gameId = VMProfile.getval(e.data,"idCard");
                    if (OppBoard.Where(c => c.gameId == gameId).Count() == 0)
                    {
                        var url = VMProfile.getval(e.data, "url");
                        var x = int.Parse(VMProfile.getval(e.data, "X"));
                        var y = int.Parse(VMProfile.getval(e.data, "Y"));
                        Application.Current.Dispatcher.Invoke(new Action(delegate()
                        {
                            OppBoard.Add(new SimpleCard(url, Location.Battlefield, gameId, x, y));
                        }), null);
                    }
                    
                }
            }
        }

        void MyBoard_CollectionChanged(object sender, System.Collections.Specialized.NotifyCollectionChangedEventArgs e)
        {
            if (e != null)
            {
                if (e.NewItems != null)
                {
                    foreach (SimpleCard c in e.NewItems)
                    {
                        c.gameId = c.gameId.Equals("") ? randomString(10) : c.gameId;

                        _Server.MoveCard(c.gameId, c.location.ToString(), Location.Battlefield.ToString(),
                            (int)c.center.X, (int)c.center.Y, ((Card)c).path, name, roomChat.roomdest.nameRoom);
                        c.location = Location.Battlefield;
                    }
                }
            }
        }

        private static Random random = new Random((int)DateTime.Now.Ticks);
        private string randomString(int size)
        {
            StringBuilder builder = new StringBuilder();
            char ch;
            for (int i = 0; i < size; i++)
            {
                ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
                builder.Append(ch);
            }

            return builder.ToString();
        }

        void r_GETU(object sender, serverReturnEventArgs e)
        {
            name = VMProfile.getval(e.data, "username");
            _Server.GETUReturn -= new EventHandler<serverReturnEventArgs>(r_GETU);

            
        }

        void r_GLID(object sender, serverReturnEventArgs e)
        {
            _Server.GLIDReturn -= new EventHandler<serverReturnEventArgs>(r_GLID);
            List<Deck> decks = VMDecks.DeckSpliting(e.data);
            if (decks.Count > 0)
            {
                _Server.SDTUReturn += new EventHandler<serverReturnEventArgs>(r_SDTU);
                _Server.GetDeck(name, decks.Last().Id);
            }
            else
            {
                roomChat.addContent("You need at least one deck to play.");
                surrender(null);
            }
        }

        void r_SDTU(object sender, serverReturnEventArgs e)
        {
            _Server.SDTUReturn -= new EventHandler<serverReturnEventArgs>(r_SDTU);

            List<Card> cards = CardSpliting(e.data);

            /*
          * empty the deck
          */
            Application.Current.Dispatcher.Invoke(new Action(delegate()
            {
                Deck.Clear();
            }), null);

            /*
             * fill the deck
             */
            foreach (Card elem in cards)
            {
                //if (!elem.Equals(String.Empty))
                Application.Current.Dispatcher.Invoke(new Action(delegate()
                {
                    Deck.Insert(0, elem);
                }), null);
            }
            Deck.Shuffle();
            DeckCount = "Deck " + Deck.Count;
        }

        void r_RSET(object sender, serverReturnEventArgs e)
        {

            Application.Current.Dispatcher.Invoke(new Action(delegate()
                        {
            Deck.Clear();
            Hand.Clear();
            MyBoard.Clear();
            OppBoard.Clear();
            Exile.Clear();
            Grave.Clear();
            MYPV = 20;
            HISPV = 20;
                        }), null);
            MoveToEventArgs args = new MoveToEventArgs("Room");
            EventHandler<MoveToEventArgs> handler = this.getMoveTo();

            if (handler != null)
                handler(this, args);
        }

        void r_UPGI(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("healthpoints"))
            {
                HISPV = int.Parse(VMProfile.getval(e.data, "healthpoints"));
            }
        }

        public static List<Card> CardSpliting(string serverReturn)
        {
            List<Card> ret = new List<Card>();



            foreach (String elem in Regex.Split(serverReturn, "idCard\r").Where(w => w != "").ToArray())
            {
                if (!elem.Contains("idDeck"))
                {
                    String tmp = "idCard\r" + elem;

                    for (int i = 0; i < Convert.ToInt32(VMProfile.getval(tmp, "nbCard")); i++)
                    {
                        Card tmpcard = new Card(VMBuilding.db.ElementAt(Convert.ToInt32(VMProfile.getval(tmp, "idCard"))));
                        tmpcard.location = Location.Deck;
                        ret.Add(tmpcard);
                    }
                }
            }
            return ret;
        }

        public void loadDeck()
        {
            _Server.GLIDReturn += new EventHandler<serverReturnEventArgs>(r_GLID);
            _Server.GetListDecks(name);
            _Server.MOVEReturn += new EventHandler<serverReturnEventArgs>(r_MOVE);
           /* _Server.GetDeck();
            for (int i = 0; i < 10; i++)
            {
                Deck.Add(new SimpleCard("C:/Users/Periph_a/Downloads/pokemon.jpg"));
                Deck.Add(new SimpleCard("C:/Users/Periph_a/Downloads/netrunner.jpg"));
                Deck.Add(new SimpleCard("C:/Users/Periph_a/Downloads/wakfu.jpg"));
                Deck.Add(new SimpleCard("C:/Users/Periph_a/Downloads/yugioh.jpg"));
            }
            DeckCount = "Deck " + Deck.Count;*/
        }

        private void drawCard(object param)
        {
            drawCard();
        }

        private void surrender(object param)
        {
            _Server.BackToLobby(name, _Room.roomAssociated.nameRoom); 
        }

        private void reducepv(object param)
        {
            MYPV -= 1;
            _Server.ChangeHealthCounters(name, _Room.roomAssociated.nameRoom, MYPV, 0);
        }

        private void addpv(object param)
        {
            MYPV += 1;
            _Server.ChangeHealthCounters(name, _Room.roomAssociated.nameRoom, MYPV, 0);
        }

        public void drawCard(int number = 1)
        {
            for (int i =0; i < number; i++)
            {
                if (Deck.Count > 0)
                {
                    Hand.Add(Deck.First());
                    Deck.RemoveAt(0);
                    Card c = (Card)Hand.Last();

                    c.gameId = c.gameId.Equals("") ? randomString(10) : c.gameId;

                    _Server.MoveCard(c.gameId, c.location.ToString(), Location.Hand.ToString(),
                        0, 0, c.path, name, roomChat.roomdest.nameRoom);
                    Hand.Last().location = Location.Hand;
                    DeckCount = "Deck " + Deck.Count;
                }
                else
                {
                    break;
                }
            }
        }
        public override void refresh_label() { }
    }
}
