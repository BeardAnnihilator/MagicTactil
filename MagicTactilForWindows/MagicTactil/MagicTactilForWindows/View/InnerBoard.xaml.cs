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
    /// Interaction logic for InnerBord.xaml
    /// </summary>
    public partial class InnerBoard : UserControl
    {
        public InnerBoard()
        {
            InitializeComponent();
        }

        private void friendButton_Click(object sender, RoutedEventArgs e)
        {
            if (this.FriendList.Visibility == System.Windows.Visibility.Visible)
                this.FriendList.Visibility = System.Windows.Visibility.Hidden;
            else
                this.FriendList.Visibility = System.Windows.Visibility.Visible;
        }
    }
}
