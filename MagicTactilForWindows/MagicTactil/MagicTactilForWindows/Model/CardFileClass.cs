using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Media.Imaging;


namespace MagicTactilForWindows.Model
{
   

    public class Set
    {
        public string name { get; set; }
        public string longname { get; set; }
    }

    public class Sets
    {
        public List<Set> set { get; set; }
    }

    public class Card : MagicTactilForWindows.ViewModel.SimpleCard, IComparable
    {
        public Card() : base("")
        {
        }

        public Card(Card other): base(other.fileName)
        {
            bitmap = other.bitmap;
            name = other.name;
            set = other.set;
            color = other.color;
            manacost = other.manacost;
            type = other.type;
            pt = other.pt;
            tablerow = other.tablerow;
            text = other.text;
        }

        public new string path
        {
            get {
                var type = this.set.GetType();
                if (type == typeof(Newtonsoft.Json.Linq.JObject))
                {
                    Newtonsoft.Json.Linq.JObject toto = ((Newtonsoft.Json.Linq.JObject)(this.set));

                    return (string)((Newtonsoft.Json.Linq.JValue)toto.First.First).Value;
                }
                else if (type == typeof(Newtonsoft.Json.Linq.JArray))
                {
                    Newtonsoft.Json.Linq.JArray toto = ((Newtonsoft.Json.Linq.JArray)(this.set));

                    return (string)((Newtonsoft.Json.Linq.JValue)toto[0].First.First).Value;
                }
                return "";
            }
        }

        public new BitmapSource Bitmap
        {
            get
            {
                if (bitmap == null)
                {
                        string url = "http://upload.wikimedia.org/wikipedia/en/a/aa/Magic_the_gathering-card_back.jpg";
                        var type = this.set.GetType();
                        if (type == typeof(Newtonsoft.Json.Linq.JObject))
                        {
                            Newtonsoft.Json.Linq.JObject toto = ((Newtonsoft.Json.Linq.JObject)(this.set));

                            url = (string)((Newtonsoft.Json.Linq.JValue)toto.First.First).Value;
                        }
                        else if (type == typeof(Newtonsoft.Json.Linq.JArray))
                        {
                            Newtonsoft.Json.Linq.JArray toto = ((Newtonsoft.Json.Linq.JArray)(this.set));

                            url = (string)((Newtonsoft.Json.Linq.JValue)toto[0].First.First).Value;
                        }
                    bitmap = new BitmapImage(new Uri(url));
                }

                return bitmap;
            }
        }

        public string name { get; set; }
        public object set { get; set; }
        public object color { get; set; }
        public string manacost { get; set; }
        public string type { get; set; }
        public string pt { get; set; }
        public string tablerow { get; set; }
        public string text { get; set; }

        

        public int CompareTo(object obj)
        {
            return this.name.CompareTo(((Card)obj).name);
        }

        public override string ToString()
        {
            return name;
        }
    }

    public class Cards
    {
        public List<Card> card { get; set; }
    }

    public class CockatriceCarddatabase
    {
        public Sets sets { get; set; }
        public Cards cards { get; set; }
    }
    /// <summary>
    /// This class represent the card db
    /// </summary>
    public class CardFileClass
    {
        public CockatriceCarddatabase cockatrice_carddatabase { get; set; }
    }
}
