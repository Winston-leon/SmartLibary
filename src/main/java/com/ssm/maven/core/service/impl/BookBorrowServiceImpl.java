package com.ssm.maven.core.service.impl;

import com.ssm.maven.core.dao.BookBorrowDao;
import com.ssm.maven.core.entity.BookBorrowRecord;
import com.ssm.maven.core.service.BookBorrowService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("bookBorrowService")
public class BookBorrowServiceImpl implements BookBorrowService {
    @Resource
    private BookBorrowDao bookBorrowDao;

    @Override
    public int borrowBook(BookBorrowRecord bookBorrowRecord) {
        return bookBorrowDao.borrowBook(bookBorrowRecord);
    }

    @Override
    public int changeBookStatus(Map<String, Object> map) {
        return bookBorrowDao.changeBookStatus(map);
    }

    @Override
    public BookBorrowRecord findRecord(Integer id) {
        return bookBorrowDao.findRecord(id);
    }

    @Override
    public int returnBook(Map<String, Object> map) {
        return bookBorrowDao.returnBook(map);
    }

    @Override
    public int renewBook(Map<String, Object> map) {
        return bookBorrowDao.renewBook(map);
    }

    @Override
    public List<BookBorrowRecord> findRecordsByUserID(Integer user_id) {
        return bookBorrowDao.findRecordsByUserID(user_id);
    }

    @Override
    public Long getTotalRecordsByUserID(Integer user_id) {
        return bookBorrowDao.getTotalRecordsByUserID(user_id);
    }
}
