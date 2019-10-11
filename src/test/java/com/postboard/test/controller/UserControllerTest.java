package com.postboard.test.controller;

import org.junit.Test;

public class UserControllerTest {
	
	@Test
	public void testHashCode(){
		String s="a";
		int hashCode = s.hashCode();
		System.out.println(Integer.toHexString(hashCode));
		System.out.println(1 ^ 0xF);
	}
}
