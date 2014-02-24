using System;
using System.Net;
using System.Text;
using System.Net.Sockets;

namespace NetWork
{
    public class Client
    {
        public TcpClient client { get; set; }
        public int id { get; set; }

        public Client(int _id, TcpCliet _client)
        {
            this.id = _id;
            this.client = _client;
        }
    }
}
