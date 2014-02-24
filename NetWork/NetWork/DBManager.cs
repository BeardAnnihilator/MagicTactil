using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Text.RegularExpressions;
using System.IO;

namespace MagicTactilServer.Classes
{
    class DBManager
    {
        #region Enums

        enum LogStatus
        {
            Disconnected = 0,
            Connected
        };
        enum RoomStatus
        {
            Admin = 0,
            Player,
            Spectator,
            None
        };
        enum ReturnCode
        {
            SignUp_OK = 0,
            SignUp_KO,
            SignIn_OK,
            SignIn_KO,
            SignOut_OK,
            SignOut_KO
        };
        #endregion

        public DBManager()
        {
            if (!File.Exists((Environment.CurrentDirectory + @"\users.xml")))
            {
                FileStream fd = File.Create(Environment.CurrentDirectory + @"\users.xml");
                fd.Close();
                XDocument root = new XDocument(new XDeclaration("1.0", "utf-8", "yes"),
                                               new XElement("users", @""));
                root.Save(Environment.CurrentDirectory + @"\users.xml");
            }
        }

        #region Tools

        private void fillInPacket(ref Dictionary<string, string> dataPacket, String[] keys)
        {
            string res;
            foreach (string key in keys)
            {
                if (dataPacket.TryGetValue(key, out res) == false)
                {
                    dataPacket[key] = "";
                }
            }
        }

        private bool profileCanBeCreated(Dictionary<string, string> dataPacket, XDocument xmlStream)
        {
            if (dataPacket["username"] != "" && dataPacket["password"] != "" && dataPacket["email"] != "")
            {
                var result = from auth in xmlStream.Descendants("user")
                             where ((string)auth.Attribute("username") == dataPacket["username"])
                             select auth;
                if (result.Count() == 0)
                {
                    return (true);
                }
            }
            return (false);
        }

        private XElement getProfileDisconnected(Dictionary<string, string> dataPacket, XDocument xmlStream)
        {
            XElement user = null;

            if (dataPacket["username"] == "" || dataPacket["password"] == "")
               return (user);
            var result = from auth in xmlStream.Descendants("user")
                         where ((string)auth.Attribute("username") == dataPacket["username"]) &&
                                (string)auth.Attribute("password") == dataPacket["password"]
                         select auth;
            if (result.Count() == 1)
            {
                user = xmlStream.Descendants("user").First(elem => ((string)elem.Attribute("username") == dataPacket["username"]) &&
                                                                             (string)elem.Attribute("password") == dataPacket["password"]);
            }
            return user;
        }

        private XElement getProfileConnected(Dictionary<string, string> dataPacket, XDocument xmlStream)
        {
            XElement user = null;
            var result = from auth in xmlStream.Descendants("user")
                         where ((string)auth.Attribute("username") == dataPacket["username"])
                         select auth;
            if (result.Count() == 1)
            {
                user = xmlStream.Descendants("user").First(elem => ((string)elem.Attribute("username") == dataPacket["username"]));
            }
            return user;
        }
        #endregion

        #region Authentication functions

        public string newUser(Dictionary<string, string> dataPacket)
        {
            XElement xmltree = XElement.Load(Environment.CurrentDirectory + @"\users.xml");
            XDocument xmlStream = XDocument.Load(Environment.CurrentDirectory + @"\users.xml");
            fillInPacket(ref dataPacket, new String[] { "email", "username", "name",
                                                        "givenname", "birthday", "location",
                                                        "password", "telephone", "gender" });

            if (this.profileCanBeCreated(dataPacket, xmlStream) == true)
            {
                xmltree.Add(new XElement("user", new XAttribute("email", dataPacket["email"]),
                                         new XAttribute("username", dataPacket["username"]),
                                         new XAttribute("name", dataPacket["name"]),
                                         new XAttribute("givenname", dataPacket["givenname"]),
                                         new XAttribute("birthday", dataPacket["birthday"]),
                                         new XAttribute("location", dataPacket["location"]),
                                         new XAttribute("password", dataPacket["password"]),
                                         new XAttribute("telephone", dataPacket["telephone"]),
                                         new XAttribute("gender", dataPacket["gender"]),
                                         new XAttribute("logstatus", LogStatus.Disconnected.ToString()),
                                         new XAttribute("roomstatus", RoomStatus.None.ToString()),
                                         new XAttribute("id", "0"), @"") );
                xmltree.Save(Environment.CurrentDirectory + @"\users.xml");
                return (ReturnCode.SignUp_OK.ToString());
            }
            return (ReturnCode.SignUp_KO.ToString());
        }

