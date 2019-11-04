package com.ssm.maven.core.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

public class BookBorrowRecord implements Serializable {
    public static final Integer akl1 = 30;
    public static final Integer akl2 = 45;
    public static final double feePerDay = 0.25;

    private Integer id;
    private Integer book_id;
    private Integer user_id;
    private Timestamp br_time;
    private Integer allowed_keep_length;
    private Integer is_done;
    private BigDecimal arrearage;
    private Integer renew_times = 0;

    public BookBorrowRecord(Integer book_id, Integer user_id, Timestamp br_time, Integer allowed_keep_length, Integer is_done, BigDecimal arrearage, Integer renew_times) {
        this.book_id = book_id;
        this.user_id = user_id;
        this.br_time = br_time;
        this.allowed_keep_length = allowed_keep_length;
        this.is_done = is_done;
        this.arrearage = arrearage;
        this.renew_times = renew_times;
    }

    public BookBorrowRecord() {}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getBookId() {
        return book_id;
    }

    public void setBookId(Integer book_id) {
        this.book_id = book_id;
    }

    public Integer getUserId() {
        return user_id;
    }

    public void setUserId(Integer user_id) {
        this.user_id = user_id;
    }

    public Timestamp getBRTime() {
        return br_time;
    }

    public void setBRTime(Timestamp br_time) {
        this.br_time = br_time;
    }

    public Integer getAllowedKeepLength() {
        return allowed_keep_length;
    }

    public void setAllowedKeepLength(Integer allowed_keep_length) {
        this.allowed_keep_length = allowed_keep_length;
    }

    public Integer getIsDone() {
        return is_done;
    }

    public void setIsDone(Integer is_done) {
        this.is_done = is_done;
    }

    public BigDecimal getArrearage() {
        return arrearage;
    }

    public void setArrearage(BigDecimal arrearage) {
        this.arrearage = arrearage;
    }

    public Integer getRenewTimes() {
        return renew_times;
    }

    public void setRenewTimes(Integer renew_times) {
        this.renew_times = renew_times;
    }

    @Override
    public String toString() {
        return "BookRecord{" +
                "id='" + id + '\'' +
                ", book_id='" + book_id + '\'' +
                ", user_id='" + user_id + '\'' +
                ", br_time='" + br_time + '\'' +
                ", allowed_keep_length='" + allowed_keep_length + '\'' +
                ", is_done='" + is_done + '\'' +
                ", arrearage='" + arrearage + '\'' +
                ", renew_times='" + renew_times + '\'' +
                '}';
    }
}
