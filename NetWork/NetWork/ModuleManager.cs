using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NetWork;
using MagicTactilServer.Classes;
using System.Net.Sockets;

namespace NetWork
{
    class ModuleManager
    {
        delegate byte[] Handle(Dictionary<string, string> dataPacket);
        private DBManager BDD;
        private RoomManager Rooms;
        private Authentication auth;
        private Profile profile;
        private Dictionary<string, Handle> handles;

        public ModuleManager()
        {
            this.BDD = new DBManager();
            this.Rooms = new RoomManager(this.BDD);
            this.auth = new Authentication(ref this.BDD);
            this.profile = new Profile(ref this.BDD);
            handles = new Dictionary<string, Handle>()
            {
                {"MSGP", new Handle(sendPMessage)},
                {"REGU", new Handle(createAccount)},
                {"SGNI", new Handle(signIn)},
                {"SGNO", new Handle(signOut)},
                {"GETU", new Handle(getUser)},
                {"SETU", new Handle(setUser)}

            };
        }


        public void addClientInRoom(int IdRoom, int IdClient, TcpClient client)
        {
            this.Rooms.addClientInRoom(IdRoom, IdClient, client);
        }

        public byte[] execHandle(Dictionary<string, string> dataPacket)
        {
            Handle func = new Handle(this.handles[dataPacket["func"]]);
            return func(dataPacket);
        }
        
        public byte[] sendPMessage(Dictionary<string, string> dataPacket)
        {
            this.Rooms.sendMessage(dataPacket);
            return new byte[1];
        }

        public byte[] createAccount(Dictionary<string, string> dataPacket)
        {
            Console.WriteLine("CREAT ACCOUNT");
            return this.auth.createAccount(dataPacket);

        }

        public byte[] signIn(Dictionary<string, string> dataPacket)
        {
            Console.WriteLine("SIGN IN");
            return this.auth.signIn(dataPacket);

        }

        public byte[] signOut(Dictionary<string, string> dataPacket)
        {
            Console.WriteLine("SIGN OUT");
            return this.auth.signOut(dataPacket);

        }

        public byte[] getUser(Dictionary<string, string> dataPacket)
        {
            Console.WriteLine("GET USER");
            return this.profile.getInfoProfile(dataPacket);

        }

        public byte[] setUser(Dictionary<string, string> dataPacket)
        {
            Console.WriteLine("SET USER");
            return this.profile.setInfoProfile(dataPacket);
        }
    }
}
