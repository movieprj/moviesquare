package com.together.moviesquare.movie.vo;

import java.util.List;
import java.util.stream.Collectors;

import lombok.Builder;
import lombok.Data;


@Data
@Builder
public class MovieResult {
    private String DOCID;
    private String movieId;
    private String movieSeq;
    private String title;
    private String titleEng;
    private String titleOrg;
    private String titleEtc;
    private String prodYear;
    private Directors directors;
    private Actors actors;
    private String nation;
    private String company;
    private Plots plots;
    private String runtime;
    private String rating;
    private String genre;
    private String kmdbUrl;
    private String type;
    private String use;
    private String episodes;
    private String ratedYn;
    private String repRatDate;
    private String repRlsDate;
    private Ratings ratings;
    private String keywords;
    private String posters;
    private String stlls;
    private Staffs staffs;
    private Vods vods;
    private String openThtr;
    private Stats stats;
    private String screenArea;
    private String screenCnt;
    private String salesAcc;
    private String audiAcc;
    private String statSouce;
    private String statDate;
    private String themeSong;
    private String soundtrack;
    private String fLocation;
    private String Awards1;
    private String Awards2;
    private String regDate;
    private String modDate;
    private Codes Codes;
    private CommCodes CommCodes;
    private String ALIAS;

    private String actorsNm;
    private String directorsNm;
    private String staffsNm;
    private String distributor;
    
    @Data
    @Builder
    public static class Directors {
        private List<Director> director;
        private String directorsNm;
        
        @Data
        @Builder
        public static class Director {
            private String directorNm;
            private String directorEnNm;
            private String directorId;
        }
        
        public String setDirectorsNm() {
        	if(director != null && director.size() > 0)
	        	directorsNm = director.stream()
					                    .map(Director::getDirectorNm)
					                    .collect(Collectors.joining(","));
        	return directorsNm;
        }

    }
    
    @Data
    @Builder
    public static class Actors {
        private List<Actor> actor;
        private String actorsNm;
        
        public String setActorsNm() {
        	if(actor != null && actor.size() > 0)
        		actorsNm = actor.stream().map(Actor::getActorNm).collect(Collectors.joining(","));
        	return actorsNm;
        }
        
        @Data
        @Builder
        public static class Actor {
            private String actorNm;
            private String actorEnNm;
            private String actorId;
        }
        
    }
    @Data
    @Builder
    public static class Plots {
        private Plot[] plot;
        @Data
        @Builder
        public static class Plot {
            private String plotLang;
            private String plotText;
        }
    }
    @Data
    @Builder
    public static class Ratings {
        private Rating[] rating;
        @Data
        @Builder
        public static class Rating {
            private String ratingMain;
            private String ratingDate;
            private String ratingNo;
            private String ratingGrade;
            private String releaseDate;
            private String runtime;
        }
    }
    @Data
    public static class Staffs {
        private List<Staff> staff;
        private String staffsNm;
        private String distributor;
        
        public String setStaffsNm() {
        	if(staff != null && staff.size() > 0)
        		staffsNm = staff.stream().map(Staff::getStaffNm).collect(Collectors.joining(","));
        	return staffsNm;
        }
        
        public String setDistributor() {
        	if(staff != null && staff.size() > 0)
        		distributor = staff.stream()
                .filter(staff -> "배급사".equals(staff.getStaffRoleGroup()))
                .map(Staff::getStaffNm)
                .collect(Collectors.joining(","));
        	return distributor;
        }
        @Data
        @Builder
        public static class Staff {
            private String staffNm;
            private String staffEnNm;
            private String staffRoleGroup;
            private String staffRole;
            private String staffEtc;
            private String staffId;
        }
    }
    @Data
    @Builder
    public static class Vods {
        private Vod[] vod;
        @Data
        @Builder
        public static class Vod {
            private String vodClass;
            private String vodUrl;
        }
    }
    @Data
    @Builder
    public static class Stats {
        private Stat[] stat;
        @Data
        @Builder
        public static class Stat {
            private String screenArea;
            private String screenCnt;
            private String salesAcc;
            private String audiAcc;
            private String statSouce;
            private String statDate;
        }
    }
    @Data
    @Builder
    public static class Codes {
        private Code[] Code;
        @Data
        @Builder
        public static class Code {
            private String CodeNm;
            private String CodeNo;
        }
    }
    @Data
    @Builder
    public static class CommCodes {
        private CommCode[] CommCode;
        @Data
        @Builder
        public static class CommCode {
            private String CodeNm;
            private String CodeNo;
        }
    }
}