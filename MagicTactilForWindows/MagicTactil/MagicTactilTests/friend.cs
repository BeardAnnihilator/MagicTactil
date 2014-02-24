using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MagicTactilTests
{
    [TestClass]
    public class friend
    {
        [TestMethod]
        public void VMFriendinstanciation()
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

                MagicTactilForWindows.ViewModel.VMFriend deck = new MagicTactilForWindows.ViewModel.VMFriend(network);
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMFrienddoubleclickfriend()
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

                MagicTactilForWindows.ViewModel.VMFriend deck = new MagicTactilForWindows.ViewModel.VMFriend(network);
                deck.doubleClickAFriend("alex");
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMFriendremove()
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

                MagicTactilForWindows.ViewModel.VMFriend deck = new MagicTactilForWindows.ViewModel.VMFriend(network);
                deck.removeFriend("alex");
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }
    }
}
