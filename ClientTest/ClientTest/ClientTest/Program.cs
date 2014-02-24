using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Net.Sockets;
using System.Runtime.InteropServices;


namespace ClientTest
{


    class Program
    {

        /*        static public Dictionary<string, string> FillInData(string toSerialize, Dictionary<string, string> infoProfile)
                {
                    char[] sep = new char[1];
                    sep[0] = '\n';
                    string[] infoFields = toSerialize.Split(sep);
                    sep[0] = '\r';

                    foreach (var item in infoFields)
                    {
                        if (item != "")
                        {
                            string[] tmp = item.Split(sep);
                            infoProfile[tmp[0]] = tmp[1];
                        }
                    }
                    foreach (var item in infoProfile)
                    {
                        Console.WriteLine(item.Key + "=[" + item.Value + "]");      
                    }
                    return (infoProfile);
                }*/


        static byte[] getBytes(HeadPacket p)
        {
            int size = Marshal.SizeOf(p);
            byte[] arr = new byte[size];
            IntPtr ptr = Marshal.AllocHGlobal(size);

            Marshal.StructureToPtr(p, ptr, true);
            Marshal.Copy(ptr, arr, 0, size);
            Marshal.FreeHGlobal(ptr);

            return arr;
        }

        static HeadPacket fromBytes(byte[] arr)
        {
            HeadPacket str = new HeadPacket();

            int size = Marshal.SizeOf(str);
            IntPtr ptr = Marshal.AllocHGlobal(size);

            Marshal.Copy(arr, 0, ptr, size);

            str = (HeadPacket)Marshal.PtrToStructure(ptr, str.GetType());
            Marshal.FreeHGlobal(ptr);

            return str;
        }



