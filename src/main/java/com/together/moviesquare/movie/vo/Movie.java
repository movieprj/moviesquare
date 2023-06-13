package com.together.moviesquare.movie.vo;

import java.io.Serializable;

public class Movie  implements Serializable{
	private static final long serialVersionUID = -1744689743188008428L;
	
	private int id;
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
	
	public Movie() {
		super();
	}
	
	public Movie(int id, String movieid, String posters, String title, String actors, String director, String staffs,
			String company, String distributor, String genre, String type, String runtime, String rating, String nation,
			String reprlsdate, String keywords, String cost, String audiacc, String salesacc) {
		super();
		this.id = id;
		this.movieid = movieid;
		this.posters = posters;
		this.title = title;
		this.actors = actors;
		this.director = director;
		this.staffs = staffs;
		this.company = company;
		this.distributor = distributor;
		this.genre = genre;
		this.type = type;
		this.runtime = runtime;
		this.rating = rating;
		this.nation = nation;
		this.reprlsdate = reprlsdate;
		this.keywords = keywords;
		this.cost = cost;
		this.audiacc = audiacc;
		this.salesacc = salesacc;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMovieid() {
		return movieid;
	}

	public void setMovieid(String movieid) {
		this.movieid = movieid;
	}

	public String getPosters() {
		return posters;
	}

	public void setPosters(String posters) {
		this.posters = posters;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getActors() {
		return actors;
	}

	public void setActors(String actors) {
		this.actors = actors;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public String getStaffs() {
		return staffs;
	}

	public void setStaffs(String staffs) {
		this.staffs = staffs;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getDistributor() {
		return distributor;
	}

	public void setDistributor(String distributor) {
		this.distributor = distributor;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getRuntime() {
		return runtime;
	}

	public void setRuntime(String runtime) {
		this.runtime = runtime;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public String getReprlsdate() {
		return reprlsdate;
	}

	public void setReprlsdate(String reprlsdate) {
		this.reprlsdate = reprlsdate;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	public String getAudiacc() {
		return audiacc;
	}

	public void setAudiacc(String audiacc) {
		this.audiacc = audiacc;
	}

	public String getSalesacc() {
		return salesacc;
	}

	public void setSalesacc(String salesacc) {
		this.salesacc = salesacc;
	}

	@Override
	public String toString() {
		return "Movie [id=" + id + ", movieid=" + movieid + ", posters=" + posters + ", title=" + title + ", actors="
				+ actors + ", director=" + director + ", staffs=" + staffs + ", company=" + company + ", distributor="
				+ distributor + ", genre=" + genre + ", type=" + type + ", runtime=" + runtime + ", rating=" + rating
				+ ", nation=" + nation + ", reprlsdate=" + reprlsdate + ", keywords=" + keywords + ", cost=" + cost
				+ ", audiacc=" + audiacc + ", salesacc=" + salesacc + "]";
	}
}
