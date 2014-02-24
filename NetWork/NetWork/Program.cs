using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NetWork;
using System.Net.Sockets;
using System.Threading;
using System.Net;
using MagicTactilServer.Classes;
using System.IO;
using System.Runtime.InteropServices;


namespace NetWork
{
    class Network
    {
        int IdClientConnected;
        private ModuleManager ModuleH;
        private TcpListener tcpListener;
        private Thread listenThread;

        public Network()
        {
            this.ModuleH = new ModuleManager();
            this.IdClientConnected = 0;
        }

        public void Start()
        {

            this.tcpListener = new TcpListener(IPAddress.Any, 3000);
            this.listenThread = new Thread(new ThreadStart(ListenForClients));
            this.listenThread.Start();
        }


        private void ListenForClients()
        {
            this.tcpListener.Start();

            while (true)
            {
                //blocks until a client has connected to the server
                TcpClient client = this.tcpListener.AcceptTcpClient();
                Client c = new Client(this.IdClientConnected, client);

                //create a thread to handle communication 
                //with connected client                
                this.ModuleH.addClientInRoom(0, this.IdClientConnected, client);
                Thread clientThread = new Thread(new ParameterizedThreadStart(HandleClientComm));
                clientThread.Start(c);
                this.IdClientConnected += 1;
            }
        }

       // static public Dictionary<string, string> FillInData(string toSerialize, Dictionary<string, string> infoProfile)
        public void FillInData(string toSerialize, ref Dictionary<string, string> infoProfile)
        {
            char[] sep = new char[1];
            sep[0] = '\n';
            string[] infoFields = toSerialize.Split(sep);
            sep[0] = '\r';

            foreach (var item in infoFields)
            {
                if (item != "")
                {
                    string[] tmp = item.Split(sep);
                    infoProfile[tmp[0]] = tmp[1];
                }
            }
            foreach (var item in infoProfile)
            {
                Console.WriteLine("DATA -> "+ item);
            }
        }

        byte[] getBytes(HeadPacket p)
        {
            int size = Marshal.SizeOf(p);
            byte[] arr = new byte[size];
            IntPtr ptr = Marshal.AllocHGlobal(size);

            Marshal.StructureToPtr(p, ptr, true);
            Marshal.Copy(ptr, arr, 0, size);
            Marshal.FreeHGlobal(ptr);

            return arr;
        }

        HeadPacket fromBytes(byte[] arr)
        {
           HeadPacket p = new HeadPacket();

            int size = Marshal.SizeOf(p);
            IntPtr ptr = Marshal.AllocHGlobal(size);

            Marshal.Copy(arr, 0, ptr, size);

            p = (HeadPacket)Marshal.PtrToStructure(ptr, p.GetType());
            Marshal.FreeHGlobal(ptr);

            return p;
        }


        private void HandleClientComm(object client)
        {
            Dictionary<string, string> dataPacket;
            Client tcpClient = (Client)client;
            NetworkStream clientStream = tcpClient.client.GetStream();
            Console.WriteLine("WAIT  CLIENT[" + tcpClient.id + "]");

            try
            {
                int bytesRead = 0;
                int i = 0;
                int tmp = 0;
                int len = Marshal.SizeOf(new HeadPacket());
                byte[] receiveData = new byte[len];
                byte[] sendData;
                byte[] returnHandle;
                

                while (true)
                {
                    byte[] data = new byte[255];
                    dataPacket = new Dictionary<string, string>();
                    Packet packet = new Packet();
                    HeadPacket headpacket = new HeadPacket();
                   
                    Console.Write("CLIENT[" + tcpClient.id + "]");
                    bytesRead = clientStream.Read(receiveData, 0, len);                  
                    clientStream.Flush();

                    headpacket = fromBytes(receiveData);
                    packet.headpacket = headpacket;

                    dataPacket["idSocket"] = tcpClient.id.ToString();
                    dataPacket["dest"] = packet.headpacket.destination.ToString();
                    dataPacket["source"] = packet.headpacket.source.ToString();
                    dataPacket["func"] = packet.headpacket.function.ToString();
                    dataPacket["size"] = packet.headpacket.size.ToString();

                    bytesRead = clientStream.Read(data, 0, 255);
                    dataPacket["data"] = System.Text.Encoding.UTF8.GetString(data);
                    dataPacket["data"] = dataPacket["data"].Trim("\0".ToCharArray());
                    i = bytesRead;
                    tmp = int.Parse(dataPacket["size"]);
                    while (i < tmp)
                    {
                        data = new byte[255];
                        bytesRead = clientStream.Read(data, 0, 255);
                        dataPacket["data"] += System.Text.Encoding.UTF8.GetString(data);
                        dataPacket["data"] = dataPacket["data"].Trim("\0".ToCharArray());
                        i += bytesRead;
                    }
                    clientStream.Flush();
                    this.FillInData(dataPacket["data"], ref dataPacket);

                    foreach  ( var item in dataPacket)
                    {
                        Console.WriteLine("dataPacket ->" + item);
                    }

                    returnHandle = this.ModuleH.execHandle(dataPacket);
                    headpacket.size = returnHandle.Length;
                    sendData = getBytes(headpacket);
                    headpacket = fromBytes(sendData);

                    Console.WriteLine("SEND DEST -> [" + headpacket.destination.ToString() + "]");
                    Console.WriteLine("SEND SRC  -> [" + headpacket.source.ToString() + "]");
                    Console.WriteLine("SEND FUNC -> [" + headpacket.function + "]");
                    Console.WriteLine("SEND SIZE -> [" + headpacket.size.ToString()+ "]");
                    Console.WriteLine("SEND DATA -> [" + System.Text.Encoding.UTF8.GetString(returnHandle)+ "]");

                    clientStream.Write(sendData, 0, sendData.Length);
                    clientStream.Flush();

                    clientStream.Write(returnHandle, 0, returnHandle.Length);
                    clientStream.Flush();
                    dataPacket.Clear();
                }
            }
            catch (IOException e)
            {
                if (e.Source != null)
                {
                    Packet packetLogOut = new Packet();

                    packetLogOut.headpacket = new HeadPacket();
                    packetLogOut.headpacket.destination = tcpClient.id;
                    packetLogOut.headpacket.source = tcpClient.id;
                    packetLogOut.headpacket.function = "SGNO";
                    packetLogOut.headpacket.size = 0;



                    Console.WriteLine("\nIOException Source ->{0}", e.Source); 
                    Console.WriteLine("CLIENT[{0}]-> Disconnected", tcpClient.id);
                }
            }

            tcpClient.client.Close();
        }

        static void Main(string[] args)
        {
            Network net = new Network();
       

            net.Start();
        }

    }
}
