using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MagicTactilTests
{
    [TestClass]
    public class createroom
    {
        [TestMethod]
        public void VMCreateRoominstanciation()
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

                MagicTactilForWindows.ViewModel.VMCreateRoom deck = new MagicTactilForWindows.ViewModel.VMCreateRoom(network);
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMCreateRoomcancel()
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

                MagicTactilForWindows.ViewModel.VMCreateRoom deck = new MagicTactilForWindows.ViewModel.VMCreateRoom(network);
                //deck.cancel.Execute(null);
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMCreateRoomcreate()
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

                MagicTactilForWindows.ViewModel.VMCreateRoom deck = new MagicTactilForWindows.ViewModel.VMCreateRoom(network);
                //deck.create.Execute(null);
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMCreateRoomerrmess()
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

                MagicTactilForWindows.ViewModel.VMCreateRoom deck = new MagicTactilForWindows.ViewModel.VMCreateRoom(network);
                deck.errMess = "test!%!!";
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMCreateerrvisi()
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

                MagicTactilForWindows.ViewModel.VMCreateRoom deck = new MagicTactilForWindows.ViewModel.VMCreateRoom(network);
                //deck.errVisibility = System.Windows.Visibility.Visible;
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMCreateRoomformat()
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

                MagicTactilForWindows.ViewModel.VMCreateRoom deck = new MagicTactilForWindows.ViewModel.VMCreateRoom(network);
                deck.Format = "Standard";
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

    }
}
