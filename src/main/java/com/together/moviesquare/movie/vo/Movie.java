package com.together.moviesquare.movie.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class Movie  implements Serializable{
	private static final long serialVersionUID = -1744689743188008428L;
	
	private String id;
	private String movieid;
	private String posters;
	private String title;
	private String actors;
	private String director;
	private String staffs;
	private String company;
	private String distributor;
	private String genre;
	private String type;
	private String runtime;
	private String rating;
	private String nation;
	private String reprlsdate;
	private String keywords;
	private String cost;
	private String audiacc;
	private String salesacc;
	
}
