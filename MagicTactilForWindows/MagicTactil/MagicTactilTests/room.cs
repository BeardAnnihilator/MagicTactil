using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MagicTactilTests
{
    [TestClass]
    public class room
    {
        [TestMethod]
        public void VMroomInstanciation()
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

                MagicTactilForWindows.ViewModel.VMRoom deck = new MagicTactilForWindows.ViewModel.VMRoom(network);
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMroomrefreshplayerlistexception()
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

                MagicTactilForWindows.ViewModel.VMRoom room = new MagicTactilForWindows.ViewModel.VMRoom(network);
                room.refreshPlayerList();
                Assert.Fail();
            }
            catch (Exception)
            {
                var message = "ok";
                
            }
        }

        [TestMethod]
        public void VMroomrefreshplayerlist()
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

                MagicTactilForWindows.ViewModel.VMRoom room = new MagicTactilForWindows.ViewModel.VMRoom(network);
                room.roomAssociated = new MagicTactilForWindows.ViewModel.Room(1, "name", "name", "name", 1);
                room.refreshPlayerList();
                
            }
            catch (Exception)
            {
                var message = "ok";
                Assert.Fail();

            }
        }

        [TestMethod]
        public void VMroomleaveexception()
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

                MagicTactilForWindows.ViewModel.VMRoom room = new MagicTactilForWindows.ViewModel.VMRoom(network);
                room.refreshPlayerList();
                Assert.Fail();
            }
            catch (Exception)
            {
                var message = "ok";
                
            }
        }

        [TestMethod]
        public void VMroomleave()
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

                MagicTactilForWindows.ViewModel.VMRoom room = new MagicTactilForWindows.ViewModel.VMRoom(network);
                room.roomAssociated = new MagicTactilForWindows.ViewModel.Room(1, "name", "name", "name", 1);
                room.refreshPlayerList();

            }
            catch (Exception)
            {
                var message = "ok";
                Assert.Fail();

            }
        }

        [TestMethod]
        public void VMroomdeleteexception()
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

                MagicTactilForWindows.ViewModel.VMRoom room = new MagicTactilForWindows.ViewModel.VMRoom(network);
                room.refreshPlayerList();
                Assert.Fail();
            }
            catch (Exception)
            {
                var message = "ok";
                
            }
        }

        [TestMethod]
        public void VMroomdelete()
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

                MagicTactilForWindows.ViewModel.VMRoom room = new MagicTactilForWindows.ViewModel.VMRoom(network);
                room.roomAssociated = new MagicTactilForWindows.ViewModel.Room(1, "name", "name", "name", 1);
                room.refreshPlayerList();

            }
            catch (Exception)
            {
                var message = "ok";
                Assert.Fail();

            }
        }

        [TestMethod]
        public void VMroomrIamReadyexception()
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

                MagicTactilForWindows.ViewModel.VMRoom room = new MagicTactilForWindows.ViewModel.VMRoom(network);
                room.refreshPlayerList();
                Assert.Fail();
            }
            catch (Exception)
            {
                var message = "ok";
                
            }
        }

        [TestMethod]
        public void VMroomIamReady()
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

                MagicTactilForWindows.ViewModel.VMRoom room = new MagicTactilForWindows.ViewModel.VMRoom(network);
                room.roomAssociated = new MagicTactilForWindows.ViewModel.Room(1, "name", "name", "name", 1);
                room.refreshPlayerList();

            }
            catch (Exception)
            {
                var message = "ok";
                Assert.Fail();

            }
        }
    }
}
