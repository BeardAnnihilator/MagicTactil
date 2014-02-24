using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
using Microsoft.Surface.Presentation;

namespace MagicTactilForWindows.View
{
	/// <summary>
	/// Interaction logic for Game.xaml
	/// </summary>
	public partial class Game : UserControl
	{
		public Game()
		{
			this.InitializeComponent();

            DeckButton.Loaded += new RoutedEventHandler(OnDeckButtonLoaded);
            GraveyardButton.Loaded += new RoutedEventHandler(OnGraveButtonLoaded);
            ExileButton.Loaded += new RoutedEventHandler(OnExileButtonLoaded);
		}

        private void OnDeckButtonLoaded(object sender, RoutedEventArgs e)
        {
            SurfaceDragDrop.AddDropHandler(DeckButton, OnDeckButtonCursorDrop);
        }

        private void OnGraveButtonLoaded(object sender, RoutedEventArgs e)
        {
            SurfaceDragDrop.AddDropHandler(GraveyardButton, OnGraveButtonCursorDrop);
        }

        private void OnExileButtonLoaded(object sender, RoutedEventArgs e)
        {
            SurfaceDragDrop.AddDropHandler(ExileButton, OnExileButtonCursorDrop);
        }

        private void OnGraveButtonCursorDrop(object sender, SurfaceDragDropEventArgs args)
        {
            SurfaceDragCursor droppingCursor = args.Cursor;

            if (!((VMGame)DataContext).Grave.Contains((SimpleCard)droppingCursor.Data))
            {
                ((VMGame)DataContext).Grave.Insert(0, (SimpleCard)droppingCursor.Data);
                GraveyardButton.Background = new ImageBrush { ImageSource = ((SimpleCard)droppingCursor.Data).Bitmap};
            }
        }

        private void OnExileButtonCursorDrop(object sender, SurfaceDragDropEventArgs args)
        {
            SurfaceDragCursor droppingCursor = args.Cursor;

            if (!((VMGame)DataContext).Exile.Contains((SimpleCard)droppingCursor.Data))
            {
                ((VMGame)DataContext).Exile.Insert(0, (SimpleCard)droppingCursor.Data);
                ExileButton.Background = new ImageBrush { ImageSource = ((SimpleCard)droppingCursor.Data).Bitmap };
            }
        }
        private void OnDeckButtonCursorDrop(object sender, SurfaceDragDropEventArgs args)
        {
            SurfaceDragCursor droppingCursor = args.Cursor;

            if (!((VMGame)DataContext).Deck.Contains((SimpleCard)droppingCursor.Data))
            {
                ((VMGame)DataContext).Deck.Insert(0,(SimpleCard)droppingCursor.Data);
                ((VMGame)DataContext).DeckCount = "Deck " + ((VMGame)DataContext).Deck.Count;
            }
        }
	}
}