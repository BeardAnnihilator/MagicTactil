using System;
using System.Collections.Generic;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Media;
using MagicTactilForWindows.ViewModel;
using Microsoft.Surface.Presentation.Controls;
using Microsoft.Surface.Presentation.Controls.Primitives;

namespace MagicTactilForWindows.View
{

    /// <summary>
    /// Interaction logic for Building.xaml
    /// </summary>
    public partial class Building : UserControl
    {
        public Building()
        {
            InitializeComponent();

            var scrollViewer = GetDescendantByType(this.CollectionListBox, typeof(SurfaceScrollViewer)) as SurfaceScrollViewer;
            scrollViewer.ScrollChanged +=scroll_ScrollChanged;
        }
        
        public static Visual GetDescendantByType(Visual element, Type type)
        {
            if (element == null)
            {
                return null;
            }
            if (element.GetType() == type)
            {
                return element;
            }
            Visual foundElement = null;
            if (element is FrameworkElement)
            {
                (element as FrameworkElement).ApplyTemplate();
            }
            for (int i = 0; i < VisualTreeHelper.GetChildrenCount(element); i++)
            {
                Visual visual = VisualTreeHelper.GetChild(element, i) as Visual;
                foundElement = GetDescendantByType(visual, type);
                if (foundElement != null)
                {
                    break;
                }
            }
            return foundElement;
        }
        
        void scroll_ScrollChanged(object sender, ScrollChangedEventArgs e)
        {
            SurfaceScrollViewer sb = e.OriginalSource as SurfaceScrollViewer;

            if (sb == null)
                return;

            if (e.VerticalChange > 0)
            {
                if (e.VerticalOffset == sb.ScrollableHeight)
                {
                    ((VMBuilding)this.DataContext).loadMore();
                }
            }
        }

    }
}
