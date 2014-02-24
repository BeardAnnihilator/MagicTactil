using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MagicTactilTests
{
    [TestClass]
    public class vmdecks
    {
        [TestMethod]
        public void VMDeckinstance()
        {
            MagicTactilForWindows.Model.Network network = null;
            try
            {
                network = new MagicTactilForWindows.Model.Network();
                network.connect("127.0.0.1", 3000);  //127.0.0.1
            }
            catch (Exception)
            {
                var message = "Unable to connect to the server";
                Assert.Fail(message);
            }

            try
            {

                MagicTactilForWindows.ViewModel.VMDecks deck = new MagicTactilForWindows.ViewModel.VMDecks(network);
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMDeckrefresh()
        {
            MagicTactilForWindows.Model.Network network = null;
            try
            {
                network = new MagicTactilForWindows.Model.Network();
                network.connect("127.0.0.1", 3000);  //127.0.0.1
            }
            catch (Exception)
            {
                var message = "Unable to connect to the server";
                Assert.Fail(message);
            }

            try
            {

                MagicTactilForWindows.ViewModel.VMDecks deck = new MagicTactilForWindows.ViewModel.VMDecks(network);
                deck.refreshDeckList();
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMDeckadd()
        {
            MagicTactilForWindows.Model.Network network = null;
            try
            {
                network = new MagicTactilForWindows.Model.Network();
                network.connect("127.0.0.1", 3000);  //127.0.0.1
            }
            catch (Exception)
            {
                var message = "Unable to connect to the server";
                Assert.Fail(message);
            }

            try
            {

                MagicTactilForWindows.ViewModel.VMDecks deck = new MagicTactilForWindows.ViewModel.VMDecks(network);
                deck.deckList.Add(new MagicTactilForWindows.ViewModel.Deck("fwef"));
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMDeckaddclear()
        {
            MagicTactilForWindows.Model.Network network = null;
            try
            {
                network = new MagicTactilForWindows.Model.Network();
                network.connect("127.0.0.1", 3000);  //127.0.0.1
            }
            catch (Exception)
            {
                var message = "Unable to connect to the server";
                Assert.Fail(message);
            }

            try
            {

                MagicTactilForWindows.ViewModel.VMDecks deck = new MagicTactilForWindows.ViewModel.VMDecks(network);
                deck.deckList.Clear();
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }
    }
}
