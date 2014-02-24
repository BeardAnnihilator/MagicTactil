package com.magictactil.app.test;

import android.test.AndroidTestCase;

import com.magictactil.model.User;
import com.magictactil.network.ProfilModule;
import com.magictactil.network.ResponseParser;

public class ProfilTest extends AndroidTestCase 
{
	@Override
	protected void 		setUp() throws Exception 
	{
		super.setUp();
	}

	public void 		testEditProfil() 
	{
//		boolean			res;
//		User			u = new User();
//		
//		u.setPseudo("test");
//		res = ProfilModule.editProfil(u);
//		assertTrue(res);
    }
	
	public void			testGetProfil()
	{
		String			res;
		User			u = new User();
		
		u.setPseudo("test_android_user");
		res = ProfilModule.getProfil(u);
		u = ResponseParser.parseUser(res);
		assertTrue(u.getPseudo().equals("test_android_user"));
	}
	
	protected void 		tearDown() throws Exception
	{
		super.tearDown();
	}
}
