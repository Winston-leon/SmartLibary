package com.ssm.maven.core.dao;

import com.ssm.maven.core.entity.BookBorrowRecord;
import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

@Repository
public interface BookBorrowDao extends Serializable {
    public int borrowBook(BookBorrowRecord bookBorrowRecord);

    public int changeBookStatus(Map<String, Object> map);

    public BookBorrowRecord findRecord(Integer id);

    public int returnBook(Map<String, Object> map);

    public int renewBook(Map<String, Object> map);

    public List<BookBorrowRecord> findRecordsByUserID(Integer user_id);

    public Long getTotalRecordsByUserID(Integer user_id);
}
