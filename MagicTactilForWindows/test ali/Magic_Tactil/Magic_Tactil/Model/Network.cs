using System;
using System.Text;
using System.Net.Sockets;
using System.Net;
using System.Threading;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Runtime.InteropServices;

namespace MagicTactilForWindows.Model
{
    class Network
    {
        #region attribute
        
        private NetworkStream clientStream;
        private int id;

        private Thread reader;

        #region event

        public event EventHandler<serverReturnEventArgs> AnyReturn;
        public event EventHandler<serverReturnEventArgs> SGNIReturn;
        public event EventHandler<serverReturnEventArgs> SGNOReturn;
        public event EventHandler<serverReturnEventArgs> REGUReturn;
        public event EventHandler<serverReturnEventArgs> MSGPReturn;
        public event EventHandler<serverReturnEventArgs> SETUReturn;
        public event EventHandler<serverReturnEventArgs> GETUReturn;
        #endregion event

        #endregion attribute

        #region constructor destructor

        public Network(String ip, int port)
        {
            TcpClient client = new TcpClient();
            IPEndPoint serverEndPoint = new IPEndPoint(IPAddress.Parse(ip), port);
            client.Connect(serverEndPoint);
            clientStream = client.GetStream();
            id = 0; // this should be the returned value 'id' from the server.

            reader = new Thread(new ThreadStart(this.read));
            reader.Start();
        }

        ~Network()
        {
            try { reader.Abort(); }
            catch (NullReferenceException) {}
        }

        #endregion constructor destructor

        #region send

        private void send(int _src, int _dst, String _fun, String _data)
        {
            Packet packet = new Packet();

            packet.headpacket.destination = _dst;
            packet.headpacket.source = _src;
            packet.headpacket.function = _fun;
            packet.data = _data;
            packet.headpacket.size = packet.data.Length;

            byte[] Datasend = getBytes(packet.headpacket);
            clientStream.Write(Datasend, 0, Datasend.Length);
            clientStream.Flush();

            byte[] data = new byte[packet.headpacket.size];
            data = Encoding.ASCII.GetBytes(packet.data);
            clientStream.Write(data, 0, data.Length);
        }

        #endregion send

        #region get

        private void read()
        {
            while (true)
            {
                serverReturnEventArgs ret = this.receive();
                this.eventThrowing(ret);
            }
        }

        private serverReturnEventArgs receive()
        {
            Packet packet = new Packet();

            int len = Marshal.SizeOf(new HeadPacket());
            byte[] receiveData = new byte[len];
            HeadPacket headpacket = new HeadPacket();

            clientStream.Read(receiveData, 0, len);
            clientStream.Flush();

            headpacket = fromBytes(receiveData);
            packet.headpacket = headpacket;

            receiveData = new byte[packet.headpacket.size];
            clientStream.Read(receiveData, 0, packet.headpacket.size);
            clientStream.Flush();

            return new serverReturnEventArgs(packet.headpacket.source, packet.headpacket.destination,
                packet.headpacket.function, packet.headpacket.size, System.Text.Encoding.UTF8.GetString(receiveData));
        }
        
	#endregion get

        #region throwEvent

        private Dictionary<String, EventHandler<serverReturnEventArgs>> eventMappping()
        {
            Dictionary<String, EventHandler<serverReturnEventArgs>> eventMap;
            eventMap = new Dictionary<string, EventHandler<serverReturnEventArgs>>();
            eventMap.Add("SGNI", SGNIReturn);
            eventMap.Add("SGNO", SGNOReturn);
            eventMap.Add("REGU", REGUReturn);
            eventMap.Add("MSGP", MSGPReturn);
            eventMap.Add("SETU", SETUReturn);
            eventMap.Add("GETU", GETUReturn);

            return eventMap;
        }

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

        public void SignIn(String username, String password)
        {
           // GetInfoUser(username);

            String data = "username" + sep + username + "\n"
                        + "password" + sep + password + "\n";

            this.send(this.id, this.id, "SGNI", data);
        }

        public void SignOut(String username, String password)
        {
            String data = "username" + sep + username +"\n";
            this.send(this.id, this.id, "SGNO", data);
        }

        public void SignUp(String mail, String username, String name, String givenname, String birthday, String location, String password, String telephone, String gender)
        {

            String data = "email" + sep     + mail      + "\n"
                        + "username" + sep  + username  + "\n"
                        + "name" + sep      + name      + "\n"
                        + "givenname" + sep + givenname + "\n"
                        + "birthday" + sep  + birthday  + "\n"
                        + "location" + sep  + location  + "\n"
                        + "password" + sep  + password  + "\n"
                        + "telephone" + sep + telephone + "\n"
                        + "gender" + sep    + gender    + "\n";

            this.send(this.id, this.id, "REGU", data);
        }

        public void GetInfoUser(String username)
        {

            String data = "username" + sep + username + "\n";

            this.send(this.id, this.id, "GETU", data);
        }

        public void SetInfoUser(String name, String key, String newValue)
        {
            String data = "username" + sep + name + "\n"
                               + key + sep + newValue + "\n";

            this.send(this.id, this.id, "SETU", data);
        }

        #endregion public

        #region static
        static byte[] getBytes(HeadPacket p)
        {
            int size = Marshal.SizeOf(p);
            byte[] arr = new byte[size];
            IntPtr ptr = Marshal.AllocHGlobal(size);

            Marshal.StructureToPtr(p, ptr, true);
            Marshal.Copy(ptr, arr, 0, size);
            Marshal.FreeHGlobal(ptr);

            return arr;
        }

        static HeadPacket fromBytes(byte[] arr)
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
}
