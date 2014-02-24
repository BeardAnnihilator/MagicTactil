using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MagicTactilForWindows.ViewModel;

namespace MagicTactilForWindows.Utilities
{
    /// <summary>
    /// A class for event within rooms
    /// </summary>
    public class RoomEventArgs : EventArgs
    {
        public Room associated;

        public RoomEventArgs(Room link)
        {
            this.associated = link;
        }
    }
}
