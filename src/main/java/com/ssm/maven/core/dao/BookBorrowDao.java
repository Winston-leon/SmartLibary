package com.ssm.maven.core.dao;

import com.ssm.maven.core.entity.BookBorrowRecord;
import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.Map;

@Repository
public interface BookBorrowDao extends Serializable {
    public int borrowBook(BookBorrowRecord bookBorrowRecord);

    public BookBorrowRecord findRecord(Integer id);

    public int returnBook(Map<String, Object> map);

    public int renewBook(Map<String, Object> map);
}
