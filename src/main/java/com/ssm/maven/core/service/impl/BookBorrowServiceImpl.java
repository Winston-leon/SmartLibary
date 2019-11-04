package com.ssm.maven.core.service.impl;

import com.ssm.maven.core.dao.BookBorrowDao;
import com.ssm.maven.core.entity.BookBorrowRecord;
import com.ssm.maven.core.service.BookBorrowService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Map;

@Service("bookBorrowService")
public class BookBorrowServiceImpl implements BookBorrowService {
    @Resource
    private BookBorrowDao bookBorrowDao;

    @Override
    public int borrowBook(BookBorrowRecord bookBorrowRecord) {
        return bookBorrowDao.borrowBook(bookBorrowRecord);
    };

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
}
