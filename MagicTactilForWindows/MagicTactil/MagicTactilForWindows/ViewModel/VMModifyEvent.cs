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
    class VMModifyEvent : APage
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

        #region eventInfo
        /*
         * can't be changed by user, used for comparison
         */ 
        private String _deepEventName = "";
        private String _deepEventDate = "";
        private String _deepEventLocation = "";
        private String _deepEventContent = "";

        /*
         * can be changed by user, used for comparison
         */ 
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
        public VMModifyEvent(Network Server)
        {
            _Server = Server;
            errMess = "";
            Server.SNIEReturn += new EventHandler<serverReturnEventArgs>(r_SNIE);
        }
        #endregion constructor

        #region event
        private ICommand __edit;
        public ICommand edit
        {
            get
            {
                if (__edit == null)
                    __edit = new RelayCommand<object>(editEvent, null);
                return __edit;
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

        private void editEvent(object param)
        {
            if (!eventName.Equals(String.Empty) && VMLogIn.IsValidDate(eventDate)
                  && !eventLocation.Equals(String.Empty) && !eventContent.Equals(String.Empty))
            {
                //errMess = "Error: Edit event is not yet stable on server.";
                if (!_deepEventLocation.Equals(eventLocation)) _Server.UpdateEvent(_deepEventName, "location", eventLocation);
                if (!_deepEventDate.Equals(eventDate)) _Server.UpdateEvent(_deepEventName, "date", eventDate);
                if (!_deepEventContent.Equals(eventContent)) _Server.UpdateEvent(_deepEventName, "description", eventContent);
            }
            else
            {

                errMess = "Error: No optional field.\nDate should be formated like dd/MM/yyyy or dd-MM-yyyy...";
            }
            
        }

        void r_SNIE(object sender, serverReturnEventArgs servRet)
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

        /*
         * Set current event.
         */ 
        public void setEvent(String eventName, String eventLocation, String eventDate, String eventContent)
        {
            this._deepEventContent = eventContent;
            this._deepEventName = eventName;
            this._deepEventDate = eventDate;
            this._deepEventLocation = eventLocation;

            this.eventContent = eventContent;
            this.eventName = eventName;
            this.eventDate = eventDate;
            this.eventLocation = eventLocation;
        }
    }
}
