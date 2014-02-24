using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Net.Sockets;
using System.Threading;
using System.Net;


namespace ClientTest
{
    class Program
    {
        static void Main(string[] args)
        {
            TcpClient client = new TcpClient();

            IPEndPoint serverEndPoint = new IPEndPoint(IPAddress.Parse("127.0.0.1"), 3000);

            client.Connect(serverEndPoint);

            NetworkStream clientStream = client.GetStream();

            ASCIIEncoding encoder = new ASCIIEncoding();
            byte[] buffer = encoder.GetBytes("Hello Server!");

            clientStream.Read(buffer, 0, buffer.Length);
            Console.WriteLine("CLIENT HAHAHAHAH  -> " + System.Text.Encoding.UTF8.GetString(buffer));
            Console.ReadKey();
            clientStream.Write(buffer, 0, buffer.Length);
            clientStream.Flush();
            Console.ReadKey();

        }
    }
}
