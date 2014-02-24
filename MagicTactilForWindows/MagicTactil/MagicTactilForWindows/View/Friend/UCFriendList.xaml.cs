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
using Microsoft.Surface.Presentation.Controls;

namespace MagicTactilForWindows
{
	/// <summary>
	/// Interaction logic for UCFriendList.xaml
	/// </summary>
	public partial class UCFriendList : UserControl
	{
		public UCFriendList()
		{
			this.InitializeComponent();
		}

        private void SurfaceRadioButton_Checked(object sender, RoutedEventArgs e)
        {
            this.LayoutRoot.Background = new SolidColorBrush(Color.FromRgb(0,0,0));
        }

        private void SurfaceRadioButton_Checked_1(object sender, RoutedEventArgs e)
        {
            this.LayoutRoot.Background = new SolidColorBrush(Color.FromRgb(13, 55, 168));
        }

        private void deleteFriendButton_Click(object sender, RoutedEventArgs e)
        {
            /*
             * Get friend name
             */
            SurfaceButton b = sender as SurfaceButton;
            String s = b.DataContext as String;

            /*
             * Call datacontext function.
             */
            ((ViewModel.VMFriend)(DataContext)).removeFriend(s);
        }

        private void ListBoxItem_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            /*
             * Get friend name
             */
            SurfaceListBoxItem b = sender as SurfaceListBoxItem;
            String s = b.Content as String;

            /*
             * Call datacontext function.
             */
            ((ViewModel.VMFriend)(DataContext)).doubleClickAFriend(s);
        }

	}
}