package com.magictactil.network;

import java.nio.ByteBuffer;

import com.magictactil.utils.Utils;

/**
 * Packet for sending to the server
 * 
 * @author Benjamin
 *
 */
public class 		Packet 
{
	private byte[]	src;
	private byte[]	dest;
	private String	func;
	private String 	data;
	private int		len;
	
	public byte[] 	getSrc() 
	{
		return src;
	}
	
	public void 	setSrc(int s) 
	{
		this.src = ByteBuffer.allocate(4).putInt(Utils.reverseBtoL(s)).array();
	}
	
	public byte[] 	getDest() 
	{
		return dest;
	}
	
	public void 	setDest(int d) 
	{
		this.dest = ByteBuffer.allocate(4).putInt(Utils.reverseBtoL(d)).array();
	}
	
	public String 	getFunc() 
	{
		return func;
	}

	public void 	setFunc(String func) 
	{
		this.func = func;
	}

	public String getData() 
	{
		return data;
	}

	public void setData(String data) 
	{
		this.data = data;
		this.len = data.length();
	}

	public byte[]	getHeader()
	{
		byte[]		header = new byte [4 + 4 + 4 + 4];
		
		System.arraycopy(dest, 0 , header, 0, 4);
		System.arraycopy(src, 0 , header, 4, 4);
		System.arraycopy(ByteBuffer.allocate(4).putInt(Utils.reverseBtoL(len)).array(), 0 , header, 8, 4);
		System.arraycopy(func.getBytes(), 0 , header, 12, 4);
		return (header);
	}
}
