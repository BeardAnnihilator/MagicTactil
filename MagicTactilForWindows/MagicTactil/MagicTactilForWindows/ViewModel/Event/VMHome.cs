using System.Windows.Input;
using MagicTactilForWindows.Utilities;
using System;
using MagicTactilForWindows.Model;
using System.Collections.ObjectModel;
using System.Windows;
namespace MagicTactilForWindows.ViewModel
{
    /// <summary>
    /// view model for the principal view
    /// </summary>
    public class VMHome : APage
    {
        #region attribute
        /// <summary>
        /// link to the server
        /// </summary>
        private Network _Server;

        private String name;
        /// <summary>
        /// event's list
        /// </summary>
        private ObservableCollection<String> _eventList = new ObservableCollection<String>();
        public ObservableCollection<String> eventList
        {
            get { return _eventList; }
            set
            {
                _eventList = value;
                OnPropertyChanged("eventList");
            }
        }

        public string cr_event_label { get { return VMInnerBoard.getLanguage().Equals("EN") ? "+ Create Event" : "+ Creer Evenement"; } }
        

        #region eventInfo

 
        private string _creatorName;
        public string creatorName { get { return _creatorName; } set { _creatorName = value; OnPropertyChanged("creatorName"); } }
        
        private string _eventName;
        public string eventName { get { return _eventName; } set { _eventName = value; OnPropertyChanged("eventName"); } }

        private string _eventDate;
        public string eventDate { get { return _eventDate; } set { _eventDate = value; OnPropertyChanged("eventDate"); } }

        private string _eventLocation;
        public string eventLocation { get { return _eventLocation; } set { _eventLocation = value; OnPropertyChanged("eventLocation"); } }

        private string _eventContent;
        public string eventContent { get { return _eventContent; } set { _eventContent = value; OnPropertyChanged("eventContent"); } }

        private Visibility _creatorRight = new Visibility();
        public Visibility creatorRight { get { return _creatorRight; } set { _creatorRight = value; OnPropertyChanged("creatorRight"); } }

        private bool _signin = true;
        public bool signin { get { return _signin; } set { _signin = value; OnPropertyChanged("SignInLabel"); } }

        public String SignInLabel { get { if (signin) return "Sign In"; else return "Sign Out"; } }
        #endregion eventInfo

        #region event
        private ICommand __create_event;
        public ICommand create_event
        {
            get
            {
                if (__create_event == null)
                    __create_event = new RelayCommand<object>(showCreateEvent, null);
                return __create_event;
            }
        }

        private ICommand __refresh_event;
        public ICommand refresh_event
        {
            get
            {
                if (__refresh_event == null)
                    __refresh_event = new RelayCommand<object>(refreshEventList, null);
                return __refresh_event;
            }
        }

        private ICommand __delete_event;
        public ICommand delete_event
        {
            get
            {
                if (__delete_event == null)
                    __delete_event = new RelayCommand<object>(deleteEvent, null);
                return __delete_event;
            }
        }

        private ICommand __modify_event;
        public ICommand modify_event
        {
            get
            {
                if (__modify_event == null)
                    __modify_event = new RelayCommand<object>(modifyEvent, null);
                return __modify_event;
            }
        }

        private ICommand __sign_up_to_event;
        public ICommand sign_up_to_event
        {
            get
            {
                if (__sign_up_to_event == null)
                    __sign_up_to_event = new RelayCommand<object>(signToEvent, null);
                return __sign_up_to_event;
            }
        }


        #endregion

        #endregion attribute

        #region constructor

        public VMHome(Network Server)
        {
            creatorRight = Visibility.Hidden;

            _Server = Server;
            Server.GETUReturn += new EventHandler<serverReturnEventArgs>(r_GETU);
            Server.GTALReturn += new EventHandler<serverReturnEventArgs>(r_GTAL);
            Server.GETEReturn += new EventHandler<serverReturnEventArgs>(r_GETE);
            Server.DELEReturn += new EventHandler<serverReturnEventArgs>(r_DELE);
            Server.ISUEReturn += new EventHandler<serverReturnEventArgs>(r_ISUE);
            Server.SGUEReturn += new EventHandler<serverReturnEventArgs>(r_SGUE);
            Server.SGOEReturn += new EventHandler<serverReturnEventArgs>(r_SGOE);
        }

        #endregion constructor

        #region event
        
        void r_GETU(object sender, serverReturnEventArgs e)
        {
            name = VMProfile.getval(e.data, "username"); ;
            _Server.GETUReturn -= new EventHandler<serverReturnEventArgs>(r_GETU);
        }

        void r_GTAL(object sender, serverReturnEventArgs e)
        {
            /*
            * empty the event list
            */
            Application.Current.Dispatcher.Invoke(new Action(delegate()
            {
                eventList.Clear();
            }), null);

            /*
             * fill the event list
             */
            foreach (String elem in e.data.Split('\n'))
            {
                if (!elem.Equals(String.Empty))
                Application.Current.Dispatcher.Invoke(new Action(delegate()
                {
                    eventList.Insert(0,elem);
                }), null);
            }
        }

        void r_GETE(object sender, serverReturnEventArgs e)
        {
            creatorName = VMProfile.getval(e.data, "creator");
            eventName = VMProfile.getval(e.data, "name");
            eventContent = VMProfile.getval(e.data, "description").Replace("<br/>","\n");
            eventDate = VMProfile.getval(e.data, "date");
            eventLocation = VMProfile.getval(e.data, "location");
            if (creatorName.Equals(name))
            {
                creatorRight = Visibility.Visible;
            }
            _Server.isUserSuscribedToEvent(name, eventName);
        }

        void r_ISUE(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
            {
                signin = false;
            }
            else if (e.data.Contains("KO"))
            {
                signin = true;
            }
        }

        void r_DELE(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
            {
                _Server.GetListEvent();
            }
        }

        void r_SGOE(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
            {
                _Server.isUserSuscribedToEvent(name, eventName);
            }
        }

        void r_SGUE(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
            {
                _Server.isUserSuscribedToEvent(name, eventName);
            }
        }
        #endregion event

        #region methods
        public void refreshEventList(object param)
        {
            _Server.GetListEvent();
        }

        private void showCreateEvent(object param)
        {
            MoveToEventArgs e = new MoveToEventArgs("CreateEvent");
            EventHandler<MoveToEventArgs> handler = this.getMoveTo();

            if (handler != null)
                handler(this, e);
        }

        private void modifyEvent(object param)
        {
            MoveToEventArgs e = new MoveToEventArgs("ModifyEvent");
            EventHandler<MoveToEventArgs> handler = this.getMoveTo();

            if (handler != null)
                handler(this, e);
        }

        private void signToEvent(object param)
        {
            if (signin)
                _Server.SignUpEvent(name, eventName);
            else
                _Server.SignOutEvent(name, eventName);
        }

        internal void getEventInfo(String p)
        {
            _Server.GetEventInfo(p);
        }

        private void deleteEvent(object param)
        {
            _Server.DeleteEvent(eventName);
        }

        public override void refresh_label() {
            OnPropertyChanged("cr_event_label");
        }
        #endregion methods

    }
}
