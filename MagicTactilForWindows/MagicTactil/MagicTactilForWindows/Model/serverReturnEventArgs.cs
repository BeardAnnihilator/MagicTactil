using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MagicTactilForWindows.Model
{
    /// <summary>
    /// represent a server return.
    /// Then can be used to be throw
    /// to others modules
    /// </summary>
    public class serverReturnEventArgs : EventArgs
    {
        public int srce { get; set; }
        public int dest { get; set; }
        public String func { get; set; }
        public int size { get; set; }
        public String data { get; set; }

        /// <summary>
        /// constructor
        /// </summary>
        /// <param name="_srce"></param>
        /// <param name="_dest"></param>
        /// <param name="_func"></param>
        /// <param name="_size"></param>
        /// <param name="_data"></param>
        public serverReturnEventArgs(int _srce, int _dest, String _func, int _size, String _data)
        {
            this.srce = _srce;
            this.dest = _dest;
            this.func = _func;
            this.size = _size;
            this.data = _data;
        }
    }
}