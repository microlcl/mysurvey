package com.eastteam.myprogram.web;

public class AuthorizationException extends RuntimeException{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3023050895318596287L;

	public AuthorizationException() {
		super();
	}

	public AuthorizationException(String message) {
		super(message);
	}

	public AuthorizationException(Throwable cause) {
		super(cause);
	}

	public AuthorizationException(String message, Throwable cause) {
		super(message, cause);
	}

}
