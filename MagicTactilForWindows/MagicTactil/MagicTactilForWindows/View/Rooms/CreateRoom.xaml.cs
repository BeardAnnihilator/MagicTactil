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
    /// Interaction logic for CreateRoom.xaml
    /// </summary>
    public partial class CreateRoom : UserControl
    {


        public CreateRoom()
        {
            InitializeComponent();
            _ModeSelector.ItemsSource = new string[]
                                            {
                                                "Standard",
                                                "Modern",
                                                "EDH",
                                                "Legacy",
                                                "Vintage",
                                            };
            _ModeSelector.SelectedIndex = 0;
            _ModeSelector.SelectedItem = "Standard";
            
 
            //BindingOperations.GetBindingExpression(this.format, TextBox.TextProperty).UpdateSource();
            //this.format.con
           _ModeSelector.SelectionChanged += ModeSelectorSelectionChanged;
           this.format.Text = "Standard";
           //this.format.UpdateLayout();

           

        }

       void ModeSelectorSelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ListBox source = e.OriginalSource as ListBox;
            if (source != null)
            {
                this.format.Text = ""+source.SelectedItem;
                //this.format.UpdateLayout();
                //ICI FORMAT PAS MARCHER
                //BindingOperations.GetBindingExpression(this.format, TextBox.TextProperty).UpdateSource();
            }
        }
    }
}
