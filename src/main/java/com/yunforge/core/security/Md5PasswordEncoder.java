package com.yunforge.core.security;

public class Md5PasswordEncoder extends MessageDigestPasswordEncoder {
	public Md5PasswordEncoder() {
		super("MD5");
	}
}