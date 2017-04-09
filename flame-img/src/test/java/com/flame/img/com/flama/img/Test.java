package com.flame.img.com.flama.img;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String source = "z:\\java\\kl\\$kls\\";
		System.out.println(source.matches("^[A-z]:\\\\(.+?\\\\)*$"));
		
		String s="abc/jpg";
	    //String regex=".+?//.(.+)";这种写法也是可以的，但我认为没有后面的精确
	    String regex=".+?//.([a-zA-z]+)";
	    Pattern pt=Pattern.compile(regex);
	    Matcher mt=pt.matcher(s);
	    if(mt.find())
	    {
	      System.out.println(mt.group(1));
	    }
	}

}
