using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MagicTactilForWindows.Model;
using MagicTactilForWindows.Utilities;
using System.Windows.Input;
using System.Collections.ObjectModel;
using System.Windows;
using System.Text.RegularExpressions;

namespace MagicTactilForWindows.ViewModel
{
    /// <summary>
    /// view model for manging rooms
    /// </summary>
    public class VMRooms : APage
    {
        #region attribute
        /*
         * link to the server
         */
        private Network _Server;

        private Room _selectedRoom;
        public Room selectedRoom
        {
            get { return _selectedRoom; }
            set { _selectedRoom = value; }
        }

        private String name;
        public string cr_room_label { get { return VMInnerBoard.getLanguage().Equals("EN") ? "+ Create Room" : "+ Creer Partie"; } }

        private ObservableCollection<String> _playerList = new ObservableCollection<String>();
        public ObservableCollection<String> playerList
        {
            get { return _playerList; }
            set { _playerList = value; OnPropertyChanged("playerList"); }

        }

        public event EventHandler<RoomEventArgs> roomJoin;

        private ObservableCollection<Room> _roomList = new ObservableCollection<Room>();
        public ObservableCollection<Room> roomList
        {
            get { return _roomList; }
            set
            {
                _roomList = value;
                OnPropertyChanged("roomList");
            }
        }


        #region command
        private ICommand __cr_room;
        public ICommand cr_room
        {
            get
            {
                if (__cr_room == null)
                    __cr_room = new RelayCommand<object>(CreateRoom, null);
                return __cr_room;
            }
        }

        private ICommand __refresh;
        public ICommand refresh
        {
            get
            {
                if (__refresh == null)
                    __refresh = new RelayCommand<object>(refreshRoomList, null);
                return __refresh;
            }
        }

        private ICommand __jo_room;
        public ICommand jo_room
        {
            get
            {
                if (__jo_room == null)
                    __jo_room = new RelayCommand<object>(JoinRoom, null);
                return __jo_room;
            }
        }

        #endregion command

        #endregion attribute

        #region constructor
        /// <summary>
        /// constructor with server as arg
        /// </summary>
        /// <param name="Server"></param>
        public VMRooms(Network Server)
        {
            _Server = Server;
            _Server.GEARReturn += new EventHandler<serverReturnEventArgs>(r_GEAR);
            _Server.GETUReturn += new EventHandler<serverReturnEventArgs>(r_GETU);
            _Server.JOROReturn += new EventHandler<serverReturnEventArgs>(r_JORO);
            _Server.GPFRReturn += new EventHandler<serverReturnEventArgs>(r_GPFR);
        }

        #endregion constructor

        public void refreshRoomList(object param)
        {
            _Server.GetAllRooms();
        }

        public void JoinRoom(object param)
        {
            _Server.JoinRoom(name, selectedRoom.nameRoom);
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

        void r_JORO(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
            {
                RoomEventArgs rargs = new RoomEventArgs(selectedRoom);
                if (roomJoin != null)
                    roomJoin(this, rargs);

                MoveToEventArgs args = new MoveToEventArgs("Room");
                EventHandler<MoveToEventArgs> handler = this.getMoveTo();

                if (handler != null)
                    handler(this, args);
            }
        }

        void r_GETU(object sender, serverReturnEventArgs e)
        {
            name = VMProfile.getval(e.data, "username");
            _Server.GETUReturn -= new EventHandler<serverReturnEventArgs>(r_GETU);
        }

        public void refreshPlayerList()
        {
            _Server.GetPlayerFromRoom(selectedRoom.id);
        }

        void r_GEAR(object sender, serverReturnEventArgs e)
        {

            List<Room> rooms = RoomSpliting(e.data);
            /*
           * empty the room list
           */
            Application.Current.Dispatcher.Invoke(new Action(delegate()
            {
                roomList.Clear();
            }), null);

            /*
             * fill the room list
             */
           foreach (Room elem in rooms)//e.data.Split('\n'))
            {
                //if (!elem.Equals(String.Empty))
                    Application.Current.Dispatcher.Invoke(new Action(delegate()
                    {
                        roomList.Insert(0, elem);
                    }), null);
            }
        }

        #region navigation
        /// <summary>
        /// go to the create room view
        /// </summary>
        /// <param name="param"></param>
        private void CreateRoom(object param)
        {
            MoveToEventArgs e = new MoveToEventArgs("CreateRoom");
            EventHandler<MoveToEventArgs> handler = this.getMoveTo();

            if (handler != null)
                handler(this, e);
        }
        #endregion navigation
        /// <summary>
        /// get a server return and build a list of room
        /// </summary>
        /// <param name="serverReturn"></param>
        /// <returns></returns>
        public static List<Room> RoomSpliting(String serverReturn)
        {
            
            List<Room> ret = new List<Room>();

            if (serverReturn.Contains("id"))
            {
                foreach (String elem in Regex.Split(serverReturn, "id\r").Where(w => w != "").ToArray())
                {
                    String tmp = "id\r" + elem;
                    ret.Add(new Room(
                        int.Parse(VMProfile.getval(tmp, "id")),
                        VMProfile.getval(tmp, "nameOwner"),
                        VMProfile.getval(tmp, "format"),
                        VMProfile.getval(tmp, "nameRoom"),
                        int.Parse(VMProfile.getval(tmp, "state"))));
                }
            }
            return ret;
        }

        public override void refresh_label() {
            OnPropertyChanged("cr_room_label");
        }

    }
}
