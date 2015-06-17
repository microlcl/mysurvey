package com.eastteam.myprogram.service;

import java.util.UUID;

import org.junit.Test;

public class UUIDTest{
	
	@Test
	public void testUUID() {
		
		UUID uuid = UUID.randomUUID();
		System.out.println(uuid);
		
	}

}
