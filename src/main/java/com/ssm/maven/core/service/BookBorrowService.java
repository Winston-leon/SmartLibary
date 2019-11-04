package com.ssm.maven.core.service;

import com.ssm.maven.core.controller.BookBorrowController;
import com.ssm.maven.core.entity.BookBorrowRecord;

import java.io.Serializable;
import java.util.Map;

public interface BookBorrowService extends Serializable {
    public int borrowBook(BookBorrowRecord bookBorrowRecord);

    public BookBorrowRecord findRecord(Integer id);

    public int returnBook(Map<String, Object> map);

    public int renewBook(Map<String, Object> map);
}
