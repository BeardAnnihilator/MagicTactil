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
using MagicTactilForWindows.ViewModel;

namespace MagicTactilForWindows
{
	/// <summary>
	/// Interaction logic for UCConversation.xaml
	/// </summary>
	public partial class UCConversation : UserControl
	{
		public UCConversation()
		{
			this.InitializeComponent();
		}

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            ((Conversation)(DataContext)).deleteMe();
        }

        private void SurfaceButton_Click(object sender, RoutedEventArgs e)
        {
            ((Conversation)(DataContext)).focusMe();


        }
	}
}