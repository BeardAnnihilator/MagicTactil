using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MagicTactilForWindows.Utilities;

namespace MagicTactilForWindows.ViewModel
{

    /*
     * Class that represent a navigation page.
     * Generaly used as datacontext for some xaml. (look VM*.cs)
     */ 
    abstract public class APage : ViewModelBase
    {
        public event EventHandler<MoveToEventArgs> moveTo;

        abstract public void refresh_label();

        protected EventHandler<MoveToEventArgs> getMoveTo()
        {
            return moveTo;
        }
    }
}
