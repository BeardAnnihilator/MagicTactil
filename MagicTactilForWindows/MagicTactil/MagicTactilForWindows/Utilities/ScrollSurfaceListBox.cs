using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Controls;
using System.Windows.Media;
using Microsoft.Surface.Presentation.Controls;

namespace MagicTactilForWindows.Utilities
{
    public class ScrollSurfaceListBox : SurfaceListBox
    {
        public ScrollViewer scroll
        {
            get
            {
                Border border = (Border)VisualTreeHelper.GetChild(this, 0);

                return (ScrollViewer)VisualTreeHelper.GetChild(border, 0);
            }
        }
    }
}
