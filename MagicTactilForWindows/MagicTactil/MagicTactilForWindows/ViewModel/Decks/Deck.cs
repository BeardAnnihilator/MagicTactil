using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MagicTactilForWindows.Model;

namespace MagicTactilForWindows.ViewModel
{
    /// <summary>
    /// this class represent a deck of cards
    /// </summary>
    public class Deck
    {
        private String name;
        public String Name
        {
            get { return name; }
            set { name = value; }
        }

        private String id;
        public String Id
        {
            get { return id; }
            set { id = value; }
        }

        private Boolean _isReal;
        public Boolean isReal
        {
            get { return _isReal; }
            set { _isReal = value; }
        }

        private List<Card> main;
        public List<Card> Main
        {
            get { return main; }
            set { main = value; }
        }

        private List<Card> side;
        public List<Card> Side
        {
            get { return side; }
            set { side = value; }
        }

        public Deck(String name, List<Card> cards = null, List<Card> side= null)
        {
            Name = name;
            Main = cards == null ? new List<Card>() : cards;
            Side = side == null ? new List<Card>() : side;
        }
        
        public Deck(String id, String name, Boolean isReal, List<Card> cards=null)
        {
            Id = id;
            Name = name;
            this.isReal = isReal;
            Main = cards == null ? new List<Card>() : cards;
            Side = side == null ? new List<Card>() : side;
        }

        public override string ToString()
        {
            return name.ToString() +"\t"+ Main.Count+" cards";
        }
    }
}
