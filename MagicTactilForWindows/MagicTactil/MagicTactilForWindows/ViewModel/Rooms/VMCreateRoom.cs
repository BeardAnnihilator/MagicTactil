using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MagicTactilForWindows.Model;
using MagicTactilForWindows.Utilities;
using System.Windows.Input;
using System.Windows;

namespace MagicTactilForWindows.ViewModel
{
    public class VMCreateRoom : APage
    {
        #region attribute
        /*
         * link to the server
         */
        private Network _Server;

        public event EventHandler<RoomEventArgs> roomCreation;

        private String name;

        private String _RoomName;
        public String RoomName {
            get { return _RoomName; }
            set { _RoomName = value; OnPropertyChanged("RoomName"); }
        }

        private String _Format;
        public String Format
        {
            get { return _Format; }
            set { _Format = value; OnPropertyChanged("Format"); }
        }

        private Visibility _errVisibility = new Visibility();
        public Visibility errVisibility { get { return _errVisibility; } set { _errVisibility = value; OnPropertyChanged("errVisibility"); } }
        private String _errMess = "";
        public String errMess
        {
            get { return _errMess; }
            set
            {
                _errMess = value;
                if (value.Equals(""))
                    errVisibility = Visibility.Hidden;
                else
                    errVisibility = Visibility.Visible;
                OnPropertyChanged("errMess");
            }
        }

        #endregion attribute

        #region command

        private ICommand __create;
        public ICommand create
        {
            get
            {
                if (__create == null)
                    __create = new RelayCommand<object>(createRoom, null);
                return __create;
            }
        }

        private ICommand __cancel;
        public ICommand cancel
        {
            get
            {
                if (__cancel == null)
                    __cancel = new RelayCommand<object>(cancelRoom, null);
                return __cancel;
            }
        }

        #endregion command

        #region constructor

        public VMCreateRoom(Network Server)
        {
            _Server = Server;
            Format = "Standard";
            _Server.GETUReturn += new EventHandler<serverReturnEventArgs>(r_GETU);
            _Server.CNROReturn += new EventHandler<serverReturnEventArgs>(r_CNRO);
            errVisibility = Visibility.Hidden;
        }

        #endregion constructor

        #region server result
        void r_GETU(object sender, serverReturnEventArgs e)
        {
            name = VMProfile.getval(e.data, "username");
            _Server.GETUReturn -= new EventHandler<serverReturnEventArgs>(r_GETU);
        }

        void r_CNRO(object sender, serverReturnEventArgs e)
        {
            if (!e.data.Contains("KO"))
            {
                Room created = new Room(int.Parse(e.data), name, Format, RoomName, 0);
                RoomEventArgs rargs = new RoomEventArgs(created);
                if (roomCreation != null)
                    roomCreation(this, rargs);


                MoveToEventArgs args = new MoveToEventArgs("Room");
                EventHandler<MoveToEventArgs> handler = this.getMoveTo();

                if (handler != null)
                    handler(this, args);
            }
        }

        #endregion server result

        #region event
        private void createRoom(object param)
        {
            if (Format != null && RoomName != null && !Format.Equals("") && !RoomName.Equals(""))
            {
                _Server.CreateRoom(name, Format, RoomName, 1); // 1 = public
            }
            else
            {
                errVisibility = Visibility.Visible;
                errMess = "There is no optional fields";
            }
        }

        private void cancelRoom(object param)
        {
            MoveToEventArgs e = new MoveToEventArgs("Rooms");
            EventHandler<MoveToEventArgs> handler = this.getMoveTo();
            errVisibility = Visibility.Hidden;

            if (handler != null)
                handler(this, e);
        }
        #endregion event

        public override void refresh_label() { }
    }
}
