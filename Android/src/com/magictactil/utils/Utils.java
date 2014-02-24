package com.magictactil.utils;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;

import org.apache.http.util.ByteArrayBuffer;

import android.app.ProgressDialog;
import android.content.Context;
import android.util.Log;

/**
 * Class containting utilis functions
 * 
 * @author Benjamin
 *
 */
public class Utils 
{
	/**
	 * Change a Little endian int to a big endian int
	 * 
	 * @param x, the int to change
	 * @return the int in big endian format
	 */
	public static int  		reverseLtoB(int x) 
	{  
        ByteBuffer bbuf = ByteBuffer.allocate(4);  
        bbuf.order(ByteOrder.LITTLE_ENDIAN);  
        bbuf.putInt(x);  
        bbuf.order(ByteOrder.BIG_ENDIAN);  
        return bbuf.getInt(0);  
    }
	
	/**
	 * Change a Big endian int to a little endian int
	 * 
	 * @param x, the int to change
	 * @return the int in little endian format
	 */
	public static int  		reverseBtoL(int x) 
	{  
		ByteBuffer bbuf = ByteBuffer.allocate(4);  
		bbuf.order(ByteOrder.BIG_ENDIAN);  
		bbuf.putInt(x);  
		bbuf.order(ByteOrder.LITTLE_ENDIAN);  
		return bbuf.getInt(0);  
	} 
	
	/**
	 * Create the progress bar dialog
	 * 
	 * @param mess
	 */
	public static ProgressDialog		createDialogProgressBar(String mess, Context c)
	{
		ProgressDialog					progress_dialog;
		
		progress_dialog = new ProgressDialog(c);
		progress_dialog.setMessage(mess);
		progress_dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
		progress_dialog.setIndeterminate(true);
		progress_dialog.setCancelable(false);
		progress_dialog.show();
		return (progress_dialog);
	}
	
	/**
	 * Download an image from its url
	 * 
	 * @param url, url
	 * @param file, file to save the image
	 */
	public static void				downloadImgFromUrl(String url, File file)
	{
		URL 				urlc;

		if (!url.equals("null"))
		{
			try 
			{
				Log.d(Constants.TAG, "Download " + url + " in " + file.getPath());
				urlc = new URL(url);
				URLConnection 	ucon = urlc.openConnection();
				InputStream 	is = ucon.getInputStream();
				BufferedInputStream bis = new BufferedInputStream(is);

				ByteArrayBuffer baf = new ByteArrayBuffer(5000);
				int current = 0;
				while ((current = bis.read()) != -1) 
				{
					baf.append((byte) current);
				}

				FileOutputStream fos = new FileOutputStream(file);
				fos.write(baf.toByteArray());
				fos.flush();
				fos.close();
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}
		}
	}
}
