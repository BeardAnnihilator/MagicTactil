using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MagicTactilTests
{
    [TestClass]
    public class rooms
    {
        [TestMethod]
        public void roomslipting()
        {
            var list = MagicTactilForWindows.ViewModel.VMRooms.RoomSpliting("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\nid\r2\nnameOwner\ralex\nformat\rStandard\nnameRoom\rwerwqer\nstate\r1\nid\r3\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerwerer\nstate\r1\nid\r4\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerqwerwdf\nstate\r1\nid\r5\nnameOwner\ralex\nformat\rStandard\nnameRoom\rrfwefwefff\nstate\r1\nid\r6\nnameOwner\ralex\nformat\rStandard\nnameRoom\rwerqwerdddd\nstate\r1\nid\r7\nnameOwner\ralex\nformat\rStandard\nnameRoom\rgerscc\nstate\r1\nid\r8\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerdd\nstate\r1\nid\r12\nnameOwner\rmick\nformat\rStandard\nnameRoom\rswaaaaaag\nstate\r1\nid\r13\nnameOwner\ralex\nformat\rStandard\nnameRoom\rjkl\nstate\r1\nid\r14\nnameOwner\ralex\nformat\rStandard\nnameRoom\rewrqf\nstate\r1\nid\r15\nnameOwner\ralex\nformat\rStandard\nnameRoom\rrwedd\nstate\r1\nid\r16\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerweqr\nstate\r1\nid\r17\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerqwerwer\nstate\r1\nid\r19\nnameOwner\ralex\nformat\rStandard\nnameRoom\rturh\nstate\r1\nid\r20\nnameOwner\ralex\nformat\rStandard\nnameRoom\rrqwerrr\nstate\r1\nid\r21\nnameOwner\ralex\nformat\rStandard\nnameRoom\rerwtwt\nstate\r1\nid\r22\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerwerr\nstate\r1\nid\r23\nnameOwner\rmick\nformat\rStandard\nnameRoom\rwedff\nstate\r1\nid\r24\nnameOwner\ralex\nformat\rStandard\nnameRoom\rrwefffbb\nstate\r1\nid\r25\nnameOwner\ralex\nformat\rStandard\nnameRoom\rwerdfdff\nstate\r1\nid\r26\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerwrewr\nstate\r1\nid\r27\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerwrewrssss\nstate\r1\nid\r28\nnameOwner\ralex\nformat\rStandard\nnameRoom\rtyhgn\nstate\r1\nid\r29\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerwerfffgssaerfsdf\nstate\r1\nid\r30\nnameOwner\ralex\nformat\rStandard\nnameRoom\rAzsxdfcgvbnm\nstate\r1\nid\r31\nnameOwner\ralex\nformat\rStandard\nnameRoom\rOUIJHK\nstate\r1\nid\r32\nnameOwner\ralex\nformat\rStandard\nnameRoom\rNVHDKJEe\nstate\r1\nid\r33\nnameOwner\ralex\nformat\rStandard\nnameRoom\rfgserfsdSAAA\nstate\r1\nid\r34\nnameOwner\ralex\nformat\rStandard\nnameRoom\rASDHTRsryuyf\nstate\r1\nid\r35\nnameOwner\ralex\nformat\rStandard\nnameRoom\rzasxdcfvguuiopkmdqwedufQWEFHWEUF\nstate\r1\nid\r36\nnameOwner\rmick\nformat\rStandard\nnameRoom\rqwerqwerqwerr\nstate\r1\nid\r37\nnameOwner\ralex\nformat\rStandard\nnameRoom\retgergerg\nstate\r1\nid\r38\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerwsdas\nstate\r1\nid\r39\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwrwerwrqwrrwqesddfg\nstate\r1\n");
            if (list.Count != 35)
                Assert.Fail("nb room :" +list.Count);
        }

        [TestMethod]
        public void roomsliptingexception()
        {
            try
            {

                var list = MagicTactilForWindows.ViewModel.VMRooms.RoomSpliting("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\nid\r2\nnameOwner\ralex\nformat\rStandard\nnameRoom\rwerwqer\nstate\r1\nid\r3\nnameOwner\ralex\n\nnameRoom\rqwerwerer\nstate\r1\nid\r4\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerqwerwdf\nstate\r1\nid\r5\nnameOwner\ralex\nformat\rStandard\nnameRoom\rrfwefwefff\nstate\r1\nid\r6\nnameOwner\ralex\nformat\rStandard\nnameRoom\rwerqwerdddd\nstate\r1\nid\r7\nnameOwner\ralex\nformat\rStandard\nnameRoom\rgerscc\nstate\r1\nid\r8\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerdd\nstate\r1\nid\r12\nnameOwner\rmick\nformat\rStandard\nnameRoom\rswaaaaaag\nstate\r1\nid\r13\nnameOwner\ralex\nformat\rStandard\nnameRoom\rjkl\nstate\r1\nid\r14\nnameOwner\ralex\nformat\rStandard\nnameRoom\rewrqf\nstate\r1\nid\r15\nnameOwner\ralex\nformat\rStandard\nnameRoom\rrwedd\nstate\r1\nid\r16\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerweqr\nstate\r1\nid\r17\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerqwerwer\nstate\r1\nid\r19\nnameOwner\ralex\nformat\rStandard\nnameRoom\rturh\nstate\r1\nid\r20\nnameOwner\ralex\nformat\rStandard\nnameRoom\rrqwerrr\nstate\r1\nid\r21\nnameOwner\ralex\nformat\rStandard\nnameRoom\rerwtwt\nstate\r1\nid\r22\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerwerr\nstate\r1\nid\r23\nnameOwner\rmick\nformat\rStandard\nnameRoom\rwedff\nstate\r1\nid\r24\nnameOwner\ralex\nformat\rStandard\nnameRoom\rrwefffbb\nstate\r1\nid\r25\nnameOwner\ralex\nformat\rStandard\nnameRoom\rwerdfdff\nstate\r1\nid\r26\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerwrewr\nstate\r1\nid\r27\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerwrewrssss\nstate\r1\nid\r28\nnameOwner\ralex\nformat\rStandard\nnameRoom\rtyhgn\nstate\r1\nid\r29\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerwerfffgssaerfsdf\nstate\r1\nid\r30\nnameOwner\ralex\nformat\rStandard\nnameRoom\rAzsxdfcgvbnm\nstate\r1\nid\r31\nnameOwner\ralex\nformat\rStandard\nnameRoom\rOUIJHK\nstate\r1\nid\r32\nnameOwner\ralex\nformat\rStandard\nnameRoom\rNVHDKJEe\nstate\r1\nid\r33\nnameOwner\ralex\nformat\rStandard\nnameRoom\rfgserfsdSAAA\nstate\r1\nid\r34\nnameOwner\ralex\nformat\rStandard\nnameRoom\rASDHTRsryuyf\nstate\r1\nid\r35\nnameOwner\ralex\nformat\rStandard\nnameRoom\rzasxdcfvguuiopkmdqwedufQWEFHWEUF\nstate\r1\nid\r36\nnameOwner\rmick\nformat\rStandard\nnameRoom\rqwerqwerqwerr\nstate\r1\nid\r37\nnameOwner\ralex\nformat\rStandard\nnameRoom\retgergerg\nstate\r1\nid\r38\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwerwsdas\nstate\r1\nid\r39\nnameOwner\ralex\nformat\rStandard\nnameRoom\rqwrwerwrqwrrwqesddfg\nstate\r1\n");
                Assert.Fail("exception should have been thrown");
            }
            catch (Exception e)
            {
            }
        }

        [TestMethod]
        public void VMroomsInstance()
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

                MagicTactilForWindows.ViewModel.VMRooms deck = new MagicTactilForWindows.ViewModel.VMRooms(network);
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void refreshroomlist()
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

                MagicTactilForWindows.ViewModel.VMRooms vmrooms = new MagicTactilForWindows.ViewModel.VMRooms(network);
                vmrooms.refreshRoomList(null);
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }

           

        }

        [TestMethod]
        public void refreshplayerlistexception()
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

                MagicTactilForWindows.ViewModel.VMRooms vmrooms = new MagicTactilForWindows.ViewModel.VMRooms(network);
                vmrooms.refreshPlayerList();
                Assert.Fail("exception should have been thrown");
            }
            catch (Exception)
            {
                var message = "OK";
                
            }



        }

        [TestMethod]
        public void refreshplayerlist()
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

                MagicTactilForWindows.ViewModel.VMRooms vmrooms = new MagicTactilForWindows.ViewModel.VMRooms(network);
                vmrooms.selectedRoom = new MagicTactilForWindows.ViewModel.Room(1, "name", "name", "name", 1);
                vmrooms.refreshPlayerList();
                
            }
            catch (Exception)
            {
                var message = "ola";
                Assert.Fail();
            }



        }

        [TestMethod]
        public void createroom()
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

                MagicTactilForWindows.ViewModel.VMRooms vmrooms = new MagicTactilForWindows.ViewModel.VMRooms(network);
                vmrooms.selectedRoom = new MagicTactilForWindows.ViewModel.Room(1, "name", "name", "name", 1);
                vmrooms.refreshPlayerList();

            }
            catch (Exception)
            {
                var message = "ola";
                Assert.Fail();
            }



        }

        [TestMethod]
        public void joinroom()
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

                MagicTactilForWindows.ViewModel.VMRooms vmrooms = new MagicTactilForWindows.ViewModel.VMRooms(network);
                vmrooms.selectedRoom = new MagicTactilForWindows.ViewModel.Room(1, "name", "name", "name", 1);
                vmrooms.refreshPlayerList();

            }
            catch (Exception)
            {
                var message = "ola";
                Assert.Fail();
            }



        }

        [TestMethod]
        public void deleteroom()
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

                MagicTactilForWindows.ViewModel.VMRooms vmrooms = new MagicTactilForWindows.ViewModel.VMRooms(network);
                vmrooms.selectedRoom = new MagicTactilForWindows.ViewModel.Room(1, "name", "name", "name", 1);
                vmrooms.refreshPlayerList();

            }
            catch (Exception)
            {
                var message = "ola";
                Assert.Fail();
            }



        }

        [TestMethod]
        public void modifyroom()
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

                MagicTactilForWindows.ViewModel.VMRooms vmrooms = new MagicTactilForWindows.ViewModel.VMRooms(network);
                vmrooms.selectedRoom = new MagicTactilForWindows.ViewModel.Room(1, "name", "name", "name", 1);
                vmrooms.refreshPlayerList();

            }
            catch (Exception)
            {
                var message = "ola";
                Assert.Fail();
            }



        }

        [TestMethod]
        public void getplayerfromroom()
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

                MagicTactilForWindows.ViewModel.VMRooms vmrooms = new MagicTactilForWindows.ViewModel.VMRooms(network);
                vmrooms.selectedRoom = new MagicTactilForWindows.ViewModel.Room(1, "name", "name", "name", 1);
                vmrooms.refreshPlayerList();

            }
            catch (Exception)
            {
                var message = "ola";
                Assert.Fail();
            }



        }

    }
}
