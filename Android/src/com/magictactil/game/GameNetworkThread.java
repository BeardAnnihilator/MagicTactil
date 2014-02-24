package com.magictactil.game;

import com.magictactil.network.Client_tcp;

public class 					GameNetworkThread extends Thread
{
	private Client_tcp			socket;
	
	public void					run()
	{
		String					res;
		
		socket = Client_tcp.getInstance();
		res = socket.receive();
		res.charAt(0);
	}
}
