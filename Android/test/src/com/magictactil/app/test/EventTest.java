package com.magictactil.app.test;

import java.math.BigInteger;
import java.security.SecureRandom;

import com.magictactil.model.Event;
import com.magictactil.network.EventModule;

import android.test.AndroidTestCase;

public class EventTest extends AndroidTestCase 
{
	@Override
	protected void 		setUp() throws Exception 
	{
		super.setUp();
	}

	public void 		testCreateGoodEvent() 
	{
		Event			event = new Event();
		boolean			res;
		SecureRandom 	random = new SecureRandom();
		
		event.setName("test_" + new BigInteger(130, random).toString(32));
		event.setCreator("a");
		event.setCreator_email("a");
		event.setDate("25/01/2014");
		event.setDescription("Event created by android test");
		event.setLocation("la penne sur huveaune");
		res = EventModule.createEvent(event);
		assertTrue(res);
    }
	
	protected void 		tearDown() throws Exception
	{
		super.tearDown();
	}
}
