using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Sockets;

namespace MagicTactilServer.Classes
{
    class RoomManager
    {
        private DBManager _db;
        private Dictionary<int, Room> _rooms;

        public RoomManager(DBManager db)
        {
            _db = db;
            _rooms = new Dictionary<int, Room>() { {0, new Room(_db)} };
        }

        public void sendMessage(Dictionary<string, string> dataPacket)
        {
            int idrooms = this.findRoomByClient(int.Parse(dataPacket["source"]));
            int idclient = int.Parse(dataPacket["dest"]);
            byte[] message = Encoding.ASCII.GetBytes(dataPacket["data"]);
            _rooms[idrooms].sendMessage(idclient, message);
        }

        public int findRoomByClient(int idclient)
        {
            int idroom;

            foreach (var item in _rooms)
            {
                idroom = item.Value.findClient(idclient);
                if (idroom != -1)
                    return item.Key;
            }
            return -1;
        }

        public void addClientInRoom(int IdRoom, int IdClient, TcpClient client)
        {
            _rooms[IdRoom].addClient(IdClient, client);
        }

        public void addRoom(Room room, int id)
        {
            _rooms[id] = room;
        }
    }
}
