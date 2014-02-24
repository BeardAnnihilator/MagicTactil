using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MagicTactilForWindows.Model;
using System.Windows.Input;
using MagicTactilForWindows.Utilities;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Windows.Data;
using System.Xml;
using System.Configuration;

namespace MagicTactilForWindows.ViewModel
{

    enum InnerBoardView
    {
        HOME,
        PROFILE,
        CR_EVENT,
        MOD_EVENT,
        INNER_ROOM,
        INNER_DECKS,
    };

    /*
     * represent the inside part of the application (after loged in)
     */ 
    public class VMInnerBoard : APage
    {
        #region friend
        private VMFriend _Friend;
        public VMFriend Friend { get { return _Friend; } set { _Friend = value; OnPropertyChanged("Friend"); } }

        private VMConversationManager _ConversationManager;
        public VMConversationManager ConversationManager { get { return _ConversationManager; } set { _ConversationManager = value; OnPropertyChanged("ConversationManager"); } }

        #endregion friend

        #region attribute
        /*
         * link to the server
         */ 
        private Network _Server;
        
        private string _name;
        public string name { get { return _name; } set { _name = value; } }

        public string Home_label {get{return getLanguage().Equals("EN") ? "Home" : "Accueil";}}
        public string Rooms_label { get { return getLanguage().Equals("EN") ? "Rooms" : "Jeu"; } }
        public string Profile_label { get { return getLanguage().Equals("EN") ? "Profile" : "Profil"; } }
        public string LogOut_label { get { return getLanguage().Equals("EN") ? "Log out" : "Quitter"; } }
        public string Friends_label { get { return getLanguage().Equals("EN") ? "Friends" : "Amis"; } }
        public string language { get {return getLanguage().Equals("EN") ? "English" : "Francais"; } }

        #region collection of views
        /*
         * The collections of VM classes (representing Views)
         */
        private ObservableCollection<ViewModelBase> _ViewModels;
        public ObservableCollection<ViewModelBase> ViewModels
        {
            get { return _ViewModels; }
            set
            {
                _ViewModels = value;
                OnPropertyChanged("ViewModels");
            }
        }

        /*
         * These ones are used for bindings
         */
        private ICollectionView _ViewModelView;
        public ICollectionView ViewModelView
        {
            get { return _ViewModelView; }
            set
            {
                _ViewModelView = value;
                OnPropertyChanged("ViewModelView");
            }
        }
        #endregion collection of views

        #region command
        /*
         * command associated to the xaml button
         */
        private ICommand __disconnect;
        public ICommand disconnect
        {
            get
            {
                if (__disconnect == null)
                    __disconnect = new RelayCommand<object>(disconnection, null);
                return __disconnect;
            }
        }

        private ICommand __home;
        public ICommand home
        {
            get
            {
                if (__home == null)
                    __home = new RelayCommand<object>(showHome, null);
                return __home;
            }
        }

        private ICommand __rooms;
        public ICommand rooms
        {
            get
            {
                if (__rooms == null)
                    __rooms = new RelayCommand<object>(showRooms, null);
                return __rooms;
            }
        }

        private ICommand __profile;
        public ICommand profile
        {
            get
            {
                if (__profile == null)
                    __profile = new RelayCommand<object>(showProfile, null);
                return __profile;
            }
        }

        private ICommand __decks;
        public ICommand decks
        {
            get
            {
                if (__decks == null)
                    __decks = new RelayCommand<object>(showDecks, null);
                return __decks;
            }
        }

        private ICommand __translate;
        public ICommand translate
        {
            get
            {
                if (__translate == null)
                    __translate = new RelayCommand<object>(translateLanguage, null);
                return __translate;
            }
        }

        #endregion command

        #endregion attribute

        #region constructor

        public VMInnerBoard(Network Server)
        {
           _Server = Server;

           VMHome home = new VMHome(_Server);
           VMProfile profile = new VMProfile(_Server);
           VMCreateEvent create_event = new VMCreateEvent(_Server);
           VMModifyEvent mod_event = new VMModifyEvent(_Server);

           VMInnerRooms in_rooms = new VMInnerRooms(_Server);
           VMInnerDecks in_decks = new VMInnerDecks(_Server);
           

           ConversationManager =new VMConversationManager(_Server);
           Friend = new VMFriend(_Server, ConversationManager);

           home.moveTo +=new EventHandler<MoveToEventArgs>(Inner_moveTo);
           create_event.moveTo += new EventHandler<MoveToEventArgs>(Inner_moveTo);
           mod_event.moveTo += new EventHandler<MoveToEventArgs>(Inner_moveTo);
           Friend.moveTo += new EventHandler<MoveToEventArgs>(Inner_moveTo);
           in_rooms.moveTo += new EventHandler<MoveToEventArgs>(Inner_moveTo);
           
            /*
            * contains the home and profile screen (and probably more if this comment is not updated)
            */ 

           ViewModels = new ObservableCollection<ViewModelBase>()
            {
                home,
                profile,
                create_event,
                mod_event,
                in_rooms,
                in_decks
            };
           ViewModelView = CollectionViewSource.GetDefaultView(ViewModels);
        }

