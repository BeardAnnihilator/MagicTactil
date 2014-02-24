using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.ObjectModel;
using MagicTactilForWindows.Model;
using System.Windows;
using System.Windows.Input;
using MagicTactilForWindows.Utilities;

namespace MagicTactilForWindows.ViewModel
{
    /// <summary>
    /// Friend list manager
    /// </summary>
    public class VMFriend : APage
    {
        private String name;
        private Network _Server;

        #region lists
        private bool _frORbl;
        public bool frORbl { get { return _frORbl; } set {
            _frORbl = value; OnPropertyChanged("frORbl");  OnPropertyChanged("frORblList"); } }
        private ObservableCollection<String> _friendList = new ObservableCollection<String>();
        public ObservableCollection<String> friendList { get { return _friendList; } set { _friendList = value; OnPropertyChanged("frORblList"); } }
        private ObservableCollection<String> _blackList = new ObservableCollection<String>();
        public ObservableCollection<String> blackList { get { return _blackList; } set { _blackList = value; OnPropertyChanged("frORblList"); } }
        
        public ObservableCollection<String> frORblList
        {
            get { 
                if (frORbl) return friendList; else return blackList; }
            set
            {
                if (frORbl) friendList = value; else blackList = value;
                OnPropertyChanged("frORblList");
            }
        }
        #endregion lists

        private String _entry;
        public String entry { get { return _entry; } set { _entry = value; OnPropertyChanged("entry"); } }
        private ICommand __friendenter;
        public ICommand friendenter
        {
            get
            {
                if (__friendenter == null)
                    __friendenter = new RelayCommand<object>(ask, null);
                return __friendenter;
            }
        }

        private VMConversationManager ConversationManager;

        /// <summary>
        /// constructor takes server in args
        /// </summary>
        /// <param name="Server"></param>
        public VMFriend(Network Server)
        {
            _Server = Server;
            Server.GETUReturn += new EventHandler<serverReturnEventArgs>(r_GETU);
            Server.GFRLReturn += new EventHandler<serverReturnEventArgs>(r_GFRL);
            Server.GTBLReturn += new EventHandler<serverReturnEventArgs>(r_GTBL);
            Server.ADFRReturn += new EventHandler<serverReturnEventArgs>(r_ADFR);
            Server.ADBLReturn += new EventHandler<serverReturnEventArgs>(r_ADBL);
            Server.DELFReturn += new EventHandler<serverReturnEventArgs>(r_DELF);
            Server.DEBLReturn += new EventHandler<serverReturnEventArgs>(r_DEBL);
            frORbl = true;
        }

        /// <summary>
        /// construcotr  with a conversatino manager
        /// </summary>
        /// <param name="Server"></param>
        /// <param name="CM"></param>
        public VMFriend(Network Server, VMConversationManager CM)
        {
            _Server = Server;
            Server.GETUReturn += new EventHandler<serverReturnEventArgs>(r_GETU);
            Server.GFRLReturn += new EventHandler<serverReturnEventArgs>(r_GFRL);
            Server.GTBLReturn += new EventHandler<serverReturnEventArgs>(r_GTBL);
            Server.ADFRReturn += new EventHandler<serverReturnEventArgs>(r_ADFR);
            Server.ADBLReturn += new EventHandler<serverReturnEventArgs>(r_ADBL);
            Server.DELFReturn += new EventHandler<serverReturnEventArgs>(r_DELF);
            Server.DEBLReturn += new EventHandler<serverReturnEventArgs>(r_DEBL);
            frORbl = true;
            ConversationManager = CM;
            
        }

        void r_ADFR(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
            {
                _Server.getFriendList(name);
            }
        }

        void r_ADBL(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
            {
                _Server.getBlackList(name);
            }
        }

        void r_GETU(object sender, serverReturnEventArgs e)
        {
            name = VMProfile.getval(e.data, "username");
            if (ConversationManager != null)
                ConversationManager.setName(name);
            _Server.getFriendList(name);
            _Server.getBlackList(name);
            _Server.GETUReturn -= new EventHandler<serverReturnEventArgs>(r_GETU);
        }

        void r_GFRL(object sender, serverReturnEventArgs e)
        {
            /*
           * empty the friend list
           */
            Application.Current.Dispatcher.Invoke(new Action(delegate()
            {
                friendList.Clear();
            }), null);

            /*
             * fill the friend list
             */
            foreach (String elem in e.data.Split('\n'))
            {
                if (!elem.Equals(String.Empty))
                    Application.Current.Dispatcher.Invoke(new Action(delegate()
                    {
                        friendList.Insert(0, elem);
                    }), null);
            }
        }

        void r_GTBL(object sender, serverReturnEventArgs e)
        {
            /*
           * empty the black list
           */
            Application.Current.Dispatcher.Invoke(new Action(delegate()
            {
                blackList.Clear();
            }), null);

            /*
             * fill the black list
             */
            foreach (String elem in e.data.Split('\n'))
            {
                if (!elem.Equals(String.Empty))
                    Application.Current.Dispatcher.Invoke(new Action(delegate()
                    {
                        blackList.Insert(0, elem);
                    }), null);
            }
        }

        void r_DELF(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
            {
                _Server.getFriendList(name);
            }
            else
            {
                //TODO: in case fail to remove a friend
            }
        }

        void r_DEBL(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
            {
                _Server.getBlackList(name);
            }
            else
            {
                //TODO: in case fail to remove a friend
            }
        }

        /// <summary>
        /// send friend request
        /// </summary>
        /// <param name="param"></param>
        private void ask(object param)
        {
            if (VMLogIn.IsValidName(entry))
            {
                if (frORbl)
                    _Server.addFriend(name, entry);
                else
                    _Server.addToBlackList(name, entry);
            }
        }

        /// <summary>
        /// remove a friend
        /// </summary>
        /// <param name="relative"></param>
        public void removeFriend(String relative)
        {
            if (frORbl)
                _Server.remFriend(name, relative);
            else
                _Server.remFromBlackList(name, relative);
        }

        /// <summary>
        /// open chat with a friend
        /// </summary>
        /// <param name="friend"></param>
        public void doubleClickAFriend(String friend)
        {
            if (ConversationManager != null)
            {
                ConversationManager.Add(friend);
            }
        }
        public override void refresh_label() { }
    }
}
