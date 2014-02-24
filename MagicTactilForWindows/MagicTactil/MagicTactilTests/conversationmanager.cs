using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MagicTactilTests
{
    [TestClass]
    public class conversationmanager
    {
        [TestMethod]
        public void VMconversationmanagerinstanciation()
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

                MagicTactilForWindows.ViewModel.VMConversationManager deck = new MagicTactilForWindows.ViewModel.VMConversationManager(network);
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMconversationmanageraddd()
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

                MagicTactilForWindows.ViewModel.VMConversationManager deck = new MagicTactilForWindows.ViewModel.VMConversationManager(network);
                deck.Add("boulu");
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMconversationmanagersetfocus()
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

                MagicTactilForWindows.ViewModel.VMConversationManager deck = new MagicTactilForWindows.ViewModel.VMConversationManager(network);
                deck.setFocus(new MagicTactilForWindows.ViewModel.Conversation(network, "bouluo", new MagicTactilForWindows.ViewModel.Room(1, "", "", "", 1)));
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMconversationmanagersetfocusweird()
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

                MagicTactilForWindows.ViewModel.VMConversationManager deck = new MagicTactilForWindows.ViewModel.VMConversationManager(network);
                deck.setFocus(new MagicTactilForWindows.ViewModel.Conversation(network, "R@#$TRF#$!", new MagicTactilForWindows.ViewModel.Room(1, "Q@#$%F#$", "@%^RF#$T", "#@T$G#@$TFG#$", 1)));
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMconversationmanagersetfocusonconv()
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

                MagicTactilForWindows.ViewModel.VMConversationManager deck = new MagicTactilForWindows.ViewModel.VMConversationManager(network);
                deck.setFocus(new MagicTactilForWindows.ViewModel.Conversation(network, "borqweruluo", new MagicTactilForWindows.ViewModel.Room(2, "LALAAL", "WERQWT", "TWQF", 0)));
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }
    }
}