        public string signIn(Dictionary<string, string> dataPacket)
        {
            XDocument xmlStream = XDocument.Load(Environment.CurrentDirectory + @"\users.xml");
            fillInPacket(ref dataPacket, new String[] { "username", "password" });
            XElement user = getProfileDisconnected(dataPacket, xmlStream);

            if (user != null)
            {
                user.SetAttributeValue("logstatus", LogStatus.Connected.ToString());
                xmlStream.Save(Environment.CurrentDirectory + @"\users.xml");
                return (ReturnCode.SignIn_OK.ToString());
            }
            return (ReturnCode.SignIn_KO.ToString());
        }

        public string signOut(Dictionary<string, string> dataPacket)
        {
            XDocument xmlStream = XDocument.Load(Environment.CurrentDirectory + @"\users.xml");
            fillInPacket(ref dataPacket, new String[] { "username"});
            XElement user = getProfileConnected(dataPacket, xmlStream);
            if (user != null)
            {
                XmlDocument doc = new XmlDocument();
                doc.LoadXml(user.ToString());
                XmlNode node = doc.FirstChild;
                user.SetAttributeValue("logstatus", LogStatus.Disconnected.ToString());
                xmlStream.Save(Environment.CurrentDirectory + @"\users.xml");
                return (ReturnCode.SignOut_OK.ToString());
            }
            return (ReturnCode.SignOut_KO.ToString());
        }
        #endregion

        #region Profile functions

        private Dictionary<string, string> fillInProfile(XmlNode node)
        {
            Dictionary<string, string> profile = new Dictionary<string, string>();

            profile["code"] = "OK";
            profile["email"] = node.Attributes["email"].Value;
            profile["username"] = node.Attributes["username"].Value;
            profile["name"] = node.Attributes["name"].Value;
            profile["givenname"] = node.Attributes["givenname"].Value;
            profile["id"] = node.Attributes["id"].Value;
            profile["gender"] = node.Attributes["gender"].Value;
            profile["telephone"] = node.Attributes["telephone"].Value;
            profile["location"] = node.Attributes["location"].Value;
            profile["birthday"] = node.Attributes["birthday"].Value;
            return (profile);
        }

        public Dictionary<string, string> infoProfile(Dictionary<string, string> dataPacket)
        {
            XDocument xmlStream = XDocument.Load(Environment.CurrentDirectory + @"\users.xml");
            Dictionary<string, string> profile = new Dictionary<string, string>();
            fillInPacket(ref dataPacket, new String[] { "username" });
            XElement user = getProfileConnected(dataPacket, xmlStream);

            if (user != null)
            {
                XmlDocument doc = new XmlDocument();
                doc.LoadXml(user.ToString());
                XmlNode node = doc.FirstChild;
                if (node.Attributes["logstatus"].Value == LogStatus.Disconnected.ToString())
                    return (null);
                return (this.fillInProfile(node));
            }

            return (null);
        }

        public Dictionary<string, string> setInfoProfile(Dictionary<string, string> dataPacket)
        {
            XDocument xmlStream = XDocument.Load(Environment.CurrentDirectory + @"\users.xml");
            Dictionary<string, string> profile = new Dictionary<string, string>();
            fillInPacket(ref dataPacket, new String[] { "username"});
            XElement user = getProfileConnected(dataPacket, xmlStream);

            if (user != null)
            {
                XmlDocument doc = new XmlDocument();
                doc.LoadXml(user.ToString());
                XmlNode node = doc.FirstChild;
                if (node.Attributes["logstatus"].Value == LogStatus.Disconnected.ToString())
                    return (null);
                foreach (KeyValuePair<string, string> item in dataPacket)
                {
                    if (item.Key != "source" && item.Key != "dest" && item.Key != "func" && item.Key != "size" && item.Key != "data")
                    {
                        Console.WriteLine("user[" + item.Key + "]");
                        user.SetAttributeValue(item.Key, item.Value);
                    }
                }
                xmlStream.Save(Environment.CurrentDirectory + @"\users.xml");
                return (this.fillInProfile(node));
            }
            return (null);
        }
        #endregion
    }
}