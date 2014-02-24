using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Sockets;

namespace MagicTactilServer.Classes
{
    class Room
    {
        private  DBManager _db;
        private Dictionary<int, TcpClient> _clients;

        public Room(DBManager db)
        {
            _db = db;
            _clients = new Dictionary<int, TcpClient>();
        }

        public void addClient(int id, TcpClient client)
        {
            _clients[id] = client;
        }

        public int findClient(int idclient)
        {
            foreach (var item in this._clients)
            {
                if (item.Key == idclient)
                    return idclient;
            }
            return (-1);
        }

        public void sendMessage(int idclient, byte[] message)
        {
            Console.WriteLine("client[" + idclient + "] -> send message[" + System.Text.Encoding.UTF8.GetString(message) + "]");   
            _clients[idclient].GetStream().Write(message, 0, message.Length);
            _clients[idclient].GetStream().Flush();
        }
    }
}
