using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MagicTactilForWindows.Model;
using System.Windows.Input;
using MagicTactilForWindows.Utilities;
using System.Collections.ObjectModel;
using System.Windows;

namespace MagicTactilForWindows.ViewModel
{
    public class VMRoom : APage
    {
        #region attribute
        /*
         * link to the server
         */
        private Network _Server;
        private Room _roomAssociated;
        public Room roomAssociated
        {
            get { return _roomAssociated; }
            set { _roomAssociated = value; }
        }
        private String name;

        private ObservableCollection<String> _playerList = new ObservableCollection<String>();
        public ObservableCollection<String> playerList
        {
            get { return _playerList; }
            set { _playerList = value; OnPropertyChanged("playerList"); }

        }

        private Conversation _roomChat;
        public Conversation roomChat { get { return _roomChat; } set { _roomChat = value; OnPropertyChanged("roomChat"); } }

        #region command
        private ICommand __leave;
        public ICommand leave
        {
            get
            {
                if (__leave == null)
                    __leave = new RelayCommand<object>(leaveRoom, null);
                return __leave;
            }
        }
        private ICommand __ready;
        public ICommand ready
        {
            get
            {
                if (__ready == null)
                    __ready = new RelayCommand<object>(iAmReady, null);
                return __ready;
            }
        }

        #endregion command

        #endregion attribute

        #region constructor
        public VMRoom(Network Server)
        {
            _Server = Server;

            _Server.GPFRReturn += new EventHandler<serverReturnEventArgs>(r_GPFR);
            _Server.LEARReturn += new EventHandler<serverReturnEventArgs>(r_LEAR);
            _Server.DEROReturn += new EventHandler<serverReturnEventArgs>(r_DERO);
            _Server.GETUReturn += new EventHandler<serverReturnEventArgs>(r_GETU);
            _Server.KILRReturn += new EventHandler<serverReturnEventArgs>(r_KILR);
            _Server.PJROReturn += new EventHandler<serverReturnEventArgs>(r_PJRO);
            _Server.PLROReturn += new EventHandler<serverReturnEventArgs>(r_PLRO);
            //refreshPlayerList();
        }
        #endregion constructor

        public void refreshPlayerList()
        {
            _Server.GetPlayerFromRoom(roomAssociated.id);
        }

        #region server_return

        void r_KILR(object sender, serverReturnEventArgs e)
        {
            leaveTheRoom();
        }

        void r_PJRO(object sender, serverReturnEventArgs e)
        {
            refreshPlayerList();
        }

        void r_PLRO(object sender, serverReturnEventArgs e)
        {
            refreshPlayerList();
        }

        void r_GPFR(object sender, serverReturnEventArgs e)
        {
            /*
            * empty the player list
            */
            Application.Current.Dispatcher.Invoke(new Action(delegate()
            {
                playerList.Clear();
            }), null);

            /*
             * fill the room list
             */
            foreach (String elem in e.data.Split('\n'))
            {
                if (!elem.Equals(String.Empty))
                    Application.Current.Dispatcher.Invoke(new Action(delegate()
                    {
                        playerList.Insert(0, elem);
                    }), null);
            }
        }

        private void leaveTheRoom()
        {
            MoveToEventArgs args = new MoveToEventArgs("Rooms");
            EventHandler<MoveToEventArgs> handler = this.getMoveTo();

            if (handler != null)
                handler(this, args);
        }

        void r_LEAR(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
            {
                leaveTheRoom();
            }
        }

        void r_DERO(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
            {
                leaveTheRoom();
            }
        }

        void r_GETU(object sender, serverReturnEventArgs e)
        {
            name = VMProfile.getval(e.data, "username");
            _Server.GETUReturn -= new EventHandler<serverReturnEventArgs>(r_GETU);
        }

        #endregion server_return

        #region event

        public void roomAssociation(object sender, RoomEventArgs e)
        {
            roomAssociated = e.associated;
            roomChat = new Conversation(_Server, name, roomAssociated);
        }

        private void leaveRoom(object param)
        {
            if (name.Equals(roomAssociated.nameOwner))
            {
                _Server.DeleteRoom(name, roomAssociated.nameRoom);
            }
            else
            {
                _Server.LeaveRoom(name, roomAssociated.nameRoom);
            }
        }

        private void iAmReady(object param)
        {
            MoveToEventArgs e = new MoveToEventArgs("Game");
            EventHandler<MoveToEventArgs> handler = this.getMoveTo();

            if (handler != null)
                handler(this, e);
        }
        #endregion event



        public override void refresh_label() { }
        

    }
}