        static public void Main(string[] args)
        {

            TcpClient client = new TcpClient();

            IPEndPoint serverEndPoint = new IPEndPoint(IPAddress.Parse("127.0.0.1"), 3000);

            client.Connect(serverEndPoint);

        //    string ok = Console.ReadLine();

            for (int i = 0; i != 1; ++i)
            {
                NetworkStream clientStream = client.GetStream();

                ASCIIEncoding encoder = new ASCIIEncoding();


                Packet packet = new Packet();


                //WRITE
                packet.headpacket.destination = 1;
                packet.headpacket.source = 0;
                packet.headpacket.function = "REGU";
                packet.data = "email\razsx@gmteril.com\nusername\razsxrm\npassword\rcoulol\nname\r\nbirthday\r\nlocation\r\ngivenname\r\ntelephone\r\ngender\r\n";
                //"email\rmickael.pueu@gmail.com\nusername\rmicel\nname\rpueu\ngivenname\rmicel\nbirthday\r18/07/1991\nlocation\rbeing\npassword\rcoulol\ntelephone\r1234567890\ngender\rbeijingnoua\n";
                packet.headpacket.size = packet.data.Length;

                byte[] Datasend = getBytes(packet.headpacket);
                clientStream.Write(Datasend, 0, Datasend.Length - 4);
                clientStream.Flush();

                byte[] data = new byte[packet.headpacket.size];
                data = Encoding.ASCII.GetBytes(packet.data);
                clientStream.Write(data, 0, data.Length);

                //READ

                int len = Marshal.SizeOf(new HeadPacket());
                byte[] receiveData = new byte[len];
                HeadPacket headpacket = new HeadPacket();

                clientStream.Read(receiveData, 0, len);
                clientStream.Flush();

                headpacket = fromBytes(receiveData);
                packet.headpacket = headpacket;

                Console.Write("Source  -> " + packet.headpacket.source);
                Console.Write("destionation  -> " + packet.headpacket.destination);
                Console.Write("function -> " + packet.headpacket.function);
                Console.Write("size  -> " + packet.headpacket.size);

                receiveData = new byte[packet.headpacket.size];
                clientStream.Read(receiveData, 0, packet.headpacket.size);
                clientStream.Flush();

                Console.Write("DATA ->" + System.Text.Encoding.UTF8.GetString(receiveData));
                



                
                
/*                byte[] buffer = new byte[5];
                byte[] src = new byte[1];
                byte[] dest = new byte[1];
                byte[] func = new byte[4];
                byte[] SrcByte = new byte[4];
                byte[] DestByte = new byte[4];
                byte[] func2 = new byte[4];
                byte[] size32 = new byte[4];
                byte[] dataRetour = new byte[255];

                int sizeint32;
                int SrcInt;
                int DestInt;

                src = Encoding.ASCII.GetBytes("0");
                clientStream.Write(src, 0, src.Length);
                clientStream.Flush();

                dest = Encoding.ASCII.GetBytes("0");
                clientStream.Write(dest, 0, dest.Length);
                //               Console.WriteLine(System.Text.Encoding.UTF8.GetString(dest));
                clientStream.Flush();

                func = Encoding.ASCII.GetBytes("REGU");
                clientStream.Write(func, 0, func.Length);
                //             Console.WriteLine(System.Text.Encoding.UTF8.GetString(func));
                clientStream.Flush();

    
                byte[] size = BitConverter.GetBytes(Encoding.ASCII.GetBytes("email\rmickael.pucheu@gmail.com\nusername\rmickael\nname\rpucheu\ngivenname\rmickael\nbirthday\r18/07/1991\nlocation\rbeijing\npassword\rcoucoulol\ntelephone\r1234567890\ngender\rbeijingnoua\n").Length);
                //  username = Encoding.ASCII.GetBytes("mehdi");
                clientStream.Write(size, 0, size.Length);
                clientStream.Flush();

                //byte[] username = BitConverter.GetBytes(Encoding.ASCII.GetBytes("username\rmehdi").Length);
                byte[] username = new byte[Encoding.ASCII.GetBytes("email\rmickael.pucheu@gmail.com\nusername\rmickael\nname\rpucheu\ngivenname\rmickael\nbirthday\r18/07/1991\nlocation\rbeijing\npassword\rcoucoulol\ntelephone\r1234567890\ngender\rbeijingnoua\n").Length];
                username = Encoding.ASCII.GetBytes("email\rmickael.pucheu@gmail.com\nusername\rmickael\nname\rpucheu\ngivenname\rmickael\nbirthday\r18/07/1991\nlocation\rbeijing\npassword\rcoucoulol\ntelephone\r1234567890\ngender\rbeijingnoua\n");
                Console.WriteLine(System.Text.Encoding.UTF8.GetString(username));
                clientStream.Write(username, 0, username.Length);
                clientStream.Flush();


                // ICI = recuperation du code de retour
                clientStream.Read(SrcByte, 0, 4);
                SrcInt = BitConverter.ToInt32(SrcByte, 0);
                Console.WriteLine(SrcInt.ToString());
                clientStream.Read(DestByte, 0, 4);
                DestInt = BitConverter.ToInt32(DestByte, 0);
                Console.WriteLine(DestInt.ToString());
                clientStream.Read(func2, 0, 4);
                Console.WriteLine(System.Text.Encoding.UTF8.GetString(func2));
                clientStream.Read(size32, 0, 4);
                sizeint32 = BitConverter.ToInt32(size32, 0);
                Console.WriteLine(sizeint32.ToString());                
                clientStream.Flush();
                clientStream.Read(dataRetour, 0,255);
                Console.WriteLine(System.Text.Encoding.UTF8.GetString(dataRetour));




                string ok = Console.ReadLine();

                src = Encoding.ASCII.GetBytes("0");
                clientStream.Write(src, 0, src.Length);
                clientStream.Flush();

                dest = Encoding.ASCII.GetBytes("0");
                clientStream.Write(dest, 0, dest.Length);
                //               Console.WriteLine(System.Text.Encoding.UTF8.GetString(dest));
                clientStream.Flush();

                func = Encoding.ASCII.GetBytes("SGNI");
                clientStream.Write(func, 0, func.Length);
                //             Console.WriteLine(System.Text.Encoding.UTF8.GetString(func));
                clientStream.Flush();



                byte[] size1 = BitConverter.GetBytes(Encoding.ASCII.GetBytes("username\rmickael\npassword\rcoucoulol").Length);
                //  username = Encoding.ASCII.GetBytes("mehdi");
                clientStream.Write(size1, 0, size1.Length);
                clientStream.Flush();

                //byte[] username = BitConverter.GetBytes(Encoding.ASCII.GetBytes("username\rmehdi").Length);
                byte[] username1 = new byte[Encoding.ASCII.GetBytes("username\rmickael\npassword\rcoucoulol").Length];
                username1 = Encoding.ASCII.GetBytes("username\rmickael\npassword\rcoucoulol");
                clientStream.Write(username1, 0, username1.Length);
                clientStream.Flush();


                ok = Console.ReadLine();

                src = Encoding.ASCII.GetBytes("0");
                clientStream.Write(src, 0, src.Length);
                clientStream.Flush();

                dest = Encoding.ASCII.GetBytes("0");
                clientStream.Write(dest, 0, dest.Length);
                //               Console.WriteLine(System.Text.Encoding.UTF8.GetString(dest));
                clientStream.Flush();

                func = Encoding.ASCII.GetBytes("GETU");
                clientStream.Write(func, 0, func.Length);
                //             Console.WriteLine(System.Text.Encoding.UTF8.GetString(func));
                clientStream.Flush();



                byte[] size2 = BitConverter.GetBytes(Encoding.ASCII.GetBytes("username\rmickael").Length);
                //  username = Encoding.ASCII.GetBytes("mehdi");
                clientStream.Write(size2, 0, size2.Length);
                clientStream.Flush();

                //byte[] username = BitConverter.GetBytes(Encoding.ASCII.GetBytes("username\rmehdi").Length);
                byte[] username2 = new byte[Encoding.ASCII.GetBytes("username\rmickael").Length];
                username2 = Encoding.ASCII.GetBytes("username\rmickael");
                clientStream.Write(username2, 0, username2.Length);
                clientStream.Flush();

                ok = Console.ReadLine();


                src = Encoding.ASCII.GetBytes("0");
                clientStream.Write(src, 0, src.Length);
                clientStream.Flush();

                dest = Encoding.ASCII.GetBytes("0");
                clientStream.Write(dest, 0, dest.Length);
                //               Console.WriteLine(System.Text.Encoding.UTF8.GetString(dest));
                clientStream.Flush();

                func = Encoding.ASCII.GetBytes("SETU");
                clientStream.Write(func, 0, func.Length);
                //             Console.WriteLine(System.Text.Encoding.UTF8.GetString(func));
                clientStream.Flush();



                byte[] size3 = BitConverter.GetBytes(Encoding.ASCII.GetBytes("username\rmickael\ntelephone\rpoulet").Length);
                //  username = Encoding.ASCII.GetBytes("mehdi");
                clientStream.Write(size3, 0, size3.Length);
                clientStream.Flush();

                //byte[] username = BitConverter.GetBytes(Encoding.ASCII.GetBytes("username\rmehdi").Length);
                byte[] username3 = new byte[Encoding.ASCII.GetBytes("username\rmickael\ntelephone\rpoulet").Length];
                username3 = Encoding.ASCII.GetBytes("username\rmickael\ntelephone\rpoulet");
                clientStream.Write(username3, 0, username3.Length);
                clientStream.Flush();



                ok = Console.ReadLine();
                
                src = Encoding.ASCII.GetBytes("0");
                clientStream.Write(src, 0, src.Length);
                clientStream.Flush();

                dest = Encoding.ASCII.GetBytes("0");
                clientStream.Write(dest, 0, dest.Length);
                //               Console.WriteLine(System.Text.Encoding.UTF8.GetString(dest));
                clientStream.Flush();

                func = Encoding.ASCII.GetBytes("SGNO");
                clientStream.Write(func, 0, func.Length);
                //             Console.WriteLine(System.Text.Encoding.UTF8.GetString(func));
                clientStream.Flush();


                /*ICI IMPORTANTR REPRENDRE LE BIT CONVERTER POUR TOUS LES PACKETS */
                byte[] size4 = BitConverter.GetBytes(Encoding.ASCII.GetBytes("username\rmickael").Length);
                //  username = Encoding.ASCII.GetBytes("mehdi");
                clientStream.Write(size4, 0, size4.Length);
                clientStream.Flush();

                //byte[] username = BitConverter.GetBytes(Encoding.ASCII.GetBytes("username\rmehdi").Length);
                byte[] username4 = new byte[Encoding.ASCII.GetBytes("username\rmickael").Length];
                username4 = Encoding.ASCII.GetBytes("username\rmickael");
                clientStream.Write(username4, 0, username4.Length);
                clientStream.Flush();

             






//                ok = Console.ReadLine();

                /*
                string info = @"email\rmickael.pucheu@gmail.com\nusername\rmickael\nname\rpucheu\ngivenname\rmickael\nbirthday\r18/07/1991\nlocation\rbeijing\npassword\rcoucoulol\ntelephone\r1234567890\ngender\rbeijingnoua\n";
                byte[] data = new byte[info.Length];
                clientStream.Write(data, 0, data.Length);
                clientStream.Flush();


                clientStream.Read(buffer, 0, buffer.Length);
                Console.WriteLine("[" + System.Text.Encoding.UTF8.GetString(buffer) + "]");
                clientStream.Flush();

                //        Console.WriteLine(i);
                //        Console.WriteLine("-------------------");
                /*buffer = encoder.GetBytes(" ok ok");

                clientStream.Write(buffer, 0, buffer.Length);
                clientStream.Flush();
                clientStream.Read(buffer, 0, buffer.Length);
                Console.WriteLine(System.Text.Encoding.UTF8.GetString(buffer));*/
            }
            string ok2 = Console.ReadLine();
        }

    }
}
