using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NetWork;

namespace MagicTactilServer.Classes
{
    class Authentication : Serialize
    {
        private  DBManager _db;

        public Authentication(ref DBManager db)
        {
            Console.WriteLine(db);
            _db = db;
        }

        public byte[] createAccount(Dictionary<string, string> dataPacket)
        {
            return (serializeString(_db.newUser(dataPacket)));
        }

        public byte[] signIn(Dictionary<string, string> dataPacket)
        {
            return (serializeString(_db.signIn(dataPacket)));
        }

        public byte[] signOut(Dictionary<string, string> dataPacket)
        {
            return (serializeString(_db.signOut(dataPacket)));
        }
    }
}
