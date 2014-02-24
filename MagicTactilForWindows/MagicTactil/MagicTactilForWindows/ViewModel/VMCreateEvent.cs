using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MagicTactilForWindows.Model;
using System.Windows.Input;
using MagicTactilForWindows.Utilities;
using System.Windows;

namespace MagicTactilForWindows.ViewModel
{
    class VMCreateEvent : APage
    {
        #region attributes
        private Network _Server;

        private Visibility _errVisibility = new Visibility();
        public Visibility errVisibility { get { return _errVisibility; } set { _errVisibility = value; OnPropertyChanged("errVisibility"); } }
        private String _errMess = "";
        public String errMess { get { return _errMess; } set { _errMess = value;
        if (value.Equals(""))
            errVisibility = Visibility.Hidden;
        else
            errVisibility = Visibility.Visible;
        OnPropertyChanged("errMess"); } }

        private String _creatorName;
        private String _creatorEmail;

        #region eventInfo
        private String _eventName = "";
        public String eventName { get { return _eventName; } set { _eventName = value; OnPropertyChanged("eventName"); } }

        private String _eventDate = "";
        public String eventDate { get { return _eventDate; } set { _eventDate = value; OnPropertyChanged("eventDate"); } }

        private String _eventLocation = "";
        public String eventLocation { get { return _eventLocation; } set { _eventLocation = value; OnPropertyChanged("eventLocation"); } }

        private String _eventContent = "";
        public String eventContent { get { return _eventContent; } set { _eventContent = value; OnPropertyChanged("eventContent"); } }
        #endregion eventInfo
        #endregion attributes

        #region constructor
        public VMCreateEvent(Network Server)
        {
            _Server = Server;
            errMess = "";
            Server.GETUReturn += new EventHandler<serverReturnEventArgs>(r_GETU);
            Server.CREVReturn += new EventHandler<serverReturnEventArgs>(r_CREV);
        }
        #endregion constructor

        #region event
        private ICommand __create;
        public ICommand create
        {
            get
            {
                if (__create == null)
                    __create = new RelayCommand<object>(createEvent, null);
                return __create;
            }
        }

        private ICommand __cancel;
        public ICommand cancel
        {
            get
            {
                if (__cancel == null)
                    __cancel = new RelayCommand<object>(goHome, null);
                return __cancel;
            }
        }
        #endregion

        private void createEvent(object param)
        {
            if (!eventName.Equals(String.Empty) && VMLogIn.IsValidDate(eventDate)
                  && !eventLocation.Equals(String.Empty) && !eventContent.Equals(String.Empty))
                _Server.CreateEvent(_creatorName, eventName, _creatorEmail, eventContent, eventDate, eventLocation);
            else
            {

                errMess = "Error: No optional field.\nDate should be formated like dd/MM/yyyy or dd-MM-yyyy...";
            }
            
        }

        void r_CREV(object sender, serverReturnEventArgs servRet)
        {
            if (servRet.data.Contains("OK"))
            {
                goHome(null);
            }
            else
            {
                errMess = "Error: Event name exists already.";
            }
        }

        private void goHome(object param)
        {
            setEvent(String.Empty, String.Empty, String.Empty, String.Empty);
            errMess = String.Empty;
            MoveToEventArgs e = new MoveToEventArgs("Home");
            EventHandler<MoveToEventArgs> handler = this.getMoveTo();

            if (handler != null)
                handler(this, e);
        }

        void r_GETU(object sender, serverReturnEventArgs e)
        {
            _creatorName = VMProfile.getval(e.data, "username");
            _creatorEmail = VMProfile.getval(e.data, "email");
            _Server.GETUReturn -= new EventHandler<serverReturnEventArgs>(r_GETU);
        }

        /*
         * Set current event.
         */ 
        public void setEvent(String eventName, String eventLocation, String eventDate, String eventContent)
        {
            this.eventContent = eventContent;
            this.eventName = eventName;
            this.eventDate = eventDate;
            this.eventLocation = eventLocation;
        }
    }
}
