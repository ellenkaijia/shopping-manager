package com.manager.entity.login;

import java.io.Serializable;

public class LoginEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4111768094197135255L;
	
	private Long id;
	
	private String name;
	
	private String password;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	

}
