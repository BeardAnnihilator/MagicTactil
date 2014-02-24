using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using MagicTactilForWindows.Utilities;
using MagicTactilForWindows.ViewModel;
using Microsoft.Surface.Presentation;
using Microsoft.Surface.Presentation.Controls;

namespace MagicTactilForWindows
{
	/// <summary>
	/// Interaction logic for UCBoard.xaml
	/// </summary>
	public partial class UCBoard : UserControl
	{
		public UCBoard()
		{
			this.InitializeComponent();
            
		}

        protected override void OnInitialized(EventArgs e)
        {
            base.OnInitialized(e);
            
        }

        private static void OnAutomaticElementPositionChanged(DependencyObject UCboard, DependencyPropertyChangedEventArgs eventArgs)
        {
            var control = (UCBoard)UCboard;
            if (control.AutomaticPositionElement)
                control.scatterView.setAutomaticMode();
            else
                control.scatterView.removeAutomaticMode();
        }


        public static readonly DependencyProperty AutomaticPositionElementProperty =
       DependencyProperty.Register("AutomaticPositionElement", typeof(bool), typeof(UCBoard), new PropertyMetadata(default(bool), OnAutomaticElementPositionChanged));
        public bool AutomaticPositionElement
        {
            get { return (bool)this.GetValue(AutomaticPositionElementProperty); }
            set { this.SetValue(AutomaticPositionElementProperty, value); }
        }


        #region OnDragSourcePreviewMouseDown
        /*
         * Function called if the mouse button is down 
         */ 
        private void OnDragSourcePreviewMouseDown(object sender, MouseButtonEventArgs e)
        {
            FrameworkElement findSource = e.OriginalSource as FrameworkElement;
            ScatterViewItem draggedElement = null;

            // Find the ScatterViewItem object that is being touched.
            while (draggedElement == null && findSource != null)
            {
                if ((draggedElement = findSource as ScatterViewItem) == null)
                {
                    findSource = VisualTreeHelper.GetParent(findSource) as FrameworkElement;
                }
            }
            // In case no element has been clicked
            if (draggedElement == null)
            {
                return;
            }


            SimpleCard data = draggedElement.Content as SimpleCard;

            // If the data has not been specified as draggable, 
            // or the ScatterViewItem cannot move, return.
            if (data == null)
            {
                return;
            }

            // Create the cursor visual.
            ScatterViewItem cursorVisual = new ScatterViewItem()
            {
                Content = draggedElement.DataContext,
                Style = FindResource("ScatterItemStyle") as Style
            };

            // Create a list of input devices. Add the touches that
            // are currently captured within the dragged element and
            // the current touch (if it isn't already in the list).
            List<InputDevice> devices = new List<InputDevice>();
            devices.Add(e.Device);
            foreach (TouchDevice touch in draggedElement.TouchesCapturedWithin)
            {
                if (touch != e.Device)
                {
                    devices.Add(touch);
                }
            }

            // Get the drag source object
            ItemsControl dragSource = ItemsControl.ItemsControlFromItemContainer(draggedElement);

            SurfaceDragCursor startDragOkay =
                SurfaceDragDrop.BeginDragDrop(
                  dragSource,                 // The ScatterView object that the cursor is dragged out from.
                  draggedElement,             // The ScatterViewItem object that is dragged from the drag source.
                  cursorVisual,               // The visual element of the cursor.
                  draggedElement.DataContext, // The data attached with the cursor.
                  devices,                    // The input devices that start dragging the cursor.
                  DragDropEffects.Move);      // The allowed drag-and-drop effects of the operation.

            if (startDragOkay != null)
            {
                // Set e.Handled to true, otherwise the ScatterViewItem will capture the touch 
                // and cause the BeginDragDrop to fail.
                e.Handled = true;
                // Hide the ScatterViewItem.
                draggedElement.Visibility = Visibility.Hidden;
            }

            // Remove the element from the container
            ((ObservableCollection<SimpleCard>)this.scatterView.ItemsSource).Remove(data);
        }
        #endregion

    }
}