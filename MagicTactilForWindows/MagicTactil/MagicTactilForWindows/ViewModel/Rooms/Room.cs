using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Input;
using MagicTactilForWindows.Utilities;

namespace MagicTactilForWindows.ViewModel
{
    /// <summary>
    /// represent a room
    /// </summary>
    public class Room
    {
        private int _id;
        public int id { get { return _id; } set { _id = value; } }

        private String _nameOwner;
        public String nameOwner { get { return _nameOwner; } set { _nameOwner = value; } }
        
        private String _format;
        public String format { get { return _format; } set { _format = value; } }
        
        private String _nameRoom;
        public String nameRoom { get { return _nameRoom; } set { _nameRoom = value; } }

        private int _state;
        public int state { get { return _state; } set { _state = value; } }

        public Room(int id, String nameOwner, String format, String nameRoom, int state)
        {
            this.id = id;
            this.nameOwner = nameOwner;
            this.format = format;
            this.nameRoom = nameRoom;
            this.state = state;
        }

        public override string ToString()
        {
            return nameRoom + "\t" + format + "\t" + nameOwner;
        }

        
    }
}
