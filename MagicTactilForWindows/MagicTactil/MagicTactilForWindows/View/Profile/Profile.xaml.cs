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
    /// Interaction logic for Profile.xaml
    /// </summary>
    public partial class Profile : UserControl
    {
        public Profile()
        {
            InitializeComponent();
        }

        private void modifyButton_Click(object sender, RoutedEventArgs e)
        {
            if (modifyButton.Content.Equals("Edit"))
            {
                modifyButton.Content = "Confirm";
                userInfo.ValLabels.Visibility = System.Windows.Visibility.Hidden;
                userInfo.TextBoxes.Visibility = System.Windows.Visibility.Visible;
                modifyButton.IsDefault = true;
                cancelButton.Visibility = Visibility.Visible;
            }
            else
            {
                ((ViewModel.VMProfile)(DataContext)).edit();
                modifyButton.Content = "Edit";
                userInfo.ValLabels.Visibility = System.Windows.Visibility.Visible;
                userInfo.TextBoxes.Visibility = System.Windows.Visibility.Hidden;
                modifyButton.IsDefault = false;
                cancelButton.Visibility = Visibility.Hidden;
            }
        }

        private void cancelButton_Click(object sender, RoutedEventArgs e)
        {
            ((ViewModel.VMProfile)(DataContext)).refresh();
            modifyButton.Content = "Edit";
            userInfo.ValLabels.Visibility = System.Windows.Visibility.Visible;
            userInfo.TextBoxes.Visibility = System.Windows.Visibility.Hidden;
            modifyButton.IsDefault = false;
            cancelButton.Visibility = Visibility.Hidden;
        }
    }
}
