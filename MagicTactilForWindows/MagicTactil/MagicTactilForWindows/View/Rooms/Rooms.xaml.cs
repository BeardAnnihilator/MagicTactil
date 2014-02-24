using System;
using System.Collections.Generic;
using System.Linq;
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

namespace MagicTactilForWindows.View
{
    /// <summary>
    /// Interaction logic for Rooms.xaml
    /// </summary>
    public partial class Rooms : UserControl
    {
        public Rooms()
        {
            InitializeComponent();
        }

        private void RoomsListBox1_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (RoomsListBox1.SelectedItem != null)
            {
                JoinButton.Visibility = System.Windows.Visibility.Visible;
                playerListBox.Visibility = System.Windows.Visibility.Visible;
                ((ViewModel.VMRooms)(DataContext)).refreshPlayerList();
            }
            else
            {
                JoinButton.Visibility = System.Windows.Visibility.Hidden;
                playerListBox.Visibility = System.Windows.Visibility.Hidden;
            }
        }
    }
}
