using System;
using System.Collections.Generic;
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
using System.Diagnostics;
using Microsoft.Surface.Presentation.Controls;
using MagicTactilForWindows.ViewModel;
using Microsoft.Surface.Presentation;
using System.Collections.ObjectModel;

namespace MagicTactilForWindows
{
	/// <summary>
	/// Interaction logic for UCHand.xaml
	/// </summary>
	public partial class UCHand : UserControl
	{
		public UCHand()
		{
			this.InitializeComponent();
            Loaded += new RoutedEventHandler(OnLoaded);
		}

        private void OnLoaded(object sender, RoutedEventArgs e)
        {
            SurfaceDragDrop.AddDropHandler(this, OnCursorDrop);
        }

        private void OnCursorDrop(object sender, SurfaceDragDropEventArgs args)
        {
            SurfaceDragCursor droppingCursor = args.Cursor;

                if (!HandListBox.Items.Contains(droppingCursor.Data))
                {
                    ((ObservableCollection<SimpleCard>)HandListBox.ItemsSource).Add((SimpleCard)droppingCursor.Data);
                }
        }

        private void HandListBox_PreviewMouseMove(object sender, MouseEventArgs e)
        {
            // If this is a mouse whose state has been initialized when its down event happens
            if (InputDeviceHelper.GetDragSource(e.Device) != null)
            {
                StartDragDrop(HandListBox, e);
            }
        }
        private List<InputDevice> ignoredDeviceList = new List<InputDevice>();
        private void HandListBox_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            ignoredDeviceList.Remove(e.Device);
            InputDeviceHelper.ClearDeviceState(e.Device);

            InputDeviceHelper.InitializeDeviceState(e.Device);
        }
        private const int DragThreshold = 15;
        private static T GetVisualAncestor<T>(DependencyObject descendent) where T : class
        {
            T ancestor = null;
            DependencyObject scan = descendent;
            ancestor = null;

            while (scan != null && ((ancestor = scan as T) == null))
            {
                scan = VisualTreeHelper.GetParent(scan);
            }

            return ancestor;
        }
        private static IEnumerable<InputDevice> MergeInputDevices(IEnumerable<TouchDevice> existingInputDevices, InputDevice extraInputDevice)
        {
            var result = new List<InputDevice> { extraInputDevice };

            foreach (InputDevice inputDevice in existingInputDevices)
            {
                if (inputDevice != extraInputDevice)
                {
                    result.Add(inputDevice);
                }
            }

            return result;
        }
        private void StartDragDrop(ListBox sourceListBox, InputEventArgs e)
        {
            DependencyObject downSource = InputDeviceHelper.GetDragSource(e.Device);
            Debug.Assert(downSource != null);
            
            SurfaceListBoxItem draggedListBoxItem = GetVisualAncestor<SurfaceListBoxItem>(downSource);
            if (draggedListBoxItem == null)
            {
                return;
            }

            SimpleCard data = draggedListBoxItem.Content as SimpleCard;

            // Create a new ScatterViewItem as cursor visual.
            ScatterViewItem cursorVisual = new ScatterViewItem();
            cursorVisual.Style = (Style)FindResource("ScatterItemStyle");
            cursorVisual.Content = data;
           
            IEnumerable<InputDevice> devices = null;
            
            TouchEventArgs touchEventArgs = e as TouchEventArgs;
            if (touchEventArgs != null)
            {
                devices = MergeInputDevices(draggedListBoxItem.TouchesCapturedWithin, e.Device);
            }
            else
            {
                devices = new List<InputDevice>(new InputDevice[] { e.Device });
            }
            
            SurfaceDragCursor cursor = SurfaceDragDrop.BeginDragDrop(HandListBox, draggedListBoxItem, cursorVisual, data, devices, DragDropEffects.All);

            // Reset the input device's state.

            InputDeviceHelper.ClearDeviceState(e.Device);

            ((ObservableCollection<SimpleCard>)this.HandListBox.ItemsSource).Remove(data); 
        }
    }
}