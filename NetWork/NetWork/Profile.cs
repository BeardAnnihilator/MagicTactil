using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Sockets;
using System.Threading;
using System.Net;
using NetWork;

namespace MagicTactilServer.Classes 
{
    class Profile : Serialize
    {
        private DBManager _db;

        public Profile( ref DBManager db)
        {
            _db = db;
        }

        public Byte[] getInfoProfile(Dictionary<string, string> dataPacket)
        {
            return (serializeDictionnaryString(_db.infoProfile(dataPacket)));
        }

        public byte[] setInfoProfile(Dictionary<string, string> dataPacket)
        {
            return (serializeDictionnaryString(_db.setInfoProfile(dataPacket)));
        }
    }
}
