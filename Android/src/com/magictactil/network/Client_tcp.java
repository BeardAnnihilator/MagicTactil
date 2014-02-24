package com.magictactil.network;

import java.io.DataInputStream;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.nio.ByteBuffer;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.util.Log;

import com.magictactil.utils.Constants;
import com.magictactil.utils.Utils;

//Classe qui gere le reseau (comunication avec le serveur)
public class 					Client_tcp
{
	private Socket				sock;
	private static Client_tcp 	socket = new Client_tcp();
	private boolean 			isConnected = false;

	//Obtenir l'instance de Client_tcp de n'importe ou
	public static 				Client_tcp getInstance()
	{
		return (socket);
	}

	//Tester si la connexion est OK
	public static boolean 		isOnline(Context ctx)
	{
		android.net.NetworkInfo.State mobile;
		android.net.NetworkInfo.State wifi;

		ConnectivityManager conMgr =  (ConnectivityManager)ctx.getSystemService(Context.CONNECTIVITY_SERVICE);
		NetworkInfo i = conMgr.getActiveNetworkInfo();

		if (i == null)
			return (false);
		if (!i.isConnected())
			return (false);
		if (!i.isAvailable())
			return (false);

		mobile = conMgr.getNetworkInfo(0).getState();
		wifi = conMgr.getNetworkInfo(1).getState();
		if ((mobile == NetworkInfo.State.CONNECTED) || (mobile == NetworkInfo.State.CONNECTING))
		{
			return (true);
		}
		else if ((wifi == NetworkInfo.State.CONNECTED) || (wifi == NetworkInfo.State.CONNECTING))
		{
			return (true);
		}
		else
			return (false);
	}

	/**
	 * Connect to server
	 * 
	 * @param ip
	 * @param port
	 * @return
	 */
	public boolean 				connect(String ip, int port)
	{
		try 
		{
			Log.i(com.magictactil.utils.Constants.TAG, "Socket connect");
			this.sock = new Socket();
			this.sock.connect(new InetSocketAddress(ip, port), 3000);
		} 
		catch (UnknownHostException e) 
		{
			e.printStackTrace();
			return (false);
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
			return (false);
		}
		if (this.sock.isConnected())
		{
			this.isConnected = true;
			return (true);
		}
		return (false);
	}

	//Envoi de message au serveur
	public boolean 				send(String msg)
	{
		byte[] 					mess;
		
		mess = msg.getBytes();
		try
		{
			this.sock.getOutputStream().write(mess);	
			this.sock.getOutputStream().flush();
			return (true);
		}
		catch (IOException e) 
		{
			return (false);
		}
	}
	
	public boolean 				send(byte [] msg)
	{
		try
		{
			this.sock.getOutputStream().write(msg);	
			this.sock.getOutputStream().flush();
			return (true);
		}
		catch (IOException e) 
		{
			return (false);
		}
	}

	/**
	 * Lecture bloquante de la socket (pour l'interface) 
	 * @return
	 */
	public String 				receive()
	{
		DataInputStream			in;
		String 					message = "";
		String					src;
		String					dst;
		String					func;
		int						size;
		byte[]		 			buffer = (byte[]) new byte[4];

		try 
		{
			in = new DataInputStream(this.sock.getInputStream());
            in.read(buffer, 0, 4);
            src = new String(buffer).substring(0, 4);
            in.read(buffer, 0, 4);
            dst = new String(buffer).substring(0, 4);
            in.read(buffer, 0, 4);
            size = ByteBuffer.wrap(buffer, 0, 4).getInt();
            size = Utils.reverseLtoB(size);
            in.read(buffer, 0, 4);
            func = new String(buffer).substring(0, 4);
            Log.d(Constants.TAG, "receive FUNC (" + func + "): size " + size);
            buffer = new byte[size];
            in.read(buffer, 0, size);
            message = new String(buffer).substring(0, size);
            Log.d(Constants.TAG, message);
		} 
		catch (IOException e)
		{
			e.printStackTrace();
		}
		return message;
	}
	
	/**
	 * Lecture non bloquante de la socket (pour le combat)
	 * 
	 * @return
	 */
	public Response				nonBlockingReceive()
	{
		Response				res = null;
		DataInputStream			in;
		String					src;
		String					dst;
		int						size;
		byte[]		 			buffer = (byte[]) new byte[4];
		
		try 
		{
			if (this.sock.getInputStream().available() > 0)
			{
				res = new Response();
				in = new DataInputStream(this.sock.getInputStream());
	            in.read(buffer, 0, 4);
	            src = new String(buffer).substring(0, 4);
	            in.read(buffer, 0, 4);
	            dst = new String(buffer).substring(0, 4);
	            in.read(buffer, 0, 4);
	            size = ByteBuffer.wrap(buffer, 0, 4).getInt();
	            size = Utils.reverseLtoB(size);
	            in.read(buffer, 0, 4);
	            res.setFunc(new String(buffer).substring(0, 4));
	            Log.d(Constants.TAG, "receive FUNC (" + res.getFunc() + "): size " + size);
	            buffer = new byte[size];
	            in.read(buffer, 0, size);
	            res.setData(new String(buffer).substring(0, size));
	            Log.d(Constants.TAG, res.getData());
			}
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		return res;
	}

	//Fermeture de la socket
	public void 				closeSocket()
	{
		try 
		{
			Log.d(Constants.TAG, "Close socket");
			this.sock.close();
			this.isConnected = false;
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
	}
	
	//Getter de la socket
	public Socket 				getSocket() 
	{
		return (this.sock);
	}

	//Setter de la socket
	public void 				setSocket(Socket socket) 
	{
		this.sock = socket;		
	}

	//Getter de l'etat de connexion de la socket
	public boolean 				getIsConnected()
	{
		return (this.isConnected);
	}
}