        #endregion constructor

        #region event
        
        //void r_GETU(object sender, serverReturnEventArgs e)
        //{
        //    String i = e.data;
        //}
        
        #endregion event


        #region event handler
        private void Inner_moveTo(object sender, MoveToEventArgs e)
        {
            this.move_To(e.page);
        }
        #endregion event handler

        #region navigation
        /*
         * this function change the value of ViewModelView.current
         * so the screen change.
         */
        private void move_To(string page)
        {
            if (ViewModelView != null)
            {
                switch (page)
                {
                    case "Home":
                        ((VMHome)ViewModels.ElementAt((int)InnerBoardView.HOME)).refreshEventList(null); //TODO : something cleaner for the same thing
                        ViewModelView.MoveCurrentToPosition((int)InnerBoardView.HOME);
                        break;
                    case "Profile":
                        ViewModelView.MoveCurrentToPosition((int)InnerBoardView.PROFILE);
                        break;
                    case "CreateEvent":
                        ViewModelView.MoveCurrentToPosition((int)InnerBoardView.CR_EVENT);
                        break;
                    case "ModifyEvent":
                        ((VMModifyEvent)ViewModels.ElementAt((int)InnerBoardView.MOD_EVENT)).setEvent(
                            ((VMHome)ViewModels.ElementAt((int)InnerBoardView.HOME)).eventName,
                            ((VMHome)ViewModels.ElementAt((int)InnerBoardView.HOME)).eventLocation,
                            ((VMHome)ViewModels.ElementAt((int)InnerBoardView.HOME)).eventDate,
                            ((VMHome)ViewModels.ElementAt((int)InnerBoardView.HOME)).eventContent); //TODO : something cleaner for the same thing
                        ViewModelView.MoveCurrentToPosition((int)InnerBoardView.MOD_EVENT);
                        break;
                    case "InnerRooms":
                        ViewModelView.MoveCurrentToPosition((int)InnerBoardView.INNER_ROOM);
                        ((VMInnerRooms)ViewModels.ElementAt((int)InnerBoardView.INNER_ROOM)).refreshRoomList();
                        break;
                    case "InnerDecks":
                        ViewModelView.MoveCurrentToPosition((int)InnerBoardView.INNER_DECKS);
                        ((VMInnerDecks)ViewModels.ElementAt((int)InnerBoardView.INNER_DECKS)).refreshDeckList();
                        break; 
                }
            }
        }

        /*
         * This function release the event with the good argument.
         */
        private void disconnection(object param)
        {
            /*
             * putting the home screen as default screen for next connexion
             */
            move_To("Home"); 

            /*
             * go back to log screen
             */
            MoveToEventArgs e = new MoveToEventArgs("logIn");
            EventHandler<MoveToEventArgs> handler = this.getMoveTo();

            if (handler != null)
                handler(this, e);
        }

        private void showProfile(object param)
        {
            move_To("Profile");
        }

        private void showHome(object param)
        {
            move_To("Home");
        }

        private void showRooms(object param)
        {
            move_To("InnerRooms");
        }

        private void showDecks(object param)
        {
            move_To("InnerDecks");
        }


        #endregion navigation

        /// <summary>
        /// get used language
        /// </summary>
        /// <returns></returns>
        public static string getLanguage()
        {
            XmlDocument doc = new XmlDocument();
            doc.Load("MagicTactilForWindows.exe.config");
            XmlNodeList l = doc.GetElementsByTagName("add");

            var valueAttribute = l.Item(1).Attributes["value"];

            return valueAttribute.Value;
        }

        private void translateLanguage(object param)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load("MagicTactilForWindows.exe.config");
            XmlNodeList l = doc.GetElementsByTagName("add");

            var valueAttribute = l.Item(1).Attributes["value"];
            if (!ReferenceEquals(null, valueAttribute))
            {
                valueAttribute.Value = valueAttribute.Value.Equals("EN") ? "FR" : "EN";
                
            }

            doc.Save("MagicTactilForWindows.exe.config");
            refresh_label();
            
            
        }

        public override void refresh_label() {

            OnPropertyChanged("language");
            OnPropertyChanged("Home_label");
            OnPropertyChanged("Profile_label");
            OnPropertyChanged("Friends_label");
            OnPropertyChanged("Rooms_label");
            OnPropertyChanged("LogOut_label");
            foreach (APage p in ViewModels)
            {
                p.refresh_label();
            }
        }
    }
}
