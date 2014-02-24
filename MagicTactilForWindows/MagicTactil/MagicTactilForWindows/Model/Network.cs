using System;
using System.Text;
using System.Net.Sockets;
using System.Net;
using System.Threading;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace MagicTactilForWindows.Model
{
    /// <summary>
    /// Server's abstraction
    /// </summary>
    public abstract class ANetwork
    {
        #region attribute

        protected int default_dst = 0;
        protected int _id;
        public int id
        {
            get { return _id; }
            set { if (_id == 0) _id = value; }
        }
        protected Thread reader;

        #region events
        public event EventHandler<serverReturnEventArgs> AnyReturn;
        #region AUTH
        public event EventHandler<serverReturnEventArgs> SGNIReturn;
        public event EventHandler<serverReturnEventArgs> SGNOReturn;
        public event EventHandler<serverReturnEventArgs> REGUReturn;
        #endregion AUTH

        #region profile
        public event EventHandler<serverReturnEventArgs> SETUReturn;
        public event EventHandler<serverReturnEventArgs> GETUReturn;
        #endregion profile

        #region event
        public event EventHandler<serverReturnEventArgs> CREVReturn;
        public event EventHandler<serverReturnEventArgs> SGUEReturn;
        public event EventHandler<serverReturnEventArgs> SGOEReturn;
        public event EventHandler<serverReturnEventArgs> DELEReturn;
        public event EventHandler<serverReturnEventArgs> SNIEReturn;
        public event EventHandler<serverReturnEventArgs> GTALReturn;
        public event EventHandler<serverReturnEventArgs> GETEReturn;
        public event EventHandler<serverReturnEventArgs> ISUEReturn;
        #endregion event

        #region friend_blacklist
        public event EventHandler<serverReturnEventArgs> ADFRReturn;
        public event EventHandler<serverReturnEventArgs> DELFReturn;
        public event EventHandler<serverReturnEventArgs> GFRLReturn;

        public event EventHandler<serverReturnEventArgs> ADBLReturn;
        public event EventHandler<serverReturnEventArgs> DEBLReturn;
        public event EventHandler<serverReturnEventArgs> GTBLReturn;
        #endregion friend_blacklist

        #region room
        public event EventHandler<serverReturnEventArgs> CNROReturn;
        public event EventHandler<serverReturnEventArgs> DEROReturn;
        public event EventHandler<serverReturnEventArgs> JOROReturn;
        public event EventHandler<serverReturnEventArgs> LEARReturn;
        public event EventHandler<serverReturnEventArgs> GPFRReturn;
        public event EventHandler<serverReturnEventArgs> GEARReturn;
        public event EventHandler<serverReturnEventArgs> KILRReturn;
        public event EventHandler<serverReturnEventArgs> PJROReturn;
        public event EventHandler<serverReturnEventArgs> PLROReturn;
        #endregion room

        #region notification
        public event EventHandler<serverReturnEventArgs> MESPReturn;
        public event EventHandler<serverReturnEventArgs> MESBReturn;
        #endregion notification

        #region deck
        public event EventHandler<serverReturnEventArgs> GLIDReturn;
        public event EventHandler<serverReturnEventArgs> CRDKReturn;
        public event EventHandler<serverReturnEventArgs> SDTUReturn;
        #endregion deck

        #region cards
        public event EventHandler<serverReturnEventArgs> GCBIReturn;
        public event EventHandler<serverReturnEventArgs> ACFDReturn;
        public event EventHandler<serverReturnEventArgs> RCFDReturn;
        #endregion cards

        #region game
        public event EventHandler<serverReturnEventArgs> MOVEReturn;
        public event EventHandler<serverReturnEventArgs> TAPCReturn;
        public event EventHandler<serverReturnEventArgs> UTAPReturn;
        public event EventHandler<serverReturnEventArgs> UTAAReturn;
        public event EventHandler<serverReturnEventArgs> UPGIReturn;
        public event EventHandler<serverReturnEventArgs> DAABReturn;
        public event EventHandler<serverReturnEventArgs> SYWLReturn;
        public event EventHandler<serverReturnEventArgs> RSETReturn;
        #endregion game

        #endregion events

        #endregion attribute

        #region constructor destructor

        public abstract void connect(string ip, int port);

        public abstract void disconnect();

        ~ANetwork()
        {
            try { reader.Abort(); }
            catch (NullReferenceException) { }
        }

        #endregion constructor destructor

        #region send

        /*
         * Send message to server
         */ 
        protected abstract void send(int _src, int _dst, String _fun, String _data);

        #endregion send

        #region get

        /*
         * receive message from server
         */ 
        protected void read()
        {
            while (true)
            {
                serverReturnEventArgs ret = this.receive();
                this.eventThrowing(ret);
            }
        }

        protected abstract serverReturnEventArgs receive();

        #endregion get

        #region throwEvent

        /* 
         * Return a dictionary with (4char code -> event) 
         * (Can't be done in constructor because Dictionary is unmutable)
         * (So we do it dynamicly.)
         */
        private Dictionary<String, EventHandler<serverReturnEventArgs>> eventMappping()
        {
            Dictionary<String, EventHandler<serverReturnEventArgs>> eventMap;
            eventMap = new Dictionary<string, EventHandler<serverReturnEventArgs>>();
            eventMap.Add("SGNI", SGNIReturn);
            eventMap.Add("SGNO", SGNOReturn);
            eventMap.Add("REGU", REGUReturn);
            eventMap.Add("SETU", SETUReturn);
            eventMap.Add("GETU", GETUReturn);
            eventMap.Add("CREV", CREVReturn);
            eventMap.Add("SGUE", SGUEReturn);
            eventMap.Add("SGOE", SGOEReturn);
            eventMap.Add("DELE", DELEReturn);
            eventMap.Add("SNIE", SNIEReturn);
            eventMap.Add("GTAL", GTALReturn);
            eventMap.Add("GETE", GETEReturn);
            eventMap.Add("ADFR", ADFRReturn);
            eventMap.Add("DELF", DELFReturn);
            eventMap.Add("GFRL", GFRLReturn);
            eventMap.Add("ADBL", ADBLReturn);
            eventMap.Add("DEBL", DEBLReturn);
            eventMap.Add("GTBL", GTBLReturn);
            eventMap.Add("CNRO", CNROReturn);
            eventMap.Add("DERO", DEROReturn);
            eventMap.Add("JORO", JOROReturn);
            eventMap.Add("LEAR", LEARReturn);
            eventMap.Add("ISUE", ISUEReturn);
            eventMap.Add("GEAR", GEARReturn);
            eventMap.Add("GPFR", GPFRReturn);
            eventMap.Add("KILR", KILRReturn);
            eventMap.Add("PJRO", PJROReturn);
            eventMap.Add("PLRO", PLROReturn);
            eventMap.Add("MESP", MESPReturn);
            eventMap.Add("MESB", MESBReturn);
            eventMap.Add("GLID", GLIDReturn);
            eventMap.Add("CRDK", CRDKReturn);
            eventMap.Add("SDTU", SDTUReturn);
            eventMap.Add("GCBI", GCBIReturn);
            eventMap.Add("ACFD", ACFDReturn);
            eventMap.Add("RCFD", RCFDReturn);
            eventMap.Add("MOVE", MOVEReturn);
            eventMap.Add("TAPC", TAPCReturn);
            eventMap.Add("UTAP", UTAPReturn);
            eventMap.Add("UTAA", UTAAReturn);
            eventMap.Add("UPGI", UPGIReturn);
            eventMap.Add("DAAB", DAABReturn);
            eventMap.Add("SYWL", SYWLReturn);
            eventMap.Add("RSET", RSETReturn);
            return eventMap;
        }

        /* 
         * Throw event depending of the server returns
         */
        private void eventThrowing(serverReturnEventArgs e)
        {
            if (AnyReturn != null)
                AnyReturn(this, e);

            EventHandler<serverReturnEventArgs> eventHandler;
            if (this.eventMappping().TryGetValue(e.func, out eventHandler))
            {
                if (eventHandler != null)
                    eventHandler(this, e);
            }
        }

        #endregion throwEvent

        #region public

        private String sep = "\r";

        #region AUTH
        /*
         * log in SGNI
         */
        public void SignIn(String username, String password)
        {
            // TODO : get id
            String data = "username" + sep + username + "\n"
                        + "password" + sep + password + "\n";
            this.send(this._id, this.default_dst, "SGNI", data);
        }

        /*
         * log out SGNO
         */
        public void SignOut(String username, String password)
        {
            String data = "username" + sep + username + "\n";
            this.send(this._id, this.default_dst, "SGNO", data);
        }

        /*
         * register REGU
         */
        public void SignUp(String mail, String username, String name, String givenname, String birthday, String location, String password, String telephone, String gender)
        {
            String data = "email" + sep + mail + "\n"
                        + "username" + sep + username + "\n"
                        + "name" + sep + name + "\n"
                        + "givenname" + sep + givenname + "\n"
                        + "birthday" + sep + birthday + "\n"
                        + "location" + sep + location + "\n"
                        + "password" + sep + password + "\n"
                        + "telephone" + sep + telephone + "\n"
                        + "gender" + sep + gender + "\n";

            this.send(this._id, this.default_dst, "REGU", data);
        }

        #endregion AUTH
        #region PROFILE
        /*
         * GETU
         */
        public void GetInfoUser(String username)
        {
            String data = "username" + sep + username + "\n";
            this.send(this._id, this.default_dst, "GETU", data);
        }

        /*
         * SETU
         */
        public void SetInfoUser(String name, String key, String newValue)
        {
            String data = "username" + sep + name + "\n"
                               + key + sep + newValue + "\n";
            this.send(this._id, this.default_dst, "SETU", data);
        }
        #endregion PROFILE
        #region EVENT
        /*
         * Create event CREV
         */
        public void CreateEvent(String creator, String name, String creatorEmail, String description, String date, String location)
        {
            String data = "creator" + sep + creator + "\n"
                            + "name" + sep + name + "\n"
                            + "creatorEmail" + sep + creatorEmail + "\n"
                            + "description" + sep + description.Replace("\r", String.Empty).Replace("\n","<br/>") + "\n"
                            + "date" + sep + date + "\n"
                            + "location" + sep + location + "\n";
            this.send(this._id, this.default_dst, "CREV", data);
        }

        /*
         * Sign up event SGUE
         */
        public void SignUpEvent(String username, String eventName)
        {
            String data = "username" + sep + username + "\n"
                            + "name" + sep + eventName + "\n";
            this.send(this._id, this.default_dst, "SGUE", data);
        }

        /*
         * Sign out event SGOE
         */
        public void SignOutEvent(String username, String eventName)
        {
            String data = "username" + sep + username + "\n"
                            + "name" + sep + eventName + "\n";
            this.send(this._id, this.default_dst, "SGOE", data);
        }

        /*
         * Delete event DELE
         */
        public void DeleteEvent(String eventName)
        {
            String data = "name" + sep + eventName + "\n";
            this.send(this._id, this.default_dst, "DELE", data);
        }

        /*
         * update event SNIE
         */
        public void UpdateEvent(String eventName, String key, String value)
        {
            String data = "name" + sep + eventName + "\n"
                            + key + sep + value.Replace("\r", String.Empty).Replace("\n", "<br/>") + "\n";
            this.send(this._id, this.default_dst, "SNIE", data);
        }

        /*
         * get List of event GTAL
         */
        public void GetListEvent()
        {
            String data = String.Empty;
            this.send(this._id, this.default_dst, "GTAL", data);
        }

        /*
         * get info of event GETE
         */
        public void GetEventInfo(String eventName)
        {
            String data = "name" + sep + eventName + "\n";
            this.send(this._id, this.default_dst, "GETE", data);
        }

        /*
         * check if user is registered to an event ISUE
         */
        public void isUserSuscribedToEvent(String username, String eventName)
        {
            String data = "username" + sep + username + "\n" 
                + "name" + sep + eventName + "\n";
            this.send(this._id, this.default_dst, "ISUE", data);
        }
        #endregion EVENT
        #region FRIEND
        
        /*
         * add a friend ADFR
         */
        public void addFriend(String name, String friendName)
        {
            String data = "username" + sep + name + "\n"
             + "belongsto" + sep + friendName + "\n";
            this.send(this._id, this.default_dst, "ADFR", data);
        }

        /*
         * remove a friend DEFR
         */
        public void remFriend(String name, String friendName)
        {
            String data = "username" + sep + name + "\n"
             + "belongsto" + sep + friendName + "\n";
            this.send(this._id, this.default_dst, "DELF", data);
        }

        /*
         * get Friend List GFRL
         */
        public void getFriendList(String name)
        {
            String data = "username" + sep + name + "\n";
            this.send(this._id, this.default_dst, "GFRL", data);
        }

        #endregion FRIEND
        #region BLACKLIST

        /*
         * add someone to blacklist ADBL
         */
        public void addToBlackList(String name, String blackName)
        {
            String data = "username" + sep + name + "\n"
             + "belongsto" + sep + blackName + "\n";
            this.send(this._id, this.default_dst, "ADBL", data);
        }

        /*
         * remove someone from blacklist DEBL
         */
        public void remFromBlackList(String name, String blackName)
        {
            String data = "username" + sep + name + "\n"
             + "belongsto" + sep + blackName + "\n";
            this.send(this._id, this.default_dst, "DEBL", data);
        }

        /*
        * get black List GTBL
        */
        public void getBlackList(String name)
        {
            String data = "username" + sep + name + "\n";
            this.send(this._id, this.default_dst, "GTBL", data);
        }

        #endregion BLACKLIST
        #region ROOM
        /// <summary>
        /// Create a new room CNRO
        /// </summary>
        /// <param name="creatorName"></param>
        /// <param name="format"></param>
        /// <param name="nameRoom"></param>
        /// <param name="state"></param>
        public void CreateRoom(String creatorName, String format, String nameRoom, int state)
        {
            String data = "nameOwner" + sep + creatorName + "\n"
                            + "format" + sep + format + "\n"
                            + "nameRoom" + sep + nameRoom + "\n"
                            + "state" + sep + state + "\n";
            this.send(this._id, this.default_dst, "CNRO", data);
        }

        /// <summary>
        /// Delete a room DERO
        /// </summary>
        /// <param name="nameOwner"></param>
        /// <param name="nameRoom"></param>
        public void DeleteRoom(String nameOwner, String nameRoom)
        {
            String data = "nameOwner" + sep + nameOwner + "\n"
                + "nameRoom" + sep + nameRoom + "\n";
            this.send(this._id, this.default_dst, "DERO", data);
        }

        /// <summary>
        /// Join a room JORO
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="roomName"></param>
        public void JoinRoom(String userName, String roomName)
        {
            String data = "username" + sep + userName + "\n"
                            + "nameRoom" + sep + roomName + "\n";
            this.send(this._id, this.default_dst, "JORO", data);
        }

        /// <summary>
        /// Leave a room LEAR
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="roomName"></param>
        public void LeaveRoom(String userName, String roomName)
        {
            String data = "username" + sep + userName + "\n"
                            + "nameRoom" + sep + roomName + "\n";
            this.send(this._id, this.default_dst, "LEAR", data);
        }

        /// <summary>
        /// Get All rooms GEAR
        /// </summary>
        public void GetAllRooms()
        {
            String data = "";
            this.send(this._id, this.default_dst, "GEAR", data);
        }

        /// <summary>
        /// Leave a room GPFR
        /// </summary>
        /// <param name="idroom"></param>
        public void GetPlayerFromRoom(int idroom)
        {
            String data = "idRoom" + sep + idroom + "\n";
            this.send(this._id, this.default_dst, "GPFR", data);
        }

        #endregion ROOM
        #region NOTIFICATION
        /// <summary>
        /// Send private message to user destName, 
        /// message is the content of the message
        /// </summary>
        /// <param name="destName"></param>
        /// <param name="message"></param>
        public void PrivateMessage(String destName, String message)
        {
            String data = "username" + sep + destName + "\n"
                        + "message" + sep + message + "\n";
            this.send(this._id, this.default_dst, "MESP", data);
        }
        /// <summary>
        /// Send message in the room roomName,
        /// message is the content of the message
        /// </summary>
        /// <param name="roomName"></param>
        /// <param name="message"></param>
        public void BroadcastMessage(String roomName, String message)
        {
            String data = "message" + sep + message + "\n"
                                    + "nameRoom" + sep + roomName + "\n";
            this.send(this._id, this.default_dst, "MESB", data);
        }
        #endregion NOTIFICATION
        #region DECK
        public void GetListDecks(String username)
        {
            String data = "nameOwner" + sep + username + "\n";
            this.send(this._id, this.default_dst, "GLID", data);
        }
        public void CreateDeck(String username, String deckname, Boolean isReal)
        {
            String data = "deckName"+ sep + deckname + "\n" 
                +"nameOwner" + sep + username + "\n"
                + "isReal" + sep + isReal + "\n";
            this.send(this._id, this.default_dst, "CRDK", data);
        }
        public void GetDeck(String username, String idDeck)
        {
            String data = "nameOwner" + sep + username + "\n"+
                          "idDeck" + sep + idDeck + "\n";
            this.send(this._id, this.default_dst, "SDTU", data);
        }
        #endregion DECK
        #region CARDS
        public void GetCardById(String id)
        {
        }
        public void SetCardToDeck(String username, String deckName, String idCard, int nbCard, Boolean isSided)
        {
            String data = "nameOwner" + sep + username + "\n" + 
                "deckName" + sep + deckName + "\n" +
                "idCard" + sep + idCard + "\n" +
                "nbCard" + sep + nbCard + "\n" +
                "isSided" + sep + isSided + "\n";
            this.send(this._id, this.default_dst, "ACFD", data);
        }
        public void RemoveCardFromDeck(String username, String deckName, String idCard, int nbCard, Boolean isSided)
        {
        }
        #endregion CARDS
        #region GAME
        public void MoveCard(string idCard, string source, string destination, int X, int Y, string url, string client_name, string nameRoom)
        {
            String data = "idCard" + sep + idCard + "\n" +
                "source" + sep + source + "\n" +
                "destination" + sep + destination + "\n" +
                "X" + sep + X + "\n" +
                "Y" + sep + Y + "\n" +
                "url" + sep + url + "\n" +
                "client_name" + sep + client_name + "\n" +
                "nameRoom" + sep + nameRoom + "\n";

            this.send(this._id, this.default_dst, "MOVE", data);
        }
        public void TapCard(string idCard, string client_name, string nameRoom)
        {
            String data = "";

            this.send(this._id, this.default_dst, "TAPC", data);
        }
        public void UntapCard(string idCard, string client_name, string nameRoom)
        {
            String data = "";

            this.send(this._id, this.default_dst, "UTAP", data);
        }
        public void UntapAllCards(string client_name, string nameRoom)
        {
            String data = "";

            this.send(this._id, this.default_dst, "UTAA", data);
        }
        public void ChangeHealthCounters(string client_name, string nameRoom,int healthpoints, int marqueurs)
        {
            String data = "client_name" + sep + client_name + "\n" +
                          "nameRoom" + sep + nameRoom + "\n" +
                          "healthpoints" + sep + healthpoints + "\n" +
                          "marqueurs" + sep + marqueurs + "\n";

            this.send(this._id, this.default_dst, "UPGI", data);
        }
        public void DrawArrow(string idCardA, string idCardB, string client_name, string nameRoom)
        {
            String data = "";

            this.send(this._id, this.default_dst, "DAAB", data);
        }
        public void GiveUp(string client_name, string nameRoom)
        {
            String data = "";

            this.send(this._id, this.default_dst, "SYWL", data);
        }
        public void BackToLobby(string client_name, string nameRoom)
        {
            String data = "client_name" + sep + client_name + "\n" +
                          "nameRoom" + sep + nameRoom + "\n";

            this.send(this._id, this.default_dst, "RSET", data);
        }
        #endregion GAME

        #endregion public

        #region static

        /// <summary>
        /// from HeadPacket to byte[]
        /// </summary>
        /// <param name="p"></param>
        /// <returns></returns>
        public static byte[] getBytes(HeadPacket p)
        {
            int size = Marshal.SizeOf(p);
            byte[] arr = new byte[size];
            IntPtr ptr = Marshal.AllocHGlobal(size);

            Marshal.StructureToPtr(p, ptr, true);
            Marshal.Copy(ptr, arr, 0, size);
            Marshal.FreeHGlobal(ptr);

            return arr;
        }

        /// <summary>
        /// from byte[] to HeadPacket
        /// </summary>
        /// <param name="arr"></param>
        /// <returns></returns>
        public static HeadPacket fromBytes(byte[] arr)
        {
            HeadPacket str = new HeadPacket();

            int size = Marshal.SizeOf(str);
            IntPtr ptr = Marshal.AllocHGlobal(size);

            Marshal.Copy(arr, 0, ptr, size);

            str = (HeadPacket)Marshal.PtrToStructure(ptr, str.GetType());
            Marshal.FreeHGlobal(ptr);

            return str;
        }



        #endregion static
    }

    /*
     * Network ovveride for Surface
     */
    public class Network : ANetwork
    {
        protected string _Ip;
        public string Ip
        { get { return _Ip; } set { _Ip = value; } }
        protected NetworkStream clientStream;
        protected TcpClient client;
        /// <summary>
        /// connection
        /// </summary>
        public Network()
        {
          /*  TcpClient client = new TcpClient();
            IPEndPoint serverEndPoint = new IPEndPoint(IPAddress.Parse(ip), port);
            client.Connect(serverEndPoint);
            clientStream = client.GetStream();
            id = 0; // this should be the returned value 'id' from the server.

            //starting a reading thread for server returns
            reader = new Thread(new ThreadStart(this.read));
            reader.Start();*/
        }

        public bool isConnected = false;

        /// <summary>
        /// connect to the server
        /// </summary>
        /// <param name="ip"></param>
        /// <param name="port"></param>
        public override void connect(string ip, int port)
        {
            isConnected = false;
            Ip = ip;
            client = new TcpClient();
            IPEndPoint serverEndPoint = new IPEndPoint(IPAddress.Parse(ip), port);
            client.Connect(serverEndPoint);
            clientStream = client.GetStream();
            _id = 0; // this should be the returned value 'id' from the server.

            //starting a reading thread for server returns
            reader = new Thread(new ThreadStart(this.read));
            reader.Start();
            isConnected = true;
        }

        /// <summary>
        /// write to server
        /// </summary>
        /// <param name="_src"></param>
        /// <param name="_dst"></param>
        /// <param name="_fun"></param>
        /// <param name="_data"></param>
        protected override void send(int _src, int _dst, String _fun, String _data)
        {
            Packet packet = new Packet();

            packet.headpacket.destination = _dst;
            packet.headpacket.source = _src;
            packet.headpacket.function = _fun;
            packet.data = _data;
            packet.headpacket.size = packet.data.Length;

            byte[] Datasend = getBytes(packet.headpacket);
            clientStream.Write(Datasend, 0, Datasend.Length - 4);
            clientStream.Flush();

            byte[] data = new byte[packet.headpacket.size];
            data = Encoding.ASCII.GetBytes(packet.data);
            clientStream.Write(data, 0, data.Length);
        }

        /// <summary>
        ///  read from server
        /// </summary>
        /// <returns></returns>
        protected override serverReturnEventArgs receive()
        {
            try
            {
                Packet packet = new Packet();

                int len = Marshal.SizeOf(new HeadPacket());
                byte[] receiveData = new byte[len];
                HeadPacket headpacket = new HeadPacket();

                clientStream.Read(receiveData, 0, len - 4);
                clientStream.Flush();

                String headdata = System.Text.Encoding.UTF8.GetString(receiveData);
                headpacket = fromBytes(receiveData);
                packet.headpacket = headpacket;

                receiveData = new byte[packet.headpacket.size];
                clientStream.Read(receiveData, 0, packet.headpacket.size);
                clientStream.Flush();

                String data = System.Text.Encoding.UTF8.GetString(receiveData);


                return new serverReturnEventArgs(packet.headpacket.source, packet.headpacket.destination,
                    packet.headpacket.function, packet.headpacket.size, System.Text.Encoding.UTF8.GetString(receiveData));
            }
            catch (System.OutOfMemoryException)
            {
                // Server gone wild :/
            }
            catch (System.IO.IOException)
            {
                //disconected because you try to reach an other serv
            }
            catch (ObjectDisposedException)
            {
                //disconected because you try to reach an other serv
            }
            return new serverReturnEventArgs(0,0,"EERR", 2, "KO");
        }

        public override void disconnect()
        {
            try
            {
                clientStream.Close();
                client.Close();
            }
            catch (Exception e)
            {
            }
            isConnected = false;
        }
    }
}
