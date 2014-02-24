using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Controls;
using Microsoft.Surface.Presentation.Controls;
using Microsoft.Surface.Presentation;
using System.Windows;
using System.Windows.Media;
using MagicTactilForWindows.ViewModel;
using System.Collections.ObjectModel;
using System.Windows.Input;
using System.Windows.Controls.Primitives;

namespace MagicTactilForWindows.Utilities
{
    public class DragDropScatterView : ScatterView
    {
        public DragDropScatterView()
        {
            // Change Background to transparent, or Drag Drop hit test will by pass it if its Background is null.
            Background = Brushes.Transparent;
            AllowDrop = true;

            Loaded += new RoutedEventHandler(OnLoaded);
            Unloaded += new RoutedEventHandler(OnUnloaded);
        }

        #region Public Properties

        public void setAutomaticMode()
        {
            ItemContainerGenerator.StatusChanged += ItemContainerGenerator_StatusChanged;
        }

        public void removeAutomaticMode()
        {
            ItemContainerGenerator.StatusChanged -= ItemContainerGenerator_StatusChanged;
        }

        void ItemContainerGenerator_StatusChanged(object sender, EventArgs e)
        {
            if (ItemContainerGenerator.Status != GeneratorStatus.ContainersGenerated)
            {
                return;
            }

            foreach (SimpleCard card in Items)
            {
                var svi = ItemContainerGenerator.ContainerFromItem(card) as ScatterViewItem;

                Point center = new Point((this.ActualWidth * card.center.X / 100) + 45 , (this.ActualHeight * card.center.Y / 100) + 65);

                if (svi != null)
                {
                    svi.Center = center;
                    svi.Orientation = 0;
                    svi.Height = 130;
                    svi.Width = 91;
                    svi.SetRelativeZIndex(RelativeScatterViewZIndex.Topmost);
                    svi.Orientation = 0;
                    svi.CanRotate = false;
                    svi.CanScale = false;
                }
            }
        }

        

        /// <summary>
        /// Property to identify whether the ScatterViewItem can be dragged.
        /// </summary>
        public static readonly DependencyProperty AllowDragProperty = DependencyProperty.Register(
            "AllowDrag",
            typeof(bool),
            typeof(DragDropScatterView),
            new PropertyMetadata(true/*defaultValue*/));

        /// <summary>
        /// Getter of AllowDrag AttachProperty.
        /// </summary>
        /// <param name="element"></param>
        /// <returns></returns>
        public static bool GetAllowDrag(DependencyObject element)
        {
            return (bool)element.GetValue(AllowDragProperty);
        }

        /// <summary>
        /// Setter of AllowDrag AttachProperty.
        /// </summary>
        /// <param name="element"></param>
        /// <param name="value"></param>
        public static void SetAllowDrag(DependencyObject element, bool value)
        {
            element.SetValue(AllowDragProperty, value);
        }

        #endregion

        #region Private Methods

        /*
         * On element loaded, add the drop handler to this container
         */ 
        private void OnLoaded(object sender, RoutedEventArgs e)
        {
            SurfaceDragDrop.AddDropHandler(this, OnCursorDrop);
        }
        /*
         * On element unloaded, remove the drop handler
         */ 
        private void OnUnloaded(object sender, RoutedEventArgs e)
        {
            SurfaceDragDrop.RemoveDropHandler(this, OnCursorDrop);
        }

        /*
         * Function called when an element is dropped inside the container.
         */ 
        private void OnCursorDrop(object sender, SurfaceDragDropEventArgs args)
        {
            SurfaceDragCursor droppingCursor = args.Cursor;

                // check if item is not already in the container
                if (!Items.Contains(droppingCursor.Data))
                {
                    Point center = droppingCursor.GetPosition(this);
                    center.X = ((center.X - 45) / this.ActualWidth) * 100;
                    center.Y = ((center.Y - 65)   / this.ActualHeight) * 100;
                    ((SimpleCard)droppingCursor.Data).center = center;
                    // Add item in the container
                    ((ObservableCollection<SimpleCard>)ItemsSource).Add((SimpleCard)droppingCursor.Data);
                    

                    // set the properties of the item just dropped
                    var svi = ItemContainerGenerator.ContainerFromItem(droppingCursor.Data) as ScatterViewItem;
                    if (svi != null)
                    {
                        svi.Center = droppingCursor.GetPosition(this);
                        svi.Orientation = droppingCursor.GetOrientation(this);
                        svi.Height = droppingCursor.Visual.ActualHeight;
                        svi.Width = droppingCursor.Visual.ActualWidth;
                        svi.SetRelativeZIndex(RelativeScatterViewZIndex.Topmost);
                        svi.Orientation = 0;
                        svi.CanRotate = false;
                        svi.CanScale = false;
                    }
                }
        }
        #endregion
    }
}
