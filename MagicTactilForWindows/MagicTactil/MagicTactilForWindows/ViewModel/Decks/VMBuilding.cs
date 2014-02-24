using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Input;
using System.Windows.Media.Imaging;
using MagicTactilForWindows.Model;
using MagicTactilForWindows.Utilities;

namespace MagicTactilForWindows.ViewModel
{
    public class VMBuilding : APage
    {

        #region attributes
        private Network _Server;
        private String name;
        public static List<Card> db = Utilities.JsonImporter._download_serialized_json_data<CardFileClass>("cards.json").cockatrice_carddatabase.cards.card;
        public static List<Card> sorteddb = sortList(db);
        
        private uint offset = 0;
        private uint index_size = 50;

        private string _filter = "";
        public string Filter
        {
            get { return _filter; }
            set { _filter = value; OnPropertyChanged("Filter");
            offset = 0;
            _collection.Clear();
            var number = (int)index_size>FilteredList.Count?FilteredList.Count:(int)index_size;
            Collection = new ObservableCollection<Card>(FilteredList.GetRange((int)offset, number));
            offset = (uint)number;
            selectedCard = Collection.First();
            OnPropertyChanged("selectedCard");
            }
        }

        private Deck deck = new Deck("tmp");

        private ObservableCollection<Model.Card> main = new ObservableCollection<Card>();
        public ObservableCollection<Model.Card> Main
        {
            get { return main; }
            set { main = value; OnPropertyChanged("Main"); }
        }

        private ObservableCollection<Model.Card> side = new ObservableCollection<Card>();
        public ObservableCollection<Model.Card> Side
        {
            get { return side; }
            set { side = value; OnPropertyChanged("Side"); }
        }

        private List<Model.Card> FilteredList
        {
            get { return sorteddb.Where(s => s.name.ToLower().Contains(Filter.ToLower())).ToList(); }
        }

        private SimpleCard _selectedCard = new SimpleCard("http://upload.wikimedia.org/wikipedia/en/a/aa/Magic_the_gathering-card_back.jpg");
        public SimpleCard selectedCard
        {
            get { return _selectedCard; }
            set { _selectedCard = value;
                OnPropertyChanged("selectedCard");}
        }

        private ObservableCollection<Model.Card> _collection = new ObservableCollection<Card>();
        public ObservableCollection<Model.Card> Collection
        {
            get { return _collection; }
            set { _collection = value; OnPropertyChanged("Collection"); }
        }

        private Boolean __isNew;
        public Boolean isNew
        {
            get { return __isNew; }
            set { __isNew = value; OnPropertyChanged("isNew"); }
        }

        private String __deckName;
        public String deckName 
        {
            get { return __deckName; }
            set { __deckName = value; OnPropertyChanged("deckName"); }
        }

        private ICommand __save;
        public ICommand save
        {
            get
            {
                if (__save == null)
                    __save = new RelayCommand<object>(Save, null);
                return __save;
            }
        }

        private ICommand __back;
        public ICommand back
        {
            get
            {
                if (__back == null)
                    __back = new RelayCommand<object>(Back, null);
                return __back;
            }
        }

        private ICommand __toMain;
        public ICommand toMain
        {
            get
            {
                if (__toMain == null)
                    __toMain = new RelayCommand<object>(ToMain, null);
                return __toMain;
            }
        }

        private ICommand __toSide;
        public ICommand toSide
        {
            get
            {
                if (__toSide == null)
                    __toSide = new RelayCommand<object>(ToSide, null);
                return __toSide;
            }
        }

#endregion 

        /// <summary>
        /// constructor takes server in args
        /// </summary>
        /// <param name="Server"></param>
        public VMBuilding(Network Server)
        {
            _Server = Server;
            _Server.GETUReturn += new EventHandler<serverReturnEventArgs>(r_GETU);
            _Server.CRDKReturn += new EventHandler<serverReturnEventArgs>(r_CRDK);

            var url = "cards.json";
            this.Collection = new ObservableCollection<Card>(FilteredList.GetRange(0, (int)index_size));
            offset = index_size;

            this.selectedCard = this.Collection.First();
        }

        void r_GETU(object sender, serverReturnEventArgs e)
        {
            name = VMProfile.getval(e.data, "username");
            _Server.GETUReturn -= new EventHandler<serverReturnEventArgs>(r_GETU);  
        }

        void r_CRDK(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
                isNew = false;
            // stuff...
        }

        /// <summary>
        /// clear deck
        /// </summary>
        public void Clear()
        {
            deckName = "Deck Name";
            __isNew = true;
            deck = new Deck("tmp");
        }

        /// <summary>
        /// display more cards
        /// </summary>
        public void loadMore()
        {
            var number = (int)index_size > FilteredList.Count  - (int)offset ? 
                FilteredList.Count - (int)offset
                : (int)index_size;
            ObservableCollection<Model.Card> tmp =
                new ObservableCollection<Card>(FilteredList.GetRange((int)offset, number));
            
            Application.Current.Dispatcher.Invoke(new Action(delegate()
            {
            foreach (Model.Card c in tmp)
            {
                this.Collection.Add(c);
            }
            }), null);

            offset = offset + (uint)number;        
        }

        private void Save(object param)
        {
            Dictionary<Card, int> deckTOsend = new Dictionary<Card, int>();
            Dictionary<Card, int> sideTOsend = new Dictionary<Card, int>();

            foreach (Card c in Main)
            {
                if (deckTOsend.Keys.Contains(c))
                    deckTOsend[c] += 1;
                else
                    deckTOsend.Add(c, 1);
            }
            foreach (Card c in Side)
            {
                if (sideTOsend.Keys.Contains(c))
                    sideTOsend[c] += 1;
                else
                    sideTOsend.Add(c, 1);
            }
            if (__isNew)
            {
                _Server.CreateDeck(name,deckName,true);
                deck.Name = deckName;
                foreach (KeyValuePair<Card, int> pair in deckTOsend)
                {
                    _Server.SetCardToDeck(name, deckName, db.IndexOf(pair.Key).ToString(), pair.Value, false);
                }
                foreach (KeyValuePair<Card, int> pair in sideTOsend)
                {
                    _Server.SetCardToDeck(name, deckName, db.IndexOf(pair.Key).ToString(), pair.Value, true);
                }
            }
        }
        private void Back(object param)
        {
            MoveToEventArgs args = new MoveToEventArgs("Decks");
            EventHandler<MoveToEventArgs> handler = this.getMoveTo();

            if (handler != null)
                handler(this, args);
        }
        /// <summary>
        /// put card to side board
        /// </summary>
        /// <param name="param"></param>
        private void ToMain(object param)
        {
            if (selectedCard.GetType() == typeof(Model.Card))
            Application.Current.Dispatcher.Invoke(new Action(delegate()
            {
                this.Main.Add((Model.Card)selectedCard);
            }), null);
        }

        /// <summary>
        /// sort a list
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="list"></param>
        /// <returns></returns>
        public static List<T> sortList<T>(List<T> list)
        {
            list.Sort();
            return list;
        }

        /// <summary>
        /// put card in sideboard
        /// </summary>
        /// <param name="param"></param>
        private void ToSide(object param)
        {
            if (selectedCard.GetType() == typeof(Model.Card))
            Application.Current.Dispatcher.Invoke(new Action(delegate()
            {
                this.Side.Add((Model.Card)selectedCard);
            }), null);
        }

        public override void refresh_label() { }
    }
}
