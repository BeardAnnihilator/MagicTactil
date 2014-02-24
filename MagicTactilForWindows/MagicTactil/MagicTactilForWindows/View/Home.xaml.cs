using System.Windows.Controls;
using System;

namespace MagicTactilForWindows.View
{
	/// <summary>
	/// Interaction logic for Home.xaml
	/// </summary>
	public partial class Home : UserControl
	{
		public Home()
		{
			this.InitializeComponent();
		}

        private void eventListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (eventListBox.SelectedValue != null)
            {
                eventInfo.Visibility = System.Windows.Visibility.Visible;
                try
                {
                    ((ViewModel.VMHome)(DataContext)).creatorRight = System.Windows.Visibility.Hidden;
                    ((ViewModel.VMHome)(DataContext)).getEventInfo((String)eventListBox.SelectedValue);
                }
                catch (NullReferenceException ex)
                {
                    eventInfo.Visibility = System.Windows.Visibility.Hidden;
                    // there is no selected value everything is fine...
                    // the user just changed the Uri
                }
            }
            else
                eventInfo.Visibility = System.Windows.Visibility.Hidden;

        }
	}
}