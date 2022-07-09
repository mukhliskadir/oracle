package com.example.mosque;

import java.io.InputStream;
import java.io.Serializable;
import java.sql.Blob;
import java.sql.Date;

import javax.servlet.http.Part;

public class Announcement implements Serializable {


	private static final long serialVersionUID = 1L;
	public int id;
	public Object picture;
	public String title;
	public String descr;
	public Date date;
	public String time;
	
	public Announcement() {}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	


	public Object getPicture() {
		return picture;
	}

	public void setPicture(Object picture) {
		this.picture = picture;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public void setPicture(InputStream inputStream) {
		// TODO Auto-generated method stub
		
	}
	
	
}
