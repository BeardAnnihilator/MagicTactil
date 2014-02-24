using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows;
using System.Windows.Input;
using MagicTactilForWindows.Model;
using MagicTactilForWindows.Utilities;

namespace MagicTactilForWindows.ViewModel
{
    public class VMDecks : APage
    {
        private Network _Server;

        private String name;

        private ICommand __new;
        public ICommand New
        {
            get
            {
                if (__new == null)
                    __new = new RelayCommand<object>(buildNew, null);
                return __new;
            }
        }

        private ObservableCollection<Deck> _deckList = new ObservableCollection<Deck>();
        public ObservableCollection<Deck> deckList
        {
            get { return _deckList; }
            set
            {
                _deckList = value;
                OnPropertyChanged("deckList");
            }
        }


        /// <summary>
        /// constructor takes server as arg
        /// </summary>
        /// <param name="Server"></param>
        public VMDecks(Network Server)
        {
            _Server = Server;
            _Server.GETUReturn += new EventHandler<serverReturnEventArgs>(r_GETU);
        }
        
        /// <summary>
        /// refresh the list of decks
        /// </summary>
        public void refreshDeckList()
        {
            _Server.GLIDReturn += new EventHandler<serverReturnEventArgs>(r_GLID);

            _Server.GetListDecks(name);
        }

        /// <summary>
        /// receive the server return for the list of decks
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void r_GLID(object sender, serverReturnEventArgs e)
        {
            _Server.GLIDReturn -= new EventHandler<serverReturnEventArgs>(r_GLID);
            
            List<Deck> decks = DeckSpliting(e.data);

            if (decks.Count > 0)
            {
                _Server.SDTUReturn += new EventHandler<serverReturnEventArgs>(r_SDTU);
                /*
               * empty the deck list
               */
                Application.Current.Dispatcher.Invoke(new Action(delegate()
                {
                    deckList.Clear();
                }), null);

                /*
                 * fill the deck list
                 */
                foreach (Deck elem in decks)
                {
                    Application.Current.Dispatcher.Invoke(new Action(delegate()
                    {
                        deckList.Insert(0, elem);
                    }), null);

                    _Server.GetDeck(name, deckList.First().Id);
                }
            }
        }

        /// <summary>
        /// split a server return aand build a list of deck
        /// </summary>
        /// <param name="serverReturn"></param>
        /// <returns></returns>
        public static List<Deck> DeckSpliting(String serverReturn)
        {
            List<Deck> ret = new List<Deck>();

            foreach (String elem in Regex.Split(serverReturn, "idDeck\r").Where(w => w != "").ToArray())
            {
                String tmp = "idDeck\r" + elem;
                Deck tmpdeck = new Deck(VMProfile.getval(tmp, "idDeck"),
                                VMProfile.getval(tmp, "deckName"),
                                Boolean.Parse(VMProfile.getval(tmp, "isReal")),
                                null);
                ret.Add(tmpdeck);
            }

            return ret;
        }

        /// <summary>
        /// server return for user info
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void r_GETU(object sender, serverReturnEventArgs e)
        {
            name = VMProfile.getval(e.data, "username");
            _Server.GETUReturn -= new EventHandler<serverReturnEventArgs>(r_GETU);
        }

        /// <summary>
        /// server return for deck to user
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void r_SDTU(object sender, serverReturnEventArgs e)
        {
            _Server.SDTUReturn -= new EventHandler<serverReturnEventArgs>(r_SDTU);

            var idDeck = VMProfile.getval(e.data, "idDeck");
            var deck = deckList.Where(d => d.Id == idDeck).FirstOrDefault();

            List<Card> cards = VMGame.CardSpliting(e.data);

            /*
          * empty the deck
          */
            Application.Current.Dispatcher.Invoke(new Action(delegate()
            {
                deck.Main.Clear();
                deckList.Remove(deck);
            }), null);

            /*
             * fill the deck
             */
            foreach (Card elem in cards)
            {
                Application.Current.Dispatcher.Invoke(new Action(delegate()
                {
                    deck.Main.Insert(0, elem);
                }), null);
            }

            Application.Current.Dispatcher.Invoke(new Action(delegate()
            {
                deckList.Add(deck);
            }), null);
        }

        /// <summary>
        /// event click build new deck
        /// </summary>
        /// <param name="param"></param>
        private void buildNew(object param)
        {
            MoveToEventArgs args = new MoveToEventArgs("BuildingNew");
            EventHandler<MoveToEventArgs> handler = this.getMoveTo();

            if (handler != null)
                handler(this, args);
        }

        public override void refresh_label() { }
    }
}
