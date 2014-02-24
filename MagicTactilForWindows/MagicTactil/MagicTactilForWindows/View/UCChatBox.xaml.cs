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
	/// Interaction logic for UCChatBox.xaml
	/// </summary>
	public partial class UCChatBox : UserControl
	{
		public UCChatBox()
		{
			this.InitializeComponent();
		}

        private void SurfaceTextBox_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Return)
            {
                ((Conversation)DataContext).sendMessage(buffer.Text);
                buffer.Text = "";
            }
        }
	}
}